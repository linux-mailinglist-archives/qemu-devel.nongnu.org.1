Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DD4A22B5D
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Jan 2025 11:11:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdRV3-0003Iv-C8; Thu, 30 Jan 2025 05:10:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdRUz-0003AJ-9R
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:10:13 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdRUx-0007I1-1Y
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:10:12 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdRUt-00000006TyA-2Raz; Thu, 30 Jan 2025 11:10:07 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v4 11/33] migration: Add thread pool of optional load threads
Date: Thu, 30 Jan 2025 11:08:32 +0100
Message-ID: <6bd6ea6a59ef6b350fbffa1ae82830762559fa52.1738171076.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738171076.git.maciej.szmigiero@oracle.com>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.037, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Some drivers might want to make use of auxiliary helper threads during VM
state loading, for example to make sure that their blocking (sync) I/O
operations don't block the rest of the migration process.

Add a migration core managed thread pool to facilitate this use case.

The migration core will wait for these threads to finish before
(re)starting the VM at destination.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 include/migration/misc.h |  3 ++
 include/qemu/typedefs.h  |  2 +
 migration/migration.c    |  2 +-
 migration/migration.h    |  5 +++
 migration/savevm.c       | 92 +++++++++++++++++++++++++++++++++++++++-
 migration/savevm.h       |  2 +-
 6 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 67f7ef7a0e5c..bc5ce31b52e0 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -45,9 +45,12 @@ bool migrate_ram_is_ignored(RAMBlock *block);
 /* migration/block.c */
 
 AnnounceParameters *migrate_announce_params(void);
+
 /* migration/savevm.c */
 
 void dump_vmstate_json_to_file(FILE *out_fp);
+void qemu_loadvm_start_load_thread(MigrationLoadThread function,
+                                   void *opaque);
 
 /* migration/migration.c */
 void migration_object_init(void);
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 3d84efcac47a..fd23ff7771b1 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -131,5 +131,7 @@ typedef struct IRQState *qemu_irq;
  * Function types
  */
 typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
+typedef bool (*MigrationLoadThread)(void *opaque, bool *should_quit,
+                                    Error **errp);
 
 #endif /* QEMU_TYPEDEFS_H */
diff --git a/migration/migration.c b/migration/migration.c
index 65b51d360896..0f29188499e4 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -400,7 +400,7 @@ void migration_incoming_state_destroy(void)
      * RAM state cleanup needs to happen after multifd cleanup, because
      * multifd threads can use some of its states (receivedmap).
      */
-    qemu_loadvm_state_cleanup();
+    qemu_loadvm_state_cleanup(mis);
 
     if (mis->to_src_file) {
         /* Tell source that we are done */
diff --git a/migration/migration.h b/migration/migration.h
index c5731626bbfb..1699fe7d91cc 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -43,6 +43,7 @@
 #define  MIGRATION_THREAD_DST_PREEMPT       "mig/dst/preempt"
 
 struct PostcopyBlocktimeContext;
+typedef struct ThreadPool ThreadPool;
 
 #define  MIGRATION_RESUME_ACK_VALUE  (1)
 
@@ -187,6 +188,10 @@ struct MigrationIncomingState {
     Coroutine *colo_incoming_co;
     QemuSemaphore colo_incoming_sem;
 
+    /* Optional load threads pool and its thread exit request flag */
+    ThreadPool *load_threads;
+    bool load_threads_abort;
+
     /*
      * PostcopyBlocktimeContext to keep information for postcopy
      * live migration, to calculate vCPU block time
diff --git a/migration/savevm.c b/migration/savevm.c
index 0ceea9638cc1..74d1960de3c6 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -54,6 +54,7 @@
 #include "qemu/job.h"
 #include "qemu/main-loop.h"
 #include "block/snapshot.h"
+#include "block/thread-pool.h"
 #include "qemu/cutils.h"
 #include "io/channel-buffer.h"
 #include "io/channel-file.h"
@@ -131,6 +132,35 @@ static struct mig_cmd_args {
  * generic extendable format with an exception for two old entities.
  */
 
+/***********************************************************/
+/* Optional load threads pool support */
+
+static void qemu_loadvm_thread_pool_create(MigrationIncomingState *mis)
+{
+    assert(!mis->load_threads);
+    mis->load_threads = thread_pool_new();
+    mis->load_threads_abort = false;
+}
+
+static void qemu_loadvm_thread_pool_destroy(MigrationIncomingState *mis)
+{
+    qatomic_set(&mis->load_threads_abort, true);
+
+    bql_unlock(); /* Load threads might be waiting for BQL */
+    g_clear_pointer(&mis->load_threads, thread_pool_free);
+    bql_lock();
+}
+
+static bool qemu_loadvm_thread_pool_wait(MigrationState *s,
+                                         MigrationIncomingState *mis)
+{
+    bql_unlock(); /* Let load threads do work requiring BQL */
+    thread_pool_wait(mis->load_threads);
+    bql_lock();
+
+    return !migrate_has_error(s);
+}
+
 /***********************************************************/
 /* savevm/loadvm support */
 
@@ -2810,16 +2840,62 @@ static int qemu_loadvm_state_setup(QEMUFile *f, Error **errp)
     return 0;
 }
 
-void qemu_loadvm_state_cleanup(void)
+struct LoadThreadData {
+    MigrationLoadThread function;
+    void *opaque;
+};
+
+static int qemu_loadvm_load_thread(void *thread_opaque)
+{
+    struct LoadThreadData *data = thread_opaque;
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    g_autoptr(Error) local_err = NULL;
+
+    if (!data->function(data->opaque, &mis->load_threads_abort, &local_err)) {
+        MigrationState *s = migrate_get_current();
+
+        assert(local_err);
+
+        /*
+         * In case of multiple load threads failing which thread error
+         * return we end setting is purely arbitrary.
+         */
+        migrate_set_error(s, local_err);
+    }
+
+    return 0;
+}
+
+void qemu_loadvm_start_load_thread(MigrationLoadThread function,
+                                   void *opaque)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    struct LoadThreadData *data;
+
+    /* We only set it from this thread so it's okay to read it directly */
+    assert(!mis->load_threads_abort);
+
+    data = g_new(struct LoadThreadData, 1);
+    data->function = function;
+    data->opaque = opaque;
+
+    thread_pool_submit_immediate(mis->load_threads, qemu_loadvm_load_thread,
+                                 data, g_free);
+}
+
+void qemu_loadvm_state_cleanup(MigrationIncomingState *mis)
 {
     SaveStateEntry *se;
 
     trace_loadvm_state_cleanup();
+
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (se->ops && se->ops->load_cleanup) {
             se->ops->load_cleanup(se->opaque);
         }
     }
+
+    qemu_loadvm_thread_pool_destroy(mis);
 }
 
 /* Return true if we should continue the migration, or false. */
@@ -2970,6 +3046,7 @@ out:
 
 int qemu_loadvm_state(QEMUFile *f)
 {
+    MigrationState *s = migrate_get_current();
     MigrationIncomingState *mis = migration_incoming_get_current();
     Error *local_err = NULL;
     int ret;
@@ -2979,6 +3056,8 @@ int qemu_loadvm_state(QEMUFile *f)
         return -EINVAL;
     }
 
+    qemu_loadvm_thread_pool_create(mis);
+
     ret = qemu_loadvm_state_header(f);
     if (ret) {
         return ret;
@@ -3008,6 +3087,17 @@ int qemu_loadvm_state(QEMUFile *f)
         return ret;
     }
 
+    if (ret == 0) {
+        if (!qemu_loadvm_thread_pool_wait(s, mis)) {
+            ret = -EINVAL;
+        }
+    }
+    /*
+     * Set this flag unconditionally so we'll catch further attempts to
+     * start additional threads via an appropriate assert()
+     */
+    qatomic_set(&mis->load_threads_abort, true);
+
     if (ret == 0) {
         ret = qemu_file_get_error(f);
     }
diff --git a/migration/savevm.h b/migration/savevm.h
index 8b78493dbc0e..3fa06574e632 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -64,7 +64,7 @@ void qemu_savevm_live_state(QEMUFile *f);
 int qemu_save_device_state(QEMUFile *f);
 
 int qemu_loadvm_state(QEMUFile *f);
-void qemu_loadvm_state_cleanup(void);
+void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
 int qemu_load_device_state(QEMUFile *f);
 int qemu_loadvm_approve_switchover(void);

