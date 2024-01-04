Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E508239DE
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 01:50:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLBs4-0008Kp-Gd; Wed, 03 Jan 2024 19:46:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBrq-0008Hf-CR
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:45:51 -0500
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBro-0007TY-9D
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:45:50 -0500
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-67ff241c2bcso11816d6.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 16:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704329147; x=1704933947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KpA/Kj66rISFQ/iHtkD7zXF8SxLl+/TJ5O3hi3eQFdo=;
 b=H3MObuQ9DJFjlsPkAUtIjzebELDBgWLJbpyGCOlaySurAg329xWJ/fOkbPqVpPFMj6
 J6sXk0Wh96Yk8l3XFDRr4PVUPogzVPltnOCz1MhOWg58T2bO7lyftsgRH4kHddAigiOH
 AKf9oiJhWSJLGIAQiUklCcxdWOS4d6LQeDgI1BwXH3NVRqum11Bnq2c8C//ZXsNJ8qg5
 L0bAJ8zIFqqm6WGvIfnHsprOAAK0A28uTLEMu6cyp/mPleIxS/8bVOinPzsbiM7Xv9rq
 KIZkJWMe37ApuReZ+/wCA8jvipJwwNSmPEq9NvevNipBdThfU/05ZWiGHxgaMsYQvrQE
 8ljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704329147; x=1704933947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KpA/Kj66rISFQ/iHtkD7zXF8SxLl+/TJ5O3hi3eQFdo=;
 b=O6ACLSAZq/Kqhbjn0A1ODyg9oEt6ziDiD2h2HML3YSF1b8+BYbwk4AIp13GiKHNbfz
 XpBPJYzZc0c/nC95gCoSFrY+FkG6XcNU6s8CKZ0X8vlKw8pFymciIIGWj9dfgcZkZq/d
 /bTPY7D1PB3KNhnfSR4cgVm1ShhyDnrQyTV2kmp1Z3Mmlns+FW+u6pflTAgoKFQHvxSC
 7d175Tcgox+B6ewxKW/U+pzF7klsvE7gAoezRZL0x3pB5WUiDlr6rKESJuBnx6wC9VE1
 HKhgFqirECQZkH7fFGiZj8TggVN0UtaAQxunTokvbRg2/fKK8+QcuXKMUOMlI3015crw
 94KQ==
X-Gm-Message-State: AOJu0YzCg/6KURRLGrsv2m+aJ2pr6o/S39AP4GsiP2a2+selVFNlJZ6R
 oF/fwrnUXBO+yT9ttx1wKKdYdc6vc+7u9g==
X-Google-Smtp-Source: AGHT+IGsQA9kH+au0DUSHnYs3/9oSqfusxwYvlH4I8TNshkQxKpa9T//gY+Jgvk4kW6ofCGI5GxxHQ==
X-Received: by 2002:ad4:5d42:0:b0:67f:8107:12a7 with SMTP id
 jk2-20020ad45d42000000b0067f810712a7mr38956044qvb.31.1704329147384; 
 Wed, 03 Jan 2024 16:45:47 -0800 (PST)
Received: from n231-230-216.byted.org ([147.160.184.87])
 by smtp.gmail.com with ESMTPSA id
 x19-20020ae9f813000000b0077d66e5b2e6sm10646087qkh.3.2024.01.03.16.45.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 16:45:47 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: farosas@suse.de, peter.maydell@linaro.org, peterx@redhat.com,
 marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v3 12/20] migration/multifd: Add new migration option for
 multifd DSA offloading.
Date: Thu,  4 Jan 2024 00:44:44 +0000
Message-Id: <20240104004452.324068-13-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240104004452.324068-1-hao.xiang@bytedance.com>
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f36;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qv1-xf36.google.com
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

Intel DSA offloading is an optional feature that turns on if
proper hardware and software stack is available. To turn on
DSA offloading in multifd live migration:

multifd-dsa-accel="[dsa_dev_path1] [dsa_dev_path2] ... [dsa_dev_pathX]"

This feature is turned off by default.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 migration/migration-hmp-cmds.c |  8 ++++++++
 migration/options.c            | 30 ++++++++++++++++++++++++++++++
 migration/options.h            |  1 +
 qapi/migration.json            | 26 +++++++++++++++++++++++---
 4 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 99710c8ffb..761d6d54de 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -353,6 +353,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: '%s'\n",
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
             params->tls_authz);
+        monitor_printf(mon, "%s: '%s'\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_DSA_ACCEL),
+            params->multifd_dsa_accel);
 
         if (params->has_block_bitmap_mapping) {
             const BitmapMigrationNodeAliasList *bmnal;
@@ -615,6 +618,11 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_block_incremental = true;
         visit_type_bool(v, param, &p->block_incremental, &err);
         break;
+    case MIGRATION_PARAMETER_MULTIFD_DSA_ACCEL:
+        p->multifd_dsa_accel = g_new0(StrOrNull, 1);
+        p->multifd_dsa_accel->type = QTYPE_QSTRING;
+        visit_type_str(v, param, &p->multifd_dsa_accel->u.s, &err);
+        break;
     case MIGRATION_PARAMETER_MULTIFD_CHANNELS:
         p->has_multifd_channels = true;
         visit_type_uint8(v, param, &p->multifd_channels, &err);
diff --git a/migration/options.c b/migration/options.c
index 180698a8f5..b5f69031a9 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -179,6 +179,8 @@ Property migration_properties[] = {
     DEFINE_PROP_MIG_MODE("mode", MigrationState,
                       parameters.mode,
                       MIG_MODE_NORMAL),
+    DEFINE_PROP_STRING("multifd-dsa-accel", MigrationState,
+                       parameters.multifd_dsa_accel),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -903,6 +905,13 @@ const char *migrate_tls_creds(void)
     return s->parameters.tls_creds;
 }
 
+const char *migrate_multifd_dsa_accel(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->parameters.multifd_dsa_accel;
+}
+
 const char *migrate_tls_hostname(void)
 {
     MigrationState *s = migrate_get_current();
@@ -1027,6 +1036,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->vcpu_dirty_limit = s->parameters.vcpu_dirty_limit;
     params->has_mode = true;
     params->mode = s->parameters.mode;
+    params->multifd_dsa_accel = g_strdup(s->parameters.multifd_dsa_accel ?
+                                         s->parameters.multifd_dsa_accel : "");
 
     return params;
 }
@@ -1035,6 +1046,7 @@ void migrate_params_init(MigrationParameters *params)
 {
     params->tls_hostname = g_strdup("");
     params->tls_creds = g_strdup("");
+    params->multifd_dsa_accel = g_strdup("");
 
     /* Set has_* up only for parameter checks */
     params->has_compress_level = true;
@@ -1364,6 +1376,11 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_mode) {
         dest->mode = params->mode;
     }
+
+    if (params->multifd_dsa_accel) {
+        assert(params->multifd_dsa_accel->type == QTYPE_QSTRING);
+        dest->multifd_dsa_accel = params->multifd_dsa_accel->u.s;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1508,6 +1525,13 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_mode) {
         s->parameters.mode = params->mode;
     }
+
+    if (params->multifd_dsa_accel) {
+        g_free(s->parameters.multifd_dsa_accel);
+        assert(params->multifd_dsa_accel->type == QTYPE_QSTRING);
+        s->parameters.multifd_dsa_accel =
+            g_strdup(params->multifd_dsa_accel->u.s);
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
@@ -1533,6 +1557,12 @@ void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
         params->tls_authz->type = QTYPE_QSTRING;
         params->tls_authz->u.s = strdup("");
     }
+    if (params->multifd_dsa_accel
+        && params->multifd_dsa_accel->type == QTYPE_QNULL) {
+        qobject_unref(params->multifd_dsa_accel->u.n);
+        params->multifd_dsa_accel->type = QTYPE_QSTRING;
+        params->multifd_dsa_accel->u.s = strdup("");
+    }
 
     migrate_params_test_apply(params, &tmp);
 
diff --git a/migration/options.h b/migration/options.h
index c901eb57c6..56100961a9 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -94,6 +94,7 @@ const char *migrate_tls_authz(void);
 const char *migrate_tls_creds(void);
 const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
+const char *migrate_multifd_dsa_accel(void);
 
 /* parameters setters */
 
diff --git a/qapi/migration.json b/qapi/migration.json
index 4c7a42e364..74465bc821 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -879,6 +879,12 @@
 # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
 #        (Since 8.2)
 #
+# @multifd-dsa-accel: If enabled, use DSA accelerator offloading for
+#     certain memory operations. Enable DSA accelerator offloading by
+#     setting this string to a list of DSA device path separated by space
+#     characters. Setting this string to an empty string means disabling
+#     DSA accelerator offloading. Defaults to an empty string. (since 8.2)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -902,7 +908,7 @@
            'cpu-throttle-initial', 'cpu-throttle-increment',
            'cpu-throttle-tailslow',
            'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
-           'avail-switchover-bandwidth', 'downtime-limit',
+           'avail-switchover-bandwidth', 'downtime-limit', 'multifd-dsa-accel',
            { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
            { 'name': 'block-incremental', 'features': [ 'deprecated' ] },
            'multifd-channels',
@@ -1067,6 +1073,12 @@
 # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
 #        (Since 8.2)
 #
+# @multifd-dsa-accel: If enabled, use DSA accelerator offloading for
+#     certain memory operations. Enable DSA accelerator offloading by
+#     setting this string to a list of DSA device path separated by space
+#     characters. Setting this string to an empty string means disabling
+#     DSA accelerator offloading. Defaults to an empty string. (since 8.2)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -1120,7 +1132,8 @@
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
                                             'features': [ 'unstable' ] },
             '*vcpu-dirty-limit': 'uint64',
-            '*mode': 'MigMode'} }
+            '*mode': 'MigMode',
+            '*multifd-dsa-accel': 'StrOrNull'} }
 
 ##
 # @migrate-set-parameters:
@@ -1295,6 +1308,12 @@
 # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
 #        (Since 8.2)
 #
+# @multifd-dsa-accel: If enabled, use DSA accelerator offloading for
+#     certain memory operations. Enable DSA accelerator offloading by
+#     setting this string to a list of DSA device path separated by space
+#     characters. Setting this string to an empty string means disabling
+#     DSA accelerator offloading. Defaults to an empty string. (since 8.2)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -1345,7 +1364,8 @@
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
                                             'features': [ 'unstable' ] },
             '*vcpu-dirty-limit': 'uint64',
-            '*mode': 'MigMode'} }
+            '*mode': 'MigMode',
+            '*multifd-dsa-accel': 'str'} }
 
 ##
 # @query-migrate-parameters:
-- 
2.30.2


