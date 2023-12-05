Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B23805AD0
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 18:09:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAYuB-0005Kh-9v; Tue, 05 Dec 2023 12:08:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rAYu8-0005KK-V1
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 12:08:16 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rAYu7-0006pz-7B
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 12:08:16 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6d9a1c13ea6so1402303a34.2
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 09:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701796094; x=1702400894; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=bG3WbB9VwX024FxxhGm6FQB4scfI4yff6HQdiK3q6jc=;
 b=T6dm4rPhp7QiPWCHWeMH32Re/4iLaflxw9dozXXTi/tVVz5t2pkNBVKaEZ2CeOILiG
 DBFlQiS14+1RRILk4XkEpPR+UFT5e/UWvJTPAhBspBeFndvn2NRBwtmT8jTw7w5osAIo
 LOSLqOJec/c5jVnsNttByob8x3Mwh/vWD3h3Gjtr5X6S59DIktdwHH4q9K206tkMfXy0
 UgCldRBJhnFNeXGMoknbDQuiqwgZbKij7DnQ+oO3M0o8fVzv+kcEfpaH0h2ysyRt/YC9
 /6bqKEfpIeE+xYBpIQLzcUwp1aHeADV1xxcT1AUrk8AyWE8phNmieFY7hZ9AKp/A2ZsB
 OSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701796094; x=1702400894;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bG3WbB9VwX024FxxhGm6FQB4scfI4yff6HQdiK3q6jc=;
 b=T876xbVqHeXLcmAP9IRfg5A2/5tyWfHC6DOYE4bLPtfAkZD2PayDxER5mCyxaIp4gg
 PV7QRZ1CQhvwJznC2O9dJR8y/OPyE4eIMObSZH8cnOOAdkG8kQJcpmCkvFD31oBHPYNH
 pASPwBARx8Zxv39lCZrtO6g7riubcLXba2JgGw7sl2UvnZG64wl3kNvBo9KQYpVZTbwX
 4EUvdlvlzYSG6IEzFzBpmqwZGD84Hp10SKIGf9VzgPeTcJ+r9oET8QBQFUU2xT1fMX89
 Zj/cMZ4CJpzKlrS2ekN7F7Jdt22772/066n1YoCYjBBlUVL7/Rroh2EsDImucdmMZATx
 aaMg==
X-Gm-Message-State: AOJu0YwaT150LRYLvQUFquoBufKTWSv5Yx8ectr9N49cGvI4KWFl1i3U
 nPwwjfAiF5xFDMPQ0PA2WII=
X-Google-Smtp-Source: AGHT+IH+nUt6i0FUz8c0UYGXKZ92oDgRXk/ZHx31ycQwe+RHrpupHgREGW4CGoU38KABpAAzrOykVA==
X-Received: by 2002:a9d:6318:0:b0:6b7:4a52:a33a with SMTP id
 q24-20020a9d6318000000b006b74a52a33amr5215330otk.14.1701796093854; 
 Tue, 05 Dec 2023 09:08:13 -0800 (PST)
Received: from DESKTOPUU50BPD
 (2603-8080-1f00-9c00-d1de-fde2-a957-367e.res6.spectrum.com.
 [2603:8080:1f00:9c00:d1de:fde2:a957:367e])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a9d62d1000000b006b9848f8aa7sm2351510otk.45.2023.12.05.09.08.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Dec 2023 09:08:13 -0800 (PST)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <bcain@quicinc.com>,
	<qemu-devel@nongnu.org>
Cc: "'Matheus Bernardino \(QUIC\)'" <quic_mathbern@quicinc.com>,
 "'Sid Manning'" <sidneym@quicinc.com>,
 "'Marco Liebel \(QUIC\)'" <quic_mliebel@quicinc.com>,
 <richard.henderson@linaro.org>, <philmd@linaro.org>, <ale@rev.ng>,
 <anjo@rev.ng>
References: <20231205015303.575807-1-ltaylorsimpson@gmail.com>
 <20231205015303.575807-4-ltaylorsimpson@gmail.com>
 <BN7PR02MB41943B67448AAC160D120ED2B885A@BN7PR02MB4194.namprd02.prod.outlook.com>
In-Reply-To: <BN7PR02MB41943B67448AAC160D120ED2B885A@BN7PR02MB4194.namprd02.prod.outlook.com>
Subject: RE: [PATCH 3/9] Hexagon (target/hexagon) Make generators object
 oriented - gen_helper_protos
Date: Tue, 5 Dec 2023 11:08:11 -0600
Message-ID: <0e5901da279d$a14e8f80$e3ebae80$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGyQ8bIQqyrR/dhEhhm+TVtuipI8AIeKodrArs1AD2ww+Zf8A==
Content-Language: en-us
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-ot1-x336.google.com
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
> Sent: Monday, December 4, 2023 9:46 PM
> To: Taylor Simpson <ltaylorsimpson@gmail.com>; qemu-devel@nongnu.org
> Cc: Matheus Bernardino (QUIC) <quic_mathbern@quicinc.com>; Sid
> Manning <sidneym@quicinc.com>; Marco Liebel (QUIC)
> <quic_mliebel@quicinc.com>; richard.henderson@linaro.org;
> philmd@linaro.org; ale@rev.ng; anjo@rev.ng
> Subject: RE: [PATCH 3/9] Hexagon (target/hexagon) Make generators =
object
> oriented - gen_helper_protos
>=20
>=20
>=20
> > -----Original Message-----
> > From: Taylor Simpson <ltaylorsimpson@gmail.com>
> > Sent: Monday, December 4, 2023 7:53 PM
> > To: qemu-devel@nongnu.org
> > Cc: Brian Cain <bcain@quicinc.com>; Matheus Bernardino (QUIC)
> > <quic_mathbern@quicinc.com>; Sid Manning <sidneym@quicinc.com>;
> Marco
> > Liebel (QUIC) <quic_mliebel@quicinc.com>;
> > richard.henderson@linaro.org; philmd@linaro.org; ale@rev.ng;
> > anjo@rev.ng; ltaylorsimpson@gmail.com
> > Subject: [PATCH 3/9] Hexagon (target/hexagon) Make generators object
> > oriented - gen_helper_protos
> >
> > Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> > ---
> >  target/hexagon/gen_helper_protos.py | 184 =
++++++++--------------------
> >  target/hexagon/hex_common.py        |  15 +--
> >  2 files changed, 55 insertions(+), 144 deletions(-)
> >
> > diff --git a/target/hexagon/gen_helper_protos.py
> > b/target/hexagon/gen_helper_protos.py
> > index 131043795a..9277199e1d 100755
> > --- a/target/hexagon/gen_helper_protos.py
> > +++ b/target/hexagon/gen_helper_protos.py
> >  ##
> >  ## Generate the DEF_HELPER prototype for an instruction
> >  ##     For A2_add: Rd32=3Dadd(Rs32,Rt32)
> > @@ -65,116 +32,62 @@ def gen_helper_prototype(f, tag, tagregs,
> tagimms):
> >      regs =3D tagregs[tag]
> >      imms =3D tagimms[tag]
> >
> > -    numresults =3D 0
> > +    ## If there is a scalar result, it is the return type
> > +    return_type =3D ""
>=20
> Should we use `return_type =3D None` here?
>=20
> >      numscalarresults =3D 0
> > -    numscalarreadwrite =3D 0
> >      for regtype, regid in regs:
> > -        if hex_common.is_written(regid):
> > -            numresults +=3D 1
> > -            if hex_common.is_scalar_reg(regtype):
> > +        reg =3D hex_common.get_register(tag, regtype, regid)
> > +        if reg.is_written() and reg.is_scalar_reg():
> > +                return_type =3D reg.helper_proto_type()
> >                  numscalarresults +=3D 1
> > -        if hex_common.is_readwrite(regid):
> > -            if hex_common.is_scalar_reg(regtype):
> > -                numscalarreadwrite +=3D 1
> > +    if numscalarresults =3D=3D 0:
> > +        return_type =3D "void"
>=20
> Should we use `return_type =3D None` here?

I don't see a point of setting it to None.  By the time it gets to the =
use below, it will definitely have a value.  We could initialize it to =
void instead of "" and skip this check.


> > +
> > +    ## Other stuff the helper might need
> > +    if hex_common.need_pkt_has_multi_cof(tag):
> > +        declared.append("i32")
> > +    if hex_common.need_pkt_need_commit(tag):
> > +        declared.append("i32")
> > +    if hex_common.need_PC(tag):
> > +        declared.append("i32")
> > +    if hex_common.need_next_PC(tag):
> > +        declared.append("i32")
> > +    if hex_common.need_slot(tag):
> > +        declared.append("i32")
> > +    if hex_common.need_part1(tag):
> > +        declared.append("i32")
>=20
> What do you think of this instead?  The delta below is on top of this =
patch.
>=20
> --- a/target/hexagon/gen_helper_protos.py
> +++ b/target/hexagon/gen_helper_protos.py
> @@ -73,18 +73,9 @@ def gen_helper_prototype(f, tag, tagregs, tagimms):
>          declared.append("s32")
>=20
>      ## Other stuff the helper might need
> -    if hex_common.need_pkt_has_multi_cof(tag):
> -        declared.append("i32")
> -    if hex_common.need_pkt_need_commit(tag):
> -        declared.append("i32")
> -    if hex_common.need_PC(tag):
> -        declared.append("i32")
> -    if hex_common.need_next_PC(tag):
> -        declared.append("i32")
> -    if hex_common.need_slot(tag):
> -        declared.append("i32")
> -    if hex_common.need_part1(tag):
> -        declared.append("i32")
> +    for stuff in hex_common.other_stuff:
> +        if stuff(tag):
> +            declared.append('i32')
>=20
>      arguments =3D ", ".join(declared)
>      f.write(f"DEF_HELPER_{len(declared) - 1}({tag}, {arguments})\n") =
diff --git
> a/target/hexagon/gen_tcg_funcs.py b/target/hexagon/gen_tcg_funcs.py
> index 8c2bc03c10..cb02d91886 100755
> --- a/target/hexagon/gen_tcg_funcs.py
> +++ b/target/hexagon/gen_tcg_funcs.py
> @@ -109,18 +109,9 @@ def gen_tcg_func(f, tag, regs, imms):
>=20
> declared.append(f"tcg_constant_tl({hex_common.imm_name(immlett)})")
>=20
>          ## Other stuff the helper might need
> -        if hex_common.need_pkt_has_multi_cof(tag):
> -            =
declared.append("tcg_constant_tl(ctx->pkt->pkt_has_multi_cof)")
> -        if hex_common.need_pkt_need_commit(tag):
> -            declared.append("tcg_constant_tl(ctx->need_commit)")
> -        if hex_common.need_PC(tag):
> -            declared.append("tcg_constant_tl(ctx->pkt->pc)")
> -        if hex_common.need_next_PC(tag):
> -            declared.append("tcg_constant_tl(ctx->next_PC)")
> -        if hex_common.need_slot(tag):
> -            declared.append("gen_slotval(ctx)")
> -        if hex_common.need_part1(tag):
> -            declared.append("tcg_constant_tl(insn->part1)")
> +        for stuff, text in hex_common.other_stuff:
> +            if stuff(tag):
> +                declared.append(text)
>=20
>          arguments =3D ", ".join(declared)
>          f.write(f"    gen_helper_{tag}({arguments});\n")
> diff --git a/target/hexagon/hex_common.py
> b/target/hexagon/hex_common.py index 90d61a1b16..954532921d 100755
> --- a/target/hexagon/hex_common.py
> +++ b/target/hexagon/hex_common.py
> @@ -1028,3 +1028,13 @@ def get_register(tag, regtype, regid):
>          return registers[f"{regtype}{regid}"]
>      else:
>          return new_registers[f"{regtype}{regid}"]
> +
> +
> +other_stuff =3D {
> +    need_pkt_has_multi_cof: "tcg_constant_tl(ctx->pkt-
> >pkt_has_multi_cof)",
> +    need_pkt_need_commit: "tcg_constant_tl(ctx->need_commit)",
> +    need_PC: "tcg_constant_tl(ctx->pkt->pc)",
> +    need_next_PC: "tcg_constant_tl(ctx->next_PC)",
> +    need_slot: "gen_slotval(ctx)",
> +    need_part1: "tcg_constant_tl(insn->part1)", }

Great idea to centralize these in hex_common.  There are three parts =
though.  There's the actual helper argument in gen_hepler_funcs.py.  =
I'll think about how best to cover the 3 parts.  Let me know if you have =
ideas as well.

Thanks,
Taylor




