Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 789237CA271
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 10:49:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJGf-0007jx-9r; Mon, 16 Oct 2023 04:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJGc-0007jY-EC
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:48:02 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJGa-0001Al-4W
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697446080; x=1728982080;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TkN681/KObc4X+pDGx/3PsHpoCt2Br6pYChqRu2oqZ8=;
 b=AYqRMR2grnkJ47dBSC+sF+eMPdwkkYTO/6F7wpCm2F+MyXkzGkhTx2g8
 1y+gj8gVprij3kAURhZFnqVdp7JjrYipaSUKacMraD43BFDx3Kwmz2RND
 NORtzcc64r5lexRNmsa6KkyAEbYNnvAmi5VBfc4GYcKdY5asOciTN4ijm
 FOWoXtTbTtAl6kQhdh826a8Cv9NsYOlsa5lZsiEI76zlTTFvHTzgJB1Pv
 cxWS1czVd3wkr3qhT0druuChSOKpaGwL7RiaMcQaGA9ef4xotRpKjhbbJ
 4KzjGuBNvs8u48BsIXG+a6YZh+n66sORRcJw8dc9XOAdWWPiUGyUH9Gjk Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="365737600"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="365737600"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:47:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="749222862"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="749222862"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:47:55 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 10/27] vfio/container: Move per container device list in
 base container
Date: Mon, 16 Oct 2023 16:32:06 +0800
Message-Id: <20231016083223.1519410-11-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016083223.1519410-1-zhenzhong.duan@intel.com>
References: <20231016083223.1519410-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.151;
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

VFIO Device is also changed to point to base container instead of
legacy container.

No fucntional change intended.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h         |  3 +--
 include/hw/vfio/vfio-container-base.h |  1 +
 hw/vfio/common.c                      | 23 +++++++++++++++--------
 hw/vfio/container.c                   | 12 ++++++------
 4 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 39bcc7ec33..6979359457 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -89,7 +89,6 @@ typedef struct VFIOLegacyContainer {
     unsigned int dma_max_mappings;
     QLIST_HEAD(, VFIOGroup) group_list;
     QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
-    QLIST_HEAD(, VFIODevice) device_list;
 } VFIOLegacyContainer;
 
 typedef struct VFIORamDiscardListener {
@@ -109,7 +108,7 @@ typedef struct VFIODevice {
     QLIST_ENTRY(VFIODevice) container_next;
     QLIST_ENTRY(VFIODevice) global_next;
     struct VFIOGroup *group;
-    VFIOLegacyContainer *container;
+    VFIOContainer *bcontainer;
     char *sysfsdev;
     char *name;
     DeviceState *dev;
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 5ab52774b5..49637a1e6c 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -70,6 +70,7 @@ struct VFIOContainer {
     QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
     QLIST_ENTRY(VFIOContainer) next;
+    QLIST_HEAD(, VFIODevice) device_list;
 };
 
 int vfio_container_dma_map(VFIOContainer *bcontainer,
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 855d6d82d0..7350af038a 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -152,7 +152,7 @@ void vfio_unblock_multiple_devices_migration(void)
 
 bool vfio_viommu_preset(VFIODevice *vbasedev)
 {
-    return vbasedev->container->bcontainer.space->as != &address_space_memory;
+    return vbasedev->bcontainer->space->as != &address_space_memory;
 }
 
 static void vfio_set_migration_error(int err)
@@ -186,6 +186,7 @@ bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
 
 static bool vfio_devices_all_dirty_tracking(VFIOLegacyContainer *container)
 {
+    VFIOContainer *bcontainer = &container->bcontainer;
     VFIODevice *vbasedev;
     MigrationState *ms = migrate_get_current();
 
@@ -194,7 +195,7 @@ static bool vfio_devices_all_dirty_tracking(VFIOLegacyContainer *container)
         return false;
     }
 
-    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
+    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
         VFIOMigration *migration = vbasedev->migration;
 
         if (!migration) {
@@ -212,9 +213,10 @@ static bool vfio_devices_all_dirty_tracking(VFIOLegacyContainer *container)
 
 bool vfio_devices_all_device_dirty_tracking(VFIOLegacyContainer *container)
 {
+    VFIOContainer *bcontainer = &container->bcontainer;
     VFIODevice *vbasedev;
 
-    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
+    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
         if (!vbasedev->dirty_pages_supported) {
             return false;
         }
@@ -229,13 +231,14 @@ bool vfio_devices_all_device_dirty_tracking(VFIOLegacyContainer *container)
  */
 bool vfio_devices_all_running_and_mig_active(VFIOLegacyContainer *container)
 {
+    VFIOContainer *bcontainer = &container->bcontainer;
     VFIODevice *vbasedev;
 
     if (!migration_is_active(migrate_get_current())) {
         return false;
     }
 
-    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
+    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
         VFIOMigration *migration = vbasedev->migration;
 
         if (!migration) {
@@ -901,12 +904,13 @@ static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
                                      VFIOLegacyContainer *container)
 {
     VFIOPCIDevice *pcidev;
+    VFIOContainer *bcontainer = &container->bcontainer;
     VFIODevice *vbasedev;
     Object *owner;
 
     owner = memory_region_owner(section->mr);
 
-    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
+    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
         if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
             continue;
         }
@@ -1007,13 +1011,14 @@ static void vfio_devices_dma_logging_stop(VFIOLegacyContainer *container)
     uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
                               sizeof(uint64_t))] = {};
     struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
+    VFIOContainer *bcontainer = &container->bcontainer;
     VFIODevice *vbasedev;
 
     feature->argsz = sizeof(buf);
     feature->flags = VFIO_DEVICE_FEATURE_SET |
                      VFIO_DEVICE_FEATURE_DMA_LOGGING_STOP;
 
-    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
+    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
         if (!vbasedev->dirty_tracking) {
             continue;
         }
@@ -1104,6 +1109,7 @@ static int vfio_devices_dma_logging_start(VFIOLegacyContainer *container)
 {
     struct vfio_device_feature *feature;
     VFIODirtyRanges ranges;
+    VFIOContainer *bcontainer = &container->bcontainer;
     VFIODevice *vbasedev;
     int ret = 0;
 
@@ -1114,7 +1120,7 @@ static int vfio_devices_dma_logging_start(VFIOLegacyContainer *container)
         return -errno;
     }
 
-    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
+    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
         if (vbasedev->dirty_tracking) {
             continue;
         }
@@ -1211,10 +1217,11 @@ int vfio_devices_query_dirty_bitmap(VFIOLegacyContainer *container,
                                     VFIOBitmap *vbmap, hwaddr iova,
                                     hwaddr size)
 {
+    VFIOContainer *bcontainer = &container->bcontainer;
     VFIODevice *vbasedev;
     int ret;
 
-    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
+    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
         ret = vfio_device_dma_logging_report(vbasedev, iova, size,
                                              vbmap->bitmap);
         if (ret) {
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 26617afaa9..edcdee2904 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1123,7 +1123,7 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
     int groupid = vfio_device_groupid(vbasedev, errp);
     VFIODevice *vbasedev_iter;
     VFIOGroup *group;
-    VFIOLegacyContainer *container;
+    VFIOContainer *bcontainer;
     int ret;
 
     if (groupid < 0) {
@@ -1150,9 +1150,9 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
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
@@ -1162,13 +1162,13 @@ void vfio_detach_device(VFIODevice *vbasedev)
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


