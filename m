Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9937C7011
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 16:08:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqwM5-0000qP-DF; Thu, 12 Oct 2023 10:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqwLG-0008NQ-5E
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:07:11 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqwL9-0008EW-V2
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:07:08 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DE1691F74C;
 Thu, 12 Oct 2023 14:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697119620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VqP+ho12n+Y5hPTN0+FsvdUNCjTSc5IPV+iWy1nErzs=;
 b=nrXQXwUZI6YL6ngTRXd+H7dGLnDBIVfiHvl9PqbDpzCeZCLM4ifvrdUnDyt/MDVd0FwQ3m
 GY7sMF6BdOBITHNqUIPP9cAm8apjDshtx+tlptkfdOHkyrKPmavP9NudGKmwuljJv17xVG
 A0O3mjG0PlaXEoNp986OOih8FcUFbTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697119620;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VqP+ho12n+Y5hPTN0+FsvdUNCjTSc5IPV+iWy1nErzs=;
 b=knmpAnX8kyfuV1hXJjHURLDUraf2xIMSomWjG8Kmj4Nf8jVZN4t/p6dSJiZyDgD69BsQcv
 RNT02rYXDAHe1LCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5BF04139ED;
 Thu, 12 Oct 2023 14:06:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8NzsCYP9J2U5CgAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 12 Oct 2023 14:06:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [RFC PATCH v2 3/6] migration/multifd: Decouple control flow from the
 SYNC packet
Date: Thu, 12 Oct 2023 11:06:48 -0300
Message-Id: <20231012140651.13122-4-farosas@suse.de>
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

We currently use the 'sem_sync' semaphore on the sending side:

1) to know when the multifd_send_thread() has finished sending the
   MULTIFD_FLAG_SYNC packet;

  This is unnecessary. Multifd sends packets one by one and completion
  is already bound by the 'sem' semaphore. The SYNC packet has nothing
  special that would require it to have a separate semaphore on the
  sending side.

2) to wait for the multifd threads to finish before cleaning up;

   This happens because multifd_send_sync_main() blocks
   ram_save_complete() from finishing until the semaphore is
   posted. This is surprising and not documented.

Clarify the above situation by renaming 'sem_sync' to 'sem_done' and
making the #2 usage the main one. Post to 'sem_sync' only when there's
no more pending_jobs.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
I remove the parts about the receiving side. I wasn't sure about them
and we don't need to mix the two. Potentially we need the sem_sync on
the recv to ensure all channels wait before becoming available to read
once again after a FLUSH.
---
 migration/multifd.c    | 76 ++++++++++++++++++++++++------------------
 migration/multifd.h    |  4 +--
 migration/trace-events |  2 +-
 3 files changed, 47 insertions(+), 35 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 92ae61a50f..94f4ae5ff8 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -533,7 +533,7 @@ void multifd_save_cleanup(void)
         p->c = NULL;
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem);
-        qemu_sem_destroy(&p->sem_sync);
+        qemu_sem_destroy(&p->sem_done);
         g_free(p->name);
         p->name = NULL;
         multifd_pages_clear(p->pages);
@@ -591,6 +591,44 @@ int multifd_send_sync_main(QEMUFile *f)
         }
     }
 
+    for (i = 0; i < migrate_multifd_channels(); i++) {
+        MultiFDSendParams *p = &multifd_send_state->params[i];
+
+        trace_multifd_send_sync_main_signal(p->id);
+
+        qemu_mutex_lock(&p->mutex);
+
+        if (p->quit) {
+            error_report("%s: channel %d has already quit", __func__, i);
+            qemu_mutex_unlock(&p->mutex);
+            return -1;
+        }
+
+        p->packet_num = multifd_send_state->packet_num++;
+        p->flags |= MULTIFD_FLAG_SYNC;
+        p->pending_job++;
+        qemu_mutex_unlock(&p->mutex);
+        qemu_sem_post(&p->sem);
+    }
+
+    /* wait for all channels to be idle */
+    for (i = 0; i < migrate_multifd_channels(); i++) {
+        MultiFDSendParams *p = &multifd_send_state->params[i];
+
+        /*
+         * Even idle channels will wait for p->sem at the top of the
+         * loop.
+         */
+        qemu_sem_post(&p->sem);
+
+        trace_multifd_send_wait(migrate_multifd_channels() - i);
+        qemu_sem_wait(&p->sem_done);
+
+        qemu_mutex_lock(&p->mutex);
+        assert(!p->pending_job || p->quit);
+        qemu_mutex_unlock(&p->mutex);
+    }
+
     /*
      * When using zero-copy, it's necessary to flush the pages before any of
      * the pages can be sent again, so we'll make sure the new version of the
@@ -601,34 +639,11 @@ int multifd_send_sync_main(QEMUFile *f)
      * to be less frequent, e.g. only after we finished one whole scanning of
      * all the dirty bitmaps.
      */
-
     flush_zero_copy = migrate_zero_copy_send();
 
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
-        trace_multifd_send_sync_main_signal(p->id);
-
-        qemu_mutex_lock(&p->mutex);
-
-        if (p->quit) {
-            error_report("%s: channel %d has already quit", __func__, i);
-            qemu_mutex_unlock(&p->mutex);
-            return -1;
-        }
-
-        p->packet_num = multifd_send_state->packet_num++;
-        p->flags |= MULTIFD_FLAG_SYNC;
-        p->pending_job++;
-        qemu_mutex_unlock(&p->mutex);
-        qemu_sem_post(&p->sem);
-    }
-    for (i = 0; i < migrate_multifd_channels(); i++) {
-        MultiFDSendParams *p = &multifd_send_state->params[i];
-
-        trace_multifd_send_sync_main_wait(p->id);
-        qemu_sem_wait(&p->sem_sync);
-
         if (flush_zero_copy && p->c && (multifd_zero_copy_flush(p->c) < 0)) {
             return -1;
         }
@@ -728,12 +743,9 @@ static void *multifd_send_thread(void *opaque)
             p->pending_job--;
             qemu_mutex_unlock(&p->mutex);
 
-            if (flags & MULTIFD_FLAG_SYNC) {
-                qemu_sem_post(&p->sem_sync);
-            }
         } else {
             qemu_mutex_unlock(&p->mutex);
-            /* sometimes there are spurious wakeups */
+            qemu_sem_post(&p->sem_done);
         }
     }
 
@@ -749,7 +761,7 @@ out:
      * who pay attention to me.
      */
     if (ret != 0) {
-        qemu_sem_post(&p->sem_sync);
+        qemu_sem_post(&p->sem_done);
     }
 
     qemu_mutex_lock(&p->mutex);
@@ -786,7 +798,7 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
          * is not created, and then tell who pay attention to me.
          */
         p->quit = true;
-        qemu_sem_post(&p->sem_sync);
+        qemu_sem_post(&p->sem_done);
     }
 }
 
@@ -863,7 +875,7 @@ static void multifd_new_send_channel_cleanup(MultiFDSendParams *p,
 {
      migrate_set_error(migrate_get_current(), err);
      /* Error happen, we need to tell who pay attention to me */
-     qemu_sem_post(&p->sem_sync);
+     qemu_sem_post(&p->sem_done);
      /*
       * Although multifd_send_thread is not created, but main migration
       * thread need to judge whether it is running, so we need to mark
@@ -915,7 +927,7 @@ int multifd_save_setup(Error **errp)
 
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem, 0);
-        qemu_sem_init(&p->sem_sync, 0);
+        qemu_sem_init(&p->sem_done, 0);
         p->quit = false;
         p->pending_job = 0;
         p->id = i;
diff --git a/migration/multifd.h b/migration/multifd.h
index a835643b48..71bd66974d 100644
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
diff --git a/migration/trace-events b/migration/trace-events
index ee9c8f4d63..3aef79a951 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -137,7 +137,7 @@ multifd_send(uint8_t id, uint64_t packet_num, uint32_t normal, uint32_t flags, u
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


