Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A890F820129
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 20:13:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJIHr-0003kX-J5; Fri, 29 Dec 2023 14:12:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJIHp-0003kD-J3
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 14:12:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJIHn-0005cd-PE
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 14:12:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703877166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HthP2324PqFVDgUfZ5tCQVIxUeAtwMzGw+oyq1PebpE=;
 b=LOM0yPcmUhIFO2sQVd0NQiNdcbbISYSLXtffF/Ufzf467DRCsBgjb69vQmnQ+2OoTRw+eh
 DT/cidqjhfU07/2Bc3/iMUfJFcb7Qk5XtEzJ4InnM8FfJVSCMBAj3JdqITkmpGR+YgLH3W
 MtLcGwmRgykFXnPpfHtz08LGVSvx4AA=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-5DaqG1z_PY-p-t0UbGcgxg-1; Fri, 29 Dec 2023 14:12:43 -0500
X-MC-Unique: 5DaqG1z_PY-p-t0UbGcgxg-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6d9feae8dfdso9902900a34.2
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 11:12:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703877163; x=1704481963;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HthP2324PqFVDgUfZ5tCQVIxUeAtwMzGw+oyq1PebpE=;
 b=EHhAgG3xsjYGJJ5pHp9OjXgrd6S+2zmxfv5PQ/bug5tLgp2irchR2s7WyBpCHJYNJn
 tt713L64bTzBGmU3hjiJI7JVpsvtJmwURp5YwwRAZ2gV6AhKe7VPKLmKO7v/bJ4OesVj
 Em1msn5ogPaASIqYjpNvn/sl9e7WFtbkYFoTjBY9o37csq9gm6mO0leF79U/46CxP3Kc
 +twU16pwKMfFluVr459t+6j4oNKaZYUPBiv3o76Wc7Oi9onaMkzzRfyFjp/dODP43K57
 j8qdwQIZLX8HaI9IXLOfOlJmzfYg/q+FusgVNZxqO+N4SHY1npUx2cZjGWn5P5QhLg2k
 /DFA==
X-Gm-Message-State: AOJu0Yx2mdYz/d7t1JCiZJ7EMUljndaIDuKiZeO8fLpcwGDSQyzLBYBJ
 tzAos6ByYlR3JMZCpZvqxCsUP5TAGHGVlyU+d8Cg2Ebv6RhpZ+cDIxIP1kK1SVAzNAmM6Oxmzxf
 /WYT3P/QN5TaYkjU6B4h88HqrIqQdwXrMExvEv/Y=
X-Received: by 2002:a9d:6186:0:b0:6db:ff73:be74 with SMTP id
 g6-20020a9d6186000000b006dbff73be74mr5784168otk.28.1703877163111; 
 Fri, 29 Dec 2023 11:12:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHXAiad12ra3owXpLbxEsqX6nvZ4eT/iJLBVB5u3E+wSfz5/hk+R4qIETPGGXDlU35G9rhL6vQTBOFE6Qv3Hs=
X-Received: by 2002:a9d:6186:0:b0:6db:ff73:be74 with SMTP id
 g6-20020a9d6186000000b006dbff73be74mr5784157otk.28.1703877162834; Fri, 29 Dec
 2023 11:12:42 -0800 (PST)
MIME-Version: 1.0
References: <20231228120524.70239-1-pbonzini@redhat.com>
 <1623ee93-f676-49a3-837e-0438eeaeb0bd@linaro.org>
In-Reply-To: <1623ee93-f676-49a3-837e-0438eeaeb0bd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 29 Dec 2023 20:12:30 +0100
Message-ID: <CABgObfb=FZ5weG-afk0ag1Kk5ExY6a-O2o3ntyLXDV35nsgaxg@mail.gmail.com>
Subject: Re: [PATCH] tcg/i386: use 8-bit OR or XOR for unsigned 8-bit
 immediates
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000000837d3060daad1cf"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.553,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000000837d3060daad1cf
Content-Type: text/plain; charset="UTF-8"

Il gio 28 dic 2023, 21:45 Richard Henderson <richard.henderson@linaro.org>
ha scritto:

> On 12/28/23 23:05, Paolo Bonzini wrote:
> > In the case where OR or XOR has an 8-bit immediate between 128 and 255,
> we can
> > operate on a low-byte register and shorten the output by two or three
> bytes
> > (two if a prefix byte is needed for REX.B).
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   tcg/i386/tcg-target.c.inc | 7 +++++++
> >   1 file changed, 7 insertions(+)
>
> At least once upon a time the partial register stall like this was quite
> slow.  IIRC there
> have been improvements in the last couple of generations, but it's still
> slower.
>
> Data to show this is worthwhile?
>

To be honest I simply had noticed that GCC generates it just fine these
days.

However, Agner Fog says that the (previously very high) penalty for partial
register access became just 1 uop starting with the Pentium D, and it's
gone completely except for AH/BH/CH/DH starting with Haswell.

On Atom and AMD processors there's a false dependency on the rest of the
register, but you'd have a (true) dependency anyway for OR r32, imm. The
only case where the false dependency matters is for instructions such as
MOV AL, imm; these have such a dependency on Atom and AMD processors but
not on recent Intel processors.

Paolo


>
> r~
>
> >
> > diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
> > index 1791b959738..a24a23f43b1 100644
> > --- a/tcg/i386/tcg-target.c.inc
> > +++ b/tcg/i386/tcg-target.c.inc
> > @@ -244,6 +244,7 @@ static bool tcg_target_const_match(int64_t val,
> TCGType type, int ct, int vece)
> >   #define P_VEXL          0x80000         /* Set VEX.L = 1 */
> >   #define P_EVEX          0x100000        /* Requires EVEX encoding */
> >
> > +#define OPC_ARITH_EbIb       (0x80)
> >   #define OPC_ARITH_EvIz      (0x81)
> >   #define OPC_ARITH_EvIb      (0x83)
> >   #define OPC_ARITH_GvEv      (0x03)          /* ... plus (ARITH_FOO <<
> 3) */
> > @@ -1366,6 +1367,12 @@ static void tgen_arithi(TCGContext *s, int c, int
> r0,
> >           tcg_out8(s, val);
> >           return;
> >       }
> > +    if (val == (uint8_t)val && (c == ARITH_OR || c == ARITH_XOR) &&
> > +        (r0 < 4 || TCG_TARGET_REG_BITS == 64)) {
> > +        tcg_out_modrm(s, OPC_ARITH_EbIb + P_REXB_RM, c, r0);
> > +        tcg_out8(s, val);
> > +        return;
> > +    }
> >       if (rexw == 0 || val == (int32_t)val) {
> >           tcg_out_modrm(s, OPC_ARITH_EvIz + rexw, c, r0);
> >           tcg_out32(s, val);
>
>

--0000000000000837d3060daad1cf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il gio 28 dic 2023, 21:45 Richard Henderson &lt;<a hre=
f=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&=
gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 12/28/23 23:05, =
Paolo Bonzini wrote:<br>
&gt; In the case where OR or XOR has an 8-bit immediate between 128 and 255=
, we can<br>
&gt; operate on a low-byte register and shorten the output by two or three =
bytes<br>
&gt; (two if a prefix byte is needed for REX.B).<br>
&gt; <br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0tcg/i386/tcg-target.c.inc | 7 +++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 7 insertions(+)<br>
<br>
At least once upon a time the partial register stall like this was quite sl=
ow.=C2=A0 IIRC there <br>
have been improvements in the last couple of generations, but it&#39;s stil=
l slower.<br>
<br>
Data to show this is worthwhile?<br></blockquote></div></div><div dir=3D"au=
to"><br></div><div dir=3D"auto">To be honest I simply had noticed that GCC =
generates it just fine these days.</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">However, Agner Fog says that the (previously very high) penalty =
for partial register access became just 1 uop starting with the Pentium D, =
and it&#39;s gone completely except for AH/BH/CH/DH starting with Haswell.<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">On Atom and AMD processo=
rs there&#39;s a false dependency on the rest of the register, but you&#39;=
d have a (true) dependency anyway for OR r32, imm. The only case where the =
false dependency matters is for instructions such as MOV AL, imm; these hav=
e such a dependency on Atom and AMD processors but not on recent Intel proc=
essors.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo=C2=A0</div=
><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">
<br>
<br>
r~<br>
<br>
&gt; <br>
&gt; diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc<br>
&gt; index 1791b959738..a24a23f43b1 100644<br>
&gt; --- a/tcg/i386/tcg-target.c.inc<br>
&gt; +++ b/tcg/i386/tcg-target.c.inc<br>
&gt; @@ -244,6 +244,7 @@ static bool tcg_target_const_match(int64_t val, TC=
GType type, int ct, int vece)<br>
&gt;=C2=A0 =C2=A0#define P_VEXL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x80000=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Set VEX.L =3D 1 */<br>
&gt;=C2=A0 =C2=A0#define P_EVEX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x100000=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Requires EVEX encoding */<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +#define OPC_ARITH_EbIb=C2=A0 =C2=A0 =C2=A0 =C2=A0(0x80)<br>
&gt;=C2=A0 =C2=A0#define OPC_ARITH_EvIz=C2=A0 =C2=A0 =C2=A0 (0x81)<br>
&gt;=C2=A0 =C2=A0#define OPC_ARITH_EvIb=C2=A0 =C2=A0 =C2=A0 (0x83)<br>
&gt;=C2=A0 =C2=A0#define OPC_ARITH_GvEv=C2=A0 =C2=A0 =C2=A0 (0x03)=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ... plus (ARITH_FOO &lt;&lt; 3) */<br>
&gt; @@ -1366,6 +1367,12 @@ static void tgen_arithi(TCGContext *s, int c, i=
nt r0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_out8(s, val);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 if (val =3D=3D (uint8_t)val &amp;&amp; (c =3D=3D ARITH_=
OR || c =3D=3D ARITH_XOR) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (r0 &lt; 4 || TCG_TARGET_REG_BITS =3D=3D =
64)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_out_modrm(s, OPC_ARITH_EbIb + P_REXB_=
RM, c, r0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_out8(s, val);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rexw =3D=3D 0 || val =3D=3D (int32_t)val=
) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_out_modrm(s, OPC_ARITH_EvI=
z + rexw, c, r0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_out32(s, val);<br>
<br>
</blockquote></div></div></div>

--0000000000000837d3060daad1cf--


