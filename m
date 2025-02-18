Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F9FA39391
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Feb 2025 07:50:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkHQR-00022u-7P; Tue, 18 Feb 2025 01:49:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=OI5l=VJ=kaod.org=clg@ozlabs.org>)
 id 1tkHQN-00022R-Qg; Tue, 18 Feb 2025 01:49:43 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=OI5l=VJ=kaod.org=clg@ozlabs.org>)
 id 1tkHQL-00076r-IF; Tue, 18 Feb 2025 01:49:43 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Yxqrg1x8jz4x0t;
 Tue, 18 Feb 2025 17:49:39 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Yxqrc3nHjz4wcr;
 Tue, 18 Feb 2025 17:49:36 +1100 (AEDT)
Message-ID: <ca2ad388-2bb0-4583-88c1-7821064592e6@kaod.org>
Date: Tue, 18 Feb 2025 07:49:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/28] hw/arm/aspeed: Add SoC and Machine Support for
 AST2700 A1
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20250213033531.3367697-1-jamin_lin@aspeedtech.com>
 <20250213033531.3367697-19-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250213033531.3367697-19-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=OI5l=VJ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 2/13/25 04:35, Jamin Lin wrote:
> The memory map for AST2700 A1 remains compatible with AST2700 A0. However, the
> IRQ mapping has been updated for AST2700 A1, with GIC interrupts now ranging
> from 192 to 201. Add a new IRQ map table for AST2700 A1.
> Add "aspeed_soc_ast2700a1_class_init" to initialize the AST2700 A1 SoC.
> Introduce "aspeed_machine_ast2700a1_evb_class_init" to initialize the
> AST2700 A1 EVB.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed.c         | 13 +++++++
>   hw/arm/aspeed_ast27x0.c | 80 +++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 93 insertions(+)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 6ddfdbdeba..c0539e5950 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -1672,6 +1672,15 @@ static void aspeed_machine_ast2700a0_evb_class_init(ObjectClass *oc, void *data)
>       mc->default_ram_size = 1 * GiB;
>       aspeed_machine_class_init_cpus_defaults(mc);
>   }
> +
> +static void aspeed_machine_ast2700a1_evb_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
> +
> +    mc->desc = "Aspeed AST2700 A1 EVB (Cortex-A35)";
> +    amc->soc_name  = "ast2700-a1";
> +}
>   #endif
>   
>   static void aspeed_machine_qcom_dc_scm_v1_class_init(ObjectClass *oc,
> @@ -1798,6 +1807,10 @@ static const TypeInfo aspeed_machine_types[] = {
>           .name          = MACHINE_TYPE_NAME("ast2700a0-evb"),
>           .parent        = TYPE_ASPEED_MACHINE,
>           .class_init    = aspeed_machine_ast2700a0_evb_class_init,
> +        }, {
> +        .name          = MACHINE_TYPE_NAME("ast2700a1-evb"),
> +        .parent        = MACHINE_TYPE_NAME("ast2700a0-evb"),

Shouldn't the parent be TYPE_ASPEED_MACHINE instead ?

> +        .class_init    = aspeed_machine_ast2700a1_evb_class_init,
>   #endif
>       }, {
>           .name          = TYPE_ASPEED_MACHINE,
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index 0ccec774de..926b4c3e76 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -119,6 +119,52 @@ static const int aspeed_soc_ast2700a0_irqmap[] = {
>       [ASPEED_DEV_SDHCI]     = 133,
>   };
>   
> +static const int aspeed_soc_ast2700a1_irqmap[] = {
> +    [ASPEED_DEV_SDMC]      = 0,
> +    [ASPEED_DEV_HACE]      = 4,
> +    [ASPEED_DEV_XDMA]      = 5,
> +    [ASPEED_DEV_UART4]     = 8,
> +    [ASPEED_DEV_SCU]       = 12,
> +    [ASPEED_DEV_RTC]       = 13,
> +    [ASPEED_DEV_EMMC]      = 15,
> +    [ASPEED_DEV_TIMER1]    = 16,
> +    [ASPEED_DEV_TIMER2]    = 17,
> +    [ASPEED_DEV_TIMER3]    = 18,
> +    [ASPEED_DEV_TIMER4]    = 19,
> +    [ASPEED_DEV_TIMER5]    = 20,
> +    [ASPEED_DEV_TIMER6]    = 21,
> +    [ASPEED_DEV_TIMER7]    = 22,
> +    [ASPEED_DEV_TIMER8]    = 23,
> +    [ASPEED_DEV_DP]        = 28,
> +    [ASPEED_DEV_LPC]       = 192,
> +    [ASPEED_DEV_IBT]       = 192,
> +    [ASPEED_DEV_KCS]       = 192,
> +    [ASPEED_DEV_I2C]       = 194,
> +    [ASPEED_DEV_ADC]       = 194,
> +    [ASPEED_DEV_GPIO]      = 194,
> +    [ASPEED_DEV_FMC]       = 195,
> +    [ASPEED_DEV_WDT]       = 195,
> +    [ASPEED_DEV_PWM]       = 195,
> +    [ASPEED_DEV_I3C]       = 195,
> +    [ASPEED_DEV_UART0]     = 196,
> +    [ASPEED_DEV_UART1]     = 196,
> +    [ASPEED_DEV_UART2]     = 196,
> +    [ASPEED_DEV_UART3]     = 196,
> +    [ASPEED_DEV_UART5]     = 196,
> +    [ASPEED_DEV_UART6]     = 196,
> +    [ASPEED_DEV_UART7]     = 196,
> +    [ASPEED_DEV_UART8]     = 196,
> +    [ASPEED_DEV_UART9]     = 196,
> +    [ASPEED_DEV_UART10]    = 196,
> +    [ASPEED_DEV_UART11]    = 196,
> +    [ASPEED_DEV_UART12]    = 196,
> +    [ASPEED_DEV_ETH1]      = 196,
> +    [ASPEED_DEV_ETH2]      = 196,
> +    [ASPEED_DEV_ETH3]      = 196,
> +    [ASPEED_DEV_PECI]      = 197,
> +    [ASPEED_DEV_SDHCI]     = 197,
> +};
> +
>   /* GICINT 128 */
>   /* GICINT 192 */
>   static const int ast2700_gic128_gic192_intcmap[] = {
> @@ -838,6 +884,34 @@ static void aspeed_soc_ast2700a0_class_init(ObjectClass *oc, void *data)
>       sc->get_irq      = aspeed_soc_ast2700_get_irq;
>   }
>   
> +static void aspeed_soc_ast2700a1_class_init(ObjectClass *oc, void *data)
> +{
> +    static const char * const valid_cpu_types[] = {
> +        ARM_CPU_TYPE_NAME("cortex-a35"),
> +        NULL
> +    };
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +    AspeedSoCClass *sc = ASPEED_SOC_CLASS(oc);
> +
> +    /* Reason: The Aspeed SoC can only be instantiated from a board */
> +    dc->user_creatable = false;
> +    dc->realize      = aspeed_soc_ast2700_realize;
> +
> +    sc->name         = "ast2700-a1";
> +    sc->valid_cpu_types = valid_cpu_types;
> +    sc->silicon_rev  = AST2700_A1_SILICON_REV;
> +    sc->sram_size    = 0x20000;
> +    sc->spis_num     = 3;
> +    sc->wdts_num     = 8;
> +    sc->macs_num     = 3;
> +    sc->uarts_num    = 13;
> +    sc->num_cpus     = 4;
> +    sc->uarts_base   = ASPEED_DEV_UART0;
> +    sc->irqmap       = aspeed_soc_ast2700a1_irqmap;
> +    sc->memmap       = aspeed_soc_ast2700_memmap;
> +    sc->get_irq      = aspeed_soc_ast2700_get_irq;
> +}
> +
>   static const TypeInfo aspeed_soc_ast27x0_types[] = {
>       {
>           .name           = TYPE_ASPEED27X0_SOC,
> @@ -850,6 +924,12 @@ static const TypeInfo aspeed_soc_ast27x0_types[] = {
>           .instance_init  = aspeed_soc_ast2700_init,
>           .class_init     = aspeed_soc_ast2700a0_class_init,
>       },
> +    {
> +        .name           = "ast2700-a1",
> +        .parent         = TYPE_ASPEED27X0_SOC,
> +        .instance_init  = aspeed_soc_ast2700_init,
> +        .class_init     = aspeed_soc_ast2700a1_class_init,
> +    },
>   };
>   
>   DEFINE_TYPES(aspeed_soc_ast27x0_types)


