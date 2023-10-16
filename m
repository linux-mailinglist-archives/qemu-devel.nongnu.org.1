Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5867CA25D
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 10:49:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJHl-0002vG-UM; Mon, 16 Oct 2023 04:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJHU-0002ku-32
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:48:56 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJHQ-0001HS-Ru
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697446132; x=1728982132;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+5euWQCg0SwFy0K+UjW/imvDiJ5SW8o4bCCUOEJuxCs=;
 b=fkVMJnBrfox8OxS3i6n6cUDsesopx2vgydBqavVumfEz8NlxtvRq2Y5Q
 PyNryr+uQBJqTCtDQkh37nuL4AsgcbBb3Ubh4tuFHH0jpxYBzkh0o33Od
 7UX7CM/xYQ632Rq1y5yXGsiRa8PJTr/H7VqcXChmGWzvITYretLAzG7/u
 iF7EGLTJZRuCutBcqLzAdWr61UB7N9xbOI0SUrmVhYETeHGFvg8/yYhad
 6urnLkm+3IcsbyCkdGjTwj8SZirKkGjYG4YPsVJoQaPg8SqtJ/8xnmdFq
 sQnLKw56ZwRLBbxgo1vBefHG5g6pFyrhzjjuaArLjzVd30bxU0kjhC8Ew A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="365737687"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="365737687"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:48:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="749223014"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="749223014"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:48:37 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 19/27] vfio/iommufd: Implement the iommufd backend
Date: Mon, 16 Oct 2023 16:32:15 +0800
Message-Id: <20231016083223.1519410-20-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016083223.1519410-1-zhenzhong.duan@intel.com>
References: <20231016083223.1519410-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.151;
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

From: Yi Liu <yi.l.liu@intel.com>

Add the iommufd backend. The IOMMUFD container class is implemented
based on the new /dev/iommu user API. This backend obviously depends
on CONFIG_IOMMUFD.

So far, the iommufd backend doesn't support dirty page sync yet due
to missing support in the host kernel.

Co-authored-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h         |  22 ++
 include/hw/vfio/vfio-container-base.h |   3 +
 hw/vfio/common.c                      |  19 +-
 hw/vfio/iommufd.c                     | 535 ++++++++++++++++++++++++++
 hw/vfio/meson.build                   |   3 +
 hw/vfio/trace-events                  |  12 +
 6 files changed, 590 insertions(+), 4 deletions(-)
 create mode 100644 hw/vfio/iommufd.c

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 9f2b86581b..e72f5962ee 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -83,6 +83,23 @@ typedef struct VFIOLegacyContainer {
     QLIST_HEAD(, VFIOGroup) group_list;
 } VFIOLegacyContainer;
 
+#ifdef CONFIG_IOMMUFD
+typedef struct VFIOIOASHwpt {
+    uint32_t hwpt_id;
+    QLIST_HEAD(, VFIODevice) device_list;
+    QLIST_ENTRY(VFIOIOASHwpt) next;
+} VFIOIOASHwpt;
+
+typedef struct IOMMUFDBackend IOMMUFDBackend;
+
+typedef struct VFIOIOMMUFDContainer {
+    VFIOContainer bcontainer;
+    IOMMUFDBackend *be;
+    uint32_t ioas_id;
+    QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
+} VFIOIOMMUFDContainer;
+#endif
+
 typedef struct VFIODeviceOps VFIODeviceOps;
 
 typedef struct VFIODevice {
@@ -110,6 +127,11 @@ typedef struct VFIODevice {
     OnOffAuto pre_copy_dirty_page_tracking;
     bool dirty_pages_supported;
     bool dirty_tracking;
+#ifdef CONFIG_IOMMUFD
+    int devid;
+    VFIOIOASHwpt *hwpt;
+    IOMMUFDBackend *iommufd;
+#endif
 } VFIODevice;
 
 struct VFIODeviceOps {
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 9a5971a00a..5345986993 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -114,6 +114,9 @@ void vfio_container_init(VFIOContainer *bcontainer,
 void vfio_container_destroy(VFIOContainer *bcontainer);
 
 #define TYPE_VFIO_IOMMU_BACKEND_LEGACY_OPS "vfio-iommu-backend-legacy-ops"
+#ifdef CONFIG_IOMMUFD
+#define TYPE_VFIO_IOMMU_BACKEND_IOMMUFD_OPS "vfio-iommu-backend-iommufd-ops"
+#endif
 #define TYPE_VFIO_IOMMU_BACKEND_OPS "vfio-iommu-backend-ops"
 
 DECLARE_CLASS_CHECKERS(VFIOIOMMUBackendOpsClass,
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index ee2ebf4be9..6901573c32 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1520,10 +1520,13 @@ VFIOAddressSpace *vfio_get_address_space(AddressSpace *as)
 
 void vfio_put_address_space(VFIOAddressSpace *space)
 {
-    if (QLIST_EMPTY(&space->containers)) {
-        QLIST_REMOVE(space, list);
-        g_free(space);
+    if (!QLIST_EMPTY(&space->containers)) {
+        return;
     }
+
+    QLIST_REMOVE(space, list);
+    g_free(space);
+
     if (QLIST_EMPTY(&vfio_address_spaces)) {
         qemu_unregister_reset(vfio_reset_handler, NULL);
     }
@@ -1558,8 +1561,16 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
 {
     const VFIOIOMMUBackendOpsClass *ops;
 
-    ops = VFIO_IOMMU_BACKEND_OPS_CLASS(
+#ifdef CONFIG_IOMMUFD
+    if (vbasedev->iommufd) {
+        ops = VFIO_IOMMU_BACKEND_OPS_CLASS(
+                  object_class_by_name(TYPE_VFIO_IOMMU_BACKEND_IOMMUFD_OPS));
+    } else
+#endif
+    {
+        ops = VFIO_IOMMU_BACKEND_OPS_CLASS(
                   object_class_by_name(TYPE_VFIO_IOMMU_BACKEND_LEGACY_OPS));
+    }
     if (!ops) {
         error_setg(errp, "VFIO IOMMU Backend not found!");
         return -ENODEV;
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
new file mode 100644
index 0000000000..ee8c4620b6
--- /dev/null
+++ b/hw/vfio/iommufd.c
@@ -0,0 +1,535 @@
+/*
+ * iommufd container backend
+ *
+ * Copyright (C) 2023 Intel Corporation.
+ * Copyright Red Hat, Inc. 2023
+ *
+ * Authors: Yi Liu <yi.l.liu@intel.com>
+ *          Eric Auger <eric.auger@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include <sys/ioctl.h>
+#include <linux/vfio.h>
+#include <linux/iommufd.h>
+
+#include "hw/vfio/vfio-common.h"
+#include "qemu/error-report.h"
+#include "trace.h"
+#include "qapi/error.h"
+#include "sysemu/iommufd.h"
+#include "hw/qdev-core.h"
+#include "sysemu/reset.h"
+#include "qemu/cutils.h"
+#include "qemu/chardev_open.h"
+
+static int iommufd_map(VFIOContainer *bcontainer, hwaddr iova,
+                       ram_addr_t size, void *vaddr, bool readonly)
+{
+    VFIOIOMMUFDContainer *container =
+        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
+
+    return iommufd_backend_map_dma(container->be,
+                                   container->ioas_id,
+                                   iova, size, vaddr, readonly);
+}
+
+static int iommufd_unmap(VFIOContainer *bcontainer,
+                         hwaddr iova, ram_addr_t size,
+                         IOMMUTLBEntry *iotlb)
+{
+    VFIOIOMMUFDContainer *container =
+        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
+
+    /* TODO: Handle dma_unmap_bitmap with iotlb args (migration) */
+    return iommufd_backend_unmap_dma(container->be,
+                                     container->ioas_id, iova, size);
+}
+
+static void vfio_kvm_device_add_device(VFIODevice *vbasedev)
+{
+    Error *err = NULL;
+
+    if (vfio_kvm_device_add_fd(vbasedev->fd, &err)) {
+        error_report_err(err);
+    }
+}
+
+static void vfio_kvm_device_del_device(VFIODevice *vbasedev)
+{
+    Error *err = NULL;
+
+    if (vfio_kvm_device_del_fd(vbasedev->fd, &err)) {
+        error_report_err(err);
+    }
+}
+
+static int iommufd_connect_and_bind(VFIODevice *vbasedev, Error **errp)
+{
+    IOMMUFDBackend *iommufd = vbasedev->iommufd;
+    struct vfio_device_bind_iommufd bind = {
+        .argsz = sizeof(bind),
+        .flags = 0,
+    };
+    int ret;
+
+    ret = iommufd_backend_connect(iommufd, errp);
+    if (ret) {
+        return ret;
+    }
+
+    /*
+     * Add device to kvm-vfio to be prepared for the tracking
+     * in KVM. Especially for some emulated devices, it requires
+     * to have kvm information in the device open.
+     */
+    vfio_kvm_device_add_device(vbasedev);
+
+    /* Bind device to iommufd */
+    bind.iommufd = iommufd->fd;
+    ret = ioctl(vbasedev->fd, VFIO_DEVICE_BIND_IOMMUFD, &bind);
+    if (ret) {
+        error_setg_errno(errp, errno, "error bind device fd=%d to iommufd=%d",
+                         vbasedev->fd, bind.iommufd);
+        goto err_bind;
+    }
+
+    vbasedev->devid = bind.out_devid;
+    trace_vfio_iommufd_bind_device(bind.iommufd, vbasedev->name,
+                                   vbasedev->fd, vbasedev->devid);
+    return ret;
+err_bind:
+    vfio_kvm_device_del_device(vbasedev);
+    iommufd_backend_disconnect(iommufd);
+    return ret;
+}
+
+static void iommufd_unbind_and_disconnect(VFIODevice *vbasedev)
+{
+    /* Unbind is automatically conducted when device fd is closed */
+    vfio_kvm_device_del_device(vbasedev);
+    iommufd_backend_disconnect(vbasedev->iommufd);
+}
+
+static int vfio_get_devicefd(const char *sysfs_path, Error **errp)
+{
+    long int ret = -ENOTTY;
+    char *path, *vfio_dev_path = NULL, *vfio_path = NULL;
+    DIR *dir = NULL;
+    struct dirent *dent;
+    gchar *contents;
+    struct stat st;
+    gsize length;
+    int major, minor;
+    dev_t vfio_devt;
+
+    path = g_strdup_printf("%s/vfio-dev", sysfs_path);
+    if (stat(path, &st) < 0) {
+        error_setg_errno(errp, errno, "no such host device");
+        goto out_free_path;
+    }
+
+    dir = opendir(path);
+    if (!dir) {
+        error_setg_errno(errp, errno, "couldn't open dirrectory %s", path);
+        goto out_free_path;
+    }
+
+    while ((dent = readdir(dir))) {
+        if (!strncmp(dent->d_name, "vfio", 4)) {
+            vfio_dev_path = g_strdup_printf("%s/%s/dev", path, dent->d_name);
+            break;
+        }
+    }
+
+    if (!vfio_dev_path) {
+        error_setg(errp, "failed to find vfio-dev/vfioX/dev");
+        goto out_close_dir;
+    }
+
+    if (!g_file_get_contents(vfio_dev_path, &contents, &length, NULL)) {
+        error_setg(errp, "failed to load \"%s\"", vfio_dev_path);
+        goto out_free_dev_path;
+    }
+
+    if (sscanf(contents, "%d:%d", &major, &minor) != 2) {
+        error_setg(errp, "failed to get major:minor for \"%s\"", vfio_dev_path);
+        goto out_free_dev_path;
+    }
+    g_free(contents);
+    vfio_devt = makedev(major, minor);
+
+    vfio_path = g_strdup_printf("/dev/vfio/devices/%s", dent->d_name);
+    ret = open_cdev(vfio_path, vfio_devt);
+    if (ret < 0) {
+        error_setg(errp, "Failed to open %s", vfio_path);
+    }
+
+    trace_vfio_iommufd_get_devicefd(vfio_path, ret);
+    g_free(vfio_path);
+
+out_free_dev_path:
+    g_free(vfio_dev_path);
+out_close_dir:
+    closedir(dir);
+out_free_path:
+    if (*errp) {
+        error_prepend(errp, VFIO_MSG_PREFIX, path);
+    }
+    g_free(path);
+
+    return ret;
+}
+
+static VFIOIOASHwpt *vfio_container_get_hwpt(VFIOIOMMUFDContainer *container,
+                                             uint32_t hwpt_id)
+{
+    VFIOIOASHwpt *hwpt;
+
+    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
+        if (hwpt->hwpt_id == hwpt_id) {
+            return hwpt;
+        }
+    }
+
+    hwpt = g_malloc0(sizeof(*hwpt));
+
+    hwpt->hwpt_id = hwpt_id;
+    QLIST_INIT(&hwpt->device_list);
+    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
+
+    return hwpt;
+}
+
+static void vfio_container_put_hwpt(IOMMUFDBackend *be, VFIOIOASHwpt *hwpt)
+{
+    QLIST_REMOVE(hwpt, next);
+    iommufd_backend_free_id(be->fd, hwpt->hwpt_id);
+    g_free(hwpt);
+}
+
+static int __vfio_device_attach_hwpt(VFIODevice *vbasedev, uint32_t hwpt_id,
+                                     Error **errp)
+{
+    struct vfio_device_attach_iommufd_pt attach_data = {
+        .argsz = sizeof(attach_data),
+        .flags = 0,
+        .pt_id = hwpt_id,
+    };
+    int ret;
+
+    ret = ioctl(vbasedev->fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data);
+    if (ret) {
+        error_setg_errno(errp, errno,
+                         "[iommufd=%d] error attach %s (%d) to hwpt_id=%d",
+                         vbasedev->iommufd->fd, vbasedev->name, vbasedev->fd,
+                         hwpt_id);
+    }
+    return ret;
+}
+
+static int __vfio_device_detach_hwpt(VFIODevice *vbasedev, Error **errp)
+{
+    struct vfio_device_detach_iommufd_pt detach_data = {
+        .argsz = sizeof(detach_data),
+        .flags = 0,
+    };
+    int ret;
+
+    ret = ioctl(vbasedev->fd, VFIO_DEVICE_DETACH_IOMMUFD_PT, &detach_data);
+    if (ret) {
+        error_setg_errno(errp, errno, "detach %s from ioas failed",
+                         vbasedev->name);
+    }
+    return ret;
+}
+
+static int vfio_device_attach_container(VFIODevice *vbasedev,
+                                        VFIOIOMMUFDContainer *container,
+                                        Error **errp)
+{
+    int ret, iommufd = vbasedev->iommufd->fd;
+    VFIOIOASHwpt *hwpt;
+    uint32_t hwpt_id;
+    Error *err = NULL;
+
+    /* try to attach to an existing hwpt in this container */
+    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
+        ret = __vfio_device_attach_hwpt(vbasedev, hwpt->hwpt_id, &err);
+        if (ret) {
+            const char *msg = error_get_pretty(err);
+
+            trace_vfio_iommufd_fail_attach_existing_hwpt(msg);
+            error_free(err);
+            err = NULL;
+        } else {
+            goto found_hwpt;
+        }
+    }
+
+    ret = iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
+                                     container->ioas_id, &hwpt_id);
+
+    if (ret) {
+        error_setg_errno(errp, errno, "error alloc shadow hwpt");
+        return ret;
+    }
+
+    /* Attach device to an hwpt within iommufd */
+    ret = __vfio_device_attach_hwpt(vbasedev, hwpt_id, errp);
+    if (ret) {
+        iommufd_backend_free_id(iommufd, hwpt_id);
+        return ret;
+    }
+
+    hwpt = vfio_container_get_hwpt(container, hwpt_id);
+found_hwpt:
+    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, next);
+    vbasedev->hwpt = hwpt;
+
+    trace_vfio_iommufd_attach_device(iommufd, vbasedev->name, vbasedev->fd,
+                                     container->ioas_id, hwpt->hwpt_id);
+    return ret;
+}
+
+static void vfio_device_detach_container(VFIODevice *vbasedev,
+                                         VFIOIOMMUFDContainer *container)
+{
+    VFIOIOASHwpt *hwpt = vbasedev->hwpt;
+    Error *err = NULL;
+    int ret;
+
+    ret = __vfio_device_detach_hwpt(vbasedev, &err);
+    if (ret) {
+        error_report_err(err);
+    }
+
+    QLIST_REMOVE(vbasedev, next);
+    vbasedev->hwpt = NULL;
+    if (QLIST_EMPTY(&hwpt->device_list)) {
+        vfio_container_put_hwpt(vbasedev->iommufd, hwpt);
+    }
+
+    trace_vfio_iommufd_detach_device(container->be->fd, vbasedev->name,
+                                     container->ioas_id);
+}
+
+static void vfio_iommufd_container_destroy(VFIOIOMMUFDContainer *container)
+{
+    VFIOContainer *bcontainer = &container->bcontainer;
+
+    if (!QLIST_EMPTY(&container->hwpt_list)) {
+        return;
+    }
+    memory_listener_unregister(&bcontainer->listener);
+    vfio_container_destroy(bcontainer);
+    iommufd_backend_put_ioas(container->be, container->ioas_id);
+    g_free(container);
+}
+
+static int vfio_ram_block_discard_disable(bool state)
+{
+    /*
+     * We support coordinated discarding of RAM via the RamDiscardManager.
+     */
+    return ram_block_uncoordinated_discard_disable(state);
+}
+
+static int iommufd_attach_device(char *name, VFIODevice *vbasedev,
+                                 AddressSpace *as, Error **errp)
+{
+    VFIOIOMMUBackendOpsClass *ops = VFIO_IOMMU_BACKEND_OPS_CLASS(
+        object_class_by_name(TYPE_VFIO_IOMMU_BACKEND_IOMMUFD_OPS));
+    VFIOContainer *bcontainer;
+    VFIOIOMMUFDContainer *container;
+    VFIOAddressSpace *space;
+    struct vfio_device_info dev_info = { .argsz = sizeof(dev_info) };
+    int ret, devfd;
+    uint32_t ioas_id;
+    Error *err = NULL;
+
+    devfd = vfio_get_devicefd(vbasedev->sysfsdev, errp);
+    if (devfd < 0) {
+        return devfd;
+    }
+    vbasedev->fd = devfd;
+
+    ret = iommufd_connect_and_bind(vbasedev, errp);
+    if (ret) {
+        goto err_connect_bind;
+    }
+
+    space = vfio_get_address_space(as);
+
+    /* try to attach to an existing container in this space */
+    QLIST_FOREACH(bcontainer, &space->containers, next) {
+        container = container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
+        if (bcontainer->ops != ops || vbasedev->iommufd != container->be) {
+            continue;
+        }
+        if (vfio_device_attach_container(vbasedev, container, &err)) {
+            const char *msg = error_get_pretty(err);
+
+            trace_vfio_iommufd_fail_attach_existing_container(msg);
+            error_free(err);
+            err = NULL;
+        } else {
+            ret = vfio_ram_block_discard_disable(true);
+            if (ret) {
+                error_setg(errp,
+                              "Cannot set discarding of RAM broken (%d)", ret);
+                goto err_discard_disable;
+            }
+            goto found_container;
+        }
+    }
+
+    /* Need to allocate a new dedicated container */
+    ret = iommufd_backend_get_ioas(vbasedev->iommufd, &ioas_id);
+    if (ret < 0) {
+        error_setg_errno(errp, errno, "Failed to alloc ioas");
+        goto err_get_ioas;
+    }
+
+    trace_vfio_iommufd_alloc_ioas(vbasedev->iommufd->fd, ioas_id);
+
+    container = g_malloc0(sizeof(*container));
+    container->be = vbasedev->iommufd;
+    container->ioas_id = ioas_id;
+    QLIST_INIT(&container->hwpt_list);
+
+    bcontainer = &container->bcontainer;
+    vfio_container_init(bcontainer, space, ops);
+    QLIST_INSERT_HEAD(&space->containers, bcontainer, next);
+
+    ret = vfio_device_attach_container(vbasedev, container, errp);
+    if (ret) {
+        goto err_attach_container;
+    }
+
+    ret = vfio_ram_block_discard_disable(true);
+    if (ret) {
+        goto err_discard_disable;
+    }
+
+    /*
+     * TODO: for now iommufd BE is on par with vfio iommu type1, so it's
+     * fine to add the whole range as window. For SPAPR, below code
+     * should be updated.
+     */
+    vfio_host_win_add(bcontainer, 0, (hwaddr)-1, 4096);
+    bcontainer->pgsizes = 4096;
+
+    bcontainer->listener = vfio_memory_listener;
+
+    memory_listener_register(&bcontainer->listener, bcontainer->space->as);
+
+    if (bcontainer->error) {
+        ret = -1;
+        error_propagate_prepend(errp, bcontainer->error,
+                                "memory listener initialization failed: ");
+        goto err_listener_register;
+    }
+
+    bcontainer->initialized = true;
+
+found_container:
+    ret = ioctl(devfd, VFIO_DEVICE_GET_INFO, &dev_info);
+    if (ret) {
+        error_setg_errno(errp, errno, "error getting device info");
+        goto err_listener_register;
+    }
+
+    /*
+     * TODO: examine RAM_BLOCK_DISCARD stuff, should we do group level
+     * for discarding incompatibility check as well?
+     */
+    if (vbasedev->ram_block_discard_allowed) {
+        vfio_ram_block_discard_disable(false);
+    }
+
+    vbasedev->group = 0;
+    vbasedev->num_irqs = dev_info.num_irqs;
+    vbasedev->num_regions = dev_info.num_regions;
+    vbasedev->flags = dev_info.flags;
+    vbasedev->reset_works = !!(dev_info.flags & VFIO_DEVICE_FLAGS_RESET);
+    vbasedev->bcontainer = bcontainer;
+    QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
+    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
+
+    trace_vfio_iommufd_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
+                                   vbasedev->num_regions, vbasedev->flags);
+    return 0;
+
+err_listener_register:
+    vfio_ram_block_discard_disable(false);
+err_discard_disable:
+    vfio_device_detach_container(vbasedev, container);
+err_attach_container:
+    vfio_iommufd_container_destroy(container);
+err_get_ioas:
+    vfio_put_address_space(space);
+    iommufd_unbind_and_disconnect(vbasedev);
+err_connect_bind:
+    close(vbasedev->fd);
+    return ret;
+}
+
+static void iommufd_detach_device(VFIODevice *vbasedev)
+{
+    VFIOContainer *bcontainer = vbasedev->bcontainer;
+    VFIOIOMMUFDContainer *container;
+    VFIOAddressSpace *space = bcontainer->space;
+
+    QLIST_REMOVE(vbasedev, global_next);
+    QLIST_REMOVE(vbasedev, container_next);
+    vbasedev->bcontainer = NULL;
+
+    if (!vbasedev->ram_block_discard_allowed) {
+        vfio_ram_block_discard_disable(false);
+    }
+
+    container = container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
+    vfio_device_detach_container(vbasedev, container);
+    vfio_iommufd_container_destroy(container);
+    vfio_put_address_space(space);
+
+    iommufd_unbind_and_disconnect(vbasedev);
+    close(vbasedev->fd);
+}
+
+static void vfio_iommu_backend_iommufd_ops_class_init(ObjectClass *oc,
+                                                      void *data) {
+    VFIOIOMMUBackendOpsClass *ops = VFIO_IOMMU_BACKEND_OPS_CLASS(oc);
+
+    ops->dma_map = iommufd_map;
+    ops->dma_unmap = iommufd_unmap;
+    ops->attach_device = iommufd_attach_device;
+    ops->detach_device = iommufd_detach_device;
+}
+
+static const TypeInfo vfio_iommu_backend_iommufd_ops_type = {
+    .name = TYPE_VFIO_IOMMU_BACKEND_IOMMUFD_OPS,
+
+    .parent = TYPE_VFIO_IOMMU_BACKEND_OPS,
+    .class_init = vfio_iommu_backend_iommufd_ops_class_init,
+    .abstract = true,
+};
+static void vfio_iommu_backend_iommufd_ops_register_types(void)
+{
+    type_register_static(&vfio_iommu_backend_iommufd_ops_type);
+}
+type_init(vfio_iommu_backend_iommufd_ops_register_types);
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index eb6ce6229d..9cae2c9e21 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -7,6 +7,9 @@ vfio_ss.add(files(
   'spapr.c',
   'migration.c',
 ))
+if have_iommufd
+  vfio_ss.add(files('iommufd.c'))
+endif
 vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'display.c',
   'pci-quirks.c',
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 08a1f9dfa4..9b180cf77c 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -164,3 +164,15 @@ vfio_state_pending_estimate(const char *name, uint64_t precopy, uint64_t postcop
 vfio_state_pending_exact(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" stopcopy size 0x%"PRIx64" precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
 vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
 vfio_vmstate_change_prepare(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
+
+#iommufd.c
+
+vfio_iommufd_get_devicefd(const char *dev, int devfd) " %s (fd=%d)"
+vfio_iommufd_bind_device(int iommufd, const char *name, int devfd, int devid) " [iommufd=%d] Successfully bound device %s (fd=%d): output devid=%d"
+vfio_iommufd_fail_attach_existing_hwpt(const char *msg) " %s"
+vfio_iommufd_attach_device(int iommufd, const char *name, int devfd, int ioasid, int hwptid) " [iommufd=%d] Successfully attached device %s (%d) to ioasid=%d: output hwptd=%d"
+vfio_iommufd_detach_device(int iommufd, const char *name, int ioasid) " [iommufd=%d] Detached %s from ioasid=%d"
+vfio_iommufd_alloc_ioas(int iommufd, int ioas_id) " [iommufd=%d] new IOMMUFD container with ioasid=%d"
+vfio_iommufd_device_info(char *name, int devfd, int num_irqs, int num_regions, int flags) " %s (%d) num_irqs=%d num_regions=%d flags=%d"
+vfio_iommufd_fail_attach_existing_container(const char *msg) " %s"
+vfio_iommufd_container_reset(char *name) " Successfully reset %s"
-- 
2.34.1


