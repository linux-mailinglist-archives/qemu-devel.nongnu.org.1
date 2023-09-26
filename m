Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 403967AEBC0
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 13:48:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql6Xl-0002Ko-JM; Tue, 26 Sep 2023 07:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ql6Xj-0002Jo-VK
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 07:47:55 -0400
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ql6Xg-0002Mw-LF
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 07:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695728872; x=1727264872;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vtdpUsNVaP2oQakmimI6zjUPacj7auoOPMVARWfhUNA=;
 b=XNZrzYFRYBwsV8q07kXiJjFfQrKlJQjxWQlh0M9us881GFk4mDY+T22K
 HHc1we0dMKByPLhiOQvHBFU+F23ElemczZzj3Pe73AcWeO/V8Fgqnm5ga
 cKqYSnZ0gGIQiLTM/85jpZDwZVU0HWND+g6nvCUx3x6SiMH49OBRh9vB3
 OsdlrWM4OnwXoas1rkoB3FIMbIEeGuBoDMwKce8tnKFM8PMhLBjFnbUzL
 S3d8nrGnFR35Zl2pCbpFmzrM/zqAparjn69d2aSh7o2i6vtQDr1Os3Tog
 l+jVNeItCVeqqA421FnLBjddCoDViYajssfCYiMZXTfyhCfy0Oyrtn8wh Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="378825435"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; d="scan'208";a="378825435"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 04:47:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="748789672"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; d="scan'208";a="748789672"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 04:47:46 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 06/12] vfio/pci: Introduce vfio_[attach/detach]_device
Date: Tue, 26 Sep 2023 19:32:49 +0800
Message-Id: <20230926113255.1177834-7-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926113255.1177834-1-zhenzhong.duan@intel.com>
References: <20230926113255.1177834-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.93;
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

From: Eric Auger <eric.auger@redhat.com>

We want the VFIO devices to be able to use two different
IOMMU backends, the legacy VFIO one and the new iommufd one.

Introduce vfio_[attach/detach]_device which aim at hiding the
underlying IOMMU backend (IOCTLs, datatypes, ...).

Once vfio_attach_device completes, the device is attached
to a security context and its fd can be used. Conversely
When vfio_detach_device completes, the device has been
detached from the security context.

At the moment only the implementation based on the legacy
container/group exists. Let's use it from the vfio-pci device.
Subsequent patches will handle other devices.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h |  3 ++
 hw/vfio/common.c              | 68 +++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c                 | 50 +++-----------------------
 hw/vfio/trace-events          |  2 +-
 4 files changed, 77 insertions(+), 46 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index c4e7c3b4a7..12fbfbc37d 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -225,6 +225,9 @@ void vfio_put_group(VFIOGroup *group);
 struct vfio_device_info *vfio_get_device_info(int fd);
 int vfio_get_device(VFIOGroup *group, const char *name,
                     VFIODevice *vbasedev, Error **errp);
+int vfio_attach_device(char *name, VFIODevice *vbasedev,
+                       AddressSpace *as, Error **errp);
+void vfio_detach_device(VFIODevice *vbasedev);
 
 int vfio_kvm_device_add_fd(int fd, Error **errp);
 int vfio_kvm_device_del_fd(int fd, Error **errp);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 959b1362bb..7f3798b152 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -2611,3 +2611,71 @@ int vfio_eeh_as_op(AddressSpace *as, uint32_t op)
     }
     return vfio_eeh_container_op(container, op);
 }
+
+static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
+{
+    char *tmp, group_path[PATH_MAX], *group_name;
+    int ret, groupid;
+    ssize_t len;
+
+    tmp = g_strdup_printf("%s/iommu_group", vbasedev->sysfsdev);
+    len = readlink(tmp, group_path, sizeof(group_path));
+    g_free(tmp);
+
+    if (len <= 0 || len >= sizeof(group_path)) {
+        ret = len < 0 ? -errno : -ENAMETOOLONG;
+        error_setg_errno(errp, -ret, "no iommu_group found");
+        return ret;
+    }
+
+    group_path[len] = 0;
+
+    group_name = basename(group_path);
+    if (sscanf(group_name, "%d", &groupid) != 1) {
+        error_setg_errno(errp, errno, "failed to read %s", group_path);
+        return -errno;
+    }
+    return groupid;
+}
+
+int vfio_attach_device(char *name, VFIODevice *vbasedev,
+                       AddressSpace *as, Error **errp)
+{
+    int groupid = vfio_device_groupid(vbasedev, errp);
+    VFIODevice *vbasedev_iter;
+    VFIOGroup *group;
+    int ret;
+
+    if (groupid < 0) {
+        return groupid;
+    }
+
+    trace_vfio_attach_device(vbasedev->name, groupid);
+
+    group = vfio_get_group(groupid, as, errp);
+    if (!group) {
+        return -ENOENT;
+    }
+
+    QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
+        if (strcmp(vbasedev_iter->name, vbasedev->name) == 0) {
+            error_setg(errp, "device is already attached");
+            vfio_put_group(group);
+            return -EBUSY;
+        }
+    }
+    ret = vfio_get_device(group, name, vbasedev, errp);
+    if (ret) {
+        vfio_put_group(group);
+    }
+
+    return ret;
+}
+
+void vfio_detach_device(VFIODevice *vbasedev)
+{
+    VFIOGroup *group = vbasedev->group;
+
+    vfio_put_base_device(vbasedev);
+    vfio_put_group(group);
+}
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 3b2ca3c24c..fe56789893 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2828,10 +2828,10 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
 
 static void vfio_put_device(VFIOPCIDevice *vdev)
 {
+    vfio_detach_device(&vdev->vbasedev);
+
     g_free(vdev->vbasedev.name);
     g_free(vdev->msix);
-
-    vfio_put_base_device(&vdev->vbasedev);
 }
 
 static void vfio_err_notifier_handler(void *opaque)
@@ -2978,13 +2978,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 {
     VFIOPCIDevice *vdev = VFIO_PCI(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
-    VFIODevice *vbasedev_iter;
-    VFIOGroup *group;
-    char *tmp, *subsys, group_path[PATH_MAX], *group_name;
+    char *tmp, *subsys;
     Error *err = NULL;
-    ssize_t len;
     struct stat st;
-    int groupid;
     int i, ret;
     bool is_mdev;
     char uuid[UUID_FMT_LEN];
@@ -3015,39 +3011,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     vbasedev->type = VFIO_DEVICE_TYPE_PCI;
     vbasedev->dev = DEVICE(vdev);
 
-    tmp = g_strdup_printf("%s/iommu_group", vbasedev->sysfsdev);
-    len = readlink(tmp, group_path, sizeof(group_path));
-    g_free(tmp);
-
-    if (len <= 0 || len >= sizeof(group_path)) {
-        error_setg_errno(errp, len < 0 ? errno : ENAMETOOLONG,
-                         "no iommu_group found");
-        goto error;
-    }
-
-    group_path[len] = 0;
-
-    group_name = basename(group_path);
-    if (sscanf(group_name, "%d", &groupid) != 1) {
-        error_setg_errno(errp, errno, "failed to read %s", group_path);
-        goto error;
-    }
-
-    trace_vfio_realize(vbasedev->name, groupid);
-
-    group = vfio_get_group(groupid, pci_device_iommu_address_space(pdev), errp);
-    if (!group) {
-        goto error;
-    }
-
-    QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
-        if (strcmp(vbasedev_iter->name, vbasedev->name) == 0) {
-            error_setg(errp, "device is already attached");
-            vfio_put_group(group);
-            goto error;
-        }
-    }
-
     /*
      * Mediated devices *might* operate compatibly with discarding of RAM, but
      * we cannot know for certain, it depends on whether the mdev vendor driver
@@ -3065,7 +3028,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     if (vbasedev->ram_block_discard_allowed && !is_mdev) {
         error_setg(errp, "x-balloon-allowed only potentially compatible "
                    "with mdev devices");
-        vfio_put_group(group);
         goto error;
     }
 
@@ -3076,10 +3038,10 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         name = g_strdup(vbasedev->name);
     }
 
-    ret = vfio_get_device(group, name, vbasedev, errp);
+    ret = vfio_attach_device(name, vbasedev,
+                             pci_device_iommu_address_space(pdev), errp);
     g_free(name);
     if (ret) {
-        vfio_put_group(group);
         goto error;
     }
 
@@ -3304,7 +3266,6 @@ error:
 static void vfio_instance_finalize(Object *obj)
 {
     VFIOPCIDevice *vdev = VFIO_PCI(obj);
-    VFIOGroup *group = vdev->vbasedev.group;
 
     vfio_display_finalize(vdev);
     vfio_bars_finalize(vdev);
@@ -3318,7 +3279,6 @@ static void vfio_instance_finalize(Object *obj)
      * g_free(vdev->igd_opregion);
      */
     vfio_put_device(vdev);
-    vfio_put_group(group);
 }
 
 static void vfio_exitfn(PCIDevice *pdev)
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index e64ca4a019..e710026a73 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -37,7 +37,7 @@ vfio_pci_hot_reset_dep_devices(int domain, int bus, int slot, int function, int
 vfio_pci_hot_reset_result(const char *name, const char *result) "%s hot reset: %s"
 vfio_populate_device_config(const char *name, unsigned long size, unsigned long offset, unsigned long flags) "Device %s config:\n  size: 0x%lx, offset: 0x%lx, flags: 0x%lx"
 vfio_populate_device_get_irq_info_failure(const char *errstr) "VFIO_DEVICE_GET_IRQ_INFO failure: %s"
-vfio_realize(const char *name, int group_id) " (%s) group %d"
+vfio_attach_device(const char *name, int group_id) " (%s) group %d"
 vfio_mdev(const char *name, bool is_mdev) " (%s) is_mdev %d"
 vfio_add_ext_cap_dropped(const char *name, uint16_t cap, uint16_t offset) "%s 0x%x@0x%x"
 vfio_pci_reset(const char *name) " (%s)"
-- 
2.34.1


