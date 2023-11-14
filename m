Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D757EADF3
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 11:26:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2qcD-0002sW-1b; Tue, 14 Nov 2023 05:25:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r2qbv-0002rz-I7
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 05:25:35 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r2qbr-0007aG-Tt
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 05:25:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699957531; x=1731493531;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=beaeu8IqmX/V0s1PBASYA1xe7/Nv1dxUUJPGBO8qNNQ=;
 b=Q39HfA4lZZX19LsN2tV9ot71Mc6B5jIy/P2ZRj34U89owpOWPMtfOm9n
 ifn5t+4Lgu+liJZKLozqMbfH0ve7M3l0euRs4ylH0jZlzfWppDtAqjo5r
 y28zFyL7tU8mN7VbuIBzKdUI7eXs2lFBSXPef+3eLa+DX7AsCXGWiJnDW
 GOnMJMqVuZy51TKhxHSkYU11wzew/w1KVGZCYoIUEFZwK5qplSW3l3DqG
 25m6w1TwZRM7o7VFYRrLomqxSofqw1QSkm3/kNAoeHEI84xdhrEiYrEfU
 LU3kAydFpulWJW9ENlIBh3Au9NG5fQGPZZ9mjicQ8+Qcz9ZWtQoRU7ZY2 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="394543397"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; d="scan'208";a="394543397"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 02:25:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="888212788"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; d="scan'208";a="888212788"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 02:25:22 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v6 01/21] backends/iommufd: Introduce the iommufd object
Date: Tue, 14 Nov 2023 18:09:35 +0800
Message-Id: <20231114100955.1961974-2-zhenzhong.duan@intel.com>
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

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
v6: remove redundant call, alloc_hwpt, get/put_ioas

 MAINTAINERS              |   7 ++
 qapi/qom.json            |  19 ++++
 include/sysemu/iommufd.h |  44 ++++++++
 backends/iommufd.c       | 228 +++++++++++++++++++++++++++++++++++++++
 backends/Kconfig         |   4 +
 backends/meson.build     |   1 +
 backends/trace-events    |  10 ++
 qemu-options.hx          |  12 +++
 8 files changed, 325 insertions(+)
 create mode 100644 include/sysemu/iommufd.h
 create mode 100644 backends/iommufd.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ff1238bb98..a4891f7bda 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2166,6 +2166,13 @@ F: hw/vfio/ap.c
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
diff --git a/qapi/qom.json b/qapi/qom.json
index c53ef978ff..1fd8555a75 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -794,6 +794,23 @@
 { 'struct': 'VfioUserServerProperties',
   'data': { 'socket': 'SocketAddress', 'device': 'str' } }
 
+##
+# @IOMMUFDProperties:
+#
+# Properties for iommufd objects.
+#
+# @fd: file descriptor name previously passed via 'getfd' command,
+#     which represents a pre-opened /dev/iommu.  This allows the
+#     iommufd object to be shared accross several subsystems
+#     (VFIO, VDPA, ...), and the file descriptor to be shared
+#     with other process, e.g. DPDK.  (default: QEMU opens
+#     /dev/iommu by itself)
+#
+# Since: 8.2
+##
+{ 'struct': 'IOMMUFDProperties',
+  'data': { '*fd': 'str' } }
+
 ##
 # @RngProperties:
 #
@@ -934,6 +951,7 @@
     'input-barrier',
     { 'name': 'input-linux',
       'if': 'CONFIG_LINUX' },
+    'iommufd',
     'iothread',
     'main-loop',
     { 'name': 'memory-backend-epc',
@@ -1003,6 +1021,7 @@
       'input-barrier':              'InputBarrierProperties',
       'input-linux':                { 'type': 'InputLinuxProperties',
                                       'if': 'CONFIG_LINUX' },
+      'iommufd':                    'IOMMUFDProperties',
       'iothread':                   'IothreadProperties',
       'main-loop':                  'MainLoopProperties',
       'memory-backend-epc':         { 'type': 'MemoryBackendEpcProperties',
diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
new file mode 100644
index 0000000000..9b3a86f57d
--- /dev/null
+++ b/include/sysemu/iommufd.h
@@ -0,0 +1,44 @@
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
+int iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
+                               Error **errp);
+void iommufd_backend_free_id(IOMMUFDBackend *be, uint32_t id);
+int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
+                            ram_addr_t size, void *vaddr, bool readonly);
+int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
+                              hwaddr iova, ram_addr_t size);
+#endif
diff --git a/backends/iommufd.c b/backends/iommufd.c
new file mode 100644
index 0000000000..ea3e2a8f85
--- /dev/null
+++ b/backends/iommufd.c
@@ -0,0 +1,228 @@
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
+int iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
+                               Error **errp)
+{
+    int ret, fd = be->fd;
+    struct iommu_ioas_alloc alloc_data  = {
+        .size = sizeof(alloc_data),
+        .flags = 0,
+    };
+
+    ret = ioctl(fd, IOMMU_IOAS_ALLOC, &alloc_data);
+    if (ret) {
+        error_setg_errno(errp, errno, "Failed to allocate ioas");
+        return ret;
+    }
+
+    *ioas_id = alloc_data.out_ioas_id;
+    trace_iommufd_backend_alloc_ioas(fd, *ioas_id, ret);
+
+    return ret;
+}
+
+void iommufd_backend_free_id(IOMMUFDBackend *be, uint32_t id)
+{
+    int ret, fd = be->fd;
+    struct iommu_destroy des = {
+        .size = sizeof(des),
+        .id = id,
+    };
+
+    ret = ioctl(fd, IOMMU_DESTROY, &des);
+    trace_iommufd_backend_free_id(fd, id, ret);
+    if (ret) {
+        error_report("Failed to free id: %u %m", id);
+    }
+}
+
+int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
+                            ram_addr_t size, void *vaddr, bool readonly)
+{
+    int ret, fd = be->fd;
+    struct iommu_ioas_map map = {
+        .size = sizeof(map),
+        .flags = IOMMU_IOAS_MAP_READABLE |
+                 IOMMU_IOAS_MAP_FIXED_IOVA,
+        .ioas_id = ioas_id,
+        .__reserved = 0,
+        .user_va = (uintptr_t)vaddr,
+        .iova = iova,
+        .length = size,
+    };
+
+    if (!readonly) {
+        map.flags |= IOMMU_IOAS_MAP_WRITEABLE;
+    }
+
+    ret = ioctl(fd, IOMMU_IOAS_MAP, &map);
+    trace_iommufd_backend_map_dma(fd, ioas_id, iova, size,
+                                  vaddr, readonly, ret);
+    if (ret) {
+        ret = -errno;
+        error_report("IOMMU_IOAS_MAP failed: %m");
+    }
+    return ret;
+}
+
+int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
+                              hwaddr iova, ram_addr_t size)
+{
+    int ret, fd = be->fd;
+    struct iommu_ioas_unmap unmap = {
+        .size = sizeof(unmap),
+        .ioas_id = ioas_id,
+        .iova = iova,
+        .length = size,
+    };
+
+    ret = ioctl(fd, IOMMU_IOAS_UNMAP, &unmap);
+    /*
+     * IOMMUFD takes mapping as some kind of object, unmapping
+     * nonexistent mapping is treated as deleting a nonexistent
+     * object and return ENOENT. This is different from legacy
+     * backend which allows it. vIOMMU may trigger a lot of
+     * redundant unmapping, to avoid flush the log, treat them
+     * as succeess for IOMMUFD just like legacy backend.
+     */
+    if (ret && errno == ENOENT) {
+        trace_iommufd_backend_unmap_dma_non_exist(fd, ioas_id, iova, size, ret);
+        ret = 0;
+    } else {
+        trace_iommufd_backend_unmap_dma(fd, ioas_id, iova, size, ret);
+    }
+
+    if (ret) {
+        ret = -errno;
+        error_report("IOMMU_IOAS_UNMAP failed: %m");
+    }
+    return ret;
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
diff --git a/backends/meson.build b/backends/meson.build
index 914c7c4afb..9a5cea480d 100644
--- a/backends/meson.build
+++ b/backends/meson.build
@@ -20,6 +20,7 @@ if have_vhost_user
   system_ss.add(when: 'CONFIG_VIRTIO', if_true: files('vhost-user.c'))
 endif
 system_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('cryptodev-vhost.c'))
+system_ss.add(when: 'CONFIG_IOMMUFD', if_true: files('iommufd.c'))
 if have_vhost_user_crypto
   system_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('cryptodev-vhost-user.c'))
 endif
diff --git a/backends/trace-events b/backends/trace-events
index 652eb76a57..d45c6e31a6 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -5,3 +5,13 @@ dbus_vmstate_pre_save(void)
 dbus_vmstate_post_load(int version_id) "version_id: %d"
 dbus_vmstate_loading(const char *id) "id: %s"
 dbus_vmstate_saving(const char *id) "id: %s"
+
+# iommufd.c
+iommufd_backend_connect(int fd, bool owned, uint32_t users, int ret) "fd=%d owned=%d users=%d (%d)"
+iommufd_backend_disconnect(int fd, uint32_t users) "fd=%d users=%d"
+iommu_backend_set_fd(int fd) "pre-opened /dev/iommu fd=%d"
+iommufd_backend_map_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, void *vaddr, bool readonly, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" addr=%p readonly=%d (%d)"
+iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " Unmap nonexistent mapping: iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
+iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
+iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas, int ret) " iommufd=%d ioas=%d (%d)"
+iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
diff --git a/qemu-options.hx b/qemu-options.hx
index 42fd09e4de..70507c0ee6 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5224,6 +5224,18 @@ SRST
 
         The ``share`` boolean option is on by default with memfd.
 
+    ``-object iommufd,id=id[,fd=fd]``
+        Creates an iommufd backend which allows control of DMA mapping
+        through the /dev/iommu device.
+
+        The ``id`` parameter is a unique ID which frontends (such as
+        vfio-pci of vdpa) will use to connect with the iommufd backend.
+
+        The ``fd`` parameter is an optional pre-opened file descriptor
+        resulting from /dev/iommu opening. Usually the iommufd is shared
+        across all subsystems, bringing the benefit of centralized
+        reference counting.
+
     ``-object rng-builtin,id=id``
         Creates a random number generator backend which obtains entropy
         from QEMU builtin functions. The ``id`` parameter is a unique ID
-- 
2.34.1


