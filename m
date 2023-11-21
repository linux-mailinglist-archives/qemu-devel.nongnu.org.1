Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C345C7F37DB
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 22:09:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5XyQ-0006O7-Ct; Tue, 21 Nov 2023 16:07:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5XyM-0006Ni-Ax
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 16:07:54 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5XyK-0005jD-7k
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 16:07:53 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9c41e95efcbso833763566b.3
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 13:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700600869; x=1701205669; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BaCFQVPsPU3RWyl13jVTgaxGiUbz/jYJ6BXu8Y7EwM8=;
 b=sMCIz+zkWtdnfGr+pEyi5L04EaaQJjds2u79JWjrcQliN2B9QS5dkr8mYHIWdyotsJ
 8Lk6gGwWH+iny0w8C7UrThkWiRWmfPYEvPBST7IhbXmO1M2yPGN4t6HVY+N9d9CHGu1v
 K7Vp4sq/oyJvCdsnKBajgKiYGI8FfEg2l0FGxyGhBv1kPGdpWf4MKGidRnhZ2vU/48/p
 R5q4pvOHrD93zltYZPPcKAFaIGuYzYuGRu+QLz+0n9k+ZmBSgPlruzbXvGlqkquPxkeY
 pqg4IGVk7MYDCILQECe59DCRkMcsExyzsb1Eg+Y3JKC3bC0rFmh76SXOXvpGuNPeOPxd
 PmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700600869; x=1701205669;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BaCFQVPsPU3RWyl13jVTgaxGiUbz/jYJ6BXu8Y7EwM8=;
 b=TyPd6plnUO7pdS4OI9Ma1907V+je2pPxzi0rzvvVW62IPKivEVE7KyXYrYcjNm+oWK
 dOv0U0YYtD120H0h5gyakTEQab6lx4alj70fTyJD3DLyqK2Gwiwk58UsYb04kk3U7m59
 Lr/iPj6CxGQFmZcSLu2Z/OqRGQOIBPqH/ob2zzUpGRhC27hLHlo3NPsucIOQ+Tlz0203
 HlIDzKfZMR958DU6RHmUvwwh5NjZfEcmFcVLOgJ7cUgpE2iqcKKZBmn8tFZQexFz6WnE
 BL49roFVgv/RqTa5fglrvhG1iwyw3vkrKrTZkPjAgLmIJ0qFNo/35LDG2EjhZZ5iTkNo
 bMcA==
X-Gm-Message-State: AOJu0Yxa6o6yzjXfgNrTL79LLu0cM3xQbC4duEvOAmNi0+hb8Ick7Sk+
 HnMrhukuDYZ+NnNgIvm3JmTwWw==
X-Google-Smtp-Source: AGHT+IEOoam1Dg7+OAeTbcJ0wbPYloQsZrTOZRD28p5gVg/tOd4PyBLOaIhbuGRig+XDU2A4suUERg==
X-Received: by 2002:a17:907:130d:b0:a02:14d6:424e with SMTP id
 vj13-20020a170907130d00b00a0214d6424emr52844ejb.56.1700600869526; 
 Tue, 21 Nov 2023 13:07:49 -0800 (PST)
Received: from [192.168.69.100] (lgp44-h02-176-184-8-219.dsl.sta.abo.bbox.fr.
 [176.184.8.219]) by smtp.gmail.com with ESMTPSA id
 p20-20020a170906a01400b009adc77fe164sm5671160ejy.66.2023.11.21.13.07.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Nov 2023 13:07:49 -0800 (PST)
Message-ID: <f0448a90-7096-4534-a75b-76f7e3dfc342@linaro.org>
Date: Tue, 21 Nov 2023 22:07:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu 1/1] Implement STM32L4x5 EXTI
Content-Language: en-US
To: ~aminier <arnaud.minier@telecom-paris.fr>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alistair@alistair23.me, peter.maydell@linaro.org,
 ines.varhol@telecom-paris.fr
References: <170057856467.12935.6421900912319796560-1@git.sr.ht>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <170057856467.12935.6421900912319796560-1@git.sr.ht>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

Hi Arnaud,

On 11/11/23 15:33, ~aminier wrote:
> From: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> 
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   hw/arm/Kconfig                    |   1 +
>   hw/arm/stm32l4x5_soc.c            |  65 +++++-
>   hw/misc/Kconfig                   |   3 +
>   hw/misc/meson.build               |   1 +
>   hw/misc/stm32l4x5_exti.c          | 329 ++++++++++++++++++++++++++++++
>   hw/misc/trace-events              |   5 +
>   include/hw/arm/stm32l4x5_soc.h    |   3 +
>   include/hw/misc/stm32l4x5_exti.h  |  64 ++++++
>   tests/qtest/meson.build           |   5 +
>   tests/qtest/stm32l4x5_exti-test.c | 102 +++++++++
>   10 files changed, 576 insertions(+), 2 deletions(-)
>   create mode 100644 hw/misc/stm32l4x5_exti.c
>   create mode 100644 include/hw/misc/stm32l4x5_exti.h
>   create mode 100644 tests/qtest/stm32l4x5_exti-test.c


> diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
> index 198d3f6d3e..6f2a1b34b3 100644
> --- a/hw/arm/stm32l4x5_soc.c
> +++ b/hw/arm/stm32l4x5_soc.c
> @@ -43,10 +43,51 @@
>   #define SRAM2_BASE_ADDRESS 0x10000000
>   #define SRAM2_SIZE (32 * KiB)
>   
> +static const hwaddr exti_addr = 0x40010400;

Why not a #define?

> +#define NUM_EXTI_IRQ 40


> diff --git a/hw/misc/stm32l4x5_exti.c b/hw/misc/stm32l4x5_exti.c


> +static void stm32l4x5_exti_set_irq(void *opaque, int irq, int level)
> +{
> +    Stm32l4x5ExtiState *s = opaque;
> +
> +    trace_stm32l4x5_exti_set_irq(irq, level);
> +
> +    if (irq >= NUM_INTERRUPT_OUT_LINES) {
> +        return;

This can not happen. If you are unsure, this would be a programming
error, thus aborting is better, but nothing needed IMO.

> +    }
> +
> +    if (irq < 32) {
> +        if (((1 << irq) & s->exti_rtsr1) && level) {
> +            /* Rising Edge */
> +            s->exti_pr1 |= 1 << irq;
> +        }
> +
> +        if (((1 << irq) & s->exti_ftsr1) && !level) {
> +            /* Falling Edge */
> +            s->exti_pr1 |= 1 << irq;
> +        }
> +
> +        if (!((1 << irq) & s->exti_imr1)) {
> +            /* Interrupt is masked */
> +            return;
> +        }
> +    } else {
> +        /* Shift the value to enable access in x2 registers*/
> +        int irq_x2 = irq - 32;
> +        if (((1 << irq_x2) & s->exti_rtsr2) && level) {
> +            /* Rising Edge */
> +            s->exti_pr2 |= 1 << irq_x2;
> +        }
> +
> +        if (((1 << irq_x2) & s->exti_ftsr2) && !level) {
> +            /* Falling Edge */
> +            s->exti_pr2 |= 1 << irq_x2;
> +        }
> +
> +        if (!((1 << irq_x2) & s->exti_imr2)) {
> +            /* Interrupt is masked */
> +            return;
> +        }
> +    }
> +    qemu_irq_pulse(s->irq[irq]);
> +}

Could be simpler avoiding duplication, as:

---
static void stm32l4x5_exti_set_irq(void *opaque, int irq, int level)
{
     Stm32l4x5ExtiState *s = opaque;
     int oirq = irq;
     uint32_t *rtsr;
     uint32_t *ftsr;
     uint32_t *pr;
     uint32_t *imr;

     trace_stm32l4x5_exti_set_irq(irq, level);

     if (irq < 32) {
         rtsr = &s->exti_rtsr1;
         ftsr = &s->exti_ftsr1;
         pr = &s->exti_pr1;
         imr = &s->exti_imr1;
     } else {
         rtsr = &s->exti_rtsr2;
         ftsr = &s->exti_ftsr2;
         pr = &s->exti_pr2;
         imr = &s->exti_imr2;
         /* Shift the value to enable access in x2 registers. */
         irq -= 32;
     }

     if (((1 << irq) & *rtsr) && level) {
         /* Rising Edge */
         *pr |= 1 << irq;
     }

     if (((1 << irq) & *ftsr) && !level) {
         /* Falling Edge */
         *pr |= 1 << irq;
     }

     if (!((1 << irq) & *imr)) {
         /* Interrupt is masked */
         return;
     }

     qemu_irq_pulse(s->irq[oirq]);
}
---

But changing Stm32l4x5ExtiState as:

---
struct Stm32l4x5ExtiState {
     SysBusDevice parent_obj;

     MemoryRegion mmio;

     uint32_t imr[2];
     uint32_t emr[2];
     uint32_t rtsr[2];
     uint32_t ftsr[2];
     uint32_t swier[2];
     uint32_t pr[2];

     qemu_irq irq[NUM_INTERRUPT_OUT_LINES];
};
---

We get even simpler:

---
static void stm32l4x5_exti_set_irq(void *opaque, int irq, int level)
{
     Stm32l4x5ExtiState *s = opaque;
     unsigned n = irq >= 32;
     int oirq = irq;

     trace_stm32l4x5_exti_set_irq(irq, level);

     if (irq >= 32) {
         /* Shift the value to enable access in x2 registers. */
         irq -= 32;
     }

     if (((1 << irq) & s->rtsr[n]) && level) {
         /* Rising Edge */
         s->pr[n] |= 1 << irq;
     }

     if (((1 << irq) & s->ftsr[n]) && !level) {
         /* Falling Edge */
         s->pr[n] |= 1 << irq;
     }

     if (!((1 << irq) & s->imr[n])) {
         /* Interrupt is masked */
         return;
     }

     qemu_irq_pulse(s->irq[oirq]);
}
---

(code untested).

> +
> +static uint64_t stm32l4x5_exti_read(void *opaque, hwaddr addr,
> +                                    unsigned int size)
> +{
> +    Stm32l4x5ExtiState *s = opaque;
> +    uint32_t r = 0;

        unsigned n = addr >= EXTI_IMR2;
> +
> +    switch (addr) {
> +    case EXTI_IMR1:
> +        r = s->exti_imr1;
> +        break;

This becomes:

        case EXTI_IMR1:
        case EXTI_IMR2:
            r = s->exti_imr[n];
            break;
        ...

> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "STM32L4X5_exti_read: Bad offset %x\n", (int)addr);

Please use '0x' prefix for hexadecimal.

> +        break;
> +    }
> +
> +    trace_stm32l4x5_exti_read(addr, r);
> +
> +    return r;
> +}


> +static const MemoryRegionOps stm32l4x5_exti_ops = {
> +    .read = stm32l4x5_exti_read,
> +    .write = stm32l4x5_exti_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,

Your implementation is 32-bit wide (all your registers are),
so:

        .impl.min_access_size = 4,
        .impl.max_access_size = 4,

What are the allowed accesses? any 8/16/32/64 bits?
(This is what happens when .valid fields aren't set).

> +};


> +static void stm32l4x5_exti_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->reset = stm32l4x5_exti_reset;

Better set a ResettableClass handler. DeviceClass::reset will soon
be deprecated.

> +    dc->vmsd = &vmstate_stm32l4x5_exti;
> +}


> +static void stm32l4x5_exti_register_types(void)
> +{
> +    type_register_static(&stm32l4x5_exti_info);
> +}

Preferably use the DEFINE_TYPES() macro.

> +type_init(stm32l4x5_exti_register_types)


> diff --git a/include/hw/misc/stm32l4x5_exti.h b/include/hw/misc/stm32l4x5_exti.h
> new file mode 100644
> index 0000000000..4305e7fcbb
> --- /dev/null
> +++ b/include/hw/misc/stm32l4x5_exti.h
> @@ -0,0 +1,64 @@
> +/*
> + * STM32L4x5 SoC family EXTI


"STM32L4x5 EXTI (Extended interrupts and events controller)"


> +#define NUM_GPIO_EVENT_IN_LINES 16

Since not used externally, NUM_GPIO_EVENT_IN_LINES could be
restricted to the source.

> +#define NUM_INTERRUPT_OUT_LINES 40
> +
> +struct Stm32l4x5ExtiState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion mmio;
> +
> +    uint32_t exti_imr1;
> +    uint32_t exti_emr1;
> +    uint32_t exti_rtsr1;
> +    uint32_t exti_ftsr1;
> +    uint32_t exti_swier1;
> +    uint32_t exti_pr1;
> +    uint32_t exti_imr2;
> +    uint32_t exti_emr2;
> +    uint32_t exti_rtsr2;
> +    uint32_t exti_ftsr2;
> +    uint32_t exti_swier2;
> +    uint32_t exti_pr2;

See previous suggestion for Stm32l4x5ExtiState. Besides, no
need to use the cumbersome 'exti_' prefix.

> +    qemu_irq irq[NUM_INTERRUPT_OUT_LINES];
> +};
> +
> +#endif

Good patch quality, looking forward for v2!

Regards,

Phil.

