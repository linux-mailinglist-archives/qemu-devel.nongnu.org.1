Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE7E725764
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 10:21:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6oP9-0005Ph-SH; Wed, 07 Jun 2023 04:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1q6oP7-0005Km-0W
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 04:20:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1q6oP5-0001Bh-Ib
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 04:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686126026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3hDbxti1mzmH5hnVdCg+LRg206jjs+QYKo9QmIio7K8=;
 b=RFRWelDabRcABiY1T8kaM6pwTDbhO/IfLSsYz+aGEuhPEfbhL+97ZSqeq7odOvATrEl6HO
 117i15cX/yY1/JjF/1t4QKrJwCjNL/MnyCvCwbPV0QwtMsP8P/O5wb7lfLXKMKKNZc6AiS
 FU2BSCmXy2dTYvImUy+Ym0faEvmYZqg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-A7OqV7ZoNpSehrDcOXnvWg-1; Wed, 07 Jun 2023 04:20:25 -0400
X-MC-Unique: A7OqV7ZoNpSehrDcOXnvWg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5153b118ea0so612927a12.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 01:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686126024; x=1688718024;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3hDbxti1mzmH5hnVdCg+LRg206jjs+QYKo9QmIio7K8=;
 b=HRITjE5/jMdIqFykH/sRqfv6p6U81NoALPKPWSg9jdbknMlTVibCtyALup8oiTtlu1
 LevoO3UsSpNKko/SvZEscrCT0x5jXirIORhMlzZBFHt3OG1LUcOiAUd/tbcyZ3ak831e
 4VNFUgwg2qIDaef831hjSqUmVu43ILgBTSEAxlhZXjamABMaE0V61p24nn6+0lsRnyhC
 MCDAFzHcu+yILaR6jSugh8xf1okpldbbola/0Z0bceCjErTdzo/jUiytIC74wSXXKudN
 rtroDu0F5upE671pxpR6j9hM2bRq1Fc3W1YSc9+IzVX+uy6QMn+1By75qjAWeGfaew57
 q0BQ==
X-Gm-Message-State: AC+VfDxFSDtdCtVtC+dA5aO2SnmI2bDdfqLpv/VGKRBcdRyRbKfpzMLy
 AwhqFyMwJEsGsvomGpO7Lnb3JoHzaXDvcqDpVmmy9Y7OXwEDsqZn2O4d+bT0KpG6Z1d+Huw8yeg
 pZrXpJ4eGBlvnbGEFeY8ZFM4mQvUPvZ8=
X-Received: by 2002:a05:6402:31e4:b0:50d:975f:3729 with SMTP id
 dy4-20020a05640231e400b0050d975f3729mr4629424edb.11.1686126023992; 
 Wed, 07 Jun 2023 01:20:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ66UIkC3JwShANg7Ets78fr8L7xD7rarshKfaA2XCSLlP4kNIkkT+Zg5UVGfxoJivALYDRnx58etHfAb2zfNIw=
X-Received: by 2002:a05:6402:31e4:b0:50d:975f:3729 with SMTP id
 dy4-20020a05640231e400b0050d975f3729mr4629419edb.11.1686126023862; Wed, 07
 Jun 2023 01:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230602173328.1917385-1-eperezma@redhat.com>
 <CACGkMEufxwhQQHQYW+3ZA+4fbYhAsPOGbcrPkzB8tVGCGXf1Fw@mail.gmail.com>
In-Reply-To: <CACGkMEufxwhQQHQYW+3ZA+4fbYhAsPOGbcrPkzB8tVGCGXf1Fw@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 7 Jun 2023 16:19:47 +0800
Message-ID: <CAPpAL=x9HSHDFwdTWyEYhvYua3TAYjBfFA4LPddMZpWUogk4Bw@mail.gmail.com>
Subject: Re: [PATCH] vdpa: mask _F_CTRL_GUEST_OFFLOADS for vhost vdpa devices
To: Jason Wang <jasowang@redhat.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Cindy Lu <lulu@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Hawkins Jiawei <yin31149@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

QE tested sanity testing for this patch on the vhost_vdpa device,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Tue, Jun 6, 2023 at 9:33=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Sat, Jun 3, 2023 at 1:33=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
> >
> > QEMU does not emulate it so it must be disabled as long as the backend
> > does not support it.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> Thanks
>
> > ---
> >  net/vhost-vdpa.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > index 5360924ba0..427a57dd6f 100644
> > --- a/net/vhost-vdpa.c
> > +++ b/net/vhost-vdpa.c
> > @@ -54,6 +54,7 @@ const int vdpa_feature_bits[] =3D {
> >      VIRTIO_F_VERSION_1,
> >      VIRTIO_NET_F_CSUM,
> >      VIRTIO_NET_F_GUEST_CSUM,
> > +    VIRTIO_NET_F_CTRL_GUEST_OFFLOADS,
> >      VIRTIO_NET_F_GSO,
> >      VIRTIO_NET_F_GUEST_TSO4,
> >      VIRTIO_NET_F_GUEST_TSO6,
> > --
> > 2.31.1
> >
>


