Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B797E6A48
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 13:04:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r13jR-000269-TA; Thu, 09 Nov 2023 07:01:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r13jG-0001uS-Es
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 07:01:48 -0500
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r13jD-0001gn-L6
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 07:01:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699531303; x=1731067303;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/FVO90dmacO3PUCbL9JOBbZNyydyIi7kvmZeqZfjEvk=;
 b=ERmoBheHbqEIoxo1ntI3jZHfo7tOcPqcDunlSNzB4Pgux8TmxvbR01hw
 b5pYoj6r/b/saIZAroTAgDzZ5vC6BqVCmaiVYlJGYBCq0wuALCwC73xmx
 YyTt22TAfJqZ26WhYvpmbfQPH7slanW7mUTD3ie6obKVfW46y0o5BzwPy
 EeWUc9UX0bIuENarbEtqe0SO4jCQspOZuLO5m1lU0oFJ7eZ/7zFdXfwc1
 JjflWL+eVaxpktSYl45/yg3l7WRcy6/NGnDrmWnbK0dxbvdy+ki9msIZr
 712rwMAc4RdhU1JkA5Voj9X7iHE5A1nPOz3wZ5Ts7U3DEYFh+j6A3YZ8G g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="369305859"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; d="scan'208";a="369305859"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2023 04:01:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; d="scan'208";a="11516105"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2023 04:01:38 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v5 12/20] vfio/platform: Make vfio cdev pre-openable by
 passing a file handle
Date: Thu,  9 Nov 2023 19:45:21 +0800
Message-Id: <20231109114529.1904193-13-zhenzhong.duan@intel.com>
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

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/platform.c | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 86e176ee97..59a50b1598 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -36,6 +36,7 @@
 #include "hw/platform-bus.h"
 #include "hw/qdev-properties.h"
 #include "sysemu/kvm.h"
+#include "monitor/monitor.h"
 
 /*
  * Functions used whatever the injection method
@@ -530,14 +531,13 @@ static VFIODeviceOps vfio_platform_ops = {
  */
 static int vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
 {
-    struct stat st;
     int ret;
 
-    /* @sysfsdev takes precedence over @host */
-    if (vbasedev->sysfsdev) {
+    /* @fd takes precedence over @sysfsdev which takes precedence over @host */
+    if (vbasedev->fd < 0 && vbasedev->sysfsdev) {
         g_free(vbasedev->name);
         vbasedev->name = g_path_get_basename(vbasedev->sysfsdev);
-    } else {
+    } else if (vbasedev->fd < 0) {
         if (!vbasedev->name || strchr(vbasedev->name, '/')) {
             error_setg(errp, "wrong host device name");
             return -EINVAL;
@@ -547,10 +547,9 @@ static int vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
                                              vbasedev->name);
     }
 
-    if (stat(vbasedev->sysfsdev, &st) < 0) {
-        error_setg_errno(errp, errno,
-                         "failed to get the sysfs host device file status");
-        return -errno;
+    ret = vfio_device_get_name(vbasedev, errp);
+    if (ret) {
+        return ret;
     }
 
     ret = vfio_attach_device(vbasedev->name, vbasedev,
@@ -657,6 +656,28 @@ static Property vfio_platform_dev_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void vfio_platform_instance_init(Object *obj)
+{
+    VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(obj);
+
+    vdev->vbasedev.fd = -1;
+}
+
+#ifdef CONFIG_IOMMUFD
+static void vfio_platform_set_fd(Object *obj, const char *str, Error **errp)
+{
+    VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(obj);
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
 static void vfio_platform_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -664,6 +685,9 @@ static void vfio_platform_class_init(ObjectClass *klass, void *data)
 
     dc->realize = vfio_platform_realize;
     device_class_set_props(dc, vfio_platform_dev_properties);
+#ifdef CONFIG_IOMMUFD
+    object_class_property_add_str(klass, "fd", NULL, vfio_platform_set_fd);
+#endif
     dc->vmsd = &vfio_platform_vmstate;
     dc->desc = "VFIO-based platform device assignment";
     sbc->connect_irq_notifier = vfio_start_irqfd_injection;
@@ -676,6 +700,7 @@ static const TypeInfo vfio_platform_dev_info = {
     .name = TYPE_VFIO_PLATFORM,
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(VFIOPlatformDevice),
+    .instance_init = vfio_platform_instance_init,
     .class_init = vfio_platform_class_init,
     .class_size = sizeof(VFIOPlatformDeviceClass),
 };
-- 
2.34.1


