Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5031D78D541
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 12:55:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbIqS-0007tu-2b; Wed, 30 Aug 2023 06:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qbIqI-0007Ou-DY
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:54:36 -0400
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qbIqF-0007jy-QZ
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693392871; x=1724928871;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Fe536ojnXPqBN2KauwtAnauVAuNJwCDbrghoCi5sVtQ=;
 b=ePwGoogv1J4J0OSpZysST9IgLWvGl+qH1e+XIM8v4bMtLmVi/JuCq8VX
 7quyLFz9D3ptc2wIMHkQchYLLV28nYfhA6qm8BCmH3FFhz88fFhNWoNQ3
 nJyaJMZh64GdEruvSZ23Gs48QW8CYkOGIfoQ8ompZP+8IyovxIfGeEzOT
 /8qIyGJc8qSgolcGfFUhAClJPZgTmVsxRFL38Oosvg+CDJOKdgHBdIFGs
 iQNOCmF95n+udvNAh/b7+f1z1ASN3K+ghF/vI97MS3hAWArNs/4fvemvM
 kmT4zQJICFWtaIIjxkRrfrN4l39g4RDhDhWv6CreVF7dlKLG92iO0F3Hp g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="373016736"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; d="scan'208";a="373016736"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2023 03:54:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="715866316"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; d="scan'208";a="715866316"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2023 03:54:04 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v1 22/22] vfio/pci: Make vfio cdev pre-openable by passing a
 file handle
Date: Wed, 30 Aug 2023 18:37:54 +0800
Message-Id: <20230830103754.36461-23-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830103754.36461-1-zhenzhong.duan@intel.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
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

This gives management tools like libvirt a chance to open the vfio
cdev with privilege and pass FD to qemu. This way qemu never needs
to have privilege to open a VFIO or iommu cdev node.

Add a helper function vfio_device_get_name() to check fd and get
device name, it will also be used by other vfio devices.

There is no easy way to check if a device is mdev with FD passing,
so fail the x-balloon-allowed check unconditionally in this case.

There is also no easy way to get BDF as name with FD passing, so
we fake a name by VFIO_FD[fd].

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/helpers.c             | 28 ++++++++++++++++++++++++++++
 hw/vfio/iommufd.c             | 12 ++++++++----
 hw/vfio/pci.c                 | 35 ++++++++++++++++++++++++++++-------
 include/hw/vfio/vfio-common.h |  1 +
 4 files changed, 65 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 4338456b08..1a27efb075 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -596,3 +596,31 @@ bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type)
 
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
+        vbasedev->name = g_path_get_basename(vbasedev->sysfsdev);
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
+        vbasedev->name = g_strdup_printf("VFIO_FD%d", vbasedev->fd);
+    }
+#endif
+    return 0;
+}
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index dd24e76e39..2cd2daebf4 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -376,11 +376,15 @@ static int iommufd_attach_device(char *name, VFIODevice *vbasedev,
     uint32_t ioas_id;
     Error *err = NULL;
 
-    devfd = vfio_get_devicefd(vbasedev->sysfsdev, errp);
-    if (devfd < 0) {
-        return devfd;
+    if (vbasedev->fd < 0) {
+        devfd = vfio_get_devicefd(vbasedev->sysfsdev, errp);
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
index 99265253f8..eff52b5014 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -44,6 +44,7 @@
 #include "migration/qemu-file.h"
 #include "linux/iommufd.h"
 #include "sysemu/iommufd.h"
+#include "monitor/monitor.h"
 
 #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
 
@@ -3171,18 +3172,23 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     VFIODevice *vbasedev = &vdev->vbasedev;
     char *tmp, *subsys;
     Error *err = NULL;
-    struct stat st;
     int i, ret;
     bool is_mdev;
     char uuid[UUID_FMT_LEN];
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
@@ -3191,13 +3197,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
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
@@ -3559,6 +3561,7 @@ static void vfio_instance_init(Object *obj)
     vdev->host.bus = ~0U;
     vdev->host.slot = ~0U;
     vdev->host.function = ~0U;
+    vdev->vbasedev.fd = -1;
 
     vdev->nv_gpudirect_clique = 0xFF;
 
@@ -3619,6 +3622,21 @@ static Property vfio_pci_dev_properties[] = {
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
@@ -3626,6 +3644,9 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
 
     dc->reset = vfio_pci_reset;
     device_class_set_props(dc, vfio_pci_dev_properties);
+#ifdef CONFIG_IOMMUFD
+    object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
+#endif
     dc->desc = "VFIO-based PCI device assignment";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     pdc->realize = vfio_realize;
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 027a59a13a..41c8eeaa54 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -242,6 +242,7 @@ struct vfio_info_cap_header *
 vfio_get_device_info_cap(struct vfio_device_info *info, uint16_t id);
 struct vfio_info_cap_header *
 vfio_get_cap(void *ptr, uint32_t cap_offset, uint16_t id);
+int vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
 #endif
 extern const MemoryListener vfio_prereg_listener;
 
-- 
2.34.1


