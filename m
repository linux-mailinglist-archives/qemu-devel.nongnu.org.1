Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5368F819034
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:02:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfKJ-0006t7-DX; Tue, 19 Dec 2023 14:00:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfJM-0004pa-BB
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:59:26 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfJK-0007Oa-Ag
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:59:24 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SvmFg3Wq5z4xR5;
 Wed, 20 Dec 2023 05:59:19 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvmFb16t7z4xS5;
 Wed, 20 Dec 2023 05:59:14 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 28/47] vfio/iommufd: Enable pci hot reset through iommufd cdev
 interface
Date: Tue, 19 Dec 2023 19:56:24 +0100
Message-ID: <20231219185643.725448-29-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219185643.725448-1-clg@redhat.com>
References: <20231219185643.725448-1-clg@redhat.com>
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Implement the newly introduced pci_hot_reset callback named
iommufd_cdev_pci_hot_reset to do iommufd specific check and
reset operation.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/iommufd.c    | 150 +++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/trace-events |   1 +
 2 files changed, 151 insertions(+)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 01b448e840581e0dd6d3df1897169665f79dcbe3..6e53e013ef57b6d7e3be58e61356fbabacbe8bf3 100644
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
index 3340c93af0e9d366e04e6fe573f1010ab2a861a6..8fdde5445697789edeb4c6383566c1b417cc1595 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -174,3 +174,4 @@ iommufd_cdev_detach_ioas_hwpt(int iommufd, const char *name) " [iommufd=%d] Succ
 iommufd_cdev_fail_attach_existing_container(const char *msg) " %s"
 iommufd_cdev_alloc_ioas(int iommufd, int ioas_id) " [iommufd=%d] new IOMMUFD container with ioasid=%d"
 iommufd_cdev_device_info(char *name, int devfd, int num_irqs, int num_regions, int flags) " %s (%d) num_irqs=%d num_regions=%d flags=%d"
+iommufd_cdev_pci_hot_reset_dep_devices(int domain, int bus, int slot, int function, int dev_id) "\t%04x:%02x:%02x.%x devid %d"
-- 
2.43.0


