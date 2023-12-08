Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F32809E93
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 09:48:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBWVT-00063i-2f; Fri, 08 Dec 2023 03:46:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7WKM=HT=redhat.com=clg@ozlabs.org>)
 id 1rBWVL-0005zS-9l
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 03:46:39 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7WKM=HT=redhat.com=clg@ozlabs.org>)
 id 1rBWVE-0000lB-TK
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 03:46:37 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Sml9c0V5Dz4x3G;
 Fri,  8 Dec 2023 19:46:28 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sml9Y24K0z4x1v;
 Fri,  8 Dec 2023 19:46:24 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-9.0 05/10] vfio/container: Introduce a VFIOIOMMU legacy
 QOM interface
Date: Fri,  8 Dec 2023 09:45:55 +0100
Message-ID: <20231208084600.858964-6-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231208084600.858964-1-clg@redhat.com>
References: <20231208084600.858964-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=7WKM=HT=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Convert the legacy VFIOIOMMUOps struct to the new VFIOIOMMU QOM
interface. The set of of operations for this backend can be referenced
with a literal typename instead of a C struct. This will simplify
support of multiple backends.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h         |  1 -
 include/hw/vfio/vfio-container-base.h |  1 +
 hw/vfio/common.c                      |  6 ++-
 hw/vfio/container.c                   | 59 +++++++++++++++++++++++----
 4 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index b8aa8a549532442a31c8e85ce385c992d84f6bd5..14c497b6b0a79466e8f567aceed384ec2c75ea90 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -210,7 +210,6 @@ typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
 typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
 extern VFIOGroupList vfio_group_list;
 extern VFIODeviceList vfio_device_list;
-extern const VFIOIOMMUOps vfio_legacy_ops;
 extern const VFIOIOMMUOps vfio_iommufd_ops;
 extern const MemoryListener vfio_memory_listener;
 extern int vfio_kvm_device_fd;
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 81d49fe562d3840859096dd8a62ac38d62314939..a31fd9c2e3b9a571083ea8987ac27e91b332c170 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -95,6 +95,7 @@ void vfio_container_destroy(VFIOContainerBase *bcontainer);
 typedef struct VFIOIOMMU VFIOIOMMU;
 
 #define TYPE_VFIO_IOMMU "vfio-iommu"
+#define TYPE_VFIO_IOMMU_LEGACY TYPE_VFIO_IOMMU "-legacy"
 
 #define VFIO_IOMMU(obj) INTERFACE_CHECK(VFIOIOMMU, (obj), TYPE_VFIO_IOMMU)
 DECLARE_CLASS_CHECKERS(VFIOIOMMUClass, VFIO_IOMMU, TYPE_VFIO_IOMMU)
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 49dab41566f07ba7be1100fed1973e028d34467c..2329d0efc8c1d617f0bfee5283e82b295d2d477d 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1503,13 +1503,17 @@ retry:
 int vfio_attach_device(char *name, VFIODevice *vbasedev,
                        AddressSpace *as, Error **errp)
 {
-    const VFIOIOMMUClass *ops = &vfio_legacy_ops;
+    const VFIOIOMMUClass *ops =
+        VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
 
 #ifdef CONFIG_IOMMUFD
     if (vbasedev->iommufd) {
         ops = &vfio_iommufd_ops;
     }
 #endif
+
+    assert(ops);
+
     return ops->attach_device(name, vbasedev, as, errp);
 }
 
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index f4a0434a5239bfb6a17b91c8879cb98e686afccc..fdf4e116570013732d48071a5122d25b02da715c 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -369,10 +369,30 @@ static int vfio_get_iommu_type(VFIOContainer *container,
     return -EINVAL;
 }
 
+/*
+ * vfio_get_iommu_ops - get a VFIOIOMMUClass associated with a type
+ */
+static const VFIOIOMMUClass *vfio_get_iommu_class(int iommu_type, Error **errp)
+{
+    ObjectClass *klass = NULL;
+
+    switch (iommu_type) {
+    case VFIO_TYPE1v2_IOMMU:
+    case VFIO_TYPE1_IOMMU:
+        klass = object_class_by_name(TYPE_VFIO_IOMMU_LEGACY);
+        break;
+    default:
+        g_assert_not_reached();
+    };
+
+    return VFIO_IOMMU_CLASS(klass);
+}
+
 static int vfio_init_container(VFIOContainer *container, int group_fd,
                                VFIOAddressSpace *space, Error **errp)
 {
     int iommu_type, ret;
+    const VFIOIOMMUClass *vioc = NULL;
 
     iommu_type = vfio_get_iommu_type(container, errp);
     if (iommu_type < 0) {
@@ -401,7 +421,14 @@ static int vfio_init_container(VFIOContainer *container, int group_fd,
     }
 
     container->iommu_type = iommu_type;
-    vfio_container_init(&container->bcontainer, space, &vfio_legacy_ops);
+
+    vioc = vfio_get_iommu_class(iommu_type, errp);
+    if (!vioc) {
+        error_setg(errp, "No available IOMMU models");
+        return -EINVAL;
+    }
+
+    vfio_container_init(&container->bcontainer, space, vioc);
     return 0;
 }
 
@@ -1098,12 +1125,26 @@ out_single:
     return ret;
 }
 
-const VFIOIOMMUOps vfio_legacy_ops = {
-    .dma_map = vfio_legacy_dma_map,
-    .dma_unmap = vfio_legacy_dma_unmap,
-    .attach_device = vfio_legacy_attach_device,
-    .detach_device = vfio_legacy_detach_device,
-    .set_dirty_page_tracking = vfio_legacy_set_dirty_page_tracking,
-    .query_dirty_bitmap = vfio_legacy_query_dirty_bitmap,
-    .pci_hot_reset = vfio_legacy_pci_hot_reset,
+static void vfio_iommu_legacy_class_init(ObjectClass *klass, void *data)
+{
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
+
+    vioc->dma_map = vfio_legacy_dma_map;
+    vioc->dma_unmap = vfio_legacy_dma_unmap;
+    vioc->attach_device = vfio_legacy_attach_device;
+    vioc->detach_device = vfio_legacy_detach_device;
+    vioc->set_dirty_page_tracking = vfio_legacy_set_dirty_page_tracking;
+    vioc->query_dirty_bitmap = vfio_legacy_query_dirty_bitmap;
+    vioc->pci_hot_reset = vfio_legacy_pci_hot_reset;
 };
+
+static const TypeInfo types[] = {
+    {
+        .name = TYPE_VFIO_IOMMU_LEGACY,
+        .parent = TYPE_VFIO_IOMMU,
+        .class_init = vfio_iommu_legacy_class_init,
+        .class_size = sizeof(VFIOIOMMUClass),
+    },
+};
+
+DEFINE_TYPES(types)
-- 
2.43.0


