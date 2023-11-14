Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B35567EAA39
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 06:44:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2mBn-0007Io-Jr; Tue, 14 Nov 2023 00:42:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r2mBV-0007Fy-Lc
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 00:42:03 -0500
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r2mBT-0001U3-UH
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 00:42:01 -0500
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7789a4c01ddso346439085a.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 21:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1699940519; x=1700545319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UC/+IR5Y7dIjrKdVazsg+msPhpgomaB++LU+9G8M++8=;
 b=YmfmMnqpEgzggjOjnb2yoyOWMIIfigoQCiPuLQIsUyiDkMe/fLx9MsQUX7nF/7+x0j
 YDC2pZc/lLQtJaH4In79G/4VuxxCUenVziCPnaT+cwK95qIcZyuDQlSK4Ie9a8YslX+s
 6xaX29hZurDn3Z2jrffgXLWqhTDd4HJovmG+j38ZK5n0s1HXAy4BA9PqZpbedMvjCdnw
 Nt4MOVkgaFFrb09qPHlHA3PtxUhZ5g5fAMxxuPiy3lX4zmYX/C3ePrZRK3RluhroWLtI
 kSpKawVyceJsekjwb3r8qkKF6PhkyJvdDkghRijZYBn8FQJtEErB3ih+v0ebPJYsdo/p
 OfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699940519; x=1700545319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UC/+IR5Y7dIjrKdVazsg+msPhpgomaB++LU+9G8M++8=;
 b=WF1F/3xiKtzvA3X01ir1mRsD8BVgjEqspAcuVIRmmHWul84vOJu5MNAR1E3qF9xo75
 kogzA12nMNxi7oW0bhj+d34Otc63bnLce/quYFCIUCme1mC1yAipPVojVxXtBEZYnas4
 S8APRcu8vDdacsX5bVisswmpKyXfICXtbOYnjc03T5zRjDbiQhlLQnAWPrQTeL8TJ3pb
 0KkLbtkbGWWApQGRWZ/efWz2/ibN2WazSsvozOwO6wphl3DTdNX2twJuJQgVY6A1NlTO
 7fBxSAie6JITRqtXQHW0eXzUkZ1MB1It4ocgVJEWWXR3SbfFDN9hM0e9oau8v74zkDi5
 6QoQ==
X-Gm-Message-State: AOJu0YwV7gAsUbbJia2eWgv4tk/LPgvcgmHAAf5YrzkH0ER4Kf1fAYmV
 VJZieTmlkHOjlBSBChKFXKtwPw==
X-Google-Smtp-Source: AGHT+IGBzP24lWpYXIa/JTY78ljFJlV021h5ohwVPYqsIhmF/i4pSWOcFdAzLFj5FkNx+ddOIzu3Iw==
X-Received: by 2002:a05:620a:9493:b0:77a:605:d693 with SMTP id
 sn19-20020a05620a949300b0077a0605d693mr959550qkn.22.1699940518794; 
 Mon, 13 Nov 2023 21:41:58 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.104])
 by smtp.gmail.com with ESMTPSA id
 w2-20020a05620a094200b0077891d2d12dsm2400367qkw.43.2023.11.13.21.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 21:41:58 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: farosas@suse.de, peter.maydell@linaro.org, quintela@redhat.com,
 peterx@redhat.com, marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v2 15/20] migration/multifd: Add test hook to set normal page
 ratio.
Date: Tue, 14 Nov 2023 05:40:27 +0000
Message-Id: <20231114054032.1192027-16-hao.xiang@bytedance.com>
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
 qapi/migration.json | 18 +++++++++++++++---
 3 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 6e424b5d63..e7f1e2df24 100644
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
@@ -860,6 +868,12 @@ int migrate_multifd_channels(void)
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
@@ -1258,6 +1272,14 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
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
 
@@ -1378,6 +1400,11 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
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
@@ -1528,6 +1555,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
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
index a8e3b66d6f..bb876c8325 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -882,6 +882,9 @@
 # @multifd-dsa-accel: If enabled, use DSA accelerator offloading for
 #                     certain memory operations. (since 8.2)
 #
+# @multifd-normal-page-ratio: Test hook setting the normal page ratio.
+#     (Since 8.2)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -915,7 +918,8 @@
            'block-bitmap-mapping',
            { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
            'vcpu-dirty-limit',
-           'mode'] }
+           'mode',
+           'multifd-normal-page-ratio'] }
 
 ##
 # @MigrateSetParameters:
@@ -1073,6 +1077,9 @@
 # @multifd-dsa-accel: If enabled, use DSA accelerator offloading for
 #                     certain memory operations. (since 8.2)
 #
+# @multifd-normal-page-ratio: Test hook setting the normal page ratio.
+#     (Since 8.2)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -1127,7 +1134,8 @@
                                             'features': [ 'unstable' ] },
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
-            '*multifd-dsa-accel': 'StrOrNull'} }
+            '*multifd-dsa-accel': 'StrOrNull',
+            '*multifd-normal-page-ratio': 'uint8'} }
 
 ##
 # @migrate-set-parameters:
@@ -1305,6 +1313,9 @@
 # @multifd-dsa-accel: If enabled, use DSA accelerator offloading for
 #                     certain memory operations. (since 8.2)
 #
+# @multifd-normal-page-ratio: Test hook setting the normal page ratio.
+#     (Since 8.2)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -1356,7 +1367,8 @@
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


