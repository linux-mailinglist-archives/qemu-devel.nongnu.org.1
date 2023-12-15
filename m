Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE2381412C
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 06:20:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE0av-0005Yd-5h; Fri, 15 Dec 2023 00:18:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rE0at-0005YQ-7Y; Fri, 15 Dec 2023 00:18:39 -0500
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rE0ao-0003jp-3F; Fri, 15 Dec 2023 00:18:38 -0500
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-7cad628ad93so102837241.3; 
 Thu, 14 Dec 2023 21:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702617512; x=1703222312; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XKY/O6KVcNCcF3H3XlB8EWP64PWrdzQ/7w2G0UUtLf4=;
 b=QIPDfvRQxcCj6/V1RwgYfxXVoDigH8WtCHCPJON8+ZWeEnJzyN/YMuryqUGsIdnWdZ
 yPM+bVfrSF6lC/oLgZFkudgjlLUj4iH/hzFkfyhEspFRDyo4oKhDCLtQ7i4SfuKmaShP
 2Gtf4KKW6fdwW/YmA4F7HkyIbTqIsFtqE1YJtjGcoqs5NfUSiJ+14hv8oAp8RF/nw4XN
 CL6O7WtOp/sG6DIZDMwgf3AA93WdhtpUvkI6G63DYeIL79u9U8mAeLCclZyBkR+cx3OG
 Dk+v3zkDV63G6EZhCeb88gB/Ti2oVtbbo8ffy/pGmtMFzVSacrFMD/uHQWrfXTq3XC5h
 6LNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702617512; x=1703222312;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XKY/O6KVcNCcF3H3XlB8EWP64PWrdzQ/7w2G0UUtLf4=;
 b=frNFomWZLuBmg6gspZkeO0VDQ1wWfGE7oHRBr/JgQ/h/BUDkU19hNERgYVkVZ6JvMC
 F27bKI6Zfa0QUFc3qhJivqVAM+PKnOcwsh0Swb6qnP601IZfwkOKL1/lsoPXFUAOj792
 nvzxoGzA4fXZCPM4djgKwtgeh6FSqCCWZPM/fXSkvEp6oyIPBFbiKOOooOpJvyHprxfR
 GUbfJh9ceE9GzgTCLI8xsRj722GlUrV1pygZgzrfzopsi2p5JbXDVCIuNLf7QbD8gFv/
 h6Zn7ezfBWwLaLG1jD6/DhqeoyO5udlyaVvQA/vQuciuw6IU51F4pDdFOb0IIpmzA93I
 equg==
X-Gm-Message-State: AOJu0Yz1bAXw1HdqUZAQI//s7iaNKS3teddQ673QNzQl+11bWyfcVWHZ
 CwD/sO0qVufy04J9uEeHCRqbkqzA5LX0l6h8SHw=
X-Google-Smtp-Source: AGHT+IFsDDcvUxOE1pQbBqft7IrnydqmNGIvlqnp7T4en2zxpAtlADXKSchkuZruxTOiqUMOrmJ0b47EXNjk00OBUnQ=
X-Received: by 2002:a67:c091:0:b0:460:7b72:894f with SMTP id
 x17-20020a67c091000000b004607b72894fmr7966806vsi.33.1702617512053; Thu, 14
 Dec 2023 21:18:32 -0800 (PST)
MIME-Version: 1.0
References: <170100975340.4879.5844108484092111139-0@git.sr.ht>
 <170100975340.4879.5844108484092111139-1@git.sr.ht>
 <CAKmqyKM+usN_VwrwCE68yt9nKT-LZoPw2Xgg_sV_5kw38rwjjw@mail.gmail.com>
 <87r0jzz5ai.fsf@draig.linaro.org>
In-Reply-To: <87r0jzz5ai.fsf@draig.linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 15 Dec 2023 15:18:05 +1000
Message-ID: <CAKmqyKNEehbEgPXN-c1Bf=aB=974muigx_=yu3=tkijGfHb4+A@mail.gmail.com>
Subject: Re: [PATCH qemu 1/2] hw/arm: Add minimal support for the STM32L4x5 SoC
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: "~inesvarhol" <inesvarhol@proton.me>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, 
 alistair@alistair23.me, philmd@linaro.org, peter.maydell@linaro.org, 
 ines.varhol@telecom-paris.fr, arnaud.minier@telecom-paris.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x932.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Dec 7, 2023 at 2:04=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:
>
> Alistair Francis <alistair23@gmail.com> writes:
>
> > On Mon, Nov 27, 2023 at 12:44=E2=80=AFAM ~inesvarhol <inesvarhol@git.sr=
.ht> wrote:
> >>
> >> From: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> >>
> >> This patch adds a new STM32L4x5 SoC, it is necessary to add support fo=
r
> >> the B-L475E-IOT01A board.
> >> The implementation is derived from the STM32F405 SoC.
> >> The implementation contains no peripherals, only memory regions are
> >> implemented.
> >>
> >> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >>
> >> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> >> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> >> ---
> >>  MAINTAINERS                    |   8 +
> >>  hw/arm/Kconfig                 |   5 +
> >>  hw/arm/meson.build             |   1 +
> >>  hw/arm/stm32l4x5_soc.c         | 277 ++++++++++++++++++++++++++++++++=
+
> >>  include/hw/arm/stm32l4x5_soc.h |  68 ++++++++
> >>  5 files changed, 359 insertions(+)
> >>  create mode 100644 hw/arm/stm32l4x5_soc.c
> >>  create mode 100644 include/hw/arm/stm32l4x5_soc.h
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index ff1238bb98..32458d41dd 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -1122,6 +1122,14 @@ L: qemu-arm@nongnu.org
> >>  S: Maintained
> >>  F: hw/arm/olimex-stm32-h405.c
> >>
> >> +STM32L4x5 SoC Family
> >> +M: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> >> +M: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> >> +L: qemu-arm@nongnu.org
> >> +S: Maintained
> >> +F: hw/arm/stm32l4x5_soc.c
> >> +F: include/hw/arm/stm32l4x5_soc.h
> >> +
> >>  SmartFusion2
> >>  M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> >>  M: Peter Maydell <peter.maydell@linaro.org>
> >> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> >> index 3ada335a24..d2b94d9a47 100644
> >> --- a/hw/arm/Kconfig
> >> +++ b/hw/arm/Kconfig
> >> @@ -448,6 +448,11 @@ config STM32F405_SOC
> >>      select STM32F4XX_SYSCFG
> >>      select STM32F4XX_EXTI
> >>
> >> +config STM32L4X5_SOC
> >> +    bool
> >> +    select ARM_V7M
> >> +    select OR_IRQ
> >> +
> >>  config XLNX_ZYNQMP_ARM
> >>      bool
> >>      default y if PIXMAN
> >> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> >> index 68245d3ad1..9766da10c4 100644
> >> --- a/hw/arm/meson.build
> >> +++ b/hw/arm/meson.build
> >> @@ -42,6 +42,7 @@ arm_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm=
2836.c', 'raspi.c'))
> >>  arm_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f100_so=
c.c'))
> >>  arm_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_so=
c.c'))
> >>  arm_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: files('stm32f405_so=
c.c'))
> >> +arm_ss.add(when: 'CONFIG_STM32L4X5_SOC', if_true: files('stm32l4x5_so=
c.c'))
> >>  arm_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zynqm=
p.c', 'xlnx-zcu102.c'))
> >>  arm_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal.c'=
, 'xlnx-versal-virt.c'))
> >>  arm_ss.add(when: 'CONFIG_FSL_IMX25', if_true: files('fsl-imx25.c', 'i=
mx25_pdk.c'))
> >> diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
> >> new file mode 100644
> >> index 0000000000..f476878b2c
> >> --- /dev/null
> >> +++ b/hw/arm/stm32l4x5_soc.c
> >> @@ -0,0 +1,277 @@
> >> +/*
> >> + * STM32L4x5 SoC family
> >> + *
> >> + * SPDX-License-Identifier: MIT
> >
> > I'm pretty sure this must be GPL to be accepted
>
> Does it? A quick grep of the code shows we have quite a lot of hw
> emulation files that are MIT licensed. Although IANAL MIT is very
> permissive and easily combined with GPL as long at the final product is
> under GPL.

Ah interesting. I just assumed everything had to be GPL

Nevermind then!

Alistair

>
> I think there is some LGPL code about for TCG but I'm not sure how well
> tagged that is.
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro

