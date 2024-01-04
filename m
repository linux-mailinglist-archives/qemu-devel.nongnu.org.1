Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3C08239C9
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 01:47:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLBsB-0008ON-4B; Wed, 03 Jan 2024 19:46:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBs3-0008K0-28
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:46:03 -0500
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBrx-0007Vf-4T
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:46:02 -0500
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7811d1e68b0so1721885a.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 16:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704329153; x=1704933953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S8Y4l8VuWq53Qum8DYTd3/HxY7Xs+wZVIBH3RjynbWA=;
 b=G5ye2g9Ga7Qa4FFhiWi3uhYqi491UuLwoGIOkW6fqbAOYtekdscZMog+iLQf/2ddXa
 Om3JWcV9WnlFz+3koHm4szdWSrlodBMMVYiO3cv0Qppfdj4Q4CB4wUrBancF9EYOBUr+
 2YkGRklA1m1lOgDNfrr1PI0bLjQgYe2qXoLzFsH8+QF0IL26uN5Z5biEVUoYU350x5bL
 ysLC4Gc41cCSAEEQDYryb9o4CbaPdG7n2jZLehr8cnKPcEGAXodaJ45jjSkg9EScCC91
 rUiyUWTXiLyusEKN/Yd7T2vZWfQ9rOTREi4i/1NLF8XsElimwIltrhdik4Zz1ps9GdXN
 +hCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704329153; x=1704933953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S8Y4l8VuWq53Qum8DYTd3/HxY7Xs+wZVIBH3RjynbWA=;
 b=vtsiQTZMlcRjwvEmAuxy4FqgTgW7t5kahtBjb8Mpt6i2IEaPN8pRCcViGFwvUU8khd
 x+yFGJ7y7ytiw/XCd2emDArR2SQZZQ4ne73VHtzOqJ/D9ZX3mrcPbiUl8Wmkf5uVDApR
 uI6D0SGwaO8Rr5iAeIoVYcAP+Y89PtWp5Gg4x7/dtOoUFb4oixm/AYOp7vwqYuoekgQd
 yCc3C3O1EJL1pR6xdM46+5VvL+EyZTqt+Qi3tYb4N09Eo3nZy2lv2p3lz/2Gu0+jLBLq
 BPwiApu+bMvYTInOAPCUJ6jBbpUaQUWJFdDcg2Lq5WKuVjj3z1jfQ8J4JETEw6WX/L9R
 vhyQ==
X-Gm-Message-State: AOJu0Yxua+EBSHFqyNXxCZvAfuBX5rce1kwIgn3nOr2+RHORJDG9DEE/
 k61B2IWVnckKF0Xeb2PhtpCYRrZdYowxmg==
X-Google-Smtp-Source: AGHT+IGk/B725hM2d0TR2io9mbXDbCRAzRPNV5vPFlnPwc+PdoFX7HiO4OThfVRW1+KXTlScmDkkSA==
X-Received: by 2002:a37:de0f:0:b0:781:7ac2:d7d8 with SMTP id
 h15-20020a37de0f000000b007817ac2d7d8mr11336785qkj.100.1704329153472; 
 Wed, 03 Jan 2024 16:45:53 -0800 (PST)
Received: from n231-230-216.byted.org ([147.160.184.87])
 by smtp.gmail.com with ESMTPSA id
 x19-20020ae9f813000000b0077d66e5b2e6sm10646087qkh.3.2024.01.03.16.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 16:45:52 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: farosas@suse.de, peter.maydell@linaro.org, peterx@redhat.com,
 marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v3 18/20] migration/multifd: Enable set packet size migration
 option.
Date: Thu,  4 Jan 2024 00:44:50 +0000
Message-Id: <20240104004452.324068-19-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240104004452.324068-1-hao.xiang@bytedance.com>
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x72b.google.com
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
is high and bandwidth is also high (a long and fat pipe), using a bigger
packet size can help reduce migration total time. In addition, Intel
DSA offloading performs better with a large batch task. Providing an
option to set the packet size is useful for performance tuning.

Set the option:
migrate_set_parameter multifd-packet-size 4190208

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 migration/migration-hmp-cmds.c | 7 +++++++
 migration/multifd-zlib.c       | 6 ++++--
 migration/multifd-zstd.c       | 6 ++++--
 migration/multifd.c            | 6 ++++--
 migration/multifd.h            | 3 ---
 5 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 8219d112d6..272b553c3a 100644
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
index 37ce48621e..4318ccced8 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -49,6 +49,7 @@ static int zlib_send_setup(MultiFDSendParams *p, Error **errp)
     struct zlib_data *z = g_new0(struct zlib_data, 1);
     z_stream *zs = &z->zs;
     const char *err_msg;
+    uint64_t multifd_packet_size = migrate_multifd_packet_size();
 
     zs->zalloc = Z_NULL;
     zs->zfree = Z_NULL;
@@ -58,7 +59,7 @@ static int zlib_send_setup(MultiFDSendParams *p, Error **errp)
         goto err_free_z;
     }
     /* This is the maximum size of the compressed buffer */
-    z->zbuff_len = compressBound(MULTIFD_PACKET_SIZE);
+    z->zbuff_len = compressBound(multifd_packet_size);
     z->zbuff = g_try_malloc(z->zbuff_len);
     if (!z->zbuff) {
         err_msg = "out of memory for zbuff";
@@ -186,6 +187,7 @@ static int zlib_send_prepare(MultiFDSendParams *p, Error **errp)
  */
 static int zlib_recv_setup(MultiFDRecvParams *p, Error **errp)
 {
+    uint64_t multifd_packet_size = migrate_multifd_packet_size();
     struct zlib_data *z = g_new0(struct zlib_data, 1);
     z_stream *zs = &z->zs;
 
@@ -200,7 +202,7 @@ static int zlib_recv_setup(MultiFDRecvParams *p, Error **errp)
         return -1;
     }
     /* To be safe, we reserve twice the size of the packet */
-    z->zbuff_len = MULTIFD_PACKET_SIZE * 2;
+    z->zbuff_len = multifd_packet_size * 2;
     z->zbuff = g_try_malloc(z->zbuff_len);
     if (!z->zbuff) {
         inflateEnd(zs);
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index b471daadcd..a6fdb2ac11 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -49,6 +49,7 @@ struct zstd_data {
  */
 static int zstd_send_setup(MultiFDSendParams *p, Error **errp)
 {
+    uint64_t multifd_packet_size = migrate_multifd_packet_size();
     struct zstd_data *z = g_new0(struct zstd_data, 1);
     int res;
 
@@ -69,7 +70,7 @@ static int zstd_send_setup(MultiFDSendParams *p, Error **errp)
         return -1;
     }
     /* This is the maximum size of the compressed buffer */
-    z->zbuff_len = ZSTD_compressBound(MULTIFD_PACKET_SIZE);
+    z->zbuff_len = ZSTD_compressBound(multifd_packet_size);
     z->zbuff = g_try_malloc(z->zbuff_len);
     if (!z->zbuff) {
         ZSTD_freeCStream(z->zcs);
@@ -175,6 +176,7 @@ static int zstd_send_prepare(MultiFDSendParams *p, Error **errp)
  */
 static int zstd_recv_setup(MultiFDRecvParams *p, Error **errp)
 {
+    uint64_t multifd_packet_size = migrate_multifd_packet_size();
     struct zstd_data *z = g_new0(struct zstd_data, 1);
     int ret;
 
@@ -196,7 +198,7 @@ static int zstd_recv_setup(MultiFDRecvParams *p, Error **errp)
     }
 
     /* To be safe, we reserve twice the size of the packet */
-    z->zbuff_len = MULTIFD_PACKET_SIZE * 2;
+    z->zbuff_len = multifd_packet_size * 2;
     z->zbuff = g_try_malloc(z->zbuff_len);
     if (!z->zbuff) {
         ZSTD_freeDStream(z->zds);
diff --git a/migration/multifd.c b/migration/multifd.c
index cfae5401a9..700fb1c034 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1046,7 +1046,8 @@ static void multifd_new_send_channel_create(gpointer opaque)
 int multifd_save_setup(Error **errp)
 {
     int thread_count;
-    uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
+    uint32_t page_count =
+        migrate_multifd_packet_size() / qemu_target_page_size();
     uint8_t i;
     const char *dsa_parameter = migrate_multifd_dsa_accel();
     int ret;
@@ -1327,7 +1328,8 @@ static void *multifd_recv_thread(void *opaque)
 int multifd_load_setup(Error **errp)
 {
     int thread_count;
-    uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
+    uint32_t page_count =
+        migrate_multifd_packet_size() / qemu_target_page_size();
     uint8_t i;
     const char *dsa_parameter = migrate_multifd_dsa_accel();
     int ret;
diff --git a/migration/multifd.h b/migration/multifd.h
index 97b5f888a7..4f30b24832 100644
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


