Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5D98239CF
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 01:47:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLBsE-0008PW-0C; Wed, 03 Jan 2024 19:46:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBrt-0008Ir-C7
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:45:58 -0500
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBrr-0007Ux-4E
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:45:52 -0500
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-781be0ccd30so2011985a.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 16:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704329150; x=1704933950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4zcvbuPRkd1v9O03CktODz85Vx0MyEaYslBBvtvwnD4=;
 b=K21UDL1evC0VjiMdghIqAa/LmxA8rkV71v8PoSP6YJ/op8tfX153zKDTJg91uRPpQR
 lrpVcM+k8Us94yGLpOd7WUkmMXPtOuXnEj9ePJBWTDquHuKHR9KSn1OxqdCpBx2QL/E1
 IUazsuAcTGJJsYaHyG5e3ju4U9yiGyBc83AhMdKWw7XyA2IwDEAYzbnPn9Usa0wgEFgL
 EGZI2dx/3v/9kwWqjJr3Qc8Zwr8/eN6arPTNiz/1rI6pDWKUzqrO+MFa7cqSnWaQ1p6i
 uRp485T71gpMEpaTjJzdcy/bI/TGVrxIzy75FoIOGab86KWyZwzPEK1kPh5Av0lsJ/4C
 JlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704329150; x=1704933950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4zcvbuPRkd1v9O03CktODz85Vx0MyEaYslBBvtvwnD4=;
 b=s+Udntp0H6ibqrAYVkh+tAohq67Z5RvHDOdCTxkm+ISdqoa9jqH+EY60fhfWXvnjjm
 q7ODUdYy9iFQxci2bkitAbc4H3I2YwbDW745o4x9U/b/Bvy1qBq43iSOf+zanNCqbiKe
 IoLipzrzXLxKCa7yQf4xKdecRPgKkmjWS+ktzzyQrzW9UfZJ4zL7hiUx01TKuU3OXVGc
 rIUHoSzxpMnJrLZkBoaLMsJjtd0Swrank1vyNnxsEw1tu4ZLGfKVDyyAMuSibQBEwFWC
 wqpFqQTyik+yjZ81ON6Oa9YosweMZlWa51I39dL/WpGe9HaM0Nz2TISKm0zqeaBJDFB5
 udfg==
X-Gm-Message-State: AOJu0YwUi+OncvWoWh0GbXZ/t2CH7Uj4oeh20OiBP7Tu6OD6N3zJDRHF
 5Ttgeo7y27XXLCjipVb3BCjAGVpTLlSA6w==
X-Google-Smtp-Source: AGHT+IEJe9Dz9UdY2zFkadFu1W73sgzK0JtCp/3uFQ5/qLEVJGDnTRGbx/n9WKkGIeZh+wTZWrQ8Kg==
X-Received: by 2002:a05:620a:1362:b0:781:5efd:403b with SMTP id
 d2-20020a05620a136200b007815efd403bmr14689077qkl.13.1704329150292; 
 Wed, 03 Jan 2024 16:45:50 -0800 (PST)
Received: from n231-230-216.byted.org ([147.160.184.87])
 by smtp.gmail.com with ESMTPSA id
 x19-20020ae9f813000000b0077d66e5b2e6sm10646087qkh.3.2024.01.03.16.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 16:45:49 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: farosas@suse.de, peter.maydell@linaro.org, peterx@redhat.com,
 marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v3 15/20] migration/multifd: Add test hook to set normal page
 ratio.
Date: Thu,  4 Jan 2024 00:44:47 +0000
Message-Id: <20240104004452.324068-16-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240104004452.324068-1-hao.xiang@bytedance.com>
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x72e.google.com
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

Multifd sender thread performs zero page checking. If a page is
a zero page, only the page's metadata is sent to the receiver.
If a page is a normal page, the entire page's content is sent to
the receiver. This change adds a test hook to set the normal page
ratio. A zero page will be forced to be sent as a normal page. This
is useful for live migration performance analysis and optimization.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 migration/options.c | 32 ++++++++++++++++++++++++++++++++
 migration/options.h |  1 +
 qapi/migration.json | 18 +++++++++++++++---
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index b5f69031a9..aceb391338 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -79,6 +79,11 @@
 #define DEFAULT_MIGRATE_ANNOUNCE_ROUNDS    5
 #define DEFAULT_MIGRATE_ANNOUNCE_STEP    100
 
+/*
+ * Parameter for multifd normal page test hook.
+ */
+#define DEFAULT_MIGRATE_MULTIFD_NORMAL_PAGE_RATIO 101
+
 #define DEFINE_PROP_MIG_CAP(name, x)             \
     DEFINE_PROP_BOOL(name, MigrationState, capabilities[x], false)
 
@@ -181,6 +186,9 @@ Property migration_properties[] = {
                       MIG_MODE_NORMAL),
     DEFINE_PROP_STRING("multifd-dsa-accel", MigrationState,
                        parameters.multifd_dsa_accel),
+    DEFINE_PROP_UINT8("multifd-normal-page-ratio", MigrationState,
+                      parameters.multifd_normal_page_ratio,
+                      DEFAULT_MIGRATE_MULTIFD_NORMAL_PAGE_RATIO),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -862,6 +870,12 @@ int migrate_multifd_channels(void)
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
@@ -1261,6 +1275,14 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
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
 
@@ -1381,6 +1403,11 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
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
@@ -1532,6 +1559,11 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
         s->parameters.multifd_dsa_accel =
             g_strdup(params->multifd_dsa_accel->u.s);
     }
+
+    if (params->has_multifd_normal_page_ratio) {
+        s->parameters.multifd_normal_page_ratio =
+            params->multifd_normal_page_ratio;
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
diff --git a/migration/options.h b/migration/options.h
index 56100961a9..21e3e7b0cf 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -95,6 +95,7 @@ const char *migrate_tls_creds(void);
 const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
 const char *migrate_multifd_dsa_accel(void);
+uint8_t migrate_multifd_normal_page_ratio(void);
 
 /* parameters setters */
 
diff --git a/qapi/migration.json b/qapi/migration.json
index 74465bc821..dedcdd076a 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -885,6 +885,9 @@
 #     characters. Setting this string to an empty string means disabling
 #     DSA accelerator offloading. Defaults to an empty string. (since 8.2)
 #
+# @multifd-normal-page-ratio: Test hook setting the normal page ratio.
+#     (Since 8.2)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -918,7 +921,8 @@
            'block-bitmap-mapping',
            { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
            'vcpu-dirty-limit',
-           'mode'] }
+           'mode',
+           'multifd-normal-page-ratio'] }
 
 ##
 # @MigrateSetParameters:
@@ -1079,6 +1083,9 @@
 #     characters. Setting this string to an empty string means disabling
 #     DSA accelerator offloading. Defaults to an empty string. (since 8.2)
 #
+# @multifd-normal-page-ratio: Test hook setting the normal page ratio.
+#     (Since 8.2)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -1133,7 +1140,8 @@
                                             'features': [ 'unstable' ] },
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
-            '*multifd-dsa-accel': 'StrOrNull'} }
+            '*multifd-dsa-accel': 'StrOrNull',
+            '*multifd-normal-page-ratio': 'uint8'} }
 
 ##
 # @migrate-set-parameters:
@@ -1314,6 +1322,9 @@
 #     characters. Setting this string to an empty string means disabling
 #     DSA accelerator offloading. Defaults to an empty string. (since 8.2)
 #
+# @multifd-normal-page-ratio: Test hook setting the normal page ratio.
+#     (Since 8.2)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -1365,7 +1376,8 @@
                                             'features': [ 'unstable' ] },
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
-            '*multifd-dsa-accel': 'str'} }
+            '*multifd-dsa-accel': 'str',
+            '*multifd-normal-page-ratio': 'uint8'} }
 
 ##
 # @query-migrate-parameters:
-- 
2.30.2


