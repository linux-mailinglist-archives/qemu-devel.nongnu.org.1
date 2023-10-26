Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E41E37D897C
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 22:09:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw6ew-0004FC-85; Thu, 26 Oct 2023 16:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qw6es-0004CN-2V
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 16:08:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qw6el-0008S8-56
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 16:08:44 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39QJsblH023580; Thu, 26 Oct 2023 20:08:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=AvsPNs2nKBgjZO8o7etnM9p3prd+ESnf6kjTqDI2cA4=;
 b=jYbehM/uA20ravcwohhvESaYBrWyfGp/sAg4PtCpbbaPYx8o+GfbSag02Rc6WUynNnYE
 odL+cFe5mrqeLt+wK4Xg6yRhq05f07ceMa31XXDLGV+QCttEUJubGqBTWQvdqM1PKQAS
 vc1/ZR63TEWvNnjurS7+RWv7vjJbJJWQW8WrvurMjfpCD/Z/znwcPf7iW8nw909OBv1l
 CX9A0iMsEEQQjtH1cDPU5Vo4Z4Q4l441xjl8tSLJyGh1awYX+yH7LUfd7jLcYFWYB9Ry
 KSui9O6cTCRKvOS63EkC6EsXmtSetg5AYKd7lPfzO0Dz+iPxFq1eCMOfV9kwbLcClnVL 5Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tywtb84uw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Oct 2023 20:08:36 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39QImeQs008549; Thu, 26 Oct 2023 20:08:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3tywqhtymc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Oct 2023 20:08:35 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39QK8YLn036361;
 Thu, 26 Oct 2023 20:08:34 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3tywqhtykn-2; Thu, 26 Oct 2023 20:08:34 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 1/6] migration: mode parameter
Date: Thu, 26 Oct 2023 13:08:28 -0700
Message-Id: <1698350913-415926-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1698350913-415926-1-git-send-email-steven.sistare@oracle.com>
References: <1698350913-415926-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_19,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310260174
X-Proofpoint-ORIG-GUID: wv6x8ceIiZdSkDgr0fBE8O8wqEUrRMPY
X-Proofpoint-GUID: wv6x8ceIiZdSkDgr0fBE8O8wqEUrRMPY
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
 hw/core/qdev-properties-system.c    | 14 ++++++++++++++
 include/hw/qdev-properties-system.h |  4 ++++
 include/migration/misc.h            |  1 +
 migration/migration-hmp-cmds.c      |  9 +++++++++
 migration/options.c                 | 21 +++++++++++++++++++++
 migration/options.h                 |  1 +
 qapi/migration.json                 | 27 ++++++++++++++++++++++++---
 7 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 6883406..07a848d 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -673,6 +673,20 @@ const PropertyInfo qdev_prop_multifd_compression = {
     .set_default_value = qdev_propinfo_set_default_value_enum,
 };
 
+/* --- MigMode --- */
+
+QEMU_BUILD_BUG_ON(sizeof(MigMode) != sizeof(int));
+
+const PropertyInfo qdev_prop_mig_mode = {
+    .name = "MigMode",
+    .description = "mig_mode values, "
+                   "normal",
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
index a82597f..35e57b8 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -387,6 +387,11 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %" PRIu64 " MB/s\n",
             MigrationParameter_str(MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT),
             params->vcpu_dirty_limit);
+
+        assert(params->has_mode);
+        monitor_printf(mon, "%s: %s\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_MODE),
+            qapi_enum_lookup(&MigMode_lookup, params->mode));
     }
 
     qapi_free_MigrationParameters(params);
@@ -661,6 +666,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_vcpu_dirty_limit = true;
         visit_type_size(v, param, &p->vcpu_dirty_limit, &err);
         break;
+    case MIGRATION_PARAMETER_MODE:
+        p->has_mode = true;
+        visit_type_MigMode(v, param, &p->mode, &err);
+        break;
     default:
         assert(0);
     }
diff --git a/migration/options.c b/migration/options.c
index 42fb818..cbede3f 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -175,6 +175,9 @@ Property migration_properties[] = {
     DEFINE_PROP_UINT64("vcpu-dirty-limit", MigrationState,
                        parameters.vcpu_dirty_limit,
                        DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT),
+    DEFINE_PROP_MIG_MODE("mode", MigrationState,
+                      parameters.mode,
+                      MIG_MODE_NORMAL),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -803,6 +806,13 @@ uint64_t migrate_max_postcopy_bandwidth(void)
     return s->parameters.max_postcopy_bandwidth;
 }
 
+MigMode migrate_mode(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->parameters.mode;
+}
+
 int migrate_multifd_channels(void)
 {
     MigrationState *s = migrate_get_current();
@@ -975,6 +985,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->x_vcpu_dirty_limit_period = s->parameters.x_vcpu_dirty_limit_period;
     params->has_vcpu_dirty_limit = true;
     params->vcpu_dirty_limit = s->parameters.vcpu_dirty_limit;
+    params->has_mode = true;
+    params->mode = s->parameters.mode;
 
     return params;
 }
@@ -1010,6 +1022,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_announce_step = true;
     params->has_x_vcpu_dirty_limit_period = true;
     params->has_vcpu_dirty_limit = true;
+    params->has_mode = true;
 }
 
 /*
@@ -1307,6 +1320,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_vcpu_dirty_limit) {
         dest->vcpu_dirty_limit = params->vcpu_dirty_limit;
     }
+
+    if (params->has_mode) {
+        dest->mode = params->mode;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1437,6 +1454,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_vcpu_dirty_limit) {
         s->parameters.vcpu_dirty_limit = params->vcpu_dirty_limit;
     }
+
+    if (params->has_mode) {
+        s->parameters.mode = params->mode;
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
diff --git a/migration/options.h b/migration/options.h
index 237f2d6..246c160 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -83,6 +83,7 @@ uint8_t migrate_max_cpu_throttle(void);
 uint64_t migrate_max_bandwidth(void);
 uint64_t migrate_avail_switchover_bandwidth(void);
 uint64_t migrate_max_postcopy_bandwidth(void);
+MigMode migrate_mode(void);
 int migrate_multifd_channels(void);
 MultiFDCompression migrate_multifd_compression(void);
 int migrate_multifd_zlib_level(void);
diff --git a/qapi/migration.json b/qapi/migration.json
index db3df12..f99904e 100644
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
@@ -833,6 +842,9 @@
 # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
 #     Defaults to 1.  (Since 8.1)
 #
+# @mode: Migration mode. See description in @MigMode. Default is 'normal'.
+#        (Since 8.2)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
@@ -857,7 +869,8 @@
            'multifd-zlib-level', 'multifd-zstd-level',
            'block-bitmap-mapping',
            { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
-           'vcpu-dirty-limit'] }
+           'vcpu-dirty-limit',
+           'mode'] }
 
 ##
 # @MigrateSetParameters:
@@ -1009,6 +1022,9 @@
 # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
 #     Defaults to 1.  (Since 8.1)
 #
+# @mode: Migration mode. See description in @MigMode. Default is 'normal'.
+#        (Since 8.2)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
@@ -1051,7 +1067,8 @@
             '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
                                             'features': [ 'unstable' ] },
-            '*vcpu-dirty-limit': 'uint64'} }
+            '*vcpu-dirty-limit': 'uint64',
+            '*mode': 'MigMode'} }
 
 ##
 # @migrate-set-parameters:
@@ -1223,6 +1240,9 @@
 # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
 #     Defaults to 1.  (Since 8.1)
 #
+# @mode: Migration mode. See description in @MigMode. Default is 'normal'.
+#        (Since 8.2)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
@@ -1262,7 +1282,8 @@
             '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
                                             'features': [ 'unstable' ] },
-            '*vcpu-dirty-limit': 'uint64'} }
+            '*vcpu-dirty-limit': 'uint64',
+            '*mode': 'MigMode'} }
 
 ##
 # @query-migrate-parameters:
-- 
1.8.3.1


