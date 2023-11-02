Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F967DED80
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 08:37:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qySAa-000155-Rm; Thu, 02 Nov 2023 03:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qySAU-0000ag-DG
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:31:06 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qySAS-0003PH-0Q
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:31:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698910264; x=1730446264;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kSokffqzS+mxdyV6rsa1kPj97RxOw80RU6XfZVz/QCU=;
 b=Ym+0WtykXRX5/Ma0hoa7nxkpWkEOtzSDS7iebGpKeUug9rhPtInu64uk
 3ou563QGS1M/OTE/W48Q56AKuH2zTuBdihWeAIQ3g9ZLW+m2tGNoWdC47
 ZqfGQNB773J44UaTOe0Njj7tQacQN+Yc6D4yUa3yQMPio5s3tKNzBXd8j
 T5UJXNSx/ti5xjNNfyrWzekHSnYuDAY3KgnDRLAFjG/4gyVSbuwHprrmo
 y9PxAV/gvgLi25/aMx633PzB3iEM3Ne1AKmxlTvT1vQTL1BW14HSfz6ez
 UC4qoM5vgc12ET9YVDTpRnOm4EED0v1EvbDdp8P0IhcHisKIoApvhrgo+ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="452953359"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="452953359"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:30:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="711055709"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="711055709"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:30:40 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 32/41] vfio/pci: Introduce a vfio pci hot reset interface
Date: Thu,  2 Nov 2023 15:12:53 +0800
Message-Id: <20231102071302.1818071-33-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.31;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Legacy vfio pci and iommufd cdev have different process to hot reset
vfio device, expand current code to abstract out pci_hot_reset callback
for legacy vfio, this same interface will also be used by iommufd
cdev vfio device.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/pci.h                         |  1 +
 include/hw/vfio/vfio-container-base.h |  3 +++
 hw/vfio/container.c                   |  2 ++
 hw/vfio/pci.c                         | 11 ++++++++++-
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 1006061afb..12cc765821 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -220,6 +220,7 @@ extern const PropertyInfo qdev_prop_nv_gpudirect_clique;
 
 int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
                                     struct vfio_pci_hot_reset_info **info_p);
+int vfio_legacy_pci_hot_reset(VFIODevice *vbasedev, bool single);
 
 int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
 
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 4b6f017c6f..45bb19c767 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -106,6 +106,9 @@ struct VFIOIOMMUOps {
     int (*set_dirty_page_tracking)(VFIOContainerBase *bcontainer, bool start);
     int (*query_dirty_bitmap)(VFIOContainerBase *bcontainer, VFIOBitmap *vbmap,
                               hwaddr iova, hwaddr size);
+    /* PCI specific */
+    int (*pci_hot_reset)(VFIODevice *vbasedev, bool single);
+
     /* SPAPR specific */
     int (*add_window)(VFIOContainerBase *bcontainer,
                       MemoryRegionSection *section,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index ed2d721b2b..f27cc15d09 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -33,6 +33,7 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "migration/migration.h"
+#include "pci.h"
 
 VFIOGroupList vfio_group_list =
     QLIST_HEAD_INITIALIZER(vfio_group_list);
@@ -929,4 +930,5 @@ const VFIOIOMMUOps vfio_legacy_ops = {
     .detach_device = vfio_legacy_detach_device,
     .set_dirty_page_tracking = vfio_legacy_set_dirty_page_tracking,
     .query_dirty_bitmap = vfio_legacy_query_dirty_bitmap,
+    .pci_hot_reset = vfio_legacy_pci_hot_reset,
 };
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index eb55e8ae88..a6194b7bfe 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2483,8 +2483,9 @@ int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
     return 0;
 }
 
-static int vfio_pci_hot_reset(VFIOPCIDevice *vdev, bool single)
+int vfio_legacy_pci_hot_reset(VFIODevice *vbasedev, bool single)
 {
+    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
     VFIOGroup *group;
     struct vfio_pci_hot_reset_info *info = NULL;
     struct vfio_pci_dependent_device *devices;
@@ -2647,6 +2648,14 @@ out_single:
     return ret;
 }
 
+static int vfio_pci_hot_reset(VFIOPCIDevice *vdev, bool single)
+{
+    VFIODevice *vbasedev = &vdev->vbasedev;
+    const VFIOIOMMUOps *ops = vbasedev->bcontainer->ops;
+
+    return ops->pci_hot_reset(vbasedev, single);
+}
+
 /*
  * We want to differentiate hot reset of multiple in-use devices vs hot reset
  * of a single in-use device.  VFIO_DEVICE_RESET will already handle the case
-- 
2.34.1


