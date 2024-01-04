Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 253D9824218
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 13:57:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLNGF-00064M-Mf; Thu, 04 Jan 2024 07:55:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLNGA-000644-3c
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 07:55:42 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLNG6-00015e-1l
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 07:55:39 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50e7c6f0487so457083e87.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 04:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704372936; x=1704977736; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A72gbG4UiiLDXxw8Quv21kfU/8tlCqfojSn+T8b2IiE=;
 b=tzzHN8j9O3hNFGbq+q+I3+KabKA7+GAtZLI0xdTeQ4YrG1XsO4RZbh245STA2yo1Pj
 Cw5vt6/JQpL/UHLSZrWmuQs288G6gJb9X6rpSboNfj7APfUa7EwrFO76UOKmY8H4nyXq
 +jsn6jOX1lo+ja3DPkBa1Cy00pgZrp1EaxSFA3W/uimhlxKKKD1s8+YNJXWIaZPiQ84z
 AFC5X3CFRjXKojDpCuxyxrjfL6FvVjDekDhVabg8YPOLJXpIp7ZyqI5Wk6ABZnrUHn2w
 t5UPWeyfvv2htCzzKQ+KXe4mVEHYCGyMdjd1jbj2JXbNZVOCstA9y0unqav/+cBiG+Bm
 /F3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704372936; x=1704977736;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A72gbG4UiiLDXxw8Quv21kfU/8tlCqfojSn+T8b2IiE=;
 b=hBuWOVm+08iU428gvTu4aZhHcUYKz12vx1GeuPVxIMrMQ3Kx4G2J664feGBkAsCnBy
 qfVhTigZUHgpKxO1ptExCBaqy2qvyhHNIEFvCBJE0G0CidVKH5CdpDXN5zmpelp+GArh
 A15JDJtrkjtNMy8JrBcwmCRvT+G1n74ewkC5sctT2ia9sSBHfsdOgweIp41Joh0eZXkp
 e2kDJwevScLx3HOydIB1C9Tu0WGZ9eLhDMHifBsG4lpy5KRn2Hd86/+Pn6Ryg3WlZiEI
 bcIZWP5m35jc87gpWlBzVJVhKiKkosgB5GDT1DpBasHYglv4u0o0m93TSRQ1ziHJdnhq
 qC0Q==
X-Gm-Message-State: AOJu0YwOBIGToTUAZuGaIb12aoEFAQVQhjP4tLeD5FHJ81/uwPBmDda0
 IhK9vcM5HA3+mHmyCnazzQTdCNuxMSOFqg==
X-Google-Smtp-Source: AGHT+IGtJ1CFBjfFpppAnIjjVcBWdJ18HN3nS91/qMQtuj9cKuCm8oUTM3+vDQGF2PnnuDkoBOiJHw==
X-Received: by 2002:ac2:420e:0:b0:50e:79a5:5462 with SMTP id
 y14-20020ac2420e000000b0050e79a55462mr202217lfh.199.1704372935963; 
 Thu, 04 Jan 2024 04:55:35 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.232])
 by smtp.gmail.com with ESMTPSA id
 s24-20020aa7cb18000000b0054ce9ef93fbsm18841866edt.4.2024.01.04.04.55.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jan 2024 04:55:35 -0800 (PST)
Message-ID: <9fc5c70d-0616-49da-94c9-476407925bc7@linaro.org>
Date: Thu, 4 Jan 2024 13:55:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] hw/arm: Add minimal support for the B-L475E-IOT01A
 board
Content-Language: en-US
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alistair@alistair23.me, peter.maydell@linaro.org,
 arnaud.minier@telecom-paris.fr
References: <20231221213838.54944-1-ines.varhol@telecom-paris.fr>
 <20231221213838.54944-3-ines.varhol@telecom-paris.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231221213838.54944-3-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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
> This commit adds a new B-L475E-IOT01A board using the STM32L475VG SoC
> as well as a dedicated documentation file.
> The implementation is derived from the Netduino Plus 2 machine.
> There are no peripherals implemented yet, only memory regions.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

(please drop newline)

> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   MAINTAINERS                             |  7 +++
>   configs/devices/arm-softmmu/default.mak |  1 +
>   docs/system/arm/b-l475e-iot01a.rst      | 46 ++++++++++++++++
>   docs/system/arm/stm32.rst               |  6 ++-
>   docs/system/target-arm.rst              |  1 +
>   hw/arm/Kconfig                          |  6 +++
>   hw/arm/b-l475e-iot01a.c                 | 70 +++++++++++++++++++++++++
>   hw/arm/meson.build                      |  1 +
>   8 files changed, 136 insertions(+), 2 deletions(-)
>   create mode 100644 docs/system/arm/b-l475e-iot01a.rst
>   create mode 100644 hw/arm/b-l475e-iot01a.c


> diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
> new file mode 100644
> index 0000000000..c3790e3dc8
> --- /dev/null
> +++ b/hw/arm/b-l475e-iot01a.c
> @@ -0,0 +1,70 @@
> +/*
> + * B-L475E-IOT01A Discovery Kit machine
> + * (B-L475E-IOT01A IoT Node)
> + *
> + * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
> + * Copyright (c) 2023 Inès Varhol <ines.varhol@telecom-paris.fr>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + * This work is heavily inspired by the netduinoplus2 by Alistair Francis.
> + * Original code is licensed under the MIT License:
> + *
> + * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
> + */
> +
> +/*
> + * The reference used is the STMicroElectronics UM2153 User manual
> + * Discovery kit for IoT node, multi-channel communication with STM32L4.
> + * https://www.st.com/en/evaluation-tools/b-l475e-iot01a.html#documentation
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/boards.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/qdev-clock.h"
> +#include "qemu/error-report.h"
> +#include "hw/arm/stm32l4x5_soc.h"
> +#include "hw/arm/boot.h"
> +
> +/* Main SYSCLK frequency in Hz (80MHz) */
> +#define SYSCLK_FRQ 80000000ULL

Alternative self-documenting name: MAIN_SYSCLK_FREQ_HZ

> +static void b_l475e_iot01a_machine_init(MachineClass *mc)
> +{
> +    static const char *machine_valid_cpu_types[] = {
> +        ARM_CPU_TYPE_NAME("cortex-m4"),
> +        NULL};

Per our coding style, the trailing '}' goes on a newline.

> +    mc->desc = "B-L475E-IOT01A Discovery Kit (Cortex-M4)";
> +    mc->init = b_l475e_iot01a_init;
> +    mc->valid_cpu_types = machine_valid_cpu_types;
> +
> +    /* SRAM pre-allocated as part of the SoC instantiation */
> +    mc->default_ram_size = 0;
> +}

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


