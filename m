Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CA7828ACC
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 18:14:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNFfv-0008PV-AW; Tue, 09 Jan 2024 12:14:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNFfs-0008Ox-6n
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 12:14:01 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNFff-0002GR-Fh
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 12:13:59 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3376d424a79so1709521f8f.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 09:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704820421; x=1705425221; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CHC1NK96q6cWM/H+9W9W8XZwDAj/9wTds35KcQ/gzhg=;
 b=cEQ0C1kwKaHfEP7h5Z1SNQaPjh4nf8mgWB3VLjc12edZvxcg9lpP0oS7RHmMkjqEzw
 A1lZ7E05RQHA4LfycP8IXwJaZGZqN17TSnMnj1GEwJvODZO+7B4EFrkMcnAmqbQkdtNF
 mRVs9+bLYfsXIh9lSMoRtLBHWQu5ibN8GPvo4j/gsRfXYj9YKkugAM8iYaZmHZepEOge
 FQL43fRuDNSAgIywSEIndcgj8zE7yJSk0kLyrsgpXzm68pwR1b6o/KFAoa5L9cj1XimK
 DnPb3owkxbHelbcqqSri+2SvQr+xE8QW09mskHmJGSDsgIawzej5l3g7yOzluJWVc2Lt
 Z2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704820421; x=1705425221;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CHC1NK96q6cWM/H+9W9W8XZwDAj/9wTds35KcQ/gzhg=;
 b=mznuMUrjQrEV5/AS5pvoIBLi6dFSv+p01hknYHlSqTxoU0/psbkYAWmzcH6IuMlmkj
 mZTCqUuBENlIxoQDw8QpTXBEYhRZCxmDsJcJN6ev0fCBzD43QiCXTwiDDc5zIZrXTEa4
 mMSd2jdPyLUXOo/W5n5OKgjlbr0fyxm1zdwhPnbcXaU39EalxHbXYLXGVLBy2RZ4B/df
 PZ3kACvMnTSGntZKt3mNO4TMbIwhEhHhaSkyIt6BwjKh84UZT+DImdbpQAxEAFAFLWh4
 CleygjVYpn/qNXR8iWrstkGxo6fLtZbMp/8HmdLxVYV3xvyBNQeqojDdSQIrirHBt7D6
 Z5UQ==
X-Gm-Message-State: AOJu0YyPu7S5ValQAtkCp6rIERqp6Kiwhhh9xK+f/Euxg+oTXkvI0ZxD
 kYevdiRgUI1sVm2W7QC3Scqr0FgumQZ1AQ==
X-Google-Smtp-Source: AGHT+IFlM3YF/vCcXhM6S2tUsDkLWD2ahxzeW/csSkNXeWQi4eS6yCjTqvFElPc9YrluQbOJ/psEKw==
X-Received: by 2002:adf:fe09:0:b0:336:660d:20e1 with SMTP id
 n9-20020adffe09000000b00336660d20e1mr801164wrr.75.1704820421397; 
 Tue, 09 Jan 2024 09:13:41 -0800 (PST)
Received: from [192.168.69.100] (rsa59-h02-176-184-32-47.dsl.sta.abo.bbox.fr.
 [176.184.32.47]) by smtp.gmail.com with ESMTPSA id
 g18-20020adff3d2000000b00336aac53e75sm2850512wrp.97.2024.01.09.09.13.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 09:13:41 -0800 (PST)
Message-ID: <50a4ff56-65e5-4c14-86ba-c0759d1c5034@linaro.org>
Date: Tue, 9 Jan 2024 18:13:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/3] hw/misc: Implement STM32L4x5 EXTI
Content-Language: en-US
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, qemu-arm@nongnu.org,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20240109160658.311932-1-ines.varhol@telecom-paris.fr>
 <20240109160658.311932-2-ines.varhol@telecom-paris.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240109160658.311932-2-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 9/1/24 17:06, Inès Varhol wrote:
> Although very similar to the STM32F4xx EXTI, STM32L4x5 EXTI generates
> more than 32 event/interrupt requests and thus uses more registers
> than STM32F4xx EXTI which generates 23 event/interrupt requests.
> 
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   docs/system/arm/b-l475e-iot01a.rst |   5 +-
>   hw/misc/Kconfig                    |   3 +
>   hw/misc/meson.build                |   1 +
>   hw/misc/stm32l4x5_exti.c           | 290 +++++++++++++++++++++++++++++
>   hw/misc/trace-events               |   5 +
>   include/hw/misc/stm32l4x5_exti.h   |  51 +++++
>   6 files changed, 352 insertions(+), 3 deletions(-)
>   create mode 100644 hw/misc/stm32l4x5_exti.c
>   create mode 100644 include/hw/misc/stm32l4x5_exti.h


> +static unsigned configurable_mask(unsigned bank)
> +{
> +     return valid_mask(bank) & ~exti_romask[bank];
> +}

Excellent, I'm glad of all the improvement you made over
the review process, great work!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +static void stm32l4x5_exti_write(void *opaque, hwaddr addr,
> +                                 uint64_t val64, unsigned int size)
> +{
> +    Stm32l4x5ExtiState *s = opaque;
> +    const unsigned bank = regbank_index_by_addr(addr);
> +
> +    trace_stm32l4x5_exti_write(addr, val64);
> +
> +    switch (addr) {
> +    case EXTI_IMR1:
> +    case EXTI_IMR2:
> +        s->imr[bank] = val64 & valid_mask(bank);
> +        return;
> +    case EXTI_EMR1:
> +    case EXTI_EMR2:
> +        s->emr[bank] = val64 & valid_mask(bank);
> +        return;
> +    case EXTI_RTSR1:
> +    case EXTI_RTSR2:
> +        s->rtsr[bank] = val64 & configurable_mask(bank);
> +        return;
> +    case EXTI_FTSR1:
> +    case EXTI_FTSR2:
> +        s->ftsr[bank] = val64 & configurable_mask(bank);
> +        return;
> +    case EXTI_SWIER1:
> +    case EXTI_SWIER2: {
> +        const uint32_t set = val64 & configurable_mask(bank);
> +        const uint32_t pend = set & ~s->swier[bank] & s->imr[bank] &
> +                              ~s->pr[bank];
> +        s->swier[bank] = set;
> +        s->pr[bank] |= pend;
> +        for (unsigned i = 0; i < irqs_per_bank[bank]; i++) {
> +            if (extract32(pend, i, 1)) {
> +                qemu_irq_pulse(s->irq[i + 32 * bank]);
> +            }
> +        }
> +        return;
> +    }

[...]

