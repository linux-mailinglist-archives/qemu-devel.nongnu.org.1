Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D77367EAE0C
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 11:29:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2qcV-0003Ji-NA; Tue, 14 Nov 2023 05:26:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r2qcT-0003JI-Io
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 05:26:09 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r2qcR-0007jN-04
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 05:26:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699957567; x=1731493567;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pB86zIrCR+9lvoDbuO3vM+uSeRw8J03Ps4JxwthGHag=;
 b=Ep7XVL4a4bWxWA5QD+FRfgQuGgxA82dFqsR2yJ1gePBXFTcf7rQaVAyH
 y1hsaDqEzmCgJva09fxRDs/IIX8hXDMAOP8ehXSBjlAUhTwC6tpdsVhWF
 UjZRm1X+nKjHiDF0ZLobGi6AMOeYQXqJPxJTVWr4HasPDz/thb+qp1uNG
 mgPK80uvbWuElLyKteXAiqdjeCIDSc5jL5iZ3mh5qMI+cjFNBv5PV9IQu
 FjMIHBeq6W/djfvmQL25G+S5znXTifWmKKKsvnGQPVICtDV5hrqBncEQy
 XHNERMDaXAOVrK+y9NegtmuLyJRghm1z158q9AEFC8BW1f7yzjyKB37qo Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="394543490"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; d="scan'208";a="394543490"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 02:26:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="888212964"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; d="scan'208";a="888212964"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 02:26:01 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 09/21] vfio/iommufd: Enable pci hot reset through iommufd
 cdev interface
Date: Tue, 14 Nov 2023 18:09:43 +0800
Message-Id: <20231114100955.1961974-10-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.65;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Add a new callback iommufd_cdev_pci_hot_reset to do iommufd specific
check and reset operation.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
v6: pci_hot_reset return -errno if fails

 hw/vfio/iommufd.c    | 145 +++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/trace-events |   1 +
 2 files changed, 146 insertions(+)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index e5bf528e89..3eec428162 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -24,6 +24,7 @@
 #include "sysemu/reset.h"
 #include "qemu/cutils.h"
 #include "qemu/chardev_open.h"
+#include "pci.h"
 
 static int iommufd_cdev_map(VFIOContainerBase *bcontainer, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly)
@@ -473,9 +474,153 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
     close(vbasedev->fd);
 }
 
+static VFIODevice *iommufd_cdev_pci_find_by_devid(__u32 devid)
+{
+    VFIODevice *vbasedev_iter;
+
+    QLIST_FOREACH(vbasedev_iter, &vfio_device_list, global_next) {
+        if (vbasedev_iter->bcontainer->ops != &vfio_iommufd_ops) {
+            continue;
+        }
+        if (devid == vbasedev_iter->devid) {
+            return vbasedev_iter;
+        }
+    }
+    return NULL;
+}
+
+static int iommufd_cdev_pci_hot_reset(VFIODevice *vbasedev, bool single)
+{
+    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
+    struct vfio_pci_hot_reset_info *info = NULL;
+    struct vfio_pci_dependent_device *devices;
+    struct vfio_pci_hot_reset *reset;
+    int ret, i;
+    bool multi = false;
+
+    trace_vfio_pci_hot_reset(vdev->vbasedev.name, single ? "one" : "multi");
+
+    if (!single) {
+        vfio_pci_pre_reset(vdev);
+    }
+    vdev->vbasedev.needs_reset = false;
+
+    ret = vfio_pci_get_pci_hot_reset_info(vdev, &info);
+
+    if (ret) {
+        goto out_single;
+    }
+
+    assert(info->flags & VFIO_PCI_HOT_RESET_FLAG_DEV_ID);
+
+    devices = &info->devices[0];
+
+    if (!(info->flags & VFIO_PCI_HOT_RESET_FLAG_DEV_ID_OWNED)) {
+        if (!vdev->has_pm_reset) {
+            for (i = 0; i < info->count; i++) {
+                if (devices[i].devid == VFIO_PCI_DEVID_NOT_OWNED) {
+                    error_report("vfio: Cannot reset device %s, "
+                                 "depends on device %04x:%02x:%02x.%x "
+                                 "which is not owned.",
+                                 vdev->vbasedev.name, devices[i].segment,
+                                 devices[i].bus, PCI_SLOT(devices[i].devfn),
+                                 PCI_FUNC(devices[i].devfn));
+                }
+            }
+        }
+        ret = -EPERM;
+        goto out_single;
+    }
+
+    trace_vfio_pci_hot_reset_has_dep_devices(vdev->vbasedev.name);
+
+    for (i = 0; i < info->count; i++) {
+        VFIOPCIDevice *tmp;
+        VFIODevice *vbasedev_iter;
+
+        trace_iommufd_cdev_pci_hot_reset_dep_devices(devices[i].segment,
+                                                     devices[i].bus,
+                                                     PCI_SLOT(devices[i].devfn),
+                                                     PCI_FUNC(devices[i].devfn),
+                                                     devices[i].devid);
+
+        /*
+         * If a VFIO cdev device is resettable, all the dependent devices
+         * are either bound to same iommufd or within same iommu_groups as
+         * one of the iommufd bound devices.
+         */
+        assert(devices[i].devid != VFIO_PCI_DEVID_NOT_OWNED);
+
+        if (devices[i].devid == vdev->vbasedev.devid ||
+            devices[i].devid == VFIO_PCI_DEVID_OWNED) {
+            continue;
+        }
+
+        vbasedev_iter = iommufd_cdev_pci_find_by_devid(devices[i].devid);
+        if (!vbasedev_iter || !vbasedev_iter->dev->realized ||
+            vbasedev_iter->type != VFIO_DEVICE_TYPE_PCI) {
+            continue;
+        }
+        tmp = container_of(vbasedev_iter, VFIOPCIDevice, vbasedev);
+        if (single) {
+            ret = -EINVAL;
+            goto out_single;
+        }
+        vfio_pci_pre_reset(tmp);
+        tmp->vbasedev.needs_reset = false;
+        multi = true;
+    }
+
+    if (!single && !multi) {
+        ret = -EINVAL;
+        goto out_single;
+    }
+
+    /* Use zero length array for hot reset with iommufd backend */
+    reset = g_malloc0(sizeof(*reset));
+    reset->argsz = sizeof(*reset);
+
+     /* Bus reset! */
+    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_PCI_HOT_RESET, reset);
+    g_free(reset);
+    if (ret) {
+        ret = -errno;
+    }
+
+    trace_vfio_pci_hot_reset_result(vdev->vbasedev.name,
+                                    ret ? strerror(errno) : "Success");
+
+    /* Re-enable INTx on affected devices */
+    for (i = 0; i < info->count; i++) {
+        VFIOPCIDevice *tmp;
+        VFIODevice *vbasedev_iter;
+
+        if (devices[i].devid == vdev->vbasedev.devid ||
+            devices[i].devid == VFIO_PCI_DEVID_OWNED) {
+            continue;
+        }
+
+        vbasedev_iter = iommufd_cdev_pci_find_by_devid(devices[i].devid);
+        if (!vbasedev_iter || !vbasedev_iter->dev->realized ||
+            vbasedev_iter->type != VFIO_DEVICE_TYPE_PCI) {
+            continue;
+        }
+        tmp = container_of(vbasedev_iter, VFIOPCIDevice, vbasedev);
+        vfio_pci_post_reset(tmp);
+    }
+out_single:
+    if (!single) {
+        vfio_pci_post_reset(vdev);
+    }
+    g_free(info);
+
+    return ret;
+}
+
 const VFIOIOMMUOps vfio_iommufd_ops = {
     .dma_map = iommufd_cdev_map,
     .dma_unmap = iommufd_cdev_unmap,
     .attach_device = iommufd_cdev_attach,
     .detach_device = iommufd_cdev_detach,
+    .pci_hot_reset = iommufd_cdev_pci_hot_reset,
 };
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 5d3e9e8cee..d838232d5a 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -174,3 +174,4 @@ iommufd_cdev_detach_ioas_hwpt(int iommufd, const char *name, const char *str, in
 iommufd_cdev_fail_attach_existing_container(const char *msg) " %s"
 iommufd_cdev_alloc_ioas(int iommufd, int ioas_id) " [iommufd=%d] new IOMMUFD container with ioasid=%d"
 iommufd_cdev_device_info(char *name, int devfd, int num_irqs, int num_regions, int flags) " %s (%d) num_irqs=%d num_regions=%d flags=%d"
+iommufd_cdev_pci_hot_reset_dep_devices(int domain, int bus, int slot, int function, int dev_id) "\t%04x:%02x:%02x.%x devid %d"
-- 
2.34.1


