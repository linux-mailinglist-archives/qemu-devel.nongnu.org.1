Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF95CA22281
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Jan 2025 18:05:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdBU7-0000Az-87; Wed, 29 Jan 2025 12:04:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=PAS2=UV=kaod.org=clg@ozlabs.org>)
 id 1tdBU5-0000AK-8b; Wed, 29 Jan 2025 12:04:13 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=PAS2=UV=kaod.org=clg@ozlabs.org>)
 id 1tdBTy-0006Ox-Vf; Wed, 29 Jan 2025 12:04:12 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4YjpQY5BHcz4x4t;
 Thu, 30 Jan 2025 04:03:49 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4YjpQT6pxFz4wxm;
 Thu, 30 Jan 2025 04:03:44 +1100 (AEDT)
Message-ID: <2d9247ab-34dd-4dde-a9c0-c04c2d8a1a18@kaod.org>
Date: Wed, 29 Jan 2025 18:03:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/18] hw/intc/aspeed: Rename INTC to INTC0
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20250121070424.2465942-1-jamin_lin@aspeedtech.com>
 <20250121070424.2465942-2-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250121070424.2465942-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=PAS2=UV=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.037, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 1/21/25 08:04, Jamin Lin wrote:
> The design of the INTC has significant changes in the AST2700 A1. In the
> AST2700 A0, there was one INTC controller, whereas in the AST2700 A1,
> there were two INTC controllers: INTC0 (CPU DIE) and INTC1 (I/O DIE).
> 
> The previous INTC model only supported the AST2700 A0 and was implemented for
> the INTC0 (CPU DIE). To support the future INTC1 (I/O DIE) model, rename INTC
> to INTC0.


Why not introduce definitions with _INTC_IO_ and leave alone the current
instead ? Do we expect to have more than 2 INTC controllers ?


Thanks,

C.




> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast27x0.c       |  6 +--
>   hw/intc/aspeed_intc.c         | 90 +++++++++++++++++------------------
>   include/hw/arm/aspeed_soc.h   |  2 +-
>   include/hw/intc/aspeed_intc.h |  2 +-
>   4 files changed, 50 insertions(+), 50 deletions(-)
> 
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index 4114e15ddd..ba461fcd3c 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -56,7 +56,7 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
>       [ASPEED_DEV_ETH2]      =  0x14060000,
>       [ASPEED_DEV_ETH3]      =  0x14070000,
>       [ASPEED_DEV_EMMC]      =  0x12090000,
> -    [ASPEED_DEV_INTC]      =  0x12100000,
> +    [ASPEED_DEV_INTC0]     =  0x12100000,
>       [ASPEED_DEV_SLI]       =  0x12C17000,
>       [ASPEED_DEV_SLIIO]     =  0x14C1E000,
>       [ASPEED_GIC_DIST]      =  0x12200000,
> @@ -372,7 +372,7 @@ static void aspeed_soc_ast2700_init(Object *obj)
>   
>       object_initialize_child(obj, "sli", &s->sli, TYPE_ASPEED_2700_SLI);
>       object_initialize_child(obj, "sliio", &s->sliio, TYPE_ASPEED_2700_SLIIO);
> -    object_initialize_child(obj, "intc", &a->intc, TYPE_ASPEED_2700_INTC);
> +    object_initialize_child(obj, "intc", &a->intc, TYPE_ASPEED_2700_INTC0);
>   
>       snprintf(typename, sizeof(typename), "aspeed.adc-%s", socname);
>       object_initialize_child(obj, "adc", &s->adc, typename);
> @@ -517,7 +517,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>       }
>   
>       aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc), 0,
> -                    sc->memmap[ASPEED_DEV_INTC]);
> +                    sc->memmap[ASPEED_DEV_INTC0]);
>   
>       /* GICINT orgates -> INTC -> GIC */
>       for (i = 0; i < ic->num_ints; i++) {
> diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
> index 126b711b94..df4da759e1 100644
> --- a/hw/intc/aspeed_intc.c
> +++ b/hw/intc/aspeed_intc.c
> @@ -14,27 +14,27 @@
>   #include "hw/registerfields.h"
>   #include "qapi/error.h"
>   
> -/* INTC Registers */
> -REG32(GICINT128_EN,         0x1000)
> -REG32(GICINT128_STATUS,     0x1004)
> -REG32(GICINT129_EN,         0x1100)
> -REG32(GICINT129_STATUS,     0x1104)
> -REG32(GICINT130_EN,         0x1200)
> -REG32(GICINT130_STATUS,     0x1204)
> -REG32(GICINT131_EN,         0x1300)
> -REG32(GICINT131_STATUS,     0x1304)
> -REG32(GICINT132_EN,         0x1400)
> -REG32(GICINT132_STATUS,     0x1404)
> -REG32(GICINT133_EN,         0x1500)
> -REG32(GICINT133_STATUS,     0x1504)
> -REG32(GICINT134_EN,         0x1600)
> -REG32(GICINT134_STATUS,     0x1604)
> -REG32(GICINT135_EN,         0x1700)
> -REG32(GICINT135_STATUS,     0x1704)
> -REG32(GICINT136_EN,         0x1800)
> -REG32(GICINT136_STATUS,     0x1804)
> -
> -#define GICINT_STATUS_BASE     R_GICINT128_STATUS
> +/* AST2700 INTC0 Registers */
> +REG32(INTC0_GICINT128_EN,         0x1000)
> +REG32(INTC0_GICINT128_STATUS,     0x1004)
> +REG32(INTC0_GICINT129_EN,         0x1100)
> +REG32(INTC0_GICINT129_STATUS,     0x1104)
> +REG32(INTC0_GICINT130_EN,         0x1200)
> +REG32(INTC0_GICINT130_STATUS,     0x1204)
> +REG32(INTC0_GICINT131_EN,         0x1300)
> +REG32(INTC0_GICINT131_STATUS,     0x1304)
> +REG32(INTC0_GICINT132_EN,         0x1400)
> +REG32(INTC0_GICINT132_STATUS,     0x1404)
> +REG32(INTC0_GICINT133_EN,         0x1500)
> +REG32(INTC0_GICINT133_STATUS,     0x1504)
> +REG32(INTC0_GICINT134_EN,         0x1600)
> +REG32(INTC0_GICINT134_STATUS,     0x1604)
> +REG32(INTC0_GICINT135_EN,         0x1700)
> +REG32(INTC0_GICINT135_STATUS,     0x1704)
> +REG32(INTC0_GICINT136_EN,         0x1800)
> +REG32(INTC0_GICINT136_STATUS,     0x1804)
> +
> +#define GICINT_STATUS_BASE     R_INTC0_GICINT128_STATUS
>   
>   static void aspeed_intc_update(AspeedINTCState *s, int irq, int level)
>   {
> @@ -153,15 +153,15 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
>       trace_aspeed_intc_write(offset, size, data);
>   
>       switch (addr) {
> -    case R_GICINT128_EN:
> -    case R_GICINT129_EN:
> -    case R_GICINT130_EN:
> -    case R_GICINT131_EN:
> -    case R_GICINT132_EN:
> -    case R_GICINT133_EN:
> -    case R_GICINT134_EN:
> -    case R_GICINT135_EN:
> -    case R_GICINT136_EN:
> +    case R_INTC0_GICINT128_EN:
> +    case R_INTC0_GICINT129_EN:
> +    case R_INTC0_GICINT130_EN:
> +    case R_INTC0_GICINT131_EN:
> +    case R_INTC0_GICINT132_EN:
> +    case R_INTC0_GICINT133_EN:
> +    case R_INTC0_GICINT134_EN:
> +    case R_INTC0_GICINT135_EN:
> +    case R_INTC0_GICINT136_EN:
>           irq = (offset & 0x0f00) >> 8;
>   
>           if (irq >= aic->num_ints) {
> @@ -202,15 +202,15 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
>           }
>           s->regs[addr] = data;
>           break;
> -    case R_GICINT128_STATUS:
> -    case R_GICINT129_STATUS:
> -    case R_GICINT130_STATUS:
> -    case R_GICINT131_STATUS:
> -    case R_GICINT132_STATUS:
> -    case R_GICINT133_STATUS:
> -    case R_GICINT134_STATUS:
> -    case R_GICINT135_STATUS:
> -    case R_GICINT136_STATUS:
> +    case R_INTC0_GICINT128_STATUS:
> +    case R_INTC0_GICINT129_STATUS:
> +    case R_INTC0_GICINT130_STATUS:
> +    case R_INTC0_GICINT131_STATUS:
> +    case R_INTC0_GICINT132_STATUS:
> +    case R_INTC0_GICINT133_STATUS:
> +    case R_INTC0_GICINT134_STATUS:
> +    case R_INTC0_GICINT135_STATUS:
> +    case R_INTC0_GICINT136_STATUS:
>           irq = (offset & 0x0f00) >> 8;
>   
>           if (irq >= aic->num_ints) {
> @@ -336,26 +336,26 @@ static const TypeInfo aspeed_intc_info = {
>       .abstract = true,
>   };
>   
> -static void aspeed_2700_intc_class_init(ObjectClass *klass, void *data)
> +static void aspeed_2700_intc0_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>       AspeedINTCClass *aic = ASPEED_INTC_CLASS(klass);
>   
> -    dc->desc = "ASPEED 2700 INTC Controller";
> +    dc->desc = "ASPEED 2700 INTC 0 Controller";
>       aic->num_lines = 32;
>       aic->num_ints = 9;
>   }
>   
> -static const TypeInfo aspeed_2700_intc_info = {
> -    .name = TYPE_ASPEED_2700_INTC,
> +static const TypeInfo aspeed_2700_intc0_info = {
> +    .name = TYPE_ASPEED_2700_INTC0,
>       .parent = TYPE_ASPEED_INTC,
> -    .class_init = aspeed_2700_intc_class_init,
> +    .class_init = aspeed_2700_intc0_class_init,
>   };
>   
>   static void aspeed_intc_register_types(void)
>   {
>       type_register_static(&aspeed_intc_info);
> -    type_register_static(&aspeed_2700_intc_info);
> +    type_register_static(&aspeed_2700_intc0_info);
>   }
>   
>   type_init(aspeed_intc_register_types);
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 689f52dae8..51e585e3e4 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -194,7 +194,7 @@ enum {
>       ASPEED_DEV_EHCI1,
>       ASPEED_DEV_EHCI2,
>       ASPEED_DEV_VIC,
> -    ASPEED_DEV_INTC,
> +    ASPEED_DEV_INTC0,
>       ASPEED_DEV_SDMC,
>       ASPEED_DEV_SCU,
>       ASPEED_DEV_ADC,
> diff --git a/include/hw/intc/aspeed_intc.h b/include/hw/intc/aspeed_intc.h
> index 18cb43476c..10718ed4a1 100644
> --- a/include/hw/intc/aspeed_intc.h
> +++ b/include/hw/intc/aspeed_intc.h
> @@ -13,7 +13,7 @@
>   #include "hw/or-irq.h"
>   
>   #define TYPE_ASPEED_INTC "aspeed.intc"
> -#define TYPE_ASPEED_2700_INTC TYPE_ASPEED_INTC "-ast2700"
> +#define TYPE_ASPEED_2700_INTC0 TYPE_ASPEED_INTC "0" "-ast2700"
>   OBJECT_DECLARE_TYPE(AspeedINTCState, AspeedINTCClass, ASPEED_INTC)
>   
>   #define ASPEED_INTC_NR_REGS (0x2000 >> 2)


