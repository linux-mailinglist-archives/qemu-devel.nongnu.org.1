Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E868C7D63D5
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:46:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvYZy-00017T-4X; Wed, 25 Oct 2023 03:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=4l40=GH=kaod.org=clg@ozlabs.org>)
 id 1qvYZs-00016T-Mu; Wed, 25 Oct 2023 03:45:20 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=4l40=GH=kaod.org=clg@ozlabs.org>)
 id 1qvYZq-0007TR-EK; Wed, 25 Oct 2023 03:45:20 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SFgvH5cFRz4wxX;
 Wed, 25 Oct 2023 18:45:15 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SFgvG00mBz4wch;
 Wed, 25 Oct 2023 18:45:13 +1100 (AEDT)
Message-ID: <e7e81178-beaf-4aca-8181-6a56b8c74816@kaod.org>
Date: Wed, 25 Oct 2023 09:45:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] hw/arm/aspeed: Move AspeedSoCState::cpu/vic to
 Aspeed2400SoCState
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org
References: <20231024162423.40206-1-philmd@linaro.org>
 <20231024162423.40206-12-philmd@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231024162423.40206-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=4l40=GH=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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

On 10/24/23 18:24, Philippe Mathieu-Daudé wrote:
> The ARM array and VIC peripheral are only used by the
> 2400 series, remove them from the common AspeedSoCState.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   include/hw/arm/aspeed_soc.h               |  5 +++--
>   hw/arm/{aspeed_soc.c => aspeed_ast2400.c} | 27 +++++++++++++----------
>   hw/arm/meson.build                        |  2 +-
>   3 files changed, 19 insertions(+), 15 deletions(-)
>   rename hw/arm/{aspeed_soc.c => aspeed_ast2400.c} (95%)
> 
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 6f783138e1..cb832bc1ee 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -49,14 +49,12 @@
>   struct AspeedSoCState {
>       DeviceState parent;
>   
> -    ARMCPU cpu[ASPEED_CPUS_NUM];
>       MemoryRegion *memory;
>       MemoryRegion *dram_mr;
>       MemoryRegion dram_container;
>       MemoryRegion sram;
>       MemoryRegion spi_boot_container;
>       MemoryRegion spi_boot;
> -    AspeedVICState vic;
>       AspeedRtcState rtc;
>       AspeedTimerCtrlState timerctrl;
>       AspeedI2CState i2c;
> @@ -99,6 +97,9 @@ OBJECT_DECLARE_TYPE(AspeedSoCState, AspeedSoCClass, ASPEED_SOC)
>   
>   struct Aspeed2400SoCState {
>       AspeedSoCState parent;
> +
> +    ARMCPU cpu[ASPEED_CPUS_NUM];
> +    AspeedVICState vic;
>   };
>   
>   #define TYPE_ASPEED2400_SOC "aspeed2400-soc"
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_ast2400.c
> similarity index 95%
> rename from hw/arm/aspeed_soc.c
> rename to hw/arm/aspeed_ast2400.c
> index dfb97f6dbd..a4334c81b8 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_ast2400.c
> @@ -135,13 +135,15 @@ static const int aspeed_soc_ast2400_irqmap[] = {
>   
>   static qemu_irq aspeed_soc_ast2400_get_irq(AspeedSoCState *s, int dev)
>   {
> +    Aspeed2400SoCState *a = ASPEED2400_SOC(s);
>       AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
>   
> -    return qdev_get_gpio_in(DEVICE(&s->vic), sc->irqmap[dev]);
> +    return qdev_get_gpio_in(DEVICE(&a->vic), sc->irqmap[dev]);
>   }
>   
>   static void aspeed_ast2400_soc_init(Object *obj)
>   {
> +    Aspeed2400SoCState *a = ASPEED2400_SOC(obj);
>       AspeedSoCState *s = ASPEED_SOC(obj);
>       AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
>       int i;
> @@ -153,7 +155,7 @@ static void aspeed_ast2400_soc_init(Object *obj)
>       }
>   
>       for (i = 0; i < sc->num_cpus; i++) {
> -        object_initialize_child(obj, "cpu[*]", &s->cpu[i], sc->cpu_type);
> +        object_initialize_child(obj, "cpu[*]", &a->cpu[i], sc->cpu_type);
>       }
>   
>       snprintf(typename, sizeof(typename), "aspeed.scu-%s", socname);
> @@ -167,7 +169,7 @@ static void aspeed_ast2400_soc_init(Object *obj)
>       object_property_add_alias(obj, "hw-prot-key", OBJECT(&s->scu),
>                                 "hw-prot-key");
>   
> -    object_initialize_child(obj, "vic", &s->vic, TYPE_ASPEED_VIC);
> +    object_initialize_child(obj, "vic", &a->vic, TYPE_ASPEED_VIC);
>   
>       object_initialize_child(obj, "rtc", &s->rtc, TYPE_ASPEED_RTC);
>   
> @@ -242,6 +244,7 @@ static void aspeed_ast2400_soc_init(Object *obj)
>   static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
>   {
>       int i;
> +    Aspeed2400SoCState *a = ASPEED2400_SOC(dev);
>       AspeedSoCState *s = ASPEED_SOC(dev);
>       AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
>       Error *err = NULL;
> @@ -264,15 +267,15 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
>   
>       /* CPU */
>       for (i = 0; i < sc->num_cpus; i++) {
> -        object_property_set_link(OBJECT(&s->cpu[i]), "memory",
> +        object_property_set_link(OBJECT(&a->cpu[i]), "memory",
>                                    OBJECT(s->memory), &error_abort);
> -        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
> +        if (!qdev_realize(DEVICE(&a->cpu[i]), NULL, errp)) {
>               return;
>           }
>       }
>   
>       /* SRAM */
> -    sram_name = g_strdup_printf("aspeed.sram.%d", CPU(&s->cpu[0])->cpu_index);
> +    sram_name = g_strdup_printf("aspeed.sram.%d", CPU(&a->cpu[0])->cpu_index);
>       memory_region_init_ram(&s->sram, OBJECT(s), sram_name, sc->sram_size, &err);
>       if (err) {
>           error_propagate(errp, err);
> @@ -288,14 +291,14 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
>       aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->scu), 0, sc->memmap[ASPEED_DEV_SCU]);
>   
>       /* VIC */
> -    if (!sysbus_realize(SYS_BUS_DEVICE(&s->vic), errp)) {
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&a->vic), errp)) {
>           return;
>       }
> -    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->vic), 0, sc->memmap[ASPEED_DEV_VIC]);
> -    sysbus_connect_irq(SYS_BUS_DEVICE(&s->vic), 0,
> -                       qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_IRQ));
> -    sysbus_connect_irq(SYS_BUS_DEVICE(&s->vic), 1,
> -                       qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_FIQ));
> +    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->vic), 0, sc->memmap[ASPEED_DEV_VIC]);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&a->vic), 0,
> +                       qdev_get_gpio_in(DEVICE(&a->cpu), ARM_CPU_IRQ));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&a->vic), 1,
> +                       qdev_get_gpio_in(DEVICE(&a->cpu), ARM_CPU_FIQ));
>   
>       /* RTC */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->rtc), errp)) {
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index 42e7aa36f3..68245d3ad1 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -48,9 +48,9 @@ arm_ss.add(when: 'CONFIG_FSL_IMX25', if_true: files('fsl-imx25.c', 'imx25_pdk.c'
>   arm_ss.add(when: 'CONFIG_FSL_IMX31', if_true: files('fsl-imx31.c', 'kzm.c'))
>   arm_ss.add(when: 'CONFIG_FSL_IMX6', if_true: files('fsl-imx6.c'))
>   arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
> -  'aspeed_soc.c',
>     'aspeed.c',
>     'aspeed_soc_common.c',
> +  'aspeed_ast2400.c',
>     'aspeed_ast2600.c',
>     'aspeed_ast10x0.c',
>     'aspeed_eeprom.c',


