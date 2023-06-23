Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F5F73B90F
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 15:48:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCh7X-00081w-Ul; Fri, 23 Jun 2023 09:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qCh7I-00081Y-UI
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:46:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qCh7E-0005gb-Qz
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687527980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qLMrMbaiPR3gPBIVSuveNSALW8ao+220xOz1Bs7hjZw=;
 b=Bbz9WsFQJ6btXd35epGNAdaLWVltZW6XfKSjxAEv5z8K7O2ZdnWYzC2k1dtYVchmshcRmY
 YDaJRsLrB1AImAQ9d+mvPqTDasyeHZI3cz3JeMcoUoEMZz07AM17ByrTNqBDy5LVf/Lkxb
 +UtyrlfwFNDUSSNox07PAWPQepf3UZQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-wnUFKKqGNNS_IqBFhhKhNQ-1; Fri, 23 Jun 2023 09:46:18 -0400
X-MC-Unique: wnUFKKqGNNS_IqBFhhKhNQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-25eccfe125dso352406a91.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 06:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687527977; x=1690119977;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qLMrMbaiPR3gPBIVSuveNSALW8ao+220xOz1Bs7hjZw=;
 b=Bi45PqQD6LdCM8zZ2GMb0j55+nE3QMBmMtHHFhA/NMq7uqmAfnSB/fWZ222JGgdrtp
 gIdOWQcL4ILPwQKzvNt9pAAvbBTFORkC5eZQs9eqpTDOG3aC6QN+5sydt8t0Kbxw13sO
 on6opHjqXN6wVfZV5uL56xchYSb3B6sXWw5btq8sA2DcG7xPPON7ow305Fz8SreJ6/Z5
 iJOTk6hBDwzbbKJQc5u/2r+F7rhH0m+yGIS/5ZZcGMbkyAzGB5Iw5VTawio5y1MNBiJC
 EM+jEp9o9tLyamrYTQkZy/nGZusVwD9rxLd2YV8tQ42nmTvjc2ZB/pjMWbOlzlzX4zz1
 95CA==
X-Gm-Message-State: AC+VfDxRMn53TaOXpEilsYTR1TmJY0lPx4YjV0P8hoda1i/jbkMAaEoy
 n/1uliksVRJB7eLSxKiUkgNcMtUIiGvb9cRqupzcYNs3ps/qlmZQDHy8uraLmtfKDG4ydBIcTTc
 tun8gBewk4jyjfEPCFuwffXagnJu4Gyc=
X-Received: by 2002:a17:90a:ba8a:b0:25e:f6c0:4961 with SMTP id
 t10-20020a17090aba8a00b0025ef6c04961mr11058496pjr.43.1687527977235; 
 Fri, 23 Jun 2023 06:46:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ahBUjr7G0fbeKY6XDK13+nAXXg0T8GAPzcnp95FwYVOOHfT5lPRFnMsuiiCdrUA8/VQ8p5E4Fu+mM9e9oHwA=
X-Received: by 2002:a17:90a:ba8a:b0:25e:f6c0:4961 with SMTP id
 t10-20020a17090aba8a00b0025ef6c04961mr11058479pjr.43.1687527976840; Fri, 23
 Jun 2023 06:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230524091333.201767-1-aesteve@redhat.com>
 <20230524091333.201767-4-aesteve@redhat.com>
 <20230623024322-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230623024322-mutt-send-email-mst@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 23 Jun 2023 15:46:05 +0200
Message-ID: <CADSE00JZefxzgktuE4ZeMnT9RhWsYBS9-wO1AZwLMkHNe+745Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] vhost-user: add shared_object msg
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, marcandre.lureau@gmail.com, 
 cohuck@redhat.com, Fam Zheng <fam@euphon.net>
Content-Type: multipart/alternative; boundary="0000000000009bc49405fecc3985"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--0000000000009bc49405fecc3985
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 23, 2023 at 8:45=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:

> On Wed, May 24, 2023 at 11:13:32AM +0200, Albert Esteve wrote:
> > Add new vhost-user protocol message
> > `VHOST_USER_BACKEND_SHARED_OBJECT`. This new
> > message is sent from vhost-user back-ends
> > to interact with the virtio-dmabuf table
> > in order to add, remove, or lookup for
> > virtio dma-buf shared objects.
> >
> > The action taken in the front-end depends
> > on the type stored in the payload struct.
> >
> > In the libvhost-user library add helper
> > functions to allow sending messages to
> > interact with the virtio shared objects
> > hash table.
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  docs/interop/vhost-user.rst               | 15 ++++
> >  hw/virtio/vhost-user.c                    | 68 ++++++++++++++++++
> >  subprojects/libvhost-user/libvhost-user.c | 88 +++++++++++++++++++++++
> >  subprojects/libvhost-user/libvhost-user.h | 56 +++++++++++++++
> >  4 files changed, 227 insertions(+)
> >
> > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> > index 5a070adbc1..d3d8db41e5 100644
> > --- a/docs/interop/vhost-user.rst
> > +++ b/docs/interop/vhost-user.rst
> > @@ -1528,6 +1528,21 @@ is sent by the front-end.
> >
> >    The state.num field is currently reserved and must be set to 0.
> >
> > +``VHOST_USER_BACKEND_SHARED_OBJECT``
> > +  :id: 6
> > +  :equivalent ioctl: N/A
> > +  :request payload: ``struct VhostUserShared``
> > +  :reply payload: ``struct VhostUserShared`` (only for ``LOOKUP``
> requests)
> > +
> > +  Backends that need to interact with the virtio-dmabuf shared table A=
PI
> > +  can send this message. The operation is determined by the ``type``
> member
> > +  of the payload struct. The valid values for the operation type are
> > +  ``VHOST_SHARED_OBJECT_*`` members, i.e., ``ADD``, ``LOOKUP``, and
> ``REMOVE``.
> > +  ``LOOKUP`` operations require the ``VHOST_USER_NEED_REPLY_MASK`` fla=
g
> to be
> > +  set by the back-end, and the front-end will then send the dma-buf fd
> as
> > +  a response if the UUID matches an object in the table, or a negative
> value
> > +  otherwise.
> > +
> >  .. _reply_ack:
> >
> >  VHOST_USER_PROTOCOL_F_REPLY_ACK
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index 74a2a28663..5ac5f0eafd 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -10,6 +10,7 @@
> >
> >  #include "qemu/osdep.h"
> >  #include "qapi/error.h"
> > +#include "hw/virtio/virtio-dmabuf.h"
> >  #include "hw/virtio/vhost.h"
> >  #include "hw/virtio/vhost-user.h"
> >  #include "hw/virtio/vhost-backend.h"
> > @@ -20,6 +21,7 @@
> >  #include "sysemu/kvm.h"
> >  #include "qemu/error-report.h"
> >  #include "qemu/main-loop.h"
> > +#include "qemu/uuid.h"
> >  #include "qemu/sockets.h"
> >  #include "sysemu/runstate.h"
> >  #include "sysemu/cryptodev.h"
> > @@ -128,6 +130,7 @@ typedef enum VhostUserSlaveRequest {
> >      VHOST_USER_BACKEND_IOTLB_MSG =3D 1,
> >      VHOST_USER_BACKEND_CONFIG_CHANGE_MSG =3D 2,
> >      VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG =3D 3,
> > +    VHOST_USER_BACKEND_SHARED_OBJECT =3D 6,
> >      VHOST_USER_BACKEND_MAX
> >  }  VhostUserSlaveRequest;
> >
> > @@ -190,6 +193,18 @@ typedef struct VhostUserInflight {
> >      uint16_t queue_size;
> >  } VhostUserInflight;
> >
> > +typedef enum VhostUserSharedType {
> > +    VHOST_SHARED_OBJECT_ADD =3D 0,
> > +    VHOST_SHARED_OBJECT_LOOKUP,
> > +    VHOST_SHARED_OBJECT_REMOVE,
> > +} VhostUserSharedType;
> > +
> > +typedef struct VhostUserShared {
> > +    unsigned char uuid[16];
> > +    VhostUserSharedType type;
> > +    int dmabuf_fd;
> > +} VhostUserShared;
> > +
> >  typedef struct {
> >      VhostUserRequest request;
> >
> > @@ -214,6 +229,7 @@ typedef union {
> >          VhostUserCryptoSession session;
> >          VhostUserVringArea area;
> >          VhostUserInflight inflight;
> > +        VhostUserShared object;
> >  } VhostUserPayload;
> >
> >  typedef struct VhostUserMsg {
> > @@ -1582,6 +1598,52 @@ static int
> vhost_user_slave_handle_vring_host_notifier(struct vhost_dev *dev,
> >      return 0;
> >  }
> >
> > +static int vhost_user_backend_handle_shared_object(VhostUserShared
> *object)
> > +{
> > +    QemuUUID uuid;
>
> Can we initialize it here? uuid =3D { .data =3D object->uuid } ?
>
> Also, pls put space after variable declaration.
>

At this point, they are still just char arrays, so I need the memcpy.
But I will add the space after variable declaration.


>
> > +    memcpy(uuid.data, object->uuid, sizeof(object->uuid));
> > +
> > +    switch (object->type) {
> > +    case VHOST_SHARED_OBJECT_ADD:
> > +        return virtio_add_dmabuf(&uuid, object->dmabuf_fd);
> > +    case VHOST_SHARED_OBJECT_LOOKUP:
> > +        object->dmabuf_fd =3D virtio_lookup_dmabuf(&uuid);
> > +        if (object->dmabuf_fd < 0) {
> > +            return object->dmabuf_fd;
> > +        }
> > +        break;
> > +    case VHOST_SHARED_OBJECT_REMOVE:
> > +        return virtio_remove_resource(&uuid);
> > +    }
> > +
>
> I couldn't figure out why, but if I commit this then run checkpatch,
> like this
> ./scripts/checkpatch.pl HEAD~1..HEAD
>
> then it is unhappy about the : in case. Any idea why?
>
> > +    return 0;
> > +}
> > +
> > +static bool
> > +vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHeader *hd=
r,
> > +                                  VhostUserPayload *payload)
> > +{
> > +    Error *local_err =3D NULL;
> > +    struct iovec iov[2];
> > +    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> > +        hdr->flags &=3D ~VHOST_USER_NEED_REPLY_MASK;
> > +        hdr->flags |=3D VHOST_USER_REPLY_MASK;
> > +
> > +        hdr->size =3D sizeof(payload->object);
> > +
> > +        iov[0].iov_base =3D hdr;
> > +        iov[0].iov_len =3D VHOST_USER_HDR_SIZE;
> > +        iov[1].iov_base =3D payload;
> > +        iov[1].iov_len =3D hdr->size;
> > +
> > +        if (qio_channel_writev_all(ioc, iov, ARRAY_SIZE(iov),
> &local_err)) {
> > +            error_report_err(local_err);
> > +            return false;
> > +        }
> > +    }
> > +    return true;
> > +}
> > +
> >  static void close_slave_channel(struct vhost_user *u)
> >  {
> >      g_source_destroy(u->slave_src);
> > @@ -1639,6 +1701,12 @@ static gboolean slave_read(QIOChannel *ioc,
> GIOCondition condition,
> >          ret =3D vhost_user_slave_handle_vring_host_notifier(dev,
> &payload.area,
> >                                                            fd ? fd[0] :
> -1);
> >          break;
> > +    case VHOST_USER_BACKEND_SHARED_OBJECT:
> > +        ret =3D vhost_user_backend_handle_shared_object(&payload.objec=
t);
> > +        if (!vhost_user_backend_send_dmabuf_fd(ioc, &hdr, &payload)) {
> > +            goto err;
> > +        }
> > +        break;
> >      default:
> >          error_report("Received unexpected msg type: %d.", hdr.request)=
;
> >          ret =3D -EINVAL;
> > diff --git a/subprojects/libvhost-user/libvhost-user.c
> b/subprojects/libvhost-user/libvhost-user.c
> > index 8fb61e2df2..27f16d292a 100644
> > --- a/subprojects/libvhost-user/libvhost-user.c
> > +++ b/subprojects/libvhost-user/libvhost-user.c
> > @@ -1403,6 +1403,94 @@ bool vu_set_queue_host_notifier(VuDev *dev,
> VuVirtq *vq, int fd,
> >      return vu_process_message_reply(dev, &vmsg);
> >  }
> >
> > +bool
> > +vu_get_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN], int
> *dmabuf_fd)
> > +{
> > +    bool result =3D false;
> > +    VhostUserMsg msg_reply;
> > +    VhostUserMsg msg =3D {
> > +        .request =3D VHOST_USER_BACKEND_SHARED_OBJECT,
> > +        .size =3D sizeof(msg.payload.object),
> > +        .flags =3D VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MASK,
> > +        .payload.object =3D {
> > +            .type =3D VHOST_SHARED_OBJECT_LOOKUP,
> > +        },
> > +    };
> > +
> > +    memcpy(msg.payload.object.uuid, uuid, sizeof(uuid[0]) * UUID_LEN);
> > +
> > +    pthread_mutex_lock(&dev->slave_mutex);
> > +    if (!vu_message_write(dev, dev->slave_fd, &msg)) {
> > +        goto out;
> > +    }
> > +
> > +    if (!vu_message_read_default(dev, dev->slave_fd, &msg_reply)) {
> > +        goto out;
> > +    }
> > +
> > +    if (msg_reply.request !=3D msg.request) {
> > +        DPRINT("Received unexpected msg type. Expected %d, received %d=
",
> > +               msg.request, msg_reply.request);
> > +        goto out;
> > +    }
> > +
> > +    *dmabuf_fd =3D msg_reply.payload.object.dmabuf_fd;
> > +    result =3D *dmabuf_fd > 0;
> > +out:
> > +    pthread_mutex_unlock(&dev->slave_mutex);
> > +
> > +    return result;
> > +}
> > +
> > +static bool
> > +vu_send_message(VuDev *dev, VhostUserMsg *vmsg)
> > +{
> > +    bool result =3D false;
> > +    pthread_mutex_lock(&dev->slave_mutex);
> > +    if (!vu_message_write(dev, dev->slave_fd, vmsg)) {
> > +        goto out;
> > +    }
> > +
> > +    result =3D true;
> > +out:
> > +    pthread_mutex_unlock(&dev->slave_mutex);
> > +
> > +    return result;
> > +}
> > +
> > +bool
> > +vu_add_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN], int
> dmabuf_fd)
> > +{
> > +    VhostUserMsg msg =3D {
> > +        .request =3D VHOST_USER_BACKEND_SHARED_OBJECT,
> > +        .size =3D sizeof(msg.payload.object),
> > +        .flags =3D VHOST_USER_VERSION,
> > +        .payload.object =3D {
> > +            .dmabuf_fd =3D dmabuf_fd,
> > +            .type =3D VHOST_SHARED_OBJECT_ADD,
> > +        },
> > +    };
> > +    memcpy(msg.payload.object.uuid, uuid, sizeof(uuid[0]) * UUID_LEN);
> > +
> > +    return vu_send_message(dev, &msg);
> > +}
> > +
> > +bool
> > +vu_rm_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN])
> > +{
> > +    VhostUserMsg msg =3D {
> > +        .request =3D VHOST_USER_BACKEND_SHARED_OBJECT,
> > +        .size =3D sizeof(msg.payload.object),
> > +        .flags =3D VHOST_USER_VERSION,
> > +        .payload.object =3D {
> > +            .type =3D VHOST_SHARED_OBJECT_REMOVE,
> > +        },
> > +    };
> > +    memcpy(msg.payload.object.uuid, uuid, sizeof(uuid[0]) * UUID_LEN);
> > +
> > +    return vu_send_message(dev, &msg);
> > +}
> > +
> >  static bool
> >  vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
> >  {
> > diff --git a/subprojects/libvhost-user/libvhost-user.h
> b/subprojects/libvhost-user/libvhost-user.h
> > index 49208cceaa..a43d115bd7 100644
> > --- a/subprojects/libvhost-user/libvhost-user.h
> > +++ b/subprojects/libvhost-user/libvhost-user.h
> > @@ -119,6 +119,7 @@ typedef enum VhostUserSlaveRequest {
> >      VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG =3D 3,
> >      VHOST_USER_BACKEND_VRING_CALL =3D 4,
> >      VHOST_USER_BACKEND_VRING_ERR =3D 5,
> > +    VHOST_USER_BACKEND_SHARED_OBJECT =3D 6,
> >      VHOST_USER_BACKEND_MAX
> >  }  VhostUserSlaveRequest;
> >
> > @@ -172,6 +173,20 @@ typedef struct VhostUserInflight {
> >      uint16_t queue_size;
> >  } VhostUserInflight;
> >
> > +typedef enum VhostUserSharedType {
> > +    VHOST_SHARED_OBJECT_ADD =3D 0,
> > +    VHOST_SHARED_OBJECT_LOOKUP,
> > +    VHOST_SHARED_OBJECT_REMOVE,
> > +} VhostUserSharedType;
> > +
> > +#define UUID_LEN 16
> > +
> > +typedef struct VhostUserShared {
> > +    unsigned char uuid[UUID_LEN];
> > +    VhostUserSharedType type;
> > +    int dmabuf_fd;
> > +} VhostUserShared;
> > +
> >  #if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
> >  # define VU_PACKED __attribute__((gcc_struct, packed))
> >  #else
> > @@ -199,6 +214,7 @@ typedef struct VhostUserMsg {
> >          VhostUserConfig config;
> >          VhostUserVringArea area;
> >          VhostUserInflight inflight;
> > +        VhostUserShared object;
> >      } payload;
> >
> >      int fds[VHOST_MEMORY_BASELINE_NREGIONS];
> > @@ -539,6 +555,46 @@ void vu_set_queue_handler(VuDev *dev, VuVirtq *vq,
> >  bool vu_set_queue_host_notifier(VuDev *dev, VuVirtq *vq, int fd,
> >                                  int size, int offset);
> >
> > +/**
> > + * vu_get_shared_object:
> > + * @dev: a VuDev context
> > + * @uuid: UUID of the shared object
> > + * @dmabuf_fd: output dma-buf file descriptor
> > + *
> > + * Lookup for a virtio shared object (i.e., dma-buf fd) associated wit=
h
> the
> > + * received UUID. Result, if found, is stored in the dmabuf_fd argumen=
t.
> > + *
> > + * Returns: whether the virtio object was found.
> > + */
> > +bool vu_get_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN],
> > +                          int *dmabuf_fd);
> > +
> > +/**
> > + * vu_add_shared_object:
> > + * @dev: a VuDev context
> > + * @uuid: UUID of the shared object
> > + * @dmabuf_fd: output dma-buf file descriptor
> > + *
> > + * Stores a new shared object (i.e., dma-buf fd) in the hash table, an=
d
> > + * associates it with the received UUID.
> > + *
> > + * Returns: TRUE on success, FALSE on failure.
> > + */
> > +bool vu_add_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN],
> > +                          int dmabuf_fd);
> > +
> > +/**
> > + * vu_rm_shared_object:
> > + * @dev: a VuDev context
> > + * @uuid: UUID of the shared object
> > + *
> > + * Removes a shared object (i.e., dma-buf fd) associated with the
> > + * received UUID from the hash table.
> > + *
> > + * Returns: TRUE on success, FALSE on failure.
> > + */
> > +bool vu_rm_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN]);
> > +
> >  /**
> >   * vu_queue_set_notification:
> >   * @dev: a VuDev context
> > --
> > 2.40.0
>
>

--0000000000009bc49405fecc3985
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br clear=3D"all"><div><div dir=3D"ltr" c=
lass=3D"gmail_signature"><div dir=3D"ltr"><p style=3D"color:rgb(0,0,0);font=
-family:RedHatText,sans-serif;font-weight:bold;margin:0px;padding:0px;font-=
size:14px"><br></p></div></div></div></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 23, 2023 at 8:45=E2=80=AFA=
M Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On=
 Wed, May 24, 2023 at 11:13:32AM +0200, Albert Esteve wrote:<br>
&gt; Add new vhost-user protocol message<br>
&gt; `VHOST_USER_BACKEND_SHARED_OBJECT`. This new<br>
&gt; message is sent from vhost-user back-ends<br>
&gt; to interact with the virtio-dmabuf table<br>
&gt; in order to add, remove, or lookup for<br>
&gt; virtio dma-buf shared objects.<br>
&gt; <br>
&gt; The action taken in the front-end depends<br>
&gt; on the type stored in the payload struct.<br>
&gt; <br>
&gt; In the libvhost-user library add helper<br>
&gt; functions to allow sending messages to<br>
&gt; interact with the virtio shared objects<br>
&gt; hash table.<br>
&gt; <br>
&gt; Signed-off-by: Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com"=
 target=3D"_blank">aesteve@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/interop/vhost-user.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| 15 ++++<br>
&gt;=C2=A0 hw/virtio/vhost-user.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 68 ++++++++++++++++++<br>
&gt;=C2=A0 subprojects/libvhost-user/libvhost-user.c | 88 +++++++++++++++++=
++++++<br>
&gt;=C2=A0 subprojects/libvhost-user/libvhost-user.h | 56 +++++++++++++++<b=
r>
&gt;=C2=A0 4 files changed, 227 insertions(+)<br>
&gt; <br>
&gt; diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst=
<br>
&gt; index 5a070adbc1..d3d8db41e5 100644<br>
&gt; --- a/docs/interop/vhost-user.rst<br>
&gt; +++ b/docs/interop/vhost-user.rst<br>
&gt; @@ -1528,6 +1528,21 @@ is sent by the front-end.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 The state.num field is currently reserved and must be set=
 to 0.<br>
&gt;=C2=A0 <br>
&gt; +``VHOST_USER_BACKEND_SHARED_OBJECT``<br>
&gt; +=C2=A0 :id: 6<br>
&gt; +=C2=A0 :equivalent ioctl: N/A<br>
&gt; +=C2=A0 :request payload: ``struct VhostUserShared``<br>
&gt; +=C2=A0 :reply payload: ``struct VhostUserShared`` (only for ``LOOKUP`=
` requests)<br>
&gt; +<br>
&gt; +=C2=A0 Backends that need to interact with the virtio-dmabuf shared t=
able API<br>
&gt; +=C2=A0 can send this message. The operation is determined by the ``ty=
pe`` member<br>
&gt; +=C2=A0 of the payload struct. The valid values for the operation type=
 are<br>
&gt; +=C2=A0 ``VHOST_SHARED_OBJECT_*`` members, i.e., ``ADD``, ``LOOKUP``, =
and ``REMOVE``.<br>
&gt; +=C2=A0 ``LOOKUP`` operations require the ``VHOST_USER_NEED_REPLY_MASK=
`` flag to be<br>
&gt; +=C2=A0 set by the back-end, and the front-end will then send the dma-=
buf fd as<br>
&gt; +=C2=A0 a response if the UUID matches an object in the table, or a ne=
gative value<br>
&gt; +=C2=A0 otherwise.<br>
&gt; +<br>
&gt;=C2=A0 .. _reply_ack:<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 VHOST_USER_PROTOCOL_F_REPLY_ACK<br>
&gt; diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c<br>
&gt; index 74a2a28663..5ac5f0eafd 100644<br>
&gt; --- a/hw/virtio/vhost-user.c<br>
&gt; +++ b/hw/virtio/vhost-user.c<br>
&gt; @@ -10,6 +10,7 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 #include &quot;qapi/error.h&quot;<br>
&gt; +#include &quot;hw/virtio/virtio-dmabuf.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/virtio/vhost.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/virtio/vhost-user.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/virtio/vhost-backend.h&quot;<br>
&gt; @@ -20,6 +21,7 @@<br>
&gt;=C2=A0 #include &quot;sysemu/kvm.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/error-report.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/main-loop.h&quot;<br>
&gt; +#include &quot;qemu/uuid.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/sockets.h&quot;<br>
&gt;=C2=A0 #include &quot;sysemu/runstate.h&quot;<br>
&gt;=C2=A0 #include &quot;sysemu/cryptodev.h&quot;<br>
&gt; @@ -128,6 +130,7 @@ typedef enum VhostUserSlaveRequest {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_IOTLB_MSG =3D 1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_CONFIG_CHANGE_MSG =3D 2,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG =3D 3,<=
br>
&gt; +=C2=A0 =C2=A0 VHOST_USER_BACKEND_SHARED_OBJECT =3D 6,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_MAX<br>
&gt;=C2=A0 }=C2=A0 VhostUserSlaveRequest;<br>
&gt;=C2=A0 <br>
&gt; @@ -190,6 +193,18 @@ typedef struct VhostUserInflight {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint16_t queue_size;<br>
&gt;=C2=A0 } VhostUserInflight;<br>
&gt;=C2=A0 <br>
&gt; +typedef enum VhostUserSharedType {<br>
&gt; +=C2=A0 =C2=A0 VHOST_SHARED_OBJECT_ADD =3D 0,<br>
&gt; +=C2=A0 =C2=A0 VHOST_SHARED_OBJECT_LOOKUP,<br>
&gt; +=C2=A0 =C2=A0 VHOST_SHARED_OBJECT_REMOVE,<br>
&gt; +} VhostUserSharedType;<br>
&gt; +<br>
&gt; +typedef struct VhostUserShared {<br>
&gt; +=C2=A0 =C2=A0 unsigned char uuid[16];<br>
&gt; +=C2=A0 =C2=A0 VhostUserSharedType type;<br>
&gt; +=C2=A0 =C2=A0 int dmabuf_fd;<br>
&gt; +} VhostUserShared;<br>
&gt; +<br>
&gt;=C2=A0 typedef struct {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VhostUserRequest request;<br>
&gt;=C2=A0 <br>
&gt; @@ -214,6 +229,7 @@ typedef union {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserCryptoSession session;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserVringArea area;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserInflight inflight;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserShared object;<br>
&gt;=C2=A0 } VhostUserPayload;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 typedef struct VhostUserMsg {<br>
&gt; @@ -1582,6 +1598,52 @@ static int vhost_user_slave_handle_vring_host_n=
otifier(struct vhost_dev *dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +static int vhost_user_backend_handle_shared_object(VhostUserShared *o=
bject)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 QemuUUID uuid;<br>
<br>
Can we initialize it here? uuid =3D { .data =3D object-&gt;uuid } ?<br>
<br>
Also, pls put space after variable declaration.<br></blockquote><div><br></=
div><div>At this point, they are still just char arrays, so I need the memc=
py.</div><div>But I will add the space after variable declaration.</div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 memcpy(uuid.data, object-&gt;uuid, sizeof(object-&gt;uu=
id));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (object-&gt;type) {<br>
&gt; +=C2=A0 =C2=A0 case VHOST_SHARED_OBJECT_ADD:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return virtio_add_dmabuf(&amp;uuid, objec=
t-&gt;dmabuf_fd);<br>
&gt; +=C2=A0 =C2=A0 case VHOST_SHARED_OBJECT_LOOKUP:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object-&gt;dmabuf_fd =3D virtio_lookup_dm=
abuf(&amp;uuid);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (object-&gt;dmabuf_fd &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return object-&gt;dmabuf_fd=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case VHOST_SHARED_OBJECT_REMOVE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return virtio_remove_resource(&amp;uuid);=
<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
<br>
I couldn&#39;t figure out why, but if I commit this then run checkpatch,<br=
>
like this<br>
./scripts/<a href=3D"http://checkpatch.pl" rel=3D"noreferrer" target=3D"_bl=
ank">checkpatch.pl</a> HEAD~1..HEAD<br>
<br>
then it is unhappy about the : in case. Any idea why?<br>
<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool<br>
&gt; +vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHeader *h=
dr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserPayload *payload=
)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 struct iovec iov[2];<br>
&gt; +=C2=A0 =C2=A0 if (hdr-&gt;flags &amp; VHOST_USER_NEED_REPLY_MASK) {<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hdr-&gt;flags &amp;=3D ~VHOST_USER_NEED_R=
EPLY_MASK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hdr-&gt;flags |=3D VHOST_USER_REPLY_MASK;=
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hdr-&gt;size =3D sizeof(payload-&gt;objec=
t);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 iov[0].iov_base =3D hdr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 iov[0].iov_len =3D VHOST_USER_HDR_SIZE;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 iov[1].iov_base =3D payload;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 iov[1].iov_len =3D hdr-&gt;size;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qio_channel_writev_all(ioc, iov, ARRA=
Y_SIZE(iov), &amp;local_err)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(local_err)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static void close_slave_channel(struct vhost_user *u)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_source_destroy(u-&gt;slave_src);<br>
&gt; @@ -1639,6 +1701,12 @@ static gboolean slave_read(QIOChannel *ioc, GIO=
Condition condition,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vhost_user_slave_handle_vrin=
g_host_notifier(dev, &amp;payload.area,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fd ? fd[=
0] : -1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case VHOST_USER_BACKEND_SHARED_OBJECT:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vhost_user_backend_handle_shared_=
object(&amp;payload.object);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!vhost_user_backend_send_dmabuf_fd(io=
c, &amp;hdr, &amp;payload)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Received unexpect=
ed msg type: %d.&quot;, hdr.request);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -EINVAL;<br>
&gt; diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/l=
ibvhost-user/libvhost-user.c<br>
&gt; index 8fb61e2df2..27f16d292a 100644<br>
&gt; --- a/subprojects/libvhost-user/libvhost-user.c<br>
&gt; +++ b/subprojects/libvhost-user/libvhost-user.c<br>
&gt; @@ -1403,6 +1403,94 @@ bool vu_set_queue_host_notifier(VuDev *dev, VuV=
irtq *vq, int fd,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return vu_process_message_reply(dev, &amp;vmsg);<b=
r>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +bool<br>
&gt; +vu_get_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN], int *d=
mabuf_fd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 bool result =3D false;<br>
&gt; +=C2=A0 =C2=A0 VhostUserMsg msg_reply;<br>
&gt; +=C2=A0 =C2=A0 VhostUserMsg msg =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .request =3D VHOST_USER_BACKEND_SHARED_OB=
JECT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .size =3D sizeof(msg.payload.object),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =3D VHOST_USER_VERSION | VHOST_USE=
R_NEED_REPLY_MASK,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .payload.object =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D VHOST_SHARED_OBJE=
CT_LOOKUP,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memcpy(msg.payload.object.uuid, uuid, sizeof(uuid[0]) *=
 UUID_LEN);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 pthread_mutex_lock(&amp;dev-&gt;slave_mutex);<br>
&gt; +=C2=A0 =C2=A0 if (!vu_message_write(dev, dev-&gt;slave_fd, &amp;msg))=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!vu_message_read_default(dev, dev-&gt;slave_fd, &am=
p;msg_reply)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (msg_reply.request !=3D msg.request) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINT(&quot;Received unexpected msg type=
. Expected %d, received %d&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg.request, m=
sg_reply.request);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 *dmabuf_fd =3D msg_reply.payload.object.dmabuf_fd;<br>
&gt; +=C2=A0 =C2=A0 result =3D *dmabuf_fd &gt; 0;<br>
&gt; +out:<br>
&gt; +=C2=A0 =C2=A0 pthread_mutex_unlock(&amp;dev-&gt;slave_mutex);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return result;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool<br>
&gt; +vu_send_message(VuDev *dev, VhostUserMsg *vmsg)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 bool result =3D false;<br>
&gt; +=C2=A0 =C2=A0 pthread_mutex_lock(&amp;dev-&gt;slave_mutex);<br>
&gt; +=C2=A0 =C2=A0 if (!vu_message_write(dev, dev-&gt;slave_fd, vmsg)) {<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 result =3D true;<br>
&gt; +out:<br>
&gt; +=C2=A0 =C2=A0 pthread_mutex_unlock(&amp;dev-&gt;slave_mutex);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return result;<br>
&gt; +}<br>
&gt; +<br>
&gt; +bool<br>
&gt; +vu_add_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN], int dm=
abuf_fd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VhostUserMsg msg =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .request =3D VHOST_USER_BACKEND_SHARED_OB=
JECT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .size =3D sizeof(msg.payload.object),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =3D VHOST_USER_VERSION,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .payload.object =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .dmabuf_fd =3D dmabuf_fd,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D VHOST_SHARED_OBJE=
CT_ADD,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 memcpy(msg.payload.object.uuid, uuid, sizeof(uuid[0]) *=
 UUID_LEN);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return vu_send_message(dev, &amp;msg);<br>
&gt; +}<br>
&gt; +<br>
&gt; +bool<br>
&gt; +vu_rm_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN])<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VhostUserMsg msg =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .request =3D VHOST_USER_BACKEND_SHARED_OB=
JECT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .size =3D sizeof(msg.payload.object),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =3D VHOST_USER_VERSION,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .payload.object =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D VHOST_SHARED_OBJE=
CT_REMOVE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 memcpy(msg.payload.object.uuid, uuid, sizeof(uuid[0]) *=
 UUID_LEN);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return vu_send_message(dev, &amp;msg);<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static bool<br>
&gt;=C2=A0 vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)<br>
&gt;=C2=A0 {<br>
&gt; diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/l=
ibvhost-user/libvhost-user.h<br>
&gt; index 49208cceaa..a43d115bd7 100644<br>
&gt; --- a/subprojects/libvhost-user/libvhost-user.h<br>
&gt; +++ b/subprojects/libvhost-user/libvhost-user.h<br>
&gt; @@ -119,6 +119,7 @@ typedef enum VhostUserSlaveRequest {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG =3D 3,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_VRING_CALL =3D 4,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_VRING_ERR =3D 5,<br>
&gt; +=C2=A0 =C2=A0 VHOST_USER_BACKEND_SHARED_OBJECT =3D 6,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_MAX<br>
&gt;=C2=A0 }=C2=A0 VhostUserSlaveRequest;<br>
&gt;=C2=A0 <br>
&gt; @@ -172,6 +173,20 @@ typedef struct VhostUserInflight {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint16_t queue_size;<br>
&gt;=C2=A0 } VhostUserInflight;<br>
&gt;=C2=A0 <br>
&gt; +typedef enum VhostUserSharedType {<br>
&gt; +=C2=A0 =C2=A0 VHOST_SHARED_OBJECT_ADD =3D 0,<br>
&gt; +=C2=A0 =C2=A0 VHOST_SHARED_OBJECT_LOOKUP,<br>
&gt; +=C2=A0 =C2=A0 VHOST_SHARED_OBJECT_REMOVE,<br>
&gt; +} VhostUserSharedType;<br>
&gt; +<br>
&gt; +#define UUID_LEN 16<br>
&gt; +<br>
&gt; +typedef struct VhostUserShared {<br>
&gt; +=C2=A0 =C2=A0 unsigned char uuid[UUID_LEN];<br>
&gt; +=C2=A0 =C2=A0 VhostUserSharedType type;<br>
&gt; +=C2=A0 =C2=A0 int dmabuf_fd;<br>
&gt; +} VhostUserShared;<br>
&gt; +<br>
&gt;=C2=A0 #if defined(_WIN32) &amp;&amp; (defined(__x86_64__) || defined(_=
_i386__))<br>
&gt;=C2=A0 # define VU_PACKED __attribute__((gcc_struct, packed))<br>
&gt;=C2=A0 #else<br>
&gt; @@ -199,6 +214,7 @@ typedef struct VhostUserMsg {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserConfig config;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserVringArea area;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserInflight inflight;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserShared object;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 } payload;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 int fds[VHOST_MEMORY_BASELINE_NREGIONS];<br>
&gt; @@ -539,6 +555,46 @@ void vu_set_queue_handler(VuDev *dev, VuVirtq *vq=
,<br>
&gt;=C2=A0 bool vu_set_queue_host_notifier(VuDev *dev, VuVirtq *vq, int fd,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int size, int offset);<br>
&gt;=C2=A0 <br>
&gt; +/**<br>
&gt; + * vu_get_shared_object:<br>
&gt; + * @dev: a VuDev context<br>
&gt; + * @uuid: UUID of the shared object<br>
&gt; + * @dmabuf_fd: output dma-buf file descriptor<br>
&gt; + *<br>
&gt; + * Lookup for a virtio shared object (i.e., dma-buf fd) associated wi=
th the<br>
&gt; + * received UUID. Result, if found, is stored in the dmabuf_fd argume=
nt.<br>
&gt; + *<br>
&gt; + * Returns: whether the virtio object was found.<br>
&gt; + */<br>
&gt; +bool vu_get_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN],<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 int *dmabuf_fd);<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * vu_add_shared_object:<br>
&gt; + * @dev: a VuDev context<br>
&gt; + * @uuid: UUID of the shared object<br>
&gt; + * @dmabuf_fd: output dma-buf file descriptor<br>
&gt; + *<br>
&gt; + * Stores a new shared object (i.e., dma-buf fd) in the hash table, a=
nd <br>
&gt; + * associates it with the received UUID.<br>
&gt; + *<br>
&gt; + * Returns: TRUE on success, FALSE on failure.<br>
&gt; + */<br>
&gt; +bool vu_add_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN],<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 int dmabuf_fd);<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * vu_rm_shared_object:<br>
&gt; + * @dev: a VuDev context<br>
&gt; + * @uuid: UUID of the shared object<br>
&gt; + *<br>
&gt; + * Removes a shared object (i.e., dma-buf fd) associated with the<br>
&gt; + * received UUID from the hash table.<br>
&gt; + *<br>
&gt; + * Returns: TRUE on success, FALSE on failure.<br>
&gt; + */<br>
&gt; +bool vu_rm_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN]);<b=
r>
&gt; +<br>
&gt;=C2=A0 /**<br>
&gt;=C2=A0 =C2=A0* vu_queue_set_notification:<br>
&gt;=C2=A0 =C2=A0* @dev: a VuDev context<br>
&gt; -- <br>
&gt; 2.40.0<br>
<br>
</blockquote></div></div>

--0000000000009bc49405fecc3985--


