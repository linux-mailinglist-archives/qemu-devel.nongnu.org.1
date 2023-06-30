Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B03743425
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 07:25:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF6bZ-0008L7-VP; Fri, 30 Jun 2023 01:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mf8A=CS=redhat.com=clg@ozlabs.org>)
 id 1qF6bT-0008IB-1G
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 01:23:31 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mf8A=CS=redhat.com=clg@ozlabs.org>)
 id 1qF6bQ-0004i2-LV
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 01:23:30 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QskHb4TlQz4wpS;
 Fri, 30 Jun 2023 15:23:23 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QskHY1B11z4wpR;
 Fri, 30 Jun 2023 15:23:20 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 13/16] vfio/migration: Make VFIO migration non-experimental
Date: Fri, 30 Jun 2023 07:22:32 +0200
Message-ID: <20230630052235.1934154-14-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630052235.1934154-1-clg@redhat.com>
References: <20230630052235.1934154-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=mf8A=CS=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

From: Avihai Horon <avihaih@nvidia.com>

The major parts of VFIO migration are supported today in QEMU. This
includes basic VFIO migration, device dirty page tracking and precopy
support.

Thus, at this point in time, it seems appropriate to make VFIO migration
non-experimental: remove the x prefix from enable_migration property,
change it to ON_OFF_AUTO and let the default value be AUTO.

In addition, make the following adjustments:
1. When enable_migration is ON and migration is not supported, fail VFIO
   device realization.
2. When enable_migration is AUTO (i.e., not explicitly enabled), require
   device dirty tracking support. This is because device dirty tracking
   is currently the only method to do dirty page tracking, which is
   essential for migrating in a reasonable downtime. Setting
   enable_migration to ON will not require device dirty tracking.
3. Make migration error and blocker messages more elaborate.
4. Remove error prints in vfio_migration_query_flags().
5. Rename trace_vfio_migration_probe() to
   trace_vfio_migration_realize().

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h |  6 +--
 hw/vfio/common.c              | 16 ++++++-
 hw/vfio/migration.c           | 79 +++++++++++++++++++++++------------
 hw/vfio/pci.c                 |  4 +-
 hw/vfio/trace-events          |  2 +-
 5 files changed, 73 insertions(+), 34 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 1d19c6f251c1..93429b9abba0 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -139,7 +139,7 @@ typedef struct VFIODevice {
     bool needs_reset;
     bool no_mmap;
     bool ram_block_discard_allowed;
-    bool enable_migration;
+    OnOffAuto enable_migration;
     VFIODeviceOps *ops;
     unsigned int num_irqs;
     unsigned int num_regions;
@@ -225,9 +225,9 @@ typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
 extern VFIOGroupList vfio_group_list;
 
 bool vfio_mig_active(void);
-int vfio_block_multiple_devices_migration(Error **errp);
+int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
 void vfio_unblock_multiple_devices_migration(void);
-int vfio_block_giommu_migration(Error **errp);
+int vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp);
 int64_t vfio_mig_bytes_transferred(void);
 void vfio_reset_bytes_transferred(void);
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 28ec9e999c09..77e2ee0e5c6e 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -381,7 +381,7 @@ static unsigned int vfio_migratable_device_num(void)
     return device_num;
 }
 
-int vfio_block_multiple_devices_migration(Error **errp)
+int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
 {
     int ret;
 
@@ -390,6 +390,12 @@ int vfio_block_multiple_devices_migration(Error **errp)
         return 0;
     }
 
+    if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
+        error_setg(errp, "Migration is currently not supported with multiple "
+                         "VFIO devices");
+        return -EINVAL;
+    }
+
     error_setg(&multiple_devices_migration_blocker,
                "Migration is currently not supported with multiple "
                "VFIO devices");
@@ -427,7 +433,7 @@ static bool vfio_viommu_preset(void)
     return false;
 }
 
-int vfio_block_giommu_migration(Error **errp)
+int vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp)
 {
     int ret;
 
@@ -436,6 +442,12 @@ int vfio_block_giommu_migration(Error **errp)
         return 0;
     }
 
+    if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
+        error_setg(errp,
+                   "Migration is currently not supported with vIOMMU enabled");
+        return -EINVAL;
+    }
+
     error_setg(&giommu_migration_blocker,
                "Migration is currently not supported with vIOMMU enabled");
     ret = migrate_add_blocker(giommu_migration_blocker, errp);
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 7cf143926ce9..1db7d52ab2c1 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -724,14 +724,6 @@ static int vfio_migration_query_flags(VFIODevice *vbasedev, uint64_t *mig_flags)
     feature->argsz = sizeof(buf);
     feature->flags = VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_MIGRATION;
     if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
-        if (errno == ENOTTY) {
-            error_report("%s: VFIO migration is not supported in kernel",
-                         vbasedev->name);
-        } else {
-            error_report("%s: Failed to query VFIO migration support, err: %s",
-                         vbasedev->name, strerror(errno));
-        }
-
         return -errno;
     }
 
@@ -810,6 +802,27 @@ static int vfio_migration_init(VFIODevice *vbasedev)
     return 0;
 }
 
+static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
+{
+    int ret;
+
+    if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
+        error_propagate(errp, err);
+        return -EINVAL;
+    }
+
+    vbasedev->migration_blocker = error_copy(err);
+    error_free(err);
+
+    ret = migrate_add_blocker(vbasedev->migration_blocker, errp);
+    if (ret < 0) {
+        error_free(vbasedev->migration_blocker);
+        vbasedev->migration_blocker = NULL;
+    }
+
+    return ret;
+}
+
 /* ---------------------------------------------------------------------- */
 
 int64_t vfio_mig_bytes_transferred(void)
@@ -824,40 +837,54 @@ void vfio_reset_bytes_transferred(void)
 
 int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
 {
-    int ret = -ENOTSUP;
+    Error *err = NULL;
+    int ret;
 
-    if (!vbasedev->enable_migration) {
-        goto add_blocker;
+    if (vbasedev->enable_migration == ON_OFF_AUTO_OFF) {
+        error_setg(&err, "%s: Migration is disabled for VFIO device",
+                   vbasedev->name);
+        return vfio_block_migration(vbasedev, err, errp);
     }
 
     ret = vfio_migration_init(vbasedev);
     if (ret) {
-        goto add_blocker;
+        if (ret == -ENOTTY) {
+            error_setg(&err, "%s: VFIO migration is not supported in kernel",
+                       vbasedev->name);
+        } else {
+            error_setg(&err,
+                       "%s: Migration couldn't be initialized for VFIO device, "
+                       "err: %d (%s)",
+                       vbasedev->name, ret, strerror(-ret));
+        }
+
+        return vfio_block_migration(vbasedev, err, errp);
+    }
+
+    if (!vbasedev->dirty_pages_supported) {
+        if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO) {
+            error_setg(&err,
+                       "%s: VFIO device doesn't support device dirty tracking",
+                       vbasedev->name);
+            return vfio_block_migration(vbasedev, err, errp);
+        }
+
+        warn_report("%s: VFIO device doesn't support device dirty tracking",
+                    vbasedev->name);
     }
 
-    ret = vfio_block_multiple_devices_migration(errp);
+    ret = vfio_block_multiple_devices_migration(vbasedev, errp);
     if (ret) {
         return ret;
     }
 
-    ret = vfio_block_giommu_migration(errp);
+    ret = vfio_block_giommu_migration(vbasedev, errp);
     if (ret) {
         return ret;
     }
 
-    trace_vfio_migration_probe(vbasedev->name);
+    trace_vfio_migration_realize(vbasedev->name);
     return 0;
-
-add_blocker:
-    error_setg(&vbasedev->migration_blocker,
-               "VFIO device doesn't support migration");
-
-    ret = migrate_add_blocker(vbasedev->migration_blocker, errp);
-    if (ret < 0) {
-        error_free(vbasedev->migration_blocker);
-        vbasedev->migration_blocker = NULL;
-    }
-    return ret;
 }
 
 void vfio_migration_exit(VFIODevice *vbasedev)
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 8fb2c53a63bf..73e19a04b2bf 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3347,8 +3347,8 @@ static Property vfio_pci_dev_properties[] = {
                     VFIO_FEATURE_ENABLE_REQ_BIT, true),
     DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
                     VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
-    DEFINE_PROP_BOOL("x-enable-migration", VFIOPCIDevice,
-                     vbasedev.enable_migration, false),
+    DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
+                            vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
     DEFINE_PROP_BOOL("x-balloon-allowed", VFIOPCIDevice,
                      vbasedev.ram_block_discard_allowed, false),
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index e328d644d289..ee7509e68e4f 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -155,7 +155,7 @@ vfio_load_cleanup(const char *name) " (%s)"
 vfio_load_device_config_state(const char *name) " (%s)"
 vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
 vfio_load_state_device_data(const char *name, uint64_t data_size, int ret) " (%s) size 0x%"PRIx64" ret %d"
-vfio_migration_probe(const char *name) " (%s)"
+vfio_migration_realize(const char *name) " (%s)"
 vfio_migration_set_state(const char *name, const char *state) " (%s) state %s"
 vfio_migration_state_notifier(const char *name, const char *state) " (%s) state %s"
 vfio_save_block(const char *name, int data_size) " (%s) data_size %d"
-- 
2.41.0


