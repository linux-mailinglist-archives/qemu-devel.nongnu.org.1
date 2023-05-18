Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B417079DA
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 07:51:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzWX0-0001s4-4G; Thu, 18 May 2023 01:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1pzWWn-0001rX-LE
 for qemu-devel@nongnu.org; Thu, 18 May 2023 01:50:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1pzWWe-0001hZ-Ot
 for qemu-devel@nongnu.org; Thu, 18 May 2023 01:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684389007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dX2oOqOh6EgGnRUVjT8rVogWTy+niEDOasc51dPMzlQ=;
 b=YhfElayqvq5rILfb4k++E/I8Exoqb8dCMdgFVjpujHbprWmai/lnMg6Oa2tHDt4M8tyLDb
 qP4kWYnJGnDfc08YaNwJq6lDbJhnscTZZCIusVY4F5fCkibXOKDAwGmyVgRpNZnVHIcNTV
 uMmApsM8YflNgVlgXCDuMfr3lGJi6LM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-wDKlfwn6NBe5fCyGbzuwvw-1; Thu, 18 May 2023 01:50:06 -0400
X-MC-Unique: wDKlfwn6NBe5fCyGbzuwvw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4f39ae34494so713504e87.2
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 22:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684389004; x=1686981004;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dX2oOqOh6EgGnRUVjT8rVogWTy+niEDOasc51dPMzlQ=;
 b=MJjZjQNVqAGlKb0qUuekG6FmR/82KyERWTQZUUTAgHAQYlc9I3pTDe01EgS8lMBk+J
 FHmH6RNnn1Z5lGiaJf/r9ZuyC1hAttQjtfI1UQTRNMqpkkF7iXvpcj2CvovbpV2T2f+b
 0p4zx25OSOG4DJp/ywHoWQkVT5VkKc+ZT1CF3BvWnXMP8qdrpEE90S8iMHbGw5+JpmZ4
 mmbDi+d3DE4CSjWoTgoZj2WR4P9kfT3HO/skSLXbzFcKspH0sgV7Ow2MGEQET6uf/5bx
 GrZ7KslN9OEWhnMVCXlReIoI1Lfvv597uKYZzYvHwFV27Oo6+O64JwzgPfTrllJJ4ZAd
 tKWw==
X-Gm-Message-State: AC+VfDwVjh3a0fjj1p+OX9Ko01VLIwidq4odBORnb6YRrz+Qw3MVRt/8
 4HBdizjbBGGv6ttUPW9pC2veUpa9wyVYZOmwAXFSm2GDjmIdRM8SSF4Kkr+dw4zJOrf1B7bk6Ge
 kS9FGJ+qZloowJ48tGK4/k7aXbRD/I7M=
X-Received: by 2002:ac2:4e45:0:b0:4f3:9f9b:ad09 with SMTP id
 f5-20020ac24e45000000b004f39f9bad09mr544877lfr.38.1684389004548; 
 Wed, 17 May 2023 22:50:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7CZb4DxmOLwROCrGE7u2B+qPgZ2WFk2Vumoqrsvoc/GCxsyXS6exzjJDWR/iGz1kO8HNgYJRC6+fd3RhIV6s8=
X-Received: by 2002:ac2:4e45:0:b0:4f3:9f9b:ad09 with SMTP id
 f5-20020ac24e45000000b004f39f9bad09mr544872lfr.38.1684389004182; Wed, 17 May
 2023 22:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230509154435.1410162-1-eperezma@redhat.com>
 <20230509154435.1410162-6-eperezma@redhat.com>
 <CACGkMEvujW-VFhrxk8FD0d76UeT0Q3osYC5odqMHntwoTHmizA@mail.gmail.com>
 <CAJaqyWd8GbMrTCKPKz_65CUkg6a83Y3aRg41R4aSKLpnpFj23Q@mail.gmail.com>
In-Reply-To: <CAJaqyWd8GbMrTCKPKz_65CUkg6a83Y3aRg41R4aSKLpnpFj23Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 May 2023 13:49:53 +0800
Message-ID: <CACGkMEutrxhYOEozQq1scXaPXDVfX+ZRcLr4+w8CvODoxJqTjQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] vdpa: move CVQ isolation check to
 net_init_vhost_vdpa
To: Eugenio Perez Martin <eperezma@redhat.com>
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
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, May 17, 2023 at 2:30=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, May 17, 2023 at 5:59=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Tue, May 9, 2023 at 11:44=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
> > >
> > > Evaluating it at start time instead of initialization time may make t=
he
> > > guest capable of dynamically adding or removing migration blockers.
> > >
> > > Also, moving to initialization reduces the number of ioctls in the
> > > migration, reducing failure possibilities.
> > >
> > > As a drawback we need to check for CVQ isolation twice: one time with=
 no
> > > MQ negotiated and another one acking it, as long as the device suppor=
ts
> > > it.  This is because Vring ASID / group management is based on vq
> > > indexes, but we don't know the index of CVQ before negotiating MQ.
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > > v2: Take out the reset of the device from vhost_vdpa_cvq_is_isolated
> > > v3: Only record cvq_isolated, true if the device have cvq isolated in
> > >     both !MQ and MQ configurations.
> > > ---
> > >  net/vhost-vdpa.c | 178 +++++++++++++++++++++++++++++++++++----------=
--
> > >  1 file changed, 135 insertions(+), 43 deletions(-)
> > >
> > > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > > index 3fb833fe76..29054b77a9 100644
> > > --- a/net/vhost-vdpa.c
> > > +++ b/net/vhost-vdpa.c
> > > @@ -43,6 +43,10 @@ typedef struct VhostVDPAState {
> > >
> > >      /* The device always have SVQ enabled */
> > >      bool always_svq;
> > > +
> > > +    /* The device can isolate CVQ in its own ASID */
> > > +    bool cvq_isolated;
> > > +
> > >      bool started;
> > >  } VhostVDPAState;
> > >
> > > @@ -362,15 +366,8 @@ static NetClientInfo net_vhost_vdpa_info =3D {
> > >          .check_peer_type =3D vhost_vdpa_check_peer_type,
> > >  };
> > >
> > > -/**
> > > - * Get vring virtqueue group
> > > - *
> > > - * @device_fd  vdpa device fd
> > > - * @vq_index   Virtqueue index
> > > - *
> > > - * Return -errno in case of error, or vq group if success.
> > > - */
> > > -static int64_t vhost_vdpa_get_vring_group(int device_fd, unsigned vq=
_index)
> > > +static int64_t vhost_vdpa_get_vring_group(int device_fd, unsigned vq=
_index,
> > > +                                          Error **errp)
> > >  {
> > >      struct vhost_vring_state state =3D {
> > >          .index =3D vq_index,
> > > @@ -379,8 +376,7 @@ static int64_t vhost_vdpa_get_vring_group(int dev=
ice_fd, unsigned vq_index)
> > >
> > >      if (unlikely(r < 0)) {
> > >          r =3D -errno;
> > > -        error_report("Cannot get VQ %u group: %s", vq_index,
> > > -                     g_strerror(errno));
> > > +        error_setg_errno(errp, errno, "Cannot get VQ %u group", vq_i=
ndex);
> > >          return r;
> > >      }
> > >
> > > @@ -480,9 +476,9 @@ static int vhost_vdpa_net_cvq_start(NetClientStat=
e *nc)
> > >  {
> > >      VhostVDPAState *s, *s0;
> > >      struct vhost_vdpa *v;
> > > -    uint64_t backend_features;
> > >      int64_t cvq_group;
> > > -    int cvq_index, r;
> > > +    int r;
> > > +    Error *err =3D NULL;
> > >
> > >      assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
> > >
> > > @@ -502,41 +498,22 @@ static int vhost_vdpa_net_cvq_start(NetClientSt=
ate *nc)
> > >      /*
> > >       * If we early return in these cases SVQ will not be enabled. Th=
e migration
> > >       * will be blocked as long as vhost-vdpa backends will not offer=
 _F_LOG.
> > > -     *
> > > -     * Calling VHOST_GET_BACKEND_FEATURES as they are not available =
in v->dev
> > > -     * yet.
> > >       */
> > > -    r =3D ioctl(v->device_fd, VHOST_GET_BACKEND_FEATURES, &backend_f=
eatures);
> > > -    if (unlikely(r < 0)) {
> > > -        error_report("Cannot get vdpa backend_features: %s(%d)",
> > > -            g_strerror(errno), errno);
> > > -        return -1;
> > > +    if (!vhost_vdpa_net_valid_svq_features(v->dev->features, NULL)) =
{
> > > +        return 0;
> > >      }
> > > -    if (!(backend_features & BIT_ULL(VHOST_BACKEND_F_IOTLB_ASID)) ||
> > > -        !vhost_vdpa_net_valid_svq_features(v->dev->features, NULL)) =
{
> > > +
> > > +    if (!s->cvq_isolated) {
> > >          return 0;
> > >      }
> > >
> > > -    /*
> > > -     * Check if all the virtqueues of the virtio device are in a dif=
ferent vq
> > > -     * than the last vq. VQ group of last group passed in cvq_group.
> > > -     */
> > > -    cvq_index =3D v->dev->vq_index_end - 1;
> > > -    cvq_group =3D vhost_vdpa_get_vring_group(v->device_fd, cvq_index=
);
> > > +    cvq_group =3D vhost_vdpa_get_vring_group(v->device_fd,
> > > +                                           v->dev->vq_index_end - 1,
> > > +                                           &err);
> > >      if (unlikely(cvq_group < 0)) {
> > > +        error_report_err(err);
> > >          return cvq_group;
> > >      }
> > > -    for (int i =3D 0; i < cvq_index; ++i) {
> > > -        int64_t group =3D vhost_vdpa_get_vring_group(v->device_fd, i=
);
> > > -
> > > -        if (unlikely(group < 0)) {
> > > -            return group;
> > > -        }
> > > -
> > > -        if (group =3D=3D cvq_group) {
> > > -            return 0;
> > > -        }
> > > -    }
> > >
> > >      r =3D vhost_vdpa_set_address_space_id(v, cvq_group, VHOST_VDPA_N=
ET_CVQ_ASID);
> > >      if (unlikely(r < 0)) {
> > > @@ -799,6 +776,111 @@ static const VhostShadowVirtqueueOps vhost_vdpa=
_net_svq_ops =3D {
> > >      .avail_handler =3D vhost_vdpa_net_handle_ctrl_avail,
> > >  };
> > >
> > > +/**
> > > + * Probe the device to check control virtqueue is isolated.
> > > + *
> > > + * @device_fd vhost-vdpa file descriptor
> > > + * @features features to negotiate
> > > + * @cvq_index Control vq index
> > > + *
> > > + * Returns -1 in case of error, 0 if false and 1 if true
> > > + */
> > > +static int vhost_vdpa_cvq_is_isolated(int device_fd, uint64_t featur=
es,
> > > +                                      unsigned cvq_index, Error **er=
rp)
> > > +{
> > > +    int64_t cvq_group;
> > > +    int r;
> > > +
> > > +    r =3D vhost_vdpa_set_dev_features_fd(device_fd, features);
> > > +    if (unlikely(r < 0)) {
> > > +        error_setg_errno(errp, -r, "Cannot set device features");
> > > +        return r;
> > > +    }
> > > +
> > > +    cvq_group =3D vhost_vdpa_get_vring_group(device_fd, cvq_index, e=
rrp);
> > > +    if (unlikely(cvq_group < 0)) {
> > > +        return cvq_group;
> > > +    }
> > > +
> > > +    for (int i =3D 0; i < cvq_index; ++i) {
> > > +        int64_t group =3D vhost_vdpa_get_vring_group(device_fd, i, e=
rrp);
> > > +
> > > +        if (unlikely(group < 0)) {
> > > +            return group;
> > > +        }
> > > +
> > > +        if (group =3D=3D (int64_t)cvq_group) {
> > > +            return 0;
> > > +        }
> > > +    }
> > > +
> > > +    return 1;
> > > +}
> > > +
> > > +/**
> > > + * Probe if CVQ is isolated when the device is MQ and when it is not=
 MQ
> > > + *
> > > + * @device_fd         The vdpa device fd
> > > + * @features          Features offered by the device.
> > > + * @cvq_index         The control vq index if mq is negotiated. Igno=
red
> > > + *                    otherwise.
> > > + *
> > > + * Returns <0 in case of failure, 0 if false and 1 if true.
> > > + */
> > > +static int vhost_vdpa_probe_cvq_isolation(int device_fd, uint64_t fe=
atures,
> > > +                                          int cvq_index, Error **err=
p)
> > > +{
> > > +    uint64_t backend_features;
> > > +    int r;
> > > +
> > > +    ERRP_GUARD();
> > > +
> > > +    r =3D ioctl(device_fd, VHOST_GET_BACKEND_FEATURES, &backend_feat=
ures);
> > > +    if (unlikely(r < 0)) {
> > > +        error_setg_errno(errp, errno, "Cannot get vdpa backend_featu=
res");
> > > +        return r;
> > > +    }
> > > +
> > > +    if (!(backend_features & BIT_ULL(VHOST_BACKEND_F_IOTLB_ASID))) {
> > > +        return 0;
> > > +    }
> > > +
> > > +    r =3D vhost_vdpa_cvq_is_isolated(device_fd,
> > > +                                   features & ~BIT_ULL(VIRTIO_NET_F_=
MQ), 2,
> > > +                                   errp);
> > > +    if (unlikely(r < 0)) {
> > > +        if (r !=3D -ENOTSUP) {
> > > +            return r;
> > > +        }
> > > +
> > > +        /*
> > > +         * The kernel report VHOST_BACKEND_F_IOTLB_ASID if the vdpa =
frontend
> > > +         * support ASID even if the parent driver does not.  The CVQ=
 cannot be
> > > +         * isolated in this case.
> > > +         */
> > > +        error_free(*errp);
> > > +        *errp =3D NULL;
> > > +        return 0;
> > > +    }
> > > +
> > > +    if (r =3D=3D 0) {
> > > +        return 0;
> > > +    }
> > > +
> > > +    vhost_vdpa_reset_status_fd(device_fd);
> > > +    if (!(features & BIT_ULL(VIRTIO_NET_F_MQ))) {
> > > +        return 0;
> > > +    }
> > > +
> > > +    r =3D vhost_vdpa_cvq_is_isolated(device_fd, features, cvq_index =
* 2, errp);
> >
> > I think checking this once should be sufficient. That is to say, it
> > should be a bug if there's hardware that puts cvq in a dedicated group
> > in MQ but not in SQ.
> >
>
> This is checking the NIC is not buggy :). Otherwise, we're giving
> access to the guest to the CVQ shadow vring. And, currently, SVQ code
> assumes only QEMU can access it.

Just to make sure we are at the same page, I meant, the hardware
should be buggy if the isolation of cvq is not consistent between
single and multiqueue.

>
> But maybe this made more sense in previous versions, where the series
> also cached the cvq group here. If I understand you correctly, it is
> enough to check that CVQ is isolated in SQ, and assume it will be
> isolated also in MQ, right? I can modify the patch that way if you
> confirm this.

I think so, or just negotiate with what hardware provides us and check.

Thanks

>
> Thanks!
>
> > Thanks
> >
> > > +    if (unlikely(r < 0)) {
> > > +        return r;
> > > +    }
> > > +
> > > +    vhost_vdpa_reset_status_fd(device_fd);
> > > +    return r;
> > > +}
> > > +
> > >  static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
> > >                                         const char *device,
> > >                                         const char *name,
> > > @@ -808,16 +890,25 @@ static NetClientState *net_vhost_vdpa_init(NetC=
lientState *peer,
> > >                                         bool is_datapath,
> > >                                         bool svq,
> > >                                         struct vhost_vdpa_iova_range =
iova_range,
> > > -                                       uint64_t features)
> > > +                                       uint64_t features,
> > > +                                       Error **errp)
> > >  {
> > >      NetClientState *nc =3D NULL;
> > >      VhostVDPAState *s;
> > >      int ret =3D 0;
> > >      assert(name);
> > > +    int cvq_isolated;
> > > +
> > >      if (is_datapath) {
> > >          nc =3D qemu_new_net_client(&net_vhost_vdpa_info, peer, devic=
e,
> > >                                   name);
> > >      } else {
> > > +        cvq_isolated =3D vhost_vdpa_probe_cvq_isolation(vdpa_device_=
fd, features,
> > > +                                                      queue_pair_ind=
ex, errp);
> > > +        if (unlikely(cvq_isolated < 0)) {
> > > +            return NULL;
> > > +        }
> > > +
> > >          nc =3D qemu_new_net_control_client(&net_vhost_vdpa_cvq_info,=
 peer,
> > >                                           device, name);
> > >      }
> > > @@ -844,6 +935,7 @@ static NetClientState *net_vhost_vdpa_init(NetCli=
entState *peer,
> > >
> > >          s->vhost_vdpa.shadow_vq_ops =3D &vhost_vdpa_net_svq_ops;
> > >          s->vhost_vdpa.shadow_vq_ops_opaque =3D s;
> > > +        s->cvq_isolated =3D cvq_isolated;
> > >
> > >          /*
> > >           * TODO: We cannot migrate devices with CVQ as there is no w=
ay to set
> > > @@ -972,7 +1064,7 @@ int net_init_vhost_vdpa(const Netdev *netdev, co=
nst char *name,
> > >      for (i =3D 0; i < queue_pairs; i++) {
> > >          ncs[i] =3D net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name,
> > >                                       vdpa_device_fd, i, 2, true, opt=
s->x_svq,
> > > -                                     iova_range, features);
> > > +                                     iova_range, features, errp);
> > >          if (!ncs[i])
> > >              goto err;
> > >      }
> > > @@ -980,7 +1072,7 @@ int net_init_vhost_vdpa(const Netdev *netdev, co=
nst char *name,
> > >      if (has_cvq) {
> > >          nc =3D net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name,
> > >                                   vdpa_device_fd, i, 1, false,
> > > -                                 opts->x_svq, iova_range, features);
> > > +                                 opts->x_svq, iova_range, features, =
errp);
> > >          if (!nc)
> > >              goto err;
> > >      }
> > > --
> > > 2.31.1
> > >
> >
>


