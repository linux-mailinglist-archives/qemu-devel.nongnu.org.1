Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B821750043
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 09:41:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJUSq-0006I2-Lw; Wed, 12 Jul 2023 03:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qJUSY-00065E-GX
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:40:26 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qJUST-0006qz-2h
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689147621; x=1720683621;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=e1bK2/5YqIG3HhcMuAu3dWqLstZ/iSzazUm2JNZHXFI=;
 b=Lxo/HnEVy3g+7HdgfzieBvwKEyZQjFayENKxKo1idPbZ4vml2yIMVGJx
 glvnEDB+hdmolqifhpBWlUKPzDtYMPwTKKOUW0B7PbCQzucV7mkiqclyW
 tyumaMkqWa3n57ki9fjNjkqTIzgDJbgEv1mwiwpAhU/ALXdBcySNzEC4w
 mYpI5OQxnUldQul56CKjWtOQGkWK9iVVXYAxM9shEcbZcOPl86bCNH8pj
 64nSZfJLhU2v4lKlkkZAn3oK/nscM3NV1rxW0ITz+SEO4r7+ZgV7PcTFD
 7bnEm19gAdwskjTo6DU4k7/Zu57eNJgcMMX2++xJogiJkQHYYywYkp3lN w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="430953822"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="430953822"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 00:40:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="835024112"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="835024112"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 00:40:00 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, eric.auger@redhat.com, peterx@redhat.com,
 jasonwang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [RFC PATCH v4 18/24] backends/iommufd: Introduce the iommufd object
Date: Wed, 12 Jul 2023 15:25:22 +0800
Message-Id: <20230712072528.275577-19-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712072528.275577-1-zhenzhong.duan@intel.com>
References: <20230712072528.275577-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=zhenzhong.duan@intel.com; helo=mga07.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Introduce an iommufd object which allows the interaction
with the host /dev/iommu device.

The /dev/iommu can have been already pre-opened outside of qemu,
in which case the fd can be passed directly along with the
iommufd object:

This allows the iommufd object to be shared accross several
subsystems (VFIO, VDPA, ...). For example, libvirt would open
the /dev/iommu once.

If no fd is passed along with the iommufd object, the /dev/iommu
is opened by the qemu code.

The CONFIG_IOMMUFD option must be set to compile this new object.

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 MAINTAINERS              |   7 +
 backends/Kconfig         |   4 +
 backends/iommufd.c       | 268 +++++++++++++++++++++++++++++++++++++++
 backends/meson.build     |   3 +
 backends/trace-events    |  12 ++
 include/sysemu/iommufd.h |  47 +++++++
 qapi/qom.json            |  18 ++-
 qemu-options.hx          |  13 ++
 8 files changed, 371 insertions(+), 1 deletion(-)
 create mode 100644 backends/iommufd.c
 create mode 100644 include/sysemu/iommufd.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e158a25cfe..25835caf39 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2079,6 +2079,13 @@ F: hw/vfio/ap.c
 F: docs/system/s390x/vfio-ap.rst
 L: qemu-s390x@nongnu.org
 
+iommufd
+M: Yi Liu <yi.l.liu@intel.com>
+M: Eric Auger <eric.auger@redhat.com>
+S: Supported
+F: backends/iommufd.c
+F: include/sysemu/iommufd.h
+
 vhost
 M: Michael S. Tsirkin <mst@redhat.com>
 S: Supported
diff --git a/backends/Kconfig b/backends/Kconfig
index f35abc1609..2cb23f62fa 100644
--- a/backends/Kconfig
+++ b/backends/Kconfig
@@ -1 +1,5 @@
 source tpm/Kconfig
+
+config IOMMUFD
+    bool
+    depends on VFIO
diff --git a/backends/iommufd.c b/backends/iommufd.c
new file mode 100644
index 0000000000..6d0b9114a1
--- /dev/null
+++ b/backends/iommufd.c
@@ -0,0 +1,268 @@
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
+#include "sysemu/iommufd.h"
+#include "qapi/error.h"
+#include "qapi/qmp/qerror.h"
+#include "qemu/module.h"
+#include "qom/object_interfaces.h"
+#include "qemu/error-report.h"
+#include "monitor/monitor.h"
+#include "trace.h"
+#include <sys/ioctl.h>
+#include <linux/iommufd.h>
+
+static void iommufd_backend_init(Object *obj)
+{
+    IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
+
+    be->fd = -1;
+    be->users = 0;
+    be->owned = true;
+    qemu_mutex_init(&be->lock);
+}
+
+static void iommufd_backend_finalize(Object *obj)
+{
+    IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
+
+    if (be->owned) {
+        close(be->fd);
+        be->fd = -1;
+    }
+}
+
+static void iommufd_backend_set_fd(Object *obj, const char *str, Error **errp)
+{
+    IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
+    int fd = -1;
+
+    fd = monitor_fd_param(monitor_cur(), str, errp);
+    if (fd == -1) {
+        error_prepend(errp, "Could not parse remote object fd %s:", str);
+        return;
+    }
+    qemu_mutex_lock(&be->lock);
+    be->fd = fd;
+    be->owned = false;
+    qemu_mutex_unlock(&be->lock);
+    trace_iommu_backend_set_fd(be->fd);
+}
+
+static void iommufd_backend_class_init(ObjectClass *oc, void *data)
+{
+    object_class_property_add_str(oc, "fd", NULL, iommufd_backend_set_fd);
+}
+
+int iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
+{
+    int fd, ret = 0;
+
+    qemu_mutex_lock(&be->lock);
+    if (be->users == UINT32_MAX) {
+        error_setg(errp, "too many connections");
+        ret = -E2BIG;
+        goto out;
+    }
+    if (be->owned && !be->users) {
+        fd = qemu_open_old("/dev/iommu", O_RDWR);
+        if (fd < 0) {
+            error_setg_errno(errp, errno, "/dev/iommu opening failed");
+            ret = fd;
+            goto out;
+        }
+        be->fd = fd;
+    }
+    be->users++;
+out:
+    trace_iommufd_backend_connect(be->fd, be->owned,
+                                  be->users, ret);
+    qemu_mutex_unlock(&be->lock);
+    return ret;
+}
+
+void iommufd_backend_disconnect(IOMMUFDBackend *be)
+{
+    qemu_mutex_lock(&be->lock);
+    if (!be->users) {
+        goto out;
+    }
+    be->users--;
+    if (!be->users && be->owned) {
+        close(be->fd);
+        be->fd = -1;
+    }
+out:
+    trace_iommufd_backend_disconnect(be->fd, be->users);
+    qemu_mutex_unlock(&be->lock);
+}
+
+static int iommufd_backend_alloc_ioas(int fd, uint32_t *ioas)
+{
+    int ret;
+    struct iommu_ioas_alloc alloc_data  = {
+        .size = sizeof(alloc_data),
+        .flags = 0,
+    };
+
+    ret = ioctl(fd, IOMMU_IOAS_ALLOC, &alloc_data);
+    if (ret) {
+        error_report("Failed to allocate ioas %m");
+    }
+
+    *ioas = alloc_data.out_ioas_id;
+    trace_iommufd_backend_alloc_ioas(fd, *ioas, ret);
+
+    return ret;
+}
+
+static void iommufd_backend_free_ioas(int fd, uint32_t ioas)
+{
+    int ret;
+    struct iommu_destroy des = {
+        .size = sizeof(des),
+        .id = ioas,
+    };
+
+    ret = ioctl(fd, IOMMU_DESTROY, &des);
+    trace_iommufd_backend_free_ioas(fd, ioas, ret);
+    if (ret) {
+        error_report("Failed to free ioas: %u %m", ioas);
+    }
+}
+
+int iommufd_backend_get_ioas(IOMMUFDBackend *be, uint32_t *ioas_id)
+{
+    int ret;
+
+    ret = iommufd_backend_alloc_ioas(be->fd, ioas_id);
+    trace_iommufd_backend_get_ioas(be->fd, *ioas_id, ret);
+    return ret;
+}
+
+void iommufd_backend_put_ioas(IOMMUFDBackend *be, uint32_t ioas)
+{
+    trace_iommufd_backend_put_ioas(be->fd, ioas);
+    iommufd_backend_free_ioas(be->fd, ioas);
+}
+
+int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas,
+                              hwaddr iova, ram_addr_t size)
+{
+    int ret;
+    struct iommu_ioas_unmap unmap = {
+        .size = sizeof(unmap),
+        .ioas_id = ioas,
+        .iova = iova,
+        .length = size,
+    };
+
+    ret = ioctl(be->fd, IOMMU_IOAS_UNMAP, &unmap);
+    trace_iommufd_backend_unmap_dma(be->fd, ioas, iova, size, ret);
+    if (ret && errno == ENOENT) {
+        ret = 0;
+    }
+    if (ret) {
+        error_report("IOMMU_IOAS_UNMAP failed: %s", strerror(errno));
+    }
+    return !ret ? 0 : -errno;
+}
+
+int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas, hwaddr iova,
+                            ram_addr_t size, void *vaddr, bool readonly)
+{
+    int ret;
+    struct iommu_ioas_map map = {
+        .size = sizeof(map),
+        .flags = IOMMU_IOAS_MAP_READABLE |
+                 IOMMU_IOAS_MAP_FIXED_IOVA,
+        .ioas_id = ioas,
+        .__reserved = 0,
+        .user_va = (int64_t)vaddr,
+        .iova = iova,
+        .length = size,
+    };
+
+    if (!readonly) {
+        map.flags |= IOMMU_IOAS_MAP_WRITEABLE;
+    }
+
+    ret = ioctl(be->fd, IOMMU_IOAS_MAP, &map);
+    trace_iommufd_backend_map_dma(be->fd, ioas, iova, size,
+                                  vaddr, readonly, ret);
+    if (ret) {
+        error_report("IOMMU_IOAS_MAP failed: %s", strerror(errno));
+    }
+    return !ret ? 0 : -errno;
+}
+
+int iommufd_backend_copy_dma(IOMMUFDBackend *be, uint32_t src_ioas,
+                             uint32_t dst_ioas, hwaddr iova,
+                             ram_addr_t size, bool readonly)
+{
+    int ret;
+    struct iommu_ioas_copy copy = {
+        .size = sizeof(copy),
+        .flags = IOMMU_IOAS_MAP_READABLE |
+                 IOMMU_IOAS_MAP_FIXED_IOVA,
+        .dst_ioas_id = dst_ioas,
+        .src_ioas_id = src_ioas,
+        .length = size,
+        .dst_iova = iova,
+        .src_iova = iova,
+    };
+
+    if (!readonly) {
+        copy.flags |= IOMMU_IOAS_MAP_WRITEABLE;
+    }
+
+    ret = ioctl(be->fd, IOMMU_IOAS_COPY, &copy);
+    trace_iommufd_backend_copy_dma(be->fd, src_ioas, dst_ioas,
+                                   iova, size, readonly, ret);
+    if (ret) {
+        error_report("IOMMU_IOAS_COPY failed: %s", strerror(errno));
+    }
+    return !ret ? 0 : -errno;
+}
+
+static const TypeInfo iommufd_backend_info = {
+    .name = TYPE_IOMMUFD_BACKEND,
+    .parent = TYPE_OBJECT,
+    .instance_size = sizeof(IOMMUFDBackend),
+    .instance_init = iommufd_backend_init,
+    .instance_finalize = iommufd_backend_finalize,
+    .class_size = sizeof(IOMMUFDBackendClass),
+    .class_init = iommufd_backend_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_USER_CREATABLE },
+        { }
+    }
+};
+
+static void register_types(void)
+{
+    type_register_static(&iommufd_backend_info);
+}
+
+type_init(register_types);
diff --git a/backends/meson.build b/backends/meson.build
index 914c7c4afb..29dc147c8e 100644
--- a/backends/meson.build
+++ b/backends/meson.build
@@ -20,6 +20,9 @@ if have_vhost_user
   system_ss.add(when: 'CONFIG_VIRTIO', if_true: files('vhost-user.c'))
 endif
 system_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('cryptodev-vhost.c'))
+if have_iommufd
+  system_ss.add(files('iommufd.c'))
+endif
 if have_vhost_user_crypto
   system_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('cryptodev-vhost-user.c'))
 endif
diff --git a/backends/trace-events b/backends/trace-events
index 652eb76a57..2c8af3e726 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -5,3 +5,15 @@ dbus_vmstate_pre_save(void)
 dbus_vmstate_post_load(int version_id) "version_id: %d"
 dbus_vmstate_loading(const char *id) "id: %s"
 dbus_vmstate_saving(const char *id) "id: %s"
+
+# iommufd.c
+iommufd_backend_connect(int fd, bool owned, uint32_t users, int ret) "fd=%d owned=%d users=%d (%d)"
+iommufd_backend_disconnect(int fd, uint32_t users) "fd=%d users=%d"
+iommu_backend_set_fd(int fd) "pre-opened /dev/iommu fd=%d"
+iommufd_backend_get_ioas(int iommufd, uint32_t ioas, int ret) " iommufd=%d ioas=%d (%d)"
+iommufd_backend_put_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
+iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
+iommufd_backend_map_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, void *vaddr, bool readonly, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" addr=%p readonly=%d (%d)"
+iommufd_backend_copy_dma(int iommufd, uint32_t src_ioas, uint32_t dst_ioas, uint64_t iova, uint64_t size, bool readonly, int ret) " iommufd=%d src_ioas=%d dst_ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" readonly=%d (%d)"
+iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas, int ret) " iommufd=%d ioas=%d (%d)"
+iommufd_backend_free_ioas(int iommufd, uint32_t ioas, int ret) " iommufd=%d ioas=%d (%d)"
diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
new file mode 100644
index 0000000000..59468f389a
--- /dev/null
+++ b/include/sysemu/iommufd.h
@@ -0,0 +1,47 @@
+#ifndef SYSEMU_IOMMUFD_H
+#define SYSEMU_IOMMUFD_H
+
+#include "qom/object.h"
+#include "qemu/thread.h"
+#include "exec/hwaddr.h"
+#include "exec/cpu-common.h"
+
+#define TYPE_IOMMUFD_BACKEND "iommufd"
+OBJECT_DECLARE_TYPE(IOMMUFDBackend, IOMMUFDBackendClass,
+                    IOMMUFD_BACKEND)
+#define IOMMUFD_BACKEND(obj) \
+    OBJECT_CHECK(IOMMUFDBackend, (obj), TYPE_IOMMUFD_BACKEND)
+#define IOMMUFD_BACKEND_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(IOMMUFDBackendClass, (obj), TYPE_IOMMUFD_BACKEND)
+#define IOMMUFD_BACKEND_CLASS(klass) \
+    OBJECT_CLASS_CHECK(IOMMUFDBackendClass, (klass), TYPE_IOMMUFD_BACKEND)
+struct IOMMUFDBackendClass {
+    ObjectClass parent_class;
+};
+
+struct IOMMUFDBackend {
+    Object parent;
+
+    /*< protected >*/
+    int fd;            /* /dev/iommu file descriptor */
+    bool owned;        /* is the /dev/iommu opened internally */
+    QemuMutex lock;
+    uint32_t users;
+
+    /*< public >*/
+};
+
+int iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
+void iommufd_backend_disconnect(IOMMUFDBackend *be);
+
+int iommufd_backend_get_ioas(IOMMUFDBackend *be, uint32_t *ioas_id);
+void iommufd_backend_put_ioas(IOMMUFDBackend *be, uint32_t ioas_id);
+int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas,
+                              hwaddr iova, ram_addr_t size);
+int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas, hwaddr iova,
+                            ram_addr_t size, void *vaddr, bool readonly);
+int iommufd_backend_copy_dma(IOMMUFDBackend *be, uint32_t src_ioas,
+                             uint32_t dst_ioas, hwaddr iova,
+                             ram_addr_t size, bool readonly);
+
+#endif
diff --git a/qapi/qom.json b/qapi/qom.json
index 7f92ea43e8..78627eb412 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -778,6 +778,18 @@
 { 'struct': 'VfioUserServerProperties',
   'data': { 'socket': 'SocketAddress', 'device': 'str' } }
 
+##
+# @IOMMUFDProperties:
+#
+# Properties for IOMMUFDbackend objects.
+#
+# fd: file descriptor name
+#
+# Since: 7.2
+##
+{ 'struct': 'IOMMUFDProperties',
+        'data': { '*fd': 'str' } }
+
 ##
 # @RngProperties:
 #
@@ -932,6 +944,8 @@
     'qtest',
     'rng-builtin',
     'rng-egd',
+    { 'name': 'iommufd',
+      'if': 'CONFIG_IOMMUFD' },
     { 'name': 'rng-random',
       'if': 'CONFIG_POSIX' },
     'secret',
@@ -1013,7 +1027,9 @@
       'tls-creds-x509':             'TlsCredsX509Properties',
       'tls-cipher-suites':          'TlsCredsProperties',
       'x-remote-object':            'RemoteObjectProperties',
-      'x-vfio-user-server':         'VfioUserServerProperties'
+      'x-vfio-user-server':         'VfioUserServerProperties',
+      'iommufd':                    { 'type': 'IOMMUFDProperties',
+                                      'if': 'CONFIG_IOMMUFD' }
   } }
 
 ##
diff --git a/qemu-options.hx b/qemu-options.hx
index f8f384e551..8f5e18cc4f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5098,6 +5098,19 @@ SRST
 
         The ``share`` boolean option is on by default with memfd.
 
+#ifdef CONFIG_IOMMUFD
+    ``-object iommufd,id=id[,fd=fd]``
+        Creates an iommufd backend which allows control of DMA mapping
+        through the /dev/iommu device.
+
+        The ``id`` parameter is a unique ID which frontends (such as
+        vfio-pci of vdpa) will use to connect withe the iommufd backend.
+
+        The ``fd`` parameter is an optional pre-opened file descriptor
+        resulting from /dev/iommu opening. Usually the iommufd is shared
+        accross all subsystems, bringing the benefit of centralized
+        reference counting.
+#endif
     ``-object rng-builtin,id=id``
         Creates a random number generator backend which obtains entropy
         from QEMU builtin functions. The ``id`` parameter is a unique ID
-- 
2.34.1


