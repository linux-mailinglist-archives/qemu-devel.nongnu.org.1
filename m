Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 782357EAA34
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 06:43:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2mBT-0007F3-KV; Tue, 14 Nov 2023 00:41:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r2mBQ-0007Ed-OL
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 00:41:57 -0500
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r2mBO-0001TN-Pi
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 00:41:56 -0500
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-66d0f945893so43964976d6.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 21:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1699940514; x=1700545314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m1r1zQ1wix8p0/drY4otOIWoj+h39RPeRIVWFAAZ2w0=;
 b=L1YLAbCY+wJPH3pvwinhWkrroN79JbWaZ3rC1mvQ2RpEnzc2phaoYg6KgFhgSOB0sq
 Iup4Y8LdhUoQNeWbpRE82NyYnWEuIR09TaM1rHDrWnQ900zf9sJHHv9Mo0Ao0pwDF1TT
 dipYgtFkNyc595pSpWcrDWDHxxSM7ksLgan8a58BIFUTsQm7zFW2chKbDY8kwZYrDsLi
 /qo0QDUZy8c1xLXQziUgx7yf+jvXQSr9xFC8KmIdrzyGiS+j07qej+ykmfRmDNh/rQZq
 +2aSX8KAFMB+GoUz4ZoqV81NEBOcXawHS/C0Oz3oAkXkc0VzAvdOKhCVDpWKA3i0/61Y
 woAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699940514; x=1700545314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m1r1zQ1wix8p0/drY4otOIWoj+h39RPeRIVWFAAZ2w0=;
 b=vKxFoLDoepZqKI/PLnnrc2qhsHMX5jSHqAItjid62PXVdyenTk6psegi/yofrRhgOb
 yKZXinWlUnt6CRUI+A5g6XyU8zMZq84meKs0ROUasDzsj82YZuA2yIIOSRdmo0nZapBC
 TIHD/GMetyyxiyVAhxJMGRrHn8nCqxlCQrMemE/n1zMGhFomSFFImGzqbTxcOh5d3Z91
 DokAkRCAGhxW1lukrYSV7LS9m+lGju3RhwhyPbh8EJqr36/hBIXRAxbkvdRdEF4xhLR1
 XgQj93UInURmzCK0QmU5NExSdD1sWv1r2unhrYg0NFKincwBEZ4701Kgzoi7oCaTmp++
 mjPg==
X-Gm-Message-State: AOJu0YysG5R8mrI9J4s7Wlb3czcq15fnXq/6ZDSOuZuwc73IXsAVy3AZ
 LMb+mdvHZDLczRdcz1qoV3dyqw==
X-Google-Smtp-Source: AGHT+IE5GToIbmWtFNvhu174v4ELtJkJjQBCUe87f2CJRVfx+6QqJic7xymCXnSqWlVIY2IEA3Hk+Q==
X-Received: by 2002:a05:6214:2d01:b0:66d:670:d425 with SMTP id
 mz1-20020a0562142d0100b0066d0670d425mr2001134qvb.31.1699940513880; 
 Mon, 13 Nov 2023 21:41:53 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.104])
 by smtp.gmail.com with ESMTPSA id
 w2-20020a05620a094200b0077891d2d12dsm2400367qkw.43.2023.11.13.21.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 21:41:53 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: farosas@suse.de, peter.maydell@linaro.org, quintela@redhat.com,
 peterx@redhat.com, marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v2 12/20] migration/multifd: Add new migration option for
 multifd DSA offloading.
Date: Tue, 14 Nov 2023 05:40:24 +0000
Message-Id: <20231114054032.1192027-13-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231114054032.1192027-1-hao.xiang@bytedance.com>
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2f;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qv1-xf2f.google.com
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

multifd-dsa-accel="[dsa_dev_path1] ] [dsa_dev_path2] ... [dsa_dev_pathX]"

This feature is turned off by default.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 migration/migration-hmp-cmds.c |  8 ++++++++
 migration/options.c            | 28 ++++++++++++++++++++++++++++
 migration/options.h            |  1 +
 qapi/migration.json            | 17 ++++++++++++++---
 scripts/meson-buildoptions.sh  |  6 +++---
 5 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 86ae832176..d9451744dd 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -353,6 +353,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: '%s'\n",
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
             params->tls_authz);
+        monitor_printf(mon, "%s: %s\n",
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
index 97d121d4d7..6e424b5d63 100644
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
@@ -901,6 +903,13 @@ const char *migrate_tls_creds(void)
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
@@ -1025,6 +1034,7 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->vcpu_dirty_limit = s->parameters.vcpu_dirty_limit;
     params->has_mode = true;
     params->mode = s->parameters.mode;
+    params->multifd_dsa_accel = s->parameters.multifd_dsa_accel;
 
     return params;
 }
@@ -1033,6 +1043,7 @@ void migrate_params_init(MigrationParameters *params)
 {
     params->tls_hostname = g_strdup("");
     params->tls_creds = g_strdup("");
+    params->multifd_dsa_accel = g_strdup("");
 
     /* Set has_* up only for parameter checks */
     params->has_compress_level = true;
@@ -1362,6 +1373,11 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
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
@@ -1506,6 +1522,12 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_mode) {
         s->parameters.mode = params->mode;
     }
+
+    if (params->multifd_dsa_accel) {
+        g_free(s->parameters.multifd_dsa_accel);
+        assert(params->multifd_dsa_accel->type == QTYPE_QSTRING);
+        s->parameters.multifd_dsa_accel = g_strdup(params->multifd_dsa_accel->u.s);
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
@@ -1531,6 +1553,12 @@ void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
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
index 9783289bfc..a8e3b66d6f 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -879,6 +879,9 @@
 # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
 #        (Since 8.2)
 #
+# @multifd-dsa-accel: If enabled, use DSA accelerator offloading for
+#                     certain memory operations. (since 8.2)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -902,7 +905,7 @@
            'cpu-throttle-initial', 'cpu-throttle-increment',
            'cpu-throttle-tailslow',
            'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
-           'avail-switchover-bandwidth', 'downtime-limit',
+           'avail-switchover-bandwidth', 'downtime-limit', 'multifd-dsa-accel',
            { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
            { 'name': 'block-incremental', 'features': [ 'deprecated' ] },
            'multifd-channels',
@@ -1067,6 +1070,9 @@
 # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
 #        (Since 8.2)
 #
+# @multifd-dsa-accel: If enabled, use DSA accelerator offloading for
+#                     certain memory operations. (since 8.2)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -1120,7 +1126,8 @@
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
                                             'features': [ 'unstable' ] },
             '*vcpu-dirty-limit': 'uint64',
-            '*mode': 'MigMode'} }
+            '*mode': 'MigMode',
+            '*multifd-dsa-accel': 'StrOrNull'} }
 
 ##
 # @migrate-set-parameters:
@@ -1295,6 +1302,9 @@
 # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
 #        (Since 8.2)
 #
+# @multifd-dsa-accel: If enabled, use DSA accelerator offloading for
+#                     certain memory operations. (since 8.2)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -1345,7 +1355,8 @@
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
                                             'features': [ 'unstable' ] },
             '*vcpu-dirty-limit': 'uint64',
-            '*mode': 'MigMode'} }
+            '*mode': 'MigMode',
+            '*multifd-dsa-accel': 'str'} }
 
 ##
 # @query-migrate-parameters:
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index bf139e3fb4..35222ab63e 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -32,6 +32,7 @@ meson_options_help() {
   printf "%s\n" '  --enable-debug-stack-usage'
   printf "%s\n" '                           measure coroutine stack usage'
   printf "%s\n" '  --enable-debug-tcg       TCG debugging'
+  printf "%s\n" '  --enable-enqcmd          MENQCMD optimizations'
   printf "%s\n" '  --enable-fdt[=CHOICE]    Whether and how to find the libfdt library'
   printf "%s\n" '                           (choices: auto/disabled/enabled/internal/system)'
   printf "%s\n" '  --enable-fuzzing         build fuzzing targets'
@@ -93,7 +94,6 @@ meson_options_help() {
   printf "%s\n" '  avx2            AVX2 optimizations'
   printf "%s\n" '  avx512bw        AVX512BW optimizations'
   printf "%s\n" '  avx512f         AVX512F optimizations'
-  printf "%s\n" '  enqcmd          ENQCMD optimizations'
   printf "%s\n" '  blkio           libblkio block device driver'
   printf "%s\n" '  bochs           bochs image format support'
   printf "%s\n" '  bpf             eBPF support'
@@ -241,8 +241,6 @@ _meson_option_parse() {
     --disable-avx512bw) printf "%s" -Davx512bw=disabled ;;
     --enable-avx512f) printf "%s" -Davx512f=enabled ;;
     --disable-avx512f) printf "%s" -Davx512f=disabled ;;
-    --enable-enqcmd) printf "%s" -Denqcmd=true ;;
-    --disable-enqcmd) printf "%s" -Denqcmd=false ;;
     --enable-gcov) printf "%s" -Db_coverage=true ;;
     --disable-gcov) printf "%s" -Db_coverage=false ;;
     --enable-lto) printf "%s" -Db_lto=true ;;
@@ -309,6 +307,8 @@ _meson_option_parse() {
     --disable-docs) printf "%s" -Ddocs=disabled ;;
     --enable-dsound) printf "%s" -Ddsound=enabled ;;
     --disable-dsound) printf "%s" -Ddsound=disabled ;;
+    --enable-enqcmd) printf "%s" -Denqcmd=true ;;
+    --disable-enqcmd) printf "%s" -Denqcmd=false ;;
     --enable-fdt) printf "%s" -Dfdt=enabled ;;
     --disable-fdt) printf "%s" -Dfdt=disabled ;;
     --enable-fdt=*) quote_sh "-Dfdt=$2" ;;
-- 
2.30.2


