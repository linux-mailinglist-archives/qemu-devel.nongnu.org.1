Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E57380C797
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 12:04:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCe3S-0001iy-7c; Mon, 11 Dec 2023 06:02:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rCe3Q-0001io-QH
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 06:02:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rCe3O-0007Wz-R1
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 06:02:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702292545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yoig53HaG3nlw8NZtKDviIVm490+RRQ50TrPgSY7Yx0=;
 b=d90as/ED5n9u8xXuGv8YsLUKlhrNoj3sl0J6QLx4w3CygpGxKHzMzVp8z8PoGerUSK/J8u
 g/J4PLGMY1Ptzylju9IAtYEA8tdJGapmSxPF4NEtM3I/hQGab1KHNyGSHcaMQajaZM7cQ0
 64cqSr+Efp6NHfezc+WDuyrY58rIEhY=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-sRuisr6iOPe0veWC_lhKkA-1; Mon, 11 Dec 2023 06:02:24 -0500
X-MC-Unique: sRuisr6iOPe0veWC_lhKkA-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-5df5d595287so10553427b3.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 03:02:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702292543; x=1702897343;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yoig53HaG3nlw8NZtKDviIVm490+RRQ50TrPgSY7Yx0=;
 b=aiFZOF3vq8pS3f8QaD7GKre+vNZrj/VPAkks2qVx1NuGosddY7fEj00lI4TQyOLnIH
 46L6MLcIQGU1np9vi6WGi7pdoKylK0RZP63EPEfoyvugd96KTT8QybcTUKsfyQbdxR3F
 ktsavz4hqjARFVWqhLv/GUhSKogwsnJfLq5JhaFil7bfzg9ZAnAM4+2VELWRK6apkkso
 99GPuqN3lxoF7kljG0Xje9WPkxYPt/OcZBet3bkJ2U5DuqGC1xMVru+M268Y9Whrs0Sg
 fxoC+vS32OJSRLIbgcw1jxW2ZoWPkS1QsoV5edgsfz0sWke5xw7m7EMpFb98gyECrejX
 UpWQ==
X-Gm-Message-State: AOJu0YxJbggHyNOVv3puRpxar7R77EUhQrhc58wAoODDUPvvOxNwtzZF
 Ox0nAsHgU4fL7sWULpnrk6+yjQpnuEz7RB9SB0xceHmlaRzURU/sK8Vl+UpWc3iH0sHNOMwhjWp
 2KKkQIyt09ySkL7MlzgRBKdWBG+s6o5M=
X-Received: by 2002:a05:690c:3246:b0:5e1:7599:5910 with SMTP id
 fg6-20020a05690c324600b005e175995910mr21121ywb.44.1702292543456; 
 Mon, 11 Dec 2023 03:02:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbgwJcVRUH7jSCCpKDO2iiGhh84t5yQOacXBJT8dmdAWDI/VEaWdvxKLpuU7ZP8ZrXSN2TxIcQX5blUGC7ie8=
X-Received: by 2002:a05:690c:3246:b0:5e1:7599:5910 with SMTP id
 fg6-20020a05690c324600b005e175995910mr21108ywb.44.1702292543190; Mon, 11 Dec
 2023 03:02:23 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-6-git-send-email-si-wei.liu@oracle.com>
 <CAJaqyWfNuq6B9P=buRpsYQC=ALO8Dw+_SYLmPfTLNp=aNnLUDg@mail.gmail.com>
In-Reply-To: <CAJaqyWfNuq6B9P=buRpsYQC=ALO8Dw+_SYLmPfTLNp=aNnLUDg@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 11 Dec 2023 12:01:47 +0100
Message-ID: <CAJaqyWc-XreUqvf-XLhf4eMLrq2naP-MDOV6fqMLVKwFpsiVqw@mail.gmail.com>
Subject: Re: [PATCH 05/40] vdpa: populate desc_group from net_vhost_vdpa_init
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: jasowang@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Dec 11, 2023 at 11:46=E2=80=AFAM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Thu, Dec 7, 2023 at 7:50=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com>=
 wrote:
> >
> > Add the desc_group field to struct vhost_vdpa, and get it
> > populated when the corresponding vq is initialized at
> > net_vhost_vdpa_init. If the vq does not have descriptor
> > group capability, or it doesn't have a dedicated ASID
> > group to host descriptors other than the data buffers,
> > desc_group will be set to a negative value -1.
> >
>
> We should use a defined constant. As always, I don't have a good name
> though :). DESC_GROUP_SAME_AS_BUFFERS_GROUP?
>
> > Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> > ---
> >  include/hw/virtio/vhost-vdpa.h |  1 +
> >  net/vhost-vdpa.c               | 15 +++++++++++++--
> >  2 files changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-v=
dpa.h
> > index 6533ad2..63493ff 100644
> > --- a/include/hw/virtio/vhost-vdpa.h
> > +++ b/include/hw/virtio/vhost-vdpa.h
> > @@ -87,6 +87,7 @@ typedef struct vhost_vdpa {
> >      Error *migration_blocker;
> >      VhostVDPAHostNotifier notifier[VIRTIO_QUEUE_MAX];
> >      IOMMUNotifier n;
> > +    int64_t desc_group;
> >  } VhostVDPA;
> >
> >  int vhost_vdpa_get_iova_range(int fd, struct vhost_vdpa_iova_range *io=
va_range);
> > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > index cb5705d..1a738b2 100644
> > --- a/net/vhost-vdpa.c
> > +++ b/net/vhost-vdpa.c
> > @@ -1855,11 +1855,22 @@ static NetClientState *net_vhost_vdpa_init(NetC=
lientState *peer,
> >
> >      ret =3D vhost_vdpa_add(nc, (void *)&s->vhost_vdpa, queue_pair_inde=
x, nvqs);
> >      if (ret) {
> > -        qemu_del_net_client(nc);
> > -        return NULL;
> > +        goto err;
> >      }
> >
> > +    if (is_datapath) {
> > +        ret =3D vhost_vdpa_probe_desc_group(vdpa_device_fd, features,
> > +                                          0, &desc_group, errp);

Also, it is always checking for the vring group of the first virtqueue
of the vdpa parent device, isn't it? The 3rd parameter should be
queue_pair_index*2.

Even with queue_pair_index*2., we're also assuming tx queue will have
the same vring group as rx. While I think this is a valid assumption,
maybe it is better to probe it at initialization and act as if the
device does not have VHOST_BACKEND_F_DESC_ASID if we find otherwise?

Thanks!


> > +        if (unlikely(ret < 0)) {
> > +            goto err;
> > +        }
> > +    }
> > +    s->vhost_vdpa.desc_group =3D desc_group;
>
> Why not do the probe at the same time as the CVQ isolation probe? It
> would save all the effort to restore the previous device status, not
> to mention not needed to initialize and reset the device so many times
> for the probing. The error unwinding is not needed here that way.
>
> I think the most controversial part is how to know the right vring
> group. When I sent the CVQ probe, I delegated that to the device
> startup and we decide it would be weird to have CVQ isolated only in
> the MQ case but not in the SQ case. I think we could do the same here
> for the sake of making the series simpler: just checking the actual
> isolation of vring descriptor group, and then move to save the actual
> vring group at initialization if it saves significant time.
>
> Does it make sense to you?
>
> Thanks!
>
> >      return nc;
> > +
> > +err:
> > +    qemu_del_net_client(nc);
> > +    return NULL;
> >  }
> >
> >  static int vhost_vdpa_get_features(int fd, uint64_t *features, Error *=
*errp)
> > --
> > 1.8.3.1
> >


