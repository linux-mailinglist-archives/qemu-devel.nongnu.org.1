Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBA27D8134
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 12:51:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvxvF-000444-PX; Thu, 26 Oct 2023 06:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxv6-0003ik-S8
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 06:48:57 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxv5-0001PR-0b
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 06:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698317335; x=1729853335;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=R/+ewG8v978gJGlYUDJaC7WmoKKlcpiH18ocYc0hRUo=;
 b=Qr12zO6hiP/BfMWsgdCsRsCbu7CXt6URhyPlv16lYV43c0OalasYHYYG
 s3LS0R/f2a83YZsgraIVleufcSnAJvIQnbyAoN3QNWBGYSaq9OfioCoK9
 bm/k3+zWNgxqy87y4yvC7OaTwstk2/hfRZFa/3AK8OwTwZ7wcjbeNPQPU
 s4nXlhRKIigyNdG/GVikTX/k85Y5un9gR7ownusw/J0FL3EXhB0y3rCLC
 AhmLctATrdx3paWLjehyVaCa/3obMAIyJCFDm6/z9w8U6nJkhIlJhcvf5
 VQYPWyLIArsIKHVO9GBo/ee72CGy3r+rBquDoR6BgyJdS3qH0je7w+4p5 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="372563798"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; d="scan'208";a="372563798"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:48:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="463840"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:48:00 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 31/37] vfio/pci: Adapt vfio pci hot reset support with
 iommufd BE
Date: Thu, 26 Oct 2023 18:30:58 +0800
Message-Id: <20231026103104.1686921-32-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

As pci hot reset path need to reference pci specific functions
and data structures, adding container level callback functions
for legacy and iommufd BE and referencing those pci specific
func/data is no better than implementing reset support with
iommufd BE directly in pci.c

This way we can also share the common bus reset and system reset
path for both BEs.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/pci.c        | 156 ++++++++++++++++++++++++++++++++++++++++++-
 hw/vfio/trace-events |   1 +
 2 files changed, 156 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c17e1f4376..d7a41c8def 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -42,6 +42,7 @@
 #include "qapi/error.h"
 #include "migration/blocker.h"
 #include "migration/qemu-file.h"
+#include "linux/iommufd.h"
 
 #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
 
@@ -2497,7 +2498,7 @@ static int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
     return 0;
 }
 
-static int vfio_pci_hot_reset(VFIOPCIDevice *vdev, bool single)
+static int vfio_pci_hot_reset_legacy(VFIOPCIDevice *vdev, bool single)
 {
     VFIOGroup *group;
     struct vfio_pci_hot_reset_info *info = NULL;
@@ -2661,6 +2662,159 @@ out_single:
     return ret;
 }
 
+#ifdef CONFIG_IOMMUFD
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
+static int vfio_pci_hot_reset_iommufd(VFIOPCIDevice *vdev, bool single)
+{
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
+#endif
+
+static int vfio_pci_hot_reset(VFIOPCIDevice *vdev, bool single)
+{
+#ifdef CONFIG_IOMMUFD
+    if (vdev->vbasedev.iommufd) {
+        return vfio_pci_hot_reset_iommufd(vdev, single);
+    } else
+#endif
+    {
+        return vfio_pci_hot_reset_legacy(vdev, single);
+    }
+}
+
 /*
  * We want to differentiate hot reset of multiple in-use devices vs hot reset
  * of a single in-use device.  VFIO_DEVICE_RESET will already handle the case
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 9b180cf77c..71c5840636 100644
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


