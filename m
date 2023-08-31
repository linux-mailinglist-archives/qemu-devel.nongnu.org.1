Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5491778F2C3
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 20:40:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbmaE-0002S6-BE; Thu, 31 Aug 2023 14:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qbmZw-0001nN-2j
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 14:39:43 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qbmZt-0002I7-LL
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 14:39:39 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6CDE32185E;
 Thu, 31 Aug 2023 18:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693507176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=swlq77dy5YMKKTArUbn3kVk9WsfzhHqGuEgL1/CaOcM=;
 b=SRbdK7is1oHdqq4ddneyNK/QIPCMPW709r5e9cPJSYPLwp4peJUIgkdTGxhwEXOp6u4GRu
 1ZQCwEGFq3l39XSyKX8syed9Y8Zm9ww8JwHyvG0SAUNjqVSv21NtpGX1c2HkbVCcNSmYg8
 j/Dkvggzom+txHxlPAbJdGO1pwK68ZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693507176;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=swlq77dy5YMKKTArUbn3kVk9WsfzhHqGuEgL1/CaOcM=;
 b=UwzeuiXzDwe8jFoP/GMKzu6pPhg3DKRalEdPdtiAra80pA/ZiTSEwU2vbh0T86T3IeNyIv
 fKEwF4J7gP5HZeCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0DE313583;
 Thu, 31 Aug 2023 18:39:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4LSDHmbe8GQhPgAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 31 Aug 2023 18:39:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>
Subject: [PATCH v5 8/8] migration: Add a wrapper to cleanup migration files
Date: Thu, 31 Aug 2023 15:39:16 -0300
Message-Id: <20230831183916.13203-9-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230831183916.13203-1-farosas@suse.de>
References: <20230831183916.13203-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

We currently have a pattern for cleaning up a migration QEMUFile:

  qemu_mutex_lock(&s->qemu_file_lock);
  file = s->file_name;
  s->file_name = NULL;
  qemu_mutex_unlock(&s->qemu_file_lock);

  migration_ioc_unregister_yank_from_file(file);
  qemu_file_shutdown(file);
  qemu_fclose(file);

This sequence requires some consideration about locking to avoid
TOC/TOU bugs and avoid passing NULL into the functions that don't
expect it.

There's not need to call a shutdown() right before a close() and a
shutdown() in another thread being issued as a means to unblock a file
should not collide with this close().

Create a wrapper function to make sure the locking is being done
properly. Remove the extra shutdown().

The yank is linked to the QIOChannel, so if more than one QEMUFile
share the same channel, care must be taken to (un)register only one
yank function.

Move the yank unregister before clearing the pointer, so we can avoid
locking and add a comment explaining we're only using the QEMUFile as
a way to access the channel.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c      | 93 ++++++++++++--------------------------
 migration/yank_functions.c |  5 ++
 2 files changed, 35 insertions(+), 63 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 7fec57ad7f..99d21c3442 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -217,6 +217,25 @@ MigrationIncomingState *migration_incoming_get_current(void)
     return current_incoming;
 }
 
+static void migration_file_release(QEMUFile **file)
+{
+    MigrationState *ms = migrate_get_current();
+    QEMUFile *tmp;
+
+    /*
+     * Reset the pointer before releasing it to avoid holding the lock
+     * for too long.
+     */
+    WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
+        tmp = *file;
+        *file = NULL;
+    }
+
+    if (tmp) {
+        qemu_fclose(tmp);
+    }
+}
+
 void migration_incoming_transport_cleanup(MigrationIncomingState *mis)
 {
     if (mis->socket_address_list) {
@@ -1155,8 +1174,6 @@ static void migrate_fd_cleanup(MigrationState *s)
     qemu_savevm_state_cleanup();
 
     if (s->to_dst_file) {
-        QEMUFile *tmp;
-
         trace_migrate_fd_cleanup();
         qemu_mutex_unlock_iothread();
         if (s->migration_thread_running) {
@@ -1166,16 +1183,9 @@ static void migrate_fd_cleanup(MigrationState *s)
         qemu_mutex_lock_iothread();
 
         multifd_save_cleanup();
-        qemu_mutex_lock(&s->qemu_file_lock);
-        tmp = s->to_dst_file;
-        s->to_dst_file = NULL;
-        qemu_mutex_unlock(&s->qemu_file_lock);
-        /*
-         * Close the file handle without the lock to make sure the
-         * critical section won't block for long.
-         */
-        migration_ioc_unregister_yank_from_file(tmp);
-        qemu_fclose(tmp);
+
+        migration_ioc_unregister_yank_from_file(s->to_dst_file);
+        migration_file_release(&s->to_dst_file);
     }
 
     /*
@@ -1815,38 +1825,6 @@ static int migrate_handle_rp_resume_ack(MigrationState *s, uint32_t value)
     return 0;
 }
 
-/*
- * Release ms->rp_state.from_dst_file (and postcopy_qemufile_src if
- * existed) in a safe way.
- */
-static void migration_release_dst_files(MigrationState *ms)
-{
-    QEMUFile *file;
-
-    WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
-        /*
-         * Reset the from_dst_file pointer first before releasing it, as we
-         * can't block within lock section
-         */
-        file = ms->rp_state.from_dst_file;
-        ms->rp_state.from_dst_file = NULL;
-    }
-
-    /*
-     * Do the same to postcopy fast path socket too if there is.  No
-     * locking needed because this qemufile should only be managed by
-     * return path thread.
-     */
-    if (ms->postcopy_qemufile_src) {
-        migration_ioc_unregister_yank_from_file(ms->postcopy_qemufile_src);
-        qemu_file_shutdown(ms->postcopy_qemufile_src);
-        qemu_fclose(ms->postcopy_qemufile_src);
-        ms->postcopy_qemufile_src = NULL;
-    }
-
-    qemu_fclose(file);
-}
-
 /*
  * Handles messages sent on the return path towards the source VM
  *
@@ -2046,7 +2024,12 @@ static int await_return_path_close_on_source(MigrationState *ms)
     ret = ms->rp_state.error;
     ms->rp_state.error = false;
 
-    migration_release_dst_files(ms);
+    migration_file_release(&ms->rp_state.from_dst_file);
+
+    if (ms->postcopy_qemufile_src) {
+        migration_ioc_unregister_yank_from_file(ms->postcopy_qemufile_src);
+    }
+    migration_file_release(&ms->postcopy_qemufile_src);
 
     trace_migration_return_path_end_after(ret);
     return ret;
@@ -2502,26 +2485,10 @@ static MigThrError postcopy_pause(MigrationState *s)
     assert(s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
 
     while (true) {
-        QEMUFile *file;
-
-        /*
-         * Current channel is possibly broken. Release it.  Note that this is
-         * guaranteed even without lock because to_dst_file should only be
-         * modified by the migration thread.  That also guarantees that the
-         * unregister of yank is safe too without the lock.  It should be safe
-         * even to be within the qemu_file_lock, but we didn't do that to avoid
-         * taking more mutex (yank_lock) within qemu_file_lock.  TL;DR: we make
-         * the qemu_file_lock critical section as small as possible.
-         */
+        /* Current channel is possibly broken. Release it. */
         assert(s->to_dst_file);
         migration_ioc_unregister_yank_from_file(s->to_dst_file);
-        qemu_mutex_lock(&s->qemu_file_lock);
-        file = s->to_dst_file;
-        s->to_dst_file = NULL;
-        qemu_mutex_unlock(&s->qemu_file_lock);
-
-        qemu_file_shutdown(file);
-        qemu_fclose(file);
+        migration_file_release(&s->to_dst_file);
 
         /*
          * We're already pausing, so ignore any errors on the return
diff --git a/migration/yank_functions.c b/migration/yank_functions.c
index d5a710a3f2..31b0d790e2 100644
--- a/migration/yank_functions.c
+++ b/migration/yank_functions.c
@@ -48,6 +48,11 @@ void migration_ioc_unregister_yank(QIOChannel *ioc)
     }
 }
 
+/*
+ * There's no direct relationship between the QEMUFile and the
+ * yank. This is just a convenience helper because the QIOChannel and
+ * the QEMUFile lifecycles happen to match.
+ */
 void migration_ioc_unregister_yank_from_file(QEMUFile *file)
 {
     QIOChannel *ioc = qemu_file_get_ioc(file);
-- 
2.35.3


