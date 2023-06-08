Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C6C728177
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:37:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Foi-0000tf-0D; Thu, 08 Jun 2023 09:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7Foa-0000oT-Fw
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:36:37 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7FoU-0007PH-Hp
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:36:35 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5149e65c218so1104441a12.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 06:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686231385; x=1688823385;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oaCSIAHcbV+4he+iDkUHMV1vnskjnyZfMyUPy6EOHu8=;
 b=JAUQuVha2nmPB3EPQ6sDaNBxV1JrqE+8GYoDIv5C8DwLE+2JgpzXAzhyMbPefHKarA
 EA0iG8f4AjbYfUjppsw/l5oLfV6NLFO7CMonlNwYW+aBU3uTnzv8qvCQ9kRrafR8VWPW
 aJ6sJREjCO/fWlzCGUpUqovkVTz5ULpjGYlPPI3bN6ZOsyfObj3QYTjTPsIlfHvN7DS3
 MGoCdNm386qPRRqqjQPuMvpeIID7TOxfGb90F6XkObbQOT5gbaNoCyP44qI6OcdElgB5
 8cGbQlNsjwTtpSZhyeXXbL3dFKIAujhvGYVS2uc7E+xjEfczoiRdtKN7BkIAmZIXVkEm
 G20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686231385; x=1688823385;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oaCSIAHcbV+4he+iDkUHMV1vnskjnyZfMyUPy6EOHu8=;
 b=Amox3luypHuOPPpIzhBCndMeu7/2YxeD5p7wTz77l9SLd7EO/f91b2b9ETrDKLGz+H
 OlNkW+oC85eKFPlqa4m0dpuGQjdx/rf6AASVMkB6fvcitApDogpBwNjEfl1+EW6mmMPo
 G4xGHKBacHGn/lgsaqmB4WgExVkXbePOjwtn28iwxyOVMbCyXo1YShA0RDBjT8p4IsVr
 ZQ6yccGFKaVzQ5wo1Dgmc8XedmgQfnuMLgHg6SROlLrguQEhYNXtHVRL2swNgJJOoxSy
 3rnkV/fNwIVNr0SGR5wMLxBzpLp1oG3OKgHaZlXpBVRh/WhMfoN3zzaasMfcaKXC7HGz
 loUw==
X-Gm-Message-State: AC+VfDzHB3ludZwWxXwyj7nUAQsLTMQR50JQiRpOQscn3oEckMtvcoLx
 RQ75A0OSbTFCEye5Uau6a0Z1HVkDhmpEcLUYYUM16zFrkaIV4R4mr5Q=
X-Google-Smtp-Source: ACHHUZ6KVyDLwMlx1ZIBPdb+UX705gNqDADP8DGM6IhFxSxDNRKOF6dPU1FacL6zmm5rJVKkm67CSkKVk793n51usXI=
X-Received: by 2002:aa7:de16:0:b0:514:abb9:7ab1 with SMTP id
 h22-20020aa7de16000000b00514abb97ab1mr7260635edv.8.1686231385589; Thu, 08 Jun
 2023 06:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230517081204.30333-1-m.elsayed4420@gmail.com>
 <20230517081204.30333-3-m.elsayed4420@gmail.com>
In-Reply-To: <20230517081204.30333-3-m.elsayed4420@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Jun 2023 14:36:14 +0100
Message-ID: <CAFEAcA_tOGAU2wu_Pj_tq1zP--UTsKKeeGbnZ+SqGBk0X5HvQA@mail.gmail.com>
Subject: Re: [PATCH 2/8] tiva c usart module implementation
To: Mohamed ElSayed <m.elsayed4420@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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
>  hw/char/tm4c123_usart.c         | 381 ++++++++++++++++++++++++++++++++
>  hw/char/trace-events            |   4 +
>  include/hw/char/tm4c123_usart.h | 124 +++++++++++

Patches that add new device source files should also have
the changes to the Kconfig and meson.build files that tie
them in to the build system (which you currently have put
all together in patch 8).

>  3 files changed, 509 insertions(+)
>  create mode 100644 hw/char/tm4c123_usart.c
>  create mode 100644 include/hw/char/tm4c123_usart.h
>
> diff --git a/hw/char/tm4c123_usart.c b/hw/char/tm4c123_usart.c
> new file mode 100644
> index 0000000000..21bfe781b0
> --- /dev/null
> +++ b/hw/char/tm4c123_usart.c
> @@ -0,0 +1,381 @@
> +/*
> + * TM4C123 USART
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

TI don't explicitly say so, but this UART is a variant of the PL011.
So I think instead of a completely separate model for it, we should
extend the hw/char/pl011.c code to handle any specific new behaviour
we need for this variant. There's already handling in pl011.c
for the TYPE_PL011_LUMINARY, which is an older TI-specific PL011
flavour, so you have a pattern to work with. For that variant the
only thing we needed to override was the ID register values; you
might need a little bit more for this one, but likely not much.

So below I've only noted a few things rather than doing a review
of the whole device.

> +#include "qemu/osdep.h"
> +#include "hw/char/tm4c123_usart.h"
> +#include "hw/irq.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "trace.h"
> +
> +#define LOG(mask, fmt, args...) qemu_log_mask(mask, "%s: " fmt, __func__, ## args)

Please don't hide simple calls to qemu_log_mask() behind
macros like this.

> +#define READONLY LOG(LOG_GUEST_ERROR, "0x%"HWADDR_PRIx" is a readonly field\n.", addr)

If you put all the readonly registers together and let them
fall through, ie.
   case USART_FR:
   case USART_RIS:
       /* etc */
       qemu_log_mask(...);

then you only need one line which reports the write to a read-only
register, and the macro isn't really necessary.

(Also, stray trailing '.' after the newline.)


> +
> +static bool usart_clock_enabled(TM4C123SysCtlState *s, hwaddr addr)
> +{
> +    switch (addr) {
> +        case USART_0:
> +            return s->sysctl_rcgcuart & (1 << 0);
> +            break;
> +        case USART_1:
> +            return s->sysctl_rcgcuart & (1 << 1);
> +            break;
> +        case USART_2:
> +            return s->sysctl_rcgcuart & (1 << 2);
> +            break;
> +        case USART_3:
> +            return s->sysctl_rcgcuart & (1 << 3);
> +            break;
> +        case USART_4:
> +            return s->sysctl_rcgcuart & (1 << 4);
> +            break;
> +        case USART_5:
> +            return s->sysctl_rcgcuart & (1 << 5);
> +            break;
> +        case USART_6:
> +            return s->sysctl_rcgcuart & (1 << 6);
> +            break;
> +        case USART_7:
> +            return s->sysctl_rcgcuart & (1 << 7);
> +            break;
> +    }
> +    return false;
> +}

The UART device shouldn't have a direct pointer to the sysctl
device like this, and it shouldn't be poking around inside
its MMIORegion to find out its physical address either.

The "right" approach here is that the sysctl device has a
bunch of clock outputs for the various UART clocks, the SoC
code wires up each clock output to the appropriate UART
device, and the UART device calls clock_is_enabled() on
its input clock.

The simple approach is to say "we'll just assume the
UART clock has been enabled", because correct guest code
will do that anyway and the device implementation doesn't
much care what the clock is. That's what we usually do
with UART models.

thanks
-- PMM

