Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CF77ED6E5
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 23:04:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Ny3-0003ba-JP; Wed, 15 Nov 2023 17:02:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1r3Ny2-0003bS-1W
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 17:02:38 -0500
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1r3Nxz-0003by-Sx
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 17:02:37 -0500
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-58786e23d38so84065eaf.3
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 14:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700085753; x=1700690553; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=wuUhsn+fX08HGQS/pA4kcsr89nwKKb4BMPuwmY+6DFE=;
 b=SQ2SWahiSW5/Rx6XRaXzLHrmXIWM/i6ObdeN3jA/NPC1Cf9DmUHj63vrQOdx8LHZhy
 Sz8pJSGfJHo69vY6g9cbvMGh3Dk7kHROeF0+vmJIRFTKKcdiiS7eeynVX1AWzvc018LW
 zlTPeBbNoNxjLw9ZBEuotZkofLo9KlPRkxiDq3LuXG/R7eslE3N2Yt+YHhOh4/nQnW7u
 2wYLShmcVUVqI4hFuuzXoQqS0aEde//LrGHjsfeNFNY15t/VKyGbIy1HT46AFTDJ1Btp
 PvlTxqOAdUrzMPlcbyCk9wWxw2j1kgl8qz9QyHkN4FsHxOycjGFvTW2OXfOLlzT1NpGA
 kaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700085753; x=1700690553;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wuUhsn+fX08HGQS/pA4kcsr89nwKKb4BMPuwmY+6DFE=;
 b=gYiszZdlBXuUsczT+WP1eIrVByne6eJx/lg1N5f4UXU8OyPzcLkFbXvrcJKbFDtSwo
 r1RzYqp23FjtRxpLRftO+1cFCIfCIdujhuvsoKobHP4RnYz9Yb3aU9MrdlIFmvy9eqmN
 BCbirh5mgudC5KCbi74cAvskXAMLz3oavkSYmAqXL13itamBsVgZDN+9LdpkhJCV1sm5
 yUvCzkf/KzH2q9zTBqbolvaaXfX6CLHA89GbKxm3pL/xb/LU/O6J2qgs+vlzZY0QDFFl
 Zm0sprF7STTvLW8FaVqUsYycIGyb2kdJ23wRm3UaC/Z8uJvFshWkTany9khGCdFlEiXQ
 3iQw==
X-Gm-Message-State: AOJu0YzVUxCpOcV+CJaxL8d5JXaN5plnv7jibZ33+ptj8CrffuNlyUKW
 ooetIusIt0B9p47cPvi1Te8=
X-Google-Smtp-Source: AGHT+IEbrL6LaROh2a78oYlbwdbr9D6F8LrAMjZk7/SkqeduWbb4IHU/7e9OpBBCn+UzFT6BnfdA7Q==
X-Received: by 2002:a4a:de0b:0:b0:58a:231d:750d with SMTP id
 y11-20020a4ade0b000000b0058a231d750dmr13082938oot.9.1700085753506; 
 Wed, 15 Nov 2023 14:02:33 -0800 (PST)
Received: from DESKTOPUU50BPD
 (2603-8080-1f00-9c00-14d9-7925-4e97-88a2.res6.spectrum.com.
 [2603:8080:1f00:9c00:14d9:7925:4e97:88a2])
 by smtp.gmail.com with ESMTPSA id
 e12-20020a4aaacc000000b0058a3c5d590bsm801241oon.7.2023.11.15.14.02.32
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Nov 2023 14:02:32 -0800 (PST)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <bcain@quicinc.com>,
	<qemu-devel@nongnu.org>
Cc: "'Matheus Bernardino \(QUIC\)'" <quic_mathbern@quicinc.com>,
 "'Sid Manning'" <sidneym@quicinc.com>, <richard.henderson@linaro.org>,
 <philmd@linaro.org>, <ale@rev.ng>, <anjo@rev.ng>
References: <20231109212549.356168-1-ltaylorsimpson@gmail.com>
 <SN6PR02MB4205D15E8A90CBFDE1C81D0FB8B1A@SN6PR02MB4205.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4205D15E8A90CBFDE1C81D0FB8B1A@SN6PR02MB4205.namprd02.prod.outlook.com>
Subject: RE: [RFC PATCH] Hexagon (target/hexagon) Make generators object
 oriented
Date: Wed, 15 Nov 2023 16:02:31 -0600
Message-ID: <002e01da180f$6f03d870$4d0b8950$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFqGi//C5px47NHXw9na6oUbp/F6gE+OlsBsVHwaSA=
Content-Language: en-us
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



> -----Original Message-----
> From: Brian Cain <bcain@quicinc.com>
> Sent: Wednesday, November 15, 2023 1:51 PM
> To: Taylor Simpson <ltaylorsimpson@gmail.com>; qemu-devel@nongnu.org
> Cc: Matheus Bernardino (QUIC) <quic_mathbern@quicinc.com>; Sid
> Manning <sidneym@quicinc.com>; richard.henderson@linaro.org;
> philmd@linaro.org; ale@rev.ng; anjo@rev.ng
> Subject: RE: [RFC PATCH] Hexagon (target/hexagon) Make generators =
object
> oriented
>=20
>=20
>=20
> > -----Original Message-----
> > From: Taylor Simpson <ltaylorsimpson@gmail.com>
> > Sent: Thursday, November 9, 2023 3:26 PM
> > To: qemu-devel@nongnu.org
> > Cc: Brian Cain <bcain@quicinc.com>; Matheus Bernardino (QUIC)
> > <quic_mathbern@quicinc.com>; Sid Manning <sidneym@quicinc.com>;
> > richard.henderson@linaro.org; philmd@linaro.org; ale@rev.ng;
> anjo@rev.ng;
> > ltaylorsimpson@gmail.com
> > Subject: [RFC PATCH] Hexagon (target/hexagon) Make generators object
> > oriented
> >
> > RFC - This patch handles gen_tcg_funcs.py.  I'd like to get comments
> > on the general approach before working on the other Python scripts.
> >
> > The generators are generally a bunch of Python if-then-else
> > statements based on the regtype and regid.  Encapsulate =
regtype/regid
> > into a class hierarchy.  Clients lookup the register and invoke
> > methods.
> >
> > This has several advantages for making the code easier to read,
> > understand, and maintain
> > - The class name makes it more clear what the operand does
> > - All the methods for a given type of operand are together
> > - Don't need as many calls to hex_common.bad_register
> > - We can remove the functions in hex_common that use regtype/regid
> >   (e.g., is_read)
> >
> > Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> > ---
> > diff --git a/target/hexagon/hex_common.py
> b/target/hexagon/hex_common.py
> > index 0da65d6dd6..13ee55b6b2 100755
> > --- a/target/hexagon/hex_common.py
> > +++ b/target/hexagon/hex_common.py
> > +class ModifierSource(Source):
> > +    def genptr_decl(self, f, tag, regno):
> > +        f.write(f"    const int {self.regN} =3D =
insn->regno[{regno}];\n")
> > +        f.write(f"    TCGv {self.regV} =3D hex_gpr[{self.regN} +
> HEX_REG_M0];\n")
> > +    def idef_arg(self, declared):
> > +        declared.append(self.regV)
> > +        declared.append(self.regN)
> > +
>=20
> IMO it's easier to reason about a function if it doesn't modify its =
inputs and
> instead it returns the transformed input.  If idef_arg instead =
returned a new
> list or returned an iterable for the caller to catenate, it would be =
clearer.

We should figure out a better way to handle the special case of modifier =
registers.  For every other register type,
Idef_arg simply returns self.regV.  For circular addressing, we also =
need the value of the corresponding CS register.  Currently,
we solve this by passing the register number so that idef-parser can get =
the value (i.e.,  hex_gpr[HEX_REG_CS0 + self.regN]).

We could have idef-parser skip the circular addressing instructions (it =
already skips the bit-reverse instructions).  That seems
like a big hammer though.  Any other thoughts?


> > +class PredReadWrite(ReadWrite):
> > +    def genptr_decl(self, f, tag, regno):
> > +        f.write(f"    const int {self.regN} =3D =
insn->regno[{regno}];\n")
> > +        f.write(f"    TCGv {self.regV} =3D tcg_temp_new();\n")
> > +        f.write(f"    tcg_gen_mov_tl({self.regV}, =
hex_pred[{self.regN}]);\n")
>=20
> Instead of successive calls to f.write(), each passing their own =
string with a
> newline, use triple quotes:
>=20
> f.write(f"""    const int {self.regN} =3D insn->regno[{regno}];
>     TCGv {self.regV} =3D tcg_temp_new();
>     tcg_gen_mov_tl({self.regV}, hex_pred[{self.regN}]);\n""")
>=20
> If necessary/appropriate, you can also use textwrap.dedent() to make =
the
> leading whitespace look appropriate:
> https://docs.python.org/3/library/textwrap.html#textwrap.dedent
>=20
> import textwrap
> ...
> f.write(textwrap.dedent(f"""    const int {self.regN} =3D =
insn->regno[{regno}];
>     TCGv {self.regV} =3D tcg_temp_new();
>     tcg_gen_mov_tl({self.regV}, hex_pred[{self.regN}]);\n"""))
>=20

The indenting is for the readability of the output.  We could dedent =
everything and run the result through the indent utility
as idef-parser does.  Not sure it's worth it though.

> > +def init_registers():
> > +    registers["Rd"] =3D GprDest("R", "d")
> > +    registers["Re"] =3D GprDest("R", "e")
> > +    registers["Rs"] =3D GprSource("R", "s")
> > +    registers["Rt"] =3D GprSource("R", "t")
> > +    registers["Ru"] =3D GprSource("R", "u")
> > +    registers["Rv"] =3D GprSource("R", "v")
> > +    registers["Rx"] =3D GprReadWrite("R", "x")
> > +    registers["Ry"] =3D GprReadWrite("R", "y")
> > +    registers["Cd"] =3D ControlDest("C", "d")
> > +    registers["Cs"] =3D ControlSource("C", "s")
> > +    registers["Mu"] =3D ModifierSource("M", "u")
> > +    registers["Pd"] =3D PredDest("P", "d")
> > +    registers["Pe"] =3D PredDest("P", "e")
> > +    registers["Ps"] =3D PredSource("P", "s")
> > +    registers["Pt"] =3D PredSource("P", "t")
> > +    registers["Pu"] =3D PredSource("P", "u")
> > +    registers["Pv"] =3D PredSource("P", "v")
> > +    registers["Px"] =3D PredReadWrite("P", "x")
> > +    registers["Rdd"] =3D PairDest("R", "dd")
> > +    registers["Ree"] =3D PairDest("R", "ee")
> > +    registers["Rss"] =3D PairSource("R", "ss")
> > +    registers["Rtt"] =3D PairSource("R", "tt")
> > +    registers["Rxx"] =3D PairReadWrite("R", "xx")
> > +    registers["Ryy"] =3D PairReadWrite("R", "yy")
> > +    registers["Cdd"] =3D ControlPairDest("C", "dd")
> > +    registers["Css"] =3D ControlPairSource("C", "ss")
> > +    registers["Vd"] =3D VRegDest("V", "d")
> > +    registers["Vs"] =3D VRegSource("V", "s")
> > +    registers["Vu"] =3D VRegSource("V", "u")
> > +    registers["Vv"] =3D VRegSource("V", "v")
> > +    registers["Vw"] =3D VRegSource("V", "w")
> > +    registers["Vx"] =3D VRegReadWrite("V", "x")
> > +    registers["Vy"] =3D VRegTmp("V", "y")
> > +    registers["Vdd"] =3D VRegPairDest("V", "dd")
> > +    registers["Vuu"] =3D VRegPairSource("V", "uu")
> > +    registers["Vvv"] =3D VRegPairSource("V", "vv")
> > +    registers["Vxx"] =3D VRegPairReadWrite("V", "xx")
> > +    registers["Qd"] =3D QRegDest("Q", "d")
> > +    registers["Qe"] =3D QRegDest("Q", "e")
> > +    registers["Qs"] =3D QRegSource("Q", "s")
> > +    registers["Qt"] =3D QRegSource("Q", "t")
> > +    registers["Qu"] =3D QRegSource("Q", "u")
> > +    registers["Qv"] =3D QRegSource("Q", "v")
> > +    registers["Qx"] =3D QRegReadWrite("Q", "x")
> > +
> > +    new_registers["Ns"] =3D GprNewSource("N", "s")
> > +    new_registers["Nt"] =3D GprNewSource("N", "t")
> > +    new_registers["Pt"] =3D PredNewSource("P", "t")
> > +    new_registers["Pu"] =3D PredNewSource("P", "u")
> > +    new_registers["Pv"] =3D PredNewSource("P", "v")
> > +    new_registers["Os"] =3D VRegNewSource("O", "s")
>=20
> AFAICT the keys for registers and new_registers can be derived from =
the
> values themselves.  Rather than worry about copy/paste errors causing
> these not to correspond, you can create a dictionary from an iterable =
like so:
>=20
> registers =3D (
>     GprDest("R", "d"),
>     GprDest("R", "e"),
>     GprSource("R", "s"),
>     GprSource("R", "t"),
> ...
> )
> registers =3D { reg.regtype + reg.regid for reg in registers }

Will work on this.

> In general this looks like a good change to me.

Thanks for the feedback,
Taylor



