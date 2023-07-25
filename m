Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C65DA7606D8
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 05:50:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qO92b-0003d2-Fq; Mon, 24 Jul 2023 23:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qO92a-0003ct-Ho
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 23:48:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qO92Y-0005sj-NL
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 23:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690256928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xoP0IHJVqP+6klsti9EyXbgdgNTqzCVCjB5LrliofX0=;
 b=alteJ61UM4Um1JbaYXQ3XBQxqaNJZr7mBJ+xmYElQKK/QU4x8LIz37ECkpHt0V+r1+ephx
 ZBT2fM7rgB5YDr0PRO4DWqRP+iuvN1B1DLiWeXujf4UUxN/GjYkx6+V8pVYL2dYoa63Baz
 2N1EFChqVzAZt+BNgJTh37faGREId/Y=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-qWKtGdJrPtGNMEm_h1xo3Q-1; Mon, 24 Jul 2023 23:48:45 -0400
X-MC-Unique: qWKtGdJrPtGNMEm_h1xo3Q-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b708d79112so44802631fa.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 20:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690256924; x=1690861724;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xoP0IHJVqP+6klsti9EyXbgdgNTqzCVCjB5LrliofX0=;
 b=CNuEHmjBElqjhzk9f9D4lA+QXNbuDPbUNgNvCdItFInfH8flbLXcrJBrh8K/RlaQgM
 PJ40i/U4NN4e44ePyvq65iOK2jJC7N9LwQrAlUwA94ZUBMLxmidyjbUJOA96MleqNfkp
 +OpmHgC3Eu1V7EgRvZryCewPlDS4x/uVRqiqCCjqxr3X1QqBlRdkjD2pgfkULVTbmive
 TZcH1vFe4bFVf0kzPj8k015As5qSBsRsPPMJQAhqhgBPwtNpZQWu8jFiXKrKreHCbdhB
 iXmAJAqZbudJ9Uzk+/cpEtApkUZL4ZzBpNUdn/hf7hP/tOdFl0dSBt1w0sftrz2VH87e
 e8Dg==
X-Gm-Message-State: ABy/qLYY7B+Uezp1UEAv7rqDEqfcm4uj8l5whSu9tyZ24xvWlagFtg+r
 zfgdoxYLtvwhKPFuaAGmYdaMFmuQbiBt4q/g0a8rf/5Umpxju+DVWi7H+qMrzX1AezgziOoRp7g
 7LUmeOn3QPEtj7aRl3r2XCt2M7ef4TXE=
X-Received: by 2002:a05:651c:237:b0:2b9:452f:41c3 with SMTP id
 z23-20020a05651c023700b002b9452f41c3mr7415727ljn.46.1690256924118; 
 Mon, 24 Jul 2023 20:48:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGBoOCcGv0YkXD36ESwAzIiWHvl/74VWiM6frmwPTmDJJYAbVUtJBo73rj1pJhCyDnSXfiYHdF3X4ZYoE/F/cU=
X-Received: by 2002:a05:651c:237:b0:2b9:452f:41c3 with SMTP id
 z23-20020a05651c023700b002b9452f41c3mr7415711ljn.46.1690256923804; Mon, 24
 Jul 2023 20:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230720181459.607008-1-eperezma@redhat.com>
 <20230720181459.607008-12-eperezma@redhat.com>
 <95fda9f7-285b-4ff2-f1fa-03f5bc804429@oracle.com>
 <CAJaqyWcb186aNf_=YhxR3nQk03nLHH9s3oiQthjaqeCY2rPJsQ@mail.gmail.com>
In-Reply-To: <CAJaqyWcb186aNf_=YhxR3nQk03nLHH9s3oiQthjaqeCY2rPJsQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 25 Jul 2023 11:48:32 +0800
Message-ID: <CACGkMEs1imfQid9cwnaY3yvCxkqCXv4k62-VSCJE7P4eJom87g@mail.gmail.com>
Subject: Re: [RFC PATCH 11/12] vdpa: use SVQ to stall dataplane while NIC
 state is being restored
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, 
 yvugenfi@redhat.com, Dragos Tatulea <dtatulea@nvidia.com>, 
 Shannon Nelson <snelson@pensando.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

On Tue, Jul 25, 2023 at 3:59=E2=80=AFAM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Sat, Jul 22, 2023 at 12:59=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.co=
m> wrote:
> >
> >
> >
> > On 7/20/2023 11:14 AM, Eugenio P=C3=A9rez wrote:
> > > Some dynamic state of a virtio-net vDPA devices is restored from CVQ =
in
> > > the event of a live migration.  However, dataplane needs to be disabl=
ed
> > > so the NIC does not receive buffers in the invalid ring.
> > >
> > > As a default method to achieve it, let's offer a shadow vring with 0
> > > avail idx.  As a fallback method, we will enable dataplane vqs later,=
 as
> > > proposed previously.
> > Let's not jump to conclusion too early what will be the default v.s.
> > fallback [1] - as this is on a latency sensitive path, I'm not fully
> > convinced ring reset could perform better than or equally same as the
> > deferred dataplane enablement approach on hardware. At this stage I
> > think ring_reset has no adoption on vendors device, while it's
> > definitely easier with lower hardware overhead for vendor to implement
> > deferred dataplane enabling.

That's my feeling as well.

> > If at some point vendor's device has to
> > support RING_RESET for other use cases (MTU change propagation for ex.,
> > a prerequisite for GRO HW) than live migration,

Currently, it is used for changing ring size, and it is planned for
AF_XDP. But I think neither of them requires low latency.

Thanks

> > defaulting to RING_RESET
> > on this SVQ path has no real benefit but adds complications needlessly
> > to vendor's device.
> >
>
> I agree with that. Let's say "*This series* uses RING_RESET as the
> default method, and late vq enablement as fallback".
>
> Michael, given the current HW support, would it work to start merging
> the late enable for vDPA after the feature freeze, and then add the
> use of RING_RESET on top later?
>
> Thanks!
>
> > [1]
> > https://lore.kernel.org/virtualization/bf2164a9-1dfd-14d9-be2a-8bb7620a=
0619@oracle.com/T/#m15caca6fbb00ca9c00e2b33391297a2d8282ff89
> >
> > Thanks,
> > -Siwei
> >
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > >   net/vhost-vdpa.c | 49 +++++++++++++++++++++++++++++++++++++++++++--=
---
> > >   1 file changed, 44 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > > index af83de92f8..e14ae48f23 100644
> > > --- a/net/vhost-vdpa.c
> > > +++ b/net/vhost-vdpa.c
> > > @@ -338,10 +338,25 @@ static int vhost_vdpa_net_data_start(NetClientS=
tate *nc)
> > >   {
> > >       VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> > >       struct vhost_vdpa *v =3D &s->vhost_vdpa;
> > > +    bool has_cvq =3D v->dev->vq_index_end % 2;
> > >
> > >       assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
> > >
> > > -    if (s->always_svq ||
> > > +    if (has_cvq && (v->dev->features & VIRTIO_F_RING_RESET)) {
> > > +        /*
> > > +         * Offer a fake vring to the device while the state is resto=
red
> > > +         * through CVQ.  That way, the guest will not see packets in=
 unexpected
> > > +         * queues.
> > > +         *
> > > +         * This will be undone after loading all state through CVQ, =
at
> > > +         * vhost_vdpa_net_load.
> > > +         *
> > > +         * TODO: Future optimizations may skip some SVQ setup and te=
ardown,
> > > +         * like set the right kick and call fd or doorbell maps dire=
ctly, and
> > > +         * the iova tree.
> > > +         */
> > > +        v->shadow_vqs_enabled =3D true;
> > > +    } else if (s->always_svq ||
> > >           migration_is_setup_or_active(migrate_get_current()->state))=
 {
> > >           v->shadow_vqs_enabled =3D true;
> > >           v->shadow_data =3D true;
> > > @@ -738,10 +753,34 @@ static int vhost_vdpa_net_load(NetClientState *=
nc)
> > >           return r;
> > >       }
> > >
> > > -    for (int i =3D 0; i < v->dev->vq_index; ++i) {
> > > -        r =3D vhost_vdpa_set_vring_ready(v, i);
> > > -        if (unlikely(r)) {
> > > -            return r;
> > > +    if (v->dev->features & VIRTIO_F_RING_RESET && !s->always_svq &&
> > > +        !migration_is_setup_or_active(migrate_get_current()->state))=
 {
> > > +        NICState *nic =3D qemu_get_nic(s->nc.peer);
> > > +        int queue_pairs =3D n->multiqueue ? n->max_queue_pairs : 1;
> > > +
> > > +        for (int i =3D 0; i < queue_pairs; ++i) {
> > > +            NetClientState *ncs =3D qemu_get_peer(nic->ncs, i);
> > > +            VhostVDPAState *s_i =3D DO_UPCAST(VhostVDPAState, nc, nc=
s);
> > > +
> > > +            for (int j =3D 0; j < 2; ++j) {
> > > +                vhost_net_virtqueue_reset(v->dev->vdev, ncs->peer, j=
);
> > > +            }
> > > +
> > > +            s_i->vhost_vdpa.shadow_vqs_enabled =3D false;
> > > +
> > > +            for (int j =3D 0; j < 2; ++j) {
> > > +                r =3D vhost_net_virtqueue_restart(v->dev->vdev, ncs-=
>peer, j);
> > > +                if (unlikely(r < 0)) {
> > > +                    return r;
> > > +                }
> > > +            }
> > > +        }
> > > +    } else {
> > > +        for (int i =3D 0; i < v->dev->vq_index; ++i) {
> > > +            r =3D vhost_vdpa_set_vring_ready(v, i);
> > > +            if (unlikely(r)) {
> > > +                return r;
> > > +            }
> > >           }
> > >       }
> > >
> >
>


