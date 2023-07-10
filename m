Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC4474DDB8
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 21:04:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIwAX-0003XW-DA; Mon, 10 Jul 2023 15:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIwAL-0003XB-J2
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 15:03:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIwAJ-0008Js-1l
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 15:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689015798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2dA2z2l3k+D9awbRHry1OtbVA/Xad+59j3YSv3jCHHQ=;
 b=gF9Wqe+f5f5qVUAJoXRdw4UM9YuRbNDLGiqgBJmv7pQRcgSAKJeqizQk4YKZnoIX1iSx6g
 HTqlCQ1SPGHlcfANicjzMvzX4meHb7GyIxkjFKHU522DXcs6UJ7NaDjSOmGhF9PgqaaxEP
 BOuHN1tgDJzEPkG6DBbD8v5pkfpOy6U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-_vALwzT9NtCy9r1jYO_z4w-1; Mon, 10 Jul 2023 15:03:16 -0400
X-MC-Unique: _vALwzT9NtCy9r1jYO_z4w-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fc08035926so9709035e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 12:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689015795; x=1691607795;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2dA2z2l3k+D9awbRHry1OtbVA/Xad+59j3YSv3jCHHQ=;
 b=O9Mpfm8LhNB7E4io8NHQB0IWjATkP1pqZsF+AJ+T3UYZFpJRPT9HG4vz6hFC6lcIA1
 X5cQXma4nUycLF0t9sj1zn+udiPyySy6Hy6z34Y+oluG0aHkwevzUD0Airs7tllZGaxQ
 wgBGAiEnKk8qQLB6i03U9UnApTUK1QESGNabM7ASoazcLAL5PN/g+a8mKmJ7Doco8U3L
 YG/b324+e7HL5lL74z5QwTRFor2tM+zO7r6kiZn42vER/XCAIrbXPW3NAyi3Mxk9PPnN
 3dJmy7fiQZAp0WGYMuZOhubC4z7cLcqek5vCfszKwdWLO/BgvAoK+ngF1b+DcnuqFnFv
 eUng==
X-Gm-Message-State: ABy/qLbQKu6Nw6Y60dIdnlmCrB6AdJwF1lm1bGpiAzMZ+9za3HT7/3/v
 MhhBjKFgLg+MfCbSxDzlqq+EHs6rjXeVqCz7k1pLrxRXtkMJHLqrlS4VphV4Vv13xZlgGRnw6m4
 6Lm/6P3kZGvnG3zw=
X-Received: by 2002:a05:600c:4f85:b0:3fb:ebe2:6f5f with SMTP id
 n5-20020a05600c4f8500b003fbebe26f5fmr12277378wmq.13.1689015795578; 
 Mon, 10 Jul 2023 12:03:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEHEYVt4MPdbG6GxdNzpAsHL5ZDSQKRrgqbarAwmA9m5KEVoGZb6lQa6jURMBpwhweMxNENEw==
X-Received: by 2002:a05:600c:4f85:b0:3fb:ebe2:6f5f with SMTP id
 n5-20020a05600c4f8500b003fbebe26f5fmr12277365wmq.13.1689015795193; 
 Mon, 10 Jul 2023 12:03:15 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 e14-20020a05600c218e00b003fa96fe2bd9sm11058260wme.22.2023.07.10.12.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 12:03:14 -0700 (PDT)
Date: Mon, 10 Jul 2023 15:03:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com, cohuck@redhat.com,
 Fam Zheng <fam@euphon.net>, kraxel@redhat.com
Subject: Re: [PATCH v4 3/4] vhost-user: add shared_object msg
Message-ID: <20230710150030-mutt-send-email-mst@kernel.org>
References: <20230626073426.285659-1-aesteve@redhat.com>
 <20230626073426.285659-4-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626073426.285659-4-aesteve@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jun 26, 2023 at 09:34:25AM +0200, Albert Esteve wrote:
> Add three new vhost-user protocol
> `VHOST_USER_BACKEND_SHARED_OBJECT_* messages`.
> These new messages are sent from vhost-user
> back-ends to interact with the virtio-dmabuf
> table in order to add, remove, or lookup for
> virtio dma-buf shared objects.
> 
> The action taken in the front-end depends
> on the type stored in the payload struct.
> 
> In the libvhost-user library we need to add
> helper functions to allow sending messages to
> interact with the virtio shared objects
> hash table.
> 
> The messages can only be sent after successfully
> negotiating a new VHOST_USER_PROTOCOL_F_SHARED_OBJECT
> vhost-user protocol feature bit.
> 
> Signed-off-by: Albert Esteve <aesteve@redhat.com>

It bothers me that apparently, any backend can now
make qemu allocate any amount of memory by sending
lots of add messages.

Any way to limit this? If not - at least let's make this
a property that's opt-in?


> ---
>  docs/interop/vhost-user.rst               |  42 +++++++++
>  hw/virtio/vhost-user.c                    |  99 +++++++++++++++++++++
>  subprojects/libvhost-user/libvhost-user.c | 101 ++++++++++++++++++++++
>  subprojects/libvhost-user/libvhost-user.h |  53 +++++++++++-
>  4 files changed, 294 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 5a070adbc1..bca5600ff1 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -1528,6 +1528,48 @@ is sent by the front-end.
>  
>    The state.num field is currently reserved and must be set to 0.
>  
> +``VHOST_USER_BACKEND_SHARED_OBJECT_ADD``
> +  :id: 6
> +  :equivalent ioctl: N/A
> +  :request payload: ``struct VhostUserShared``
> +  :reply payload: N/A
> +
> +  When the ``VHOST_USER_PROTOCOL_F_SHARED_OBJECT`` protocol
> +  feature has been successfully negotiated, this message can be submitted
> +  by the backends to add a new dma-buf fd to the virtio-dmabuf shared
> +  table API can send this message. The fd gets associated with a UUID.
> +  If ``VHOST_USER_PROTOCOL_F_REPLY_ACK`` is negotiated, and the back-end sets
> +  the ``VHOST_USER_NEED_REPLY`` flag, the front-end must respond with zero when
> +  operation is successfully completed, or non-zero otherwise.
> +
> +``VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE``
> +  :id: 7
> +  :equivalent ioctl: N/A
> +  :request payload: ``struct VhostUserShared``
> +  :reply payload: N/A
> +
> +  When the ``VHOST_USER_PROTOCOL_F_SHARED_OBJECT`` protocol
> +  feature has been successfully negotiated, this message can be submitted
> +  by the backend to remove a dma-buf from to the virtio-dmabuf shared
> +  table API can send this message. The shared table will remove the dma-buf
> +  fd associated with the UUID. If ``VHOST_USER_PROTOCOL_F_REPLY_ACK`` is
> +  negotiated, and the back-end sets the ``VHOST_USER_NEED_REPLY`` flag, the
> +  front-end must respond with zero when operation is successfully completed,
> +  or non-zero otherwise.
> +
> +``VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP``
> +  :id: 8
> +  :equivalent ioctl: N/A
> +  :request payload: ``struct VhostUserShared``
> +  :reply payload: dmabuf fd and ``u64``
> +
> +  When the ``VHOST_USER_PROTOCOL_F_SHARED_OBJECT`` protocol
> +  feature has been successfully negotiated, this message can be submitted
> +  by the backends to retrieve a given dma-buf fd from the virtio-dmabuf
> +  shared table given a UUID. Frontend will reply passing the fd and a zero
> +  when the operation is successful, or non-zero otherwise. Note that if the
> +  operation fails, no fd is sent to the backend.
> +
>  .. _reply_ack:
>  
>  VHOST_USER_PROTOCOL_F_REPLY_ACK
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 74a2a28663..e340c39a19 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -10,6 +10,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> +#include "hw/virtio/virtio-dmabuf.h"
>  #include "hw/virtio/vhost.h"
>  #include "hw/virtio/vhost-user.h"
>  #include "hw/virtio/vhost-backend.h"
> @@ -20,6 +21,7 @@
>  #include "sysemu/kvm.h"
>  #include "qemu/error-report.h"
>  #include "qemu/main-loop.h"
> +#include "qemu/uuid.h"
>  #include "qemu/sockets.h"
>  #include "sysemu/runstate.h"
>  #include "sysemu/cryptodev.h"
> @@ -73,6 +75,7 @@ enum VhostUserProtocolFeature {
>      /* Feature 14 reserved for VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS. */
>      VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
>      VHOST_USER_PROTOCOL_F_STATUS = 16,
> +    VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 17,
>      VHOST_USER_PROTOCOL_F_MAX
>  };
>  
> @@ -128,6 +131,9 @@ typedef enum VhostUserSlaveRequest {
>      VHOST_USER_BACKEND_IOTLB_MSG = 1,
>      VHOST_USER_BACKEND_CONFIG_CHANGE_MSG = 2,
>      VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG = 3,
> +    VHOST_USER_BACKEND_SHARED_OBJECT_ADD = 6,
> +    VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE = 7,
> +    VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP = 8,
>      VHOST_USER_BACKEND_MAX
>  }  VhostUserSlaveRequest;
>  
> @@ -190,6 +196,10 @@ typedef struct VhostUserInflight {
>      uint16_t queue_size;
>  } VhostUserInflight;
>  
> +typedef struct VhostUserShared {
> +    unsigned char uuid[16];
> +} VhostUserShared;
> +
>  typedef struct {
>      VhostUserRequest request;
>  
> @@ -214,6 +224,7 @@ typedef union {
>          VhostUserCryptoSession session;
>          VhostUserVringArea area;
>          VhostUserInflight inflight;
> +        VhostUserShared object;
>  } VhostUserPayload;
>  
>  typedef struct VhostUserMsg {
> @@ -1582,6 +1593,83 @@ static int vhost_user_slave_handle_vring_host_notifier(struct vhost_dev *dev,
>      return 0;
>  }
>  
> +static int
> +vhost_user_backend_handle_shared_object_add(VhostUserShared *object,
> +                                            int dmabuf_fd)
> +{
> +    QemuUUID uuid;
> +
> +    memcpy(uuid.data, object->uuid, sizeof(object->uuid));
> +    return virtio_add_dmabuf(&uuid, dmabuf_fd);
> +}
> +
> +static int
> +vhost_user_backend_handle_shared_object_remove(VhostUserShared *object)
> +{
> +    QemuUUID uuid;
> +
> +    memcpy(uuid.data, object->uuid, sizeof(object->uuid));
> +    return virtio_remove_resource(&uuid);
> +}
> +
> +static bool
> +vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHeader *hdr,
> +                                  VhostUserPayload *payload)
> +{
> +    Error *local_err = NULL;
> +    struct iovec iov[2];
> +
> +    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> +        hdr->flags &= ~VHOST_USER_NEED_REPLY_MASK;
> +    }
> +    hdr->flags |= VHOST_USER_REPLY_MASK;
> +
> +    hdr->size = sizeof(payload->u64);
> +
> +    iov[0].iov_base = hdr;
> +    iov[0].iov_len = VHOST_USER_HDR_SIZE;
> +    iov[1].iov_base = payload;
> +    iov[1].iov_len = hdr->size;
> +
> +    if (qio_channel_writev_all(ioc, iov, ARRAY_SIZE(iov), &local_err)) {
> +        error_report_err(local_err);
> +        return false;
> +    }
> +    return true;
> +}
> +
> +static int
> +vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
> +                                               QIOChannel *ioc,
> +                                               VhostUserHeader *hdr,
> +                                               VhostUserPayload *payload)
> +{
> +    QemuUUID uuid;
> +    CharBackend *chr = u->user->chr;
> +    int dmabuf_fd = -1;
> +    int fd_num = 0;
> +
> +    memcpy(uuid.data, payload->object.uuid, sizeof(payload->object.uuid));
> +
> +    dmabuf_fd = virtio_lookup_dmabuf(&uuid);
> +    if (dmabuf_fd != -1) {
> +        fd_num++;
> +    }
> +
> +    payload->u64 = 0;
> +    if (qemu_chr_fe_set_msgfds(chr, &dmabuf_fd, fd_num) < 0) {
> +        error_report("Failed to set msg fds.");
> +        payload->u64 = -EINVAL;
> +    }
> +
> +    if (!vhost_user_backend_send_dmabuf_fd(ioc, hdr, payload)) {
> +        error_report("Failed to write response msg.");
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}
> +
>  static void close_slave_channel(struct vhost_user *u)
>  {
>      g_source_destroy(u->slave_src);
> @@ -1639,6 +1727,17 @@ static gboolean slave_read(QIOChannel *ioc, GIOCondition condition,
>          ret = vhost_user_slave_handle_vring_host_notifier(dev, &payload.area,
>                                                            fd ? fd[0] : -1);
>          break;
> +    case VHOST_USER_BACKEND_SHARED_OBJECT_ADD:
> +        ret = vhost_user_backend_handle_shared_object_add(&payload.object,
> +                                                          fd ? fd[0] : -1);
> +        break;
> +    case VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE:
> +        ret = vhost_user_backend_handle_shared_object_remove(&payload.object);
> +        break;
> +    case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
> +        ret = vhost_user_backend_handle_shared_object_lookup(dev->opaque, ioc,
> +                                                             &hdr, &payload);
> +        break;
>      default:
>          error_report("Received unexpected msg type: %d.", hdr.request);
>          ret = -EINVAL;
> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
> index 8fb61e2df2..672d8292a0 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -1403,6 +1403,107 @@ bool vu_set_queue_host_notifier(VuDev *dev, VuVirtq *vq, int fd,
>      return vu_process_message_reply(dev, &vmsg);
>  }
>  
> +bool
> +vu_get_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN], int *dmabuf_fd)
> +{
> +    bool result = false;
> +    VhostUserMsg msg_reply;
> +    VhostUserMsg msg = {
> +        .request = VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP,
> +        .size = sizeof(msg.payload.object),
> +        .flags = VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MASK,
> +    };
> +
> +    memcpy(msg.payload.object.uuid, uuid, sizeof(uuid[0]) * UUID_LEN);
> +
> +    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SHARED_OBJECT)) {
> +        return false;
> +    }
> +
> +    pthread_mutex_lock(&dev->slave_mutex);
> +    if (!vu_message_write(dev, dev->slave_fd, &msg)) {
> +        goto out;
> +    }
> +
> +    if (!vu_message_read_default(dev, dev->slave_fd, &msg_reply)) {
> +        goto out;
> +    }
> +
> +    if (msg_reply.request != msg.request) {
> +        DPRINT("Received unexpected msg type. Expected %d, received %d",
> +               msg.request, msg_reply.request);
> +        goto out;
> +    }
> +
> +    if (msg_reply.fd_num != 1) {
> +        DPRINT("Received unexpected number of fds. Expected 1, received %d",
> +               msg_reply.fd_num);
> +        goto out;
> +    }
> +
> +    *dmabuf_fd = msg_reply.fds[0];
> +    result = *dmabuf_fd > 0 && msg_reply.payload.u64 == 0;
> +out:
> +    pthread_mutex_unlock(&dev->slave_mutex);
> +
> +    return result;
> +}
> +
> +static bool
> +vu_send_message(VuDev *dev, VhostUserMsg *vmsg)
> +{
> +    bool result = false;
> +    pthread_mutex_lock(&dev->slave_mutex);
> +    if (!vu_message_write(dev, dev->slave_fd, vmsg)) {
> +        goto out;
> +    }
> +
> +    result = true;
> +out:
> +    pthread_mutex_unlock(&dev->slave_mutex);
> +
> +    return result;
> +}
> +
> +bool
> +vu_add_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN], int dmabuf_fd)
> +{
> +    int fd_num = 0;
> +    VhostUserMsg msg = {
> +        .request = VHOST_USER_BACKEND_SHARED_OBJECT_ADD,
> +        .size = sizeof(msg.payload.object),
> +        .flags = VHOST_USER_VERSION,
> +    };
> +
> +    msg.fds[fd_num++] = dmabuf_fd;
> +    msg.fd_num = fd_num;
> +    memcpy(msg.payload.object.uuid, uuid, sizeof(uuid[0]) * UUID_LEN);
> +
> +    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SHARED_OBJECT)) {
> +        return false;
> +    }
> +
> +    return vu_send_message(dev, &msg);
> +}
> +
> +bool
> +vu_rm_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN])
> +{
> +    VhostUserMsg msg = {
> +        .request = VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE,
> +        .size = sizeof(msg.payload.object),
> +        .flags = VHOST_USER_VERSION,
> +    };
> +
> +    memcpy(msg.payload.object.uuid, uuid, sizeof(uuid[0]) * UUID_LEN);
> +
> +    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SHARED_OBJECT)) {
> +        return false;
> +    }
> +
> +    return vu_send_message(dev, &msg);
> +}
> +
>  static bool
>  vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
>  {
> diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
> index 49208cceaa..907af1bcda 100644
> --- a/subprojects/libvhost-user/libvhost-user.h
> +++ b/subprojects/libvhost-user/libvhost-user.h
> @@ -64,7 +64,8 @@ enum VhostUserProtocolFeature {
>      VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD = 12,
>      VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS = 14,
>      VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
> -
> +    /* Feature 16 is reserved for VHOST_USER_PROTOCOL_F_STATUS. */
> +    VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 17,
>      VHOST_USER_PROTOCOL_F_MAX
>  };
>  
> @@ -119,6 +120,9 @@ typedef enum VhostUserSlaveRequest {
>      VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG = 3,
>      VHOST_USER_BACKEND_VRING_CALL = 4,
>      VHOST_USER_BACKEND_VRING_ERR = 5,
> +    VHOST_USER_BACKEND_SHARED_OBJECT_ADD = 6,
> +    VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE = 7,
> +    VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP = 8,
>      VHOST_USER_BACKEND_MAX
>  }  VhostUserSlaveRequest;
>  
> @@ -172,6 +176,12 @@ typedef struct VhostUserInflight {
>      uint16_t queue_size;
>  } VhostUserInflight;
>  
> +#define UUID_LEN 16
> +
> +typedef struct VhostUserShared {
> +    unsigned char uuid[UUID_LEN];
> +} VhostUserShared;
> +
>  #if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
>  # define VU_PACKED __attribute__((gcc_struct, packed))
>  #else
> @@ -199,6 +209,7 @@ typedef struct VhostUserMsg {
>          VhostUserConfig config;
>          VhostUserVringArea area;
>          VhostUserInflight inflight;
> +        VhostUserShared object;
>      } payload;
>  
>      int fds[VHOST_MEMORY_BASELINE_NREGIONS];
> @@ -539,6 +550,46 @@ void vu_set_queue_handler(VuDev *dev, VuVirtq *vq,
>  bool vu_set_queue_host_notifier(VuDev *dev, VuVirtq *vq, int fd,
>                                  int size, int offset);
>  
> +/**
> + * vu_get_shared_object:
> + * @dev: a VuDev context
> + * @uuid: UUID of the shared object
> + * @dmabuf_fd: output dma-buf file descriptor
> + *
> + * Lookup for a virtio shared object (i.e., dma-buf fd) associated with the
> + * received UUID. Result, if found, is stored in the dmabuf_fd argument.
> + *
> + * Returns: whether the virtio object was found.
> + */
> +bool vu_get_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN],
> +                          int *dmabuf_fd);
> +
> +/**
> + * vu_add_shared_object:
> + * @dev: a VuDev context
> + * @uuid: UUID of the shared object
> + * @dmabuf_fd: output dma-buf file descriptor
> + *
> + * Stores a new shared object (i.e., dma-buf fd) in the hash table, and
> + * associates it with the received UUID.
> + *
> + * Returns: TRUE on success, FALSE on failure.
> + */
> +bool vu_add_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN],
> +                          int dmabuf_fd);
> +
> +/**
> + * vu_rm_shared_object:
> + * @dev: a VuDev context
> + * @uuid: UUID of the shared object
> + *
> + * Removes a shared object (i.e., dma-buf fd) associated with the
> + * received UUID from the hash table.
> + *
> + * Returns: TRUE on success, FALSE on failure.
> + */
> +bool vu_rm_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN]);
> +
>  /**
>   * vu_queue_set_notification:
>   * @dev: a VuDev context
> -- 
> 2.40.0


