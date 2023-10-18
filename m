Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F14CF7CE4C3
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 19:39:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtAVI-0004QW-9N; Wed, 18 Oct 2023 13:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qtAVF-0004Q7-HL
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 13:38:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qtAVD-0002Fi-Ra
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 13:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697650718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zkElbI49uRCM6EBauKNVKoQIzC8sICHgysDYlTl7wYY=;
 b=XhIEoPNN2GfGyp9xrKytA/wICE+CIJrnm1KNLli7gu3KUMjYHOebPZwmqagS7MjIhloUvM
 oH/734kwVxMKiI3F70XITPPQt/l4zVQB+FS8zYi4x1RAbJR6kSk7gLeemKTyAAGin/1yBD
 P3rIaDE99bfIlXH0ww0u5tNgxAzXPiY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-iJ63qZXXNoWjO4nZgNq9mQ-1; Wed, 18 Oct 2023 13:38:26 -0400
X-MC-Unique: iJ63qZXXNoWjO4nZgNq9mQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9bd86510329so516873066b.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 10:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697650705; x=1698255505;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zkElbI49uRCM6EBauKNVKoQIzC8sICHgysDYlTl7wYY=;
 b=N6sDXOI0zsmnxGWM+cxXuoMMemRUFD92/ZLtk5GW2TDmNM7xP4QBksA495eLd5fny2
 qbWpWhGTy/2P2fa+jLqgao3eo121kR28fjrBYqjelRaXghoH6xjKAIPdTl2RfxTnkVvt
 dmgWXfcn56FmiwHjLpE4aH1/2T+ca3vzpMAO03VlCgfhpvqHBxuBWVfXqEC4zeuMDvA8
 YpDLBQbrQyZLJzQriQfZ5lkw7+IFK47GoIRGXWIX7E7oIn5MKvDO+h2Rzl/ZHjSdHrpw
 NVTGdzMPcw0+BmLmWhydsyD1mvThaHijOVRrcBvnwHn6HtYTJmczBzUMt/Mg3pOc7c5q
 a4Ow==
X-Gm-Message-State: AOJu0Yx+Udp7I6F8+jeRbrSVqxtSq+RVx/rf17b0UJVrR/SJhK0/0Ji0
 xZYaz5WDtyGdo4BtKDZHE+s0psCgiwXPEBATnDiGodaGJqQ1m78eG4J8f4OCNrxJk1B5Je158Sn
 yM5fXGtmPpHuzvjUZ6VQTZ3Ob2yIpn8M=
X-Received: by 2002:a17:907:26c1:b0:9bd:d7bd:1a52 with SMTP id
 bp1-20020a17090726c100b009bdd7bd1a52mr4640408ejc.20.1697650705179; 
 Wed, 18 Oct 2023 10:38:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFByRpOrqkK2sdvQdXcsFIX6nsCeGrVHd7aWTCxUMe9DTcv7akgRa9twOWXJL+GykTq9vDISANf2+W5/r6sggo=
X-Received: by 2002:a17:907:26c1:b0:9bd:d7bd:1a52 with SMTP id
 bp1-20020a17090726c100b009bdd7bd1a52mr4640390ejc.20.1697650704762; Wed, 18
 Oct 2023 10:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230912120650.371781-1-anisinha@redhat.com>
 <20231018080451-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231018080451-mutt-send-email-mst@kernel.org>
From: Ani Sinha <anisinha@redhat.com>
Date: Wed, 18 Oct 2023 23:08:11 +0530
Message-ID: <CAK3XEhP-AHh0P12O8=Guia4nVPx1DZjXekYUgoDQ4RKcM4cAfQ@mail.gmail.com>
Subject: Re: [PATCH] cpu/cpuid: check CPUID_PAE to determine 36 bit processor
 address space
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000035e2ff0608011b2c"
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

--00000000000035e2ff0608011b2c
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Oct, 2023, 5:35 pm Michael S. Tsirkin, <mst@redhat.com> wrote:

> On Tue, Sep 12, 2023 at 05:36:50PM +0530, Ani Sinha wrote:
> > PAE mode in x86 supports 36 bit address space. Check the PAE CPUID on the
> > guest processor and set phys_bits to 36 if PAE feature is set. This is in
> > addition to checking the presence of PSE36 CPUID feature for setting 36
> bit
> > phys_bits.
> >
> > Signed-off-by: Ani Sinha <anisinha@redhat.com>
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> who's applying this?
>

I thought it would be you? What did I miss?


> > ---
> >  target/i386/cpu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Note: Not sure what tests I should be running in order to make sure I am
> > not breaking any guest OSes. Usual qtests pass.
> >
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 24ee67b42d..f3a5c99117 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -7375,7 +7375,7 @@ static void x86_cpu_realizefn(DeviceState *dev,
> Error **errp)
> >              return;
> >          }
> >
> > -        if (env->features[FEAT_1_EDX] & CPUID_PSE36) {
> > +        if (env->features[FEAT_1_EDX] & (CPUID_PSE36 | CPUID_PAE)) {
> >              cpu->phys_bits = 36;
> >          } else {
> >              cpu->phys_bits = 32;
> > --
> > 2.39.1
>
>

--00000000000035e2ff0608011b2c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, 18 Oct, 2023, 5:35 pm Michael S. Tsirkin, &lt;=
<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">On Tue, Sep 12, 2023 at 05:36:50PM +0530, Ani =
Sinha wrote:<br>
&gt; PAE mode in x86 supports 36 bit address space. Check the PAE CPUID on =
the<br>
&gt; guest processor and set phys_bits to 36 if PAE feature is set. This is=
 in<br>
&gt; addition to checking the presence of PSE36 CPUID feature for setting 3=
6 bit<br>
&gt; phys_bits.<br>
&gt; <br>
&gt; Signed-off-by: Ani Sinha &lt;<a href=3D"mailto:anisinha@redhat.com" ta=
rget=3D"_blank" rel=3D"noreferrer">anisinha@redhat.com</a>&gt;<br>
<br>
Acked-by: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">mst@redhat.com</a>&gt;<br>
<br>
who&#39;s applying this?<br></blockquote></div></div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">I thought it would be you? What did I miss?</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">
<br>
&gt; ---<br>
&gt;=C2=A0 target/i386/cpu.c | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; Note: Not sure what tests I should be running in order to make sure I =
am<br>
&gt; not breaking any guest OSes. Usual qtests pass.<br>
&gt; <br>
&gt; diff --git a/target/i386/cpu.c b/target/i386/cpu.c<br>
&gt; index 24ee67b42d..f3a5c99117 100644<br>
&gt; --- a/target/i386/cpu.c<br>
&gt; +++ b/target/i386/cpu.c<br>
&gt; @@ -7375,7 +7375,7 @@ static void x86_cpu_realizefn(DeviceState *dev, =
Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (env-&gt;features[FEAT_1_EDX] &amp; CP=
UID_PSE36) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (env-&gt;features[FEAT_1_EDX] &amp; (C=
PUID_PSE36 | CPUID_PAE)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-&gt;phys_bits =3D =
36;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-&gt;phys_bits =3D =
32;<br>
&gt; -- <br>
&gt; 2.39.1<br>
<br>
</blockquote></div></div></div>

--00000000000035e2ff0608011b2c--


