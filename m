Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B52E6783BE8
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 10:38:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYMsd-0002co-5m; Tue, 22 Aug 2023 04:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qYMsI-0002cS-JU
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 04:36:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qYMsD-0005sp-Ga
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 04:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692693383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZV4nSNFbSI4vOppE/Zper5O4KcOHLe9FUiooWZ+Qzbw=;
 b=cY/lDQNc6vqxwGFXzcDHyAdIyWWdZeG6ID7R7Ukejzqr9IVlvWcoHsfQMFl/Z9rJwTeuZ0
 YS1XdlWPRYI9bcus/k2/sb+8ytVtAvZCvhK+MAZG2UekZXyfW08ULXR5jBrDpvXEAMMH5t
 ikDCL1nYAyink+0rxOBsd/R0dfNl6Y0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-vhAvpk0DPOGryox4wCAAmA-1; Tue, 22 Aug 2023 04:36:22 -0400
X-MC-Unique: vhAvpk0DPOGryox4wCAAmA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2bb9bcac581so44482661fa.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 01:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692693380; x=1693298180;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZV4nSNFbSI4vOppE/Zper5O4KcOHLe9FUiooWZ+Qzbw=;
 b=EBBLMidBea/TR1YuqUiKYbHIB4/9am0rXUuX5rV6KGRIhDKvz8jS++q1AhVwiXhN+z
 s1Rb5Std4UhkHzmtLlwTo4737kvAMkPhxFzDoOPdfCdBWoXQOakX8rrHKhvESs/vujxT
 Spb2o0KAam96/2ZBs8s00ejNxgInRkGbNVGcstv11+2T7hrIstpecacNLvb0kjbOdRq2
 0HoXkFev6cq9o8wOcbZwDQpVs3AR4sbJEfp/jSTKukM5HCrHlW++/1C190FuQWCqsz6N
 LSxhNs/w2/l1RUxTiGLiEAz18iOf+qs64X3MsUNzAXw65xp9WpelLNzU+2R8IDlxmsqX
 WF6A==
X-Gm-Message-State: AOJu0YyKYXGvJq64Ybi+GW4F7ROioGoNg7yd51AmjNX+uJlkbAuK5Fcb
 gW1bhqDFVFq48WYb7KU3ndsAr/3shKYuQFpUBU/sl/4ryt97xUwpu02UsFDqPdK8Pi2A4oOllLd
 bvKqyddvXb5RfdceMD16pnKgi9j7Fvoc=
X-Received: by 2002:a2e:3503:0:b0:2bc:b75e:b88 with SMTP id
 z3-20020a2e3503000000b002bcb75e0b88mr5094700ljz.18.1692693380680; 
 Tue, 22 Aug 2023 01:36:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmfnWmG+y7bWZU9zJnpG8H4rwvLcV5aq0ctGVU0pqEndbuFRYUhRBZpjfff8jRL6NQBrAcJMafpBrEu6gyDVM=
X-Received: by 2002:a2e:3503:0:b0:2bc:b75e:b88 with SMTP id
 z3-20020a2e3503000000b002bcb75e0b88mr5094680ljz.18.1692693380305; Tue, 22 Aug
 2023 01:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230810153611.3410882-1-eperezma@redhat.com>
 <20230810153611.3410882-5-eperezma@redhat.com>
 <CACGkMEveLShOzufBdgeQ+N8-R+Vv7CW6y+aSPSD5ZRnzy4sEXw@mail.gmail.com>
 <CAJaqyWcoB0kbeepk+HX=b75VjhYg8pv60kHPvMx0XijVgMrmgA@mail.gmail.com>
In-Reply-To: <CAJaqyWcoB0kbeepk+HX=b75VjhYg8pv60kHPvMx0XijVgMrmgA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 22 Aug 2023 16:36:08 +0800
Message-ID: <CACGkMEuR5V81j-8AM7Eycb7rauL0o=MqLO7Lhe_OKzT98=-QiA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] vdpa: move vhost_vdpa_set_vrings_ready to the
 caller
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, si-wei.liu@oracle.com, 
 Parav Pandit <parav@mellanox.com>, Gautam Dawar <gdawar@xilinx.com>, 
 Zhu Lingshan <lingshan.zhu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cindy Lu <lulu@redhat.com>, Harpreet Singh Anand <hanand@xilinx.com>,
 Stefano Garzarella <sgarzare@redhat.com>, 
 Hawkins Jiawei <yin31149@gmail.com>, Shannon Nelson <snelson@pensando.io>,
 Lei Yang <leiyang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 22, 2023 at 4:09=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Mon, Aug 14, 2023 at 8:57=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Thu, Aug 10, 2023 at 11:36=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@r=
edhat.com> wrote:
> > >
> > > Doing that way allows CVQ to be enabled before the dataplane vqs,
> > > restoring the state as MQ or MAC addresses properly in the case of a
> > > migration.
> > >
> >
> > A typo in the subject, should be vhost_vdpa_set_vring_ready.
> >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > >  hw/virtio/vdpa-dev.c   |  3 +++
> > >  hw/virtio/vhost-vdpa.c |  3 ---
> > >  net/vhost-vdpa.c       | 57 +++++++++++++++++++++++++++++-----------=
--
> > >  3 files changed, 42 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
> > > index 363b625243..f22d5d5bc0 100644
> > > --- a/hw/virtio/vdpa-dev.c
> > > +++ b/hw/virtio/vdpa-dev.c
> > > @@ -255,6 +255,9 @@ static int vhost_vdpa_device_start(VirtIODevice *=
vdev, Error **errp)
> > >          error_setg_errno(errp, -ret, "Error starting vhost");
> > >          goto err_guest_notifiers;
> > >      }
> > > +    for (i =3D 0; i < s->dev.nvqs; ++i) {
> > > +        vhost_vdpa_set_vring_ready(&s->vdpa, i);
> > > +    }
> > >      s->started =3D true;
> > >
> > >      /*
> > > diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> > > index 0d9975b5b5..8ca2e3800c 100644
> > > --- a/hw/virtio/vhost-vdpa.c
> > > +++ b/hw/virtio/vhost-vdpa.c
> > > @@ -1297,9 +1297,6 @@ static int vhost_vdpa_dev_start(struct vhost_de=
v *dev, bool started)
> > >          if (unlikely(!ok)) {
> > >              return -1;
> > >          }
> > > -        for (int i =3D 0; i < dev->nvqs; ++i) {
> > > -            vhost_vdpa_set_vring_ready(v, dev->vq_index + i);
> > > -        }
> > >      } else {
> > >          vhost_vdpa_suspend(dev);
> > >          vhost_vdpa_svqs_stop(dev);
> > > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > > index 9251351b4b..3bf60f9431 100644
> > > --- a/net/vhost-vdpa.c
> > > +++ b/net/vhost-vdpa.c
> > > @@ -371,6 +371,22 @@ static int vhost_vdpa_net_data_start(NetClientSt=
ate *nc)
> > >      return 0;
> > >  }
> > >
> > > +static int vhost_vdpa_net_data_load(NetClientState *nc)
> > > +{
> > > +    VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> > > +    struct vhost_vdpa *v =3D &s->vhost_vdpa;
> > > +    bool has_cvq =3D v->dev->vq_index_end % 2;
> > > +
> > > +    if (has_cvq) {
> > > +        return 0;
> > > +    }
> > > +
> > > +    for (int i =3D 0; i < v->dev->nvqs; ++i) {
> > > +        vhost_vdpa_set_vring_ready(v, i + v->dev->vq_index);
> > > +    }
> > > +    return 0;
> > > +}
> > > +
> > >  static void vhost_vdpa_net_client_stop(NetClientState *nc)
> > >  {
> > >      VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> > > @@ -393,6 +409,7 @@ static NetClientInfo net_vhost_vdpa_info =3D {
> > >          .size =3D sizeof(VhostVDPAState),
> > >          .receive =3D vhost_vdpa_receive,
> > >          .start =3D vhost_vdpa_net_data_start,
> > > +        .load =3D vhost_vdpa_net_data_load,
> >
> > This deserve an independent patch?
> >
>
> Ok so I misread your reply.
>
> An independent patch would just add a stub vhost_vdpa_net_data_load,
> since it's its only purpose. I can add that to the patch message in
> the next version.

Fine with me.

Thanks

>
> Thanks!
>
> > Thanks
> >
> > >          .stop =3D vhost_vdpa_net_client_stop,
> > >          .cleanup =3D vhost_vdpa_cleanup,
> > >          .has_vnet_hdr =3D vhost_vdpa_has_vnet_hdr,
> > > @@ -974,26 +991,30 @@ static int vhost_vdpa_net_cvq_load(NetClientSta=
te *nc)
> > >
> > >      assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
> > >
> > > -    if (!v->shadow_vqs_enabled) {
> > > -        return 0;
> > > -    }
> > > +    vhost_vdpa_set_vring_ready(v, v->dev->vq_index);
> > >
> > > -    n =3D VIRTIO_NET(v->dev->vdev);
> > > -    r =3D vhost_vdpa_net_load_mac(s, n);
> > > -    if (unlikely(r < 0)) {
> > > -        return r;
> > > -    }
> > > -    r =3D vhost_vdpa_net_load_mq(s, n);
> > > -    if (unlikely(r)) {
> > > -        return r;
> > > -    }
> > > -    r =3D vhost_vdpa_net_load_offloads(s, n);
> > > -    if (unlikely(r)) {
> > > -        return r;
> > > +    if (v->shadow_vqs_enabled) {
> > > +        n =3D VIRTIO_NET(v->dev->vdev);
> > > +        r =3D vhost_vdpa_net_load_mac(s, n);
> > > +        if (unlikely(r < 0)) {
> > > +            return r;
> > > +        }
> > > +        r =3D vhost_vdpa_net_load_mq(s, n);
> > > +        if (unlikely(r)) {
> > > +            return r;
> > > +        }
> > > +        r =3D vhost_vdpa_net_load_offloads(s, n);
> > > +        if (unlikely(r)) {
> > > +            return r;
> > > +        }
> > > +        r =3D vhost_vdpa_net_load_rx(s, n);
> > > +        if (unlikely(r)) {
> > > +            return r;
> > > +        }
> > >      }
> > > -    r =3D vhost_vdpa_net_load_rx(s, n);
> > > -    if (unlikely(r)) {
> > > -        return r;
> > > +
> > > +    for (int i =3D 0; i < v->dev->vq_index; ++i) {
> > > +        vhost_vdpa_set_vring_ready(v, i);
> > >      }
> > >
> > >      return 0;
> > > --
> > > 2.39.3
> > >
> >
>


