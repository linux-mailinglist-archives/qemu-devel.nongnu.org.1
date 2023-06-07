Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE02725753
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 10:20:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6oOC-0004lY-AF; Wed, 07 Jun 2023 04:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1q6oOA-0004lL-PB
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 04:19:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1q6oO9-0000q0-Ds
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 04:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686125968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Wz2Z6cDM54d4Hu9OH10KMdZT9KWpF/CsRgm/NXaiq8=;
 b=YdX66HezDnSzDm32/RvIn1/LDfhzXaRZr7coR+Z2Bd7kAt2JP9pIF+tPGTI40A5kMb6n+y
 UMViTPHIWLu5Xfb5MoQLnBP8ROZtEE1TbsXpYD4JH+jMBRTHGiJsFrW0vBbB43JH/Z1sBZ
 csEAadkxfVnSCsqCzaoJdkRZQaBmRJM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-xhjMkIyzMHKsO4wTtavp4w-1; Wed, 07 Jun 2023 04:19:27 -0400
X-MC-Unique: xhjMkIyzMHKsO4wTtavp4w-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-514b8d2b21fso601301a12.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 01:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686125966; x=1688717966;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Wz2Z6cDM54d4Hu9OH10KMdZT9KWpF/CsRgm/NXaiq8=;
 b=D+YZsQ8xqUinvIcOm+1MQii1MXK4WO6hB9GZfamE3mF/bWqPw3h9dfciuM0DVz32n+
 Ft59ntcUSvWS4iYqNQqr/JfXSm8cbE9gZ/7ElXi9tq3y2TthMnFEKYEnU9ISFkbLs9il
 XBqt5jLQoeYHbSvL/yjWTMItucVM6TuzWezHHV6hTgdghd7d6oiB9+xDNWPE2J2drDEw
 7HtAY0m4rz9oW7p0bVU3lfIoS0lI5Q4TB8qVuq9P4DcQwEgvlMr3JnS8A/Z/FEsxK1Ok
 F7wRkZAyNmlbhnq/FVGPjEkV49PmHA8RhJcFOOxA+l+U7BZ87iwJ6KNnWluiw11O746X
 7nWw==
X-Gm-Message-State: AC+VfDyPxgi8XljX5hiQqtzG46j3hJXe4Jk9i0DLg0TjBO7SBjjbhQTA
 YNoLrE8PJeO0k4Fah1Igi0tDi5fX31Yu0RiSp9bF/vRmmJssyahQcVJpkpFJd26vB9mNtatZDa1
 mHx0oluJD+sA7cbOQUKcGy8B0h8jdLRs=
X-Received: by 2002:aa7:da42:0:b0:514:a484:e85d with SMTP id
 w2-20020aa7da42000000b00514a484e85dmr4412741eds.1.1686125966230; 
 Wed, 07 Jun 2023 01:19:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7NTnknxwVlaT8sT/klJgUYd25DIj3w2Q4unuNTKwThLkgC6yhdP0Kp2ZK20sJ3BrQMJfaFsbnbzpb63OiEcgI=
X-Received: by 2002:aa7:da42:0:b0:514:a484:e85d with SMTP id
 w2-20020aa7da42000000b00514a484e85dmr4412733eds.1.1686125966004; Wed, 07 Jun
 2023 01:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230602173451.1917999-1-eperezma@redhat.com>
 <CACGkMEsgnMjYYxyXy3ERet=oXyYD4Z8ULL4w+hK4yhUJTRYWsw@mail.gmail.com>
In-Reply-To: <CACGkMEsgnMjYYxyXy3ERet=oXyYD4Z8ULL4w+hK4yhUJTRYWsw@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 7 Jun 2023 16:18:49 +0800
Message-ID: <CAPpAL=w3iVFyEeA2zkqMuvYVVOAaV_Cnq7LY4W+W484x1KuMjQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa: fix not using CVQ buffer in case of error
To: Jason Wang <jasowang@redhat.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 qemu-devel@nongnu.org, Cindy Lu <lulu@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Hawkins Jiawei <yin31149@gmail.com>
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


On Tue, Jun 6, 2023 at 9:32=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Sat, Jun 3, 2023 at 1:35=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
> >
> > Bug introducing when refactoring.  Otherway, the guest never received
> > the used buffer.
> >
> > Fixes: be4278b65fc1 ("vdpa: extract vhost_vdpa_net_cvq_add from vhost_v=
dpa_net_handle_ctrl_avail")
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> Thanks
>
> > ---
> >  net/vhost-vdpa.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > index 16d47f7b3c..5360924ba0 100644
> > --- a/net/vhost-vdpa.c
> > +++ b/net/vhost-vdpa.c
> > @@ -807,7 +807,7 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostSh=
adowVirtqueue *svq,
> >      }
> >
> >      if (*s->status !=3D VIRTIO_NET_OK) {
> > -        return VIRTIO_NET_ERR;
> > +        goto out;
> >      }
> >
> >      status =3D VIRTIO_NET_ERR;
> > --
> > 2.31.1
> >
>


