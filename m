Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B97D87AEBCE
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 13:50:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql6YA-0003Is-9G; Tue, 26 Sep 2023 07:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ql6Y6-0003EO-Ba
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 07:48:18 -0400
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ql6Y2-0002Rw-Ru
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 07:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695728894; x=1727264894;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Xqd23yx/zX/rOfxr6Url3VKaswGl8B+/O/TYoZI5AAA=;
 b=Z/MKahnuz2cp5vIbkvE2og8zNA7ZoMq3fvm56+XjSufR/UVas28DL06z
 LJBfJjVwp4+aHkLVlKN8z0M/FwUngMhO1mLXaF9ta23riV3Nmb0MgUNWa
 AZ/ZaGLYSAx524jpQYSLKbmONzXFZmVe50UCu8n9K8OJROLUR2L1ZCzS0
 Gf0C821XIHxSelUi6zTYV9V0KnoIlyRsXmWla35yzjKmefkRMmRAINu/f
 pK+d+3TqWg+IBIEOc6dOa8yUi+i3FeEmauAqGyMOR7r1Kg26FY7jAX2xL
 ZaAB+KJGD9FjLkqI4bSgt5IuhFCoJrptHsRDuslYKLJTSN3p04AIx42Dp A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="378825502"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; d="scan'208";a="378825502"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 04:48:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="748789800"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; d="scan'208";a="748789800"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 04:48:09 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 11/12] vfio/common: Introduce two kinds of VFIO device lists
Date: Tue, 26 Sep 2023 19:32:54 +0800
Message-Id: <20230926113255.1177834-12-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926113255.1177834-1-zhenzhong.duan@intel.com>
References: <20230926113255.1177834-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.93;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

In VFIO subsystem, there are different VFIO device iteration requirements.
One requirement is to iterate all VFIO devices, the other is to iterate
VFIO device in same container.

Currently VFIO device is iterated through VFIO group list which is group
perceivable and less efficient.

Introduce two kinds of VFIO device lists, one is a global list, the other
is per container list. With the two lists added, we can make some migration
and reset related functions group agnostic.

For example, vfio_device_list is used in below functions:
vfio_mig_active
vfio_reset_handler
vfio_multiple_devices_migration_is_supported

Per container list is used in below functions:
vfio_devices_all_dirty_tracking
vfio_devices_all_device_dirty_tracking
vfio_devices_all_running_and_mig_active
vfio_devices_dma_logging_stop
vfio_devices_dma_logging_start
vfio_devices_query_dirty_bitmap

This is a prerequisite for future IOMMUFD backend support which
has same kind of iteration requirement.

vfio_group_list is preserved for some functions which honor group
iteration, those functions are all related to legacy backend.

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h |   5 +
 hw/vfio/common.c              | 194 ++++++++++++++++------------------
 2 files changed, 94 insertions(+), 105 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index c486bdef2a..54905b9dd4 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -98,6 +98,7 @@ typedef struct VFIOContainer {
     QLIST_HEAD(, VFIOGroup) group_list;
     QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
     QLIST_ENTRY(VFIOContainer) next;
+    QLIST_HEAD(, VFIODevice) device_list;
 } VFIOContainer;
 
 typedef struct VFIOGuestIOMMU {
@@ -129,7 +130,10 @@ typedef struct VFIODeviceOps VFIODeviceOps;
 
 typedef struct VFIODevice {
     QLIST_ENTRY(VFIODevice) next;
+    QLIST_ENTRY(VFIODevice) container_next;
+    QLIST_ENTRY(VFIODevice) global_next;
     struct VFIOGroup *group;
+    VFIOContainer *container;
     char *sysfsdev;
     char *name;
     DeviceState *dev;
@@ -229,6 +233,7 @@ int vfio_kvm_device_del_fd(int fd, Error **errp);
 
 extern const MemoryRegionOps vfio_region_ops;
 typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
+typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
 extern VFIOGroupList vfio_group_list;
 
 bool vfio_mig_active(void);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 12ebf2f11d..645e2dc39a 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -48,6 +48,8 @@
 
 VFIOGroupList vfio_group_list =
     QLIST_HEAD_INITIALIZER(vfio_group_list);
+static VFIODeviceList vfio_device_list =
+    QLIST_HEAD_INITIALIZER(vfio_device_list);
 static QLIST_HEAD(, VFIOAddressSpace) vfio_address_spaces =
     QLIST_HEAD_INITIALIZER(vfio_address_spaces);
 
@@ -94,18 +96,15 @@ static int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
 
 bool vfio_mig_active(void)
 {
-    VFIOGroup *group;
     VFIODevice *vbasedev;
 
-    if (QLIST_EMPTY(&vfio_group_list)) {
+    if (QLIST_EMPTY(&vfio_device_list)) {
         return false;
     }
 
-    QLIST_FOREACH(group, &vfio_group_list, next) {
-        QLIST_FOREACH(vbasedev, &group->device_list, next) {
-            if (vbasedev->migration_blocker) {
-                return false;
-            }
+    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
+        if (vbasedev->migration_blocker) {
+            return false;
         }
     }
     return true;
@@ -120,19 +119,16 @@ static Error *multiple_devices_migration_blocker;
  */
 static bool vfio_multiple_devices_migration_is_supported(void)
 {
-    VFIOGroup *group;
     VFIODevice *vbasedev;
     unsigned int device_num = 0;
     bool all_support_p2p = true;
 
-    QLIST_FOREACH(group, &vfio_group_list, next) {
-        QLIST_FOREACH(vbasedev, &group->device_list, next) {
-            if (vbasedev->migration) {
-                device_num++;
+    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
+        if (vbasedev->migration) {
+            device_num++;
 
-                if (!(vbasedev->migration->mig_flags & VFIO_MIGRATION_P2P)) {
-                    all_support_p2p = false;
-                }
+            if (!(vbasedev->migration->mig_flags & VFIO_MIGRATION_P2P)) {
+                all_support_p2p = false;
             }
         }
     }
@@ -184,7 +180,7 @@ void vfio_unblock_multiple_devices_migration(void)
 
 bool vfio_viommu_preset(VFIODevice *vbasedev)
 {
-    return vbasedev->group->container->space->as != &address_space_memory;
+    return vbasedev->container->space->as != &address_space_memory;
 }
 
 static void vfio_set_migration_error(int err)
@@ -218,7 +214,6 @@ bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
 
 static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
 {
-    VFIOGroup *group;
     VFIODevice *vbasedev;
     MigrationState *ms = migrate_get_current();
 
@@ -227,19 +222,17 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
         return false;
     }
 
-    QLIST_FOREACH(group, &container->group_list, container_next) {
-        QLIST_FOREACH(vbasedev, &group->device_list, next) {
-            VFIOMigration *migration = vbasedev->migration;
+    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
+        VFIOMigration *migration = vbasedev->migration;
 
-            if (!migration) {
-                return false;
-            }
+        if (!migration) {
+            return false;
+        }
 
-            if (vbasedev->pre_copy_dirty_page_tracking == ON_OFF_AUTO_OFF &&
-                (vfio_device_state_is_running(vbasedev) ||
-                 vfio_device_state_is_precopy(vbasedev))) {
-                return false;
-            }
+        if (vbasedev->pre_copy_dirty_page_tracking == ON_OFF_AUTO_OFF &&
+            (vfio_device_state_is_running(vbasedev) ||
+             vfio_device_state_is_precopy(vbasedev))) {
+            return false;
         }
     }
     return true;
@@ -247,14 +240,11 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
 
 static bool vfio_devices_all_device_dirty_tracking(VFIOContainer *container)
 {
-    VFIOGroup *group;
     VFIODevice *vbasedev;
 
-    QLIST_FOREACH(group, &container->group_list, container_next) {
-        QLIST_FOREACH(vbasedev, &group->device_list, next) {
-            if (!vbasedev->dirty_pages_supported) {
-                return false;
-            }
+    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
+        if (!vbasedev->dirty_pages_supported) {
+            return false;
         }
     }
 
@@ -267,27 +257,24 @@ static bool vfio_devices_all_device_dirty_tracking(VFIOContainer *container)
  */
 static bool vfio_devices_all_running_and_mig_active(VFIOContainer *container)
 {
-    VFIOGroup *group;
     VFIODevice *vbasedev;
 
     if (!migration_is_active(migrate_get_current())) {
         return false;
     }
 
-    QLIST_FOREACH(group, &container->group_list, container_next) {
-        QLIST_FOREACH(vbasedev, &group->device_list, next) {
-            VFIOMigration *migration = vbasedev->migration;
+    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
+        VFIOMigration *migration = vbasedev->migration;
 
-            if (!migration) {
-                return false;
-            }
+        if (!migration) {
+            return false;
+        }
 
-            if (vfio_device_state_is_running(vbasedev) ||
-                vfio_device_state_is_precopy(vbasedev)) {
-                continue;
-            } else {
-                return false;
-            }
+        if (vfio_device_state_is_running(vbasedev) ||
+            vfio_device_state_is_precopy(vbasedev)) {
+            continue;
+        } else {
+            return false;
         }
     }
     return true;
@@ -1187,20 +1174,17 @@ static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
 {
     VFIOPCIDevice *pcidev;
     VFIODevice *vbasedev;
-    VFIOGroup *group;
     Object *owner;
 
     owner = memory_region_owner(section->mr);
 
-    QLIST_FOREACH(group, &container->group_list, container_next) {
-        QLIST_FOREACH(vbasedev, &group->device_list, next) {
-            if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
-                continue;
-            }
-            pcidev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
-            if (OBJECT(pcidev) == owner) {
-                return true;
-            }
+    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
+        if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
+            continue;
+        }
+        pcidev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
+        if (OBJECT(pcidev) == owner) {
+            return true;
         }
     }
 
@@ -1296,24 +1280,21 @@ static void vfio_devices_dma_logging_stop(VFIOContainer *container)
                               sizeof(uint64_t))] = {};
     struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
     VFIODevice *vbasedev;
-    VFIOGroup *group;
 
     feature->argsz = sizeof(buf);
     feature->flags = VFIO_DEVICE_FEATURE_SET |
                      VFIO_DEVICE_FEATURE_DMA_LOGGING_STOP;
 
-    QLIST_FOREACH(group, &container->group_list, container_next) {
-        QLIST_FOREACH(vbasedev, &group->device_list, next) {
-            if (!vbasedev->dirty_tracking) {
-                continue;
-            }
+    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
+        if (!vbasedev->dirty_tracking) {
+            continue;
+        }
 
-            if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
-                warn_report("%s: Failed to stop DMA logging, err %d (%s)",
-                             vbasedev->name, -errno, strerror(errno));
-            }
-            vbasedev->dirty_tracking = false;
+        if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
+            warn_report("%s: Failed to stop DMA logging, err %d (%s)",
+                        vbasedev->name, -errno, strerror(errno));
         }
+        vbasedev->dirty_tracking = false;
     }
 }
 
@@ -1396,7 +1377,6 @@ static int vfio_devices_dma_logging_start(VFIOContainer *container)
     struct vfio_device_feature *feature;
     VFIODirtyRanges ranges;
     VFIODevice *vbasedev;
-    VFIOGroup *group;
     int ret = 0;
 
     vfio_dirty_tracking_init(container, &ranges);
@@ -1406,21 +1386,19 @@ static int vfio_devices_dma_logging_start(VFIOContainer *container)
         return -errno;
     }
 
-    QLIST_FOREACH(group, &container->group_list, container_next) {
-        QLIST_FOREACH(vbasedev, &group->device_list, next) {
-            if (vbasedev->dirty_tracking) {
-                continue;
-            }
+    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
+        if (vbasedev->dirty_tracking) {
+            continue;
+        }
 
-            ret = ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
-            if (ret) {
-                ret = -errno;
-                error_report("%s: Failed to start DMA logging, err %d (%s)",
-                             vbasedev->name, ret, strerror(errno));
-                goto out;
-            }
-            vbasedev->dirty_tracking = true;
+        ret = ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
+        if (ret) {
+            ret = -errno;
+            error_report("%s: Failed to start DMA logging, err %d (%s)",
+                         vbasedev->name, ret, strerror(errno));
+            goto out;
         }
+        vbasedev->dirty_tracking = true;
     }
 
 out:
@@ -1500,21 +1478,18 @@ static int vfio_devices_query_dirty_bitmap(VFIOContainer *container,
                                            hwaddr size)
 {
     VFIODevice *vbasedev;
-    VFIOGroup *group;
     int ret;
 
-    QLIST_FOREACH(group, &container->group_list, container_next) {
-        QLIST_FOREACH(vbasedev, &group->device_list, next) {
-            ret = vfio_device_dma_logging_report(vbasedev, iova, size,
-                                                 vbmap->bitmap);
-            if (ret) {
-                error_report("%s: Failed to get DMA logging report, iova: "
-                             "0x%" HWADDR_PRIx ", size: 0x%" HWADDR_PRIx
-                             ", err: %d (%s)",
-                             vbasedev->name, iova, size, ret, strerror(-ret));
+    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
+        ret = vfio_device_dma_logging_report(vbasedev, iova, size,
+                                             vbmap->bitmap);
+        if (ret) {
+            error_report("%s: Failed to get DMA logging report, iova: "
+                         "0x%" HWADDR_PRIx ", size: 0x%" HWADDR_PRIx
+                         ", err: %d (%s)",
+                         vbasedev->name, iova, size, ret, strerror(-ret));
 
-                return ret;
-            }
+            return ret;
         }
     }
 
@@ -1798,22 +1773,17 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
 
 void vfio_reset_handler(void *opaque)
 {
-    VFIOGroup *group;
     VFIODevice *vbasedev;
 
-    QLIST_FOREACH(group, &vfio_group_list, next) {
-        QLIST_FOREACH(vbasedev, &group->device_list, next) {
-            if (vbasedev->dev->realized) {
-                vbasedev->ops->vfio_compute_needs_reset(vbasedev);
-            }
+    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
+        if (vbasedev->dev->realized) {
+            vbasedev->ops->vfio_compute_needs_reset(vbasedev);
         }
     }
 
-    QLIST_FOREACH(group, &vfio_group_list, next) {
-        QLIST_FOREACH(vbasedev, &group->device_list, next) {
-            if (vbasedev->dev->realized && vbasedev->needs_reset) {
-                vbasedev->ops->vfio_hot_reset_multi(vbasedev);
-            }
+    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
+        if (vbasedev->dev->realized && vbasedev->needs_reset) {
+            vbasedev->ops->vfio_hot_reset_multi(vbasedev);
         }
     }
 }
@@ -2643,6 +2613,7 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
     int groupid = vfio_device_groupid(vbasedev, errp);
     VFIODevice *vbasedev_iter;
     VFIOGroup *group;
+    VFIOContainer *container;
     int ret;
 
     if (groupid < 0) {
@@ -2666,8 +2637,14 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
     ret = vfio_get_device(group, name, vbasedev, errp);
     if (ret) {
         vfio_put_group(group);
+        return ret;
     }
 
+    container = group->container;
+    vbasedev->container = container;
+    QLIST_INSERT_HEAD(&container->device_list, vbasedev, container_next);
+    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
+
     return ret;
 }
 
@@ -2675,6 +2652,13 @@ void vfio_detach_device(VFIODevice *vbasedev)
 {
     VFIOGroup *group = vbasedev->group;
 
+    if (!vbasedev->container) {
+        return;
+    }
+
+    QLIST_REMOVE(vbasedev, global_next);
+    QLIST_REMOVE(vbasedev, container_next);
+    vbasedev->container = NULL;
     vfio_put_base_device(vbasedev);
     vfio_put_group(group);
 }
-- 
2.34.1


