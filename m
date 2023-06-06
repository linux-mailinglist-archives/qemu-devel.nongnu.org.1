Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E42887246A6
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:46:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Xwk-0007w1-1q; Tue, 06 Jun 2023 10:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1q6Xwi-0007q4-5v
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:46:04 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1q6Xwg-0004R0-EC
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:46:03 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AE5731FD76;
 Tue,  6 Jun 2023 14:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1686062760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GlN22RhbQhJB6/5iBlVX5sHJkyTJGwjkb6VY0xTHKTg=;
 b=y642QhejnUzVZyFBgCpIONVcgL1T+e99lXi6OTHgvj0Ni3R/5KTcvP45546M1i3xCYVEU+
 UnYFJrluDI6F+QRsyCabSYCMJm59gLhPd7E0kVHmMf+GD8aYkCR+ErLpN2x5wDbHb/Af9S
 Zh+hivUWyc2nX1pP7zTBpmMIy/deYoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1686062760;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GlN22RhbQhJB6/5iBlVX5sHJkyTJGwjkb6VY0xTHKTg=;
 b=jcOinv/cH7HLpJ4jqjEpN52JN5J9EQ1tNJGPO9FvcBJkCDtMJxs0eo4wM72TpGkf6+uBFc
 NsdaKusGIIdC2BCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C627913519;
 Tue,  6 Jun 2023 14:45:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wIRmIqZGf2SRCAAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 06 Jun 2023 14:45:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 Jiang Jiacheng <jiangjiacheng@huawei.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 2/3] migration/multifd: Protect accesses to migration_threads
Date: Tue,  6 Jun 2023 11:45:50 -0300
Message-Id: <20230606144551.24367-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230606144551.24367-1-farosas@suse.de>
References: <20230606144551.24367-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This doubly linked list is common for all the multifd and migration
threads so we need to avoid concurrent access.

Add a mutex to protect the data from concurrent access. This fixes a
crash when removing two MigrationThread objects from the list at the
same time during cleanup of multifd threads.

To avoid destroying the mutex before the last element has been
removed, move calls to qmp_migration_thread_remove so they run before
multifd_save_cleanup joins the threads.

Fixes: 671326201d ("migration: Introduce interface query-migrationthreads")
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c  |  5 ++++-
 migration/multifd.c    |  3 ++-
 migration/threadinfo.c | 19 ++++++++++++++++++-
 migration/threadinfo.h |  5 +++--
 4 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index e731fc98a1..b3b8345eb2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1146,6 +1146,7 @@ static void migrate_fd_cleanup(MigrationState *s)
         qemu_mutex_lock_iothread();
 
         multifd_save_cleanup();
+        qmp_migration_threads_cleanup();
         qemu_mutex_lock(&s->qemu_file_lock);
         tmp = s->to_dst_file;
         s->to_dst_file = NULL;
@@ -1405,6 +1406,8 @@ void migrate_init(MigrationState *s)
     s->vm_old_state = -1;
     s->iteration_initial_bytes = 0;
     s->threshold_size = 0;
+
+    qmp_migration_threads_init();
 }
 
 int migrate_add_blocker_internal(Error *reason, Error **errp)
@@ -2997,10 +3000,10 @@ static void *migration_thread(void *opaque)
     }
 
     trace_migration_thread_after_loop();
+    qmp_migration_threads_remove(thread);
     migration_iteration_finish(s);
     object_unref(OBJECT(s));
     rcu_unregister_thread();
-    qmp_migration_threads_remove(thread);
     return NULL;
 }
 
diff --git a/migration/multifd.c b/migration/multifd.c
index 5ec1ac5c64..ee7944560a 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -762,12 +762,13 @@ out:
         qemu_sem_post(&multifd_send_state->channels_ready);
     }
 
+    qmp_migration_threads_remove(thread);
+
     qemu_mutex_lock(&p->mutex);
     p->running = false;
     qemu_mutex_unlock(&p->mutex);
 
     rcu_unregister_thread();
-    qmp_migration_threads_remove(thread);
     trace_multifd_send_thread_end(p->id, p->num_packets, p->total_normal_pages);
 
     return NULL;
diff --git a/migration/threadinfo.c b/migration/threadinfo.c
index c3e85c33e8..1fe64a02dd 100644
--- a/migration/threadinfo.c
+++ b/migration/threadinfo.c
@@ -10,23 +10,40 @@
  *  See the COPYING file in the top-level directory.
  */
 
+#include "qemu/osdep.h"
+#include "qemu/queue.h"
+#include "qemu/lockable.h"
 #include "threadinfo.h"
 
+QemuMutex migration_threads_lock;
 static QLIST_HEAD(, MigrationThread) migration_threads;
 
+void qmp_migration_threads_init(void)
+{
+    qemu_mutex_init(&migration_threads_lock);
+}
+
+void qmp_migration_threads_cleanup(void)
+{
+    qemu_mutex_destroy(&migration_threads_lock);
+}
+
 MigrationThread *qmp_migration_threads_add(const char *name, int thread_id)
 {
     MigrationThread *thread =  g_new0(MigrationThread, 1);
     thread->name = name;
     thread->thread_id = thread_id;
 
-    QLIST_INSERT_HEAD(&migration_threads, thread, node);
+    WITH_QEMU_LOCK_GUARD(&migration_threads_lock) {
+        QLIST_INSERT_HEAD(&migration_threads, thread, node);
+    }
 
     return thread;
 }
 
 void qmp_migration_threads_remove(MigrationThread *thread)
 {
+    QEMU_LOCK_GUARD(&migration_threads_lock);
     if (thread) {
         QLIST_REMOVE(thread, node);
         g_free(thread);
diff --git a/migration/threadinfo.h b/migration/threadinfo.h
index 61b990f5e3..eb7f8e5bb2 100644
--- a/migration/threadinfo.h
+++ b/migration/threadinfo.h
@@ -10,8 +10,6 @@
  *  See the COPYING file in the top-level directory.
  */
 
-#include "qemu/queue.h"
-#include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-migration.h"
 
@@ -23,5 +21,8 @@ struct MigrationThread {
     QLIST_ENTRY(MigrationThread) node;
 };
 
+void qmp_migration_threads_init(void);
+void qmp_migration_threads_cleanup(void);
+
 MigrationThread *qmp_migration_threads_add(const char *name, int thread_id);
 void qmp_migration_threads_remove(MigrationThread *info);
-- 
2.35.3


