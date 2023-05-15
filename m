Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4E3703DC0
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 21:31:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pydso-0005wX-DY; Mon, 15 May 2023 15:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1pydsl-0005vq-Sc; Mon, 15 May 2023 15:29:19 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1pydsh-0006kl-MJ; Mon, 15 May 2023 15:29:19 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-ba6e90e9199so6252369276.0; 
 Mon, 15 May 2023 12:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684178954; x=1686770954;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=esHYvXeZJkqQw7R9rg1TW90ziSNlIv2BfMZaFHwa4iE=;
 b=lUuqZEuGzLUZP9obiFXXNNmkgoLjeBpbsSl1G2y4UoaE/Qq1zkc6cskCJKiartf/nv
 HavPJ0Ien8JqBKL4rrbK9nXSxSDU8xqJn+IS0/fis07ynhiIrEYgulrTyfQke19eGZm6
 z24lFuWZqxFwUCDaaZhTiK9Opj0s0yBwd0Qlt00US6WJ4uQ4wlG/9HwL63yT56OzziA7
 Zw1AORxoEe5KQJ7v62Un3kPOzJ3xE7SuAbRkXD1Y1jkvFg0m7Eor5NjjEj1b64YvNvu2
 yhpfE2CgKAOTcQYUt0hLei9Ul1akKUr5rPugA6K60WLSCA9Zmr9OCslk3/1v2W42sxM3
 NI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684178954; x=1686770954;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=esHYvXeZJkqQw7R9rg1TW90ziSNlIv2BfMZaFHwa4iE=;
 b=drthhejGcrTu0Ebv8l6Dvw73GE5JcpvRqTK3cYdjLzhf5W/mLXp3qTHtoDC+zBz+qh
 N+eixIw6dhG4H2j8+/2KmdldU4eKXfxMAJP5R/XEKmTLKs7gfeEESlps42flw2MSjXCs
 GQf8J6qr/UCNo8ddryW1vrcHO5IhpzCBtwdBiLuGtx9Ab4EVH339uAbxlxX3hO8AfR2V
 Jv6p8t179b6V28KvhUTvP75kidorEaPShfsnC1MJc1x8t4L+C0mN7GMTOIJgnB43TsMS
 BeRyKoA5fMqgKtqoahcx+Nuv9gzcxcpbEVs+aj300/SeWczy2Hehj0XEHrfoNQcyJJKY
 DSPQ==
X-Gm-Message-State: AC+VfDzs4i+eETNyB2d0hBc1apTQCJlXBBW4DHWAtGgcDAZQZ6NB8Q8T
 aS/6Zja5bdzuM2QPqUFJGc1T775dPsrUMqdbBzY=
X-Google-Smtp-Source: ACHHUZ6bJj6+pIiFk/DuRwURx/TBXgW4g5tVly1ZgISWAR8PKV/5vs20QFYww6LYRWB3nKmOxLhpaVD6w1sc2IKyOXY=
X-Received: by 2002:a25:ae9a:0:b0:ba7:5181:9f92 with SMTP id
 b26-20020a25ae9a000000b00ba751819f92mr7367768ybj.34.1684178953678; Mon, 15
 May 2023 12:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230510103004.30015-1-qianfanguijin@163.com>
 <20230510103004.30015-6-qianfanguijin@163.com>
In-Reply-To: <20230510103004.30015-6-qianfanguijin@163.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Mon, 15 May 2023 21:29:02 +0200
Message-ID: <CAPan3Woc64177GOYyn+mYapc6Ntq+T_u_4bf-hZQ9_61qRiHKQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/11] hw/misc: Rename axp209 to axp22x and add support
 AXP221 PMU
To: qianfanguijin@163.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Beniamino Galvani <b.galvani@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000045b6e405fbc0782c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-yb1-xb2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--00000000000045b6e405fbc0782c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Qianfan,

Good idea indeed to turn this driver into a more generic one. If possible,
its best to re-use code rather than adding new.

On Wed, May 10, 2023 at 12:30=E2=80=AFPM <qianfanguijin@163.com> wrote:

> From: qianfan Zhao <qianfanguijin@163.com>
>
> This patch adds minimal support for AXP-221 PMU and connect it to
> bananapi M2U board.
>
> Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
> ---
>  hw/arm/Kconfig        |   3 +-
>  hw/arm/bananapi_m2u.c |   6 +
>  hw/misc/Kconfig       |   2 +-
>  hw/misc/axp209.c      | 238 -----------------------------------
>  hw/misc/axp2xx.c      | 283 ++++++++++++++++++++++++++++++++++++++++++
>  hw/misc/meson.build   |   2 +-
>  hw/misc/trace-events  |   8 +-
>  7 files changed, 297 insertions(+), 245 deletions(-)
>  delete mode 100644 hw/misc/axp209.c
>  create mode 100644 hw/misc/axp2xx.c
>
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index b7a84f6e3f..bad4ea158c 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -355,7 +355,7 @@ config ALLWINNER_A10
>      select ALLWINNER_WDT
>      select ALLWINNER_EMAC
>      select ALLWINNER_I2C
> -    select AXP209_PMU
> +    select AXP2XX_PMU
>      select SERIAL
>      select UNIMP
>
> @@ -378,6 +378,7 @@ config ALLWINNER_R40
>      bool
>      default y if TCG && ARM
>      select ALLWINNER_A10_PIT
> +    select AXP2XX_PMU
>      select SERIAL
>      select ARM_TIMER
>      select ARM_GIC
> diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
> index 1d49a006b5..9c5360a41b 100644
> --- a/hw/arm/bananapi_m2u.c
> +++ b/hw/arm/bananapi_m2u.c
> @@ -23,6 +23,7 @@
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "hw/boards.h"
> +#include "hw/i2c/i2c.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/arm/allwinner-r40.h"
>
> @@ -61,6 +62,7 @@ static void bpim2u_init(MachineState *machine)
>  {
>      bool bootroom_loaded =3D false;
>      AwR40State *r40;
> +    I2CBus *i2c;
>
>      /* BIOS is not supported by this board */
>      if (machine->firmware) {
> @@ -104,6 +106,10 @@ static void bpim2u_init(MachineState *machine)
>          }
>      }
>
> +    /* Connect AXP221 */
> +    i2c =3D I2C_BUS(qdev_get_child_bus(DEVICE(&r40->i2c0), "i2c"));
> +    i2c_slave_create_simple(i2c, "axp221_pmu", 0x34);
> +
>      /* SDRAM */
>      memory_region_add_subregion(get_system_memory(),
>                                  r40->memmap[AW_R40_DEV_SDRAM],
> machine->ram);
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 2ef5781ef8..efeb430a6c 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -176,7 +176,7 @@ config ALLWINNER_A10_CCM
>  config ALLWINNER_A10_DRAMC
>      bool
>
> -config AXP209_PMU
> +config AXP2XX_PMU
>      bool
>      depends on I2C
>
> diff --git a/hw/misc/axp209.c b/hw/misc/axp209.c
> deleted file mode 100644
> index 2908ed99a6..0000000000
> --- a/hw/misc/axp209.c
> +++ /dev/null
> @@ -1,238 +0,0 @@
> -/*
> - * AXP-209 PMU Emulation
> - *
> - * Copyright (C) 2022 Strahinja Jankovic <strahinja.p.jankovic@gmail.com=
>
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining=
 a
> - * copy of this software and associated documentation files (the
> "Software"),
> - * to deal in the Software without restriction, including without
> limitation
> - * the rights to use, copy, modify, merge, publish, distribute,
> sublicense,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be
> included in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
> SHALL THE
> - * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHE=
R
> - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG
> - * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> - * DEALINGS IN THE SOFTWARE.
> - *
> - * SPDX-License-Identifier: MIT
> - */
> -
> -#include "qemu/osdep.h"
> -#include "qemu/log.h"
> -#include "trace.h"
> -#include "hw/i2c/i2c.h"
> -#include "migration/vmstate.h"
> -
> -#define TYPE_AXP209_PMU "axp209_pmu"
> -
> -#define AXP209(obj) \
> -    OBJECT_CHECK(AXP209I2CState, (obj), TYPE_AXP209_PMU)
> -
> -/* registers */
> -enum {
> -    REG_POWER_STATUS =3D 0x0u,
> -    REG_OPERATING_MODE,
> -    REG_OTG_VBUS_STATUS,
> -    REG_CHIP_VERSION,
> -    REG_DATA_CACHE_0,
> -    REG_DATA_CACHE_1,
> -    REG_DATA_CACHE_2,
> -    REG_DATA_CACHE_3,
> -    REG_DATA_CACHE_4,
> -    REG_DATA_CACHE_5,
> -    REG_DATA_CACHE_6,
> -    REG_DATA_CACHE_7,
> -    REG_DATA_CACHE_8,
> -    REG_DATA_CACHE_9,
> -    REG_DATA_CACHE_A,
> -    REG_DATA_CACHE_B,
> -    REG_POWER_OUTPUT_CTRL =3D 0x12u,
> -    REG_DC_DC2_OUT_V_CTRL =3D 0x23u,
> -    REG_DC_DC2_DVS_CTRL =3D 0x25u,
> -    REG_DC_DC3_OUT_V_CTRL =3D 0x27u,
> -    REG_LDO2_4_OUT_V_CTRL,
> -    REG_LDO3_OUT_V_CTRL,
> -    REG_VBUS_CH_MGMT =3D 0x30u,
> -    REG_SHUTDOWN_V_CTRL,
> -    REG_SHUTDOWN_CTRL,
> -    REG_CHARGE_CTRL_1,
> -    REG_CHARGE_CTRL_2,
> -    REG_SPARE_CHARGE_CTRL,
> -    REG_PEK_KEY_CTRL,
> -    REG_DC_DC_FREQ_SET,
> -    REG_CHR_TEMP_TH_SET,
> -    REG_CHR_HIGH_TEMP_TH_CTRL,
> -    REG_IPSOUT_WARN_L1,
> -    REG_IPSOUT_WARN_L2,
> -    REG_DISCHR_TEMP_TH_SET,
> -    REG_DISCHR_HIGH_TEMP_TH_CTRL,
> -    REG_IRQ_BANK_1_CTRL =3D 0x40u,
> -    REG_IRQ_BANK_2_CTRL,
> -    REG_IRQ_BANK_3_CTRL,
> -    REG_IRQ_BANK_4_CTRL,
> -    REG_IRQ_BANK_5_CTRL,
> -    REG_IRQ_BANK_1_STAT =3D 0x48u,
> -    REG_IRQ_BANK_2_STAT,
> -    REG_IRQ_BANK_3_STAT,
> -    REG_IRQ_BANK_4_STAT,
> -    REG_IRQ_BANK_5_STAT,
> -    REG_ADC_ACIN_V_H =3D 0x56u,
> -    REG_ADC_ACIN_V_L,
> -    REG_ADC_ACIN_CURR_H,
> -    REG_ADC_ACIN_CURR_L,
> -    REG_ADC_VBUS_V_H,
> -    REG_ADC_VBUS_V_L,
> -    REG_ADC_VBUS_CURR_H,
> -    REG_ADC_VBUS_CURR_L,
> -    REG_ADC_INT_TEMP_H,
> -    REG_ADC_INT_TEMP_L,
> -    REG_ADC_TEMP_SENS_V_H =3D 0x62u,
> -    REG_ADC_TEMP_SENS_V_L,
> -    REG_ADC_BAT_V_H =3D 0x78u,
> -    REG_ADC_BAT_V_L,
> -    REG_ADC_BAT_DISCHR_CURR_H,
> -    REG_ADC_BAT_DISCHR_CURR_L,
> -    REG_ADC_BAT_CHR_CURR_H,
> -    REG_ADC_BAT_CHR_CURR_L,
> -    REG_ADC_IPSOUT_V_H,
> -    REG_ADC_IPSOUT_V_L,
> -    REG_DC_DC_MOD_SEL =3D 0x80u,
> -    REG_ADC_EN_1,
> -    REG_ADC_EN_2,
> -    REG_ADC_SR_CTRL,
> -    REG_ADC_IN_RANGE,
> -    REG_GPIO1_ADC_IRQ_RISING_TH,
> -    REG_GPIO1_ADC_IRQ_FALLING_TH,
> -    REG_TIMER_CTRL =3D 0x8au,
> -    REG_VBUS_CTRL_MON_SRP,
> -    REG_OVER_TEMP_SHUTDOWN =3D 0x8fu,
> -    REG_GPIO0_FEAT_SET,
> -    REG_GPIO_OUT_HIGH_SET,
> -    REG_GPIO1_FEAT_SET,
> -    REG_GPIO2_FEAT_SET,
> -    REG_GPIO_SIG_STATE_SET_MON,
> -    REG_GPIO3_SET,
> -    REG_COULOMB_CNTR_CTRL =3D 0xb8u,
> -    REG_POWER_MEAS_RES,
> -    NR_REGS
> -};
> -
> -#define AXP209_CHIP_VERSION_ID             (0x01)
> -#define AXP209_DC_DC2_OUT_V_CTRL_RESET     (0x16)
> -#define AXP209_IRQ_BANK_1_CTRL_RESET       (0xd8)
> -
> -/* A simple I2C slave which returns values of ID or CNT register. */
> -typedef struct AXP209I2CState {
> -    /*< private >*/
> -    I2CSlave i2c;
> -    /*< public >*/
> -    uint8_t regs[NR_REGS];  /* peripheral registers */
> -    uint8_t ptr;            /* current register index */
> -    uint8_t count;          /* counter used for tx/rx */
> -} AXP209I2CState;
> -
> -/* Reset all counters and load ID register */
> -static void axp209_reset_enter(Object *obj, ResetType type)
> -{
> -    AXP209I2CState *s =3D AXP209(obj);
> -
> -    memset(s->regs, 0, NR_REGS);
> -    s->ptr =3D 0;
> -    s->count =3D 0;
> -    s->regs[REG_CHIP_VERSION] =3D AXP209_CHIP_VERSION_ID;
> -    s->regs[REG_DC_DC2_OUT_V_CTRL] =3D AXP209_DC_DC2_OUT_V_CTRL_RESET;
> -    s->regs[REG_IRQ_BANK_1_CTRL] =3D AXP209_IRQ_BANK_1_CTRL_RESET;
> -}
> -
> -/* Handle events from master. */
> -static int axp209_event(I2CSlave *i2c, enum i2c_event event)
> -{
> -    AXP209I2CState *s =3D AXP209(i2c);
> -
> -    s->count =3D 0;
> -
> -    return 0;
> -}
> -
> -/* Called when master requests read */
> -static uint8_t axp209_rx(I2CSlave *i2c)
> -{
> -    AXP209I2CState *s =3D AXP209(i2c);
> -    uint8_t ret =3D 0xff;
> -
> -    if (s->ptr < NR_REGS) {
> -        ret =3D s->regs[s->ptr++];
> -    }
> -
> -    trace_axp209_rx(s->ptr - 1, ret);
> -
> -    return ret;
> -}
> -
> -/*
> - * Called when master sends write.
> - * Update ptr with byte 0, then perform write with second byte.
> - */
> -static int axp209_tx(I2CSlave *i2c, uint8_t data)
> -{
> -    AXP209I2CState *s =3D AXP209(i2c);
> -
> -    if (s->count =3D=3D 0) {
> -        /* Store register address */
> -        s->ptr =3D data;
> -        s->count++;
> -        trace_axp209_select(data);
> -    } else {
> -        trace_axp209_tx(s->ptr, data);
> -        if (s->ptr =3D=3D REG_DC_DC2_OUT_V_CTRL) {
> -            s->regs[s->ptr++] =3D data;
> -        }
> -    }
> -
> -    return 0;
> -}
> -
> -static const VMStateDescription vmstate_axp209 =3D {
> -    .name =3D TYPE_AXP209_PMU,
> -    .version_id =3D 1,
> -    .fields =3D (VMStateField[]) {
> -        VMSTATE_UINT8_ARRAY(regs, AXP209I2CState, NR_REGS),
> -        VMSTATE_UINT8(count, AXP209I2CState),
> -        VMSTATE_UINT8(ptr, AXP209I2CState),
> -        VMSTATE_END_OF_LIST()
> -    }
> -};
> -
> -static void axp209_class_init(ObjectClass *oc, void *data)
> -{
> -    DeviceClass *dc =3D DEVICE_CLASS(oc);
> -    I2CSlaveClass *isc =3D I2C_SLAVE_CLASS(oc);
> -    ResettableClass *rc =3D RESETTABLE_CLASS(oc);
> -
> -    rc->phases.enter =3D axp209_reset_enter;
> -    dc->vmsd =3D &vmstate_axp209;
> -    isc->event =3D axp209_event;
> -    isc->recv =3D axp209_rx;
> -    isc->send =3D axp209_tx;
> -}
> -
> -static const TypeInfo axp209_info =3D {
> -    .name =3D TYPE_AXP209_PMU,
> -    .parent =3D TYPE_I2C_SLAVE,
> -    .instance_size =3D sizeof(AXP209I2CState),
> -    .class_init =3D axp209_class_init
> -};
> -
> -static void axp209_register_devices(void)
> -{
> -    type_register_static(&axp209_info);
> -}
> -
> -type_init(axp209_register_devices);
> diff --git a/hw/misc/axp2xx.c b/hw/misc/axp2xx.c
> new file mode 100644
> index 0000000000..52a6ffc7f3
> --- /dev/null
> +++ b/hw/misc/axp2xx.c
> @@ -0,0 +1,283 @@
> +/*
> + * AXP-2XX PMU Emulation, supported lists:
> + *   AXP209
> + *   AXP221
> + *
> + * Copyright (C) 2022 Strahinja Jankovic <strahinja.p.jankovic@gmail.com=
>
> + * Copyright (C) 2023 qianfan Zhao <qianfanguijin@163.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the
> "Software"),
> + * to deal in the Software without restriction, including without
> limitation
> + * the rights to use, copy, modify, merge, publish, distribute,
> sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
> SHALL THE
> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHE=
R
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG
> + * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> + * DEALINGS IN THE SOFTWARE.
> + *
> + * SPDX-License-Identifier: MIT
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qom/object.h"
> +#include "trace.h"
> +#include "hw/i2c/i2c.h"
> +#include "migration/vmstate.h"
> +
> +#define TYPE_AXP2XX     "axp2xx_pmu"
> +#define TYPE_AXP209_PMU "axp209_pmu"
> +#define TYPE_AXP221_PMU "axp221_pmu"
> +
> +OBJECT_DECLARE_TYPE(AXP2xxI2CState, AXP2xxClass, AXP2XX)
> +
> +#define NR_REGS                            (0xff)
> +
> +/* A simple I2C slave which returns values of ID or CNT register. */
> +typedef struct AXP2xxI2CState {
> +    /*< private >*/
> +    I2CSlave i2c;
> +    /*< public >*/
> +    uint8_t regs[NR_REGS];  /* peripheral registers */
> +    uint8_t ptr;            /* current register index */
> +    uint8_t count;          /* counter used for tx/rx */
> +} AXP2xxI2CState;
> +
> +typedef struct AXP2xxClass {
> +    /*< private >*/
> +    I2CSlaveClass parent_class;
> +    /*< public >*/
> +    void (*reset_enter)(AXP2xxI2CState *s, ResetType type);
> +} AXP2xxClass;
> +
> +#define AXP209_CHIP_VERSION_ID             (0x01)
> +#define AXP209_DC_DC2_OUT_V_CTRL_RESET     (0x16)
> +
> +/* Reset all counters and load ID register */
> +static void axp209_reset_enter(AXP2xxI2CState *s, ResetType type)
> +{
> +    memset(s->regs, 0, NR_REGS);
> +    s->ptr =3D 0;
> +    s->count =3D 0;
> +
> +    s->regs[0x03] =3D AXP209_CHIP_VERSION_ID;
> +    s->regs[0x23] =3D AXP209_DC_DC2_OUT_V_CTRL_RESET;
> +
> +    s->regs[0x30] =3D 0x60;
> +    s->regs[0x32] =3D 0x46;
> +    s->regs[0x34] =3D 0x41;
> +    s->regs[0x35] =3D 0x22;
> +    s->regs[0x36] =3D 0x5d;
> +    s->regs[0x37] =3D 0x08;
> +    s->regs[0x38] =3D 0xa5;
> +    s->regs[0x39] =3D 0x1f;
> +    s->regs[0x3a] =3D 0x68;
> +    s->regs[0x3b] =3D 0x5f;
> +    s->regs[0x3c] =3D 0xfc;
> +    s->regs[0x3d] =3D 0x16;
> +    s->regs[0x40] =3D 0xd8;
> +    s->regs[0x42] =3D 0xff;
> +    s->regs[0x43] =3D 0x3b;
> +    s->regs[0x80] =3D 0xe0;
> +    s->regs[0x82] =3D 0x83;
> +    s->regs[0x83] =3D 0x80;
> +    s->regs[0x84] =3D 0x32;
> +    s->regs[0x86] =3D 0xff;
> +    s->regs[0x90] =3D 0x07;
> +    s->regs[0x91] =3D 0xa0;
> +    s->regs[0x92] =3D 0x07;
> +    s->regs[0x93] =3D 0x07;
> +}
> +
> +#define AXP221_PWR_STATUS_ACIN_PRESENT          BIT(7)
> +#define AXP221_PWR_STATUS_ACIN_AVAIL            BIT(6)
> +#define AXP221_PWR_STATUS_VBUS_PRESENT          BIT(5)
> +#define AXP221_PWR_STATUS_VBUS_USED             BIT(4)
> +#define AXP221_PWR_STATUS_BAT_CHARGING          BIT(2)
> +#define AXP221_PWR_STATUS_ACIN_VBUS_POWERED     BIT(1)
> +
> +/* Reset all counters and load ID register */
> +static void axp221_reset_enter(AXP2xxI2CState *s, ResetType type)
> +{
> +    memset(s->regs, 0, NR_REGS);
> +    s->ptr =3D 0;
> +    s->count =3D 0;
> +
> +    /* input power status register */
> +    s->regs[0x00] =3D AXP221_PWR_STATUS_ACIN_PRESENT
> +                    | AXP221_PWR_STATUS_ACIN_AVAIL
> +                    | AXP221_PWR_STATUS_ACIN_VBUS_POWERED;
> +
> +    s->regs[0x01] =3D 0x00; /* no battery is connected */
> +
> +    /*
> +     * CHIPID register, no documented on datasheet, but it is checked in
> +     * u-boot spl. I had read it from AXP221s and got 0x06 value.
> +     * So leave 06h here.
> +     */
> +    s->regs[0x03] =3D 0x06;
> +
> +    s->regs[0x10] =3D 0xbf;
> +    s->regs[0x13] =3D 0x01;
> +    s->regs[0x30] =3D 0x60;
> +    s->regs[0x31] =3D 0x03;
> +    s->regs[0x32] =3D 0x43;
> +    s->regs[0x33] =3D 0xc6;
> +    s->regs[0x34] =3D 0x45;
> +    s->regs[0x35] =3D 0x0e;
> +    s->regs[0x36] =3D 0x5d;
> +    s->regs[0x37] =3D 0x08;
> +    s->regs[0x38] =3D 0xa5;
> +    s->regs[0x39] =3D 0x1f;
> +    s->regs[0x3c] =3D 0xfc;
> +    s->regs[0x3d] =3D 0x16;
> +    s->regs[0x80] =3D 0x80;
> +    s->regs[0x82] =3D 0xe0;
> +    s->regs[0x84] =3D 0x32;
> +    s->regs[0x8f] =3D 0x01;
> +
> +    s->regs[0x90] =3D 0x07;
> +    s->regs[0x91] =3D 0x1f;
> +    s->regs[0x92] =3D 0x07;
> +    s->regs[0x93] =3D 0x1f;
> +
> +    s->regs[0x40] =3D 0xd8;
> +    s->regs[0x41] =3D 0xff;
> +    s->regs[0x42] =3D 0x03;
> +    s->regs[0x43] =3D 0x03;
> +
> +    s->regs[0xb8] =3D 0xc0;
> +    s->regs[0xb9] =3D 0x64;
> +    s->regs[0xe6] =3D 0xa0;
>

Would it be possible to change this array to be more human readable?

Perhaps using the register names from the datasheet (if available or some
other source) as the names for defines / enums or just as comments can help=
.
That way we can know what the contents mean.


> +}
> +
> +static void axp2xx_reset_enter(Object *obj, ResetType type)
> +{
> +    AXP2xxI2CState *s =3D AXP2XX(obj);
> +    AXP2xxClass *sc =3D AXP2XX_GET_CLASS(s);
> +
> +    sc->reset_enter(s, type);
> +}
> +
> +/* Handle events from master. */
> +static int axp2xx_event(I2CSlave *i2c, enum i2c_event event)
> +{
> +    AXP2xxI2CState *s =3D AXP2XX(i2c);
> +
> +    s->count =3D 0;
> +
> +    return 0;
> +}
> +
> +/* Called when master requests read */
> +static uint8_t axp2xx_rx(I2CSlave *i2c)
> +{
> +    AXP2xxI2CState *s =3D AXP2XX(i2c);
> +    uint8_t ret =3D 0xff;
> +
> +    if (s->ptr < NR_REGS) {
> +        ret =3D s->regs[s->ptr++];
> +    }
> +
> +    trace_axp2xx_rx(s->ptr - 1, ret);
> +
> +    return ret;
> +}
> +
> +/*
> + * Called when master sends write.
> + * Update ptr with byte 0, then perform write with second byte.
> + */
> +static int axp2xx_tx(I2CSlave *i2c, uint8_t data)
> +{
> +    AXP2xxI2CState *s =3D AXP2XX(i2c);
> +
> +    if (s->count =3D=3D 0) {
> +        /* Store register address */
> +        s->ptr =3D data;
> +        s->count++;
> +        trace_axp2xx_select(data);
> +    } else {
> +        trace_axp2xx_tx(s->ptr, data);
> +        s->regs[s->ptr++] =3D data;
> +    }
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_axp2xx =3D {
> +    .name =3D TYPE_AXP209_PMU,
>

Should the .name value be TYPE_AXP2xx_PMU instead, since we're describing
the new generic axp2xx here?

+    .version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT8_ARRAY(regs, AXP2xxI2CState, NR_REGS),
> +        VMSTATE_UINT8(count, AXP2xxI2CState),
> +        VMSTATE_UINT8(ptr, AXP2xxI2CState),
>

In the 'struct AXPxxI2CState'  definition above, the order of definition
is: regs, ptr, count. For consistency, ptr and count should then be swapped
here to match.


> +        VMSTATE_END_OF_LIST()
>

Another question that comes to my mind here: is it allowed by the migration
API to have a new axp2xx device
show up while the previous axp209 disappears? (in case for the allwinner
A10 cubieboard).

My expectation with this code would be that during such a migration, any
current state of the axp209 device would be lost
and a new fresh device would show up to the guest.

I don't know enough about the migration support to tell if this is OK or
not.
If another reviewer could help clarify, that would be great.


> +    }
> +};
> +
> +static void axp2xx_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> +    I2CSlaveClass *isc =3D I2C_SLAVE_CLASS(oc);
> +    ResettableClass *rc =3D RESETTABLE_CLASS(oc);
> +
> +    rc->phases.enter =3D axp2xx_reset_enter;
> +    dc->vmsd =3D &vmstate_axp2xx;
> +    isc->event =3D axp2xx_event;
> +    isc->recv =3D axp2xx_rx;
> +    isc->send =3D axp2xx_tx;
> +}
> +
> +static const TypeInfo axp2xx_info =3D {
> +    .name =3D TYPE_AXP2XX,
> +    .parent =3D TYPE_I2C_SLAVE,
> +    .instance_size =3D sizeof(AXP2xxI2CState),
> +    .class_size =3D sizeof(AXP2xxClass),
> +    .class_init =3D axp2xx_class_init,
> +    .abstract =3D true,
> +};
> +
> +static void axp209_class_init(ObjectClass *oc, void *data)
> +{
> +    AXP2xxClass *sc =3D AXP2XX_CLASS(oc);
> +
> +    sc->reset_enter =3D axp209_reset_enter;
> +}
> +
> +static const TypeInfo axp209_info =3D {
> +    .name =3D TYPE_AXP209_PMU,
> +    .parent =3D TYPE_AXP2XX,
> +    .class_init =3D axp209_class_init
> +};
> +
> +static void axp221_class_init(ObjectClass *oc, void *data)
> +{
> +    AXP2xxClass *sc =3D AXP2XX_CLASS(oc);
> +
> +    sc->reset_enter =3D axp221_reset_enter;
> +}
> +
> +static const TypeInfo axp221_info =3D {
> +    .name =3D TYPE_AXP221_PMU,
> +    .parent =3D TYPE_AXP2XX,
> +    .class_init =3D axp221_class_init,
> +};
> +
> +static void axp2xx_register_devices(void)
> +{
> +    type_register_static(&axp2xx_info);
> +    type_register_static(&axp209_info);
> +    type_register_static(&axp221_info);
> +}
> +
> +type_init(axp2xx_register_devices);
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 96e35f1cdb..1db0343333 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -45,7 +45,7 @@ softmmu_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true:
> files('allwinner-h3-dramc.c
>  softmmu_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true:
> files('allwinner-h3-sysctrl.c'))
>  softmmu_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true:
> files('allwinner-sid.c'))
>  softmmu_ss.add(when: 'CONFIG_ALLWINNER_R40', if_true:
> files('allwinner-r40-ccu.c'))
> -softmmu_ss.add(when: 'CONFIG_AXP209_PMU', if_true: files('axp209.c'))
> +softmmu_ss.add(when: 'CONFIG_AXP2XX_PMU', if_true: files('axp2xx.c'))
>  softmmu_ss.add(when: 'CONFIG_REALVIEW', if_true: files('arm_sysctl.c'))
>  softmmu_ss.add(when: 'CONFIG_NSERIES', if_true: files('cbus.c'))
>  softmmu_ss.add(when: 'CONFIG_ECCMEMCTL', if_true: files('eccmemctl.c'))
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index c47876a902..24cdec83fe 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -23,10 +23,10 @@ allwinner_sid_write(uint64_t offset, uint64_t data,
> unsigned size) "offset 0x%"
>  avr_power_read(uint8_t value) "power_reduc read value:%u"
>  avr_power_write(uint8_t value) "power_reduc write value:%u"
>
> -# axp209.c
> -axp209_rx(uint8_t reg, uint8_t data) "Read reg 0x%" PRIx8 " : 0x%" PRIx8
> -axp209_select(uint8_t reg) "Accessing reg 0x%" PRIx8
> -axp209_tx(uint8_t reg, uint8_t data) "Write reg 0x%" PRIx8 " : 0x%" PRIx=
8
> +# axp2xx
> +axp2xx_rx(uint8_t reg, uint8_t data) "Read reg 0x%" PRIx8 " : 0x%" PRIx8
> +axp2xx_select(uint8_t reg) "Accessing reg 0x%" PRIx8
> +axp2xx_tx(uint8_t reg, uint8_t data) "Write reg 0x%" PRIx8 " : 0x%" PRIx=
8
>
>  # eccmemctl.c
>  ecc_mem_writel_mer(uint32_t val) "Write memory enable 0x%08x"
> --
> 2.25.1
>
>

--=20
Niek Linnenbank

--00000000000045b6e405fbc0782c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Qianfan,<br></div><div><br></div><div>=
Good idea indeed to turn this driver into a more generic one. If possible, =
its best to re-use code rather than adding new.<br></div><div><br></div><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 1=
0, 2023 at 12:30=E2=80=AFPM &lt;<a href=3D"mailto:qianfanguijin@163.com">qi=
anfanguijin@163.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">From: qianfan Zhao &lt;<a href=3D"mailto:qianfanguijin@1=
63.com" target=3D"_blank">qianfanguijin@163.com</a>&gt;<br>
<br>
This patch adds minimal support for AXP-221 PMU and connect it to<br>
bananapi M2U board.<br>
<br>
Signed-off-by: qianfan Zhao &lt;<a href=3D"mailto:qianfanguijin@163.com" ta=
rget=3D"_blank">qianfanguijin@163.com</a>&gt;<br>
---<br>
=C2=A0hw/arm/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +-<br>
=C2=A0hw/arm/bananapi_m2u.c |=C2=A0 =C2=A06 +<br>
=C2=A0hw/misc/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0hw/misc/axp209.c=C2=A0 =C2=A0 =C2=A0 | 238 --------------------------=
---------<br>
=C2=A0hw/misc/axp2xx.c=C2=A0 =C2=A0 =C2=A0 | 283 ++++++++++++++++++++++++++=
++++++++++++++++<br>
=C2=A0hw/misc/meson.build=C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0hw/misc/trace-events=C2=A0 |=C2=A0 =C2=A08 +-<br>
=C2=A07 files changed, 297 insertions(+), 245 deletions(-)<br>
=C2=A0delete mode 100644 hw/misc/axp209.c<br>
=C2=A0create mode 100644 hw/misc/axp2xx.c<br>
<br>
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig<br>
index b7a84f6e3f..bad4ea158c 100644<br>
--- a/hw/arm/Kconfig<br>
+++ b/hw/arm/Kconfig<br>
@@ -355,7 +355,7 @@ config ALLWINNER_A10<br>
=C2=A0 =C2=A0 =C2=A0select ALLWINNER_WDT<br>
=C2=A0 =C2=A0 =C2=A0select ALLWINNER_EMAC<br>
=C2=A0 =C2=A0 =C2=A0select ALLWINNER_I2C<br>
-=C2=A0 =C2=A0 select AXP209_PMU<br>
+=C2=A0 =C2=A0 select AXP2XX_PMU<br>
=C2=A0 =C2=A0 =C2=A0select SERIAL<br>
=C2=A0 =C2=A0 =C2=A0select UNIMP<br>
<br>
@@ -378,6 +378,7 @@ config ALLWINNER_R40<br>
=C2=A0 =C2=A0 =C2=A0bool<br>
=C2=A0 =C2=A0 =C2=A0default y if TCG &amp;&amp; ARM<br>
=C2=A0 =C2=A0 =C2=A0select ALLWINNER_A10_PIT<br>
+=C2=A0 =C2=A0 select AXP2XX_PMU<br>
=C2=A0 =C2=A0 =C2=A0select SERIAL<br>
=C2=A0 =C2=A0 =C2=A0select ARM_TIMER<br>
=C2=A0 =C2=A0 =C2=A0select ARM_GIC<br>
diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c<br>
index 1d49a006b5..9c5360a41b 100644<br>
--- a/hw/arm/bananapi_m2u.c<br>
+++ b/hw/arm/bananapi_m2u.c<br>
@@ -23,6 +23,7 @@<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
=C2=A0#include &quot;qemu/error-report.h&quot;<br>
=C2=A0#include &quot;hw/boards.h&quot;<br>
+#include &quot;hw/i2c/i2c.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
=C2=A0#include &quot;hw/arm/allwinner-r40.h&quot;<br>
<br>
@@ -61,6 +62,7 @@ static void bpim2u_init(MachineState *machine)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0bool bootroom_loaded =3D false;<br>
=C2=A0 =C2=A0 =C2=A0AwR40State *r40;<br>
+=C2=A0 =C2=A0 I2CBus *i2c;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* BIOS is not supported by this board */<br>
=C2=A0 =C2=A0 =C2=A0if (machine-&gt;firmware) {<br>
@@ -104,6 +106,10 @@ static void bpim2u_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 /* Connect AXP221 */<br>
+=C2=A0 =C2=A0 i2c =3D I2C_BUS(qdev_get_child_bus(DEVICE(&amp;r40-&gt;i2c0)=
, &quot;i2c&quot;));<br>
+=C2=A0 =C2=A0 i2c_slave_create_simple(i2c, &quot;axp221_pmu&quot;, 0x34);<=
br>
+<br>
=C2=A0 =C2=A0 =C2=A0/* SDRAM */<br>
=C2=A0 =C2=A0 =C2=A0memory_region_add_subregion(get_system_memory(),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r40-&gt;memmap[AW_R40_DEV_SDRA=
M], machine-&gt;ram);<br>
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig<br>
index 2ef5781ef8..efeb430a6c 100644<br>
--- a/hw/misc/Kconfig<br>
+++ b/hw/misc/Kconfig<br>
@@ -176,7 +176,7 @@ config ALLWINNER_A10_CCM<br>
=C2=A0config ALLWINNER_A10_DRAMC<br>
=C2=A0 =C2=A0 =C2=A0bool<br>
<br>
-config AXP209_PMU<br>
+config AXP2XX_PMU<br>
=C2=A0 =C2=A0 =C2=A0bool<br>
=C2=A0 =C2=A0 =C2=A0depends on I2C<br>
<br>
diff --git a/hw/misc/axp209.c b/hw/misc/axp209.c<br>
deleted file mode 100644<br>
index 2908ed99a6..0000000000<br>
--- a/hw/misc/axp209.c<br>
+++ /dev/null<br>
@@ -1,238 +0,0 @@<br>
-/*<br>
- * AXP-209 PMU Emulation<br>
- *<br>
- * Copyright (C) 2022 Strahinja Jankovic &lt;<a href=3D"mailto:strahinja.p=
.jankovic@gmail.com" target=3D"_blank">strahinja.p.jankovic@gmail.com</a>&g=
t;<br>
- *<br>
- * Permission is hereby granted, free of charge, to any person obtaining a=
<br>
- * copy of this software and associated documentation files (the &quot;Sof=
tware&quot;),<br>
- * to deal in the Software without restriction, including without limitati=
on<br>
- * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,<br>
- * and/or sell copies of the Software, and to permit persons to whom the<b=
r>
- * Software is furnished to do so, subject to the following conditions:<br=
>
- *<br>
- * The above copyright notice and this permission notice shall be included=
 in<br>
- * all copies or substantial portions of the Software.<br>
- *<br>
- * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL=
 THE<br>
- * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER<=
br>
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
<br>
- * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER<br>
- * DEALINGS IN THE SOFTWARE.<br>
- *<br>
- * SPDX-License-Identifier: MIT<br>
- */<br>
-<br>
-#include &quot;qemu/osdep.h&quot;<br>
-#include &quot;qemu/log.h&quot;<br>
-#include &quot;trace.h&quot;<br>
-#include &quot;hw/i2c/i2c.h&quot;<br>
-#include &quot;migration/vmstate.h&quot;<br>
-<br>
-#define TYPE_AXP209_PMU &quot;axp209_pmu&quot;<br>
-<br>
-#define AXP209(obj) \<br>
-=C2=A0 =C2=A0 OBJECT_CHECK(AXP209I2CState, (obj), TYPE_AXP209_PMU)<br>
-<br>
-/* registers */<br>
-enum {<br>
-=C2=A0 =C2=A0 REG_POWER_STATUS =3D 0x0u,<br>
-=C2=A0 =C2=A0 REG_OPERATING_MODE,<br>
-=C2=A0 =C2=A0 REG_OTG_VBUS_STATUS,<br>
-=C2=A0 =C2=A0 REG_CHIP_VERSION,<br>
-=C2=A0 =C2=A0 REG_DATA_CACHE_0,<br>
-=C2=A0 =C2=A0 REG_DATA_CACHE_1,<br>
-=C2=A0 =C2=A0 REG_DATA_CACHE_2,<br>
-=C2=A0 =C2=A0 REG_DATA_CACHE_3,<br>
-=C2=A0 =C2=A0 REG_DATA_CACHE_4,<br>
-=C2=A0 =C2=A0 REG_DATA_CACHE_5,<br>
-=C2=A0 =C2=A0 REG_DATA_CACHE_6,<br>
-=C2=A0 =C2=A0 REG_DATA_CACHE_7,<br>
-=C2=A0 =C2=A0 REG_DATA_CACHE_8,<br>
-=C2=A0 =C2=A0 REG_DATA_CACHE_9,<br>
-=C2=A0 =C2=A0 REG_DATA_CACHE_A,<br>
-=C2=A0 =C2=A0 REG_DATA_CACHE_B,<br>
-=C2=A0 =C2=A0 REG_POWER_OUTPUT_CTRL =3D 0x12u,<br>
-=C2=A0 =C2=A0 REG_DC_DC2_OUT_V_CTRL =3D 0x23u,<br>
-=C2=A0 =C2=A0 REG_DC_DC2_DVS_CTRL =3D 0x25u,<br>
-=C2=A0 =C2=A0 REG_DC_DC3_OUT_V_CTRL =3D 0x27u,<br>
-=C2=A0 =C2=A0 REG_LDO2_4_OUT_V_CTRL,<br>
-=C2=A0 =C2=A0 REG_LDO3_OUT_V_CTRL,<br>
-=C2=A0 =C2=A0 REG_VBUS_CH_MGMT =3D 0x30u,<br>
-=C2=A0 =C2=A0 REG_SHUTDOWN_V_CTRL,<br>
-=C2=A0 =C2=A0 REG_SHUTDOWN_CTRL,<br>
-=C2=A0 =C2=A0 REG_CHARGE_CTRL_1,<br>
-=C2=A0 =C2=A0 REG_CHARGE_CTRL_2,<br>
-=C2=A0 =C2=A0 REG_SPARE_CHARGE_CTRL,<br>
-=C2=A0 =C2=A0 REG_PEK_KEY_CTRL,<br>
-=C2=A0 =C2=A0 REG_DC_DC_FREQ_SET,<br>
-=C2=A0 =C2=A0 REG_CHR_TEMP_TH_SET,<br>
-=C2=A0 =C2=A0 REG_CHR_HIGH_TEMP_TH_CTRL,<br>
-=C2=A0 =C2=A0 REG_IPSOUT_WARN_L1,<br>
-=C2=A0 =C2=A0 REG_IPSOUT_WARN_L2,<br>
-=C2=A0 =C2=A0 REG_DISCHR_TEMP_TH_SET,<br>
-=C2=A0 =C2=A0 REG_DISCHR_HIGH_TEMP_TH_CTRL,<br>
-=C2=A0 =C2=A0 REG_IRQ_BANK_1_CTRL =3D 0x40u,<br>
-=C2=A0 =C2=A0 REG_IRQ_BANK_2_CTRL,<br>
-=C2=A0 =C2=A0 REG_IRQ_BANK_3_CTRL,<br>
-=C2=A0 =C2=A0 REG_IRQ_BANK_4_CTRL,<br>
-=C2=A0 =C2=A0 REG_IRQ_BANK_5_CTRL,<br>
-=C2=A0 =C2=A0 REG_IRQ_BANK_1_STAT =3D 0x48u,<br>
-=C2=A0 =C2=A0 REG_IRQ_BANK_2_STAT,<br>
-=C2=A0 =C2=A0 REG_IRQ_BANK_3_STAT,<br>
-=C2=A0 =C2=A0 REG_IRQ_BANK_4_STAT,<br>
-=C2=A0 =C2=A0 REG_IRQ_BANK_5_STAT,<br>
-=C2=A0 =C2=A0 REG_ADC_ACIN_V_H =3D 0x56u,<br>
-=C2=A0 =C2=A0 REG_ADC_ACIN_V_L,<br>
-=C2=A0 =C2=A0 REG_ADC_ACIN_CURR_H,<br>
-=C2=A0 =C2=A0 REG_ADC_ACIN_CURR_L,<br>
-=C2=A0 =C2=A0 REG_ADC_VBUS_V_H,<br>
-=C2=A0 =C2=A0 REG_ADC_VBUS_V_L,<br>
-=C2=A0 =C2=A0 REG_ADC_VBUS_CURR_H,<br>
-=C2=A0 =C2=A0 REG_ADC_VBUS_CURR_L,<br>
-=C2=A0 =C2=A0 REG_ADC_INT_TEMP_H,<br>
-=C2=A0 =C2=A0 REG_ADC_INT_TEMP_L,<br>
-=C2=A0 =C2=A0 REG_ADC_TEMP_SENS_V_H =3D 0x62u,<br>
-=C2=A0 =C2=A0 REG_ADC_TEMP_SENS_V_L,<br>
-=C2=A0 =C2=A0 REG_ADC_BAT_V_H =3D 0x78u,<br>
-=C2=A0 =C2=A0 REG_ADC_BAT_V_L,<br>
-=C2=A0 =C2=A0 REG_ADC_BAT_DISCHR_CURR_H,<br>
-=C2=A0 =C2=A0 REG_ADC_BAT_DISCHR_CURR_L,<br>
-=C2=A0 =C2=A0 REG_ADC_BAT_CHR_CURR_H,<br>
-=C2=A0 =C2=A0 REG_ADC_BAT_CHR_CURR_L,<br>
-=C2=A0 =C2=A0 REG_ADC_IPSOUT_V_H,<br>
-=C2=A0 =C2=A0 REG_ADC_IPSOUT_V_L,<br>
-=C2=A0 =C2=A0 REG_DC_DC_MOD_SEL =3D 0x80u,<br>
-=C2=A0 =C2=A0 REG_ADC_EN_1,<br>
-=C2=A0 =C2=A0 REG_ADC_EN_2,<br>
-=C2=A0 =C2=A0 REG_ADC_SR_CTRL,<br>
-=C2=A0 =C2=A0 REG_ADC_IN_RANGE,<br>
-=C2=A0 =C2=A0 REG_GPIO1_ADC_IRQ_RISING_TH,<br>
-=C2=A0 =C2=A0 REG_GPIO1_ADC_IRQ_FALLING_TH,<br>
-=C2=A0 =C2=A0 REG_TIMER_CTRL =3D 0x8au,<br>
-=C2=A0 =C2=A0 REG_VBUS_CTRL_MON_SRP,<br>
-=C2=A0 =C2=A0 REG_OVER_TEMP_SHUTDOWN =3D 0x8fu,<br>
-=C2=A0 =C2=A0 REG_GPIO0_FEAT_SET,<br>
-=C2=A0 =C2=A0 REG_GPIO_OUT_HIGH_SET,<br>
-=C2=A0 =C2=A0 REG_GPIO1_FEAT_SET,<br>
-=C2=A0 =C2=A0 REG_GPIO2_FEAT_SET,<br>
-=C2=A0 =C2=A0 REG_GPIO_SIG_STATE_SET_MON,<br>
-=C2=A0 =C2=A0 REG_GPIO3_SET,<br>
-=C2=A0 =C2=A0 REG_COULOMB_CNTR_CTRL =3D 0xb8u,<br>
-=C2=A0 =C2=A0 REG_POWER_MEAS_RES,<br>
-=C2=A0 =C2=A0 NR_REGS<br>
-};<br>
-<br>
-#define AXP209_CHIP_VERSION_ID=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(0x01)<br>
-#define AXP209_DC_DC2_OUT_V_CTRL_RESET=C2=A0 =C2=A0 =C2=A0(0x16)<br>
-#define AXP209_IRQ_BANK_1_CTRL_RESET=C2=A0 =C2=A0 =C2=A0 =C2=A0(0xd8)<br>
-<br>
-/* A simple I2C slave which returns values of ID or CNT register. */<br>
-typedef struct AXP209I2CState {<br>
-=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
-=C2=A0 =C2=A0 I2CSlave i2c;<br>
-=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
-=C2=A0 =C2=A0 uint8_t regs[NR_REGS];=C2=A0 /* peripheral registers */<br>
-=C2=A0 =C2=A0 uint8_t ptr;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* cur=
rent register index */<br>
-=C2=A0 =C2=A0 uint8_t count;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* counter =
used for tx/rx */<br>
-} AXP209I2CState;<br>
-<br>
-/* Reset all counters and load ID register */<br>
-static void axp209_reset_enter(Object *obj, ResetType type)<br>
-{<br>
-=C2=A0 =C2=A0 AXP209I2CState *s =3D AXP209(obj);<br>
-<br>
-=C2=A0 =C2=A0 memset(s-&gt;regs, 0, NR_REGS);<br>
-=C2=A0 =C2=A0 s-&gt;ptr =3D 0;<br>
-=C2=A0 =C2=A0 s-&gt;count =3D 0;<br>
-=C2=A0 =C2=A0 s-&gt;regs[REG_CHIP_VERSION] =3D AXP209_CHIP_VERSION_ID;<br>
-=C2=A0 =C2=A0 s-&gt;regs[REG_DC_DC2_OUT_V_CTRL] =3D AXP209_DC_DC2_OUT_V_CT=
RL_RESET;<br>
-=C2=A0 =C2=A0 s-&gt;regs[REG_IRQ_BANK_1_CTRL] =3D AXP209_IRQ_BANK_1_CTRL_R=
ESET;<br>
-}<br>
-<br>
-/* Handle events from master. */<br>
-static int axp209_event(I2CSlave *i2c, enum i2c_event event)<br>
-{<br>
-=C2=A0 =C2=A0 AXP209I2CState *s =3D AXP209(i2c);<br>
-<br>
-=C2=A0 =C2=A0 s-&gt;count =3D 0;<br>
-<br>
-=C2=A0 =C2=A0 return 0;<br>
-}<br>
-<br>
-/* Called when master requests read */<br>
-static uint8_t axp209_rx(I2CSlave *i2c)<br>
-{<br>
-=C2=A0 =C2=A0 AXP209I2CState *s =3D AXP209(i2c);<br>
-=C2=A0 =C2=A0 uint8_t ret =3D 0xff;<br>
-<br>
-=C2=A0 =C2=A0 if (s-&gt;ptr &lt; NR_REGS) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D s-&gt;regs[s-&gt;ptr++];<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 trace_axp209_rx(s-&gt;ptr - 1, ret);<br>
-<br>
-=C2=A0 =C2=A0 return ret;<br>
-}<br>
-<br>
-/*<br>
- * Called when master sends write.<br>
- * Update ptr with byte 0, then perform write with second byte.<br>
- */<br>
-static int axp209_tx(I2CSlave *i2c, uint8_t data)<br>
-{<br>
-=C2=A0 =C2=A0 AXP209I2CState *s =3D AXP209(i2c);<br>
-<br>
-=C2=A0 =C2=A0 if (s-&gt;count =3D=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Store register address */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;ptr =3D data;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;count++;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_axp209_select(data);<br>
-=C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_axp209_tx(s-&gt;ptr, data);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;ptr =3D=3D REG_DC_DC2_OUT_V_CTRL) {<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[s-&gt;ptr++] =3D data=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 return 0;<br>
-}<br>
-<br>
-static const VMStateDescription vmstate_axp209 =3D {<br>
-=C2=A0 =C2=A0 .name =3D TYPE_AXP209_PMU,<br>
-=C2=A0 =C2=A0 .version_id =3D 1,<br>
-=C2=A0 =C2=A0 .fields =3D (VMStateField[]) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT8_ARRAY(regs, AXP209I2CState, NR_R=
EGS),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT8(count, AXP209I2CState),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT8(ptr, AXP209I2CState),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
-=C2=A0 =C2=A0 }<br>
-};<br>
-<br>
-static void axp209_class_init(ObjectClass *oc, void *data)<br>
-{<br>
-=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(oc);<br>
-=C2=A0 =C2=A0 I2CSlaveClass *isc =3D I2C_SLAVE_CLASS(oc);<br>
-=C2=A0 =C2=A0 ResettableClass *rc =3D RESETTABLE_CLASS(oc);<br>
-<br>
-=C2=A0 =C2=A0 rc-&gt;phases.enter =3D axp209_reset_enter;<br>
-=C2=A0 =C2=A0 dc-&gt;vmsd =3D &amp;vmstate_axp209;<br>
-=C2=A0 =C2=A0 isc-&gt;event =3D axp209_event;<br>
-=C2=A0 =C2=A0 isc-&gt;recv =3D axp209_rx;<br>
-=C2=A0 =C2=A0 isc-&gt;send =3D axp209_tx;<br>
-}<br>
-<br>
-static const TypeInfo axp209_info =3D {<br>
-=C2=A0 =C2=A0 .name =3D TYPE_AXP209_PMU,<br>
-=C2=A0 =C2=A0 .parent =3D TYPE_I2C_SLAVE,<br>
-=C2=A0 =C2=A0 .instance_size =3D sizeof(AXP209I2CState),<br>
-=C2=A0 =C2=A0 .class_init =3D axp209_class_init<br>
-};<br>
-<br>
-static void axp209_register_devices(void)<br>
-{<br>
-=C2=A0 =C2=A0 type_register_static(&amp;axp209_info);<br>
-}<br>
-<br>
-type_init(axp209_register_devices);<br>
diff --git a/hw/misc/axp2xx.c b/hw/misc/axp2xx.c<br>
new file mode 100644<br>
index 0000000000..52a6ffc7f3<br>
--- /dev/null<br>
+++ b/hw/misc/axp2xx.c<br>
@@ -0,0 +1,283 @@<br>
+/*<br>
+ * AXP-2XX PMU Emulation, supported lists:<br>
+ *=C2=A0 =C2=A0AXP209<br>
+ *=C2=A0 =C2=A0AXP221<br>
+ *<br>
+ * Copyright (C) 2022 Strahinja Jankovic &lt;<a href=3D"mailto:strahinja.p=
.jankovic@gmail.com" target=3D"_blank">strahinja.p.jankovic@gmail.com</a>&g=
t;<br>
+ * Copyright (C) 2023 qianfan Zhao &lt;<a href=3D"mailto:qianfanguijin@163=
.com" target=3D"_blank">qianfanguijin@163.com</a>&gt;<br>
+ *<br>
+ * Permission is hereby granted, free of charge, to any person obtaining a=
<br>
+ * copy of this software and associated documentation files (the &quot;Sof=
tware&quot;),<br>
+ * to deal in the Software without restriction, including without limitati=
on<br>
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,<br>
+ * and/or sell copies of the Software, and to permit persons to whom the<b=
r>
+ * Software is furnished to do so, subject to the following conditions:<br=
>
+ *<br>
+ * The above copyright notice and this permission notice shall be included=
 in<br>
+ * all copies or substantial portions of the Software.<br>
+ *<br>
+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL=
 THE<br>
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER<=
br>
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
<br>
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER<br>
+ * DEALINGS IN THE SOFTWARE.<br>
+ *<br>
+ * SPDX-License-Identifier: MIT<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qemu/log.h&quot;<br>
+#include &quot;qom/object.h&quot;<br>
+#include &quot;trace.h&quot;<br>
+#include &quot;hw/i2c/i2c.h&quot;<br>
+#include &quot;migration/vmstate.h&quot;<br>
+<br>
+#define TYPE_AXP2XX=C2=A0 =C2=A0 =C2=A0&quot;axp2xx_pmu&quot;<br>
+#define TYPE_AXP209_PMU &quot;axp209_pmu&quot;<br>
+#define TYPE_AXP221_PMU &quot;axp221_pmu&quot;<br>
+<br>
+OBJECT_DECLARE_TYPE(AXP2xxI2CState, AXP2xxClass, AXP2XX)<br>
+<br>
+#define NR_REGS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (0xff)<br>
+<br>
+/* A simple I2C slave which returns values of ID or CNT register. */<br>
+typedef struct AXP2xxI2CState {<br>
+=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
+=C2=A0 =C2=A0 I2CSlave i2c;<br>
+=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
+=C2=A0 =C2=A0 uint8_t regs[NR_REGS];=C2=A0 /* peripheral registers */<br>
+=C2=A0 =C2=A0 uint8_t ptr;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* cur=
rent register index */<br>
+=C2=A0 =C2=A0 uint8_t count;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* counter =
used for tx/rx */<br>
+} AXP2xxI2CState;<br>
+<br>
+typedef struct AXP2xxClass {<br>
+=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
+=C2=A0 =C2=A0 I2CSlaveClass parent_class;<br>
+=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
+=C2=A0 =C2=A0 void (*reset_enter)(AXP2xxI2CState *s, ResetType type);<br>
+} AXP2xxClass;<br>
+<br>
+#define AXP209_CHIP_VERSION_ID=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(0x01)<br>
+#define AXP209_DC_DC2_OUT_V_CTRL_RESET=C2=A0 =C2=A0 =C2=A0(0x16)<br>
+<br>
+/* Reset all counters and load ID register */<br>
+static void axp209_reset_enter(AXP2xxI2CState *s, ResetType type)<br>
+{<br>
+=C2=A0 =C2=A0 memset(s-&gt;regs, 0, NR_REGS);<br>
+=C2=A0 =C2=A0 s-&gt;ptr =3D 0;<br>
+=C2=A0 =C2=A0 s-&gt;count =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x03] =3D AXP209_CHIP_VERSION_ID;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x23] =3D AXP209_DC_DC2_OUT_V_CTRL_RESET;<br>
+<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x30] =3D 0x60;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x32] =3D 0x46;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x34] =3D 0x41;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x35] =3D 0x22;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x36] =3D 0x5d;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x37] =3D 0x08;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x38] =3D 0xa5;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x39] =3D 0x1f;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x3a] =3D 0x68;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x3b] =3D 0x5f;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x3c] =3D 0xfc;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x3d] =3D 0x16;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x40] =3D 0xd8;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x42] =3D 0xff;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x43] =3D 0x3b;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x80] =3D 0xe0;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x82] =3D 0x83;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x83] =3D 0x80;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x84] =3D 0x32;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x86] =3D 0xff;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x90] =3D 0x07;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x91] =3D 0xa0;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x92] =3D 0x07;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x93] =3D 0x07;<br>
+}<br>
+<br>
+#define AXP221_PWR_STATUS_ACIN_PRESENT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 B=
IT(7)<br>
+#define AXP221_PWR_STATUS_ACIN_AVAIL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 BIT(6)<br>
+#define AXP221_PWR_STATUS_VBUS_PRESENT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 B=
IT(5)<br>
+#define AXP221_PWR_STATUS_VBUS_USED=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0BIT(4)<br>
+#define AXP221_PWR_STATUS_BAT_CHARGING=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 B=
IT(2)<br>
+#define AXP221_PWR_STATUS_ACIN_VBUS_POWERED=C2=A0 =C2=A0 =C2=A0BIT(1)<br>
+<br>
+/* Reset all counters and load ID register */<br>
+static void axp221_reset_enter(AXP2xxI2CState *s, ResetType type)<br>
+{<br>
+=C2=A0 =C2=A0 memset(s-&gt;regs, 0, NR_REGS);<br>
+=C2=A0 =C2=A0 s-&gt;ptr =3D 0;<br>
+=C2=A0 =C2=A0 s-&gt;count =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 /* input power status register */<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x00] =3D AXP221_PWR_STATUS_ACIN_PRESENT<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | AX=
P221_PWR_STATUS_ACIN_AVAIL<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | AX=
P221_PWR_STATUS_ACIN_VBUS_POWERED;<br>
+<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x01] =3D 0x00; /* no battery is connected */<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* CHIPID register, no documented on datasheet, but it =
is checked in<br>
+=C2=A0 =C2=A0 =C2=A0* u-boot spl. I had read it from AXP221s and got 0x06 =
value.<br>
+=C2=A0 =C2=A0 =C2=A0* So leave 06h here.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x03] =3D 0x06;<br>
+<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x10] =3D 0xbf;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x13] =3D 0x01;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x30] =3D 0x60;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x31] =3D 0x03;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x32] =3D 0x43;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x33] =3D 0xc6;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x34] =3D 0x45;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x35] =3D 0x0e;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x36] =3D 0x5d;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x37] =3D 0x08;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x38] =3D 0xa5;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x39] =3D 0x1f;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x3c] =3D 0xfc;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x3d] =3D 0x16;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x80] =3D 0x80;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x82] =3D 0xe0;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x84] =3D 0x32;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x8f] =3D 0x01;<br>
+<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x90] =3D 0x07;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x91] =3D 0x1f;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x92] =3D 0x07;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x93] =3D 0x1f;<br>
+<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x40] =3D 0xd8;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x41] =3D 0xff;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x42] =3D 0x03;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0x43] =3D 0x03;<br>
+<br>
+=C2=A0 =C2=A0 s-&gt;regs[0xb8] =3D 0xc0;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0xb9] =3D 0x64;<br>
+=C2=A0 =C2=A0 s-&gt;regs[0xe6] =3D 0xa0;<br></blockquote><div><br></div><d=
iv>Would it be possible to change this array to be more human readable?</di=
v><div><br></div><div>Perhaps using the register names from the datasheet (=
if available or some other source) as the names for defines / enums or just=
 as comments can help.</div><div>That way we can know what the contents mea=
n.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
+}<br>
+<br>
+static void axp2xx_reset_enter(Object *obj, ResetType type)<br>
+{<br>
+=C2=A0 =C2=A0 AXP2xxI2CState *s =3D AXP2XX(obj);<br>
+=C2=A0 =C2=A0 AXP2xxClass *sc =3D AXP2XX_GET_CLASS(s);<br>
+<br>
+=C2=A0 =C2=A0 sc-&gt;reset_enter(s, type);<br>
+}<br>
+<br>
+/* Handle events from master. */<br>
+static int axp2xx_event(I2CSlave *i2c, enum i2c_event event)<br>
+{<br>
+=C2=A0 =C2=A0 AXP2xxI2CState *s =3D AXP2XX(i2c);<br>
+<br>
+=C2=A0 =C2=A0 s-&gt;count =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+/* Called when master requests read */<br>
+static uint8_t axp2xx_rx(I2CSlave *i2c)<br>
+{<br>
+=C2=A0 =C2=A0 AXP2xxI2CState *s =3D AXP2XX(i2c);<br>
+=C2=A0 =C2=A0 uint8_t ret =3D 0xff;<br>
+<br>
+=C2=A0 =C2=A0 if (s-&gt;ptr &lt; NR_REGS) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D s-&gt;regs[s-&gt;ptr++];<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 trace_axp2xx_rx(s-&gt;ptr - 1, ret);<br>
+<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+/*<br>
+ * Called when master sends write.<br>
+ * Update ptr with byte 0, then perform write with second byte.<br>
+ */<br>
+static int axp2xx_tx(I2CSlave *i2c, uint8_t data)<br>
+{<br>
+=C2=A0 =C2=A0 AXP2xxI2CState *s =3D AXP2XX(i2c);<br>
+<br>
+=C2=A0 =C2=A0 if (s-&gt;count =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Store register address */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;ptr =3D data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;count++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_axp2xx_select(data);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_axp2xx_tx(s-&gt;ptr, data);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[s-&gt;ptr++] =3D data;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+static const VMStateDescription vmstate_axp2xx =3D {<br>
+=C2=A0 =C2=A0 .name =3D TYPE_AXP209_PMU,<br></blockquote><br></div><div cl=
ass=3D"gmail_quote">Should the .name value be TYPE_AXP2xx_PMU instead, sinc=
e we&#39;re describing the new generic axp2xx here?</div><div class=3D"gmai=
l_quote"><br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 .version_id =3D 1,<br>
+=C2=A0 =C2=A0 .fields =3D (VMStateField[]) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT8_ARRAY(regs, AXP2xxI2CState, NR_R=
EGS),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT8(count, AXP2xxI2CState),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT8(ptr, AXP2xxI2CState),<br></block=
quote><div><br></div><div>In the &#39;struct AXPxxI2CState&#39;=C2=A0 defin=
ition above, the order of definition is: regs, ptr, count. For consistency,=
 ptr and count should then be swapped here to match.<br></div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br></blockquote><div><br=
></div><div><div>Another question that comes to my mind here: is it allowed=
 by the migration API to have a new axp2xx device</div><div>show up while t=
he previous axp209 disappears? (in case for the allwinner A10 cubieboard).<=
/div><div><br></div><div>My expectation with this code would be that during=
 such a migration, any current state of the axp209 device would be lost</di=
v><div>and a new fresh device would show up to the guest.</div><div><br></d=
iv><div>I don&#39;t know enough about the migration support to tell if this=
 is OK or not.</div><div>If another reviewer could help clarify, that would=
 be great.<br></div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
+=C2=A0 =C2=A0 }<br>
+};<br>
+<br>
+static void axp2xx_class_init(ObjectClass *oc, void *data)<br>
+{<br>
+=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(oc);<br>
+=C2=A0 =C2=A0 I2CSlaveClass *isc =3D I2C_SLAVE_CLASS(oc);<br>
+=C2=A0 =C2=A0 ResettableClass *rc =3D RESETTABLE_CLASS(oc);<br>
+<br>
+=C2=A0 =C2=A0 rc-&gt;phases.enter =3D axp2xx_reset_enter;<br>
+=C2=A0 =C2=A0 dc-&gt;vmsd =3D &amp;vmstate_axp2xx;<br>
+=C2=A0 =C2=A0 isc-&gt;event =3D axp2xx_event;<br>
+=C2=A0 =C2=A0 isc-&gt;recv =3D axp2xx_rx;<br>
+=C2=A0 =C2=A0 isc-&gt;send =3D axp2xx_tx;<br>
+}<br>
+<br>
+static const TypeInfo axp2xx_info =3D {<br>
+=C2=A0 =C2=A0 .name =3D TYPE_AXP2XX,<br>
+=C2=A0 =C2=A0 .parent =3D TYPE_I2C_SLAVE,<br>
+=C2=A0 =C2=A0 .instance_size =3D sizeof(AXP2xxI2CState),<br>
+=C2=A0 =C2=A0 .class_size =3D sizeof(AXP2xxClass),<br>
+=C2=A0 =C2=A0 .class_init =3D axp2xx_class_init,<br>
+=C2=A0 =C2=A0 .abstract =3D true,<br>
+};<br>
+<br>
+static void axp209_class_init(ObjectClass *oc, void *data)<br>
+{<br>
+=C2=A0 =C2=A0 AXP2xxClass *sc =3D AXP2XX_CLASS(oc);<br>
+<br>
+=C2=A0 =C2=A0 sc-&gt;reset_enter =3D axp209_reset_enter;<br>
+}<br>
+<br>
+static const TypeInfo axp209_info =3D {<br>
+=C2=A0 =C2=A0 .name =3D TYPE_AXP209_PMU,<br>
+=C2=A0 =C2=A0 .parent =3D TYPE_AXP2XX,<br>
+=C2=A0 =C2=A0 .class_init =3D axp209_class_init<br>
+};<br>
+<br>
+static void axp221_class_init(ObjectClass *oc, void *data)<br>
+{<br>
+=C2=A0 =C2=A0 AXP2xxClass *sc =3D AXP2XX_CLASS(oc);<br>
+<br>
+=C2=A0 =C2=A0 sc-&gt;reset_enter =3D axp221_reset_enter;<br>
+}<br>
+<br>
+static const TypeInfo axp221_info =3D {<br>
+=C2=A0 =C2=A0 .name =3D TYPE_AXP221_PMU,<br>
+=C2=A0 =C2=A0 .parent =3D TYPE_AXP2XX,<br>
+=C2=A0 =C2=A0 .class_init =3D axp221_class_init,<br>
+};<br>
+<br>
+static void axp2xx_register_devices(void)<br>
+{<br>
+=C2=A0 =C2=A0 type_register_static(&amp;axp2xx_info);<br>
+=C2=A0 =C2=A0 type_register_static(&amp;axp209_info);<br>
+=C2=A0 =C2=A0 type_register_static(&amp;axp221_info);<br>
+}<br>
+<br>
+type_init(axp2xx_register_devices);<br>
diff --git a/hw/misc/meson.build b/hw/misc/meson.build<br>
index 96e35f1cdb..1db0343333 100644<br>
--- a/hw/misc/meson.build<br>
+++ b/hw/misc/meson.build<br>
@@ -45,7 +45,7 @@ softmmu_ss.add(when: &#39;CONFIG_ALLWINNER_H3&#39;, if_tr=
ue: files(&#39;allwinner-h3-dramc.c<br>
=C2=A0softmmu_ss.add(when: &#39;CONFIG_ALLWINNER_H3&#39;, if_true: files(&#=
39;allwinner-h3-sysctrl.c&#39;))<br>
=C2=A0softmmu_ss.add(when: &#39;CONFIG_ALLWINNER_H3&#39;, if_true: files(&#=
39;allwinner-sid.c&#39;))<br>
=C2=A0softmmu_ss.add(when: &#39;CONFIG_ALLWINNER_R40&#39;, if_true: files(&=
#39;allwinner-r40-ccu.c&#39;))<br>
-softmmu_ss.add(when: &#39;CONFIG_AXP209_PMU&#39;, if_true: files(&#39;axp2=
09.c&#39;))<br>
+softmmu_ss.add(when: &#39;CONFIG_AXP2XX_PMU&#39;, if_true: files(&#39;axp2=
xx.c&#39;))<br>
=C2=A0softmmu_ss.add(when: &#39;CONFIG_REALVIEW&#39;, if_true: files(&#39;a=
rm_sysctl.c&#39;))<br>
=C2=A0softmmu_ss.add(when: &#39;CONFIG_NSERIES&#39;, if_true: files(&#39;cb=
us.c&#39;))<br>
=C2=A0softmmu_ss.add(when: &#39;CONFIG_ECCMEMCTL&#39;, if_true: files(&#39;=
eccmemctl.c&#39;))<br>
diff --git a/hw/misc/trace-events b/hw/misc/trace-events<br>
index c47876a902..24cdec83fe 100644<br>
--- a/hw/misc/trace-events<br>
+++ b/hw/misc/trace-events<br>
@@ -23,10 +23,10 @@ allwinner_sid_write(uint64_t offset, uint64_t data, uns=
igned size) &quot;offset 0x%&quot;<br>
=C2=A0avr_power_read(uint8_t value) &quot;power_reduc read value:%u&quot;<b=
r>
=C2=A0avr_power_write(uint8_t value) &quot;power_reduc write value:%u&quot;=
<br>
<br>
-# axp209.c<br>
-axp209_rx(uint8_t reg, uint8_t data) &quot;Read reg 0x%&quot; PRIx8 &quot;=
 : 0x%&quot; PRIx8<br>
-axp209_select(uint8_t reg) &quot;Accessing reg 0x%&quot; PRIx8<br>
-axp209_tx(uint8_t reg, uint8_t data) &quot;Write reg 0x%&quot; PRIx8 &quot=
; : 0x%&quot; PRIx8<br>
+# axp2xx<br>
+axp2xx_rx(uint8_t reg, uint8_t data) &quot;Read reg 0x%&quot; PRIx8 &quot;=
 : 0x%&quot; PRIx8<br>
+axp2xx_select(uint8_t reg) &quot;Accessing reg 0x%&quot; PRIx8<br>
+axp2xx_tx(uint8_t reg, uint8_t data) &quot;Write reg 0x%&quot; PRIx8 &quot=
; : 0x%&quot; PRIx8<br>
<br>
=C2=A0# eccmemctl.c<br>
=C2=A0ecc_mem_writel_mer(uint32_t val) &quot;Write memory enable 0x%08x&quo=
t;<br>
-- <br>
2.25.1<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"l=
tr"><div>Niek Linnenbank<br><br></div></div></div></div>

--00000000000045b6e405fbc0782c--

