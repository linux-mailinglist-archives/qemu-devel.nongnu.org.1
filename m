Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EAF75C4D9
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 12:42:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMnYw-00065J-NC; Fri, 21 Jul 2023 06:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qMnYu-00064p-7b
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 06:40:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qMnYr-0002S7-Bf
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 06:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689936035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vw/tD1UgBwOtkLZXZXOYTOE1yd0+DAdEy3Nj4AOe9nY=;
 b=Dlz9MHxgeGQrOIUAURFwn/edIgMQwoPJWxkbx8qvEhIpJD7+wLaW9MxU/nSd30pq0wOdIY
 yTiF07midlcGSJ4GeyV+migqbwycKUvzytEKoAoy47ScNCSkK5yB7xWClF/Rjc6IRd7L6k
 Y4pC6UnUV3zWBsycW5hzi4qoS0WXNSo=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-NmTKUu4TOFaqrI4TOh0iqQ-1; Fri, 21 Jul 2023 06:40:34 -0400
X-MC-Unique: NmTKUu4TOFaqrI4TOh0iqQ-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-c5f4d445190so1603724276.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 03:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689936034; x=1690540834;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vw/tD1UgBwOtkLZXZXOYTOE1yd0+DAdEy3Nj4AOe9nY=;
 b=Np3qOvbCsfeF79M7aqGE2TZVvWmg5KI6UaOVkD8GVMmd5O2uWIdSC5xr7Y3JB82P+0
 u+XXja6u7aYYZemTh0kpOtgivIoYC0f0q9REnCz4jkIFHf1CjovXoGysvC5EePdHvTpq
 3acPaDxl1mKqQZTh4xLFhQSbsiJULJDnXh5R44MUaNcuBaAi+JlE57FJoqcFUcMJVdge
 BJxN4uQr7lm7LPMwQo5q6fuxrbdxvXGnq6HG8Wq8y7m/1j+jUMOqFn7iVOpmgqPJVZrY
 sa1ecoDK0HFSS3OWZ3JZRXvCTMub7tFoOqO+4SX3532RFOp2UjM6frJU5LaVIMrEMSJc
 CL6g==
X-Gm-Message-State: ABy/qLYRHcIqWJ3W/ZxC6chGtYd44svL/oJnHOR7bYLasNKf1KXKK7JX
 CPTc417TodHcYdEo2A6SKMJu9BkHJ/6KGFD6UVJEsRNe2BmMtnUJYxvZ7PsdSbje8Dydn8ES6dl
 dnfAmVFQgtb7cSHGukveC4pVKVpiId0w=
X-Received: by 2002:a25:dacf:0:b0:cc7:52e7:b91d with SMTP id
 n198-20020a25dacf000000b00cc752e7b91dmr1432540ybf.9.1689936033770; 
 Fri, 21 Jul 2023 03:40:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGgEq/AjPbK913o7eRpl4EiF7NRPqAaBIH7CkuOVlrd/j1UMjjrACvzdP/iidcDVAsB+9BTd+3v9OhcERto5jk=
X-Received: by 2002:a25:dacf:0:b0:cc7:52e7:b91d with SMTP id
 n198-20020a25dacf000000b00cc752e7b91dmr1432528ybf.9.1689936033445; Fri, 21
 Jul 2023 03:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230418225638.1467969-1-peili.dev@gmail.com>
 <CAJaqyWebSowMMWh+HCjj7tmbA3Ey6C69T=SPA4k+6fd_-GjfoA@mail.gmail.com>
 <CACGkMEu0d0y82wo1p2g-ovbUTYJcVon0-t8fvgFQLokZmd7hDQ@mail.gmail.com>
 <CACCFcFr8rYbM3OF8Hk=WnS7mAUv49aTsYHWnMwkMVg8SWRhp+Q@mail.gmail.com>
 <CAJaqyWeOuUDKyXd7QAOUhMb-6G+P_q_X4Nz7K+QSJwqdE8UO2Q@mail.gmail.com>
 <20230718065500-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230718065500-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 21 Jul 2023 12:39:57 +0200
Message-ID: <CAJaqyWc-ubCuC=vLZkPzvm3=0f755TA4BroXswQ=Qv3Y1qx8fw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Reduce vdpa initialization / startup overhead
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Pei Li <peili@andrew.cmu.edu>, Jason Wang <jasowang@redhat.com>,
 peili.dev@gmail.com, 
 qemu-devel@nongnu.org, Si-Wei Liu <si-wei.liu@oracle.com>
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

On Tue, Jul 18, 2023 at 12:55=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Thu, Apr 20, 2023 at 10:59:56AM +0200, Eugenio Perez Martin wrote:
> > On Thu, Apr 20, 2023 at 7:25=E2=80=AFAM Pei Li <peili@andrew.cmu.edu> w=
rote:
> > >
> > > Hi all,
> > >
> > > My bad, I just submitted the kernel patch. If we are passing some gen=
eric command, still we have to add an additional field in the structure to =
indicate what is the unbatched version of this command, and the struct vhos=
t_ioctls would be some command specific structure. In summary, the structur=
e would be something like
> > > struct vhost_cmd_batch {
> > >     int ncmds;
> > >     int cmd;
> >
> > The unbatched version should go in each vhost_ioctls. That allows us
> > to send many different commands in one ioctl instead of having to
> > resort to many ioctls, each one for a different task.
> >
> > The problem with that is the size of that struct vhost_ioctl, so we
> > can build an array. I think it should be enough with the biggest of
> > them (vhost_vring_addr ?) for a long time, but I would like to know if
> > anybody finds a drawback here. We could always resort to pointers if
> > we find we need more space, or start with them from the beginning.
> >
> > CCing Si-Wei here too, as he is also interested in reducing the startup=
 time.
> >
> > Thanks!
>
> And copying my response too:
> This is all very exciting, but what exactly is the benefit?
> No optimization patches are going to be merged without
> numbers showing performance gains.
> In this case, can you show gains in process startup time?
> Are they significant enough to warrant adding new UAPI?
>

This should have been marked as RFC in that regard.

When this was sent it was one of the planned actions to reduce
overhead. After Si-Wei benchmarks, all the efforts will focus on
reducing the pinning / maps for the moment. It is unlikely that this
will be moved forward soon.

Thanks!


>
>
> > >     struct vhost_ioctls[];
> > > };
> > >
> > > This is doable. Also, this is my first time submitting patches to ope=
n source, sorry about the mess in advance. That being said, feel free to th=
row questions / comments!
> > >
> > > Thanks and best regards,
> > > Pei
> > >
> > > On Wed, Apr 19, 2023 at 9:19=E2=80=AFPM Jason Wang <jasowang@redhat.c=
om> wrote:
> > >>
> > >> On Wed, Apr 19, 2023 at 11:33=E2=80=AFPM Eugenio Perez Martin
> > >> <eperezma@redhat.com> wrote:
> > >> >
> > >> > On Wed, Apr 19, 2023 at 12:56=E2=80=AFAM <peili.dev@gmail.com> wro=
te:
> > >> > >
> > >> > > From: Pei Li <peili.dev@gmail.com>
> > >> > >
> > >> > > Currently, part of the vdpa initialization / startup process
> > >> > > needs to trigger many ioctls per vq, which is very inefficient
> > >> > > and causing unnecessary context switch between user mode and
> > >> > > kernel mode.
> > >> > >
> > >> > > This patch creates an additional ioctl() command, namely
> > >> > > VHOST_VDPA_GET_VRING_GROUP_BATCH, that will batching
> > >> > > commands of VHOST_VDPA_GET_VRING_GROUP into a single
> > >> > > ioctl() call.
> > >>
> > >> I'd expect there's a kernel patch but I didn't see that?
> > >>
> > >> If we want to go this way. Why simply have a more generic way, that =
is
> > >> introducing something like:
> > >>
> > >> VHOST_CMD_BATCH which did something like
> > >>
> > >> struct vhost_cmd_batch {
> > >>     int ncmds;
> > >>     struct vhost_ioctls[];
> > >> };
> > >>
> > >> Then you can batch other ioctls other than GET_VRING_GROUP?
> > >>
> > >> Thanks
> > >>
> > >> > >
> > >> >
> > >> > It seems to me you forgot to send the 0/2 cover letter :).
> > >> >
> > >> > Please include the time we save thanks to avoiding the repetitive
> > >> > ioctls in each patch.
> > >> >
> > >> > CCing Jason and Michael.
> > >> >
> > >> > > Signed-off-by: Pei Li <peili.dev@gmail.com>
> > >> > > ---
> > >> > >  hw/virtio/vhost-vdpa.c                       | 31 +++++++++++++=
++-----
> > >> > >  include/standard-headers/linux/vhost_types.h |  3 ++
> > >> > >  linux-headers/linux/vhost.h                  |  7 +++++
> > >> > >  3 files changed, 33 insertions(+), 8 deletions(-)
> > >> > >
> > >> > > diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> > >> > > index bc6bad23d5..6d45ff8539 100644
> > >> > > --- a/hw/virtio/vhost-vdpa.c
> > >> > > +++ b/hw/virtio/vhost-vdpa.c
> > >> > > @@ -679,7 +679,8 @@ static int vhost_vdpa_set_backend_cap(struct=
 vhost_dev *dev)
> > >> > >      uint64_t f =3D 0x1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2 |
> > >> > >          0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH |
> > >> > >          0x1ULL << VHOST_BACKEND_F_IOTLB_ASID |
> > >> > > -        0x1ULL << VHOST_BACKEND_F_SUSPEND;
> > >> > > +        0x1ULL << VHOST_BACKEND_F_SUSPEND |
> > >> > > +        0x1ULL << VHOST_BACKEND_F_IOCTL_BATCH;
> > >> > >      int r;
> > >> > >
> > >> > >      if (vhost_vdpa_call(dev, VHOST_GET_BACKEND_FEATURES, &featu=
res)) {
> > >> > > @@ -731,14 +732,28 @@ static int vhost_vdpa_get_vq_index(struct =
vhost_dev *dev, int idx)
> > >> > >
> > >> > >  static int vhost_vdpa_set_vring_ready(struct vhost_dev *dev)
> > >> > >  {
> > >> > > -    int i;
> > >> > > +    int i, nvqs =3D dev->nvqs;
> > >> > > +    uint64_t backend_features =3D dev->backend_cap;
> > >> > > +
> > >> > >      trace_vhost_vdpa_set_vring_ready(dev);
> > >> > > -    for (i =3D 0; i < dev->nvqs; ++i) {
> > >> > > -        struct vhost_vring_state state =3D {
> > >> > > -            .index =3D dev->vq_index + i,
> > >> > > -            .num =3D 1,
> > >> > > -        };
> > >> > > -        vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING_ENABLE, &stat=
e);
> > >> > > +
> > >> > > +    if (!(backend_features & BIT_ULL(VHOST_BACKEND_F_IOCTL_BATC=
H))) {
> > >> > > +        for (i =3D 0; i < nvqs; ++i) {
> > >> > > +            struct vhost_vring_state state =3D {
> > >> > > +                .index =3D dev->vq_index + i,
> > >> > > +                .num =3D 1,
> > >> > > +            };
> > >> > > +            vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING_ENABLE, &=
state);
> > >> > > +        }
> > >> > > +    } else {
> > >> > > +        struct vhost_vring_state states[nvqs + 1];
> > >> > > +        states[0].num =3D nvqs;
> > >> > > +        for (i =3D 1; i <=3D nvqs; ++i) {
> > >> > > +            states[i].index =3D dev->vq_index + i - 1;
> > >> > > +            states[i].num =3D 1;
> > >> > > +        }
> > >> > > +
> > >> >
> > >> > I think it's more clear to share the array of vhost_vring_state
> > >> > states[nvqs + 1], and then fill it either in one shot with
> > >> > VHOST_VDPA_SET_VRING_ENABLE_BATCH or individually with
> > >> > VHOST_VDPA_SET_VRING_ENABLE.
> > >> >
> > >> > The same feedback goes for VHOST_VDPA_GET_VRING_GROUP_BATCH in the=
 next patch.
> > >> >
> > >> > > +        vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING_ENABLE_BATCH,=
 &states[0]);
> > >> > >      }
> > >> > >      return 0;
> > >> >
> > >> > This comment is previous to your patch but I just realized we don'=
t
> > >> > check the return value of vhost_vdpa_call. Maybe it is worth
> > >> > considering addressing that in this series too.
> > >> >
> > >> > >  }
> > >> > > diff --git a/include/standard-headers/linux/vhost_types.h b/incl=
ude/standard-headers/linux/vhost_types.h
> > >> > > index c41a73fe36..068d0e1ceb 100644
> > >> > > --- a/include/standard-headers/linux/vhost_types.h
> > >> > > +++ b/include/standard-headers/linux/vhost_types.h
> > >> > > @@ -164,4 +164,7 @@ struct vhost_vdpa_iova_range {
> > >> > >  /* Device can be suspended */
> > >> > >  #define VHOST_BACKEND_F_SUSPEND  0x4
> > >> > >
> > >> > > +/* IOCTL requests can be batched */
> > >> > > +#define VHOST_BACKEND_F_IOCTL_BATCH 0x6
> > >> > > +
> > >> > >  #endif
> > >> > > diff --git a/linux-headers/linux/vhost.h b/linux-headers/linux/v=
host.h
> > >> > > index f9f115a7c7..4c9ddd0a0e 100644
> > >> > > --- a/linux-headers/linux/vhost.h
> > >> > > +++ b/linux-headers/linux/vhost.h
> > >> > > @@ -180,4 +180,11 @@
> > >> > >   */
> > >> > >  #define VHOST_VDPA_SUSPEND             _IO(VHOST_VIRTIO, 0x7D)
> > >> > >
> > >> > > +/* Batch version of VHOST_VDPA_SET_VRING_ENABLE
> > >> > > + *
> > >> > > + * Enable/disable the ring while batching the commands.
> > >> > > + */
> > >> > > +#define VHOST_VDPA_SET_VRING_ENABLE_BATCH      _IOW(VHOST_VIRTI=
O, 0x7F, \
> > >> > > +                                            struct vhost_vring_=
state)
> > >> > > +
> > >> >
> > >> > These headers should be updated with update-linux-headers.sh. To b=
e
> > >> > done that way we need the changes merged in the kernel before.
> > >> >
> > >> > We can signal that the series is not ready for inclusion with the
> > >> > subject [RFC. PATCH], like [1], and note it in the commit message.
> > >> > That way, you can keep updating the header manually for demonstrat=
ion
> > >> > purposes.
> > >> >
> > >> > Thanks!
> > >> >
> > >> > [1] https://lore.kernel.org/qemu-devel/20220413163206.1958254-23-e=
perezma@redhat.com/
> > >> >
> > >>
> > >>
> >
> >
>


