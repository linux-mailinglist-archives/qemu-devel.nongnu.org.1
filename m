Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D687E6FC3
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 17:59:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r18N3-0000Vw-SK; Thu, 09 Nov 2023 11:59:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r18N1-0000VR-Vp
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 11:59:07 -0500
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r18Mz-00043u-JY
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 11:59:07 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1F4FB21989;
 Thu,  9 Nov 2023 16:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1699549144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+wd/S9CpqNrpGfHOVNwNzoqNmI6AASWsTqjWJoA4fGM=;
 b=2OYT/uSgxZyA1zG817Q4JLLa8YY9taoWqCcUnha+RDQ14M0d4zMcnYf/Ly9wkxy9xVOi+C
 n1mTx9UmxhVz3VGEWFZ9ToH1Roe1KJxcA/IcLAd3SdwMQx52y6WT0CtOWSMX59PmkgzOUy
 BslbDTecGVjD8EtExYwrs2rEZJAAk4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1699549144;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+wd/S9CpqNrpGfHOVNwNzoqNmI6AASWsTqjWJoA4fGM=;
 b=tkadnTKw2ijwGx66dg3u2l0evkm43P4PtybwAz/t/NfUHzzc4d12I2Ak0hkeli3n7izYDZ
 5Xzt8CApOHgXKABQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 86ED9138E5;
 Thu,  9 Nov 2023 16:59:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EI1xFNYPTWVXNwAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 09 Nov 2023 16:59:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 2/2] migration/multifd: Move semaphore release into main
 thread
Date: Thu,  9 Nov 2023 13:58:56 -0300
Message-Id: <20231109165856.15224-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231109165856.15224-1-farosas@suse.de>
References: <20231109165856.15224-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

We cannot operate on the multifd semaphores outside of the multifd
channel thread because multifd_save_cleanup() can run in parallel and
attempt to destroy the mutexes, which causes an assert.

Looking at the places where we use the semaphores aside from the
migration thread, there's only the TLS handshake thread and the
initial multifd_channel_connect() in the main thread. These are places
where creating the multifd channel cannot fail, so releasing the
semaphores at these places only serves the purpose of avoiding a
deadlock when an error happens before the channel(s) have started, but
after the migration thread has already called
multifd_send_sync_main().

Instead of attempting to release the semaphores at those places, move
the release into multifd_save_cleanup(). This puts the semaphore usage
in the same thread that does the cleanup, eliminating the race.

Move the call to multifd_save_cleanup() before joining for the
migration thread so we release the semaphores before.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c |  4 +++-
 migration/multifd.c   | 29 +++++++++++------------------
 2 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index cca32c553c..52be20561b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1300,6 +1300,9 @@ static void migrate_fd_cleanup(MigrationState *s)
         QEMUFile *tmp;
 
         trace_migrate_fd_cleanup();
+
+        multifd_save_cleanup();
+
         qemu_mutex_unlock_iothread();
         if (s->migration_thread_running) {
             qemu_thread_join(&s->thread);
@@ -1307,7 +1310,6 @@ static void migrate_fd_cleanup(MigrationState *s)
         }
         qemu_mutex_lock_iothread();
 
-        multifd_save_cleanup();
         qemu_mutex_lock(&s->qemu_file_lock);
         tmp = s->to_dst_file;
         s->to_dst_file = NULL;
diff --git a/migration/multifd.c b/migration/multifd.c
index ec58c58082..9ca482cfbe 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -527,6 +527,9 @@ void multifd_save_cleanup(void)
 
         if (p->running) {
             qemu_thread_join(&p->thread);
+        } else {
+            qemu_sem_post(&p->sem_sync);
+            qemu_sem_post(&multifd_send_state->channels_ready);
         }
     }
     for (i = 0; i < migrate_multifd_channels(); i++) {
@@ -751,8 +754,6 @@ out:
         assert(local_err);
         trace_multifd_send_error(p->id);
         multifd_send_terminate_threads(local_err);
-        qemu_sem_post(&p->sem_sync);
-        qemu_sem_post(&multifd_send_state->channels_ready);
         error_free(local_err);
     }
 
@@ -780,20 +781,15 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
 
     if (!qio_task_propagate_error(task, &err)) {
         trace_multifd_tls_outgoing_handshake_complete(ioc);
-        if (multifd_channel_connect(p, ioc, &err)) {
-            return;
-        }
+        multifd_channel_connect(p, ioc, NULL);
+    } else {
+        /*
+         * The multifd client could already be waiting to queue data,
+         * so let it know that we didn't even start.
+         */
+        p->quit = true;
+        trace_multifd_tls_outgoing_handshake_error(ioc, error_get_pretty(err));
     }
-
-    trace_multifd_tls_outgoing_handshake_error(ioc, error_get_pretty(err));
-
-    /*
-     * Error happen, mark multifd_send_thread status as 'quit' although it
-     * is not created, and then tell who pay attention to me.
-     */
-    p->quit = true;
-    qemu_sem_post(&multifd_send_state->channels_ready);
-    qemu_sem_post(&p->sem_sync);
 }
 
 static void *multifd_tls_handshake_thread(void *opaque)
@@ -862,9 +858,6 @@ static void multifd_new_send_channel_cleanup(MultiFDSendParams *p,
                                              QIOChannel *ioc, Error *err)
 {
      migrate_set_error(migrate_get_current(), err);
-     /* Error happen, we need to tell who pay attention to me */
-     qemu_sem_post(&multifd_send_state->channels_ready);
-     qemu_sem_post(&p->sem_sync);
      /*
       * Although multifd_send_thread is not created, but main migration
       * thread need to judge whether it is running, so we need to mark
-- 
2.35.3


