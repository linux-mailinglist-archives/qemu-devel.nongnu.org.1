Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B393C7B9A70
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:49:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFJR-0000ik-Rc; Wed, 04 Oct 2023 23:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFJN-0000ck-Pr
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:46:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFJL-0000ps-AU
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IL+0u6Y9ni2NTr+Pq389CoMdv+eJbHzzSWh12MIlkJ8=;
 b=G6H8kAyAZZzNAvKE/i2QRlVmCe17kBHyKl0AW3mjp2+XmF4NLz//QwTYH5J+gWqhXmdwhL
 Y7uIMrz9Rwv014XoCRJ6O3Qdg3vwbpKZtyxloo0TqXh7QC/4BUTP3wpxJlE+txxwXIkz78
 3K798h2LsoMCas+GSTwM4oIDb6qUeDU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-PEKlC5M-NW-dQeCJ9NRF0g-1; Wed, 04 Oct 2023 23:46:01 -0400
X-MC-Unique: PEKlC5M-NW-dQeCJ9NRF0g-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32006e08483so412431f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477559; x=1697082359;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IL+0u6Y9ni2NTr+Pq389CoMdv+eJbHzzSWh12MIlkJ8=;
 b=su9+bwaiB0Ft1hu0ssNAYNvVTt6H13x6HCara0svM6CbQ1lG7R+JoWPEjY6z9/n7MX
 wZ9kBzZy63grrSw5uf4cQpMYs4Ki81XKqMthAP67Nvkl1ciERbc1wL72diyblzDl+jck
 NHW4AfJ0Kkqwfz6FbXqG14HrrQR76cY9xd2hYi58X1mrT/aa9sHHi7bARfbM/9lCTBWM
 Ebf80vzeJYu3g/E4b2OqNvxE/kMtJbXEz1XJttF1wmgSTZX99vCOJ58IHkYcOn3OAJrS
 Kg6XdNvqZgMKGfG/y+JApnPXS6Rk12bgDC97KnNOHB0ZRiM+ZxdUgp5mYf5I2RnU59h5
 41aw==
X-Gm-Message-State: AOJu0YxXZWdXG1/2kIBQD3+5Tan+y3RSy5ZZWD3At6wTohaWjCDBcRvl
 x5m2FKgORZNSUbKLlAfjcAMUn5FJpxTy4LV3AYgsiCnj2fcb9WUGhhSgYmcbdNl7eWrnHhphDwd
 PFlU/2JwTCtuO+Z912XHWyA6O4x7nB0w0guqV8YFvWBy1zPtsnMySNlceSUNJzxCtOUre
X-Received: by 2002:adf:efd1:0:b0:31f:fc96:9af1 with SMTP id
 i17-20020adfefd1000000b0031ffc969af1mr3709993wrp.59.1696477559366; 
 Wed, 04 Oct 2023 20:45:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHn9zopj7kAhxEmenZrGnMaQvj5PD9BlG15NheDZc3oPZDYj4FXLQd9+U2MVZz8SYe8V3Ed/A==
X-Received: by 2002:adf:efd1:0:b0:31f:fc96:9af1 with SMTP id
 i17-20020adfefd1000000b0031ffc969af1mr3709984wrp.59.1696477558909; 
 Wed, 04 Oct 2023 20:45:58 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 y3-20020adff143000000b0032327b70ef6sm629501wro.70.2023.10.04.20.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:45:58 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:45:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Albert Esteve <aesteve@redhat.com>
Subject: [PULL v2 52/53] vhost-user: add shared_object msg
Message-ID: <160947666276c5b7f6bca4d746bcac2966635d79.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Albert Esteve <aesteve@redhat.com>

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

The messages can only be sent after successfully
negotiating a new VHOST_USER_PROTOCOL_F_SHARED_OBJECT
vhost-user protocol feature bit.

Finally, refactor code to send response message so
that all common parts both for the common REPLY_ACK
case, and other data responses, can call it and
avoid code repetition.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
Message-Id: <20231002065706.94707-4-aesteve@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-backend.h |   3 +
 include/hw/virtio/vhost-user.h    |   1 +
 hw/virtio/vhost-user.c            | 167 +++++++++++++++++++++++++++---
 docs/interop/vhost-user.rst       |  57 ++++++++++
 4 files changed, 216 insertions(+), 12 deletions(-)

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
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 80e2b4a463..9f9ddf878d 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -29,6 +29,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS = 14,
     VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
     VHOST_USER_PROTOCOL_F_STATUS = 16,
+    VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 17,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index a096335921..3766b415f8 100644
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
@@ -100,6 +102,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_REM_MEM_REG = 38,
     VHOST_USER_SET_STATUS = 39,
     VHOST_USER_GET_STATUS = 40,
+    VHOST_USER_GET_SHARED_OBJECT = 41,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -108,6 +111,9 @@ typedef enum VhostUserBackendRequest {
     VHOST_USER_BACKEND_IOTLB_MSG = 1,
     VHOST_USER_BACKEND_CONFIG_CHANGE_MSG = 2,
     VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG = 3,
+    VHOST_USER_BACKEND_SHARED_OBJECT_ADD = 6,
+    VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE = 7,
+    VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP = 8,
     VHOST_USER_BACKEND_MAX
 }  VhostUserBackendRequest;
 
@@ -181,6 +187,10 @@ typedef struct VhostUserInflight {
     uint16_t queue_size;
 } VhostUserInflight;
 
+typedef struct VhostUserShared {
+    unsigned char uuid[16];
+} VhostUserShared;
+
 typedef struct {
     VhostUserRequest request;
 
@@ -205,6 +215,7 @@ typedef union {
         VhostUserCryptoSession session;
         VhostUserVringArea area;
         VhostUserInflight inflight;
+        VhostUserShared object;
 } VhostUserPayload;
 
 typedef struct VhostUserMsg {
@@ -1580,6 +1591,139 @@ static int vhost_user_backend_handle_vring_host_notifier(struct vhost_dev *dev,
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
+                                 VhostUserPayload *payload, Error **errp)
+{
+    struct iovec iov[] = {
+        { .iov_base = hdr,      .iov_len = VHOST_USER_HDR_SIZE },
+        { .iov_base = payload,  .iov_len = hdr->size },
+    };
+
+    hdr->flags &= ~VHOST_USER_NEED_REPLY_MASK;
+    hdr->flags |= VHOST_USER_REPLY_MASK;
+
+    return !qio_channel_writev_all(ioc, iov, ARRAY_SIZE(iov), errp);
+}
+
+static bool
+vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHeader *hdr,
+                                  VhostUserPayload *payload, Error **errp)
+{
+    hdr->size = sizeof(payload->u64);
+    return vhost_user_send_resp(ioc, hdr, payload, errp);
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
+    Error *local_err = NULL;
+    int dmabuf_fd = -1;
+    int fd_num = 0;
+
+    memcpy(uuid.data, payload->object.uuid, sizeof(payload->object.uuid));
+
+    payload->u64 = 0;
+    switch (virtio_object_type(&uuid)) {
+    case TYPE_DMABUF:
+        dmabuf_fd = virtio_lookup_dmabuf(&uuid);
+        break;
+    case TYPE_VHOST_DEV:
+    {
+        struct vhost_dev *dev = virtio_lookup_vhost_device(&uuid);
+        if (dev == NULL) {
+            payload->u64 = -EINVAL;
+            break;
+        }
+        int ret = vhost_user_get_shared_object(dev, uuid.data, &dmabuf_fd);
+        if (ret < 0) {
+            payload->u64 = ret;
+        }
+        break;
+    }
+    case TYPE_INVALID:
+        payload->u64 = -EINVAL;
+        break;
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
+    if (!vhost_user_backend_send_dmabuf_fd(ioc, hdr, payload, &local_err)) {
+        error_report_err(local_err);
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
 static void close_backend_channel(struct vhost_user *u)
 {
     g_source_destroy(u->backend_src);
@@ -1637,6 +1781,16 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
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
@@ -1647,21 +1801,10 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
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
+        if (!vhost_user_send_resp(ioc, &hdr, &payload, &local_err)) {
             error_report_err(local_err);
             goto err;
         }
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
-- 
MST


