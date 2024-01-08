Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C485882689E
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 08:34:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMk8B-0003CU-Vz; Mon, 08 Jan 2024 02:33:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=P3fH=IS=redhat.com=clg@ozlabs.org>)
 id 1rMk83-00033r-Ie
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 02:33:01 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=P3fH=IS=redhat.com=clg@ozlabs.org>)
 id 1rMk7z-0004aS-Vc
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 02:32:57 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4T7m4N1SYqz4wx5;
 Mon,  8 Jan 2024 18:32:52 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4T7m4L1Fzpz4wcc;
 Mon,  8 Jan 2024 18:32:49 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 05/17] vfio/container: Introduce a VFIOIOMMU legacy QOM
 interface
Date: Mon,  8 Jan 2024 08:32:20 +0100
Message-ID: <20240108073232.118228-6-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108073232.118228-1-clg@redhat.com>
References: <20240108073232.118228-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=P3fH=IS=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Convert the legacy VFIOIOMMUOps struct to the new VFIOIOMMU QOM
interface. The set of of operations for this backend can be referenced
with a literal typename instead of a C struct. This will simplify
support of multiple backends.

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Tested-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h         |  1 -
 include/hw/vfio/vfio-container-base.h |  1 +
 hw/vfio/common.c                      |  6 ++-
 hw/vfio/container.c                   | 58 ++++++++++++++++++++++-----
 4 files changed, 55 insertions(+), 11 deletions(-)

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
index d6147b4aeef26b6075c88579108e566720f58ebb..c60370fc5ebe65474816dbf2b065aa0912de1a3c 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -94,6 +94,7 @@ void vfio_container_destroy(VFIOContainerBase *bcontainer);
 
 
 #define TYPE_VFIO_IOMMU "vfio-iommu"
+#define TYPE_VFIO_IOMMU_LEGACY TYPE_VFIO_IOMMU "-legacy"
 
 /*
  * VFIOContainerBase is not an abstract QOM object because it felt
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
index f4a0434a5239bfb6a17b91c8879cb98e686afccc..220e838a917f9a135af1e040a450cb52064428cf 100644
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
+    const VFIOIOMMUClass *vioc;
 
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
 
@@ -1098,12 +1125,25 @@ out_single:
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
+    },
+};
+
+DEFINE_TYPES(types)
-- 
2.43.0


