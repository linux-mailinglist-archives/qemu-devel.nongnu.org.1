Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CCB82E23B
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 22:39:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPUf1-0004sy-Mr; Mon, 15 Jan 2024 16:38:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rPUez-0004sZ-LD
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 16:38:21 -0500
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rPUex-0004ps-Kn
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 16:38:21 -0500
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3606dd96868so50154385ab.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 13:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705354698; x=1705959498; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=TBEGPYfzZ76rAlhI9HodwYsKO95YiPC9yjC486NcVaA=;
 b=gKtFvTafQcKbHfz8nrFQG2Qqp9o8zTtpS5Mrvv0/F6sXEYfgG+gp95vxw/RAL8OXf+
 XRT76BUoiXlX0jkDdDrirkavlg8GYnjNWAv5dibkKs5oigcmlMWFb8kwLsKnpGVYV3jK
 BGRGYscqJIMPLsKDC85RpClg/okJYK0G/vsmQ7Dta7LTMjrl1X3UHYhySYgPD10RkXhA
 pHd1vtZFk+BwcrEXrQc4c4/TSaYrl7h6GYkOWdbFLEFhzmI6TXShHgZS98O8eR9p2iQK
 cybwIeSqL4BcFxg5nU+kuy2PzEGQs9VyxfcLPC2skpWQKWkN/4/cexUpYDai5C73T0VW
 oUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705354698; x=1705959498;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TBEGPYfzZ76rAlhI9HodwYsKO95YiPC9yjC486NcVaA=;
 b=kFqWmAAS8Gz1imf1r5OIo5g0wWyE4OhFGvLa0V2JAExL1yBtKtr78g7YOce6Z4tlo/
 A3fXcPpzYBGkidIeNMSHcmN0sAn4SJ6FRW8paSii5nGDI/v04sgJRcQLmxceSfxCmUoB
 JOJEBtFdUyTGpd6aQRfd7aDkl5rm/5JoaOWQjyUsp8VskU9C0xBiY5WHtViwiq+Xdfh7
 LGbsKDMlxgv4X3Gxz2jVSnnmoq20a/uF04z9+PphHdDz5x0QLvvQP4FVBFUV6yf/rChU
 kgRgBUSxHonGEJFVSbiYDiiKR3cbTRtHeyFJ1vNFZTcAsoWNTIKNEw1L/U03x3IddwC3
 rPsw==
X-Gm-Message-State: AOJu0YzDQkF0VydgLA18d9EBHZs6Ied0/TNagWi6zrPhGSOpXVRWP3hp
 8bNp+DVDfI6EiV+wWggiUHQ=
X-Google-Smtp-Source: AGHT+IFDm46L/qtUV4jSGOmLHdBtZ0J5i/CV/N3/T6guM6zLztAJHJHLXmSE45gW8GEOaVQUshIW9A==
X-Received: by 2002:a05:6e02:ca3:b0:35f:a962:6e5b with SMTP id
 3-20020a056e020ca300b0035fa9626e5bmr5780202ilg.45.1705354697826; 
 Mon, 15 Jan 2024 13:38:17 -0800 (PST)
Received: from DESKTOPUU50BPD ([2601:284:8201:81c0:87f:15a9:5e7:54a0])
 by smtp.gmail.com with ESMTPSA id
 ck12-20020a056e02370c00b003608a649906sm3107328ilb.43.2024.01.15.13.38.16
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jan 2024 13:38:17 -0800 (PST)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <bcain@quicinc.com>,
	<qemu-devel@nongnu.org>
Cc: "'Matheus Bernardino \(QUIC\)'" <quic_mathbern@quicinc.com>,
 "'Sid Manning'" <sidneym@quicinc.com>,
 "'Marco Liebel \(QUIC\)'" <quic_mliebel@quicinc.com>,
 <richard.henderson@linaro.org>, <philmd@linaro.org>, <ale@rev.ng>,
 <anjo@rev.ng>
References: <20240108224845.285864-1-ltaylorsimpson@gmail.com>
 <20240108224845.285864-2-ltaylorsimpson@gmail.com>
 <SN6PR02MB42058A6598154E0652A2E24FB86C2@SN6PR02MB4205.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB42058A6598154E0652A2E24FB86C2@SN6PR02MB4205.namprd02.prod.outlook.com>
Subject: RE: [PATCH v2 1/3] Hexagon (target/hexagon) Use QEMU decodetree
 (32-bit instructions)
Date: Mon, 15 Jan 2024 14:38:16 -0700
Message-ID: <01aa01da47fb$268bf200$73a3d600$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDlTCeBMPAxHS9+BZe36zwyL9uHfAJpJLCeATp+wWiyqD/08A==
Content-Language: en-us
Received-SPF: pass client-ip=2607:f8b0:4864:20::134;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x134.google.com
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
> Sent: Sunday, January 14, 2024 5:21 PM
> To: Taylor Simpson <ltaylorsimpson@gmail.com>; qemu-devel@nongnu.org
> Cc: Matheus Bernardino (QUIC) <quic_mathbern@quicinc.com>; Sid
> Manning <sidneym@quicinc.com>; Marco Liebel (QUIC)
> <quic_mliebel@quicinc.com>; richard.henderson@linaro.org;
> philmd@linaro.org; ale@rev.ng; anjo@rev.ng
> Subject: RE: [PATCH v2 1/3] Hexagon (target/hexagon) Use QEMU
> decodetree (32-bit instructions)
>=20
>=20
>=20
> > -----Original Message-----
> > From: Taylor Simpson <ltaylorsimpson@gmail.com>
> > Sent: Monday, January 8, 2024 4:49 PM
> > To: qemu-devel@nongnu.org
> > Cc: Brian Cain <bcain@quicinc.com>; Matheus Bernardino (QUIC)
> > <quic_mathbern@quicinc.com>; Sid Manning <sidneym@quicinc.com>;
> Marco
> > Liebel (QUIC) <quic_mliebel@quicinc.com>;
> > richard.henderson@linaro.org; philmd@linaro.org; ale@rev.ng;
> > anjo@rev.ng; ltaylorsimpson@gmail.com
> > Subject: [PATCH v2 1/3] Hexagon (target/hexagon) Use QEMU decodetree
> > (32- bit instructions)
> >
> >
> > The Decodetree Specification can be found here
> > https://www.qemu.org/docs/master/devel/decodetree.html
> >
> > Covers all 32-bit instructions, including HVX
> >
> > We generate separate decoders for each instruction class.  The =
reason
> > will be more apparent in the next patch in this series.
> >
> > We add 2 new scripts
> >     gen_decodetree.py        Generate the input to decodetree.py
> >     gen_trans_funcs.py       Generate the trans_* functions used by =
the
> >                              output of decodetree.py
> >
> > Since the functions generated by decodetree.py take DisasContext * =
as
> > an argument, we add the argument to a couple of functions that =
didn't
> > need it previously.  We also set the insn field in DisasContext =
during
> > decode because it is used by the trans_* functions.
> >
> > There is a g_assert_not_reached() in decode_insns() in decode.c to
> > verify we never try to use the old decoder on 32-bit instructions
> >
> > Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> > ---
> >  target/hexagon/decode.h           |   5 +-
> >  target/hexagon/decode.c           |  54 ++++++++-
> >  target/hexagon/translate.c        |   4 +-
> >  target/hexagon/README             |  13 +-
> >  target/hexagon/gen_decodetree.py  | 193
> > ++++++++++++++++++++++++++++++
> target/hexagon/gen_trans_funcs.py | 132 ++++++++++++++++++++
> >  target/hexagon/meson.build        |  55 +++++++++
> >  7 files changed, 442 insertions(+), 14 deletions(-)  create mode
> > 100755 target/hexagon/gen_decodetree.py  create mode 100755
> > target/hexagon/gen_trans_funcs.py
> >
>=20
> LGTM, but some nitpicky suggestions:
>=20
> diff --git a/target/hexagon/gen_decodetree.py
> b/target/hexagon/gen_decodetree.py
> index 2dff975f55..62bd8a62b6 100755
> --- a/target/hexagon/gen_decodetree.py
> +++ b/target/hexagon/gen_decodetree.py
> @@ -57,7 +57,7 @@ def ordered_unique(l):
>      "d",
>      "e",
>      "f",
> -    "g"
> +    "g",
>  }
>=20
>  #
> @@ -104,9 +104,6 @@ def gen_decodetree_file(f, class_to_decode):
>          if skip_tag(tag, class_to_decode):
>              continue
>=20
> -        f.write("########################################")
> -        f.write("########################################\n")
> -
>          enc =3D encs[tag]
>          enc_str =3D "".join(reversed(encs[tag]))
>=20
> @@ -115,21 +112,21 @@ def gen_decodetree_file(f, class_to_decode):
>          if is_subinsn:
>              enc_str =3D "---" + enc_str
>=20
> -        f.write(f"## {tag}:\t{enc_str}\n")
> -        f.write("##\n")
> +        f.write(("#" * 80) + "\n"
> +                f"## {tag}:\t{enc_str}\n"
> +                "##\n")
>=20
>          regs =3D =
ordered_unique(regre.findall(iset.iset[tag]["syntax"]))
>          imms =3D =
ordered_unique(immre.findall(iset.iset[tag]["syntax"]))
>=20
>          # Write the field definitions for the registers
> -        regno =3D 0
> -        for reg in regs:
> -            reg_type =3D reg[0]
> -            reg_id =3D reg[1]
> +        for regno, reg in enumerate(regs):
> +            reg_type, reg_id, _, reg_enc_size =3D reg
>              reg_letter =3D reg_id[0]
> -            reg_num_choices =3D int(reg[3].rstrip("S"))
> -            reg_mapping =3D reg[0] + "".join(["_" for letter in =
reg[1]]) + reg[3]
> +            reg_num_choices =3D int(reg_enc_size.rstrip("S"))
> +            reg_mapping =3D reg_type + "".join("_" for letter in =
reg_id)
> + + reg_enc_size
>              reg_enc_fields =3D re.findall(reg_letter + "+", enc)
> +            print(f'{reg} -> {reg_enc_fields}')
>=20
>              # Check for some errors
>              if len(reg_enc_fields) =3D=3D 0:
> @@ -140,13 +137,12 @@ def gen_decodetree_file(f, class_to_decode):
>              if 2 ** len(reg_enc_field) !=3D reg_num_choices:
>                  raise Exception(f"{tag} has incorrect register field =
width!")
>=20
> -            f.write(f"%{tag}_{reg_type}{reg_id}\t")
> -            =
f.write(f"{enc.index(reg_enc_field)}:{len(reg_enc_field)}")
> +            f.write(f"%{tag}_{reg_type}{reg_id}\t"
> +                    =
f"{enc.index(reg_enc_field)}:{len(reg_enc_field)}")
>              if (reg_type in num_registers and
>                  reg_num_choices !=3D num_registers[reg_type]):
>                  =
f.write(f"\t!function=3Ddecode_mapped_reg_{reg_mapping}")
>              f.write("\n")
> -            regno +=3D 1
>=20
>          # Write the field definitions for the immediates
>          for imm in imms:
> @@ -189,8 +185,7 @@ def gen_decodetree_file(f, class_to_decode):
>          f.write("\n")
>=20
>           # Replace the 0s and 1s with .
> -        for x in { "0", "1" }:
> -            enc_str =3D enc_str.replace(x, ".")
> +        enc_str =3D enc_str.replace("0", ".").replace("1", ".")
>=20
>          # Write the instruction pattern
>          f.write(f"{tag}\t{enc_str} @{tag}\n")
>=20
>=20
> Consider some or all of the above, but regardless --
>=20
> Reviewed-by: Brian Cain <bcain@quicinc.com>

Thanks,
I will make the changes you suggest.

Taylor



