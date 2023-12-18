Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B33A8176ED
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 17:07:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFG9d-0001Sw-CZ; Mon, 18 Dec 2023 11:07:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFG9Y-0001Lh-WD
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 11:07:37 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFG9W-0003Ho-Qb
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 11:07:36 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5537dd673e5so370259a12.0
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 08:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702915653; x=1703520453; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4j9uNOAYPUO7RjRQoH27bZind2Y6RSmwAQWuWRBnXjI=;
 b=YGtnABIs+gKR5wh9vRRFVX3GvIH31fjEXuNDDzGf0H9YUmtNM8U+VdsivrYWOwDG4/
 mNwFc9RgZlRc4QV61S7uNFOHGejUbVCBP5NiDNdadg+UpuXcy2H8QgXM8YdppPiDSVI0
 tuNAnoS1bbSJPOo3RzZekXz3jPnf3CkPpBcBq79cOcbRnBylOEHt1VUJAG06lG7iSOcK
 CGyij+RS/fpY+x9l5qwSU7WxiKSLFPsRf3UuL2jfO3xqjB+0wQE32o3UooVoH8IxWN4q
 UbaBQtJNNf67KDQCDtIlrGW6faKiX3sqkNfI6nBUiORDVKZONiM3AjjK79REoYqH06Pj
 jtHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702915653; x=1703520453;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4j9uNOAYPUO7RjRQoH27bZind2Y6RSmwAQWuWRBnXjI=;
 b=BiXNv3UkOwvgEnZ2i5he/vgL5vkZgdARFDdKiVGwSJ819uLwyKcJIVyNPmFzQdsEU/
 SsY1HKasYEODvrPkh6W7De6SMvTzYNjOqAPGlMVTEqhmzP3PWVoWj36AEddSwQTaY6sF
 PSitAIiQ8f/pXX7fm5byRkYDJSlxNe7au77DHWvRYw5HZddO+cTrKDsgq3ZFiuR+RUeD
 ybMX/TkDojF4MegCORow9LihLBC0N6iEApPeacWl27oI1yMeCaPpLuYWoT/aKz4HrrwJ
 FR/U52LHhfSdbmRnI8RW9oCyo5yjp/u+0W9QXDE8winejdV2h1ub/1iLygtfqIpntC+b
 jn7Q==
X-Gm-Message-State: AOJu0YzbWMJ0qiBLjtfwhD4oGPVd25ZephBmzciVHSqMcLKduy0jJMpu
 uohGxq/8bgNnoTGRTYhwEaTMS9M8IR7vfmEI+HfPAQ==
X-Google-Smtp-Source: AGHT+IGlSrQ5rHy6+kDLA9DyRPk12m7dRWsyUWM848k9yxdUaugkBdQDNdcM3bWhZO5Hy0HmVoZOlogcpcpRuSHaw4A=
X-Received: by 2002:a50:aac2:0:b0:552:87c1:38fe with SMTP id
 r2-20020a50aac2000000b0055287c138femr4169309edc.0.1702915653117; Mon, 18 Dec
 2023 08:07:33 -0800 (PST)
MIME-Version: 1.0
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
 <20231208023145.1385775-5-sergey.kambalin@auriga.com>
In-Reply-To: <20231208023145.1385775-5-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Dec 2023 16:07:22 +0000
Message-ID: <CAFEAcA_TDtzaiC0axEGtOPRJgfzq2Hokbb4U23EOM2KK8ZDf5w@mail.gmail.com>
Subject: Re: [PATCH v4 04/45] Introduce BCM2838 SoC
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Fri, 8 Dec 2023 at 02:33, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/arm/bcm2838.c                     | 100 +++++++++++++++++++++++++++
>  hw/arm/bcm2838_peripherals.c         |  72 +++++++++++++++++++
>  hw/arm/meson.build                   |   2 +
>  include/hw/arm/bcm2838.h             |  29 ++++++++
>  include/hw/arm/bcm2838_peripherals.h |  36 ++++++++++
>  5 files changed, 239 insertions(+)
>  create mode 100644 hw/arm/bcm2838.c
>  create mode 100644 hw/arm/bcm2838_peripherals.c
>  create mode 100644 include/hw/arm/bcm2838.h
>  create mode 100644 include/hw/arm/bcm2838_peripherals.h
>
> diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
> new file mode 100644
> index 0000000000..c61c59661b
> --- /dev/null
> +++ b/hw/arm/bcm2838.c
> @@ -0,0 +1,100 @@
> +/*
> + * BCM2838 SoC emulation
> + *
> + * Copyright (C) 2022 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/module.h"
> +#include "hw/arm/raspi_platform.h"
> +#include "hw/sysbus.h"
> +#include "hw/arm/bcm2838.h"
> +#include "trace.h"
> +
> +#define VIRTUAL_PMU_IRQ 7
> +
> +static void bcm2838_init(Object *obj)
> +{
> +    BCM2838State *s = BCM2838(obj);
> +
> +    object_initialize_child(obj, "peripherals", &s->peripherals,
> +                            TYPE_BCM2838_PERIPHERALS);
> +    object_property_add_alias(obj, "board-rev", OBJECT(&s->peripherals),
> +                              "board-rev");
> +    object_property_add_alias(obj, "vcram-size", OBJECT(&s->peripherals),
> +                              "vcram-size");
> +    object_property_add_alias(obj, "command-line", OBJECT(&s->peripherals),
> +                              "command-line");
> +}
> +
> +static void bcm2838_realize(DeviceState *dev, Error **errp)
> +{
> +    int n;
> +    BCM2838State *s = BCM2838(dev);
> +    BCM283XBaseState *s_base = BCM283X_BASE(dev);
> +    BCM283XBaseClass *bc_base = BCM283X_BASE_GET_CLASS(dev);
> +    BCM2838PeripheralState *ps = BCM2838_PERIPHERALS(&s->peripherals);
> +    BCMSocPeripheralBaseState *ps_base =
> +        BCM_SOC_PERIPHERALS_BASE(&s->peripherals);
> +
> +    if (!bcm283x_common_realize(dev, ps_base, errp)) {
> +        return;
> +    }
> +    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(ps), 1, BCM2838_PERI_LOW_BASE, 1);
> +
> +    /* bcm2836 interrupt controller (and mailboxes, etc.) */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s_base->control), errp)) {
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s_base->control), 0, bc_base->ctrl_base);
> +
> +    /* Create cores */
> +    for (n = 0; n < bc_base->core_count; n++) {
> +        /* TODO: this should be converted to a property of ARM_CPU */
> +        s_base->cpu[n].core.mp_affinity = (bc_base->clusterid << 8) | n;

We have a property now, so we can do:

    object_property_set_int(OBJECT(&s->cpu[n].core), "mp-affinity",
                            (bc->clusterid << 8) | n, &error_abort);

rather than propagating a TODO item.

https://lore.kernel.org/qemu-devel/20231123143813.42632-4-philmd@linaro.org/
is the patch (still pending) that does this in the existing rpi code.

> +
> +        /* start powered off if not enabled */
> +        if (!object_property_set_bool(OBJECT(&s_base->cpu[n].core),
> +                                      "start-powered-off",
> +                                      n >= s_base->enabled_cpus,
> +                                      errp)) {
> +            return;
> +        }

Trying to set start-powered-off can never fail, so we don't need
to error-check it, but can just error_abort.
https://lore.kernel.org/qemu-devel/20231123143813.42632-5-philmd@linaro.org/
is the patch which does that for the existing uses.

> +
> +        if (!qdev_realize(DEVICE(&s_base->cpu[n].core), NULL, errp)) {
> +            return;
> +        }
> +    }
> +}

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

