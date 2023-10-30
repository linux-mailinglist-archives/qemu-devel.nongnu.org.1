Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B40BA7DB27D
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 05:19:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxJjk-0001vh-Jj; Mon, 30 Oct 2023 00:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxJji-0001vV-8U
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 00:18:46 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxJjf-0006y2-O0
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 00:18:45 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40837ebba42so27058335e9.0
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 21:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698639520; x=1699244320; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uV9BbOAwN+ExyoHqMUozGLxSieM73JeIzBDBnSn5RuI=;
 b=GAUBMOfENnOkcnFHeCBy7+bKRxLb6eLEc6stTQq9kL1Q4RkkjKBxYlu99jMt3ioDh3
 B76FO+ogXQYoJ04nxA2A8UuokMkxLPHO1ETTHVm2IQoHIr7Tqlbqe2QmVtb11rvxyP1Q
 UrC+qAh5Wd56vKnlwd0cWwTWdiBLd3Vb8C03H/fEaLyQfFkLF6WWZRh4swKWIGrAlcUe
 2rrZD59/LFJMyNo0pLnJv1dOP3bjb/lVrcw1JRxJLlZMaGYrwzU+OHc6n5X/sGUrmHsJ
 fOt1vYl4NGrmci/enbgOAeKqND6EgwOxHK38eUUhU2iLhMNk2mzDFDNsfvBVPuf/E4W6
 ttAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698639520; x=1699244320;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uV9BbOAwN+ExyoHqMUozGLxSieM73JeIzBDBnSn5RuI=;
 b=T3A4PBfRvm7ylYoZlpjXLR6F4ZBpYm5+0BNDxegjRENUdXjoEC3XyjB1LqXH//jN6/
 kKIxxBssStjcdkfxM1FiG+Zo+/KKNOaRui54RChxOaUX4qjjauxk5uYSeDfkCQJHUKrd
 2KDobdBKaAGNQwun5D8rfWGR/keLrpoh3Jxid0FPledh0qKyZi07P5G0CyxtGuGSqmAY
 svnNKAQ094cBiFoiVJX03lvB7hcfHKE5XK87337H/UlKVUOlL7yt4JH+XkHTSYIRJQKI
 tS3JeEeI1gHrvz78WhLUjk2wMVIzvmS5MLZD6mXLwkkYTlFNFdi/fHZp+kM/LSdfIzQO
 gq8g==
X-Gm-Message-State: AOJu0YxFrudLjXEdDg4K8HY2+LRmEul8txe2xaQixziG4JtiHguJs8/P
 /OAaUVENY61t1OlTZ6djzttsqFjmTC3KPGmGNsk=
X-Google-Smtp-Source: AGHT+IEw1ftR8kpnu0ku0Z7NumCz+Wd5CRw0O76kaglKwEvkbLilSoEYjZKSSPV6oD4WMP9L0gR3bg==
X-Received: by 2002:a05:600c:4514:b0:408:53d6:10b3 with SMTP id
 t20-20020a05600c451400b0040853d610b3mr7112804wmo.22.1698639520527; 
 Sun, 29 Oct 2023 21:18:40 -0700 (PDT)
Received: from [192.168.69.115] ([176.170.212.50])
 by smtp.gmail.com with ESMTPSA id
 er14-20020a05600c84ce00b004064cd71aa8sm8066730wmb.34.2023.10.29.21.18.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 21:18:40 -0700 (PDT)
Message-ID: <856b918d-ea32-8b88-f366-76ef81f121f9@linaro.org>
Date: Mon, 30 Oct 2023 05:18:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: Patch to fix malfunctioning of T2-T5 timers on the STM32 platform
Content-Language: en-US
To: Lucjan Bryndza <lbryndza.oss@icloud.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>
References: <04E66FC8-A5DC-469B-B23E-8FF9E4757915@icloud.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <04E66FC8-A5DC-469B-B23E-8FF9E4757915@icloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.972,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Lucjan,

On 27/10/23 21:37, Lucjan Bryndza wrote:
> 
> Current implementation of T2 - T5 times on the STM32 platform does not 
> work properly.
> After configuring the timer-counter circuit to report interrupts every 
> 10ms, in reality the first interrupt is reported
> only once after a few seconds, while subsequent interrupts do not come.
> The current code also does not properly emulate the operation of even 
> the basic functions of the TIME-BASE unit.
> This patch contains fixes that reimplements the basic functionality
> of the time base unit such as up-counting down-counting , and 
> alternate-mode up-down counting.
> The ptimer() API is used to emulate timers.
> After applying the patch, STM32 timer works correctly in its basic 
> functionality.
> The ISIX-RTOS test unit was used to test the patch.
> Links and instructions can be found below:
> 
> https://github.com/lucckb/isixrtos/blob/master/tests/libisix/01_basic_primitives.cpp <https://github.com/lucckb/isixrtos/blob/master/tests/libisix/01_basic_primitives.cpp>
> https://github.com/lucckb/isixrtos/blob/master/extras/doc/unit_test_qemu.md <https://github.com/lucckb/isixrtos/blob/master/extras/doc/unit_test_qemu.md>
> 
> 
> qemu-system-arm -M olimex-stm32-h405  -kernel 
> build/tests/libisix/isixunittests.binary -nographic
> unittests_entry.cpp:146|ISIX VERSION pub/ep0319-157-gb239b35f-dirty
> unittests_entry.cpp:83|Exceptions pretest. OK
> 51 selected tests
> [   RUN    ] 01_base_00 TimeBase timer vs systick
> [  1001ms  ] ...
> [   RUN    ] 01_base_01 Basic heap allocator
> [   1ms    ] ...
> 
> 
> Best Regards
> Lucjan Bryndza
> 
> 
>  From 3ccfe70979d1b263d4fa22104ecf42ac5a628554 Mon Sep 17 00:00:00 2001
> From: Lucjan Bryndza <lbryndza.oss@icloud.com>
> Date: Thu, 26 Oct 2023 22:45:26 +0200
> Subject: [PATCH] Fixing the basic functionality of STM32 timers
> 
> The current implementation of timers does not work properly
> even in the basic functionality. A counter configured to report
> an interrupt 10ms every reports the first interrupts after a
> few seconds.   Count up and
> count down modes are also not properly implemented. This commit fixes 
> bugs with interrupt
> reporting and implements the basic modes of the counter's
> time-base block.
> 
> Signed-off-by: Lucjan Bryndza <lbryndza.oss@icloud.com>
> ---
>   hw/arm/stm32f405_soc.c             |   2 +-
>   hw/timer/stm32f2xx_timer.c         | 291 ++++++++++++++++++-----------
>   include/hw/timer/stm32f2xx_timer.h |  23 ++-
>   3 files changed, 202 insertions(+), 114 deletions(-)
> 
> diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
> index cef23d7ee4..69316181b3 100644
> --- a/hw/arm/stm32f405_soc.c
> +++ b/hw/arm/stm32f405_soc.c
> @@ -183,7 +183,7 @@ static void stm32f405_soc_realize(DeviceState 
> *dev_soc, Error **errp)
>       /* Timer 2 to 5 */
>       for (i = 0; i < STM_NUM_TIMERS; i++) {
>           dev = DEVICE(&(s->timer[i]));
> -        qdev_prop_set_uint64(dev, "clock-frequency", 1000000000);
> +       qdev_prop_set_uint64(dev, "clock-frequency", 48000000);

Correct, this is for the 405 SoC.

>           if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), errp)) {
>               return;
>           }
> diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
> index ba8694dcd3..65f3287125 100644
> --- a/hw/timer/stm32f2xx_timer.c
> +++ b/hw/timer/stm32f2xx_timer.c
> @@ -29,11 +29,18 @@
>   #include "migration/vmstate.h"
>   #include "qemu/log.h"
>   #include "qemu/module.h"
> +#include "qemu/typedefs.h"
> +#include "qemu/timer.h"
> +#include "qemu/main-loop.h"
> +#include "sysemu/dma.h"
>   #ifndef STM_TIMER_ERR_DEBUG
>   #define STM_TIMER_ERR_DEBUG 0
>   #endif
> +/* PCLK /4 */
> +#define CLOCK_FREQUENCY 48000000ULL

This timer is generic, we shouldn't enforce a frequency from a
particular SoC.


>   static const MemoryRegionOps stm32f2xx_timer_ops = {
> @@ -275,7 +353,7 @@ static const VMStateDescription 
> vmstate_stm32f2xx_timer = {
>       .version_id = 1,
>       .minimum_version_id = 1,
>       .fields = (VMStateField[]) {
> -        VMSTATE_INT64(tick_offset, STM32F2XXTimerState),
> +        VMSTATE_INT32(count_mode, STM32F2XXTimerState),
>           VMSTATE_UINT32(tim_cr1, STM32F2XXTimerState),
>           VMSTATE_UINT32(tim_cr2, STM32F2XXTimerState),
>           VMSTATE_UINT32(tim_smcr, STM32F2XXTimerState),
> @@ -300,25 +378,24 @@ static const VMStateDescription 
> vmstate_stm32f2xx_timer = {
>   static Property stm32f2xx_timer_properties[] = {
>       DEFINE_PROP_UINT64("clock-frequency", struct STM32F2XXTimerState,
> -                       freq_hz, 1000000000),
> +                       freq_hz, CLOCK_FREQUENCY),

So here I suggest using '0', and in stm32f2xx_timer_realize() propagate
an error if the frequency is still 0.

>       DEFINE_PROP_END_OF_LIST(),
>   };

Regards,

Phil.

