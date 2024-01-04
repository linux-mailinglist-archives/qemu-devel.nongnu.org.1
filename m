Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 989F1824281
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 14:12:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLNW5-00030Y-1n; Thu, 04 Jan 2024 08:12:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLNW2-00030C-Pl
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 08:12:06 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLNVz-0006Jm-A3
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 08:12:06 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-336f2c88361so438255f8f.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 05:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704373920; x=1704978720; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QCQK2YHF40/oVZdGanpblAG0qjgj40cOa4xxTM9PKAY=;
 b=y/5U+jgRNNU2gBPxRgtjwPUqe4v4mcfvj8L1yIOxk2nPdWfsNZnGRYJtgWGXN7H4r1
 M/xKUsEsTfPtrpZ51u7/qOd1WLzYmX84ROHGS2WCVSzM6k4H3ZnS5Z/JhoAscWgICkh0
 TlNRqZ+ojfcqKk3CYGJZLMMNuu8uhluVlfAH4trHIv2pJItL5K/BKYaGa87F7IpGTDnQ
 m55MJz96beZNeikRjl6v9m+FpRcqlRohA9s+PuRXAuKQcHRTcWARG3lJyubmeYhqhoK6
 gLzVDATM5z+XDU0opA7IchkFYjXAPRnhsTAnbfM4MQZ9iklYYTdPEljZwaWuVTkcT2dJ
 Q8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704373920; x=1704978720;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QCQK2YHF40/oVZdGanpblAG0qjgj40cOa4xxTM9PKAY=;
 b=ZJRObvtt0XfoLqkKPJqBb3ygEnroRYsCiIKwEUus2Ig2fZjdTnYWPjKmqKEdbnC3/a
 78EpzIYPs9TuXD0Ix4k9/qRc8JAjU+fVTma90469gGJgiFH+jcv0dj+SD/CSEkccbmxL
 pSVlJNHMdJvTCWjDi8+RuLnbfYnGtYfgFqiwES1tC1phh7WtU53kp4idwHstYRtJ3bb/
 m292u6SF7tdW9s9SfnO6iGxevJ1jFEPt8gay9+oS3d84I1PuB4dQMYlf1Qe7aLtIB/PR
 LOqFUG7lVgebJa3rHVDX2qZAk9Y+SMAEg5tCTgOinGzcGd77zvln1TLkh/pcqLWvpxTC
 YRRA==
X-Gm-Message-State: AOJu0YzKHBERkBj3rk6yXgVhx3npIMEGRed86kDLdWxSva17wMO/HR60
 YBamZTI4F8ki1s+6j5MxksZ//J9jrVal7g==
X-Google-Smtp-Source: AGHT+IGdv5b1gfMWLsJ1FqmL5LR4/VMBjboA+2COX8/gGgfcWbbnJ+L/HNf7xDUTLHqNtlUG2mkLoQ==
X-Received: by 2002:a05:600c:518d:b0:40d:5c4d:478a with SMTP id
 fa13-20020a05600c518d00b0040d5c4d478amr291414wmb.32.1704373920463; 
 Thu, 04 Jan 2024 05:12:00 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.232])
 by smtp.gmail.com with ESMTPSA id
 fa26-20020a05600c519a00b0040d5ab35657sm5731870wmb.4.2024.01.04.05.11.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jan 2024 05:11:59 -0800 (PST)
Message-ID: <1d15fc3d-1334-4ef0-8484-d8dcbfa10df3@linaro.org>
Date: Thu, 4 Jan 2024 14:11:57 +0100
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
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
> +
> +static void b_l475e_iot01a_init(MachineState *machine)
> +{
> +    const Stm32l4x5SocClass *sc;
> +    DeviceState *dev;
> +    Clock *sysclk;
> +
> +    /* This clock doesn't need migration because it is fixed-frequency */
> +    sysclk = clock_new(OBJECT(machine), "SYSCLK");
> +    clock_set_hz(sysclk, SYSCLK_FRQ);
> +
> +    dev = qdev_new(TYPE_STM32L4X5XG_SOC);

Missing machine parentship relation.

> +    sc = STM32L4X5_SOC_GET_CLASS(dev);
> +    qdev_connect_clock_in(dev, "sysclk", sysclk);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    armv7m_load_kernel(ARM_CPU(first_cpu),
> +                       machine->kernel_filename,
> +                       0, sc->flash_size);
> +}

Using:

-- >8 --
diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
index c3790e3dc8..85b8cdcd57 100644
--- a/hw/arm/b-l475e-iot01a.c
+++ b/hw/arm/b-l475e-iot01a.c
@@ -45,10 +45,11 @@ static void b_l475e_iot01a_init(MachineState *machine)
      clock_set_hz(sysclk, SYSCLK_FRQ);

      dev = qdev_new(TYPE_STM32L4X5XG_SOC);
-    sc = STM32L4X5_SOC_GET_CLASS(dev);
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
      qdev_connect_clock_in(dev, "sysclk", sysclk);
      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);

+    sc = STM32L4X5_SOC_GET_CLASS(dev);
      armv7m_load_kernel(ARM_CPU(first_cpu),
                         machine->kernel_filename,
                         0, sc->flash_size);
---

we get:

(qemu) info qom-tree
/machine (b-l475e-iot01a-machine)
   /SYSCLK (clock)
   /peripheral (container)
   /peripheral-anon (container)
   /soc (stm32l4x5xg-soc)
     /SRAM1[0] (memory-region)
     /SRAM2[0] (memory-region)
     /armv7m (armv7m)
       /armv7m-container[0] (memory-region)
       /bitband[0] (ARM-bitband-memory)
         /bitband[0] (memory-region)
       /bitband[1] (ARM-bitband-memory)
         /bitband[0] (memory-region)
       /cpu (cortex-m4-arm-cpu)
         /unnamed-gpio-in[0] (irq)
         /unnamed-gpio-in[1] (irq)
         /unnamed-gpio-in[2] (irq)
         /unnamed-gpio-in[3] (irq)
       /cpuclk (clock)
       /nvic (armv7m_nvic)
         /NMI[0] (irq)
         ...

