Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C767CBD80
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 10:31:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsfU1-0005Nq-T2; Tue, 17 Oct 2023 04:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsfTb-0004t8-GI
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:30:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsfTV-0005H1-CE
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697531447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cJ2QRNsJQmLLVHS2tgeJHXn693FXLNv7p8EShltl7nw=;
 b=I7O2Y7XWeT8HbtUIadM8zXP8sVVJNLmjsRvhJfiEz60fjKSBlo/UZWb9aVX5P9mThe8jVo
 rU9t1vV/orJZxWEEk5xImT5gpv2TuQqXvTYjAkXrKLHwc/mXEdNLBi2J8lngzlBc9qbBtw
 Op/bxrWgk/v40IqmT/S5vw8ijsjn9cM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155-Pab2FBCrMkWtUF8yRd9e4Q-1; Tue, 17 Oct 2023 04:30:45 -0400
X-MC-Unique: Pab2FBCrMkWtUF8yRd9e4Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D7B4D8F15C4;
 Tue, 17 Oct 2023 08:30:44 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D31701C060AE;
 Tue, 17 Oct 2023 08:30:41 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>
Subject: [PULL 12/38] migration: hold the BQL during setup
Date: Tue, 17 Oct 2023 10:29:37 +0200
Message-ID: <20231017083003.15951-13-quintela@redhat.com>
In-Reply-To: <20231017083003.15951-1-quintela@redhat.com>
References: <20231017083003.15951-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: Fiona Ebner <f.ebner@proxmox.com>

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
qemu_savevm_state_header() call, even for migration for consistency.

The section around multifd_send_sync_main() needs to be unlocked to
avoid a deadlock. In particular, the multifd_save_setup() function calls
socket_send_channel_create() using multifd_new_send_channel_async() as a
callback and then waits for the callback to signal via the
channels_ready semaphore. The connection happens via
qio_task_run_in_thread(), but the callback is only executed via
qio_task_thread_result() which is scheduled for the main event loop.
Without unlocking the section, the main thread would never get to
process the task result and the callback meaning there would be no
signal via the channels_ready semaphore.

The comment in ram_init_bitmaps() was introduced by 4987783400
("migration: fix incorrect memory_global_dirty_log_start outside BQL")
and is removed, because it referred to the qemu_mutex_lock_iothread()
call.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231013105839.415989-1-f.ebner@proxmox.com>
---
 include/migration/register.h   | 2 +-
 migration/block-dirty-bitmap.c | 3 ---
 migration/block.c              | 5 -----
 migration/migration.c          | 6 ++++++
 migration/ram.c                | 6 +++---
 migration/savevm.c             | 2 --
 6 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index 2b12c6adec..fed1d04a3c 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -25,6 +25,7 @@ typedef struct SaveVMHandlers {
      * used to perform early checks.
      */
     int (*save_prepare)(void *opaque, Error **errp);
+    int (*save_setup)(QEMUFile *f, void *opaque);
     void (*save_cleanup)(void *opaque);
     int (*save_live_complete_postcopy)(QEMUFile *f, void *opaque);
     int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
@@ -50,7 +51,6 @@ typedef struct SaveVMHandlers {
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
index d115e1cfa5..b60698d6e2 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -731,18 +731,13 @@ static int block_save_setup(QEMUFile *f, void *opaque)
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
index 98151b1424..79fa11e3f6 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3020,7 +3020,9 @@ static void *migration_thread(void *opaque)
     object_ref(OBJECT(s));
     update_iteration_initial_status(s);
 
+    qemu_mutex_lock_iothread();
     qemu_savevm_state_header(s->to_dst_file);
+    qemu_mutex_unlock_iothread();
 
     /*
      * If we opened the return path, we need to make sure dst has it
@@ -3048,7 +3050,9 @@ static void *migration_thread(void *opaque)
         qemu_savevm_send_colo_enable(s->to_dst_file);
     }
 
+    qemu_mutex_lock_iothread();
     qemu_savevm_state_setup(s->to_dst_file);
+    qemu_mutex_unlock_iothread();
 
     qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
                                MIGRATION_STATUS_ACTIVE);
@@ -3159,8 +3163,10 @@ static void *bg_migration_thread(void *opaque)
     ram_write_tracking_prepare();
 #endif
 
+    qemu_mutex_lock_iothread();
     qemu_savevm_state_header(s->to_dst_file);
     qemu_savevm_state_setup(s->to_dst_file);
+    qemu_mutex_unlock_iothread();
 
     qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
                                MIGRATION_STATUS_ACTIVE);
diff --git a/migration/ram.c b/migration/ram.c
index e8df4dc862..d3d9c8b65b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2891,8 +2891,6 @@ static void migration_bitmap_clear_discarded_pages(RAMState *rs)
 
 static void ram_init_bitmaps(RAMState *rs)
 {
-    /* For memory_global_dirty_log_start below.  */
-    qemu_mutex_lock_iothread();
     qemu_mutex_lock_ramlist();
 
     WITH_RCU_READ_LOCK_GUARD() {
@@ -2904,7 +2902,6 @@ static void ram_init_bitmaps(RAMState *rs)
         }
     }
     qemu_mutex_unlock_ramlist();
-    qemu_mutex_unlock_iothread();
 
     /*
      * After an eventual first bitmap sync, fixup the initial bitmap
@@ -3067,7 +3064,10 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
 
     migration_ops = g_malloc0(sizeof(MigrationOps));
     migration_ops->ram_save_target_page = ram_save_target_page_legacy;
+
+    qemu_mutex_unlock_iothread();
     ret = multifd_send_sync_main(f);
+    qemu_mutex_lock_iothread();
     if (ret < 0) {
         return ret;
     }
diff --git a/migration/savevm.c b/migration/savevm.c
index bce698b0af..8622f229e5 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1672,10 +1672,8 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
     }
     ms->to_dst_file = f;
 
-    qemu_mutex_unlock_iothread();
     qemu_savevm_state_header(f);
     qemu_savevm_state_setup(f);
-    qemu_mutex_lock_iothread();
 
     while (qemu_file_get_error(f) == 0) {
         if (qemu_savevm_state_iterate(f, false) > 0) {
-- 
2.41.0


