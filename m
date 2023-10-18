Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE227CD88A
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 11:51:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt38C-0000pn-Mz; Wed, 18 Oct 2023 05:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=VFJy=GA=redhat.com=clg@ozlabs.org>)
 id 1qt37u-0000PE-V3
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:46:13 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=VFJy=GA=redhat.com=clg@ozlabs.org>)
 id 1qt37n-0003TA-Rf
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:46:01 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S9Qvn5Gmhz4xbT;
 Wed, 18 Oct 2023 20:45:57 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9Qvl4ZmHz4xbC;
 Wed, 18 Oct 2023 20:45:55 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 07/22] vfio/pci: Introduce vfio_[attach/detach]_device
Date: Wed, 18 Oct 2023 11:45:16 +0200
Message-ID: <20231018094531.733211-8-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018094531.733211-1-clg@redhat.com>
References: <20231018094531.733211-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=VFJy=GA=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

We also take benefit of this patch to properly free
vbasedev->name on failure.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h |  3 ++
 hw/vfio/common.c              | 74 +++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c                 | 66 +++++++------------------------
 hw/vfio/trace-events          |  3 +-
 4 files changed, 93 insertions(+), 53 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index c4e7c3b4a7757087ab4bc02b634216bf3ae857d6..12fbfbc37d466abcd85a838f26567dc0add84de0 100644
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
index d8ed432cb6d0e8e955984401cdbbe921d87636f7..f4c33c9858f5cc2b8245a9725fd660e7898ee760 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -2611,3 +2611,77 @@ int vfio_eeh_as_op(AddressSpace *as, uint32_t op)
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
+/*
+ * vfio_attach_device: attach a device to a security context
+ * @name and @vbasedev->name are likely to be different depending
+ * on the type of the device, hence the need for passing @name
+ */
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
+    trace_vfio_detach_device(vbasedev->name, group->groupid);
+    vfio_put_base_device(vbasedev);
+    vfio_put_group(group);
+}
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 898296fd5441b07fded7e50a53b2927683dd4b1a..40ae46266e33a2b58ed1069113c2967489ed3b95 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2895,10 +2895,10 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
 
 static void vfio_pci_put_device(VFIOPCIDevice *vdev)
 {
+    vfio_detach_device(&vdev->vbasedev);
+
     g_free(vdev->vbasedev.name);
     g_free(vdev->msix);
-
-    vfio_put_base_device(&vdev->vbasedev);
 }
 
 static void vfio_err_notifier_handler(void *opaque)
@@ -3045,13 +3045,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
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
@@ -3082,39 +3078,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
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
@@ -3132,7 +3095,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     if (vbasedev->ram_block_discard_allowed && !is_mdev) {
         error_setg(errp, "x-balloon-allowed only potentially compatible "
                    "with mdev devices");
-        vfio_put_group(group);
         goto error;
     }
 
@@ -3143,17 +3105,17 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
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
 
     vfio_populate_device(vdev, &err);
     if (err) {
         error_propagate(errp, err);
-        goto error;
+        goto out_detach;
     }
 
     /* Get a copy of config space */
@@ -3163,7 +3125,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     if (ret < (int)MIN(pci_config_size(&vdev->pdev), vdev->config_size)) {
         ret = ret < 0 ? -errno : -EFAULT;
         error_setg_errno(errp, -ret, "failed to read device config space");
-        goto error;
+        goto out_detach;
     }
 
     /* vfio emulates a lot for us, but some bits need extra love */
@@ -3182,7 +3144,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     if (vdev->vendor_id != PCI_ANY_ID) {
         if (vdev->vendor_id >= 0xffff) {
             error_setg(errp, "invalid PCI vendor ID provided");
-            goto error;
+            goto out_detach;
         }
         vfio_add_emulated_word(vdev, PCI_VENDOR_ID, vdev->vendor_id, ~0);
         trace_vfio_pci_emulated_vendor_id(vbasedev->name, vdev->vendor_id);
@@ -3193,7 +3155,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     if (vdev->device_id != PCI_ANY_ID) {
         if (vdev->device_id > 0xffff) {
             error_setg(errp, "invalid PCI device ID provided");
-            goto error;
+            goto out_detach;
         }
         vfio_add_emulated_word(vdev, PCI_DEVICE_ID, vdev->device_id, ~0);
         trace_vfio_pci_emulated_device_id(vbasedev->name, vdev->device_id);
@@ -3204,7 +3166,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     if (vdev->sub_vendor_id != PCI_ANY_ID) {
         if (vdev->sub_vendor_id > 0xffff) {
             error_setg(errp, "invalid PCI subsystem vendor ID provided");
-            goto error;
+            goto out_detach;
         }
         vfio_add_emulated_word(vdev, PCI_SUBSYSTEM_VENDOR_ID,
                                vdev->sub_vendor_id, ~0);
@@ -3215,7 +3177,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     if (vdev->sub_device_id != PCI_ANY_ID) {
         if (vdev->sub_device_id > 0xffff) {
             error_setg(errp, "invalid PCI subsystem device ID provided");
-            goto error;
+            goto out_detach;
         }
         vfio_add_emulated_word(vdev, PCI_SUBSYSTEM_ID, vdev->sub_device_id, ~0);
         trace_vfio_pci_emulated_sub_device_id(vbasedev->name,
@@ -3248,7 +3210,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     vfio_msix_early_setup(vdev, &err);
     if (err) {
         error_propagate(errp, err);
-        goto error;
+        goto out_detach;
     }
 
     vfio_bars_register(vdev);
@@ -3364,6 +3326,8 @@ out_deregister:
 out_teardown:
     vfio_teardown_msi(vdev);
     vfio_bars_exit(vdev);
+out_detach:
+    vfio_detach_device(vbasedev);
 error:
     error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
 }
@@ -3371,7 +3335,6 @@ error:
 static void vfio_instance_finalize(Object *obj)
 {
     VFIOPCIDevice *vdev = VFIO_PCI(obj);
-    VFIOGroup *group = vdev->vbasedev.group;
 
     vfio_display_finalize(vdev);
     vfio_bars_finalize(vdev);
@@ -3385,7 +3348,6 @@ static void vfio_instance_finalize(Object *obj)
      * g_free(vdev->igd_opregion);
      */
     vfio_pci_put_device(vdev);
-    vfio_put_group(group);
 }
 
 static void vfio_exitfn(PCIDevice *pdev)
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 0ba3c5a0e26bc82f40a0d7737e68128d2c9334fe..8ac13eb106db68c4f547b1b3819f96272309a124 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -37,7 +37,8 @@ vfio_pci_hot_reset_dep_devices(int domain, int bus, int slot, int function, int
 vfio_pci_hot_reset_result(const char *name, const char *result) "%s hot reset: %s"
 vfio_populate_device_config(const char *name, unsigned long size, unsigned long offset, unsigned long flags) "Device %s config:\n  size: 0x%lx, offset: 0x%lx, flags: 0x%lx"
 vfio_populate_device_get_irq_info_failure(const char *errstr) "VFIO_DEVICE_GET_IRQ_INFO failure: %s"
-vfio_realize(const char *name, int group_id) " (%s) group %d"
+vfio_attach_device(const char *name, int group_id) " (%s) group %d"
+vfio_detach_device(const char *name, int group_id) " (%s) group %d"
 vfio_mdev(const char *name, bool is_mdev) " (%s) is_mdev %d"
 vfio_add_ext_cap_dropped(const char *name, uint16_t cap, uint16_t offset) "%s 0x%x@0x%x"
 vfio_pci_reset(const char *name) " (%s)"
-- 
2.41.0


