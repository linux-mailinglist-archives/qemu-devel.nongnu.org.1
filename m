Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30585820E9B
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 22:23:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rK3G8-0001Hi-RX; Sun, 31 Dec 2023 16:22:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bryan.zhang@bytedance.com>)
 id 1rK2uq-00078F-Ei
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 16:00:12 -0500
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bryan.zhang@bytedance.com>)
 id 1rK2uo-0007O9-25
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 16:00:11 -0500
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6808c3938afso19386596d6.1
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 13:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704056408; x=1704661208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KFMYKbvGtBzN+tfuFjKDhZboY6Ude5pmCu0Q8MJ27FM=;
 b=kpgeYdSJoQiSEFFmMQZhgcuhEPCTji35t1g2FM2N2Ny0daFJTnaEs1KKLiCxplmql4
 17y8YFBBd0DRvGBD1v3OMoq2zDPU8soHAhMeNWM1YtQQDfX7tHA4RvnATfyWDIc5xb7e
 XODOY1SvEZQNr6PA+jAM2MM2uu5bSr18q55uma6SySaULcp2pg5uuwpkjRJQZEvMJcNL
 4L214ZR6ui3vMF0dHjF54W9GzBK9URlBR2PqIv6m5jUVPbAVGC7f/j6y6ksUlMrK8hgx
 uO0MBBgy5Zd1FXD+zoWeogbVUFgg5qTUGVi6ng2WaJdQI1AH5bqZsj5ghE1GRH0DuEmf
 QsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704056408; x=1704661208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KFMYKbvGtBzN+tfuFjKDhZboY6Ude5pmCu0Q8MJ27FM=;
 b=SrI7EgcUZgNlawhQTcV9OsEPw9Po10RD1L05KM/EeNmBhWouZlvW3zBdbu/0V7ZLCu
 8b18rjEsbCp7fCgAOYf1tnoMWhMA6PrkkrLlp5TMCvC3wGWE88HQ7d30QmbAO97D/4nJ
 K9B2F3TxdL0ySfYRYDkeO1NxEu6ih9a3S6T7H1z5GiNAhcof0Hf3yXrBbMAapXILV4cL
 afgu0CltM3OEe7mhQ8+paJfCNYkDZquKnBpYu7CCRlD9V/f9T/yOUh5JMrlr0WI0x/Rp
 v1TU+pDOD5S/y64yktmGRcWde2rBs+ATz03dxfk4NGADJHCDTHvbq9+qCyRUUxnJYNDZ
 +ACQ==
X-Gm-Message-State: AOJu0YyLRG4nImli57URP69XwSbtiIBsqOBw+9LnAinNdMXGtDeOk4Ul
 PgfXjNrnyKnl8cOqRUPvfPqRfnR5LgYQA48wNX7rmi1u8qk=
X-Google-Smtp-Source: AGHT+IHrg71Oi9EpoDk30amwO3unQ9XbCFWFyVd5iTewWYerQNTfM3pEStF0dnkzYWWBMZcAroYvhg==
X-Received: by 2002:a05:620a:1138:b0:781:33e3:ec1b with SMTP id
 p24-20020a05620a113800b0078133e3ec1bmr18330845qkk.18.1704056408286; 
 Sun, 31 Dec 2023 13:00:08 -0800 (PST)
Received: from n36-186-108.byted.org. ([147.160.184.90])
 by smtp.gmail.com with ESMTPSA id
 pb21-20020a05620a839500b007811da87cefsm8111750qkn.127.2023.12.31.13.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 13:00:07 -0800 (PST)
From: Bryan Zhang <bryan.zhang@bytedance.com>
To: qemu-devel@nongnu.org, farosas@suse.de, marcandre.lureau@redhat.com,
 peterx@redhat.com, quintela@redhat.com, peter.maydell@linaro.org,
 hao.xiang@bytedance.com
Cc: bryan.zhang@bytedance.com
Subject: [PATCH 2/5] migration: Add compression level parameter for QATzip
Date: Sun, 31 Dec 2023 20:58:01 +0000
Message-Id: <20231231205804.2366509-3-bryan.zhang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231231205804.2366509-1-bryan.zhang@bytedance.com>
References: <20231231205804.2366509-1-bryan.zhang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=bryan.zhang@bytedance.com; helo=mail-qv1-xf33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 31 Dec 2023 16:22:09 -0500
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

Adds support for a parameter to specify QATzip compression level. This
is a preparatory commit for a subsequent commit that will actually use
QATzip compression.

Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 migration/migration-hmp-cmds.c |  4 ++++
 migration/options.c            | 27 +++++++++++++++++++++++++++
 migration/options.h            |  1 +
 qapi/migration.json            | 19 ++++++++++++++++++-
 4 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 99710c8ffb..c3a8f1888d 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -628,6 +628,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_multifd_zlib_level = true;
         visit_type_uint8(v, param, &p->multifd_zlib_level, &err);
         break;
+    case MIGRATION_PARAMETER_MULTIFD_QATZIP_LEVEL:
+        p->has_multifd_qatzip_level = true;
+        visit_type_uint8(v, param, &p->multifd_qatzip_level, &err);
+        break;
     case MIGRATION_PARAMETER_MULTIFD_ZSTD_LEVEL:
         p->has_multifd_zstd_level = true;
         visit_type_uint8(v, param, &p->multifd_zstd_level, &err);
diff --git a/migration/options.c b/migration/options.c
index 8d8ec73ad9..4a931effae 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -62,6 +62,12 @@
 #define DEFAULT_MIGRATE_MULTIFD_COMPRESSION MULTIFD_COMPRESSION_NONE
 /* 0: means nocompress, 1: best speed, ... 9: best compress ratio */
 #define DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL 1
+/*
+ * 1: best speed, ... 9: best compress ratio
+ * There is some nuance here. Refer to QATzip documentation to understand
+ * the mapping of QATzip levels to standard deflate levels.
+ */
+#define DEFAULT_MIGRATE_MULTIFD_QATZIP_LEVEL 1
 /* 0: means nocompress, 1: best speed, ... 20: best compress ratio */
 #define DEFAULT_MIGRATE_MULTIFD_ZSTD_LEVEL 1
 
@@ -143,6 +149,9 @@ Property migration_properties[] = {
     DEFINE_PROP_UINT8("multifd-zlib-level", MigrationState,
                       parameters.multifd_zlib_level,
                       DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL),
+    DEFINE_PROP_UINT8("multifd-qatzip-level", MigrationState,
+                      parameters.multifd_qatzip_level,
+                      DEFAULT_MIGRATE_MULTIFD_QATZIP_LEVEL),
     DEFINE_PROP_UINT8("multifd-zstd-level", MigrationState,
                       parameters.multifd_zstd_level,
                       DEFAULT_MIGRATE_MULTIFD_ZSTD_LEVEL),
@@ -859,6 +868,13 @@ int migrate_multifd_zlib_level(void)
     return s->parameters.multifd_zlib_level;
 }
 
+int migrate_multifd_qatzip_level(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->parameters.multifd_qatzip_level;
+}
+
 int migrate_multifd_zstd_level(void)
 {
     MigrationState *s = migrate_get_current();
@@ -981,6 +997,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->multifd_compression = s->parameters.multifd_compression;
     params->has_multifd_zlib_level = true;
     params->multifd_zlib_level = s->parameters.multifd_zlib_level;
+    params->has_multifd_qatzip_level = true;
+    params->multifd_qatzip_level = s->parameters.multifd_qatzip_level;
     params->has_multifd_zstd_level = true;
     params->multifd_zstd_level = s->parameters.multifd_zstd_level;
     params->has_xbzrle_cache_size = true;
@@ -1036,6 +1054,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_multifd_channels = true;
     params->has_multifd_compression = true;
     params->has_multifd_zlib_level = true;
+    params->has_multifd_qatzip_level = true;
     params->has_multifd_zstd_level = true;
     params->has_xbzrle_cache_size = true;
     params->has_max_postcopy_bandwidth = true;
@@ -1145,6 +1164,14 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
         return false;
     }
 
+    if (params->has_multifd_qatzip_level &&
+        ((params->multifd_qatzip_level > 9) ||
+        (params->multifd_qatzip_level < 1))) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "multifd_qatzip_level",
+                   "a value between 1 and 9");
+        return false;
+    }
+
     if (params->has_multifd_zstd_level &&
         (params->multifd_zstd_level > 20)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "multifd_zstd_level",
diff --git a/migration/options.h b/migration/options.h
index 246c160aee..82707f34d0 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -87,6 +87,7 @@ MigMode migrate_mode(void);
 int migrate_multifd_channels(void);
 MultiFDCompression migrate_multifd_compression(void);
 int migrate_multifd_zlib_level(void);
+int migrate_multifd_qatzip_level(void);
 int migrate_multifd_zstd_level(void);
 uint8_t migrate_throttle_trigger_threshold(void);
 const char *migrate_tls_authz(void);
diff --git a/qapi/migration.json b/qapi/migration.json
index eb2f883513..6d5a4b0489 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -842,6 +842,11 @@
 #     speed, and 9 means best compression ratio which will consume
 #     more CPU. Defaults to 1. (Since 5.0)
 #
+# @multifd-qatzip-level: Set the compression level to be used in live
+#     migration. The level is an integer between 1 and 9, where 1 means
+#     the best compression speed, and 9 means the best compression
+#     ratio which will consume more CPU. Defaults to 1.
+#
 # @multifd-zstd-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 20,
 #     where 0 means no compression, 1 means the best compression
@@ -903,7 +908,7 @@
            'multifd-channels',
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
            'max-cpu-throttle', 'multifd-compression',
-           'multifd-zlib-level', 'multifd-zstd-level',
+           'multifd-zlib-level', 'multifd-qatzip-level', 'multifd-zstd-level',
            'block-bitmap-mapping',
            { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
            'vcpu-dirty-limit',
@@ -1030,6 +1035,11 @@
 #     speed, and 9 means best compression ratio which will consume
 #     more CPU. Defaults to 1. (Since 5.0)
 #
+# @multifd-qatzip-level: Set the compression level to be used in live
+#     migration. The level is an integer between 1 and 9, where 1 means
+#     the best compression speed, and 9 means the best compression
+#     ratio which will consume more CPU. Defaults to 1.
+#
 # @multifd-zstd-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 20,
 #     where 0 means no compression, 1 means the best compression
@@ -1110,6 +1120,7 @@
             '*max-cpu-throttle': 'uint8',
             '*multifd-compression': 'MultiFDCompression',
             '*multifd-zlib-level': 'uint8',
+            '*multifd-qatzip-level': 'uint8',
             '*multifd-zstd-level': 'uint8',
             '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
@@ -1258,6 +1269,11 @@
 #     speed, and 9 means best compression ratio which will consume
 #     more CPU. Defaults to 1. (Since 5.0)
 #
+# @multifd-qatzip-level: Set the compression level to be used in live
+#     migration. The level is an integer between 1 and 9, where 1 means
+#     the best compression speed, and 9 means the best compression
+#     ratio which will consume more CPU. Defaults to 1.
+#
 # @multifd-zstd-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 20,
 #     where 0 means no compression, 1 means the best compression
@@ -1335,6 +1351,7 @@
             '*max-cpu-throttle': 'uint8',
             '*multifd-compression': 'MultiFDCompression',
             '*multifd-zlib-level': 'uint8',
+            '*multifd-qatzip-level': 'uint8',
             '*multifd-zstd-level': 'uint8',
             '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
-- 
2.30.2


