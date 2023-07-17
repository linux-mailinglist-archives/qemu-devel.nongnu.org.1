Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC227561C9
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 13:43:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLMcU-0000y9-Ab; Mon, 17 Jul 2023 07:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qLMcS-0000xd-E9
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 07:42:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qLMcM-0000if-FG
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 07:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689594137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hz5FoXT113E3PVBPHj4OQeN0eJXrXuqo4AWGU65yQ08=;
 b=A9WBn1NKsOientU4jIN/I0RS0KpAque2ykLgKXQtdNtLOS9Rnymj9Qi5G1USWi1nirodJ3
 i1HTQ1tEY1oztxNqiVNCb2qlXaqzzD55wEcf+MeO3x9UnSlbAkGhNsT0RoiBfun2+UEHef
 y3wl666KpGVAj+h4CNE+SQ3VNtym5bg=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-halvOcRCO8yzAGtDUtF3mQ-1; Mon, 17 Jul 2023 07:42:15 -0400
X-MC-Unique: halvOcRCO8yzAGtDUtF3mQ-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-553d076dce5so1820291a12.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 04:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689594134; x=1692186134;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hz5FoXT113E3PVBPHj4OQeN0eJXrXuqo4AWGU65yQ08=;
 b=CIpEvvdzgODewNxFDiw30lD015p0wexSzSg5rr0FVWq6oGO3SFOn3K8y9IOZsqxXof
 j5ropiLgbngacvKs6eTRHgSZHRpbreQCuTirSKXbM1xnmSZgxhvV2grqq0/MVxxO9RY8
 RwR5MfoSJxyUqNoBHazRBJIFLdlJufHUTm6WM8Wm1PFldXOdyHWPM6n/i6ojs1vtj9LI
 wxwo4h0jtHDdHGl7L21HUpVP2uCJQe8ovi53eGGr+BXuyg51mrF2phxrgIA4qAcXn0T9
 /FoUX3IP/AQgpwF9AWhmtkj92fAg6EXe9yI+FFKbg/ryPfGtiFc9iTMcF9xtCC46SH8w
 heGg==
X-Gm-Message-State: ABy/qLZBt13oD9Dc9kL0URO02dcAV9nu0lcnxvOW2mdmWgA0C8Ja8e5Q
 azGw0Icy5VC8izawfEs4VsNlu1S93dqLwWlSqKropFc/iUts+uxvXBUJPcd/xVQBH5zgQSkMPZo
 q1ET9jcD9um/foKzMNujMIsW4Huy05Vo=
X-Received: by 2002:a17:90b:1196:b0:263:fbe5:2125 with SMTP id
 gk22-20020a17090b119600b00263fbe52125mr9999908pjb.15.1689594134176; 
 Mon, 17 Jul 2023 04:42:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGKoZ7YelZi6gPS954inMinXh6s+pVsA6Q/jbeugngF4oRze0rx+Pyr1CDZ1XuZC4pEddilw6j1bRKhyI08rTQ=
X-Received: by 2002:a17:90b:1196:b0:263:fbe5:2125 with SMTP id
 gk22-20020a17090b119600b00263fbe52125mr9999897pjb.15.1689594133769; Mon, 17
 Jul 2023 04:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230626073426.285659-1-aesteve@redhat.com>
 <20230626073426.285659-4-aesteve@redhat.com>
 <20230710150030-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230710150030-mutt-send-email-mst@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 17 Jul 2023 13:42:02 +0200
Message-ID: <CADSE00+MYYeTto5CCROpynB2p+FjcCASp6azyxb2FVRm7VhBrw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] vhost-user: add shared_object msg
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com, cohuck@redhat.com, 
 Fam Zheng <fam@euphon.net>, kraxel@redhat.com
Content-Type: multipart/alternative; boundary="0000000000002886b00600ad4a6d"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

--0000000000002886b00600ad4a6d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

True. It may be a good idea to impose a limit in the number of entries that
can be added to the table.
And fail to add new entries once it reaches the limit.

Not sure what would be a good limit though. For example,
https://www.kernel.org/doc/html/v4.9/media/uapi/v4l/vidioc-reqbufs.html#c.v=
4l2_requestbuffers
does not limit the number of buffers that can be allocated simultaneously,
it is an unsigned 32-bits value.
However, I guess 16-bits (65535) would suffice to cover the vast majority
of usecases. Or even lower, and
can be adjusted later, as this API gets (more) used.

Does that make sense?

Thanks.
BR,
Albert

On Mon, Jul 10, 2023 at 9:03=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:

> On Mon, Jun 26, 2023 at 09:34:25AM +0200, Albert Esteve wrote:
> > Add three new vhost-user protocol
> > `VHOST_USER_BACKEND_SHARED_OBJECT_* messages`.
> > These new messages are sent from vhost-user
> > back-ends to interact with the virtio-dmabuf
> > table in order to add, remove, or lookup for
> > virtio dma-buf shared objects.
> >
> > The action taken in the front-end depends
> > on the type stored in the payload struct.
> >
> > In the libvhost-user library we need to add
> > helper functions to allow sending messages to
> > interact with the virtio shared objects
> > hash table.
> >
> > The messages can only be sent after successfully
> > negotiating a new VHOST_USER_PROTOCOL_F_SHARED_OBJECT
> > vhost-user protocol feature bit.
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
>
> It bothers me that apparently, any backend can now
> make qemu allocate any amount of memory by sending
> lots of add messages.
>
> Any way to limit this? If not - at least let's make this
> a property that's opt-in?
>
>
> > ---
> >  docs/interop/vhost-user.rst               |  42 +++++++++
> >  hw/virtio/vhost-user.c                    |  99 +++++++++++++++++++++
> >  subprojects/libvhost-user/libvhost-user.c | 101 ++++++++++++++++++++++
> >  subprojects/libvhost-user/libvhost-user.h |  53 +++++++++++-
> >  4 files changed, 294 insertions(+), 1 deletion(-)
> >
> > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> > index 5a070adbc1..bca5600ff1 100644
> > --- a/docs/interop/vhost-user.rst
> > +++ b/docs/interop/vhost-user.rst
> > @@ -1528,6 +1528,48 @@ is sent by the front-end.
> >
> >    The state.num field is currently reserved and must be set to 0.
> >
> > +``VHOST_USER_BACKEND_SHARED_OBJECT_ADD``
> > +  :id: 6
> > +  :equivalent ioctl: N/A
> > +  :request payload: ``struct VhostUserShared``
> > +  :reply payload: N/A
> > +
> > +  When the ``VHOST_USER_PROTOCOL_F_SHARED_OBJECT`` protocol
> > +  feature has been successfully negotiated, this message can be
> submitted
> > +  by the backends to add a new dma-buf fd to the virtio-dmabuf shared
> > +  table API can send this message. The fd gets associated with a UUID.
> > +  If ``VHOST_USER_PROTOCOL_F_REPLY_ACK`` is negotiated, and the
> back-end sets
> > +  the ``VHOST_USER_NEED_REPLY`` flag, the front-end must respond with
> zero when
> > +  operation is successfully completed, or non-zero otherwise.
> > +
> > +``VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE``
> > +  :id: 7
> > +  :equivalent ioctl: N/A
> > +  :request payload: ``struct VhostUserShared``
> > +  :reply payload: N/A
> > +
> > +  When the ``VHOST_USER_PROTOCOL_F_SHARED_OBJECT`` protocol
> > +  feature has been successfully negotiated, this message can be
> submitted
> > +  by the backend to remove a dma-buf from to the virtio-dmabuf shared
> > +  table API can send this message. The shared table will remove the
> dma-buf
> > +  fd associated with the UUID. If ``VHOST_USER_PROTOCOL_F_REPLY_ACK`` =
is
> > +  negotiated, and the back-end sets the ``VHOST_USER_NEED_REPLY`` flag=
,
> the
> > +  front-end must respond with zero when operation is successfully
> completed,
> > +  or non-zero otherwise.
> > +
> > +``VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP``
> > +  :id: 8
> > +  :equivalent ioctl: N/A
> > +  :request payload: ``struct VhostUserShared``
> > +  :reply payload: dmabuf fd and ``u64``
> > +
> > +  When the ``VHOST_USER_PROTOCOL_F_SHARED_OBJECT`` protocol
> > +  feature has been successfully negotiated, this message can be
> submitted
> > +  by the backends to retrieve a given dma-buf fd from the virtio-dmabu=
f
> > +  shared table given a UUID. Frontend will reply passing the fd and a
> zero
> > +  when the operation is successful, or non-zero otherwise. Note that i=
f
> the
> > +  operation fails, no fd is sent to the backend.
> > +
> >  .. _reply_ack:
> >
> >  VHOST_USER_PROTOCOL_F_REPLY_ACK
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index 74a2a28663..e340c39a19 100644
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
> > @@ -73,6 +75,7 @@ enum VhostUserProtocolFeature {
> >      /* Feature 14 reserved for
> VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS. */
> >      VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS =3D 15,
> >      VHOST_USER_PROTOCOL_F_STATUS =3D 16,
> > +    VHOST_USER_PROTOCOL_F_SHARED_OBJECT =3D 17,
> >      VHOST_USER_PROTOCOL_F_MAX
> >  };
> >
> > @@ -128,6 +131,9 @@ typedef enum VhostUserSlaveRequest {
> >      VHOST_USER_BACKEND_IOTLB_MSG =3D 1,
> >      VHOST_USER_BACKEND_CONFIG_CHANGE_MSG =3D 2,
> >      VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG =3D 3,
> > +    VHOST_USER_BACKEND_SHARED_OBJECT_ADD =3D 6,
> > +    VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE =3D 7,
> > +    VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,
> >      VHOST_USER_BACKEND_MAX
> >  }  VhostUserSlaveRequest;
> >
> > @@ -190,6 +196,10 @@ typedef struct VhostUserInflight {
> >      uint16_t queue_size;
> >  } VhostUserInflight;
> >
> > +typedef struct VhostUserShared {
> > +    unsigned char uuid[16];
> > +} VhostUserShared;
> > +
> >  typedef struct {
> >      VhostUserRequest request;
> >
> > @@ -214,6 +224,7 @@ typedef union {
> >          VhostUserCryptoSession session;
> >          VhostUserVringArea area;
> >          VhostUserInflight inflight;
> > +        VhostUserShared object;
> >  } VhostUserPayload;
> >
> >  typedef struct VhostUserMsg {
> > @@ -1582,6 +1593,83 @@ static int
> vhost_user_slave_handle_vring_host_notifier(struct vhost_dev *dev,
> >      return 0;
> >  }
> >
> > +static int
> > +vhost_user_backend_handle_shared_object_add(VhostUserShared *object,
> > +                                            int dmabuf_fd)
> > +{
> > +    QemuUUID uuid;
> > +
> > +    memcpy(uuid.data, object->uuid, sizeof(object->uuid));
> > +    return virtio_add_dmabuf(&uuid, dmabuf_fd);
> > +}
> > +
> > +static int
> > +vhost_user_backend_handle_shared_object_remove(VhostUserShared *object=
)
> > +{
> > +    QemuUUID uuid;
> > +
> > +    memcpy(uuid.data, object->uuid, sizeof(object->uuid));
> > +    return virtio_remove_resource(&uuid);
> > +}
> > +
> > +static bool
> > +vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHeader *hd=
r,
> > +                                  VhostUserPayload *payload)
> > +{
> > +    Error *local_err =3D NULL;
> > +    struct iovec iov[2];
> > +
> > +    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> > +        hdr->flags &=3D ~VHOST_USER_NEED_REPLY_MASK;
> > +    }
> > +    hdr->flags |=3D VHOST_USER_REPLY_MASK;
> > +
> > +    hdr->size =3D sizeof(payload->u64);
> > +
> > +    iov[0].iov_base =3D hdr;
> > +    iov[0].iov_len =3D VHOST_USER_HDR_SIZE;
> > +    iov[1].iov_base =3D payload;
> > +    iov[1].iov_len =3D hdr->size;
> > +
> > +    if (qio_channel_writev_all(ioc, iov, ARRAY_SIZE(iov), &local_err))=
 {
> > +        error_report_err(local_err);
> > +        return false;
> > +    }
> > +    return true;
> > +}
> > +
> > +static int
> > +vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
> > +                                               QIOChannel *ioc,
> > +                                               VhostUserHeader *hdr,
> > +                                               VhostUserPayload
> *payload)
> > +{
> > +    QemuUUID uuid;
> > +    CharBackend *chr =3D u->user->chr;
> > +    int dmabuf_fd =3D -1;
> > +    int fd_num =3D 0;
> > +
> > +    memcpy(uuid.data, payload->object.uuid,
> sizeof(payload->object.uuid));
> > +
> > +    dmabuf_fd =3D virtio_lookup_dmabuf(&uuid);
> > +    if (dmabuf_fd !=3D -1) {
> > +        fd_num++;
> > +    }
> > +
> > +    payload->u64 =3D 0;
> > +    if (qemu_chr_fe_set_msgfds(chr, &dmabuf_fd, fd_num) < 0) {
> > +        error_report("Failed to set msg fds.");
> > +        payload->u64 =3D -EINVAL;
> > +    }
> > +
> > +    if (!vhost_user_backend_send_dmabuf_fd(ioc, hdr, payload)) {
> > +        error_report("Failed to write response msg.");
> > +        return -EINVAL;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> >  static void close_slave_channel(struct vhost_user *u)
> >  {
> >      g_source_destroy(u->slave_src);
> > @@ -1639,6 +1727,17 @@ static gboolean slave_read(QIOChannel *ioc,
> GIOCondition condition,
> >          ret =3D vhost_user_slave_handle_vring_host_notifier(dev,
> &payload.area,
> >                                                            fd ? fd[0] :
> -1);
> >          break;
> > +    case VHOST_USER_BACKEND_SHARED_OBJECT_ADD:
> > +        ret =3D
> vhost_user_backend_handle_shared_object_add(&payload.object,
> > +                                                          fd ? fd[0] :
> -1);
> > +        break;
> > +    case VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE:
> > +        ret =3D
> vhost_user_backend_handle_shared_object_remove(&payload.object);
> > +        break;
> > +    case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
> > +        ret =3D
> vhost_user_backend_handle_shared_object_lookup(dev->opaque, ioc,
> > +                                                             &hdr,
> &payload);
> > +        break;
> >      default:
> >          error_report("Received unexpected msg type: %d.", hdr.request)=
;
> >          ret =3D -EINVAL;
> > diff --git a/subprojects/libvhost-user/libvhost-user.c
> b/subprojects/libvhost-user/libvhost-user.c
> > index 8fb61e2df2..672d8292a0 100644
> > --- a/subprojects/libvhost-user/libvhost-user.c
> > +++ b/subprojects/libvhost-user/libvhost-user.c
> > @@ -1403,6 +1403,107 @@ bool vu_set_queue_host_notifier(VuDev *dev,
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
> > +        .request =3D VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP,
> > +        .size =3D sizeof(msg.payload.object),
> > +        .flags =3D VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MASK,
> > +    };
> > +
> > +    memcpy(msg.payload.object.uuid, uuid, sizeof(uuid[0]) * UUID_LEN);
> > +
> > +    if (!vu_has_protocol_feature(dev,
> VHOST_USER_PROTOCOL_F_SHARED_OBJECT)) {
> > +        return false;
> > +    }
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
> > +    if (msg_reply.fd_num !=3D 1) {
> > +        DPRINT("Received unexpected number of fds. Expected 1, receive=
d
> %d",
> > +               msg_reply.fd_num);
> > +        goto out;
> > +    }
> > +
> > +    *dmabuf_fd =3D msg_reply.fds[0];
> > +    result =3D *dmabuf_fd > 0 && msg_reply.payload.u64 =3D=3D 0;
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
> > +    int fd_num =3D 0;
> > +    VhostUserMsg msg =3D {
> > +        .request =3D VHOST_USER_BACKEND_SHARED_OBJECT_ADD,
> > +        .size =3D sizeof(msg.payload.object),
> > +        .flags =3D VHOST_USER_VERSION,
> > +    };
> > +
> > +    msg.fds[fd_num++] =3D dmabuf_fd;
> > +    msg.fd_num =3D fd_num;
> > +    memcpy(msg.payload.object.uuid, uuid, sizeof(uuid[0]) * UUID_LEN);
> > +
> > +    if (!vu_has_protocol_feature(dev,
> VHOST_USER_PROTOCOL_F_SHARED_OBJECT)) {
> > +        return false;
> > +    }
> > +
> > +    return vu_send_message(dev, &msg);
> > +}
> > +
> > +bool
> > +vu_rm_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN])
> > +{
> > +    VhostUserMsg msg =3D {
> > +        .request =3D VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE,
> > +        .size =3D sizeof(msg.payload.object),
> > +        .flags =3D VHOST_USER_VERSION,
> > +    };
> > +
> > +    memcpy(msg.payload.object.uuid, uuid, sizeof(uuid[0]) * UUID_LEN);
> > +
> > +    if (!vu_has_protocol_feature(dev,
> VHOST_USER_PROTOCOL_F_SHARED_OBJECT)) {
> > +        return false;
> > +    }
> > +
> > +    return vu_send_message(dev, &msg);
> > +}
> > +
> >  static bool
> >  vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
> >  {
> > diff --git a/subprojects/libvhost-user/libvhost-user.h
> b/subprojects/libvhost-user/libvhost-user.h
> > index 49208cceaa..907af1bcda 100644
> > --- a/subprojects/libvhost-user/libvhost-user.h
> > +++ b/subprojects/libvhost-user/libvhost-user.h
> > @@ -64,7 +64,8 @@ enum VhostUserProtocolFeature {
> >      VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD =3D 12,
> >      VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS =3D 14,
> >      VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS =3D 15,
> > -
> > +    /* Feature 16 is reserved for VHOST_USER_PROTOCOL_F_STATUS. */
> > +    VHOST_USER_PROTOCOL_F_SHARED_OBJECT =3D 17,
> >      VHOST_USER_PROTOCOL_F_MAX
> >  };
> >
> > @@ -119,6 +120,9 @@ typedef enum VhostUserSlaveRequest {
> >      VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG =3D 3,
> >      VHOST_USER_BACKEND_VRING_CALL =3D 4,
> >      VHOST_USER_BACKEND_VRING_ERR =3D 5,
> > +    VHOST_USER_BACKEND_SHARED_OBJECT_ADD =3D 6,
> > +    VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE =3D 7,
> > +    VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,
> >      VHOST_USER_BACKEND_MAX
> >  }  VhostUserSlaveRequest;
> >
> > @@ -172,6 +176,12 @@ typedef struct VhostUserInflight {
> >      uint16_t queue_size;
> >  } VhostUserInflight;
> >
> > +#define UUID_LEN 16
> > +
> > +typedef struct VhostUserShared {
> > +    unsigned char uuid[UUID_LEN];
> > +} VhostUserShared;
> > +
> >  #if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
> >  # define VU_PACKED __attribute__((gcc_struct, packed))
> >  #else
> > @@ -199,6 +209,7 @@ typedef struct VhostUserMsg {
> >          VhostUserConfig config;
> >          VhostUserVringArea area;
> >          VhostUserInflight inflight;
> > +        VhostUserShared object;
> >      } payload;
> >
> >      int fds[VHOST_MEMORY_BASELINE_NREGIONS];
> > @@ -539,6 +550,46 @@ void vu_set_queue_handler(VuDev *dev, VuVirtq *vq,
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

--0000000000002886b00600ad4a6d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Michael,<div><br></div><div>True. It may be a good idea=
 to impose a limit in the number of entries that can be added to the table.=
</div><div>And fail to add new entries once it reaches the limit.</div><div=
><br></div><div>Not sure what would be a good limit though. For example,=C2=
=A0<a href=3D"https://www.kernel.org/doc/html/v4.9/media/uapi/v4l/vidioc-re=
qbufs.html#c.v4l2_requestbuffers" target=3D"_blank">https://www.kernel.org/=
doc/html/v4.9/media/uapi/v4l/vidioc-reqbufs.html#c.v4l2_requestbuffers</a><=
/div><div>does not limit the number of buffers that can be allocated simult=
aneously, it is an unsigned 32-bits value.</div><div>However, I guess 16-bi=
ts (65535) would suffice to cover the vast majority of usecases. Or even lo=
wer, and</div><div>can be adjusted later, as this API gets (more) used.</di=
v><div><br></div><div>Does that make sense?</div><div><br></div><div>Thanks=
.</div><div>BR,</div><div>Albert</div></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 10, 2023 at 9:03=E2=80=AF=
PM Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blan=
k">mst@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On Mon, Jun 26, 2023 at 09:34:25AM +0200, Albert Esteve wr=
ote:<br>
&gt; Add three new vhost-user protocol<br>
&gt; `VHOST_USER_BACKEND_SHARED_OBJECT_* messages`.<br>
&gt; These new messages are sent from vhost-user<br>
&gt; back-ends to interact with the virtio-dmabuf<br>
&gt; table in order to add, remove, or lookup for<br>
&gt; virtio dma-buf shared objects.<br>
&gt; <br>
&gt; The action taken in the front-end depends<br>
&gt; on the type stored in the payload struct.<br>
&gt; <br>
&gt; In the libvhost-user library we need to add<br>
&gt; helper functions to allow sending messages to<br>
&gt; interact with the virtio shared objects<br>
&gt; hash table.<br>
&gt; <br>
&gt; The messages can only be sent after successfully<br>
&gt; negotiating a new VHOST_USER_PROTOCOL_F_SHARED_OBJECT<br>
&gt; vhost-user protocol feature bit.<br>
&gt; <br>
&gt; Signed-off-by: Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com"=
 target=3D"_blank">aesteve@redhat.com</a>&gt;<br>
<br>
It bothers me that apparently, any backend can now<br>
make qemu allocate any amount of memory by sending<br>
lots of add messages.<br>
<br>
Any way to limit this? If not - at least let&#39;s make this<br>
a property that&#39;s opt-in?<br>
<br>
<br>
&gt; ---<br>
&gt;=C2=A0 docs/interop/vhost-user.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 42 +++++++++<br>
&gt;=C2=A0 hw/virtio/vhost-user.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 99 +++++++++++++++++++++<br>
&gt;=C2=A0 subprojects/libvhost-user/libvhost-user.c | 101 ++++++++++++++++=
++++++<br>
&gt;=C2=A0 subprojects/libvhost-user/libvhost-user.h |=C2=A0 53 +++++++++++=
-<br>
&gt;=C2=A0 4 files changed, 294 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst=
<br>
&gt; index 5a070adbc1..bca5600ff1 100644<br>
&gt; --- a/docs/interop/vhost-user.rst<br>
&gt; +++ b/docs/interop/vhost-user.rst<br>
&gt; @@ -1528,6 +1528,48 @@ is sent by the front-end.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 The state.num field is currently reserved and must be set=
 to 0.<br>
&gt;=C2=A0 <br>
&gt; +``VHOST_USER_BACKEND_SHARED_OBJECT_ADD``<br>
&gt; +=C2=A0 :id: 6<br>
&gt; +=C2=A0 :equivalent ioctl: N/A<br>
&gt; +=C2=A0 :request payload: ``struct VhostUserShared``<br>
&gt; +=C2=A0 :reply payload: N/A<br>
&gt; +<br>
&gt; +=C2=A0 When the ``VHOST_USER_PROTOCOL_F_SHARED_OBJECT`` protocol<br>
&gt; +=C2=A0 feature has been successfully negotiated, this message can be =
submitted<br>
&gt; +=C2=A0 by the backends to add a new dma-buf fd to the virtio-dmabuf s=
hared<br>
&gt; +=C2=A0 table API can send this message. The fd gets associated with a=
 UUID.<br>
&gt; +=C2=A0 If ``VHOST_USER_PROTOCOL_F_REPLY_ACK`` is negotiated, and the =
back-end sets<br>
&gt; +=C2=A0 the ``VHOST_USER_NEED_REPLY`` flag, the front-end must respond=
 with zero when<br>
&gt; +=C2=A0 operation is successfully completed, or non-zero otherwise.<br=
>
&gt; +<br>
&gt; +``VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE``<br>
&gt; +=C2=A0 :id: 7<br>
&gt; +=C2=A0 :equivalent ioctl: N/A<br>
&gt; +=C2=A0 :request payload: ``struct VhostUserShared``<br>
&gt; +=C2=A0 :reply payload: N/A<br>
&gt; +<br>
&gt; +=C2=A0 When the ``VHOST_USER_PROTOCOL_F_SHARED_OBJECT`` protocol<br>
&gt; +=C2=A0 feature has been successfully negotiated, this message can be =
submitted<br>
&gt; +=C2=A0 by the backend to remove a dma-buf from to the virtio-dmabuf s=
hared<br>
&gt; +=C2=A0 table API can send this message. The shared table will remove =
the dma-buf<br>
&gt; +=C2=A0 fd associated with the UUID. If ``VHOST_USER_PROTOCOL_F_REPLY_=
ACK`` is<br>
&gt; +=C2=A0 negotiated, and the back-end sets the ``VHOST_USER_NEED_REPLY`=
` flag, the<br>
&gt; +=C2=A0 front-end must respond with zero when operation is successfull=
y completed,<br>
&gt; +=C2=A0 or non-zero otherwise.<br>
&gt; +<br>
&gt; +``VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP``<br>
&gt; +=C2=A0 :id: 8<br>
&gt; +=C2=A0 :equivalent ioctl: N/A<br>
&gt; +=C2=A0 :request payload: ``struct VhostUserShared``<br>
&gt; +=C2=A0 :reply payload: dmabuf fd and ``u64``<br>
&gt; +<br>
&gt; +=C2=A0 When the ``VHOST_USER_PROTOCOL_F_SHARED_OBJECT`` protocol<br>
&gt; +=C2=A0 feature has been successfully negotiated, this message can be =
submitted<br>
&gt; +=C2=A0 by the backends to retrieve a given dma-buf fd from the virtio=
-dmabuf<br>
&gt; +=C2=A0 shared table given a UUID. Frontend will reply passing the fd =
and a zero<br>
&gt; +=C2=A0 when the operation is successful, or non-zero otherwise. Note =
that if the<br>
&gt; +=C2=A0 operation fails, no fd is sent to the backend.<br>
&gt; +<br>
&gt;=C2=A0 .. _reply_ack:<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 VHOST_USER_PROTOCOL_F_REPLY_ACK<br>
&gt; diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c<br>
&gt; index 74a2a28663..e340c39a19 100644<br>
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
&gt; @@ -73,6 +75,7 @@ enum VhostUserProtocolFeature {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Feature 14 reserved for VHOST_USER_PROTOCOL_F_I=
NBAND_NOTIFICATIONS. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS =3D 15,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_PROTOCOL_F_STATUS =3D 16,<br>
&gt; +=C2=A0 =C2=A0 VHOST_USER_PROTOCOL_F_SHARED_OBJECT =3D 17,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_PROTOCOL_F_MAX<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt; @@ -128,6 +131,9 @@ typedef enum VhostUserSlaveRequest {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_IOTLB_MSG =3D 1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_CONFIG_CHANGE_MSG =3D 2,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG =3D 3,<=
br>
&gt; +=C2=A0 =C2=A0 VHOST_USER_BACKEND_SHARED_OBJECT_ADD =3D 6,<br>
&gt; +=C2=A0 =C2=A0 VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE =3D 7,<br>
&gt; +=C2=A0 =C2=A0 VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_MAX<br>
&gt;=C2=A0 }=C2=A0 VhostUserSlaveRequest;<br>
&gt;=C2=A0 <br>
&gt; @@ -190,6 +196,10 @@ typedef struct VhostUserInflight {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint16_t queue_size;<br>
&gt;=C2=A0 } VhostUserInflight;<br>
&gt;=C2=A0 <br>
&gt; +typedef struct VhostUserShared {<br>
&gt; +=C2=A0 =C2=A0 unsigned char uuid[16];<br>
&gt; +} VhostUserShared;<br>
&gt; +<br>
&gt;=C2=A0 typedef struct {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VhostUserRequest request;<br>
&gt;=C2=A0 <br>
&gt; @@ -214,6 +224,7 @@ typedef union {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserCryptoSession session;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserVringArea area;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserInflight inflight;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserShared object;<br>
&gt;=C2=A0 } VhostUserPayload;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 typedef struct VhostUserMsg {<br>
&gt; @@ -1582,6 +1593,83 @@ static int vhost_user_slave_handle_vring_host_n=
otifier(struct vhost_dev *dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +static int<br>
&gt; +vhost_user_backend_handle_shared_object_add(VhostUserShared *object,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 int dmabuf_fd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 QemuUUID uuid;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memcpy(uuid.data, object-&gt;uuid, sizeof(object-&gt;uu=
id));<br>
&gt; +=C2=A0 =C2=A0 return virtio_add_dmabuf(&amp;uuid, dmabuf_fd);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int<br>
&gt; +vhost_user_backend_handle_shared_object_remove(VhostUserShared *objec=
t)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 QemuUUID uuid;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memcpy(uuid.data, object-&gt;uuid, sizeof(object-&gt;uu=
id));<br>
&gt; +=C2=A0 =C2=A0 return virtio_remove_resource(&amp;uuid);<br>
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
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (hdr-&gt;flags &amp; VHOST_USER_NEED_REPLY_MASK) {<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hdr-&gt;flags &amp;=3D ~VHOST_USER_NEED_R=
EPLY_MASK;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 hdr-&gt;flags |=3D VHOST_USER_REPLY_MASK;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 hdr-&gt;size =3D sizeof(payload-&gt;u64);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 iov[0].iov_base =3D hdr;<br>
&gt; +=C2=A0 =C2=A0 iov[0].iov_len =3D VHOST_USER_HDR_SIZE;<br>
&gt; +=C2=A0 =C2=A0 iov[1].iov_base =3D payload;<br>
&gt; +=C2=A0 =C2=A0 iov[1].iov_len =3D hdr-&gt;size;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (qio_channel_writev_all(ioc, iov, ARRAY_SIZE(iov), &=
amp;local_err)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(local_err);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int<br>
&gt; +vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0QIOChannel *ioc,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0VhostUserHeader *hdr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0VhostUserPayload *payload)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 QemuUUID uuid;<br>
&gt; +=C2=A0 =C2=A0 CharBackend *chr =3D u-&gt;user-&gt;chr;<br>
&gt; +=C2=A0 =C2=A0 int dmabuf_fd =3D -1;<br>
&gt; +=C2=A0 =C2=A0 int fd_num =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memcpy(uuid.data, payload-&gt;object.uuid, sizeof(paylo=
ad-&gt;object.uuid));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dmabuf_fd =3D virtio_lookup_dmabuf(&amp;uuid);<br>
&gt; +=C2=A0 =C2=A0 if (dmabuf_fd !=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fd_num++;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 payload-&gt;u64 =3D 0;<br>
&gt; +=C2=A0 =C2=A0 if (qemu_chr_fe_set_msgfds(chr, &amp;dmabuf_fd, fd_num)=
 &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Failed to set msg fds.=
&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 payload-&gt;u64 =3D -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!vhost_user_backend_send_dmabuf_fd(ioc, hdr, payloa=
d)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Failed to write respon=
se msg.&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static void close_slave_channel(struct vhost_user *u)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_source_destroy(u-&gt;slave_src);<br>
&gt; @@ -1639,6 +1727,17 @@ static gboolean slave_read(QIOChannel *ioc, GIO=
Condition condition,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vhost_user_slave_handle_vrin=
g_host_notifier(dev, &amp;payload.area,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fd ? fd[=
0] : -1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case VHOST_USER_BACKEND_SHARED_OBJECT_ADD:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vhost_user_backend_handle_shared_=
object_add(&amp;payload.object,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fd ? fd[0] : -1=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vhost_user_backend_handle_shared_=
object_remove(&amp;payload.object);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vhost_user_backend_handle_shared_=
object_lookup(dev-&gt;opaque, ioc,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&a=
mp;hdr, &amp;payload);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Received unexpect=
ed msg type: %d.&quot;, hdr.request);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -EINVAL;<br>
&gt; diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/l=
ibvhost-user/libvhost-user.c<br>
&gt; index 8fb61e2df2..672d8292a0 100644<br>
&gt; --- a/subprojects/libvhost-user/libvhost-user.c<br>
&gt; +++ b/subprojects/libvhost-user/libvhost-user.c<br>
&gt; @@ -1403,6 +1403,107 @@ bool vu_set_queue_host_notifier(VuDev *dev, Vu=
Virtq *vq, int fd,<br>
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
JECT_LOOKUP,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .size =3D sizeof(msg.payload.object),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =3D VHOST_USER_VERSION | VHOST_USE=
R_NEED_REPLY_MASK,<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memcpy(msg.payload.object.uuid, uuid, sizeof(uuid[0]) *=
 UUID_LEN);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F=
_SHARED_OBJECT)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
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
&gt; +=C2=A0 =C2=A0 if (msg_reply.fd_num !=3D 1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINT(&quot;Received unexpected number o=
f fds. Expected 1, received %d&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg_reply.fd_n=
um);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 *dmabuf_fd =3D msg_reply.fds[0];<br>
&gt; +=C2=A0 =C2=A0 result =3D *dmabuf_fd &gt; 0 &amp;&amp; msg_reply.paylo=
ad.u64 =3D=3D 0;<br>
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
&gt; +=C2=A0 =C2=A0 int fd_num =3D 0;<br>
&gt; +=C2=A0 =C2=A0 VhostUserMsg msg =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .request =3D VHOST_USER_BACKEND_SHARED_OB=
JECT_ADD,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .size =3D sizeof(msg.payload.object),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =3D VHOST_USER_VERSION,<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 msg.fds[fd_num++] =3D dmabuf_fd;<br>
&gt; +=C2=A0 =C2=A0 msg.fd_num =3D fd_num;<br>
&gt; +=C2=A0 =C2=A0 memcpy(msg.payload.object.uuid, uuid, sizeof(uuid[0]) *=
 UUID_LEN);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F=
_SHARED_OBJECT)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return vu_send_message(dev, &amp;msg);<br>
&gt; +}<br>
&gt; +<br>
&gt; +bool<br>
&gt; +vu_rm_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN])<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VhostUserMsg msg =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .request =3D VHOST_USER_BACKEND_SHARED_OB=
JECT_REMOVE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .size =3D sizeof(msg.payload.object),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =3D VHOST_USER_VERSION,<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memcpy(msg.payload.object.uuid, uuid, sizeof(uuid[0]) *=
 UUID_LEN);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F=
_SHARED_OBJECT)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return vu_send_message(dev, &amp;msg);<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static bool<br>
&gt;=C2=A0 vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)<br>
&gt;=C2=A0 {<br>
&gt; diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/l=
ibvhost-user/libvhost-user.h<br>
&gt; index 49208cceaa..907af1bcda 100644<br>
&gt; --- a/subprojects/libvhost-user/libvhost-user.h<br>
&gt; +++ b/subprojects/libvhost-user/libvhost-user.h<br>
&gt; @@ -64,7 +64,8 @@ enum VhostUserProtocolFeature {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD =3D 12,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS =3D 14,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS =3D 15,<=
br>
&gt; -<br>
&gt; +=C2=A0 =C2=A0 /* Feature 16 is reserved for VHOST_USER_PROTOCOL_F_STA=
TUS. */<br>
&gt; +=C2=A0 =C2=A0 VHOST_USER_PROTOCOL_F_SHARED_OBJECT =3D 17,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_PROTOCOL_F_MAX<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt; @@ -119,6 +120,9 @@ typedef enum VhostUserSlaveRequest {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG =3D 3,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_VRING_CALL =3D 4,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_VRING_ERR =3D 5,<br>
&gt; +=C2=A0 =C2=A0 VHOST_USER_BACKEND_SHARED_OBJECT_ADD =3D 6,<br>
&gt; +=C2=A0 =C2=A0 VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE =3D 7,<br>
&gt; +=C2=A0 =C2=A0 VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_MAX<br>
&gt;=C2=A0 }=C2=A0 VhostUserSlaveRequest;<br>
&gt;=C2=A0 <br>
&gt; @@ -172,6 +176,12 @@ typedef struct VhostUserInflight {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint16_t queue_size;<br>
&gt;=C2=A0 } VhostUserInflight;<br>
&gt;=C2=A0 <br>
&gt; +#define UUID_LEN 16<br>
&gt; +<br>
&gt; +typedef struct VhostUserShared {<br>
&gt; +=C2=A0 =C2=A0 unsigned char uuid[UUID_LEN];<br>
&gt; +} VhostUserShared;<br>
&gt; +<br>
&gt;=C2=A0 #if defined(_WIN32) &amp;&amp; (defined(__x86_64__) || defined(_=
_i386__))<br>
&gt;=C2=A0 # define VU_PACKED __attribute__((gcc_struct, packed))<br>
&gt;=C2=A0 #else<br>
&gt; @@ -199,6 +209,7 @@ typedef struct VhostUserMsg {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserConfig config;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserVringArea area;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserInflight inflight;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserShared object;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 } payload;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 int fds[VHOST_MEMORY_BASELINE_NREGIONS];<br>
&gt; @@ -539,6 +550,46 @@ void vu_set_queue_handler(VuDev *dev, VuVirtq *vq=
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
nd<br>
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
</blockquote></div>

--0000000000002886b00600ad4a6d--


