Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C424737AB2
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 07:47:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBqgV-0007s6-G9; Wed, 21 Jun 2023 01:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBqgJ-0007rV-MB
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 01:47:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBqgH-00088N-Rv
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 01:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687326420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=caehTjHmxAnRg06rIzwSJcSsihZqva93mQM+S7A5go4=;
 b=Q3aHPjRvYHnsXkAuq8yQOh79orQcNlh8b6qohA14OpTSglNPTQq5sXDdewXfw25tnpi1YZ
 IS8tkgByJwXFaoTrSgPESI9/64HKprWQPcdDs4PnTwZ1nLOhH8qPBjO9IlzItNQac9/9TC
 YJ5jDnvxCrf1Uoanw3fwQf9/XYxIrVg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-HqLwIsJrMyyt_W_PJvGGAw-1; Wed, 21 Jun 2023 01:46:58 -0400
X-MC-Unique: HqLwIsJrMyyt_W_PJvGGAw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-763a15829e5so367919785a.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 22:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687326417; x=1689918417;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=caehTjHmxAnRg06rIzwSJcSsihZqva93mQM+S7A5go4=;
 b=Pb8YxJh6TH3xrXlptYuKPu+sE5MZ+2evBALCFOxQ0bB5oi12Ej0sSUKxEpCu6EEGmj
 FPizQzA59ZN5BNScHKjsebIZ5+pNztl3JffgUs2fS2JXOUfhPTmNXL21rlriTlYBcsSi
 WFMmUe9DKpWTOZtdpZ8YKaDcyZA8+3XeENK9lvCx3x3oqoJUK8ooIO3JXjq83ieutsKw
 ZJ7++1lZjpvFEDYcNNEzcQlWh68YUoCZIW4guV0XLoLl2DxGFOK/OHuRpMR5d3l4MBFH
 8jTURlvsB14o63kNQMEAYJTRAHdU2Q+ovgl2hzlcE002DCrM83sZrfAbRvD5bdhgWN0y
 cZfg==
X-Gm-Message-State: AC+VfDzNk+2AkI+s5GuDZ4kU3zWClEucsLpsP3QJcid77fnrcALt3ch8
 EoI653UyOX2fA3w1dQxoCivk375vlQNRIyGfP0/PyEJF4gD79q2fvJN8cE2555rMnhHwIFMt7p5
 UpvOo4cLwKZ06EmAQOMal3HjV9x6lxIk=
X-Received: by 2002:a05:620a:674c:b0:763:af8d:9932 with SMTP id
 rq12-20020a05620a674c00b00763af8d9932mr3504722qkn.30.1687326417695; 
 Tue, 20 Jun 2023 22:46:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6gVYPXfNSDtt4D2FqBmrwOGSpmSs5qMfvVsOxHm/UyX7BYcTkX9mcAJSM0FSthRzT+iiZxd/1tkEU5dLMx/rQ=
X-Received: by 2002:a05:620a:674c:b0:763:af8d:9932 with SMTP id
 rq12-20020a05620a674c00b00763af8d9932mr3504706qkn.30.1687326417353; Tue, 20
 Jun 2023 22:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230620151634.21053-1-pbonzini@redhat.com>
 <20230620151634.21053-4-pbonzini@redhat.com>
 <c0624482-6b69-70f7-4d02-88d150822e7a@linaro.org>
In-Reply-To: <c0624482-6b69-70f7-4d02-88d150822e7a@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 21 Jun 2023 07:46:47 +0200
Message-ID: <CABgObfa-Yw2EzDpQ873Opa7DJHbDiZMXqcRSie6VC3z6M-VNgw@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] target/i386: TCG supports RDSEED
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000ba17a205fe9d4b66"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

--000000000000ba17a205fe9d4b66
Content-Type: text/plain; charset="UTF-8"

Il mar 20 giu 2023, 18:24 Richard Henderson <richard.henderson@linaro.org>
ha scritto:

> On 6/20/23 17:16, Paolo Bonzini wrote:
> > TCG implements RDSEED, and in fact uses qcrypto_random_bytes which is
> > secure enough to match hardware behavior.  Expose it to guests.
> >
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   target/i386/cpu.c | 5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index ff3dcd02dcb..fc4246223d4 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -657,11 +657,10 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t
> vendor1,
> >             CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ADX
> | \
> >             CPUID_7_0_EBX_PCOMMIT | CPUID_7_0_EBX_CLFLUSHOPT |
>   \
> >             CPUID_7_0_EBX_CLWB | CPUID_7_0_EBX_MPX |
> CPUID_7_0_EBX_FSGSBASE | \
> > -          CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_AVX2)
> > +          CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_AVX2 |
> CPUID_7_0_EBX_RDSEED)
> >             /* missing:
> >             CPUID_7_0_EBX_HLE
> > -          CPUID_7_0_EBX_INVPCID, CPUID_7_0_EBX_RTM,
> > -          CPUID_7_0_EBX_RDSEED */
> > +          CPUID_7_0_EBX_INVPCID, CPUID_7_0_EBX_RTM */
> >   #define TCG_7_0_ECX_FEATURES (CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
> \
> >             /* CPUID_7_0_ECX_OSPKE is dynamic */ \
> >             CPUID_7_0_ECX_LA57 | CPUID_7_0_ECX_PKS | CPUID_7_0_ECX_VAES)
>
> Still missing the check for CPUID_7_0_EBX_RDSEED at the RDSEED insn.
>

Sorry, I 6kissed that remain. It's more of a separate patch IMO, I will add
it.

Paolo


> r~
>
>

--000000000000ba17a205fe9d4b66
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 20 giu 2023, 18:24 Richard Henderson &lt;<a hre=
f=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&=
gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 6/20/23 17:16, P=
aolo Bonzini wrote:<br>
&gt; TCG implements RDSEED, and in fact uses qcrypto_random_bytes which is<=
br>
&gt; secure enough to match hardware behavior.=C2=A0 Expose it to guests.<b=
r>
&gt; <br>
&gt; Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson=
@linaro.org" target=3D"_blank" rel=3D"noreferrer">richard.henderson@linaro.=
org</a>&gt;<br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/i386/cpu.c | 5 ++---<br>
&gt;=C2=A0 =C2=A01 file changed, 2 insertions(+), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/target/i386/cpu.c b/target/i386/cpu.c<br>
&gt; index ff3dcd02dcb..fc4246223d4 100644<br>
&gt; --- a/target/i386/cpu.c<br>
&gt; +++ b/target/i386/cpu.c<br>
&gt; @@ -657,11 +657,10 @@ void x86_cpu_vendor_words2str(char *dst, uint32_=
t vendor1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPUID_7_0_EBX_BMI1 | CP=
UID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ADX | \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPUID_7_0_EBX_PCOMMIT |=
 CPUID_7_0_EBX_CLFLUSHOPT |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPUID_7_0_EBX_CLWB | CP=
UID_7_0_EBX_MPX | CPUID_7_0_EBX_FSGSBASE | \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX=
_AVX2)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX=
_AVX2 | CPUID_7_0_EBX_RDSEED)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* missing:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPUID_7_0_EBX_HLE<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUID_7_0_EBX_INVPCID, CPUID_7_0_E=
BX_RTM,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUID_7_0_EBX_RDSEED */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUID_7_0_EBX_INVPCID, CPUID_7_0_E=
BX_RTM */<br>
&gt;=C2=A0 =C2=A0#define TCG_7_0_ECX_FEATURES (CPUID_7_0_ECX_UMIP | CPUID_7=
_0_ECX_PKU | \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* CPUID_7_0_ECX_OSPKE =
is dynamic */ \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPUID_7_0_ECX_LA57 | CP=
UID_7_0_ECX_PKS | CPUID_7_0_ECX_VAES)<br>
<br>
Still missing the check for CPUID_7_0_EBX_RDSEED at the RDSEED insn.<br></b=
lockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Sorry, =
I 6kissed that remain. It&#39;s more of a separate patch IMO, I will add it=
.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D=
"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">
<br>
r~<br>
<br>
</blockquote></div></div></div>

--000000000000ba17a205fe9d4b66--


