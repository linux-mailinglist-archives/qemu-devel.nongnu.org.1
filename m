Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD3B7D621C
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:08:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvXzL-0002Wp-QY; Wed, 25 Oct 2023 03:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=4l40=GH=kaod.org=clg@ozlabs.org>)
 id 1qvXzF-0002P8-Io; Wed, 25 Oct 2023 03:07:30 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=4l40=GH=kaod.org=clg@ozlabs.org>)
 id 1qvXzB-0000s2-Qr; Wed, 25 Oct 2023 03:07:27 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SFg3b4Dh8z4wx7;
 Wed, 25 Oct 2023 18:07:23 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SFg3Y2GYYz4wx5;
 Wed, 25 Oct 2023 18:07:21 +1100 (AEDT)
Message-ID: <e43f1bb7-acc4-471d-afb9-7ccedb811e4a@kaod.org>
Date: Wed, 25 Oct 2023 09:07:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] hw/arm/aspeed: Rename aspeed_soc_realize() as
 AST2400/2500 specific
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org
References: <20231024162423.40206-1-philmd@linaro.org>
 <20231024162423.40206-4-philmd@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231024162423.40206-4-philmd@linaro.org>
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
> Keep aspeed_soc_class_init() generic, set the realize handler
> to aspeed_ast2400_soc_realize() in each 2400/2500 class_init.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   hw/arm/aspeed_soc.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index bb377e9e6e..191276a320 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -239,7 +239,7 @@ static void aspeed_ast2400_soc_init(Object *obj)
>       object_initialize_child(obj, "video", &s->video, TYPE_UNIMPLEMENTED_DEVICE);
>   }
>   
> -static void aspeed_soc_realize(DeviceState *dev, Error **errp)
> +static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
>   {
>       int i;
>       AspeedSoCState *s = ASPEED_SOC(dev);
> @@ -509,9 +509,6 @@ static void aspeed_soc_class_init(ObjectClass *oc, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(oc);
>   
> -    dc->realize = aspeed_soc_realize;
> -    /* Reason: Uses serial_hds and nd_table in realize() directly */
> -    dc->user_creatable = false;
>       device_class_set_props(dc, aspeed_soc_properties);
>   }
>   
> @@ -527,6 +524,11 @@ static const TypeInfo aspeed_soc_type_info = {
>   static void aspeed_soc_ast2400_class_init(ObjectClass *oc, void *data)
>   {
>       AspeedSoCClass *sc = ASPEED_SOC_CLASS(oc);
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +
> +    dc->realize = aspeed_ast2400_soc_realize;
> +    /* Reason: Uses serial_hds and nd_table in realize() directly */
> +    dc->user_creatable = false;
>   
>       sc->name         = "ast2400-a1";
>       sc->cpu_type     = ARM_CPU_TYPE_NAME("arm926");
> @@ -554,6 +556,11 @@ static const TypeInfo aspeed_soc_ast2400_type_info = {
>   static void aspeed_soc_ast2500_class_init(ObjectClass *oc, void *data)
>   {
>       AspeedSoCClass *sc = ASPEED_SOC_CLASS(oc);
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +
> +    dc->realize = aspeed_ast2400_soc_realize;
> +    /* Reason: Uses serial_hds and nd_table in realize() directly */
> +    dc->user_creatable = false;
>   
>       sc->name         = "ast2500-a1";
>       sc->cpu_type     = ARM_CPU_TYPE_NAME("arm1176");


