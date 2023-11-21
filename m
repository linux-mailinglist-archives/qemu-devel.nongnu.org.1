Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D94F67F27DB
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 09:47:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5MPF-00066d-W1; Tue, 21 Nov 2023 03:46:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5MPE-00066S-74
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:46:52 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5MPB-0001Qo-LA
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:46:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700556409; x=1732092409;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UNas8XAavess8nltGjqiy+ekcAqAWzf1KSGBBlwm46k=;
 b=X/b/3d+tSRpD/xFY2saIxr4tp7wbQpViz+G1TfsujqC56UqJlOSsfrSq
 47norjBaKpz05CiEyfgJu0/bpglDrVZFjTEDPVYzJO9GPBGEjvPWFAzjy
 JB6N22XLIx8SK2PeCIw4JXCh/fbpx1aPBNo+Aelo5PKRyC2iYhMMqrR/y
 DAlNw/1Ov0bXhGLXPIpHozllDa/jE/qXbap8OeBTr6jYRlmkxt6gAUgvt
 TbgL6YMBtOIl/HUm8drmMT9JJoEYlnj3w/v7tGxNqw80uzf/i6zDDApye
 0jqfwoZXvZ19g+giM1Wdg3FDY/OnXwcAk+0avFXJLM6ZdzAMg1l2R38JB g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="395722084"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; d="scan'208";a="395722084"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2023 00:46:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="884124907"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; d="scan'208";a="884124907"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2023 00:46:45 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com
Subject: [PATCH v7 08/27] vfio/pci: Introduce a vfio pci hot reset interface
Date: Tue, 21 Nov 2023 16:44:07 +0800
Message-Id: <20231121084426.1286987-9-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121084426.1286987-1-zhenzhong.duan@intel.com>
References: <20231121084426.1286987-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Legacy vfio pci and iommufd cdev have different process to hot reset
vfio device, expand current code to abstract out pci_hot_reset callback
for legacy vfio, this same interface will also be used by iommufd
cdev vfio device.

Rename vfio_pci_hot_reset to vfio_legacy_pci_hot_reset and move it
into container.c.

vfio_pci_[pre/post]_reset and vfio_pci_host_match are exported so
they could be called in legacy and iommufd pci_hot_reset callback.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
---
 hw/vfio/pci.h                         |   3 +
 include/hw/vfio/vfio-container-base.h |   3 +
 hw/vfio/container.c                   | 170 ++++++++++++++++++++++++++
 hw/vfio/pci.c                         | 168 +------------------------
 4 files changed, 182 insertions(+), 162 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 1006061afb..6e64a2654e 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -218,6 +218,9 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr);
 
 extern const PropertyInfo qdev_prop_nv_gpudirect_clique;
 
+void vfio_pci_pre_reset(VFIOPCIDevice *vdev);
+void vfio_pci_post_reset(VFIOPCIDevice *vdev);
+bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name);
 int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
                                     struct vfio_pci_hot_reset_info **info_p);
 
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
index ed2d721b2b..1dbf9b9a17 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -33,6 +33,7 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "migration/migration.h"
+#include "pci.h"
 
 VFIOGroupList vfio_group_list =
     QLIST_HEAD_INITIALIZER(vfio_group_list);
@@ -922,6 +923,174 @@ static void vfio_legacy_detach_device(VFIODevice *vbasedev)
     vfio_put_group(group);
 }
 
+static int vfio_legacy_pci_hot_reset(VFIODevice *vbasedev, bool single)
+{
+    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
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
+        goto out_single;
+    }
+    devices = &info->devices[0];
+
+    trace_vfio_pci_hot_reset_has_dep_devices(vdev->vbasedev.name);
+
+    /* Verify that we have all the groups required */
+    for (i = 0; i < info->count; i++) {
+        PCIHostDeviceAddress host;
+        VFIOPCIDevice *tmp;
+        VFIODevice *vbasedev_iter;
+
+        host.domain = devices[i].segment;
+        host.bus = devices[i].bus;
+        host.slot = PCI_SLOT(devices[i].devfn);
+        host.function = PCI_FUNC(devices[i].devfn);
+
+        trace_vfio_pci_hot_reset_dep_devices(host.domain,
+                host.bus, host.slot, host.function, devices[i].group_id);
+
+        if (vfio_pci_host_match(&host, vdev->vbasedev.name)) {
+            continue;
+        }
+
+        QLIST_FOREACH(group, &vfio_group_list, next) {
+            if (group->groupid == devices[i].group_id) {
+                break;
+            }
+        }
+
+        if (!group) {
+            if (!vdev->has_pm_reset) {
+                error_report("vfio: Cannot reset device %s, "
+                             "depends on group %d which is not owned.",
+                             vdev->vbasedev.name, devices[i].group_id);
+            }
+            ret = -EPERM;
+            goto out;
+        }
+
+        /* Prep dependent devices for reset and clear our marker. */
+        QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
+            if (!vbasedev_iter->dev->realized ||
+                vbasedev_iter->type != VFIO_DEVICE_TYPE_PCI) {
+                continue;
+            }
+            tmp = container_of(vbasedev_iter, VFIOPCIDevice, vbasedev);
+            if (vfio_pci_host_match(&host, tmp->vbasedev.name)) {
+                if (single) {
+                    ret = -EINVAL;
+                    goto out_single;
+                }
+                vfio_pci_pre_reset(tmp);
+                tmp->vbasedev.needs_reset = false;
+                multi = true;
+                break;
+            }
+        }
+    }
+
+    if (!single && !multi) {
+        ret = -EINVAL;
+        goto out_single;
+    }
+
+    /* Determine how many group fds need to be passed */
+    count = 0;
+    QLIST_FOREACH(group, &vfio_group_list, next) {
+        for (i = 0; i < info->count; i++) {
+            if (group->groupid == devices[i].group_id) {
+                count++;
+                break;
+            }
+        }
+    }
+
+    reset = g_malloc0(sizeof(*reset) + (count * sizeof(*fds)));
+    reset->argsz = sizeof(*reset) + (count * sizeof(*fds));
+    fds = &reset->group_fds[0];
+
+    /* Fill in group fds */
+    QLIST_FOREACH(group, &vfio_group_list, next) {
+        for (i = 0; i < info->count; i++) {
+            if (group->groupid == devices[i].group_id) {
+                fds[reset->count++] = group->fd;
+                break;
+            }
+        }
+    }
+
+    /* Bus reset! */
+    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_PCI_HOT_RESET, reset);
+    g_free(reset);
+    if (ret) {
+        ret = -errno;
+    }
+
+    trace_vfio_pci_hot_reset_result(vdev->vbasedev.name,
+                                    ret ? strerror(errno) : "Success");
+
+out:
+    /* Re-enable INTx on affected devices */
+    for (i = 0; i < info->count; i++) {
+        PCIHostDeviceAddress host;
+        VFIOPCIDevice *tmp;
+        VFIODevice *vbasedev_iter;
+
+        host.domain = devices[i].segment;
+        host.bus = devices[i].bus;
+        host.slot = PCI_SLOT(devices[i].devfn);
+        host.function = PCI_FUNC(devices[i].devfn);
+
+        if (vfio_pci_host_match(&host, vdev->vbasedev.name)) {
+            continue;
+        }
+
+        QLIST_FOREACH(group, &vfio_group_list, next) {
+            if (group->groupid == devices[i].group_id) {
+                break;
+            }
+        }
+
+        if (!group) {
+            break;
+        }
+
+        QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
+            if (!vbasedev_iter->dev->realized ||
+                vbasedev_iter->type != VFIO_DEVICE_TYPE_PCI) {
+                continue;
+            }
+            tmp = container_of(vbasedev_iter, VFIOPCIDevice, vbasedev);
+            if (vfio_pci_host_match(&host, tmp->vbasedev.name)) {
+                vfio_pci_post_reset(tmp);
+                break;
+            }
+        }
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
 const VFIOIOMMUOps vfio_legacy_ops = {
     .dma_map = vfio_legacy_dma_map,
     .dma_unmap = vfio_legacy_dma_unmap,
@@ -929,4 +1098,5 @@ const VFIOIOMMUOps vfio_legacy_ops = {
     .detach_device = vfio_legacy_detach_device,
     .set_dirty_page_tracking = vfio_legacy_set_dirty_page_tracking,
     .query_dirty_bitmap = vfio_legacy_query_dirty_bitmap,
+    .pci_hot_reset = vfio_legacy_pci_hot_reset,
 };
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index eb55e8ae88..d00c3472c7 100644
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
@@ -2435,7 +2435,7 @@ static void vfio_pci_post_reset(VFIOPCIDevice *vdev)
     vfio_quirk_reset(vdev);
 }
 
-static bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name)
+bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name)
 {
     char tmp[13];
 
@@ -2485,166 +2485,10 @@ int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
 
 static int vfio_pci_hot_reset(VFIOPCIDevice *vdev, bool single)
 {
-    VFIOGroup *group;
-    struct vfio_pci_hot_reset_info *info = NULL;
-    struct vfio_pci_dependent_device *devices;
-    struct vfio_pci_hot_reset *reset;
-    int32_t *fds;
-    int ret, i, count;
-    bool multi = false;
-
-    trace_vfio_pci_hot_reset(vdev->vbasedev.name, single ? "one" : "multi");
-
-    if (!single) {
-        vfio_pci_pre_reset(vdev);
-    }
-    vdev->vbasedev.needs_reset = false;
-
-    ret = vfio_pci_get_pci_hot_reset_info(vdev, &info);
-
-    if (ret) {
-        goto out_single;
-    }
-    devices = &info->devices[0];
-
-    trace_vfio_pci_hot_reset_has_dep_devices(vdev->vbasedev.name);
-
-    /* Verify that we have all the groups required */
-    for (i = 0; i < info->count; i++) {
-        PCIHostDeviceAddress host;
-        VFIOPCIDevice *tmp;
-        VFIODevice *vbasedev_iter;
-
-        host.domain = devices[i].segment;
-        host.bus = devices[i].bus;
-        host.slot = PCI_SLOT(devices[i].devfn);
-        host.function = PCI_FUNC(devices[i].devfn);
-
-        trace_vfio_pci_hot_reset_dep_devices(host.domain,
-                host.bus, host.slot, host.function, devices[i].group_id);
-
-        if (vfio_pci_host_match(&host, vdev->vbasedev.name)) {
-            continue;
-        }
-
-        QLIST_FOREACH(group, &vfio_group_list, next) {
-            if (group->groupid == devices[i].group_id) {
-                break;
-            }
-        }
-
-        if (!group) {
-            if (!vdev->has_pm_reset) {
-                error_report("vfio: Cannot reset device %s, "
-                             "depends on group %d which is not owned.",
-                             vdev->vbasedev.name, devices[i].group_id);
-            }
-            ret = -EPERM;
-            goto out;
-        }
-
-        /* Prep dependent devices for reset and clear our marker. */
-        QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
-            if (!vbasedev_iter->dev->realized ||
-                vbasedev_iter->type != VFIO_DEVICE_TYPE_PCI) {
-                continue;
-            }
-            tmp = container_of(vbasedev_iter, VFIOPCIDevice, vbasedev);
-            if (vfio_pci_host_match(&host, tmp->vbasedev.name)) {
-                if (single) {
-                    ret = -EINVAL;
-                    goto out_single;
-                }
-                vfio_pci_pre_reset(tmp);
-                tmp->vbasedev.needs_reset = false;
-                multi = true;
-                break;
-            }
-        }
-    }
-
-    if (!single && !multi) {
-        ret = -EINVAL;
-        goto out_single;
-    }
-
-    /* Determine how many group fds need to be passed */
-    count = 0;
-    QLIST_FOREACH(group, &vfio_group_list, next) {
-        for (i = 0; i < info->count; i++) {
-            if (group->groupid == devices[i].group_id) {
-                count++;
-                break;
-            }
-        }
-    }
-
-    reset = g_malloc0(sizeof(*reset) + (count * sizeof(*fds)));
-    reset->argsz = sizeof(*reset) + (count * sizeof(*fds));
-    fds = &reset->group_fds[0];
-
-    /* Fill in group fds */
-    QLIST_FOREACH(group, &vfio_group_list, next) {
-        for (i = 0; i < info->count; i++) {
-            if (group->groupid == devices[i].group_id) {
-                fds[reset->count++] = group->fd;
-                break;
-            }
-        }
-    }
-
-    /* Bus reset! */
-    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_PCI_HOT_RESET, reset);
-    g_free(reset);
-
-    trace_vfio_pci_hot_reset_result(vdev->vbasedev.name,
-                                    ret ? strerror(errno) : "Success");
-
-out:
-    /* Re-enable INTx on affected devices */
-    for (i = 0; i < info->count; i++) {
-        PCIHostDeviceAddress host;
-        VFIOPCIDevice *tmp;
-        VFIODevice *vbasedev_iter;
-
-        host.domain = devices[i].segment;
-        host.bus = devices[i].bus;
-        host.slot = PCI_SLOT(devices[i].devfn);
-        host.function = PCI_FUNC(devices[i].devfn);
-
-        if (vfio_pci_host_match(&host, vdev->vbasedev.name)) {
-            continue;
-        }
-
-        QLIST_FOREACH(group, &vfio_group_list, next) {
-            if (group->groupid == devices[i].group_id) {
-                break;
-            }
-        }
-
-        if (!group) {
-            break;
-        }
-
-        QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
-            if (!vbasedev_iter->dev->realized ||
-                vbasedev_iter->type != VFIO_DEVICE_TYPE_PCI) {
-                continue;
-            }
-            tmp = container_of(vbasedev_iter, VFIOPCIDevice, vbasedev);
-            if (vfio_pci_host_match(&host, tmp->vbasedev.name)) {
-                vfio_pci_post_reset(tmp);
-                break;
-            }
-        }
-    }
-out_single:
-    if (!single) {
-        vfio_pci_post_reset(vdev);
-    }
-    g_free(info);
+    VFIODevice *vbasedev = &vdev->vbasedev;
+    const VFIOIOMMUOps *ops = vbasedev->bcontainer->ops;
 
-    return ret;
+    return ops->pci_hot_reset(vbasedev, single);
 }
 
 /*
-- 
2.34.1


