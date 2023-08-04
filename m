Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 060FF77016B
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 15:26:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRuo3-0001th-PL; Fri, 04 Aug 2023 09:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRunx-0001qu-Pw
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 09:25:21 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRunv-0006M5-Kj
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 09:25:21 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4fe1344b707so3405477e87.1
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 06:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691155518; x=1691760318;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YjTYrVUKWLS3R4xCDGMiE1Y8/QMy0PkCSJsNjGOoj9Q=;
 b=pzfPT4IJPKFhOaN+ErPjLhdgg7iFraMaxUKjoWPFk02WLoilqZKZhmzqWMLbqlO6/R
 w1KEZ4xtf9w54vcGjDwUXUV9QYL29gAJZU8hu26htCCXDyHWgU2kjEVXHm+sKqcZcDNV
 DggcGmOPr390w86LwnoWlWvHhuree1QZPv1dUeO8Z8c2bBi3cDLiuqCYIVil+TeJzf3C
 u5RekHX7lOhgPH5HpJyU8CogWGS70Pr/2ZnKetOkkK74WF6OskN2D2eOrHxPHyREUpph
 SmbMD3URqmJU5Gi8kprvQHM6QPxSWoBCpdsf/KBtAv+WDqIJa9noXG+Vzf640A/lCTqK
 NTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691155518; x=1691760318;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YjTYrVUKWLS3R4xCDGMiE1Y8/QMy0PkCSJsNjGOoj9Q=;
 b=BtQpeUNL2BRFBdS6Jd/7QGQNKjXSH3M0SX0Sp0WA9v9SfR/0gkpuE9QaJklT4Glpvp
 4fLbit36M3dxzpoohFp1NwadFUKdzjtX/oxsEyfRMSEEOskIKvEe1j/D2sDXg4MR87DP
 ZSeIQq1RCEzFhpt0AX7n9bvjKqICfrMdtz/jvs+ZT5xl61yM5UkLmuqxrVSY1dqkjhwx
 8aBrjrEUtRcSs5HfPT/EUjIxivwwX0VJ0Dbh8y4RPV/56TQHfSMuGrf3itiscEF0j/K1
 LlNnRhMVQifTgqRT1bIvaf57QfDiGMX5mnJ4QMuuE7aS45pJFZP+FlN3KT54CzYsmbRI
 jBLA==
X-Gm-Message-State: AOJu0YyWGG9cU1rJD5u6Sr/BV2A1iJZumU0onukWjobgJJwdIndBajvY
 HqLQNB318mk0lwPLZtc5dEiiFcUwjgtDL3mTbkX8MA==
X-Google-Smtp-Source: AGHT+IFSXsZglRxOm1PKzxmbrFKhPLIdSK1wVAkA3hM8E3wrqApT825ebfUZgkx+YWNAU8ZRcALleJYY8zMjMXugbSs=
X-Received: by 2002:ac2:4d88:0:b0:4fd:d18f:2d93 with SMTP id
 g8-20020ac24d88000000b004fdd18f2d93mr1309294lfe.6.1691155517681; Fri, 04 Aug
 2023 06:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20230726132512.149618-18-sergey.kambalin@auriga.com>
In-Reply-To: <20230726132512.149618-18-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2023 14:25:06 +0100
Message-ID: <CAFEAcA_Ut7=Ev5PP=NccvR2gnpx4w+OE=C5MmkjGDtPLS+9q1A@mail.gmail.com>
Subject: Re: [PATCH 17/44] Add RNG200 skeleton
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 26 Jul 2023 at 14:45, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/misc/bcm2838_rng200.c         | 118 +++++++++++++++++++++++++++++++
>  hw/misc/meson.build              |   1 +
>  hw/misc/trace-events             |  10 +++
>  include/hw/misc/bcm2838_rng200.h |  77 ++++++++++++++++++++
>  4 files changed, 206 insertions(+)
>  create mode 100644 hw/misc/bcm2838_rng200.c
>  create mode 100644 include/hw/misc/bcm2838_rng200.h
>
> diff --git a/hw/misc/bcm2838_rng200.c b/hw/misc/bcm2838_rng200.c
> new file mode 100644
> index 0000000000..a17e8f2cda
> --- /dev/null
> +++ b/hw/misc/bcm2838_rng200.c
> @@ -0,0 +1,118 @@
> +/*
> + * BCM2838 Random Number Generator emulation
> + *
> + * Copyright (C) 2022 Sergey Pushkarev <sergey.pushkarev@auriga.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/misc/bcm2838_rng200.h"
> +#include "trace.h"
> +
> +static void bcm2838_rng200_rng_reset(BCM2838Rng200State *state)
> +{
> +    state->rng_ctrl.value = 0;
> +
> +    trace_bcm2838_rng200_rng_soft_reset();
> +}
> +
> +static uint64_t bcm2838_rng200_read(void *opaque, hwaddr offset,
> +                                    unsigned size)
> +{
> +    uint32_t res = 0;
> +
> +    trace_bcm2838_rng200_read((void *)offset, size, res);
> +    return res;
> +}
> +
> +static void bcm2838_rng200_write(void *opaque, hwaddr offset,
> +                                 uint64_t value, unsigned size)
> +{
> +
> +    trace_bcm2838_rng200_write((void *)offset, value, size);

Why trace the device instance pointer in these two tracepoints
and not in the others? (Generally we don't, unless there are
multiple devices of the same type in the system and it's important
to be able to distinguish them; and in that case there are
more useful ways to do it than the raw device pointer.)

> +}
> +
> +static const MemoryRegionOps bcm2838_rng200_ops = {
> +    .read = bcm2838_rng200_read,
> +    .write = bcm2838_rng200_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +};
> +
> +static void bcm2838_rng200_realize(DeviceState *dev, Error **errp)
> +{
> +    BCM2838Rng200State *s = BCM2838_RNG200(dev);
> +
> +    if (s->rng == NULL) {
> +        Object *default_backend = object_new(TYPE_RNG_BUILTIN);
> +
> +        object_property_add_child(OBJECT(dev), "default-backend",
> +                                  default_backend);
> +        object_unref(default_backend);
> +
> +        object_property_set_link(OBJECT(dev), "rng", default_backend,
> +                                 errp);
> +    }
> +
> +    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
> +}
> +
> +static void bcm2838_rng200_init(Object *obj)
> +{
> +    BCM2838Rng200State *s = BCM2838_RNG200(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +
> +    s->clock = qdev_init_clock_in(DEVICE(s), "rbg-clock",
> +                                  NULL, s,
> +                                  ClockPreUpdate);
> +    if (s->clock == NULL) {
> +        error_setg(&error_fatal, "Failed to init RBG clock");
> +        return;
> +    }
> +
> +    memory_region_init_io(&s->iomem, obj, &bcm2838_rng200_ops, s,
> +                          TYPE_BCM2838_RNG200, 0x28);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +}
> +
> +static void bcm2838_rng200_reset(DeviceState *dev)
> +{
> +    BCM2838Rng200State *s = BCM2838_RNG200(dev);
> +    bcm2838_rng200_rng_reset(s);
> +}
> +
> +static Property bcm2838_rng200_properties[] = {
> +    DEFINE_PROP_UINT32("rbg-period", BCM2838Rng200State, rbg_period, 250),
> +    DEFINE_PROP_UINT32("rng-fifo-cap", BCM2838Rng200State, rng_fifo_cap, 128),
> +    DEFINE_PROP_LINK("rng", BCM2838Rng200State, rng,
> +                     TYPE_RNG_BACKEND, RngBackend *),
> +    DEFINE_PROP_BOOL("use-timer", BCM2838Rng200State, use_timer, true),

Do we really need all these properties? The SoC only has
one of these devices, so why do we need the flexibility ?

> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void bcm2838_rng200_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = bcm2838_rng200_realize;
> +    dc->reset = bcm2838_rng200_reset;
> +    device_class_set_props(dc, bcm2838_rng200_properties);
> +}
> +
> +static const TypeInfo bcm2838_rng200_info = {
> +    .name          = TYPE_BCM2838_RNG200,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(BCM2838Rng200State),
> +    .class_init    = bcm2838_rng200_class_init,
> +    .instance_init = bcm2838_rng200_init,
> +};
> +
> +static void bcm2838_rng200_register_types(void)
> +{
> +    type_register_static(&bcm2838_rng200_info);
> +}
> +
> +type_init(bcm2838_rng200_register_types)
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 892f8b91c5..a6230ced43 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -88,6 +88,7 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
>    'bcm2835_thermal.c',
>    'bcm2835_cprman.c',
>    'bcm2835_powermgt.c',
> +  'bcm2838_rng200.c'
>  ))
>  system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
>  system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 4d1a0e17af..d26cd2d22d 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -297,3 +297,13 @@ virt_ctrl_instance_init(void *dev) "ctrl: %p"
>  lasi_chip_mem_valid(uint64_t addr, uint32_t val) "access to addr 0x%"PRIx64" is %d"
>  lasi_chip_read(uint64_t addr, uint32_t val) "addr 0x%"PRIx64" val 0x%08x"
>  lasi_chip_write(uint64_t addr, uint32_t val) "addr 0x%"PRIx64" val 0x%08x"
> +
> +# bcm2838_rng200.c
> +bcm2838_rng200_rng_soft_reset(void) "========= RNumG SOFT RESET ========="
> +bcm2838_rng200_rbg_soft_reset(void) "========= RBitG SOFT RESET ========="
> +bcm2838_rng200_enable_rbg(void)     "========= RBitG ENABLED ========="
> +bcm2838_rng200_disable_rbg(void)    "========= RBitG DISABLED ========="
> +bcm2838_rng200_update_fifo(uint32_t len, uint32_t fifo_len)    "len %u, fifo_len %u"
> +bcm2838_rng200_fifo_full(void) "========= RNumG FIFO FULL ========="

Can you make these trace strings a bit more in line with the style
for other trace strings, please (i.e. lose the caps and =======) ?

> +bcm2838_rng200_write(void *addr, uint64_t value, unsigned size) "addr %p, value 0x%016" PRIx64 ", size %u"
> +bcm2838_rng200_read(void *addr, unsigned size, uint64_t value) "addr %p, size %u, value 0x%016" PRIx64
> diff --git a/include/hw/misc/bcm2838_rng200.h b/include/hw/misc/bcm2838_rng200.h
> new file mode 100644
> index 0000000000..77f6cd8df4
> --- /dev/null
> +++ b/include/hw/misc/bcm2838_rng200.h
> @@ -0,0 +1,77 @@
> +/*
> + * BCM2838 Random Number Generator emulation
> + *
> + * Copyright (C) 2022 Sergey Pushkarev <sergey.pushkarev@auriga.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef BCM2838_RNG200_H
> +#define BCM2838_RNG200_H
> +
> +#include <stdbool.h>
> +#include "qom/object.h"
> +#include "qemu/fifo8.h"
> +#include "sysemu/rng.h"
> +#include "hw/sysbus.h"
> +#include "hw/ptimer.h"
> +#include "hw/qdev-clock.h"
> +#include "hw/irq.h"
> +
> +#define TYPE_BCM2838_RNG200 "bcm2838-rng200"
> +OBJECT_DECLARE_SIMPLE_TYPE(BCM2838Rng200State, BCM2838_RNG200)
> +
> +typedef union BCM2838Rng200Ctrl {
> +    uint32_t value;
> +    struct {
> +        uint32_t rbg_enable:1;
> +        uint32_t __r0:12;
> +        uint32_t div:8;
> +    };

Don't use bitfields in models of hardware (either of
register layouts or of in-guest-memory data), please.
It's not portable (bitfield layout depends on endianness,
plus on Windows the layout of structs with bitfields isn't
the same as GCC's normal standard).

Use normal-sized uint32_t values, and extract subfields
with bitfield ops. include/hw/registerfields.h has some
useful macros you can use where you define the fields in
a register, and then can get at them with eg
   bool enable = FIELD_EX32(s->ctrl, CTRL, ENABLE);

> +} BCM2838Rng200Ctrl;
> +
> +typedef union BCM2838Rng200Int {
> +    uint32_t value;
> +    struct {
> +        uint32_t total_bits_count_irq:1;
> +        uint32_t __r0:4;
> +        uint32_t nist_fail_irq:1;
> +        uint32_t __r1:11;
> +        uint32_t startup_transition_met_irq:1;
> +        uint32_t __r2:13;
> +        uint32_t master_fail_lockout_irq:1;
> +    };
> +} BCM2838Rng200Int;
> +
> +typedef union BCM2838Rng200FifoCount {
> +    uint32_t value;
> +    struct {
> +        uint32_t count:8;
> +        uint32_t thld:8;
> +    };
> +} BCM2838Rng200FifoCount;
> +
> +struct BCM2838Rng200State {
> +    SysBusDevice busdev;
> +    MemoryRegion iomem;
> +
> +    ptimer_state *ptimer;
> +    RngBackend *rng;
> +    Clock *clock;
> +
> +    uint32_t rbg_period;
> +    uint32_t rng_fifo_cap;
> +    bool use_timer;
> +
> +    Fifo8    fifo;
> +    qemu_irq irq;
> +    BCM2838Rng200Ctrl rng_ctrl;
> +    BCM2838Rng200Int rng_int_status;
> +    BCM2838Rng200Int rng_int_enable;
> +    uint32_t rng_total_bit_count;
> +    BCM2838Rng200FifoCount rng_fifo_count;
> +    uint32_t rng_bit_count_threshold;
> +};
> +
> +#endif /* BCM2838_RNG200_H */

As with the other device, my suggestion is to put the
vmstate struct definition in the same patch as the
fields are added to the device state struct.

thanks
-- PMM

