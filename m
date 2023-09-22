Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E10117AB42E
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 16:54:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjhXI-0005BN-A9; Fri, 22 Sep 2023 10:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qjhXD-00052A-2Q
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 10:53:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qjhX6-00012B-U3
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 10:53:34 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 26FEC21D08;
 Fri, 22 Sep 2023 14:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695394407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S54/hWB4L38YKWaZobSVuX7FQvtzeZFISNNBdAlMUpU=;
 b=hfQHcXO/iyFZdSXvvr7wCALdRqkoer+rLWpSoc2w54Ha9+CuVGjyllQ9M5GPM4ViFV9A1N
 ueiH1S8xCTwXaJ4J2YNPoLww9ALB6ZR/WjD1REoN3e6GsN3nyWltWvsvsaPDoDyN/Xx79t
 EzOuHZbYsXzxAoKb8p8LgY5BiE4f9c4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695394407;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S54/hWB4L38YKWaZobSVuX7FQvtzeZFISNNBdAlMUpU=;
 b=9xVf74MJ7P6Ptb3SczWIoACmVD+MO+GiE37QjMVDx2RJeHcr0mtl3YyP7NkczMqu8FGkit
 hsyo8uEgAkB3SDCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D55313478;
 Fri, 22 Sep 2023 14:53:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UPaaGWWqDWUpDAAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 22 Sep 2023 14:53:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [RFC PATCH 2/3] migration/multifd: Decouple control flow from the
 SYNC packet
Date: Fri, 22 Sep 2023 11:53:18 -0300
Message-Id: <20230922145319.27380-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230922145319.27380-1-farosas@suse.de>
References: <20230922145319.27380-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
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

We currently have the sem_sync semaphore that is used:

1) on the sending side, to know when the multifd_send_thread has
   finished sending the MULTIFD_FLAG_SYNC packet;

  This is unnecessary. Multifd sends packets (not pages) one by one
  and completion is already bound by both the channels_ready and sem
  semaphores. The SYNC packet has nothing special that would require
  it to have a separate semaphore on the sending side.

2) on the receiving side, to know when the multifd_recv_thread has
   finished receiving the MULTIFD_FLAG_SYNC packet;

  This is unnecessary because the multifd_recv_state->sem_sync
  semaphore already does the same thing. We care that the SYNC arrived
  from the source, knowing that the SYNC has been received by the recv
  thread doesn't add anything.

3) on both sending and receiving sides, to wait for the multifd threads
   to finish before cleaning up;

   This happens because multifd_send_sync_main() blocks
   ram_save_complete() from finishing until the semaphore is
   posted. This is surprising and not documented.

Clarify the above situation by renaming 'sem_sync' to 'sem_done' and
making the #3 usage the main one. Stop tracking the SYNC packet on
source (#1) and leave multifd_recv_state->sem_sync untouched on the
destination (#2).

Due to the 'channels_ready' and 'sem' semaphores, we always send
packets in lockstep with switching MultiFDSendParams, so
p->pending_job is always either 1 or 0. The thread has no knowledge of
whether it will have more to send once it posts to
channels_ready. Send it on an extra loop so it sees no pending_job and
releases the semaphore.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c    | 89 ++++++++++++++++++++++++++++++++----------
 migration/multifd.h    |  8 ++--
 migration/trace-events |  2 +-
 3 files changed, 73 insertions(+), 26 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index d626740f2f..3d4a631915 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -541,7 +541,7 @@ void multifd_save_cleanup(void)
         p->c = NULL;
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem);
-        qemu_sem_destroy(&p->sem_sync);
+        qemu_sem_destroy(&p->sem_done);
         g_free(p->name);
         p->name = NULL;
         multifd_pages_clear(p->pages);
@@ -592,7 +592,7 @@ int multifd_send_sync_main(QEMUFile *f)
 
     if (!migrate_multifd()) {
         return 0;
-    }
+
     if (multifd_send_state->pages->num) {
         if (multifd_send_pages(f) < 0) {
             error_report("%s: multifd_send_pages fail", __func__);
@@ -600,6 +600,12 @@ int multifd_send_sync_main(QEMUFile *f)
         }
     }
 
+    /* wait for all channels to be idle */
+    for (i = 0; i < migrate_multifd_channels(); i++) {
+        trace_multifd_send_sync_main_wait(p->id);
+        qemu_sem_wait(&multifd_send_state->channels_ready);
+    }
+
     /*
      * When using zero-copy, it's necessary to flush the pages before any of
      * the pages can be sent again, so we'll make sure the new version of the
@@ -610,9 +616,46 @@ int multifd_send_sync_main(QEMUFile *f)
      * to be less frequent, e.g. only after we finished one whole scanning of
      * all the dirty bitmaps.
      */
-
     flush_zero_copy = migrate_zero_copy_send();
 
+    for (i = 0; i < migrate_multifd_channels(); i++) {
+        MultiFDSendParams *p = &multifd_send_state->params[i];
+
+        qemu_mutex_lock(&p->mutex);
+        assert(!p->pending_job);
+        qemu_mutex_unlock(&p->mutex);
+
+        qemu_sem_post(&p->sem);
+        qemu_sem_wait(&p->sem_done);
+
+        if (flush_zero_copy && p->c && (multifd_zero_copy_flush(p->c) < 0)) {
+            return -1;
+        }
+    }
+
+    /*
+     * All channels went idle and have no more jobs. Unless we send
+     * them more work, we're good to allow any cleanup code to run at
+     * this point.
+     */
+
+    return 0;
+}
+
+int multifd_send_sync_main(QEMUFile *f)
+{
+    int i, ret;
+
+    if (!migrate_multifd()) {
+        return 0;
+    }
+    if (multifd_send_state->pages->num) {
+        if (multifd_send_pages(f) < 0) {
+            error_report("%s: multifd_send_pages fail", __func__);
+            return -1;
+        }
+    }
+
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
@@ -633,11 +676,21 @@ int multifd_send_sync_main(QEMUFile *f)
         qemu_mutex_unlock(&p->mutex);
         qemu_sem_post(&p->sem);
     }
+
+    for (i = 0; i < migrate_multifd_channels(); i++) {
+        trace_multifd_send_wait(migrate_multifd_channels() - i);
+        qemu_sem_wait(&multifd_send_state->channels_ready);
+    }
+
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
-        trace_multifd_send_sync_main_wait(p->id);
-        qemu_sem_wait(&p->sem_sync);
+        qemu_mutex_lock(&p->mutex);
+        assert(!p->pending_job);
+        qemu_mutex_unlock(&p->mutex);
+
+        qemu_sem_post(&p->sem);
+        qemu_sem_wait(&p->sem_done);
 
         if (flush_zero_copy && p->c && (multifd_zero_copy_flush(p->c) < 0)) {
             return -1;
@@ -739,15 +792,9 @@ static void *multifd_send_thread(void *opaque)
             p->pending_job--;
             qemu_mutex_unlock(&p->mutex);
 
-            if (flags & MULTIFD_FLAG_SYNC) {
-                qemu_sem_post(&p->sem_sync);
-            }
-        } else if (p->quit) {
-            qemu_mutex_unlock(&p->mutex);
-            break;
         } else {
+            qemu_sem_post(&p->sem_done);
             qemu_mutex_unlock(&p->mutex);
-            /* sometimes there are spurious wakeups */
         }
     }
 
@@ -764,7 +811,7 @@ out:
      */
     if (ret != 0) {
         qemu_sem_post(&multifd_send_state->channels_ready);
-        qemu_sem_post(&p->sem_sync);
+        qemu_sem_post(&p->sem_done);
     }
 
     qemu_mutex_lock(&p->mutex);
@@ -802,7 +849,7 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
          */
         p->quit = true;
         qemu_sem_post(&multifd_send_state->channels_ready);
-        qemu_sem_post(&p->sem_sync);
+        qemu_sem_post(&p->sem_done);
     }
 }
 
@@ -880,7 +927,7 @@ static void multifd_new_send_channel_cleanup(MultiFDSendParams *p,
      migrate_set_error(migrate_get_current(), err);
      /* Error happen, we need to tell who pay attention to me */
      qemu_sem_post(&multifd_send_state->channels_ready);
-     qemu_sem_post(&p->sem_sync);
+     qemu_sem_post(&p->sem_done);
      /*
       * Although multifd_send_thread is not created, but main migration
       * thread need to judge whether it is running, so we need to mark
@@ -938,7 +985,7 @@ int multifd_save_setup(Error **errp)
 
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem, 0);
-        qemu_sem_init(&p->sem_sync, 0);
+        qemu_sem_init(&p->sem_done, 0);
         p->quit = false;
         p->pending_job = 0;
         p->id = i;
@@ -1047,7 +1094,7 @@ void multifd_load_cleanup(void)
              * multifd_recv_thread may hung at MULTIFD_FLAG_SYNC handle code,
              * however try to wakeup it without harm in cleanup phase.
              */
-            qemu_sem_post(&p->sem_sync);
+            qemu_sem_post(&p->sem_done);
         }
 
         qemu_thread_join(&p->thread);
@@ -1059,7 +1106,7 @@ void multifd_load_cleanup(void)
         object_unref(OBJECT(p->c));
         p->c = NULL;
         qemu_mutex_destroy(&p->mutex);
-        qemu_sem_destroy(&p->sem_sync);
+        qemu_sem_destroy(&p->sem_done);
         g_free(p->name);
         p->name = NULL;
         p->packet_len = 0;
@@ -1100,7 +1147,7 @@ void multifd_recv_sync_main(void)
             }
         }
         trace_multifd_recv_sync_main_signal(p->id);
-        qemu_sem_post(&p->sem_sync);
+        qemu_sem_post(&p->sem_done);
     }
     trace_multifd_recv_sync_main(multifd_recv_state->packet_num);
 }
@@ -1152,7 +1199,7 @@ static void *multifd_recv_thread(void *opaque)
 
         if (flags & MULTIFD_FLAG_SYNC) {
             qemu_sem_post(&multifd_recv_state->sem_sync);
-            qemu_sem_wait(&p->sem_sync);
+            qemu_sem_wait(&p->sem_done);
         }
     }
 
@@ -1195,7 +1242,7 @@ int multifd_load_setup(Error **errp)
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
         qemu_mutex_init(&p->mutex);
-        qemu_sem_init(&p->sem_sync, 0);
+        qemu_sem_init(&p->sem_done, 0);
         p->quit = false;
         p->id = i;
         p->packet_len = sizeof(MultiFDPacket_t)
diff --git a/migration/multifd.h b/migration/multifd.h
index a835643b48..2d53f91da3 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -90,8 +90,8 @@ typedef struct {
 
     /* sem where to wait for more work */
     QemuSemaphore sem;
-    /* syncs main thread and channels */
-    QemuSemaphore sem_sync;
+    /* channel is done transmitting until more pages are queued */
+    QemuSemaphore sem_done;
 
     /* this mutex protects the following parameters */
     QemuMutex mutex;
@@ -153,8 +153,8 @@ typedef struct {
     /* number of pages in a full packet */
     uint32_t page_count;
 
-    /* syncs main thread and channels */
-    QemuSemaphore sem_sync;
+    /* channel is done transmitting until more pages are queued */
+    QemuSemaphore sem_done;
 
     /* this mutex protects the following parameters */
     QemuMutex mutex;
diff --git a/migration/trace-events b/migration/trace-events
index 4666f19325..4367a1a22b 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -136,7 +136,7 @@ multifd_send(uint8_t id, uint64_t packet_num, uint32_t normal, uint32_t flags, u
 multifd_send_error(uint8_t id) "channel %u"
 multifd_send_sync_main(long packet_num) "packet num %ld"
 multifd_send_sync_main_signal(uint8_t id) "channel %u"
-multifd_send_sync_main_wait(uint8_t id) "channel %u"
+multifd_send_wait(uint8_t n) "waiting for %u channels to finish sending"
 multifd_send_terminate_threads(bool error) "error %d"
 multifd_send_thread_end(uint8_t id, uint64_t packets, uint64_t normal_pages) "channel %u packets %" PRIu64 " normal pages %"  PRIu64
 multifd_send_thread_start(uint8_t id) "%u"
-- 
2.35.3


