Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE2D79A501
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 09:51:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfbgv-000478-U7; Mon, 11 Sep 2023 03:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=GLJ6=E3=redhat.com=clg@ozlabs.org>)
 id 1qfbgt-00043K-RZ
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:50:39 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=GLJ6=E3=redhat.com=clg@ozlabs.org>)
 id 1qfbgq-0008Co-TQ
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:50:39 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Rkf5l63pkz4xM7;
 Mon, 11 Sep 2023 17:50:35 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rkf5k0X96z4xM5;
 Mon, 11 Sep 2023 17:50:33 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 10/13] migration: Add .save_prepare() handler to struct
 SaveVMHandlers
Date: Mon, 11 Sep 2023 09:50:05 +0200
Message-ID: <20230911075008.462712-11-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911075008.462712-1-clg@redhat.com>
References: <20230911075008.462712-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=GLJ6=E3=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Avihai Horon <avihaih@nvidia.com>

Add a new .save_prepare() handler to struct SaveVMHandlers. This handler
is called early, even before migration starts, and can be used by
devices to perform early checks.

Refactor migrate_init() to be able to return errors and call
.save_prepare() from there.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/migration/register.h |  5 +++++
 migration/migration.h        |  2 +-
 migration/savevm.h           |  1 +
 migration/migration.c        | 15 +++++++++++++--
 migration/savevm.c           | 29 ++++++++++++++++++++++++++++-
 5 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index 90914f32f50cab9fc6b7797fbf3fb509a0860291..2b12c6adeca7ce5c7282e8df3c2def0068d44c18 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -20,6 +20,11 @@ typedef struct SaveVMHandlers {
     /* This runs inside the iothread lock.  */
     SaveStateHandler *save_state;
 
+    /*
+     * save_prepare is called early, even before migration starts, and can be
+     * used to perform early checks.
+     */
+    int (*save_prepare)(void *opaque, Error **errp);
     void (*save_cleanup)(void *opaque);
     int (*save_live_complete_postcopy)(QEMUFile *f, void *opaque);
     int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
diff --git a/migration/migration.h b/migration/migration.h
index c5695de214965dfddd854779e4da8d09f04d35ba..c390500604b6db50eb1bb1dbb8ee56f5e1bd8610 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -472,7 +472,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in);
 bool migration_is_setup_or_active(int state);
 bool migration_is_running(int state);
 
-void migrate_init(MigrationState *s);
+int migrate_init(MigrationState *s, Error **errp);
 bool migration_is_blocked(Error **errp);
 /* True if outgoing migration has entered postcopy phase */
 bool migration_in_postcopy(void);
diff --git a/migration/savevm.h b/migration/savevm.h
index e894bbc143313a34c5c573f0839d5c13567cc521..74669733dd63a080b765866c703234a5c4939223 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -31,6 +31,7 @@
 
 bool qemu_savevm_state_blocked(Error **errp);
 void qemu_savevm_non_migratable_list(strList **reasons);
+int qemu_savevm_state_prepare(Error **errp);
 void qemu_savevm_state_setup(QEMUFile *f);
 bool qemu_savevm_state_guest_unplug_pending(void);
 int qemu_savevm_state_resume_prepare(MigrationState *s);
diff --git a/migration/migration.c b/migration/migration.c
index ce01a3ba6af72aa35063f88355349ec739708d4a..d61e5727429aef92b129f04208ee82eff414bd97 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1392,8 +1392,15 @@ bool migration_is_active(MigrationState *s)
             s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
 }
 
-void migrate_init(MigrationState *s)
+int migrate_init(MigrationState *s, Error **errp)
 {
+    int ret;
+
+    ret = qemu_savevm_state_prepare(errp);
+    if (ret) {
+        return ret;
+    }
+
     /*
      * Reinitialise all migration state, except
      * parameters/capabilities that the user set, and
@@ -1432,6 +1439,8 @@ void migrate_init(MigrationState *s)
     memset(&mig_stats, 0, sizeof(mig_stats));
     memset(&compression_counters, 0, sizeof(compression_counters));
     migration_reset_vfio_bytes_transferred();
+
+    return 0;
 }
 
 int migrate_add_blocker_internal(Error *reason, Error **errp)
@@ -1641,7 +1650,9 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
         migrate_set_block_incremental(true);
     }
 
-    migrate_init(s);
+    if (migrate_init(s, errp)) {
+        return false;
+    }
 
     return true;
 }
diff --git a/migration/savevm.c b/migration/savevm.c
index e14efeced0fb8e4b2dc2b7799f5612799f185170..bb3e99194c608d4a08fe46182cfa67d94635d3c9 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1233,6 +1233,30 @@ bool qemu_savevm_state_guest_unplug_pending(void)
     return false;
 }
 
+int qemu_savevm_state_prepare(Error **errp)
+{
+    SaveStateEntry *se;
+    int ret;
+
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        if (!se->ops || !se->ops->save_prepare) {
+            continue;
+        }
+        if (se->ops->is_active) {
+            if (!se->ops->is_active(se->opaque)) {
+                continue;
+            }
+        }
+
+        ret = se->ops->save_prepare(se->opaque, errp);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
 void qemu_savevm_state_setup(QEMUFile *f)
 {
     MigrationState *ms = migrate_get_current();
@@ -1619,7 +1643,10 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
         return -EINVAL;
     }
 
-    migrate_init(ms);
+    ret = migrate_init(ms, errp);
+    if (ret) {
+        return ret;
+    }
     ms->to_dst_file = f;
 
     qemu_mutex_unlock_iothread();
-- 
2.41.0


