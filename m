Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADC9750054
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 09:43:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJUTD-0007FV-AQ; Wed, 12 Jul 2023 03:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qJUT2-0006rE-Fw
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:40:59 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qJUT0-0006qz-E3
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689147654; x=1720683654;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VJApsMWtEMRp8NNkn7PHsV7VdDnJEJTobgOET2s86y8=;
 b=TqE/MPbIiExhNenr4Uf7K8HSis4dVw7Wu7ol6FFbMAG4JFgtnaut3QQ5
 fc6vujeWEFfAFdnmgbNmTjCJzQYm9f4Ls3UI5ZPbjw50dvYbxDxErKKu4
 +Pc+pL2NCmX5LybD8RSrKCrotQ0YilDh3rqp2+wUJITESxUh3Xa4/IhSi
 BbPYf9IVTF3UBvP1BIICNzJsSrDaw0DDWimHW8FqGUUF5MQTqdUwX+3+O
 DpV8ayQpiErl7xUY6EgHybprB7MT6+DjsqSrEj7sAsmw9wIW9yB6pKWyx
 9ijeID1b8FCoKXwt6hjytvGkRfCG8QbPlji8+yxaMY1tgqyWv7aAv5v6O Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="430953866"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="430953866"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 00:40:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="835024157"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="835024157"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 00:40:15 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, eric.auger@redhat.com, peterx@redhat.com,
 jasonwang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [RFC PATCH v4 22/24] vfio/pci: Adapt vfio pci hot reset support with
 iommufd BE
Date: Wed, 12 Jul 2023 15:25:26 +0800
Message-Id: <20230712072528.275577-23-zhenzhong.duan@intel.com>
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

As pci hot reset path need to reference pci specific functions
and data structures, adding container level callback functions
for legacy and iommufd BE and referencing those pci specific
func/data is no better than implementing reset support with
iommufd BE directly in pci.c

This way we can also share the common bus reset and system reset
path for different BEs.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/pci.c        | 224 +++++++++++++++++++++++++++++++++++++++----
 hw/vfio/trace-events |   1 +
 2 files changed, 208 insertions(+), 17 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 43e4da9bff..6e49ac5ee9 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -42,6 +42,7 @@
 #include "qapi/error.h"
 #include "migration/blocker.h"
 #include "migration/qemu-file.h"
+#include "linux/iommufd.h"
 
 #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
 
@@ -2378,22 +2379,13 @@ static bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name)
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
-
-    trace_vfio_pci_hot_reset(vdev->vbasedev.name, single ? "one" : "multi");
+    int ret, count;
 
-    if (!single) {
-        vfio_pci_pre_reset(vdev);
-    }
-    vdev->vbasedev.needs_reset = false;
+    assert(info_p && !*info_p);
 
     info = g_malloc0(sizeof(*info));
     info->argsz = sizeof(*info);
@@ -2401,24 +2393,53 @@ static int vfio_pci_hot_reset(VFIOPCIDevice *vdev, bool single)
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
 
@@ -2560,6 +2581,175 @@ out_single:
     return ret;
 }
 
+#ifdef CONFIG_IOMMUFD
+static VFIODevice *vfio_pci_iommufd_binded(__u32 devid)
+{
+    VFIOAddressSpace *space;
+    VFIOContainer *bcontainer;
+    VFIOIOMMUFDContainer *container;
+    VFIOIOASHwpt *hwpt;
+    VFIODevice *vbasedev_iter;
+    VFIOIOMMUBackendOpsClass *ops = VFIO_IOMMU_BACKEND_OPS_CLASS(
+        object_class_by_name(TYPE_VFIO_IOMMU_BACKEND_IOMMUFD_OPS));
+
+     QLIST_FOREACH(space, &vfio_address_spaces, list) {
+        QLIST_FOREACH(bcontainer, &space->containers, next) {
+            if (bcontainer->ops != ops) {
+                continue;
+            }
+            container = container_of(bcontainer, VFIOIOMMUFDContainer,
+                                     bcontainer);
+            QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
+                QLIST_FOREACH(vbasedev_iter, &hwpt->device_list, next) {
+                    if (devid == vbasedev_iter->devid) {
+                        return vbasedev_iter;
+                    }
+                }
+            }
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
+        vbasedev_iter = vfio_pci_iommufd_binded(devices[i].devid);
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
+        vbasedev_iter = vfio_pci_iommufd_binded(devices[i].devid);
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
index 4412c510e4..375c57f4fb 100644
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


