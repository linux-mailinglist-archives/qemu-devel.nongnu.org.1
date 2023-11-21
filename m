Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9CE7F27DD
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 09:47:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5MPM-000677-BJ; Tue, 21 Nov 2023 03:47:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5MPI-00066y-CP
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:46:56 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5MPF-0001Qo-BV
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:46:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700556413; x=1732092413;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SJ7Va2T7ak5UciNAvMEEVNZXzKuRGCGY5c4uhn0XlMA=;
 b=Oo+4IaHhJIcnU11KMpQBfgWZ9y7vhQBkp7PxWcU0KZZQ+lH7hDiT9PrU
 IZah7Fs7y5BqLQp+JvsxeTJk/9/GYUNZCvtOhwfZLccxJLVcjyi5TPAzz
 ltDbN0McQM5v6DEw+sccQrwx/SCdy8hL8zK2J7EoZ7A42iBMLLr63H0Nw
 VcOKju9xxOQzVFW4gbIhj1xuvxUmoHlxlEYacxjaMlqRu0+n20jZ57Q97
 QCpGRZIIRoEeC3DSK5HoIhoH2ty+u1Eh8ZX4ZtLbfvTdzpAoZUyCnjoO9
 IwAt9sbVr+gwhgtPAcfrXaZKeijWQIDqijjYKiWF1LjrzOECMXO1l+Qx+ A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="395722095"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; d="scan'208";a="395722095"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2023 00:46:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="884124918"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; d="scan'208";a="884124918"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2023 00:46:48 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com
Subject: [PATCH v7 09/27] vfio/iommufd: Enable pci hot reset through iommufd
 cdev interface
Date: Tue, 21 Nov 2023 16:44:08 +0800
Message-Id: <20231121084426.1286987-10-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121084426.1286987-1-zhenzhong.duan@intel.com>
References: <20231121084426.1286987-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.65;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
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

Implement the newly introduced pci_hot_reset callback named
iommufd_cdev_pci_hot_reset to do iommufd specific check and
reset operation.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
---
 hw/vfio/iommufd.c    | 150 +++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/trace-events |   1 +
 2 files changed, 151 insertions(+)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 01b448e840..6e53e013ef 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -24,6 +24,7 @@
 #include "sysemu/reset.h"
 #include "qemu/cutils.h"
 #include "qemu/chardev_open.h"
+#include "pci.h"
 
 static int iommufd_cdev_map(VFIOContainerBase *bcontainer, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly)
@@ -468,9 +469,158 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
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
+static VFIOPCIDevice *
+iommufd_cdev_dep_get_realized_vpdev(struct vfio_pci_dependent_device *dep_dev,
+                                    VFIODevice *reset_dev)
+{
+    VFIODevice *vbasedev_tmp;
+
+    if (dep_dev->devid == reset_dev->devid ||
+        dep_dev->devid == VFIO_PCI_DEVID_OWNED) {
+        return NULL;
+    }
+
+    vbasedev_tmp = iommufd_cdev_pci_find_by_devid(dep_dev->devid);
+    if (!vbasedev_tmp || !vbasedev_tmp->dev->realized ||
+        vbasedev_tmp->type != VFIO_DEVICE_TYPE_PCI) {
+        return NULL;
+    }
+
+    return container_of(vbasedev_tmp, VFIOPCIDevice, vbasedev);
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
+        tmp = iommufd_cdev_dep_get_realized_vpdev(&devices[i], &vdev->vbasedev);
+        if (!tmp) {
+            continue;
+        }
+
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
+
+        tmp = iommufd_cdev_dep_get_realized_vpdev(&devices[i], &vdev->vbasedev);
+        if (!tmp) {
+            continue;
+        }
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
index 3340c93af0..8fdde54456 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -174,3 +174,4 @@ iommufd_cdev_detach_ioas_hwpt(int iommufd, const char *name) " [iommufd=%d] Succ
 iommufd_cdev_fail_attach_existing_container(const char *msg) " %s"
 iommufd_cdev_alloc_ioas(int iommufd, int ioas_id) " [iommufd=%d] new IOMMUFD container with ioasid=%d"
 iommufd_cdev_device_info(char *name, int devfd, int num_irqs, int num_regions, int flags) " %s (%d) num_irqs=%d num_regions=%d flags=%d"
+iommufd_cdev_pci_hot_reset_dep_devices(int domain, int bus, int slot, int function, int dev_id) "\t%04x:%02x:%02x.%x devid %d"
-- 
2.34.1


