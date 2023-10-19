Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 042E67CEDDB
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 04:07:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtIQi-0007mJ-1M; Wed, 18 Oct 2023 22:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qtIQf-0007m3-Ip
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 22:06:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qtIQd-0007Ht-Oe
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 22:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697681186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=88UpEhOyhp62r1C9QObLDP+1Ziz1jyI7eG/6SVgSZ+c=;
 b=Vso24BkmmeeEYgZqI3bQIeIrmlpa9PJnseE4D3ZCknFKifZmbXO/wDUDMu1igSGMLS8SCf
 1Hb23Yj5Halbyno46XZlKYYq0NuRGOoD3yzeMr4oDZZFcLIvGL8cWCAPsWp+bCqqCuGBLE
 By8qUfoLcChO1k1QvaspV19C3Gbg0ck=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-GZ-V9LDjPUa1ncXLZu_Pxg-1; Wed, 18 Oct 2023 22:06:24 -0400
X-MC-Unique: GZ-V9LDjPUa1ncXLZu_Pxg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9b2cf504e3aso549107266b.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 19:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697681183; x=1698285983;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=88UpEhOyhp62r1C9QObLDP+1Ziz1jyI7eG/6SVgSZ+c=;
 b=mZ06OmPBgIsLdtXafY+fX+GI7MhstAM0g92uqNg468aMAr76yTf3DNZIwlmK152Zie
 nYwk0I6IgT0JBfBQW2bcnB4FvmrL4sUUHsaJAPczC6jHIj//o+CPykAoU6EVWnPIYei+
 jeLzpbMc9J/iajTRT7Wu1v9owA9jwcWLf8KEY1MmDNXTvkFTKkUNZBb/ypAKyKvkcJlv
 qD96UZuj3Gs+Byvrmf1Sh2UvOHTaS6oEG5RZWCE59cWaIXVxA1a0gChJ6bar5t2pTk/8
 LOYWV480fDhd1X7mr5GSGcZB0snrBILMTkOtCj7FyAhtwIrM7nMmCZLy9z47HPVVRnDi
 6voQ==
X-Gm-Message-State: AOJu0YxSuySZMzTqrTMBDAqRna1M1QDlFaeVP020kNatYerkK3zpP6mu
 AG8Iu8MHtn2pPgk4BTKZOOjywNXVXEaLd37RP6ymIxpmc5uCQWceWYJQITixKby0t3yj1aYtBK4
 t6c+L3lr73kOLBUWpRcYMwZHU/b3Nw1A=
X-Received: by 2002:a17:906:6a13:b0:9be:4bb0:64f with SMTP id
 qw19-20020a1709066a1300b009be4bb0064fmr610756ejc.54.1697681183176; 
 Wed, 18 Oct 2023 19:06:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG59Lrv0zwgWM4CIpv8zDFapzsu2pR6ZcnhiOB24LvoISJEBpSTQ89K6wmF6MWA7qY7Yr47WTTs/KBT9akEhRw=
X-Received: by 2002:a17:906:6a13:b0:9be:4bb0:64f with SMTP id
 qw19-20020a1709066a1300b009be4bb0064fmr610747ejc.54.1697681182901; Wed, 18
 Oct 2023 19:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230912120650.371781-1-anisinha@redhat.com>
 <20231018080451-mutt-send-email-mst@kernel.org>
 <CAK3XEhP-AHh0P12O8=Guia4nVPx1DZjXekYUgoDQ4RKcM4cAfQ@mail.gmail.com>
 <20231018134023-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231018134023-mutt-send-email-mst@kernel.org>
From: Ani Sinha <anisinha@redhat.com>
Date: Thu, 19 Oct 2023 07:36:10 +0530
Message-ID: <CAK3XEhMW=yhusc4JGRmW4hQxe2QAEJK_fyPnr3r1YHzfZsCYDQ@mail.gmail.com>
Subject: Re: [PATCH] cpu/cpuid: check CPUID_PAE to determine 36 bit processor
 address space
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <eduardo@habkost.net>
Content-Type: multipart/alternative; boundary="000000000000d956ac06080833ec"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000d956ac06080833ec
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Oct, 2023, 11:14 pm Michael S. Tsirkin, <mst@redhat.com> wrote:

> On Wed, Oct 18, 2023 at 11:08:11PM +0530, Ani Sinha wrote:
> >
> >
> > On Wed, 18 Oct, 2023, 5:35 pm Michael S. Tsirkin, <mst@redhat.com>
> wrote:
> >
> >     On Tue, Sep 12, 2023 at 05:36:50PM +0530, Ani Sinha wrote:
> >     > PAE mode in x86 supports 36 bit address space. Check the PAE CPUID
> on the
> >     > guest processor and set phys_bits to 36 if PAE feature is set.
> This is in
> >     > addition to checking the presence of PSE36 CPUID feature for
> setting 36
> >     bit
> >     > phys_bits.
> >     >
> >     > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> >
> >     Acked-by: Michael S. Tsirkin <mst@redhat.com>
> >
> >     who's applying this?
> >
> >
> > I thought it would be you? What did I miss?
>
> I just don't play a lot with CPUID flags and might easily miss things.
> Used to be Eduardo .. maybe CC him.
>

Eduardo can you pick this up?


> >
> >
> >     > ---
> >     >  target/i386/cpu.c | 2 +-
> >     >  1 file changed, 1 insertion(+), 1 deletion(-)
> >     >
> >     > Note: Not sure what tests I should be running in order to make
> sure I am
> >     > not breaking any guest OSes. Usual qtests pass.
> >     >
> >     > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> >     > index 24ee67b42d..f3a5c99117 100644
> >     > --- a/target/i386/cpu.c
> >     > +++ b/target/i386/cpu.c
> >     > @@ -7375,7 +7375,7 @@ static void x86_cpu_realizefn(DeviceState
> *dev,
> >     Error **errp)
> >     >              return;
> >     >          }
> >     >
> >     > -        if (env->features[FEAT_1_EDX] & CPUID_PSE36) {
> >     > +        if (env->features[FEAT_1_EDX] & (CPUID_PSE36 |
> CPUID_PAE)) {
> >     >              cpu->phys_bits = 36;
> >     >          } else {
> >     >              cpu->phys_bits = 32;
> >     > --
> >     > 2.39.1
> >
> >
>
>

--000000000000d956ac06080833ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, 18 Oct, 2023, 11:14 pm Michael S. Tsirkin, &lt=
;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">On Wed, Oct 18, 2023 at 11:08:11PM +0530, Ani=
 Sinha wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Wed, 18 Oct, 2023, 5:35 pm Michael S. Tsirkin, &lt;<a href=3D"mailt=
o:mst@redhat.com" target=3D"_blank" rel=3D"noreferrer">mst@redhat.com</a>&g=
t; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Tue, Sep 12, 2023 at 05:36:50PM +0530, Ani Sinha=
 wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; PAE mode in x86 supports 36 bit address space.=
 Check the PAE CPUID on the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; guest processor and set phys_bits to 36 if PAE=
 feature is set. This is in<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; addition to checking the presence of PSE36 CPU=
ID feature for setting 36<br>
&gt;=C2=A0 =C2=A0 =C2=A0bit<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; phys_bits.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Signed-off-by: Ani Sinha &lt;<a href=3D"mailto=
:anisinha@redhat.com" target=3D"_blank" rel=3D"noreferrer">anisinha@redhat.=
com</a>&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Acked-by: Michael S. Tsirkin &lt;<a href=3D"mailto:=
mst@redhat.com" target=3D"_blank" rel=3D"noreferrer">mst@redhat.com</a>&gt;=
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0who&#39;s applying this?<br>
&gt; <br>
&gt; <br>
&gt; I thought it would be you? What did I miss?<br>
<br>
I just don&#39;t play a lot with CPUID flags and might easily miss things.<=
br>
Used to be Eduardo .. maybe CC him.<br></blockquote></div></div><div dir=3D=
"auto"><br></div><div dir=3D"auto">Eduardo can you pick this up?</div><div =
dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">
<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 target/i386/cpu.c | 2 +-<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deleti=
on(-)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Note: Not sure what tests I should be running =
in order to make sure I am<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; not breaking any guest OSes. Usual qtests pass=
.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/target/i386/cpu.c b/target/i386/c=
pu.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; index 24ee67b42d..f3a5c99117 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- a/target/i386/cpu.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/target/i386/cpu.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -7375,7 +7375,7 @@ static void x86_cpu_real=
izefn(DeviceState *dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (env-&gt;featu=
res[FEAT_1_EDX] &amp; CPUID_PSE36) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (env-&gt;featu=
res[FEAT_1_EDX] &amp; (CPUID_PSE36 | CPUID_PAE)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 cpu-&gt;phys_bits =3D 36;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 cpu-&gt;phys_bits =3D 32;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; --<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; 2.39.1<br>
&gt; <br>
&gt; <br>
<br>
</blockquote></div></div></div>

--000000000000d956ac06080833ec--


