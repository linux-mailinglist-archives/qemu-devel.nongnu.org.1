Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B4481AD9C
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:41:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9ux-0003Uq-8h; Wed, 20 Dec 2023 22:40:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rG9uu-0003Ua-FZ
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:40:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rG9us-0005Pw-HL
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:40:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703130009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ShyjgvS12V21+RlZo+FB9Pwb2RML92btY+S2ljfnXLw=;
 b=VQzPhs+o6+eA7GGhTmA6unTDyyoLPb/SQIdO8++y04rCjcCRCEaSEsLyoPVUSyd+knpJB0
 krVuNo48alfZneG8LQLx7+tC2slHsRpFNFswi0r1w3T2K/1vqZDGPldzsI3AVvWlpFUpgX
 MzsaNVU6HAfkZx2psHpQ1yOcsYLxyyY=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-o0Ow7LDeMueu1_IPAn45Ug-1; Wed, 20 Dec 2023 22:40:06 -0500
X-MC-Unique: o0Ow7LDeMueu1_IPAn45Ug-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3ba402bd76aso421052b6e.2
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:40:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703130005; x=1703734805;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ShyjgvS12V21+RlZo+FB9Pwb2RML92btY+S2ljfnXLw=;
 b=JeU3vkKas5zjFiPYeNf2RlwQZNZSBpYbLPBODBqtf9DTgVQAa5UKBGw7k7ZOWiNOXu
 5K/PYZFC+mErG+y4OWLFDq+OL/Bu6yh60Teeu+k+y13dHs2DsAMW4VIOhHE5Qn3a9SsD
 5SpnmADdiSJ18N+8VdQqJkdxRM97Al9WHhf6639hXmbpsQ0snfU4cXVCXq0g0Ue4cVVO
 au+UhGWi260M9ocu3nRDsmpDP0kVL2GpYo0u2lMFYVilD2bRI2MNMZmopUIvKDyUV/gQ
 0x1vVdW4mHAxvFOT7QoW6Fnudv6IwgtIuUITiPhTq1B3vzXTgHZHVH+IXcl6GwwhiL3T
 2ipg==
X-Gm-Message-State: AOJu0Yyd+q1yN8l9A9fCoYhvqYPZT6q4khRhBKs4EMqLVgpZqgkQ5038
 yrQbNfvgtjih3fXyCWhb26Q4y5phbhA73NHaLtFaSLnmCw0XmdbjSoEm/q0pRpa3hxRwe5MLeAV
 CQGt3JtX2gh+97zS3dCX4oiPVPR8sjGc=
X-Received: by 2002:a05:6808:1998:b0:3b8:b706:3a47 with SMTP id
 bj24-20020a056808199800b003b8b7063a47mr28856008oib.74.1703130005638; 
 Wed, 20 Dec 2023 19:40:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvp9AEZeTRKCFzH7q3WPWG+9+TLeSTU/QEvdUL9BxoLlrXwQpdHOSqPHjFnWdwX8BoZDxmTTQOgQNwW6B8Gqc=
X-Received: by 2002:a05:6808:1998:b0:3b8:b706:3a47 with SMTP id
 bj24-20020a056808199800b003b8b7063a47mr28855994oib.74.1703130005428; Wed, 20
 Dec 2023 19:40:05 -0800 (PST)
MIME-Version: 1.0
References: <20231215172830.2540987-1-eperezma@redhat.com>
 <20231215172830.2540987-8-eperezma@redhat.com>
 <CACGkMEtoVLthML2SauX_Ptwdw6KMbtK1EY6BGD=E3mqN01x5hA@mail.gmail.com>
 <CAJaqyWdFgqeVBEng_i1FDFr9cg6-s8FCAS77tKRnWz3d02tgLQ@mail.gmail.com>
In-Reply-To: <CAJaqyWdFgqeVBEng_i1FDFr9cg6-s8FCAS77tKRnWz3d02tgLQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Dec 2023 11:39:54 +0800
Message-ID: <CACGkMEsFTugq7AuJiAyWXCAidC4g8Tw7AvwtUC5ma=kwR6TG3Q@mail.gmail.com>
Subject: Re: [PATCH for 9.0 07/12] vdpa: set backend capabilities at
 vhost_vdpa_init
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 si-wei.liu@oracle.com, 
 Lei Yang <leiyang@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
 Zhu Lingshan <lingshan.zhu@intel.com>, Parav Pandit <parav@mellanox.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Dec 20, 2023 at 3:08=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, Dec 20, 2023 at 5:34=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Sat, Dec 16, 2023 at 1:28=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
> > >
> > > The backend does not reset them until the vdpa file descriptor is clo=
sed
> > > so there is no harm in doing it only once.
> > >
> > > This allows the destination of a live migration to premap memory in
> > > batches, using VHOST_BACKEND_F_IOTLB_BATCH.
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > >  hw/virtio/vhost-vdpa.c | 50 ++++++++++++++++------------------------=
--
> > >  1 file changed, 19 insertions(+), 31 deletions(-)
> > >
> > > diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> > > index 449c3794b2..43f7c382b1 100644
> > > --- a/hw/virtio/vhost-vdpa.c
> > > +++ b/hw/virtio/vhost-vdpa.c
> > > @@ -587,11 +587,25 @@ static int vhost_vdpa_init(struct vhost_dev *de=
v, void *opaque, Error **errp)
> > >      struct vhost_vdpa *v =3D opaque;
> > >      assert(dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_VD=
PA);
> > >      trace_vhost_vdpa_init(dev, v->shared, opaque);
> > > +    uint64_t backend_features;
> > > +    uint64_t qemu_backend_features =3D 0x1ULL << VHOST_BACKEND_F_IOT=
LB_MSG_V2 |
> > > +                                     0x1ULL << VHOST_BACKEND_F_IOTLB=
_BATCH |
> > > +                                     0x1ULL << VHOST_BACKEND_F_IOTLB=
_ASID |
> > > +                                     0x1ULL << VHOST_BACKEND_F_SUSPE=
ND;
> > >      int ret;
> > >
> > >      v->dev =3D dev;
> > >      dev->opaque =3D  opaque ;
> > >      v->shared->listener =3D vhost_vdpa_memory_listener;
> > > +
> > > +    if (vhost_vdpa_call(dev, VHOST_GET_BACKEND_FEATURES, &backend_fe=
atures)) {
> > > +        return -EFAULT;
> > > +    }
> > > +
> > > +    backend_features &=3D qemu_backend_features;
> > > +
> > > +    dev->backend_cap =3D backend_features;
> > > +    v->shared->backend_cap =3D backend_features;
> > >      vhost_vdpa_init_svq(dev, v);
> > >
> > >      error_propagate(&dev->migration_blocker, v->migration_blocker);
> > > @@ -599,6 +613,11 @@ static int vhost_vdpa_init(struct vhost_dev *dev=
, void *opaque, Error **errp)
> > >          return 0;
> > >      }
> > >
> > > +    ret =3D vhost_vdpa_call(dev, VHOST_SET_BACKEND_FEATURES, &backen=
d_features);
> > > +    if (ret) {
> > > +        return -EFAULT;
> > > +    }
> > > +
> > >      /*
> > >       * If dev->shadow_vqs_enabled at initialization that means the d=
evice has
> > >       * been started with x-svq=3Don, so don't block migration
> > > @@ -829,36 +848,6 @@ static int vhost_vdpa_set_features(struct vhost_=
dev *dev,
> > >      return vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_FEATURES_OK);
> > >  }
> > >
> > > -static int vhost_vdpa_set_backend_cap(struct vhost_dev *dev)
> >
> > How about keeping this function but just calling it in vhost_vdpa_init(=
)?
> >
>
> Sure, that is possible. I need to remove the VhostOps
> vhost_set_backend_cap =3D vhost_vdpa_set_backend_cap, anyway, is that ok
> for you?

Fine with me.

Thanks

>
> Thanks!
>


