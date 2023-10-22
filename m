Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EDB7D228F
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 12:24:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quVbR-0002gl-4Y; Sun, 22 Oct 2023 06:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1quVbO-0002cY-Rg
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 06:22:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1quVbL-00017L-OB
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 06:22:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697970150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D7zvgOly6LMBYYcc1BiE4ZrjS+b/8TNyHgDNDFtUNKk=;
 b=L3Jdl4a/aE23b9kh24iGhXzpW7ShUNW4UMRdtaELXhVpbHqJDzOCp2w0KhMzb9s8JHtx6/
 rZroPbfggqMT2l1te6lJaBYUJ7pJohGR1QnOcEAvifDoq3CL8gEKj3CsBstW0AUn7M25QO
 kGMP3dNCoCxw/q4DzdBvuIuCuArC5hc=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-Fk-Na50zOtaUXWeEunnKvA-1; Sun, 22 Oct 2023 06:22:18 -0400
X-MC-Unique: Fk-Na50zOtaUXWeEunnKvA-1
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-7b6dd44b2easo1648772241.3
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 03:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697970138; x=1698574938;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D7zvgOly6LMBYYcc1BiE4ZrjS+b/8TNyHgDNDFtUNKk=;
 b=ZWsN8GoRIVB87gNQOMCxSCQ8tJ6XqsggOF8mZieYVuCD1DJDxeSmZImfqq7ap2AWMt
 l8PSPquo29Iti4q4gSUofqtZtsvnhG8AhWG9JmyZ3PFiy80YFeDmt8bYmUhqCd0ucBWF
 9wkNrX+teQwxOPfPdYgnD7sKmwo8krx9l+sHnDsI3CyUfFvmXt9AoixTjTVw3vsrSAkT
 FM88em/V2eG/VeC860QsdiYSjORWOAIZQks2HhWKDWqY3ge72eJk9+0WVFhbdBMWsM6l
 iylKbfAwjSLTEOabphMmtzizrYuBO871r+2LlopRwv8XxdYReNbVyQwF696UeCLLJgJ8
 BUcg==
X-Gm-Message-State: AOJu0YxlI1TkV8AUKtCjloK6HBiJZQWf8lm8MI9uu0aj/3aZg4OEKAA/
 ZtwEb81QmF8V3PyLSruLPCkdjg739b3vRyg5DxjlgjToOoRNMNhkm4au7CKckAzRSngJcvMaLHo
 L1JlGBgsRrNBdJ9EMqiVFklLUSSGK9EA=
X-Received: by 2002:a67:b006:0:b0:457:ba55:b913 with SMTP id
 z6-20020a67b006000000b00457ba55b913mr5502765vse.34.1697970138033; 
 Sun, 22 Oct 2023 03:22:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWHjpRFOASBHIwclgaR0wOT3CTheXtVHMr4kPrj/wAfoEfM4qZAPcLQno/PsEKF+nHTgqALX0GTZnxiwQWP8k=
X-Received: by 2002:a67:b006:0:b0:457:ba55:b913 with SMTP id
 z6-20020a67b006000000b00457ba55b913mr5502755vse.34.1697970137728; Sun, 22 Oct
 2023 03:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231019182921.1772928-1-richard.henderson@linaro.org>
 <20231019182921.1772928-4-richard.henderson@linaro.org>
 <5f54e3e1-1c90-0249-04f4-df522e292abe@linaro.org>
 <03ba02fd-fade-4409-be16-2f81a5690b4c@redhat.com>
 <4339bf9e-ad25-41b7-91cd-1da8c65d782d@linaro.org>
In-Reply-To: <4339bf9e-ad25-41b7-91cd-1da8c65d782d@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 22 Oct 2023 12:22:07 +0200
Message-ID: <CABgObfaZgav6tGbuykNqtxMezCa7f2Gtzx_ER30upgGUCX7W=Q@mail.gmail.com>
Subject: Re: [PATCH 3/7] target/i386: Use tcg_gen_ext_tl
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, 
 Laurent Vivier <laurent@vivier.eu>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000e629b106084b7a9f"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000e629b106084b7a9f
Content-Type: text/plain; charset="UTF-8"

Il dom 22 ott 2023, 03:29 Richard Henderson <richard.henderson@linaro.org>
ha scritto:

> >   static TCGv gen_ext_tl(TCGv dst, TCGv src, MemOp size, bool sign)
> >   {
> > -    if (memop_size(size) == TARGET_LONG_BITS) {
> > +    if (size == MO_TL) {
>
> Yep.
>
> > I can add it in my x86 series if desirable ...
>
> That's probably fine; you may well get your PR in before my next.
>

I will probably keep only SHA instructions for 8.2 (plus the VEX todos and
the reorganized checks) and delay the rest.

There are a bunch of things I would do in a slightly different manner now,
so it's better to clean up the generic x86 decoder code before implementing
the less orthogonal instruction formats from the one-byte. I should have
time to finish opcodes 0xC0 to 0xFF over the Christmas break in time for
9.0. :)

Paolo



> >>> +    tcg_gen_ext_tl(dst, src, size | (sign ? MO_SIGN : 0));
> >>> +    return dst;
> >>>   }
> >>
> >> While here, I'd rename 'size' -> 'mop'. Regardless,
> >
> > Not sure about that, because "size" should be just the low bits of MemOp
> (the MO_SIGN bit
> > is passed separately).
>
> Agreed.
>
>
> r~
>
>

--000000000000e629b106084b7a9f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il dom 22 ott 2023, 03:29 Richard Henderson &lt;<a hre=
f=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&=
gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">&gt;=C2=A0 =C2=A0st=
atic TCGv gen_ext_tl(TCGv dst, TCGv src, MemOp size, bool sign)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0=C2=A0=C2=A0 if (memop_size(size) =3D=3D TARGET_LONG_BITS) {<br=
>
&gt; +=C2=A0=C2=A0=C2=A0 if (size =3D=3D MO_TL) {<br>
<br>
Yep.<br>
<br>
&gt; I can add it in my x86 series if desirable ...<br>
<br>
That&#39;s probably fine; you may well get your PR in before my next.<br></=
blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">I will=
 probably keep only SHA instructions for 8.2 (plus the VEX todos and the re=
organized checks) and delay the rest.</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">There are a bunch of things I would do in a slightly differen=
t manner now, so it&#39;s better to clean up the generic x86 decoder code b=
efore implementing the less orthogonal instruction formats from the one-byt=
e. I should have time to finish opcodes 0xC0 to 0xFF over the Christmas bre=
ak in time for 9.0. :)</div><div dir=3D"auto"><br></div><div dir=3D"auto">P=
aolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 tcg_gen_ext_tl(dst, src, size | (sign ? MO=
_SIGN : 0));<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 return dst;<br>
&gt;&gt;&gt; =C2=A0 }<br>
&gt;&gt;<br>
&gt;&gt; While here, I&#39;d rename &#39;size&#39; -&gt; &#39;mop&#39;. Reg=
ardless,<br>
&gt; <br>
&gt; Not sure about that, because &quot;size&quot; should be just the low b=
its of MemOp (the MO_SIGN bit <br>
&gt; is passed separately).<br>
<br>
Agreed.<br>
<br>
<br>
r~<br>
<br>
</blockquote></div></div></div>

--000000000000e629b106084b7a9f--


