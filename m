Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 395BA719E91
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 15:44:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ibI-00079Q-EA; Thu, 01 Jun 2023 09:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q4ibG-00079E-VX
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:44:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q4ibF-0007qg-IQ
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685627059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=09dG3ngs3N+0l1d4fZmd4NzcTnstX2opJKC3vhwp/BE=;
 b=A1x3nvBe/wZ6QET6BoX92D3O10mni93j4SRSLGWkEFyUgRduGZfgtNcb3Wewm3nHJciVQy
 7i6X4NJ9MisZwOy2UcM0TP7NchU7GIKIwTqv9H1lvDwMRmHOBbc0p7nDh3twOhC9TYZpk7
 e88EGPBUpGnbBUbn0lt4r+lq7/nzz3A=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-D1HtUAMPPs-9YtxvXX5NSA-1; Thu, 01 Jun 2023 09:44:16 -0400
X-MC-Unique: D1HtUAMPPs-9YtxvXX5NSA-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6b0ca3d311eso788917a34.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 06:44:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685627056; x=1688219056;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=09dG3ngs3N+0l1d4fZmd4NzcTnstX2opJKC3vhwp/BE=;
 b=ERM1Nt+Z0Tr8WUmxpHtM15fD0EWtwA2M4yFs2P2vxSA8zceDLafV2z6JmUyAv6SL53
 G80ZpU01p4iP9RRQbnyKDoQw6uoRSjWtukZRvQiKxQM5J6laVyEhYKKkCJgwqt7ox5mN
 Eeh406zjKzRvX6mhnYCvG+/Q/PQFi9pk2K9rP7gxMKNkfsQzvLfz3W9yKNfErI9QU+fq
 vlJs73LM8Go9Qs0UrhbeTcVhKtEUA6eC2KonVM6gE8ZaMIkXQ4VUtX6U89hmldiG5TaM
 bSr6KNy3CnOe3YpSfDjQ5NYZFAiObXyZytJfJ+ADN1OjOgEb0w4FDim4neJCPdnAAL52
 JyuQ==
X-Gm-Message-State: AC+VfDxV1ZdJ2yvtfp6RDCvDs2Q0tELqRjDiSsi6WVJ9P6ScllYFTsNL
 R/Nh5N2nTvG985PEf/SH7gKEqcRHWWhpuzst0cBqvd7DtiP83XHbxGWmE6KU4AZ8R1n2GP5h23T
 jVuER5AOouZTCYgxlR1YbHFG8IIZddAM=
X-Received: by 2002:a05:6830:cf:b0:6ad:e8ad:bb1e with SMTP id
 x15-20020a05683000cf00b006ade8adbb1emr4529915oto.21.1685627055979; 
 Thu, 01 Jun 2023 06:44:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Lu4Xf71SX7z85r46Z3M05cx5pXZPKYzU+E8YtTWJlDZDRyyu1gjEr/3poq1tdzxnJQE31Tzv7GH/4X6GOOPU=
X-Received: by 2002:a05:6830:cf:b0:6ad:e8ad:bb1e with SMTP id
 x15-20020a05683000cf00b006ade8adbb1emr4529903oto.21.1685627055752; Thu, 01
 Jun 2023 06:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685584543.git.yin31149@gmail.com>
 <39fddc462ad4c7619843a4cd7cba92e0bbc48c45.1685584543.git.yin31149@gmail.com>
 <CAKrof1OyEL5RGTWgHjgfMSkMC-afiWW8VAF5qirCy3juErWSqA@mail.gmail.com>
In-Reply-To: <CAKrof1OyEL5RGTWgHjgfMSkMC-afiWW8VAF5qirCy3juErWSqA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 1 Jun 2023 15:43:38 +0200
Message-ID: <CAJaqyWewHKZebftQc6HrhDQEV5cTWiJUkVL4NgzOVqoGdP+6Sw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] virtio-net: expose
 virtio_net_supported_guest_offloads()
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jun 1, 2023 at 11:05=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> On Thu, 1 Jun 2023 at 16:48, Hawkins Jiawei <yin31149@gmail.com> wrote:
> >
> > To support restoring offloads state in vdpa, need to expose
> > the function virtio_net_supported_guest_offloads(), then vdpa
> > uses this function to get the guest supported offloads.
>
> Here it should be changed to "then QEMU uses this function
> to get the guest supported offloads.". I will correct the commit
> message in the v3 patch.
>

Maybe "to get the device supported offloads allow qemu to know the
defaults, so it can skip the control message sending if they match
with the driver's configuration"?

We can also add "This will be the default at guest's startup, these
values can mismatch only at live migration".

What do you think?

Thanks!

> Thanks!
>
> >
> > Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> > ---
> >  hw/net/virtio-net.c            | 2 +-
> >  include/hw/virtio/virtio-net.h | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 7b27dad6c4..7e8897a8bc 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -874,7 +874,7 @@ static uint64_t virtio_net_guest_offloads_by_featur=
es(uint32_t features)
> >      return guest_offloads_mask & features;
> >  }
> >
> > -static inline uint64_t virtio_net_supported_guest_offloads(const VirtI=
ONet *n)
> > +uint64_t virtio_net_supported_guest_offloads(const VirtIONet *n)
> >  {
> >      VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> >      return virtio_net_guest_offloads_by_features(vdev->guest_features)=
;
> > diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-=
net.h
> > index ef234ffe7e..5f5dcb4572 100644
> > --- a/include/hw/virtio/virtio-net.h
> > +++ b/include/hw/virtio/virtio-net.h
> > @@ -227,5 +227,6 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *vde=
v,
> >                                    unsigned out_num);
> >  void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
> >                                     const char *type);
> > +uint64_t virtio_net_supported_guest_offloads(const VirtIONet *n);
> >
> >  #endif
> > --
> > 2.25.1
> >
>


