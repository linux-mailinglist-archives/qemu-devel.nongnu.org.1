Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A174E7EE75E
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 20:20:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3htS-0005Nl-GG; Thu, 16 Nov 2023 14:19:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1r3htQ-0005NO-Uq
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 14:19:12 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1r3htO-0007Ft-Es
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 14:19:12 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6ce353df504so614010a34.3
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 11:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700162349; x=1700767149; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=gxELJpo3OWTJ4nUos7/QubKz7YGVKuFLTmZDsh440C0=;
 b=c7AJMOycbnO7YnFMKVQp//EifRsmzpCupI2y806DvKIGLIOssuUbbjgu8KPnIH7KdW
 6EDgwPSdtJgUHRAkZl9J59X7tE6+zNn2XoSC0SYIUh3n4fyv4sDuz+7/jCCatzf2z5Hg
 pUc05nPuBslceTIL7GpK9vv6quRDBS0+B6RAgN1o9/US0j3E737ePZNrxFNCx8edjxUn
 zMtl3wtb5c/SuOw+4dFpDbfnRybFcIwYRFJ6agCAD7z2TNguCJilZPrT2CUALO4vY3H1
 10LixmfYB30n82wek0XWIF53cIAfP781ne5x3JJVnXYzqRpL0oefREGjrfVmh3yEU2rE
 nIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700162349; x=1700767149;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gxELJpo3OWTJ4nUos7/QubKz7YGVKuFLTmZDsh440C0=;
 b=lfmuSCAz65ocMWmBhUl5/aEJQ4ij/roZvGgblCEMyWHytkGamx9T/U+d53hx78oN+y
 s2rD+Q1SM9ecar+ORlv1NOIKHbephHU3luGP5b1t6KKIkXi6DanSLKUeFJBBIGX9PmMt
 oj5VksGJ63ysErDesZCXOdMKGw2zqErQWbQ8OrZdcFFmXgYpFS3Y3EfZlcdDpeFxydtT
 D1b+XfkGpr8m6Rjw0TQEgGLI/g1/H6bJilIBhgyYDuqmR9zTS1xZTye7lDKNWgvA2RBK
 IbjJgdtEljkoOOEIMKhtoLRxMzcO3GjzcVLH1DykRifyzdA7mwZEvYEoT14ShBS87VGh
 /4OA==
X-Gm-Message-State: AOJu0Yyy4DF7olzpnYm+Ome+nSFlCdq8+NIuJiyBqsSbD0ME8DA8f6Ci
 iXBmwldQ0gH2eSP7Ra3x2Nc=
X-Google-Smtp-Source: AGHT+IF+OWdZ/WW0Ab0Ov5/qPlAcULkNDox9nZunBDjY6BZlaAaGOPyMzSaEz7paJoibKlHKb+RjdA==
X-Received: by 2002:a05:6830:140e:b0:6c4:cda6:ff3e with SMTP id
 v14-20020a056830140e00b006c4cda6ff3emr9783120otp.18.1700162348937; 
 Thu, 16 Nov 2023 11:19:08 -0800 (PST)
Received: from DESKTOPUU50BPD
 (2603-8080-1f00-9c00-61a2-7b12-e978-aea8.res6.spectrum.com.
 [2603:8080:1f00:9c00:61a2:7b12:e978:aea8])
 by smtp.gmail.com with ESMTPSA id
 s4-20020a05683004c400b006ce342a5dbdsm1010251otd.13.2023.11.16.11.19.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 16 Nov 2023 11:19:08 -0800 (PST)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <bcain@quicinc.com>,
	<qemu-devel@nongnu.org>
Cc: "'Matheus Bernardino \(QUIC\)'" <quic_mathbern@quicinc.com>,
 "'Sid Manning'" <sidneym@quicinc.com>, <richard.henderson@linaro.org>,
 <philmd@linaro.org>, <ale@rev.ng>, <anjo@rev.ng>
References: <20231109212549.356168-1-ltaylorsimpson@gmail.com>
 <SN6PR02MB4205D15E8A90CBFDE1C81D0FB8B1A@SN6PR02MB4205.namprd02.prod.outlook.com>
 <002e01da180f$6f03d870$4d0b8950$@gmail.com>
 <SN6PR02MB420519681274CCAEA5CD198AB8B0A@SN6PR02MB4205.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB420519681274CCAEA5CD198AB8B0A@SN6PR02MB4205.namprd02.prod.outlook.com>
Subject: RE: [RFC PATCH] Hexagon (target/hexagon) Make generators object
 oriented
Date: Thu, 16 Nov 2023 13:19:06 -0600
Message-ID: <001401da18c1$c5919c60$50b4d520$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFqGi//C5px47NHXw9na6oUbp/F6gE+OlsBAqBrWCMBamNxa7Ey/Xtg
Content-Language: en-us
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-ot1-x32b.google.com
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
> Sent: Thursday, November 16, 2023 10:25 AM
> To: ltaylorsimpson@gmail.com; qemu-devel@nongnu.org
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
> > From: ltaylorsimpson@gmail.com <ltaylorsimpson@gmail.com>
> > Sent: Wednesday, November 15, 2023 4:03 PM
> > To: Brian Cain <bcain@quicinc.com>; qemu-devel@nongnu.org
> > Cc: Matheus Bernardino (QUIC) <quic_mathbern@quicinc.com>; Sid
> Manning
> > <sidneym@quicinc.com>; richard.henderson@linaro.org;
> > philmd@linaro.org; ale@rev.ng; anjo@rev.ng
> > Subject: RE: [RFC PATCH] Hexagon (target/hexagon) Make generators
> > object oriented
> >
> > > -----Original Message-----
> > > From: Brian Cain <bcain@quicinc.com>
> > > Sent: Wednesday, November 15, 2023 1:51 PM
> > > To: Taylor Simpson <ltaylorsimpson@gmail.com>; qemu-
> devel@nongnu.org
> > > Cc: Matheus Bernardino (QUIC) <quic_mathbern@quicinc.com>; Sid
> > > Manning <sidneym@quicinc.com>; richard.henderson@linaro.org;
> > > philmd@linaro.org; ale@rev.ng; anjo@rev.ng
> > > Subject: RE: [RFC PATCH] Hexagon (target/hexagon) Make generators
> > > object oriented
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Taylor Simpson <ltaylorsimpson@gmail.com>
> > > > Sent: Thursday, November 9, 2023 3:26 PM
> > > > To: qemu-devel@nongnu.org
> > > > Cc: Brian Cain <bcain@quicinc.com>; Matheus Bernardino (QUIC)
> > > > <quic_mathbern@quicinc.com>; Sid Manning <sidneym@quicinc.com>;
> > > > richard.henderson@linaro.org; philmd@linaro.org; ale@rev.ng;
> > > anjo@rev.ng;
> > > > ltaylorsimpson@gmail.com
> > > > Subject: [RFC PATCH] Hexagon (target/hexagon) Make generators
> > > > object oriented
> > > >
> > > > RFC - This patch handles gen_tcg_funcs.py.  I'd like to get
> > > > comments on the general approach before working on the other
> Python scripts.
> > > >
> > > > The generators are generally a bunch of Python if-then-else
> > > > statements based on the regtype and regid.  Encapsulate
> > > > regtype/regid into a class hierarchy.  Clients lookup the =
register
> > > > and invoke methods.
> > > >
> > > > This has several advantages for making the code easier to read,
> > > > understand, and maintain
> > > > - The class name makes it more clear what the operand does
> > > > - All the methods for a given type of operand are together
> > > > - Don't need as many calls to hex_common.bad_register
> > > > - We can remove the functions in hex_common that use =
regtype/regid
> > > >   (e.g., is_read)
> > > >
> > > > Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> > > > ---
> > > > diff --git a/target/hexagon/hex_common.py
> > > b/target/hexagon/hex_common.py
> > > > index 0da65d6dd6..13ee55b6b2 100755
> > > > --- a/target/hexagon/hex_common.py
> > > > +++ b/target/hexagon/hex_common.py
> > > > +class PredReadWrite(ReadWrite):
> > > > +    def genptr_decl(self, f, tag, regno):
> > > > +        f.write(f"    const int {self.regN} =3D =
insn->regno[{regno}];\n")
> > > > +        f.write(f"    TCGv {self.regV} =3D tcg_temp_new();\n")
> > > > +        f.write(f"    tcg_gen_mov_tl({self.regV},
> hex_pred[{self.regN}]);\n")
> > >
> > > Instead of successive calls to f.write(), each passing their own
> > > string with a newline, use triple quotes:
> > >
> > > f.write(f"""    const int {self.regN} =3D insn->regno[{regno}];
> > >     TCGv {self.regV} =3D tcg_temp_new();
> > >     tcg_gen_mov_tl({self.regV}, hex_pred[{self.regN}]);\n""")
> > >
> > > If necessary/appropriate, you can also use textwrap.dedent() to =
make
> > > the leading whitespace look appropriate:
> > > https://docs.python.org/3/library/textwrap.html#textwrap.dedent
> > >
> > > import textwrap
> > > ...
> > > f.write(textwrap.dedent(f"""    const int {self.regN} =3D insn-
> >regno[{regno}];
> > >     TCGv {self.regV} =3D tcg_temp_new();
> > >     tcg_gen_mov_tl({self.regV}, hex_pred[{self.regN}]);\n"""))
> > >
> >
> > The indenting is for the readability of the output.  We could dedent
> > everything and run the result through the indent utility as
> > idef-parser does.  Not sure it's worth it though.
>=20
> Regardless of textwrap.dedent(), I think the output is most readable =
with
> triple-quotes.  It's more readable than it is with multiple =
f.write("this line\n")
> invocations.
>=20
> The intent of calling textwrap.dedent is to allow you to not out-dent =
the text
> in the python program.  Since the indentation of the other lines next =
to the
> string literal are significant to the program, it might be =
odd/confusing to see
> the python program have out-dented text lines.
>=20
> Consider the readability of the python program:
>=20
> if foo:
>     f.write(textwrap.dedent(f"""\
>         const int {self.regN} =3D insn->regno[{regno}];
>         TCGv {self.regV} =3D tcg_temp_new();
>         tcg_gen_mov_tl({self.regV}, hex_pred[{self.regN}]);
>         """))
>       if bar:
>          f.write(textwrap.dedent(f"""\
>               int x =3D {bar.reg};
>               """)
> vs
>=20
> if foo:
>      f.write(f"""\
> const int {self.regN} =3D insn->regno[{regno}]; TCGv {self.regV} =3D
> tcg_temp_new(); tcg_gen_mov_tl({self.regV}, =
hex_pred[{self.regN}]);\n""")
>       if bar:
>          f.write(f"""\
> int x =3D {bar.reg};
> """)
>=20
> The latter omits textwrap.dedent() - if we used the leading whitespace =
here
> like we do in the former, the output text would have inconsistent =
formatting.

Let's go with the first version but add an indent.  I'll use a little =
helper function:
def code_fmt(txt):
    return textwrap.indent(textwrap.dedent(txt), "    ")

Then, the Python code would look like this:
class PairSource(Register, Pair, OldSource):
    def decl_tcg(self, f, tag, regno):
        self.decl_reg_num(f, regno)
        f.write(code_fmt(f"""\
            TCGv_i64 {self.reg_tcg()} =3D tcg_temp_new_i64();
            tcg_gen_concat_i32_i64({self.reg_tcg()},
                hex_gpr[{self.reg_num}],
                hex_gpr[{self.reg_num} + 1]);
        """))

The generated code will be as desired:
static void generate_A2_vaddw(DisasContext *ctx)
{
    Insn *insn G_GNUC_UNUSED =3D ctx->insn;
    const int RddN =3D insn->regno[0];
    TCGv_i64 RddV =3D get_result_gpr_pair(ctx, RddN);
    const int RssN =3D insn->regno[1];
    TCGv_i64 RssV =3D tcg_temp_new_i64();
    tcg_gen_concat_i32_i64(RssV,
        hex_gpr[RssN],
        hex_gpr[RssN + 1]);
    const int RttN =3D insn->regno[2];
    TCGv_i64 RttV =3D tcg_temp_new_i64();
    tcg_gen_concat_i32_i64(RttV,
        hex_gpr[RttN],
        hex_gpr[RttN + 1]);
    emit_A2_vaddw(ctx, ctx->insn, ctx->pkt, RddV, RssV, RttV);
    gen_log_reg_write_pair(ctx, RddN, RddV);
}

> > > > +def init_registers():
> > > > +    registers["Rd"] =3D GprDest("R", "d")
> > > > +    registers["Re"] =3D GprDest("R", "e")
> > > > +    registers["Qu"] =3D QRegSource("Q", "u")
> > > > +    registers["Qv"] =3D QRegSource("Q", "v")
> > > > +    registers["Qx"] =3D QRegReadWrite("Q", "x")
> > > > +
> > > > +    new_registers["Ns"] =3D GprNewSource("N", "s")
> > > > +    new_registers["Nt"] =3D GprNewSource("N", "t")
> > > > +    new_registers["Pt"] =3D PredNewSource("P", "t")
> > > > +    new_registers["Pu"] =3D PredNewSource("P", "u")
> > > > +    new_registers["Pv"] =3D PredNewSource("P", "v")
> > > > +    new_registers["Os"] =3D VRegNewSource("O", "s")
> > >
> > > AFAICT the keys for registers and new_registers can be derived =
from
> > > the values themselves.  Rather than worry about copy/paste errors
> > > causing these not to correspond, you can create a dictionary from =
an
> iterable like so:
> > >
> > > registers =3D (
> > >     GprDest("R", "d"),
> > >     GprDest("R", "e"),
> > >     GprSource("R", "s"),
> > >     GprSource("R", "t"),
> > > ...
> > > )
> > > registers =3D { reg.regtype + reg.regid for reg in registers }

I couldn't get this to work exactly as you suggest.  Perhaps it is my =
neophyte Python skills, but assigning to registers creates a variable =
local to the function rather than updating the global variable.  So, I =
ended up with this:
ef init_registers():
    regs =3D {
        GprDest("R", "d"),
        GprDest("R", "e"),
        GprSource("R", "s"),
        ...
    }
    for reg in regs:
        registers[f"{reg.regtype}{reg.regid}"] =3D reg

    new_regs =3D {
        GprNewSource("N", "s"),
        GprNewSource("N", "t"),
        ...
    }
    for reg in new_regs:
        new_registers[f"{reg.regtype}{reg.regid}"] =3D reg


Thanks,
Taylor


