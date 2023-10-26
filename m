Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 813B97D8116
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 12:48:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvxti-0008E5-Jh; Thu, 26 Oct 2023 06:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxtf-00088B-Pa
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 06:47:27 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxtd-0001Nq-Ku
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 06:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698317245; x=1729853245;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8Q9n3gWiCRR4PqU+IktZvocxRr0g9kjMU/I1dH7+vfw=;
 b=MYuUcIN4yfsmb4FAI6Az1VGMde8aqW6JEPgnQ589mtPdKUFxf85xB0QL
 q5a8OHkNfmkPqPZQ91ZNS2scRzNO6pDjnVy1e7ebB4RRyKsLqcwdJIhzU
 Gof9SNKzdE4CN02TYLJnlcSOC8mQC5YaVvGhUn4z9bo55v2XabNFMpgcK
 GGJKF4gn0iZWKapARuItOc4wuh2Kdx44fj11sa/OQBdfWb9RaEMhNmkMW
 RepI+RBKWIHZBXlbN+BiTKejjaN727BH0WCjh9jBG0QKoDRjI2p4buDKc
 5GSykKyM2moDIKKHpUUA9jOqeKIzyYuG1OBx6wbO+66vpcuDwDPoDByqC A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="372563350"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; d="scan'208";a="372563350"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:46:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="463653"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:46:44 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 12/37] vfio/container: Move per container device list in
 base container
Date: Thu, 26 Oct 2023 18:30:39 +0800
Message-Id: <20231026103104.1686921-13-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

VFIO Device is also changed to point to base container instead of
legacy container.

No fucntional change intended.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
[ clg: context changes ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h         |  3 +--
 include/hw/vfio/vfio-container-base.h |  1 +
 hw/vfio/common.c                      | 23 +++++++++++++++--------
 hw/vfio/container.c                   | 12 ++++++------
 4 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index d053c61872..f7a84dc8d0 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -90,7 +90,6 @@ typedef struct VFIOContainer {
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
     QLIST_HEAD(, VFIOGroup) group_list;
     QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
-    QLIST_HEAD(, VFIODevice) device_list;
     GList *iova_ranges;
 } VFIOContainer;
 
@@ -118,7 +117,7 @@ typedef struct VFIODevice {
     QLIST_ENTRY(VFIODevice) container_next;
     QLIST_ENTRY(VFIODevice) global_next;
     struct VFIOGroup *group;
-    VFIOContainer *container;
+    VFIOContainerBase *bcontainer;
     char *sysfsdev;
     char *name;
     DeviceState *dev;
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index ea8436a064..f1de1ef120 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -53,6 +53,7 @@ typedef struct VFIOContainerBase {
     bool dirty_pages_supported;
     QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
     QLIST_ENTRY(VFIOContainerBase) next;
+    QLIST_HEAD(, VFIODevice) device_list;
 } VFIOContainerBase;
 
 typedef struct VFIOGuestIOMMU {
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7d9b87fc67..f8475348ad 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -145,7 +145,7 @@ void vfio_unblock_multiple_devices_migration(void)
 
 bool vfio_viommu_preset(VFIODevice *vbasedev)
 {
-    return vbasedev->container->bcontainer.space->as != &address_space_memory;
+    return vbasedev->bcontainer->space->as != &address_space_memory;
 }
 
 static void vfio_set_migration_error(int err)
@@ -179,6 +179,7 @@ bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
 
 static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
 {
+    VFIOContainerBase *bcontainer = &container->bcontainer;
     VFIODevice *vbasedev;
     MigrationState *ms = migrate_get_current();
 
@@ -187,7 +188,7 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
         return false;
     }
 
-    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
+    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
         VFIOMigration *migration = vbasedev->migration;
 
         if (!migration) {
@@ -205,9 +206,10 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
 
 bool vfio_devices_all_device_dirty_tracking(VFIOContainer *container)
 {
+    VFIOContainerBase *bcontainer = &container->bcontainer;
     VFIODevice *vbasedev;
 
-    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
+    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
         if (!vbasedev->dirty_pages_supported) {
             return false;
         }
@@ -222,13 +224,14 @@ bool vfio_devices_all_device_dirty_tracking(VFIOContainer *container)
  */
 bool vfio_devices_all_running_and_mig_active(VFIOContainer *container)
 {
+    VFIOContainerBase *bcontainer = &container->bcontainer;
     VFIODevice *vbasedev;
 
     if (!migration_is_active(migrate_get_current())) {
         return false;
     }
 
-    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
+    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
         VFIOMigration *migration = vbasedev->migration;
 
         if (!migration) {
@@ -835,12 +838,13 @@ static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
                                      VFIOContainer *container)
 {
     VFIOPCIDevice *pcidev;
+    VFIOContainerBase *bcontainer = &container->bcontainer;
     VFIODevice *vbasedev;
     Object *owner;
 
     owner = memory_region_owner(section->mr);
 
-    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
+    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
         if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
             continue;
         }
@@ -941,13 +945,14 @@ static void vfio_devices_dma_logging_stop(VFIOContainer *container)
     uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
                               sizeof(uint64_t))] = {};
     struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
+    VFIOContainerBase *bcontainer = &container->bcontainer;
     VFIODevice *vbasedev;
 
     feature->argsz = sizeof(buf);
     feature->flags = VFIO_DEVICE_FEATURE_SET |
                      VFIO_DEVICE_FEATURE_DMA_LOGGING_STOP;
 
-    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
+    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
         if (!vbasedev->dirty_tracking) {
             continue;
         }
@@ -1038,6 +1043,7 @@ static int vfio_devices_dma_logging_start(VFIOContainer *container)
 {
     struct vfio_device_feature *feature;
     VFIODirtyRanges ranges;
+    VFIOContainerBase *bcontainer = &container->bcontainer;
     VFIODevice *vbasedev;
     int ret = 0;
 
@@ -1048,7 +1054,7 @@ static int vfio_devices_dma_logging_start(VFIOContainer *container)
         return -errno;
     }
 
-    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
+    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
         if (vbasedev->dirty_tracking) {
             continue;
         }
@@ -1141,10 +1147,11 @@ int vfio_devices_query_dirty_bitmap(VFIOContainer *container,
                                     VFIOBitmap *vbmap, hwaddr iova,
                                     hwaddr size)
 {
+    VFIOContainerBase *bcontainer = &container->bcontainer;
     VFIODevice *vbasedev;
     int ret;
 
-    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
+    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
         ret = vfio_device_dma_logging_report(vbasedev, iova, size,
                                              vbmap->bitmap);
         if (ret) {
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 6f02ca133e..3228dd2109 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -889,7 +889,7 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
     int groupid = vfio_device_groupid(vbasedev, errp);
     VFIODevice *vbasedev_iter;
     VFIOGroup *group;
-    VFIOContainer *container;
+    VFIOContainerBase *bcontainer;
     int ret;
 
     if (groupid < 0) {
@@ -916,9 +916,9 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
         return ret;
     }
 
-    container = group->container;
-    vbasedev->container = container;
-    QLIST_INSERT_HEAD(&container->device_list, vbasedev, container_next);
+    bcontainer = &group->container->bcontainer;
+    vbasedev->bcontainer = bcontainer;
+    QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
     QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
 
     return ret;
@@ -928,13 +928,13 @@ void vfio_detach_device(VFIODevice *vbasedev)
 {
     VFIOGroup *group = vbasedev->group;
 
-    if (!vbasedev->container) {
+    if (!vbasedev->bcontainer) {
         return;
     }
 
     QLIST_REMOVE(vbasedev, global_next);
     QLIST_REMOVE(vbasedev, container_next);
-    vbasedev->container = NULL;
+    vbasedev->bcontainer = NULL;
     trace_vfio_detach_device(vbasedev->name, group->groupid);
     vfio_put_base_device(vbasedev);
     vfio_put_group(group);
-- 
2.34.1


