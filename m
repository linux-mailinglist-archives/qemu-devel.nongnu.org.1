Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CE379AA8A
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 19:16:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfkTx-0002rT-B1; Mon, 11 Sep 2023 13:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qfkTu-0002pY-Qe
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 13:13:50 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qfkTs-0000D9-7n
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 13:13:50 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CD2871F88C;
 Mon, 11 Sep 2023 17:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694452426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=86Hnc8VCm1b08YFeJ9MLYUHFLCAO81JcW8bL6osu5cc=;
 b=K/puJbCPKRac9ij2IyIMhXgGV0KBQ2Kdtr6wPodim38COEYN71tc6WzPENCxkQZlHzN1rw
 DMwcL10UvqWAUrRkO4WqKIDKFjGmUPsW/WNpfkBFXZCz1cS392xG5TqpY/StJ7jhUW/jeO
 rq3YXU59aXaBCiGWH0269oLEH0rW+m8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694452426;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=86Hnc8VCm1b08YFeJ9MLYUHFLCAO81JcW8bL6osu5cc=;
 b=JQk5g0TW1i4lD7Kr0GmOevQVo4YA6eWdwrJtU9KN9JAu4r7rVy0SXWzuBzoPM9y3SdSPFl
 3G0e6x/8WXRXrfCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 398DC139CC;
 Mon, 11 Sep 2023 17:13:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8MpGOshK/2QyIAAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 11 Sep 2023 17:13:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v6 10/10] migration: Add a wrapper to cleanup migration files
Date: Mon, 11 Sep 2023 14:13:20 -0300
Message-Id: <20230911171320.24372-11-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230911171320.24372-1-farosas@suse.de>
References: <20230911171320.24372-1-farosas@suse.de>
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

This sequence requires some consideration about locking to avoid
TOC/TOU bugs and avoid passing NULL into the functions that don't
expect it.

There's no need to call a shutdown() right before a close() and a
shutdown() in another thread being issued as a means to unblock a file
should not collide with this close().

Create a wrapper function to make sure the locking is being done
properly. Remove the extra shutdown().

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 89 ++++++++++++-------------------------------
 1 file changed, 25 insertions(+), 64 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 7fec57ad7f..3e94521321 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -217,6 +217,26 @@ MigrationIncomingState *migration_incoming_get_current(void)
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
+        qemu_fclose(tmp);
+    }
+}
+
 void migration_incoming_transport_cleanup(MigrationIncomingState *mis)
 {
     if (mis->socket_address_list) {
@@ -1155,8 +1175,6 @@ static void migrate_fd_cleanup(MigrationState *s)
     qemu_savevm_state_cleanup();
 
     if (s->to_dst_file) {
-        QEMUFile *tmp;
-
         trace_migrate_fd_cleanup();
         qemu_mutex_unlock_iothread();
         if (s->migration_thread_running) {
@@ -1166,16 +1184,7 @@ static void migrate_fd_cleanup(MigrationState *s)
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
+        migration_file_release(&s->to_dst_file);
     }
 
     /*
@@ -1815,38 +1824,6 @@ static int migrate_handle_rp_resume_ack(MigrationState *s, uint32_t value)
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
@@ -2046,7 +2023,8 @@ static int await_return_path_close_on_source(MigrationState *ms)
     ret = ms->rp_state.error;
     ms->rp_state.error = false;
 
-    migration_release_dst_files(ms);
+    migration_file_release(&ms->rp_state.from_dst_file);
+    migration_file_release(&ms->postcopy_qemufile_src);
 
     trace_migration_return_path_end_after(ret);
     return ret;
@@ -2502,26 +2480,9 @@ static MigThrError postcopy_pause(MigrationState *s)
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
-- 
2.35.3


