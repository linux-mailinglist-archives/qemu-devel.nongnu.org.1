Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2D17579E3
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 12:56:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLiMt-00046X-UA; Tue, 18 Jul 2023 06:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qLiMs-00046E-ML
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 06:55:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qLiMq-0004yV-O2
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 06:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689677744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LGKvf+HrStHUFLDT/Ab7Ly8KWy/8Oo3rhxjzrq6eDas=;
 b=YzwZxzWFQFC4VuXUbloO19p1i9odkWQGbZ3sJrVSksQlXvyF8K6KbxNwFJabyZIrK69tL0
 2jV0vgMR7ymJqSYTNrZPZ4qhVVqV76Ovzyzi7+ePcbGNot3FJMsdN3J61W16y+tf79NQXS
 +zoIctUs0T3J27NKv/xE5viIMbQbb0I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-em3PucaWNzyMfJjoC2uPaQ-1; Tue, 18 Jul 2023 06:55:42 -0400
X-MC-Unique: em3PucaWNzyMfJjoC2uPaQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fc30453231so35057735e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 03:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689677741; x=1692269741;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LGKvf+HrStHUFLDT/Ab7Ly8KWy/8Oo3rhxjzrq6eDas=;
 b=KH6O9k/z2wi+LMgAQT9U8pHrXGjTCefg4UcVqr09HcOTw8XYVx8CdlvL3kgUXeM0sC
 DTHlp6Q0c1AE0DkTatH9n7xAzDi6paqdcv2YvAcpNXESZfjnVMRUzxCCXrh+zuy47twl
 LSHHiwaVzt9TN+2xiyITba5Ev7EtYBmg93QGZ4qXg6+G8vAdG9wde+qwBrBidbL3+Ecz
 RBzuJ544ges/CYzly7krLB5WlhIFqWbFoIawtjULwzuoHESL/vBCn+pl+kYB6PMwKhjr
 RcDDzuP0r2epQuLe4yg45yyU2GpYdfkzNSnyAoatMdh7JXHI6i5ECOjVcKp2iZZU+Dil
 pnDw==
X-Gm-Message-State: ABy/qLb8KqrRJYzRwJi06YgfjkuifW2MDGpDeoKPQIvLWRNfwUbFQVLj
 XO6yKfJAIACw/JHFVtV/JIpdjdMYbPJtdp1MP1Z/9LshXSy/9TMUFs78AKf6ZHxMPvjgTrgNVVk
 cTh731mXmYbTsh5k=
X-Received: by 2002:a05:600c:2253:b0:3fb:a937:6024 with SMTP id
 a19-20020a05600c225300b003fba9376024mr1638927wmm.29.1689677741694; 
 Tue, 18 Jul 2023 03:55:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGZnbsDZgb+uQ/D/UJb/sNVGF3DI1uT+roLvfRF5trpeLDxK/+JIkrSILQGYQBEXguBPXY6JQ==
X-Received: by 2002:a05:600c:2253:b0:3fb:a937:6024 with SMTP id
 a19-20020a05600c225300b003fba9376024mr1638912wmm.29.1689677741358; 
 Tue, 18 Jul 2023 03:55:41 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:a216:963c:8e9a:5e99:d745])
 by smtp.gmail.com with ESMTPSA id
 q8-20020a1ce908000000b003fc02a410d0sm10035081wmc.48.2023.07.18.03.55.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jul 2023 03:55:40 -0700 (PDT)
Date: Tue, 18 Jul 2023 06:55:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Pei Li <peili@andrew.cmu.edu>, Jason Wang <jasowang@redhat.com>,
 peili.dev@gmail.com, qemu-devel@nongnu.org,
 Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH 1/2] Reduce vdpa initialization / startup overhead
Message-ID: <20230718065500-mutt-send-email-mst@kernel.org>
References: <20230418225638.1467969-1-peili.dev@gmail.com>
 <CAJaqyWebSowMMWh+HCjj7tmbA3Ey6C69T=SPA4k+6fd_-GjfoA@mail.gmail.com>
 <CACGkMEu0d0y82wo1p2g-ovbUTYJcVon0-t8fvgFQLokZmd7hDQ@mail.gmail.com>
 <CACCFcFr8rYbM3OF8Hk=WnS7mAUv49aTsYHWnMwkMVg8SWRhp+Q@mail.gmail.com>
 <CAJaqyWeOuUDKyXd7QAOUhMb-6G+P_q_X4Nz7K+QSJwqdE8UO2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWeOuUDKyXd7QAOUhMb-6G+P_q_X4Nz7K+QSJwqdE8UO2Q@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Thu, Apr 20, 2023 at 10:59:56AM +0200, Eugenio Perez Martin wrote:
> On Thu, Apr 20, 2023 at 7:25 AM Pei Li <peili@andrew.cmu.edu> wrote:
> >
> > Hi all,
> >
> > My bad, I just submitted the kernel patch. If we are passing some generic command, still we have to add an additional field in the structure to indicate what is the unbatched version of this command, and the struct vhost_ioctls would be some command specific structure. In summary, the structure would be something like
> > struct vhost_cmd_batch {
> >     int ncmds;
> >     int cmd;
> 
> The unbatched version should go in each vhost_ioctls. That allows us
> to send many different commands in one ioctl instead of having to
> resort to many ioctls, each one for a different task.
> 
> The problem with that is the size of that struct vhost_ioctl, so we
> can build an array. I think it should be enough with the biggest of
> them (vhost_vring_addr ?) for a long time, but I would like to know if
> anybody finds a drawback here. We could always resort to pointers if
> we find we need more space, or start with them from the beginning.
> 
> CCing Si-Wei here too, as he is also interested in reducing the startup time.
> 
> Thanks!

And copying my response too:
This is all very exciting, but what exactly is the benefit?
No optimization patches are going to be merged without
numbers showing performance gains.
In this case, can you show gains in process startup time?
Are they significant enough to warrant adding new UAPI?



> >     struct vhost_ioctls[];
> > };
> >
> > This is doable. Also, this is my first time submitting patches to open source, sorry about the mess in advance. That being said, feel free to throw questions / comments!
> >
> > Thanks and best regards,
> > Pei
> >
> > On Wed, Apr 19, 2023 at 9:19 PM Jason Wang <jasowang@redhat.com> wrote:
> >>
> >> On Wed, Apr 19, 2023 at 11:33 PM Eugenio Perez Martin
> >> <eperezma@redhat.com> wrote:
> >> >
> >> > On Wed, Apr 19, 2023 at 12:56 AM <peili.dev@gmail.com> wrote:
> >> > >
> >> > > From: Pei Li <peili.dev@gmail.com>
> >> > >
> >> > > Currently, part of the vdpa initialization / startup process
> >> > > needs to trigger many ioctls per vq, which is very inefficient
> >> > > and causing unnecessary context switch between user mode and
> >> > > kernel mode.
> >> > >
> >> > > This patch creates an additional ioctl() command, namely
> >> > > VHOST_VDPA_GET_VRING_GROUP_BATCH, that will batching
> >> > > commands of VHOST_VDPA_GET_VRING_GROUP into a single
> >> > > ioctl() call.
> >>
> >> I'd expect there's a kernel patch but I didn't see that?
> >>
> >> If we want to go this way. Why simply have a more generic way, that is
> >> introducing something like:
> >>
> >> VHOST_CMD_BATCH which did something like
> >>
> >> struct vhost_cmd_batch {
> >>     int ncmds;
> >>     struct vhost_ioctls[];
> >> };
> >>
> >> Then you can batch other ioctls other than GET_VRING_GROUP?
> >>
> >> Thanks
> >>
> >> > >
> >> >
> >> > It seems to me you forgot to send the 0/2 cover letter :).
> >> >
> >> > Please include the time we save thanks to avoiding the repetitive
> >> > ioctls in each patch.
> >> >
> >> > CCing Jason and Michael.
> >> >
> >> > > Signed-off-by: Pei Li <peili.dev@gmail.com>
> >> > > ---
> >> > >  hw/virtio/vhost-vdpa.c                       | 31 +++++++++++++++-----
> >> > >  include/standard-headers/linux/vhost_types.h |  3 ++
> >> > >  linux-headers/linux/vhost.h                  |  7 +++++
> >> > >  3 files changed, 33 insertions(+), 8 deletions(-)
> >> > >
> >> > > diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> >> > > index bc6bad23d5..6d45ff8539 100644
> >> > > --- a/hw/virtio/vhost-vdpa.c
> >> > > +++ b/hw/virtio/vhost-vdpa.c
> >> > > @@ -679,7 +679,8 @@ static int vhost_vdpa_set_backend_cap(struct vhost_dev *dev)
> >> > >      uint64_t f = 0x1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2 |
> >> > >          0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH |
> >> > >          0x1ULL << VHOST_BACKEND_F_IOTLB_ASID |
> >> > > -        0x1ULL << VHOST_BACKEND_F_SUSPEND;
> >> > > +        0x1ULL << VHOST_BACKEND_F_SUSPEND |
> >> > > +        0x1ULL << VHOST_BACKEND_F_IOCTL_BATCH;
> >> > >      int r;
> >> > >
> >> > >      if (vhost_vdpa_call(dev, VHOST_GET_BACKEND_FEATURES, &features)) {
> >> > > @@ -731,14 +732,28 @@ static int vhost_vdpa_get_vq_index(struct vhost_dev *dev, int idx)
> >> > >
> >> > >  static int vhost_vdpa_set_vring_ready(struct vhost_dev *dev)
> >> > >  {
> >> > > -    int i;
> >> > > +    int i, nvqs = dev->nvqs;
> >> > > +    uint64_t backend_features = dev->backend_cap;
> >> > > +
> >> > >      trace_vhost_vdpa_set_vring_ready(dev);
> >> > > -    for (i = 0; i < dev->nvqs; ++i) {
> >> > > -        struct vhost_vring_state state = {
> >> > > -            .index = dev->vq_index + i,
> >> > > -            .num = 1,
> >> > > -        };
> >> > > -        vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING_ENABLE, &state);
> >> > > +
> >> > > +    if (!(backend_features & BIT_ULL(VHOST_BACKEND_F_IOCTL_BATCH))) {
> >> > > +        for (i = 0; i < nvqs; ++i) {
> >> > > +            struct vhost_vring_state state = {
> >> > > +                .index = dev->vq_index + i,
> >> > > +                .num = 1,
> >> > > +            };
> >> > > +            vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING_ENABLE, &state);
> >> > > +        }
> >> > > +    } else {
> >> > > +        struct vhost_vring_state states[nvqs + 1];
> >> > > +        states[0].num = nvqs;
> >> > > +        for (i = 1; i <= nvqs; ++i) {
> >> > > +            states[i].index = dev->vq_index + i - 1;
> >> > > +            states[i].num = 1;
> >> > > +        }
> >> > > +
> >> >
> >> > I think it's more clear to share the array of vhost_vring_state
> >> > states[nvqs + 1], and then fill it either in one shot with
> >> > VHOST_VDPA_SET_VRING_ENABLE_BATCH or individually with
> >> > VHOST_VDPA_SET_VRING_ENABLE.
> >> >
> >> > The same feedback goes for VHOST_VDPA_GET_VRING_GROUP_BATCH in the next patch.
> >> >
> >> > > +        vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING_ENABLE_BATCH, &states[0]);
> >> > >      }
> >> > >      return 0;
> >> >
> >> > This comment is previous to your patch but I just realized we don't
> >> > check the return value of vhost_vdpa_call. Maybe it is worth
> >> > considering addressing that in this series too.
> >> >
> >> > >  }
> >> > > diff --git a/include/standard-headers/linux/vhost_types.h b/include/standard-headers/linux/vhost_types.h
> >> > > index c41a73fe36..068d0e1ceb 100644
> >> > > --- a/include/standard-headers/linux/vhost_types.h
> >> > > +++ b/include/standard-headers/linux/vhost_types.h
> >> > > @@ -164,4 +164,7 @@ struct vhost_vdpa_iova_range {
> >> > >  /* Device can be suspended */
> >> > >  #define VHOST_BACKEND_F_SUSPEND  0x4
> >> > >
> >> > > +/* IOCTL requests can be batched */
> >> > > +#define VHOST_BACKEND_F_IOCTL_BATCH 0x6
> >> > > +
> >> > >  #endif
> >> > > diff --git a/linux-headers/linux/vhost.h b/linux-headers/linux/vhost.h
> >> > > index f9f115a7c7..4c9ddd0a0e 100644
> >> > > --- a/linux-headers/linux/vhost.h
> >> > > +++ b/linux-headers/linux/vhost.h
> >> > > @@ -180,4 +180,11 @@
> >> > >   */
> >> > >  #define VHOST_VDPA_SUSPEND             _IO(VHOST_VIRTIO, 0x7D)
> >> > >
> >> > > +/* Batch version of VHOST_VDPA_SET_VRING_ENABLE
> >> > > + *
> >> > > + * Enable/disable the ring while batching the commands.
> >> > > + */
> >> > > +#define VHOST_VDPA_SET_VRING_ENABLE_BATCH      _IOW(VHOST_VIRTIO, 0x7F, \
> >> > > +                                            struct vhost_vring_state)
> >> > > +
> >> >
> >> > These headers should be updated with update-linux-headers.sh. To be
> >> > done that way we need the changes merged in the kernel before.
> >> >
> >> > We can signal that the series is not ready for inclusion with the
> >> > subject [RFC. PATCH], like [1], and note it in the commit message.
> >> > That way, you can keep updating the header manually for demonstration
> >> > purposes.
> >> >
> >> > Thanks!
> >> >
> >> > [1] https://lore.kernel.org/qemu-devel/20220413163206.1958254-23-eperezma@redhat.com/
> >> >
> >>
> >>
> 
> 


