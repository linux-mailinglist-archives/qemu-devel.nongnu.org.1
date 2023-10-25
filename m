Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A08A7D7492
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 21:41:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvjjL-0000wd-EQ; Wed, 25 Oct 2023 15:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1qvjjI-0000uB-Lm
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:39:48 -0400
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1qvjjG-0006At-Th
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:39:48 -0400
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-77774120c6eso9831885a.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 12:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1698262786; x=1698867586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qrHVfcJmjwWlckvc+ypGZtCAWYmRlr+54BSzc+Ljn00=;
 b=B/rlKsomehtl8tjaB10HZbeRiSqpJwRdKFPmJGllCCfSz5qtaDDrCbi4LuSEF7XynT
 S4kkivLPF51c2TYfvkiSWtz6X0T8CMjjWjp49ncisC1VqmWXJe6eKGC2jKVHiC9s1SNi
 Z0ihPetkMXoiCBFDpS/XNt32LlWjm2BS9mRumbeUCM1oDH0fxSKgPzfX3t4lzyv6kGoH
 VWVgPz2+iElIDyxv9wjcxkQw0hNyIC2XeJBEDWDYhss64OxIFUupPAUS4g1WLmrpHLSv
 qmiVGXAL4fmnj/xy3/QMNaQPwsMjErN3XA3/t8/DXq3SraCO4qXFbqGTfWqBlB4zTZk9
 Kt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698262786; x=1698867586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qrHVfcJmjwWlckvc+ypGZtCAWYmRlr+54BSzc+Ljn00=;
 b=dcUfYMARhijh8UvlBlXU18EnL2izP7jEHW8c+Ci/rjO88xNlP3JcUUT/TRdnFDqYSW
 24X1UM0l8Hg0T+adunlJENH9mGde60DEessh5VaJA98oMMwnQEh/4XGlXTiyaDG7LlMl
 zjoVxJmR+o6xC6xeiTXJh9SZ78iROT69DubPTDUOEYGq++mUNzVDTcUGpYOqAqX3VdE9
 JDbeAsFZQ3ASM5qGN8gAVLrQZT/xgzS1Z2eN5RHTDN8QIMb5Xeq/WBMsSc+YiuiQ7ppx
 MlW8GigTjPnfzTMv0MM0Wyy7nXa9y3wVozazW1eyQQtB8nh6qYGtVemuyn1rKyTW8Awq
 Ix8Q==
X-Gm-Message-State: AOJu0YzeIcJy4f1vZb6bkij7vojgbcs8at7eg6wNqpln4B41YGtLZeC1
 7ZcBBwLZx8D0xM6xKqu4BhaUag==
X-Google-Smtp-Source: AGHT+IGYiQso/p/7QMMXhIIYHzqKQKgvqU1zvOVf6Gxv6pnpJUJYoZpN2Atny0R/J24w3gril4+KOQ==
X-Received: by 2002:a05:620a:f01:b0:770:fc39:25e4 with SMTP id
 v1-20020a05620a0f0100b00770fc3925e4mr17741343qkl.45.1698262785953; 
 Wed, 25 Oct 2023 12:39:45 -0700 (PDT)
Received: from n231-230-216.byted.org ([147.160.184.135])
 by smtp.gmail.com with ESMTPSA id
 o8-20020a05620a228800b0076cdc3b5beasm4453721qkh.86.2023.10.25.12.39.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 12:39:45 -0700 (PDT)
From: Hao Xiang <hao.xiang@bytedance.com>
To: quintela@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com,
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH 11/16] migration/multifd: Add test hook to set normal page
 ratio.
Date: Wed, 25 Oct 2023 19:38:17 +0000
Message-Id: <20231025193822.2813204-12-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231025193822.2813204-1-hao.xiang@bytedance.com>
References: <20231025193822.2813204-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x735.google.com
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

Multifd sender thread performs zero page checking. If a page is
a zero page, only the page's metadata is sent to the receiver.
If a page is a normal page, the entire page's content is sent to
the receiver. This change adds a test hook to set the normal page
ratio. A zero page will be forced to be sent as a normal page. This
is useful for live migration performance analysis and optimization.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 migration/options.c | 31 +++++++++++++++++++++++++++++++
 migration/options.h |  1 +
 qapi/migration.json | 17 ++++++++++++++---
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 6a3a78a626..9ee0ad5d89 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -78,6 +78,11 @@
 #define DEFAULT_MIGRATE_ANNOUNCE_ROUNDS    5
 #define DEFAULT_MIGRATE_ANNOUNCE_STEP    100
 
+/*
+ * Parameter for multifd normal page test hook.
+ */
+#define DEFAULT_MIGRATE_MULTIFD_NORMAL_PAGE_RATIO 101
+
 #define DEFINE_PROP_MIG_CAP(name, x)             \
     DEFINE_PROP_BOOL(name, MigrationState, capabilities[x], false)
 
@@ -175,6 +180,9 @@ Property migration_properties[] = {
                        DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT),
     DEFINE_PROP_STRING("multifd-dsa-accel", MigrationState,
                        parameters.multifd_dsa_accel),
+    DEFINE_PROP_UINT8("multifd-normal-page-ratio", MigrationState,
+                      parameters.multifd_normal_page_ratio,
+                      DEFAULT_MIGRATE_MULTIFD_NORMAL_PAGE_RATIO),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -808,6 +816,12 @@ int migrate_multifd_channels(void)
     return s->parameters.multifd_channels;
 }
 
+uint8_t migrate_multifd_normal_page_ratio(void)
+{
+    MigrationState *s = migrate_get_current();
+    return s->parameters.multifd_normal_page_ratio;
+}
+
 MultiFDCompression migrate_multifd_compression(void)
 {
     MigrationState *s = migrate_get_current();
@@ -1192,6 +1206,14 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
         return false;
     }
 
+    if (params->has_multifd_normal_page_ratio &&
+        params->multifd_normal_page_ratio > 100) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "multifd_normal_page_ratio",
+                   "a value between 0 and 100");
+        return false;
+    }
+
     return true;
 }
 
@@ -1304,6 +1326,11 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
         assert(params->multifd_dsa_accel->type == QTYPE_QSTRING);
         dest->multifd_dsa_accel = params->multifd_dsa_accel->u.s;
     }
+
+    if (params->has_multifd_normal_page_ratio) {
+        dest->has_multifd_normal_page_ratio = true;
+        dest->multifd_normal_page_ratio = params->multifd_normal_page_ratio;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1436,6 +1463,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
         assert(params->multifd_dsa_accel->type == QTYPE_QSTRING);
         s->parameters.multifd_dsa_accel = g_strdup(params->multifd_dsa_accel->u.s);
     }
+
+    if (params->has_multifd_normal_page_ratio) {
+        s->parameters.multifd_normal_page_ratio = params->multifd_normal_page_ratio;
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
diff --git a/migration/options.h b/migration/options.h
index f757835b4a..dafb09d6ea 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -92,6 +92,7 @@ const char *migrate_tls_creds(void);
 const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
 const char *migrate_multifd_dsa_accel(void);
+uint8_t migrate_multifd_normal_page_ratio(void);
 
 /* parameters setters */
 
diff --git a/qapi/migration.json b/qapi/migration.json
index 201f58527e..a667527081 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -832,6 +832,9 @@
 # @multifd-dsa-accel: If enabled, use DSA accelerator offloading for
 #                     certain memory operations. (since 8.1)
 #
+# @multifd-normal-page-ratio: Test hook setting the normal page ratio.
+#     (Since 8.1)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
@@ -856,7 +859,7 @@
            'multifd-zlib-level', 'multifd-zstd-level',
            'block-bitmap-mapping',
            { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
-           'vcpu-dirty-limit'] }
+           'vcpu-dirty-limit', 'multifd-normal-page-ratio'] }
 
 ##
 # @MigrateSetParameters:
@@ -1001,6 +1004,9 @@
 # @multifd-dsa-accel: If enabled, use DSA accelerator offloading for
 #                     certain memory operations. (since 8.1)
 #
+# @multifd-normal-page-ratio: Test hook setting the normal page ratio.
+#     (Since 8.1)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
@@ -1043,7 +1049,8 @@
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
                                             'features': [ 'unstable' ] },
             '*vcpu-dirty-limit': 'uint64',
-            '*multifd-dsa-accel': 'StrOrNull'} }
+            '*multifd-dsa-accel': 'StrOrNull',
+            '*multifd-normal-page-ratio': 'uint8'} }
 
 ##
 # @migrate-set-parameters:
@@ -1208,6 +1215,9 @@
 # @multifd-dsa-accel: If enabled, use DSA accelerator offloading for
 #                     certain memory operations. (since 8.1)
 #
+# @multifd-normal-page-ratio: Test hook setting the normal page ratio.
+#     (Since 8.1)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
@@ -1247,7 +1257,8 @@
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
                                             'features': [ 'unstable' ] },
             '*vcpu-dirty-limit': 'uint64',
-            '*multifd-dsa-accel': 'str'} }
+            '*multifd-dsa-accel': 'str',
+            '*multifd-normal-page-ratio': 'uint8'} }
 
 ##
 # @query-migrate-parameters:
-- 
2.30.2


