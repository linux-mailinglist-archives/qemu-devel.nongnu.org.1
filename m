Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0C47E8350
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 21:03:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1XiT-00022g-AM; Fri, 10 Nov 2023 15:02:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r1XiR-00021g-GR
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 15:02:55 -0500
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r1XiP-0004eF-Q0
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 15:02:55 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B1B90219B9;
 Fri, 10 Nov 2023 20:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1699646572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nZpA8N+9GDsiJN8mA/lqa+vyWaYNZiYwdvx4LS9shsI=;
 b=DnLRJA7lJeYRAGRCryl/YINUyslowVAtl8W9iS5WV1257n5LHQv3NU2Nieyfo44PjIOC6t
 4+aGZTGmKXIUsw54khfOyHqV6a/95SAb6MZDPxX7c5R2dIFHnaRjhTAMgmKQrB2XO1qJM7
 59i/E0wAKmwSFyMFHosRDrxWNmz8PqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1699646572;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nZpA8N+9GDsiJN8mA/lqa+vyWaYNZiYwdvx4LS9shsI=;
 b=Pg4P5eoWEbOtkBObHmxf8upiOhi3lpE87/ehNkPNXFNBYxRiKjmsu3Av8WpJOQ5RUyHE1B
 Txbmb2EbOA66XPBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 40BFD138FC;
 Fri, 10 Nov 2023 20:02:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6D2LA2uMTmWiaQAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 10 Nov 2023 20:02:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 4/4] migration/multifd: Move semaphore release into
 main thread
Date: Fri, 10 Nov 2023 17:02:41 -0300
Message-Id: <20231110200241.20679-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231110200241.20679-1-farosas@suse.de>
References: <20231110200241.20679-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
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

Move the call to multifd_save_cleanup() before joining the migration
thread so we release the semaphores before and avoid deadlock.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c |  4 +++-
 migration/multifd.c   | 33 +++++++++++++++++----------------
 2 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 28a34c9068..5a07f5318d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1293,6 +1293,9 @@ static void migrate_fd_cleanup(MigrationState *s)
         QEMUFile *tmp;
 
         trace_migrate_fd_cleanup();
+
+        multifd_save_cleanup();
+
         qemu_mutex_unlock_iothread();
         if (s->migration_thread_running) {
             qemu_thread_join(&s->thread);
@@ -1300,7 +1303,6 @@ static void migrate_fd_cleanup(MigrationState *s)
         }
         qemu_mutex_lock_iothread();
 
-        multifd_save_cleanup();
         qemu_mutex_lock(&s->qemu_file_lock);
         tmp = s->to_dst_file;
         s->to_dst_file = NULL;
diff --git a/migration/multifd.c b/migration/multifd.c
index 639505dd10..a66be2d4e4 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -531,6 +531,15 @@ void multifd_save_cleanup(void)
 
         if (p->thread) {
             qemu_thread_join(p->thread);
+        } else {
+            /*
+             * The migration thread might be waiting on these. It is
+             * the responsibility of the channel thread to release
+             * them, unless it has never been created, then do it
+             * here.
+             */
+            qemu_sem_post(&p->sem_sync);
+            qemu_sem_post(&multifd_send_state->channels_ready);
         }
     }
     for (i = 0; i < migrate_multifd_channels(); i++) {
@@ -784,20 +793,15 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
 
     if (!qio_task_propagate_error(task, &err)) {
         trace_multifd_tls_outgoing_handshake_complete(ioc);
-        if (multifd_channel_connect(p, ioc, &err)) {
-            return;
-        }
+        multifd_channel_connect(p, ioc, &error_abort);
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
@@ -870,9 +874,6 @@ static void multifd_new_send_channel_cleanup(MultiFDSendParams *p,
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


