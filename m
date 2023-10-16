Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9906B7CA25B
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 10:49:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJGU-0007hZ-Dz; Mon, 16 Oct 2023 04:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJGM-0007an-Qt
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:47:52 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJGJ-0001AB-U8
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697446063; x=1728982063;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+pVnJWeuf5IGR1SJs6p3ezEqVedUcS3tsyfw5pT1jVU=;
 b=jm7N93/PmxKXQ7xZ6YRe53BJZzg3fZixmhcCYpskAXoXJQj0PvALn3u5
 bjoB6AkrmWqlPjM1sjTsYtXy85RUwuKpzT1gNlUpf0M3e5ZVNH6jOxWeM
 WUZUdvw0UqkqP24iyuf1Bb+V1ZiCd8TIMQ7fc1r2ChHZZ6+GBpcTlYpjt
 /MM/t9euaUt93FNuiuLZaIiXmqrxU3KcZz97ZGsC9pyvju4xx+yS8CQjC
 MPCLMCymYhUiL45k6tK1kx05CrVlrUSTgURJJLSZ1S97cph45vtGeT2aT
 ebyWiQUu4LS7x6ExaflnImbdWBYqoUEfW7w335z3vTxPkMaun/V4faGO4 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="365737546"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="365737546"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:47:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="749222709"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="749222709"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:47:38 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 06/27] vfio/container: Move space field to base container
Date: Mon, 16 Oct 2023 16:32:02 +0800
Message-Id: <20231016083223.1519410-7-zhenzhong.duan@intel.com>
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

From: Eric Auger <eric.auger@redhat.com>

Move the space field to the base object. Also the VFIOAddressSpace
now contains a list of base containers.

No fucntional change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h         |  8 --------
 include/hw/vfio/vfio-container-base.h |  9 +++++++++
 hw/vfio/common.c                      |  4 ++--
 hw/vfio/container-base.c              |  4 ++++
 hw/vfio/container.c                   | 28 +++++++++++++--------------
 5 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 884d1627f4..33f475957c 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -73,17 +73,10 @@ typedef struct VFIOMigration {
     bool initial_data_sent;
 } VFIOMigration;
 
-typedef struct VFIOAddressSpace {
-    AddressSpace *as;
-    QLIST_HEAD(, VFIOLegacyContainer) containers;
-    QLIST_ENTRY(VFIOAddressSpace) list;
-} VFIOAddressSpace;
-
 struct VFIOGroup;
 
 typedef struct VFIOLegacyContainer {
     VFIOContainer bcontainer;
-    VFIOAddressSpace *space;
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
     MemoryListener listener;
     MemoryListener prereg_listener;
@@ -98,7 +91,6 @@ typedef struct VFIOLegacyContainer {
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
     QLIST_HEAD(, VFIOGroup) group_list;
     QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
-    QLIST_ENTRY(VFIOLegacyContainer) next;
     QLIST_HEAD(, VFIODevice) device_list;
 } VFIOLegacyContainer;
 
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index b6c8eb2313..9504564f4e 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -33,6 +33,12 @@ typedef struct VFIOContainer VFIOContainer;
 typedef struct VFIODevice VFIODevice;
 typedef struct VFIOIOMMUBackendOpsClass VFIOIOMMUBackendOpsClass;
 
+typedef struct VFIOAddressSpace {
+    AddressSpace *as;
+    QLIST_HEAD(, VFIOContainer) containers;
+    QLIST_ENTRY(VFIOAddressSpace) list;
+} VFIOAddressSpace;
+
 typedef struct VFIOGuestIOMMU {
     VFIOContainer *bcontainer;
     IOMMUMemoryRegion *iommu_mr;
@@ -52,7 +58,9 @@ typedef struct {
  */
 struct VFIOContainer {
     VFIOIOMMUBackendOpsClass *ops;
+    VFIOAddressSpace *space;
     QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
+    QLIST_ENTRY(VFIOContainer) next;
 };
 
 int vfio_container_dma_map(VFIOContainer *bcontainer,
@@ -63,6 +71,7 @@ int vfio_container_dma_unmap(VFIOContainer *bcontainer,
                              IOMMUTLBEntry *iotlb);
 
 void vfio_container_init(VFIOContainer *bcontainer,
+                         VFIOAddressSpace *space,
                          struct VFIOIOMMUBackendOpsClass *ops);
 void vfio_container_destroy(VFIOContainer *bcontainer);
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 1adfdca4f5..c92af34eed 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -152,7 +152,7 @@ void vfio_unblock_multiple_devices_migration(void)
 
 bool vfio_viommu_preset(VFIODevice *vbasedev)
 {
-    return vbasedev->container->space->as != &address_space_memory;
+    return vbasedev->container->bcontainer.space->as != &address_space_memory;
 }
 
 static void vfio_set_migration_error(int err)
@@ -990,7 +990,7 @@ static void vfio_dirty_tracking_init(VFIOLegacyContainer *container,
     dirty.container = container;
 
     memory_listener_register(&dirty.listener,
-                             container->space->as);
+                             container->bcontainer.space->as);
 
     *ranges = dirty.ranges;
 
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 6da50e8151..e1056dd78e 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -49,9 +49,11 @@ int vfio_container_dma_unmap(VFIOContainer *bcontainer,
 }
 
 void vfio_container_init(VFIOContainer *bcontainer,
+                         VFIOAddressSpace *space,
                          struct VFIOIOMMUBackendOpsClass *ops)
 {
     bcontainer->ops = ops;
+    bcontainer->space = space;
     QLIST_INIT(&bcontainer->giommu_list);
 }
 
@@ -59,6 +61,8 @@ void vfio_container_destroy(VFIOContainer *bcontainer)
 {
     VFIOGuestIOMMU *giommu, *tmp;
 
+    QLIST_REMOVE(bcontainer, next);
+
     QLIST_FOREACH_SAFE(giommu, &bcontainer->giommu_list, giommu_next, tmp) {
         memory_region_unregister_iommu_notifier(
                 MEMORY_REGION(giommu->iommu_mr), &giommu->n);
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index de6b018eeb..fd2d602fb9 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -588,7 +588,8 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
      * details once we know which type of IOMMU we are using.
      */
 
-    QLIST_FOREACH(container, &space->containers, next) {
+    QLIST_FOREACH(bcontainer, &space->containers, next) {
+        container = container_of(bcontainer, VFIOLegacyContainer, bcontainer);
         if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
             ret = vfio_ram_block_discard_disable(container, true);
             if (ret) {
@@ -624,7 +625,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     }
 
     container = g_malloc0(sizeof(*container));
-    container->space = space;
     container->fd = fd;
     container->error = NULL;
     container->dirty_pages_supported = false;
@@ -632,7 +632,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     QLIST_INIT(&container->hostwin_list);
     QLIST_INIT(&container->vrdl_list);
     bcontainer = &container->bcontainer;
-    vfio_container_init(bcontainer, ops);
+    vfio_container_init(bcontainer, space, ops);
 
     ret = vfio_init_container(container, group->fd, errp);
     if (ret) {
@@ -750,14 +750,15 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
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
@@ -771,7 +772,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     return 0;
 listener_release_exit:
     QLIST_REMOVE(group, container_next);
-    QLIST_REMOVE(container, next);
+    QLIST_REMOVE(bcontainer, next);
     vfio_kvm_device_del_group(group);
     vfio_listener_release(container);
 
@@ -813,10 +814,9 @@ static void vfio_disconnect_container(VFIOGroup *group)
     }
 
     if (QLIST_EMPTY(&container->group_list)) {
-        VFIOAddressSpace *space = container->space;
+        VFIOAddressSpace *space = container->bcontainer.space;
         VFIOHostDMAWindow *hostwin, *next;
 
-        QLIST_REMOVE(container, next);
         vfio_container_destroy(bcontainer);
 
         QLIST_FOREACH_SAFE(hostwin, &container->hostwin_list, hostwin_next,
@@ -842,7 +842,7 @@ static VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
     QLIST_FOREACH(group, &vfio_group_list, next) {
         if (group->groupid == groupid) {
             /* Found it.  Now is it already in the right context? */
-            if (group->container->space->as == as) {
+            if (group->container->bcontainer.space->as == as) {
                 return group;
             } else {
                 error_setg(errp, "group %d used in multiple address spaces",
@@ -1040,27 +1040,27 @@ static int vfio_eeh_container_op(VFIOLegacyContainer *container, uint32_t op)
 static VFIOLegacyContainer *vfio_eeh_as_container(AddressSpace *as)
 {
     VFIOAddressSpace *space = vfio_get_address_space(as);
-    VFIOLegacyContainer *container = NULL;
+    VFIOContainer *bcontainer = NULL;
 
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
+    return container_of(bcontainer, VFIOLegacyContainer, bcontainer);
 }
 
 bool vfio_eeh_as_ok(AddressSpace *as)
-- 
2.34.1


