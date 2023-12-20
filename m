Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB3F81991B
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 08:09:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFqgx-00032o-VD; Wed, 20 Dec 2023 02:08:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rFqgt-0002zI-Pp
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 02:08:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rFqgr-00005f-34
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 02:08:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703056104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tShi8pokjXmzopuoTKTFXjF8ChuaMwwbKRcVsNdAtrE=;
 b=e/9y3k9eMfFsrSTWMqX0hxmNCqVGPIOeT0aqOPvWImh/B8X1nJ8TAx7AT3ccNwgyGOf113
 E1nmHpKtce3VfXB/ATwi2EqB3dcefpsgdI4LfqEx5Ty7QHibQ7l67/Zgy2gSznVODYUcaf
 4qIhDjhU0FAoBgQ3s6mbI59WPi7lTnY=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-RSUzW7WxMQW2gnq4z8JJ2A-1; Wed, 20 Dec 2023 02:08:22 -0500
X-MC-Unique: RSUzW7WxMQW2gnq4z8JJ2A-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-5e617562a65so48477557b3.1
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 23:08:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703056102; x=1703660902;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tShi8pokjXmzopuoTKTFXjF8ChuaMwwbKRcVsNdAtrE=;
 b=ShW2tgUKceuilLMemkjHP/VsdqyneDeREGhDAx6lVL0XE/SuwDjDenGK9rHpzAMmGV
 TpARgsWfddIgZCjeOOknNVJ1lBghTIvuPvLXpnrqtf1Ei63kKN1mmqTzXJDhvlWMJwXo
 ZQ4qJ1QD7nqpakJ1BfVmrWhs/N8HAN/3cDCy/BY6YJcrZKb0t3sXxJkOr8EFNdmkOgWC
 zY1wHf9n1qhyykglPL5KOqCuj7rDJLurjbkXl92F/oUa8LUoBJUvCwUMWoj5qQXfePID
 7G94vthjVtEMXaE4V50hnJ0M6njl9U1IkCa4QEv7TW8gQucSptb8sQJNbD7XpsQVVCfB
 sIgQ==
X-Gm-Message-State: AOJu0YxecYILSTbkl1iDEYU+LDSEirdhyCG6vYmfCOgJxoV0FM5JX07e
 548v5FMky3Nd/4imbI37ZylI7YuYMpyCeczI6jL+tzf9IXvykBYyo7kTXZFhMpHvDbskHkdR3Rp
 3ocxhy7XkkUVXg98W6EqpvXWOlHWdppQ=
X-Received: by 2002:a25:8f8f:0:b0:db5:4b23:534 with SMTP id
 u15-20020a258f8f000000b00db54b230534mr10802064ybl.17.1703056101913; 
 Tue, 19 Dec 2023 23:08:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqOqbAYj44UCT1/uy6gm+Snvi/Qx8DKs4zdaHlyB8YUoK2dJHBkSZNy6gyc7ZJNsTb8j4ZQOgw/CsZGahoTJI=
X-Received: by 2002:a25:8f8f:0:b0:db5:4b23:534 with SMTP id
 u15-20020a258f8f000000b00db54b230534mr10802053ybl.17.1703056101633; Tue, 19
 Dec 2023 23:08:21 -0800 (PST)
MIME-Version: 1.0
References: <20231215172830.2540987-1-eperezma@redhat.com>
 <20231215172830.2540987-8-eperezma@redhat.com>
 <CACGkMEtoVLthML2SauX_Ptwdw6KMbtK1EY6BGD=E3mqN01x5hA@mail.gmail.com>
In-Reply-To: <CACGkMEtoVLthML2SauX_Ptwdw6KMbtK1EY6BGD=E3mqN01x5hA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 20 Dec 2023 08:07:45 +0100
Message-ID: <CAJaqyWdFgqeVBEng_i1FDFr9cg6-s8FCAS77tKRnWz3d02tgLQ@mail.gmail.com>
Subject: Re: [PATCH for 9.0 07/12] vdpa: set backend capabilities at
 vhost_vdpa_init
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 si-wei.liu@oracle.com, 
 Lei Yang <leiyang@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
 Zhu Lingshan <lingshan.zhu@intel.com>, Parav Pandit <parav@mellanox.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
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

On Wed, Dec 20, 2023 at 5:34=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Sat, Dec 16, 2023 at 1:28=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > The backend does not reset them until the vdpa file descriptor is close=
d
> > so there is no harm in doing it only once.
> >
> > This allows the destination of a live migration to premap memory in
> > batches, using VHOST_BACKEND_F_IOTLB_BATCH.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  hw/virtio/vhost-vdpa.c | 50 ++++++++++++++++--------------------------
> >  1 file changed, 19 insertions(+), 31 deletions(-)
> >
> > diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> > index 449c3794b2..43f7c382b1 100644
> > --- a/hw/virtio/vhost-vdpa.c
> > +++ b/hw/virtio/vhost-vdpa.c
> > @@ -587,11 +587,25 @@ static int vhost_vdpa_init(struct vhost_dev *dev,=
 void *opaque, Error **errp)
> >      struct vhost_vdpa *v =3D opaque;
> >      assert(dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_VDPA=
);
> >      trace_vhost_vdpa_init(dev, v->shared, opaque);
> > +    uint64_t backend_features;
> > +    uint64_t qemu_backend_features =3D 0x1ULL << VHOST_BACKEND_F_IOTLB=
_MSG_V2 |
> > +                                     0x1ULL << VHOST_BACKEND_F_IOTLB_B=
ATCH |
> > +                                     0x1ULL << VHOST_BACKEND_F_IOTLB_A=
SID |
> > +                                     0x1ULL << VHOST_BACKEND_F_SUSPEND=
;
> >      int ret;
> >
> >      v->dev =3D dev;
> >      dev->opaque =3D  opaque ;
> >      v->shared->listener =3D vhost_vdpa_memory_listener;
> > +
> > +    if (vhost_vdpa_call(dev, VHOST_GET_BACKEND_FEATURES, &backend_feat=
ures)) {
> > +        return -EFAULT;
> > +    }
> > +
> > +    backend_features &=3D qemu_backend_features;
> > +
> > +    dev->backend_cap =3D backend_features;
> > +    v->shared->backend_cap =3D backend_features;
> >      vhost_vdpa_init_svq(dev, v);
> >
> >      error_propagate(&dev->migration_blocker, v->migration_blocker);
> > @@ -599,6 +613,11 @@ static int vhost_vdpa_init(struct vhost_dev *dev, =
void *opaque, Error **errp)
> >          return 0;
> >      }
> >
> > +    ret =3D vhost_vdpa_call(dev, VHOST_SET_BACKEND_FEATURES, &backend_=
features);
> > +    if (ret) {
> > +        return -EFAULT;
> > +    }
> > +
> >      /*
> >       * If dev->shadow_vqs_enabled at initialization that means the dev=
ice has
> >       * been started with x-svq=3Don, so don't block migration
> > @@ -829,36 +848,6 @@ static int vhost_vdpa_set_features(struct vhost_de=
v *dev,
> >      return vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_FEATURES_OK);
> >  }
> >
> > -static int vhost_vdpa_set_backend_cap(struct vhost_dev *dev)
>
> How about keeping this function but just calling it in vhost_vdpa_init()?
>

Sure, that is possible. I need to remove the VhostOps
vhost_set_backend_cap =3D vhost_vdpa_set_backend_cap, anyway, is that ok
for you?

Thanks!


