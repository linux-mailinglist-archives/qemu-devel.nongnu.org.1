Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A37F9708F02
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 06:53:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzs5S-00080I-Mu; Fri, 19 May 2023 00:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1pzs5P-0007zg-3i
 for qemu-devel@nongnu.org; Fri, 19 May 2023 00:51:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1pzs5M-0007DW-MG
 for qemu-devel@nongnu.org; Fri, 19 May 2023 00:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684471883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T7LT22ViUPuOZsLkqLS7k8EZDX9hR4q7YlZibve4IsQ=;
 b=gTse5De8H4FCLLyh6G2yVdzeqU0H1kQ5fmzspIqjvTsFELRpfabI8JUDS7qgT2K93xAqHA
 07N90j8f4T77q6I3otzWh3bO4mGr6VSRiNiG7nA29Cvz0b5dNgfEQl0qkY9ow3Prsm4r6P
 f8VXhnPaQ+RLbGpYKVcuS9y+HYYxsxs=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-CkJttjJQPWKrS-I42KMr2Q-1; Fri, 19 May 2023 00:51:21 -0400
X-MC-Unique: CkJttjJQPWKrS-I42KMr2Q-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-ba81b24c1deso5955700276.3
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 21:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684471881; x=1687063881;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T7LT22ViUPuOZsLkqLS7k8EZDX9hR4q7YlZibve4IsQ=;
 b=HY5gNz8K7nhnmOct5xL0dnn5zO61RuByqZfuCBtoOPapp7J8+t2of35n4UACtpAV44
 TUdPdpkCs1nalOD5lZdpWkpekFMEgulM0Vkd/1YwTucrMSV+Ckl3+6L7d+71Hh2rrVyr
 N8nxI13zjAOCPHg5UpI+BGnS0FoNp5JbcMZvkSZWW4BM6EqoK736GoSm4gq+nyyot/wG
 tUOPIMIWpv8YRYlS0jIj3l4+ERRYesjOvgLSIGVJs6WZxzrswdZO9FrfbSHxAPq+Ur3d
 ah9LFzWlx0SZvRwmx0SUEhH1gYUt7t0sicunEv05iD0j4mSA6FCvW64pzkf4IpSf8Bfj
 +/9w==
X-Gm-Message-State: AC+VfDytYuC1qRQLg5D8Ef2VieUdzpg7YfgpuqesAVYxywW222bQZ7Cn
 AUP3iIHxsVRh7n+cndPfKDKAanNpKIAlc997jpj2Ty1HQWjEkLktnKUHUTyYYjAGNzXtzUsU0Gt
 Sp6lZsf2TwL7hpdJAqt0/3aNxNm5rKT4=
X-Received: by 2002:a25:c710:0:b0:b7e:6685:84a with SMTP id
 w16-20020a25c710000000b00b7e6685084amr618456ybe.1.1684471881076; 
 Thu, 18 May 2023 21:51:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7pFL2ADwuoOxxgMxwCga9vBxhD2aCEtKEXQFLJJb5TKfJIbfsckzYUlL14FGMbvoHbYlrIzlfRG7ud9+FRSJU=
X-Received: by 2002:a25:c710:0:b0:b7e:6685:84a with SMTP id
 w16-20020a25c710000000b00b7e6685084amr618434ybe.1.1684471880773; Thu, 18 May
 2023 21:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230509154435.1410162-1-eperezma@redhat.com>
 <20230509154435.1410162-6-eperezma@redhat.com>
 <CACGkMEvujW-VFhrxk8FD0d76UeT0Q3osYC5odqMHntwoTHmizA@mail.gmail.com>
 <CAJaqyWd8GbMrTCKPKz_65CUkg6a83Y3aRg41R4aSKLpnpFj23Q@mail.gmail.com>
 <CACGkMEutrxhYOEozQq1scXaPXDVfX+ZRcLr4+w8CvODoxJqTjQ@mail.gmail.com>
 <CAJaqyWe=cop=M_kz7JazvnCboaMAqA4xuVO7WBS9rks83JHgkw@mail.gmail.com>
 <20230518172138-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230518172138-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 19 May 2023 06:50:43 +0200
Message-ID: <CAJaqyWemU=aq5QeuWCHO4V=QKpNrV6=9QQZKfwDm_KapfDK3zQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] vdpa: move CVQ isolation check to
 net_init_vhost_vdpa
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, 
 Parav Pandit <parav@mellanox.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 longpeng2@huawei.com, 
 Stefano Garzarella <sgarzare@redhat.com>, Gautam Dawar <gdawar@xilinx.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, alvaro.karsz@solid-run.com, 
 Liuxiangdong <liuxiangdong5@huawei.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 si-wei.liu@oracle.com, 
 Shannon Nelson <snelson@pensando.io>, Lei Yang <leiyang@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>
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

On Thu, May 18, 2023 at 11:23=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Thu, May 18, 2023 at 08:36:22AM +0200, Eugenio Perez Martin wrote:
> > On Thu, May 18, 2023 at 7:50=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Wed, May 17, 2023 at 2:30=E2=80=AFPM Eugenio Perez Martin
> > > <eperezma@redhat.com> wrote:
> > > >
> > > > On Wed, May 17, 2023 at 5:59=E2=80=AFAM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > On Tue, May 9, 2023 at 11:44=E2=80=AFPM Eugenio P=C3=A9rez <epere=
zma@redhat.com> wrote:
> > > > > >
> > > > > > Evaluating it at start time instead of initialization time may =
make the
> > > > > > guest capable of dynamically adding or removing migration block=
ers.
> > > > > >
> > > > > > Also, moving to initialization reduces the number of ioctls in =
the
> > > > > > migration, reducing failure possibilities.
> > > > > >
> > > > > > As a drawback we need to check for CVQ isolation twice: one tim=
e with no
> > > > > > MQ negotiated and another one acking it, as long as the device =
supports
> > > > > > it.  This is because Vring ASID / group management is based on =
vq
> > > > > > indexes, but we don't know the index of CVQ before negotiating =
MQ.
> > > > > >
> > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > ---
> > > > > > v2: Take out the reset of the device from vhost_vdpa_cvq_is_iso=
lated
> > > > > > v3: Only record cvq_isolated, true if the device have cvq isola=
ted in
> > > > > >     both !MQ and MQ configurations.
> > > > > > ---
> > > > > >  net/vhost-vdpa.c | 178 +++++++++++++++++++++++++++++++++++----=
--------
> > > > > >  1 file changed, 135 insertions(+), 43 deletions(-)
> > > > > >
> > > > > > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > > > > > index 3fb833fe76..29054b77a9 100644
> > > > > > --- a/net/vhost-vdpa.c
> > > > > > +++ b/net/vhost-vdpa.c
> > > > > > @@ -43,6 +43,10 @@ typedef struct VhostVDPAState {
> > > > > >
> > > > > >      /* The device always have SVQ enabled */
> > > > > >      bool always_svq;
> > > > > > +
> > > > > > +    /* The device can isolate CVQ in its own ASID */
> > > > > > +    bool cvq_isolated;
> > > > > > +
> > > > > >      bool started;
> > > > > >  } VhostVDPAState;
> > > > > >
> > > > > > @@ -362,15 +366,8 @@ static NetClientInfo net_vhost_vdpa_info =
=3D {
> > > > > >          .check_peer_type =3D vhost_vdpa_check_peer_type,
> > > > > >  };
> > > > > >
> > > > > > -/**
> > > > > > - * Get vring virtqueue group
> > > > > > - *
> > > > > > - * @device_fd  vdpa device fd
> > > > > > - * @vq_index   Virtqueue index
> > > > > > - *
> > > > > > - * Return -errno in case of error, or vq group if success.
> > > > > > - */
> > > > > > -static int64_t vhost_vdpa_get_vring_group(int device_fd, unsig=
ned vq_index)
> > > > > > +static int64_t vhost_vdpa_get_vring_group(int device_fd, unsig=
ned vq_index,
> > > > > > +                                          Error **errp)
> > > > > >  {
> > > > > >      struct vhost_vring_state state =3D {
> > > > > >          .index =3D vq_index,
> > > > > > @@ -379,8 +376,7 @@ static int64_t vhost_vdpa_get_vring_group(i=
nt device_fd, unsigned vq_index)
> > > > > >
> > > > > >      if (unlikely(r < 0)) {
> > > > > >          r =3D -errno;
> > > > > > -        error_report("Cannot get VQ %u group: %s", vq_index,
> > > > > > -                     g_strerror(errno));
> > > > > > +        error_setg_errno(errp, errno, "Cannot get VQ %u group"=
, vq_index);
> > > > > >          return r;
> > > > > >      }
> > > > > >
> > > > > > @@ -480,9 +476,9 @@ static int vhost_vdpa_net_cvq_start(NetClie=
ntState *nc)
> > > > > >  {
> > > > > >      VhostVDPAState *s, *s0;
> > > > > >      struct vhost_vdpa *v;
> > > > > > -    uint64_t backend_features;
> > > > > >      int64_t cvq_group;
> > > > > > -    int cvq_index, r;
> > > > > > +    int r;
> > > > > > +    Error *err =3D NULL;
> > > > > >
> > > > > >      assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA)=
;
> > > > > >
> > > > > > @@ -502,41 +498,22 @@ static int vhost_vdpa_net_cvq_start(NetCl=
ientState *nc)
> > > > > >      /*
> > > > > >       * If we early return in these cases SVQ will not be enabl=
ed. The migration
> > > > > >       * will be blocked as long as vhost-vdpa backends will not=
 offer _F_LOG.
> > > > > > -     *
> > > > > > -     * Calling VHOST_GET_BACKEND_FEATURES as they are not avai=
lable in v->dev
> > > > > > -     * yet.
> > > > > >       */
> > > > > > -    r =3D ioctl(v->device_fd, VHOST_GET_BACKEND_FEATURES, &bac=
kend_features);
> > > > > > -    if (unlikely(r < 0)) {
> > > > > > -        error_report("Cannot get vdpa backend_features: %s(%d)=
",
> > > > > > -            g_strerror(errno), errno);
> > > > > > -        return -1;
> > > > > > +    if (!vhost_vdpa_net_valid_svq_features(v->dev->features, N=
ULL)) {
> > > > > > +        return 0;
> > > > > >      }
> > > > > > -    if (!(backend_features & BIT_ULL(VHOST_BACKEND_F_IOTLB_ASI=
D)) ||
> > > > > > -        !vhost_vdpa_net_valid_svq_features(v->dev->features, N=
ULL)) {
> > > > > > +
> > > > > > +    if (!s->cvq_isolated) {
> > > > > >          return 0;
> > > > > >      }
> > > > > >
> > > > > > -    /*
> > > > > > -     * Check if all the virtqueues of the virtio device are in=
 a different vq
> > > > > > -     * than the last vq. VQ group of last group passed in cvq_=
group.
> > > > > > -     */
> > > > > > -    cvq_index =3D v->dev->vq_index_end - 1;
> > > > > > -    cvq_group =3D vhost_vdpa_get_vring_group(v->device_fd, cvq=
_index);
> > > > > > +    cvq_group =3D vhost_vdpa_get_vring_group(v->device_fd,
> > > > > > +                                           v->dev->vq_index_en=
d - 1,
> > > > > > +                                           &err);
> > > > > >      if (unlikely(cvq_group < 0)) {
> > > > > > +        error_report_err(err);
> > > > > >          return cvq_group;
> > > > > >      }
> > > > > > -    for (int i =3D 0; i < cvq_index; ++i) {
> > > > > > -        int64_t group =3D vhost_vdpa_get_vring_group(v->device=
_fd, i);
> > > > > > -
> > > > > > -        if (unlikely(group < 0)) {
> > > > > > -            return group;
> > > > > > -        }
> > > > > > -
> > > > > > -        if (group =3D=3D cvq_group) {
> > > > > > -            return 0;
> > > > > > -        }
> > > > > > -    }
> > > > > >
> > > > > >      r =3D vhost_vdpa_set_address_space_id(v, cvq_group, VHOST_=
VDPA_NET_CVQ_ASID);
> > > > > >      if (unlikely(r < 0)) {
> > > > > > @@ -799,6 +776,111 @@ static const VhostShadowVirtqueueOps vhos=
t_vdpa_net_svq_ops =3D {
> > > > > >      .avail_handler =3D vhost_vdpa_net_handle_ctrl_avail,
> > > > > >  };
> > > > > >
> > > > > > +/**
> > > > > > + * Probe the device to check control virtqueue is isolated.
> > > > > > + *
> > > > > > + * @device_fd vhost-vdpa file descriptor
> > > > > > + * @features features to negotiate
> > > > > > + * @cvq_index Control vq index
> > > > > > + *
> > > > > > + * Returns -1 in case of error, 0 if false and 1 if true
> > > > > > + */
> > > > > > +static int vhost_vdpa_cvq_is_isolated(int device_fd, uint64_t =
features,
> > > > > > +                                      unsigned cvq_index, Erro=
r **errp)
> > > > > > +{
> > > > > > +    int64_t cvq_group;
> > > > > > +    int r;
> > > > > > +
> > > > > > +    r =3D vhost_vdpa_set_dev_features_fd(device_fd, features);
> > > > > > +    if (unlikely(r < 0)) {
> > > > > > +        error_setg_errno(errp, -r, "Cannot set device features=
");
> > > > > > +        return r;
> > > > > > +    }
> > > > > > +
> > > > > > +    cvq_group =3D vhost_vdpa_get_vring_group(device_fd, cvq_in=
dex, errp);
> > > > > > +    if (unlikely(cvq_group < 0)) {
> > > > > > +        return cvq_group;
> > > > > > +    }
> > > > > > +
> > > > > > +    for (int i =3D 0; i < cvq_index; ++i) {
> > > > > > +        int64_t group =3D vhost_vdpa_get_vring_group(device_fd=
, i, errp);
> > > > > > +
> > > > > > +        if (unlikely(group < 0)) {
> > > > > > +            return group;
> > > > > > +        }
> > > > > > +
> > > > > > +        if (group =3D=3D (int64_t)cvq_group) {
> > > > > > +            return 0;
> > > > > > +        }
> > > > > > +    }
> > > > > > +
> > > > > > +    return 1;
> > > > > > +}
> > > > > > +
> > > > > > +/**
> > > > > > + * Probe if CVQ is isolated when the device is MQ and when it =
is not MQ
> > > > > > + *
> > > > > > + * @device_fd         The vdpa device fd
> > > > > > + * @features          Features offered by the device.
> > > > > > + * @cvq_index         The control vq index if mq is negotiated=
. Ignored
> > > > > > + *                    otherwise.
> > > > > > + *
> > > > > > + * Returns <0 in case of failure, 0 if false and 1 if true.
> > > > > > + */
> > > > > > +static int vhost_vdpa_probe_cvq_isolation(int device_fd, uint6=
4_t features,
> > > > > > +                                          int cvq_index, Error=
 **errp)
> > > > > > +{
> > > > > > +    uint64_t backend_features;
> > > > > > +    int r;
> > > > > > +
> > > > > > +    ERRP_GUARD();
> > > > > > +
> > > > > > +    r =3D ioctl(device_fd, VHOST_GET_BACKEND_FEATURES, &backen=
d_features);
> > > > > > +    if (unlikely(r < 0)) {
> > > > > > +        error_setg_errno(errp, errno, "Cannot get vdpa backend=
_features");
> > > > > > +        return r;
> > > > > > +    }
> > > > > > +
> > > > > > +    if (!(backend_features & BIT_ULL(VHOST_BACKEND_F_IOTLB_ASI=
D))) {
> > > > > > +        return 0;
> > > > > > +    }
> > > > > > +
> > > > > > +    r =3D vhost_vdpa_cvq_is_isolated(device_fd,
> > > > > > +                                   features & ~BIT_ULL(VIRTIO_=
NET_F_MQ), 2,
> > > > > > +                                   errp);
> > > > > > +    if (unlikely(r < 0)) {
> > > > > > +        if (r !=3D -ENOTSUP) {
> > > > > > +            return r;
> > > > > > +        }
> > > > > > +
> > > > > > +        /*
> > > > > > +         * The kernel report VHOST_BACKEND_F_IOTLB_ASID if the=
 vdpa frontend
> > > > > > +         * support ASID even if the parent driver does not.  T=
he CVQ cannot be
> > > > > > +         * isolated in this case.
> > > > > > +         */
> > > > > > +        error_free(*errp);
> > > > > > +        *errp =3D NULL;
> > > > > > +        return 0;
> > > > > > +    }
> > > > > > +
> > > > > > +    if (r =3D=3D 0) {
> > > > > > +        return 0;
> > > > > > +    }
> > > > > > +
> > > > > > +    vhost_vdpa_reset_status_fd(device_fd);
> > > > > > +    if (!(features & BIT_ULL(VIRTIO_NET_F_MQ))) {
> > > > > > +        return 0;
> > > > > > +    }
> > > > > > +
> > > > > > +    r =3D vhost_vdpa_cvq_is_isolated(device_fd, features, cvq_=
index * 2, errp);
> > > > >
> > > > > I think checking this once should be sufficient. That is to say, =
it
> > > > > should be a bug if there's hardware that puts cvq in a dedicated =
group
> > > > > in MQ but not in SQ.
> > > > >
> > > >
> > > > This is checking the NIC is not buggy :). Otherwise, we're giving
> > > > access to the guest to the CVQ shadow vring. And, currently, SVQ co=
de
> > > > assumes only QEMU can access it.
> > >
> > > Just to make sure we are at the same page, I meant, the hardware
> > > should be buggy if the isolation of cvq is not consistent between
> > > single and multiqueue.
> > >
> >
> > Yes, I got you.
> >
> > The problem with that particular bug is that we will handle guest's
> > vring with the bad IOVA tree. Since QEMU is not sanitizing that
> > descriptors anymore, the device can be used to write at qemu memory.
> > At this time only SVQ vring and in buffers should be writable by this,
> > so it's not a big deal.
> >
> > This can also happen if the device is buggy in other ways. For
> > example, reporting that CVQ is isolated at VHOST_VDPA_GET_VRING_GROUP
> > but then handling maps ignoring the ASID parameter. There is no
> > protection for that, so I agree this double check makes little sense.
>
> Ok so you will repost with this check removed?
>

Yes, I'll repost it.

Thanks!

> > > >
> > > > But maybe this made more sense in previous versions, where the seri=
es
> > > > also cached the cvq group here. If I understand you correctly, it i=
s
> > > > enough to check that CVQ is isolated in SQ, and assume it will be
> > > > isolated also in MQ, right? I can modify the patch that way if you
> > > > confirm this.
> > >
> > > I think so, or just negotiate with what hardware provides us and chec=
k.
> > >
> >
> > To always probe with SQ makes the code simpler, but let me know if you
> > think there are advantages to probing otherwise.
> >
> > Thanks!
>


