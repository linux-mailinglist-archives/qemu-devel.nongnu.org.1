Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD0B806281
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 00:01:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAeOZ-00019K-59; Tue, 05 Dec 2023 18:00:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rAeOX-00018F-09
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 18:00:01 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rAeOV-0003vZ-2D
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 18:00:00 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6d8750719b6so2801558a34.1
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 14:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701817197; x=1702421997; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=tmkiRFLdTca3bwPUoPSsY8LTNTo1W/9rmKM9C35NFmQ=;
 b=BAkYIgE9yOrNjHBF4+tzEHeqg5iGkRDwaGKiO3zM6eVaE59QvhcOpUkO1H76zKD0sD
 gcFRh9xzm/F+EeBbrWJ9/iAwQAEs+Xk56Xe3nr0zOtX02TvzfZzqQr1fSaz6/wV9MSq9
 nj0wKE7gcoGN0Px7WFgYA66vl5EQ0MDYznSfKQUyoqPCRQ7gpgGNtEMTAz4QdwVlBy+p
 jNmPXPg/Yee+5zSxOoniI+hpa4yBmvs/s4rTvzVbYqyzVqW7oBY6m0m78BLHT81wV1cm
 osFJy45TU2i1uYtPDTRpcbsnr729jkXsVx8UTrSohhnXAImusV6gKR8YyAQexH+V5BIQ
 Womw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701817197; x=1702421997;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tmkiRFLdTca3bwPUoPSsY8LTNTo1W/9rmKM9C35NFmQ=;
 b=XKaPoi/315OTQqC+WFwXeUpvby9iT1tl8Gs9dsMsOWekGH5T/P9MOd/sAyrs4uGZlF
 7okvtj9Z9W+M1+oYtXf5VVyjMDwqbq0HIhxHJfglBrfUsOvXI8hsxQRXNY8UQ1gRhYfm
 iqCoe55HCvbM1pO5p7mULRDLJxyKktE56lEKjCU09GoNNPXGNfglu9UR5oR25uuAvuw+
 QYKCBdHc8fyqHW04pI8EAnGLbxKxISQacklz1lGAoCmKO/qMpWu07kZt00CjThqm1eaD
 zBaicKUZVtcV6WUt0dHO7VLGOO5kstmfy9f0hxV85nZ1+4lmy07By9LIkecxdc4OEvR4
 /Z9g==
X-Gm-Message-State: AOJu0Yx82Mp5boBmYwoRUoaD6hwja6BBeiHIGxFWm/67U/LW4NzuF5ev
 G4abQhnZ1ZGG4HwDfcaRbqQ=
X-Google-Smtp-Source: AGHT+IGTY7bQwbXiO9PknMjEjC0k40B9eqGnq+8EkPiS3sxjxwZieUPB/3dJ0ojyT4wVHHR2CN8yYA==
X-Received: by 2002:a9d:77c9:0:b0:6d8:74e2:b00a with SMTP id
 w9-20020a9d77c9000000b006d874e2b00amr25329otl.72.1701817197503; 
 Tue, 05 Dec 2023 14:59:57 -0800 (PST)
Received: from DESKTOPUU50BPD
 (2603-8080-1f00-9c00-d1de-fde2-a957-367e.res6.spectrum.com.
 [2603:8080:1f00:9c00:d1de:fde2:a957:367e])
 by smtp.gmail.com with ESMTPSA id
 v3-20020a9d69c3000000b006c4727812fdsm2363830oto.15.2023.12.05.14.59.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Dec 2023 14:59:56 -0800 (PST)
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
 <0e5901da279d$a14e8f80$e3ebae80$@gmail.com>
In-Reply-To: <0e5901da279d$a14e8f80$e3ebae80$@gmail.com>
Subject: RE: [PATCH 3/9] Hexagon (target/hexagon) Make generators object
 oriented - gen_helper_protos
Date: Tue, 5 Dec 2023 16:59:55 -0600
Message-ID: <0f2601da27ce$c41556d0$4c400470$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGyQ8bIQqyrR/dhEhhm+TVtuipI8AIeKodrArs1AD0B6TiYKLC09lBA
Content-Language: en-us
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-ot1-x331.google.com
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
> From: ltaylorsimpson@gmail.com <ltaylorsimpson@gmail.com>
> Sent: Tuesday, December 5, 2023 11:08 AM
> To: 'Brian Cain' <bcain@quicinc.com>; qemu-devel@nongnu.org
> Cc: 'Matheus Bernardino (QUIC)' <quic_mathbern@quicinc.com>; 'Sid
> Manning' <sidneym@quicinc.com>; 'Marco Liebel (QUIC)'
> <quic_mliebel@quicinc.com>; richard.henderson@linaro.org;
> philmd@linaro.org; ale@rev.ng; anjo@rev.ng
> Subject: RE: [PATCH 3/9] Hexagon (target/hexagon) Make generators =
object
> oriented - gen_helper_protos
>=20
>=20
>=20
> > -----Original Message-----
> > From: Brian Cain <bcain@quicinc.com>
> > Sent: Monday, December 4, 2023 9:46 PM
> > To: Taylor Simpson <ltaylorsimpson@gmail.com>; qemu-
> devel@nongnu.org
> > Cc: Matheus Bernardino (QUIC) <quic_mathbern@quicinc.com>; Sid
> Manning
> > <sidneym@quicinc.com>; Marco Liebel (QUIC)
> <quic_mliebel@quicinc.com>;
> > richard.henderson@linaro.org; philmd@linaro.org; ale@rev.ng;
> > anjo@rev.ng
> > Subject: RE: [PATCH 3/9] Hexagon (target/hexagon) Make generators
> > object oriented - gen_helper_protos
> >
> >
> >
> > > -----Original Message-----
> > > From: Taylor Simpson <ltaylorsimpson@gmail.com>
> > > Sent: Monday, December 4, 2023 7:53 PM
> > > To: qemu-devel@nongnu.org
> > > Cc: Brian Cain <bcain@quicinc.com>; Matheus Bernardino (QUIC)
> > > <quic_mathbern@quicinc.com>; Sid Manning <sidneym@quicinc.com>;
> > Marco
> > > Liebel (QUIC) <quic_mliebel@quicinc.com>;
> > > richard.henderson@linaro.org; philmd@linaro.org; ale@rev.ng;
> > > anjo@rev.ng; ltaylorsimpson@gmail.com
> > > Subject: [PATCH 3/9] Hexagon (target/hexagon) Make generators =
object
> > > oriented - gen_helper_protos
> > >
> > > Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> > > ---
> > >  target/hexagon/gen_helper_protos.py | 184 =
++++++++--------------------
> > >  target/hexagon/hex_common.py        |  15 +--
> > >  2 files changed, 55 insertions(+), 144 deletions(-)
> > >
> > > diff --git a/target/hexagon/gen_helper_protos.py
> > > b/target/hexagon/gen_helper_protos.py
> > > index 131043795a..9277199e1d 100755
> > > --- a/target/hexagon/gen_helper_protos.py
> > > +++ b/target/hexagon/gen_helper_protos.py
> > >  ##
> > >  ## Generate the DEF_HELPER prototype for an instruction
> > >  ##     For A2_add: Rd32=3Dadd(Rs32,Rt32)
> > > @@ -65,116 +32,62 @@ def gen_helper_prototype(f, tag, tagregs,
> > tagimms):
> > >      regs =3D tagregs[tag]
> > >      imms =3D tagimms[tag]
> > >
> > > -    numresults =3D 0
> > > +    ## If there is a scalar result, it is the return type
> > > +    return_type =3D ""
> >
> > Should we use `return_type =3D None` here?
> >
> > >      numscalarresults =3D 0
> > > -    numscalarreadwrite =3D 0
> > >      for regtype, regid in regs:
> > > -        if hex_common.is_written(regid):
> > > -            numresults +=3D 1
> > > -            if hex_common.is_scalar_reg(regtype):
> > > +        reg =3D hex_common.get_register(tag, regtype, regid)
> > > +        if reg.is_written() and reg.is_scalar_reg():
> > > +                return_type =3D reg.helper_proto_type()
> > >                  numscalarresults +=3D 1
> > > -        if hex_common.is_readwrite(regid):
> > > -            if hex_common.is_scalar_reg(regtype):
> > > -                numscalarreadwrite +=3D 1
> > > +    if numscalarresults =3D=3D 0:
> > > +        return_type =3D "void"
> >
> > Should we use `return_type =3D None` here?
>=20
> I don't see a point of setting it to None.  By the time it gets to the =
use below,
> it will definitely have a value.  We could initialize it to void =
instead of "" and
> skip this check.
>=20
>=20
> > > +
> > > +    ## Other stuff the helper might need
> > > +    if hex_common.need_pkt_has_multi_cof(tag):
> > > +        declared.append("i32")
> > > +    if hex_common.need_pkt_need_commit(tag):
> > > +        declared.append("i32")
> > > +    if hex_common.need_PC(tag):
> > > +        declared.append("i32")
> > > +    if hex_common.need_next_PC(tag):
> > > +        declared.append("i32")
> > > +    if hex_common.need_slot(tag):
> > > +        declared.append("i32")
> > > +    if hex_common.need_part1(tag):
> > > +        declared.append("i32")
> >
> > What do you think of this instead?  The delta below is on top of =
this patch.
> >
> > --- a/target/hexagon/gen_helper_protos.py
> > +++ b/target/hexagon/gen_helper_protos.py
> > @@ -73,18 +73,9 @@ def gen_helper_prototype(f, tag, tagregs, =
tagimms):
> >          declared.append("s32")
> >
> >      ## Other stuff the helper might need
> > -    if hex_common.need_pkt_has_multi_cof(tag):
> > -        declared.append("i32")
> > -    if hex_common.need_pkt_need_commit(tag):
> > -        declared.append("i32")
> > -    if hex_common.need_PC(tag):
> > -        declared.append("i32")
> > -    if hex_common.need_next_PC(tag):
> > -        declared.append("i32")
> > -    if hex_common.need_slot(tag):
> > -        declared.append("i32")
> > -    if hex_common.need_part1(tag):
> > -        declared.append("i32")
> > +    for stuff in hex_common.other_stuff:
> > +        if stuff(tag):
> > +            declared.append('i32')
> >
> >      arguments =3D ", ".join(declared)
> >      f.write(f"DEF_HELPER_{len(declared) - 1}({tag}, =
{arguments})\n")
> > diff --git a/target/hexagon/gen_tcg_funcs.py
> > b/target/hexagon/gen_tcg_funcs.py index 8c2bc03c10..cb02d91886 =
100755
> > --- a/target/hexagon/gen_tcg_funcs.py
> > +++ b/target/hexagon/gen_tcg_funcs.py
> > @@ -109,18 +109,9 @@ def gen_tcg_func(f, tag, regs, imms):
> >
> >
> declared.append(f"tcg_constant_tl({hex_common.imm_name(immlett)})")
> >
> >          ## Other stuff the helper might need
> > -        if hex_common.need_pkt_has_multi_cof(tag):
> > -            =
declared.append("tcg_constant_tl(ctx->pkt->pkt_has_multi_cof)")
> > -        if hex_common.need_pkt_need_commit(tag):
> > -            declared.append("tcg_constant_tl(ctx->need_commit)")
> > -        if hex_common.need_PC(tag):
> > -            declared.append("tcg_constant_tl(ctx->pkt->pc)")
> > -        if hex_common.need_next_PC(tag):
> > -            declared.append("tcg_constant_tl(ctx->next_PC)")
> > -        if hex_common.need_slot(tag):
> > -            declared.append("gen_slotval(ctx)")
> > -        if hex_common.need_part1(tag):
> > -            declared.append("tcg_constant_tl(insn->part1)")
> > +        for stuff, text in hex_common.other_stuff:
> > +            if stuff(tag):
> > +                declared.append(text)
> >
> >          arguments =3D ", ".join(declared)
> >          f.write(f"    gen_helper_{tag}({arguments});\n")
> > diff --git a/target/hexagon/hex_common.py
> > b/target/hexagon/hex_common.py index 90d61a1b16..954532921d 100755
> > --- a/target/hexagon/hex_common.py
> > +++ b/target/hexagon/hex_common.py
> > @@ -1028,3 +1028,13 @@ def get_register(tag, regtype, regid):
> >          return registers[f"{regtype}{regid}"]
> >      else:
> >          return new_registers[f"{regtype}{regid}"]
> > +
> > +
> > +other_stuff =3D {
> > +    need_pkt_has_multi_cof: "tcg_constant_tl(ctx->pkt-
> > >pkt_has_multi_cof)",
> > +    need_pkt_need_commit: "tcg_constant_tl(ctx->need_commit)",
> > +    need_PC: "tcg_constant_tl(ctx->pkt->pc)",
> > +    need_next_PC: "tcg_constant_tl(ctx->next_PC)",
> > +    need_slot: "gen_slotval(ctx)",
> > +    need_part1: "tcg_constant_tl(insn->part1)", }
>=20
> Great idea to centralize these in hex_common.  There are three parts
> though.  There's the actual helper argument in gen_hepler_funcs.py.  =
I'll
> think about how best to cover the 3 parts.  Let me know if you have =
ideas as
> well.
>=20
> Thanks,
> Taylor

How about this?

In hex_common.py
class HelperArg:
    def __init__(self, proto_arg, call_arg, func_arg):
        self.proto_arg =3D proto_arg
        self.call_arg =3D call_arg
        self.func_arg =3D func_arg

def extra_helper_args(tag):
    args =3D []
    if need_pkt_has_multi_cof(tag):
        args.append(HelperArg(
            "i32",
            "tcg_constant_tl(ctx->pkt->pkt_has_multi_cof)",
            "uint32_t pkt_has_multi_cof"
        ))
    if need_pkt_need_commit(tag):
        args.append(HelperArg(
            "i32",
            "tcg_constant_tl(ctx->need_commit)",
            "uint32_t pkt_need_commit"
        ))
    ...
    return args

In gen_tcg_funcs.py
        for extra_arg in hex_common.extra_helper_args(tag):
            declared.append(extra_arg.call_arg)

In gen_helper_protos.py
    for extra_arg in hex_common.extra_helper_args(tag):
        declared.append(extra_arg.proto_arg)

In gen_helper_funcs.py
    for extra_arg in hex_common.extra_helper_args(tag):
        declared.append(extra_arg.func_arg)

A further refinement would be to have all the registers and immediates =
create a HelperArg.  Then, we could consolidate the logic to create the =
argument lists in hex_common.py.  For example, we pass the destination =
register as an input to the helper for predicated instructions, and the =
pointer to the destination for HVX.

Thanks,
Taylor



