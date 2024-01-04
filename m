Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BB782428C
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 14:15:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLNYP-0003yU-0J; Thu, 04 Jan 2024 08:14:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLNYM-0003y1-P4
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 08:14:30 -0500
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLNYK-0004nE-Un
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 08:14:30 -0500
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4283cc63c04so2888791cf.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 05:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704374068; x=1704978868; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/5eJ73uL6SIPSMtx/cWI8TACp9c8WZ4bl9KoSeR2bTM=;
 b=d1jEKooK+mzHHV8TbwB2ftxhiNXVl+vXV6311po7xawZNPXr86c07F9kGoFKEGoCvQ
 Io0nsJk3qjyeor7G7cFl3+7a7tnXdtVwxdhLF8fPBVO1IkEiAUoSvaInkAJZVDfolPfF
 6jTkJOqd/IGi6Qn17F71ehI+fWWRnigjlJWR4kqXVEKLX8G4GFHYdUEMLK0YRzj7rqUg
 L1n9QDNLIDZRku+R9/Xh6aJgEo1xFiDP3wSkkg9mLCwvKimrxHN4RsUk4AvKvEZz7snz
 1l+sBew69BZ7MzrFYxaQME7cxdBbn3K3JfJ5mJEXah58X9DfS8StUpCqlH4FxdHXyY85
 c5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704374068; x=1704978868;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/5eJ73uL6SIPSMtx/cWI8TACp9c8WZ4bl9KoSeR2bTM=;
 b=td+ucbR94Rqbeurc9PjouOHpCq2HVvMiHNUauYLdMPFF5S52BEAPRssR6baxZyHf1y
 rNDkiGfr6Cvbs3qhVvOXLpnZoafnnICZYADBifBohMm1A2cKDGKemhIIqbakI2qgdEjs
 1g8+AqcJSnQlrRQSsls1OY7lsuJDVDOYJs7vSuJ/ykVdMz1nBQCqby8ovm3S5Vv+ys4J
 PC+iYeZx5SgC80JgZeqLSWW6SF01QqE3sRH00u8Ntl25k8khQH8pP6TO6ZlDSUeviYgF
 FIj3Ls9b65jS6vHe/gk3oGmQduaeOtaGOsyMaA1qorjITqpnvukoobnADIDGrwYv+l2u
 Et5A==
X-Gm-Message-State: AOJu0YxoKBCMmYgKtkDPl0O71ySsOuNjmkuJujEo7cncI/9okL0aa6hf
 ktnMdRrdlCKt9ouB/k99D7ZIXKrFetmYjQ==
X-Google-Smtp-Source: AGHT+IGKEOvCqJEQv9cGauumM0UhaOkbZ8WDYJ1mcS5iYAeBhKhhxSaEUTLyk5pvfNoZ6V5kYkBfqA==
X-Received: by 2002:ac8:59c5:0:b0:425:4043:50ec with SMTP id
 f5-20020ac859c5000000b00425404350ecmr681208qtf.123.1704374067880; 
 Thu, 04 Jan 2024 05:14:27 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.232])
 by smtp.gmail.com with ESMTPSA id
 gb12-20020a05622a598c00b0042753a7ada2sm15157427qtb.85.2024.01.04.05.14.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jan 2024 05:14:27 -0800 (PST)
Message-ID: <908650b4-3bb2-4cf2-8909-5bffc622950f@linaro.org>
Date: Thu, 4 Jan 2024 14:14:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] hw/misc: Implement STM32L4x5 EXTI
Content-Language: en-US
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org
References: <20231228161944.303768-1-ines.varhol@telecom-paris.fr>
 <20231228161944.303768-2-ines.varhol@telecom-paris.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231228161944.303768-2-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=philmd@linaro.org; helo=mail-qt1-x836.google.com
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

On 28/12/23 17:19, Inès Varhol wrote:
> Although very similar to the STM32F4xx EXTI, STM32L4x5 EXTI generates
> more than 32 event/interrupt requests and thus uses more registers
> than STM32F4xx EXTI which generates 23 event/interrupt requests.
> 
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   docs/system/arm/b-l475e-iot01a.rst |   5 +-
>   hw/misc/Kconfig                    |   3 +
>   hw/misc/meson.build                |   1 +
>   hw/misc/stm32l4x5_exti.c           | 288 +++++++++++++++++++++++++++++
>   hw/misc/trace-events               |   5 +
>   include/hw/misc/stm32l4x5_exti.h   |  51 +++++
>   6 files changed, 350 insertions(+), 3 deletions(-)
>   create mode 100644 hw/misc/stm32l4x5_exti.c
>   create mode 100644 include/hw/misc/stm32l4x5_exti.h


> +static void stm32l4x5_exti_write(void *opaque, hwaddr addr,
> +                                 uint64_t val64, unsigned int size)
> +{
> +    Stm32l4x5ExtiState *s = opaque;
> +    const uint32_t value = (uint32_t)val64;
> +
> +    trace_stm32l4x5_exti_write(addr, value);
> +
> +    switch (addr) {
> +    case EXTI_IMR1:
> +        s->imr[0] = value;
> +        return;
> +    case EXTI_EMR1:
> +        s->emr[0] = value;
> +        return;
> +    case EXTI_RTSR1:
> +        s->rtsr[0] = value & ~DIRECT_LINE_MASK1;
> +        return;
> +    case EXTI_FTSR1:
> +        s->ftsr[0] = value & ~DIRECT_LINE_MASK1;
> +        return;
> +    case EXTI_SWIER1:
> +        const uint32_t set1 = value & ~DIRECT_LINE_MASK1;
> +        const uint32_t pend1 = set1 & ~s->swier[0] & s->imr[0] & ~s->pr[0];
> +        s->swier[0] = set1;
> +        s->pr[0] |= pend1;
> +        for (int i = 0; i < 32; i++) {
> +            if (pend1 & (1 << i)) {
> +                qemu_irq_pulse(s->irq[i]);
> +            }
> +        }
> +        return;
> +    case EXTI_PR1:
> +        const uint32_t cleared1 = s->pr[0] & value & ~DIRECT_LINE_MASK1;
> +        /* This bit is cleared by writing a 1 to it */
> +        s->pr[0] &= ~cleared1;
> +        /* Software triggered interrupts are cleared as well */
> +        s->swier[0] &= ~cleared1;
> +        return;
> +    case EXTI_IMR2:
> +        s->imr[1] = value & ~RESERVED_BITS_MASK2;
> +        return;
> +    case EXTI_EMR2:
> +        s->emr[1] = value & ~RESERVED_BITS_MASK2;
> +        return;
> +    case EXTI_RTSR2:
> +        s->rtsr[1] = value & ACTIVABLE_MASK2;
> +        return;
> +    case EXTI_FTSR2:
> +        s->ftsr[1] = value & ACTIVABLE_MASK2;
> +        return;
> +    case EXTI_SWIER2:
> +        const uint32_t set2 = value & ACTIVABLE_MASK2;
> +        const uint32_t pend2 = set2 & ~s->swier[1] & s->imr[1] & ~s->pr[1];
> +        s->swier[1] = set2;
> +        s->pr[1] |= pend2;
> +        for (int i = 0; i < 8; i++) {
> +            if (pend2 & (1 << i)) {
> +                qemu_irq_pulse(s->irq[32 + i]);
> +            }
> +        }
> +        return;
> +    case EXTI_PR2:
> +        const uint32_t cleared = s->pr[1] & value & ACTIVABLE_MASK2;
> +        /* This bit is cleared by writing a 1 to it */
> +        s->pr[1] &= ~cleared;
> +        /* Software triggered interrupts are cleared as well */
> +        s->swier[1] &= ~cleared;
> +        return;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "STM32L4X5_exti_write: Bad offset 0x%x\n", (int)addr);
> +    }
> +}

This doesn't build:

../../hw/misc/stm32l4x5_exti.c:172:9: error: expected expression
         const uint32_t set1 = value & ~DIRECT_LINE_MASK1;
         ^
../../hw/misc/stm32l4x5_exti.c:173:32: error: use of undeclared 
identifier 'set1'
         const uint32_t pend1 = set1 & ~s->swier[0] & s->imr[0] & ~s->pr[0];
                                ^
../../hw/misc/stm32l4x5_exti.c:174:23: error: use of undeclared 
identifier 'set1'
         s->swier[0] = set1;
                       ^
../../hw/misc/stm32l4x5_exti.c:183:9: error: expected expression
         const uint32_t cleared1 = s->pr[0] & value & ~DIRECT_LINE_MASK1;
         ^
../../hw/misc/stm32l4x5_exti.c:185:22: error: use of undeclared 
identifier 'cleared1'
         s->pr[0] &= ~cleared1;
                      ^
../../hw/misc/stm32l4x5_exti.c:187:25: error: use of undeclared 
identifier 'cleared1'
         s->swier[0] &= ~cleared1;
                         ^
../../hw/misc/stm32l4x5_exti.c:202:9: error: expected expression
         const uint32_t set2 = value & ACTIVABLE_MASK2;
         ^
../../hw/misc/stm32l4x5_exti.c:203:32: error: use of undeclared 
identifier 'set2'
         const uint32_t pend2 = set2 & ~s->swier[1] & s->imr[1] & ~s->pr[1];
                                ^
../../hw/misc/stm32l4x5_exti.c:204:23: error: use of undeclared 
identifier 'set2'
         s->swier[1] = set2;
                       ^
../../hw/misc/stm32l4x5_exti.c:213:9: error: expected expression
         const uint32_t cleared = s->pr[1] & value & ACTIVABLE_MASK2;
         ^
../../hw/misc/stm32l4x5_exti.c:215:22: error: use of undeclared 
identifier 'cleared'
         s->pr[1] &= ~cleared;
                      ^
../../hw/misc/stm32l4x5_exti.c:217:25: error: use of undeclared 
identifier 'cleared'
         s->swier[1] &= ~cleared;
                         ^
14 errors generated.

I could build using:

-- >8 --
diff --git a/hw/misc/stm32l4x5_exti.c b/hw/misc/stm32l4x5_exti.c
index 81c901d3e5..aedf1fb370 100644
--- a/hw/misc/stm32l4x5_exti.c
+++ b/hw/misc/stm32l4x5_exti.c
@@ -170,3 +170,3 @@ static void stm32l4x5_exti_write(void *opaque, 
hwaddr addr,
          return;
-    case EXTI_SWIER1:
+    case EXTI_SWIER1: {
          const uint32_t set1 = value & ~DIRECT_LINE_MASK1;
@@ -181,3 +181,4 @@ static void stm32l4x5_exti_write(void *opaque, 
hwaddr addr,
          return;
-    case EXTI_PR1:
+    }
+    case EXTI_PR1: {
          const uint32_t cleared1 = s->pr[0] & value & ~DIRECT_LINE_MASK1;
@@ -188,2 +189,3 @@ static void stm32l4x5_exti_write(void *opaque, 
hwaddr addr,
          return;
+    }
      case EXTI_IMR2:
@@ -200,3 +202,3 @@ static void stm32l4x5_exti_write(void *opaque, 
hwaddr addr,
          return;
-    case EXTI_SWIER2:
+    case EXTI_SWIER2: {
          const uint32_t set2 = value & ACTIVABLE_MASK2;
@@ -211,3 +213,4 @@ static void stm32l4x5_exti_write(void *opaque, 
hwaddr addr,
          return;
-    case EXTI_PR2:
+    }
+    case EXTI_PR2: {
          const uint32_t cleared = s->pr[1] & value & ACTIVABLE_MASK2;
@@ -218,2 +221,3 @@ static void stm32l4x5_exti_write(void *opaque, 
hwaddr addr,
          return;
+    }
      default:

---

