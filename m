Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCC284A452
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Feb 2024 20:50:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX4yS-0008Oa-Cd; Mon, 05 Feb 2024 14:49:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1rX4yO-0008Mr-4D; Mon, 05 Feb 2024 14:49:44 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1rX4yK-0004Mi-Up; Mon, 05 Feb 2024 14:49:42 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E9649220CF;
 Mon,  5 Feb 2024 19:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707162579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RcI/y8jvmVgitvb508laoEwUnIXzhwQaVS94qyIogTc=;
 b=TDggMpU3uu7BxA31x4Uu2syqre2nec1NzMOk00vdl8WMYl2xe6p5JwJZSumCZRjPfiF0zu
 FZ4sxzIz4N2QBw8P7fYFdkqP6eJI2S4IYV3NUBD6C8yxPege2qvYcVn3g+kMa+vpS4sqIb
 8Bx4DGYQNckM54QJwS1+rLm6supB+fU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707162579;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RcI/y8jvmVgitvb508laoEwUnIXzhwQaVS94qyIogTc=;
 b=4rtj4bXyZ1s5wq3rEVlF3lvUCDNzan5AVxFMrzcc1IuYea8N2cWu47cdaQfXLd7k3pTrfL
 +yhtk/YotV6yDdCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707162577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RcI/y8jvmVgitvb508laoEwUnIXzhwQaVS94qyIogTc=;
 b=y98Vczr23+m1J05FvBWnka1+cdWmzW6cfYDMbCJJFEjY/fj8sY7U9t0lCDeN5XrDs2wsJW
 b6CYfmRb3iGYbjy/Z0Vkg4qrbrIVc75rxbRRlZ86MfpHJ3+YPNRphYVjvmAJdGhvuL3I3K
 E9iYPfvgr1l0z4hzEcs3bMxOojXSPKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707162577;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RcI/y8jvmVgitvb508laoEwUnIXzhwQaVS94qyIogTc=;
 b=z3YVun3gKapwHw3PuKF8fOxvI5stfsc6QWJ4L0HLpCDalRuhACJM8ra8Io+aEXFS/+1svT
 KgD2W9UDn/jtDICQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E97B136F5;
 Mon,  5 Feb 2024 19:49:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AKKbNc87wWWYQAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 05 Feb 2024 19:49:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>, chenyuhui5@huawei.com
Subject: [PATCH v2 2/6] migration/multifd: Remove p->running
Date: Mon,  5 Feb 2024 16:49:25 -0300
Message-Id: <20240205194929.28963-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240205194929.28963-1-farosas@suse.de>
References: <20240205194929.28963-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 0.77
X-Spamd-Result: default: False [0.77 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_THREE(0.00)[3]; NEURAL_HAM_SHORT(-0.13)[-0.643];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-3.00)[100.00%]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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
on a non existent thread if the thread has never been created.

However, there are at least two bugs in this logic:

1) On the sending side, p->running is set too early and
qemu_thread_create() can be skipped due to an error during TLS
handshake, leaving the flag set and leading to a crash when
multifd_send_cleanup() calls qemu_thread_join().

2) During exit, the multifd thread clears the flag while holding the
channel lock. The counterpart at multifd_send_cleanup() reads the flag
outside of the lock and might free the mutex while the multifd thread
still has it locked.

Fix the first issue by setting the flag right before creating the
thread. Rename it from p->running to p->thread_created to clarify its
usage.

Fix the second issue by not clearing the flag at the multifd thread
exit. We don't have any use for that.

Note that these bugs are straight-forward logic issues and not race
conditions. There is still a gap for races to affect this code due to
multifd_send_cleanup() being allowed to run concurrently with the
thread creation loop. This issue is solved in the next patches.

Cc: qemu-stable <qemu-stable@nongnu.org>
Fixes: 29647140157a ("migration/tls: add support for multifd tls-handshake")
Reported-by: Avihai Horon <avihaih@nvidia.com>
Reported-by: <chenyuhui5@huawei.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 27 ++++++++++++---------------
 migration/multifd.h |  7 ++-----
 2 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 8195c1daf3..515d88e04b 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -634,7 +634,7 @@ static void multifd_send_terminate_threads(void)
             qemu_thread_join(&p->tls_thread);
         }
 
-        if (p->running) {
+        if (p->thread_created) {
             qemu_thread_join(&p->thread);
         }
     }
@@ -862,7 +862,6 @@ out:
         error_free(local_err);
     }
 
-    p->running = false;
     rcu_unregister_thread();
     migration_threads_remove(thread);
     trace_multifd_send_thread_end(p->id, p->packets_sent, p->total_normal_pages);
@@ -953,6 +952,8 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
     migration_ioc_register_yank(ioc);
     p->registered_yank = true;
     p->c = ioc;
+
+    p->thread_created = true;
     qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
                        QEMU_THREAD_JOINABLE);
     return true;
@@ -967,7 +968,6 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
     trace_multifd_new_send_channel_async(p->id);
     if (!qio_task_propagate_error(task, &local_err)) {
         qio_channel_set_delay(ioc, false);
-        p->running = true;
         if (multifd_channel_connect(p, ioc, &local_err)) {
             return;
         }
@@ -1128,15 +1128,15 @@ void multifd_recv_cleanup(void)
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
+        if (p->thread_created) {
+            qemu_thread_join(&p->thread);
+        }
     }
     for (i = 0; i < migrate_multifd_channels(); i++) {
         multifd_recv_cleanup_channel(&multifd_recv_state->params[i]);
@@ -1222,9 +1222,6 @@ static void *multifd_recv_thread(void *opaque)
         multifd_recv_terminate_threads(local_err);
         error_free(local_err);
     }
-    qemu_mutex_lock(&p->mutex);
-    p->running = false;
-    qemu_mutex_unlock(&p->mutex);
 
     rcu_unregister_thread();
     trace_multifd_recv_thread_end(p->id, p->packets_recved, p->total_normal_pages);
@@ -1330,7 +1327,7 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
     p->c = ioc;
     object_ref(OBJECT(ioc));
 
-    p->running = true;
+    p->thread_created = true;
     qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
                        QEMU_THREAD_JOINABLE);
     qatomic_inc(&multifd_recv_state->count);
diff --git a/migration/multifd.h b/migration/multifd.h
index 720c9d50db..7881980ee6 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -73,6 +73,7 @@ typedef struct {
     char *name;
     /* channel thread id */
     QemuThread thread;
+    bool thread_created;
     QemuThread tls_thread;
     bool tls_thread_created;
     /* communication channel */
@@ -93,8 +94,6 @@ typedef struct {
     /* syncs main thread and channels */
     QemuSemaphore sem_sync;
 
-    /* is this channel thread running */
-    bool running;
     /* multifd flags for each packet */
     uint32_t flags;
     /*
@@ -143,6 +142,7 @@ typedef struct {
     char *name;
     /* channel thread id */
     QemuThread thread;
+    bool thread_created;
     /* communication channel */
     QIOChannel *c;
     /* packet allocated len */
@@ -157,8 +157,6 @@ typedef struct {
 
     /* this mutex protects the following parameters */
     QemuMutex mutex;
-    /* is this channel thread running */
-    bool running;
     /* should this thread finish */
     bool quit;
     /* multifd flags for each packet */
@@ -217,4 +215,3 @@ static inline void multifd_send_prepare_header(MultiFDSendParams *p)
 
 
 #endif
-
-- 
2.35.3


