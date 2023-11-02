Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1D07DED81
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 08:37:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qySAb-00017z-4u; Thu, 02 Nov 2023 03:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qySAW-0000f3-Bh
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:31:08 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qySAU-0003OZ-8M
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698910266; x=1730446266;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qYbjFJsZTdqafFCCXBwd0B8hhpm9nk9rj4ooJuAp0t4=;
 b=hFM+boJicjju8MKSXX0eFrWk60z+q0xcAnMsXo1ZZf8iQTSpHlZbmoe7
 Ca6w83hscW5tG/l1C9zftk3Fkoyj/Wr9MEpG2GTC0H+Z0AIWzZdBnHY9o
 hpO/i6JYW6OA1/iP7EJazDThUsvcnkNPiHazJWkz/+xTEVoNm8Mc/a2Nj
 vT7Q7raJgAObf6JobPYzz2P8IaX/BDLlmtHp7Tx6Fzb0SlJWtwx3XqA2p
 EjYoeIyugk7bPihJpn0NBga9By6+SlbbArtH8XzSWePWVvjESSs0yuRp3
 pV1UsgP/iosAetz1kqkzvfcRD1xcyamGyJ1QiOyRG/pRbIgqVacBzNsOA w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="452953387"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="452953387"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:30:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="711055723"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="711055723"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:30:45 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 33/41] vfio/iommufd: Enable pci hot reset through iommufd
 cdev interface
Date: Thu,  2 Nov 2023 15:12:54 +0800
Message-Id: <20231102071302.1818071-34-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
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

Add a new callback iommufd_pci_hot_reset to do iommufd specific
check and reset operation.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/pci.h        |   2 +
 hw/vfio/iommufd.c    | 142 +++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c        |   4 +-
 hw/vfio/trace-events |   1 +
 4 files changed, 147 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 12cc765821..ec4a03aecd 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -218,6 +218,8 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr);
 
 extern const PropertyInfo qdev_prop_nv_gpudirect_clique;
 
+void vfio_pci_pre_reset(VFIOPCIDevice *vdev);
+void vfio_pci_post_reset(VFIOPCIDevice *vdev);
 int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
                                     struct vfio_pci_hot_reset_info **info_p);
 int vfio_legacy_pci_hot_reset(VFIODevice *vbasedev, bool single);
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 22f02f92a9..aedfe31c3c 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -24,6 +24,7 @@
 #include "sysemu/reset.h"
 #include "qemu/cutils.h"
 #include "qemu/chardev_open.h"
+#include "pci.h"
 
 static int iommufd_map(VFIOContainerBase *bcontainer, hwaddr iova,
                        ram_addr_t size, void *vaddr, bool readonly)
@@ -543,9 +544,150 @@ static void iommufd_detach_device(VFIODevice *vbasedev)
     close(vbasedev->fd);
 }
 
+static VFIODevice *vfio_pci_find_by_iommufd_devid(__u32 devid)
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
+static int iommufd_pci_hot_reset(VFIODevice *vbasedev, bool single)
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
+        trace_vfio_pci_hot_reset_dep_devices_iommufd(devices[i].segment,
+                                             devices[i].bus,
+                                             PCI_SLOT(devices[i].devfn),
+                                             PCI_FUNC(devices[i].devfn),
+                                             devices[i].devid);
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
+        vbasedev_iter = vfio_pci_find_by_iommufd_devid(devices[i].devid);
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
+        vbasedev_iter = vfio_pci_find_by_iommufd_devid(devices[i].devid);
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
     .dma_map = iommufd_map,
     .dma_unmap = iommufd_unmap,
     .attach_device = iommufd_attach_device,
     .detach_device = iommufd_detach_device,
+    .pci_hot_reset = iommufd_pci_hot_reset,
 };
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index a6194b7bfe..eb662fd086 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2374,7 +2374,7 @@ static int vfio_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
     return 0;
 }
 
-static void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
+void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
 {
     PCIDevice *pdev = &vdev->pdev;
     uint16_t cmd;
@@ -2411,7 +2411,7 @@ static void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
     vfio_pci_write_config(pdev, PCI_COMMAND, cmd, 2);
 }
 
-static void vfio_pci_post_reset(VFIOPCIDevice *vdev)
+void vfio_pci_post_reset(VFIOPCIDevice *vdev)
 {
     Error *err = NULL;
     int nr;
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index d85342b65f..e88a7d5ccc 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -34,6 +34,7 @@ vfio_check_af_flr(const char *name) "%s Supports FLR via AF cap"
 vfio_pci_hot_reset(const char *name, const char *type) " (%s) %s"
 vfio_pci_hot_reset_has_dep_devices(const char *name) "%s: hot reset dependent devices:"
 vfio_pci_hot_reset_dep_devices(int domain, int bus, int slot, int function, int group_id) "\t%04x:%02x:%02x.%x group %d"
+vfio_pci_hot_reset_dep_devices_iommufd(int domain, int bus, int slot, int function, int dev_id) "\t%04x:%02x:%02x.%x devid %d"
 vfio_pci_hot_reset_result(const char *name, const char *result) "%s hot reset: %s"
 vfio_populate_device_config(const char *name, unsigned long size, unsigned long offset, unsigned long flags) "Device %s config:\n  size: 0x%lx, offset: 0x%lx, flags: 0x%lx"
 vfio_populate_device_get_irq_info_failure(const char *errstr) "VFIO_DEVICE_GET_IRQ_INFO failure: %s"
-- 
2.34.1


