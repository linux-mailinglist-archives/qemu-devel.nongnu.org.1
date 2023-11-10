Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A71B97E8359
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 21:04:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1XiR-00021X-Dz; Fri, 10 Nov 2023 15:02:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r1XiQ-00021L-Ec
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 15:02:54 -0500
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r1XiO-0004dx-Hb
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 15:02:54 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CAA99219B5;
 Fri, 10 Nov 2023 20:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1699646570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2aI0UloZRongbOYJrsT9CxfT8577Scr/Q6hhR4hYmDg=;
 b=1kuBlZ9Y9HzkyVNUFyEYxG7+ycQLcHFmeNMuGnOvyKrZDU6kk0psmPR19C9Nh4GKXU7SHY
 +LDouoiRvaqjOaYn5uUZ4kbaqdVFXi8H2gAKrLyq81DL5rqyy0iW8Wcn7l3Nhg5xYOQ2lW
 ESiJBjG8jsAS9ykNgnrcoQs+2w6J+EA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1699646570;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2aI0UloZRongbOYJrsT9CxfT8577Scr/Q6hhR4hYmDg=;
 b=v7gdYNxxqKVpED7XNDTbesahpiaH4VcqvHkXKCKVNVaNfv6JYTDVITa1S5ZuYvNgrOAmX4
 pVbLQoH733OKijCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 596F3138FC;
 Fri, 10 Nov 2023 20:02:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0Ml6CWmMTmWiaQAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 10 Nov 2023 20:02:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 3/4] migration/multifd: Remove p->running
Date: Fri, 10 Nov 2023 17:02:40 -0300
Message-Id: <20231110200241.20679-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231110200241.20679-1-farosas@suse.de>
References: <20231110200241.20679-1-farosas@suse.de>
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

We currently only need p->running to avoid calling qemu_thread_join()
on a non existent thread if the thread has never been created. We
could turn the QemuThread into a pointer and check for NULL instead
and get rid of the p->running flag. Testing the pointer directly is
more precise and less prone to misuse.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 41 ++++++++++++++++++++---------------------
 migration/multifd.h |  8 ++------
 2 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index d632dbc095..639505dd10 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -529,8 +529,8 @@ void multifd_save_cleanup(void)
             qemu_thread_join(p->tls_thread);
         }
 
-        if (p->running) {
-            qemu_thread_join(&p->thread);
+        if (p->thread) {
+            qemu_thread_join(p->thread);
         }
     }
     for (i = 0; i < migrate_multifd_channels(); i++) {
@@ -558,6 +558,8 @@ void multifd_save_cleanup(void)
         p->normal = NULL;
         g_free(p->tls_thread);
         p->tls_thread = NULL;
+        g_free(p->thread);
+        p->thread = NULL;
         multifd_send_state->ops->send_cleanup(p, &local_err);
         if (local_err) {
             migrate_set_error(migrate_get_current(), local_err);
@@ -762,10 +764,6 @@ out:
         error_free(local_err);
     }
 
-    qemu_mutex_lock(&p->mutex);
-    p->running = false;
-    qemu_mutex_unlock(&p->mutex);
-
     rcu_unregister_thread();
     migration_threads_remove(thread);
     trace_multifd_send_thread_end(p->id, p->num_packets, p->total_normal_pages);
@@ -860,7 +858,9 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
         migration_ioc_register_yank(ioc);
         p->registered_yank = true;
         p->c = ioc;
-        qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
+
+        p->thread = g_new0(QemuThread, 1);
+        qemu_thread_create(p->thread, p->name, multifd_send_thread, p,
                            QEMU_THREAD_JOINABLE);
     }
     return true;
@@ -892,7 +892,6 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
     trace_multifd_new_send_channel_async(p->id);
     if (!qio_task_propagate_error(task, &local_err)) {
         qio_channel_set_delay(ioc, false);
-        p->running = true;
         if (multifd_channel_connect(p, ioc, &local_err)) {
             return;
         }
@@ -1034,15 +1033,15 @@ void multifd_load_cleanup(void)
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
-        if (p->running) {
-            /*
-             * multifd_recv_thread may hung at MULTIFD_FLAG_SYNC handle code,
-             * however try to wakeup it without harm in cleanup phase.
-             */
-            qemu_sem_post(&p->sem_sync);
-        }
+        /*
+         * multifd_recv_thread may hung at MULTIFD_FLAG_SYNC handle code,
+         * however try to wakeup it without harm in cleanup phase.
+         */
+        qemu_sem_post(&p->sem_sync);
 
-        qemu_thread_join(&p->thread);
+        if (p->thread) {
+            qemu_thread_join(p->thread);
+        }
     }
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
@@ -1061,6 +1060,8 @@ void multifd_load_cleanup(void)
         p->iov = NULL;
         g_free(p->normal);
         p->normal = NULL;
+        g_free(p->thread);
+        p->thread = NULL;
         multifd_recv_state->ops->recv_cleanup(p);
     }
     qemu_sem_destroy(&multifd_recv_state->sem_sync);
@@ -1152,9 +1153,6 @@ static void *multifd_recv_thread(void *opaque)
         multifd_recv_terminate_threads(local_err);
         error_free(local_err);
     }
-    qemu_mutex_lock(&p->mutex);
-    p->running = false;
-    qemu_mutex_unlock(&p->mutex);
 
     rcu_unregister_thread();
     trace_multifd_recv_thread_end(p->id, p->num_packets, p->total_normal_pages);
@@ -1198,6 +1196,7 @@ int multifd_load_setup(Error **errp)
         p->normal = g_new0(ram_addr_t, page_count);
         p->page_count = page_count;
         p->page_size = qemu_target_page_size();
+        p->thread = g_new0(QemuThread, 1);
     }
 
     for (i = 0; i < thread_count; i++) {
@@ -1264,8 +1263,8 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
     /* initial packet */
     p->num_packets = 1;
 
-    p->running = true;
-    qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
+    p->thread = g_new0(QemuThread, 1);
+    qemu_thread_create(p->thread, p->name, multifd_recv_thread, p,
                        QEMU_THREAD_JOINABLE);
     qatomic_inc(&multifd_recv_state->count);
 }
diff --git a/migration/multifd.h b/migration/multifd.h
index 4ff78e9863..d21edaeaae 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -74,7 +74,7 @@ typedef struct {
     /* channel thread name */
     char *name;
     /* channel thread id */
-    QemuThread thread;
+    QemuThread *thread;
     QemuThread *tls_thread;
     /* communication channel */
     QIOChannel *c;
@@ -96,8 +96,6 @@ typedef struct {
 
     /* this mutex protects the following parameters */
     QemuMutex mutex;
-    /* is this channel thread running */
-    bool running;
     /* should this thread finish */
     bool quit;
     /* multifd flags for each packet */
@@ -144,7 +142,7 @@ typedef struct {
     /* channel thread name */
     char *name;
     /* channel thread id */
-    QemuThread thread;
+    QemuThread *thread;
     /* communication channel */
     QIOChannel *c;
     /* packet allocated len */
@@ -159,8 +157,6 @@ typedef struct {
 
     /* this mutex protects the following parameters */
     QemuMutex mutex;
-    /* is this channel thread running */
-    bool running;
     /* should this thread finish */
     bool quit;
     /* multifd flags for each packet */
-- 
2.35.3


