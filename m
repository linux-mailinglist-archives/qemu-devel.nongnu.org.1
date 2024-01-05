Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E648252F1
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 12:33:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLiR8-0003jn-QO; Fri, 05 Jan 2024 06:32:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLiR5-0003jO-SS
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 06:32:24 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLiR4-0004B7-9A
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 06:32:23 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a28d25253d2so158283666b.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 03:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704454340; x=1705059140; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6Ki4iJu5Z2dtOUCyOqUx926JbIQ+swkf687+BhNbUEY=;
 b=rzMLaizZRkrmMaAfUV9iSiG/WgbqFh4IOa9sAV/4Z9BSG2lh1zS5f/jCA41QjfLX/i
 PxlWa/0BSxbFZp9kEHrfxsbPjqqDdOL72NTlbLMir2m+o33iRci9OYigPGglYPbxRsq/
 EuqEqNzXlBrgAQ2SSehd0e/B5EKP/Mxdm0hNoOwn63eq/sVOGCnDrNm3c3m2JQTaWeWq
 dFLI9xXgf4O6ymSuvUX1QCbrOSwWAZVcFOAnDN7VaQx13Dxenh+mzaGBo/R4rwh8Oqp0
 +pTdZ3lsRPBP/4tWn/6EX4krknr3R/G+tTYch6xVflbA+eXfgQVzRczIj8dUDnH34l/m
 GEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704454340; x=1705059140;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Ki4iJu5Z2dtOUCyOqUx926JbIQ+swkf687+BhNbUEY=;
 b=SkbLWbzki7nZrkenveIMUx6x42C/u5lXg7ijuAQmUD/7KkG3FG+jMP0ebyCCij1TSR
 BGu9n2xE7/kBFrw1g3bef7KHnWMv2BM4czyLQzTTem1gWtz20pjOpy/Xg63gfHB9ugcy
 G2EOHK5fbatcF8iWSp4ByQFl8JPjAr3ixGca0LJq8oGhgH8C545eIbhZ0G23iLzcb7hf
 YtHlAjMZdCZ3kFnw0463cbVTvn3Rp3d/Cs7JgfoWQ+crTO9142n+QWml6aMBOBABUJUB
 wvvHBWKsZtAk/jfM4N+Z82kqLAo6Sxc89akxqkZhFdmVHyDmn+0EzoPDNB4gxyJ6ULCI
 menA==
X-Gm-Message-State: AOJu0Yzc5+iSnQLsJ4eKwDn8RYniaXYfgzBFhKadztfMwzPvjQ5uXY54
 VuVBMbpfHurqQsXa3AU0Dd3+LnjfgoembQ==
X-Google-Smtp-Source: AGHT+IEAOZK7xiNDZ44TBjQ4FxbbBJleNhKBncoCJu7e8RxfZmzpxbHi70ayo0WiMDoORjC87IXgzg==
X-Received: by 2002:a17:906:1111:b0:a29:852c:dd21 with SMTP id
 h17-20020a170906111100b00a29852cdd21mr161816eja.10.1704454340018; 
 Fri, 05 Jan 2024 03:32:20 -0800 (PST)
Received: from [192.168.69.100] (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 oz39-20020a170906cd2700b00a1f7ab65d3fsm781262ejb.131.2024.01.05.03.32.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jan 2024 03:32:19 -0800 (PST)
Message-ID: <702936da-4931-40b7-8f82-b256cdf8d9f1@linaro.org>
Date: Fri, 5 Jan 2024 12:32:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] intc/grlib_irqmp: implements the multiprocessor
 status register
Content-Language: en-US
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, qemu-devel@nongnu.org
Cc: Frederic Konrad <konrad.frederic@yahoo.fr>
References: <20240105102421.163554-1-chigot@adacore.com>
 <20240105102421.163554-4-chigot@adacore.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240105102421.163554-4-chigot@adacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

Hi Clément,

On 5/1/24 11:24, Clément Chigot wrote:
> This implements the multiprocessor status register in grlib-irqmp and bind
> it to a start signal, which will be later wired in leon3-generic to
> start a cpu.
> 
> Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
> Signed-off-by: Clément Chigot <chigot@adacore.com>
> ---
>   hw/intc/grlib_irqmp.c | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)


> @@ -323,6 +334,8 @@ static void grlib_irqmp_reset(DeviceState *d)
>   
>       memset(irqmp->state, 0, sizeof *irqmp->state);
>       irqmp->state->parent = irqmp;
> +    irqmp->state->mpstatus = ((irqmp->ncpus - 1) << 28)

Can you #define this magic '28' number?

> +        | ((1 << irqmp->ncpus) - 2);
>   }
>   
>   static void grlib_irqmp_realize(DeviceState *dev, Error **errp)
> @@ -336,6 +349,9 @@ static void grlib_irqmp_realize(DeviceState *dev, Error **errp)
>       }
>   
>       qdev_init_gpio_in(dev, grlib_irqmp_set_irq, MAX_PILS);
> +    /* Transitionning from 0 to 1 starts the CPUs.  */

What about 1 -> 0?

> +    qdev_init_gpio_out_named(dev, irqmp->start_signal, "grlib-start-cpu",
> +                             IRQMP_MAX_CPU);
>       qdev_init_gpio_out_named(dev, &irqmp->irq, "grlib-irq", 1);
>       memory_region_init_io(&irqmp->iomem, OBJECT(dev), &grlib_irqmp_ops, irqmp,
>                             "irqmp", IRQMP_REG_SIZE);


