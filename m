Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E0177927C
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 17:09:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUTlA-0000gZ-A7; Fri, 11 Aug 2023 11:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qUTl9-0000fj-98
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 11:09:03 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qUTl7-0006Lc-H4
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 11:09:03 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CC0981F889;
 Fri, 11 Aug 2023 15:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1691766539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vucv+zdUSHjVRXTo91p5aoBDVvdrWkIX3/yex5hGXWU=;
 b=RRWlAd0y0JCWOmNrbpaC6X7lEUGm+ACjBHKOxahWixYmC5TMnuloUPqPh9SpVFceZ1ZhSY
 NmA9p28b3VHPi7kTv91VMCbUG+UBq7rzQ9pPXa0XkamK4gbvAUHz003OXlOqCWudl6qc/k
 bvD0ENsrmorPS0mTP6iWV2jCGBpIK/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1691766539;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vucv+zdUSHjVRXTo91p5aoBDVvdrWkIX3/yex5hGXWU=;
 b=axtuA3C1Sb+v7lPwSeVMDv7pZ6IhtBonHZ90AF7Jv0EHcpi6uVaDbbcwCPNEUA+f8sFdbW
 gb8yRRE8BwNGRGDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A7D413592;
 Fri, 11 Aug 2023 15:08:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AOFSNQlP1mS7KwAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 11 Aug 2023 15:08:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>
Subject: [PATCH v3 10/10] migration: Add a wrapper to cleanup migration files
Date: Fri, 11 Aug 2023 12:08:36 -0300
Message-Id: <20230811150836.2895-11-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230811150836.2895-1-farosas@suse.de>
References: <20230811150836.2895-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

There are some considerations for this sequence:

- we must clear the pointer under the lock, to avoid TOC/TOU bugs;
- the shutdown() and close() expect be given a non-null parameter;
- a close() in one thread should not race with a shutdown() in another;

Create a wrapper function to make sure everything works correctly.

Note: the return path did not used to call
      migration_ioc_unregister_yank_from_file(), but I added it
      nonetheless for uniformity.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 92 ++++++++++++-------------------------------
 util/yank.c           |  2 -
 2 files changed, 26 insertions(+), 68 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 4df5ca25c1..3c33e4fae4 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -217,6 +217,27 @@ MigrationIncomingState *migration_incoming_get_current(void)
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
+        migration_ioc_unregister_yank_from_file(tmp);
+        qemu_file_shutdown(tmp);
+        qemu_fclose(tmp);
+    }
+}
+
 void migration_incoming_transport_cleanup(MigrationIncomingState *mis)
 {
     if (mis->socket_address_list) {
@@ -1155,8 +1176,6 @@ static void migrate_fd_cleanup(MigrationState *s)
     qemu_savevm_state_cleanup();
 
     if (s->to_dst_file) {
-        QEMUFile *tmp;
-
         trace_migrate_fd_cleanup();
         qemu_mutex_unlock_iothread();
         if (s->migration_thread_running) {
@@ -1166,17 +1185,7 @@ static void migrate_fd_cleanup(MigrationState *s)
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
-        qemu_file_shutdown(tmp);
-        qemu_fclose(tmp);
+        migration_file_release(&s->to_dst_file);
     }
 
     /*
@@ -1816,39 +1825,6 @@ static int migrate_handle_rp_resume_ack(MigrationState *s, uint32_t value)
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
-    qemu_file_shutdown(file);
-    qemu_fclose(file);
-}
-
 /*
  * Handles messages sent on the return path towards the source VM
  *
@@ -2048,7 +2024,8 @@ static int await_return_path_close_on_source(MigrationState *ms)
     ret = ms->rp_state.error;
     ms->rp_state.error = false;
 
-    migration_release_dst_files(ms);
+    migration_file_release(&ms->rp_state.from_dst_file);
+    migration_file_release(&ms->postcopy_qemufile_src);
 
     trace_migration_return_path_end_after(ret);
     return ret;
@@ -2504,26 +2481,9 @@ static MigThrError postcopy_pause(MigrationState *s)
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
-        migration_ioc_unregister_yank_from_file(s->to_dst_file);
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
diff --git a/util/yank.c b/util/yank.c
index abf47c346d..4b6afbf589 100644
--- a/util/yank.c
+++ b/util/yank.c
@@ -146,8 +146,6 @@ void yank_unregister_function(const YankInstance *instance,
             return;
         }
     }
-
-    abort();
 }
 
 void qmp_yank(YankInstanceList *instances,
-- 
2.35.3


