Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D018181D4
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 08:01:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFU4H-0008KQ-UI; Tue, 19 Dec 2023 01:59:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFU4F-0008K8-T8
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 01:59:03 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFU4E-0001Yt-0S
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 01:59:03 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SvSGW6Y2yz4xQZ;
 Tue, 19 Dec 2023 17:58:59 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvSGT2F9Nz4x5q;
 Tue, 19 Dec 2023 17:58:57 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-9.0 v2 08/10] vfio/iommufd: Introduce a VFIOIOMMU iommufd
 QOM interface
Date: Tue, 19 Dec 2023 07:58:23 +0100
Message-ID: <20231219065825.613767-9-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219065825.613767-1-clg@redhat.com>
References: <20231219065825.613767-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=7/MV=H6=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

As previously done for the sPAPR and legacy IOMMU backends, convert
the VFIOIOMMUOps struct to a QOM interface. The set of of operations
for this backend can be referenced with a literal typename instead of
a C struct.

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 v2: - Removed class_size initialization
 
 include/hw/vfio/vfio-common.h         |  1 -
 include/hw/vfio/vfio-container-base.h |  2 +-
 hw/vfio/common.c                      |  2 +-
 hw/vfio/iommufd.c                     | 35 ++++++++++++++++++++-------
 4 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 14c497b6b0a79466e8f567aceed384ec2c75ea90..9b7ef7d02b5a0ad5266bcc4d06cd6874178978e4 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -210,7 +210,6 @@ typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
 typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
 extern VFIOGroupList vfio_group_list;
 extern VFIODeviceList vfio_device_list;
-extern const VFIOIOMMUOps vfio_iommufd_ops;
 extern const MemoryListener vfio_memory_listener;
 extern int vfio_kvm_device_fd;
 
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 9e21d7811f3810ca2c63d9f28bdcc9aa6f75f9ad..b2813b0c117985425c842d91f011bb895955d738 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -17,7 +17,6 @@
 
 typedef struct VFIODevice VFIODevice;
 typedef struct VFIOIOMMUClass VFIOIOMMUClass;
-#define VFIOIOMMUOps VFIOIOMMUClass /* To remove */
 
 typedef struct {
     unsigned long *bitmap;
@@ -96,6 +95,7 @@ void vfio_container_destroy(VFIOContainerBase *bcontainer);
 #define TYPE_VFIO_IOMMU "vfio-iommu"
 #define TYPE_VFIO_IOMMU_LEGACY TYPE_VFIO_IOMMU "-legacy"
 #define TYPE_VFIO_IOMMU_SPAPR TYPE_VFIO_IOMMU "-spapr"
+#define TYPE_VFIO_IOMMU_IOMMUFD TYPE_VFIO_IOMMU "-iommufd"
 
 /*
  * VFIOContainerBase is not an abstract QOM object because it felt
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 2329d0efc8c1d617f0bfee5283e82b295d2d477d..89ff1c7aeda14d20b2e24f8bc251db0a71d4527c 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1508,7 +1508,7 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
 
 #ifdef CONFIG_IOMMUFD
     if (vbasedev->iommufd) {
-        ops = &vfio_iommufd_ops;
+        ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
     }
 #endif
 
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 87a561c54580adc6d7b2711331a00940ff13bd43..d4c586e842def8f04d3a914843f5eece2c75ea30 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -319,6 +319,8 @@ static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
     int ret, devfd;
     uint32_t ioas_id;
     Error *err = NULL;
+    const VFIOIOMMUClass *iommufd_vioc =
+        VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
 
     if (vbasedev->fd < 0) {
         devfd = iommufd_cdev_getfd(vbasedev->sysfsdev, errp);
@@ -340,7 +342,7 @@ static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
     /* try to attach to an existing container in this space */
     QLIST_FOREACH(bcontainer, &space->containers, next) {
         container = container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
-        if (bcontainer->ops != &vfio_iommufd_ops ||
+        if (bcontainer->ops != iommufd_vioc ||
             vbasedev->iommufd != container->be) {
             continue;
         }
@@ -374,7 +376,7 @@ static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
     container->ioas_id = ioas_id;
 
     bcontainer = &container->bcontainer;
-    vfio_container_init(bcontainer, space, &vfio_iommufd_ops);
+    vfio_container_init(bcontainer, space, iommufd_vioc);
     QLIST_INSERT_HEAD(&space->containers, bcontainer, next);
 
     ret = iommufd_cdev_attach_container(vbasedev, container, errp);
@@ -476,9 +478,11 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
 static VFIODevice *iommufd_cdev_pci_find_by_devid(__u32 devid)
 {
     VFIODevice *vbasedev_iter;
+    const VFIOIOMMUClass *iommufd_vioc =
+        VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
 
     QLIST_FOREACH(vbasedev_iter, &vfio_device_list, global_next) {
-        if (vbasedev_iter->bcontainer->ops != &vfio_iommufd_ops) {
+        if (vbasedev_iter->bcontainer->ops != iommufd_vioc) {
             continue;
         }
         if (devid == vbasedev_iter->devid) {
@@ -621,10 +625,23 @@ out_single:
     return ret;
 }
 
-const VFIOIOMMUOps vfio_iommufd_ops = {
-    .dma_map = iommufd_cdev_map,
-    .dma_unmap = iommufd_cdev_unmap,
-    .attach_device = iommufd_cdev_attach,
-    .detach_device = iommufd_cdev_detach,
-    .pci_hot_reset = iommufd_cdev_pci_hot_reset,
+static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
+{
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
+
+    vioc->dma_map = iommufd_cdev_map;
+    vioc->dma_unmap = iommufd_cdev_unmap;
+    vioc->attach_device = iommufd_cdev_attach;
+    vioc->detach_device = iommufd_cdev_detach;
+    vioc->pci_hot_reset = iommufd_cdev_pci_hot_reset;
 };
+
+static const TypeInfo types[] = {
+    {
+        .name = TYPE_VFIO_IOMMU_IOMMUFD,
+        .parent = TYPE_VFIO_IOMMU,
+        .class_init = vfio_iommu_iommufd_class_init,
+    },
+};
+
+DEFINE_TYPES(types)
-- 
2.43.0


