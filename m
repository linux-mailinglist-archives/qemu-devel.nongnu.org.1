Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 893548268B0
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 08:35:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMk88-00037l-5v; Mon, 08 Jan 2024 02:33:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=P3fH=IS=redhat.com=clg@ozlabs.org>)
 id 1rMk80-000335-Rb
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 02:32:56 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=P3fH=IS=redhat.com=clg@ozlabs.org>)
 id 1rMk7x-0004Zi-3N
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 02:32:54 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4T7m4K4mMjz4wp0;
 Mon,  8 Jan 2024 18:32:49 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4T7m4H4Y5fz4wcc;
 Mon,  8 Jan 2024 18:32:47 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 04/17] vfio/container: Introduce a VFIOIOMMU QOM interface
Date: Mon,  8 Jan 2024 08:32:19 +0100
Message-ID: <20240108073232.118228-5-clg@redhat.com>
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

VFIOContainerBase was not introduced as an abstract QOM object because
it felt unnecessary to expose all the IOMMU backends to the QEMU
machine and human interface. However, we can still abstract the IOMMU
backend handlers using a QOM interface class. This provides more
flexibility when referencing the various implementations.

Simply transform the VFIOIOMMUOps struct in an InterfaceClass and do
some initial name replacements. Next changes will start converting
VFIOIOMMUOps.

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Tested-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h | 23 +++++++++++++++++++----
 hw/vfio/common.c                      |  2 +-
 hw/vfio/container-base.c              | 12 +++++++++++-
 hw/vfio/pci.c                         |  2 +-
 4 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 5c9594b6c77681e5593236e711e7e391e5f2bdff..d6147b4aeef26b6075c88579108e566720f58ebb 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -16,7 +16,8 @@
 #include "exec/memory.h"
 
 typedef struct VFIODevice VFIODevice;
-typedef struct VFIOIOMMUOps VFIOIOMMUOps;
+typedef struct VFIOIOMMUClass VFIOIOMMUClass;
+#define VFIOIOMMUOps VFIOIOMMUClass /* To remove */
 
 typedef struct {
     unsigned long *bitmap;
@@ -34,7 +35,7 @@ typedef struct VFIOAddressSpace {
  * This is the base object for vfio container backends
  */
 typedef struct VFIOContainerBase {
-    const VFIOIOMMUOps *ops;
+    const VFIOIOMMUClass *ops;
     VFIOAddressSpace *space;
     MemoryListener listener;
     Error *error;
@@ -88,10 +89,24 @@ int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
 
 void vfio_container_init(VFIOContainerBase *bcontainer,
                          VFIOAddressSpace *space,
-                         const VFIOIOMMUOps *ops);
+                         const VFIOIOMMUClass *ops);
 void vfio_container_destroy(VFIOContainerBase *bcontainer);
 
-struct VFIOIOMMUOps {
+
+#define TYPE_VFIO_IOMMU "vfio-iommu"
+
+/*
+ * VFIOContainerBase is not an abstract QOM object because it felt
+ * unnecessary to expose all the IOMMU backends to the QEMU machine
+ * and human interface. However, we can still abstract the IOMMU
+ * backend handlers using a QOM interface class. This provides more
+ * flexibility when referencing the various implementations.
+ */
+DECLARE_CLASS_CHECKERS(VFIOIOMMUClass, VFIO_IOMMU, TYPE_VFIO_IOMMU)
+
+struct VFIOIOMMUClass {
+    InterfaceClass parent_class;
+
     /* basic feature */
     int (*dma_map)(const VFIOContainerBase *bcontainer,
                    hwaddr iova, ram_addr_t size,
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 08a3e576725b1fc9f2f7e425375df3b827c4fe56..49dab41566f07ba7be1100fed1973e028d34467c 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1503,7 +1503,7 @@ retry:
 int vfio_attach_device(char *name, VFIODevice *vbasedev,
                        AddressSpace *as, Error **errp)
 {
-    const VFIOIOMMUOps *ops = &vfio_legacy_ops;
+    const VFIOIOMMUClass *ops = &vfio_legacy_ops;
 
 #ifdef CONFIG_IOMMUFD
     if (vbasedev->iommufd) {
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 1ffd25bbfa8bd3d404e43b96357273b95f5a0031..913ae49077c4f09b7b27517c1231cfbe4befb7fb 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -72,7 +72,7 @@ int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
 }
 
 void vfio_container_init(VFIOContainerBase *bcontainer, VFIOAddressSpace *space,
-                         const VFIOIOMMUOps *ops)
+                         const VFIOIOMMUClass *ops)
 {
     bcontainer->ops = ops;
     bcontainer->space = space;
@@ -99,3 +99,13 @@ void vfio_container_destroy(VFIOContainerBase *bcontainer)
 
     g_list_free_full(bcontainer->iova_ranges, g_free);
 }
+
+static const TypeInfo types[] = {
+    {
+        .name = TYPE_VFIO_IOMMU,
+        .parent = TYPE_INTERFACE,
+        .class_size = sizeof(VFIOIOMMUClass),
+    },
+};
+
+DEFINE_TYPES(types)
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9f838978bea11cacf95b0907c76ac0879a6313bf..d7fe06715c4b9cde66a68c31aaf405315921b0d6 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2488,7 +2488,7 @@ int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
 static int vfio_pci_hot_reset(VFIOPCIDevice *vdev, bool single)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
-    const VFIOIOMMUOps *ops = vbasedev->bcontainer->ops;
+    const VFIOIOMMUClass *ops = vbasedev->bcontainer->ops;
 
     return ops->pci_hot_reset(vbasedev, single);
 }
-- 
2.43.0


