Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B577B5162D
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Sep 2025 13:56:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwJPm-0000hd-LB; Wed, 10 Sep 2025 07:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1uwJPc-0000fJ-AB
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 07:54:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1uwJPR-0001S6-04
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 07:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757505279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jZutaUqpeRJkDrhkGr1Uqda4eHNhRNzYvu03VqrYz5Y=;
 b=ILrl/xU0NlwCQfZsgxloMPVQRlQf6aZMm2pZrI4TuH9Bh8gsebVSWzpdtuhvV9T/p3TNdB
 GAFA5i818Bh85qX5BYDZF+E/EQ6szCasl0hNLFo5mSdr2N93feH/8zRtDWzvUactXAThR0
 MY12PCjMYzI9HwEf4nLkvg85RB7OgXI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-tuP3oy2oN-yasBKsHbj6Gg-1; Wed,
 10 Sep 2025 07:54:36 -0400
X-MC-Unique: tuP3oy2oN-yasBKsHbj6Gg-1
X-Mimecast-MFC-AGG-ID: tuP3oy2oN-yasBKsHbj6Gg_1757505275
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E14119560AB; Wed, 10 Sep 2025 11:54:34 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.15])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D262A1800446; Wed, 10 Sep 2025 11:54:28 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: stevensd@chromium.org, dbassey@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 mst@redhat.com, slp@redhat.com, hi@alyssa.is, stefanha@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Stefano Garzarella <sgarzare@redhat.com>,
 jasowang@redhat.com, david@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v8 1/7] vhost-user: Add VirtIO Shared Memory map request
Date: Wed, 10 Sep 2025 13:54:14 +0200
Message-ID: <20250910115420.1012191-2-aesteve@redhat.com>
In-Reply-To: <20250910115420.1012191-1-aesteve@redhat.com>
References: <20250910115420.1012191-1-aesteve@redhat.com>
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

Add SHMEM_MAP/UNMAP requests to vhost-user for dynamic management of
VIRTIO Shared Memory mappings.

This implementation introduces VirtioSharedMemoryMapping as a unified
QOM object that manages both the mapping metadata and MemoryRegion
lifecycle. This object provides reference-counted lifecycle management
with automatic cleanup of file descriptors and memory regions
through QOM finalization.

This request allows backends to dynamically map file descriptors into a
VIRTIO Shared Memory Region identified by their shmid. Maps are created
using memory_region_init_ram_from_fd() with configurable read/write
permissions, and the resulting MemoryRegions are added as subregions to
the shmem container region. The mapped memory is then advertised to the
guest VIRTIO drivers as a base address plus offset for reading and
writting according to the requested mmap flags.

The backend can unmap memory ranges within a given VIRTIO Shared Memory
Region to free resources. Upon receiving this message, the frontend
removes the MemoryRegion as a subregion and automatically unreferences
the VirtioSharedMemoryMapping object, triggering cleanup if no other
references exist.

Error handling has been improved to ensure consistent behavior across
handlers that manage their own vhost_user_send_resp() calls. Since
these handlers clear the VHOST_USER_NEED_REPLY_MASK flag, explicit
error checking ensures proper connection closure on failures,
maintaining the expected error flow.

Note the memory region commit for these operations needs to be delayed
until after we respond to the backend to avoid deadlocks.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 hw/virtio/vhost-user.c                    | 206 +++++++++++++++++++++-
 hw/virtio/virtio.c                        | 198 +++++++++++++++++++++
 include/hw/virtio/virtio.h                | 136 ++++++++++++++
 subprojects/libvhost-user/libvhost-user.c |  70 ++++++++
 subprojects/libvhost-user/libvhost-user.h |  54 ++++++
 5 files changed, 662 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 1e1d6b0d6e..4783b1904b 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -115,6 +115,8 @@ typedef enum VhostUserBackendRequest {
     VHOST_USER_BACKEND_SHARED_OBJECT_ADD = 6,
     VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE = 7,
     VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP = 8,
+    VHOST_USER_BACKEND_SHMEM_MAP = 9,
+    VHOST_USER_BACKEND_SHMEM_UNMAP = 10,
     VHOST_USER_BACKEND_MAX
 }  VhostUserBackendRequest;
 
@@ -192,6 +194,23 @@ typedef struct VhostUserShared {
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
 
@@ -224,6 +243,7 @@ typedef union {
         VhostUserInflight inflight;
         VhostUserShared object;
         VhostUserTransferDeviceState transfer_state;
+        VhostUserMMap mmap;
 } VhostUserPayload;
 
 typedef struct VhostUserMsg {
@@ -1768,6 +1788,172 @@ vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
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
+    /* Create VirtioSharedMemoryMapping object */
+    VirtioSharedMemoryMapping *mapping = virtio_shared_memory_mapping_new(
+        vu_mmap->shmid, fd, vu_mmap->fd_offset, vu_mmap->shm_offset,
+        vu_mmap->len, vu_mmap->flags & VHOST_USER_FLAG_MAP_RW);
+
+    if (!mapping) {
+        memory_region_transaction_commit();
+        return -EFAULT;
+    }
+
+    /* Add the mapping to the shared memory region */
+    if (virtio_add_shmem_map(shmem, mapping) != 0) {
+        error_report("Failed to add shared memory mapping");
+        object_unref(OBJECT(mapping));
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
+    memory_region_del_subregion(&shmem->mr, mmap->mr);
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
@@ -1833,8 +2019,24 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
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
index 9a81ad912e..ba5ffa58bd 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3045,6 +3045,181 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
     return vmstate_save_state(f, &vmstate_virtio, vdev, NULL);
 }
 
+VirtioSharedMemory *virtio_new_shmem_region(VirtIODevice *vdev, uint8_t shmid, uint64_t size)
+{
+    VirtioSharedMemory *elem;
+    g_autofree char *name = NULL;
+
+    elem = g_new0(VirtioSharedMemory, 1);
+    elem->shmid = shmid;
+
+    /* Initialize embedded MemoryRegion as container for shmem mappings */
+    name = g_strdup_printf("virtio-shmem-%d", shmid);
+    memory_region_init(&elem->mr, OBJECT(vdev), name, size);
+    QTAILQ_INIT(&elem->mmaps);
+    QSIMPLEQ_INSERT_TAIL(&vdev->shmem_list, elem, entry);
+    return elem;
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
+static void virtio_shared_memory_mapping_instance_init(Object *obj)
+{
+    VirtioSharedMemoryMapping *mapping = VIRTIO_SHARED_MEMORY_MAPPING(obj);
+
+    mapping->shmid = 0;
+    mapping->fd = -1;
+    mapping->offset = 0;
+    mapping->len = 0;
+    mapping->mr = NULL;
+}
+
+static void virtio_shared_memory_mapping_finalize(Object *obj)
+{
+    VirtioSharedMemoryMapping *mapping = VIRTIO_SHARED_MEMORY_MAPPING(obj);
+
+    /* Clean up MemoryRegion if it exists */
+    if (mapping->mr) {
+        /* Unparent the MemoryRegion to trigger cleanup */
+        object_unparent(OBJECT(mapping->mr));
+        mapping->mr = NULL;
+    }
+
+    /* Close file descriptor */
+    if (mapping->fd >= 0) {
+        close(mapping->fd);
+        mapping->fd = -1;
+    }
+}
+
+VirtioSharedMemoryMapping *virtio_shared_memory_mapping_new(uint8_t shmid,
+                                                            int fd,
+                                                            uint64_t fd_offset,
+                                                            uint64_t shm_offset,
+                                                            uint64_t len,
+                                                            bool allow_write)
+{
+    VirtioSharedMemoryMapping *mapping;
+    MemoryRegion *mr;
+    g_autoptr(GString) mr_name = g_string_new(NULL);
+    uint32_t ram_flags;
+    Error *local_err = NULL;
+
+    if (len == 0) {
+        error_report("Shared memory mapping size cannot be zero");
+        return NULL;
+    }
+
+    fd = dup(fd);
+    if (fd < 0) {
+        error_report("Failed to duplicate fd: %s", strerror(errno));
+        return NULL;
+    }
+
+    /* Determine RAM flags */
+    ram_flags = RAM_SHARED;
+    if (!allow_write) {
+        ram_flags |= RAM_READONLY_FD;
+    }
+
+    /* Create the VirtioSharedMemoryMapping */
+    mapping = VIRTIO_SHARED_MEMORY_MAPPING(
+        object_new(TYPE_VIRTIO_SHARED_MEMORY_MAPPING));
+
+    /* Set up object properties */
+    mapping->shmid = shmid;
+    mapping->fd = fd;
+    mapping->offset = shm_offset;
+    mapping->len = len;
+
+    /* Create MemoryRegion as a child of this object */
+    mr = g_new0(MemoryRegion, 1);
+    g_string_printf(mr_name, "virtio-shmem-%d-%" PRIx64, shmid, shm_offset);
+
+    /* Initialize MemoryRegion with file descriptor */
+    if (!memory_region_init_ram_from_fd(mr, OBJECT(mapping), mr_name->str,
+                                        len, ram_flags, fd, fd_offset,
+                                        &local_err)) {
+        error_report_err(local_err);
+        g_free(mr);
+        close(fd);
+        object_unref(OBJECT(mapping));
+        return NULL;
+    }
+
+    mapping->mr = mr;
+    return mapping;
+}
+
+int virtio_add_shmem_map(VirtioSharedMemory *shmem,
+                         VirtioSharedMemoryMapping *mapping)
+{
+    if (!mapping) {
+        error_report("VirtioSharedMemoryMapping cannot be NULL");
+        return -1;
+    }
+    if (!mapping->mr) {
+        error_report("VirtioSharedMemoryMapping has no MemoryRegion");
+        return -1;
+    }
+
+    /* Validate boundaries against the VIRTIO shared memory region */
+    if (mapping->offset + mapping->len > shmem->mr.size) {
+        error_report("Memory exceeds the shared memory boundaries");
+        return -1;
+    }
+
+    /* Add as subregion to the VIRTIO shared memory */
+    memory_region_add_subregion(&shmem->mr, mapping->offset, mapping->mr);
+
+    /* Add to the mapped regions list */
+    QTAILQ_INSERT_TAIL(&shmem->mmaps, mapping, link);
+
+    return 0;
+}
+
+VirtioSharedMemoryMapping *virtio_find_shmem_map(VirtioSharedMemory *shmem,
+                                          hwaddr offset, uint64_t size)
+{
+    VirtioSharedMemoryMapping *mapping;
+    QTAILQ_FOREACH(mapping, &shmem->mmaps, link) {
+        if (mapping->offset == offset && mapping->mr->size == size) {
+            return mapping;
+        }
+    }
+    return NULL;
+}
+
+void virtio_del_shmem_map(VirtioSharedMemory *shmem, hwaddr offset,
+                          uint64_t size)
+{
+    VirtioSharedMemoryMapping *mapping = virtio_find_shmem_map(shmem, offset, size);
+    if (mapping == NULL) {
+        return;
+    }
+
+    /*
+     * Remove from memory region first
+     */
+    memory_region_del_subregion(&shmem->mr, mapping->mr);
+
+    /*
+     * Remove from list and unref the mapping which will trigger automatic cleanup
+     * when the reference count reaches zero.
+     */
+    QTAILQ_REMOVE(&shmem->mmaps, mapping, link);
+    object_unref(OBJECT(mapping));
+}
+
 /* A wrapper for use as a VMState .put function */
 static int virtio_device_put(QEMUFile *f, void *opaque, size_t size,
                               const VMStateField *field, JSONWriter *vmdesc)
@@ -3521,6 +3696,7 @@ void virtio_init(VirtIODevice *vdev, uint16_t device_id, size_t config_size)
             NULL, virtio_vmstate_change, vdev);
     vdev->device_endian = virtio_default_endian();
     vdev->use_guest_notifier_mask = true;
+    QSIMPLEQ_INIT(&vdev->shmem_list);
 }
 
 /*
@@ -4032,11 +4208,24 @@ static void virtio_device_free_virtqueues(VirtIODevice *vdev)
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
+            VirtioSharedMemoryMapping *mapping = QTAILQ_FIRST(&shmem->mmaps);
+            virtio_del_shmem_map(shmem, mapping->offset, mapping->mr->size);
+        }
+
+        /* Clean up the embedded MemoryRegion */
+        object_unparent(OBJECT(&shmem->mr));
+        QSIMPLEQ_REMOVE_HEAD(&vdev->shmem_list, entry);
+        g_free(shmem);
+    }
 }
 
 static const Property virtio_properties[] = {
@@ -4402,9 +4591,18 @@ static const TypeInfo virtio_device_info = {
     .class_size = sizeof(VirtioDeviceClass),
 };
 
+static const TypeInfo virtio_shared_memory_mapping_info = {
+    .name = TYPE_VIRTIO_SHARED_MEMORY_MAPPING,
+    .parent = TYPE_OBJECT,
+    .instance_size = sizeof(VirtioSharedMemoryMapping),
+    .instance_init = virtio_shared_memory_mapping_instance_init,
+    .instance_finalize = virtio_shared_memory_mapping_finalize,
+};
+
 static void virtio_register_types(void)
 {
     type_register_static(&virtio_device_info);
+    type_register_static(&virtio_shared_memory_mapping_info);
 }
 
 type_init(virtio_register_types)
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index c594764f23..8cecb221cb 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -98,6 +98,46 @@ enum virtio_device_endian {
     VIRTIO_DEVICE_ENDIAN_BIG,
 };
 
+#define TYPE_VIRTIO_SHARED_MEMORY_MAPPING "virtio-shared-memory-mapping"
+OBJECT_DECLARE_SIMPLE_TYPE(VirtioSharedMemoryMapping, VIRTIO_SHARED_MEMORY_MAPPING)
+
+/**
+ * VirtioSharedMemoryMapping:
+ * @parent: Parent QOM object
+ * @shmid: VIRTIO Shared Memory Region ID  
+ * @fd: File descriptor for the shared memory region
+ * @offset: Offset within the VIRTIO Shared Memory Region
+ * @len: Size of the mapping
+ * @mr: MemoryRegion associated with this shared memory mapping
+ * @link: List entry for the shared memory region's mapping list
+ *
+ * A QOM object that represents an individual file descriptor-based shared
+ * memory mapping within a VIRTIO Shared Memory Region. It manages the
+ * MemoryRegion lifecycle and file descriptor cleanup through QOM reference
+ * counting. When the object is unreferenced and its reference count drops
+ * to zero, it automatically cleans up the MemoryRegion and closes the file
+ * descriptor.
+ */
+struct VirtioSharedMemoryMapping {
+    Object parent;
+    
+    uint8_t shmid;
+    int fd;
+    hwaddr offset;
+    uint64_t len;
+    MemoryRegion *mr;
+    QTAILQ_ENTRY(VirtioSharedMemoryMapping) link;
+};
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
@@ -167,6 +207,8 @@ struct VirtIODevice
      */
     EventNotifier config_notifier;
     bool device_iotlb_enabled;
+    /* Shared memory region for mappings. */
+    QSIMPLEQ_HEAD(, VirtioSharedMemory) shmem_list;
 };
 
 struct VirtioDeviceClass {
@@ -295,6 +337,100 @@ void virtio_notify(VirtIODevice *vdev, VirtQueue *vq);
 
 int virtio_save(VirtIODevice *vdev, QEMUFile *f);
 
+/**
+ * virtio_new_shmem_region() - Create a new shared memory region
+ * @vdev: VirtIODevice
+ * @shmid: Shared memory ID
+ * @size: Size of the shared memory region
+ *
+ * Creates a new VirtioSharedMemory region for the given device and ID.
+ * The returned VirtioSharedMemory is owned by the VirtIODevice and will
+ * be automatically freed when the device is destroyed. The caller
+ * should not free the returned pointer.
+ *
+ * Returns: Pointer to the new VirtioSharedMemory region, or NULL on failure
+ */
+VirtioSharedMemory *virtio_new_shmem_region(VirtIODevice *vdev, uint8_t shmid, uint64_t size);
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
+ * virtio_shared_memory_mapping_new() - Create a new VirtioSharedMemoryMapping
+ * @shmid: VIRTIO Shared Memory Region ID
+ * @fd: File descriptor for the shared memory
+ * @fd_offset: Offset within the file descriptor
+ * @shm_offset: Offset within the VIRTIO Shared Memory Region
+ * @len: Size of the mapping
+ * @allow_write: Whether to allow write access to the mapping
+ *
+ * Creates a new VirtioSharedMemoryMapping that manages a shared memory mapping.
+ * The object will create a MemoryRegion using memory_region_init_ram_from_fd()
+ * as a child object. When the object is finalized, it will automatically
+ * clean up the MemoryRegion and close the file descriptor.
+ *
+ * Return: A new VirtioSharedMemoryMapping on success, NULL on error.
+ */
+VirtioSharedMemoryMapping *virtio_shared_memory_mapping_new(uint8_t shmid,
+                                                            int fd,
+                                                            uint64_t fd_offset,
+                                                            uint64_t shm_offset,
+                                                            uint64_t len,
+                                                            bool allow_write);
+
+/**
+ * virtio_add_shmem_map() - Add a memory mapping to a shared region
+ * @shmem: VirtioSharedMemory region
+ * @mapping: VirtioSharedMemoryMapping to add (transfers ownership)
+ *
+ * Adds a memory mapping to the shared memory region. The VirtioSharedMemoryMapping
+ * ownership is transferred to the shared memory region and will be automatically
+ * cleaned up through QOM reference counting when virtio_del_shmem_map() is
+ * called or when the shared memory region is destroyed.
+ *
+ * Returns: 0 on success, negative errno on failure
+ */
+int virtio_add_shmem_map(VirtioSharedMemory *shmem,
+                         VirtioSharedMemoryMapping *mapping);
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


