Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30187B25F1B
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Aug 2025 10:39:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umTTi-0007JP-IN; Thu, 14 Aug 2025 04:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1umTTd-0007JC-S3
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 04:38:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1umTTZ-00060o-BE
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 04:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755160699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=trklvPSAEOGArGb9zhpOZiaAnvdUV/AusLF82IqInQQ=;
 b=EPVKrkY+XEuqDU7ZOX0Jih4gav6W6mu5Lj9Usua3GNPrVONdUdY85gH9qtgHyX4XQMyd/s
 UsY9MZQZqRRtq7i77VwQ1Qjdj3PlRHI8JVS4CdAbvC5PP2zUffIPO2Q+ePeiUg3zMA/ipc
 RQwFlPcBVSpEeLJ3QcFlpCZqAk49yxo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-_z1M_DHGOLKaXgfAcEm_UA-1; Thu,
 14 Aug 2025 04:38:15 -0400
X-MC-Unique: _z1M_DHGOLKaXgfAcEm_UA-1
X-Mimecast-MFC-AGG-ID: _z1M_DHGOLKaXgfAcEm_UA_1755160694
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CC011800340; Thu, 14 Aug 2025 08:38:14 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.225.203])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 13946180044F; Thu, 14 Aug 2025 08:38:06 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 hi@alyssa.is, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, slp@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, david@redhat.com, jasowang@redhat.com,
 stefanha@redhat.com, dbassey@redhat.com, stevensd@chromium.org,
 Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v6 1/8] vhost-user: Add VirtIO Shared Memory map request
Date: Thu, 14 Aug 2025 10:37:42 +0200
Message-ID: <20250814083749.1317197-2-aesteve@redhat.com>
In-Reply-To: <20250814083749.1317197-1-aesteve@redhat.com>
References: <20250814083749.1317197-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add SHMEM_MAP/UNMAP requests to vhost-user for
dynamic management of VIRTIO Shared Memory mappings.

This implementation introduces VhostUserShmemObject
as an intermediate QOM parent for MemoryRegions
created for SHMEM_MAP requests. This object
provides reference-counted lifecycle management
with automatic cleanup.

This request allows backends to dynamically map
file descriptors into a VIRTIO Shared Memory
Regions identified by their shmid. Maps are created
using mmap() with configurable read/write permissions,
and the resulting MemoryRegions are added as subregions
to the shmem container region. The mapped memory is
then advertised to the guest VIRTIO drivers as a base
address plus offset for reading and writting according
to the requested mmap flags.

The backend can unmap memory ranges within a given
VIRTIO Shared Memory Region to free resources.
Upon receiving this message, the frontend removes
the MemoryRegion as a subregion and automatically
unreferences the associated VhostUserShmemObject,
triggering cleanup if no other references exist.

Error handling has been improved to ensure consistent
behavior across handlers that manage their own
vhost_user_send_resp() calls. Since these handlers
clear the VHOST_USER_NEED_REPLY_MASK flag, explicit
error checking ensures proper connection closure on
failures, maintaining the expected error flow.

Note the memory region commit for these
operations needs to be delayed until after we
respond to the backend to avoid deadlocks.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 hw/virtio/meson.build                     |   1 +
 hw/virtio/vhost-user-shmem.c              | 166 +++++++++++++++++
 hw/virtio/vhost-user.c                    | 207 +++++++++++++++++++++-
 hw/virtio/virtio.c                        | 111 ++++++++++++
 include/hw/virtio/vhost-user-shmem.h      | 106 +++++++++++
 include/hw/virtio/virtio.h                |  93 ++++++++++
 subprojects/libvhost-user/libvhost-user.c |  70 ++++++++
 subprojects/libvhost-user/libvhost-user.h |  54 ++++++
 8 files changed, 806 insertions(+), 2 deletions(-)
 create mode 100644 hw/virtio/vhost-user-shmem.c
 create mode 100644 include/hw/virtio/vhost-user-shmem.h

diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 3ea7b3cec8..5efcf70b75 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -20,6 +20,7 @@ if have_vhost
     # fixme - this really should be generic
     specific_virtio_ss.add(files('vhost-user.c'))
     system_virtio_ss.add(files('vhost-user-base.c'))
+    system_virtio_ss.add(files('vhost-user-shmem.c'))
 
     # MMIO Stubs
     system_virtio_ss.add(files('vhost-user-device.c'))
diff --git a/hw/virtio/vhost-user-shmem.c b/hw/virtio/vhost-user-shmem.c
new file mode 100644
index 0000000000..ef231f5077
--- /dev/null
+++ b/hw/virtio/vhost-user-shmem.c
@@ -0,0 +1,166 @@
+/*
+ * VHost-user Shared Memory Object
+ *
+ * Copyright Red Hat, Inc. 2024
+ *
+ * Authors:
+ *     Albert Esteve <aesteve@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/virtio/vhost-user-shmem.h"
+#include "system/memory.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "trace.h"
+#include <sys/mman.h>
+
+/**
+ * VhostUserShmemObject
+ *
+ * An intermediate QOM object that manages individual shared memory mappings
+ * created by VHOST_USER_BACKEND_SHMEM_MAP requests. It acts as a parent for
+ * MemoryRegion objects, providing proper lifecycle management with reference
+ * counting. When the object is unreferenced and its reference count drops
+ * to zero, it automatically cleans up the MemoryRegion and unmaps the memory.
+ */
+
+static void vhost_user_shmem_object_finalize(Object *obj);
+static void vhost_user_shmem_object_instance_init(Object *obj);
+
+static const TypeInfo vhost_user_shmem_object_info = {
+    .name = TYPE_VHOST_USER_SHMEM_OBJECT,
+    .parent = TYPE_OBJECT,
+    .instance_size = sizeof(VhostUserShmemObject),
+    .instance_init = vhost_user_shmem_object_instance_init,
+    .instance_finalize = vhost_user_shmem_object_finalize,
+};
+
+static void vhost_user_shmem_object_instance_init(Object *obj)
+{
+    VhostUserShmemObject *shmem_obj = VHOST_USER_SHMEM_OBJECT(obj);
+
+    shmem_obj->shmid = 0;
+    shmem_obj->fd = -1;
+    shmem_obj->fd_offset = 0;
+    shmem_obj->shm_offset = 0;
+    shmem_obj->len = 0;
+    shmem_obj->flags = 0;
+    shmem_obj->mapped_addr = NULL;
+    shmem_obj->mr = NULL;
+}
+
+static void vhost_user_shmem_object_finalize(Object *obj)
+{
+    VhostUserShmemObject *shmem_obj = VHOST_USER_SHMEM_OBJECT(obj);
+
+    /* Clean up MemoryRegion if it exists */
+    if (shmem_obj->mr) {
+        /* Unparent the MemoryRegion to trigger cleanup */
+        object_unparent(OBJECT(shmem_obj->mr));
+        shmem_obj->mr = NULL;
+    }
+
+    /* Clean up memory mapping */
+    if (shmem_obj->mapped_addr && shmem_obj->mapped_addr != MAP_FAILED) {
+        if (munmap(shmem_obj->mapped_addr, shmem_obj->len) < 0) {
+            warn_report("vhost-user-shmem: failed to unmap memory region");
+        }
+        shmem_obj->mapped_addr = NULL;
+    }
+
+    /* Close file descriptor */
+    if (shmem_obj->fd >= 0) {
+        close(shmem_obj->fd);
+        shmem_obj->fd = -1;
+    }
+}
+
+VhostUserShmemObject *vhost_user_shmem_object_new(uint8_t shmid,
+                                                   int fd,
+                                                   uint64_t fd_offset,
+                                                   uint64_t shm_offset,
+                                                   uint64_t len,
+                                                   uint16_t flags)
+{
+    VhostUserShmemObject *shmem_obj;
+    void *mapped_addr;
+    MemoryRegion *mr;
+    g_autoptr(GString) mr_name = g_string_new(NULL);
+    int prot_flags;
+
+    if (fd < 0) {
+        error_report("Invalid file descriptor: %d", fd);
+        return NULL;
+    }
+
+    if (len == 0) {
+        error_report("Shared memory mapping size cannot be zero");
+        return NULL;
+    }
+
+    /* Determine memory protection flags */
+    prot_flags = PROT_READ;
+    if (flags & VHOST_USER_FLAG_MAP_RW) {
+        prot_flags |= PROT_WRITE;
+    }
+
+    /* Map the shared memory region */
+    mapped_addr = mmap(NULL, len, prot_flags, MAP_SHARED, fd, fd_offset);
+    if (mapped_addr == MAP_FAILED) {
+        error_report("Failed to map shared memory region: %s", strerror(errno));
+        return NULL;
+    }
+
+    /* Create the VhostUserShmemObject */
+    shmem_obj = VHOST_USER_SHMEM_OBJECT(
+        object_new(TYPE_VHOST_USER_SHMEM_OBJECT));
+
+    /* Set up object properties */
+    shmem_obj->shmid = shmid;
+    shmem_obj->fd = fd;
+    shmem_obj->fd_offset = fd_offset;
+    shmem_obj->shm_offset = shm_offset;
+    shmem_obj->len = len;
+    shmem_obj->flags = flags;
+    shmem_obj->mapped_addr = mapped_addr;
+
+    /* Create MemoryRegion as a child of this object */
+    mr = g_new0(MemoryRegion, 1);
+    g_string_printf(mr_name, "vhost-user-shmem-%d-%" PRIx64, shmid, shm_offset);
+
+    /* Initialize MemoryRegion with the mapped memory */
+    memory_region_init_ram_device_ptr(mr, OBJECT(shmem_obj), mr_name->str,
+                                      len, mapped_addr);
+
+    shmem_obj->mr = mr;
+    return shmem_obj;
+}
+
+MemoryRegion *vhost_user_shmem_object_get_mr(VhostUserShmemObject *shmem_obj)
+{
+    g_assert(shmem_obj);
+    return shmem_obj->mr;
+}
+
+int vhost_user_shmem_object_get_fd(VhostUserShmemObject *shmem_obj)
+{
+    g_assert(shmem_obj);
+    return shmem_obj->fd;
+}
+
+void *vhost_user_shmem_object_get_mapped_addr(VhostUserShmemObject *shmem_obj)
+{
+    g_assert(shmem_obj);
+    return shmem_obj->mapped_addr;
+}
+
+static void vhost_user_shmem_register_types(void)
+{
+    type_register_static(&vhost_user_shmem_object_info);
+}
+
+type_init(vhost_user_shmem_register_types)
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 1e1d6b0d6e..eb3ad728b0 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/virtio/virtio-dmabuf.h"
+#include "hw/virtio/vhost-user-shmem.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/virtio-crypto.h"
 #include "hw/virtio/vhost-user.h"
@@ -115,6 +116,8 @@ typedef enum VhostUserBackendRequest {
     VHOST_USER_BACKEND_SHARED_OBJECT_ADD = 6,
     VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE = 7,
     VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP = 8,
+    VHOST_USER_BACKEND_SHMEM_MAP = 9,
+    VHOST_USER_BACKEND_SHMEM_UNMAP = 10,
     VHOST_USER_BACKEND_MAX
 }  VhostUserBackendRequest;
 
@@ -192,6 +195,23 @@ typedef struct VhostUserShared {
     unsigned char uuid[16];
 } VhostUserShared;
 
+/* For the flags field of VhostUserMMap */
+#define VHOST_USER_FLAG_MAP_RW (1u << 0)
+
+typedef struct {
+    /* VIRTIO Shared Memory Region ID */
+    uint8_t shmid;
+    uint8_t padding[7];
+    /* File offset */
+    uint64_t fd_offset;
+    /* Offset within the VIRTIO Shared Memory Region */
+    uint64_t shm_offset;
+    /* Size of the mapping */
+    uint64_t len;
+    /* Flags for the mmap operation, from VHOST_USER_FLAG_MAP_* */
+    uint16_t flags;
+} VhostUserMMap;
+
 typedef struct {
     VhostUserRequest request;
 
@@ -224,6 +244,7 @@ typedef union {
         VhostUserInflight inflight;
         VhostUserShared object;
         VhostUserTransferDeviceState transfer_state;
+        VhostUserMMap mmap;
 } VhostUserPayload;
 
 typedef struct VhostUserMsg {
@@ -1768,6 +1789,172 @@ vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
     return 0;
 }
 
+/**
+ * vhost_user_backend_handle_shmem_map() - Handle SHMEM_MAP backend request
+ * @dev: vhost device
+ * @ioc: QIOChannel for communication
+ * @hdr: vhost-user message header
+ * @payload: message payload containing mapping details
+ * @fd: file descriptor for the shared memory region
+ *
+ * Handles VHOST_USER_BACKEND_SHMEM_MAP requests from the backend. Creates
+ * a VhostUserShmemObject to manage the shared memory mapping and adds it
+ * to the appropriate VirtIO shared memory region. The VhostUserShmemObject
+ * serves as an intermediate parent for the MemoryRegion, ensuring proper
+ * lifecycle management with reference counting.
+ *
+ * Returns: 0 on success, negative errno on failure
+ */
+static int
+vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
+                                    QIOChannel *ioc,
+                                    VhostUserHeader *hdr,
+                                    VhostUserPayload *payload,
+                                    int fd)
+{
+    VirtioSharedMemory *shmem;
+    VhostUserMMap *vu_mmap = &payload->mmap;
+    Error *local_err = NULL;
+    g_autoptr(GString) shm_name = g_string_new(NULL);
+
+    if (fd < 0) {
+        error_report("Bad fd for map");
+        return -EBADF;
+    }
+
+    if (QSIMPLEQ_EMPTY(&dev->vdev->shmem_list)) {
+        error_report("Device has no VIRTIO Shared Memory Regions. "
+                     "Requested ID: %d", vu_mmap->shmid);
+        return -EFAULT;
+    }
+
+    shmem = virtio_find_shmem_region(dev->vdev, vu_mmap->shmid);
+    if (!shmem) {
+        error_report("VIRTIO Shared Memory Region at "
+                     "ID %d not found or unitialized", vu_mmap->shmid);
+        return -EFAULT;
+    }
+
+    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
+        (vu_mmap->shm_offset + vu_mmap->len) > shmem->mr.size) {
+        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx64,
+                     vu_mmap->shm_offset, vu_mmap->len);
+        return -EFAULT;
+    }
+
+    g_string_printf(shm_name, "virtio-shm%i-%lu",
+                    vu_mmap->shmid, vu_mmap->shm_offset);
+
+    memory_region_transaction_begin();
+
+    /* Create VhostUserShmemObject as intermediate parent for MemoryRegion */
+    VhostUserShmemObject *shmem_obj = vhost_user_shmem_object_new(
+        vu_mmap->shmid, fd, vu_mmap->fd_offset, vu_mmap->shm_offset,
+        vu_mmap->len, vu_mmap->flags);
+
+    if (!shmem_obj) {
+        memory_region_transaction_commit();
+        return -EFAULT;
+    }
+
+    /* Add the mapping using our VhostUserShmemObject as the parent */
+    if (virtio_add_shmem_map(shmem, shmem_obj) != 0) {
+        error_report("Failed to add shared memory mapping");
+        object_unref(OBJECT(shmem_obj));
+        memory_region_transaction_commit();
+        return -EFAULT;
+    }
+
+    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
+        payload->u64 = 0;
+        hdr->size = sizeof(payload->u64);
+        vhost_user_send_resp(ioc, hdr, payload, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            memory_region_transaction_commit();
+            return -EFAULT;
+        }
+    }
+
+    memory_region_transaction_commit();
+
+    return 0;
+}
+
+/**
+ * vhost_user_backend_handle_shmem_unmap() - Handle SHMEM_UNMAP backend request
+ * @dev: vhost device
+ * @ioc: QIOChannel for communication
+ * @hdr: vhost-user message header
+ * @payload: message payload containing unmapping details
+ *
+ * Handles VHOST_USER_BACKEND_SHMEM_UNMAP requests from the backend. Removes
+ * the specified memory mapping from the VirtIO shared memory region. This
+ * automatically unreferences the associated VhostUserShmemObject, which may
+ * trigger its finalization and cleanup (munmap, close fd) if no other
+ * references exist.
+ *
+ * Returns: 0 on success, negative errno on failure
+ */
+static int
+vhost_user_backend_handle_shmem_unmap(struct vhost_dev *dev,
+                                      QIOChannel *ioc,
+                                      VhostUserHeader *hdr,
+                                      VhostUserPayload *payload)
+{
+    VirtioSharedMemory *shmem;
+    VirtioSharedMemoryMapping *mmap = NULL;
+    VhostUserMMap *vu_mmap = &payload->mmap;
+    Error *local_err = NULL;
+
+    if (QSIMPLEQ_EMPTY(&dev->vdev->shmem_list)) {
+        error_report("Device has no VIRTIO Shared Memory Regions. "
+                     "Requested ID: %d", vu_mmap->shmid);
+        return -EFAULT;
+    }
+
+    shmem = virtio_find_shmem_region(dev->vdev, vu_mmap->shmid);
+    if (!shmem) {
+        error_report("VIRTIO Shared Memory Region at "
+                     "ID %d not found or unitialized", vu_mmap->shmid);
+        return -EFAULT;
+    }
+
+    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
+        (vu_mmap->shm_offset + vu_mmap->len) > shmem->mr.size) {
+        error_report("Bad offset/len for unmmap %" PRIx64 "+%" PRIx64,
+                     vu_mmap->shm_offset, vu_mmap->len);
+        return -EFAULT;
+    }
+
+    mmap = virtio_find_shmem_map(shmem, vu_mmap->shm_offset, vu_mmap->len);
+    if (!mmap) {
+        error_report("Shared memory mapping not found at offset %" PRIx64
+                     " with length %" PRIx64,
+                     vu_mmap->shm_offset, vu_mmap->len);
+        return -EFAULT;
+    }
+
+    memory_region_transaction_begin();
+    memory_region_del_subregion(&shmem->mr, mmap->mem);
+    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
+        payload->u64 = 0;
+        hdr->size = sizeof(payload->u64);
+        vhost_user_send_resp(ioc, hdr, payload, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            memory_region_transaction_commit();
+            return -EFAULT;
+        }
+    }
+    memory_region_transaction_commit();
+
+    /* Free the MemoryRegion only after vhost_commit */
+    virtio_del_shmem_map(shmem, vu_mmap->shm_offset, vu_mmap->len);
+
+    return 0;
+}
+
 static void close_backend_channel(struct vhost_user *u)
 {
     g_source_destroy(u->backend_src);
@@ -1833,8 +2020,24 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
                                                              &payload.object);
         break;
     case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
-        ret = vhost_user_backend_handle_shared_object_lookup(dev->opaque, ioc,
-                                                             &hdr, &payload);
+        /* Handler manages its own response, check error and close connection */
+        if (vhost_user_backend_handle_shared_object_lookup(dev->opaque, ioc,
+                                                           &hdr, &payload) < 0) {
+            goto err;
+        }
+        break;
+    case VHOST_USER_BACKEND_SHMEM_MAP:
+        /* Handler manages its own response, check error and close connection */
+        if (vhost_user_backend_handle_shmem_map(dev, ioc, &hdr, &payload,
+                                                fd ? fd[0] : -1) < 0) {
+            goto err;
+        }
+        break;
+    case VHOST_USER_BACKEND_SHMEM_UNMAP:
+        /* Handler manages its own response, check error and close connection */
+        if (vhost_user_backend_handle_shmem_unmap(dev, ioc, &hdr, &payload) < 0) {
+            goto err;
+        }
         break;
     default:
         error_report("Received unexpected msg type: %d.", hdr.request);
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 9a81ad912e..28cefda255 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-virtio.h"
+#include "hw/virtio/vhost-user-shmem.h"
 #include "trace.h"
 #include "qemu/defer-call.h"
 #include "qemu/error-report.h"
@@ -3045,6 +3046,102 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
     return vmstate_save_state(f, &vmstate_virtio, vdev, NULL);
 }
 
+VirtioSharedMemory *virtio_new_shmem_region(VirtIODevice *vdev, uint8_t shmid)
+{
+    VirtioSharedMemory *elem;
+    g_autofree char *name = NULL;
+
+    elem = g_new0(VirtioSharedMemory, 1);
+    elem->shmid = shmid;
+
+    /* Initialize embedded MemoryRegion as container for shmem mappings */
+    name = g_strdup_printf("virtio-shmem-%d", shmid);
+    memory_region_init(&elem->mr, OBJECT(vdev), name, UINT64_MAX);
+    QTAILQ_INIT(&elem->mmaps);
+    QSIMPLEQ_INSERT_TAIL(&vdev->shmem_list, elem, entry);
+    return QSIMPLEQ_LAST(&vdev->shmem_list, VirtioSharedMemory, entry);
+}
+
+VirtioSharedMemory *virtio_find_shmem_region(VirtIODevice *vdev, uint8_t shmid)
+{
+    VirtioSharedMemory *shmem, *next;
+    QSIMPLEQ_FOREACH_SAFE(shmem, &vdev->shmem_list, entry, next) {
+        if (shmem->shmid == shmid) {
+            return shmem;
+        }
+    }
+    return NULL;
+}
+
+int virtio_add_shmem_map(VirtioSharedMemory *shmem,
+                         VhostUserShmemObject *shmem_obj)
+{
+    VirtioSharedMemoryMapping *mmap;
+    MemoryRegion *mr;
+    if (!shmem_obj) {
+        error_report("VhostUserShmemObject cannot be NULL");
+        return -1;
+    }
+    mr = vhost_user_shmem_object_get_mr(shmem_obj);
+    if (!mr) {
+        error_report("VhostUserShmemObject has no MemoryRegion");
+        return -1;
+    }
+
+    /* Validate boundaries against the VIRTIO shared memory region */
+    if (shmem_obj->shm_offset + shmem_obj->len > shmem->mr.size) {
+        error_report("Memory exceeds the shared memory boundaries");
+        return -1;
+    }
+
+    /* Create the VirtioSharedMemoryMapping wrapper */
+    mmap = g_new0(VirtioSharedMemoryMapping, 1);
+    mmap->mem = mr;
+    mmap->offset = shmem_obj->shm_offset;
+    mmap->shmem_obj = shmem_obj;
+
+    /* Take a reference on the VhostUserShmemObject */
+    object_ref(OBJECT(shmem_obj));
+
+    /* Add as subregion to the VIRTIO shared memory */
+    memory_region_add_subregion(&shmem->mr, mmap->offset, mmap->mem);
+
+    /* Add to the mapped regions list */
+    QTAILQ_INSERT_TAIL(&shmem->mmaps, mmap, link);
+
+    return 0;
+}
+
+VirtioSharedMemoryMapping *virtio_find_shmem_map(VirtioSharedMemory *shmem,
+                                          hwaddr offset, uint64_t size)
+{
+    VirtioSharedMemoryMapping *mmap;
+    QTAILQ_FOREACH(mmap, &shmem->mmaps, link) {
+        if (mmap->offset == offset && mmap->mem->size == size) {
+            return mmap;
+        }
+    }
+    return NULL;
+}
+
+void virtio_del_shmem_map(VirtioSharedMemory *shmem, hwaddr offset,
+                          uint64_t size)
+{
+    VirtioSharedMemoryMapping *mmap = virtio_find_shmem_map(shmem, offset, size);
+    if (mmap == NULL) {
+        return;
+    }
+
+    /*
+     * Unref the VhostUserShmemObject which will trigger automatic cleanup
+     * when the reference count reaches zero.
+     */
+    object_unref(OBJECT(mmap->shmem_obj));
+
+    QTAILQ_REMOVE(&shmem->mmaps, mmap, link);
+    g_free(mmap);
+}
+
 /* A wrapper for use as a VMState .put function */
 static int virtio_device_put(QEMUFile *f, void *opaque, size_t size,
                               const VMStateField *field, JSONWriter *vmdesc)
@@ -3521,6 +3618,7 @@ void virtio_init(VirtIODevice *vdev, uint16_t device_id, size_t config_size)
             NULL, virtio_vmstate_change, vdev);
     vdev->device_endian = virtio_default_endian();
     vdev->use_guest_notifier_mask = true;
+    QSIMPLEQ_INIT(&vdev->shmem_list);
 }
 
 /*
@@ -4032,11 +4130,24 @@ static void virtio_device_free_virtqueues(VirtIODevice *vdev)
 static void virtio_device_instance_finalize(Object *obj)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(obj);
+    VirtioSharedMemory *shmem;
 
     virtio_device_free_virtqueues(vdev);
 
     g_free(vdev->config);
     g_free(vdev->vector_queues);
+    while (!QSIMPLEQ_EMPTY(&vdev->shmem_list)) {
+        shmem = QSIMPLEQ_FIRST(&vdev->shmem_list);
+        while (!QTAILQ_EMPTY(&shmem->mmaps)) {
+            VirtioSharedMemoryMapping *mmap_reg = QTAILQ_FIRST(&shmem->mmaps);
+            virtio_del_shmem_map(shmem, mmap_reg->offset, mmap_reg->mem->size);
+        }
+
+        /* Clean up the embedded MemoryRegion */
+        object_unparent(OBJECT(&shmem->mr));
+        QSIMPLEQ_REMOVE_HEAD(&vdev->shmem_list, entry);
+        g_free(shmem);
+    }
 }
 
 static const Property virtio_properties[] = {
diff --git a/include/hw/virtio/vhost-user-shmem.h b/include/hw/virtio/vhost-user-shmem.h
new file mode 100644
index 0000000000..ffbbea9c54
--- /dev/null
+++ b/include/hw/virtio/vhost-user-shmem.h
@@ -0,0 +1,106 @@
+/*
+ * VHost-user Shared Memory Object
+ *
+ * Copyright Red Hat, Inc. 2024
+ *
+ * Authors:
+ *     Albert Esteve <aesteve@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef VHOST_USER_SHMEM_H
+#define VHOST_USER_SHMEM_H
+
+#include "qemu/osdep.h"
+#include "qom/object.h"
+#include "system/memory.h"
+#include "qapi/error.h"
+
+/* vhost-user memory mapping flags */
+#define VHOST_USER_FLAG_MAP_RW (1u << 0)
+
+#define TYPE_VHOST_USER_SHMEM_OBJECT "vhost-user-shmem"
+OBJECT_DECLARE_SIMPLE_TYPE(VhostUserShmemObject, VHOST_USER_SHMEM_OBJECT)
+
+/**
+ * VhostUserShmemObject:
+ * @parent: Parent object
+ * @shmid: VIRTIO Shared Memory Region ID
+ * @fd: File descriptor for the shared memory region
+ * @fd_offset: Offset within the file descriptor
+ * @shm_offset: Offset within the VIRTIO Shared Memory Region
+ * @len: Size of the mapping
+ * @flags: Mapping flags (read/write permissions)
+ * @mapped_addr: Pointer to the mapped memory region
+ * @mr: MemoryRegion associated with this shared memory mapping
+ *
+ * An intermediate QOM object that manages individual shared memory mappings
+ * created by VHOST_USER_BACKEND_SHMEM_MAP requests. It acts as a parent for
+ * MemoryRegion objects, providing proper lifecycle management with reference
+ * counting. When the object is unreferenced and its reference count drops
+ * to zero, it automatically cleans up the MemoryRegion and unmaps the memory.
+ */
+struct VhostUserShmemObject {
+    Object parent;
+
+    uint8_t shmid;
+    int fd;
+    uint64_t fd_offset;
+    uint64_t shm_offset;
+    uint64_t len;
+    uint16_t flags;
+    void *mapped_addr;
+    MemoryRegion *mr;
+};
+
+/**
+ * vhost_user_shmem_object_new() - Create a new VhostUserShmemObject
+ * @shmid: VIRTIO Shared Memory Region ID
+ * @fd: File descriptor for the shared memory
+ * @fd_offset: Offset within the file descriptor
+ * @shm_offset: Offset within the VIRTIO Shared Memory Region
+ * @len: Size of the mapping
+ * @flags: Mapping flags (VHOST_USER_FLAG_MAP_*)
+ *
+ * Creates a new VhostUserShmemObject that manages a shared memory mapping.
+ * The object will automatically map the memory using mmap() and create
+ * a MemoryRegion as a child object. When the object is finalized, it will
+ * automatically unmap the memory and close the file descriptor.
+ * Errors are reported via error_report().
+ *
+ * Return: A new VhostUserShmemObject on success, NULL on error.
+ */
+VhostUserShmemObject *vhost_user_shmem_object_new(uint8_t shmid,
+                                                   int fd,
+                                                   uint64_t fd_offset,
+                                                   uint64_t shm_offset,
+                                                   uint64_t len,
+                                                   uint16_t flags);
+
+/**
+ * vhost_user_shmem_object_get_mr() - Get the MemoryRegion
+ * @shmem_obj: VhostUserShmemObject instance
+ *
+ * Return: The MemoryRegion associated with this shared memory object.
+ */
+MemoryRegion *vhost_user_shmem_object_get_mr(VhostUserShmemObject *shmem_obj);
+
+/**
+ * vhost_user_shmem_object_get_fd() - Get the file descriptor
+ * @shmem_obj: VhostUserShmemObject instance
+ *
+ * Return: The file descriptor for the shared memory region.
+ */
+int vhost_user_shmem_object_get_fd(VhostUserShmemObject *shmem_obj);
+
+/**
+ * vhost_user_shmem_object_get_mapped_addr() - Get the mapped memory address
+ * @shmem_obj: VhostUserShmemObject instance
+ *
+ * Return: The mapped memory address.
+ */
+void *vhost_user_shmem_object_get_mapped_addr(VhostUserShmemObject *shmem_obj);
+
+#endif /* VHOST_USER_SHMEM_H */
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index c594764f23..a563bbac2c 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -98,6 +98,26 @@ enum virtio_device_endian {
     VIRTIO_DEVICE_ENDIAN_BIG,
 };
 
+struct VhostUserShmemObject;
+
+struct VirtioSharedMemoryMapping {
+    MemoryRegion *mem;
+    hwaddr offset;
+    QTAILQ_ENTRY(VirtioSharedMemoryMapping) link;
+    struct VhostUserShmemObject *shmem_obj; /* Intermediate parent object */
+};
+
+typedef struct VirtioSharedMemoryMapping VirtioSharedMemoryMapping;
+
+struct VirtioSharedMemory {
+    uint8_t shmid;
+    MemoryRegion mr;
+    QTAILQ_HEAD(, VirtioSharedMemoryMapping) mmaps;
+    QSIMPLEQ_ENTRY(VirtioSharedMemory) entry;
+};
+
+typedef struct VirtioSharedMemory VirtioSharedMemory;
+
 /**
  * struct VirtIODevice - common VirtIO structure
  * @name: name of the device
@@ -167,6 +187,8 @@ struct VirtIODevice
      */
     EventNotifier config_notifier;
     bool device_iotlb_enabled;
+    /* Shared memory region for mappings. */
+    QSIMPLEQ_HEAD(, VirtioSharedMemory) shmem_list;
 };
 
 struct VirtioDeviceClass {
@@ -295,6 +317,77 @@ void virtio_notify(VirtIODevice *vdev, VirtQueue *vq);
 
 int virtio_save(VirtIODevice *vdev, QEMUFile *f);
 
+/**
+ * virtio_new_shmem_region() - Create a new shared memory region
+ * @vdev: VirtIODevice
+ * @shmid: Shared memory ID
+ *
+ * Creates a new VirtioSharedMemory region for the given device and ID.
+ * The returned VirtioSharedMemory is owned by the VirtIODevice and will
+ * be automatically freed when the device is destroyed. The caller
+ * should not free the returned pointer.
+ *
+ * Returns: Pointer to the new VirtioSharedMemory region, or NULL on failure
+ */
+VirtioSharedMemory *virtio_new_shmem_region(VirtIODevice *vdev, uint8_t shmid);
+
+/**
+ * virtio_find_shmem_region() - Find an existing shared memory region
+ * @vdev: VirtIODevice
+ * @shmid: Shared memory ID to find
+ *
+ * Finds an existing VirtioSharedMemory region by ID. The returned pointer
+ * is owned by the VirtIODevice and should not be freed by the caller.
+ *
+ * Returns: Pointer to the VirtioSharedMemory region, or NULL if not found
+ */
+VirtioSharedMemory *virtio_find_shmem_region(VirtIODevice *vdev, uint8_t shmid);
+
+/**
+ * virtio_add_shmem_map() - Add a memory mapping to a shared region
+ * @shmem: VirtioSharedMemory region
+ * @shmem_obj: VhostUserShmemObject to add (takes a reference)
+ *
+ * Adds a memory mapping to the shared memory region. The VhostUserShmemObject
+ * is added as a child of the mapping and will be automatically managed through
+ * QOM reference counting. The mapping will be removed when
+ * virtio_del_shmem_map() is called or when the shared memory region is
+ * destroyed.
+ *
+ * Returns: 0 on success, negative errno on failure
+ */
+int virtio_add_shmem_map(VirtioSharedMemory *shmem,
+                         struct VhostUserShmemObject *shmem_obj);
+
+/**
+ * virtio_find_shmem_map() - Find a memory mapping in a shared region
+ * @shmem: VirtioSharedMemory region
+ * @offset: Offset within the shared memory region
+ * @size: Size of the mapping to find
+ *
+ * Finds an existing memory mapping that covers the specified range.
+ * The returned VirtioSharedMemoryMapping is owned by the VirtioSharedMemory
+ * region and should not be freed by the caller.
+ *
+ * Returns: Pointer to the VirtioSharedMemoryMapping, or NULL if not found
+ */
+VirtioSharedMemoryMapping *virtio_find_shmem_map(VirtioSharedMemory *shmem,
+                                          hwaddr offset, uint64_t size);
+
+/**
+ * virtio_del_shmem_map() - Remove a memory mapping from a shared region
+ * @shmem: VirtioSharedMemory region
+ * @offset: Offset of the mapping to remove
+ * @size: Size of the mapping to remove
+ *
+ * Removes a memory mapping from the shared memory region. This will
+ * automatically unref the associated VhostUserShmemObject, which may
+ * trigger its finalization and cleanup if no other references exist.
+ * The mapping's MemoryRegion will be properly unmapped and cleaned up.
+ */
+void virtio_del_shmem_map(VirtioSharedMemory *shmem, hwaddr offset,
+                          uint64_t size);
+
 extern const VMStateInfo virtio_vmstate_info;
 
 #define VMSTATE_VIRTIO_DEVICE \
diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 9c630c2170..034cbfdc3c 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -1592,6 +1592,76 @@ vu_rm_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN])
     return vu_send_message(dev, &msg);
 }
 
+bool
+vu_shmem_map(VuDev *dev, uint8_t shmid, uint64_t fd_offset,
+             uint64_t shm_offset, uint64_t len, uint64_t flags, int fd)
+{
+    VhostUserMsg vmsg = {
+        .request = VHOST_USER_BACKEND_SHMEM_MAP,
+        .size = sizeof(vmsg.payload.mmap),
+        .flags = VHOST_USER_VERSION,
+        .payload.mmap = {
+            .shmid = shmid,
+            .fd_offset = fd_offset,
+            .shm_offset = shm_offset,
+            .len = len,
+            .flags = flags,
+        },
+        .fd_num = 1,
+        .fds[0] = fd,
+    };
+
+    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SHMEM)) {
+        return false;
+    }
+
+    if (vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK)) {
+        vmsg.flags |= VHOST_USER_NEED_REPLY_MASK;
+    }
+
+    pthread_mutex_lock(&dev->backend_mutex);
+    if (!vu_message_write(dev, dev->backend_fd, &vmsg)) {
+        pthread_mutex_unlock(&dev->backend_mutex);
+        return false;
+    }
+
+    /* Also unlocks the backend_mutex */
+    return vu_process_message_reply(dev, &vmsg);
+}
+
+bool
+vu_shmem_unmap(VuDev *dev, uint8_t shmid, uint64_t shm_offset, uint64_t len)
+{
+    VhostUserMsg vmsg = {
+        .request = VHOST_USER_BACKEND_SHMEM_UNMAP,
+        .size = sizeof(vmsg.payload.mmap),
+        .flags = VHOST_USER_VERSION,
+        .payload.mmap = {
+            .shmid = shmid,
+            .fd_offset = 0,
+            .shm_offset = shm_offset,
+            .len = len,
+        },
+    };
+
+    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SHMEM)) {
+        return false;
+    }
+
+    if (vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK)) {
+        vmsg.flags |= VHOST_USER_NEED_REPLY_MASK;
+    }
+
+    pthread_mutex_lock(&dev->backend_mutex);
+    if (!vu_message_write(dev, dev->backend_fd, &vmsg)) {
+        pthread_mutex_unlock(&dev->backend_mutex);
+        return false;
+    }
+
+    /* Also unlocks the backend_mutex */
+    return vu_process_message_reply(dev, &vmsg);
+}
+
 static bool
 vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
index 2ffc58c11b..26b710c92d 100644
--- a/subprojects/libvhost-user/libvhost-user.h
+++ b/subprojects/libvhost-user/libvhost-user.h
@@ -69,6 +69,8 @@ enum VhostUserProtocolFeature {
     /* Feature 16 is reserved for VHOST_USER_PROTOCOL_F_STATUS. */
     /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
     VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 18,
+    /* Feature 19 is reserved for VHOST_USER_PROTOCOL_F_DEVICE_STATE */
+    VHOST_USER_PROTOCOL_F_SHMEM = 20,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
@@ -127,6 +129,8 @@ typedef enum VhostUserBackendRequest {
     VHOST_USER_BACKEND_SHARED_OBJECT_ADD = 6,
     VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE = 7,
     VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP = 8,
+    VHOST_USER_BACKEND_SHMEM_MAP = 9,
+    VHOST_USER_BACKEND_SHMEM_UNMAP = 10,
     VHOST_USER_BACKEND_MAX
 }  VhostUserBackendRequest;
 
@@ -186,6 +190,23 @@ typedef struct VhostUserShared {
     unsigned char uuid[UUID_LEN];
 } VhostUserShared;
 
+/* For the flags field of VhostUserMMap */
+#define VHOST_USER_FLAG_MAP_RW (1u << 0)
+
+typedef struct {
+    /* VIRTIO Shared Memory Region ID */
+    uint8_t shmid;
+    uint8_t padding[7];
+    /* File offset */
+    uint64_t fd_offset;
+    /* Offset within the VIRTIO Shared Memory Region */
+    uint64_t shm_offset;
+    /* Size of the mapping */
+    uint64_t len;
+    /* Flags for the mmap operation, from VHOST_USER_FLAG_MAP_* */
+    uint16_t flags;
+} VhostUserMMap;
+
 #define VU_PACKED __attribute__((packed))
 
 typedef struct VhostUserMsg {
@@ -210,6 +231,7 @@ typedef struct VhostUserMsg {
         VhostUserVringArea area;
         VhostUserInflight inflight;
         VhostUserShared object;
+        VhostUserMMap mmap;
     } payload;
 
     int fds[VHOST_MEMORY_BASELINE_NREGIONS];
@@ -593,6 +615,38 @@ bool vu_add_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN]);
  */
 bool vu_rm_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN]);
 
+/**
+ * vu_shmem_map:
+ * @dev: a VuDev context
+ * @shmid: VIRTIO Shared Memory Region ID
+ * @fd_offset: File offset
+ * @shm_offset: Offset within the VIRTIO Shared Memory Region
+ * @len: Size of the mapping
+ * @flags: Flags for the mmap operation
+ * @fd: A file descriptor
+ *
+ * Advertises a new mapping to be made in a given VIRTIO Shared Memory Region.
+ *
+ * Returns: TRUE on success, FALSE on failure.
+ */
+bool vu_shmem_map(VuDev *dev, uint8_t shmid, uint64_t fd_offset,
+                  uint64_t shm_offset, uint64_t len, uint64_t flags, int fd);
+
+/**
+ * vu_shmem_unmap:
+ * @dev: a VuDev context
+ * @shmid: VIRTIO Shared Memory Region ID
+ * @fd_offset: File offset
+ * @len: Size of the mapping
+ *
+ * The front-end un-mmaps a given range in the VIRTIO Shared Memory Region
+ * with the requested `shmid`.
+ *
+ * Returns: TRUE on success, FALSE on failure.
+ */
+bool vu_shmem_unmap(VuDev *dev, uint8_t shmid, uint64_t shm_offset,
+                    uint64_t len);
+
 /**
  * vu_queue_set_notification:
  * @dev: a VuDev context
-- 
2.49.0


