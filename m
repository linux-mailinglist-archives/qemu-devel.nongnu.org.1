Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8867DB285
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 05:29:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxJsB-0003Y3-VL; Mon, 30 Oct 2023 00:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qxJs9-0003Xb-Jz
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 00:27:29 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qxJs6-00085m-Nj
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 00:27:29 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-4a93e4b566bso198306e0c.1
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 21:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698640045; x=1699244845; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z1L0tJlNrsjQWof8/BVwjG2qmQfzG7BEtaw70M7ghQE=;
 b=AqPIcS1H6XEv+bZQtPRKFpc5kybRkEAxROmcvqBFi8IswK39Tvof8H3hrQo5HTwZT1
 vC9QEA4SxYYCVmhNgybxdEnMkdFfq29Z3MQPsBuAqwqesNI/f+pEplR07HwvmZr7Wikk
 G/Xln83dvX6tg7JX0n82rgCoSCWS87vSzpmPbUF+T9t9lDdPf1V7Lg36qgBFoY/pTvoT
 tw3qOmCHoctR2zbUrSKeJoHEOw4d7ePUEX5EUyct+N0rrcbNduvSXjxwVCTItydTSA42
 e+HIdP39I3pg/2FqKKyP8/FnJ3kCStYPgiDv5KkCJ/uxG+LTiAaq69gwIisJgL5lngI7
 +P7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698640045; x=1699244845;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z1L0tJlNrsjQWof8/BVwjG2qmQfzG7BEtaw70M7ghQE=;
 b=dBdZKVm+iqmcH19pv75V0T1YFVhrowKQl+1UcxJ5z3JJAwFgpBD1kAmu2QGcXIJn5U
 KjI9n8ogjFUNjEcPDrwCXEyV+vQwmaRm0hHajVB2ZRJ7MDQrt8TEHuSu6aNni3D4h+2I
 uZb2xMic+e1wRVc7O6Oh1z+qXMhu5XPPccDmThX5vXiEqYizfmmHyHx/vydLdyMqF0hU
 K3oYhXTxKBHvKVpYsmGshvpPcSU6JI8U0ueI3k4EMoHfvD/332m1uunXXVeCn0hUOmS1
 04+zRmio6NlECeQyfsC/7XZ6rtDqz+9w5MQlrg3If0y2mtG4fzyOEbIGVMr/viwXFrug
 buQQ==
X-Gm-Message-State: AOJu0Yx/XYW5PZbpIjMqAvTUXWobGGsgLlPWsxwBX8jYhBRCFcXzKXdP
 9ghD1LE0tVCd5dqmLNVV9c3cKxLBFqyuHyKbFNs=
X-Google-Smtp-Source: AGHT+IEu2YC+QxwerCXQhbeUaLSMsv3GhAUbvvcNv1yL4oyfI2VCXaMYOkmgfDM6WGORwhoXVrDm4ATTql5GjaJsRr0=
X-Received: by 2002:a1f:1c4b:0:b0:49a:56d2:562d with SMTP id
 c72-20020a1f1c4b000000b0049a56d2562dmr7441402vkc.4.1698640045362; Sun, 29 Oct
 2023 21:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <04E66FC8-A5DC-469B-B23E-8FF9E4757915@icloud.com>
In-Reply-To: <04E66FC8-A5DC-469B-B23E-8FF9E4757915@icloud.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 30 Oct 2023 14:26:58 +1000
Message-ID: <CAKmqyKO6UJnMHuPhjiBiQK4M4tOzT00omVt=48T-rEhDdn_anA@mail.gmail.com>
Subject: Re: Patch to fix malfunctioning of T2-T5 timers on the STM32 platform
To: Lucjan Bryndza <lbryndza.oss@icloud.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa32.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sat, Oct 28, 2023 at 5:55=E2=80=AFAM Lucjan Bryndza <lbryndza.oss@icloud=
.com> wrote:
>
>
> Current implementation of T2 - T5 times on the STM32 platform does not wo=
rk properly.
> After configuring the timer-counter circuit to report interrupts every 10=
ms, in reality the first interrupt is reported
> only once after a few seconds, while subsequent interrupts do not come.
> The current code also does not properly emulate the operation of even the=
 basic functions of the TIME-BASE unit.
> This patch contains fixes that reimplements the basic functionality
> of the time base unit such as up-counting down-counting , and alternate-m=
ode up-down counting.
> The ptimer() API is used to emulate timers.
> After applying the patch, STM32 timer works correctly in its basic functi=
onality.
> The ISIX-RTOS test unit was used to test the patch.
> Links and instructions can be found below:
>
> https://github.com/lucckb/isixrtos/blob/master/tests/libisix/01_basic_pri=
mitives.cpp
> https://github.com/lucckb/isixrtos/blob/master/extras/doc/unit_test_qemu.=
md
>
>
> qemu-system-arm -M olimex-stm32-h405  -kernel build/tests/libisix/isixuni=
ttests.binary -nographic
> unittests_entry.cpp:146|ISIX VERSION pub/ep0319-157-gb239b35f-dirty
> unittests_entry.cpp:83|Exceptions pretest. OK
> 51 selected tests
> [   RUN    ] 01_base_00 TimeBase timer vs systick
> [  1001ms  ] ...
> [   RUN    ] 01_base_01 Basic heap allocator
> [   1ms    ] ...

Hello,

Thanks for the patch. The STM32 timers were tested when they were
written, but it is entirely possible there are bugs in there. It's
great to see you are using the STM32 emulation and contributing back.

When submitting patches, can you please follow the documentation on
the QEMU wiki: https://www.qemu.org/docs/master/devel/submitting-a-patch.ht=
ml#split-up-long-patches

The most important part is splitting up patches into small self
contained changes. That way it's easy to review and test each change.
You can then submit the changes as a patch series.

>
>
> Best Regards
> Lucjan Bryndza
>
>
> From 3ccfe70979d1b263d4fa22104ecf42ac5a628554 Mon Sep 17 00:00:00 2001
> From: Lucjan Bryndza <lbryndza.oss@icloud.com>
> Date: Thu, 26 Oct 2023 22:45:26 +0200
> Subject: [PATCH] Fixing the basic functionality of STM32 timers

When submitting a patch please use git send-email, there are
instructions here:
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#submitting-y=
our-patches

>
> The current implementation of timers does not work properly
> even in the basic functionality. A counter configured to report
> an interrupt 10ms every reports the first interrupts after a
> few seconds.   Count up and
> count down modes are also not properly implemented. This commit fixes bug=
s with interrupt
> reporting and implements the basic modes of the counter's
> time-base block.
>
> Signed-off-by: Lucjan Bryndza <lbryndza.oss@icloud.com>
> ---
>  hw/arm/stm32f405_soc.c             |   2 +-
>  hw/timer/stm32f2xx_timer.c         | 291 ++++++++++++++++++-----------
>  include/hw/timer/stm32f2xx_timer.h |  23 ++-
>  3 files changed, 202 insertions(+), 114 deletions(-)
>
> diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
> index cef23d7ee4..69316181b3 100644
> --- a/hw/arm/stm32f405_soc.c
> +++ b/hw/arm/stm32f405_soc.c
> @@ -183,7 +183,7 @@ static void stm32f405_soc_realize(DeviceState *dev_so=
c, Error **errp)
>      /* Timer 2 to 5 */
>      for (i =3D 0; i < STM_NUM_TIMERS; i++) {
>          dev =3D DEVICE(&(s->timer[i]));
> -        qdev_prop_set_uint64(dev, "clock-frequency", 1000000000);
> +       qdev_prop_set_uint64(dev, "clock-frequency", 48000000);
>          if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), errp)) {
>              return;
>          }
> diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
> index ba8694dcd3..65f3287125 100644
> --- a/hw/timer/stm32f2xx_timer.c
> +++ b/hw/timer/stm32f2xx_timer.c
> @@ -29,11 +29,18 @@
>  #include "migration/vmstate.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
> +#include "qemu/typedefs.h"
> +#include "qemu/timer.h"
> +#include "qemu/main-loop.h"
> +#include "sysemu/dma.h"
>
>  #ifndef STM_TIMER_ERR_DEBUG
>  #define STM_TIMER_ERR_DEBUG 0
>  #endif
>
> +/* PCLK /4 */
> +#define CLOCK_FREQUENCY 48000000ULL
> +
>  #define DB_PRINT_L(lvl, fmt, args...) do { \
>      if (STM_TIMER_ERR_DEBUG >=3D lvl) { \
>          qemu_log("%s: " fmt, __func__, ## args); \
> @@ -42,63 +49,87 @@
>
>  #define DB_PRINT(fmt, args...) DB_PRINT_L(1, fmt, ## args)
>
> -static void stm32f2xx_timer_set_alarm(STM32F2XXTimerState *s, int64_t no=
w);
>
> -static void stm32f2xx_timer_interrupt(void *opaque)
> +static uint32_t stm32f2xx_timer_get_count(STM32F2XXTimerState *s)
>  {
> -    STM32F2XXTimerState *s =3D opaque;
> -
> -    DB_PRINT("Interrupt\n");
> -
> -    if (s->tim_dier & TIM_DIER_UIE && s->tim_cr1 & TIM_CR1_CEN) {
> -        s->tim_sr |=3D 1;
> -        qemu_irq_pulse(s->irq);
> -        stm32f2xx_timer_set_alarm(s, s->hit_time);
> -    }
> -
> -    if (s->tim_ccmr1 & (TIM_CCMR1_OC2M2 | TIM_CCMR1_OC2M1) &&
> -        !(s->tim_ccmr1 & TIM_CCMR1_OC2M0) &&
> -        s->tim_ccmr1 & TIM_CCMR1_OC2PE &&
> -        s->tim_ccer & TIM_CCER_CC2E) {
> -        /* PWM 2 - Mode 1 */
> -        DB_PRINT("PWM2 Duty Cycle: %d%%\n",
> -                s->tim_ccr2 / (100 * (s->tim_psc + 1)));
> +    uint64_t cnt =3D ptimer_get_count(s->timer);
> +    if (s->count_mode =3D=3D TIMER_UP_COUNT) {
> +        return s->tim_arr - (cnt & 0xffff);
> +    } else {
> +        return cnt & 0xffff;
>      }
>  }
>
> -static inline int64_t stm32f2xx_ns_to_ticks(STM32F2XXTimerState *s, int6=
4_t t)
> +
> +static void stm32f2xx_timer_set_count(STM32F2XXTimerState *s, uint32_t c=
nt)
>  {
> -    return muldiv64(t, s->freq_hz, 1000000000ULL) / (s->tim_psc + 1);
> +    if (s->count_mode =3D=3D TIMER_UP_COUNT) {
> +        ptimer_set_count(s->timer, s->tim_arr - (cnt & 0xffff));
> +    } else {
> +        ptimer_set_count(s->timer, cnt & 0xffff);
> +    }
>  }
>
> -static void stm32f2xx_timer_set_alarm(STM32F2XXTimerState *s, int64_t no=
w)
> +static void stm32f2xx_timer_update(STM32F2XXTimerState *s)
>  {
> -    uint64_t ticks;
> -    int64_t now_ticks;
> +    if (s->tim_cr1 & TIM_CR1_DIR) {
> +        s->count_mode =3D TIMER_DOWN_COUNT;
> +    } else {
> +        s->count_mode =3D TIMER_UP_COUNT;
> +    }
>
> -    if (s->tim_arr =3D=3D 0) {
> -        return;
> +    if (s->tim_cr1 & TIM_CR1_CMS) {
> +        s->count_mode =3D TIMER_UP_COUNT;
>      }
>
> -    DB_PRINT("Alarm set at: 0x%x\n", s->tim_cr1);
> +    if (s->tim_cr1 & TIM_CR1_CEN) {
> +        DB_PRINT("Enabling timer\n");
> +        ptimer_set_freq(s->timer, s->freq_hz);
> +        ptimer_run(s->timer, !(s->tim_cr1 & 0x04));
> +    } else {
> +        DB_PRINT("Disabling timer\n");
> +        ptimer_stop(s->timer);
> +    }
> +}
>
> -    now_ticks =3D stm32f2xx_ns_to_ticks(s, now);
> -    ticks =3D s->tim_arr - (now_ticks - s->tick_offset);
> +static void stm32f2xx_timer_update_uif(STM32F2XXTimerState *s, uint8_t v=
alue)
> +{
> +    s->tim_sr &=3D ~TIM_SR1_UIF;
> +    s->tim_sr |=3D (value & TIM_SR1_UIF);
> +    qemu_set_irq(s->irq, value);
> +}
>
> -    DB_PRINT("Alarm set in %d ticks\n", (int) ticks);
> +static void stm32f2xx_timer_tick(void *opaque)
> +{
> +    STM32F2XXTimerState *s =3D (STM32F2XXTimerState *)opaque;
> +    DB_PRINT("Alarm raised\n");
> +    stm32f2xx_timer_update_uif(s, 1);
> +
> +    if (s->count_mode =3D=3D TIMER_UP_COUNT) {
> +        stm32f2xx_timer_set_count(s, 0);
> +    } else {
> +        stm32f2xx_timer_set_count(s, s->tim_arr);
> +    }
>
> -    s->hit_time =3D muldiv64((ticks + (uint64_t) now_ticks) * (s->tim_ps=
c + 1),
> -                               1000000000ULL, s->freq_hz);
> +    if (s->tim_cr1 & TIM_CR1_CMS) {
> +        if (s->count_mode =3D=3D TIMER_UP_COUNT) {
> +            s->count_mode =3D TIMER_DOWN_COUNT;
> +        } else {
> +            s->count_mode =3D TIMER_UP_COUNT;
> +        }
> +    }
>
> -    timer_mod(s->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + s->hit_t=
ime);
> -    DB_PRINT("Wait Time: %" PRId64 " ticks\n", s->hit_time);
> +    if (s->tim_cr1 & TIM_CR1_OPM) {
> +        s->tim_cr1 &=3D ~TIM_CR1_CEN;
> +    } else {
> +        stm32f2xx_timer_update(s);
> +    }
>  }
>
> +
>  static void stm32f2xx_timer_reset(DeviceState *dev)
>  {
>      STM32F2XXTimerState *s =3D STM32F2XXTIMER(dev);
> -    int64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> -
>      s->tim_cr1 =3D 0;
>      s->tim_cr2 =3D 0;
>      s->tim_smcr =3D 0;
> @@ -117,8 +148,6 @@ static void stm32f2xx_timer_reset(DeviceState *dev)
>      s->tim_dcr =3D 0;
>      s->tim_dmar =3D 0;
>      s->tim_or =3D 0;
> -
> -    s->tick_offset =3D stm32f2xx_ns_to_ticks(s, now);
>  }
>
>  static uint64_t stm32f2xx_timer_read(void *opaque, hwaddr offset,
> @@ -132,15 +161,18 @@ static uint64_t stm32f2xx_timer_read(void *opaque, =
hwaddr offset,
>      case TIM_CR1:
>          return s->tim_cr1;
>      case TIM_CR2:
> -        return s->tim_cr2;
> +        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: CR2 not supported")=
;
> +        return 0;
>      case TIM_SMCR:
> -        return s->tim_smcr;
> +        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: SMCR not supported"=
);
> +        return 0;
>      case TIM_DIER:
>          return s->tim_dier;
>      case TIM_SR:
>          return s->tim_sr;
>      case TIM_EGR:
> -        return s->tim_egr;
> +        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: EGR write only");
> +        return 0;
>      case TIM_CCMR1:
>          return s->tim_ccmr1;
>      case TIM_CCMR2:
> @@ -148,8 +180,7 @@ static uint64_t stm32f2xx_timer_read(void *opaque, hw=
addr offset,
>      case TIM_CCER:
>          return s->tim_ccer;
>      case TIM_CNT:
> -        return stm32f2xx_ns_to_ticks(s, qemu_clock_get_ns(QEMU_CLOCK_VIR=
TUAL)) -
> -               s->tick_offset;
> +        return stm32f2xx_timer_get_count(s);
>      case TIM_PSC:
>          return s->tim_psc;
>      case TIM_ARR:
> @@ -163,105 +194,152 @@ static uint64_t stm32f2xx_timer_read(void *opaque=
, hwaddr offset,
>      case TIM_CCR4:
>          return s->tim_ccr4;
>      case TIM_DCR:
> -        return s->tim_dcr;
> +        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: DCR not supported")=
;
> +        return 0;
>      case TIM_DMAR:
> -        return s->tim_dmar;
> +        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: CR2 not supported")=
;
> +        return 0;
>      case TIM_OR:
>          return s->tim_or;
>      default:
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, off=
set);
>      }
> -
>      return 0;
>  }
>
> +static void stm32f2xx_update_cr1(STM32F2XXTimerState *s, uint64_t value)
> +{
> +    s->tim_cr1 =3D value & 0x3FF;
> +    ptimer_transaction_begin(s->timer);
> +    stm32f2xx_timer_update(s);
> +    ptimer_transaction_commit(s->timer);
> +    DB_PRINT("write cr1 =3D %x\n", s->tim_cr1);
> +}
> +
> +static void stm32f2xx_update_sr(STM32F2XXTimerState *s, uint64_t value)
> +{
> +    s->tim_sr ^=3D (value ^ 0xFFFF);
> +    s->tim_sr &=3D 0x1eFF;
> +    ptimer_transaction_begin(s->timer);
> +    stm32f2xx_timer_update_uif(s, s->tim_sr & 0x1);
> +    ptimer_transaction_commit(s->timer);
> +    DB_PRINT("write sr =3D %x\n", s->tim_sr);
> +}
> +
> +static void stm32f2xx_update_psc(STM32F2XXTimerState *s, uint64_t value)
> +{
> +    s->tim_psc =3D value & 0xffff;
> +    ptimer_transaction_begin(s->timer);
> +    ptimer_set_freq(s->timer, s->freq_hz);
> +    ptimer_transaction_commit(s->timer);
> +    DB_PRINT("write psc =3D %x\n", s->tim_psc);
> +}
> +
> +static void stm32f2xx_update_egr(STM32F2XXTimerState *s, uint64_t value)
> +{
> +    s->tim_egr =3D value & 0x1E;
> +    if (value & TIM_EGR_TG) {
> +        s->tim_sr |=3D TIM_EGR_TG;
> +    }
> +    if (value & TIM_EGR_UG) {
> +        /* UG bit - reload */
> +        ptimer_transaction_begin(s->timer);
> +        ptimer_set_limit(s->timer, s->tim_arr, 1);
> +        ptimer_transaction_commit(s->timer);
> +    }
> +    DB_PRINT("write EGR =3D %x\n", s->tim_egr);
> +}
> +
> +static void stm32f2xx_update_cnt(STM32F2XXTimerState *s, uint64_t value)
> +{
> +    ptimer_transaction_begin(s->timer);
> +    stm32f2xx_timer_set_count(s, value & 0xffff);
> +    ptimer_transaction_commit(s->timer);
> +    DB_PRINT("write cnt =3D %x\n", stm32f2xx_timer_get_count(s));
> +}
> +
> +static void stm32f2xx_update_arr(STM32F2XXTimerState *s, uint64_t value)
> +{
> +    s->tim_arr =3D value & 0xffff;
> +    ptimer_transaction_begin(s->timer);
> +    ptimer_set_limit(s->timer, s->tim_arr, 1);
> +    ptimer_transaction_commit(s->timer);
> +    DB_PRINT("write arr =3D %x\n", s->tim_arr);
> +}
> +
>  static void stm32f2xx_timer_write(void *opaque, hwaddr offset,
> -                        uint64_t val64, unsigned size)
> +                        uint64_t value, unsigned size)
>  {
>      STM32F2XXTimerState *s =3D opaque;
> -    uint32_t value =3D val64;
> -    int64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> -    uint32_t timer_val =3D 0;
> -
> -    DB_PRINT("Write 0x%x, 0x%"HWADDR_PRIx"\n", value, offset);
>
>      switch (offset) {
>      case TIM_CR1:
> -        s->tim_cr1 =3D value;
> -        return;
> +       stm32f2xx_update_cr1(s, value);
> +       break;
>      case TIM_CR2:
> -        s->tim_cr2 =3D value;
> -        return;
> +        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: CR2 not supported")=
;
> +        break;
>      case TIM_SMCR:
> -        s->tim_smcr =3D value;
> -        return;
> +        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: SCMR not supported"=
);
> +        break;
>      case TIM_DIER:
> -        s->tim_dier =3D value;
> -        return;
> +        s->tim_dier =3D value & 0x5F5F;
> +        DB_PRINT("write dier =3D %x\n", s->tim_dier);
> +        break;
>      case TIM_SR:
> -        /* This is set by hardware and cleared by software */
> -        s->tim_sr &=3D value;
> -        return;
> +        stm32f2xx_update_sr(s, value);
> +        break;
>      case TIM_EGR:
> -        s->tim_egr =3D value;
> -        if (s->tim_egr & TIM_EGR_UG) {
> -            timer_val =3D 0;
> -            break;
> -        }
> -        return;
> +        stm32f2xx_update_egr(s, value);
> +        break;
>      case TIM_CCMR1:
> -        s->tim_ccmr1 =3D value;
> -        return;
> +        s->tim_ccmr1 =3D value & 0xffff;
> +        DB_PRINT("write ccmr1 =3D %x\n", s->tim_ccmr1);
> +        break;
>      case TIM_CCMR2:
> -        s->tim_ccmr2 =3D value;
> -        return;
> +        s->tim_ccmr2 =3D value & 0xffff;
> +        DB_PRINT("write ccmr2 =3D %x\n", s->tim_ccmr2);
> +        break;
>      case TIM_CCER:
> -        s->tim_ccer =3D value;
> -        return;
> +        s->tim_ccer =3D value & 0x3333;
> +        DB_PRINT("write ccer =3D %x\n", s->tim_ccer);
> +        break;
>      case TIM_PSC:
> -        timer_val =3D stm32f2xx_ns_to_ticks(s, now) - s->tick_offset;
> -        s->tim_psc =3D value & 0xFFFF;
> +        stm32f2xx_update_psc(s, value);
>          break;
>      case TIM_CNT:
> -        timer_val =3D value;
> +        stm32f2xx_update_cnt(s, value);
>          break;
>      case TIM_ARR:
> -        s->tim_arr =3D value;
> -        stm32f2xx_timer_set_alarm(s, now);
> -        return;
> +        stm32f2xx_update_arr(s, value);
> +        break;
>      case TIM_CCR1:
> -        s->tim_ccr1 =3D value;
> -        return;
> +        s->tim_ccr1 =3D value & 0xffff;
> +        break;
>      case TIM_CCR2:
> -        s->tim_ccr2 =3D value;
> -        return;
> +        s->tim_ccr2 =3D value & 0xffff;
> +        break;
>      case TIM_CCR3:
> -        s->tim_ccr3 =3D value;
> -        return;
> +        s->tim_ccr3 =3D value & 0xffff;
> +        break;
>      case TIM_CCR4:
> -        s->tim_ccr4 =3D value;
> -        return;
> +        s->tim_ccr4 =3D value & 0xffff;
> +        break;
>      case TIM_DCR:
> -        s->tim_dcr =3D value;
> -        return;
> +        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: DCR not supported")=
;
> +        break;
>      case TIM_DMAR:
> -        s->tim_dmar =3D value;
> -        return;
> +        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: DMAR not supported"=
);
> +        break;
>      case TIM_OR:
> -        s->tim_or =3D value;
> -        return;
> +        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: OR not supported");
> +        break;
>      default:
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, off=
set);
> -        return;
> +        break;

Why convert these from return to break?

>      }
> -
> -    /* This means that a register write has affected the timer in a way =
that
> -     * requires a refresh of both tick_offset and the alarm.
> -     */
> -    s->tick_offset =3D stm32f2xx_ns_to_ticks(s, now) - timer_val;
> -    stm32f2xx_timer_set_alarm(s, now);
>  }
>
>  static const MemoryRegionOps stm32f2xx_timer_ops =3D {
> @@ -275,7 +353,7 @@ static const VMStateDescription vmstate_stm32f2xx_tim=
er =3D {
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,

You will need to increment version_id and minimum_version_id here as
this is a breaking change

>      .fields =3D (VMStateField[]) {
> -        VMSTATE_INT64(tick_offset, STM32F2XXTimerState),
> +        VMSTATE_INT32(count_mode, STM32F2XXTimerState),
>          VMSTATE_UINT32(tim_cr1, STM32F2XXTimerState),
>          VMSTATE_UINT32(tim_cr2, STM32F2XXTimerState),
>          VMSTATE_UINT32(tim_smcr, STM32F2XXTimerState),
> @@ -300,25 +378,24 @@ static const VMStateDescription vmstate_stm32f2xx_t=
imer =3D {
>
>  static Property stm32f2xx_timer_properties[] =3D {
>      DEFINE_PROP_UINT64("clock-frequency", struct STM32F2XXTimerState,
> -                       freq_hz, 1000000000),
> +                       freq_hz, CLOCK_FREQUENCY),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
>  static void stm32f2xx_timer_init(Object *obj)
>  {
>      STM32F2XXTimerState *s =3D STM32F2XXTIMER(obj);
> -
>      sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
> -

You don't need to remove these lines

>      memory_region_init_io(&s->iomem, obj, &stm32f2xx_timer_ops, s,
>                            "stm32f2xx_timer", 0x400);
>      sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
> +

Or add this one

Alistair

>  }
>
>  static void stm32f2xx_timer_realize(DeviceState *dev, Error **errp)
>  {
>      STM32F2XXTimerState *s =3D STM32F2XXTIMER(dev);
> -    s->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, stm32f2xx_timer_interr=
upt, s);
> +    s->timer =3D ptimer_init(stm32f2xx_timer_tick, s, PTIMER_POLICY_LEGA=
CY);
>  }
>
>  static void stm32f2xx_timer_class_init(ObjectClass *klass, void *data)
> diff --git a/include/hw/timer/stm32f2xx_timer.h b/include/hw/timer/stm32f=
2xx_timer.h
> index 90f40f1746..c83f7b0d6f 100644
> --- a/include/hw/timer/stm32f2xx_timer.h
> +++ b/include/hw/timer/stm32f2xx_timer.h
> @@ -28,6 +28,7 @@
>  #include "hw/sysbus.h"
>  #include "qemu/timer.h"
>  #include "qom/object.h"
> +#include "hw/ptimer.h"
>
>  #define TIM_CR1      0x00
>  #define TIM_CR2      0x04
> @@ -49,9 +50,15 @@
>  #define TIM_DMAR     0x4C
>  #define TIM_OR       0x50
>
> -#define TIM_CR1_CEN   1
> +#define TIM_CR1_CEN 0x0001
> +#define TIM_CR1_DIR 0x0010
> +#define TIM_CR1_CMS 0x0060
> +#define TIM_CR1_OPM 0x0008
>
> -#define TIM_EGR_UG 1
> +#define TIM_SR1_UIF 0x0001
> +
> +#define TIM_EGR_UG 0x0001
> +#define TIM_EGR_TG 0x0040
>
>  #define TIM_CCER_CC2E   (1 << 4)
>  #define TIM_CCMR1_OC2M2 (1 << 14)
> @@ -61,6 +68,7 @@
>
>  #define TIM_DIER_UIE  1
>
> +
>  #define TYPE_STM32F2XX_TIMER "stm32f2xx-timer"
>  typedef struct STM32F2XXTimerState STM32F2XXTimerState;
>  DECLARE_INSTANCE_CHECKER(STM32F2XXTimerState, STM32F2XXTIMER,
> @@ -72,12 +80,10 @@ struct STM32F2XXTimerState {
>
>      /* <public> */
>      MemoryRegion iomem;
> -    QEMUTimer *timer;
> +    ptimer_state *timer;
>      qemu_irq irq;
> -
> -    int64_t tick_offset;
> -    uint64_t hit_time;
>      uint64_t freq_hz;
> +    int count_mode;
>
>      uint32_t tim_cr1;
>      uint32_t tim_cr2;
> @@ -99,4 +105,9 @@ struct STM32F2XXTimerState {
>      uint32_t tim_or;
>  };
>
> +enum {
> +    TIMER_UP_COUNT     =3D 0,
> +    TIMER_DOWN_COUNT   =3D 1
> +};
> +
>  #endif /* HW_STM32F2XX_TIMER_H */
> --
> 2.39.3 (Apple Git-145)
>
>

