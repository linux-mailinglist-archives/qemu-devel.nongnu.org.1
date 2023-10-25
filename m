Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 270407D6222
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:10:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvY1e-0006hB-AJ; Wed, 25 Oct 2023 03:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=4l40=GH=kaod.org=clg@ozlabs.org>)
 id 1qvY1U-0006de-JD; Wed, 25 Oct 2023 03:09:48 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=4l40=GH=kaod.org=clg@ozlabs.org>)
 id 1qvY1S-0001FX-Sv; Wed, 25 Oct 2023 03:09:48 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SFg6H2SpQz4wx5;
 Wed, 25 Oct 2023 18:09:43 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SFg6F0Pn4z4wdC;
 Wed, 25 Oct 2023 18:09:40 +1100 (AEDT)
Message-ID: <8d95d908-ed62-43c3-8811-743ec23ed570@kaod.org>
Date: Wed, 25 Oct 2023 09:09:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] hw/arm/aspeed: Introduce TYPE_ASPEED2600_SOC
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org
References: <20231024162423.40206-1-philmd@linaro.org>
 <20231024162423.40206-7-philmd@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231024162423.40206-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=4l40=GH=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
> TYPE_ASPEED2600_SOC inherits from TYPE_ASPEED_SOC.
> In few commits we'll add more fields, but to keep
> review process simple, don't add any yet.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>



Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   include/hw/arm/aspeed_soc.h |  7 +++++++
>   hw/arm/aspeed_ast2600.c     | 26 +++++++++++++-------------
>   2 files changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index dcb43a4ecd..103b1598f6 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -101,6 +101,13 @@ struct AspeedSoCState {
>   #define TYPE_ASPEED_SOC "aspeed-soc"
>   OBJECT_DECLARE_TYPE(AspeedSoCState, AspeedSoCClass, ASPEED_SOC)
>   
> +struct Aspeed2600SoCState {
> +    AspeedSoCState parent;
> +};
> +
> +#define TYPE_ASPEED2600_SOC "aspeed2600-soc"
> +OBJECT_DECLARE_SIMPLE_TYPE(Aspeed2600SoCState, ASPEED2600_SOC)
> +
>   struct Aspeed10x0SoCState {
>       AspeedSoCState parent;
>   };
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index e122e1c32d..1ee460e56c 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -646,18 +646,18 @@ static void aspeed_soc_ast2600_class_init(ObjectClass *oc, void *data)
>       sc->get_irq      = aspeed_soc_ast2600_get_irq;
>   }
>   
> -static const TypeInfo aspeed_soc_ast2600_type_info = {
> -    .name           = "ast2600-a3",
> -    .parent         = TYPE_ASPEED_SOC,
> -    .instance_size  = sizeof(AspeedSoCState),
> -    .instance_init  = aspeed_soc_ast2600_init,
> -    .class_init     = aspeed_soc_ast2600_class_init,
> -    .class_size     = sizeof(AspeedSoCClass),
> +static const TypeInfo aspeed_soc_ast2600_types[] = {
> +    {
> +        .name           = TYPE_ASPEED2600_SOC,
> +        .parent         = TYPE_ASPEED_SOC,
> +        .instance_size  = sizeof(Aspeed2600SoCState),
> +        .abstract       = true,
> +    }, {
> +        .name           = "ast2600-a3",
> +        .parent         = TYPE_ASPEED2600_SOC,
> +        .instance_init  = aspeed_soc_ast2600_init,
> +        .class_init     = aspeed_soc_ast2600_class_init,
> +    },
>   };
>   
> -static void aspeed_soc_register_types(void)
> -{
> -    type_register_static(&aspeed_soc_ast2600_type_info);
> -};
> -
> -type_init(aspeed_soc_register_types)
> +DEFINE_TYPES(aspeed_soc_ast2600_types)


