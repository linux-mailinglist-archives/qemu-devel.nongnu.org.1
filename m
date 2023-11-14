Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1357EAA38
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 06:44:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2mBD-0007B0-Gm; Tue, 14 Nov 2023 00:41:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r2mB9-0007AO-Cr
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 00:41:39 -0500
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r2mB7-0001RT-8S
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 00:41:39 -0500
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-77a277eb084so346430485a.2
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 21:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1699940494; x=1700545294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z3Qnk3XRMyF+hVRPcPcuJsAD6fV3CsVX4VzBIwkD5H4=;
 b=ibvd3VS0d1LZbzwXEPmsKpo180QMIVJDqrhysBt/Lb5OW7rHHQCZTFFwMNaAxzTTwS
 hqobNZmQTqnCA2rwjV/LJ62GwG1ahkhzp8/cRC+V91v5SjaWXkYuqZ2bh9j1WQUPGflb
 zTbOex4S8Rq5vYm5XCqa36Jilqdfmo2ByZXYTA32cHgeer0jUOwVjfLdYOhUUJ2TKC+P
 9+vSDURZQCcc1j6VG8XS1mH28hVYpI/wrmLvafCOlzgaI59YXVUNMzZp9PhWWjWzJ9xe
 JvChr6fm6u5mn+53F3X2CTHU0RBZvJcHjcEoxAup1Jc5oALz3xm+VXon4C2ba8+1HROl
 kirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699940494; x=1700545294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z3Qnk3XRMyF+hVRPcPcuJsAD6fV3CsVX4VzBIwkD5H4=;
 b=iKKiPEdexIg2oxO1FWG+U4eKzdAuhAbBFRzjcXt6N4uY4tYdiCybvW8Q6PyeAe3dHR
 InGONL05XA8e0pEFUIOADF9dQ3J9TEe96SvivOmEe7UvxmZo9W7FlsTOwVEQDKiVmbb0
 Y+yn+m8ZrCh93JVHzY04d/hlTmU6545ABLvdJCyncUaDCRai/zp/e4j8LTmr2q/aoVNP
 jonPaCQ7oSRH+gWpl2PMlCroG6UsEN8XKVxYhWBgCATlXXuGlFDIYP7zYEcCQwVgEd8H
 8CyMkoFPBxAMboIT5EqPSUj9k7zeH0qQkNTNb3i0rHRBVxEQWHY4vJwnmnSx/CT5ezOn
 2EWg==
X-Gm-Message-State: AOJu0YyeSNU1Ze1tpGb3JCwecLUUmXXS+XVB1TQu3u6pIKL6OigcBjdT
 eH/ZmBaLiCwpzuhKseBNaGdM/A==
X-Google-Smtp-Source: AGHT+IGFv27ChdLqhVZVKeKHoqW1DF8D01/HCeyJzHQjoBY7a+yGauUKZp3azGdc11o9Yfl/kvkVtA==
X-Received: by 2002:a05:620a:8703:b0:777:ac06:ed91 with SMTP id
 px3-20020a05620a870300b00777ac06ed91mr1239738qkn.23.1699940494447; 
 Mon, 13 Nov 2023 21:41:34 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.104])
 by smtp.gmail.com with ESMTPSA id
 w2-20020a05620a094200b0077891d2d12dsm2400367qkw.43.2023.11.13.21.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 21:41:34 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: farosas@suse.de, peter.maydell@linaro.org, quintela@redhat.com,
 peterx@redhat.com, marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Subject: [PATCH v2 02/20] multifd: Support for zero pages transmission
Date: Tue, 14 Nov 2023 05:40:14 +0000
Message-Id: <20231114054032.1192027-3-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231114054032.1192027-1-hao.xiang@bytedance.com>
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x733.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Juan Quintela <quintela@redhat.com>

This patch adds counters and similar. Logic will be added on the
following patch.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/multifd.c    | 37 ++++++++++++++++++++++++++++++-------
 migration/multifd.h    | 17 ++++++++++++++++-
 migration/trace-events |  8 ++++----
 3 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index ec58c58082..d28ef0028b 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -267,6 +267,7 @@ static void multifd_send_fill_packet(MultiFDSendParams *p)
     packet->normal_pages = cpu_to_be32(p->normal_num);
     packet->next_packet_size = cpu_to_be32(p->next_packet_size);
     packet->packet_num = cpu_to_be64(p->packet_num);
+    packet->zero_pages = cpu_to_be32(p->zero_num);
 
     if (p->pages->block) {
         strncpy(packet->ramblock, p->pages->block->idstr, 256);
@@ -326,7 +327,15 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
     p->next_packet_size = be32_to_cpu(packet->next_packet_size);
     p->packet_num = be64_to_cpu(packet->packet_num);
 
-    if (p->normal_num == 0) {
+    p->zero_num = be32_to_cpu(packet->zero_pages);
+    if (p->zero_num > packet->pages_alloc - p->normal_num) {
+        error_setg(errp, "multifd: received packet "
+                   "with %u zero pages and expected maximum pages are %u",
+                   p->zero_num, packet->pages_alloc - p->normal_num) ;
+        return -1;
+    }
+
+    if (p->normal_num == 0 && p->zero_num == 0) {
         return 0;
     }
 
@@ -431,6 +440,7 @@ static int multifd_send_pages(QEMUFile *f)
     p->packet_num = multifd_send_state->packet_num++;
     multifd_send_state->pages = p->pages;
     p->pages = pages;
+
     qemu_mutex_unlock(&p->mutex);
     qemu_sem_post(&p->sem);
 
@@ -552,6 +562,8 @@ void multifd_save_cleanup(void)
         p->iov = NULL;
         g_free(p->normal);
         p->normal = NULL;
+        g_free(p->zero);
+        p->zero = NULL;
         multifd_send_state->ops->send_cleanup(p, &local_err);
         if (local_err) {
             migrate_set_error(migrate_get_current(), local_err);
@@ -680,6 +692,7 @@ static void *multifd_send_thread(void *opaque)
             uint64_t packet_num = p->packet_num;
             uint32_t flags;
             p->normal_num = 0;
+            p->zero_num = 0;
 
             if (use_zero_copy_send) {
                 p->iovs_num = 0;
@@ -704,12 +717,13 @@ static void *multifd_send_thread(void *opaque)
             p->flags = 0;
             p->num_packets++;
             p->total_normal_pages += p->normal_num;
+            p->total_zero_pages += p->zero_num;
             p->pages->num = 0;
             p->pages->block = NULL;
             qemu_mutex_unlock(&p->mutex);
 
-            trace_multifd_send(p->id, packet_num, p->normal_num, flags,
-                               p->next_packet_size);
+            trace_multifd_send(p->id, packet_num, p->normal_num, p->zero_num,
+                               flags, p->next_packet_size);
 
             if (use_zero_copy_send) {
                 /* Send header first, without zerocopy */
@@ -732,6 +746,8 @@ static void *multifd_send_thread(void *opaque)
 
             stat64_add(&mig_stats.multifd_bytes,
                        p->next_packet_size + p->packet_len);
+            stat64_add(&mig_stats.normal_pages, p->normal_num);
+            stat64_add(&mig_stats.zero_pages, p->zero_num);
             p->next_packet_size = 0;
             qemu_mutex_lock(&p->mutex);
             p->pending_job--;
@@ -762,7 +778,8 @@ out:
 
     rcu_unregister_thread();
     migration_threads_remove(thread);
-    trace_multifd_send_thread_end(p->id, p->num_packets, p->total_normal_pages);
+    trace_multifd_send_thread_end(p->id, p->num_packets, p->total_normal_pages,
+                                  p->total_zero_pages);
 
     return NULL;
 }
@@ -939,6 +956,7 @@ int multifd_save_setup(Error **errp)
         p->normal = g_new0(ram_addr_t, page_count);
         p->page_size = qemu_target_page_size();
         p->page_count = page_count;
+        p->zero = g_new0(ram_addr_t, page_count);
 
         if (migrate_zero_copy_send()) {
             p->write_flags = QIO_CHANNEL_WRITE_FLAG_ZERO_COPY;
@@ -1054,6 +1072,8 @@ void multifd_load_cleanup(void)
         p->iov = NULL;
         g_free(p->normal);
         p->normal = NULL;
+        g_free(p->zero);
+        p->zero = NULL;
         multifd_recv_state->ops->recv_cleanup(p);
     }
     qemu_sem_destroy(&multifd_recv_state->sem_sync);
@@ -1122,10 +1142,11 @@ static void *multifd_recv_thread(void *opaque)
         flags = p->flags;
         /* recv methods don't know how to handle the SYNC flag */
         p->flags &= ~MULTIFD_FLAG_SYNC;
-        trace_multifd_recv(p->id, p->packet_num, p->normal_num, flags,
-                           p->next_packet_size);
+        trace_multifd_recv(p->id, p->packet_num, p->normal_num, p->zero_num,
+                           flags, p->next_packet_size);
         p->num_packets++;
         p->total_normal_pages += p->normal_num;
+        p->total_zero_pages += p->zero_num;
         qemu_mutex_unlock(&p->mutex);
 
         if (p->normal_num) {
@@ -1150,7 +1171,8 @@ static void *multifd_recv_thread(void *opaque)
     qemu_mutex_unlock(&p->mutex);
 
     rcu_unregister_thread();
-    trace_multifd_recv_thread_end(p->id, p->num_packets, p->total_normal_pages);
+    trace_multifd_recv_thread_end(p->id, p->num_packets, p->total_normal_pages,
+                                  p->total_zero_pages);
 
     return NULL;
 }
@@ -1191,6 +1213,7 @@ int multifd_load_setup(Error **errp)
         p->normal = g_new0(ram_addr_t, page_count);
         p->page_count = page_count;
         p->page_size = qemu_target_page_size();
+        p->zero = g_new0(ram_addr_t, page_count);
     }
 
     for (i = 0; i < thread_count; i++) {
diff --git a/migration/multifd.h b/migration/multifd.h
index a835643b48..d587b0e19c 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -48,7 +48,10 @@ typedef struct {
     /* size of the next packet that contains pages */
     uint32_t next_packet_size;
     uint64_t packet_num;
-    uint64_t unused[4];    /* Reserved for future use */
+    /* zero pages */
+    uint32_t zero_pages;
+    uint32_t unused32[1];    /* Reserved for future use */
+    uint64_t unused64[3];    /* Reserved for future use */
     char ramblock[256];
     uint64_t offset[];
 } __attribute__((packed)) MultiFDPacket_t;
@@ -122,6 +125,8 @@ typedef struct {
     uint64_t num_packets;
     /* non zero pages sent through this channel */
     uint64_t total_normal_pages;
+    /* zero pages sent through this channel */
+    uint64_t total_zero_pages;
     /* buffers to send */
     struct iovec *iov;
     /* number of iovs used */
@@ -130,6 +135,10 @@ typedef struct {
     ram_addr_t *normal;
     /* num of non zero pages */
     uint32_t normal_num;
+    /* Pages that are zero */
+    ram_addr_t *zero;
+    /* num of zero pages */
+    uint32_t zero_num;
     /* used for compression methods */
     void *data;
 }  MultiFDSendParams;
@@ -181,12 +190,18 @@ typedef struct {
     uint8_t *host;
     /* non zero pages recv through this channel */
     uint64_t total_normal_pages;
+    /* zero pages recv through this channel */
+    uint64_t total_zero_pages;
     /* buffers to recv */
     struct iovec *iov;
     /* Pages that are not zero */
     ram_addr_t *normal;
     /* num of non zero pages */
     uint32_t normal_num;
+    /* Pages that are zero */
+    ram_addr_t *zero;
+    /* num of zero pages */
+    uint32_t zero_num;
     /* used for de-compression methods */
     void *data;
 } MultiFDRecvParams;
diff --git a/migration/trace-events b/migration/trace-events
index de4a743c8a..c0a758db9d 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -128,21 +128,21 @@ postcopy_preempt_reset_channel(void) ""
 # multifd.c
 multifd_new_send_channel_async(uint8_t id) "channel %u"
 multifd_new_send_channel_async_error(uint8_t id, void *err) "channel=%u err=%p"
-multifd_recv(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " pages %u flags 0x%x next packet size %u"
+multifd_recv(uint8_t id, uint64_t packet_num, uint32_t normal, uint32_t zero, uint32_t flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " normal pages %u zero pages %u flags 0x%x next packet size %u"
 multifd_recv_new_channel(uint8_t id) "channel %u"
 multifd_recv_sync_main(long packet_num) "packet num %ld"
 multifd_recv_sync_main_signal(uint8_t id) "channel %u"
 multifd_recv_sync_main_wait(uint8_t id) "channel %u"
 multifd_recv_terminate_threads(bool error) "error %d"
-multifd_recv_thread_end(uint8_t id, uint64_t packets, uint64_t pages) "channel %u packets %" PRIu64 " pages %" PRIu64
+multifd_recv_thread_end(uint8_t id, uint64_t packets, uint64_t normal_pages, uint64_t zero_pages) "channel %u packets %" PRIu64 " normal pages %" PRIu64 " zero pages %" PRIu64
 multifd_recv_thread_start(uint8_t id) "%u"
-multifd_send(uint8_t id, uint64_t packet_num, uint32_t normal, uint32_t flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " normal pages %u flags 0x%x next packet size %u"
+multifd_send(uint8_t id, uint64_t packet_num, uint32_t normalpages, uint32_t zero_pages, uint32_t flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " normal pages %u zero pages %u flags 0x%x next packet size %u"
 multifd_send_error(uint8_t id) "channel %u"
 multifd_send_sync_main(long packet_num) "packet num %ld"
 multifd_send_sync_main_signal(uint8_t id) "channel %u"
 multifd_send_sync_main_wait(uint8_t id) "channel %u"
 multifd_send_terminate_threads(bool error) "error %d"
-multifd_send_thread_end(uint8_t id, uint64_t packets, uint64_t normal_pages) "channel %u packets %" PRIu64 " normal pages %"  PRIu64
+multifd_send_thread_end(uint8_t id, uint64_t packets, uint64_t normal_pages, uint64_t zero_pages) "channel %u packets %" PRIu64 " normal pages %"  PRIu64 " zero pages %"  PRIu64
 multifd_send_thread_start(uint8_t id) "%u"
 multifd_tls_outgoing_handshake_start(void *ioc, void *tioc, const char *hostname) "ioc=%p tioc=%p hostname=%s"
 multifd_tls_outgoing_handshake_error(void *ioc, const char *err) "ioc=%p err=%s"
-- 
2.30.2


