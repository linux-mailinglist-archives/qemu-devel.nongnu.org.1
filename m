Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F16765544
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 15:42:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP0V8-0007Qo-KV; Thu, 27 Jul 2023 08:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qP0V2-0007QM-TB
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 08:53:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qP0V0-00012g-MF
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 08:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690462425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EHZ7RYbvJDoOftWLGoIxm3vBkSe0CYlebODAwjxwL7w=;
 b=D0WArtH+CM8M+Hkta9VbMIOv7FJTodKEewGju2oMBEl0L74mIYzPyZ34HFIVUJSj3jDYX/
 m7MdCpOU+9jdmwo7ufm2sol7cguC36o+JLwV4yJeOL/SRMVMgPddN237Jc0IIBXr7oeWNv
 ybOiCHdi4cSDmK4/XFCzv4jXK41Y5SU=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-ECOHDrAjMYitDzM7qkjFpg-1; Thu, 27 Jul 2023 08:53:44 -0400
X-MC-Unique: ECOHDrAjMYitDzM7qkjFpg-1
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-4475cacfffeso226210137.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 05:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690462423; x=1691067223;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EHZ7RYbvJDoOftWLGoIxm3vBkSe0CYlebODAwjxwL7w=;
 b=HJqvZ3/Yua0L1FHMhKXJi+FXnN2YNH3Bc4Buhr3uVfcap+DI7ZxQSBff9QcAiO6so9
 T+c/rJZ0wQZDMyqafJue3l7dbd2D70PsyFx3tlsB2kSrETuD70UCPu2PkAE+SZmDgPkJ
 GwKJZS0pENPuF8k9kl1glzNNbplBWWx8UTxe2vZYe5iNihMiyUOAv2JfCgqV2cZ/LFKv
 mF92wQWAh0NzQOICViK80BxDXmnnFigczz8MwPaAovywddoz6LeUNZCBJz28tURBbSVd
 4I80A9WyySvJee8nSPX3ut6pgKCCIT+Hh9Ze+Y0P1hT7FDtpdwcJiz+mBX7stGfG12Iq
 N++g==
X-Gm-Message-State: ABy/qLYuhKHA3fjS2a1Gk4RE1p+rIC0Ydc4MNyKtAZviLe7LMLeSacSd
 6BL4WbetPPLrQVW+vVwNvlUFCoOkW2rs9kn3ctyTgBQV7/+F7GmN9O5YvNfcdIA2N9MtvUWALDv
 MPJx9ZS92aBRxbq2Y4/qFxrATWu1D6EM=
X-Received: by 2002:a05:6102:a28:b0:443:9037:d8e4 with SMTP id
 8-20020a0561020a2800b004439037d8e4mr1167383vsb.8.1690462423502; 
 Thu, 27 Jul 2023 05:53:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH9ncEPhFK3MRczkTisHVSmiIPlpyhgkzUHWFA8RFxXh78KjWzBfu0oi52uTyXIQt6lEXJGwEcGLP2BchzaHnw=
X-Received: by 2002:a05:6102:a28:b0:443:9037:d8e4 with SMTP id
 8-20020a0561020a2800b004439037d8e4mr1167368vsb.8.1690462423186; Thu, 27 Jul
 2023 05:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230720181459.607008-1-eperezma@redhat.com>
 <CAJaqyWdkyX9Ha-kd+haqEpfXfpVhSLmRa5hkZZGkvZjrD4Ketg@mail.gmail.com>
 <18f8d9c7-fa1d-7e45-82cc-7bd742ec18fd@redhat.com>
In-Reply-To: <18f8d9c7-fa1d-7e45-82cc-7bd742ec18fd@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 27 Jul 2023 14:53:07 +0200
Message-ID: <CAJaqyWddSBUqp4mGpQdZDVhy8WCZ3iu9AWqH1KZOwZZ2zC53=A@mail.gmail.com>
Subject: Re: [RFC PATCH 00/12] Prefer to use SVQ to stall dataplane at NIC
 state restore through CVQ
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, yvugenfi@redhat.com, si-wei.liu@oracle.com, 
 "Michael S. Tsirkin" <mst@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
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

On Tue, Jul 25, 2023 at 9:15=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
>
> =E5=9C=A8 2023/7/21 14:48, Eugenio Perez Martin =E5=86=99=E9=81=93:
> > On Thu, Jul 20, 2023 at 8:15=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
> >> At this moment the migration of net features that depends on CVQ is no=
t
> >> possible, as there is no reliable way to restore the device state like=
 mac
> >> address, number of enabled queues, etc to the destination.  This is ma=
inly
> >> caused because the device must only read CVQ, and process all the comm=
ands
> >> before resuming the dataplane.
> >>
> >> This series uses the VirtIO feature _F_RING_RESET to achieve it, addin=
g an
> >> alternative method to late vq enabling proposed in [1][2].  It expose =
SVQ to
> >> the device until it process all the CVQ messages, and then replaces th=
e vring
> >> for the guest's one.
> >>
> > A couple of things I forgot to add:
> > * Assuming the implementation of _F_RING_RESET in vdpa is calling
> > kernel vdpa ops .set_vq_ready(vq, false). I'm not sure if this is the
> > best implementation, but it is currently unused in the kernel. At the
> > same time, .set_vq_ready(vq, true) also enables the vq again.
>
>
> I think we need another ops, as set_vq_ready() tends to be functional
> equivalent to queue_enable.
>
> If we reuse set_vq_ready(vq, false), we would get conflict in the future
> when driver is allowed to stop/resume a specific virtqueue via setting 0
> to queue_enable. And that's also the reason why queue_enable is not
> resued to reset a virtqueue.
>

Yes, I totally agree.

>
> >
> >> As an advantage, it uses a feature well deviced in the VirtIO standard=
.  As a
> >> disadvantage, current HW already support the late enabling and it does=
 not
> >> support RING_RESET.
> >>
> >> This patch must be applied on top of the series ("Enable vdpa net migr=
ation
> >> with features depending on CVQ") [1][2].
> >>
> >> The patch has been tested with vp_vdpa, but using high IOVA instead of=
 a
> >> sepparated ID for shadow CVQ and shadow temporal vrings.
> >>
> > And with _F_STATE implementation I sent long ago.
> >
> > Based on this, my suggestion is:
> > * Leave the late enable for vDPA devices.
> > * Make them fail if the vDPA parent device does not support it. This
> > can be considered as a fix.
> > * Leave _F_RING_RESET to be added on top, as the semantics are not
> > implemented in vDPA at the moment.
> >
> > Would that work?
>
>
> I think it can work, let's start from late enabling which seems
> lightweight than reset and see. We can leave the vp_vdpa to be done on
> top with another series.
>

great!

Thanks!


> Thanks
>
>
> >
> >> [1] Message-id: <20230706191227.835526-1-eperezma@redhat.com>
> >> [2] https://lists.nongnu.org/archive/html/qemu-devel/2023-07/msg01325.=
html
> >>
> >> Eugenio P=C3=A9rez (12):
> >>    vhost: add vhost_reset_queue_op
> >>    vhost: add vhost_restart_queue_op
> >>    vhost_net: Use ops->vhost_restart_queue in vhost_net_virtqueue_rest=
art
> >>    vhost_net: Use ops->vhost_reset_queue in vhost_net_virtqueue_reset
> >>    vdpa: add vhost_vdpa_set_vring_ready_internal
> >>    vdpa: add vhost_vdpa_svq_stop
> >>    vdpa: add vhost_vdpa_reset_queue
> >>    vdpa: add vhost_vdpa_svq_start
> >>    vdpa: add vhost_vdpa_restart_queue
> >>    vdpa: enable all vqs if the device support RING_RESET feature
> >>    vdpa: use SVQ to stall dataplane while NIC state is being restored
> >>    vhost: Allow _F_RING_RESET with shadow virtqueue
> >>
> >>   include/hw/virtio/vhost-backend.h  |   6 ++
> >>   hw/net/vhost_net.c                 |  16 ++--
> >>   hw/virtio/vhost-shadow-virtqueue.c |   1 +
> >>   hw/virtio/vhost-vdpa.c             | 139 +++++++++++++++++++++------=
--
> >>   net/vhost-vdpa.c                   |  55 ++++++++++--
> >>   hw/virtio/trace-events             |   2 +-
> >>   6 files changed, 171 insertions(+), 48 deletions(-)
> >>
> >> --
> >> 2.39.3
> >>
> >>
>


