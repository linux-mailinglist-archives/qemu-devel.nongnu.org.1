Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0247CD890
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 11:51:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt38M-0001Ca-7u; Wed, 18 Oct 2023 05:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=VFJy=GA=redhat.com=clg@ozlabs.org>)
 id 1qt385-0000dU-Gt
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:46:19 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=VFJy=GA=redhat.com=clg@ozlabs.org>)
 id 1qt382-0003Uq-PM
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:46:17 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S9Qw26vKCz4xbr;
 Wed, 18 Oct 2023 20:46:10 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9Qw10xkpz4xbC;
 Wed, 18 Oct 2023 20:46:08 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 12/22] vfio/common: Introduce a per container device list
Date: Wed, 18 Oct 2023 11:45:21 +0200
Message-ID: <20231018094531.733211-13-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018094531.733211-1-clg@redhat.com>
References: <20231018094531.733211-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=VFJy=GA=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Several functions need to iterate over the VFIO devices attached to
a given container.  This is currently achieved by iterating over the
groups attached to the container and then over the devices in the group.
Let's introduce a per container device list that simplifies this
search.

Per container list is used in below functions:
vfio_devices_all_dirty_tracking
vfio_devices_all_device_dirty_tracking
vfio_devices_all_running_and_mig_active
vfio_devices_dma_logging_stop
vfio_devices_dma_logging_start
vfio_devices_query_dirty_bitmap

This will also ease the migration of IOMMUFD by hiding the group
specificity.

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h |   2 +
 hw/vfio/common.c              | 141 +++++++++++++++-------------------
 2 files changed, 65 insertions(+), 78 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index c486bdef2adfe77e02f80559005d09426a7634bd..8ca70dd82156e25610fe96917843f334549818fe 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -98,6 +98,7 @@ typedef struct VFIOContainer {
     QLIST_HEAD(, VFIOGroup) group_list;
     QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
     QLIST_ENTRY(VFIOContainer) next;
+    QLIST_HEAD(, VFIODevice) device_list;
 } VFIOContainer;
 
 typedef struct VFIOGuestIOMMU {
@@ -129,6 +130,7 @@ typedef struct VFIODeviceOps VFIODeviceOps;
 
 typedef struct VFIODevice {
     QLIST_ENTRY(VFIODevice) next;
+    QLIST_ENTRY(VFIODevice) container_next;
     struct VFIOGroup *group;
     char *sysfsdev;
     char *name;
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 019da387d239cd005ab38577a68f35a013c98587..ef9dc7c74713f113a459db61aad7a017e21cf99a 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -218,7 +218,6 @@ bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
 
 static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
 {
-    VFIOGroup *group;
     VFIODevice *vbasedev;
     MigrationState *ms = migrate_get_current();
 
@@ -227,19 +226,17 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
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
@@ -247,14 +244,11 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
 
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
 
@@ -267,27 +261,24 @@ static bool vfio_devices_all_device_dirty_tracking(VFIOContainer *container)
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
@@ -1187,20 +1178,17 @@ static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
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
 
@@ -1296,24 +1284,21 @@ static void vfio_devices_dma_logging_stop(VFIOContainer *container)
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
 
@@ -1396,7 +1381,6 @@ static int vfio_devices_dma_logging_start(VFIOContainer *container)
     struct vfio_device_feature *feature;
     VFIODirtyRanges ranges;
     VFIODevice *vbasedev;
-    VFIOGroup *group;
     int ret = 0;
 
     vfio_dirty_tracking_init(container, &ranges);
@@ -1406,21 +1390,19 @@ static int vfio_devices_dma_logging_start(VFIOContainer *container)
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
@@ -1500,21 +1482,18 @@ static int vfio_devices_query_dirty_bitmap(VFIOContainer *container,
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
 
@@ -2648,6 +2627,7 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
     int groupid = vfio_device_groupid(vbasedev, errp);
     VFIODevice *vbasedev_iter;
     VFIOGroup *group;
+    VFIOContainer *container;
     int ret;
 
     if (groupid < 0) {
@@ -2671,8 +2651,12 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
     ret = vfio_get_device(group, name, vbasedev, errp);
     if (ret) {
         vfio_put_group(group);
+        return ret;
     }
 
+    container = group->container;
+    QLIST_INSERT_HEAD(&container->device_list, vbasedev, container_next);
+
     return ret;
 }
 
@@ -2680,6 +2664,7 @@ void vfio_detach_device(VFIODevice *vbasedev)
 {
     VFIOGroup *group = vbasedev->group;
 
+    QLIST_REMOVE(vbasedev, container_next);
     trace_vfio_detach_device(vbasedev->name, group->groupid);
     vfio_put_base_device(vbasedev);
     vfio_put_group(group);
-- 
2.41.0


