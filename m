Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F39F750813
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 14:22:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJYpc-0002mK-Kl; Wed, 12 Jul 2023 08:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1qJYpa-0002lD-AO
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 08:20:30 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1qJYpY-0002Rm-AP
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 08:20:30 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4fa16c6a85cso10761700e87.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 05:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689164426; x=1691756426;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fuU7PCAIX9UdLStzuZ57VdQenVeNz0CGZgIZn5NbJVs=;
 b=mWwFb1nG6WPO6p5uWLKEDekaN17EqFsj4UsDcTX342qsMdJWIxA2sRQMe2/ERbxGoP
 deFcsAU1VFoTOIaJf8Uav93jklStYeK1dAWX9pGtzjh6p1Ub80yUZfJ52ENWUnmEBJ9F
 MNhFYzNio2yDpk2NG6ypBCswK5s8g++RYpKGQFGnE1jtUAB8fk8fINIzNJF+A94AXxba
 iH7PumOm7Gdd2R6IUHzYKPu5r/QqlUlICgT4HfI75zNiY6xAJ8ahY8KW2/P/ggErSlQN
 C2lgTia92+duNTaZx4TVz/KbOztob0e5vdU7geG5UmUgAEMz+5NF53te7+9UkcZqW2dU
 9tBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689164426; x=1691756426;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fuU7PCAIX9UdLStzuZ57VdQenVeNz0CGZgIZn5NbJVs=;
 b=KnG6fFii1FpEhjJoyFD1mCVABaALr6zN7a9130vo4sRCdhf4+bE/+MLnFC2/hF/ZN8
 jcuAFiuQ1IbTyiWxVqQukI4rJSGLYxlzWAK3kU0U8TBpf93slgRqziRxVIYMveS+us3i
 tYpNRZjijO7K2SlIGCrFrVL/P7ACOjd3Ownb4Uhw4BM+PTJusM76iuzgUc0FEDGgA/+q
 9lOm7zri3mkb8Jf0YaCZOyeY/I6h8/7UeXGOomhC3gynr3T1D5i/EfDDjp7h3gVoMh4e
 gcbFGIKfHbJtPGKjSywJuaQjr/jgcoiDjpSI8NneShFSsFLE1D3r65+pEGXVVKapCd7s
 s8eQ==
X-Gm-Message-State: ABy/qLb7oDj791QZtNXt7N0CleFAFvxAablMC9OkMCFJ7Jpc9Z0KhhIi
 f3b6ua0L/ff+BnihB4saJA32COcNSBzNLC+UIj1owMW3rJCltw==
X-Google-Smtp-Source: APBJJlFCS5PG2oIM+mjgEV7pq2hUeOSxFqQHYvlQHwla4LcZRNlUMR+W+odcp5n+E43Y/r3TSoQ7rLuZcWvgjlGZeQU=
X-Received: by 2002:a05:6512:238f:b0:4fb:c881:be5b with SMTP id
 c15-20020a056512238f00b004fbc881be5bmr18958736lfv.2.1689164425493; Wed, 12
 Jul 2023 05:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230710140249.56324-1-francisco.iglesias@amd.com>
In-Reply-To: <20230710140249.56324-1-francisco.iglesias@amd.com>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 12 Jul 2023 14:20:14 +0200
Message-ID: <CAJy5ezoYVFBhrZFm=vjO6KDeEJFp-ZYLhVLR2Gh=cxSVtDp5KA@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] Xilinx Versal CFI support
To: Francisco Iglesias <francisco.iglesias@amd.com>
Cc: qemu-devel@nongnu.org, frasse.iglesias@gmail.com, alistair@alistair23.me, 
 peter.maydell@linaro.org, fkonrad@amd.com, sai.pavan.boddu@amd.com, 
 tong.ho@amd.com, vikram.garhwal@amd.com
Content-Type: multipart/alternative; boundary="0000000000008c82d00600493d4c"
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000008c82d00600493d4c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2023 at 4:02=E2=80=AFPM Francisco Iglesias <
francisco.iglesias@amd.com> wrote:

> Hi,
>
> This series adds support for the Configuration Frame Unit (CFU) and the
> Configuration Frame controllers (CFRAME) to the Xilinx Versal machine
> ([1], chapter 21) for emulaing bitstream loading and readback.
>
> The series starts by introducing the Xilinx CFI interface that is
> thereafter used by the Xilinx CFU components, the Xilinx CFRAME and Xilin=
x
> CFRAME broadcast models for transfering CFI packets between each other.
> Thereafter a model of the CFU_APB, CFU_FDRO and CFU_SFR are introduced an=
d
> also models of the CFRAME controller and CFRAME broadcast controller.
>
> The series thereafter ends with connecting the models to Xilinx Versal
> machine.
>

I just had a quick look and the series LGTM!
Acked-by: Edgar E. Iglesias <edgar@zeroasic.com>



>
> Best regards,
> Francisco Iglesias
>
> References:
> [1]
> https://docs.xilinx.com/r/en-US/am011-versal-acap-trm/PSM-Local-Registers
>
>
> Francisco Iglesias (8):
>   hw/misc: Introduce the Xilinx CFI interface
>   hw/misc: Introduce a model of Xilinx Versal's CFU_APB
>   hw/misc/xlnx-versal-cfu: Introduce a model of Xilinx Versal CFU_FDRO
>   hw/misc/xlnx-versal-cfu: Introduce a model of Xilinx Versal's CFU_SFR
>   hw/misc: Introduce a model of Xilinx Versal's CFRAME_REG
>   hw/misc: Introduce a model of Xilinx Versal's CFRAME_BCAST_REG
>   hw/arm/xlnx-versal: Connect the CFU_APB, CFU_FDRO and CFU_SFR
>   hw/arm/versal: Connect the CFRAME_REG and CFRAME_BCAST_REG
>
>  MAINTAINERS                              |  10 +
>  hw/arm/xlnx-versal.c                     | 158 +++-
>  hw/misc/meson.build                      |   3 +
>  hw/misc/xlnx-cfi-if.c                    |  34 +
>  hw/misc/xlnx-versal-cframe-reg.c         | 887 +++++++++++++++++++++++
>  hw/misc/xlnx-versal-cfu.c                | 566 +++++++++++++++
>  include/hw/arm/xlnx-versal.h             |  85 +++
>  include/hw/misc/xlnx-cfi-if.h            |  59 ++
>  include/hw/misc/xlnx-versal-cframe-reg.h | 305 ++++++++
>  include/hw/misc/xlnx-versal-cfu.h        | 238 ++++++
>  10 files changed, 2344 insertions(+), 1 deletion(-)
>  create mode 100644 hw/misc/xlnx-cfi-if.c
>  create mode 100644 hw/misc/xlnx-versal-cframe-reg.c
>  create mode 100644 hw/misc/xlnx-versal-cfu.c
>  create mode 100644 include/hw/misc/xlnx-cfi-if.h
>  create mode 100644 include/hw/misc/xlnx-versal-cframe-reg.h
>  create mode 100644 include/hw/misc/xlnx-versal-cfu.h
>
> --
> 2.34.1
>
>

--0000000000008c82d00600493d4c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 10, 2023 at 4:02=E2=80=AF=
PM Francisco Iglesias &lt;<a href=3D"mailto:francisco.iglesias@amd.com">fra=
ncisco.iglesias@amd.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">Hi,<br>
<br>
This series adds support for the Configuration Frame Unit (CFU) and the<br>
Configuration Frame controllers (CFRAME) to the Xilinx Versal machine<br>
([1], chapter 21) for emulaing bitstream loading and readback.<br>
<br>
The series starts by introducing the Xilinx CFI interface that is<br>
thereafter used by the Xilinx CFU components, the Xilinx CFRAME and Xilinx<=
br>
CFRAME broadcast models for transfering CFI packets between each other.<br>
Thereafter a model of the CFU_APB, CFU_FDRO and CFU_SFR are introduced and<=
br>
also models of the CFRAME controller and CFRAME broadcast controller.<br>
<br>
The series thereafter ends with connecting the models to Xilinx Versal<br>
machine.<br></blockquote><div><br></div><div>I just had a quick look and th=
e series LGTM!</div><div>Acked-by: Edgar E. Iglesias &lt;<a href=3D"mailto:=
edgar@zeroasic.com">edgar@zeroasic.com</a>&gt;<br></div><div><br></div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Best regards,<br>
Francisco Iglesias<br>
<br>
References:<br>
[1] <a href=3D"https://docs.xilinx.com/r/en-US/am011-versal-acap-trm/PSM-Lo=
cal-Registers" rel=3D"noreferrer" target=3D"_blank">https://docs.xilinx.com=
/r/en-US/am011-versal-acap-trm/PSM-Local-Registers</a><br>
<br>
<br>
Francisco Iglesias (8):<br>
=C2=A0 hw/misc: Introduce the Xilinx CFI interface<br>
=C2=A0 hw/misc: Introduce a model of Xilinx Versal&#39;s CFU_APB<br>
=C2=A0 hw/misc/xlnx-versal-cfu: Introduce a model of Xilinx Versal CFU_FDRO=
<br>
=C2=A0 hw/misc/xlnx-versal-cfu: Introduce a model of Xilinx Versal&#39;s CF=
U_SFR<br>
=C2=A0 hw/misc: Introduce a model of Xilinx Versal&#39;s CFRAME_REG<br>
=C2=A0 hw/misc: Introduce a model of Xilinx Versal&#39;s CFRAME_BCAST_REG<b=
r>
=C2=A0 hw/arm/xlnx-versal: Connect the CFU_APB, CFU_FDRO and CFU_SFR<br>
=C2=A0 hw/arm/versal: Connect the CFRAME_REG and CFRAME_BCAST_REG<br>
<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 10 +<br>
=C2=A0hw/arm/xlnx-versal.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 158 +++-<br>
=C2=A0hw/misc/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +<br>
=C2=A0hw/misc/xlnx-cfi-if.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 34 +<br>
=C2=A0hw/misc/xlnx-versal-cframe-reg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 8=
87 +++++++++++++++++++++++<br>
=C2=A0hw/misc/xlnx-versal-cfu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 566 +++++++++++++++<br>
=C2=A0include/hw/arm/xlnx-versal.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 85 +++<br>
=C2=A0include/hw/misc/xlnx-cfi-if.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 59 ++<br>
=C2=A0include/hw/misc/xlnx-versal-cframe-reg.h | 305 ++++++++<br>
=C2=A0include/hw/misc/xlnx-versal-cfu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 238 ++=
++++<br>
=C2=A010 files changed, 2344 insertions(+), 1 deletion(-)<br>
=C2=A0create mode 100644 hw/misc/xlnx-cfi-if.c<br>
=C2=A0create mode 100644 hw/misc/xlnx-versal-cframe-reg.c<br>
=C2=A0create mode 100644 hw/misc/xlnx-versal-cfu.c<br>
=C2=A0create mode 100644 include/hw/misc/xlnx-cfi-if.h<br>
=C2=A0create mode 100644 include/hw/misc/xlnx-versal-cframe-reg.h<br>
=C2=A0create mode 100644 include/hw/misc/xlnx-versal-cfu.h<br>
<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--0000000000008c82d00600493d4c--

