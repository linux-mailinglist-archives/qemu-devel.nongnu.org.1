Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5108239D2
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 01:47:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLBs5-0008L5-Uy; Wed, 03 Jan 2024 19:46:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBs1-0008JZ-Nx
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:46:02 -0500
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBrt-0007VJ-Dq
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:45:55 -0500
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-78104f6f692so74509885a.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 16:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704329152; x=1704933952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vZRlIjhhISfiTz2PoTJ+Q54Z2iN+C/amao7oXcJmFBs=;
 b=I1SVAGqe/JqWEBsyzBLRS9X+Hf9dNRDYR3+tUmXcPQDMcgdLWzPmkJSx34Jd1gj+Xu
 VBNYRAxrtf4HaITcscHk+ZU4JLtNYDV/9fJq3v4oQ5J5+iL/KfX8O28K8w1JixSqMnWn
 5rOqawkptiWTkP7Bbyzj3PQKPMGlwoJg5eIedn3lSp5LqhA//2sUCDzBYpVqgOmvPFPf
 tC4im2G8AL7h7WeMuiiBu1+DeUeyoOThbeV4fmn6iYAd9lkEJ5coYdY9AZNMF82pHofv
 OfQ1Y55HkVYncPyjlU8b5gvuPCbFFQkkggSikEcsy7TZrA1Xs7SY/XjOacz9iUK3l2d4
 CNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704329152; x=1704933952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vZRlIjhhISfiTz2PoTJ+Q54Z2iN+C/amao7oXcJmFBs=;
 b=n15GbMQlPSVBECiKStqchPstnTmr/gMDfVPsI87xET3Bvsw+RYqmL9RTA/O7ySaexu
 89Cyr3sOYDCkLc980s52Q4s7SqAAh3J/7mUp144Jvb3sgMl54133zcB0YVMrCEXuiErR
 8EADJrJPATya2S0bo5vahn4cvENNfooDBSt+JJqkVjef03jD3fLTKUQCO1BFuCN66tNs
 j9RL9lDhGGSeTv5AWgyQ9ntWdF8h+im77L4p3aZ6AM1c3SylM4GUJ4zgV++NWMubS9B8
 ikPRkR15IAtCnCJbgQ67u+JL9ePMA7wLUJOqfMyNUmDd/otOQwwSIHxzMJmJ1/eqGHT9
 ZFoQ==
X-Gm-Message-State: AOJu0Yzhbgsl63lz8r9FASQwmbhJkjmES6AnV/zFdu06GpazidBF9mJD
 6GEwSBwPPYrOnBIpCQvVDBH9gbKY3Fb4+8lK4jrUqddQsp0=
X-Google-Smtp-Source: AGHT+IGsZZQaR5NZs1/FFzeGJln/0XziW7751TnULnC533zzqkq5PTlWhpQrLzub3WVDvISOOSPmPw==
X-Received: by 2002:a05:620a:4508:b0:781:68b0:6054 with SMTP id
 t8-20020a05620a450800b0078168b06054mr3091069qkp.16.1704329152387; 
 Wed, 03 Jan 2024 16:45:52 -0800 (PST)
Received: from n231-230-216.byted.org ([147.160.184.87])
 by smtp.gmail.com with ESMTPSA id
 x19-20020ae9f813000000b0077d66e5b2e6sm10646087qkh.3.2024.01.03.16.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 16:45:51 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: farosas@suse.de, peter.maydell@linaro.org, peterx@redhat.com,
 marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v3 17/20] migration/multifd: Add migration option set packet
 size.
Date: Thu,  4 Jan 2024 00:44:49 +0000
Message-Id: <20240104004452.324068-18-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240104004452.324068-1-hao.xiang@bytedance.com>
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x734.google.com
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
 migration/options.c | 36 ++++++++++++++++++++++++++++++++++++
 migration/options.h |  1 +
 qapi/migration.json | 21 ++++++++++++++++++---
 3 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index aceb391338..fafdeb69cd 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -84,6 +84,12 @@
  */
 #define DEFAULT_MIGRATE_MULTIFD_NORMAL_PAGE_RATIO 101
 
+/*
+ * Parameter for multifd packet size.
+ */
+#define DEFAULT_MIGRATE_MULTIFD_PACKET_SIZE (128 * 4 * 1024)
+#define MAX_MIGRATE_MULTIFD_PACKET_SIZE (1023 * 4 * 1024)
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
@@ -876,6 +885,13 @@ uint8_t migrate_multifd_normal_page_ratio(void)
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
@@ -1014,6 +1030,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
     params->has_block_incremental = true;
     params->block_incremental = s->parameters.block_incremental;
+    params->has_multifd_packet_size = true;
+    params->multifd_packet_size = s->parameters.multifd_packet_size;
     params->has_multifd_channels = true;
     params->multifd_channels = s->parameters.multifd_channels;
     params->has_multifd_compression = true;
@@ -1075,6 +1093,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_downtime_limit = true;
     params->has_x_checkpoint_delay = true;
     params->has_block_incremental = true;
+    params->has_multifd_packet_size = true;
     params->has_multifd_channels = true;
     params->has_multifd_compression = true;
     params->has_multifd_zlib_level = true;
@@ -1173,6 +1192,17 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 
     /* x_checkpoint_delay is now always positive */
 
+    if (params->has_multifd_packet_size &&
+        ((params->multifd_packet_size < DEFAULT_MIGRATE_MULTIFD_PACKET_SIZE) ||
+            (params->multifd_packet_size >  MAX_MIGRATE_MULTIFD_PACKET_SIZE) ||
+            (params->multifd_packet_size % qemu_target_page_size() != 0))) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                    "multifd_packet_size",
+                    "a value between 524288 and 4190208, "
+                    "must be a multiple of guest VM's page size.");
+        return false;
+    }
+
     if (params->has_multifd_channels && (params->multifd_channels < 1)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "multifd_channels",
@@ -1354,6 +1384,9 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_block_incremental) {
         dest->block_incremental = params->block_incremental;
     }
+    if (params->has_multifd_packet_size) {
+        dest->multifd_packet_size = params->multifd_packet_size;
+    }
     if (params->has_multifd_channels) {
         dest->multifd_channels = params->multifd_channels;
     }
@@ -1499,6 +1532,9 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
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
index dedcdd076a..354f10a83f 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -888,6 +888,10 @@
 # @multifd-normal-page-ratio: Test hook setting the normal page ratio.
 #     (Since 8.2)
 #
+# @multifd-packet-size: Packet size in bytes used to migrate data.
+#     The value needs to be a multiple of guest VM's page size.
+#     The default value is 524288 and max value is 4190208. (Since 8.2)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -922,7 +926,8 @@
            { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
            'vcpu-dirty-limit',
            'mode',
-           'multifd-normal-page-ratio'] }
+           'multifd-normal-page-ratio',
+           'multifd-packet-size'] }
 
 ##
 # @MigrateSetParameters:
@@ -1086,6 +1091,10 @@
 # @multifd-normal-page-ratio: Test hook setting the normal page ratio.
 #     (Since 8.2)
 #
+# @multifd-packet-size: Packet size in bytes used to migrate data.
+#     The value needs to be a multiple of guest VM's page size.
+#     The default value is 524288 and max value is 4190208. (Since 8.2)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -1141,7 +1150,8 @@
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
             '*multifd-dsa-accel': 'StrOrNull',
-            '*multifd-normal-page-ratio': 'uint8'} }
+            '*multifd-normal-page-ratio': 'uint8',
+            '*multifd-packet-size' : 'uint64'} }
 
 ##
 # @migrate-set-parameters:
@@ -1325,6 +1335,10 @@
 # @multifd-normal-page-ratio: Test hook setting the normal page ratio.
 #     (Since 8.2)
 #
+# @multifd-packet-size: Packet size in bytes used to migrate data.
+#     The value needs to be a multiple of guest VM's page size.
+#     The default value is 524288 and max value is 4190208. (Since 8.2)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -1377,7 +1391,8 @@
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


