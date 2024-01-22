Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A2B835A18
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 05:37:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRm3a-0007dU-6f; Sun, 21 Jan 2024 23:37:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rRm3W-0007cm-C1; Sun, 21 Jan 2024 23:37:06 -0500
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rRm3U-0008AR-1i; Sun, 21 Jan 2024 23:37:06 -0500
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-7cbe98278f8so761727241.1; 
 Sun, 21 Jan 2024 20:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705898221; x=1706503021; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4FvrZ/918e+6croQmnlple/9deCPijgMaXK8VFdDJt4=;
 b=ncW05yvdWbyfJOO1IEyWPRdQr+q2rG0g33WpN7+/USqu8EGelxtKGTvyMZbyjFk5o+
 0ZPIsLUKXF4UghjY3xI181Itdn59a7PMvF2rzlsTRkcMxtoQsmXic65UMXScXFfhWqCy
 RR4dpDwDSjSNGWiwykahcXFwRVDT5nIMclYvmeck+LgzQ195S7jv2YRNW0OiWYHl2JHz
 lOPglA1WlSi6qp7ZyXeM1yBRBRonCjqbvyFMWsW9I/xQqhlgWl0Vd+/AGL+X3xAWS3sX
 6mjWiUW3sZxTSXPhYcRsNlsANbsI2Usw4O6+IUXbbIaO2C+oH9SLMiGiXsJmYPkm95NE
 Truw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705898221; x=1706503021;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4FvrZ/918e+6croQmnlple/9deCPijgMaXK8VFdDJt4=;
 b=SoyEKy9+GW+JKpfYZ3d0BGb1jc6UEYAvKFSoN4SEblJNF2dqHjR/TOyEhir+8JwcGS
 cJBVhq6eEZdsTZT1LRUP+rTMw1B6dvcQDF2eg1RSLQOppXQWjl+qOK8lQcBGO/NRFcPE
 SiH2DYq6cLuJLCkAYMhCbdTdPvQXIjvTd5VQv5D200jkV026usoDHHHYwySDlm23s5R4
 XneBK9rbIe+P/o/MWW9Qxc7WnFHHC4jfplF3Q9R+YNnjN4t7L8p4xxrmzJ6zqEtUvTMg
 /qEleyqiy0TaV/aRN0fxmne1o7uXRnP+uSlE8Cm0q7f8LxCmALdY67VMEq49rUgK+2AQ
 yLTg==
X-Gm-Message-State: AOJu0YzMlD7BrYxznIJTnBve5laQKV9MTar+T4Uf/PpwhUf7MA6wrJrS
 2rptowYfTqrCaHMohqTCBC3+Hl4CWJ3m3L1xNhAAwZg+2i3W7C/Qo2g8NW1689CFOwtwAHy6rnB
 ql/H7OCnocIDEKcLPYp8NLqKUb+k=
X-Google-Smtp-Source: AGHT+IHev/Kmhqm93ooYLWlVzsNHTBIWMokDaycJBlaN/mqrcxfZiB7K9f8HYjaLv+FBEeVlnFBcWC6dQaj8fqXU6A8=
X-Received: by 2002:a05:6122:209f:b0:4b7:8d7c:3488 with SMTP id
 i31-20020a056122209f00b004b78d7c3488mr1039280vkd.6.1705898221392; Sun, 21 Jan
 2024 20:37:01 -0800 (PST)
MIME-Version: 1.0
References: <20240113102913.18278-1-arnaud.minier@telecom-paris.fr>
 <20240113102913.18278-3-arnaud.minier@telecom-paris.fr>
In-Reply-To: <20240113102913.18278-3-arnaud.minier@telecom-paris.fr>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 22 Jan 2024 14:36:35 +1000
Message-ID: <CAKmqyKPycNRQqTsFngdfTfdmakPWA+FnU_bcnVk6v=qjZFhkHQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] Add an internal clock multiplexer object
To: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>, 
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 qemu-arm@nongnu.org, Samuel Tardieu <samuel.tardieu@telecom-paris.fr>, 
 =?UTF-8?Q?Philipe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::933;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x933.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sat, Jan 13, 2024 at 8:31=E2=80=AFPM Arnaud Minier
<arnaud.minier@telecom-paris.fr> wrote:
>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/misc/stm32l4x5_rcc.c                   | 154 ++++++++++++++++++++++
>  hw/misc/trace-events                      |   5 +
>  include/hw/misc/stm32l4x5_rcc.h           | 119 +++++++++++++++++
>  include/hw/misc/stm32l4x5_rcc_internals.h |  29 ++++
>  4 files changed, 307 insertions(+)
>
> diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
> index 5a6f475740..bcc69510b0 100644
> --- a/hw/misc/stm32l4x5_rcc.c
> +++ b/hw/misc/stm32l4x5_rcc.c
> @@ -35,6 +35,128 @@
>  #define LSE_FRQ 32768ULL
>  #define LSI_FRQ 32000ULL
>
> +static void clock_mux_update(RccClockMuxState *mux)
> +{
> +    uint64_t src_freq, old_freq, freq;
> +
> +    src_freq =3D clock_get_hz(mux->srcs[mux->src]);
> +    old_freq =3D clock_get_hz(mux->out);
> +
> +    if (!mux->enabled || !mux->divider) {
> +        freq =3D 0;
> +    } else {
> +        freq =3D muldiv64(src_freq, mux->multiplier, mux->divider);
> +    }
> +
> +    /* No change, early return to avoid log spam and useless propagation=
 */
> +    if (old_freq =3D=3D freq) {
> +        return;
> +    }
> +
> +    clock_update_hz(mux->out, freq);
> +    trace_stm32l4x5_rcc_mux_update(mux->id, mux->src, src_freq, freq);
> +}
> +
> +static void clock_mux_src_update(void *opaque, ClockEvent event)
> +{
> +    RccClockMuxState **backref =3D opaque;
> +    RccClockMuxState *s =3D *backref;
> +    /*
> +     * The backref value is equal to:
> +     * s->backref + (sizeof(RccClockMuxState *) * update_src).
> +     * By subtracting we can get back the index of the updated clock.
> +     */
> +    const uint32_t update_src =3D backref - s->backref;
> +    /* Only update if the clock that was updated is the current source*/
> +    if (update_src =3D=3D s->src) {
> +        clock_mux_update(s);
> +    }
> +}
> +
> +static void clock_mux_init(Object *obj)
> +{
> +    RccClockMuxState *s =3D RCC_CLOCK_MUX(obj);
> +    size_t i;
> +
> +    for (i =3D 0; i < RCC_NUM_CLOCK_MUX_SRC; i++) {
> +        char *name =3D g_strdup_printf("srcs[%zu]", i);
> +        s->backref[i] =3D s;
> +        s->srcs[i] =3D qdev_init_clock_in(DEVICE(s), name,
> +                                        clock_mux_src_update,
> +                                        &s->backref[i],
> +                                        ClockUpdate);
> +        g_free(name);
> +    }
> +
> +    s->out =3D qdev_init_clock_out(DEVICE(s), "out");
> +}
> +
> +static void clock_mux_reset_hold(Object *obj)
> +{ }
> +
> +static const VMStateDescription clock_mux_vmstate =3D {
> +    .name =3D TYPE_RCC_CLOCK_MUX,
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_ARRAY_CLOCK(srcs, RccClockMuxState,
> +                            RCC_NUM_CLOCK_MUX_SRC),
> +        VMSTATE_BOOL(enabled, RccClockMuxState),
> +        VMSTATE_UINT32(src, RccClockMuxState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void clock_mux_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> +
> +    rc->phases.hold =3D clock_mux_reset_hold;
> +    dc->vmsd =3D &clock_mux_vmstate;
> +}
> +
> +static void clock_mux_set_enable(RccClockMuxState *mux, bool enabled)
> +{
> +    if (mux->enabled =3D=3D enabled) {
> +        return;
> +    }
> +
> +    if (enabled) {
> +        trace_stm32l4x5_rcc_mux_enable(mux->id);
> +    } else {
> +        trace_stm32l4x5_rcc_mux_disable(mux->id);
> +    }
> +
> +    mux->enabled =3D enabled;
> +    clock_mux_update(mux);
> +}
> +
> +static void clock_mux_set_factor(RccClockMuxState *mux,
> +                                 uint32_t multiplier, uint32_t divider)
> +{
> +    if (mux->multiplier =3D=3D multiplier && mux->divider =3D=3D divider=
) {
> +        return;
> +    }
> +    trace_stm32l4x5_rcc_mux_set_factor(mux->id,
> +        mux->multiplier, multiplier, mux->divider, divider);
> +
> +    mux->multiplier =3D multiplier;
> +    mux->divider =3D divider;
> +    clock_mux_update(mux);
> +}
> +
> +static void clock_mux_set_source(RccClockMuxState *mux, RccClockMuxSourc=
e src)
> +{
> +    if (mux->src =3D=3D src) {
> +        return;
> +    }
> +
> +    trace_stm32l4x5_rcc_mux_set_src(mux->id, mux->src, src);
> +    mux->src =3D src;
> +    clock_mux_update(mux);
> +}
> +
>  static void rcc_update_irq(Stm32l4x5RccState *s)
>  {
>      if (s->cifr & CIFR_IRQ_MASK) {
> @@ -326,6 +448,7 @@ static const ClockPortInitArray stm32l4x5_rcc_clocks =
=3D {
>  static void stm32l4x5_rcc_init(Object *obj)
>  {
>      Stm32l4x5RccState *s =3D STM32L4X5_RCC(obj);
> +    size_t i;
>
>      sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
>
> @@ -335,6 +458,14 @@ static void stm32l4x5_rcc_init(Object *obj)
>
>      qdev_init_clocks(DEVICE(s), stm32l4x5_rcc_clocks);
>
> +    for (i =3D 0; i < RCC_NUM_CLOCK_MUX; i++) {
> +
> +        object_initialize_child(obj, "clock[*]",
> +                                &s->clock_muxes[i],
> +                                TYPE_RCC_CLOCK_MUX);
> +
> +    }
> +
>      s->gnd =3D clock_new(obj, "gnd");
>  }
>
> @@ -380,6 +511,7 @@ static const VMStateDescription vmstate_stm32l4x5_rcc=
 =3D {
>  static void stm32l4x5_rcc_realize(DeviceState *dev, Error **errp)
>  {
>      Stm32l4x5RccState *s =3D STM32L4X5_RCC(dev);
> +    size_t i;
>
>      /* The HSE frequency must be in range 4-48 MHz */
>      if (s->hse_frequency <  4000000ULL ||
> @@ -388,10 +520,26 @@ static void stm32l4x5_rcc_realize(DeviceState *dev,=
 Error **errp)
>              return;
>          }
>
> +    for (i =3D 0; i < RCC_NUM_CLOCK_MUX; i++) {
> +        RccClockMuxState *clock_mux =3D &s->clock_muxes[i];
> +
> +        if (!qdev_realize(DEVICE(clock_mux), NULL, errp)) {
> +            return;
> +        }
> +    }
> +
>      clock_update_hz(s->msi_rc, MSI_DEFAULT_FRQ);
>      clock_update_hz(s->sai1_extclk, s->sai1_extclk_frequency);
>      clock_update_hz(s->sai2_extclk, s->sai2_extclk_frequency);
>      clock_update(s->gnd, 0);
> +
> +    /*
> +     * Dummy values to make compilation pass.
> +     * Removed in later commits.
> +     */
> +    clock_mux_set_source(&s->clock_muxes[0], RCC_CLOCK_MUX_SRC_GND);
> +    clock_mux_set_enable(&s->clock_muxes[0], true);
> +    clock_mux_set_factor(&s->clock_muxes[0], 1, 1);
>  }
>
>  static Property stm32l4x5_rcc_properties[] =3D {
> @@ -423,6 +571,12 @@ static const TypeInfo stm32l4x5_rcc_types[] =3D {
>          .instance_size  =3D sizeof(Stm32l4x5RccState),
>          .instance_init  =3D stm32l4x5_rcc_init,
>          .class_init     =3D stm32l4x5_rcc_class_init,
> +    }, {
> +        .name =3D TYPE_RCC_CLOCK_MUX,
> +        .parent =3D TYPE_DEVICE,
> +        .instance_size =3D sizeof(RccClockMuxState),
> +        .instance_init =3D clock_mux_init,
> +        .class_init =3D clock_mux_class_init,
>      }
>  };
>
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 62a7599353..d5e471811c 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -177,6 +177,11 @@ stm32l4x5_exti_write(uint64_t addr, uint64_t data) "=
reg write: addr: 0x%" PRIx64
>  # stm32l4x5_rcc.c
>  stm32l4x5_rcc_read(uint64_t addr, uint32_t data) "RCC: Read <0x%" PRIx64=
 "> -> 0x%" PRIx32 ""
>  stm32l4x5_rcc_write(uint64_t addr, uint32_t data) "RCC: Write <0x%" PRIx=
64 "> <- 0x%" PRIx32 ""
> +stm32l4x5_rcc_mux_enable(uint32_t mux_id) "RCC: Mux %d enabled"
> +stm32l4x5_rcc_mux_disable(uint32_t mux_id) "RCC: Mux %d disabled"
> +stm32l4x5_rcc_mux_set_factor(uint32_t mux_id, uint32_t old_multiplier, u=
int32_t new_multiplier, uint32_t old_divider, uint32_t new_divider) "RCC: M=
ux %d factor changed: multiplier (%u -> %u), divider (%u -> %u)"
> +stm32l4x5_rcc_mux_set_src(uint32_t mux_id, uint32_t old_src, uint32_t ne=
w_src) "RCC: Mux %d source changed: from %u to %u"
> +stm32l4x5_rcc_mux_update(uint32_t mux_id, uint32_t src, uint64_t src_fre=
q, uint64_t new_freq) "RCC: Mux %d src %d update: src_freq %" PRIu64 " new_=
freq %" PRIu64 ""
>
>  # tz-mpc.c
>  tz_mpc_reg_read(uint32_t offset, uint64_t data, unsigned size) "TZ MPC r=
egs read: offset 0x%x data 0x%" PRIx64 " size %u"
> diff --git a/include/hw/misc/stm32l4x5_rcc.h b/include/hw/misc/stm32l4x5_=
rcc.h
> index 5157e96635..6719be9fbe 100644
> --- a/include/hw/misc/stm32l4x5_rcc.h
> +++ b/include/hw/misc/stm32l4x5_rcc.h
> @@ -26,6 +26,122 @@ OBJECT_DECLARE_SIMPLE_TYPE(Stm32l4x5RccState, STM32L4=
X5_RCC)
>
>  /* In the Stm32l4x5 clock tree, mux have at most 7 sources */
>  #define RCC_NUM_CLOCK_MUX_SRC 7
> +/* NB: Prescaler are assimilated to mux with one source and one output *=
/
> +typedef enum RccClockMux {
> +    /* Internal muxes that arent't exposed publicly to other peripherals=
 */
> +    RCC_CLOCK_MUX_SYSCLK,
> +    RCC_CLOCK_MUX_PLL_INPUT,
> +    RCC_CLOCK_MUX_HCLK,
> +    RCC_CLOCK_MUX_PCLK1,
> +    RCC_CLOCK_MUX_PCLK2,
> +    RCC_CLOCK_MUX_HSE_OVER_32,
> +    RCC_CLOCK_MUX_LCD_AND_RTC_COMMON,
> +
> +    /* Muxes with a publicly available output */
> +    RCC_CLOCK_MUX_CORTEX_REFCLK,
> +    RCC_CLOCK_MUX_USART1,
> +    RCC_CLOCK_MUX_USART2,
> +    RCC_CLOCK_MUX_USART3,
> +    RCC_CLOCK_MUX_UART4,
> +    RCC_CLOCK_MUX_UART5,
> +    RCC_CLOCK_MUX_LPUART1,
> +    RCC_CLOCK_MUX_I2C1,
> +    RCC_CLOCK_MUX_I2C2,
> +    RCC_CLOCK_MUX_I2C3,
> +    RCC_CLOCK_MUX_LPTIM1,
> +    RCC_CLOCK_MUX_LPTIM2,
> +    RCC_CLOCK_MUX_SWPMI1,
> +    RCC_CLOCK_MUX_MCO,
> +    RCC_CLOCK_MUX_LSCO,
> +    RCC_CLOCK_MUX_DFSDM1,
> +    RCC_CLOCK_MUX_ADC,
> +    RCC_CLOCK_MUX_CLK48,
> +    RCC_CLOCK_MUX_SAI1,
> +    RCC_CLOCK_MUX_SAI2,
> +
> +    /*
> +     * Mux that have only one input and one output assigned to as periph=
eral.
> +     * They could be direct lines but it is simpler
> +     * to use the same logic for all outputs.
> +     */
> +    /* - AHB1 */
> +    RCC_CLOCK_MUX_TSC,
> +    RCC_CLOCK_MUX_CRC,
> +    RCC_CLOCK_MUX_FLASH,
> +    RCC_CLOCK_MUX_DMA2,
> +    RCC_CLOCK_MUX_DMA1,
> +
> +    /* - AHB2 */
> +    RCC_CLOCK_MUX_RNG,
> +    RCC_CLOCK_MUX_AES,
> +    RCC_CLOCK_MUX_OTGFS,
> +    RCC_CLOCK_MUX_GPIOA,
> +    RCC_CLOCK_MUX_GPIOB,
> +    RCC_CLOCK_MUX_GPIOC,
> +    RCC_CLOCK_MUX_GPIOD,
> +    RCC_CLOCK_MUX_GPIOE,
> +    RCC_CLOCK_MUX_GPIOF,
> +    RCC_CLOCK_MUX_GPIOG,
> +    RCC_CLOCK_MUX_GPIOH,
> +
> +    /* - AHB3 */
> +    RCC_CLOCK_MUX_QSPI,
> +    RCC_CLOCK_MUX_FMC,
> +
> +    /* - APB1 */
> +    RCC_CLOCK_MUX_OPAMP,
> +    RCC_CLOCK_MUX_DAC1,
> +    RCC_CLOCK_MUX_PWR,
> +    RCC_CLOCK_MUX_CAN1,
> +    RCC_CLOCK_MUX_SPI3,
> +    RCC_CLOCK_MUX_SPI2,
> +    RCC_CLOCK_MUX_WWDG,
> +    RCC_CLOCK_MUX_LCD,
> +    RCC_CLOCK_MUX_TIM7,
> +    RCC_CLOCK_MUX_TIM6,
> +    RCC_CLOCK_MUX_TIM5,
> +    RCC_CLOCK_MUX_TIM4,
> +    RCC_CLOCK_MUX_TIM3,
> +    RCC_CLOCK_MUX_TIM2,
> +
> +    /* - APB2 */
> +    RCC_CLOCK_MUX_TIM17,
> +    RCC_CLOCK_MUX_TIM16,
> +    RCC_CLOCK_MUX_TIM15,
> +    RCC_CLOCK_MUX_TIM8,
> +    RCC_CLOCK_MUX_SPI1,
> +    RCC_CLOCK_MUX_TIM1,
> +    RCC_CLOCK_MUX_SDMMC1,
> +    RCC_CLOCK_MUX_FW,
> +    RCC_CLOCK_MUX_SYSCFG,
> +
> +    /* - BDCR */
> +    RCC_CLOCK_MUX_RTC,
> +
> +    /* - OTHER */
> +    RCC_CLOCK_MUX_CORTEX_FCLK,
> +
> +    RCC_NUM_CLOCK_MUX
> +} RccClockMux;
> +
> +typedef struct RccClockMuxState {
> +    DeviceState parent_obj;
> +
> +    RccClockMux id;
> +    Clock *srcs[RCC_NUM_CLOCK_MUX_SRC];
> +    Clock *out;
> +    bool enabled;
> +    uint32_t src;
> +    uint32_t multiplier;
> +    uint32_t divider;
> +
> +    /*
> +     * Used by clock srcs update callback to retrieve both the clock and=
 the
> +     * source number.
> +     */
> +    struct RccClockMuxState *backref[RCC_NUM_CLOCK_MUX_SRC];
> +} RccClockMuxState;
> +
>  struct Stm32l4x5RccState {
>      SysBusDevice parent_obj;
>
> @@ -71,6 +187,9 @@ struct Stm32l4x5RccState {
>      Clock *sai1_extclk;
>      Clock *sai2_extclk;
>
> +    /* Muxes ~=3D outputs */
> +    RccClockMuxState clock_muxes[RCC_NUM_CLOCK_MUX];
> +
>      qemu_irq irq;
>      uint64_t hse_frequency;
>      uint64_t sai1_extclk_frequency;
> diff --git a/include/hw/misc/stm32l4x5_rcc_internals.h b/include/hw/misc/=
stm32l4x5_rcc_internals.h
> index 331ea30db5..4aa836848b 100644
> --- a/include/hw/misc/stm32l4x5_rcc_internals.h
> +++ b/include/hw/misc/stm32l4x5_rcc_internals.h
> @@ -21,6 +21,8 @@
>  #include "hw/registerfields.h"
>  #include "hw/misc/stm32l4x5_rcc.h"
>
> +#define TYPE_RCC_CLOCK_MUX "stm32l4x5-rcc-clock-mux"
> +OBJECT_DECLARE_SIMPLE_TYPE(RccClockMuxState, RCC_CLOCK_MUX)
>
>  /* Register map */
>  REG32(CR, 0x00)
> @@ -283,4 +285,31 @@ REG32(CSR, 0x94)
>                              R_CSR_FWRSTF_MASK   | \
>                              R_CSR_LSIRDY_MASK)
>
> +typedef enum RccClockMuxSource {
> +    RCC_CLOCK_MUX_SRC_GND =3D 0,
> +    RCC_CLOCK_MUX_SRC_HSI,
> +    RCC_CLOCK_MUX_SRC_HSE,
> +    RCC_CLOCK_MUX_SRC_MSI,
> +    RCC_CLOCK_MUX_SRC_LSI,
> +    RCC_CLOCK_MUX_SRC_LSE,
> +    RCC_CLOCK_MUX_SRC_SAI1_EXTCLK,
> +    RCC_CLOCK_MUX_SRC_SAI2_EXTCLK,
> +    RCC_CLOCK_MUX_SRC_PLL,
> +    RCC_CLOCK_MUX_SRC_PLLSAI1,
> +    RCC_CLOCK_MUX_SRC_PLLSAI2,
> +    RCC_CLOCK_MUX_SRC_PLLSAI3,
> +    RCC_CLOCK_MUX_SRC_PLL48M1,
> +    RCC_CLOCK_MUX_SRC_PLL48M2,
> +    RCC_CLOCK_MUX_SRC_PLLADC1,
> +    RCC_CLOCK_MUX_SRC_PLLADC2,
> +    RCC_CLOCK_MUX_SRC_SYSCLK,
> +    RCC_CLOCK_MUX_SRC_HCLK,
> +    RCC_CLOCK_MUX_SRC_PCLK1,
> +    RCC_CLOCK_MUX_SRC_PCLK2,
> +    RCC_CLOCK_MUX_SRC_HSE_OVER_32,
> +    RCC_CLOCK_MUX_SRC_LCD_AND_RTC_COMMON,
> +
> +    RCC_CLOCK_MUX_SRC_NUMBER,
> +} RccClockMuxSource;
> +
>  #endif /* HW_STM32L4X5_RCC_INTERNALS_H */
> --
> 2.34.1
>
>

