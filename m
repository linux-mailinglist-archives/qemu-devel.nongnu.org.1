Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A49824205
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 13:51:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLNAh-0004EU-AX; Thu, 04 Jan 2024 07:50:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLNAf-0004E5-Md
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 07:50:01 -0500
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLNAd-0008Bb-RE
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 07:50:01 -0500
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-7cd3880e86bso167716241.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 04:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704372598; x=1704977398; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IMZI/vvP+7WIuO8FbPwDuGYwgWLutSdZg5OTndZk3iw=;
 b=IiI0r3T1VNKiVMBVs0KI6ORfDPhe+6laGGPPHau4a1/KaAyMCRqXojrfnIYrQvFvMJ
 WyGAxD3wjHkTNf5YxMSypmNEINBiFwfUKd8gmw9y1ABlebpCpPggmx21bF5XE4kxywlp
 VB0/RCSMYAhyRQom1Nluph3ZkA26Wc3WhGCwwtRS1mlIzWWQQA8ztsAkqtJWIIKoMJpP
 pQ9VSUj9Ulx0FDsKWDUsKvmTpcP1txvCiRgD6Dj3YLGlzI+FSX8fM6P4mVExggFSLd87
 32WeYRnlAeymKiJUt2mGqbIHQMDC/dR3kANbzptE96uoxabPKtgLTa/1+aH3qH2mrVm7
 thXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704372598; x=1704977398;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IMZI/vvP+7WIuO8FbPwDuGYwgWLutSdZg5OTndZk3iw=;
 b=e839I8rK7q4v5Yc5TcagK1yg2P7+NTJO8DOvx6VM8ljJfwdOeLseCttyEqums06uxo
 ZnzoHPqkF8dN3+433mrW8iLIwhHck+t+zWKXrhkA1Wfh0hAC3Uj7Srs7a1wrREJpQdYy
 FZTZgfloNHHdgs7AqzLb/4TT7L5IIp5drfEkKEqNd/PWURGZdJY/A1imrHREvE8bm6LR
 xfHZRbzjHTGnI45OCZFdGP7tonDroVBcSDHH/Jg344q2wca6Vf4uJKr7ALTryiQYRn97
 VBHxglCGGmrTPD1jBnV63kY4C77/gcG74/6YylG20PbmU8K7hdFPuQBHGKZXlBsoyF90
 wydw==
X-Gm-Message-State: AOJu0Yyi16C4xluJnYx14mBYF/JHmux62DMIYCTnzkqx/9zXQGqEfut9
 t1qeFIYt3UZZFLSEWcmUNIgWJboYr9D+MQ==
X-Google-Smtp-Source: AGHT+IHBrUgoMwPxHdS9l/n37/sjCCxIRzQ/ijjZVwhW7k61g2Zyv/bVUSEl5WfkQNWFNMPtfIKX9Q==
X-Received: by 2002:a05:6102:374e:b0:467:aa80:299b with SMTP id
 u14-20020a056102374e00b00467aa80299bmr314694vst.1.1704372597526; 
 Thu, 04 Jan 2024 04:49:57 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.232])
 by smtp.gmail.com with ESMTPSA id
 j15-20020a056102334f00b0046695b658dcsm1911962vse.30.2024.01.04.04.49.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jan 2024 04:49:57 -0800 (PST)
Message-ID: <fa60d7bc-da2f-4ab7-9022-03cddaf5f39b@linaro.org>
Date: Thu, 4 Jan 2024 13:49:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] hw/arm: Add minimal support for the STM32L4x5 SoC
Content-Language: en-US
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alistair@alistair23.me, peter.maydell@linaro.org,
 arnaud.minier@telecom-paris.fr
References: <20231221213838.54944-1-ines.varhol@telecom-paris.fr>
 <20231221213838.54944-2-ines.varhol@telecom-paris.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231221213838.54944-2-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=philmd@linaro.org; helo=mail-ua1-x929.google.com
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

On 21/12/23 22:32, Inès Varhol wrote:
> This patch adds a new STM32L4x5 SoC, it is necessary to add support for
> the B-L475E-IOT01A board.
> The implementation is derived from the STM32F405 SoC.
> The implementation contains no peripherals, only memory regions are
> implemented.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

(preferably drop the newline)

> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   MAINTAINERS                    |   8 +
>   hw/arm/Kconfig                 |   5 +
>   hw/arm/meson.build             |   1 +
>   hw/arm/stm32l4x5_soc.c         | 268 +++++++++++++++++++++++++++++++++
>   include/hw/arm/stm32l4x5_soc.h |  59 ++++++++
>   5 files changed, 341 insertions(+)
>   create mode 100644 hw/arm/stm32l4x5_soc.c
>   create mode 100644 include/hw/arm/stm32l4x5_soc.h


> --- /dev/null
> +++ b/include/hw/arm/stm32l4x5_soc.h
> @@ -0,0 +1,59 @@
> +/*
> + * STM32L4x5 SoC family
> + *
> + * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
> + * Copyright (c) 2023 Inès Varhol <ines.varhol@telecom-paris.fr>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + * This work is heavily inspired by the stm32f405_soc by Alistair Francis.
> + * Original code is licensed under the MIT License:
> + *
> + * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
> + */
> +
> +/*
> + * The reference used is the STMicroElectronics RM0351 Reference manual
> + * for STM32L4x5 and STM32L4x6 advanced Arm ® -based 32-bit MCUs.
> + * https://www.st.com/en/microcontrollers-microprocessors/stm32l4x5/documentation.html
> + */
> +
> +#ifndef HW_ARM_STM32L4x5_SOC_H
> +#define HW_ARM_STM32L4x5_SOC_H
> +
> +#include "exec/memory.h"
> +#include "qemu/units.h"

"qemu/units.h" isn't used in this header,

> +#include "hw/qdev-core.h"

neither is this one.

> +#include "hw/arm/armv7m.h"
> +#include "qom/object.h"
> +
> +#define TYPE_STM32L4X5_SOC "stm32l4x5-soc"
> +#define TYPE_STM32L4X5XC_SOC "stm32l4x5xc-soc"
> +#define TYPE_STM32L4X5XE_SOC "stm32l4x5xe-soc"
> +#define TYPE_STM32L4X5XG_SOC "stm32l4x5xg-soc"
> +OBJECT_DECLARE_TYPE(Stm32l4x5SocState, Stm32l4x5SocClass, STM32L4X5_SOC)
> +
> +struct Stm32l4x5SocState {
> +    SysBusDevice parent_obj;
> +
> +    ARMv7MState armv7m;
> +
> +    MemoryRegion sram1;
> +    MemoryRegion sram2;
> +    MemoryRegion flash;
> +    MemoryRegion flash_alias;
> +
> +    Clock *sysclk;
> +    Clock *refclk;
> +};
> +
> +struct Stm32l4x5SocClass {
> +    SysBusDeviceClass parent_class;
> +
> +    size_t flash_size;
> +};
> +
> +#endif

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


