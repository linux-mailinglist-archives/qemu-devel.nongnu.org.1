Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC41868195
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Feb 2024 20:59:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reh6w-00014l-Fu; Mon, 26 Feb 2024 14:58:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1reh6p-0000zL-AU
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 14:57:55 -0500
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1reh6m-0004tx-Mt
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 14:57:55 -0500
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-4ccce61a0e8so497961e0c.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 11:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1708977471; x=1709582271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eRAn6tam9k5Jq9Tx+2Gp3ggI2rPf83QN99x9AxDRzi4=;
 b=TuFCSiomBHv/WZCF8ciTUXZylvMVO5v1+dqNUQKkML1itkzPOwPsJNh7nB78p27sQy
 WrdkjN6LfP02QZFdxucvencZQoUysul+FjCF466YZpaKcVdEEuNo6iaOp6MZOm2nL74F
 oN0TIqi4Vf9HhJsPJdC4YZyf98sL5tO5I4ynIvlVFnW5aRnO02OnRtdNhHDUL2YC6QDK
 i1bZr1UFf89RdT8Huu1e64WUBSU6EvzdiGYWcD7ydZSlN0zAeJD2uEdcS4bkpQDr+4//
 xS1R7GGTR2iqCFr1kUs3J/n5jND1JdMjruEC5UgvSLME0CFk+OQDSnZdJ9wnZVotLO0l
 VW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708977471; x=1709582271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eRAn6tam9k5Jq9Tx+2Gp3ggI2rPf83QN99x9AxDRzi4=;
 b=SPfHhicBauSLm5ZsSdry4U42rQZCzlI9rS6YawZluyXY7Mc1VIvVTqiVKnXwn72Dkq
 q2pSMbTyl3zwYnQlDNFcpPGGlTN8BvjTsd+oDmebK1EnYu9giCPC8nCb7lh+GYRszauR
 DtVzvde4h4fqMBlUOrH1w0frjz1QceYA6deE8EnzVTSZOtQc6vMnVY4pQ5qvD+gJhVOb
 c4Pfk0mFN9uwQsuWqlupS+8nE3AhcjVEbBNq+cb3gc0R8782zNNKX79CIqP4n1a4z9uS
 XaMNh7sA+rkMiTmqrAJUUmGHfxxQg/vnXwGdeLRgtjxz5dlx+QAa5HQBa7CDclyy4vSw
 2uYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2txjNV+IlzvPoKPXzWa56qYP/bSDtATeEG6yxY2dgOqaajQn2z/EsqUrkBbsbsyY8HNEBRDb0wk1pYvE+++Bi5thPbYg=
X-Gm-Message-State: AOJu0YziLt4ualL62aLtrLyQuCMq0j+XiyRO1k2lwsE+Cs/fRA/RjXY9
 +eQNjPpnMeA0LWiS9X5IWjSw+yyD7BOzcDVLEPeis+zTE+eeTF03umLNdMhnCf0=
X-Google-Smtp-Source: AGHT+IES4+FaGf+Kn7MFfRyqybSQ+zgsoxucvX1fFqMIJjjG2Eo5tHK0Bj3XB8JhhZhMgOAoYyk9/g==
X-Received: by 2002:a1f:c844:0:b0:4cb:56c5:5816 with SMTP id
 y65-20020a1fc844000000b004cb56c55816mr4394716vkf.12.1708977471009; 
 Mon, 26 Feb 2024 11:57:51 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.95])
 by smtp.gmail.com with ESMTPSA id
 ej5-20020a056122270500b004ca3dc45886sm712738vkb.47.2024.02.26.11.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 11:57:50 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v3 2/7] migration/multifd: Implement zero page transmission on
 the multifd thread.
Date: Mon, 26 Feb 2024 19:56:49 +0000
Message-Id: <20240226195654.934709-3-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240226195654.934709-1-hao.xiang@bytedance.com>
References: <20240226195654.934709-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=hao.xiang@bytedance.com; helo=mail-vk1-xa2b.google.com
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

1. Add zero_pages field in MultiFDPacket_t.
2. Implements the zero page detection and handling on the multifd
threads for non-compression, zlib and zstd compression backends.
3. Added a new value 'multifd' in ZeroPageDetection enumeration.
4. Handle migration QEMU9.0 -> QEMU8.2 compatibility.
5. Adds zero page counters and updates multifd send/receive tracing
format to track the newly added counters.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 hw/core/machine.c                |  4 +-
 hw/core/qdev-properties-system.c |  2 +-
 migration/meson.build            |  1 +
 migration/multifd-zero-page.c    | 78 ++++++++++++++++++++++++++++++
 migration/multifd-zlib.c         | 21 ++++++--
 migration/multifd-zstd.c         | 20 ++++++--
 migration/multifd.c              | 83 +++++++++++++++++++++++++++-----
 migration/multifd.h              | 24 ++++++++-
 migration/ram.c                  |  1 -
 migration/trace-events           |  8 +--
 qapi/migration.json              |  5 +-
 11 files changed, 214 insertions(+), 33 deletions(-)
 create mode 100644 migration/multifd-zero-page.c

diff --git a/hw/core/machine.c b/hw/core/machine.c
index fb5afdcae4..746da219a4 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -32,7 +32,9 @@
 #include "hw/virtio/virtio-net.h"
 #include "audio/audio.h"
 
-GlobalProperty hw_compat_8_2[] = {};
+GlobalProperty hw_compat_8_2[] = {
+    { "migration", "zero-page-detection", "legacy"},
+};
 const size_t hw_compat_8_2_len = G_N_ELEMENTS(hw_compat_8_2);
 
 GlobalProperty hw_compat_8_1[] = {
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 228e685f52..6e6f68ae1b 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -682,7 +682,7 @@ const PropertyInfo qdev_prop_mig_mode = {
 const PropertyInfo qdev_prop_zero_page_detection = {
     .name = "ZeroPageDetection",
     .description = "zero_page_detection values, "
-                   "none,legacy",
+                   "none,legacy,multifd",
     .enum_table = &ZeroPageDetection_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
diff --git a/migration/meson.build b/migration/meson.build
index 92b1cc4297..1eeb915ff6 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -22,6 +22,7 @@ system_ss.add(files(
   'migration.c',
   'multifd.c',
   'multifd-zlib.c',
+  'multifd-zero-page.c',
   'ram-compress.c',
   'options.c',
   'postcopy-ram.c',
diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c
new file mode 100644
index 0000000000..1650c41b26
--- /dev/null
+++ b/migration/multifd-zero-page.c
@@ -0,0 +1,78 @@
+/*
+ * Multifd zero page detection implementation.
+ *
+ * Copyright (c) 2024 Bytedance Inc
+ *
+ * Authors:
+ *  Hao Xiang <hao.xiang@bytedance.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "exec/ramblock.h"
+#include "migration.h"
+#include "multifd.h"
+#include "options.h"
+#include "ram.h"
+
+static void swap_page_offset(ram_addr_t *pages_offset, int a, int b)
+{
+    ram_addr_t temp;
+
+    if (a == b) {
+        return;
+    }
+
+    temp = pages_offset[a];
+    pages_offset[a] = pages_offset[b];
+    pages_offset[b] = temp;
+}
+
+/**
+ * multifd_zero_page_check_send: Perform zero page detection on all pages.
+ *
+ * Sort the page offset array by moving all normal pages to
+ * the left and all zero pages to the right of the array.
+ *
+ * @param p A pointer to the send params.
+ */
+void multifd_zero_page_check_send(MultiFDSendParams *p)
+{
+    /*
+     * QEMU older than 9.0 don't understand zero page
+     * on multifd channel. This switch is required to
+     * maintain backward compatibility.
+     */
+    bool use_multifd_zero_page =
+        (migrate_zero_page_detection() == ZERO_PAGE_DETECTION_MULTIFD);
+    MultiFDPages_t *pages = p->pages;
+    RAMBlock *rb = pages->block;
+    int index_normal = 0;
+    int index_zero = pages->num - 1;
+
+    while (index_normal <= index_zero) {
+        uint64_t offset = pages->offset[index_normal];
+        if (use_multifd_zero_page &&
+            buffer_is_zero(rb->host + offset, p->page_size)) {
+            swap_page_offset(pages->offset, index_normal, index_zero);
+            index_zero--;
+            ram_release_page(rb->idstr, offset);
+        } else {
+            index_normal++;
+            pages->normal_num++;
+        }
+    }
+}
+
+void multifd_zero_page_check_recv(MultiFDRecvParams *p)
+{
+    for (int i = 0; i < p->zero_num; i++) {
+        void *page = p->host + p->zero[i];
+        if (!buffer_is_zero(page, p->page_size)) {
+            memset(page, 0, p->page_size);
+        }
+    }
+}
diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 012e3bdea1..a8b26bc5e4 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -123,13 +123,15 @@ static int zlib_send_prepare(MultiFDSendParams *p, Error **errp)
     int ret;
     uint32_t i;
 
-    multifd_send_prepare_header(p);
+    if (!multifd_send_prepare_common(p)) {
+        goto out;
+    }
 
-    for (i = 0; i < pages->num; i++) {
+    for (i = 0; i < pages->normal_num; i++) {
         uint32_t available = z->zbuff_len - out_size;
         int flush = Z_NO_FLUSH;
 
-        if (i == pages->num - 1) {
+        if (i == pages->normal_num - 1) {
             flush = Z_SYNC_FLUSH;
         }
 
@@ -172,10 +174,10 @@ static int zlib_send_prepare(MultiFDSendParams *p, Error **errp)
     p->iov[p->iovs_num].iov_len = out_size;
     p->iovs_num++;
     p->next_packet_size = out_size;
-    p->flags |= MULTIFD_FLAG_ZLIB;
 
+out:
+    p->flags |= MULTIFD_FLAG_ZLIB;
     multifd_send_fill_packet(p);
-
     return 0;
 }
 
@@ -261,6 +263,14 @@ static int zlib_recv_pages(MultiFDRecvParams *p, Error **errp)
                    p->id, flags, MULTIFD_FLAG_ZLIB);
         return -1;
     }
+
+    multifd_zero_page_check_recv(p);
+
+    if (!p->normal_num) {
+        assert(in_size == 0);
+        return 0;
+    }
+
     ret = qio_channel_read_all(p->c, (void *)z->zbuff, in_size, errp);
 
     if (ret != 0) {
@@ -310,6 +320,7 @@ static int zlib_recv_pages(MultiFDRecvParams *p, Error **errp)
                    p->id, out_size, expected_size);
         return -1;
     }
+
     return 0;
 }
 
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index dc8fe43e94..7768040124 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -118,16 +118,18 @@ static int zstd_send_prepare(MultiFDSendParams *p, Error **errp)
     int ret;
     uint32_t i;
 
-    multifd_send_prepare_header(p);
+    if (!multifd_send_prepare_common(p)) {
+        goto out;
+    }
 
     z->out.dst = z->zbuff;
     z->out.size = z->zbuff_len;
     z->out.pos = 0;
 
-    for (i = 0; i < pages->num; i++) {
+    for (i = 0; i < pages->normal_num; i++) {
         ZSTD_EndDirective flush = ZSTD_e_continue;
 
-        if (i == pages->num - 1) {
+        if (i == pages->normal_num - 1) {
             flush = ZSTD_e_flush;
         }
         z->in.src = p->pages->block->host + pages->offset[i];
@@ -161,10 +163,10 @@ static int zstd_send_prepare(MultiFDSendParams *p, Error **errp)
     p->iov[p->iovs_num].iov_len = z->out.pos;
     p->iovs_num++;
     p->next_packet_size = z->out.pos;
-    p->flags |= MULTIFD_FLAG_ZSTD;
 
+out:
+    p->flags |= MULTIFD_FLAG_ZSTD;
     multifd_send_fill_packet(p);
-
     return 0;
 }
 
@@ -257,6 +259,14 @@ static int zstd_recv_pages(MultiFDRecvParams *p, Error **errp)
                    p->id, flags, MULTIFD_FLAG_ZSTD);
         return -1;
     }
+
+    multifd_zero_page_check_recv(p);
+
+    if (!p->normal_num) {
+        assert(in_size == 0);
+        return 0;
+    }
+
     ret = qio_channel_read_all(p->c, (void *)z->zbuff, in_size, errp);
 
     if (ret != 0) {
diff --git a/migration/multifd.c b/migration/multifd.c
index adfe8c9a0a..eace0278af 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qemu/rcu.h"
 #include "exec/target_page.h"
 #include "sysemu/sysemu.h"
@@ -126,6 +127,8 @@ static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
     MultiFDPages_t *pages = p->pages;
     int ret;
 
+    multifd_zero_page_check_send(p);
+
     if (!use_zero_copy_send) {
         /*
          * Only !zerocopy needs the header in IOV; zerocopy will
@@ -134,13 +137,13 @@ static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
         multifd_send_prepare_header(p);
     }
 
-    for (int i = 0; i < pages->num; i++) {
+    for (int i = 0; i < pages->normal_num; i++) {
         p->iov[p->iovs_num].iov_base = pages->block->host + pages->offset[i];
         p->iov[p->iovs_num].iov_len = p->page_size;
         p->iovs_num++;
     }
 
-    p->next_packet_size = pages->num * p->page_size;
+    p->next_packet_size = pages->normal_num * p->page_size;
     p->flags |= MULTIFD_FLAG_NOCOMP;
 
     multifd_send_fill_packet(p);
@@ -202,6 +205,13 @@ static int nocomp_recv_pages(MultiFDRecvParams *p, Error **errp)
                    p->id, flags, MULTIFD_FLAG_NOCOMP);
         return -1;
     }
+
+    multifd_zero_page_check_recv(p);
+
+    if (!p->normal_num) {
+        return 0;
+    }
+
     for (int i = 0; i < p->normal_num; i++) {
         p->iov[i].iov_base = p->host + p->normal[i];
         p->iov[i].iov_len = p->page_size;
@@ -236,6 +246,7 @@ static void multifd_pages_reset(MultiFDPages_t *pages)
      * overwritten later when reused.
      */
     pages->num = 0;
+    pages->normal_num = 0;
     pages->block = NULL;
 }
 
@@ -327,11 +338,13 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
     MultiFDPacket_t *packet = p->packet;
     MultiFDPages_t *pages = p->pages;
     uint64_t packet_num;
+    uint32_t zero_num = pages->num - pages->normal_num;
     int i;
 
     packet->flags = cpu_to_be32(p->flags);
     packet->pages_alloc = cpu_to_be32(p->pages->allocated);
-    packet->normal_pages = cpu_to_be32(pages->num);
+    packet->normal_pages = cpu_to_be32(pages->normal_num);
+    packet->zero_pages = cpu_to_be32(zero_num);
     packet->next_packet_size = cpu_to_be32(p->next_packet_size);
 
     packet_num = qatomic_fetch_inc(&multifd_send_state->packet_num);
@@ -349,10 +362,11 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
     }
 
     p->packets_sent++;
-    p->total_normal_pages += pages->num;
+    p->total_normal_pages += pages->normal_num;
+    p->total_zero_pages += zero_num;
 
-    trace_multifd_send(p->id, packet_num, pages->num, p->flags,
-                       p->next_packet_size);
+    trace_multifd_send(p->id, packet_num, pages->normal_num, zero_num,
+                       p->flags, p->next_packet_size);
 }
 
 static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
@@ -393,20 +407,29 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
     p->normal_num = be32_to_cpu(packet->normal_pages);
     if (p->normal_num > packet->pages_alloc) {
         error_setg(errp, "multifd: received packet "
-                   "with %u pages and expected maximum pages are %u",
+                   "with %u normal pages and expected maximum pages are %u",
                    p->normal_num, packet->pages_alloc) ;
         return -1;
     }
 
+    p->zero_num = be32_to_cpu(packet->zero_pages);
+    if (p->zero_num > packet->pages_alloc - p->normal_num) {
+        error_setg(errp, "multifd: received packet "
+                   "with %u zero pages and expected maximum zero pages are %u",
+                   p->zero_num, packet->pages_alloc - p->normal_num) ;
+        return -1;
+    }
+
     p->next_packet_size = be32_to_cpu(packet->next_packet_size);
     p->packet_num = be64_to_cpu(packet->packet_num);
     p->packets_recved++;
     p->total_normal_pages += p->normal_num;
+    p->total_zero_pages += p->zero_num;
 
-    trace_multifd_recv(p->id, p->packet_num, p->normal_num, p->flags,
-                       p->next_packet_size);
+    trace_multifd_recv(p->id, p->packet_num, p->normal_num, p->zero_num,
+                       p->flags, p->next_packet_size);
 
-    if (p->normal_num == 0) {
+    if (p->normal_num == 0 && p->zero_num == 0) {
         return 0;
     }
 
@@ -432,6 +455,18 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
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
 
@@ -823,6 +858,8 @@ static void *multifd_send_thread(void *opaque)
 
             stat64_add(&mig_stats.multifd_bytes,
                        p->next_packet_size + p->packet_len);
+            stat64_add(&mig_stats.normal_pages, pages->normal_num);
+            stat64_add(&mig_stats.zero_pages, pages->num - pages->normal_num);
 
             multifd_pages_reset(p->pages);
             p->next_packet_size = 0;
@@ -866,7 +903,8 @@ out:
 
     rcu_unregister_thread();
     migration_threads_remove(thread);
-    trace_multifd_send_thread_end(p->id, p->packets_sent, p->total_normal_pages);
+    trace_multifd_send_thread_end(p->id, p->packets_sent, p->total_normal_pages,
+                                  p->total_zero_pages);
 
     return NULL;
 }
@@ -1132,6 +1170,8 @@ static void multifd_recv_cleanup_channel(MultiFDRecvParams *p)
     p->iov = NULL;
     g_free(p->normal);
     p->normal = NULL;
+    g_free(p->zero);
+    p->zero = NULL;
     multifd_recv_state->ops->recv_cleanup(p);
 }
 
@@ -1232,7 +1272,7 @@ static void *multifd_recv_thread(void *opaque)
         p->flags &= ~MULTIFD_FLAG_SYNC;
         qemu_mutex_unlock(&p->mutex);
 
-        if (p->normal_num) {
+        if (p->normal_num + p->zero_num) {
             ret = multifd_recv_state->ops->recv_pages(p, &local_err);
             if (ret != 0) {
                 break;
@@ -1251,7 +1291,9 @@ static void *multifd_recv_thread(void *opaque)
     }
 
     rcu_unregister_thread();
-    trace_multifd_recv_thread_end(p->id, p->packets_recved, p->total_normal_pages);
+    trace_multifd_recv_thread_end(p->id, p->packets_recved,
+                                  p->total_normal_pages,
+                                  p->total_zero_pages);
 
     return NULL;
 }
@@ -1290,6 +1332,7 @@ int multifd_recv_setup(Error **errp)
         p->name = g_strdup_printf("multifdrecv_%d", i);
         p->iov = g_new0(struct iovec, page_count);
         p->normal = g_new0(ram_addr_t, page_count);
+        p->zero = g_new0(ram_addr_t, page_count);
         p->page_count = page_count;
         p->page_size = qemu_target_page_size();
     }
@@ -1359,3 +1402,17 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
                        QEMU_THREAD_JOINABLE);
     qatomic_inc(&multifd_recv_state->count);
 }
+
+bool multifd_send_prepare_common(MultiFDSendParams *p)
+{
+    multifd_zero_page_check_send(p);
+
+    if (!p->pages->normal_num) {
+        p->next_packet_size = 0;
+        return false;
+    }
+
+    multifd_send_prepare_header(p);
+
+    return true;
+}
diff --git a/migration/multifd.h b/migration/multifd.h
index 8a1cad0996..e18ffdf7cc 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -48,14 +48,24 @@ typedef struct {
     /* size of the next packet that contains pages */
     uint32_t next_packet_size;
     uint64_t packet_num;
-    uint64_t unused[4];    /* Reserved for future use */
+    /* zero pages */
+    uint32_t zero_pages;
+    uint32_t unused32[1];    /* Reserved for future use */
+    uint64_t unused64[3];    /* Reserved for future use */
     char ramblock[256];
+    /*
+     * This array contains the pointers to:
+     *  - normal pages (initial normal_pages entries)
+     *  - zero pages (following zero_pages entries)
+     */
     uint64_t offset[];
 } __attribute__((packed)) MultiFDPacket_t;
 
 typedef struct {
     /* number of used pages */
     uint32_t num;
+    /* number of normal pages */
+    uint32_t normal_num;
     /* number of allocated pages */
     uint32_t allocated;
     /* offset of each page */
@@ -124,6 +134,8 @@ typedef struct {
     uint64_t packets_sent;
     /* non zero pages sent through this channel */
     uint64_t total_normal_pages;
+    /* zero pages sent through this channel */
+    uint64_t total_zero_pages;
     /* buffers to send */
     struct iovec *iov;
     /* number of iovs used */
@@ -178,12 +190,18 @@ typedef struct {
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
@@ -205,6 +223,9 @@ typedef struct {
 
 void multifd_register_ops(int method, MultiFDMethods *ops);
 void multifd_send_fill_packet(MultiFDSendParams *p);
+bool multifd_send_prepare_common(MultiFDSendParams *p);
+void multifd_zero_page_check_send(MultiFDSendParams *p);
+void multifd_zero_page_check_recv(MultiFDRecvParams *p);
 
 static inline void multifd_send_prepare_header(MultiFDSendParams *p)
 {
@@ -213,5 +234,4 @@ static inline void multifd_send_prepare_header(MultiFDSendParams *p)
     p->iovs_num++;
 }
 
-
 #endif
diff --git a/migration/ram.c b/migration/ram.c
index 67035fb4b1..414cd0d753 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1259,7 +1259,6 @@ static int ram_save_multifd_page(RAMBlock *block, ram_addr_t offset)
     if (!multifd_queue_page(block, offset)) {
         return -1;
     }
-    stat64_add(&mig_stats.normal_pages, 1);
 
     return 1;
 }
diff --git a/migration/trace-events b/migration/trace-events
index 298ad2b0dd..9f1d7ae71a 100644
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
+multifd_send(uint8_t id, uint64_t packet_num, uint32_t normal_pages, uint32_t zero_pages, uint32_t flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " normal pages %u zero pages %u flags 0x%x next packet size %u"
 multifd_send_error(uint8_t id) "channel %u"
 multifd_send_sync_main(long packet_num) "packet num %ld"
 multifd_send_sync_main_signal(uint8_t id) "channel %u"
 multifd_send_sync_main_wait(uint8_t id) "channel %u"
 multifd_send_terminate_threads(void) ""
-multifd_send_thread_end(uint8_t id, uint64_t packets, uint64_t normal_pages) "channel %u packets %" PRIu64 " normal pages %"  PRIu64
+multifd_send_thread_end(uint8_t id, uint64_t packets, uint64_t normal_pages, uint64_t zero_pages) "channel %u packets %" PRIu64 " normal pages %"  PRIu64 " zero pages %"  PRIu64
 multifd_send_thread_start(uint8_t id) "%u"
 multifd_tls_outgoing_handshake_start(void *ioc, void *tioc, const char *hostname) "ioc=%p tioc=%p hostname=%s"
 multifd_tls_outgoing_handshake_error(void *ioc, const char *err) "ioc=%p err=%s"
diff --git a/qapi/migration.json b/qapi/migration.json
index 1e66272f8f..5a1bb8ad62 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -660,10 +660,13 @@
 #
 # @legacy: Perform zero page checking from main migration thread.
 #
+# @multifd: Perform zero page checking from multifd sender thread.
+#
 # Since: 9.0
+#
 ##
 { 'enum': 'ZeroPageDetection',
-  'data': [ 'none', 'legacy' ] }
+  'data': [ 'none', 'legacy', 'multifd' ] }
 
 ##
 # @BitmapMigrationBitmapAliasTransform:
-- 
2.30.2


