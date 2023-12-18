Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF5C817760
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 17:24:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFGPG-0007Cw-Jd; Mon, 18 Dec 2023 11:23:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFGPA-0007Cc-RF
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 11:23:44 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFGP4-0005wf-N3
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 11:23:44 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5537ee0c4aaso530743a12.0
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 08:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702916617; x=1703521417; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1tJe3GZ+2jfMoR/Etv2RrHtUGwRX3dH/dWbAWNSoaeU=;
 b=w7jBlq23IDho5Ma5uKkx/07H1c9IO8/CHlpjiuAdKLVl+4I7xlVWZtKnotF17DwA34
 wf7m2JjW4WtdCvkeCLCHtD08hglCwLEG0eAhPfRwwYO/QE+JZ6U+fFS7i/YmzfNbEfmU
 Ta6hJrMlH0hnPkP66Ll9ENAmjcqP+Jd+a3YR2iiw2sr3U4S1wD9ePE78YtJuCNUGjW2n
 A5w/ecWzpDYfyiSuvXBYDFva/E54X8D/tWQZ678+qGfK7sMMH4a1IoxAuYUk6Whc35q0
 i3AA+jq16ex/hUJzGEFGwimak8VY+JfFa0o1Y+9R3eFdapdKN167qGu7p+Q5ZcJfc53U
 PJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702916617; x=1703521417;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1tJe3GZ+2jfMoR/Etv2RrHtUGwRX3dH/dWbAWNSoaeU=;
 b=r4tCn6wu/RNB5gFToLGEb6/cAXX990bC/INOikqTHOk+6ctW2L9D7Utr+MPWVR2OmJ
 a+ecU6ACtjAmxL/n4jTLW8OCnAG3iUXQPe8UhXQnQ/oewoZwXiBXq1TTLkIyDP0e4DKV
 4POxrESDG5kRcW1cYhpd1fvEEqvzvlq5Mi3hGzTXmdWA4DlCpzcaf0iG1lm1ir+7zB0+
 2zivSqGEpuldRJ2Tu26r5TylvjGH+3iYgAof1sRKu4wWKdBnx7pBJXnkmRikVpzzSve7
 m5LNfEfbBngu9usSlw1Y3ELwl8aE4oxUPubpSz9wglzL7GmzLwbnurRXEG33qis2Q4PM
 QHzQ==
X-Gm-Message-State: AOJu0YyblRTl1fYoiDiWaIrSW74SgBp2cDdkTtaAKo5rkb/GcUdTgFUt
 0sYOdqnzhU76PRRdDjEHwGmg4dSEejtfZjbATuk7rA==
X-Google-Smtp-Source: AGHT+IGZ6wrwvc1nP40tpmUL883XqJ+Rgw4Q6vK1GdAoKO2vnqMM3jRV/BWepd6lqPoYflN7h4d+MUL03qR1pYiy7kU=
X-Received: by 2002:a50:a6d1:0:b0:553:2b99:ce52 with SMTP id
 f17-20020a50a6d1000000b005532b99ce52mr1370561edc.37.1702916616813; Mon, 18
 Dec 2023 08:23:36 -0800 (PST)
MIME-Version: 1.0
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
 <20231208023145.1385775-6-sergey.kambalin@auriga.com>
In-Reply-To: <20231208023145.1385775-6-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Dec 2023 16:23:24 +0000
Message-ID: <CAFEAcA860n0vszWO+=PttxnX4TnyUD5RXm6+SLffTYL329L4sg@mail.gmail.com>
Subject: Re: [PATCH v4 05/45] Add GIC-400 to BCM2838 SoC
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, 8 Dec 2023 at 02:32, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/arm/bcm2838.c                     | 167 +++++++++++++++++++++++++++
>  hw/arm/trace-events                  |   2 +
>  include/hw/arm/bcm2838.h             |   2 +
>  include/hw/arm/bcm2838_peripherals.h |  39 +++++++
>  4 files changed, 210 insertions(+)
>
> diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
> index c61c59661b..042e543006 100644
> --- a/hw/arm/bcm2838.c
> +++ b/hw/arm/bcm2838.c
> @@ -14,8 +14,36 @@
>  #include "hw/arm/bcm2838.h"
>  #include "trace.h"
>
> +#define GIC400_MAINTAINANCE_IRQ      9

"MAINTENANCE"

> +#define GIC400_TIMER_NS_EL2_IRQ     10
> +#define GIC400_TIMER_VIRT_IRQ       11
> +#define GIC400_LEGACY_FIQ           12
> +#define GIC400_TIMER_S_EL1_IRQ      13
> +#define GIC400_TIMER_NS_EL1_IRQ     14
> +#define GIC400_LEGACY_IRQ           15

For the virt and sbsa-ref boards we found that having interrupt
#defines use the PPI number was on net a bit confusing, so we
standardized on having the defines be the architectural INTID
(which is the PPI number + 16). See commit 9036e917f8357f4.

But I mention this more as an FYI kind of thing because changing
the numbering base at this point is probably more likely to
introduce bugs than remove them...

> +/* Number of external interrupt lines to configure the GIC with */
> +#define GIC_NUM_IRQS                192
> +
> +#define PPI(cpu, irq) (GIC_NUM_IRQS + (cpu) * GIC_INTERNAL + GIC_NR_SGIS + irq)
> +
> +#define GIC_BASE_OFS                0x0000
> +#define GIC_DIST_OFS                0x1000
> +#define GIC_CPU_OFS                 0x2000
> +#define GIC_VIFACE_THIS_OFS         0x4000
> +#define GIC_VIFACE_OTHER_OFS(cpu)  (0x5000 + (cpu) * 0x200)
> +#define GIC_VCPU_OFS                0x6000
> +
>  #define VIRTUAL_PMU_IRQ 7
>
> +static void bcm2838_gic_set_irq(void *opaque, int irq, int level)
> +{
> +    BCM2838State *s = (BCM2838State *)opaque;
> +
> +    trace_bcm2838_gic_set_irq(irq, level);
> +    qemu_set_irq(qdev_get_gpio_in(DEVICE(&s->gic), irq), level);
> +}
> +
>  static void bcm2838_init(Object *obj)
>  {
>      BCM2838State *s = BCM2838(obj);
> @@ -28,11 +56,14 @@ static void bcm2838_init(Object *obj)
>                                "vcram-size");
>      object_property_add_alias(obj, "command-line", OBJECT(&s->peripherals),
>                                "command-line");
> +
> +    object_initialize_child(obj, "gic", &s->gic, TYPE_ARM_GIC);
>  }
>
>  static void bcm2838_realize(DeviceState *dev, Error **errp)
>  {
>      int n;
> +    int int_n;

This is not a good name for a variable, especially in a
function that already has an "n" variable. As far as I can see
the use added here doesn't overlap with the existing "n" so
you could just reuse that.

Note that our coding style these days permits declaration of
loop variables inside the for():

    for (int i = 0; i < ARRAY_SIZE(thing); i++) {
        /* do something loopy */
    }

so if you prefer you can have all the loops in the function do that
and not have any local n declared at the top of the function.

>      BCM2838State *s = BCM2838(dev);
>      BCM283XBaseState *s_base = BCM283X_BASE(dev);
>      BCM283XBaseClass *bc_base = BCM283X_BASE_GET_CLASS(dev);
> @@ -56,6 +87,13 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
>          /* TODO: this should be converted to a property of ARM_CPU */
>          s_base->cpu[n].core.mp_affinity = (bc_base->clusterid << 8) | n;
>
> +        /* set periphbase/CBAR value for CPU-local registers */
> +        if (!object_property_set_int(OBJECT(&s_base->cpu[n].core), "reset-cbar",
> +                                     bc_base->ctrl_base + BCM2838_GIC_BASE,
> +                                     errp)) {
> +            return;
> +        }

This one doesn't need an error check either; compare
https://lore.kernel.org/qemu-devel/20231123143813.42632-3-philmd@linaro.org/

> +
>          /* start powered off if not enabled */
>          if (!object_property_set_bool(OBJECT(&s_base->cpu[n].core),
>                                        "start-powered-off",
> @@ -68,6 +106,135 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
>              return;
>          }
>      }
> +
> +    if (!object_property_set_uint(OBJECT(&s->gic), "revision", 2, errp)) {
> +        return;
> +    }
> +
> +    if (!object_property_set_uint(OBJECT(&s->gic), "num-cpu", BCM283X_NCPUS,
> +                                  errp)) {
> +        return;
> +    }
> +
> +    if (!object_property_set_uint(OBJECT(&s->gic), "num-irq",
> +                                  GIC_NUM_IRQS + GIC_INTERNAL, errp)) {
> +        return;
> +    }
> +
> +    if (!object_property_set_bool(OBJECT(&s->gic),
> +                                  "has-virtualization-extensions", true,
> +                                  errp)) {
> +        return;
> +    }
> +
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), errp)) {
> +        return;
> +    }
> +
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 0,
> +                    bc_base->ctrl_base + BCM2838_GIC_BASE + GIC_DIST_OFS);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 1,
> +                    bc_base->ctrl_base + BCM2838_GIC_BASE + GIC_CPU_OFS);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 2,
> +                    bc_base->ctrl_base + BCM2838_GIC_BASE + GIC_VIFACE_THIS_OFS);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 3,
> +                    bc_base->ctrl_base + BCM2838_GIC_BASE + GIC_VCPU_OFS);
> +
> +    for (n = 0; n < BCM283X_NCPUS; n++) {
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 4 + n,
> +                        bc_base->ctrl_base + BCM2838_GIC_BASE
> +                            + GIC_VIFACE_OTHER_OFS(n));
> +    }
> +
> +    DeviceState *gicdev = DEVICE(&s->gic);

Our coding style says don't put declarations in the middle
of a code block. They should go at the start of blocks.

> +
> +    for (n = 0; n < BCM283X_NCPUS; n++) {
> +        DeviceState *cpudev = DEVICE(&s_base->cpu[n]);
> +
> +        /* Connect the GICv2 outputs to the CPU */
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), n,
> +                           qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), n + BCM283X_NCPUS,
> +                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), n + 2 * BCM283X_NCPUS,
> +                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), n + 3 * BCM283X_NCPUS,
> +                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
> +
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), n + 4 * BCM283X_NCPUS,
> +                           qdev_get_gpio_in(gicdev,
> +                                            PPI(n, GIC400_MAINTAINANCE_IRQ)));
> +
> +        /* Connect timers from the CPU to the interrupt controller */
> +        qdev_connect_gpio_out(cpudev, GTIMER_PHYS,
> +                    qdev_get_gpio_in(gicdev, PPI(n, GIC400_TIMER_NS_EL1_IRQ)));
> +        qdev_connect_gpio_out(cpudev, GTIMER_VIRT,
> +                    qdev_get_gpio_in(gicdev, PPI(n, GIC400_TIMER_VIRT_IRQ)));
> +        qdev_connect_gpio_out(cpudev, GTIMER_HYP,
> +                    qdev_get_gpio_in(gicdev, PPI(n, GIC400_TIMER_NS_EL2_IRQ)));
> +        qdev_connect_gpio_out(cpudev, GTIMER_SEC,
> +                    qdev_get_gpio_in(gicdev, PPI(n, GIC400_TIMER_S_EL1_IRQ)));
> +        /* PMU interrupt */
> +        qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
> +                    qdev_get_gpio_in(gicdev, PPI(n, VIRTUAL_PMU_IRQ)));
> +    }
> +
> +    /* Connect UART0 to the interrupt controller */
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->uart0), 0,
> +                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_UART0));
> +
> +    /* Connect AUX / UART1 to the interrupt controller */
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->aux), 0,
> +                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_AUX_UART1));
> +
> +    /* Connect VC mailbox to the interrupt controller */
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->mboxes), 0,
> +                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_MBOX));
> +
> +    /* Connect SD host to the interrupt controller */
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->sdhost), 0,
> +                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_SDHOST));
> +
> +    /* According to DTS, EMMC and EMMC2 share one irq */
> +    DeviceState *mmc_irq_orgate = DEVICE(&ps->mmc_irq_orgate);
> +
> +    /* Connect EMMC and EMMC2 to the interrupt controller */
> +    qdev_connect_gpio_out(mmc_irq_orgate, 0,
> +                          qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_EMMC_EMMC2));
> +
> +    /* Connect USB OTG and MPHI to the interrupt controller */
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->mphi), 0,
> +                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_MPHI));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->dwc2), 0,
> +                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_DWC2));
> +
> +    /* Connect DMA 0-6 to the interrupt controller */
> +    for (int_n = GIC_SPI_INTERRUPT_DMA_0; int_n <= GIC_SPI_INTERRUPT_DMA_6;
> +         int_n++) {
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->dma),
> +                           int_n - GIC_SPI_INTERRUPT_DMA_0,
> +                           qdev_get_gpio_in(gicdev, int_n));
> +    }
> +
> +    /* According to DTS, DMA 7 and 8 share one irq */
> +    DeviceState *dma_7_8_irq_orgate = DEVICE(&ps->dma_7_8_irq_orgate);
> +
> +    /* Connect DMA 7-8 to the interrupt controller */
> +    qdev_connect_gpio_out(dma_7_8_irq_orgate, 0,
> +                          qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_DMA_7_8));
> +
> +    /* According to DTS, DMA 9 and 10 share one irq */
> +    DeviceState *dma_9_10_irq_orgate = DEVICE(&ps->dma_9_10_irq_orgate);
> +
> +    /* Connect DMA 9-10 to the interrupt controller */
> +    qdev_connect_gpio_out(dma_9_10_irq_orgate, 0,
> +                          qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_DMA_9_10));
> +
> +    /* Pass through inbound GPIO lines to the GIC */
> +    qdev_init_gpio_in(dev, bcm2838_gic_set_irq, GIC_NUM_IRQS);
> +
> +    /* Pass through outbound IRQ lines from the GIC */
> +    qdev_pass_gpios(DEVICE(&s->gic), DEVICE(&s->peripherals), NULL);
>  }

Otherwise looks OK.

thanks
-- PMM

