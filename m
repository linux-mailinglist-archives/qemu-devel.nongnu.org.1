Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CB77EAA33
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 06:43:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2mBy-0007lO-If; Tue, 14 Nov 2023 00:42:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r2mBl-0007IP-Fq
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 00:42:17 -0500
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r2mBh-0001Zz-VM
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 00:42:17 -0500
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-778940531dbso322665485a.0
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 21:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1699940532; x=1700545332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vt+w0QrMq+jm8GxkTLfUKv1nYJwURMZ3Gb3we60cQuI=;
 b=FCI4v9axDZMiNucVrhtJtQTU5whLpR9aUdUahWnCnbzBECXfXaThY6itVnJsEfhBV5
 mk3xgNXcxQ3RuR7pmmHikPQEFFCm+6KFVA1zra/9d45j6jx4shPPw4FxKOeq+EylCZ3g
 Ey1lYCiy1+bSMR0HobUy+Ar0mG3aVTiWVSG3rSHb+1i5oL1E28/p8RT6wTuoTT5hn00o
 TtPLMQBVQH/c6+n4ounx7JgeI2Ioj8CvMoMZY/4zfQ1NC7cgJho9zBghuen7IplhCaYY
 mVVfTPNy8in/iRePsFSIh6mjP9ErhMQXMRU5FWnzYUsbhb939tMUruubDANtrKwXUBoW
 V5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699940532; x=1700545332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vt+w0QrMq+jm8GxkTLfUKv1nYJwURMZ3Gb3we60cQuI=;
 b=DxvWsv95XlsXBLaTiqyYbXcxfTtLzd7yfH+ra8dtYRWz+KdWcZmi1yjwlP7uJGBKSB
 9yAZuybMSlLNgWLrzMSVMAX0j2kRLgFqx6n5+ApD4dZ7a1XMw+H6hVH6PwpQtBQxWfhy
 tPGOrPgB10XUKq4uD3WbuIPl0E5Gby6yp8f5UaGy29+VIIoW0+4jw6+6X5eSm3C5VSjP
 yDVbEtaHqiizMpL/rfOQC2d5hDevwLzpGx8DAlxfeeENu1b6ArSVbdyFDgAMZRsaPhTy
 70mrzpxSw5WvlS0Tn4fcnNgfbay8ebrKIub/WplC13FDB+jikN4ZLmdDYaQnTryfAYol
 oKoQ==
X-Gm-Message-State: AOJu0YyaRaX02Nt68U9xq0a3I/0Ag4dJUuwxoqEF0DkW8cfcrQNx+2Gl
 on2zR0WpSjFcYVuSh6Osoyu65w==
X-Google-Smtp-Source: AGHT+IFGZd451rj1nu9ZhzY8GwHunn4e/Y9ORufoZJW2QfoF62XqhilzhyKhbDGKsRNbsUKTHTtcmQ==
X-Received: by 2002:a05:620a:35a:b0:76c:e7b7:1d9d with SMTP id
 t26-20020a05620a035a00b0076ce7b71d9dmr1277050qkm.27.1699940531961; 
 Mon, 13 Nov 2023 21:42:11 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.104])
 by smtp.gmail.com with ESMTPSA id
 w2-20020a05620a094200b0077891d2d12dsm2400367qkw.43.2023.11.13.21.42.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 21:42:11 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: farosas@suse.de, peter.maydell@linaro.org, quintela@redhat.com,
 peterx@redhat.com, marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v2 18/20] migration/multifd: Enable set packet size migration
 option.
Date: Tue, 14 Nov 2023 05:40:30 +0000
Message-Id: <20231114054032.1192027-19-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231114054032.1192027-1-hao.xiang@bytedance.com>
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::730;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x730.google.com
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

During live migration, if the latency between sender and receiver
is high but bandwidth is high (a long and fat pipe), using a bigger
packet size can help reduce migration total time. In addition, Intel
DSA offloading performs better with a large batch task. Providing an
option to set the packet size is useful for performance tuning.

Set the option:
migrate_set_parameter multifd-packet-size 512

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 migration/migration-hmp-cmds.c | 7 +++++++
 migration/multifd-zlib.c       | 8 ++++++--
 migration/multifd-zstd.c       | 8 ++++++--
 migration/multifd.c            | 4 ++--
 migration/multifd.h            | 3 ---
 5 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 788ce699ac..2d0c71294c 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -338,6 +338,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %s\n",
             MigrationParameter_str(MIGRATION_PARAMETER_BLOCK_INCREMENTAL),
             params->block_incremental ? "on" : "off");
+        monitor_printf(mon, "%s: %" PRIu64 "\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_PACKET_SIZE),
+            params->multifd_packet_size);
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_CHANNELS),
             params->multifd_channels);
@@ -626,6 +629,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
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
index 37ce48621e..453c85d725 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -49,6 +49,8 @@ static int zlib_send_setup(MultiFDSendParams *p, Error **errp)
     struct zlib_data *z = g_new0(struct zlib_data, 1);
     z_stream *zs = &z->zs;
     const char *err_msg;
+    uint64_t multifd_packet_size =
+        migrate_multifd_packet_size() * qemu_target_page_size();
 
     zs->zalloc = Z_NULL;
     zs->zfree = Z_NULL;
@@ -58,7 +60,7 @@ static int zlib_send_setup(MultiFDSendParams *p, Error **errp)
         goto err_free_z;
     }
     /* This is the maximum size of the compressed buffer */
-    z->zbuff_len = compressBound(MULTIFD_PACKET_SIZE);
+    z->zbuff_len = compressBound(multifd_packet_size);
     z->zbuff = g_try_malloc(z->zbuff_len);
     if (!z->zbuff) {
         err_msg = "out of memory for zbuff";
@@ -186,6 +188,8 @@ static int zlib_send_prepare(MultiFDSendParams *p, Error **errp)
  */
 static int zlib_recv_setup(MultiFDRecvParams *p, Error **errp)
 {
+    uint64_t multifd_packet_size =
+        migrate_multifd_packet_size() * qemu_target_page_size();
     struct zlib_data *z = g_new0(struct zlib_data, 1);
     z_stream *zs = &z->zs;
 
@@ -200,7 +204,7 @@ static int zlib_recv_setup(MultiFDRecvParams *p, Error **errp)
         return -1;
     }
     /* To be safe, we reserve twice the size of the packet */
-    z->zbuff_len = MULTIFD_PACKET_SIZE * 2;
+    z->zbuff_len = multifd_packet_size * 2;
     z->zbuff = g_try_malloc(z->zbuff_len);
     if (!z->zbuff) {
         inflateEnd(zs);
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index b471daadcd..60298861d6 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -49,6 +49,8 @@ struct zstd_data {
  */
 static int zstd_send_setup(MultiFDSendParams *p, Error **errp)
 {
+    uint64_t multifd_packet_size =
+        migrate_multifd_packet_size() * qemu_target_page_size();
     struct zstd_data *z = g_new0(struct zstd_data, 1);
     int res;
 
@@ -69,7 +71,7 @@ static int zstd_send_setup(MultiFDSendParams *p, Error **errp)
         return -1;
     }
     /* This is the maximum size of the compressed buffer */
-    z->zbuff_len = ZSTD_compressBound(MULTIFD_PACKET_SIZE);
+    z->zbuff_len = ZSTD_compressBound(multifd_packet_size);
     z->zbuff = g_try_malloc(z->zbuff_len);
     if (!z->zbuff) {
         ZSTD_freeCStream(z->zcs);
@@ -175,6 +177,8 @@ static int zstd_send_prepare(MultiFDSendParams *p, Error **errp)
  */
 static int zstd_recv_setup(MultiFDRecvParams *p, Error **errp)
 {
+    uint64_t multifd_packet_size =
+        migrate_multifd_packet_size() * qemu_target_page_size();
     struct zstd_data *z = g_new0(struct zstd_data, 1);
     int ret;
 
@@ -196,7 +200,7 @@ static int zstd_recv_setup(MultiFDRecvParams *p, Error **errp)
     }
 
     /* To be safe, we reserve twice the size of the packet */
-    z->zbuff_len = MULTIFD_PACKET_SIZE * 2;
+    z->zbuff_len = multifd_packet_size * 2;
     z->zbuff = g_try_malloc(z->zbuff_len);
     if (!z->zbuff) {
         ZSTD_freeDStream(z->zds);
diff --git a/migration/multifd.c b/migration/multifd.c
index c9f9eef5b1..fbe8bbcc5c 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1051,7 +1051,7 @@ static void multifd_new_send_channel_create(gpointer opaque)
 int multifd_save_setup(Error **errp)
 {
     int thread_count;
-    uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
+    uint32_t page_count = migrate_multifd_packet_size();
     uint8_t i;
     const char *dsa_parameter = migrate_multifd_dsa_accel();
 
@@ -1329,7 +1329,7 @@ static void *multifd_recv_thread(void *opaque)
 int multifd_load_setup(Error **errp)
 {
     int thread_count;
-    uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
+    uint32_t page_count = migrate_multifd_packet_size();
     uint8_t i;
     const char *dsa_parameter = migrate_multifd_dsa_accel();
 
diff --git a/migration/multifd.h b/migration/multifd.h
index 62f31b03c0..173c3f4171 100644
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


