Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1218575004B
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 09:42:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJUSL-00051y-22; Wed, 12 Jul 2023 03:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qJUSG-0004l0-UF
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:40:10 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qJUSB-0006qy-9K
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689147603; x=1720683603;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=C15KB4jtp0bGgOKv9U5yewTNQKonRXzHUWMgyvUaQxM=;
 b=GfVxVSU8Eli87Dm3Ry357+NR8CzOm5c3R6GGfA0CPJ55xQvFusg6yr7F
 A5EZqEmO2MfurFyEkLj7omqiSN3O05yQCGJm3y9tpXE0LXeyWf+emj3yx
 PGPerkb7lH06924feWij8CAi1BV5UcgvPRdm6MkXD373Grgob+Hxla+gp
 I6ox6en7pOepiWNhmi2Rw10Tt3DWt/Ozpj6sWjRO8wMUa7hrGRL90XYJO
 7T0FQyLGIsDZwz+GSZrRDsrTG2l6i2abBs00DOI8GAnDq64Z35xTrOJ7Y
 9JPjdGSWTSzsKUHNWGKuT0gsFvSMUixE+FaRE3cJLuTjW8YJOGQnLDzU8 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="430953770"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="430953770"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 00:39:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="835024075"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="835024075"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 00:39:49 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, eric.auger@redhat.com, peterx@redhat.com,
 jasonwang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [RFC PATCH v4 15/24] vfio/container-base: Introduce
 [attach/detach]_device container callbacks
Date: Wed, 12 Jul 2023 15:25:19 +0800
Message-Id: <20230712072528.275577-16-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712072528.275577-1-zhenzhong.duan@intel.com>
References: <20230712072528.275577-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=zhenzhong.duan@intel.com; helo=mga07.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Let's turn attach/detach_device as container callbacks. That way,
their implementation can be easily customized for a given backend.

For the time being, only the legacy container is supported.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/as.c                          | 22 ++++++++++++++++++++++
 hw/vfio/container.c                   | 10 +++++++---
 include/hw/vfio/vfio-common.h         |  1 +
 include/hw/vfio/vfio-container-base.h |  3 +++
 4 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/as.c b/hw/vfio/as.c
index 1cdbeb3ce4..0a2363f437 100644
--- a/hw/vfio/as.c
+++ b/hw/vfio/as.c
@@ -1526,6 +1526,28 @@ retry:
     return info;
 }
 
+int vfio_attach_device(char *name, VFIODevice *vbasedev,
+                       AddressSpace *as, Error **errp)
+{
+    const VFIOIOMMUBackendOpsClass *ops;
+
+    ops = VFIO_IOMMU_BACKEND_OPS_CLASS(
+                  object_class_by_name(TYPE_VFIO_IOMMU_BACKEND_LEGACY_OPS));
+    if (!ops) {
+        error_setg(errp, "VFIO IOMMU Backend not found!");
+        return -ENODEV;
+    }
+    return ops->attach_device(name, vbasedev, as, errp);
+}
+
+void vfio_detach_device(VFIODevice *vbasedev)
+{
+    if (!vbasedev->container) {
+        return;
+    }
+    vbasedev->container->ops->detach_device(vbasedev);
+}
+
 static const TypeInfo vfio_iommu_backend_ops_type_info = {
     .name = TYPE_VFIO_IOMMU_BACKEND_OPS,
     .parent = TYPE_OBJECT,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 0dc2511d71..578cc65349 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1144,8 +1144,8 @@ static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
     return groupid;
 }
 
-int vfio_attach_device(char *name, VFIODevice *vbasedev,
-                       AddressSpace *as, Error **errp)
+static int vfio_legacy_attach_device(char *name, VFIODevice *vbasedev,
+                                     AddressSpace *as, Error **errp)
 {
     int groupid = vfio_device_groupid(vbasedev, errp);
     VFIODevice *vbasedev_iter;
@@ -1174,16 +1174,18 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
         vfio_put_group(group);
         return -1;
     }
+    vbasedev->container = &group->container->bcontainer;
 
     return 0;
 }
 
-void vfio_detach_device(VFIODevice *vbasedev)
+static void vfio_legacy_detach_device(VFIODevice *vbasedev)
 {
     VFIOGroup *group = vbasedev->group;
 
     vfio_put_base_device(vbasedev);
     vfio_put_group(group);
+    vbasedev->container = NULL;
 }
 
 static void vfio_iommu_backend_legacy_ops_class_init(ObjectClass *oc,
@@ -1197,6 +1199,8 @@ static void vfio_iommu_backend_legacy_ops_class_init(ObjectClass *oc,
     ops->query_dirty_bitmap = vfio_legacy_query_dirty_bitmap;
     ops->add_window = vfio_legacy_add_section_window;
     ops->del_window = vfio_legacy_del_section_window;
+    ops->attach_device = vfio_legacy_attach_device;
+    ops->detach_device = vfio_legacy_detach_device;
 }
 
 static const TypeInfo vfio_iommu_backend_legacy_ops_type = {
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 96bb27ceea..81a87d88b6 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -90,6 +90,7 @@ typedef struct VFIODeviceOps VFIODeviceOps;
 typedef struct VFIODevice {
     QLIST_ENTRY(VFIODevice) next;
     struct VFIOGroup *group;
+    VFIOContainer *container;
     char *sysfsdev;
     char *name;
     DeviceState *dev;
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 74ccb7255f..b18fa92146 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -135,6 +135,9 @@ struct VFIOIOMMUBackendOpsClass {
     int (*dma_unmap)(VFIOContainer *container,
                      hwaddr iova, ram_addr_t size,
                      IOMMUTLBEntry *iotlb);
+    int (*attach_device)(char *name, VFIODevice *vbasedev,
+                         AddressSpace *as, Error **errp);
+    void (*detach_device)(VFIODevice *vbasedev);
     /* migration feature */
     int (*set_dirty_page_tracking)(VFIOContainer *container, bool start);
     int (*query_dirty_bitmap)(VFIOContainer *bcontainer, VFIOBitmap *vbmap,
-- 
2.34.1


