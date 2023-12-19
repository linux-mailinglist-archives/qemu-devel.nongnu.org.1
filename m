Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF9D819045
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:04:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfL9-0007pz-1N; Tue, 19 Dec 2023 14:01:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfJW-00055F-Sz
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:59:36 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfJT-0007Ru-Je
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:59:34 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SvmFs4Tw9z4xQj;
 Wed, 20 Dec 2023 05:59:29 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvmFn23P6z4xCp;
 Wed, 20 Dec 2023 05:59:24 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Subject: [PULL 30/47] vfio/pci: Make vfio cdev pre-openable by passing a file
 handle
Date: Tue, 19 Dec 2023 19:56:26 +0100
Message-ID: <20231219185643.725448-31-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219185643.725448-1-clg@redhat.com>
References: <20231219185643.725448-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=7/MV=H6=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

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
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h |  4 ++++
 hw/vfio/helpers.c             | 43 +++++++++++++++++++++++++++++++++++
 hw/vfio/iommufd.c             | 12 ++++++----
 hw/vfio/pci.c                 | 28 +++++++++++++----------
 4 files changed, 71 insertions(+), 16 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 3dac5c167efa1fc6afefc103539ce5e01cceb602..697bf24a350d5880e59811322d9037575a90d9a2 100644
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
index 168847e7c51ef35afbea276745c1aa7e6cd94ce0..3592c3d54ecd68d4bfd23d4c3402a393fb1f2eb0 100644
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
index 6e53e013ef57b6d7e3be58e61356fbabacbe8bf3..5accd2648444defcd698bd6d0cefe11d255b4cfb 100644
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
index c5984b0598d26e7dd31fdb12dccac2e3ca81adf3..445d58c8e59b0a00a8336d092c2b8cec7e39b396 100644
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
2.43.0


