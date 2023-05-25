Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCAB71114B
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 18:49:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2E81-0007O8-8O; Thu, 25 May 2023 12:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1q2E7x-0007Nl-Jn; Thu, 25 May 2023 12:47:49 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1q2E7v-0004uj-Ej; Thu, 25 May 2023 12:47:49 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id B7898471B3;
 Thu, 25 May 2023 18:47:31 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 eblake@redhat.com, vsementsov@yandex-team.ru, jsnow@redhat.com,
 stefanha@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 pbonzini@redhat.com, t.lamprecht@proxmox.com
Subject: [PATCH v2] migration: hold the BQL during setup
Date: Thu, 25 May 2023 18:47:26 +0200
Message-Id: <20230525164726.45176-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

This is intended to be a semantic revert of commit 9b09503752
("migration: run setup callbacks out of big lock"). There have been so
many changes since that commit (e.g. a new setup callback
dirty_bitmap_save_setup() that also needs to be adapted now), it's
easier to do the revert manually.

For snapshots, the bdrv_writev_vmstate() function is used during setup
(in QIOChannelBlock backing the QEMUFile), but not holding the BQL
while calling it could lead to an assertion failure. To understand
how, first note the following:

1. Generated coroutine wrappers for block layer functions spawn the
coroutine and use AIO_WAIT_WHILE()/aio_poll() to wait for it.
2. If the host OS switches threads at an inconvenient time, it can
happen that a bottom half scheduled for the main thread's AioContext
is executed as part of a vCPU thread's aio_poll().

An example leading to the assertion failure is as follows:

main thread:
1. A snapshot-save QMP command gets issued.
2. snapshot_save_job_bh() is scheduled.

vCPU thread:
3. aio_poll() for the main thread's AioContext is called (e.g. when
the guest writes to a pflash device, as part of blk_pwrite which is a
generated coroutine wrapper).
4. snapshot_save_job_bh() is executed as part of aio_poll().
3. qemu_savevm_state() is called.
4. qemu_mutex_unlock_iothread() is called. Now
qemu_get_current_aio_context() returns 0x0.
5. bdrv_writev_vmstate() is executed during the usual savevm setup
via qemu_fflush(). But this function is a generated coroutine wrapper,
so it uses AIO_WAIT_WHILE. There, the assertion
assert(qemu_get_current_aio_context() == qemu_get_aio_context());
will fail.

To fix it, ensure that the BQL is held during setup. While it would
only be needed for snapshots, adapting migration too avoids additional
logic for conditional locking/unlocking in the setup callbacks.
Writing the header could (in theory) also trigger qemu_fflush() and
thus bdrv_writev_vmstate(), so the locked section also covers the
qemu_savevm_state_header() call, even for migration for consistentcy.

The comment in ram_init_bitmaps() was introduced by 4987783400
("migration: fix incorrect memory_global_dirty_log_start outside BQL")
and is removed, because it referred to the qemu_mutex_lock_iothread()
call.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 include/migration/register.h   | 2 +-
 migration/block-dirty-bitmap.c | 3 ---
 migration/block.c              | 5 -----
 migration/migration.c          | 6 ++++++
 migration/ram.c                | 3 ---
 migration/savevm.c             | 2 --
 6 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index a8dfd8fefd..ed8c42063b 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -20,6 +20,7 @@ typedef struct SaveVMHandlers {
     /* This runs inside the iothread lock.  */
     SaveStateHandler *save_state;
 
+    int (*save_setup)(QEMUFile *f, void *opaque);
     void (*save_cleanup)(void *opaque);
     int (*save_live_complete_postcopy)(QEMUFile *f, void *opaque);
     int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
@@ -45,7 +46,6 @@ typedef struct SaveVMHandlers {
     int (*save_live_iterate)(QEMUFile *f, void *opaque);
 
     /* This runs outside the iothread lock!  */
-    int (*save_setup)(QEMUFile *f, void *opaque);
     /* Note for save_live_pending:
      * must_precopy:
      * - must be migrated in precopy or in stopped state
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 032fc5f405..03cb2e72ee 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -1214,9 +1214,7 @@ static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque)
     DBMSaveState *s = &((DBMState *)opaque)->save;
     SaveBitmapState *dbms = NULL;
 
-    qemu_mutex_lock_iothread();
     if (init_dirty_bitmap_migration(s) < 0) {
-        qemu_mutex_unlock_iothread();
         return -1;
     }
 
@@ -1224,7 +1222,6 @@ static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque)
         send_bitmap_start(f, s, dbms);
     }
     qemu_put_bitmap_flags(f, DIRTY_BITMAP_MIG_FLAG_EOS);
-    qemu_mutex_unlock_iothread();
     return 0;
 }
 
diff --git a/migration/block.c b/migration/block.c
index b9580a6c7e..4df7862f07 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -722,18 +722,13 @@ static int block_save_setup(QEMUFile *f, void *opaque)
     trace_migration_block_save("setup", block_mig_state.submitted,
                                block_mig_state.transferred);
 
-    qemu_mutex_lock_iothread();
     ret = init_blk_migration(f);
     if (ret < 0) {
-        qemu_mutex_unlock_iothread();
         return ret;
     }
 
     /* start track dirty blocks */
     ret = set_dirty_tracking();
-
-    qemu_mutex_unlock_iothread();
-
     if (ret) {
         return ret;
     }
diff --git a/migration/migration.c b/migration/migration.c
index 5de7f734b9..c1b3c515e9 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2929,7 +2929,9 @@ static void *migration_thread(void *opaque)
     object_ref(OBJECT(s));
     update_iteration_initial_status(s);
 
+    qemu_mutex_lock_iothread();
     qemu_savevm_state_header(s->to_dst_file);
+    qemu_mutex_unlock_iothread();
 
     /*
      * If we opened the return path, we need to make sure dst has it
@@ -2957,7 +2959,9 @@ static void *migration_thread(void *opaque)
         qemu_savevm_send_colo_enable(s->to_dst_file);
     }
 
+    qemu_mutex_lock_iothread();
     qemu_savevm_state_setup(s->to_dst_file);
+    qemu_mutex_unlock_iothread();
 
     qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
                                MIGRATION_STATUS_ACTIVE);
@@ -3068,8 +3072,10 @@ static void *bg_migration_thread(void *opaque)
     ram_write_tracking_prepare();
 #endif
 
+    qemu_mutex_lock_iothread();
     qemu_savevm_state_header(s->to_dst_file);
     qemu_savevm_state_setup(s->to_dst_file);
+    qemu_mutex_unlock_iothread();
 
     qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
                                MIGRATION_STATUS_ACTIVE);
diff --git a/migration/ram.c b/migration/ram.c
index 9fb076fa58..1a2edef527 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2881,8 +2881,6 @@ static void migration_bitmap_clear_discarded_pages(RAMState *rs)
 
 static void ram_init_bitmaps(RAMState *rs)
 {
-    /* For memory_global_dirty_log_start below.  */
-    qemu_mutex_lock_iothread();
     qemu_mutex_lock_ramlist();
 
     WITH_RCU_READ_LOCK_GUARD() {
@@ -2894,7 +2892,6 @@ static void ram_init_bitmaps(RAMState *rs)
         }
     }
     qemu_mutex_unlock_ramlist();
-    qemu_mutex_unlock_iothread();
 
     /*
      * After an eventual first bitmap sync, fixup the initial bitmap
diff --git a/migration/savevm.c b/migration/savevm.c
index 03795ce8dc..be97770620 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1624,10 +1624,8 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
     memset(&compression_counters, 0, sizeof(compression_counters));
     ms->to_dst_file = f;
 
-    qemu_mutex_unlock_iothread();
     qemu_savevm_state_header(f);
     qemu_savevm_state_setup(f);
-    qemu_mutex_lock_iothread();
 
     while (qemu_file_get_error(f) == 0) {
         if (qemu_savevm_state_iterate(f, false) > 0) {
-- 
2.39.2



