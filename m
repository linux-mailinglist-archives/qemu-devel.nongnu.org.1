Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB017793AE6
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 13:17:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdqVz-0001Q3-Ry; Wed, 06 Sep 2023 07:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qdqVx-0001JE-P6
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 07:16:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qdqVu-0005NU-FW
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 07:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693998961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MZWtKSaKlWph+o4qp6F+fq8jeMJDLgA9kydzEEM6bdU=;
 b=QVuXz1G7341utM7lxpFLdDRm3ux6V5C2ZoyY4buwkME3Mw3xsj+Qrs3x7aUOoS00TmeEvk
 9exyiR9+BJmkDftP43mI9qRoxlRlt2JEgWYk4kEZYU/plsp2TkQJKwCwcZh3L5K8DDfgqp
 yklqH1sCpPwOe1kwBMRGlUJx4rwysWg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-oCo70UjTO9287olcXlfEJQ-1; Wed, 06 Sep 2023 07:15:58 -0400
X-MC-Unique: oCo70UjTO9287olcXlfEJQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08F978115B5;
 Wed,  6 Sep 2023 11:15:58 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 50D2F20BAE38;
 Wed,  6 Sep 2023 11:15:56 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 Albert Esteve <aesteve@redhat.com>, kraxel@redhat.com,
 marcandre.lureau@gmail.com
Subject: [PATCH v6 3/3] vhost-user: add shared_object msg
Date: Wed,  6 Sep 2023 13:15:49 +0200
Message-ID: <20230906111549.357178-4-aesteve@redhat.com>
In-Reply-To: <20230906111549.357178-1-aesteve@redhat.com>
References: <20230906111549.357178-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add three new vhost-user protocol
`VHOST_USER_BACKEND_SHARED_OBJECT_* messages`.
These new messages are sent from vhost-user
back-ends to interact with the virtio-dmabuf
table in order to add or remove themselves as
virtio exporters, or lookup for virtio dma-buf
shared objects.

The action taken in the front-end depends
on the type stored in the virtio shared
object hash table.

When the table holds a pointer to a vhost
backend for a given UUID, the front-end sends
a VHOST_USER_GET_SHARED_OBJECT to the
backend holding the shared object.

In the libvhost-user library we need to add
helper functions to allow sending messages to
interact with the virtio shared objects
hash table.

The messages can only be sent after successfully
negotiating a new VHOST_USER_PROTOCOL_F_SHARED_OBJECT
vhost-user protocol feature bit.

Finally, refactor code to send response message so
that all common parts both for the common REPLY_ACK
case, and other data responses, can call it and
avoid code repetition.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 docs/interop/vhost-user.rst               |  57 +++++++
 hw/virtio/vhost-user.c                    | 174 ++++++++++++++++++++--
 include/hw/virtio/vhost-backend.h         |   3 +
 subprojects/libvhost-user/libvhost-user.c | 118 +++++++++++++++
 subprojects/libvhost-user/libvhost-user.h |  55 ++++++-
 5 files changed, 393 insertions(+), 14 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 5a070adbc1..415bb47a19 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -1440,6 +1440,18 @@ Front-end message types
   query the back-end for its device status as defined in the Virtio
   specification.
 
+``VHOST_USER_GET_SHARED_OBJECT``
+  :id: 41
+  :equivalent ioctl: N/A
+  :request payload: ``struct VhostUserShared``
+  :reply payload: dmabuf fd
+
+  When the ``VHOST_USER_PROTOCOL_F_SHARED_OBJECT`` protocol
+  feature has been successfully negotiated, and the UUID is found
+  in the exporters cache, this message is submitted by the front-end
+  to retrieve a given dma-buf fd from a given back-end, determined by
+  the requested UUID. Back-end will reply passing the fd when the operation
+  is successful, or no fd otherwise.
 
 Back-end message types
 ----------------------
@@ -1528,6 +1540,51 @@ is sent by the front-end.
 
   The state.num field is currently reserved and must be set to 0.
 
+``VHOST_USER_BACKEND_SHARED_OBJECT_ADD``
+  :id: 6
+  :equivalent ioctl: N/A
+  :request payload: ``struct VhostUserShared``
+  :reply payload: N/A
+
+  When the ``VHOST_USER_PROTOCOL_F_SHARED_OBJECT`` protocol
+  feature has been successfully negotiated, this message can be submitted
+  by the backends to add themselves as exporters to the virtio shared lookup
+  table. The back-end device gets associated with a UUID in the shared table.
+  The back-end is responsible of keeping its own table with exported dma-buf fds.
+  When another back-end tries to import the resource associated with the UUID,
+  it will send a message to the front-end, which will act as a proxy to the
+  exporter back-end. If ``VHOST_USER_PROTOCOL_F_REPLY_ACK`` is negotiated, and
+  the back-end sets the ``VHOST_USER_NEED_REPLY`` flag, the front-end must
+  respond with zero when operation is successfully completed, or non-zero
+  otherwise.
+
+``VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE``
+  :id: 7
+  :equivalent ioctl: N/A
+  :request payload: ``struct VhostUserShared``
+  :reply payload: N/A
+
+  When the ``VHOST_USER_PROTOCOL_F_SHARED_OBJECT`` protocol
+  feature has been successfully negotiated, this message can be submitted
+  by the backend to remove themselves from to the virtio-dmabuf shared
+  table API. The shared table will remove the back-end device associated with
+  the UUID. If ``VHOST_USER_PROTOCOL_F_REPLY_ACK`` is negotiated, and the
+  back-end sets the ``VHOST_USER_NEED_REPLY`` flag, the front-end must respond
+  with zero when operation is successfully completed, or non-zero otherwise.
+
+``VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP``
+  :id: 8
+  :equivalent ioctl: N/A
+  :request payload: ``struct VhostUserShared``
+  :reply payload: dmabuf fd and ``u64``
+
+  When the ``VHOST_USER_PROTOCOL_F_SHARED_OBJECT`` protocol
+  feature has been successfully negotiated, this message can be submitted
+  by the backends to retrieve a given dma-buf fd from the virtio-dmabuf
+  shared table given a UUID. Frontend will reply passing the fd and a zero
+  when the operation is successful, or non-zero otherwise. Note that if the
+  operation fails, no fd is sent to the backend.
+
 .. _reply_ack:
 
 VHOST_USER_PROTOCOL_F_REPLY_ACK
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 8dcf049d42..28fa0ace42 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -10,6 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "hw/virtio/virtio-dmabuf.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/virtio-crypto.h"
 #include "hw/virtio/vhost-user.h"
@@ -21,6 +22,7 @@
 #include "sysemu/kvm.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "qemu/uuid.h"
 #include "qemu/sockets.h"
 #include "sysemu/runstate.h"
 #include "sysemu/cryptodev.h"
@@ -74,6 +76,7 @@ enum VhostUserProtocolFeature {
     /* Feature 14 reserved for VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS. */
     VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
     VHOST_USER_PROTOCOL_F_STATUS = 16,
+    VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 17,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
@@ -121,6 +124,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_REM_MEM_REG = 38,
     VHOST_USER_SET_STATUS = 39,
     VHOST_USER_GET_STATUS = 40,
+    VHOST_USER_GET_SHARED_OBJECT = 41,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -129,6 +133,9 @@ typedef enum VhostUserBackendRequest {
     VHOST_USER_BACKEND_IOTLB_MSG = 1,
     VHOST_USER_BACKEND_CONFIG_CHANGE_MSG = 2,
     VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG = 3,
+    VHOST_USER_BACKEND_SHARED_OBJECT_ADD = 6,
+    VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE = 7,
+    VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP = 8,
     VHOST_USER_BACKEND_MAX
 }  VhostUserBackendRequest;
 
@@ -202,6 +209,10 @@ typedef struct VhostUserInflight {
     uint16_t queue_size;
 } VhostUserInflight;
 
+typedef struct VhostUserShared {
+    unsigned char uuid[16];
+} VhostUserShared;
+
 typedef struct {
     VhostUserRequest request;
 
@@ -226,6 +237,7 @@ typedef union {
         VhostUserCryptoSession session;
         VhostUserVringArea area;
         VhostUserInflight inflight;
+        VhostUserShared object;
 } VhostUserPayload;
 
 typedef struct VhostUserMsg {
@@ -1601,6 +1613,144 @@ static int vhost_user_backend_handle_vring_host_notifier(struct vhost_dev *dev,
     return 0;
 }
 
+static int
+vhost_user_backend_handle_shared_object_add(struct vhost_dev *dev,
+                                            VhostUserShared *object)
+{
+    QemuUUID uuid;
+
+    memcpy(uuid.data, object->uuid, sizeof(object->uuid));
+    return virtio_add_vhost_device(&uuid, dev);
+}
+
+static int
+vhost_user_backend_handle_shared_object_remove(VhostUserShared *object)
+{
+    QemuUUID uuid;
+
+    memcpy(uuid.data, object->uuid, sizeof(object->uuid));
+    return virtio_remove_resource(&uuid);
+}
+
+static bool vhost_user_send_resp(QIOChannel *ioc, VhostUserHeader *hdr,
+                                 VhostUserPayload *payload)
+{
+    Error *local_err = NULL;
+    struct iovec iov[] = {
+        { .iov_base = hdr,      .iov_len = VHOST_USER_HDR_SIZE },
+        { .iov_base = payload,  .iov_len = hdr->size },
+    };
+
+    hdr->flags &= ~VHOST_USER_NEED_REPLY_MASK;
+    hdr->flags |= VHOST_USER_REPLY_MASK;
+
+    if (qio_channel_writev_all(ioc, iov, ARRAY_SIZE(iov), &local_err)) {
+        error_report_err(local_err);
+        return false;
+    }
+
+    return true;
+}
+
+static bool
+vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHeader *hdr,
+                                  VhostUserPayload *payload)
+{
+    hdr->size = sizeof(payload->u64);
+    return vhost_user_send_resp(ioc, hdr, payload);
+}
+
+int vhost_user_get_shared_object(struct vhost_dev *dev, unsigned char *uuid,
+                                 int *dmabuf_fd)
+{
+    struct vhost_user *u = dev->opaque;
+    CharBackend *chr = u->user->chr;
+    int ret;
+    VhostUserMsg msg = {
+        .hdr.request = VHOST_USER_GET_SHARED_OBJECT,
+        .hdr.flags = VHOST_USER_VERSION,
+    };
+    memcpy(msg.payload.object.uuid, uuid, sizeof(msg.payload.object.uuid));
+
+    ret = vhost_user_write(dev, &msg, NULL, 0);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = vhost_user_read(dev, &msg);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (msg.hdr.request != VHOST_USER_GET_SHARED_OBJECT) {
+        error_report("Received unexpected msg type. "
+                     "Expected %d received %d",
+                     VHOST_USER_GET_SHARED_OBJECT, msg.hdr.request);
+        return -EPROTO;
+    }
+
+    *dmabuf_fd = qemu_chr_fe_get_msgfd(chr);
+    if (*dmabuf_fd < 0) {
+        error_report("Failed to get dmabuf fd");
+        return -EIO;
+    }
+
+    return 0;
+}
+
+static int
+vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
+                                               QIOChannel *ioc,
+                                               VhostUserHeader *hdr,
+                                               VhostUserPayload *payload)
+{
+    QemuUUID uuid;
+    CharBackend *chr = u->user->chr;
+    int dmabuf_fd = -1;
+    int fd_num = 0;
+
+    memcpy(uuid.data, payload->object.uuid, sizeof(payload->object.uuid));
+
+    payload->u64 = 0;
+    switch (virtio_object_type(&uuid)) {
+        case TYPE_DMABUF:
+            dmabuf_fd = virtio_lookup_dmabuf(&uuid);
+            break;
+        case TYPE_VHOST_DEV:
+        {
+            struct vhost_dev *dev = virtio_lookup_vhost_device(&uuid);
+            if (dev == NULL) {
+                payload->u64 = -EINVAL;
+                break;
+            }
+            int ret = vhost_user_get_shared_object(dev, uuid.data, &dmabuf_fd);
+            if (ret < 0) {
+                payload->u64 = ret;
+            }
+            break;
+        }
+        case TYPE_INVALID:
+            payload->u64 = -EINVAL;
+            break;
+    }
+
+    if (dmabuf_fd != -1) {
+        fd_num++;
+    }
+
+    if (qemu_chr_fe_set_msgfds(chr, &dmabuf_fd, fd_num) < 0) {
+        error_report("Failed to set msg fds.");
+        payload->u64 = -EINVAL;
+    }
+
+    if (!vhost_user_backend_send_dmabuf_fd(ioc, hdr, payload)) {
+        error_report("Failed to write response msg.");
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
 static void close_backend_channel(struct vhost_user *u)
 {
     g_source_destroy(u->backend_src);
@@ -1658,6 +1808,16 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
         ret = vhost_user_backend_handle_vring_host_notifier(dev, &payload.area,
                                                           fd ? fd[0] : -1);
         break;
+    case VHOST_USER_BACKEND_SHARED_OBJECT_ADD:
+        ret = vhost_user_backend_handle_shared_object_add(dev, &payload.object);
+        break;
+    case VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE:
+        ret = vhost_user_backend_handle_shared_object_remove(&payload.object);
+        break;
+    case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
+        ret = vhost_user_backend_handle_shared_object_lookup(dev->opaque, ioc,
+                                                             &hdr, &payload);
+        break;
     default:
         error_report("Received unexpected msg type: %d.", hdr.request);
         ret = -EINVAL;
@@ -1668,22 +1828,10 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
      * directly in their request handlers.
      */
     if (hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
-        struct iovec iovec[2];
-
-
-        hdr.flags &= ~VHOST_USER_NEED_REPLY_MASK;
-        hdr.flags |= VHOST_USER_REPLY_MASK;
-
         payload.u64 = !!ret;
         hdr.size = sizeof(payload.u64);
 
-        iovec[0].iov_base = &hdr;
-        iovec[0].iov_len = VHOST_USER_HDR_SIZE;
-        iovec[1].iov_base = &payload;
-        iovec[1].iov_len = hdr.size;
-
-        if (qio_channel_writev_all(ioc, iovec, ARRAY_SIZE(iovec), &local_err)) {
-            error_report_err(local_err);
+        if (!vhost_user_send_resp(ioc, &hdr, &payload)) {
             goto err;
         }
     }
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index 31a251a9f5..1860b541d8 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -196,4 +196,7 @@ int vhost_backend_handle_iotlb_msg(struct vhost_dev *dev,
 
 int vhost_user_gpu_set_socket(struct vhost_dev *dev, int fd);
 
+int vhost_user_get_shared_object(struct vhost_dev *dev, unsigned char *uuid,
+                                        int *dmabuf_fd);
+
 #endif /* VHOST_BACKEND_H */
diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 0469a50101..432bb9fc0b 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -161,6 +161,7 @@ vu_request_to_string(unsigned int req)
         REQ(VHOST_USER_GET_MAX_MEM_SLOTS),
         REQ(VHOST_USER_ADD_MEM_REG),
         REQ(VHOST_USER_REM_MEM_REG),
+        REQ(VHOST_USER_GET_SHARED_OBJECT),
         REQ(VHOST_USER_MAX),
     };
 #undef REQ
@@ -900,6 +901,23 @@ vu_rem_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
     return false;
 }
 
+static bool
+vu_get_shared_object(VuDev *dev, VhostUserMsg *vmsg)
+{
+    int fd_num = 0;
+    int dmabuf_fd = -1;
+    if (dev->iface->get_shared_object) {
+        dmabuf_fd = dev->iface->get_shared_object(dev, &vmsg->payload.object.uuid[0]);
+    }
+    if (dmabuf_fd != -1) {
+        DPRINT("dmabuf_fd found for requested UUID\n");
+        vmsg->fds[fd_num++] = dmabuf_fd;
+    }
+    vmsg->fd_num = fd_num;
+
+    return true;
+}
+
 static bool
 vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
 {
@@ -1403,6 +1421,104 @@ bool vu_set_queue_host_notifier(VuDev *dev, VuVirtq *vq, int fd,
     return vu_process_message_reply(dev, &vmsg);
 }
 
+bool
+vu_lookup_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN], int *dmabuf_fd)
+{
+    bool result = false;
+    VhostUserMsg msg_reply;
+    VhostUserMsg msg = {
+        .request = VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP,
+        .size = sizeof(msg.payload.object),
+        .flags = VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MASK,
+    };
+
+    memcpy(msg.payload.object.uuid, uuid, sizeof(uuid[0]) * UUID_LEN);
+
+    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SHARED_OBJECT)) {
+        return false;
+    }
+
+    pthread_mutex_lock(&dev->backend_mutex);
+    if (!vu_message_write(dev, dev->backend_fd, &msg)) {
+        goto out;
+    }
+
+    if (!vu_message_read_default(dev, dev->backend_fd, &msg_reply)) {
+        goto out;
+    }
+
+    if (msg_reply.request != msg.request) {
+        DPRINT("Received unexpected msg type. Expected %d, received %d",
+               msg.request, msg_reply.request);
+        goto out;
+    }
+
+    if (msg_reply.fd_num != 1) {
+        DPRINT("Received unexpected number of fds. Expected 1, received %d",
+               msg_reply.fd_num);
+        goto out;
+    }
+
+    *dmabuf_fd = msg_reply.fds[0];
+    result = *dmabuf_fd > 0 && msg_reply.payload.u64 == 0;
+out:
+    pthread_mutex_unlock(&dev->backend_mutex);
+
+    return result;
+}
+
+static bool
+vu_send_message(VuDev *dev, VhostUserMsg *vmsg)
+{
+    bool result = false;
+    pthread_mutex_lock(&dev->backend_mutex);
+    if (!vu_message_write(dev, dev->backend_fd, vmsg)) {
+        goto out;
+    }
+
+    result = true;
+out:
+    pthread_mutex_unlock(&dev->backend_mutex);
+
+    return result;
+}
+
+bool
+vu_add_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN])
+{
+    VhostUserMsg msg = {
+        .request = VHOST_USER_BACKEND_SHARED_OBJECT_ADD,
+        .size = sizeof(msg.payload.object),
+        .flags = VHOST_USER_VERSION,
+    };
+
+    memcpy(msg.payload.object.uuid, uuid, sizeof(uuid[0]) * UUID_LEN);
+
+    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SHARED_OBJECT)) {
+        return false;
+    }
+
+    return vu_send_message(dev, &msg);
+}
+
+bool
+vu_rm_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN])
+{
+    VhostUserMsg msg = {
+        .request = VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE,
+        .size = sizeof(msg.payload.object),
+        .flags = VHOST_USER_VERSION,
+    };
+
+    memcpy(msg.payload.object.uuid, uuid, sizeof(uuid[0]) * UUID_LEN);
+
+    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SHARED_OBJECT)) {
+        return false;
+    }
+
+    return vu_send_message(dev, &msg);
+}
+
 static bool
 vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
@@ -1943,6 +2059,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
         return vu_add_mem_reg(dev, vmsg);
     case VHOST_USER_REM_MEM_REG:
         return vu_rem_mem_reg(dev, vmsg);
+    case VHOST_USER_GET_SHARED_OBJECT:
+        return vu_get_shared_object(dev, vmsg);
     default:
         vmsg_close_fds(vmsg);
         vu_panic(dev, "Unhandled request: %d", vmsg->request);
diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
index 708370c5f5..b36a42a7ca 100644
--- a/subprojects/libvhost-user/libvhost-user.h
+++ b/subprojects/libvhost-user/libvhost-user.h
@@ -64,7 +64,8 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD = 12,
     VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS = 14,
     VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
-
+    /* Feature 16 is reserved for VHOST_USER_PROTOCOL_F_STATUS. */
+    VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 17,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
@@ -109,6 +110,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_GET_MAX_MEM_SLOTS = 36,
     VHOST_USER_ADD_MEM_REG = 37,
     VHOST_USER_REM_MEM_REG = 38,
+    VHOST_USER_GET_SHARED_OBJECT = 41,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -119,6 +121,9 @@ typedef enum VhostUserBackendRequest {
     VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG = 3,
     VHOST_USER_BACKEND_VRING_CALL = 4,
     VHOST_USER_BACKEND_VRING_ERR = 5,
+    VHOST_USER_BACKEND_SHARED_OBJECT_ADD = 6,
+    VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE = 7,
+    VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP = 8,
     VHOST_USER_BACKEND_MAX
 }  VhostUserBackendRequest;
 
@@ -172,6 +177,12 @@ typedef struct VhostUserInflight {
     uint16_t queue_size;
 } VhostUserInflight;
 
+#define UUID_LEN 16
+
+typedef struct VhostUserShared {
+    unsigned char uuid[UUID_LEN];
+} VhostUserShared;
+
 #if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
 # define VU_PACKED __attribute__((gcc_struct, packed))
 #else
@@ -199,6 +210,7 @@ typedef struct VhostUserMsg {
         VhostUserConfig config;
         VhostUserVringArea area;
         VhostUserInflight inflight;
+        VhostUserShared object;
     } payload;
 
     int fds[VHOST_MEMORY_BASELINE_NREGIONS];
@@ -232,6 +244,7 @@ typedef int (*vu_get_config_cb) (VuDev *dev, uint8_t *config, uint32_t len);
 typedef int (*vu_set_config_cb) (VuDev *dev, const uint8_t *data,
                                  uint32_t offset, uint32_t size,
                                  uint32_t flags);
+typedef int (*vu_get_shared_object_cb) (VuDev *dev, const unsigned char *uuid);
 
 typedef struct VuDevIface {
     /* called by VHOST_USER_GET_FEATURES to get the features bitmask */
@@ -258,6 +271,8 @@ typedef struct VuDevIface {
     vu_get_config_cb get_config;
     /* set the config space of the device */
     vu_set_config_cb set_config;
+    /* get virtio shared object from the underlying vhost implementation. */
+    vu_get_shared_object_cb get_shared_object;
 } VuDevIface;
 
 typedef void (*vu_queue_handler_cb) (VuDev *dev, int qidx);
@@ -541,6 +556,44 @@ void vu_set_queue_handler(VuDev *dev, VuVirtq *vq,
 bool vu_set_queue_host_notifier(VuDev *dev, VuVirtq *vq, int fd,
                                 int size, int offset);
 
+/**
+ * vu_lookup_shared_object:
+ * @dev: a VuDev context
+ * @uuid: UUID of the shared object
+ * @dmabuf_fd: output dma-buf file descriptor
+ *
+ * Lookup for a virtio shared object (i.e., dma-buf fd) associated with the
+ * received UUID. Result, if found, is stored in the dmabuf_fd argument.
+ *
+ * Returns: whether the virtio object was found.
+ */
+bool vu_lookup_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN],
+                             int *dmabuf_fd);
+
+/**
+ * vu_add_shared_object:
+ * @dev: a VuDev context
+ * @uuid: UUID of the shared object
+ *
+ * Registers this back-end as the exporter for the object associated with
+ * the received UUID.
+ *
+ * Returns: TRUE on success, FALSE on failure.
+ */
+bool vu_add_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN]);
+
+/**
+ * vu_rm_shared_object:
+ * @dev: a VuDev context
+ * @uuid: UUID of the shared object
+ *
+ * Removes a shared object entry (i.e., back-end entry) associated with the
+ * received UUID key from the hash table.
+ *
+ * Returns: TRUE on success, FALSE on failure.
+ */
+bool vu_rm_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN]);
+
 /**
  * vu_queue_set_notification:
  * @dev: a VuDev context
-- 
2.41.0


