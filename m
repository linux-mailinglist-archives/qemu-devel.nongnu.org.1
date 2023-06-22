Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAFD73A969
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 22:19:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCQlp-0008P4-DL; Thu, 22 Jun 2023 16:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qCQlj-0008Ob-5G
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 16:19:03 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qCQlc-0001p9-Ns
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 16:19:00 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4f954d7309fso1329808e87.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 13:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687465133; x=1690057133;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oCTMSW6xjjcP4DWhetOpBrc4XXOPjxDHF4dZ2HQwM3I=;
 b=eSSYbngq399RFJyYcqGpe8xMra+JYc6mZfDNguy9l+4yiM86u/2M8KZRf5YzXaZUkF
 h+48zXCVZQuZB61dWuOUEdx2uvqLz6LoYCsaUBSigI4msQULkD3UVVK5QL8c7Ipyk6SL
 7qnYhaMu1uYjUlUg+KX/Fl60YbmKjVLCAlhCxWwVa0Ov5XhiBPOVBDtbyvGPJSzmxePn
 OvoajwY8tDxgKOrEhSF0KpxzqBgipe1ROfgtcVfwIFXsX0MLHSVdXQJ92ntpkVKu4Tre
 daQV8RIX2VpGse/Rs4Dqq9EB1AqWy2onkzrlEDeKHBTRCw/WOxnvhuakMubAihmlCcSV
 Ns5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687465133; x=1690057133;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oCTMSW6xjjcP4DWhetOpBrc4XXOPjxDHF4dZ2HQwM3I=;
 b=Iuia23zQuOekY+Naqoqwf1aZt0X/DLNFbJcpQ+KxMLe9brOC5y9Uwlf803FPAS2zL0
 /h8npq9k//4StJXCVY4a0UoUHTepg1P3/UFqOnyjUN6A9m9X2+v+BUHtbfiyp0qkA0D/
 modji7Zv3RIplinTi23ivG5c2/CiG5YfWmjYpUonK7h/Bag34c2D5i0bpzyuKKqvUpUk
 GVC8hY4bD4L0LZBSEKp2ZzVhQVNJnGgAdIhJOFqW7CW8H8W5RS5XZyWN+86b2p04/yh7
 +suUJryuZrefcIffHXZpEL0P7Lyaa9jjZ3TKtMZ1hV69bO7lHeBNRGNFy/lVm2aBB23B
 nUZw==
X-Gm-Message-State: AC+VfDzisqq10o907r8SvI0q5lTnfbKImv9N1CdcKwaA3KF8xoYWaB5I
 Mdnelya3oUB2C9gaQ1F1iN3q8wW5olqBlB3T2w0=
X-Google-Smtp-Source: ACHHUZ7INF3UMT6u4UYUw+As2dFKgYxN5Ljx55I1HrhxlnAqU+6Y8WautKGuTb8FD8XJW4GmfJPAW3OZAaBerUtIO1s=
X-Received: by 2002:a19:650c:0:b0:4f8:6ac4:1aa9 with SMTP id
 z12-20020a19650c000000b004f86ac41aa9mr5151474lfb.21.1687465132961; Thu, 22
 Jun 2023 13:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230524091333.201767-1-aesteve@redhat.com>
 <20230524091333.201767-4-aesteve@redhat.com>
In-Reply-To: <20230524091333.201767-4-aesteve@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 22 Jun 2023 22:18:41 +0200
Message-ID: <CAJ+F1CJ1O+s3q3+C_4_Q6LhbKbO+=K=-EbUb=SiSFywc1U-VLQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] vhost-user: add shared_object msg
To: Albert Esteve <aesteve@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, cohuck@redhat.com, 
 Fam Zheng <fam@euphon.net>
Content-Type: multipart/alternative; boundary="000000000000d2386a05febd97d7"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000d2386a05febd97d7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, May 24, 2023 at 11:13=E2=80=AFAM Albert Esteve <aesteve@redhat.com>=
 wrote:

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
> +  :reply payload: ``struct VhostUserShared`` (only for ``LOOKUP``
> requests)
>

only for LOOKUP, ahah...


> +
> +  Backends that need to interact with the virtio-dmabuf shared table API
> +  can send this message. The operation is determined by the ``type``
> member
> +  of the payload struct. The valid values for the operation type are
> +  ``VHOST_SHARED_OBJECT_*`` members, i.e., ``ADD``, ``LOOKUP``, and
> ``REMOVE``.
>

...why not use specific messages instead of this extra "type"?


> +  ``LOOKUP`` operations require the ``VHOST_USER_NEED_REPLY_MASK`` flag
> to be
> +  set by the back-end, and the front-end will then send the dma-buf fd a=
s
> +  a response if the UUID matches an object in the table, or a negative
> value
> +  otherwise.
>

This new message(s) should be initially negotiated with a protocol feature
flag.


> +
>  .. _reply_ack:
>
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
>      VHOST_USER_BACKEND_IOTLB_MSG =3D 1,
>      VHOST_USER_BACKEND_CONFIG_CHANGE_MSG =3D 2,
>      VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG =3D 3,
> +    VHOST_USER_BACKEND_SHARED_OBJECT =3D 6,
>      VHOST_USER_BACKEND_MAX
>  }  VhostUserSlaveRequest;
>
> @@ -190,6 +193,18 @@ typedef struct VhostUserInflight {
>      uint16_t queue_size;
>  } VhostUserInflight;
>
> +typedef enum VhostUserSharedType {
> +    VHOST_SHARED_OBJECT_ADD =3D 0,
> +    VHOST_SHARED_OBJECT_LOOKUP,
> +    VHOST_SHARED_OBJECT_REMOVE,
> +} VhostUserSharedType;
> +
> +typedef struct VhostUserShared {
> +    unsigned char uuid[16];
> +    VhostUserSharedType type;
> +    int dmabuf_fd;
> +} VhostUserShared;
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
> @@ -1582,6 +1598,52 @@ static int
> vhost_user_slave_handle_vring_host_notifier(struct vhost_dev *dev,
>      return 0;
>  }
>
> +static int vhost_user_backend_handle_shared_object(VhostUserShared
> *object)
> +{
> +    QemuUUID uuid;
> +    memcpy(uuid.data, object->uuid, sizeof(object->uuid));
> +
> +    switch (object->type) {
> +    case VHOST_SHARED_OBJECT_ADD:
> +        return virtio_add_dmabuf(&uuid, object->dmabuf_fd);
> +    case VHOST_SHARED_OBJECT_LOOKUP:
> +        object->dmabuf_fd =3D virtio_lookup_dmabuf(&uuid);
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
> +    Error *local_err =3D NULL;
> +    struct iovec iov[2];
> +    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> +        hdr->flags &=3D ~VHOST_USER_NEED_REPLY_MASK;
> +        hdr->flags |=3D VHOST_USER_REPLY_MASK;
> +
> +        hdr->size =3D sizeof(payload->object);
> +
> +        iov[0].iov_base =3D hdr;
> +        iov[0].iov_len =3D VHOST_USER_HDR_SIZE;
> +        iov[1].iov_base =3D payload;
> +        iov[1].iov_len =3D hdr->size;
> +
> +        if (qio_channel_writev_all(ioc, iov, ARRAY_SIZE(iov),
> &local_err)) {
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
> @@ -1639,6 +1701,12 @@ static gboolean slave_read(QIOChannel *ioc,
> GIOCondition condition,
>          ret =3D vhost_user_slave_handle_vring_host_notifier(dev,
> &payload.area,
>                                                            fd ? fd[0] :
> -1);
>          break;
> +    case VHOST_USER_BACKEND_SHARED_OBJECT:
> +        ret =3D vhost_user_backend_handle_shared_object(&payload.object)=
;
> +        if (!vhost_user_backend_send_dmabuf_fd(ioc, &hdr, &payload)) {
> +            goto err;
> +        }
> +        break;
>      default:
>          error_report("Received unexpected msg type: %d.", hdr.request);
>          ret =3D -EINVAL;
> diff --git a/subprojects/libvhost-user/libvhost-user.c
> b/subprojects/libvhost-user/libvhost-user.c
> index 8fb61e2df2..27f16d292a 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -1403,6 +1403,94 @@ bool vu_set_queue_host_notifier(VuDev *dev, VuVirt=
q
> *vq, int fd,
>      return vu_process_message_reply(dev, &vmsg);
>  }
>
> +bool
> +vu_get_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN], int
> *dmabuf_fd)
> +{
> +    bool result =3D false;
> +    VhostUserMsg msg_reply;
> +    VhostUserMsg msg =3D {
> +        .request =3D VHOST_USER_BACKEND_SHARED_OBJECT,
> +        .size =3D sizeof(msg.payload.object),
> +        .flags =3D VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MASK,
> +        .payload.object =3D {
> +            .type =3D VHOST_SHARED_OBJECT_LOOKUP,
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
> +    if (msg_reply.request !=3D msg.request) {
> +        DPRINT("Received unexpected msg type. Expected %d, received %d",
> +               msg.request, msg_reply.request);
> +        goto out;
> +    }
> +
> +    *dmabuf_fd =3D msg_reply.payload.object.dmabuf_fd;
> +    result =3D *dmabuf_fd > 0;
> +out:
> +    pthread_mutex_unlock(&dev->slave_mutex);
> +
> +    return result;
> +}
> +
> +static bool
> +vu_send_message(VuDev *dev, VhostUserMsg *vmsg)
> +{
> +    bool result =3D false;
> +    pthread_mutex_lock(&dev->slave_mutex);
> +    if (!vu_message_write(dev, dev->slave_fd, vmsg)) {
> +        goto out;
> +    }
> +
> +    result =3D true;
> +out:
> +    pthread_mutex_unlock(&dev->slave_mutex);
> +
> +    return result;
> +}
> +
> +bool
> +vu_add_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN], int
> dmabuf_fd)
> +{
> +    VhostUserMsg msg =3D {
> +        .request =3D VHOST_USER_BACKEND_SHARED_OBJECT,
> +        .size =3D sizeof(msg.payload.object),
> +        .flags =3D VHOST_USER_VERSION,
> +        .payload.object =3D {
> +            .dmabuf_fd =3D dmabuf_fd,
> +            .type =3D VHOST_SHARED_OBJECT_ADD,
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
> +    VhostUserMsg msg =3D {
> +        .request =3D VHOST_USER_BACKEND_SHARED_OBJECT,
> +        .size =3D sizeof(msg.payload.object),
> +        .flags =3D VHOST_USER_VERSION,
> +        .payload.object =3D {
> +            .type =3D VHOST_SHARED_OBJECT_REMOVE,
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
> diff --git a/subprojects/libvhost-user/libvhost-user.h
> b/subprojects/libvhost-user/libvhost-user.h
> index 49208cceaa..a43d115bd7 100644
> --- a/subprojects/libvhost-user/libvhost-user.h
> +++ b/subprojects/libvhost-user/libvhost-user.h
> @@ -119,6 +119,7 @@ typedef enum VhostUserSlaveRequest {
>      VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG =3D 3,
>      VHOST_USER_BACKEND_VRING_CALL =3D 4,
>      VHOST_USER_BACKEND_VRING_ERR =3D 5,
> +    VHOST_USER_BACKEND_SHARED_OBJECT =3D 6,
>      VHOST_USER_BACKEND_MAX
>  }  VhostUserSlaveRequest;
>
> @@ -172,6 +173,20 @@ typedef struct VhostUserInflight {
>      uint16_t queue_size;
>  } VhostUserInflight;
>
> +typedef enum VhostUserSharedType {
> +    VHOST_SHARED_OBJECT_ADD =3D 0,
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
> + * Lookup for a virtio shared object (i.e., dma-buf fd) associated with
> the
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
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000d2386a05febd97d7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 24, 2023 at 11:13=E2=80=
=AFAM Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com">aesteve@redha=
t.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">Add new vhost-user protocol message<br>
`VHOST_USER_BACKEND_SHARED_OBJECT`. This new<br>
message is sent from vhost-user back-ends<br>
to interact with the virtio-dmabuf table<br>
in order to add, remove, or lookup for<br>
virtio dma-buf shared objects.<br>
<br>
The action taken in the front-end depends<br>
on the type stored in the payload struct.<br>
<br>
In the libvhost-user library add helper<br>
functions to allow sending messages to<br>
interact with the virtio shared objects<br>
hash table.<br>
<br>
Signed-off-by: Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com" targ=
et=3D"_blank">aesteve@redhat.com</a>&gt;<br>
---<br>
=C2=A0docs/interop/vhost-user.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 15 ++++<br>
=C2=A0hw/virtio/vhost-user.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 68 ++++++++++++++++++<br>
=C2=A0subprojects/libvhost-user/libvhost-user.c | 88 ++++++++++++++++++++++=
+<br>
=C2=A0subprojects/libvhost-user/libvhost-user.h | 56 +++++++++++++++<br>
=C2=A04 files changed, 227 insertions(+)<br>
<br>
diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst<br>
index 5a070adbc1..d3d8db41e5 100644<br>
--- a/docs/interop/vhost-user.rst<br>
+++ b/docs/interop/vhost-user.rst<br>
@@ -1528,6 +1528,21 @@ is sent by the front-end.<br>
<br>
=C2=A0 =C2=A0The state.num field is currently reserved and must be set to 0=
.<br>
<br>
+``VHOST_USER_BACKEND_SHARED_OBJECT``<br>
+=C2=A0 :id: 6<br>
+=C2=A0 :equivalent ioctl: N/A<br>
+=C2=A0 :request payload: ``struct VhostUserShared``<br>
+=C2=A0 :reply payload: ``struct VhostUserShared`` (only for ``LOOKUP`` req=
uests)<br></blockquote><div><br></div><div>only for LOOKUP, ahah...<br></di=
v><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 Backends that need to interact with the virtio-dmabuf shared table =
API<br>
+=C2=A0 can send this message. The operation is determined by the ``type`` =
member<br>
+=C2=A0 of the payload struct. The valid values for the operation type are<=
br>
+=C2=A0 ``VHOST_SHARED_OBJECT_*`` members, i.e., ``ADD``, ``LOOKUP``, and `=
`REMOVE``.<br></blockquote><div><br></div><div>...why not use specific mess=
ages instead of this extra &quot;type&quot;? <br></div><div>=C2=A0<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 ``LOOKUP`` operations require the ``VHOST_USER_NEED_REPLY_MASK`` fl=
ag to be<br>
+=C2=A0 set by the back-end, and the front-end will then send the dma-buf f=
d as<br>
+=C2=A0 a response if the UUID matches an object in the table, or a negativ=
e value<br>
+=C2=A0 otherwise.<br></blockquote><div><br></div><div>This new message(s) =
should be initially negotiated with a protocol feature flag.</div><div>=C2=
=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
=C2=A0.. _reply_ack:<br>
<br>
=C2=A0VHOST_USER_PROTOCOL_F_REPLY_ACK<br>
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c<br>
index 74a2a28663..5ac5f0eafd 100644<br>
--- a/hw/virtio/vhost-user.c<br>
+++ b/hw/virtio/vhost-user.c<br>
@@ -10,6 +10,7 @@<br>
<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
+#include &quot;hw/virtio/virtio-dmabuf.h&quot;<br>
=C2=A0#include &quot;hw/virtio/vhost.h&quot;<br>
=C2=A0#include &quot;hw/virtio/vhost-user.h&quot;<br>
=C2=A0#include &quot;hw/virtio/vhost-backend.h&quot;<br>
@@ -20,6 +21,7 @@<br>
=C2=A0#include &quot;sysemu/kvm.h&quot;<br>
=C2=A0#include &quot;qemu/error-report.h&quot;<br>
=C2=A0#include &quot;qemu/main-loop.h&quot;<br>
+#include &quot;qemu/uuid.h&quot;<br>
=C2=A0#include &quot;qemu/sockets.h&quot;<br>
=C2=A0#include &quot;sysemu/runstate.h&quot;<br>
=C2=A0#include &quot;sysemu/cryptodev.h&quot;<br>
@@ -128,6 +130,7 @@ typedef enum VhostUserSlaveRequest {<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_BACKEND_IOTLB_MSG =3D 1,<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_BACKEND_CONFIG_CHANGE_MSG =3D 2,<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG =3D 3,<br>
+=C2=A0 =C2=A0 VHOST_USER_BACKEND_SHARED_OBJECT =3D 6,<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_BACKEND_MAX<br>
=C2=A0}=C2=A0 VhostUserSlaveRequest;<br>
<br>
@@ -190,6 +193,18 @@ typedef struct VhostUserInflight {<br>
=C2=A0 =C2=A0 =C2=A0uint16_t queue_size;<br>
=C2=A0} VhostUserInflight;<br>
<br>
+typedef enum VhostUserSharedType {<br>
+=C2=A0 =C2=A0 VHOST_SHARED_OBJECT_ADD =3D 0,<br>
+=C2=A0 =C2=A0 VHOST_SHARED_OBJECT_LOOKUP,<br>
+=C2=A0 =C2=A0 VHOST_SHARED_OBJECT_REMOVE,<br>
+} VhostUserSharedType;<br>
+<br>
+typedef struct VhostUserShared {<br>
+=C2=A0 =C2=A0 unsigned char uuid[16];<br>
+=C2=A0 =C2=A0 VhostUserSharedType type;<br>
+=C2=A0 =C2=A0 int dmabuf_fd;<br>
+} VhostUserShared;<br>
+<br>
=C2=A0typedef struct {<br>
=C2=A0 =C2=A0 =C2=A0VhostUserRequest request;<br>
<br>
@@ -214,6 +229,7 @@ typedef union {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VhostUserCryptoSession session;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VhostUserVringArea area;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VhostUserInflight inflight;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserShared object;<br>
=C2=A0} VhostUserPayload;<br>
<br>
=C2=A0typedef struct VhostUserMsg {<br>
@@ -1582,6 +1598,52 @@ static int vhost_user_slave_handle_vring_host_notifi=
er(struct vhost_dev *dev,<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
+static int vhost_user_backend_handle_shared_object(VhostUserShared *object=
)<br>
+{<br>
+=C2=A0 =C2=A0 QemuUUID uuid;<br>
+=C2=A0 =C2=A0 memcpy(uuid.data, object-&gt;uuid, sizeof(object-&gt;uuid));=
<br>
+<br>
+=C2=A0 =C2=A0 switch (object-&gt;type) {<br>
+=C2=A0 =C2=A0 case VHOST_SHARED_OBJECT_ADD:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return virtio_add_dmabuf(&amp;uuid, object-&gt=
;dmabuf_fd);<br>
+=C2=A0 =C2=A0 case VHOST_SHARED_OBJECT_LOOKUP:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 object-&gt;dmabuf_fd =3D virtio_lookup_dmabuf(=
&amp;uuid);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (object-&gt;dmabuf_fd &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return object-&gt;dmabuf_fd;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case VHOST_SHARED_OBJECT_REMOVE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return virtio_remove_resource(&amp;uuid);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+static bool<br>
+vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHeader *hdr,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserPayload *payload)<br=
>
+{<br>
+=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
+=C2=A0 =C2=A0 struct iovec iov[2];<br>
+=C2=A0 =C2=A0 if (hdr-&gt;flags &amp; VHOST_USER_NEED_REPLY_MASK) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hdr-&gt;flags &amp;=3D ~VHOST_USER_NEED_REPLY_=
MASK;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hdr-&gt;flags |=3D VHOST_USER_REPLY_MASK;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hdr-&gt;size =3D sizeof(payload-&gt;object);<b=
r>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 iov[0].iov_base =3D hdr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 iov[0].iov_len =3D VHOST_USER_HDR_SIZE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 iov[1].iov_base =3D payload;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 iov[1].iov_len =3D hdr-&gt;size;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qio_channel_writev_all(ioc, iov, ARRAY_SIZ=
E(iov), &amp;local_err)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
=C2=A0static void close_slave_channel(struct vhost_user *u)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0g_source_destroy(u-&gt;slave_src);<br>
@@ -1639,6 +1701,12 @@ static gboolean slave_read(QIOChannel *ioc, GIOCondi=
tion condition,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D vhost_user_slave_handle_vring_hos=
t_notifier(dev, &amp;payload.area,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fd ? fd[0] : =
-1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 case VHOST_USER_BACKEND_SHARED_OBJECT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vhost_user_backend_handle_shared_objec=
t(&amp;payload.object);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!vhost_user_backend_send_dmabuf_fd(ioc, &a=
mp;hdr, &amp;payload)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;Received unexpected ms=
g type: %d.&quot;, hdr.request);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -EINVAL;<br>
diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvho=
st-user/libvhost-user.c<br>
index 8fb61e2df2..27f16d292a 100644<br>
--- a/subprojects/libvhost-user/libvhost-user.c<br>
+++ b/subprojects/libvhost-user/libvhost-user.c<br>
@@ -1403,6 +1403,94 @@ bool vu_set_queue_host_notifier(VuDev *dev, VuVirtq =
*vq, int fd,<br>
=C2=A0 =C2=A0 =C2=A0return vu_process_message_reply(dev, &amp;vmsg);<br>
=C2=A0}<br>
<br>
+bool<br>
+vu_get_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN], int *dmabuf=
_fd)<br>
+{<br>
+=C2=A0 =C2=A0 bool result =3D false;<br>
+=C2=A0 =C2=A0 VhostUserMsg msg_reply;<br>
+=C2=A0 =C2=A0 VhostUserMsg msg =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .request =3D VHOST_USER_BACKEND_SHARED_OBJECT,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .size =3D sizeof(msg.payload.object),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =3D VHOST_USER_VERSION | VHOST_USER_NEE=
D_REPLY_MASK,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .payload.object =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D VHOST_SHARED_OBJECT_LO=
OKUP,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 };<br>
+<br>
+=C2=A0 =C2=A0 memcpy(msg.payload.object.uuid, uuid, sizeof(uuid[0]) * UUID=
_LEN);<br>
+<br>
+=C2=A0 =C2=A0 pthread_mutex_lock(&amp;dev-&gt;slave_mutex);<br>
+=C2=A0 =C2=A0 if (!vu_message_write(dev, dev-&gt;slave_fd, &amp;msg)) {<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (!vu_message_read_default(dev, dev-&gt;slave_fd, &amp;msg=
_reply)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (msg_reply.request !=3D msg.request) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINT(&quot;Received unexpected msg type. Exp=
ected %d, received %d&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg.request, msg_re=
ply.request);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 *dmabuf_fd =3D msg_reply.payload.object.dmabuf_fd;<br>
+=C2=A0 =C2=A0 result =3D *dmabuf_fd &gt; 0;<br>
+out:<br>
+=C2=A0 =C2=A0 pthread_mutex_unlock(&amp;dev-&gt;slave_mutex);<br>
+<br>
+=C2=A0 =C2=A0 return result;<br>
+}<br>
+<br>
+static bool<br>
+vu_send_message(VuDev *dev, VhostUserMsg *vmsg)<br>
+{<br>
+=C2=A0 =C2=A0 bool result =3D false;<br>
+=C2=A0 =C2=A0 pthread_mutex_lock(&amp;dev-&gt;slave_mutex);<br>
+=C2=A0 =C2=A0 if (!vu_message_write(dev, dev-&gt;slave_fd, vmsg)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 result =3D true;<br>
+out:<br>
+=C2=A0 =C2=A0 pthread_mutex_unlock(&amp;dev-&gt;slave_mutex);<br>
+<br>
+=C2=A0 =C2=A0 return result;<br>
+}<br>
+<br>
+bool<br>
+vu_add_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN], int dmabuf_=
fd)<br>
+{<br>
+=C2=A0 =C2=A0 VhostUserMsg msg =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .request =3D VHOST_USER_BACKEND_SHARED_OBJECT,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .size =3D sizeof(msg.payload.object),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =3D VHOST_USER_VERSION,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .payload.object =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .dmabuf_fd =3D dmabuf_fd,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D VHOST_SHARED_OBJECT_AD=
D,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 };<br>
+=C2=A0 =C2=A0 memcpy(msg.payload.object.uuid, uuid, sizeof(uuid[0]) * UUID=
_LEN);<br>
+<br>
+=C2=A0 =C2=A0 return vu_send_message(dev, &amp;msg);<br>
+}<br>
+<br>
+bool<br>
+vu_rm_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN])<br>
+{<br>
+=C2=A0 =C2=A0 VhostUserMsg msg =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .request =3D VHOST_USER_BACKEND_SHARED_OBJECT,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .size =3D sizeof(msg.payload.object),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =3D VHOST_USER_VERSION,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .payload.object =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D VHOST_SHARED_OBJECT_RE=
MOVE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 };<br>
+=C2=A0 =C2=A0 memcpy(msg.payload.object.uuid, uuid, sizeof(uuid[0]) * UUID=
_LEN);<br>
+<br>
+=C2=A0 =C2=A0 return vu_send_message(dev, &amp;msg);<br>
+}<br>
+<br>
=C2=A0static bool<br>
=C2=A0vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)<br>
=C2=A0{<br>
diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvho=
st-user/libvhost-user.h<br>
index 49208cceaa..a43d115bd7 100644<br>
--- a/subprojects/libvhost-user/libvhost-user.h<br>
+++ b/subprojects/libvhost-user/libvhost-user.h<br>
@@ -119,6 +119,7 @@ typedef enum VhostUserSlaveRequest {<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG =3D 3,<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_BACKEND_VRING_CALL =3D 4,<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_BACKEND_VRING_ERR =3D 5,<br>
+=C2=A0 =C2=A0 VHOST_USER_BACKEND_SHARED_OBJECT =3D 6,<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_BACKEND_MAX<br>
=C2=A0}=C2=A0 VhostUserSlaveRequest;<br>
<br>
@@ -172,6 +173,20 @@ typedef struct VhostUserInflight {<br>
=C2=A0 =C2=A0 =C2=A0uint16_t queue_size;<br>
=C2=A0} VhostUserInflight;<br>
<br>
+typedef enum VhostUserSharedType {<br>
+=C2=A0 =C2=A0 VHOST_SHARED_OBJECT_ADD =3D 0,<br>
+=C2=A0 =C2=A0 VHOST_SHARED_OBJECT_LOOKUP,<br>
+=C2=A0 =C2=A0 VHOST_SHARED_OBJECT_REMOVE,<br>
+} VhostUserSharedType;<br>
+<br>
+#define UUID_LEN 16<br>
+<br>
+typedef struct VhostUserShared {<br>
+=C2=A0 =C2=A0 unsigned char uuid[UUID_LEN];<br>
+=C2=A0 =C2=A0 VhostUserSharedType type;<br>
+=C2=A0 =C2=A0 int dmabuf_fd;<br>
+} VhostUserShared;<br>
+<br>
=C2=A0#if defined(_WIN32) &amp;&amp; (defined(__x86_64__) || defined(__i386=
__))<br>
=C2=A0# define VU_PACKED __attribute__((gcc_struct, packed))<br>
=C2=A0#else<br>
@@ -199,6 +214,7 @@ typedef struct VhostUserMsg {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VhostUserConfig config;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VhostUserVringArea area;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VhostUserInflight inflight;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserShared object;<br>
=C2=A0 =C2=A0 =C2=A0} payload;<br>
<br>
=C2=A0 =C2=A0 =C2=A0int fds[VHOST_MEMORY_BASELINE_NREGIONS];<br>
@@ -539,6 +555,46 @@ void vu_set_queue_handler(VuDev *dev, VuVirtq *vq,<br>
=C2=A0bool vu_set_queue_host_notifier(VuDev *dev, VuVirtq *vq, int fd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int size, int offset);<br>
<br>
+/**<br>
+ * vu_get_shared_object:<br>
+ * @dev: a VuDev context<br>
+ * @uuid: UUID of the shared object<br>
+ * @dmabuf_fd: output dma-buf file descriptor<br>
+ *<br>
+ * Lookup for a virtio shared object (i.e., dma-buf fd) associated with th=
e<br>
+ * received UUID. Result, if found, is stored in the dmabuf_fd argument.<b=
r>
+ *<br>
+ * Returns: whether the virtio object was found.<br>
+ */<br>
+bool vu_get_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 int *dmabuf_fd);<br>
+<br>
+/**<br>
+ * vu_add_shared_object:<br>
+ * @dev: a VuDev context<br>
+ * @uuid: UUID of the shared object<br>
+ * @dmabuf_fd: output dma-buf file descriptor<br>
+ *<br>
+ * Stores a new shared object (i.e., dma-buf fd) in the hash table, and <b=
r>
+ * associates it with the received UUID.<br>
+ *<br>
+ * Returns: TRUE on success, FALSE on failure.<br>
+ */<br>
+bool vu_add_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 int dmabuf_fd);<br>
+<br>
+/**<br>
+ * vu_rm_shared_object:<br>
+ * @dev: a VuDev context<br>
+ * @uuid: UUID of the shared object<br>
+ *<br>
+ * Removes a shared object (i.e., dma-buf fd) associated with the<br>
+ * received UUID from the hash table.<br>
+ *<br>
+ * Returns: TRUE on success, FALSE on failure.<br>
+ */<br>
+bool vu_rm_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN]);<br>
+<br>
=C2=A0/**<br>
=C2=A0 * vu_queue_set_notification:<br>
=C2=A0 * @dev: a VuDev context<br>
-- <br>
2.40.0<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000d2386a05febd97d7--

