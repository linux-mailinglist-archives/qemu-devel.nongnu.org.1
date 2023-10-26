Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9767D811F
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 12:48:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvxtC-0007Yy-Mg; Thu, 26 Oct 2023 06:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxt8-0007XV-V2; Thu, 26 Oct 2023 06:46:55 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxt6-0001Kb-Ue; Thu, 26 Oct 2023 06:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698317212; x=1729853212;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4MsmyFCLG1GX+yRd8MfR70wbqbPBpwnJkOKo9nrwlRk=;
 b=ZnX6wEqCd3uA+CmiCko49kLD/LQtwUqUgsuqjQEFQB4EUHDgb5BoGUrl
 Of0KPWv7fTSmVaAfmbK0gHQulHp53JbNZ6h5kHtHTAM0EG0eMbQqxmSUu
 mqVCkbNlGq4ABQEeFAyJiU5W3IqfSsCz1vcPAPDWzsuMlnblKZqTEhHu9
 MIk8fcLTNseptcCCxwj4Ny5sRlFbvSngC9tENTrFYv+/1PPiD/W10Uaaq
 6dBCKIz80W+/U2OzcBPzrLeGf3IOWZmAMz/VeqPCkqEAuqBZFzmqdkgST
 Ci0FyJbUCrFbkQNaJK4nCBMD4PwsbDcn4prKDKT4H3hr5SBqvbGcfTm9m A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="372563285"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; d="scan'208";a="372563285"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:46:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="463633"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:46:35 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 qemu-ppc@nongnu.org (open list:sPAPR (pseries))
Subject: [PATCH v3 10/37] vfio/container: Move space field to base container
Date: Thu, 26 Oct 2023 18:30:37 +0800
Message-Id: <20231026103104.1686921-11-zhenzhong.duan@intel.com>
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

From: Eric Auger <eric.auger@redhat.com>

Move the space field to the base object. Also the VFIOAddressSpace
now contains a list of base containers.

No fucntional change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
[ clg: context changes ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h         |  8 --------
 include/hw/vfio/vfio-container-base.h |  9 +++++++++
 hw/ppc/spapr_pci_vfio.c               | 10 +++++-----
 hw/vfio/common.c                      |  4 ++--
 hw/vfio/container-base.c              |  6 +++++-
 hw/vfio/container.c                   | 18 +++++++++---------
 6 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index fcb4003a21..857d2b8076 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -73,17 +73,10 @@ typedef struct VFIOMigration {
     bool initial_data_sent;
 } VFIOMigration;
 
-typedef struct VFIOAddressSpace {
-    AddressSpace *as;
-    QLIST_HEAD(, VFIOContainer) containers;
-    QLIST_ENTRY(VFIOAddressSpace) list;
-} VFIOAddressSpace;
-
 struct VFIOGroup;
 
 typedef struct VFIOContainer {
     VFIOContainerBase bcontainer;
-    VFIOAddressSpace *space;
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
     MemoryListener listener;
     MemoryListener prereg_listener;
@@ -98,7 +91,6 @@ typedef struct VFIOContainer {
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
     QLIST_HEAD(, VFIOGroup) group_list;
     QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
-    QLIST_ENTRY(VFIOContainer) next;
     QLIST_HEAD(, VFIODevice) device_list;
     GList *iova_ranges;
 } VFIOContainer;
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 71e1e4324e..a5fef3e6a8 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -38,12 +38,20 @@ typedef struct {
     hwaddr pages;
 } VFIOBitmap;
 
+typedef struct VFIOAddressSpace {
+    AddressSpace *as;
+    QLIST_HEAD(, VFIOContainerBase) containers;
+    QLIST_ENTRY(VFIOAddressSpace) list;
+} VFIOAddressSpace;
+
 /*
  * This is the base object for vfio container backends
  */
 typedef struct VFIOContainerBase {
     const VFIOIOMMUOps *ops;
+    VFIOAddressSpace *space;
     QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
+    QLIST_ENTRY(VFIOContainerBase) next;
 } VFIOContainerBase;
 
 typedef struct VFIOGuestIOMMU {
@@ -62,6 +70,7 @@ int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
                              IOMMUTLBEntry *iotlb);
 
 void vfio_container_init(VFIOContainerBase *bcontainer,
+                         VFIOAddressSpace *space,
                          const VFIOIOMMUOps *ops);
 void vfio_container_destroy(VFIOContainerBase *bcontainer);
 
diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index f283f7e38d..d1d07bec46 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -84,27 +84,27 @@ static int vfio_eeh_container_op(VFIOContainer *container, uint32_t op)
 static VFIOContainer *vfio_eeh_as_container(AddressSpace *as)
 {
     VFIOAddressSpace *space = vfio_get_address_space(as);
-    VFIOContainer *container = NULL;
+    VFIOContainerBase *bcontainer = NULL;
 
     if (QLIST_EMPTY(&space->containers)) {
         /* No containers to act on */
         goto out;
     }
 
-    container = QLIST_FIRST(&space->containers);
+    bcontainer = QLIST_FIRST(&space->containers);
 
-    if (QLIST_NEXT(container, next)) {
+    if (QLIST_NEXT(bcontainer, next)) {
         /*
          * We don't yet have logic to synchronize EEH state across
          * multiple containers
          */
-        container = NULL;
+        bcontainer = NULL;
         goto out;
     }
 
 out:
     vfio_put_address_space(space);
-    return container;
+    return container_of(bcontainer, VFIOContainer, bcontainer);
 }
 
 static bool vfio_eeh_as_ok(AddressSpace *as)
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 4f130ad87c..f87a0dcec3 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -145,7 +145,7 @@ void vfio_unblock_multiple_devices_migration(void)
 
 bool vfio_viommu_preset(VFIODevice *vbasedev)
 {
-    return vbasedev->container->space->as != &address_space_memory;
+    return vbasedev->container->bcontainer.space->as != &address_space_memory;
 }
 
 static void vfio_set_migration_error(int err)
@@ -924,7 +924,7 @@ static void vfio_dirty_tracking_init(VFIOContainer *container,
     dirty.container = container;
 
     memory_listener_register(&dirty.listener,
-                             container->space->as);
+                             container->bcontainer.space->as);
 
     *ranges = dirty.ranges;
 
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 6be7ce65ad..99b2957d7b 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -48,9 +48,11 @@ int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
     return bcontainer->ops->dma_unmap(bcontainer, iova, size, iotlb);
 }
 
-void vfio_container_init(VFIOContainerBase *bcontainer, const VFIOIOMMUOps *ops)
+void vfio_container_init(VFIOContainerBase *bcontainer, VFIOAddressSpace *space,
+                         const VFIOIOMMUOps *ops)
 {
     bcontainer->ops = ops;
+    bcontainer->space = space;
     QLIST_INIT(&bcontainer->giommu_list);
 }
 
@@ -58,6 +60,8 @@ void vfio_container_destroy(VFIOContainerBase *bcontainer)
 {
     VFIOGuestIOMMU *giommu, *tmp;
 
+    QLIST_REMOVE(bcontainer, next);
+
     QLIST_FOREACH_SAFE(giommu, &bcontainer->giommu_list, giommu_next, tmp) {
         memory_region_unregister_iommu_notifier(
                 MEMORY_REGION(giommu->iommu_mr), &giommu->n);
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index b2b6e05287..761310fa51 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -514,7 +514,8 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
      * details once we know which type of IOMMU we are using.
      */
 
-    QLIST_FOREACH(container, &space->containers, next) {
+    QLIST_FOREACH(bcontainer, &space->containers, next) {
+        container = container_of(bcontainer, VFIOContainer, bcontainer);
         if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
             ret = vfio_ram_block_discard_disable(container, true);
             if (ret) {
@@ -550,7 +551,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     }
 
     container = g_malloc0(sizeof(*container));
-    container->space = space;
     container->fd = fd;
     container->error = NULL;
     container->dirty_pages_supported = false;
@@ -558,7 +558,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     container->iova_ranges = NULL;
     QLIST_INIT(&container->vrdl_list);
     bcontainer = &container->bcontainer;
-    vfio_container_init(bcontainer, &vfio_legacy_ops);
+    vfio_container_init(bcontainer, space, &vfio_legacy_ops);
 
     ret = vfio_init_container(container, group->fd, errp);
     if (ret) {
@@ -613,14 +613,15 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     vfio_kvm_device_add_group(group);
 
     QLIST_INIT(&container->group_list);
-    QLIST_INSERT_HEAD(&space->containers, container, next);
+    QLIST_INSERT_HEAD(&space->containers, bcontainer, next);
 
     group->container = container;
     QLIST_INSERT_HEAD(&container->group_list, group, container_next);
 
     container->listener = vfio_memory_listener;
 
-    memory_listener_register(&container->listener, container->space->as);
+    memory_listener_register(&container->listener,
+                             container->bcontainer.space->as);
 
     if (container->error) {
         ret = -1;
@@ -634,7 +635,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     return 0;
 listener_release_exit:
     QLIST_REMOVE(group, container_next);
-    QLIST_REMOVE(container, next);
+    QLIST_REMOVE(bcontainer, next);
     vfio_kvm_device_del_group(group);
     memory_listener_unregister(&container->listener);
     if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU ||
@@ -684,9 +685,8 @@ static void vfio_disconnect_container(VFIOGroup *group)
     }
 
     if (QLIST_EMPTY(&container->group_list)) {
-        VFIOAddressSpace *space = container->space;
+        VFIOAddressSpace *space = container->bcontainer.space;
 
-        QLIST_REMOVE(container, next);
         vfio_container_destroy(bcontainer);
 
         trace_vfio_disconnect_container(container->fd);
@@ -706,7 +706,7 @@ static VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
     QLIST_FOREACH(group, &vfio_group_list, next) {
         if (group->groupid == groupid) {
             /* Found it.  Now is it already in the right context? */
-            if (group->container->space->as == as) {
+            if (group->container->bcontainer.space->as == as) {
                 return group;
             } else {
                 error_setg(errp, "group %d used in multiple address spaces",
-- 
2.34.1


