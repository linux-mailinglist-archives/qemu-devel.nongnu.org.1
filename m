Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5C782D706
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 11:17:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPK1P-0007hH-Uu; Mon, 15 Jan 2024 05:16:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPK1O-0007h1-9O
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:16:46 -0500
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPK1L-0007Q7-PX
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:16:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705313803; x=1736849803;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pcicmJgyQWLrFvYkUfe79toM2nRdOhPK1Bz0VvryvaA=;
 b=Y9rWDbtFddI5qjNp+Ew0gdcF30A0PQaJrZzktO8UktX43HCe3HpnJycX
 06MiIcNlO3iBQcOOX08IB4iseJqFMU7nvy9r5PiPz/Bke6NauxKLpRWo3
 0nBGFcj1tMVbzG6ly7K/cvOlKNwAhhdG4ltgIo1mcZZruBcR7hpAYbRFO
 UigajmDDWFibf9YGwoqiZGQymLOeettGQvtm8TnYLG8TGKX8R/+j7edpd
 RkJB/KeKptpWBFYtseRxqZOtFderAJsQNigvED5Dhj0zIA3ypxIkcVWxF
 WWBdIimEp7h/s2lpmLfNSst1JGM4VPJlWUQ0BoYUAmmrFbySmWCa+EdBW g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="390032491"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="390032491"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:16:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="1030599506"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="1030599506"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:16:38 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>
Subject: [PATCH rfcv1 4/6] vfio: initialize IOMMUFDDevice and pass to vIOMMU
Date: Mon, 15 Jan 2024 18:13:11 +0800
Message-Id: <20240115101313.131139-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115101313.131139-1-zhenzhong.duan@intel.com>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Initialize IOMMUFDDevice in vfio and pass to vIOMMU, so that vIOMMU
could get hw IOMMU information.

In VFIO legacy backend mode, we still pass a NULL IOMMUFDDevice to vIOMMU,
in case vIOMMU needs some processing for VFIO legacy backend mode.

Originally-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h |  2 ++
 hw/vfio/iommufd.c             |  2 ++
 hw/vfio/pci.c                 | 24 +++++++++++++++++++-----
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 9b7ef7d02b..fde0d0ca60 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -31,6 +31,7 @@
 #endif
 #include "sysemu/sysemu.h"
 #include "hw/vfio/vfio-container-base.h"
+#include "sysemu/iommufd_device.h"
 
 #define VFIO_MSG_PREFIX "vfio %s: "
 
@@ -126,6 +127,7 @@ typedef struct VFIODevice {
     bool dirty_tracking;
     int devid;
     IOMMUFDBackend *iommufd;
+    IOMMUFDDevice idev;
 } VFIODevice;
 
 struct VFIODeviceOps {
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 9bfddc1360..cbd035f148 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -309,6 +309,7 @@ static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
     VFIOContainerBase *bcontainer;
     VFIOIOMMUFDContainer *container;
     VFIOAddressSpace *space;
+    IOMMUFDDevice *idev = &vbasedev->idev;
     struct vfio_device_info dev_info = { .argsz = sizeof(dev_info) };
     int ret, devfd;
     uint32_t ioas_id;
@@ -428,6 +429,7 @@ found_container:
     QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
     QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
 
+    iommufd_device_init(idev, sizeof(*idev), container->be, vbasedev->devid);
     trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
                                    vbasedev->num_regions, vbasedev->flags);
     return 0;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index d7fe06715c..2c3a5d267b 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3107,11 +3107,21 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
     vfio_bars_register(vdev);
 
-    ret = vfio_add_capabilities(vdev, errp);
+    if (vbasedev->iommufd) {
+        ret = pci_device_set_iommu_device(pdev, &vbasedev->idev, errp);
+    } else {
+        ret = pci_device_set_iommu_device(pdev, 0, errp);
+    }
     if (ret) {
+        error_prepend(errp, "Failed to set iommu_device: ");
         goto out_teardown;
     }
 
+    ret = vfio_add_capabilities(vdev, errp);
+    if (ret) {
+        goto out_unset_idev;
+    }
+
     if (vdev->vga) {
         vfio_vga_quirk_setup(vdev);
     }
@@ -3128,7 +3138,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
             error_setg(errp,
                        "cannot support IGD OpRegion feature on hotplugged "
                        "device");
-            goto out_teardown;
+            goto out_unset_idev;
         }
 
         ret = vfio_get_dev_region_info(vbasedev,
@@ -3137,13 +3147,13 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         if (ret) {
             error_setg_errno(errp, -ret,
                              "does not support requested IGD OpRegion feature");
-            goto out_teardown;
+            goto out_unset_idev;
         }
 
         ret = vfio_pci_igd_opregion_init(vdev, opregion, errp);
         g_free(opregion);
         if (ret) {
-            goto out_teardown;
+            goto out_unset_idev;
         }
     }
 
@@ -3229,6 +3239,8 @@ out_deregister:
     if (vdev->intx.mmap_timer) {
         timer_free(vdev->intx.mmap_timer);
     }
+out_unset_idev:
+    pci_device_unset_iommu_device(pdev);
 out_teardown:
     vfio_teardown_msi(vdev);
     vfio_bars_exit(vdev);
@@ -3257,6 +3269,7 @@ static void vfio_instance_finalize(Object *obj)
 static void vfio_exitfn(PCIDevice *pdev)
 {
     VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
 
     vfio_unregister_req_notifier(vdev);
     vfio_unregister_err_notifier(vdev);
@@ -3271,7 +3284,8 @@ static void vfio_exitfn(PCIDevice *pdev)
     vfio_teardown_msi(vdev);
     vfio_pci_disable_rp_atomics(vdev);
     vfio_bars_exit(vdev);
-    vfio_migration_exit(&vdev->vbasedev);
+    vfio_migration_exit(vbasedev);
+    pci_device_unset_iommu_device(pdev);
 }
 
 static void vfio_pci_reset(DeviceState *dev)
-- 
2.34.1


