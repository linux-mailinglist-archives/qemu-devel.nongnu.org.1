Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEBC77040B
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 17:09:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRwQ5-0001lV-A0; Fri, 04 Aug 2023 11:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRwQ3-0001l9-Mk
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 11:08:47 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRwQ1-00060t-9H
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 11:08:47 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-51e2a6a3768so2796913a12.0
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 08:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691161723; x=1691766523;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PSIudIEBCIZ1jyWuudsIo2x6qf9/8HsT8NqufiyED7A=;
 b=gPdNvch6Ax39li7dyprI3R5YptFG15bWhhdWBrORRp0RnomWPadtIpYf9GXqZKUL/c
 myhIdriZB3tGcgGjZIgmNNJ8uF9psenO3M2w/XRKdyyoBv98vyBW+qZ63NiS6wPdyfbS
 2PXtI4oJu5ioavMdE7+Mux1YU551BwSZvP4lE4CWUhdesxKaAHosjnMo3yCtzcq5Eqz+
 taBw6piqq0GpP2zmMX7LutYshWZwpDVdxME9q0FpbFmxUGfPR7xgIx6S8dCvd40/LT0b
 0o+45VYA+eCnHpjqeBIG4HUCwb7bh+h3U4qld9SIFt7dJpHw4Exh0IPHMkB3sExVKthA
 95Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691161723; x=1691766523;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PSIudIEBCIZ1jyWuudsIo2x6qf9/8HsT8NqufiyED7A=;
 b=Mys5KbxOxdEED6TgIzFw4iwFXMr6gPwM+ByEjnJhOGUEfTLA08M+FC1vlRVrT2Y+Fd
 U2rMfhYQ4ezOu3Zy+Y9YjH3JBqqTclRnRrhzJn7Ul/r1rVn4r19Mh2z36HTyrq+4MSvD
 7R95O3rOMNBHGHlNTWMsNxXLk9QlNaLnYdEUlbPwfK1RK3B3u3DPRhWID+aMWNFmlDH8
 DTHXOvTdx5wS6cvAuoW9Q5r7vVBeP082vkPy99OTwLY1ZYIpXM0Iz5X/o/kRL5hFfrXV
 bLsky6U1rCFiWvorLP85ETZYL/1GQ/+DK+VVlZMXfYmUOUVq5yBhz7bY/cuNZq99LrHa
 3utw==
X-Gm-Message-State: AOJu0YymgHVxeVM8ED5uiHmgBOx9JtiX6PteyiU/bRghKnRtP/i6BxoI
 vEeEg5zK7U9qiuZlPRxMz2vBdedshVnYRbrXzrSLGw==
X-Google-Smtp-Source: AGHT+IF+rLrsGxTwTumRfmOxrZhcz0VJ8RBiwTRB2FituLajDSyycpw+jgccKAiEXlOya2b4iZAK7Civ32udNcY9diA=
X-Received: by 2002:aa7:cfc6:0:b0:51d:95f2:ee76 with SMTP id
 r6-20020aa7cfc6000000b0051d95f2ee76mr1445463edy.27.1691161722929; Fri, 04 Aug
 2023 08:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20230726132512.149618-44-sergey.kambalin@auriga.com>
In-Reply-To: <20230726132512.149618-44-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2023 16:08:31 +0100
Message-ID: <CAFEAcA_-gHqH_te9qLDDvFHKwLPg=3=-kYxraT8ddrkxTJfQKw@mail.gmail.com>
Subject: Re: [PATCH 43/44] Add missed BCM2835 properties
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 26 Jul 2023 at 15:24, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/misc/bcm2835_property.c            | 170 ++++++++++++++++++++++++++
>  include/hw/misc/raspberrypi-fw-defs.h |  11 ++
>  2 files changed, 181 insertions(+)
>
> diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
> index 4ed9faa54a..7d2d6e518d 100644
> --- a/hw/misc/bcm2835_property.c
> +++ b/hw/misc/bcm2835_property.c
> @@ -19,6 +19,31 @@
>  #include "trace.h"
>  #include "hw/arm/raspi_platform.h"
>
> +#define RPI_EXP_GPIO_BASE       128
> +#define VC4_GPIO_EXPANDER_COUNT 8
> +#define VCHI_BUSADDR_SIZE       sizeof(uint32_t)
> +
> +struct vc4_display_settings_t {
> +    uint32_t display_num;
> +    uint32_t width;
> +    uint32_t height;
> +    uint32_t depth;
> +    uint16_t pitch;
> +    uint32_t virtual_width;
> +    uint32_t virtual_height;
> +    uint16_t virtual_width_offset;
> +    uint32_t virtual_height_offset;
> +    unsigned long fb_bus_address;

'long' type in a packed struct ? Sounds fishy...
'long' type for any kind of address is also generally
not the correct type.

> +} QEMU_PACKED;
> +
> +struct vc4_gpio_expander_t {
> +    uint32_t direction;
> +    uint32_t polarity;
> +    uint32_t term_en;
> +    uint32_t term_pull_up;
> +    uint32_t state;
> +} vc4_gpio_expander[VC4_GPIO_EXPANDER_COUNT];

What is this state doing here ? It looks like the property is
supposed to be changing the handling of GPIOs, but in that case
we should wire the properties through to a gpio device, not
just keep hold of the values written here. Simpler would be
to ignore writes if we don't care to implement it properly.
Otherwise the state needs to live in some device and be handled
on vmsave, reset, etc.

> +
>  /* https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface */

> +        case RPI_FWREQ_FRAMEBUFFER_GET_DISPLAY_SETTINGS:

What's this one doing? 0x00040014 isn't documented in the URL above.

> +            stl_le_phys(&s->dma_as, value + 12, 0); /* display_num */
> +            stl_le_phys(&s->dma_as, value + 16, 800); /* width */
> +            stl_le_phys(&s->dma_as, value + 20, 600); /* height */
> +            stl_le_phys(&s->dma_as, value + 24, 32); /* depth */
> +            stl_le_phys(&s->dma_as, value + 28, 32); /* pitch */
> +            stl_le_phys(&s->dma_as, value + 30, 0); /* virtual_width */
> +            stl_le_phys(&s->dma_as, value + 34, 0); /* virtual_height */
> +            stl_le_phys(&s->dma_as, value + 38, 0); /* virtual_width_offset */
> +            stl_le_phys(&s->dma_as, value + 40, 0); /* virtual_height_offset */
> +            stl_le_phys(&s->dma_as, value + 44, 0); /* fb_bus_address low */
> +            stl_le_phys(&s->dma_as, value + 48, 0); /* fb_bus_address hi */
> +            resplen = sizeof(struct vc4_display_settings_t);
> +            break;

Shouldn't this return the same values as the existing
RPI_FWREQ_FRAMEBUFFER_GET_PHYSICAL_WIDTH_HEIGHT etc etc properties,
rather than hardcoded constant values ?
> +
> +        case RPI_FWREQ_FRAMEBUFFER_SET_PITCH:
> +            resplen = 0;
> +            break;

What is setting the pitch supposed to do? At the moment we
assume it's a fixed value depending on the xres, xres_virtual
and bpp (see bcm2835_fb_get_pitch()), so if the guest can
arbitrarily set it then we need to change something in our
display device model. Failing that we should maybe LOG_UNIMP
any attempt by the guest to set it.

thanks
-- PMM

