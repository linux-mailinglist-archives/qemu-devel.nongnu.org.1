Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59255807483
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 17:05:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAuNf-0004K8-5W; Wed, 06 Dec 2023 11:04:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAuNd-0004Js-Uh
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 11:04:09 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAuNc-00061I-7w
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 11:04:09 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40c19f5f822so4839735e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 08:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701878646; x=1702483446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VpujQ0DdDu5LXYWtyO5F4pn9sN4LBulnL+9KyD6czsE=;
 b=j0vRBeqKS+Zu22IQUxWB+9wDQUH+wwtAefUCGf5iksCezEJQ+VOlPzMNajn+FmnwFl
 wN5K+XvlpBedTLEed6NXhgjPPg7xzBqD2Wx/Bmwr79gq1dH2cqrG7eCfGUo8Qh9Q7E3D
 mMsvP1rrsnQsdg2HQNjbQeSXUy8OzTWAHrkaEm1uTByyaLHHfZQ3dj+/yir48vKq6Ywk
 2isGGxbBoobvsmKC2SZMydZrbS6DCufvv06bzDvWQcBjHLcp4EpRjFCLiGySvpM5prPf
 uFE5xJcYJ8q2qQKP/qVC+5Qh2JYugiSBXMi1KF+K88cW/0ZIud5NwtlcopP1M8SZuKhZ
 LexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701878646; x=1702483446;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VpujQ0DdDu5LXYWtyO5F4pn9sN4LBulnL+9KyD6czsE=;
 b=n95/r1DlBvFiJNH92XH4KriG27LAkRegu3vrkoH5aSq/0DbK0kIvv9bWLlag/KDJuC
 k5QQQZrU1dY/5yx0nJOydVHI/UTP07y1KWi/uz3UpaoPzbQ5sB4eAC4kFv5nRKjGKlHT
 tY+6Q3byqzQuwzZjQfFzyWWQnDWaUIJzSuGsosGW0PJodR9dAfn/HdC+Ox+O94EbD6EE
 /qUa9aXdVP/gBCKKdhdwkq/Gs9BWWbMfy2i0gaX4Mga9IS8hLV29rUMG84z/Kt9/GRkH
 mSeGOp09alyDGqFwnbS/O6xbcYO2ZN/k0qSSbjoZI2gfWJIw5WgT6akWyXo5f/MXmcO5
 zfsQ==
X-Gm-Message-State: AOJu0YxoHzHV4SFN46WbMx0GtmiftVo7TWFhDmUiLoCr8S//F1YSbo1d
 +CVmkv0niNFaPPp9JH+u30cYGw==
X-Google-Smtp-Source: AGHT+IEMjW9koY71XU6XxiRegKGAEHFWJmIo9V9Vew8uSpNxXUk9rwXpKFIo1PO4HaSf5zxJ0+Zu9Q==
X-Received: by 2002:a05:600c:2a4a:b0:40c:24af:1fc6 with SMTP id
 x10-20020a05600c2a4a00b0040c24af1fc6mr361291wme.107.1701878646554; 
 Wed, 06 Dec 2023 08:04:06 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 he15-20020a05600c540f00b0040c25abd724sm135244wmb.9.2023.12.06.08.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Dec 2023 08:04:06 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D563C5FBC6;
 Wed,  6 Dec 2023 16:04:05 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alistair Francis <alistair23@gmail.com>
Cc: "~inesvarhol" <inesvarhol@proton.me>,  qemu-devel@nongnu.org,
 qemu-arm@nongnu.org,  alistair@alistair23.me,  philmd@linaro.org,
 peter.maydell@linaro.org,  ines.varhol@telecom-paris.fr,
 arnaud.minier@telecom-paris.fr
Subject: Re: [PATCH qemu 1/2] hw/arm: Add minimal support for the STM32L4x5 SoC
In-Reply-To: <CAKmqyKM+usN_VwrwCE68yt9nKT-LZoPw2Xgg_sV_5kw38rwjjw@mail.gmail.com>
 (Alistair Francis's message of "Wed, 6 Dec 2023 11:18:35 +1000")
References: <170100975340.4879.5844108484092111139-0@git.sr.ht>
 <170100975340.4879.5844108484092111139-1@git.sr.ht>
 <CAKmqyKM+usN_VwrwCE68yt9nKT-LZoPw2Xgg_sV_5kw38rwjjw@mail.gmail.com>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Wed, 06 Dec 2023 16:04:05 +0000
Message-ID: <87r0jzz5ai.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Alistair Francis <alistair23@gmail.com> writes:

> On Mon, Nov 27, 2023 at 12:44=E2=80=AFAM ~inesvarhol <inesvarhol@git.sr.h=
t> wrote:
>>
>> From: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
>>
>> This patch adds a new STM32L4x5 SoC, it is necessary to add support for
>> the B-L475E-IOT01A board.
>> The implementation is derived from the STM32F405 SoC.
>> The implementation contains no peripherals, only memory regions are
>> implemented.
>>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>
>> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
>> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
>> ---
>>  MAINTAINERS                    |   8 +
>>  hw/arm/Kconfig                 |   5 +
>>  hw/arm/meson.build             |   1 +
>>  hw/arm/stm32l4x5_soc.c         | 277 +++++++++++++++++++++++++++++++++
>>  include/hw/arm/stm32l4x5_soc.h |  68 ++++++++
>>  5 files changed, 359 insertions(+)
>>  create mode 100644 hw/arm/stm32l4x5_soc.c
>>  create mode 100644 include/hw/arm/stm32l4x5_soc.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ff1238bb98..32458d41dd 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1122,6 +1122,14 @@ L: qemu-arm@nongnu.org
>>  S: Maintained
>>  F: hw/arm/olimex-stm32-h405.c
>>
>> +STM32L4x5 SoC Family
>> +M: Arnaud Minier <arnaud.minier@telecom-paris.fr>
>> +M: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
>> +L: qemu-arm@nongnu.org
>> +S: Maintained
>> +F: hw/arm/stm32l4x5_soc.c
>> +F: include/hw/arm/stm32l4x5_soc.h
>> +
>>  SmartFusion2
>>  M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
>>  M: Peter Maydell <peter.maydell@linaro.org>
>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>> index 3ada335a24..d2b94d9a47 100644
>> --- a/hw/arm/Kconfig
>> +++ b/hw/arm/Kconfig
>> @@ -448,6 +448,11 @@ config STM32F405_SOC
>>      select STM32F4XX_SYSCFG
>>      select STM32F4XX_EXTI
>>
>> +config STM32L4X5_SOC
>> +    bool
>> +    select ARM_V7M
>> +    select OR_IRQ
>> +
>>  config XLNX_ZYNQMP_ARM
>>      bool
>>      default y if PIXMAN
>> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
>> index 68245d3ad1..9766da10c4 100644
>> --- a/hw/arm/meson.build
>> +++ b/hw/arm/meson.build
>> @@ -42,6 +42,7 @@ arm_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm28=
36.c', 'raspi.c'))
>>  arm_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f100_soc.=
c'))
>>  arm_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_soc.=
c'))
>>  arm_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: files('stm32f405_soc.=
c'))
>> +arm_ss.add(when: 'CONFIG_STM32L4X5_SOC', if_true: files('stm32l4x5_soc.=
c'))
>>  arm_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zynqmp.=
c', 'xlnx-zcu102.c'))
>>  arm_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal.c', =
'xlnx-versal-virt.c'))
>>  arm_ss.add(when: 'CONFIG_FSL_IMX25', if_true: files('fsl-imx25.c', 'imx=
25_pdk.c'))
>> diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
>> new file mode 100644
>> index 0000000000..f476878b2c
>> --- /dev/null
>> +++ b/hw/arm/stm32l4x5_soc.c
>> @@ -0,0 +1,277 @@
>> +/*
>> + * STM32L4x5 SoC family
>> + *
>> + * SPDX-License-Identifier: MIT
>
> I'm pretty sure this must be GPL to be accepted

Does it? A quick grep of the code shows we have quite a lot of hw
emulation files that are MIT licensed. Although IANAL MIT is very
permissive and easily combined with GPL as long at the final product is
under GPL.

I think there is some LGPL code about for TCG but I'm not sure how well
tagged that is.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

