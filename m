Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F439AA4798
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Apr 2025 11:47:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA40z-0000RI-EK; Wed, 30 Apr 2025 05:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=tzqG=XQ=kaod.org=clg@ozlabs.org>)
 id 1uA40m-0000Qu-3p; Wed, 30 Apr 2025 05:45:52 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=tzqG=XQ=kaod.org=clg@ozlabs.org>)
 id 1uA40h-0004wo-MI; Wed, 30 Apr 2025 05:45:51 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ZnXP12ZRBz4xG0;
 Wed, 30 Apr 2025 19:45:41 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZnXNx08tBz4wbc;
 Wed, 30 Apr 2025 19:45:36 +1000 (AEST)
Message-ID: <11b5a654-00e9-447d-8827-83702ec30ab8@kaod.org>
Date: Wed, 30 Apr 2025 11:45:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] hw/arm/aspeed_ast27x0-ssp: Introduce AST27x0 A1
 SSP SoC
To: Steven Lee <steven_lee@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, longzl2@lenovo.com, yunlin.tang@aspeedtech.com
References: <20250429091855.1948374-1-steven_lee@aspeedtech.com>
 <20250429091855.1948374-6-steven_lee@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250429091855.1948374-6-steven_lee@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=tzqG=XQ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/29/25 11:18, Steven Lee wrote:
> The AST2700 SSP (Secondary Service Processor) is a Cortex-M4 coprocessor.
> This patch adds support for A1 SSP with the following updates:
> 
> - Introduce Aspeed27x0SSPSoCState structure in aspeed_soc.h
> - Define memory map and IRQ map for AST27x0 A1 SSP SoC
> - Implement initialization and realization functions
> - Add support for UART, INTC, and SCU devices
> - Map unimplemented devices for IPC and SCUIO
> 
> The IRQ mapping is similar to AST2700 CA35 SoC, featuring a two-level
> interrupt controller.
> 
> Difference from AST2700:
> 
>      - AST2700
>        - Support GICINT128 to GICINT136 in INTC
>        - The INTCIO GIC_192_201 has 10 output pins, mapped as follows:
>            Bit 0 -> GIC 192
>            Bit 1 -> GIC 193
>            Bit 2 -> GIC 194
>            Bit 3 -> GIC 195
>            Bit 4 -> GIC 196
> 
>      - AST2700-ssp
>        - Support SSPINT128 to SSPINT136 in INTC
>        - The INTCIO SSPINT_160_169 has 10 output pins, mapped as follows:
>            Bit 0 -> SSPINT 160
>            Bit 1 -> SSPINT 161
>            Bit 2 -> SSPINT 162
>            Bit 3 -> SSPINT 163
>            Bit 4 -> SSPINT 164
> 
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> Change-Id: I924bf1a657f1e83f9e16d6673713f4a06ecdb496
> ---
>   include/hw/arm/aspeed_soc.h |  14 ++
>   hw/arm/aspeed_ast27x0-ssp.c | 309 ++++++++++++++++++++++++++++++++++++
>   hw/arm/meson.build          |   1 +
>   3 files changed, 324 insertions(+)
>   create mode 100644 hw/arm/aspeed_ast27x0-ssp.c
> 
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index dd5fb731e2..7c65324801 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -145,6 +145,18 @@ struct Aspeed10x0SoCState {
>       ARMv7MState armv7m;
>   };
>   
> +struct Aspeed27x0SSPSoCState {
> +    AspeedSoCState parent;
> +    AspeedINTCState intc[2];
> +    UnimplementedDeviceState ipc[2];
> +    UnimplementedDeviceState scuio;
> +
> +    ARMv7MState armv7m;
> +};
> +
> +#define TYPE_ASPEED27X0SSP_SOC "aspeed27x0ssp-soc"
> +OBJECT_DECLARE_SIMPLE_TYPE(Aspeed27x0SSPSoCState, ASPEED27X0SSP_SOC)
> +
>   #define TYPE_ASPEED10X0_SOC "aspeed10x0-soc"
>   OBJECT_DECLARE_SIMPLE_TYPE(Aspeed10x0SoCState, ASPEED10X0_SOC)
>   
> @@ -255,6 +267,8 @@ enum {
>       ASPEED_DEV_SLIIO,
>       ASPEED_GIC_DIST,
>       ASPEED_GIC_REDIST,
> +    ASPEED_DEV_IPC0,
> +    ASPEED_DEV_IPC1,
>   };
>   
>   qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int dev);
> diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
> new file mode 100644
> index 0000000000..32a74747c8
> --- /dev/null
> +++ b/hw/arm/aspeed_ast27x0-ssp.c
> @@ -0,0 +1,309 @@
> +/*
> + * ASPEED Ast27x0 SSP SoC
> + *
> + * Copyright (C) 2025 ASPEED Technology Inc.
> + *
> + * This code is licensed under the GPL version 2 or later.  See
> + * the COPYING file in the top-level directory.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "exec/address-spaces.h"
> +#include "hw/qdev-clock.h"
> +#include "hw/misc/unimp.h"
> +#include "hw/arm/aspeed_soc.h"
> +
> +#define AST2700_SSP_RAM_SIZE (32 * MiB)
> +
> +static const hwaddr aspeed_soc_ast27x0ssp_memmap[] = {
> +    [ASPEED_DEV_SRAM]      =  0x00000000,
> +    [ASPEED_DEV_INTC]      =  0x72100000,
> +    [ASPEED_DEV_SCU]       =  0x72C02000,
> +    [ASPEED_DEV_SCUIO]     =  0x74C02000,
> +    [ASPEED_DEV_UART0]     =  0x74C33000,
> +    [ASPEED_DEV_UART1]     =  0x74C33100,
> +    [ASPEED_DEV_UART2]     =  0x74C33200,
> +    [ASPEED_DEV_UART3]     =  0x74C33300,
> +    [ASPEED_DEV_UART4]     =  0x72C1A000,
> +    [ASPEED_DEV_INTCIO]    =  0x74C18000,
> +    [ASPEED_DEV_IPC0]      =  0x72C1C000,
> +    [ASPEED_DEV_IPC1]      =  0x74C39000,
> +    [ASPEED_DEV_UART5]     =  0x74C33400,
> +    [ASPEED_DEV_UART6]     =  0x74C33500,
> +    [ASPEED_DEV_UART7]     =  0x74C33600,
> +    [ASPEED_DEV_UART8]     =  0x74C33700,
> +    [ASPEED_DEV_UART9]     =  0x74C33800,
> +    [ASPEED_DEV_UART10]    =  0x74C33900,
> +    [ASPEED_DEV_UART11]    =  0x74C33A00,
> +    [ASPEED_DEV_UART12]    =  0x74C33B00,
> +    [ASPEED_DEV_TIMER1]    =  0x72C10000,
> +};
> +
> +static const int aspeed_soc_ast27x0ssp_irqmap[] = {
> +    [ASPEED_DEV_SCU]       = 12,
> +    [ASPEED_DEV_UART0]     = 164,
> +    [ASPEED_DEV_UART1]     = 164,
> +    [ASPEED_DEV_UART2]     = 164,
> +    [ASPEED_DEV_UART3]     = 164,
> +    [ASPEED_DEV_UART4]     = 8,
> +    [ASPEED_DEV_UART5]     = 164,
> +    [ASPEED_DEV_UART6]     = 164,
> +    [ASPEED_DEV_UART7]     = 164,
> +    [ASPEED_DEV_UART8]     = 164,
> +    [ASPEED_DEV_UART9]     = 164,
> +    [ASPEED_DEV_UART10]    = 164,
> +    [ASPEED_DEV_UART11]    = 164,
> +    [ASPEED_DEV_UART12]    = 164,
> +    [ASPEED_DEV_TIMER1]    = 16,
> +};
> +
> +/* SSPINT 164 */
> +static const int ast2700_ssp132_ssp164_intcmap[] = {
> +    [ASPEED_DEV_UART0]     = 7,
> +    [ASPEED_DEV_UART1]     = 8,
> +    [ASPEED_DEV_UART2]     = 9,
> +    [ASPEED_DEV_UART3]     = 10,
> +    [ASPEED_DEV_UART5]     = 11,
> +    [ASPEED_DEV_UART6]     = 12,
> +    [ASPEED_DEV_UART7]     = 13,
> +    [ASPEED_DEV_UART8]     = 14,
> +    [ASPEED_DEV_UART9]     = 15,
> +    [ASPEED_DEV_UART10]    = 16,
> +    [ASPEED_DEV_UART11]    = 17,
> +    [ASPEED_DEV_UART12]    = 18,
> +};
> +
> +struct nvic_intc_irq_info {
> +    int irq;
> +    int intc_idx;
> +    int orgate_idx;
> +    const int *ptr;
> +};
> +
> +static struct nvic_intc_irq_info ast2700_ssp_intcmap[] = {
> +    {160, 1, 0, NULL},
> +    {161, 1, 1, NULL},
> +    {162, 1, 2, NULL},
> +    {163, 1, 3, NULL},
> +    {164, 1, 4, ast2700_ssp132_ssp164_intcmap},
> +    {165, 1, 5, NULL},
> +    {166, 1, 6, NULL},
> +    {167, 1, 7, NULL},
> +    {168, 1, 8, NULL},
> +    {169, 1, 9, NULL},
> +    {128, 0, 1, NULL},
> +    {129, 0, 2, NULL},
> +    {130, 0, 3, NULL},
> +    {131, 0, 4, NULL},
> +    {132, 0, 5, ast2700_ssp132_ssp164_intcmap},
> +    {133, 0, 6, NULL},
> +    {134, 0, 7, NULL},
> +    {135, 0, 8, NULL},
> +    {136, 0, 9, NULL},
> +};
> +
> +static qemu_irq aspeed_soc_ast27x0ssp_get_irq(AspeedSoCState *s, int dev)
> +{
> +    Aspeed27x0SSPSoCState *a = ASPEED27X0SSP_SOC(s);
> +    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
> +
> +    int or_idx;
> +    int idx;
> +    int i;
> +
> +    for (i = 0; i < ARRAY_SIZE(ast2700_ssp_intcmap); i++) {
> +        if (sc->irqmap[dev] == ast2700_ssp_intcmap[i].irq) {
> +            assert(ast2700_ssp_intcmap[i].ptr);
> +            or_idx = ast2700_ssp_intcmap[i].orgate_idx;
> +            idx = ast2700_ssp_intcmap[i].intc_idx;
> +            return qdev_get_gpio_in(DEVICE(&a->intc[idx].orgates[or_idx]),
> +                                    ast2700_ssp_intcmap[i].ptr[dev]);
> +        }
> +    }
> +
> +    return qdev_get_gpio_in(DEVICE(&a->armv7m), sc->irqmap[dev]);
> +}
> +
> +static void aspeed_soc_ast27x0ssp_init(Object *obj)
> +{
> +    Aspeed27x0SSPSoCState *a = ASPEED27X0SSP_SOC(obj);
> +    AspeedSoCState *s = ASPEED_SOC(obj);
> +    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
> +    char socname[8];
> +    char typename[64];
> +    int i;
> +
> +    if (sscanf(object_get_typename(obj), "%7s", socname) != 1) {
> +        g_assert_not_reached();
> +    }
> +
> +    object_initialize_child(obj, "armv7m", &a->armv7m, TYPE_ARMV7M);
> +
> +    s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
> +
> +    snprintf(typename, sizeof(typename), "aspeed.scu-%s", socname);
> +    object_initialize_child(obj, "scu", &s->scu, typename);
> +    qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev", sc->silicon_rev);
> +
> +    for (i = 0; i < sc->uarts_num; i++) {
> +        object_initialize_child(obj, "uart[*]", &s->uart[i], TYPE_SERIAL_MM);
> +    }
> +
> +    object_initialize_child(obj, "intc0", &a->intc[0],
> +                            TYPE_ASPEED_2700SSP_INTC);
> +    object_initialize_child(obj, "intc1", &a->intc[1],
> +                            TYPE_ASPEED_2700SSP_INTCIO);
> +
> +    object_initialize_child(obj, "timerctrl", &s->timerctrl,
> +                            TYPE_UNIMPLEMENTED_DEVICE);
> +    object_initialize_child(obj, "ipc0", &a->ipc[0],
> +                            TYPE_UNIMPLEMENTED_DEVICE);
> +    object_initialize_child(obj, "ipc1", &a->ipc[1],
> +                            TYPE_UNIMPLEMENTED_DEVICE);
> +    object_initialize_child(obj, "scuio", &a->scuio,
> +                            TYPE_UNIMPLEMENTED_DEVICE);
> +}
> +
> +static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
> +{
> +    Aspeed27x0SSPSoCState *a = ASPEED27X0SSP_SOC(dev_soc);
> +    AspeedSoCState *s = ASPEED_SOC(dev_soc);
> +    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
> +    DeviceState *armv7m;
> +    Error *err = NULL;
> +    g_autofree char *sram_name = NULL;
> +    int i;
> +
> +    if (!clock_has_source(s->sysclk)) {
> +        error_setg(errp, "sysclk clock must be wired up by the board code");
> +        return;
> +    }
> +
> +    /* AST27X0 SSP Core */
> +    armv7m = DEVICE(&a->armv7m);
> +    qdev_prop_set_uint32(armv7m, "num-irq", 256);
> +    qdev_prop_set_string(armv7m, "cpu-type", aspeed_soc_cpu_type(sc));
> +    qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
> +    object_property_set_link(OBJECT(&a->armv7m), "memory",
> +                             OBJECT(s->memory), &error_abort);
> +    sysbus_realize(SYS_BUS_DEVICE(&a->armv7m), &error_abort);
> +
> +    sram_name = g_strdup_printf("aspeed.dram.%d",
> +                                CPU(a->armv7m.cpu)->cpu_index);
> +
> +    if (!memory_region_init_ram(&s->sram, OBJECT(s), sram_name, sc->sram_size,
> +                                &err)) {
> +        return;
> +    }
> +    memory_region_add_subregion(s->memory,
> +                                sc->memmap[ASPEED_DEV_SRAM],
> +                                &s->sram);
> +
> +    /* SCU */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
> +        return;
> +    }
> +    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->scu), 0, sc->memmap[ASPEED_DEV_SCU]);
> +
> +    /* INTC */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {
> +        return;
> +    }
> +
> +    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc[0]), 0,
> +                    sc->memmap[ASPEED_DEV_INTC]);
> +
> +    /* INTCIO */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[1]), errp)) {
> +        return;
> +    }
> +
> +    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc[1]), 0,
> +                    sc->memmap[ASPEED_DEV_INTCIO]);
> +
> +    /* irq source orgates -> INTC0 */
> +    for (i = 0; i < ASPEED_INTC_GET_CLASS(&a->intc[0])->num_inpins; i++) {
> +        qdev_connect_gpio_out(DEVICE(&a->intc[0].orgates[i]), 0,
> +                              qdev_get_gpio_in(DEVICE(&a->intc[0]), i));
> +    }
> +    for (i = 0; i < ASPEED_INTC_GET_CLASS(&a->intc[0])->num_outpins; i++) {
> +        assert(i < ARRAY_SIZE(ast2700_ssp_intcmap));
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&a->intc[0]), i,
> +                           qdev_get_gpio_in(DEVICE(&a->armv7m),
> +                                            ast2700_ssp_intcmap[i].irq));
> +    }
> +    /* irq source orgates -> INTCIO */
> +    for (i = 0; i < ASPEED_INTC_GET_CLASS(&a->intc[1])->num_inpins; i++) {
> +        qdev_connect_gpio_out(DEVICE(&a->intc[1].orgates[i]), 0,
> +                              qdev_get_gpio_in(DEVICE(&a->intc[1]), i));
> +    }
> +    /* INTCIO -> INTC */
> +    for (i = 0; i < ASPEED_INTC_GET_CLASS(&a->intc[1])->num_outpins; i++) {
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&a->intc[1]), i,
> +                        qdev_get_gpio_in(DEVICE(&a->intc[0].orgates[0]), i));
> +    }
> +    /* UART */
> +    if (!aspeed_soc_uart_realize(s, errp)) {
> +        return;
> +    }
> +
> +    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->timerctrl),
> +                                  "aspeed.timerctrl",
> +                                  sc->memmap[ASPEED_DEV_TIMER1], 0x200);
> +    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&a->ipc[0]),
> +                                  "aspeed.ipc0",
> +                                  sc->memmap[ASPEED_DEV_IPC0], 0x1000);
> +    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&a->ipc[1]),
> +                                  "aspeed.ipc1",
> +                                  sc->memmap[ASPEED_DEV_IPC1], 0x1000);
> +    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&a->scuio),
> +                                  "aspeed.scuio",
> +                                  sc->memmap[ASPEED_DEV_SCUIO], 0x1000);
> +}
> +
> +static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass, void *data)
> +{
> +    static const char * const valid_cpu_types[] = {
> +        ARM_CPU_TYPE_NAME("cortex-m4"), /* TODO: cortex-m4f */

So no FPU ?  I wonder what "cortex-m4" CPU model in QEMU implements.
Something to check.


> +        NULL
> +    };
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    AspeedSoCClass *sc = ASPEED_SOC_CLASS(dc);
> +
> +    /* Reason: The Aspeed SoC can only be instantiated from a board */
> +    dc->user_creatable = false;
> +    dc->realize = aspeed_soc_ast27x0ssp_realize;
> +
> +    sc->valid_cpu_types = valid_cpu_types;
> +    sc->silicon_rev = AST2700_A1_SILICON_REV;
> +    sc->sram_size = AST2700_SSP_RAM_SIZE;
> +    sc->spis_num = 0;
> +    sc->ehcis_num = 0;
> +    sc->wdts_num = 0;
> +    sc->macs_num = 0;
> +    sc->uarts_num = 13;
> +    sc->uarts_base = ASPEED_DEV_UART0;
> +    sc->irqmap = aspeed_soc_ast27x0ssp_irqmap;
> +    sc->memmap = aspeed_soc_ast27x0ssp_memmap;
> +    sc->num_cpus = 1;
> +    sc->get_irq = aspeed_soc_ast27x0ssp_get_irq;
> +}
> +
> +static const TypeInfo aspeed_soc_ast27x0ssp_types[] = {
> +    {
> +        .name           = TYPE_ASPEED27X0SSP_SOC,
> +        .parent         = TYPE_ASPEED_SOC,
> +        .instance_size  = sizeof(Aspeed27x0SSPSoCState),
> +        .abstract       = true,

The abstract class doesn't seem useful. why keep it ?


Thanks,

C.



> +    }, {
> +        .name           = "ast2700ssp",
> +        .parent         = TYPE_ASPEED27X0SSP_SOC,
> +        .instance_init  = aspeed_soc_ast27x0ssp_init,
> +        .class_init     = aspeed_soc_ast27x0ssp_class_init,
> +    },
> +};
> +
> +DEFINE_TYPES(aspeed_soc_ast27x0ssp_types)
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index ac473ce7cd..aec0a0b98d 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -44,6 +44,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
>     'aspeed_soc_common.c',
>     'aspeed_ast2400.c',
>     'aspeed_ast2600.c',
> +  'aspeed_ast27x0-ssp.c',
>     'aspeed_ast10x0.c',
>     'aspeed_eeprom.c',
>     'fby35.c'))


