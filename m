Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C3F7D748E
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 21:41:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvjjQ-0000yI-C9; Wed, 25 Oct 2023 15:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1qvjjM-0000wu-5Z
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:39:52 -0400
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1qvjjJ-0006BJ-OA
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:39:51 -0400
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-778999c5ecfso10759785a.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 12:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1698262789; x=1698867589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HCBwezzBVtO8oUhpBVp7AXk3ceMQWBAVIo2+dQvz4iw=;
 b=IIilD8ojXCBSY0ZK09ryoxhtV2Qz5QXapGMeffAei0vfqc32G0FIZZ6UuPEQiErH03
 yQ7EeZ/Lqnksx2IV7QDyC1PuBY//XpsbsIQKO2PV00zQVBfFm4PWxweNX8d2eD6Rej7S
 pix1oVbLbB8Km53ocCgaIYasaOMSZbcEFBF+A7tiPetTBCnrHAHFojXaVTXR9HPBllZX
 bLTFmlDvTrPvcUi+C/LeCQYPldQSrHoidNlM9GodwYg6z0cwwNpQ5qfWEAkqS5Lqbi6G
 AfYPJCXsrraKQgYv1/rqH4/FNSbTb7s6Tiv64214A56hbVeVVdW/a4UlOjwjTVXEoP1D
 NA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698262789; x=1698867589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HCBwezzBVtO8oUhpBVp7AXk3ceMQWBAVIo2+dQvz4iw=;
 b=Lw1dMJSR2HENNZmAIbIkssO7ug/0iJ363h9xe+SpvSE8dvob4m6APuiDjOuR/p1Gev
 C8ZegEohKnLFjrbixJWsj3wkOhT30CFtqgtr+9kvZGefUdkQ1Jc1Tg0Ryw2DVkyfsxkV
 IMxl+1oFX8BQ9HmfrG/8ydOUMZr2FqA/RLaPE4DOU13oFclC1AqfqsROedHCxLvPRA2G
 u5tPfwWOP+OhG6/7T68Apsxnoh9z1hdhSp1bR+L+wgi6VL24SYp5ZuS3L0f57OEwDHBT
 EJrJs0zEYbMsu2Q5vGYIshdSQJqQ3JR3yqdncICFbm/o16kLKwIJDbUUqzc9fuKOo/Mw
 t6sA==
X-Gm-Message-State: AOJu0YwdT6ehVfLYqMtij8d2Nrvt41IztMHFf+4U6hMczkzwQeJJxb3T
 w8fLyPwZBMngDBoi8rWK5+VNXB4+zC0/TjKu6As=
X-Google-Smtp-Source: AGHT+IGQCvPVrVN/fs7/WJdMP8OEOrE1/bKAgoC42g5T3FHcB85yJRAuoHDd3uyYv/I3ELTc0+Kcrg==
X-Received: by 2002:a05:620a:2947:b0:779:f0be:8d7e with SMTP id
 n7-20020a05620a294700b00779f0be8d7emr5514219qkp.27.1698262788803; 
 Wed, 25 Oct 2023 12:39:48 -0700 (PDT)
Received: from n231-230-216.byted.org ([147.160.184.135])
 by smtp.gmail.com with ESMTPSA id
 o8-20020a05620a228800b0076cdc3b5beasm4453721qkh.86.2023.10.25.12.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 12:39:48 -0700 (PDT)
From: Hao Xiang <hao.xiang@bytedance.com>
To: quintela@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com,
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH 13/16] migration/multifd: Add migration option set packet size.
Date: Wed, 25 Oct 2023 19:38:19 +0000
Message-Id: <20231025193822.2813204-14-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231025193822.2813204-1-hao.xiang@bytedance.com>
References: <20231025193822.2813204-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x734.google.com
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

The current multifd packet size is 128 * 4kb. This change adds
an option to set the packet size. Both sender and receiver needs
to set the same packet size for things to work.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 migration/options.c | 34 ++++++++++++++++++++++++++++++++++
 migration/options.h |  1 +
 qapi/migration.json | 20 +++++++++++++++++---
 3 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 9ee0ad5d89..6cb3d19470 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -83,6 +83,12 @@
  */
 #define DEFAULT_MIGRATE_MULTIFD_NORMAL_PAGE_RATIO 101
 
+/*
+ * Parameter for multifd packet size.
+ */
+#define DEFAULT_MIGRATE_MULTIFD_PACKET_SIZE (512 * 1024)
+#define MAX_MIGRATE_MULTIFD_PACKET_SIZE (1024 * 4 * 1024)
+
 #define DEFINE_PROP_MIG_CAP(name, x)             \
     DEFINE_PROP_BOOL(name, MigrationState, capabilities[x], false)
 
@@ -183,6 +189,9 @@ Property migration_properties[] = {
     DEFINE_PROP_UINT8("multifd-normal-page-ratio", MigrationState,
                       parameters.multifd_normal_page_ratio,
                       DEFAULT_MIGRATE_MULTIFD_NORMAL_PAGE_RATIO),
+    DEFINE_PROP_SIZE("multifd-packet-size", MigrationState,
+                     parameters.multifd_packet_size,
+                     DEFAULT_MIGRATE_MULTIFD_PACKET_SIZE),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -822,6 +831,13 @@ uint8_t migrate_multifd_normal_page_ratio(void)
     return s->parameters.multifd_normal_page_ratio;
 }
 
+uint64_t migrate_multifd_packet_size(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->parameters.multifd_packet_size;
+}
+
 MultiFDCompression migrate_multifd_compression(void)
 {
     MigrationState *s = migrate_get_current();
@@ -958,6 +974,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
     params->has_block_incremental = true;
     params->block_incremental = s->parameters.block_incremental;
+    params->has_multifd_packet_size = true;
+    params->multifd_packet_size = s->parameters.multifd_packet_size;
     params->has_multifd_channels = true;
     params->multifd_channels = s->parameters.multifd_channels;
     params->has_multifd_compression = true;
@@ -1016,6 +1034,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_downtime_limit = true;
     params->has_x_checkpoint_delay = true;
     params->has_block_incremental = true;
+    params->has_multifd_packet_size = true;
     params->has_multifd_channels = true;
     params->has_multifd_compression = true;
     params->has_multifd_zlib_level = true;
@@ -1104,6 +1123,15 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 
     /* x_checkpoint_delay is now always positive */
 
+    if (params->has_multifd_packet_size &&
+        ((params->multifd_packet_size < DEFAULT_MIGRATE_MULTIFD_PACKET_SIZE) ||
+            (params->multifd_packet_size >  MAX_MIGRATE_MULTIFD_PACKET_SIZE))) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                    "multifd_packet_size",
+                    "a value between 524288 and 4194304");
+        return false;
+    }
+
     if (params->has_multifd_channels && (params->multifd_channels < 1)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "multifd_channels",
@@ -1281,6 +1309,9 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_block_incremental) {
         dest->block_incremental = params->block_incremental;
     }
+    if (params->has_multifd_packet_size) {
+        dest->multifd_packet_size = params->multifd_packet_size;
+    }
     if (params->has_multifd_channels) {
         dest->multifd_channels = params->multifd_channels;
     }
@@ -1408,6 +1439,9 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_block_incremental) {
         s->parameters.block_incremental = params->block_incremental;
     }
+    if (params->has_multifd_packet_size) {
+        s->parameters.multifd_packet_size = params->multifd_packet_size;
+    }
     if (params->has_multifd_channels) {
         s->parameters.multifd_channels = params->multifd_channels;
     }
diff --git a/migration/options.h b/migration/options.h
index dafb09d6ea..1170971aef 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -93,6 +93,7 @@ const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
 const char *migrate_multifd_dsa_accel(void);
 uint8_t migrate_multifd_normal_page_ratio(void);
+uint64_t migrate_multifd_packet_size(void);
 
 /* parameters setters */
 
diff --git a/qapi/migration.json b/qapi/migration.json
index a667527081..a492b73060 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -835,6 +835,10 @@
 # @multifd-normal-page-ratio: Test hook setting the normal page ratio.
 #     (Since 8.1)
 #
+# @multifd-packet-size: Packet size used to migrate data. This value
+#     needs to be a multiple of qemu_target_page_size(). The default
+#     value is (512 * 1024) (Since 8.0)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
@@ -859,7 +863,7 @@
            'multifd-zlib-level', 'multifd-zstd-level',
            'block-bitmap-mapping',
            { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
-           'vcpu-dirty-limit', 'multifd-normal-page-ratio'] }
+           'vcpu-dirty-limit', 'multifd-normal-page-ratio', 'multifd-packet-size'] }
 
 ##
 # @MigrateSetParameters:
@@ -1007,6 +1011,10 @@
 # @multifd-normal-page-ratio: Test hook setting the normal page ratio.
 #     (Since 8.1)
 #
+# @multifd-packet-size: Packet size used to migrate data. This value
+#     needs to be a multiple of qemu_target_page_size(). The default
+#     value is (512 * 1024) (Since 8.0)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
@@ -1050,7 +1058,8 @@
                                             'features': [ 'unstable' ] },
             '*vcpu-dirty-limit': 'uint64',
             '*multifd-dsa-accel': 'StrOrNull',
-            '*multifd-normal-page-ratio': 'uint8'} }
+            '*multifd-normal-page-ratio': 'uint8',
+            '*multifd-packet-size' : 'uint64'} }
 
 ##
 # @migrate-set-parameters:
@@ -1218,6 +1227,10 @@
 # @multifd-normal-page-ratio: Test hook setting the normal page ratio.
 #     (Since 8.1)
 #
+# @multifd-packet-size: Packet size used to migrate data. This value
+#     needs to be a multiple of qemu_target_page_size(). The default
+#     value is (512 * 1024) (Since 8.0)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
@@ -1258,7 +1271,8 @@
                                             'features': [ 'unstable' ] },
             '*vcpu-dirty-limit': 'uint64',
             '*multifd-dsa-accel': 'str',
-            '*multifd-normal-page-ratio': 'uint8'} }
+            '*multifd-normal-page-ratio': 'uint8',
+            '*multifd-packet-size': 'uint64'} }
 
 ##
 # @query-migrate-parameters:
-- 
2.30.2


