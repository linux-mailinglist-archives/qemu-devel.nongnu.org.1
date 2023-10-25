Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C80B47D7491
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 21:41:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvjjd-0001HP-Jz; Wed, 25 Oct 2023 15:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1qvjjT-00015l-Nv
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:39:59 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1qvjjL-0006BU-U9
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:39:58 -0400
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-77063481352so101000985a.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 12:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1698262790; x=1698867590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M+NUDX6FYlsNIn76fnLfQd7sg/7pGQAjAqSwBoE6gkI=;
 b=ZbhCQv95whfAI03CtqgeEMnYazXc5F1rDLoYCdwqSRCiQcWGHR3kVMZiP5pTydr1Ye
 Puq0FkgcPdmdlc4Pg+Mp/A1xhaZrqyvIrY+HG/Z2guXH/FP+uB3AZNZl/Juv/p8RErwT
 LA4ELgOLmASsfYMJ9WGtUX4Ioaf3AhAXhkEgEqbWuMt8DqGx6X616FFlMamOhRBe6d3q
 zY5pMkRKgwDHVVpamS9dfopXf/ztMpVmL/dtBhDxaAzfl2ZgBQdZiJGwS3g05o3I8YWI
 1jd1bv+KPHULneoSoVBMv4BMOgbU/JF+4WcVTTxRwv/3ITHHChPrGK+1tpse1ylIorSV
 PAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698262790; x=1698867590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M+NUDX6FYlsNIn76fnLfQd7sg/7pGQAjAqSwBoE6gkI=;
 b=G/4kcbLJhlq5miNj1UnAKR0g19DSbhr2I6/sCDVTwmbh8TmV98yHll0JLXPkGFAio7
 DK1BfGYVWrcCoQEAUCSf1XfCH4Dojx8Q5eqzkFVGF4O7rRSGE0U3HaV0teUIo2+jKJws
 MziH3JQrL4l+W2392nBdbDf7pVP9UTGq8qqlamLBnoSGRqysS6eEP/zqUGBLxkdWmg4R
 lTTK7bLCSKf01sps3trQjBi9Hx8wfFOC59/7HyMDSDP4W2ov+dJGTap+PAbEKHXX8R0g
 hfpf4dTmCEPKDXxvo9bMfLcd3GP40n0dzIuWD2HxK+Cy4E8RMfurdaZnPaJmqOr6jHcl
 r82g==
X-Gm-Message-State: AOJu0YyiO6EUQ/TehPu8lsgpkuDtE+y430TwMRG0PRQpbNdRAnTOVZbj
 Iv/innutFtLlDEpOPTtIybpoiA==
X-Google-Smtp-Source: AGHT+IEi5W40koLoD77Y1VAkgr7zah8uWafJNs5AaEdLxAKdchT3RdEGgtZxXKObIse6usYwF6x3TA==
X-Received: by 2002:a05:620a:4724:b0:773:ca5c:4556 with SMTP id
 bs36-20020a05620a472400b00773ca5c4556mr929497qkb.10.1698262790124; 
 Wed, 25 Oct 2023 12:39:50 -0700 (PDT)
Received: from n231-230-216.byted.org ([147.160.184.135])
 by smtp.gmail.com with ESMTPSA id
 o8-20020a05620a228800b0076cdc3b5beasm4453721qkh.86.2023.10.25.12.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 12:39:49 -0700 (PDT)
From: Hao Xiang <hao.xiang@bytedance.com>
To: quintela@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com,
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH 14/16] migration/multifd: Enable set packet size migration
 option.
Date: Wed, 25 Oct 2023 19:38:20 +0000
Message-Id: <20231025193822.2813204-15-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231025193822.2813204-1-hao.xiang@bytedance.com>
References: <20231025193822.2813204-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x731.google.com
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

During live migration, if the latency between sender and receiver
is high but bandwidth is high (a long and fat pipe), using a bigger
packet size can help reduce migration total time. In addition, Intel
DSA offloading performs better with a large batch task. Providing an
option to set the packet size is useful for performance tuning.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 migration/migration-hmp-cmds.c | 7 +++++++
 migration/multifd-zlib.c       | 4 ++--
 migration/multifd-zstd.c       | 4 ++--
 migration/multifd.c            | 6 ++++--
 migration/multifd.h            | 3 ---
 5 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index e1f110afbc..c53e4d8543 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -333,6 +333,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %s\n",
             MigrationParameter_str(MIGRATION_PARAMETER_BLOCK_INCREMENTAL),
             params->block_incremental ? "on" : "off");
+        monitor_printf(mon, "%s: %" PRIu64 "\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_PACKET_SIZE),
+            params->multifd_packet_size);
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_CHANNELS),
             params->multifd_channels);
@@ -597,6 +600,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->multifd_dsa_accel->type = QTYPE_QSTRING;
         visit_type_str(v, param, &p->multifd_dsa_accel->u.s, &err);
         break;
+    case MIGRATION_PARAMETER_MULTIFD_PACKET_SIZE:
+        p->has_multifd_packet_size = true;
+        visit_type_size(v, param, &p->multifd_packet_size, &err);
+        break;
     case MIGRATION_PARAMETER_MULTIFD_CHANNELS:
         p->has_multifd_channels = true;
         visit_type_uint8(v, param, &p->multifd_channels, &err);
diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 37ce48621e..a1b127d0d1 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -58,7 +58,7 @@ static int zlib_send_setup(MultiFDSendParams *p, Error **errp)
         goto err_free_z;
     }
     /* This is the maximum size of the compressed buffer */
-    z->zbuff_len = compressBound(MULTIFD_PACKET_SIZE);
+    z->zbuff_len = compressBound(migrate_multifd_packet_size());
     z->zbuff = g_try_malloc(z->zbuff_len);
     if (!z->zbuff) {
         err_msg = "out of memory for zbuff";
@@ -200,7 +200,7 @@ static int zlib_recv_setup(MultiFDRecvParams *p, Error **errp)
         return -1;
     }
     /* To be safe, we reserve twice the size of the packet */
-    z->zbuff_len = MULTIFD_PACKET_SIZE * 2;
+    z->zbuff_len = migrate_multifd_packet_size() * 2;
     z->zbuff = g_try_malloc(z->zbuff_len);
     if (!z->zbuff) {
         inflateEnd(zs);
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index b471daadcd..0c92112702 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -69,7 +69,7 @@ static int zstd_send_setup(MultiFDSendParams *p, Error **errp)
         return -1;
     }
     /* This is the maximum size of the compressed buffer */
-    z->zbuff_len = ZSTD_compressBound(MULTIFD_PACKET_SIZE);
+    z->zbuff_len = ZSTD_compressBound(migrate_multifd_packet_size());
     z->zbuff = g_try_malloc(z->zbuff_len);
     if (!z->zbuff) {
         ZSTD_freeCStream(z->zcs);
@@ -196,7 +196,7 @@ static int zstd_recv_setup(MultiFDRecvParams *p, Error **errp)
     }
 
     /* To be safe, we reserve twice the size of the packet */
-    z->zbuff_len = MULTIFD_PACKET_SIZE * 2;
+    z->zbuff_len = migrate_multifd_packet_size() * 2;
     z->zbuff = g_try_malloc(z->zbuff_len);
     if (!z->zbuff) {
         ZSTD_freeDStream(z->zds);
diff --git a/migration/multifd.c b/migration/multifd.c
index a0bfb48a7e..a6ecfdd449 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1045,7 +1045,8 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
 int multifd_save_setup(Error **errp)
 {
     int thread_count;
-    uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
+    uint32_t page_count =
+        migrate_multifd_packet_size() / qemu_target_page_size();
     uint8_t i;
     const char *dsa_parameter = migrate_multifd_dsa_accel();
 
@@ -1323,7 +1324,8 @@ static void *multifd_recv_thread(void *opaque)
 int multifd_load_setup(Error **errp)
 {
     int thread_count;
-    uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
+    uint32_t page_count =
+        migrate_multifd_packet_size() / qemu_target_page_size();
     uint8_t i;
     const char *dsa_parameter = migrate_multifd_dsa_accel();
 
diff --git a/migration/multifd.h b/migration/multifd.h
index 297b055e2b..8b1cf136d7 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -34,9 +34,6 @@ int multifd_queue_page(QEMUFile *f, RAMBlock *block, ram_addr_t offset);
 #define MULTIFD_FLAG_ZLIB (1 << 1)
 #define MULTIFD_FLAG_ZSTD (2 << 1)
 
-/* This value needs to be a multiple of qemu_target_page_size() */
-#define MULTIFD_PACKET_SIZE (512 * 1024)
-
 typedef struct {
     uint32_t magic;
     uint32_t version;
-- 
2.30.2


