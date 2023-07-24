Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4794B75FC45
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 18:36:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNyXG-00040Q-E6; Mon, 24 Jul 2023 12:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qNyXD-0003zo-LU
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 12:35:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qNyXB-0002vK-VO
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 12:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690216544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O4ztEtIlM0DCTRoCMlMmxuf2AnLZC6LX/sivtl1k3Ac=;
 b=gZZIZyNelU6OM1dQS2qCrfo1oUHwFGLkQa4xY0C8N5e6lzWzRRHEjfh6l1240JHpwul8/D
 ockVSqfBZwWzyBBy2ssNxvng+05D0PnAgvino44UQbMBmsvK2BrBO8OOCyIJEQcgjrwi/f
 EP+WPnuFzYToL5vn9Vhyvvtl2AIYqlg=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-M3Kbx69SMVqJyrbBLtZoxA-1; Mon, 24 Jul 2023 12:35:43 -0400
X-MC-Unique: M3Kbx69SMVqJyrbBLtZoxA-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-cfc77042aeaso4924407276.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 09:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690216543; x=1690821343;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O4ztEtIlM0DCTRoCMlMmxuf2AnLZC6LX/sivtl1k3Ac=;
 b=PwPeiR+3vh5V4xhAYjztxznE8Z6lHZiOyGMvEInUCc6E45pRHrgVqaYuR/WZ1XGIja
 dP8jBvMqVh4wDbguXlgKTTbYDuzlGIXtzAx80Z+s7hORbC8G3pgtcK+DLnrpnV7MA+6/
 t4HYKEdxSKzr6YpuUPhZMgmT4p0BuIuemD+VHoEeV4IAWCZy8k+0H0y/3o3c5lWqt5q8
 pUiazonuBu9hJbiakmMo/RV8AEHhMn3yfpblV93GjePNvEInMkELZIz9g1lBb3Gfemm3
 JSFPFHpd9kRUxsPCK6WFuPmUUgSe6Vvb4Ue4B2YIFFCu1dyYpfSy7V8JcS5xWzsp6Ehj
 GyVg==
X-Gm-Message-State: ABy/qLZ/ZibAVVPB60qvJLIO+aTPzfxwVeyZlJ6uI09eo2JU2LZy6q/I
 DO+nn1J9fmBI6JxcTG3+5y4H+SSdVnPhJbawfgzcJ/C8KOzH3mlh+fnFojEgmWnb83Ew567sRe4
 nWaCY4NC08SIZIOmx9UkP/nZYEeDbppc=
X-Received: by 2002:a25:ac49:0:b0:d12:d6e4:a08b with SMTP id
 r9-20020a25ac49000000b00d12d6e4a08bmr1988520ybd.22.1690216542759; 
 Mon, 24 Jul 2023 09:35:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF71MBIK143Iv8ljURCQmYQdjfgZTEW0TsHcczf/Lzkr1CSvwX9Pnc+93TXFT/fX3olyBS32p4xyVsJsUcy59M=
X-Received: by 2002:a25:ac49:0:b0:d12:d6e4:a08b with SMTP id
 r9-20020a25ac49000000b00d12d6e4a08bmr1988492ybd.22.1690216542216; Mon, 24 Jul
 2023 09:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230720181459.607008-1-eperezma@redhat.com>
 <20230720181459.607008-8-eperezma@redhat.com>
 <34ff94cc-82fb-831c-b07a-f7068a8a8297@oracle.com>
In-Reply-To: <34ff94cc-82fb-831c-b07a-f7068a8a8297@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 24 Jul 2023 18:35:06 +0200
Message-ID: <CAJaqyWdLTnhRZA1UAVuOXj+EoMQQKNoH7vMH3-YmBgGnMu=-cg@mail.gmail.com>
Subject: Re: [RFC PATCH 07/12] vdpa: add vhost_vdpa_reset_queue
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: qemu-devel@nongnu.org, yvugenfi@redhat.com, 
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Shannon Nelson <snelson@pensando.io>
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

On Fri, Jul 21, 2023 at 11:57=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com>=
 wrote:
>
>
>
> On 7/20/2023 11:14 AM, Eugenio P=C3=A9rez wrote:
> > Split out vq reset operation in its own function, as it may be called
> > with ring reset.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >   hw/virtio/vhost-vdpa.c | 16 ++++++++++++++++
> >   1 file changed, 16 insertions(+)
> >
> > diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> > index 6ae276ccde..df2515a247 100644
> > --- a/hw/virtio/vhost-vdpa.c
> > +++ b/hw/virtio/vhost-vdpa.c
> > @@ -547,6 +547,21 @@ int vhost_vdpa_set_vring_ready(struct vhost_vdpa *=
v, unsigned idx)
> >       return vhost_vdpa_set_vring_ready_internal(v, idx, true);
> >   }
> >
> > +/* TODO: Properly reorder static functions */
> > +static void vhost_vdpa_svq_stop(struct vhost_dev *dev, unsigned idx);
> > +static void vhost_vdpa_reset_queue(struct vhost_dev *dev, int idx)
> > +{
> > +    struct vhost_vdpa *v =3D dev->opaque;
> > +
> > +    if (dev->features & VIRTIO_F_RING_RESET) {
> > +        vhost_vdpa_set_vring_ready_internal(v, idx, false);
> I'm not sure I understand this patch - this is NOT the spec defined way
> to initiate RING_RESET? Quoting the spec diff from the original
> RING_RESET tex doc:
>
> +The device MUST reset the queue when 1 is written to \field{queue_reset}=
, and
> +present a 1 in \field{queue_reset} after the queue has been reset, until=
 the
> +driver re-enables the queue via \field{queue_enable} or the device is re=
set.
> +The device MUST present consistent default values after queue reset.
> +(see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtque=
ue Reset}).
>
> Or you intend to rewrite it to be spec conforming later on?
>

Sorry for the late notice, but yes, the plan would be either to
rewrite this piece of code or to make vDPA uAPI work that way
(unlikely). I didn't create a new ioctl for that.

Please see https://lists.nongnu.org/archive/html/qemu-devel/2023-07/msg0414=
4.html

Thanks!

> -Siwei
> > +    }
> > +
> > +    if (v->shadow_vqs_enabled) {
> > +        vhost_vdpa_svq_stop(dev, idx - dev->vq_index);
> > +    }
> > +}
> > +
> >   /*
> >    * The use of this function is for requests that only need to be
> >    * applied once. Typically such request occurs at the beginning
> > @@ -1543,4 +1558,5 @@ const VhostOps vdpa_ops =3D {
> >           .vhost_force_iommu =3D vhost_vdpa_force_iommu,
> >           .vhost_set_config_call =3D vhost_vdpa_set_config_call,
> >           .vhost_reset_status =3D vhost_vdpa_reset_status,
> > +        .vhost_reset_queue =3D vhost_vdpa_reset_queue,
> >   };
>


