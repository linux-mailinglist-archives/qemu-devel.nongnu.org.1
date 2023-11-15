Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8827EADF5
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 11:26:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2qcL-00036R-T0; Tue, 14 Nov 2023 05:26:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r2qc8-0002us-HT
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 05:25:52 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r2qc5-0007eY-9j
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 05:25:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699957545; x=1731493545;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1HZ8QkP8ww3f527wBi0MfiYRaju7xc4ku3B4y/JkJkc=;
 b=HkcEcmAGwsRHahESntPCXP8VPqw9XG1oHqXrkXYYU9md3acGy1XFLfli
 9DNCtxPBN8e3FQzu963XWZuGcDuZ7P7XSF+4VieKUVWi1CfMdPknwdlvl
 UK8cU53Ilz1I099DQI4LXE+MN3LSuOL05OWtQG/5j/GXbOlucVCU9AAcg
 9q+9358bNOojI/YkWdaC/bLYRUp8IbJwxY0AhaOhE8Wpq/yvABpwTOXbD
 0zJf4VG8kSq5IHX264Y5/9v00AOcD2TgLy/r1RmTg89W4dxHeoV+wupx2
 iCdP9Z07EGFa3sihZQYo9N6+hQOorpz9SqxtY3rJ9zIjKNOxrD1qwUrRs w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="394543431"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; d="scan'208";a="394543431"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 02:25:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="888212838"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; d="scan'208";a="888212838"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 02:25:39 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 04/21] vfio/iommufd: Implement the iommufd backend
Date: Tue, 14 Nov 2023 18:09:38 +0800
Message-Id: <20231114100955.1961974-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.65;
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

From: Yi Liu <yi.l.liu@intel.com>

Add the iommufd backend. The IOMMUFD container class is implemented
based on the new /dev/iommu user API. This backend obviously depends
on CONFIG_IOMMUFD.

So far, the iommufd backend doesn't support dirty page sync yet due
to missing support in the host kernel.

Co-authored-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
v6: simplify CONFIG_IOMMUFD checking code
    dirrectory -> directory
    check iommufd_cdev_kvm_device_add return value
    use prefix iommufd_cdev_* for all functions and trace event

 include/hw/vfio/vfio-common.h |  11 +
 hw/vfio/common.c              |   6 +
 hw/vfio/iommufd.c             | 428 ++++++++++++++++++++++++++++++++++
 hw/vfio/meson.build           |   3 +
 hw/vfio/trace-events          |  10 +
 5 files changed, 458 insertions(+)
 create mode 100644 hw/vfio/iommufd.c

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 24ecc0e7ee..3dac5c167e 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -89,6 +89,14 @@ typedef struct VFIOHostDMAWindow {
     QLIST_ENTRY(VFIOHostDMAWindow) hostwin_next;
 } VFIOHostDMAWindow;
 
+typedef struct IOMMUFDBackend IOMMUFDBackend;
+
+typedef struct VFIOIOMMUFDContainer {
+    VFIOContainerBase bcontainer;
+    IOMMUFDBackend *be;
+    uint32_t ioas_id;
+} VFIOIOMMUFDContainer;
+
 typedef struct VFIODeviceOps VFIODeviceOps;
 
 typedef struct VFIODevice {
@@ -116,6 +124,8 @@ typedef struct VFIODevice {
     OnOffAuto pre_copy_dirty_page_tracking;
     bool dirty_pages_supported;
     bool dirty_tracking;
+    int devid;
+    IOMMUFDBackend *iommufd;
 } VFIODevice;
 
 struct VFIODeviceOps {
@@ -201,6 +211,7 @@ typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
 extern VFIOGroupList vfio_group_list;
 extern VFIODeviceList vfio_device_list;
 extern const VFIOIOMMUOps vfio_legacy_ops;
+extern const VFIOIOMMUOps vfio_iommufd_ops;
 extern const MemoryListener vfio_memory_listener;
 extern int vfio_kvm_device_fd;
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 934f4f5446..6569732b7a 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
 #include <sys/ioctl.h>
 #ifdef CONFIG_KVM
 #include <linux/kvm.h>
@@ -1503,6 +1504,11 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
 {
     const VFIOIOMMUOps *ops = &vfio_legacy_ops;
 
+#ifdef CONFIG_IOMMUFD
+    if (vbasedev->iommufd) {
+        ops = &vfio_iommufd_ops;
+    }
+#endif
     return ops->attach_device(name, vbasedev, as, errp);
 }
 
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
new file mode 100644
index 0000000000..06282d885c
--- /dev/null
+++ b/hw/vfio/iommufd.c
@@ -0,0 +1,428 @@
+/*
+ * iommufd container backend
+ *
+ * Copyright (C) 2023 Intel Corporation.
+ * Copyright Red Hat, Inc. 2023
+ *
+ * Authors: Yi Liu <yi.l.liu@intel.com>
+ *          Eric Auger <eric.auger@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
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
+static int iommufd_cdev_map(VFIOContainerBase *bcontainer, hwaddr iova,
+                            ram_addr_t size, void *vaddr, bool readonly)
+{
+    VFIOIOMMUFDContainer *container =
+        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
+
+    return iommufd_backend_map_dma(container->be,
+                                   container->ioas_id,
+                                   iova, size, vaddr, readonly);
+}
+
+static int iommufd_cdev_unmap(VFIOContainerBase *bcontainer,
+                              hwaddr iova, ram_addr_t size,
+                              IOMMUTLBEntry *iotlb)
+{
+    VFIOIOMMUFDContainer *container =
+        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
+
+    /* TODO: Handle dma_unmap_bitmap with iotlb args (migration) */
+    return iommufd_backend_unmap_dma(container->be,
+                                     container->ioas_id, iova, size);
+}
+
+static int iommufd_cdev_kvm_device_add(VFIODevice *vbasedev, Error **errp)
+{
+    return vfio_kvm_device_add_fd(vbasedev->fd, errp);
+}
+
+static void iommufd_cdev_kvm_device_del(VFIODevice *vbasedev)
+{
+    Error *err = NULL;
+
+    if (vfio_kvm_device_del_fd(vbasedev->fd, &err)) {
+        error_report_err(err);
+    }
+}
+
+static int iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
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
+    ret = iommufd_cdev_kvm_device_add(vbasedev, errp);
+    if (ret) {
+        goto err_kvm_device_add;
+    }
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
+    trace_iommufd_cdev_connect_and_bind(bind.iommufd, vbasedev->name,
+                                        vbasedev->fd, vbasedev->devid);
+    return ret;
+err_bind:
+    iommufd_cdev_kvm_device_del(vbasedev);
+err_kvm_device_add:
+    iommufd_backend_disconnect(iommufd);
+    return ret;
+}
+
+static void iommufd_cdev_unbind_and_disconnect(VFIODevice *vbasedev)
+{
+    /* Unbind is automatically conducted when device fd is closed */
+    iommufd_cdev_kvm_device_del(vbasedev);
+    iommufd_backend_disconnect(vbasedev->iommufd);
+}
+
+static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
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
+        error_setg_errno(errp, errno, "couldn't open directory %s", path);
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
+    trace_iommufd_cdev_getfd(vfio_path, ret);
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
+static int iommufd_cdev_attach_ioas_hwpt(VFIODevice *vbasedev, bool is_ioas,
+                                         uint32_t id, Error **errp)
+{
+    int ret, iommufd = vbasedev->iommufd->fd;
+    struct vfio_device_attach_iommufd_pt attach_data = {
+        .argsz = sizeof(attach_data),
+        .flags = 0,
+        .pt_id = id,
+    };
+    const char *str = is_ioas ? "ioas" : "hwpt";
+
+    /* Attach device to an IOAS or hwpt within iommufd */
+    ret = ioctl(vbasedev->fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data);
+    if (ret) {
+        error_setg_errno(errp, errno,
+                         "[iommufd=%d] error attach %s (%d) to %s_id=%d",
+                         iommufd, vbasedev->name, vbasedev->fd, str, id);
+    } else {
+        trace_iommufd_cdev_attach_ioas_hwpt(iommufd, vbasedev->name,
+                                            vbasedev->fd, str, id);
+    }
+    return ret;
+}
+
+static int iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, bool is_ioas,
+                                         uint32_t id, Error **errp)
+{
+    int ret, iommufd = vbasedev->iommufd->fd;
+    struct vfio_device_detach_iommufd_pt detach_data = {
+        .argsz = sizeof(detach_data),
+        .flags = 0,
+    };
+    const char *str = is_ioas ? "ioas" : "hwpt";
+
+    ret = ioctl(vbasedev->fd, VFIO_DEVICE_DETACH_IOMMUFD_PT, &detach_data);
+    if (ret) {
+        error_setg_errno(errp, errno, "detach %s from %s failed",
+                         vbasedev->name, str);
+    } else {
+        trace_iommufd_cdev_detach_ioas_hwpt(iommufd, vbasedev->name, str, id);
+    }
+    return ret;
+}
+
+static int iommufd_cdev_attach_container(VFIODevice *vbasedev,
+                                         VFIOIOMMUFDContainer *container,
+                                         Error **errp)
+{
+    return iommufd_cdev_attach_ioas_hwpt(vbasedev, true,
+                                         container->ioas_id, errp);
+}
+
+static void iommufd_cdev_detach_container(VFIODevice *vbasedev,
+                                          VFIOIOMMUFDContainer *container)
+{
+    Error *err = NULL;
+
+    if (iommufd_cdev_detach_ioas_hwpt(vbasedev, true,
+                                      container->ioas_id, &err)) {
+        error_report_err(err);
+    }
+}
+
+static void iommufd_cdev_container_destroy(VFIOIOMMUFDContainer *container)
+{
+    VFIOContainerBase *bcontainer = &container->bcontainer;
+
+    if (!QLIST_EMPTY(&bcontainer->device_list)) {
+        return;
+    }
+    memory_listener_unregister(&bcontainer->listener);
+    vfio_container_destroy(bcontainer);
+    iommufd_backend_free_id(container->be, container->ioas_id);
+    g_free(container);
+}
+
+static int iommufd_cdev_ram_block_discard_disable(bool state)
+{
+    /*
+     * We support coordinated discarding of RAM via the RamDiscardManager.
+     */
+    return ram_block_uncoordinated_discard_disable(state);
+}
+
+static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
+                               AddressSpace *as, Error **errp)
+{
+    VFIOContainerBase *bcontainer;
+    VFIOIOMMUFDContainer *container;
+    VFIOAddressSpace *space;
+    struct vfio_device_info dev_info = { .argsz = sizeof(dev_info) };
+    int ret, devfd;
+    uint32_t ioas_id;
+    Error *err = NULL;
+
+    devfd = iommufd_cdev_getfd(vbasedev->sysfsdev, errp);
+    if (devfd < 0) {
+        return devfd;
+    }
+    vbasedev->fd = devfd;
+
+    ret = iommufd_cdev_connect_and_bind(vbasedev, errp);
+    if (ret) {
+        goto err_connect_bind;
+    }
+
+    space = vfio_get_address_space(as);
+
+    /* try to attach to an existing container in this space */
+    QLIST_FOREACH(bcontainer, &space->containers, next) {
+        container = container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
+        if (bcontainer->ops != &vfio_iommufd_ops ||
+            vbasedev->iommufd != container->be) {
+            continue;
+        }
+        if (iommufd_cdev_attach_container(vbasedev, container, &err)) {
+            const char *msg = error_get_pretty(err);
+
+            trace_iommufd_cdev_fail_attach_existing_container(msg);
+            error_free(err);
+            err = NULL;
+        } else {
+            ret = iommufd_cdev_ram_block_discard_disable(true);
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
+    ret = iommufd_backend_alloc_ioas(vbasedev->iommufd, &ioas_id, errp);
+    if (ret < 0) {
+        goto err_alloc_ioas;
+    }
+
+    trace_iommufd_cdev_alloc_ioas(vbasedev->iommufd->fd, ioas_id);
+
+    container = g_malloc0(sizeof(*container));
+    container->be = vbasedev->iommufd;
+    container->ioas_id = ioas_id;
+
+    bcontainer = &container->bcontainer;
+    vfio_container_init(bcontainer, space, &vfio_iommufd_ops);
+    QLIST_INSERT_HEAD(&space->containers, bcontainer, next);
+
+    ret = iommufd_cdev_attach_container(vbasedev, container, errp);
+    if (ret) {
+        goto err_attach_container;
+    }
+
+    ret = iommufd_cdev_ram_block_discard_disable(true);
+    if (ret) {
+        goto err_discard_disable;
+    }
+
+    bcontainer->pgsizes = qemu_real_host_page_size();
+
+    bcontainer->listener = vfio_memory_listener;
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
+        iommufd_cdev_ram_block_discard_disable(false);
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
+    trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
+                                   vbasedev->num_regions, vbasedev->flags);
+    return 0;
+
+err_listener_register:
+    iommufd_cdev_ram_block_discard_disable(false);
+err_discard_disable:
+    iommufd_cdev_detach_container(vbasedev, container);
+err_attach_container:
+    iommufd_cdev_container_destroy(container);
+err_alloc_ioas:
+    vfio_put_address_space(space);
+    iommufd_cdev_unbind_and_disconnect(vbasedev);
+err_connect_bind:
+    close(vbasedev->fd);
+    return ret;
+}
+
+static void iommufd_cdev_detach(VFIODevice *vbasedev)
+{
+    VFIOContainerBase *bcontainer = vbasedev->bcontainer;
+    VFIOIOMMUFDContainer *container;
+    VFIOAddressSpace *space = bcontainer->space;
+
+    QLIST_REMOVE(vbasedev, global_next);
+    QLIST_REMOVE(vbasedev, container_next);
+    vbasedev->bcontainer = NULL;
+
+    if (!vbasedev->ram_block_discard_allowed) {
+        iommufd_cdev_ram_block_discard_disable(false);
+    }
+
+    container = container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
+    iommufd_cdev_detach_container(vbasedev, container);
+    iommufd_cdev_container_destroy(container);
+    vfio_put_address_space(space);
+
+    iommufd_cdev_unbind_and_disconnect(vbasedev);
+    close(vbasedev->fd);
+}
+
+const VFIOIOMMUOps vfio_iommufd_ops = {
+    .dma_map = iommufd_cdev_map,
+    .dma_unmap = iommufd_cdev_unmap,
+    .attach_device = iommufd_cdev_attach,
+    .detach_device = iommufd_cdev_detach,
+};
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index eb6ce6229d..e5d98b6adc 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -7,6 +7,9 @@ vfio_ss.add(files(
   'spapr.c',
   'migration.c',
 ))
+vfio_ss.add(when: 'CONFIG_IOMMUFD', if_true: files(
+  'iommufd.c',
+))
 vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'display.c',
   'pci-quirks.c',
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 08a1f9dfa4..5d3e9e8cee 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -164,3 +164,13 @@ vfio_state_pending_estimate(const char *name, uint64_t precopy, uint64_t postcop
 vfio_state_pending_exact(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" stopcopy size 0x%"PRIx64" precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
 vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
 vfio_vmstate_change_prepare(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
+
+#iommufd.c
+
+iommufd_cdev_connect_and_bind(int iommufd, const char *name, int devfd, int devid) " [iommufd=%d] Successfully bound device %s (fd=%d): output devid=%d"
+iommufd_cdev_getfd(const char *dev, int devfd) " %s (fd=%d)"
+iommufd_cdev_attach_ioas_hwpt(int iommufd, const char *name, int devfd, const char *str, int hwptid) " [iommufd=%d] Successfully attached device %s (%d) to %s_id=%d"
+iommufd_cdev_detach_ioas_hwpt(int iommufd, const char *name, const char *str, int hwptid) " [iommufd=%d] Successfully detached %s from %s_id=%d"
+iommufd_cdev_fail_attach_existing_container(const char *msg) " %s"
+iommufd_cdev_alloc_ioas(int iommufd, int ioas_id) " [iommufd=%d] new IOMMUFD container with ioasid=%d"
+iommufd_cdev_device_info(char *name, int devfd, int num_irqs, int num_regions, int flags) " %s (%d) num_irqs=%d num_regions=%d flags=%d"
-- 
2.34.1


