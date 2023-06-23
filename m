Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E908973B27F
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 10:16:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCbwB-0007Zu-8k; Fri, 23 Jun 2023 04:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCbw8-0007ZN-SW
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 04:14:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCbw6-0001Rz-FP
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 04:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687508069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FqF7n/FdQK4cC6yn4h6yEYIGVNgVzcsNLWL7wPPzGF4=;
 b=Y2rXlqVo6Qghvraa5rakpekfptqU4Te36oC7EaBKKFbAhfC8PizILQOcSxqOmPQd1B/luA
 F1OdgNtuK6IIlPjj0P4HwVdepmqE3FEdRIzfrxdosR0LDiP1jxw29BrMs9XknMtTr99dWq
 yYam+NbctJXB+PGweDJvHOMuTGefbjY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-p2eDAFLMNbShpRDyc-yofA-1; Fri, 23 Jun 2023 04:14:27 -0400
X-MC-Unique: p2eDAFLMNbShpRDyc-yofA-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-51a45552177so235413a12.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 01:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687508066; x=1690100066;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FqF7n/FdQK4cC6yn4h6yEYIGVNgVzcsNLWL7wPPzGF4=;
 b=f6vJB01UCxOCFkbnGq440LV/nGhZyYNIiQ4zbe+OT+kfLvXVGiPrLgw6fwMyy9crHB
 F7C5R00oP6kHOW+h0GKjqtEbVmnS+z5VG61/ZU5RdMdwHXWwPh/aFg3aLaNrwWehXP3q
 jmpxwGsZTQ9StyU7T/N1HArusMVVsNkSEKidzXMwiEXVJhxJeiKPLjiBhzGBPCeZ+9R8
 vNdBVcLAvx8crHEsCFaGUITK8nsM5hrMo5XsvP6iQbIRdojEwYAPzHe0g602Ipuvqx+A
 43pXvBmV5XTxhvDXm09C0dKfUh8re4ou3RWT60KnsPmad489k2aUf0qs/raUaReSH4X6
 7FRg==
X-Gm-Message-State: AC+VfDzoq689U8KxuIzp1hphYQOrAW2HPXVMBOcMTP0ouWMVjck6ZyGr
 TvgCL0+WkruJnE0B3vOC5NE2x/dpFoJl9rhJjc3SUqtSf6yrD/T3IAhuhrgf+wXsCtw6MyT9lOQ
 Oqc5rdDwiI3WV6FZzD+3HxQM=
X-Received: by 2002:aa7:d7d4:0:b0:518:92ad:bb04 with SMTP id
 e20-20020aa7d7d4000000b0051892adbb04mr14695432eds.14.1687508065981; 
 Fri, 23 Jun 2023 01:14:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5amuwTY988QskRdXLncsz/AFSYIDM/fCnWuejNDSRSrR79UK8c/oHcDiNmhMqEqf58vS+KLg==
X-Received: by 2002:aa7:d7d4:0:b0:518:92ad:bb04 with SMTP id
 e20-20020aa7d7d4000000b0051892adbb04mr14695414eds.14.1687508065553; 
 Fri, 23 Jun 2023 01:14:25 -0700 (PDT)
Received: from redhat.com ([176.12.150.14]) by smtp.gmail.com with ESMTPSA id
 be9-20020a0564021a2900b0051a318c0120sm4932738edb.28.2023.06.23.01.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 01:14:24 -0700 (PDT)
Date: Fri, 23 Jun 2023 04:14:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, marcandre.lureau@gmail.com,
 cohuck@redhat.com, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH v3 3/4] vhost-user: add shared_object msg
Message-ID: <20230623040655-mutt-send-email-mst@kernel.org>
References: <20230524091333.201767-1-aesteve@redhat.com>
 <20230524091333.201767-4-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524091333.201767-4-aesteve@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 24, 2023 at 11:13:32AM +0200, Albert Esteve wrote:
> Add new vhost-user protocol message
> `VHOST_USER_BACKEND_SHARED_OBJECT`. This new
> message is sent from vhost-user back-ends
> to interact with the virtio-dmabuf table
> in order to add, remove, or lookup for
> virtio dma-buf shared objects.
> 
> The action taken in the front-end depends
> on the type stored in the payload struct.
> 
> In the libvhost-user library add helper
> functions to allow sending messages to
> interact with the virtio shared objects
> hash table.
> 
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  docs/interop/vhost-user.rst               | 15 ++++
>  hw/virtio/vhost-user.c                    | 68 ++++++++++++++++++
>  subprojects/libvhost-user/libvhost-user.c | 88 +++++++++++++++++++++++
>  subprojects/libvhost-user/libvhost-user.h | 56 +++++++++++++++
>  4 files changed, 227 insertions(+)
> 
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 5a070adbc1..d3d8db41e5 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -1528,6 +1528,21 @@ is sent by the front-end.
>  
>    The state.num field is currently reserved and must be set to 0.
>  
> +``VHOST_USER_BACKEND_SHARED_OBJECT``
> +  :id: 6
> +  :equivalent ioctl: N/A
> +  :request payload: ``struct VhostUserShared``
> +  :reply payload: ``struct VhostUserShared`` (only for ``LOOKUP`` requests)
> +
> +  Backends that need to interact with the virtio-dmabuf shared table API
> +  can send this message. The operation is determined by the ``type`` member
> +  of the payload struct. The valid values for the operation type are
> +  ``VHOST_SHARED_OBJECT_*`` members, i.e., ``ADD``, ``LOOKUP``, and ``REMOVE``.
> +  ``LOOKUP`` operations require the ``VHOST_USER_NEED_REPLY_MASK`` flag to be
> +  set by the back-end, and the front-end will then send the dma-buf fd as
> +  a response if the UUID matches an object in the table, or a negative value
> +  otherwise.
> +
>  .. _reply_ack:

If you are reusing same message then I would maybe just make all types
the same - if there's a reply bit backend can reply back with the same
message - might be good for debugging etc.

Also it's not detailed here but I am guessing LOOKUP at least
does not send an fd and gets an fd back? Maybe LOOKUP
at least actually should be a separate message.


>  VHOST_USER_PROTOCOL_F_REPLY_ACK
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 74a2a28663..5ac5f0eafd 100644
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
> @@ -128,6 +130,7 @@ typedef enum VhostUserSlaveRequest {
>      VHOST_USER_BACKEND_IOTLB_MSG = 1,
>      VHOST_USER_BACKEND_CONFIG_CHANGE_MSG = 2,
>      VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG = 3,
> +    VHOST_USER_BACKEND_SHARED_OBJECT = 6,
>      VHOST_USER_BACKEND_MAX
>  }  VhostUserSlaveRequest;
>  
> @@ -190,6 +193,18 @@ typedef struct VhostUserInflight {
>      uint16_t queue_size;
>  } VhostUserInflight;
>  
> +typedef enum VhostUserSharedType {
> +    VHOST_SHARED_OBJECT_ADD = 0,
> +    VHOST_SHARED_OBJECT_LOOKUP,
> +    VHOST_SHARED_OBJECT_REMOVE,
> +} VhostUserSharedType;
> +
> +typedef struct VhostUserShared {
> +    unsigned char uuid[16];
> +    VhostUserSharedType type;
> +    int dmabuf_fd;
> +} VhostUserShared;

BTW all fields in structs that go on the wire should be fixed size.

> +
>  typedef struct {
>      VhostUserRequest request;
>  
> @@ -214,6 +229,7 @@ typedef union {
>          VhostUserCryptoSession session;
>          VhostUserVringArea area;
>          VhostUserInflight inflight;
> +        VhostUserShared object;
>  } VhostUserPayload;
>  
>  typedef struct VhostUserMsg {
> @@ -1582,6 +1598,52 @@ static int vhost_user_slave_handle_vring_host_notifier(struct vhost_dev *dev,
>      return 0;
>  }
>  
> +static int vhost_user_backend_handle_shared_object(VhostUserShared *object)
> +{
> +    QemuUUID uuid;
> +    memcpy(uuid.data, object->uuid, sizeof(object->uuid));
> +
> +    switch (object->type) {
> +    case VHOST_SHARED_OBJECT_ADD:
> +        return virtio_add_dmabuf(&uuid, object->dmabuf_fd);
> +    case VHOST_SHARED_OBJECT_LOOKUP:
> +        object->dmabuf_fd = virtio_lookup_dmabuf(&uuid);
> +        if (object->dmabuf_fd < 0) {
> +            return object->dmabuf_fd;
> +        }
> +        break;
> +    case VHOST_SHARED_OBJECT_REMOVE:
> +        return virtio_remove_resource(&uuid);
> +    }
> +
> +    return 0;
> +}
> +
> +static bool
> +vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHeader *hdr,
> +                                  VhostUserPayload *payload)
> +{
> +    Error *local_err = NULL;
> +    struct iovec iov[2];
> +    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> +        hdr->flags &= ~VHOST_USER_NEED_REPLY_MASK;
> +        hdr->flags |= VHOST_USER_REPLY_MASK;
> +
> +        hdr->size = sizeof(payload->object);
> +
> +        iov[0].iov_base = hdr;
> +        iov[0].iov_len = VHOST_USER_HDR_SIZE;
> +        iov[1].iov_base = payload;
> +        iov[1].iov_len = hdr->size;
> +
> +        if (qio_channel_writev_all(ioc, iov, ARRAY_SIZE(iov), &local_err)) {
> +            error_report_err(local_err);
> +            return false;
> +        }
> +    }
> +    return true;
> +}
> +
>  static void close_slave_channel(struct vhost_user *u)
>  {
>      g_source_destroy(u->slave_src);
> @@ -1639,6 +1701,12 @@ static gboolean slave_read(QIOChannel *ioc, GIOCondition condition,
>          ret = vhost_user_slave_handle_vring_host_notifier(dev, &payload.area,
>                                                            fd ? fd[0] : -1);
>          break;
> +    case VHOST_USER_BACKEND_SHARED_OBJECT:
> +        ret = vhost_user_backend_handle_shared_object(&payload.object);
> +        if (!vhost_user_backend_send_dmabuf_fd(ioc, &hdr, &payload)) {
> +            goto err;
> +        }
> +        break;
>      default:
>          error_report("Received unexpected msg type: %d.", hdr.request);
>          ret = -EINVAL;
> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
> index 8fb61e2df2..27f16d292a 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -1403,6 +1403,94 @@ bool vu_set_queue_host_notifier(VuDev *dev, VuVirtq *vq, int fd,
>      return vu_process_message_reply(dev, &vmsg);
>  }
>  
> +bool
> +vu_get_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN], int *dmabuf_fd)
> +{
> +    bool result = false;
> +    VhostUserMsg msg_reply;
> +    VhostUserMsg msg = {
> +        .request = VHOST_USER_BACKEND_SHARED_OBJECT,
> +        .size = sizeof(msg.payload.object),
> +        .flags = VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MASK,
> +        .payload.object = {
> +            .type = VHOST_SHARED_OBJECT_LOOKUP,
> +        },
> +    };
> +
> +    memcpy(msg.payload.object.uuid, uuid, sizeof(uuid[0]) * UUID_LEN);
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
> +    *dmabuf_fd = msg_reply.payload.object.dmabuf_fd;
> +    result = *dmabuf_fd > 0;
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
> +    VhostUserMsg msg = {
> +        .request = VHOST_USER_BACKEND_SHARED_OBJECT,
> +        .size = sizeof(msg.payload.object),
> +        .flags = VHOST_USER_VERSION,
> +        .payload.object = {
> +            .dmabuf_fd = dmabuf_fd,
> +            .type = VHOST_SHARED_OBJECT_ADD,
> +        },
> +    };
> +    memcpy(msg.payload.object.uuid, uuid, sizeof(uuid[0]) * UUID_LEN);
> +
> +    return vu_send_message(dev, &msg);
> +}
> +
> +bool
> +vu_rm_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN])
> +{
> +    VhostUserMsg msg = {
> +        .request = VHOST_USER_BACKEND_SHARED_OBJECT,
> +        .size = sizeof(msg.payload.object),
> +        .flags = VHOST_USER_VERSION,
> +        .payload.object = {
> +            .type = VHOST_SHARED_OBJECT_REMOVE,
> +        },
> +    };
> +    memcpy(msg.payload.object.uuid, uuid, sizeof(uuid[0]) * UUID_LEN);
> +
> +    return vu_send_message(dev, &msg);
> +}
> +
>  static bool
>  vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
>  {
> diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
> index 49208cceaa..a43d115bd7 100644
> --- a/subprojects/libvhost-user/libvhost-user.h
> +++ b/subprojects/libvhost-user/libvhost-user.h
> @@ -119,6 +119,7 @@ typedef enum VhostUserSlaveRequest {
>      VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG = 3,
>      VHOST_USER_BACKEND_VRING_CALL = 4,
>      VHOST_USER_BACKEND_VRING_ERR = 5,
> +    VHOST_USER_BACKEND_SHARED_OBJECT = 6,
>      VHOST_USER_BACKEND_MAX
>  }  VhostUserSlaveRequest;
>  
> @@ -172,6 +173,20 @@ typedef struct VhostUserInflight {
>      uint16_t queue_size;
>  } VhostUserInflight;
>  
> +typedef enum VhostUserSharedType {
> +    VHOST_SHARED_OBJECT_ADD = 0,
> +    VHOST_SHARED_OBJECT_LOOKUP,
> +    VHOST_SHARED_OBJECT_REMOVE,
> +} VhostUserSharedType;
> +
> +#define UUID_LEN 16
> +
> +typedef struct VhostUserShared {
> +    unsigned char uuid[UUID_LEN];
> +    VhostUserSharedType type;
> +    int dmabuf_fd;
> +} VhostUserShared;
> +
>  #if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
>  # define VU_PACKED __attribute__((gcc_struct, packed))
>  #else
> @@ -199,6 +214,7 @@ typedef struct VhostUserMsg {
>          VhostUserConfig config;
>          VhostUserVringArea area;
>          VhostUserInflight inflight;
> +        VhostUserShared object;
>      } payload;
>  
>      int fds[VHOST_MEMORY_BASELINE_NREGIONS];
> @@ -539,6 +555,46 @@ void vu_set_queue_handler(VuDev *dev, VuVirtq *vq,
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


