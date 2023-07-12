Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D16750050
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 09:43:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJUTB-00072f-40; Wed, 12 Jul 2023 03:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qJUSq-0006eW-NR
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:40:48 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qJUSm-0006qy-Hm
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689147640; x=1720683640;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KHXRXNWf+zNNMgCNyiIVRGRuGjopqW7tqQLMHau6IdM=;
 b=K1fNh/8dGDFb+vGuImyHLi/lSDbjl8ZhuamKo//TIa/Gw99KUz0RiCkW
 u7utXhT5um53jlgM6ETxcKevBd2r83plQyJQJdQV2YSjsFouT6lG/mEVi
 JbFJ6T3ENtyqTz5A606fZHc2mIENz5Hll9lRWMC98Rkb5JIGKOg3ig0/b
 tAth0qLaG6WyjtlBVtgRAVkMjK+qwK5t2ei1U+gYABAUSPAy/sC7LDOmi
 e9CnxoTOET0JT+qDW2mVFp1uGq95gthO2IiD+TgYidZLRo6m56+JuMKTr
 7DiSko8t7kjKJLWUXQ6DEUOtMXHeFo0JeYS9qhV0NeFHGKsIDW0r6dXDd A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="430953858"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="430953858"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 00:40:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="835024140"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="835024140"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 00:40:12 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, eric.auger@redhat.com, peterx@redhat.com,
 jasonwang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [RFC PATCH v4 21/24] vfio/as: Add vfio device iterator callback for
 iommufd
Date: Wed, 12 Jul 2023 15:25:25 +0800
Message-Id: <20230712072528.275577-22-zhenzhong.duan@intel.com>
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
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The way to get vfio device pointer is different between legacy
container and iommufd container, with iommufd backend support
added, it's time to add the iterator support for iommufd.

In order to implement it, a pointer to hwpt is added in vbasedev.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/iommufd.c             | 31 +++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h |  1 +
 2 files changed, 32 insertions(+)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 286ad0b766..e532eed2ac 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -36,6 +36,34 @@
 #include "qemu/cutils.h"
 #include "qemu/char_dev.h"
 
+static VFIODevice *iommufd_dev_iter_next(VFIOContainer *bcontainer,
+                                           VFIODevice *curr)
+{
+
+    VFIOIOASHwpt *hwpt;
+
+    assert(object_class_dynamic_cast(OBJECT_CLASS(bcontainer->ops),
+                                     TYPE_VFIO_IOMMU_BACKEND_IOMMUFD_OPS));
+
+    VFIOIOMMUFDContainer *container = container_of(bcontainer,
+                                                   VFIOIOMMUFDContainer,
+                                                   bcontainer);
+
+    if (!curr) {
+        hwpt = QLIST_FIRST(&container->hwpt_list);
+    } else {
+        if (curr->next.le_next) {
+            return curr->next.le_next;
+        }
+        hwpt = curr->hwpt->next.le_next;
+    }
+
+    if (!hwpt) {
+        return NULL;
+    }
+    return QLIST_FIRST(&hwpt->device_list);
+}
+
 static int iommufd_map(VFIOContainer *bcontainer, hwaddr iova,
                        ram_addr_t size, void *vaddr, bool readonly)
 {
@@ -218,6 +246,7 @@ static void vfio_device_detach_container(VFIODevice *vbasedev,
     hwpt = vfio_find_hwpt_for_dev(container, vbasedev);
     if (hwpt) {
         QLIST_REMOVE(vbasedev, next);
+        vbasedev->hwpt = NULL;
         if (QLIST_EMPTY(&hwpt->device_list)) {
             vfio_container_put_hwpt(hwpt);
         }
@@ -281,6 +310,7 @@ static int vfio_device_attach_container(VFIODevice *vbasedev,
     hwpt = vfio_container_get_hwpt(container, attach_data.pt_id);
 
     QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, next);
+    vbasedev->hwpt = hwpt;
     return 0;
 }
 
@@ -490,6 +520,7 @@ static void vfio_iommu_backend_iommufd_ops_class_init(ObjectClass *oc,
                                                      void *data) {
     VFIOIOMMUBackendOpsClass *ops = VFIO_IOMMU_BACKEND_OPS_CLASS(oc);
 
+    ops->dev_iter_next = iommufd_dev_iter_next;
     ops->dma_map = iommufd_map;
     ops->dma_unmap = iommufd_unmap;
     ops->attach_device = iommufd_attach_device;
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 6434a442fd..d596e802b0 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -133,6 +133,7 @@ typedef struct VFIODevice {
 #ifdef CONFIG_IOMMUFD
     int devid;
     IOMMUFDBackend *iommufd;
+    VFIOIOASHwpt *hwpt;
 #endif
 } VFIODevice;
 
-- 
2.34.1


