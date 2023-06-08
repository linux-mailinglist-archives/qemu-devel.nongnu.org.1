Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB99728201
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:59:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7G9z-0006Kv-0v; Thu, 08 Jun 2023 09:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7G9s-0005tJ-Hw
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:58:36 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7G9p-0005BI-72
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:58:36 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5148e4a2f17so1140446a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 06:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686232711; x=1688824711;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9bfRkPTdVki0MaTXaET7dkyrmyM+zjhNDGF1bvQBBN8=;
 b=UTUH4ArIGF4M/+DGkqU0/XKIun13EQnVsGeaSPZs3HMHfyACer3Utk8gRrmkeHIRdM
 7dFBY9npgWsmEzO7SNtVq/Qv/wDk0ybNJxL6X8gYczmN0H9z2nJq6I4GqIXnHq5HyU+A
 ph3li9VSIqDWstAHxVDsMjsZWwEPWeJVR+uGFu3EkyKnmqHEkISjVeS2EUO8aDDH6CJa
 pVfKXkEiLq1hnJeXEzqPPbjy+e1bhxGKf00j0s038KAaiSUJOc+fdeenvNILuj+UEIqg
 VVH616roCEUnDRaPAlioY31FMNkUZgBpfhZ1ZshxQXa7jNAD+PMhsAl9jZp3r8plN5Ut
 1AVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686232711; x=1688824711;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9bfRkPTdVki0MaTXaET7dkyrmyM+zjhNDGF1bvQBBN8=;
 b=IwlBMTNfalHuTtCzZ4623Y/5f7OVljxA/MuN+ejZnt8HEMX6mI8Ro027USn49P1zy5
 1saJssenG/+cGuulMM99RmFk8DrlEJVm/mRJfMiDaNg0JSGOAq84D9ozqk7qExuUb3Zl
 Xa0q4p12s5Q4FPbukNSKjsKsQI7TthjStEXctxjbqtcMUYo+N1yw/pMvlgbLxiWPSlWS
 L6eGdgIFvdJeTbyD1xF8sWBvkHCikjNcM2WkkTE9hxo6L5cKmE9CILLFHMf1IJfy8uZR
 KM2bjNYyXrEYlTAp8QcqgpYK2F+Wa7dLHMsGWr8+PekuwEKeQjpPCPJhMO+shruf9uDC
 1UAA==
X-Gm-Message-State: AC+VfDyqgAoQj/oxZ3maIwI97KRQXA+l065N1AreVZTWAl0LBhKOGKYC
 V8DYcRhntk6djvQNQSR/zJaRLg0MINWFtawxuiguC0plfiavHmBiVvQ=
X-Google-Smtp-Source: ACHHUZ4+AGOY0tUCI6eoAab/r0oqZGb5gGBgqr87TDU7yyIgiGrpyuOTFgRsHYsEq1gjDqQ4elxj2ptyAxeb991Ww/E=
X-Received: by 2002:a05:6402:6c6:b0:506:9805:7b56 with SMTP id
 n6-20020a05640206c600b0050698057b56mr6962122edy.32.1686232711465; Thu, 08 Jun
 2023 06:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230517081204.30333-1-m.elsayed4420@gmail.com>
 <20230517081204.30333-5-m.elsayed4420@gmail.com>
In-Reply-To: <20230517081204.30333-5-m.elsayed4420@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Jun 2023 14:58:20 +0100
Message-ID: <CAFEAcA_83cpxPY2TGcwObbGe2MEgJfS2GVeR6UfiB6PUMFCw8A@mail.gmail.com>
Subject: Re: [PATCH 4/8] tiva c sysctl implementation
To: Mohamed ElSayed <m.elsayed4420@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Wed, 17 May 2023 at 09:13, Mohamed ElSayed <m.elsayed4420@gmail.com> wrote:
>
> Signed-off-by: Mohamed ElSayed <m.elsayed4420@gmail.com>
> ---
>  hw/misc/tm4c123_sysctl.c         | 989 +++++++++++++++++++++++++++++++
>  hw/misc/trace-events             |   5 +
>  include/hw/misc/tm4c123_sysctl.h | 307 ++++++++++
>  3 files changed, 1301 insertions(+)
>  create mode 100644 hw/misc/tm4c123_sysctl.c
>  create mode 100644 include/hw/misc/tm4c123_sysctl.h
>
> diff --git a/hw/misc/tm4c123_sysctl.c b/hw/misc/tm4c123_sysctl.c
> new file mode 100644
> index 0000000000..c996609fc7
> --- /dev/null
> +++ b/hw/misc/tm4c123_sysctl.c
> @@ -0,0 +1,989 @@
> +/*
> + * TM4C123 SYSCTL
> + *
> + * Copyright (c) 2023 Mohamed ElSayed <m.elsayed4420@gmail.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/misc/tm4c123_sysctl.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "trace.h"
> +
> +#define LOG(mask, fmt, args...) qemu_log_mask(mask, "%s: " fmt, __func__, ## args)
> +#define READONLY LOG(LOG_GUEST_ERROR, "0x%"HWADDR_PRIx" is a readonly field\n.", addr)

See the remarks in an earlier patch about these macros.

> +
> +static void tm4c123_sysctl_update_system_clock(void *opaque)
> +{
> +    TM4C123SysCtlState *s = opaque;
> +
> +    uint32_t RCC_Val = s->sysctl_rcc;
> +    uint32_t RCC2_Val = s->sysctl_rcc2;
> +
> +    uint32_t __CORE_CLK_PRE;
> +    uint32_t __CORE_CLK;

Please don't use double-underscore prefixes or all-caps for
variables.

> +
> +    if (RCC2_Val & (1UL << 31)) {  /* is rcc2 used? */
> +        if (RCC2_Val & (1UL << 11)) {  /* check BYPASS */
> +            if (((RCC2_Val >> 4) & 0x07) == 0x0) {
> +                if (((RCC_Val >> 6) & 0x1F) == 0x0) {
> +                    __CORE_CLK_PRE = 1000000UL;
> +                } else if (((RCC_Val >> 6) & 0x1F) == 0x1) {
> +                    __CORE_CLK_PRE = 1843200UL;
> +                } else if (((RCC_Val >> 6) & 0x1F) == 0x2) {
> +                    __CORE_CLK_PRE = 2000000UL;
> +                } else if (((RCC_Val >> 6) & 0x1F) == 0x3) {
> +                    __CORE_CLK_PRE = 2457600UL;
> +                } else if (((RCC_Val >> 6) & 0x1F) == 0x4) {
> +                    __CORE_CLK_PRE = 3579545UL;
> +                } else if (((RCC_Val >> 6) & 0x1F) == 0x5) {
> +                    __CORE_CLK_PRE = 3686400UL;
> +                } else if (((RCC_Val >> 6) & 0x1F) == 0x6) {
> +                    __CORE_CLK_PRE = 4000000UL;
> +                } else if (((RCC_Val >> 6) & 0x1F) == 0x7) {
> +                    __CORE_CLK_PRE = 4096000UL;
> +                } else if (((RCC_Val >> 6) & 0x1F) == 0x8) {
> +                    __CORE_CLK_PRE = 4915200UL;
> +                } else if (((RCC_Val >> 6) & 0x1F) == 0x9) {
> +                    __CORE_CLK_PRE = 5000000UL;
> +                } else if (((RCC_Val >> 6) & 0x1F) == 0xA) {
> +                    __CORE_CLK_PRE = 5120000UL;
> +                } else if (((RCC_Val >> 6) & 0x1F) == 0xB) {
> +                    __CORE_CLK_PRE = 6000000UL;
> +                } else if (((RCC_Val >> 6) & 0x1F) == 0xC) {
> +                    __CORE_CLK_PRE = 6144000UL;
> +                } else if (((RCC_Val >> 6) & 0x1F) == 0xD) {
> +                    __CORE_CLK_PRE = 7372800UL;
> +                } else if (((RCC_Val >> 6) & 0x1F) == 0xE) {
> +                    __CORE_CLK_PRE = 8000000UL;
> +                } else if (((RCC_Val >> 6) & 0x1F) == 0xF) {
> +                    __CORE_CLK_PRE = 8192000UL;
> +                } else if (((RCC_Val >> 6) & 0x1F) == 0x10) {
> +                    __CORE_CLK_PRE = 10000000UL;
> +                } else if (((RCC_Val >> 6) & 0x1F) == 0x11) {
> +                    __CORE_CLK_PRE = 12000000UL;
> +                } else if (((RCC_Val >> 6) & 0x1F) == 0x12) {
> +                    __CORE_CLK_PRE = 12288000UL;
> +                } else if (((RCC_Val >> 6) & 0x1F) == 0x13) {
> +                    __CORE_CLK_PRE = 13560000UL;
> +                } else if (((RCC_Val >> 6) & 0x1F) == 0x14) {
> +                    __CORE_CLK_PRE = 14318180UL;
> +                } else if (((RCC_Val >> 6) & 0x1F) == 0x15) {
> +                    __CORE_CLK_PRE = 16000000UL;
> +                } else if (((RCC_Val >> 6) & 0x1F) == 0x16) {
> +                    __CORE_CLK_PRE = 16384000UL;
> +                } else if (((RCC_Val >> 6) & 0x1F) == 0x17) {
> +                    __CORE_CLK_PRE = 18000000UL;
> +                } else if (((RCC_Val >> 6) & 0x1F) == 0x18) {
> +                    __CORE_CLK_PRE = 20000000UL;
> +                } else if (((RCC_Val >> 6) & 0x1F) == 0x19) {
> +                    __CORE_CLK_PRE = 24000000UL;
> +                } else if (((RCC_Val >> 6) & 0x1F) == 0x1A) {
> +                    __CORE_CLK_PRE = 25000000UL;
> +                } else {
> +                    __CORE_CLK_PRE = 0UL;
> +                }
> +                __CORE_CLK = __CORE_CLK_PRE / 2UL;  /* divide by 2 since BYPASS is set */
> +            } else {  /* PLL is used */
> +                uint32_t __PLL_MULT = ((RCC2_Val >> 4) & 0x1F) + 2;
> +                uint32_t __PLL_DIV = ((RCC2_Val >> 0) & 0x3F) + 1;
> +                uint32_t __PLL_SOURCE = ((RCC2_Val >> 13) & 0x01);
> +                if (__PLL_SOURCE == 0) {  /* source is XTAL */
> +                    __CORE_CLK_PRE = (XTALI * __PLL_MULT) / __PLL_DIV;
> +                } else {  /* source is internal oscillator */
> +                    __CORE_CLK_PRE = (16000000UL * __PLL_MULT) / __PLL_DIV;  /* internal oscillator frequency is 16MHz */
> +                }
> +                __CORE_CLK = __CORE_CLK_PRE / 2UL;  /* divide by 2 since BYPASS is set */
> +            }
> +        } else {  /* BYPASS is not set */
> +            uint32_t __SYS_DIV = ((RCC2_Val >> 22) & 0x7F) + 1;
> +            uint32_t __PLL_MULT = ((RCC2_Val >> 4) & 0x1F) + 2;
> +            uint32_t __PLL_DIV = ((RCC2_Val >> 0) & 0x3F) + 1;
> +            uint32_t __PLL_SOURCE = ((RCC2_Val >> 13) & 0x01);
> +            if (__PLL_SOURCE == 0) {  /* source is XTAL */
> +                __CORE_CLK_PRE = (XTALI * __PLL_MULT) / __PLL_DIV;
> +            } else {  /* source is internal oscillator */
> +                __CORE_CLK_PRE = (16000000UL * __PLL_MULT) / __PLL_DIV;  /* internal oscillator frequency is 16MHz */
> +            }
> +            __CORE_CLK = __CORE_CLK_PRE / __SYS_DIV;
> +        }
> +    } else {  /* rcc2 is not used */
> +        if (((RCC_Val >> 16) & 0x01) == 0x01) {  /* check USESYSCLK */
> +            if (((RCC_Val >> 23) & 0x01) == 0x01) {  /* check BYPASS */
> +                __CORE_CLK_PRE = XTALI;
> +            } else {  /* PLL is used */
> +                uint32_t __PLL_MULT = ((RCC_Val >> 18) & 0x1F) + 2;
> +                uint32_t __PLL_DIV = ((RCC_Val >> 12) & 0x3F) + 1;
> +                uint32_t __PLL_SOURCE = ((RCC_Val >> 16) & 0x01);
> +                if (__PLL_SOURCE == 0) {  /* source is XTAL */
> +                    __CORE_CLK_PRE = (XTALI * __PLL_MULT) / __PLL_DIV;
> +                } else {  /* source is internal oscillator */
> +                    __CORE_CLK_PRE = (16000000UL * __PLL_MULT) / __PLL_DIV;  /* internal oscillator frequency is 16MHz */
> +                }
> +            }
> +        } else {  /* USESYSCLK bit is not set */
> +            __CORE_CLK_PRE = 16000000UL;  /* default to internal oscillator frequency */
> +        }
> +        __CORE_CLK = __CORE_CLK_PRE / 1UL;  /* no division needed since BYPASS is not set */
> +    }
> +    trace_tm4c123_sysctl_update_system_clock(__CORE_CLK);
> +    clock_update_hz(s->mainclk, __CORE_CLK);
> +}

> +static void tm4c123_sysctl_write(void *opaque, hwaddr addr, uint64_t val64, unsigned int size)
> +{
> +    TM4C123SysCtlState *s = opaque;
> +    uint32_t val32 = val64;
> +
> +    trace_tm4c123_sysctl_write(addr, val32);
> +
> +    switch (addr) {
> +        case SYSCTL_DID0:
> +            READONLY;
> +            break;
> +        case SYSCTL_DID1:
> +            READONLY;
> +            break;
> +        case SYSCTL_PBORCTL:
> +            s->sysctl_pborctl = val32;
> +            break;
> +        case SYSCTL_RIS:
> +            READONLY;
> +            break;
> +        case SYSCTL_IMC:
> +            s->sysctl_imc = val32;
> +            /*
> +             * setting the MISC
> +             */
> +            s->sysctl_misc = val32;
> +            break;

What's this for? The spec does not say anything about the MISC
register being written by the IMC. In fact the MISC is just
the masked status of the current interrupts, so it shouldn't
have a status field at all. Reading the MISC register ought
to return s->sysctl_ris & s->sysctl_imc.

> +        case SYSCTL_MISC:
> +            s->sysctl_misc = val32;

Writing to MISC should change bits in RIS on a write-on-to-clear
basis, so this isn't right. It should be
   s->sysctl_ris &= ~val32; /* W1C */

> +            break;

> +        case SYSCTL_RESC:
> +            s->sysctl_resc = val32;
> +            break;
> +        case SYSCTL_RCC:
> +            s->sysctl_rcc = val32;
> +            /*
> +             * Setting the SYSCTL_RIS manually for now.
> +             */
> +            if (s->sysctl_rcc & SYSCTL_RCC_PWRDN && !(s->sysctl_rcc2 & SYSCTL_RCC2_USERCC2)) {
> +                s->sysctl_ris |= SYSCTL_RIS_PLLRIS;
> +            }

I don't entirely understand the comment here. My guess is that we're
opting for "report the PLL as locked immediately rather than
emulating the real hardware's timed delay before reporting it"
(which is fine, though I think the comment could be clearer
about what it's doing).

However should we really be testing PWRDN == 1 here ? That means
"PLL powered down", not "powered up"; it doesn't match the logic
you have below for the similar RCC2 bits either.

> +            tm4c123_sysctl_update_system_clock(s);
> +            break;
> +        case SYSCTL_GPIOHBCTL:
> +            s->sysctl_gpiohbctl = val32;
> +            break;
> +        case SYSCTL_RCC2:
> +            s->sysctl_rcc2 = val32;
> +            /*
> +             * Setting the SYSCTL_RIS manually for now.
> +             */
> +            if (s->sysctl_rcc2 & SYSCTL_RCC2_USERCC2 && !(s->sysctl_rcc2 & SYSCTL_RCC2_PWRDN2)) {
> +                s->sysctl_ris |= SYSCTL_RIS_PLLRIS;
> +            }
> +            tm4c123_sysctl_update_system_clock(s);

Because the logic for "do we set the PLLRIS bit?" depends
on both the rcc and rcc2 values, you need to check everything
in both places. Otherwise if the guest writes RCC.PWRDN to
0 first and RCC2.USERCC2 to 0 second then you won't notice.
So I think you should move this logic to the
tm4c123_sysctl_update_system_clock() function.

> +            break;

> +
> +static void tm4c123_sysctl_class_init(ObjectClass *kclass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(kclass);
> +    dc->reset = tm4c123_sysctl_reset;
> +    dc->realize = tm4c123_sysctl_realize;

You also need to set dc->vmsd. (Every device with internal
state needs to set up a VMStateDescription, which describes
that internal state for the purposes of migration and
for VM state save/restore.)

thanks
-- PMM

