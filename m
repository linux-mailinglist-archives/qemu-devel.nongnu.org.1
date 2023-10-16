Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6E97CA260
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 10:49:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJHE-0001ET-H3; Mon, 16 Oct 2023 04:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJHD-0001Ar-5j
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:48:39 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJHA-0001HS-0t
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697446116; x=1728982116;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=n/TZIh04D0fdSC5Hs8QnxQS7qUmltDJO7ZF/EIvMlII=;
 b=Q8Ubn5gRMVOAWByLA4vIZj8S368NF1KVcOTWhJivtmEc1yknfL6zQK2e
 l0g02v1Ey2LD3M+bPhiFdZovkziPKU+NSELdUk8sFur8rg4FHc2lS9ZJ2
 gQ2zwtb3EGFy5Vt2pEVQga7jF8ZYPKBKOFh9O/dofoSFq2l1MnwbRKHL+
 6Y6fr3OfLDVBuauZ9sdOmVVj3IBPGpRXgMDs+2otFvFolC6cQTVdQW5CJ
 rokATYnuFtYTUzRZyjupJKfeKugsSrEIZ2UGYY0xFWAMujQpLgDjM8r8o
 HuNOgJPihZVDk9gt3/DQlYaPi302zY1r5o+32dXE0lc5UcaLLcK772TVo g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="365737675"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="365737675"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:48:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="749222993"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="749222993"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:48:28 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 17/27] backends/iommufd: Introduce the iommufd object
Date: Mon, 16 Oct 2023 16:32:13 +0800
Message-Id: <20231016083223.1519410-18-zhenzhong.duan@intel.com>
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
 qapi/qom.json            |  18 ++-
 include/sysemu/iommufd.h |  46 +++++++
 backends/iommufd-stub.c  |  59 +++++++++
 backends/iommufd.c       | 268 +++++++++++++++++++++++++++++++++++++++
 backends/Kconfig         |   4 +
 backends/meson.build     |   5 +
 backends/trace-events    |  12 ++
 qemu-options.hx          |  13 ++
 9 files changed, 431 insertions(+), 1 deletion(-)
 create mode 100644 include/sysemu/iommufd.h
 create mode 100644 backends/iommufd-stub.c
 create mode 100644 backends/iommufd.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9e7dec4a58..a7cdeb7825 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2081,6 +2081,13 @@ F: hw/vfio/ap.c
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
index c53ef978ff..3f964e57f5 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -794,6 +794,18 @@
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
@@ -948,6 +960,8 @@
     'qtest',
     'rng-builtin',
     'rng-egd',
+    { 'name': 'iommufd',
+      'if': 'CONFIG_IOMMUFD' },
     { 'name': 'rng-random',
       'if': 'CONFIG_POSIX' },
     'secret',
@@ -1029,7 +1043,9 @@
       'tls-creds-x509':             'TlsCredsX509Properties',
       'tls-cipher-suites':          'TlsCredsProperties',
       'x-remote-object':            'RemoteObjectProperties',
-      'x-vfio-user-server':         'VfioUserServerProperties'
+      'x-vfio-user-server':         'VfioUserServerProperties',
+      'iommufd':                    { 'type': 'IOMMUFDProperties',
+                                      'if': 'CONFIG_IOMMUFD' }
   } }
 
 ##
diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
new file mode 100644
index 0000000000..f0e5c7eeb8
--- /dev/null
+++ b/include/sysemu/iommufd.h
@@ -0,0 +1,46 @@
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
+void iommufd_backend_free_id(int fd, uint32_t id);
+int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
+                            ram_addr_t size, void *vaddr, bool readonly);
+int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
+                              hwaddr iova, ram_addr_t size);
+int iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id,
+                               uint32_t pt_id, uint32_t *out_hwpt);
+#endif
diff --git a/backends/iommufd-stub.c b/backends/iommufd-stub.c
new file mode 100644
index 0000000000..cfb9a87859
--- /dev/null
+++ b/backends/iommufd-stub.c
@@ -0,0 +1,59 @@
+/*
+ * iommufd container backend stub
+ *
+ * Copyright (C) 2023 Intel Corporation.
+ * Copyright Red Hat, Inc. 2023
+ *
+ * Authors: Yi Liu <yi.l....@intel.com>
+ *          Eric Auger <eric.au...@redhat.com>
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
+#include "qemu/error-report.h"
+
+int iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
+{
+    return 0;
+}
+void iommufd_backend_disconnect(IOMMUFDBackend *be)
+{
+}
+void iommufd_backend_free_id(int fd, uint32_t id)
+{
+}
+int iommufd_backend_get_ioas(IOMMUFDBackend *be, uint32_t *ioas_id)
+{
+    return 0;
+}
+void iommufd_backend_put_ioas(IOMMUFDBackend *be, uint32_t ioas_id)
+{
+}
+int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
+                            ram_addr_t size, void *vaddr, bool readonly)
+{
+    return 0;
+}
+int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
+                              hwaddr iova, ram_addr_t size)
+{
+    return 0;
+}
+int iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id,
+                               uint32_t pt_id, uint32_t *out_hwpt)
+{
+    return 0;
+}
diff --git a/backends/iommufd.c b/backends/iommufd.c
new file mode 100644
index 0000000000..3f0ed37847
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
+static int iommufd_backend_alloc_ioas(int fd, uint32_t *ioas_id)
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
+    *ioas_id = alloc_data.out_ioas_id;
+    trace_iommufd_backend_alloc_ioas(fd, *ioas_id, ret);
+
+    return ret;
+}
+
+void iommufd_backend_free_id(int fd, uint32_t id)
+{
+    int ret;
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
+int iommufd_backend_get_ioas(IOMMUFDBackend *be, uint32_t *ioas_id)
+{
+    int ret;
+
+    ret = iommufd_backend_alloc_ioas(be->fd, ioas_id);
+    trace_iommufd_backend_get_ioas(be->fd, *ioas_id, ret);
+    return ret;
+}
+
+void iommufd_backend_put_ioas(IOMMUFDBackend *be, uint32_t ioas_id)
+{
+    iommufd_backend_free_id(be->fd, ioas_id);
+    trace_iommufd_backend_put_ioas(be->fd, ioas_id);
+}
+
+int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
+                            ram_addr_t size, void *vaddr, bool readonly)
+{
+    int ret;
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
+    ret = ioctl(be->fd, IOMMU_IOAS_MAP, &map);
+    trace_iommufd_backend_map_dma(be->fd, ioas_id, iova, size,
+                                  vaddr, readonly, ret);
+    if (ret) {
+        error_report("IOMMU_IOAS_MAP failed: %m");
+    }
+    return !ret ? 0 : -errno;
+}
+
+int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
+                              hwaddr iova, ram_addr_t size)
+{
+    int ret;
+    struct iommu_ioas_unmap unmap = {
+        .size = sizeof(unmap),
+        .ioas_id = ioas_id,
+        .iova = iova,
+        .length = size,
+    };
+
+    ret = ioctl(be->fd, IOMMU_IOAS_UNMAP, &unmap);
+    trace_iommufd_backend_unmap_dma(be->fd, ioas_id, iova, size, ret);
+    /*
+     * TODO: IOMMUFD doesn't support mapping PCI BARs for now.
+     * It's not a problem if there is no p2p dma, relax it here
+     * and avoid many noisy trigger from vIOMMU side.
+     */
+    if (ret && errno == ENOENT) {
+        ret = 0;
+    }
+    if (ret) {
+        error_report("IOMMU_IOAS_UNMAP failed: %m");
+    }
+    return !ret ? 0 : -errno;
+}
+
+int iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id,
+                               uint32_t pt_id, uint32_t *out_hwpt)
+{
+    int ret;
+    struct iommu_hwpt_alloc alloc_hwpt = {
+        .size = sizeof(struct iommu_hwpt_alloc),
+        .flags = 0,
+        .dev_id = dev_id,
+        .pt_id = pt_id,
+        .__reserved = 0,
+    };
+
+    ret = ioctl(iommufd, IOMMU_HWPT_ALLOC, &alloc_hwpt);
+    trace_iommufd_backend_alloc_hwpt(iommufd, dev_id, pt_id,
+                                     alloc_hwpt.out_hwpt_id, ret);
+
+    if (ret) {
+        error_report("IOMMU_HWPT_ALLOC failed: %m");
+    } else {
+        *out_hwpt = alloc_hwpt.out_hwpt_id;
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
index 914c7c4afb..05ac57ff15 100644
--- a/backends/meson.build
+++ b/backends/meson.build
@@ -20,6 +20,11 @@ if have_vhost_user
   system_ss.add(when: 'CONFIG_VIRTIO', if_true: files('vhost-user.c'))
 endif
 system_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('cryptodev-vhost.c'))
+if have_iommufd
+  system_ss.add(files('iommufd.c'))
+else
+  system_ss.add(files('iommufd-stub.c'))
+endif
 if have_vhost_user_crypto
   system_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('cryptodev-vhost-user.c'))
 endif
diff --git a/backends/trace-events b/backends/trace-events
index 652eb76a57..e5f828bca2 100644
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
+iommufd_backend_map_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, void *vaddr, bool readonly, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" addr=%p readonly=%d (%d)"
+iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
+iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas, int ret) " iommufd=%d ioas=%d (%d)"
+iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
+iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u out_hwpt=%u (%d)"
diff --git a/qemu-options.hx b/qemu-options.hx
index 54a7e94970..0af0d379a6 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5207,6 +5207,19 @@ SRST
 
         The ``share`` boolean option is on by default with memfd.
 
+#ifdef CONFIG_IOMMUFD
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
+#endif
     ``-object rng-builtin,id=id``
         Creates a random number generator backend which obtains entropy
         from QEMU builtin functions. The ``id`` parameter is a unique ID
-- 
2.34.1


