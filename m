Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2387080A9
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:04:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzcLv-0000xf-48; Thu, 18 May 2023 08:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1pzcLj-0000wl-S8
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:03:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1pzcLh-0007E1-Jl
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684411391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NdA1NTGsaUW0cTZALszDwKeUBQh91EaOQPEnc0tdXN0=;
 b=LX93m3wP8T4evPOks3bxnZcnMjWSD8wfKZysQv/UHaq8zHT/s3lIjeeWipkEVO5lmROsTR
 5A3DIVD6ah871w3wTkWjtnlqyi+My7M9abwrx/yzbXXJMA+BcaNVFYQ3rcjMmq1tGbRROS
 i+eQcWwUBiEyai/veiPsXGkAqX3Ub/8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-oP6pzwEmO8KKZYdx4twVsQ-1; Thu, 18 May 2023 08:03:08 -0400
X-MC-Unique: oP6pzwEmO8KKZYdx4twVsQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42ADA85A588;
 Thu, 18 May 2023 12:03:08 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B13591121315;
 Thu, 18 May 2023 12:03:06 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>,
 kraxel@redhat.com, Fam Zheng <fam@euphon.net>,
 Albert Esteve <aesteve@redhat.com>, cohuck@redhat.com
Subject: [PATCH v2 3/4] vhost-user: add shared_object msg
Date: Thu, 18 May 2023 14:02:57 +0200
Message-Id: <20230518120258.1394135-4-aesteve@redhat.com>
In-Reply-To: <20230518120258.1394135-1-aesteve@redhat.com>
References: <20230518120258.1394135-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Add new vhost-user protocol message
`VHOST_USER_BACKEND_SHARED_OBJECT`. This new
message is sent from vhost-user back-ends
to interact with the virtio-dmabuf table
in order to add, remove, or lookup for
virtio dma-buf shared objects.

The action taken in the front-end depends
on the type stored in the payload struct.

In the libvhost-user library add helper
functions to allow sending messages to
interact with the virtio shared objects
hash table.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 docs/interop/vhost-user.rst               | 15 ++++
 hw/virtio/vhost-user.c                    | 68 ++++++++++++++++++
 subprojects/libvhost-user/libvhost-user.c | 88 +++++++++++++++++++++++
 subprojects/libvhost-user/libvhost-user.h | 56 +++++++++++++++
 4 files changed, 227 insertions(+)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 5a070adbc1..d3d8db41e5 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -1528,6 +1528,21 @@ is sent by the front-end.
 
   The state.num field is currently reserved and must be set to 0.
 
+``VHOST_USER_BACKEND_SHARED_OBJECT``
+  :id: 6
+  :equivalent ioctl: N/A
+  :request payload: ``struct VhostUserShared``
+  :reply payload: ``struct VhostUserShared`` (only for ``LOOKUP`` requests)
+
+  Backends that need to interact with the virtio-dmabuf shared table API
+  can send this message. The operation is determined by the ``type`` member
+  of the payload struct. The valid values for the operation type are
+  ``VHOST_SHARED_OBJECT_*`` members, i.e., ``ADD``, ``LOOKUP``, and ``REMOVE``.
+  ``LOOKUP`` operations require the ``VHOST_USER_NEED_REPLY_MASK`` flag to be
+  set by the back-end, and the front-end will then send the dma-buf fd as
+  a response if the UUID matches an object in the table, or a negative value
+  otherwise.
+
 .. _reply_ack:
 
 VHOST_USER_PROTOCOL_F_REPLY_ACK
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index e5285df4ba..d9bcaafebf 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -10,6 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "hw/virtio/virtio-dmabuf.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-user.h"
 #include "hw/virtio/vhost-backend.h"
@@ -20,6 +21,7 @@
 #include "sysemu/kvm.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "qemu/uuid.h"
 #include "qemu/sockets.h"
 #include "sysemu/runstate.h"
 #include "sysemu/cryptodev.h"
@@ -138,6 +140,7 @@ typedef enum VhostUserSlaveRequest {
     VHOST_USER_BACKEND_IOTLB_MSG = 1,
     VHOST_USER_BACKEND_CONFIG_CHANGE_MSG = 2,
     VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG = 3,
+    VHOST_USER_BACKEND_SHARED_OBJECT = 6,
     VHOST_USER_BACKEND_MAX
 }  VhostUserSlaveRequest;
 
@@ -200,6 +203,18 @@ typedef struct VhostUserInflight {
     uint16_t queue_size;
 } VhostUserInflight;
 
+typedef enum VhostUserSharedType {
+    VHOST_SHARED_OBJECT_ADD = 0,
+    VHOST_SHARED_OBJECT_LOOKUP,
+    VHOST_SHARED_OBJECT_REMOVE,
+} VhostUserSharedType;
+
+typedef struct VhostUserShared {
+    unsigned char uuid[16];
+    VhostUserSharedType type;
+    int dmabuf_fd;
+} VhostUserShared;
+
 typedef struct {
     VhostUserRequest request;
 
@@ -224,6 +239,7 @@ typedef union {
         VhostUserCryptoSession session;
         VhostUserVringArea area;
         VhostUserInflight inflight;
+        VhostUserShared object;
 } VhostUserPayload;
 
 typedef struct VhostUserMsg {
@@ -1591,6 +1607,52 @@ static int vhost_user_slave_handle_vring_host_notifier(struct vhost_dev *dev,
     return 0;
 }
 
+static int vhost_user_backend_handle_shared_object(VhostUserShared *object)
+{
+    QemuUUID uuid;
+    memcpy(uuid.data, object->uuid, sizeof(object->uuid));
+
+    switch (object->type) {
+    case VHOST_SHARED_OBJECT_ADD:
+        return virtio_add_dmabuf(&uuid, object->dmabuf_fd);
+    case VHOST_SHARED_OBJECT_LOOKUP:
+        object->dmabuf_fd = virtio_lookup_dmabuf(&uuid);
+        if (object->dmabuf_fd < 0) {
+            return object->dmabuf_fd;
+        }
+        break;
+    case VHOST_SHARED_OBJECT_REMOVE:
+        return virtio_remove_resource(&uuid);
+    }
+
+    return 0;
+}
+
+static bool
+vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHeader *hdr,
+                                  VhostUserPayload *payload)
+{
+    Error *local_err = NULL;
+    struct iovec iov[2];
+    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
+        hdr->flags &= ~VHOST_USER_NEED_REPLY_MASK;
+        hdr->flags |= VHOST_USER_REPLY_MASK;
+
+        hdr->size = sizeof(payload->object);
+
+        iov[0].iov_base = hdr;
+        iov[0].iov_len = VHOST_USER_HDR_SIZE;
+        iov[1].iov_base = payload;
+        iov[1].iov_len = hdr->size;
+
+        if (qio_channel_writev_all(ioc, iov, ARRAY_SIZE(iov), &local_err)) {
+            error_report_err(local_err);
+            return false;
+        }
+    }
+    return true;
+}
+
 static void close_slave_channel(struct vhost_user *u)
 {
     g_source_destroy(u->slave_src);
@@ -1648,6 +1710,12 @@ static gboolean slave_read(QIOChannel *ioc, GIOCondition condition,
         ret = vhost_user_slave_handle_vring_host_notifier(dev, &payload.area,
                                                           fd ? fd[0] : -1);
         break;
+    case VHOST_USER_BACKEND_SHARED_OBJECT:
+        ret = vhost_user_backend_handle_shared_object(&payload.object);
+        if (!vhost_user_backend_send_dmabuf_fd(ioc, &hdr, &payload)) {
+            goto err;
+        }
+        break;
     default:
         error_report("Received unexpected msg type: %d.", hdr.request);
         ret = -EINVAL;
diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 8fb61e2df2..27f16d292a 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -1403,6 +1403,94 @@ bool vu_set_queue_host_notifier(VuDev *dev, VuVirtq *vq, int fd,
     return vu_process_message_reply(dev, &vmsg);
 }
 
+bool
+vu_get_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN], int *dmabuf_fd)
+{
+    bool result = false;
+    VhostUserMsg msg_reply;
+    VhostUserMsg msg = {
+        .request = VHOST_USER_BACKEND_SHARED_OBJECT,
+        .size = sizeof(msg.payload.object),
+        .flags = VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MASK,
+        .payload.object = {
+            .type = VHOST_SHARED_OBJECT_LOOKUP,
+        },
+    };
+
+    memcpy(msg.payload.object.uuid, uuid, sizeof(uuid[0]) * UUID_LEN);
+
+    pthread_mutex_lock(&dev->slave_mutex);
+    if (!vu_message_write(dev, dev->slave_fd, &msg)) {
+        goto out;
+    }
+
+    if (!vu_message_read_default(dev, dev->slave_fd, &msg_reply)) {
+        goto out;
+    }
+
+    if (msg_reply.request != msg.request) {
+        DPRINT("Received unexpected msg type. Expected %d, received %d",
+               msg.request, msg_reply.request);
+        goto out;
+    }
+
+    *dmabuf_fd = msg_reply.payload.object.dmabuf_fd;
+    result = *dmabuf_fd > 0;
+out:
+    pthread_mutex_unlock(&dev->slave_mutex);
+
+    return result;
+}
+
+static bool
+vu_send_message(VuDev *dev, VhostUserMsg *vmsg)
+{
+    bool result = false;
+    pthread_mutex_lock(&dev->slave_mutex);
+    if (!vu_message_write(dev, dev->slave_fd, vmsg)) {
+        goto out;
+    }
+
+    result = true;
+out:
+    pthread_mutex_unlock(&dev->slave_mutex);
+
+    return result;
+}
+
+bool
+vu_add_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN], int dmabuf_fd)
+{
+    VhostUserMsg msg = {
+        .request = VHOST_USER_BACKEND_SHARED_OBJECT,
+        .size = sizeof(msg.payload.object),
+        .flags = VHOST_USER_VERSION,
+        .payload.object = {
+            .dmabuf_fd = dmabuf_fd,
+            .type = VHOST_SHARED_OBJECT_ADD,
+        },
+    };
+    memcpy(msg.payload.object.uuid, uuid, sizeof(uuid[0]) * UUID_LEN);
+
+    return vu_send_message(dev, &msg);
+}
+
+bool
+vu_rm_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN])
+{
+    VhostUserMsg msg = {
+        .request = VHOST_USER_BACKEND_SHARED_OBJECT,
+        .size = sizeof(msg.payload.object),
+        .flags = VHOST_USER_VERSION,
+        .payload.object = {
+            .type = VHOST_SHARED_OBJECT_REMOVE,
+        },
+    };
+    memcpy(msg.payload.object.uuid, uuid, sizeof(uuid[0]) * UUID_LEN);
+
+    return vu_send_message(dev, &msg);
+}
+
 static bool
 vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
index 49208cceaa..a43d115bd7 100644
--- a/subprojects/libvhost-user/libvhost-user.h
+++ b/subprojects/libvhost-user/libvhost-user.h
@@ -119,6 +119,7 @@ typedef enum VhostUserSlaveRequest {
     VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG = 3,
     VHOST_USER_BACKEND_VRING_CALL = 4,
     VHOST_USER_BACKEND_VRING_ERR = 5,
+    VHOST_USER_BACKEND_SHARED_OBJECT = 6,
     VHOST_USER_BACKEND_MAX
 }  VhostUserSlaveRequest;
 
@@ -172,6 +173,20 @@ typedef struct VhostUserInflight {
     uint16_t queue_size;
 } VhostUserInflight;
 
+typedef enum VhostUserSharedType {
+    VHOST_SHARED_OBJECT_ADD = 0,
+    VHOST_SHARED_OBJECT_LOOKUP,
+    VHOST_SHARED_OBJECT_REMOVE,
+} VhostUserSharedType;
+
+#define UUID_LEN 16
+
+typedef struct VhostUserShared {
+    unsigned char uuid[UUID_LEN];
+    VhostUserSharedType type;
+    int dmabuf_fd;
+} VhostUserShared;
+
 #if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
 # define VU_PACKED __attribute__((gcc_struct, packed))
 #else
@@ -199,6 +214,7 @@ typedef struct VhostUserMsg {
         VhostUserConfig config;
         VhostUserVringArea area;
         VhostUserInflight inflight;
+        VhostUserShared object;
     } payload;
 
     int fds[VHOST_MEMORY_BASELINE_NREGIONS];
@@ -539,6 +555,46 @@ void vu_set_queue_handler(VuDev *dev, VuVirtq *vq,
 bool vu_set_queue_host_notifier(VuDev *dev, VuVirtq *vq, int fd,
                                 int size, int offset);
 
+/**
+ * vu_get_shared_object:
+ * @dev: a VuDev context
+ * @uuid: UUID of the shared object
+ * @dmabuf_fd: output dma-buf file descriptor
+ *
+ * Lookup for a virtio shared object (i.e., dma-buf fd) associated with the
+ * received UUID. Result, if found, is stored in the dmabuf_fd argument.
+ *
+ * Returns: whether the virtio object was found.
+ */
+bool vu_get_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN],
+                          int *dmabuf_fd);
+
+/**
+ * vu_add_shared_object:
+ * @dev: a VuDev context
+ * @uuid: UUID of the shared object
+ * @dmabuf_fd: output dma-buf file descriptor
+ *
+ * Stores a new shared object (i.e., dma-buf fd) in the hash table, and 
+ * associates it with the received UUID.
+ *
+ * Returns: TRUE on success, FALSE on failure.
+ */
+bool vu_add_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN],
+                          int dmabuf_fd);
+
+/**
+ * vu_rm_shared_object:
+ * @dev: a VuDev context
+ * @uuid: UUID of the shared object
+ *
+ * Removes a shared object (i.e., dma-buf fd) associated with the
+ * received UUID from the hash table.
+ *
+ * Returns: TRUE on success, FALSE on failure.
+ */
+bool vu_rm_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN]);
+
 /**
  * vu_queue_set_notification:
  * @dev: a VuDev context
-- 
2.40.0


