Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE73A7EAA2E
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 06:43:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2mBs-0007Ik-3i; Tue, 14 Nov 2023 00:42:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r2mBj-0007Hb-QU
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 00:42:15 -0500
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r2mBh-0001Zq-VB
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 00:42:15 -0500
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-778927f2dd3so268558485a.2
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 21:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1699940530; x=1700545330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9eRnueSlb3meh0xpvGzA55C2FuUJkOMX0kEcQV57/8g=;
 b=JV3AoPqqMAd8OLh+EcEic7h6rcxxN9C9lpd0/zBokXkg/OyWt0vqXD/atT2ojnB8VI
 wuHwKtLNsynFdcj9dR578ontssKymyozhRlNSEaBS1BnTg1n61xh4T8k/DcK9thkKpgD
 6qIqzkos6Zx26SAo1b72mbl2zCSHL8/XJbAYWWXj+FVhuqZF7wR395kETdNo93x6VBZx
 FSnlHEPRdqYbHiOYL0GiDK+rC5bMazKK8oD9sLYOTH0+gy614zuZBzrLaPr23a23dHnt
 +TaDucZ/2C4IXMXUHxb9pAOv3pqrYziIq/20xBNvzihQX5EzRZHLHEu65Rkyt8ng395w
 R1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699940530; x=1700545330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9eRnueSlb3meh0xpvGzA55C2FuUJkOMX0kEcQV57/8g=;
 b=DsNOOIlD12wvD3AW9hgE5nkJTJ/0y5M5d2p6aWhaH3qUi2gsICGw1MAK721EtAw3tV
 Ui5Dz9MmiQWPYITKzWv1bUfKyTGdOog79wAGANocrCVw+iuxY9sgaI1Jpo2896Czv0eF
 F00EARuKmYxreGL5TH4am2AdNFMuNkB8wbWsudiGE4QUmT3JVv7QpME2aa/skA+RWBUY
 O8COABqOyUQjTJqArA19ncTEDb4QocW4o5knCWgE/CrzF7T3nERnP+KYSO+9vdq74YRs
 uASn8YxkGS92ZocmuvMcMv7p4orqN2/kL64xMK4VaO7CxIF5KQGAJCO0CIomzOKJmoWq
 m9+A==
X-Gm-Message-State: AOJu0YwoBhlH7JsLO0paseXK3lUdnrrY6YjdWwVNZUYVLonONTJVS54X
 U0wQZZYVAkPCm/7xQuJSvbEnxQ==
X-Google-Smtp-Source: AGHT+IFb5lLi69yrlJWJHpQ/LAxsW7J87H+jbc+ggOeNXz8V9gh5HwY4kTwcOo5i5arK+KHj2RQV9g==
X-Received: by 2002:a05:620a:46aa:b0:775:9f9d:2c36 with SMTP id
 bq42-20020a05620a46aa00b007759f9d2c36mr1505356qkb.54.1699940530456; 
 Mon, 13 Nov 2023 21:42:10 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.104])
 by smtp.gmail.com with ESMTPSA id
 w2-20020a05620a094200b0077891d2d12dsm2400367qkw.43.2023.11.13.21.42.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 21:42:10 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: farosas@suse.de, peter.maydell@linaro.org, quintela@redhat.com,
 peterx@redhat.com, marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v2 17/20] migration/multifd: Add migration option set packet
 size.
Date: Tue, 14 Nov 2023 05:40:29 +0000
Message-Id: <20231114054032.1192027-18-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231114054032.1192027-1-hao.xiang@bytedance.com>
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x72d.google.com
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

The current multifd packet size is 128 * 4kb. This change adds
an option to set the packet size. Both sender and receiver needs
to set the same packet size for things to work.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 migration/options.c | 34 ++++++++++++++++++++++++++++++++++
 migration/options.h |  1 +
 qapi/migration.json | 21 ++++++++++++++++++---
 3 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index e7f1e2df24..81f1bf25d4 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -84,6 +84,12 @@
  */
 #define DEFAULT_MIGRATE_MULTIFD_NORMAL_PAGE_RATIO 101
 
+/*
+ * Parameter for multifd packet size.
+ */
+#define DEFAULT_MIGRATE_MULTIFD_PACKET_SIZE 128
+#define MAX_MIGRATE_MULTIFD_PACKET_SIZE 1024
+
 #define DEFINE_PROP_MIG_CAP(name, x)             \
     DEFINE_PROP_BOOL(name, MigrationState, capabilities[x], false)
 
@@ -189,6 +195,9 @@ Property migration_properties[] = {
     DEFINE_PROP_UINT8("multifd-normal-page-ratio", MigrationState,
                       parameters.multifd_normal_page_ratio,
                       DEFAULT_MIGRATE_MULTIFD_NORMAL_PAGE_RATIO),
+    DEFINE_PROP_SIZE("multifd-packet-size", MigrationState,
+                     parameters.multifd_packet_size,
+                     DEFAULT_MIGRATE_MULTIFD_PACKET_SIZE),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -874,6 +883,13 @@ uint8_t migrate_multifd_normal_page_ratio(void)
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
@@ -1012,6 +1028,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
     params->has_block_incremental = true;
     params->block_incremental = s->parameters.block_incremental;
+    params->has_multifd_packet_size = true;
+    params->multifd_packet_size = s->parameters.multifd_packet_size;
     params->has_multifd_channels = true;
     params->multifd_channels = s->parameters.multifd_channels;
     params->has_multifd_compression = true;
@@ -1072,6 +1090,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_downtime_limit = true;
     params->has_x_checkpoint_delay = true;
     params->has_block_incremental = true;
+    params->has_multifd_packet_size = true;
     params->has_multifd_channels = true;
     params->has_multifd_compression = true;
     params->has_multifd_zlib_level = true;
@@ -1170,6 +1189,15 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 
     /* x_checkpoint_delay is now always positive */
 
+    if (params->has_multifd_packet_size &&
+        ((params->multifd_packet_size < DEFAULT_MIGRATE_MULTIFD_PACKET_SIZE) ||
+            (params->multifd_packet_size >  MAX_MIGRATE_MULTIFD_PACKET_SIZE))) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                    "multifd_packet_size",
+                    "a value between 128 and 1024");
+        return false;
+    }
+
     if (params->has_multifd_channels && (params->multifd_channels < 1)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "multifd_channels",
@@ -1351,6 +1379,9 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_block_incremental) {
         dest->block_incremental = params->block_incremental;
     }
+    if (params->has_multifd_packet_size) {
+        dest->multifd_packet_size = params->multifd_packet_size;
+    }
     if (params->has_multifd_channels) {
         dest->multifd_channels = params->multifd_channels;
     }
@@ -1496,6 +1527,9 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
                     " use blockdev-mirror with NBD instead");
         s->parameters.block_incremental = params->block_incremental;
     }
+    if (params->has_multifd_packet_size) {
+        s->parameters.multifd_packet_size = params->multifd_packet_size;
+    }
     if (params->has_multifd_channels) {
         s->parameters.multifd_channels = params->multifd_channels;
     }
diff --git a/migration/options.h b/migration/options.h
index 21e3e7b0cf..5816f6dac2 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -96,6 +96,7 @@ const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
 const char *migrate_multifd_dsa_accel(void);
 uint8_t migrate_multifd_normal_page_ratio(void);
+uint64_t migrate_multifd_packet_size(void);
 
 /* parameters setters */
 
diff --git a/qapi/migration.json b/qapi/migration.json
index bb876c8325..f87daddf33 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -885,6 +885,10 @@
 # @multifd-normal-page-ratio: Test hook setting the normal page ratio.
 #     (Since 8.2)
 #
+# @multifd-packet-size: Packet size used to migrate data. This value
+#     indicates the number of pages in a packet. The default value
+#     is 128 and max value is 1024. (Since 8.2)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -919,7 +923,8 @@
            { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
            'vcpu-dirty-limit',
            'mode',
-           'multifd-normal-page-ratio'] }
+           'multifd-normal-page-ratio',
+           'multifd-packet-size'] }
 
 ##
 # @MigrateSetParameters:
@@ -1080,6 +1085,10 @@
 # @multifd-normal-page-ratio: Test hook setting the normal page ratio.
 #     (Since 8.2)
 #
+# @multifd-packet-size: Packet size used to migrate data. This value
+#     indicates the number of pages in a packet. The default value
+#     is 128 and max value is 1024. (Since 8.2)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -1135,7 +1144,8 @@
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
             '*multifd-dsa-accel': 'StrOrNull',
-            '*multifd-normal-page-ratio': 'uint8'} }
+            '*multifd-normal-page-ratio': 'uint8',
+            '*multifd-packet-size' : 'uint64'} }
 
 ##
 # @migrate-set-parameters:
@@ -1316,6 +1326,10 @@
 # @multifd-normal-page-ratio: Test hook setting the normal page ratio.
 #     (Since 8.2)
 #
+# @multifd-packet-size: Packet size used to migrate data. This value
+#     indicates the number of pages in a packet. The default value
+#     is 128 and max value is 1024. (Since 8.2)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -1368,7 +1382,8 @@
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
             '*multifd-dsa-accel': 'str',
-            '*multifd-normal-page-ratio': 'uint8'} }
+            '*multifd-normal-page-ratio': 'uint8',
+            '*multifd-packet-size': 'uint64'} }
 
 ##
 # @query-migrate-parameters:
-- 
2.30.2


