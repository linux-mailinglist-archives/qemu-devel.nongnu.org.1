Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 339D87D0242
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 21:11:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtYOI-0007Sb-VE; Thu, 19 Oct 2023 15:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtYOG-0007Ps-KY
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 15:09:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtYOF-0003bB-0A
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 15:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697742542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=01He6B9eozaaeE5WVJNLhSBI/aCxj+PrRNnaRZ9qsWE=;
 b=CAS3U330bhOvOlGnbT7NSvRDNwTlfj4B/B1+VpT09mmCqLbqGgu9o1PtfpT9uQbpaUnpHC
 oSM4JjJGs6EPsfOBGGWotafn9X4a8Yj9rUyPGqdgj7SDCzPvjHQdjZ3lVzOP8gqYWLbXI/
 IoqrIure1Af1EDKBd5UPWo/sDP4vezo=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-HkrOgG6INam3vSYEafvLBg-1; Thu, 19 Oct 2023 15:09:00 -0400
X-MC-Unique: HkrOgG6INam3vSYEafvLBg-1
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-7b68d0e9be4so5459241.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 12:09:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697742539; x=1698347339;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=01He6B9eozaaeE5WVJNLhSBI/aCxj+PrRNnaRZ9qsWE=;
 b=gU1y6fsNJlmoDPtUUZI5MbsIe9KH/MtVLsCUYJOB5Uudga9eGtCeYMV3czQ9ZAC5Rf
 pYz+1m+r38NB1V6bPy29iWbdzS1K5cINlgNYiH5vFVt1SXUNcJ9+mqWBSZAHmT1hI85m
 Na6gwQGOJyB5QqZCeXVYFAfqIT9+JWwf0qkSDOlDg3oXnqitPWpy34XRWTGpHiDcFYEE
 5T/YsDkxyGZL910XcsGRdstT8ZSAHcLaP1UhfgPW3Dyr6NhRrT8FIN5a+ecSks3ZCjFb
 UHBKWj2e/sOyC7C8j1PgnpOlHWCx2AANnqpCbA+TAVvSqft0JZOV4rJWQ9AXChma2b3F
 l4WQ==
X-Gm-Message-State: AOJu0YzzFORc2t/KjDXL3w6Z4dubheZCXH4bOUnzbGcD4w29tJmVFYSb
 sUxFAmtIihEdIypV8PziN450Sc6OwU+H/0ZhLb2HHaCPK05AVNFCYTQ3N1Vi16aAYUHzslsHFiE
 P6pYcEvd7D+5sHklQlqn+Ygm3ZIfdfaLfZVNmiVo=
X-Received: by 2002:a67:c18e:0:b0:457:dbe3:ef45 with SMTP id
 h14-20020a67c18e000000b00457dbe3ef45mr3201968vsj.19.1697742539341; 
 Thu, 19 Oct 2023 12:08:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxIpKziFb07fxQB+YHD2hNEGFuD3C5FMSda7fnCNDyww+VhneRRfAyqXr6DE0XgByCZyVpbaMwSyZzuV7M+f0=
X-Received: by 2002:a67:c18e:0:b0:457:dbe3:ef45 with SMTP id
 h14-20020a67c18e000000b00457dbe3ef45mr3201958vsj.19.1697742539130; Thu, 19
 Oct 2023 12:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231019104648.389942-1-pbonzini@redhat.com>
 <20231019104648.389942-8-pbonzini@redhat.com>
 <3cb64878-7f3c-46b4-b423-0c5a31aba797@linaro.org>
In-Reply-To: <3cb64878-7f3c-46b4-b423-0c5a31aba797@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 19 Oct 2023 21:08:46 +0200
Message-ID: <CABgObfaJDd7YS7g_iyFmfr=PCBt3cGK4xDdV8TicVKJ2FqbMAg@mail.gmail.com>
Subject: Re: [PATCH v2 07/19] target/i386: introduce flags writeback mechanism
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000f729a30608167c18"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

--000000000000f729a30608167c18
Content-Type: text/plain; charset="UTF-8"

Il gio 19 ott 2023, 19:44 Richard Henderson <richard.henderson@linaro.org>
ha scritto:

> On 10/19/23 03:46, Paolo Bonzini wrote:
> > +    /*
> > +     * Write back flags after last memory access.  Some newer ALU
> instructions, as
> > +     * well as SSE instructions, write flags in the gen_* function, but
> that can
> > +     * cause incorrect tracking of CC_OP for instructions that write to
> both memory
> > +     * and flags.
> > +     */
> > +    if (decode.cc_op != -1) {
> > +        if (decode.cc_dst) {
> > +            tcg_gen_mov_tl(cpu_cc_dst, decode.cc_dst);
> > +        }
> > +        if (decode.cc_src) {
> > +            tcg_gen_mov_tl(cpu_cc_src, decode.cc_src);
> > +        }
> > +        if (decode.cc_src2) {
> > +            tcg_gen_mov_tl(cpu_cc_src2, decode.cc_src2);
> > +        }
> > +        if (decode.cc_op == CC_OP_DYNAMIC) {
> > +            tcg_gen_mov_i32(cpu_cc_op, decode.cc_op_dynamic);
> > +        } else {
> > +            assert(!decode.cc_op_dynamic);
> > +        }
> > +        set_cc_op(s, decode.cc_op);
> > +    } else {
> > +        assert(!decode.cc_dst);
> > +        assert(!decode.cc_src);
> > +        assert(!decode.cc_src2);
> > +        assert(!decode.cc_op_dynamic);
> > +    }
>
> I suggest you use cc_op_live[] to ensure that each output is present if
> USES_CC_* is set,
> and absent otherwise. Obviously that's not possible for CC_OP_DYNAMIC, but
> for everything else...
>

I tried but it didn't work very well. I have shuffled things a bit and I
don't remember why :) so I will give it another go.

Paolo


>
> r~
>
>

--000000000000f729a30608167c18
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il gio 19 ott 2023, 19:44 Richard Henderson &lt;<a hre=
f=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&=
gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 10/19/23 03:46, =
Paolo Bonzini wrote:<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Write back flags after last memory access.=C2=
=A0 Some newer ALU instructions, as<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* well as SSE instructions, write flags in the ge=
n_* function, but that can<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* cause incorrect tracking of CC_OP for instructi=
ons that write to both memory<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* and flags.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 if (decode.cc_op !=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (decode.cc_dst) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_tl(cpu_cc_dst, =
decode.cc_dst);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (decode.cc_src) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_tl(cpu_cc_src, =
decode.cc_src);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (decode.cc_src2) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_tl(cpu_cc_src2,=
 decode.cc_src2);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (decode.cc_op =3D=3D CC_OP_DYNAMIC) {<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_i32(cpu_cc_op, =
decode.cc_op_dynamic);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(!decode.cc_op_dynami=
c);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_cc_op(s, decode.cc_op);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(!decode.cc_dst);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(!decode.cc_src);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(!decode.cc_src2);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(!decode.cc_op_dynamic);<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
I suggest you use cc_op_live[] to ensure that each output is present if USE=
S_CC_* is set, <br>
and absent otherwise. Obviously that&#39;s not possible for CC_OP_DYNAMIC, =
but for everything else...<br></blockquote></div></div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">I tried but it didn&#39;t work very well. I have =
shuffled things a bit and I don&#39;t remember why :) so I will give it ano=
ther go.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">
<br>
<br>
r~<br>
<br>
</blockquote></div></div></div>

--000000000000f729a30608167c18--


