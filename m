Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5678C7E6A3A
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 13:02:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r13jK-0001t0-6p; Thu, 09 Nov 2023 07:01:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r13j5-0001sj-RY
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 07:01:35 -0500
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r13j2-0001ej-9d
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 07:01:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699531292; x=1731067292;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=F3chQL1M72NeWVmCa7AhXQWoLFGv95OLyspEsviFHKg=;
 b=OefVwF8hSv/FifCw3Hx1wSm9OLESlVX/olGxaz/v63YH/TrAXlCH6nc/
 ZHy8v7SzRTmSlO8SN7QXhhX0CQUtQsiLLX9NkS/7YtE5hgMfIGR+ylBFH
 /OAks5iY4QzEyFzLPihr2JkSbscsggg0Hhc0KnwhqxylDoE2uFdS3O2nS
 kCalLK7YUgt24oZGjsisAcshyNWmViGQn6YnKuY9HrtoxcU7b9W29mFjI
 8J2tDH9pUzmSApLXHv6Hcm/SLzuUDL8nrS0upqs/jikMqaMxqUyXwKahN
 v7DhF3obXon6jW+oJEYttEcFTO03GPZG+gNsmVu3g8Ao8JHmW5o9Wdbgd Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="369305635"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; d="scan'208";a="369305635"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2023 04:01:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; d="scan'208";a="11516004"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2023 04:01:19 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v5 07/20] vfio/pci: Introduce a vfio pci hot reset interface
Date: Thu,  9 Nov 2023 19:45:16 +0800
Message-Id: <20231109114529.1904193-8-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109114529.1904193-1-zhenzhong.duan@intel.com>
References: <20231109114529.1904193-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.136;
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

Legacy vfio pci and iommufd cdev have different process to hot reset
vfio device, expand current code to abstract out pci_hot_reset callback
for legacy vfio, this same interface will also be used by iommufd
cdev vfio device.

Rename vfio_pci_hot_reset to vfio_legacy_pci_hot_reset and move it
into container.c, vfio_pci_host_match is also moved as a dependency.

vfio_pci_[pre/post]_reset are exported so they could be called in
legacy and iommufd pci_hot_reset callback.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
v5: Move vfio_legacy_pci_hot_reset into container.c

 hw/vfio/pci.h                         |   2 +
 include/hw/vfio/vfio-container-base.h |   3 +
 hw/vfio/container.c                   | 177 ++++++++++++++++++++++++++
 hw/vfio/pci.c                         | 176 +------------------------
 4 files changed, 187 insertions(+), 171 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 1006061afb..9264bce721 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -218,6 +218,8 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr);
 
 extern const PropertyInfo qdev_prop_nv_gpudirect_clique;
 
+void vfio_pci_pre_reset(VFIOPCIDevice *vdev);
+void vfio_pci_post_reset(VFIOPCIDevice *vdev);
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
index ed2d721b2b..cb957d063b 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -33,6 +33,7 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "migration/migration.h"
+#include "pci.h"
 
 VFIOGroupList vfio_group_list =
     QLIST_HEAD_INITIALIZER(vfio_group_list);
@@ -922,6 +923,181 @@ static void vfio_legacy_detach_device(VFIODevice *vbasedev)
     vfio_put_group(group);
 }
 
+static bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name)
+{
+    char tmp[13];
+
+    sprintf(tmp, "%04x:%02x:%02x.%1x", addr->domain,
+            addr->bus, addr->slot, addr->function);
+
+    return (strcmp(tmp, name) == 0);
+}
+
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
@@ -929,4 +1105,5 @@ const VFIOIOMMUOps vfio_legacy_ops = {
     .detach_device = vfio_legacy_detach_device,
     .set_dirty_page_tracking = vfio_legacy_set_dirty_page_tracking,
     .query_dirty_bitmap = vfio_legacy_query_dirty_bitmap,
+    .pci_hot_reset = vfio_legacy_pci_hot_reset,
 };
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index eb55e8ae88..257dae6a87 100644
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
@@ -2435,16 +2435,6 @@ static void vfio_pci_post_reset(VFIOPCIDevice *vdev)
     vfio_quirk_reset(vdev);
 }
 
-static bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name)
-{
-    char tmp[13];
-
-    sprintf(tmp, "%04x:%02x:%02x.%1x", addr->domain,
-            addr->bus, addr->slot, addr->function);
-
-    return (strcmp(tmp, name) == 0);
-}
-
 int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
                                     struct vfio_pci_hot_reset_info **info_p)
 {
@@ -2485,166 +2475,10 @@ int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
 
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


