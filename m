Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B2F7E79C0
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 08:33:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1M12-0005Qh-Kg; Fri, 10 Nov 2023 02:33:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1r1M0z-0005Mz-GL
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 02:33:17 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1r1M0x-0007DT-9z
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 02:33:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699601595; x=1731137595;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+d/QvHRS/nq18/jH2q/BnchHPO+qhQm5X4HU3nYHklw=;
 b=PYDX0y2OuJc7tJeYIPV+wZeaR24YJUWkqTeKjL78Fwe8dZYi7zpO/Pg4
 hmC/Pua73QRjIyuvQ/eq2rUBtM2S36zkOSed8QY23Q7yuMaKf29BLqMzm
 a31tZLfkiy5Xk9D84v6i3aEu6ZMDzmKtk5VECAgtrYv474CN5cSSDJzLI
 d8WwklVMq5l4T9/65ECbcEEN0RSXB+XV/LKVROo0+vWMuVat9t86tl/XO
 gpXLwRl7ot+qHPHtZzxoiv1NtB52gjJ6fXJMLjpv/NUcAHDWlDYII3IQ8
 09B0uo3FOp4Gyd0a2aIju4qlG9GxLn0KM8zPKWhYA+M/PxJWDCN78RwyG w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="11694836"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; d="scan'208";a="11694836"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2023 23:33:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="1010886550"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; d="scan'208";a="1010886550"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by fmsmga006.fm.intel.com with ESMTP; 09 Nov 2023 23:33:08 -0800
From: Yuan Liu <yuan1.liu@intel.com>
To: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Cc: qemu-devel@nongnu.org,
	yuan1.liu@intel.com,
	nanhai.zou@intel.com
Subject: [PATCH v2 1/4] migration: Introduce multifd-compression-accel
 parameter
Date: Thu,  9 Nov 2023 23:46:35 +0800
Message-Id: <20231109154638.488213-2-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231109154638.488213-1-yuan1.liu@intel.com>
References: <20231109154638.488213-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
 hw/core/qdev-properties-system.c    | 11 +++++++++++
 include/hw/qdev-properties-system.h |  4 ++++
 migration/migration-hmp-cmds.c      | 10 ++++++++++
 migration/options.c                 | 24 ++++++++++++++++++++++++
 migration/options.h                 |  1 +
 qapi/migration.json                 | 26 +++++++++++++++++++++++++-
 6 files changed, 75 insertions(+), 1 deletion(-)

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
index 0ac327ae60..da086bd836 100644
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
+#define DEFINE_PROP_MULTIFD_COMPRESSION_ACCEL(_n, _s, _f, _d) \
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
index 42fb818956..4c567c49e6 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -59,6 +59,8 @@
 #define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY (200 * 100)
 #define DEFAULT_MIGRATE_MULTIFD_CHANNELS 2
 #define DEFAULT_MIGRATE_MULTIFD_COMPRESSION MULTIFD_COMPRESSION_NONE
+/* By default use the accelerator for multifd compression */
+#define DEFAULT_MIGRATE_MULTIFD_COMPRESSION_ACCEL MULTIFD_COMPRESSION_ACCEL_AUTO
 /* 0: means nocompress, 1: best speed, ... 9: best compress ratio */
 #define DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL 1
 /* 0: means nocompress, 1: best speed, ... 20: best compress ratio */
@@ -139,6 +141,9 @@ Property migration_properties[] = {
     DEFINE_PROP_MULTIFD_COMPRESSION("multifd-compression", MigrationState,
                       parameters.multifd_compression,
                       DEFAULT_MIGRATE_MULTIFD_COMPRESSION),
+    DEFINE_PROP_MULTIFD_COMPRESSION_ACCEL("multifd-compression-accel",
+                      MigrationState, parameters.multifd_compression_accel,
+                      DEFAULT_MIGRATE_MULTIFD_COMPRESSION_ACCEL),
     DEFINE_PROP_UINT8("multifd-zlib-level", MigrationState,
                       parameters.multifd_zlib_level,
                       DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL),
@@ -818,6 +823,15 @@ MultiFDCompression migrate_multifd_compression(void)
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
@@ -945,6 +959,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->multifd_channels = s->parameters.multifd_channels;
     params->has_multifd_compression = true;
     params->multifd_compression = s->parameters.multifd_compression;
+    params->has_multifd_compression_accel = true;
+    params->multifd_compression_accel = s->parameters.multifd_compression_accel;
     params->has_multifd_zlib_level = true;
     params->multifd_zlib_level = s->parameters.multifd_zlib_level;
     params->has_multifd_zstd_level = true;
@@ -999,6 +1015,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_block_incremental = true;
     params->has_multifd_channels = true;
     params->has_multifd_compression = true;
+    params->has_multifd_compression_accel = true;
     params->has_multifd_zlib_level = true;
     params->has_multifd_zstd_level = true;
     params->has_xbzrle_cache_size = true;
@@ -1273,6 +1290,9 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_multifd_compression) {
         dest->multifd_compression = params->multifd_compression;
     }
+    if (params->has_multifd_compression_accel) {
+        dest->multifd_compression_accel = params->multifd_compression_accel;
+    }
     if (params->has_xbzrle_cache_size) {
         dest->xbzrle_cache_size = params->xbzrle_cache_size;
     }
@@ -1394,6 +1414,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
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
index db3df12d6c..47239328e4 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -616,6 +616,22 @@
             { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }

 ##
+# @MultiFDCompressionAccel:
+#
+# An enumeration of multifd compression accelerator.
+#
+# @auto: automatically determined if accelerator is available.
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
+# @multifd-compression-accel: Which compression accelerator to use.  Defaults to
+#     auto.  (Since 8.2)
+#
 # @multifd-zlib-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 9,
 #     where 0 means no compression, 1 means the best compression
@@ -853,7 +872,7 @@
            'block-incremental',
            'multifd-channels',
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
-           'max-cpu-throttle', 'multifd-compression',
+           'max-cpu-throttle', 'multifd-compression', 'multifd-compression-accel',
            'multifd-zlib-level', 'multifd-zstd-level',
            'block-bitmap-mapping',
            { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
@@ -974,6 +993,9 @@
 # @multifd-compression: Which compression method to use.  Defaults to
 #     none.  (Since 5.0)
 #
+# @multifd-compression-accel: Which compression acclerator to use.  Defaults to
+#     auto.  (Since 8.2)
+#
 # @multifd-zlib-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 9,
 #     where 0 means no compression, 1 means the best compression
@@ -1046,6 +1068,7 @@
             '*max-postcopy-bandwidth': 'size',
             '*max-cpu-throttle': 'uint8',
             '*multifd-compression': 'MultiFDCompression',
+            '*multifd-compression-accel': 'MultiFDCompressionAccel',
             '*multifd-zlib-level': 'uint8',
             '*multifd-zstd-level': 'uint8',
             '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
@@ -1257,6 +1280,7 @@
             '*max-postcopy-bandwidth': 'size',
             '*max-cpu-throttle': 'uint8',
             '*multifd-compression': 'MultiFDCompression',
+            '*multifd-compression-accel': 'MultiFDCompressionAccel',
             '*multifd-zlib-level': 'uint8',
             '*multifd-zstd-level': 'uint8',
             '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
--
2.39.3


