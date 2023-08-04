Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8ED770328
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 16:33:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRvqf-0008G6-8U; Fri, 04 Aug 2023 10:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRvqb-0008Fb-LY
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 10:32:09 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRvqU-0002qt-CO
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 10:32:05 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5221cf2bb8cso2853811a12.1
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 07:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691159516; x=1691764316;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Gwyu2o6J0y2LfVv6kLfeLv7NbMCAEZ+v9SQ50AfAuI8=;
 b=C7jMlpLkssiTCnO2SilXx4ctD5TSTrEu5o0aKSKZQh9HXXu+tnZj+R9u2yC0QHO4/e
 Ch3tF7xRPD18xbzdCY7SfYwnZyByVBr5ByACPO4JyRaZXtZnYOBwH99waf41oBfwSbao
 lBQ5jzJpPzcBdkaaWeRtEo5aiFsaaf/H6i1cR09dCA31z/Cps6KkE2Qy0ahOdkp07kQs
 Guqv6lyzudMPV5Eg7F/doqf6XYLoKnWAF65+kE4W7f6q9U1v8Bi17XYIKpFr4zP3lrHb
 KqAJIejh262xHco2p8WGaeV5lfx3L44oBFn1iO8pwawAg9WHr6mARhoPvAsLaWTiuy3J
 L/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691159516; x=1691764316;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gwyu2o6J0y2LfVv6kLfeLv7NbMCAEZ+v9SQ50AfAuI8=;
 b=RGAOQKNg5vcUsL1ICC9b40G+7vsQ/lgNTZoPHwppV6dmUxLVZwD9C+wQeZJtdL/M6m
 KA3TrvDFBznCdwd4Ksvth4TbEOTxdLhnGFM/oE8/JlYCYZtBcd2+feYzkHg5BJC2YIPS
 l7RVgpynpYLwD4cNtQ53c5oi70cp2Tdo0VfkJbiMrfn18CwD7ARroCIvdO5Q3nuiue6Q
 GSxYjQf1jjO5mvRgctF3rWS+d2Yth4+TQPCtq5xeMOMyTm07zJkkMfnvGNCsvcqbdFOg
 VdKZ02cD55oEJYPlxA54l1WVDh66c9wHAP16xsAAXrnqW/G313XGacCC1cmCT5JF8iGi
 //hA==
X-Gm-Message-State: AOJu0Yxuk6vcEULdikR/y2yUOCnQh6FgaYngcsj+N7JQAa8XnMAHb7dj
 tRpEhV7gwFf4pnH701FL1TV4H6xwjb5HjUmYpvaCzw==
X-Google-Smtp-Source: AGHT+IEymLK4SX6WPwbY/XJogb0feG+K3HLCTL6HfWf8AYLgPuU7GLYhAbkqS2ZDFaV5LIvFP/buIK6SppiiK2jaPks=
X-Received: by 2002:a05:6402:741:b0:522:273d:2ab1 with SMTP id
 p1-20020a056402074100b00522273d2ab1mr1803861edy.11.1691159515971; Fri, 04 Aug
 2023 07:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20230726132512.149618-20-sergey.kambalin@auriga.com>
In-Reply-To: <20230726132512.149618-20-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2023 15:31:44 +0100
Message-ID: <CAFEAcA8zt7=qc7KRtNReQFR0CPH7e9mPTbCb1mmnPhnjmThr-w@mail.gmail.com>
Subject: Re: [PATCH 19/44] Add RNG200 timer
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Wed, 26 Jul 2023 at 15:18, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/arm/bcm2838_peripherals.c         |  14 ++++
>  hw/arm/raspi4b.c                     |   1 -
>  hw/misc/bcm2838_rng200.c             | 105 ++++++++++++++++++++++++---
>  include/hw/arm/bcm2838_peripherals.h |   2 +
>  4 files changed, 111 insertions(+), 11 deletions(-)
>
> diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
> index 41b321b254..df97953bbe 100644
> --- a/hw/arm/bcm2838_peripherals.c
> +++ b/hw/arm/bcm2838_peripherals.c
> @@ -34,6 +34,9 @@ static void bcm2838_peripherals_init(Object *obj)
>                         bc->peri_low_size);
>      sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->peri_low_mr);
>
> +    /* Random Number Generator */
> +    object_initialize_child(obj, "rng200", &s->rng200, TYPE_BCM2838_RNG200);
> +
>      /* PCIe Host Bridge */
>      object_initialize_child(obj, "pcie-host", &s->pcie_host,
>                              TYPE_BCM2838_PCIE_HOST);
> @@ -84,6 +87,17 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
>                                          BCM2838_VC_PERI_LOW_BASE,
>                                          &s->peri_low_mr_alias, 1);
>
> +    /* Random Number Generator */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rng200), errp)) {
> +        return;
> +    }
> +    memory_region_add_subregion(
> +        &s_base->peri_mr, RNG_OFFSET,
> +        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->rng200), 0));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->rng200), 0,
> +        qdev_get_gpio_in_named(DEVICE(&s_base->ic), BCM2835_IC_GPU_IRQ,
> +                               INTERRUPT_RNG));
> +
>      /* Extended Mass Media Controller 2 */
>      object_property_set_uint(OBJECT(&s->emmc2), "sd-spec-version", 3,
>                               &error_abort);
> diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
> index 115359e451..82b6b48d3c 100644
> --- a/hw/arm/raspi4b.c
> +++ b/hw/arm/raspi4b.c
> @@ -66,7 +66,6 @@ static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
>
>      /* Temporary disable following devices until they are implemented*/
>      const char *to_be_removed_from_dt_as_wa[] = {
> -        "brcm,bcm2711-rng200",
>          "brcm,bcm2711-thermal",
>          "brcm,bcm2711-genet-v5",
>      };

These "add the rng device to the SoC" changes should be in their
own patch.

> diff --git a/hw/misc/bcm2838_rng200.c b/hw/misc/bcm2838_rng200.c
> index bfc40658e2..face1e9579 100644
> --- a/hw/misc/bcm2838_rng200.c
> +++ b/hw/misc/bcm2838_rng200.c
> @@ -9,6 +9,7 @@
>
>  #include "qemu/osdep.h"
>  #include "qemu/log.h"
> +#include "qom/object_interfaces.h"
>  #include "qapi/error.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/misc/bcm2838_rng200.h"
> @@ -35,6 +36,15 @@ static void bcm2838_rng200_update_irq(BCM2838Rng200State *state)
>                                & state->rng_int_status.value));
>  }
>
> +static void bcm2838_rng200_update_rbg_period(void *opaque, ClockEvent event)
> +{
> +    BCM2838Rng200State *s = (BCM2838Rng200State *)opaque;
> +
> +    ptimer_transaction_begin(s->ptimer);
> +    ptimer_set_period_from_clock(s->ptimer, s->clock, s->rng_fifo_cap * 8);
> +    ptimer_transaction_commit(s->ptimer);
> +}

What is this timer being used for, and why do we need it?
(This is a good example of the kind of thing to put into a
commit message.) It looks like it's trying to simulate the
way that real hardware only slowly fills up the RNG fifo.
But do we really need the extra complication? Does guest
software fall over if it finds that the FIFO is
full very quickly rather than taking a longer time?

> +
>  static void bcm2838_rng200_update_fifo(void *opaque, const void *buf,
>                                         size_t size)
>  {
> @@ -62,10 +72,11 @@ static void bcm2838_rng200_update_fifo(void *opaque, const void *buf,
>      if ((num == 0) && (num_bits > 0)) {
>          num = 1;
>      }
> -    if (num > 0) {
> +    if (!state->use_timer || (num > 0)) {
>          fifo8_push_all(fifo, buf, num);
>
> -        if (fifo8_num_used(fifo) > state->rng_fifo_count.thld) {
> +        if (!state->use_timer
> +                || (fifo8_num_used(fifo) > state->rng_fifo_count.thld)) {
>              state->rng_int_status.total_bits_count_irq = 1;
>          }
>      }
> @@ -82,10 +93,14 @@ static void bcm2838_rng200_fill_fifo(BCM2838Rng200State *state)
>                                  bcm2838_rng200_update_fifo, state);
>  }
>
> -/* state is temporary unused */
> -static void bcm2838_rng200_disable_rbg(BCM2838Rng200State *state
> -                                       __attribute__((unused)))
> +static void bcm2838_rng200_disable_rbg(BCM2838Rng200State *state)
>  {
> +    if (state->use_timer) {
> +        ptimer_transaction_begin(state->ptimer);
> +        ptimer_stop(state->ptimer);
> +        ptimer_transaction_commit(state->ptimer);
> +    }
> +
>      trace_bcm2838_rng200_disable_rbg();
>  }
>
> @@ -93,11 +108,38 @@ static void bcm2838_rng200_enable_rbg(BCM2838Rng200State *state)
>  {
>      state->rng_total_bit_count = RNG_WARM_UP_PERIOD_ELAPSED;
>
> -    bcm2838_rng200_fill_fifo(state);
> +    if (state->use_timer) {
> +        uint32_t div = state->rng_ctrl.div + 1;
> +
> +        ptimer_transaction_begin(state->ptimer);
> +        ptimer_set_limit(state->ptimer, div, 1);
> +        ptimer_set_count(state->ptimer, div);
> +        ptimer_run(state->ptimer, 0);
> +        ptimer_transaction_commit(state->ptimer);
> +    } else {
> +        bcm2838_rng200_fill_fifo(state);
> +    }
>
>      trace_bcm2838_rng200_enable_rbg();
>  }
>
> +static void bcm2838_rng200_ptimer_cb(void *arg)
> +{
> +    BCM2838Rng200State *state = (BCM2838Rng200State *)arg;
> +    Fifo8 *fifo = &state->fifo;
> +    size_t size = fifo8_num_free(fifo);
> +
> +    assert(state->rng_ctrl.rbg_enable);
> +
> +    if (size > 0) {
> +        rng_backend_request_entropy(state->rng, size,
> +                                    bcm2838_rng200_update_fifo, state);
> +    } else {
> +        ptimer_stop(state->ptimer);
> +        trace_bcm2838_rng200_fifo_full();
> +    }
> +}
> +
>  static void bcm2838_rng200_rng_reset(BCM2838Rng200State *state)
>  {
>      state->rng_ctrl.value = 0;
> @@ -129,6 +171,12 @@ static uint32_t bcm2838_rng200_read_fifo_data(BCM2838Rng200State *state)
>          buf = fifo8_pop_buf(fifo, max, &num);
>          if ((buf != NULL) && (num > 0)) {
>              memcpy(&ret, buf, num);
> +
> +            if (state->rng_ctrl.rbg_enable && state->use_timer) {
> +                ptimer_transaction_begin(state->ptimer);
> +                ptimer_run(state->ptimer, 0);
> +                ptimer_transaction_commit(state->ptimer);
> +            }
>          }
>      } else {
>          qemu_log_mask(
> @@ -138,7 +186,10 @@ static uint32_t bcm2838_rng200_read_fifo_data(BCM2838Rng200State *state)
>      }
>
>      state->rng_fifo_count.count = fifo8_num_used(fifo) >> 2;
> -    bcm2838_rng200_fill_fifo(state);
> +
> +    if (!state->use_timer) {
> +        bcm2838_rng200_fill_fifo(state);
> +    }
>
>      return ret;
>  }
> @@ -237,7 +288,11 @@ static void bcm2838_rng200_write(void *opaque, hwaddr offset,
>          break;
>      case RNG_TOTAL_BIT_COUNT_THRESHOLD_OFFSET:
>          s->rng_bit_count_threshold = value;
> -        s->rng_total_bit_count = value + 1;
> +        if (s->use_timer) {
> +            s->rng_total_bit_count = 0;
> +        } else {
> +            s->rng_total_bit_count = value + 1;
> +        }
>          break;
>      default:
>          qemu_log_mask(
> @@ -253,15 +308,39 @@ static const MemoryRegionOps bcm2838_rng200_ops = {
>      .read = bcm2838_rng200_read,
>      .write = bcm2838_rng200_write,
>      .endianness = DEVICE_NATIVE_ENDIAN,
> +    .impl = {
> +        .max_access_size = 4,
> +        .min_access_size = 4,
> +    },
> +    .valid = {
> +        .max_access_size = 4,
> +        .min_access_size = 4
> +    },

This should probably have been in a previous patch.

>  };
>
>  static void bcm2838_rng200_realize(DeviceState *dev, Error **errp)
>  {
>      BCM2838Rng200State *s = BCM2838_RNG200(dev);
>
> +    if (s->use_timer) {
> +        s->ptimer = ptimer_init(bcm2838_rng200_ptimer_cb, s,
> +                                BCM2838_RNG200_PTIMER_POLICY);
> +        if (s->ptimer == NULL) {
> +            error_setg(&error_fatal, "Failed to init RBG timer");
> +            return;
> +        }
> +    }
> +
>      if (s->rng == NULL) {
>          Object *default_backend = object_new(TYPE_RNG_BUILTIN);
>
> +        if (!user_creatable_complete(USER_CREATABLE(default_backend),
> +                                     errp)) {
> +            object_unref(default_backend);
> +            error_setg(errp, "Failed to create user creatable RNG backend");
> +            return;
> +        }
> +
>          object_property_add_child(OBJECT(dev), "default-backend",
>                                    default_backend);
>          object_unref(default_backend);
> @@ -270,6 +349,12 @@ static void bcm2838_rng200_realize(DeviceState *dev, Error **errp)
>                                   errp);
>      }
>
> +    if (s->use_timer && !clock_has_source(s->clock)) {
> +        ptimer_transaction_begin(s->ptimer);
> +        ptimer_set_period(s->ptimer, s->rbg_period * s->rng_fifo_cap * 8);
> +        ptimer_transaction_commit(s->ptimer);
> +    }
> +
>      fifo8_create(&s->fifo, s->rng_fifo_cap);
>      sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
>  }
> @@ -280,7 +365,7 @@ static void bcm2838_rng200_init(Object *obj)
>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>
>      s->clock = qdev_init_clock_in(DEVICE(s), "rbg-clock",
> -                                  NULL, s,
> +                                  bcm2838_rng200_update_rbg_period, s,
>                                    ClockPreUpdate);
>      if (s->clock == NULL) {
>          error_setg(&error_fatal, "Failed to init RBG clock");
> @@ -305,7 +390,7 @@ static Property bcm2838_rng200_properties[] = {
>      DEFINE_PROP_UINT32("rng-fifo-cap", BCM2838Rng200State, rng_fifo_cap, 128),
>      DEFINE_PROP_LINK("rng", BCM2838Rng200State, rng,
>                       TYPE_RNG_BACKEND, RngBackend *),
> -    DEFINE_PROP_BOOL("use-timer", BCM2838Rng200State, use_timer, false),
> +    DEFINE_PROP_BOOL("use-timer", BCM2838Rng200State, use_timer, true),

...property has flipped back to true again.

>      DEFINE_PROP_END_OF_LIST(),
>  };


thanks
-- PMM

