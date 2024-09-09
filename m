Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE5A971041
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Sep 2024 09:50:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snZAP-0001iN-At; Mon, 09 Sep 2024 03:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Li2i=QH=kaod.org=clg@ozlabs.org>)
 id 1snZA7-0000EC-MU; Mon, 09 Sep 2024 03:50:17 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Li2i=QH=kaod.org=clg@ozlabs.org>)
 id 1snZ9z-0004NE-9N; Mon, 09 Sep 2024 03:50:10 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4X2Js71lGrz4wc3;
 Mon,  9 Sep 2024 17:50:03 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4X2Js16BxJz4wb0;
 Mon,  9 Sep 2024 17:49:57 +1000 (AEST)
Message-ID: <63efbcd1-329d-44e3-857d-212fd9eb90ce@kaod.org>
Date: Mon, 9 Sep 2024 09:49:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 8/8] aspeed: Add uhci support for ast2400 and ast2500
To: Guenter Roeck <linux@roeck-us.net>, qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 BALATON Zoltan <balaton@eik.bme.hu>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
References: <20240906122542.3808997-1-linux@roeck-us.net>
 <20240906122542.3808997-9-linux@roeck-us.net>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240906122542.3808997-9-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Li2i=QH=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 9/6/24 14:25, Guenter Roeck wrote:
> Enable UHCI support for ast2400 and ast2500 SoCs. With this patch,
> the UHCI port is successfully instantiated on the ast2500-evb machine.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/arm/aspeed_ast2400.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
> index d125886207..93bfe3e3dd 100644
> --- a/hw/arm/aspeed_ast2400.c
> +++ b/hw/arm/aspeed_ast2400.c
> @@ -31,6 +31,7 @@ static const hwaddr aspeed_soc_ast2400_memmap[] = {
>       [ASPEED_DEV_FMC]    = 0x1E620000,
>       [ASPEED_DEV_SPI1]   = 0x1E630000,
>       [ASPEED_DEV_EHCI1]  = 0x1E6A1000,
> +    [ASPEED_DEV_UHCI]   = 0x1E6B0000,
>       [ASPEED_DEV_VIC]    = 0x1E6C0000,
>       [ASPEED_DEV_SDMC]   = 0x1E6E0000,
>       [ASPEED_DEV_SCU]    = 0x1E6E2000,
> @@ -68,6 +69,7 @@ static const hwaddr aspeed_soc_ast2500_memmap[] = {
>       [ASPEED_DEV_SPI2]   = 0x1E631000,
>       [ASPEED_DEV_EHCI1]  = 0x1E6A1000,
>       [ASPEED_DEV_EHCI2]  = 0x1E6A3000,
> +    [ASPEED_DEV_UHCI]   = 0x1E6B0000,
>       [ASPEED_DEV_VIC]    = 0x1E6C0000,
>       [ASPEED_DEV_SDMC]   = 0x1E6E0000,
>       [ASPEED_DEV_SCU]    = 0x1E6E2000,
> @@ -107,6 +109,7 @@ static const int aspeed_soc_ast2400_irqmap[] = {
>       [ASPEED_DEV_FMC]    = 19,
>       [ASPEED_DEV_EHCI1]  = 5,
>       [ASPEED_DEV_EHCI2]  = 13,
> +    [ASPEED_DEV_UHCI]   = 14,
>       [ASPEED_DEV_SDMC]   = 0,
>       [ASPEED_DEV_SCU]    = 21,
>       [ASPEED_DEV_ADC]    = 31,
> @@ -199,6 +202,8 @@ static void aspeed_ast2400_soc_init(Object *obj)
>                                   TYPE_PLATFORM_EHCI);
>       }
>   
> +    object_initialize_child(obj, "uhci", &s->uhci, TYPE_ASPEED_UHCI);
> +
>       snprintf(typename, sizeof(typename), "aspeed.sdmc-%s", socname);
>       object_initialize_child(obj, "sdmc", &s->sdmc, typename);
>       object_property_add_alias(obj, "ram-size", OBJECT(&s->sdmc),
> @@ -393,6 +398,15 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
>                              aspeed_soc_get_irq(s, ASPEED_DEV_EHCI1 + i));
>       }
>   
> +    /* UHCI */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->uhci), errp)) {
> +        return;
> +    }
> +    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->uhci), 0,
> +                    sc->memmap[ASPEED_DEV_UHCI]);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->uhci), 0,
> +                       aspeed_soc_get_irq(s, ASPEED_DEV_UHCI));
> +
>       /* SDMC - SDRAM Memory Controller */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), errp)) {
>           return;


