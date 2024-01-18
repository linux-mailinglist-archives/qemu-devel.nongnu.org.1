Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D85D831320
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 08:32:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQMs7-0006r5-Nf; Thu, 18 Jan 2024 02:31:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQMrf-0006mn-EJ
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 02:31:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQMrb-0003jt-MZ
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 02:31:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705563054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jw16IUnoGb64FbzU445mUg8Y6sxTXy2JSukP3FXcGbc=;
 b=C17J3VNhaCodNQKcgPR6kkDzgEdqwU/gnomYgq98X+wP13k5+j73d9bhwTx1LJY6ujX5CP
 O1aw+STbvBW1iLUxqumb67Rp1qRuDY145lY82GyPYgjHjCXwvW2tLSqOWf6d027M5cgTGP
 DaD3YRtw+wZqdEE4bjV8lSJKQ9C/gIo=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-2cstEanpOfOORgc2XeLDzA-1; Thu, 18 Jan 2024 02:30:50 -0500
X-MC-Unique: 2cstEanpOfOORgc2XeLDzA-1
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-468141d0ad0so1319481137.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 23:30:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705563050; x=1706167850;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jw16IUnoGb64FbzU445mUg8Y6sxTXy2JSukP3FXcGbc=;
 b=tiUNlqf9LJnvMz+4gtaZKrxzDP3sAOA2JDlnDoAO8BP3sOrd5nCs5iZ/rqR0BuVWCG
 793UdEuOCdKf1tBzXlT0yaG6PP4AIOYFk7lloBt/TFueLF/4GuPDs5YC+ydFSKMGcBjP
 u0T6XhM4w3DuYYSDcDTiOAnd/SnKxSUvfSqUegE7cSvyWMxfErw7+DBzAwVRx786yu6o
 BobFhSDob1r0dc9PhAsiHNMm8DQTL9zsKFXCPgrUZoyD0byTnnvLHLl6ZkvjHi9nliH3
 RhTQKMHxzmxf4T6J4pXvNhHZ19B1GVJhQRshFgTcDvZ+Lag8MAJ9aXjp2qSZRkO4FcFB
 gtMQ==
X-Gm-Message-State: AOJu0Yzg7+MItfoseT/EGuvVt4hiXuvSAoT9xorWwQFup79ra9lw4BWW
 sDuHB7+Xn5ImLKXa2epPQCri8oIlLVmdo47NPYBJD1Nz2H1UlwZwYpbTeVkOq+pAWxsoNh0oB8y
 us+NNrULAOrlJSBsBtiOc/cCgrMd5vru+kIS+CDvy2QbniFaS5gNzdd/t3KYPfXZjmlx2lbaIAu
 x7yFAa0fSpFT94ux04ifbZj4V8YSM=
X-Received: by 2002:a05:6102:a8c:b0:468:1e27:5db0 with SMTP id
 n12-20020a0561020a8c00b004681e275db0mr406142vsg.21.1705563049813; 
 Wed, 17 Jan 2024 23:30:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfZvxICqlEIcyDfulCuhGYMtxhwf9czxI6CQ8XZQDk7VknxXfE1tvBBRaOhedOHRTXadJso0CXOdkeR5a8m1I=
X-Received: by 2002:a05:6102:a8c:b0:468:1e27:5db0 with SMTP id
 n12-20020a0561020a8c00b004681e275db0mr406139vsg.21.1705563049578; Wed, 17 Jan
 2024 23:30:49 -0800 (PST)
MIME-Version: 1.0
References: <20240117160344.175872-1-pbonzini@redhat.com>
 <ZaiyfDX2-hUUynhp@x1n>
In-Reply-To: <ZaiyfDX2-hUUynhp@x1n>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Jan 2024 08:30:38 +0100
Message-ID: <CABgObfZF4S6f4VuKozgx_nrEVhg7s9N1rBZs46MnNcwHfVuupA@mail.gmail.com>
Subject: Re: [PATCH] vfio: use matching sizeof type
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000b666fe060f33573d"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000b666fe060f33573d
Content-Type: text/plain; charset="UTF-8"

Il gio 18 gen 2024, 06:09 Peter Xu <peterx@redhat.com> ha scritto:

> On Wed, Jan 17, 2024 at 05:03:44PM +0100, Paolo Bonzini wrote:
> > Do not use uint64_t for the type of the declaration and __u64 when
> > computing the number of elements in the array.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  hw/vfio/common.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > index 0b3352f2a9d..0da4003ecf5 100644
> > --- a/hw/vfio/common.c
> > +++ b/hw/vfio/common.c
> > @@ -1118,7 +1118,7 @@ static int
> vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
> >  {
> >      uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature) +
> >                          sizeof(struct
> vfio_device_feature_dma_logging_report),
> > -                        sizeof(__u64))] = {};
> > +                        sizeof(uint64_t))] = {};
> >      struct vfio_device_feature *feature = (struct vfio_device_feature
> *)buf;
> >      struct vfio_device_feature_dma_logging_report *report =
> >          (struct vfio_device_feature_dma_logging_report *)feature->data;
>
> There seem to have other places in the sme file that reference __u64.  Are
> we going to remove all __u64 references?  Or maybe something else?
>

I wanted to remove those that are unnecessary, but in some cases you have
to keep __u64, because you don't know that __u64 and uint64_t are the same
type (so e.g. they could have incompatible pointer types and printf
specifiers).

Paolo


> Copy Alex/Cedric to make sure this won't get lost..
>
> Thanks,
>
> --
> Peter Xu
>
>

--000000000000b666fe060f33573d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il gio 18 gen 2024, 06:09 Peter Xu &lt;<a href=3D"mail=
to:peterx@redhat.com">peterx@redhat.com</a>&gt; ha scritto:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">On Wed, Jan 17, 2024 at 05:03:44PM +0100, Paolo Bo=
nzini wrote:<br>
&gt; Do not use uint64_t for the type of the declaration and __u64 when<br>
&gt; computing the number of elements in the array.<br>
&gt; <br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/vfio/common.c | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/hw/vfio/common.c b/hw/vfio/common.c<br>
&gt; index 0b3352f2a9d..0da4003ecf5 100644<br>
&gt; --- a/hw/vfio/common.c<br>
&gt; +++ b/hw/vfio/common.c<br>
&gt; @@ -1118,7 +1118,7 @@ static int vfio_device_dma_logging_report(VFIODe=
vice *vbasedev, hwaddr iova,<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_devic=
e_feature) +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 sizeof(struct vfio_device_feature_dma_logging_report),=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 sizeof(__u64))] =3D {};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 sizeof(uint64_t))] =3D {};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 struct vfio_device_feature *feature =3D (struct vf=
io_device_feature *)buf;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 struct vfio_device_feature_dma_logging_report *rep=
ort =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (struct vfio_device_feature_dma_logg=
ing_report *)feature-&gt;data;<br>
<br>
There seem to have other places in the sme file that reference __u64.=C2=A0=
 Are<br>
we going to remove all __u64 references?=C2=A0 Or maybe something else?<br>=
</blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">I wa=
nted to remove those that are unnecessary, but in some cases you have to ke=
ep __u64, because you don&#39;t know that __u64 and uint64_t are the same t=
ype (so e.g. they could have incompatible pointer types and printf specifie=
rs).</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
<br>
Copy Alex/Cedric to make sure this won&#39;t get lost..<br>
<br>
Thanks,<br>
<br>
-- <br>
Peter Xu<br>
<br>
</blockquote></div></div></div>

--000000000000b666fe060f33573d--


