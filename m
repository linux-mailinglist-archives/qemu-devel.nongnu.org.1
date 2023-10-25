Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B7F7D748C
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 21:41:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvjjF-0000tT-UZ; Wed, 25 Oct 2023 15:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1qvjjE-0000t0-Ca
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:39:44 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1qvjjC-00069l-Je
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:39:44 -0400
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-773ac11de71so9318085a.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 12:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1698262781; x=1698867581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d4qo/1HDAGbTl7YFYPmhgxCLUMeNwG2LmT3ZjuOoSZM=;
 b=Eix6CKPj7oNbdUjL5W8FhAGtWFewD3ZFmfbhhe5sn4S+tIHE2KJU9+//YV1L9SFrN1
 C9NT4R+jrmK9gQq6QO19mOvE/BZiYJiwGEfJ+bNRl5/SFWWz3g4NWvmgUuqxN4RTEQNL
 HGus0VuktBaWLJQB8FWDCWtU3NO0SZpHEYHDSEU86Nd0fYfJS2YkhWL9ryzIMhKI5tB9
 hOs6a71nVdqWNxrBfgbrRqIxnITMer8uS+mQpwh6eqvaR0lPF5cI/ASZCgSvri7x8g4O
 G0728R3KF3bbpFirPpxni/yQZVocgOS8BsX8cQMLkR47i6rROBM8yC8ujS07OYHScgjc
 wTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698262781; x=1698867581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d4qo/1HDAGbTl7YFYPmhgxCLUMeNwG2LmT3ZjuOoSZM=;
 b=szvgKmtNLBxuoF7MJIUI9l1AbrQX6z5Lm3MLoIl5vidXc/PDcc8Wv86Fit4p/1lq8h
 P+AKbAz8VsFg7v0Va2fn8UVlK4gGG1vVMdpEgmq4j4o4LDot9B3+s0COTApLatfZBkwy
 DMqAndlM90VJyO2puD4l8BmxI6FNf1yrewsDDBppBTO1nrFeZjHQQA/Ubd6N2cyWVImT
 JpMYWodzYi1u3248hLJN6WJPZ93L+N+lFHe8eXDtsMZjzSzPT1MRITz6guDGyutN7bhB
 YZ0Kll80j/OQMPQbjTJ6sSV9ocLBOSDc4YPXSd42ZxaJ71bUM4K/j/g5BwBudhm4hUZV
 O/zw==
X-Gm-Message-State: AOJu0YzhXSZVJX30MsWcMDEUP3of9MvBklwn6eVen8aTrw+p1OcMtXAp
 k2Sn6TyL1GcjCmo0HqVGAlM2UQ==
X-Google-Smtp-Source: AGHT+IEPVmB6zKMO8XVS9qAQ4BC+UrrA7xlMwwY2CYozoz4DV6iIiqNh+14Izk3RWQejYtQc8zseiQ==
X-Received: by 2002:a05:620a:8c91:b0:774:500:a18e with SMTP id
 ra17-20020a05620a8c9100b007740500a18emr13554836qkn.75.1698262781723; 
 Wed, 25 Oct 2023 12:39:41 -0700 (PDT)
Received: from n231-230-216.byted.org ([147.160.184.135])
 by smtp.gmail.com with ESMTPSA id
 o8-20020a05620a228800b0076cdc3b5beasm4453721qkh.86.2023.10.25.12.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 12:39:41 -0700 (PDT)
From: Hao Xiang <hao.xiang@bytedance.com>
To: quintela@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com,
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH 09/16] migration/multifd: Add new migration option for multifd
 DSA offloading.
Date: Wed, 25 Oct 2023 19:38:15 +0000
Message-Id: <20231025193822.2813204-10-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231025193822.2813204-1-hao.xiang@bytedance.com>
References: <20231025193822.2813204-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x72e.google.com
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

Intel DSA offloading is an optional feature that turns on if
proper hardware and software stack is available. To turn on
DSA offloading in multifd live migration:

multifd-dsa-accel="[dsa_dev_path1] ] [dsa_dev_path2] ... [dsa_dev_pathX]"

This feature is turned off by default.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 migration/migration-hmp-cmds.c |  8 ++++++++
 migration/options.c            | 28 ++++++++++++++++++++++++++++
 migration/options.h            |  1 +
 qapi/migration.json            | 17 ++++++++++++++---
 4 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 5b25ba24f7..bdffe9e023 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -348,6 +348,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: '%s'\n",
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
             params->tls_authz);
+        monitor_printf(mon, "%s: %s\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_DSA_ACCEL),
+            params->multifd_dsa_accel);
 
         if (params->has_block_bitmap_mapping) {
             const BitmapMigrationNodeAliasList *bmnal;
@@ -586,6 +589,11 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
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
index 12b1c4dd71..6a3a78a626 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -173,6 +173,8 @@ Property migration_properties[] = {
     DEFINE_PROP_UINT64("vcpu-dirty-limit", MigrationState,
                        parameters.vcpu_dirty_limit,
                        DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT),
+    DEFINE_PROP_STRING("multifd-dsa-accel", MigrationState,
+                       parameters.multifd_dsa_accel),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -849,6 +851,13 @@ const char *migrate_tls_creds(void)
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
@@ -969,6 +978,7 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->x_vcpu_dirty_limit_period = s->parameters.x_vcpu_dirty_limit_period;
     params->has_vcpu_dirty_limit = true;
     params->vcpu_dirty_limit = s->parameters.vcpu_dirty_limit;
+    params->multifd_dsa_accel = s->parameters.multifd_dsa_accel;
 
     return params;
 }
@@ -977,6 +987,7 @@ void migrate_params_init(MigrationParameters *params)
 {
     params->tls_hostname = g_strdup("");
     params->tls_creds = g_strdup("");
+    params->multifd_dsa_accel = g_strdup("");
 
     /* Set has_* up only for parameter checks */
     params->has_compress_level = true;
@@ -1288,6 +1299,11 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_vcpu_dirty_limit) {
         dest->vcpu_dirty_limit = params->vcpu_dirty_limit;
     }
+
+    if (params->multifd_dsa_accel) {
+        assert(params->multifd_dsa_accel->type == QTYPE_QSTRING);
+        dest->multifd_dsa_accel = params->multifd_dsa_accel->u.s;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1414,6 +1430,12 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_vcpu_dirty_limit) {
         s->parameters.vcpu_dirty_limit = params->vcpu_dirty_limit;
     }
+
+    if (params->multifd_dsa_accel) {
+        g_free(s->parameters.multifd_dsa_accel);
+        assert(params->multifd_dsa_accel->type == QTYPE_QSTRING);
+        s->parameters.multifd_dsa_accel = g_strdup(params->multifd_dsa_accel->u.s);
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
@@ -1439,6 +1461,12 @@ void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
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
index c663f637fd..f757835b4a 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -91,6 +91,7 @@ const char *migrate_tls_authz(void);
 const char *migrate_tls_creds(void);
 const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
+const char *migrate_multifd_dsa_accel(void);
 
 /* parameters setters */
 
diff --git a/qapi/migration.json b/qapi/migration.json
index 3a99fe34d8..201f58527e 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -829,6 +829,9 @@
 # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
 #     Defaults to 1.  (Since 8.1)
 #
+# @multifd-dsa-accel: If enabled, use DSA accelerator offloading for
+#                     certain memory operations. (since 8.1)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
@@ -844,7 +847,7 @@
            'cpu-throttle-initial', 'cpu-throttle-increment',
            'cpu-throttle-tailslow',
            'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
-           'downtime-limit',
+           'downtime-limit', 'multifd-dsa-accel',
            { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
            'block-incremental',
            'multifd-channels',
@@ -995,6 +998,9 @@
 # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
 #     Defaults to 1.  (Since 8.1)
 #
+# @multifd-dsa-accel: If enabled, use DSA accelerator offloading for
+#                     certain memory operations. (since 8.1)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
@@ -1036,7 +1042,8 @@
             '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
                                             'features': [ 'unstable' ] },
-            '*vcpu-dirty-limit': 'uint64'} }
+            '*vcpu-dirty-limit': 'uint64',
+            '*multifd-dsa-accel': 'StrOrNull'} }
 
 ##
 # @migrate-set-parameters:
@@ -1198,6 +1205,9 @@
 # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
 #     Defaults to 1.  (Since 8.1)
 #
+# @multifd-dsa-accel: If enabled, use DSA accelerator offloading for
+#                     certain memory operations. (since 8.1)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
@@ -1236,7 +1246,8 @@
             '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
                                             'features': [ 'unstable' ] },
-            '*vcpu-dirty-limit': 'uint64'} }
+            '*vcpu-dirty-limit': 'uint64',
+            '*multifd-dsa-accel': 'str'} }
 
 ##
 # @query-migrate-parameters:
-- 
2.30.2


