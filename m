Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 334537EDBE7
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 08:23:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Wim-0002jI-WE; Thu, 16 Nov 2023 02:23:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3Wik-0002iR-Jj
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:23:26 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3Wii-0007gR-9L
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:23:26 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-50930f126b1so608309e87.3
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 23:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700119402; x=1700724202; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dqUlFsUrudmhv6OqbCROZM7lVUnreEQP/giNLNeMJu8=;
 b=pYtRUAwp5R6sx2SOl0S9W4RZdg0hri7IYtIuwE7a9d6mduM54yryT3Ngdxpxcreytr
 2iLGvImqTwGsVGs9gtEzxWOWg0sSvW2N9DatbK3qKnAqXZ46YVhJ4HpaC8pTIbW4K+tE
 xtRprRRZtakAbGeJM838ZtAiQXAIuzYi3UsbP/Ie5rSjBZ6CPLGT7vFQ4CJv77+pm/+8
 h4NH5ud96A1XVvUylrXaCoE4JraE+Ul4u1OPj5gdnNUAsN5hZX9mVlhBNz5nxZtexPQY
 vNZ9G0kdDLX/lwE/w6T0EfwqJkHk6GO6Q9F1TXiItUZCARhXq7NdjLI6rgzbH3lmQFl1
 RWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700119402; x=1700724202;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dqUlFsUrudmhv6OqbCROZM7lVUnreEQP/giNLNeMJu8=;
 b=hYCswgW8NfRxOygBpR2DL7YPF1kfPf8zmfNAwZI8BCIaR1r8gVAaNFB5qHO1iyl9a7
 x+EmsLyBLGV1cMm4NTAUMwjHH5orz4ubblwJjSmglc0PigxroYikffEyH/rgCBggzQ4u
 sKwZ7Mj/7sAEM+utFMRhKmXIJi1Z1o4V1uVg1waZtTf7xRHN0EWOjps2j+LihBD/ms2L
 0/py5q4FkYJICH0mSv2Iwo6mJ13WGRB1y6/tD0BmmaCVxvOs4tTgvxpcFPMekeE8045L
 t5WhDOj7fLmjylEumJEd75yRyPO531zWoOdvA+teArerEKnXQ6Db6+jNuklAloPWPd47
 Dbtw==
X-Gm-Message-State: AOJu0Yys4B5zCXH43hXxwVkTYoxbQfkEFMfg2IFufk/x14KUXzfL9hAq
 NbvVtQSTxRJNmIosrD+8B2GFK5mAg3r7sDkQWbo=
X-Google-Smtp-Source: AGHT+IGKOK8GoX4zDIRqkKbsYeCaMNxoCQ3jXGab3Okw89ZxDzUJcG8+H8JW1Y9wT5ozmmjPJSyNPw==
X-Received: by 2002:a19:5210:0:b0:509:4bd1:6b63 with SMTP id
 m16-20020a195210000000b005094bd16b63mr10106788lfb.16.1700119401890; 
 Wed, 15 Nov 2023 23:23:21 -0800 (PST)
Received: from [192.168.69.100] ([176.187.220.205])
 by smtp.gmail.com with ESMTPSA id
 l11-20020a5d526b000000b0031c52e81490sm12656679wrc.72.2023.11.15.23.23.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 23:23:21 -0800 (PST)
Message-ID: <1f657e11-909f-433a-8642-3a0176019b4a@linaro.org>
Date: Thu, 16 Nov 2023 08:23:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2? 1/6] hw/arm/stm32f405: Report error when
 incorrect CPU is used
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 Tyrone Ting <kfting@nuvoton.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Hao Wu <wuhaotsh@google.com>, Felipe Balbi <balbi@kernel.org>,
 Gavin Shan <gshan@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20231115232154.4515-1-philmd@linaro.org>
 <20231115232154.4515-2-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231115232154.4515-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
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

On 16/11/23 00:21, Philippe Mathieu-Daudé wrote:
> Both 'netduinoplus2' and 'olimex-stm32-h405' machines ignore the
> CPU type requested by the command line. This might confuse users,
> since the following will create a machine with a Cortex-M4 CPU:
> 
>    $ qemu-system-aarch64 -M netduinoplus2 -cpu cortex-r5f
> 
> Set the MachineClass::valid_cpu_types field (introduced in commit
> c9cf636d48 "machine: Add a valid_cpu_types property").
> Remove the now unused MachineClass::default_cpu_type field.
> 
> We now get:
> 
>    $ qemu-system-aarch64 -M netduinoplus2 -cpu cortex-r5f
>    qemu-system-aarch64: Invalid CPU type: cortex-r5f-arm-cpu
>    The valid types are: cortex-m4-arm-cpu
> 
> Since the SoC family can only use Cortex-M4 CPUs, hard-code the
> CPU type name at the SoC level, removing the QOM property
> entirely.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/arm/stm32f405_soc.h | 4 ----
>   hw/arm/netduinoplus2.c         | 7 ++++++-
>   hw/arm/olimex-stm32-h405.c     | 8 ++++++--
>   hw/arm/stm32f405_soc.c         | 8 +-------
>   4 files changed, 13 insertions(+), 14 deletions(-)


> diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
> index 3aa61c91b7..694b1dd6ed 100644
> --- a/hw/arm/olimex-stm32-h405.c
> +++ b/hw/arm/olimex-stm32-h405.c
> @@ -47,7 +47,6 @@ static void olimex_stm32_h405_init(MachineState *machine)
>       clock_set_hz(sysclk, SYSCLK_FRQ);
>   
>       dev = qdev_new(TYPE_STM32F405_SOC);
> -    qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));
>       qdev_connect_clock_in(dev, "sysclk", sysclk);
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>   
> @@ -58,9 +57,14 @@ static void olimex_stm32_h405_init(MachineState *machine)
>   
>   static void olimex_stm32_h405_machine_init(MachineClass *mc)
>   {
> +    static const char *machine_valid_cpu_types[] = {

const char * const

(in all this series).

> +        ARM_CPU_TYPE_NAME("cortex-m4"),
> +        NULL
> +    };
> +
>       mc->desc = "Olimex STM32-H405 (Cortex-M4)";
>       mc->init = olimex_stm32_h405_init;
> -    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m4");
> +    mc->valid_cpu_types = machine_valid_cpu_types;
>   
>       /* SRAM pre-allocated as part of the SoC instantiation */
>       mc->default_ram_size = 0;


