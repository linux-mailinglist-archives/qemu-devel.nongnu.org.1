Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1297D7480
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 21:40:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvjj5-0000pu-UF; Wed, 25 Oct 2023 15:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1qvjj3-0000pg-Qx
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:39:33 -0400
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1qvjj1-00067o-1H
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:39:33 -0400
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-66d03491a1eso740246d6.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 12:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1698262770; x=1698867570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j1bNuRq+y2CvFip0F1f8OlNXk4NaSY7ezUEtcTBMZxc=;
 b=RP/2w6preyrOF9ZbpyK0EvUjkWc3nfi9/3ePZtKjMuXNhOqUrszKDBRSMQxoiZR5CW
 7voZYythN52eMdRQJ0GO0ImOSYVc0tVwQrSkRXOpzP2SRcSmIUEB4R1etJY2+O1siDmr
 r/oQi4kPTQRMbVyXhY66o4lmq53OmuXjF9LWMRC4P5UYw49VAR8NSTeI+5a+mNLm6WD6
 SRR7Zo6x6uOaiSI1td0gH/TSPzHa6tH/1Sy0olWHBLa/cnMpEGJ2c164W0QQZzzvfMZk
 B39xxVj2FeASsRZs2zNpSfoMjJ7iJhLkNJTxt0tnSDyq39krl8uL15vZ0ahpZPAhGdvH
 A4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698262770; x=1698867570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j1bNuRq+y2CvFip0F1f8OlNXk4NaSY7ezUEtcTBMZxc=;
 b=hVgqiTQavjZrNU8QaSyPywON8f9Wc7VgPOa41fI28m3rGuePGs31s9mtWkD2xt87VD
 sW/alzPrPkUEHd4SlS/xKpFEzdw5HwPhpTZPhjMbgLvm2FtWbOkXwK5M6sd72NDgT3sh
 VqziB8PVAVbWZD4nZ2I/5u/LZ+UsgoXINkmAljAOizs9/XwW3uQ4BPt78xkB2CRZdLOp
 INkK3snS6ff/u9ZtH+yUiVu+TN4V34llLEuq3Kuw6bec3av+64CIUqwIHANL7xttdNL6
 P+FaGP60j+TbgEsMhIGlZ4Hy6i9IGvUHuM9fUuxWNQ4R4Ql2IVOnJs4ycuy5LCqnKD02
 16Hw==
X-Gm-Message-State: AOJu0Yx1a5/xBfXKpJXEoEmt/eRmRSRGzx19qDOklwnKjQRJHMicZzky
 xPJeEILqqpThtSaJx4JSj7T0Nw==
X-Google-Smtp-Source: AGHT+IFqmtnOCThWaFpypfvK0Klyay6WS8IU6wpDKrCSvU3xVU9fgN1NWvG0lFW9NcoE8XVPfpVQsg==
X-Received: by 2002:a05:6214:246b:b0:66d:1d92:c694 with SMTP id
 im11-20020a056214246b00b0066d1d92c694mr22580113qvb.58.1698262769870; 
 Wed, 25 Oct 2023 12:39:29 -0700 (PDT)
Received: from n231-230-216.byted.org ([147.160.184.135])
 by smtp.gmail.com with ESMTPSA id
 o8-20020a05620a228800b0076cdc3b5beasm4453721qkh.86.2023.10.25.12.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 12:39:29 -0700 (PDT)
From: Hao Xiang <hao.xiang@bytedance.com>
To: quintela@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com,
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH 01/16] Cherry pick a set of patches that enables multifd zero
 page feature.
Date: Wed, 25 Oct 2023 19:38:07 +0000
Message-Id: <20231025193822.2813204-2-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231025193822.2813204-1-hao.xiang@bytedance.com>
References: <20231025193822.2813204-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qv1-xf2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Juan Quintela had a patchset enabling zero page checking in multifd
threads.

https://lore.kernel.org/all/20220802063907.18882-13-quintela@redhat.com/

Some of the changes in that patchset has already made to upstream but
a few are still being reviewed. This patch contains the changes from
the remaining patches. This change serves as the baseline for DSA
offloading.

* multifd: Add capability to enable/disable zero_page
* migration: Export ram_release_page()
* multifd: Support for zero pages transmission
* multifd: Zero pages transmission
* So we use multifd to transmit zero pages.
---
 migration/migration-stats.h |   8 +--
 migration/multifd.c         | 105 ++++++++++++++++++++++++++++--------
 migration/multifd.h         |  19 ++++++-
 migration/options.c         |  12 +++++
 migration/options.h         |   1 +
 migration/ram.c             |  47 +++++++++++++---
 migration/trace-events      |   8 +--
 qapi/migration.json         |   7 ++-
 8 files changed, 167 insertions(+), 40 deletions(-)

diff --git a/migration/migration-stats.h b/migration/migration-stats.h
index 2358caad63..dca3c100b0 100644
--- a/migration/migration-stats.h
+++ b/migration/migration-stats.h
@@ -68,6 +68,10 @@ typedef struct {
      * Number of pages transferred that were not full of zeros.
      */
     Stat64 normal_pages;
+    /*
+     * Number of pages transferred that were full of zeros.
+     */
+    Stat64 zero_pages;
     /*
      * Number of bytes sent during postcopy.
      */
@@ -97,10 +101,6 @@ typedef struct {
      * Total number of bytes transferred.
      */
     Stat64 transferred;
-    /*
-     * Number of pages transferred that were full of zeros.
-     */
-    Stat64 zero_pages;
 } MigrationAtomicStats;
 
 extern MigrationAtomicStats mig_stats;
diff --git a/migration/multifd.c b/migration/multifd.c
index 0f6b203877..452fb158b8 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/rcu.h"
+#include "qemu/cutils.h"
 #include "exec/target_page.h"
 #include "sysemu/sysemu.h"
 #include "exec/ramblock.h"
@@ -268,6 +269,7 @@ static void multifd_send_fill_packet(MultiFDSendParams *p)
     packet->normal_pages = cpu_to_be32(p->normal_num);
     packet->next_packet_size = cpu_to_be32(p->next_packet_size);
     packet->packet_num = cpu_to_be64(p->packet_num);
+    packet->zero_pages = cpu_to_be32(p->zero_num);
 
     if (p->pages->block) {
         strncpy(packet->ramblock, p->pages->block->idstr, 256);
@@ -279,6 +281,12 @@ static void multifd_send_fill_packet(MultiFDSendParams *p)
 
         packet->offset[i] = cpu_to_be64(temp);
     }
+    for (i = 0; i < p->zero_num; i++) {
+        /* there are architectures where ram_addr_t is 32 bit */
+        uint64_t temp = p->zero[i];
+
+        packet->offset[p->normal_num + i] = cpu_to_be64(temp);
+    }
 }
 
 static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
@@ -327,7 +335,15 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
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
 
@@ -353,6 +369,18 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
         p->normal[i] = offset;
     }
 
+    for (i = 0; i < p->zero_num; i++) {
+        uint64_t offset = be64_to_cpu(packet->offset[p->normal_num + i]);
+
+        if (offset > (p->block->used_length - p->page_size)) {
+            error_setg(errp, "multifd: offset too long %" PRIu64
+                       " (max " RAM_ADDR_FMT ")",
+                       offset, p->block->used_length);
+            return -1;
+        }
+        p->zero[i] = offset;
+    }
+
     return 0;
 }
 
@@ -432,6 +460,8 @@ static int multifd_send_pages(QEMUFile *f)
     p->packet_num = multifd_send_state->packet_num++;
     multifd_send_state->pages = p->pages;
     p->pages = pages;
+    stat64_add(&mig_stats.normal_pages, p->normal_num);
+    stat64_add(&mig_stats.zero_pages, p->zero_num);
     qemu_mutex_unlock(&p->mutex);
     qemu_sem_post(&p->sem);
 
@@ -548,6 +578,8 @@ void multifd_save_cleanup(void)
         p->iov = NULL;
         g_free(p->normal);
         p->normal = NULL;
+        g_free(p->zero);
+        p->zero = NULL;
         multifd_send_state->ops->send_cleanup(p, &local_err);
         if (local_err) {
             migrate_set_error(migrate_get_current(), local_err);
@@ -622,7 +654,7 @@ int multifd_send_sync_main(QEMUFile *f)
         }
 
         p->packet_num = multifd_send_state->packet_num++;
-        p->flags |= MULTIFD_FLAG_SYNC;
+        p->sync_needed = true;
         p->pending_job++;
         qemu_mutex_unlock(&p->mutex);
         qemu_sem_post(&p->sem);
@@ -648,6 +680,8 @@ static void *multifd_send_thread(void *opaque)
     MultiFDSendParams *p = opaque;
     MigrationThread *thread = NULL;
     Error *local_err = NULL;
+    /* older qemu don't understand zero page on multifd channel */
+    bool use_multifd_zero_page = !migrate_use_main_zero_page();
     int ret = 0;
     bool use_zero_copy_send = migrate_zero_copy_send();
 
@@ -673,9 +707,17 @@ static void *multifd_send_thread(void *opaque)
         qemu_mutex_lock(&p->mutex);
 
         if (p->pending_job) {
+            RAMBlock *rb = p->pages->block;
             uint64_t packet_num = p->packet_num;
-            uint32_t flags;
+            p->flags = 0;
+            if (p->sync_needed) {
+                p->flags |= MULTIFD_FLAG_SYNC;
+                p->sync_needed = false;
+            }
+            qemu_mutex_unlock(&p->mutex);
+
             p->normal_num = 0;
+            p->zero_num = 0;
 
             if (use_zero_copy_send) {
                 p->iovs_num = 0;
@@ -684,27 +726,27 @@ static void *multifd_send_thread(void *opaque)
             }
 
             for (int i = 0; i < p->pages->num; i++) {
-                p->normal[p->normal_num] = p->pages->offset[i];
-                p->normal_num++;
+                uint64_t offset = p->pages->offset[i];
+                if (use_multifd_zero_page &&
+                    buffer_is_zero(rb->host + offset, p->page_size)) {
+                    p->zero[p->zero_num] = offset;
+                    p->zero_num++;
+                    ram_release_page(rb->idstr, offset);
+                } else {
+                    p->normal[p->normal_num] = offset;
+                    p->normal_num++;
+                }
             }
 
             if (p->normal_num) {
                 ret = multifd_send_state->ops->send_prepare(p, &local_err);
                 if (ret != 0) {
-                    qemu_mutex_unlock(&p->mutex);
                     break;
                 }
             }
             multifd_send_fill_packet(p);
-            flags = p->flags;
-            p->flags = 0;
-            p->num_packets++;
-            p->total_normal_pages += p->normal_num;
-            p->pages->num = 0;
-            p->pages->block = NULL;
-            qemu_mutex_unlock(&p->mutex);
 
-            trace_multifd_send(p->id, packet_num, p->normal_num, flags,
+            trace_multifd_send(p->id, packet_num, p->normal_num, p->zero_num, p->flags,
                                p->next_packet_size);
 
             if (use_zero_copy_send) {
@@ -731,10 +773,15 @@ static void *multifd_send_thread(void *opaque)
             stat64_add(&mig_stats.multifd_bytes, p->next_packet_size);
             stat64_add(&mig_stats.transferred, p->next_packet_size);
             qemu_mutex_lock(&p->mutex);
+            p->num_packets++;
+            p->total_normal_pages += p->normal_num;
+            p->total_zero_pages += p->zero_num;
+            p->pages->num = 0;
+            p->pages->block = NULL;
             p->pending_job--;
             qemu_mutex_unlock(&p->mutex);
 
-            if (flags & MULTIFD_FLAG_SYNC) {
+            if (p->flags & MULTIFD_FLAG_SYNC) {
                 qemu_sem_post(&p->sem_sync);
             }
         } else if (p->quit) {
@@ -768,7 +815,8 @@ out:
 
     rcu_unregister_thread();
     migration_threads_remove(thread);
-    trace_multifd_send_thread_end(p->id, p->num_packets, p->total_normal_pages);
+    trace_multifd_send_thread_end(p->id, p->num_packets, p->total_normal_pages,
+                                  p->total_zero_pages);
 
     return NULL;
 }
@@ -944,6 +992,7 @@ int multifd_save_setup(Error **errp)
         p->normal = g_new0(ram_addr_t, page_count);
         p->page_size = qemu_target_page_size();
         p->page_count = page_count;
+        p->zero = g_new0(ram_addr_t, page_count);
 
         if (migrate_zero_copy_send()) {
             p->write_flags = QIO_CHANNEL_WRITE_FLAG_ZERO_COPY;
@@ -1059,6 +1108,8 @@ void multifd_load_cleanup(void)
         p->iov = NULL;
         g_free(p->normal);
         p->normal = NULL;
+        g_free(p->zero);
+        p->zero = NULL;
         multifd_recv_state->ops->recv_cleanup(p);
     }
     qemu_sem_destroy(&multifd_recv_state->sem_sync);
@@ -1105,7 +1156,7 @@ static void *multifd_recv_thread(void *opaque)
     rcu_register_thread();
 
     while (true) {
-        uint32_t flags;
+        bool sync_needed = false;
 
         if (p->quit) {
             break;
@@ -1124,13 +1175,14 @@ static void *multifd_recv_thread(void *opaque)
             break;
         }
 
-        flags = p->flags;
+        trace_multifd_recv(p->id, p->packet_num, p->normal_num, p->zero_num,
+                           p->flags, p->next_packet_size);
+        sync_needed = p->flags & MULTIFD_FLAG_SYNC;       
         /* recv methods don't know how to handle the SYNC flag */
         p->flags &= ~MULTIFD_FLAG_SYNC;
-        trace_multifd_recv(p->id, p->packet_num, p->normal_num, flags,
-                           p->next_packet_size);
         p->num_packets++;
         p->total_normal_pages += p->normal_num;
+        p->total_zero_pages += p->zero_num;
         qemu_mutex_unlock(&p->mutex);
 
         if (p->normal_num) {
@@ -1140,7 +1192,14 @@ static void *multifd_recv_thread(void *opaque)
             }
         }
 
-        if (flags & MULTIFD_FLAG_SYNC) {
+        for (int i = 0; i < p->zero_num; i++) {
+            void *page = p->host + p->zero[i];
+            if (!buffer_is_zero(page, p->page_size)) {
+                memset(page, 0, p->page_size);
+            }
+        }
+
+        if (sync_needed) {
             qemu_sem_post(&multifd_recv_state->sem_sync);
             qemu_sem_wait(&p->sem_sync);
         }
@@ -1155,7 +1214,8 @@ static void *multifd_recv_thread(void *opaque)
     qemu_mutex_unlock(&p->mutex);
 
     rcu_unregister_thread();
-    trace_multifd_recv_thread_end(p->id, p->num_packets, p->total_normal_pages);
+    trace_multifd_recv_thread_end(p->id, p->num_packets, p->total_normal_pages,
+                                  p->total_zero_pages);
 
     return NULL;
 }
@@ -1196,6 +1256,7 @@ int multifd_load_setup(Error **errp)
         p->normal = g_new0(ram_addr_t, page_count);
         p->page_count = page_count;
         p->page_size = qemu_target_page_size();
+        p->zero = g_new0(ram_addr_t, page_count);
     }
 
     for (i = 0; i < thread_count; i++) {
diff --git a/migration/multifd.h b/migration/multifd.h
index a835643b48..e8f90776bb 100644
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
@@ -118,10 +121,14 @@ typedef struct {
     MultiFDPacket_t *packet;
     /* size of the next packet that contains pages */
     uint32_t next_packet_size;
+    /* Do we need to do an iteration sync */
+    bool sync_needed;
     /* packets sent through this channel */
     uint64_t num_packets;
     /* non zero pages sent through this channel */
     uint64_t total_normal_pages;
+    /* zero pages sent through this channel */
+    uint64_t total_zero_pages;
     /* buffers to send */
     struct iovec *iov;
     /* number of iovs used */
@@ -130,6 +137,10 @@ typedef struct {
     ram_addr_t *normal;
     /* num of non zero pages */
     uint32_t normal_num;
+    /* Pages that are  zero */
+    ram_addr_t *zero;
+    /* num of zero pages */
+    uint32_t zero_num;
     /* used for compression methods */
     void *data;
 }  MultiFDSendParams;
@@ -181,12 +192,18 @@ typedef struct {
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
+    /* Pages that are  zero */
+    ram_addr_t *zero;
+    /* num of zero pages */
+    uint32_t zero_num;
     /* used for de-compression methods */
     void *data;
 } MultiFDRecvParams;
diff --git a/migration/options.c b/migration/options.c
index 6bbfd4853d..12b1c4dd71 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -189,6 +189,7 @@ Property migration_properties[] = {
     DEFINE_PROP_MIG_CAP("x-block", MIGRATION_CAPABILITY_BLOCK),
     DEFINE_PROP_MIG_CAP("x-return-path", MIGRATION_CAPABILITY_RETURN_PATH),
     DEFINE_PROP_MIG_CAP("x-multifd", MIGRATION_CAPABILITY_MULTIFD),
+    DEFINE_PROP_MIG_CAP("x-main-zero-page", MIGRATION_CAPABILITY_MAIN_ZERO_PAGE),
     DEFINE_PROP_MIG_CAP("x-background-snapshot",
             MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT),
 #ifdef CONFIG_LINUX
@@ -278,6 +279,13 @@ bool migrate_multifd(void)
     return s->capabilities[MIGRATION_CAPABILITY_MULTIFD];
 }
 
+bool migrate_use_main_zero_page(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->capabilities[MIGRATION_CAPABILITY_MAIN_ZERO_PAGE];
+}
+
 bool migrate_pause_before_switchover(void)
 {
     MigrationState *s = migrate_get_current();
@@ -431,6 +439,7 @@ INITIALIZE_MIGRATE_CAPS_SET(check_caps_background_snapshot,
     MIGRATION_CAPABILITY_LATE_BLOCK_ACTIVATE,
     MIGRATION_CAPABILITY_RETURN_PATH,
     MIGRATION_CAPABILITY_MULTIFD,
+    MIGRATION_CAPABILITY_MAIN_ZERO_PAGE,
     MIGRATION_CAPABILITY_PAUSE_BEFORE_SWITCHOVER,
     MIGRATION_CAPABILITY_AUTO_CONVERGE,
     MIGRATION_CAPABILITY_RELEASE_RAM,
@@ -499,6 +508,9 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
             error_setg(errp, "Postcopy is not yet compatible with multifd");
             return false;
         }
+        if (new_caps[MIGRATION_CAPABILITY_MAIN_ZERO_PAGE]) {
+            error_setg(errp, "Postcopy is not yet compatible with main zero copy");
+        }
     }
 
     if (new_caps[MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT]) {
diff --git a/migration/options.h b/migration/options.h
index 045e2a41a2..c663f637fd 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -85,6 +85,7 @@ int migrate_multifd_channels(void);
 MultiFDCompression migrate_multifd_compression(void);
 int migrate_multifd_zlib_level(void);
 int migrate_multifd_zstd_level(void);
+bool migrate_use_main_zero_page(void);
 uint8_t migrate_throttle_trigger_threshold(void);
 const char *migrate_tls_authz(void);
 const char *migrate_tls_creds(void);
diff --git a/migration/ram.c b/migration/ram.c
index 2f5ce4d60b..516b5b9c59 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1292,7 +1292,6 @@ static int ram_save_multifd_page(QEMUFile *file, RAMBlock *block,
     if (multifd_queue_page(file, block, offset) < 0) {
         return -1;
     }
-    stat64_add(&mig_stats.normal_pages, 1);
 
     return 1;
 }
@@ -2149,17 +2148,43 @@ static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
         }
         return res;
     }
-
     /*
-     * Do not use multifd in postcopy as one whole host page should be
-     * placed.  Meanwhile postcopy requires atomic update of pages, so even
-     * if host page size == guest page size the dest guest during run may
-     * still see partially copied pages which is data corruption.
+     * Do not use multifd for:
+     * 1. Compression as the first page in the new block should be posted out
+     *    before sending the compressed page
+     * 2. In postcopy as one whole host page should be placed
      */
-    if (migrate_multifd() && !migration_in_postcopy()) {
+    if (!save_page_use_compression(rs) && migrate_multifd()
+        && !migration_in_postcopy()) {
+        return ram_save_multifd_page(pss->pss_channel, block, offset);
+    }
+
+    return ram_save_page(rs, pss);
+}
+
+/**
+ * ram_save_target_page_multifd: save one target page
+ *
+ * Returns the number of pages written
+ *
+ * @rs: current RAM state
+ * @pss: data about the page we want to send
+ */
+static int ram_save_target_page_multifd(RAMState *rs, PageSearchStatus *pss)
+{
+    RAMBlock *block = pss->block;
+    ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
+    int res;
+
+    if (!migration_in_postcopy()) {
         return ram_save_multifd_page(pss->pss_channel, block, offset);
     }
 
+    res = save_zero_page(pss, pss->pss_channel, block, offset);
+    if (res > 0) {
+        return res;
+    }
+
     return ram_save_page(rs, pss);
 }
 
@@ -3066,7 +3091,13 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     ram_control_after_iterate(f, RAM_CONTROL_SETUP);
 
     migration_ops = g_malloc0(sizeof(MigrationOps));
-    migration_ops->ram_save_target_page = ram_save_target_page_legacy;
+
+    if (migrate_multifd() && !migrate_use_main_zero_page()) {
+        migration_ops->ram_save_target_page = ram_save_target_page_multifd;
+    } else {    
+        migration_ops->ram_save_target_page = ram_save_target_page_legacy;
+    }
+
     ret = multifd_send_sync_main(f);
     if (ret < 0) {
         return ret;
diff --git a/migration/trace-events b/migration/trace-events
index ee9c8f4d63..3d059f3c06 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -125,21 +125,21 @@ postcopy_preempt_reset_channel(void) ""
 
 # multifd.c
 multifd_new_send_channel_async(uint8_t id) "channel %u"
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
diff --git a/qapi/migration.json b/qapi/migration.json
index d7dfaa5db9..3a99fe34d8 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -508,6 +508,11 @@
 #     and should not affect the correctness of postcopy migration.
 #     (since 7.1)
 #
+# @main-zero-page: If enabled, the detection of zero pages will be
+#                  done on the main thread.  Otherwise it is done on
+#                  the multifd threads.
+#                  (since 7.1)
+#
 # @switchover-ack: If enabled, migration will not stop the source VM
 #     and complete the migration until an ACK is received from the
 #     destination that it's OK to do so.  Exactly when this ACK is
@@ -540,7 +545,7 @@
            { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
            'validate-uuid', 'background-snapshot',
            'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
-           'dirty-limit'] }
+           'dirty-limit', 'main-zero-page'] }
 
 ##
 # @MigrationCapabilityStatus:
-- 
2.30.2


