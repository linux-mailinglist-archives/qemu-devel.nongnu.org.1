Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3D28239D4
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 01:48:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLBs4-0008Kr-VL; Wed, 03 Jan 2024 19:46:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBrj-0008Go-H1
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:45:45 -0500
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBrf-0007P9-CS
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:45:43 -0500
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-78101108e3fso2092185a.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 16:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704329137; x=1704933937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VUN9wtsKSFJnHNyD+YdsEDAeXBCenVRzW5JMxjYQNVE=;
 b=gSDau0X3veCu70CNGS3tB3TNgDjIWIPDXDl9UA9Xx9IbAVzLgOkk1PXHtmgXoDRhxl
 2uWry0bpHbZpiLRdec90P+A0BrLUO1fuJPwmZDZPhRBGMb7wLXeIED1Ir16dUw4OkMlz
 C1GZ4SsINkjuVG/OK7HQyY+i2b6vPpvIjwJfGdJg6CtVyRuDqPFTabLpj2kG7P2nWRkw
 bBacfQnr4LzRXUoOswhmLgtrjgbSsR+E+vOsdRpGYzUFjFFPTk4p1izBkIEFyfiDfbQD
 tSo5VFzSMby8mvBjKd9w+T4kYw2iYtL3K7nRgtZXHhrU8cCrzljFiZEz9yB452hkdye4
 TDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704329137; x=1704933937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VUN9wtsKSFJnHNyD+YdsEDAeXBCenVRzW5JMxjYQNVE=;
 b=MQeZeTd8zMugimVgf9HrAZ5kGbGjNsOwGQMZxy9C260WZqMKzpYyq/jSSd/zrGxseI
 FZnz6owGb2cxOjVgCexZD+wxe86q+loT/t5GnKvm5t/xTqL7lpCIDQ0wWx9+6AH1XnSL
 bIe/Fq3zul2tpTw5w8T8zHoCXlRDTh+3JcttG9VmIoWc4qPFRD2QzH86Yd0OMAelK0dq
 qoc3whBOySqzMM3G9mQjOjOHXhtmcqF9jQl7OqptRb02SPiBxmo/rYfmD/hGwO94aXNV
 hFED7SYuE211fV99ZM9Q1Bxi6Ybs7AwbUb7OXE1quhF/u1LjM/uj3eOetcA+REuY6l8b
 0QEQ==
X-Gm-Message-State: AOJu0YyadV0m9cAWKTJqTkcIxvK2JdUBd51UUywTqmDMOobkZdEBatbu
 wHpOUBon6BMkLob1ijGZt9ifMr0sd7+tXw==
X-Google-Smtp-Source: AGHT+IGlbNEQE9vJnaYy+4iAAK+OHPywD7h6BaWHWkuhoxkVPYKUyrP2ppelTO8gavXKaYtNgAO88A==
X-Received: by 2002:a05:620a:4622:b0:781:c50d:f835 with SMTP id
 br34-20020a05620a462200b00781c50df835mr6161603qkb.142.1704329137325; 
 Wed, 03 Jan 2024 16:45:37 -0800 (PST)
Received: from n231-230-216.byted.org ([147.160.184.87])
 by smtp.gmail.com with ESMTPSA id
 x19-20020ae9f813000000b0077d66e5b2e6sm10646087qkh.3.2024.01.03.16.45.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 16:45:36 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: farosas@suse.de, peter.maydell@linaro.org, peterx@redhat.com,
 marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>
Subject: [PATCH v3 02/20] multifd: Support for zero pages transmission
Date: Thu,  4 Jan 2024 00:44:34 +0000
Message-Id: <20240104004452.324068-3-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240104004452.324068-1-hao.xiang@bytedance.com>
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x735.google.com
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
index 409460684f..5a1f50c7e8 100644
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
@@ -938,6 +955,7 @@ int multifd_save_setup(Error **errp)
         p->normal = g_new0(ram_addr_t, page_count);
         p->page_size = qemu_target_page_size();
         p->page_count = page_count;
+        p->zero = g_new0(ram_addr_t, page_count);
 
         if (migrate_zero_copy_send()) {
             p->write_flags = QIO_CHANNEL_WRITE_FLAG_ZERO_COPY;
@@ -1053,6 +1071,8 @@ void multifd_load_cleanup(void)
         p->iov = NULL;
         g_free(p->normal);
         p->normal = NULL;
+        g_free(p->zero);
+        p->zero = NULL;
         multifd_recv_state->ops->recv_cleanup(p);
     }
     qemu_sem_destroy(&multifd_recv_state->sem_sync);
@@ -1121,10 +1141,11 @@ static void *multifd_recv_thread(void *opaque)
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
@@ -1149,7 +1170,8 @@ static void *multifd_recv_thread(void *opaque)
     qemu_mutex_unlock(&p->mutex);
 
     rcu_unregister_thread();
-    trace_multifd_recv_thread_end(p->id, p->num_packets, p->total_normal_pages);
+    trace_multifd_recv_thread_end(p->id, p->num_packets, p->total_normal_pages,
+                                  p->total_zero_pages);
 
     return NULL;
 }
@@ -1190,6 +1212,7 @@ int multifd_load_setup(Error **errp)
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


