Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6627CA2A1
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 10:52:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJHn-0003Ql-UV; Mon, 16 Oct 2023 04:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJHd-00036s-P0
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:49:09 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJHa-0001Lg-AS
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697446142; x=1728982142;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=b1vBWadFbefqeyoQVQBcGLcT/YMUhXspOdkxS8wof68=;
 b=BxvkvjSysRSDr2SRLqp5gCjhXP+pCy1nQ4/GhAp4ribfM7/b1dv7fRFO
 qXgdsJ+Ve5Y1CNJTywpv0AcCdb3nNW3RaefUoWX8r+xv01PSW78IlJvz6
 zTA71Yp2ceu3SaXUftTJGv76LYzTtddcCfmNZ7xt+mj904NjtqTfVKLbA
 XgBsNuF/5g2JujNLNqf90W3KW3GXrgRunT5Vu1Ex8SBkhvPk3X8+vkjLG
 QEK5VT/GOcj8Tb0sPC391WPJrix1avYp5o7nY2iarcASiiv5Ao/vs1QTv
 WMe5FNuI0rBB3g0yWFUJWfkjmpN+xwolNINfnJGR+tPFI7DIDFTE3d6BK Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="365737706"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="365737706"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:48:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="749223026"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="749223026"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:48:45 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 21/27] vfio/pci: Adapt vfio pci hot reset support with
 iommufd BE
Date: Mon, 16 Oct 2023 16:32:17 +0800
Message-Id: <20231016083223.1519410-22-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016083223.1519410-1-zhenzhong.duan@intel.com>
References: <20231016083223.1519410-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.151;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A help function vfio_pci_get_pci_hot_reset_info() is extracted out
for usage by both BEs.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/pci.c        | 212 +++++++++++++++++++++++++++++++++++++++----
 hw/vfio/trace-events |   1 +
 2 files changed, 196 insertions(+), 17 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b27011cee7..24fc047423 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -42,6 +42,7 @@
 #include "qapi/error.h"
 #include "migration/blocker.h"
 #include "migration/qemu-file.h"
+#include "linux/iommufd.h"
 
 #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
 
@@ -2445,22 +2446,13 @@ static bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name)
     return (strcmp(tmp, name) == 0);
 }
 
-static int vfio_pci_hot_reset(VFIOPCIDevice *vdev, bool single)
+static int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
+                                       struct vfio_pci_hot_reset_info **info_p)
 {
-    VFIOGroup *group;
     struct vfio_pci_hot_reset_info *info;
-    struct vfio_pci_dependent_device *devices;
-    struct vfio_pci_hot_reset *reset;
-    int32_t *fds;
-    int ret, i, count;
-    bool multi = false;
+    int ret, count;
 
-    trace_vfio_pci_hot_reset(vdev->vbasedev.name, single ? "one" : "multi");
-
-    if (!single) {
-        vfio_pci_pre_reset(vdev);
-    }
-    vdev->vbasedev.needs_reset = false;
+    assert(info_p && !*info_p);
 
     info = g_malloc0(sizeof(*info));
     info->argsz = sizeof(*info);
@@ -2468,24 +2460,53 @@ static int vfio_pci_hot_reset(VFIOPCIDevice *vdev, bool single)
     ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_PCI_HOT_RESET_INFO, info);
     if (ret && errno != ENOSPC) {
         ret = -errno;
+        g_free(info);
         if (!vdev->has_pm_reset) {
             error_report("vfio: Cannot reset device %s, "
                          "no available reset mechanism.", vdev->vbasedev.name);
         }
-        goto out_single;
+        return ret;
     }
 
     count = info->count;
-    info = g_realloc(info, sizeof(*info) + (count * sizeof(*devices)));
-    info->argsz = sizeof(*info) + (count * sizeof(*devices));
-    devices = &info->devices[0];
+    info = g_realloc(info, sizeof(*info) + (count * sizeof(info->devices[0])));
+    info->argsz = sizeof(*info) + (count * sizeof(info->devices[0]));
 
     ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_PCI_HOT_RESET_INFO, info);
     if (ret) {
         ret = -errno;
+        g_free(info);
         error_report("vfio: hot reset info failed: %m");
+        return ret;
+    }
+
+    *info_p = info;
+    return 0;
+}
+
+static int vfio_pci_hot_reset_legacy(VFIOPCIDevice *vdev, bool single)
+{
+    VFIOGroup *group;
+    struct vfio_pci_hot_reset_info *info = NULL;
+    struct vfio_pci_dependent_device *devices;
+    struct vfio_pci_hot_reset *reset;
+    int32_t *fds;
+    int ret, i, count;
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
         goto out_single;
     }
+    devices = &info->devices[0];
 
     trace_vfio_pci_hot_reset_has_dep_devices(vdev->vbasedev.name);
 
@@ -2627,6 +2648,163 @@ out_single:
     return ret;
 }
 
+#ifdef CONFIG_IOMMUFD
+static VFIODevice *vfio_pci_find_by_iommufd_devid(__u32 devid)
+{
+    VFIODevice *vbasedev_iter;
+    VFIOIOMMUBackendOpsClass *ops = VFIO_IOMMU_BACKEND_OPS_CLASS(
+        object_class_by_name(TYPE_VFIO_IOMMU_BACKEND_IOMMUFD_OPS));
+
+    QLIST_FOREACH(vbasedev_iter, &vfio_device_list, global_next) {
+        if (vbasedev_iter->bcontainer->ops != ops) {
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
+
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


