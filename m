Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DCC707A4C
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 08:38:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzXG8-0001WB-GX; Thu, 18 May 2023 02:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1pzXG5-0001TO-7W
 for qemu-devel@nongnu.org; Thu, 18 May 2023 02:37:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1pzXG2-00015B-Fl
 for qemu-devel@nongnu.org; Thu, 18 May 2023 02:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684391821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N/G+aiD6oX31CJbDKq3iVutsLM1PrkSy0z8ZcIlzAXk=;
 b=eI4pUIKraBd9D/65WwxA7Bt1Q6d1gCKbnRtt60o4n6q53gDYqh03Xr2NkYMVAkSv6i4VK7
 vm6MKUkLk3foY14x9G4a5ilbc0pfnnRSHlUNJZ0jUiU/bemHZvvHAz9vo4vWg1AQ4blLTu
 E/aZo4d0xJiqZcmiWitq+3B4PRePwMw=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-S3ZRLfG5MDaEzXuMDXsVzA-1; Thu, 18 May 2023 02:36:59 -0400
X-MC-Unique: S3ZRLfG5MDaEzXuMDXsVzA-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-561b265e237so25639917b3.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 23:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684391819; x=1686983819;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N/G+aiD6oX31CJbDKq3iVutsLM1PrkSy0z8ZcIlzAXk=;
 b=dUnSy5k7XwmOe2iZFPkIN0YVHLJMusAlbv/HP7AlnSGF22JOKmwfBlV80mw3zUP8d9
 3zna+SeCG79hBF82wPf/bYei39sKbHqjspktfVdc8rxdz+MFlncZRXqvbcczqJ5oLQnA
 FH81aW36T1x9ts81MSn0faXXGorngQ4G1FG72gfbJUQAGApQv/t7bh7onJAT5zBiEMAU
 SE0Zhw3F0Kl2PVn4j2zJraB2u6SePQFOc/pnALbZaxA91MXKnWBsgzqdgFa5BHJWnEi7
 5h3Rl7nDaqYX7Ux/FQWz0Z6+ELJvML7W/Fyv85eZjPHuNo676xV9PaQnnJQ29RciZbZp
 0gpQ==
X-Gm-Message-State: AC+VfDw90mO3EsGMX2DfsGbWAJbgZ6/+hXAJY9Nuuu5KmaboANNc80+N
 qmCoAkpHmwT6omJTpWJR3HjfQNWwzAYvfZ3sP/HmEkbhxlUYBHTnkQJxU53WFCpsMjdQIFnrXBU
 rDb074VxmzcCMTyxvVIkteH7aL3QDHq8=
X-Received: by 2002:a81:4851:0:b0:55a:9e43:7efe with SMTP id
 v78-20020a814851000000b0055a9e437efemr489962ywa.44.1684391818769; 
 Wed, 17 May 2023 23:36:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6hxUKeyZiJ1ygfjflql4s7brMcpAEIWCXe275uSCIZggTLu6CYEmekb/REcEPvQBSSC4ByrQx8Qc/6pA/t96Q=
X-Received: by 2002:a81:4851:0:b0:55a:9e43:7efe with SMTP id
 v78-20020a814851000000b0055a9e437efemr489945ywa.44.1684391818473; Wed, 17 May
 2023 23:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230509154435.1410162-1-eperezma@redhat.com>
 <20230509154435.1410162-6-eperezma@redhat.com>
 <CACGkMEvujW-VFhrxk8FD0d76UeT0Q3osYC5odqMHntwoTHmizA@mail.gmail.com>
 <CAJaqyWd8GbMrTCKPKz_65CUkg6a83Y3aRg41R4aSKLpnpFj23Q@mail.gmail.com>
 <CACGkMEutrxhYOEozQq1scXaPXDVfX+ZRcLr4+w8CvODoxJqTjQ@mail.gmail.com>
In-Reply-To: <CACGkMEutrxhYOEozQq1scXaPXDVfX+ZRcLr4+w8CvODoxJqTjQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 18 May 2023 08:36:22 +0200
Message-ID: <CAJaqyWe=cop=M_kz7JazvnCboaMAqA4xuVO7WBS9rks83JHgkw@mail.gmail.com>
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
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

On Thu, May 18, 2023 at 7:50=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, May 17, 2023 at 2:30=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Wed, May 17, 2023 at 5:59=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Tue, May 9, 2023 at 11:44=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@=
redhat.com> wrote:
> > > >
> > > > Evaluating it at start time instead of initialization time may make=
 the
> > > > guest capable of dynamically adding or removing migration blockers.
> > > >
> > > > Also, moving to initialization reduces the number of ioctls in the
> > > > migration, reducing failure possibilities.
> > > >
> > > > As a drawback we need to check for CVQ isolation twice: one time wi=
th no
> > > > MQ negotiated and another one acking it, as long as the device supp=
orts
> > > > it.  This is because Vring ASID / group management is based on vq
> > > > indexes, but we don't know the index of CVQ before negotiating MQ.
> > > >
> > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > ---
> > > > v2: Take out the reset of the device from vhost_vdpa_cvq_is_isolate=
d
> > > > v3: Only record cvq_isolated, true if the device have cvq isolated =
in
> > > >     both !MQ and MQ configurations.
> > > > ---
> > > >  net/vhost-vdpa.c | 178 +++++++++++++++++++++++++++++++++++--------=
----
> > > >  1 file changed, 135 insertions(+), 43 deletions(-)
> > > >
> > > > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > > > index 3fb833fe76..29054b77a9 100644
> > > > --- a/net/vhost-vdpa.c
> > > > +++ b/net/vhost-vdpa.c
> > > > @@ -43,6 +43,10 @@ typedef struct VhostVDPAState {
> > > >
> > > >      /* The device always have SVQ enabled */
> > > >      bool always_svq;
> > > > +
> > > > +    /* The device can isolate CVQ in its own ASID */
> > > > +    bool cvq_isolated;
> > > > +
> > > >      bool started;
> > > >  } VhostVDPAState;
> > > >
> > > > @@ -362,15 +366,8 @@ static NetClientInfo net_vhost_vdpa_info =3D {
> > > >          .check_peer_type =3D vhost_vdpa_check_peer_type,
> > > >  };
> > > >
> > > > -/**
> > > > - * Get vring virtqueue group
> > > > - *
> > > > - * @device_fd  vdpa device fd
> > > > - * @vq_index   Virtqueue index
> > > > - *
> > > > - * Return -errno in case of error, or vq group if success.
> > > > - */
> > > > -static int64_t vhost_vdpa_get_vring_group(int device_fd, unsigned =
vq_index)
> > > > +static int64_t vhost_vdpa_get_vring_group(int device_fd, unsigned =
vq_index,
> > > > +                                          Error **errp)
> > > >  {
> > > >      struct vhost_vring_state state =3D {
> > > >          .index =3D vq_index,
> > > > @@ -379,8 +376,7 @@ static int64_t vhost_vdpa_get_vring_group(int d=
evice_fd, unsigned vq_index)
> > > >
> > > >      if (unlikely(r < 0)) {
> > > >          r =3D -errno;
> > > > -        error_report("Cannot get VQ %u group: %s", vq_index,
> > > > -                     g_strerror(errno));
> > > > +        error_setg_errno(errp, errno, "Cannot get VQ %u group", vq=
_index);
> > > >          return r;
> > > >      }
> > > >
> > > > @@ -480,9 +476,9 @@ static int vhost_vdpa_net_cvq_start(NetClientSt=
ate *nc)
> > > >  {
> > > >      VhostVDPAState *s, *s0;
> > > >      struct vhost_vdpa *v;
> > > > -    uint64_t backend_features;
> > > >      int64_t cvq_group;
> > > > -    int cvq_index, r;
> > > > +    int r;
> > > > +    Error *err =3D NULL;
> > > >
> > > >      assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
> > > >
> > > > @@ -502,41 +498,22 @@ static int vhost_vdpa_net_cvq_start(NetClient=
State *nc)
> > > >      /*
> > > >       * If we early return in these cases SVQ will not be enabled. =
The migration
> > > >       * will be blocked as long as vhost-vdpa backends will not off=
er _F_LOG.
> > > > -     *
> > > > -     * Calling VHOST_GET_BACKEND_FEATURES as they are not availabl=
e in v->dev
> > > > -     * yet.
> > > >       */
> > > > -    r =3D ioctl(v->device_fd, VHOST_GET_BACKEND_FEATURES, &backend=
_features);
> > > > -    if (unlikely(r < 0)) {
> > > > -        error_report("Cannot get vdpa backend_features: %s(%d)",
> > > > -            g_strerror(errno), errno);
> > > > -        return -1;
> > > > +    if (!vhost_vdpa_net_valid_svq_features(v->dev->features, NULL)=
) {
> > > > +        return 0;
> > > >      }
> > > > -    if (!(backend_features & BIT_ULL(VHOST_BACKEND_F_IOTLB_ASID)) =
||
> > > > -        !vhost_vdpa_net_valid_svq_features(v->dev->features, NULL)=
) {
> > > > +
> > > > +    if (!s->cvq_isolated) {
> > > >          return 0;
> > > >      }
> > > >
> > > > -    /*
> > > > -     * Check if all the virtqueues of the virtio device are in a d=
ifferent vq
> > > > -     * than the last vq. VQ group of last group passed in cvq_grou=
p.
> > > > -     */
> > > > -    cvq_index =3D v->dev->vq_index_end - 1;
> > > > -    cvq_group =3D vhost_vdpa_get_vring_group(v->device_fd, cvq_ind=
ex);
> > > > +    cvq_group =3D vhost_vdpa_get_vring_group(v->device_fd,
> > > > +                                           v->dev->vq_index_end - =
1,
> > > > +                                           &err);
> > > >      if (unlikely(cvq_group < 0)) {
> > > > +        error_report_err(err);
> > > >          return cvq_group;
> > > >      }
> > > > -    for (int i =3D 0; i < cvq_index; ++i) {
> > > > -        int64_t group =3D vhost_vdpa_get_vring_group(v->device_fd,=
 i);
> > > > -
> > > > -        if (unlikely(group < 0)) {
> > > > -            return group;
> > > > -        }
> > > > -
> > > > -        if (group =3D=3D cvq_group) {
> > > > -            return 0;
> > > > -        }
> > > > -    }
> > > >
> > > >      r =3D vhost_vdpa_set_address_space_id(v, cvq_group, VHOST_VDPA=
_NET_CVQ_ASID);
> > > >      if (unlikely(r < 0)) {
> > > > @@ -799,6 +776,111 @@ static const VhostShadowVirtqueueOps vhost_vd=
pa_net_svq_ops =3D {
> > > >      .avail_handler =3D vhost_vdpa_net_handle_ctrl_avail,
> > > >  };
> > > >
> > > > +/**
> > > > + * Probe the device to check control virtqueue is isolated.
> > > > + *
> > > > + * @device_fd vhost-vdpa file descriptor
> > > > + * @features features to negotiate
> > > > + * @cvq_index Control vq index
> > > > + *
> > > > + * Returns -1 in case of error, 0 if false and 1 if true
> > > > + */
> > > > +static int vhost_vdpa_cvq_is_isolated(int device_fd, uint64_t feat=
ures,
> > > > +                                      unsigned cvq_index, Error **=
errp)
> > > > +{
> > > > +    int64_t cvq_group;
> > > > +    int r;
> > > > +
> > > > +    r =3D vhost_vdpa_set_dev_features_fd(device_fd, features);
> > > > +    if (unlikely(r < 0)) {
> > > > +        error_setg_errno(errp, -r, "Cannot set device features");
> > > > +        return r;
> > > > +    }
> > > > +
> > > > +    cvq_group =3D vhost_vdpa_get_vring_group(device_fd, cvq_index,=
 errp);
> > > > +    if (unlikely(cvq_group < 0)) {
> > > > +        return cvq_group;
> > > > +    }
> > > > +
> > > > +    for (int i =3D 0; i < cvq_index; ++i) {
> > > > +        int64_t group =3D vhost_vdpa_get_vring_group(device_fd, i,=
 errp);
> > > > +
> > > > +        if (unlikely(group < 0)) {
> > > > +            return group;
> > > > +        }
> > > > +
> > > > +        if (group =3D=3D (int64_t)cvq_group) {
> > > > +            return 0;
> > > > +        }
> > > > +    }
> > > > +
> > > > +    return 1;
> > > > +}
> > > > +
> > > > +/**
> > > > + * Probe if CVQ is isolated when the device is MQ and when it is n=
ot MQ
> > > > + *
> > > > + * @device_fd         The vdpa device fd
> > > > + * @features          Features offered by the device.
> > > > + * @cvq_index         The control vq index if mq is negotiated. Ig=
nored
> > > > + *                    otherwise.
> > > > + *
> > > > + * Returns <0 in case of failure, 0 if false and 1 if true.
> > > > + */
> > > > +static int vhost_vdpa_probe_cvq_isolation(int device_fd, uint64_t =
features,
> > > > +                                          int cvq_index, Error **e=
rrp)
> > > > +{
> > > > +    uint64_t backend_features;
> > > > +    int r;
> > > > +
> > > > +    ERRP_GUARD();
> > > > +
> > > > +    r =3D ioctl(device_fd, VHOST_GET_BACKEND_FEATURES, &backend_fe=
atures);
> > > > +    if (unlikely(r < 0)) {
> > > > +        error_setg_errno(errp, errno, "Cannot get vdpa backend_fea=
tures");
> > > > +        return r;
> > > > +    }
> > > > +
> > > > +    if (!(backend_features & BIT_ULL(VHOST_BACKEND_F_IOTLB_ASID)))=
 {
> > > > +        return 0;
> > > > +    }
> > > > +
> > > > +    r =3D vhost_vdpa_cvq_is_isolated(device_fd,
> > > > +                                   features & ~BIT_ULL(VIRTIO_NET_=
F_MQ), 2,
> > > > +                                   errp);
> > > > +    if (unlikely(r < 0)) {
> > > > +        if (r !=3D -ENOTSUP) {
> > > > +            return r;
> > > > +        }
> > > > +
> > > > +        /*
> > > > +         * The kernel report VHOST_BACKEND_F_IOTLB_ASID if the vdp=
a frontend
> > > > +         * support ASID even if the parent driver does not.  The C=
VQ cannot be
> > > > +         * isolated in this case.
> > > > +         */
> > > > +        error_free(*errp);
> > > > +        *errp =3D NULL;
> > > > +        return 0;
> > > > +    }
> > > > +
> > > > +    if (r =3D=3D 0) {
> > > > +        return 0;
> > > > +    }
> > > > +
> > > > +    vhost_vdpa_reset_status_fd(device_fd);
> > > > +    if (!(features & BIT_ULL(VIRTIO_NET_F_MQ))) {
> > > > +        return 0;
> > > > +    }
> > > > +
> > > > +    r =3D vhost_vdpa_cvq_is_isolated(device_fd, features, cvq_inde=
x * 2, errp);
> > >
> > > I think checking this once should be sufficient. That is to say, it
> > > should be a bug if there's hardware that puts cvq in a dedicated grou=
p
> > > in MQ but not in SQ.
> > >
> >
> > This is checking the NIC is not buggy :). Otherwise, we're giving
> > access to the guest to the CVQ shadow vring. And, currently, SVQ code
> > assumes only QEMU can access it.
>
> Just to make sure we are at the same page, I meant, the hardware
> should be buggy if the isolation of cvq is not consistent between
> single and multiqueue.
>

Yes, I got you.

The problem with that particular bug is that we will handle guest's
vring with the bad IOVA tree. Since QEMU is not sanitizing that
descriptors anymore, the device can be used to write at qemu memory.
At this time only SVQ vring and in buffers should be writable by this,
so it's not a big deal.

This can also happen if the device is buggy in other ways. For
example, reporting that CVQ is isolated at VHOST_VDPA_GET_VRING_GROUP
but then handling maps ignoring the ASID parameter. There is no
protection for that, so I agree this double check makes little sense.

> >
> > But maybe this made more sense in previous versions, where the series
> > also cached the cvq group here. If I understand you correctly, it is
> > enough to check that CVQ is isolated in SQ, and assume it will be
> > isolated also in MQ, right? I can modify the patch that way if you
> > confirm this.
>
> I think so, or just negotiate with what hardware provides us and check.
>

To always probe with SQ makes the code simpler, but let me know if you
think there are advantages to probing otherwise.

Thanks!


