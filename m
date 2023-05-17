Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFF9706020
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 08:31:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzAgO-00006j-CG; Wed, 17 May 2023 02:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1pzAgJ-00006N-MV
 for qemu-devel@nongnu.org; Wed, 17 May 2023 02:30:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1pzAgH-0008FI-DH
 for qemu-devel@nongnu.org; Wed, 17 May 2023 02:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684305036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wc5UQdB5h1ae1RanrZf444dL1TmfLLqxh1eHYAodvqo=;
 b=gYxOBQlNYmppdztSl7iS5NkBs6BDXugASzq4aQOnirGsBvwZT2HBRTAGkukf8HESshSu7a
 8p8n2wTzeSlQ1rH52mgFy9zCckU1Xqehz8XeXkQwdU66M2JN9i+drzIzZpwSpq7n0TcU2t
 40YCKpQpoQND6dlFd6UpV8EVqzVH0DA=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-A1qDdiV-OFa_p4J0Iq_7jA-1; Wed, 17 May 2023 02:30:35 -0400
X-MC-Unique: A1qDdiV-OFa_p4J0Iq_7jA-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-561902466b3so5535697b3.2
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 23:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684305034; x=1686897034;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wc5UQdB5h1ae1RanrZf444dL1TmfLLqxh1eHYAodvqo=;
 b=cqTh1n2URjiOhrk0Adyu22+wRQIPVbmyXg0Ze/lmT3z3xlLCL7Em6awd7bKpM7wU2S
 QNBgt8EDTYFacYEXrwWI8ihLVkFJY+952AgIVlKkWs5Bhg5YfWaiUobbc7TvROAv3hTD
 IwVsRwA82v8afpC3WBX0PwNYp49JSxGEJ/O5RkWz8zeA3jiKfYMVo0xXMxgCSYvelaWa
 /ou5RRGcwuvwizv1J3aZi7+I1emuGE1rZkjZ8LB8HWLZSQeBIH/ThJ7RzfdekOqF8aXg
 xRRxVsipbUBmyBkwzZjeBFuVFSHLELh7hrb+s0GIyjUr2413zNleKbKseU0cQYcgiLCR
 nP9A==
X-Gm-Message-State: AC+VfDzkErC123yMwPmQEdUpkdI8Dn5XQg3p4MDH4oPiR6KAQTLUmwQp
 iWBN5LUxsWzbxK5fFspdWbrdQX6I5mGQr7WYwRzxbUQ2dDcIuPYxmn8ukJm3gbtDiHIwCM3HQ7+
 L8Tq1p1VS0eZOWRutX1Y+Gv9cKRYvz7c=
X-Received: by 2002:a0d:dd52:0:b0:561:b476:6c4f with SMTP id
 g79-20020a0ddd52000000b00561b4766c4fmr2426608ywe.36.1684305034371; 
 Tue, 16 May 2023 23:30:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4NeNKc0cJhQx+yluRC8+3lp8lFtOR9X0aXJh+SirSB2zIlZ6mrH2C1CVpO7/cBwMNO31euIL1mDJhOS0Rqa9c=
X-Received: by 2002:a0d:dd52:0:b0:561:b476:6c4f with SMTP id
 g79-20020a0ddd52000000b00561b4766c4fmr2426590ywe.36.1684305034046; Tue, 16
 May 2023 23:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230509154435.1410162-1-eperezma@redhat.com>
 <20230509154435.1410162-6-eperezma@redhat.com>
 <CACGkMEvujW-VFhrxk8FD0d76UeT0Q3osYC5odqMHntwoTHmizA@mail.gmail.com>
In-Reply-To: <CACGkMEvujW-VFhrxk8FD0d76UeT0Q3osYC5odqMHntwoTHmizA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 17 May 2023 08:29:57 +0200
Message-ID: <CAJaqyWd8GbMrTCKPKz_65CUkg6a83Y3aRg41R4aSKLpnpFj23Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] vdpa: move CVQ isolation check to
 net_init_vhost_vdpa
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Parav Pandit <parav@mellanox.com>, 
 Zhu Lingshan <lingshan.zhu@intel.com>, longpeng2@huawei.com, 
 Stefano Garzarella <sgarzare@redhat.com>, Gautam Dawar <gdawar@xilinx.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, alvaro.karsz@solid-run.com, 
 Liuxiangdong <liuxiangdong5@huawei.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 si-wei.liu@oracle.com, 
 Shannon Nelson <snelson@pensando.io>, Lei Yang <leiyang@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Cindy Lu <lulu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On Wed, May 17, 2023 at 5:59=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, May 9, 2023 at 11:44=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > Evaluating it at start time instead of initialization time may make the
> > guest capable of dynamically adding or removing migration blockers.
> >
> > Also, moving to initialization reduces the number of ioctls in the
> > migration, reducing failure possibilities.
> >
> > As a drawback we need to check for CVQ isolation twice: one time with n=
o
> > MQ negotiated and another one acking it, as long as the device supports
> > it.  This is because Vring ASID / group management is based on vq
> > indexes, but we don't know the index of CVQ before negotiating MQ.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> > v2: Take out the reset of the device from vhost_vdpa_cvq_is_isolated
> > v3: Only record cvq_isolated, true if the device have cvq isolated in
> >     both !MQ and MQ configurations.
> > ---
> >  net/vhost-vdpa.c | 178 +++++++++++++++++++++++++++++++++++------------
> >  1 file changed, 135 insertions(+), 43 deletions(-)
> >
> > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > index 3fb833fe76..29054b77a9 100644
> > --- a/net/vhost-vdpa.c
> > +++ b/net/vhost-vdpa.c
> > @@ -43,6 +43,10 @@ typedef struct VhostVDPAState {
> >
> >      /* The device always have SVQ enabled */
> >      bool always_svq;
> > +
> > +    /* The device can isolate CVQ in its own ASID */
> > +    bool cvq_isolated;
> > +
> >      bool started;
> >  } VhostVDPAState;
> >
> > @@ -362,15 +366,8 @@ static NetClientInfo net_vhost_vdpa_info =3D {
> >          .check_peer_type =3D vhost_vdpa_check_peer_type,
> >  };
> >
> > -/**
> > - * Get vring virtqueue group
> > - *
> > - * @device_fd  vdpa device fd
> > - * @vq_index   Virtqueue index
> > - *
> > - * Return -errno in case of error, or vq group if success.
> > - */
> > -static int64_t vhost_vdpa_get_vring_group(int device_fd, unsigned vq_i=
ndex)
> > +static int64_t vhost_vdpa_get_vring_group(int device_fd, unsigned vq_i=
ndex,
> > +                                          Error **errp)
> >  {
> >      struct vhost_vring_state state =3D {
> >          .index =3D vq_index,
> > @@ -379,8 +376,7 @@ static int64_t vhost_vdpa_get_vring_group(int devic=
e_fd, unsigned vq_index)
> >
> >      if (unlikely(r < 0)) {
> >          r =3D -errno;
> > -        error_report("Cannot get VQ %u group: %s", vq_index,
> > -                     g_strerror(errno));
> > +        error_setg_errno(errp, errno, "Cannot get VQ %u group", vq_ind=
ex);
> >          return r;
> >      }
> >
> > @@ -480,9 +476,9 @@ static int vhost_vdpa_net_cvq_start(NetClientState =
*nc)
> >  {
> >      VhostVDPAState *s, *s0;
> >      struct vhost_vdpa *v;
> > -    uint64_t backend_features;
> >      int64_t cvq_group;
> > -    int cvq_index, r;
> > +    int r;
> > +    Error *err =3D NULL;
> >
> >      assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
> >
> > @@ -502,41 +498,22 @@ static int vhost_vdpa_net_cvq_start(NetClientStat=
e *nc)
> >      /*
> >       * If we early return in these cases SVQ will not be enabled. The =
migration
> >       * will be blocked as long as vhost-vdpa backends will not offer _=
F_LOG.
> > -     *
> > -     * Calling VHOST_GET_BACKEND_FEATURES as they are not available in=
 v->dev
> > -     * yet.
> >       */
> > -    r =3D ioctl(v->device_fd, VHOST_GET_BACKEND_FEATURES, &backend_fea=
tures);
> > -    if (unlikely(r < 0)) {
> > -        error_report("Cannot get vdpa backend_features: %s(%d)",
> > -            g_strerror(errno), errno);
> > -        return -1;
> > +    if (!vhost_vdpa_net_valid_svq_features(v->dev->features, NULL)) {
> > +        return 0;
> >      }
> > -    if (!(backend_features & BIT_ULL(VHOST_BACKEND_F_IOTLB_ASID)) ||
> > -        !vhost_vdpa_net_valid_svq_features(v->dev->features, NULL)) {
> > +
> > +    if (!s->cvq_isolated) {
> >          return 0;
> >      }
> >
> > -    /*
> > -     * Check if all the virtqueues of the virtio device are in a diffe=
rent vq
> > -     * than the last vq. VQ group of last group passed in cvq_group.
> > -     */
> > -    cvq_index =3D v->dev->vq_index_end - 1;
> > -    cvq_group =3D vhost_vdpa_get_vring_group(v->device_fd, cvq_index);
> > +    cvq_group =3D vhost_vdpa_get_vring_group(v->device_fd,
> > +                                           v->dev->vq_index_end - 1,
> > +                                           &err);
> >      if (unlikely(cvq_group < 0)) {
> > +        error_report_err(err);
> >          return cvq_group;
> >      }
> > -    for (int i =3D 0; i < cvq_index; ++i) {
> > -        int64_t group =3D vhost_vdpa_get_vring_group(v->device_fd, i);
> > -
> > -        if (unlikely(group < 0)) {
> > -            return group;
> > -        }
> > -
> > -        if (group =3D=3D cvq_group) {
> > -            return 0;
> > -        }
> > -    }
> >
> >      r =3D vhost_vdpa_set_address_space_id(v, cvq_group, VHOST_VDPA_NET=
_CVQ_ASID);
> >      if (unlikely(r < 0)) {
> > @@ -799,6 +776,111 @@ static const VhostShadowVirtqueueOps vhost_vdpa_n=
et_svq_ops =3D {
> >      .avail_handler =3D vhost_vdpa_net_handle_ctrl_avail,
> >  };
> >
> > +/**
> > + * Probe the device to check control virtqueue is isolated.
> > + *
> > + * @device_fd vhost-vdpa file descriptor
> > + * @features features to negotiate
> > + * @cvq_index Control vq index
> > + *
> > + * Returns -1 in case of error, 0 if false and 1 if true
> > + */
> > +static int vhost_vdpa_cvq_is_isolated(int device_fd, uint64_t features=
,
> > +                                      unsigned cvq_index, Error **errp=
)
> > +{
> > +    int64_t cvq_group;
> > +    int r;
> > +
> > +    r =3D vhost_vdpa_set_dev_features_fd(device_fd, features);
> > +    if (unlikely(r < 0)) {
> > +        error_setg_errno(errp, -r, "Cannot set device features");
> > +        return r;
> > +    }
> > +
> > +    cvq_group =3D vhost_vdpa_get_vring_group(device_fd, cvq_index, err=
p);
> > +    if (unlikely(cvq_group < 0)) {
> > +        return cvq_group;
> > +    }
> > +
> > +    for (int i =3D 0; i < cvq_index; ++i) {
> > +        int64_t group =3D vhost_vdpa_get_vring_group(device_fd, i, err=
p);
> > +
> > +        if (unlikely(group < 0)) {
> > +            return group;
> > +        }
> > +
> > +        if (group =3D=3D (int64_t)cvq_group) {
> > +            return 0;
> > +        }
> > +    }
> > +
> > +    return 1;
> > +}
> > +
> > +/**
> > + * Probe if CVQ is isolated when the device is MQ and when it is not M=
Q
> > + *
> > + * @device_fd         The vdpa device fd
> > + * @features          Features offered by the device.
> > + * @cvq_index         The control vq index if mq is negotiated. Ignore=
d
> > + *                    otherwise.
> > + *
> > + * Returns <0 in case of failure, 0 if false and 1 if true.
> > + */
> > +static int vhost_vdpa_probe_cvq_isolation(int device_fd, uint64_t feat=
ures,
> > +                                          int cvq_index, Error **errp)
> > +{
> > +    uint64_t backend_features;
> > +    int r;
> > +
> > +    ERRP_GUARD();
> > +
> > +    r =3D ioctl(device_fd, VHOST_GET_BACKEND_FEATURES, &backend_featur=
es);
> > +    if (unlikely(r < 0)) {
> > +        error_setg_errno(errp, errno, "Cannot get vdpa backend_feature=
s");
> > +        return r;
> > +    }
> > +
> > +    if (!(backend_features & BIT_ULL(VHOST_BACKEND_F_IOTLB_ASID))) {
> > +        return 0;
> > +    }
> > +
> > +    r =3D vhost_vdpa_cvq_is_isolated(device_fd,
> > +                                   features & ~BIT_ULL(VIRTIO_NET_F_MQ=
), 2,
> > +                                   errp);
> > +    if (unlikely(r < 0)) {
> > +        if (r !=3D -ENOTSUP) {
> > +            return r;
> > +        }
> > +
> > +        /*
> > +         * The kernel report VHOST_BACKEND_F_IOTLB_ASID if the vdpa fr=
ontend
> > +         * support ASID even if the parent driver does not.  The CVQ c=
annot be
> > +         * isolated in this case.
> > +         */
> > +        error_free(*errp);
> > +        *errp =3D NULL;
> > +        return 0;
> > +    }
> > +
> > +    if (r =3D=3D 0) {
> > +        return 0;
> > +    }
> > +
> > +    vhost_vdpa_reset_status_fd(device_fd);
> > +    if (!(features & BIT_ULL(VIRTIO_NET_F_MQ))) {
> > +        return 0;
> > +    }
> > +
> > +    r =3D vhost_vdpa_cvq_is_isolated(device_fd, features, cvq_index * =
2, errp);
>
> I think checking this once should be sufficient. That is to say, it
> should be a bug if there's hardware that puts cvq in a dedicated group
> in MQ but not in SQ.
>

This is checking the NIC is not buggy :). Otherwise, we're giving
access to the guest to the CVQ shadow vring. And, currently, SVQ code
assumes only QEMU can access it.

But maybe this made more sense in previous versions, where the series
also cached the cvq group here. If I understand you correctly, it is
enough to check that CVQ is isolated in SQ, and assume it will be
isolated also in MQ, right? I can modify the patch that way if you
confirm this.

Thanks!

> Thanks
>
> > +    if (unlikely(r < 0)) {
> > +        return r;
> > +    }
> > +
> > +    vhost_vdpa_reset_status_fd(device_fd);
> > +    return r;
> > +}
> > +
> >  static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
> >                                         const char *device,
> >                                         const char *name,
> > @@ -808,16 +890,25 @@ static NetClientState *net_vhost_vdpa_init(NetCli=
entState *peer,
> >                                         bool is_datapath,
> >                                         bool svq,
> >                                         struct vhost_vdpa_iova_range io=
va_range,
> > -                                       uint64_t features)
> > +                                       uint64_t features,
> > +                                       Error **errp)
> >  {
> >      NetClientState *nc =3D NULL;
> >      VhostVDPAState *s;
> >      int ret =3D 0;
> >      assert(name);
> > +    int cvq_isolated;
> > +
> >      if (is_datapath) {
> >          nc =3D qemu_new_net_client(&net_vhost_vdpa_info, peer, device,
> >                                   name);
> >      } else {
> > +        cvq_isolated =3D vhost_vdpa_probe_cvq_isolation(vdpa_device_fd=
, features,
> > +                                                      queue_pair_index=
, errp);
> > +        if (unlikely(cvq_isolated < 0)) {
> > +            return NULL;
> > +        }
> > +
> >          nc =3D qemu_new_net_control_client(&net_vhost_vdpa_cvq_info, p=
eer,
> >                                           device, name);
> >      }
> > @@ -844,6 +935,7 @@ static NetClientState *net_vhost_vdpa_init(NetClien=
tState *peer,
> >
> >          s->vhost_vdpa.shadow_vq_ops =3D &vhost_vdpa_net_svq_ops;
> >          s->vhost_vdpa.shadow_vq_ops_opaque =3D s;
> > +        s->cvq_isolated =3D cvq_isolated;
> >
> >          /*
> >           * TODO: We cannot migrate devices with CVQ as there is no way=
 to set
> > @@ -972,7 +1064,7 @@ int net_init_vhost_vdpa(const Netdev *netdev, cons=
t char *name,
> >      for (i =3D 0; i < queue_pairs; i++) {
> >          ncs[i] =3D net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name,
> >                                       vdpa_device_fd, i, 2, true, opts-=
>x_svq,
> > -                                     iova_range, features);
> > +                                     iova_range, features, errp);
> >          if (!ncs[i])
> >              goto err;
> >      }
> > @@ -980,7 +1072,7 @@ int net_init_vhost_vdpa(const Netdev *netdev, cons=
t char *name,
> >      if (has_cvq) {
> >          nc =3D net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name,
> >                                   vdpa_device_fd, i, 1, false,
> > -                                 opts->x_svq, iova_range, features);
> > +                                 opts->x_svq, iova_range, features, er=
rp);
> >          if (!nc)
> >              goto err;
> >      }
> > --
> > 2.31.1
> >
>


