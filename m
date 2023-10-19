Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A651F7D0354
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 22:49:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtZw7-0007Jz-Kj; Thu, 19 Oct 2023 16:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qtZvx-0007F9-8C
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 16:47:58 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qtZvt-0003SL-3W
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 16:47:56 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39JKiHE3019519; Thu, 19 Oct 2023 20:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=jyjZH7lnZYqjTB8ETp07/j47pckjaXH1CgbR4xTwVlM=;
 b=oxOYjra7l4s5sNiojXq+UrWK1nmTk2jcd+QmWnMe20QWF9XiPyOuG3ufI/OAyD6Z6p90
 gYLkSChlZsqWoNtJy6G5jsAiOJ9E/8Lrz4G0ASCs2nq9PE/2BArOf/r11oG5XZ92YolX
 rAjUYZsb1/HfPJ1acAsb4vR+I5139abHtXZdNDSPkfv4ZnEFksTXGpFsh7iXi9uAKDln
 REHwEA9JtGUWF21cYRT6/Dnc1cwBKXlRGerwPp0uM4XFhCl1HAc8UBDiS2nYUZn78/Ra
 H6ZZKiUZZwnH3Jy1AL3Rq9JXtQB5IcXcwhBkvOR8whbonGih5dak6riwHkHLUSC7YGfd +w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1d3q4d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Oct 2023 20:47:49 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39JJFmpJ040757; Thu, 19 Oct 2023 20:47:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3trfyqqahg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Oct 2023 20:47:49 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39JKllWI014514;
 Thu, 19 Oct 2023 20:47:48 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3trfyqqafy-2; Thu, 19 Oct 2023 20:47:48 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 1/4] migration: mode parameter
Date: Thu, 19 Oct 2023 13:47:43 -0700
Message-Id: <1697748466-373230-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1697748466-373230-1-git-send-email-steven.sistare@oracle.com>
References: <1697748466-373230-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_20,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190176
X-Proofpoint-GUID: tCcvPBVoOhN6Ng6u3FUj2lwDtJ61vZc9
X-Proofpoint-ORIG-GUID: tCcvPBVoOhN6Ng6u3FUj2lwDtJ61vZc9
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Create a mode migration parameter that can be used to select alternate
migration algorithms.  The default mode is normal, representing the
current migration algorithm, and does not need to be explicitly set.

No functional change until a new mode is added, except that the mode is
shown by the 'info migrate' command.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/core/qdev-properties-system.c    | 12 ++++++++++++
 include/hw/qdev-properties-system.h |  4 ++++
 include/migration/misc.h            |  1 +
 migration/migration-hmp-cmds.c      |  8 ++++++++
 migration/options.c                 | 21 +++++++++++++++++++++
 migration/options.h                 |  1 +
 qapi/migration.json                 | 27 ++++++++++++++++++++++++---
 7 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 6883406..c6fd430 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -673,6 +673,18 @@ const PropertyInfo qdev_prop_multifd_compression = {
     .set_default_value = qdev_propinfo_set_default_value_enum,
 };
 
+/* --- MigMode --- */
+
+const PropertyInfo qdev_prop_mig_mode = {
+    .name = "MigMode",
+    .description = "mig_mode values, "
+                   "normal/exec",
+    .enum_table = &MigMode_lookup,
+    .get = qdev_propinfo_get_enum,
+    .set = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
+};
+
 /* --- Reserved Region --- */
 
 /*
diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
index 0ac327a..1418801 100644
--- a/include/hw/qdev-properties-system.h
+++ b/include/hw/qdev-properties-system.h
@@ -7,6 +7,7 @@ extern const PropertyInfo qdev_prop_chr;
 extern const PropertyInfo qdev_prop_macaddr;
 extern const PropertyInfo qdev_prop_reserved_region;
 extern const PropertyInfo qdev_prop_multifd_compression;
+extern const PropertyInfo qdev_prop_mig_mode;
 extern const PropertyInfo qdev_prop_losttickpolicy;
 extern const PropertyInfo qdev_prop_blockdev_on_error;
 extern const PropertyInfo qdev_prop_bios_chs_trans;
@@ -41,6 +42,9 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
 #define DEFINE_PROP_MULTIFD_COMPRESSION(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_multifd_compression, \
                        MultiFDCompression)
+#define DEFINE_PROP_MIG_MODE(_n, _s, _f, _d) \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_mig_mode, \
+                       MigMode)
 #define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_losttickpolicy, \
                         LostTickPolicy)
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 673ac49..1bc8902 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -15,6 +15,7 @@
 #define MIGRATION_MISC_H
 
 #include "qemu/notify.h"
+#include "qapi/qapi-types-migration.h"
 #include "qapi/qapi-types-net.h"
 
 /* migration/ram.c */
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index a82597f..d8ad429 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -274,6 +274,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %" PRIu64 " ms\n",
             MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_STEP),
             params->announce_step);
+        assert(params->has_mode);
+        monitor_printf(mon, "%s: %s\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_MODE),
+            qapi_enum_lookup(&MigMode_lookup, params->mode));
         assert(params->has_compress_level);
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_COMPRESS_LEVEL),
@@ -514,6 +518,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
     }
 
     switch (val) {
+    case MIGRATION_PARAMETER_MODE:
+        p->has_mode = true;
+        visit_type_MigMode(v, param, &p->mode, &err);
+        break;
     case MIGRATION_PARAMETER_COMPRESS_LEVEL:
         p->has_compress_level = true;
         visit_type_uint8(v, param, &p->compress_level, &err);
diff --git a/migration/options.c b/migration/options.c
index 42fb818..4f26515 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -101,6 +101,9 @@ Property migration_properties[] = {
                      preempt_pre_7_2, false),
 
     /* Migration parameters */
+    DEFINE_PROP_MIG_MODE("mode", MigrationState,
+                      parameters.mode,
+                      MIG_MODE_NORMAL),
     DEFINE_PROP_UINT8("x-compress-level", MigrationState,
                       parameters.compress_level,
                       DEFAULT_MIGRATE_COMPRESS_LEVEL),
@@ -867,6 +870,13 @@ uint64_t migrate_xbzrle_cache_size(void)
     return s->parameters.xbzrle_cache_size;
 }
 
+MigMode migrate_mode(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->parameters.mode;
+}
+
 /* parameter setters */
 
 void migrate_set_block_incremental(bool value)
@@ -911,6 +921,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
 
     /* TODO use QAPI_CLONE() instead of duplicating it inline */
     params = g_malloc0(sizeof(*params));
+    params->has_mode = true;
+    params->mode = s->parameters.mode;
     params->has_compress_level = true;
     params->compress_level = s->parameters.compress_level;
     params->has_compress_threads = true;
@@ -985,6 +997,7 @@ void migrate_params_init(MigrationParameters *params)
     params->tls_creds = g_strdup("");
 
     /* Set has_* up only for parameter checks */
+    params->has_mode = true;
     params->has_compress_level = true;
     params->has_compress_threads = true;
     params->has_compress_wait_thread = true;
@@ -1206,6 +1219,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
 
     /* TODO use QAPI_CLONE() instead of duplicating it inline */
 
+    if (params->has_mode) {
+        dest->mode = params->mode;
+    }
+
     if (params->has_compress_level) {
         dest->compress_level = params->compress_level;
     }
@@ -1315,6 +1332,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
 
     /* TODO use QAPI_CLONE() instead of duplicating it inline */
 
+    if (params->has_mode) {
+        s->parameters.mode = params->mode;
+    }
+
     if (params->has_compress_level) {
         s->parameters.compress_level = params->compress_level;
     }
diff --git a/migration/options.h b/migration/options.h
index 237f2d6..d9ec873 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -92,6 +92,7 @@ const char *migrate_tls_authz(void);
 const char *migrate_tls_creds(void);
 const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
+MigMode migrate_mode(void);
 
 /* parameters setters */
 
diff --git a/qapi/migration.json b/qapi/migration.json
index db3df12..184fb78 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -616,6 +616,15 @@
             { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
 
 ##
+# @MigMode:
+#
+# @normal: the original form of migration. (since 8.2)
+#
+##
+{ 'enum': 'MigMode',
+  'data': [ 'normal' ] }
+
+##
 # @BitmapMigrationBitmapAliasTransform:
 #
 # @persistent: If present, the bitmap will be made persistent or
@@ -675,6 +684,9 @@
 #
 # Migration parameters enumeration
 #
+# @mode: Migration mode. See description in @MigMode. Default is 'normal'.
+#        (Since 8.2)
+#
 # @announce-initial: Initial delay (in milliseconds) before sending
 #     the first announce (Since 4.0)
 #
@@ -841,7 +853,8 @@
 # Since: 2.4
 ##
 { 'enum': 'MigrationParameter',
-  'data': ['announce-initial', 'announce-max',
+  'data': ['mode',
+           'announce-initial', 'announce-max',
            'announce-rounds', 'announce-step',
            'compress-level', 'compress-threads', 'decompress-threads',
            'compress-wait-thread', 'throttle-trigger-threshold',
@@ -862,6 +875,9 @@
 ##
 # @MigrateSetParameters:
 #
+# @mode: Migration mode. See description in @MigMode. Default is 'normal'.
+#        (Since 8.2)
+#
 # @announce-initial: Initial delay (in milliseconds) before sending
 #     the first announce (Since 4.0)
 #
@@ -1020,7 +1036,8 @@
 # Since: 2.4
 ##
 { 'struct': 'MigrateSetParameters',
-  'data': { '*announce-initial': 'size',
+  'data': { '*mode': 'MigMode',
+            '*announce-initial': 'size',
             '*announce-max': 'size',
             '*announce-rounds': 'size',
             '*announce-step': 'size',
@@ -1074,6 +1091,9 @@
 #
 # The optional members aren't actually optional.
 #
+# @mode: Migration mode. See description in @MigMode. Default is 'normal'.
+#        (Since 8.2)
+#
 # @announce-initial: Initial delay (in milliseconds) before sending
 #     the first announce (Since 4.0)
 #
@@ -1231,7 +1251,8 @@
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
-  'data': { '*announce-initial': 'size',
+  'data': { '*mode': 'MigMode',
+            '*announce-initial': 'size',
             '*announce-max': 'size',
             '*announce-rounds': 'size',
             '*announce-step': 'size',
-- 
1.8.3.1


