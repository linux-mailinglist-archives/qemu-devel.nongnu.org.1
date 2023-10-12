Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8F77C700F
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 16:08:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqwM6-0000xu-9E; Thu, 12 Oct 2023 10:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqwLG-0008Ns-32
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:07:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqwLE-0008FM-2f
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:07:09 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 971121F896;
 Thu, 12 Oct 2023 14:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697119626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=++Is/2mFziUP/EUP+aPGrjXPSq6ScRThkQMj6DrB2oc=;
 b=iUS/ly2k+F/WDgx53vDoj2n0UdPzCP5IBI+aLLr6ZSm4hT0PkQaiJwPoMsNEX+vDFx0c/F
 HWO8QXpQ+S6HM+L4JQmpwFggE7ijpxjocscSU1odFg4oqSF8ldu4x6rJaTdGlYY+iO879v
 S6nOBBo+68TfdQufVmyGa79Y5hKDVII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697119626;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=++Is/2mFziUP/EUP+aPGrjXPSq6ScRThkQMj6DrB2oc=;
 b=PYRFIJYyjc7uzhJaC+II9ppeRcUNG01hju5QCwdKQ073iwRHa3liinWhGtFg6NwbFmH/H/
 YxbgfGkteLisggCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 204B9139ED;
 Thu, 12 Oct 2023 14:07:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EFEmN4j9J2U5CgAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 12 Oct 2023 14:07:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [RFC PATCH v2 6/6] migration/multifd: Bring back the 'ready' semaphore
Date: Thu, 12 Oct 2023 11:06:51 -0300
Message-Id: <20231012140651.13122-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231012140651.13122-1-farosas@suse.de>
References: <20231012140651.13122-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
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

Bring back the 'ready' semaphore, but this time make it per-channel,
so that we can do true lockstep switching of MultiFDPages without
taking the channel lock.

Drop the channel lock as it now becomes useless. The rules for
accessing the MultiFDSendParams are:

- between sem and sem_done/ready if we're the channel

    qemu_sem_post(&p->ready);
    qemu_sem_wait(&p->sem);
    <owns p>
    qemu_sem_post(&p->sem_done);

- between ready and sem if we're not the channel

    qemu_sem_wait(&p->ready);
    <owns p>
    qemu_sem_post(&p->sem);

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
One issue I can see with this is that we might now have to wait at
multifd_send_pages() if a channel takes too long to send it's packet
and come back to p->ready. We would need to find a way of ignoring a
slow channel and skipping ahead to the next one in line.
---
 migration/multifd.c | 45 +++++++++++++--------------------------------
 migration/multifd.h |  5 ++---
 2 files changed, 15 insertions(+), 35 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index b7ba3fe0e6..7fa7bc33fd 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -410,10 +410,10 @@ static int multifd_send_pages(QEMUFile *f)
     for (i = next_channel;; i = (i + 1) % migrate_multifd_channels()) {
         p = &multifd_send_state->params[i];
 
-        qemu_mutex_lock(&p->mutex);
+        qemu_sem_wait(&p->ready);
+
         if (p->quit) {
             error_report("%s: channel %d has already quit!", __func__, i);
-            qemu_mutex_unlock(&p->mutex);
             return -1;
         }
         if (!p->pending_job) {
@@ -421,7 +421,6 @@ static int multifd_send_pages(QEMUFile *f)
             next_channel = (i + 1) % migrate_multifd_channels();
             break;
         }
-        qemu_mutex_unlock(&p->mutex);
     }
     assert(!p->pages->num);
     assert(!p->pages->block);
@@ -429,7 +428,6 @@ static int multifd_send_pages(QEMUFile *f)
     p->packet_num = multifd_send_state->packet_num++;
     multifd_send_state->pages = p->pages;
     p->pages = pages;
-    qemu_mutex_unlock(&p->mutex);
     qemu_sem_post(&p->sem);
 
     return 1;
@@ -529,9 +527,9 @@ void multifd_save_cleanup(void)
         }
         socket_send_channel_destroy(p->c);
         p->c = NULL;
-        qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem);
         qemu_sem_destroy(&p->sem_done);
+        qemu_sem_destroy(&p->ready);
         g_free(p->name);
         p->name = NULL;
         multifd_pages_clear(p->pages);
@@ -586,14 +584,12 @@ static void multifd_send_wait(void)
          * Even idle channels will wait for p->sem at the top of the
          * loop.
          */
+        qemu_sem_wait(&p->ready);
         qemu_sem_post(&p->sem);
 
         trace_multifd_send_wait(migrate_multifd_channels() - i);
         qemu_sem_wait(&p->sem_done);
-
-        qemu_mutex_lock(&p->mutex);
         assert(!p->pending_job || p->quit);
-        qemu_mutex_unlock(&p->mutex);
     }
 
     /*
@@ -621,20 +617,17 @@ int multifd_send_sync_main(QEMUFile *f)
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
+        qemu_sem_wait(&p->ready);
         trace_multifd_send_sync_main_signal(p->id);
 
-        qemu_mutex_lock(&p->mutex);
-
         if (p->quit) {
             error_report("%s: channel %d has already quit", __func__, i);
-            qemu_mutex_unlock(&p->mutex);
             return -1;
         }
 
         p->packet_num = multifd_send_state->packet_num++;
         p->flags |= MULTIFD_FLAG_SYNC;
         p->pending_job++;
-        qemu_mutex_unlock(&p->mutex);
         qemu_sem_post(&p->sem);
     }
 
@@ -685,15 +678,14 @@ static void *multifd_send_thread(void *opaque)
     p->num_packets = 1;
 
     while (true) {
+        qemu_sem_post(&p->ready);
         qemu_sem_wait(&p->sem);
 
         if (qatomic_read(&multifd_send_state->exiting)) {
-            qemu_mutex_lock(&p->mutex);
             p->quit = true;
-            qemu_mutex_unlock(&p->mutex);
+            qemu_sem_post(&p->sem_done);
             break;
         }
-        qemu_mutex_lock(&p->mutex);
 
         if (p->pending_job) {
             uint64_t packet_num = p->packet_num;
@@ -714,7 +706,6 @@ static void *multifd_send_thread(void *opaque)
             if (p->normal_num) {
                 ret = multifd_send_state->ops->send_prepare(p, &local_err);
                 if (ret != 0) {
-                    qemu_mutex_unlock(&p->mutex);
                     break;
                 }
             }
@@ -725,7 +716,6 @@ static void *multifd_send_thread(void *opaque)
             p->total_normal_pages += p->normal_num;
             p->pages->num = 0;
             p->pages->block = NULL;
-            qemu_mutex_unlock(&p->mutex);
 
             trace_multifd_send(p->id, packet_num, p->normal_num, flags,
                                p->next_packet_size);
@@ -753,12 +743,9 @@ static void *multifd_send_thread(void *opaque)
 
             stat64_add(&mig_stats.multifd_bytes, p->next_packet_size);
             stat64_add(&mig_stats.transferred, p->next_packet_size);
-            qemu_mutex_lock(&p->mutex);
             p->pending_job--;
-            qemu_mutex_unlock(&p->mutex);
 
         } else {
-            qemu_mutex_unlock(&p->mutex);
             qemu_sem_post(&p->sem_done);
         }
     }
@@ -766,11 +753,8 @@ static void *multifd_send_thread(void *opaque)
 out:
     if (local_err) {
         trace_multifd_send_error(p->id);
-
-        qemu_mutex_lock(&p->mutex);
         p->quit = true;
-        qemu_mutex_unlock(&p->mutex);
-
+        qemu_sem_post(&p->ready);
         multifd_send_terminate_threads(local_err);
         error_free(local_err);
     }
@@ -780,12 +764,10 @@ out:
      * who pay attention to me.
      */
     if (ret != 0) {
-        qemu_sem_post(&p->sem_done);
+        p->quit = true;
+        qemu_sem_post(&p->ready);
     }
-
-    qemu_mutex_lock(&p->mutex);
     p->running = false;
-    qemu_mutex_unlock(&p->mutex);
 
     rcu_unregister_thread();
     migration_threads_remove(thread);
@@ -817,7 +799,7 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
          * is not created, and then tell who pay attention to me.
          */
         p->quit = true;
-        qemu_sem_post(&p->sem_done);
+        qemu_sem_post(&p->ready);
     }
 }
 
@@ -893,14 +875,13 @@ static void multifd_new_send_channel_cleanup(MultiFDSendParams *p,
                                              QIOChannel *ioc, Error *err)
 {
      migrate_set_error(migrate_get_current(), err);
-     /* Error happen, we need to tell who pay attention to me */
-     qemu_sem_post(&p->sem_done);
      /*
       * Although multifd_send_thread is not created, but main migration
       * thread need to judge whether it is running, so we need to mark
       * its status.
       */
      p->quit = true;
+     qemu_sem_post(&p->ready);
      object_unref(OBJECT(ioc));
      error_free(err);
 }
@@ -944,9 +925,9 @@ int multifd_save_setup(Error **errp)
     for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
-        qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem, 0);
         qemu_sem_init(&p->sem_done, 0);
+        qemu_sem_init(&p->ready, 0);
         p->quit = false;
         p->pending_job = 0;
         p->id = i;
diff --git a/migration/multifd.h b/migration/multifd.h
index 71bd66974d..6bb10b07aa 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -93,8 +93,8 @@ typedef struct {
     /* channel is done transmitting until more pages are queued */
     QemuSemaphore sem_done;
 
-    /* this mutex protects the following parameters */
-    QemuMutex mutex;
+    QemuSemaphore ready;
+
     /* is this channel thread running */
     bool running;
     /* should this thread finish */
@@ -209,4 +209,3 @@ typedef struct {
 void multifd_register_ops(int method, MultiFDMethods *ops);
 
 #endif
-
-- 
2.35.3


