Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27427823B0D
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 04:17:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLEDU-0005Y4-DM; Wed, 03 Jan 2024 22:16:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rLEDH-0005WF-2J
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 22:16:07 -0500
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rLEDD-00039c-6r
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 22:16:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704338163; x=1735874163;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+LoEH4KvOflvXfMCEuiEsyag9n0cxdj2GiGbVmDdMe4=;
 b=cixQw6KwmKvDgLFaK0wa3Wb/QODME21ynnCKxZNwZXi/vyufq2WyuEmk
 JuavaY+EVfhimO6qgjW67n0/yJ9MKMfwmtk6y78slsth8jtQP1PobAfbS
 MBuM0KeNe63QeBndIdHwrUVOz0KXgNTxcrH76tP9BwPSK0aCbavp3rT+B
 +oqHcopCjnaz31wpiGk9a7TSNmuOevrTUlQPGplrDtDEuUU9dohA/do/5
 PLqzzt7w8yoX6nomBv064D2cWsJ5tQOX2Z0rMpW/keh5MirigI9BkdI7W
 QtZC1DVnHPZPSxR7mMnBES0rzKYDuJVwI1CXAhK30sl+vCwqXqXC+X4R8 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="376610413"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; d="scan'208";a="376610413"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2024 19:15:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; d="scan'208";a="28613644"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by orviesa001.jf.intel.com with ESMTP; 03 Jan 2024 19:15:46 -0800
From: Yuan Liu <yuan1.liu@intel.com>
To: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Cc: qemu-devel@nongnu.org,
	yuan1.liu@intel.com,
	nanhai.zou@intel.com
Subject: [PATCH v3 1/4] migration: Introduce multifd-compression-accel
 parameter
Date: Wed,  3 Jan 2024 19:28:48 +0800
Message-Id: <20240103112851.908082-2-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240103112851.908082-1-yuan1.liu@intel.com>
References: <20240103112851.908082-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.136; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-2.601, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Introduce the multifd-compression-accel option to enable or disable live
migration data (de)compression accelerator.

The default value of multifd-compression-accel is auto, and the enabling
and selection of the accelerator are automatically detected. By setting
multifd-compression-accel=none, the acceleration function can be disabled.
Similarly, users can explicitly specify a specific accelerator name, such
as multifd-compression-accel=qpl.

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
---
 hw/core/qdev-properties-system.c    | 11 ++++++++++
 include/hw/qdev-properties-system.h |  4 ++++
 migration/migration-hmp-cmds.c      | 10 ++++++++++
 migration/options.c                 | 28 ++++++++++++++++++++++++++
 migration/options.h                 |  1 +
 qapi/migration.json                 | 31 ++++++++++++++++++++++++++++-
 6 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 688340610e..ed23035845 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -673,6 +673,17 @@ const PropertyInfo qdev_prop_multifd_compression = {
     .set_default_value = qdev_propinfo_set_default_value_enum,
 };
 
+/* --- MultiFD Compression Accelerator --- */
+
+const PropertyInfo qdev_prop_multifd_compression_accel = {
+    .name = "MultiFDCompressionAccel",
+    .description = "MultiFD Compression Accelerator, "
+                   "auto/none/qpl",
+    .enum_table = &MultiFDCompressionAccel_lookup,
+    .get = qdev_propinfo_get_enum,
+    .set = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
+};
 /* --- Reserved Region --- */
 
 /*
diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
index 0ac327ae60..3c125db3a3 100644
--- a/include/hw/qdev-properties-system.h
+++ b/include/hw/qdev-properties-system.h
@@ -7,6 +7,7 @@ extern const PropertyInfo qdev_prop_chr;
 extern const PropertyInfo qdev_prop_macaddr;
 extern const PropertyInfo qdev_prop_reserved_region;
 extern const PropertyInfo qdev_prop_multifd_compression;
+extern const PropertyInfo qdev_prop_multifd_compression_accel;
 extern const PropertyInfo qdev_prop_losttickpolicy;
 extern const PropertyInfo qdev_prop_blockdev_on_error;
 extern const PropertyInfo qdev_prop_bios_chs_trans;
@@ -41,6 +42,9 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
 #define DEFINE_PROP_MULTIFD_COMPRESSION(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_multifd_compression, \
                        MultiFDCompression)
+#define DEFINE_PROP_MULTIFD_COMP_ACCEL(_n, _s, _f, _d) \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_multifd_compression_accel, \
+                       MultiFDCompressionAccel)
 #define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_losttickpolicy, \
                         LostTickPolicy)
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index a82597f18e..3a278c89d9 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -344,6 +344,11 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %s\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_COMPRESSION),
             MultiFDCompression_str(params->multifd_compression));
+        assert(params->has_multifd_compression_accel);
+        monitor_printf(mon, "%s: %s\n",
+            MigrationParameter_str(
+                MIGRATION_PARAMETER_MULTIFD_COMPRESSION_ACCEL),
+            MultiFDCompressionAccel_str(params->multifd_compression_accel));
         monitor_printf(mon, "%s: %" PRIu64 " bytes\n",
             MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
             params->xbzrle_cache_size);
@@ -610,6 +615,11 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         visit_type_MultiFDCompression(v, param, &p->multifd_compression,
                                       &err);
         break;
+    case MIGRATION_PARAMETER_MULTIFD_COMPRESSION_ACCEL:
+        p->has_multifd_compression_accel = true;
+        visit_type_MultiFDCompressionAccel(v, param,
+                                           &p->multifd_compression_accel, &err);
+        break;
     case MIGRATION_PARAMETER_MULTIFD_ZLIB_LEVEL:
         p->has_multifd_zlib_level = true;
         visit_type_uint8(v, param, &p->multifd_zlib_level, &err);
diff --git a/migration/options.c b/migration/options.c
index 42fb818956..6ef06d1816 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -59,6 +59,12 @@
 #define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY (200 * 100)
 #define DEFAULT_MIGRATE_MULTIFD_CHANNELS 2
 #define DEFAULT_MIGRATE_MULTIFD_COMPRESSION MULTIFD_COMPRESSION_NONE
+
+/*
+ * When the compression method is available and supported by the
+ * accelerator, data compression is performed using the accelerator.
+ */
+#define DEFAULT_MIGRATE_MULTIFD_COMPRESSION_ACCEL MULTIFD_COMPRESSION_ACCEL_AUTO
 /* 0: means nocompress, 1: best speed, ... 9: best compress ratio */
 #define DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL 1
 /* 0: means nocompress, 1: best speed, ... 20: best compress ratio */
@@ -139,6 +145,9 @@ Property migration_properties[] = {
     DEFINE_PROP_MULTIFD_COMPRESSION("multifd-compression", MigrationState,
                       parameters.multifd_compression,
                       DEFAULT_MIGRATE_MULTIFD_COMPRESSION),
+    DEFINE_PROP_MULTIFD_COMP_ACCEL("multifd-compression-accel", MigrationState,
+                      parameters.multifd_compression_accel,
+                      DEFAULT_MIGRATE_MULTIFD_COMPRESSION_ACCEL),
     DEFINE_PROP_UINT8("multifd-zlib-level", MigrationState,
                       parameters.multifd_zlib_level,
                       DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL),
@@ -818,6 +827,15 @@ MultiFDCompression migrate_multifd_compression(void)
     return s->parameters.multifd_compression;
 }
 
+MultiFDCompressionAccel migrate_multifd_compression_accel(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    assert(s->parameters.multifd_compression_accel <
+           MULTIFD_COMPRESSION_ACCEL__MAX);
+    return s->parameters.multifd_compression_accel;
+}
+
 int migrate_multifd_zlib_level(void)
 {
     MigrationState *s = migrate_get_current();
@@ -945,6 +963,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->multifd_channels = s->parameters.multifd_channels;
     params->has_multifd_compression = true;
     params->multifd_compression = s->parameters.multifd_compression;
+    params->has_multifd_compression_accel = true;
+    params->multifd_compression_accel = s->parameters.multifd_compression_accel;
     params->has_multifd_zlib_level = true;
     params->multifd_zlib_level = s->parameters.multifd_zlib_level;
     params->has_multifd_zstd_level = true;
@@ -999,6 +1019,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_block_incremental = true;
     params->has_multifd_channels = true;
     params->has_multifd_compression = true;
+    params->has_multifd_compression_accel = true;
     params->has_multifd_zlib_level = true;
     params->has_multifd_zstd_level = true;
     params->has_xbzrle_cache_size = true;
@@ -1273,6 +1294,9 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_multifd_compression) {
         dest->multifd_compression = params->multifd_compression;
     }
+    if (params->has_multifd_compression_accel) {
+        dest->multifd_compression_accel = params->multifd_compression_accel;
+    }
     if (params->has_xbzrle_cache_size) {
         dest->xbzrle_cache_size = params->xbzrle_cache_size;
     }
@@ -1394,6 +1418,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_multifd_compression) {
         s->parameters.multifd_compression = params->multifd_compression;
     }
+    if (params->has_multifd_compression_accel) {
+        s->parameters.multifd_compression_accel =
+            params->multifd_compression_accel;
+    }
     if (params->has_xbzrle_cache_size) {
         s->parameters.xbzrle_cache_size = params->xbzrle_cache_size;
         xbzrle_cache_resize(params->xbzrle_cache_size, errp);
diff --git a/migration/options.h b/migration/options.h
index 237f2d6b4a..e59bf4b5c1 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -85,6 +85,7 @@ uint64_t migrate_avail_switchover_bandwidth(void);
 uint64_t migrate_max_postcopy_bandwidth(void);
 int migrate_multifd_channels(void);
 MultiFDCompression migrate_multifd_compression(void);
+MultiFDCompressionAccel migrate_multifd_compression_accel(void);
 int migrate_multifd_zlib_level(void);
 int migrate_multifd_zstd_level(void);
 uint8_t migrate_throttle_trigger_threshold(void);
diff --git a/qapi/migration.json b/qapi/migration.json
index db3df12d6c..7a1dde6c5c 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -616,6 +616,22 @@
             { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
 
 ##
+# @MultiFDCompressionAccel:
+#
+# An enumeration of multifd compression accelerator.
+#
+# @auto: if accelerators are available, enable one of them.
+#
+# @none: disable compression accelerator.
+#
+# @qpl: enable qpl compression accelerator.
+#
+# Since: 8.2
+##
+{ 'enum': 'MultiFDCompressionAccel',
+  'data': [ 'auto', 'none',
+            { 'name': 'qpl', 'if': 'CONFIG_QPL' } ] }
+##
 # @BitmapMigrationBitmapAliasTransform:
 #
 # @persistent: If present, the bitmap will be made persistent or
@@ -798,6 +814,9 @@
 # @multifd-compression: Which compression method to use.  Defaults to
 #     none.  (Since 5.0)
 #
+# @multifd-compression-accel: Which compression accelerator to use.
+#     Defaults to auto.  (Since 8.2)
+#
 # @multifd-zlib-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 9,
 #     where 0 means no compression, 1 means the best compression
@@ -853,7 +872,9 @@
            'block-incremental',
            'multifd-channels',
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
-           'max-cpu-throttle', 'multifd-compression',
+           'max-cpu-throttle',
+           'multifd-compression',
+           'multifd-compression-accel',
            'multifd-zlib-level', 'multifd-zstd-level',
            'block-bitmap-mapping',
            { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
@@ -974,6 +995,9 @@
 # @multifd-compression: Which compression method to use.  Defaults to
 #     none.  (Since 5.0)
 #
+# @multifd-compression-accel: Which compression accelerator to use.
+#     Defaults to auto. (Since 8.2)
+#
 # @multifd-zlib-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 9,
 #     where 0 means no compression, 1 means the best compression
@@ -1046,6 +1070,7 @@
             '*max-postcopy-bandwidth': 'size',
             '*max-cpu-throttle': 'uint8',
             '*multifd-compression': 'MultiFDCompression',
+            '*multifd-compression-accel': 'MultiFDCompressionAccel',
             '*multifd-zlib-level': 'uint8',
             '*multifd-zstd-level': 'uint8',
             '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
@@ -1188,6 +1213,9 @@
 # @multifd-compression: Which compression method to use.  Defaults to
 #     none.  (Since 5.0)
 #
+# @multifd-compression-accel: Which compression accelerator to use.
+#     Defaults to auto. (Since 8.2)
+#
 # @multifd-zlib-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 9,
 #     where 0 means no compression, 1 means the best compression
@@ -1257,6 +1285,7 @@
             '*max-postcopy-bandwidth': 'size',
             '*max-cpu-throttle': 'uint8',
             '*multifd-compression': 'MultiFDCompression',
+            '*multifd-compression-accel': 'MultiFDCompressionAccel',
             '*multifd-zlib-level': 'uint8',
             '*multifd-zstd-level': 'uint8',
             '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
-- 
2.39.3


