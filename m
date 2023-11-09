Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB347E6A4D
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 13:04:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r13jR-00024q-2c; Thu, 09 Nov 2023 07:01:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r13jC-0001u4-BW
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 07:01:42 -0500
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r13j9-0001fh-Aq
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 07:01:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699531299; x=1731067299;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xuMqrolU/YiFApYLxxBQQeyKluti47WPxV54E6slIuE=;
 b=hwAmhZM0g1/A70LnPC98hd0POngQ0AOgFxmiJmm1Q4AmVyAc73UyKtym
 PlYyaXU49L/SnUG9n+ClBbqeAvefMukIDHCsdD20wuWV2m7rasuJLbHlQ
 /N+d4XYdHnEb9ymaX2wq6xRWECHSdx3pS3gSIfMLwe7HkcsQGAfpTf1bV
 ndenvSUGU8/h82Scnwxu5G92VUigZj9PBYBiMDgD9mmqp+ONrVENr7cSd
 7qf1T3KUS3Tr+DMkzmSW+uuukfDZQ8R1TOJGE8VpgyIy84RW/8KKR/3+F
 Ofd1AzJtHLShbOXBUjM3QQiaZFORigNgigYiKkK/3FiZF4CbhsCQosxYP w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="369305829"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; d="scan'208";a="369305829"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2023 04:01:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; d="scan'208";a="11516091"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2023 04:01:31 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v5 10/20] vfio/pci: Make vfio cdev pre-openable by passing a
 file handle
Date: Thu,  9 Nov 2023 19:45:19 +0800
Message-Id: <20231109114529.1904193-11-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109114529.1904193-1-zhenzhong.duan@intel.com>
References: <20231109114529.1904193-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
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

This gives management tools like libvirt a chance to open the vfio
cdev with privilege and pass FD to qemu. This way qemu never needs
to have privilege to open a VFIO or iommu cdev node.

Together with the earlier support of pre-opening /dev/iommu device,
now we have full support of passing a vfio device to unprivileged
qemu by management tool. This mode is no more considered for the
legacy backend. So let's remove the "TODO" comment.

Add a helper function vfio_device_get_name() to check fd and get
device name, it will also be used by other vfio devices.

There is no easy way to check if a device is mdev with FD passing,
so fail the x-balloon-allowed check unconditionally in this case.

There is also no easy way to get BDF as name with FD passing, so
we fake a name by VFIO_FD[fd].

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h |  1 +
 hw/vfio/helpers.c             | 34 +++++++++++++++++++++++++++++
 hw/vfio/iommufd.c             | 12 +++++++----
 hw/vfio/pci.c                 | 40 ++++++++++++++++++++++++-----------
 4 files changed, 71 insertions(+), 16 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 3dac5c167e..960a14e8d8 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -238,6 +238,7 @@ struct vfio_info_cap_header *
 vfio_get_device_info_cap(struct vfio_device_info *info, uint16_t id);
 struct vfio_info_cap_header *
 vfio_get_cap(void *ptr, uint32_t cap_offset, uint16_t id);
+int vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
 #endif
 
 bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 168847e7c5..d80aa58719 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -20,6 +20,7 @@
  */
 
 #include "qemu/osdep.h"
+#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
 #include <sys/ioctl.h>
 
 #include "hw/vfio/vfio-common.h"
@@ -609,3 +610,36 @@ bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type)
 
     return ret;
 }
+
+int vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
+{
+    struct stat st;
+
+    if (vbasedev->fd < 0) {
+        if (stat(vbasedev->sysfsdev, &st) < 0) {
+            error_setg_errno(errp, errno, "no such host device");
+            error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->sysfsdev);
+            return -errno;
+        }
+        /* User may specify a name, e.g: VFIO platform device */
+        if (!vbasedev->name) {
+            vbasedev->name = g_path_get_basename(vbasedev->sysfsdev);
+        }
+    }
+#ifdef CONFIG_IOMMUFD
+    else {
+        if (!vbasedev->iommufd) {
+            error_setg(errp, "Use FD passing only with iommufd backend");
+            return -EINVAL;
+        }
+        /*
+         * Give a name with fd so any function printing out vbasedev->name
+         * will not break.
+         */
+        if (!vbasedev->name) {
+            vbasedev->name = g_strdup_printf("VFIO_FD%d", vbasedev->fd);
+        }
+    }
+#endif
+    return 0;
+}
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 44dc6848bf..fd30477275 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -326,11 +326,15 @@ static int iommufd_attach_device(const char *name, VFIODevice *vbasedev,
     uint32_t ioas_id;
     Error *err = NULL;
 
-    devfd = iommufd_cdev_getfd(vbasedev->sysfsdev, errp);
-    if (devfd < 0) {
-        return devfd;
+    if (vbasedev->fd < 0) {
+        devfd = iommufd_cdev_getfd(vbasedev->sysfsdev, errp);
+        if (devfd < 0) {
+            return devfd;
+        }
+        vbasedev->fd = devfd;
+    } else {
+        devfd = vbasedev->fd;
     }
-    vbasedev->fd = devfd;
 
     ret = iommufd_connect_and_bind(vbasedev, errp);
     if (ret) {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index e9a426200b..f95725ed16 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -44,6 +44,7 @@
 #include "migration/blocker.h"
 #include "migration/qemu-file.h"
 #include "sysemu/iommufd.h"
+#include "monitor/monitor.h"
 
 #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
 
@@ -2934,18 +2935,23 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     VFIODevice *vbasedev = &vdev->vbasedev;
     char *tmp, *subsys;
     Error *err = NULL;
-    struct stat st;
     int i, ret;
     bool is_mdev;
     char uuid[UUID_STR_LEN];
     char *name;
 
-    if (!vbasedev->sysfsdev) {
+    if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
         if (!(~vdev->host.domain || ~vdev->host.bus ||
               ~vdev->host.slot || ~vdev->host.function)) {
             error_setg(errp, "No provided host device");
+#ifdef CONFIG_IOMMUFD
+            error_append_hint(errp, "Use -device vfio-pci,host=DDDD:BB:DD.F, "
+                              "-device vfio-pci,sysfsdev=PATH_TO_DEVICE "
+                              "or -device vfio-pci,fd=DEVICE_FD\n");
+#else
             error_append_hint(errp, "Use -device vfio-pci,host=DDDD:BB:DD.F "
                               "or -device vfio-pci,sysfsdev=PATH_TO_DEVICE\n");
+#endif
             return;
         }
         vbasedev->sysfsdev =
@@ -2954,13 +2960,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
                             vdev->host.slot, vdev->host.function);
     }
 
-    if (stat(vbasedev->sysfsdev, &st) < 0) {
-        error_setg_errno(errp, errno, "no such host device");
-        error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->sysfsdev);
+    if (vfio_device_get_name(vbasedev, errp)) {
         return;
     }
-
-    vbasedev->name = g_path_get_basename(vbasedev->sysfsdev);
     vbasedev->ops = &vfio_pci_ops;
     vbasedev->type = VFIO_DEVICE_TYPE_PCI;
     vbasedev->dev = DEVICE(vdev);
@@ -3320,6 +3322,7 @@ static void vfio_instance_init(Object *obj)
     vdev->host.bus = ~0U;
     vdev->host.slot = ~0U;
     vdev->host.function = ~0U;
+    vdev->vbasedev.fd = -1;
 
     vdev->nv_gpudirect_clique = 0xFF;
 
@@ -3373,11 +3376,6 @@ static Property vfio_pci_dev_properties[] = {
                                    qdev_prop_nv_gpudirect_clique, uint8_t),
     DEFINE_PROP_OFF_AUTO_PCIBAR("x-msix-relocation", VFIOPCIDevice, msix_relo,
                                 OFF_AUTOPCIBAR_OFF),
-    /*
-     * TODO - support passed fds... is this necessary?
-     * DEFINE_PROP_STRING("vfiofd", VFIOPCIDevice, vfiofd_name),
-     * DEFINE_PROP_STRING("vfiogroupfd, VFIOPCIDevice, vfiogroupfd_name),
-     */
 #ifdef CONFIG_IOMMUFD
     DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd,
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
@@ -3385,6 +3383,21 @@ static Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+#ifdef CONFIG_IOMMUFD
+static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
+{
+    VFIOPCIDevice *vdev = VFIO_PCI(obj);
+    int fd = -1;
+
+    fd = monitor_fd_param(monitor_cur(), str, errp);
+    if (fd == -1) {
+        error_prepend(errp, "Could not parse remote object fd %s:", str);
+        return;
+    }
+    vdev->vbasedev.fd = fd;
+}
+#endif
+
 static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -3392,6 +3405,9 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
 
     dc->reset = vfio_pci_reset;
     device_class_set_props(dc, vfio_pci_dev_properties);
+#ifdef CONFIG_IOMMUFD
+    object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
+#endif
     dc->desc = "VFIO-based PCI device assignment";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     pdc->realize = vfio_realize;
-- 
2.34.1


