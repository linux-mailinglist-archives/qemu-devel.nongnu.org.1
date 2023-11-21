Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2BA7F27DF
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 09:47:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5MPf-0006Sz-Up; Tue, 21 Nov 2023 03:47:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5MPe-0006Sj-Hj
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:47:18 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5MPb-0001cm-FH
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:47:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700556435; x=1732092435;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EAe7XZq9QM0SYPbyPTESyBLfOXRjEFRfeioVOqIGqq4=;
 b=aA1DFMDtWAfuS7pDQYusIAQWANALclQ+ofpybLbblKn4IVkiXJ0thhQX
 SGMOoKYgA1jPunQsC1uY+yh6EH1BEdAvN9aSF3t/m28mFb2ecHFC5HpHt
 Yvc5sp9SJhy7NjUJP0HbAZsTDwqA01ppaH4AqC74bIv3GppcYJjqGEirB
 hIoweB2788KqpG5bSPAzJ0lhOAK655LZQlZpM7Ca9mD8QuPowerebXVkH
 KvAjq/3itXnERV5pVu57A/err1geG0bwKnO+1V9E6Q4IyCehUeODllusW
 5+qIqtcR1EKFCj7FWQBOpFGKE6pr3dFEZnnGufXwpTNhUALNmS4GC4Ihr w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="395722134"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; d="scan'208";a="395722134"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2023 00:47:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="884124951"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; d="scan'208";a="884124951"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2023 00:47:02 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com
Subject: [PATCH v7 11/27] vfio/pci: Make vfio cdev pre-openable by passing a
 file handle
Date: Tue, 21 Nov 2023 16:44:10 +0800
Message-Id: <20231121084426.1286987-12-zhenzhong.duan@intel.com>
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

This gives management tools like libvirt a chance to open the vfio
cdev with privilege and pass FD to qemu. This way qemu never needs
to have privilege to open a VFIO or iommu cdev node.

Together with the earlier support of pre-opening /dev/iommu device,
now we have full support of passing a vfio device to unprivileged
qemu by management tool. This mode is no more considered for the
legacy backend. So let's remove the "TODO" comment.

Add helper functions vfio_device_set_fd() and vfio_device_get_name()
to set fd and get device name, they will also be used by other vfio
devices.

There is no easy way to check if a device is mdev with FD passing,
so fail the x-balloon-allowed check unconditionally in this case.

There is also no easy way to get BDF as name with FD passing, so
we fake a name by VFIO_FD[fd].

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
---
 include/hw/vfio/vfio-common.h |  4 ++++
 hw/vfio/helpers.c             | 43 +++++++++++++++++++++++++++++++++++
 hw/vfio/iommufd.c             | 12 ++++++----
 hw/vfio/pci.c                 | 28 +++++++++++++----------
 4 files changed, 71 insertions(+), 16 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 3dac5c167e..697bf24a35 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -251,4 +251,8 @@ int vfio_devices_query_dirty_bitmap(VFIOContainerBase *bcontainer,
                                     hwaddr size);
 int vfio_get_dirty_bitmap(VFIOContainerBase *bcontainer, uint64_t iova,
                                  uint64_t size, ram_addr_t ram_addr);
+
+/* Returns 0 on success, or a negative errno. */
+int vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
+void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
 #endif /* HW_VFIO_VFIO_COMMON_H */
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 168847e7c5..3592c3d54e 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -27,6 +27,7 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "monitor/monitor.h"
 
 /*
  * Common VFIO interrupt disable
@@ -609,3 +610,45 @@ bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type)
 
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
+    } else {
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
+
+    return 0;
+}
+
+void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
+{
+    int fd = monitor_fd_param(monitor_cur(), str, errp);
+
+    if (fd < 0) {
+        error_prepend(errp, "Could not parse remote object fd %s:", str);
+        return;
+    }
+    vbasedev->fd = fd;
+}
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 6e53e013ef..5accd26484 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -320,11 +320,15 @@ static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
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
 
     ret = iommufd_cdev_connect_and_bind(vbasedev, errp);
     if (ret) {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c5984b0598..445d58c8e5 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2944,17 +2944,19 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
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
             error_append_hint(errp, "Use -device vfio-pci,host=DDDD:BB:DD.F "
+#ifdef CONFIG_IOMMUFD
+                              "or -device vfio-pci,fd=DEVICE_FD "
+#endif
                               "or -device vfio-pci,sysfsdev=PATH_TO_DEVICE\n");
             return;
         }
@@ -2964,13 +2966,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
                             vdev->host.slot, vdev->host.function);
     }
 
-    if (stat(vbasedev->sysfsdev, &st) < 0) {
-        error_setg_errno(errp, errno, "no such host device");
-        error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->sysfsdev);
+    if (vfio_device_get_name(vbasedev, errp) < 0) {
         return;
     }
-
-    vbasedev->name = g_path_get_basename(vbasedev->sysfsdev);
     vbasedev->ops = &vfio_pci_ops;
     vbasedev->type = VFIO_DEVICE_TYPE_PCI;
     vbasedev->dev = DEVICE(vdev);
@@ -3330,6 +3328,7 @@ static void vfio_instance_init(Object *obj)
     vdev->host.bus = ~0U;
     vdev->host.slot = ~0U;
     vdev->host.function = ~0U;
+    vdev->vbasedev.fd = -1;
 
     vdev->nv_gpudirect_clique = 0xFF;
 
@@ -3383,11 +3382,6 @@ static Property vfio_pci_dev_properties[] = {
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
@@ -3395,6 +3389,13 @@ static Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+#ifdef CONFIG_IOMMUFD
+static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
+{
+    vfio_device_set_fd(&VFIO_PCI(obj)->vbasedev, str, errp);
+}
+#endif
+
 static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -3402,6 +3403,9 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
 
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


