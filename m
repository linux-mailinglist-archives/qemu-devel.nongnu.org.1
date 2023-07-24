Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 866D276002F
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 22:01:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qO1ic-0004oF-5H; Mon, 24 Jul 2023 15:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qO1iZ-0004nu-K4
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 15:59:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qO1iX-0001n3-J8
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 15:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690228780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CsU6x7qiCFJBCuYXC2qALPvxeg2+C71wwHHEUJ0WEEo=;
 b=H7qTAtfQmpDzPJ9WDFzxAm9drN7M97ddKlbcPBB3MLAvuSAuw9tEVbEaE4IaV6tnES+U1D
 43tocyEHQuVAm8tnMVs4YFSdtTIucZVwZFtXgLEteEqkW2RgHcd8Wi3au6uZm5lf/Y7VeO
 j0yM3HGJyx7+z9ufoHWYT1YT1mBHBXE=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-wCPu62F2ObOeFu13MEkLbg-1; Mon, 24 Jul 2023 15:59:38 -0400
X-MC-Unique: wCPu62F2ObOeFu13MEkLbg-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-d11f35a0d5cso1282431276.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 12:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690228778; x=1690833578;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CsU6x7qiCFJBCuYXC2qALPvxeg2+C71wwHHEUJ0WEEo=;
 b=jyHEwucXNY6Od3uNZdqy7ujqqxr+Yfu0iTS41eBJQyjT1OuMLQsMUISPuCvCyQyG6q
 Z7m+oP65nP7KoJ52oMLgjCTcA7xuft97dkqiP3/hIZPDVzqJGpyKWuYZXUQfm5VqFfJS
 4JiIqbfiDN8kV1VE7XwZDVUUewzHmYZI78DBPE3okNTnzB4gDXnNoFZdlf76qYEYH20j
 5M7MgbzUIF6TYVccqN+VKA1aQvH9RalG0u3I0GlCjvyreI4neL389LM536OKpYW+qkjV
 FZbxhxEgNlrfVwecU9iEizilh2B/mlTqxgEexlJQDJip57nQf1aCVmopj51I3XN5PVSf
 UBSQ==
X-Gm-Message-State: ABy/qLaiOGTESke0bXIqFjfeBmYEaK9ueWLwgWb2ZivS9Uyg/DS9FOUK
 QulCkDDzVmQD7JalVi5UpJFXecES2yrHoKRCT2hyKO94cu0SRiKkZR9mAVoPWrX8B4B81bIiS+M
 djPV20tzndcYIE5tZzDA/CBUMhLYBxNE=
X-Received: by 2002:a25:ab12:0:b0:d12:3108:f90f with SMTP id
 u18-20020a25ab12000000b00d123108f90fmr3245205ybi.24.1690228778263; 
 Mon, 24 Jul 2023 12:59:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHQCTwpqXrf2dXq7V1oigKtIvaVbd95pGvbHqWcDkalJ5F3p0l/nFk3NxogHthzJKQISjgIiuSlAC3fNT/8moM=
X-Received: by 2002:a25:ab12:0:b0:d12:3108:f90f with SMTP id
 u18-20020a25ab12000000b00d123108f90fmr3245190ybi.24.1690228777977; Mon, 24
 Jul 2023 12:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230720181459.607008-1-eperezma@redhat.com>
 <20230720181459.607008-12-eperezma@redhat.com>
 <95fda9f7-285b-4ff2-f1fa-03f5bc804429@oracle.com>
In-Reply-To: <95fda9f7-285b-4ff2-f1fa-03f5bc804429@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 24 Jul 2023 21:59:01 +0200
Message-ID: <CAJaqyWcb186aNf_=YhxR3nQk03nLHH9s3oiQthjaqeCY2rPJsQ@mail.gmail.com>
Subject: Re: [RFC PATCH 11/12] vdpa: use SVQ to stall dataplane while NIC
 state is being restored
To: Si-Wei Liu <si-wei.liu@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, yvugenfi@redhat.com, 
 Jason Wang <jasowang@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
 Shannon Nelson <snelson@pensando.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, Jul 22, 2023 at 12:59=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com>=
 wrote:
>
>
>
> On 7/20/2023 11:14 AM, Eugenio P=C3=A9rez wrote:
> > Some dynamic state of a virtio-net vDPA devices is restored from CVQ in
> > the event of a live migration.  However, dataplane needs to be disabled
> > so the NIC does not receive buffers in the invalid ring.
> >
> > As a default method to achieve it, let's offer a shadow vring with 0
> > avail idx.  As a fallback method, we will enable dataplane vqs later, a=
s
> > proposed previously.
> Let's not jump to conclusion too early what will be the default v.s.
> fallback [1] - as this is on a latency sensitive path, I'm not fully
> convinced ring reset could perform better than or equally same as the
> deferred dataplane enablement approach on hardware. At this stage I
> think ring_reset has no adoption on vendors device, while it's
> definitely easier with lower hardware overhead for vendor to implement
> deferred dataplane enabling. If at some point vendor's device has to
> support RING_RESET for other use cases (MTU change propagation for ex.,
> a prerequisite for GRO HW) than live migration, defaulting to RING_RESET
> on this SVQ path has no real benefit but adds complications needlessly
> to vendor's device.
>

I agree with that. Let's say "*This series* uses RING_RESET as the
default method, and late vq enablement as fallback".

Michael, given the current HW support, would it work to start merging
the late enable for vDPA after the feature freeze, and then add the
use of RING_RESET on top later?

Thanks!

> [1]
> https://lore.kernel.org/virtualization/bf2164a9-1dfd-14d9-be2a-8bb7620a06=
19@oracle.com/T/#m15caca6fbb00ca9c00e2b33391297a2d8282ff89
>
> Thanks,
> -Siwei
>
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >   net/vhost-vdpa.c | 49 +++++++++++++++++++++++++++++++++++++++++++----=
-
> >   1 file changed, 44 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > index af83de92f8..e14ae48f23 100644
> > --- a/net/vhost-vdpa.c
> > +++ b/net/vhost-vdpa.c
> > @@ -338,10 +338,25 @@ static int vhost_vdpa_net_data_start(NetClientSta=
te *nc)
> >   {
> >       VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> >       struct vhost_vdpa *v =3D &s->vhost_vdpa;
> > +    bool has_cvq =3D v->dev->vq_index_end % 2;
> >
> >       assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
> >
> > -    if (s->always_svq ||
> > +    if (has_cvq && (v->dev->features & VIRTIO_F_RING_RESET)) {
> > +        /*
> > +         * Offer a fake vring to the device while the state is restore=
d
> > +         * through CVQ.  That way, the guest will not see packets in u=
nexpected
> > +         * queues.
> > +         *
> > +         * This will be undone after loading all state through CVQ, at
> > +         * vhost_vdpa_net_load.
> > +         *
> > +         * TODO: Future optimizations may skip some SVQ setup and tear=
down,
> > +         * like set the right kick and call fd or doorbell maps direct=
ly, and
> > +         * the iova tree.
> > +         */
> > +        v->shadow_vqs_enabled =3D true;
> > +    } else if (s->always_svq ||
> >           migration_is_setup_or_active(migrate_get_current()->state)) {
> >           v->shadow_vqs_enabled =3D true;
> >           v->shadow_data =3D true;
> > @@ -738,10 +753,34 @@ static int vhost_vdpa_net_load(NetClientState *nc=
)
> >           return r;
> >       }
> >
> > -    for (int i =3D 0; i < v->dev->vq_index; ++i) {
> > -        r =3D vhost_vdpa_set_vring_ready(v, i);
> > -        if (unlikely(r)) {
> > -            return r;
> > +    if (v->dev->features & VIRTIO_F_RING_RESET && !s->always_svq &&
> > +        !migration_is_setup_or_active(migrate_get_current()->state)) {
> > +        NICState *nic =3D qemu_get_nic(s->nc.peer);
> > +        int queue_pairs =3D n->multiqueue ? n->max_queue_pairs : 1;
> > +
> > +        for (int i =3D 0; i < queue_pairs; ++i) {
> > +            NetClientState *ncs =3D qemu_get_peer(nic->ncs, i);
> > +            VhostVDPAState *s_i =3D DO_UPCAST(VhostVDPAState, nc, ncs)=
;
> > +
> > +            for (int j =3D 0; j < 2; ++j) {
> > +                vhost_net_virtqueue_reset(v->dev->vdev, ncs->peer, j);
> > +            }
> > +
> > +            s_i->vhost_vdpa.shadow_vqs_enabled =3D false;
> > +
> > +            for (int j =3D 0; j < 2; ++j) {
> > +                r =3D vhost_net_virtqueue_restart(v->dev->vdev, ncs->p=
eer, j);
> > +                if (unlikely(r < 0)) {
> > +                    return r;
> > +                }
> > +            }
> > +        }
> > +    } else {
> > +        for (int i =3D 0; i < v->dev->vq_index; ++i) {
> > +            r =3D vhost_vdpa_set_vring_ready(v, i);
> > +            if (unlikely(r)) {
> > +                return r;
> > +            }
> >           }
> >       }
> >
>


