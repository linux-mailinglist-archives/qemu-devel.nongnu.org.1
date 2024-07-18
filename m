Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EBE934A7A
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jul 2024 10:52:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMrc-0001vt-OT; Thu, 18 Jul 2024 04:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=3riu=OS=kaod.org=clg@ozlabs.org>)
 id 1sUMra-0001qk-QB; Thu, 18 Jul 2024 04:51:46 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=3riu=OS=kaod.org=clg@ozlabs.org>)
 id 1sUMrY-0000EG-Jg; Thu, 18 Jul 2024 04:51:46 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WPmkg5vrZz4x0C;
 Thu, 18 Jul 2024 18:51:39 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WPmkb4jm4z4wbr;
 Thu, 18 Jul 2024 18:51:35 +1000 (AEST)
Message-ID: <028d2b2b-05d9-4e45-9159-30b3685e2f04@kaod.org>
Date: Thu, 18 Jul 2024 10:51:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/15] hw/i2c/aspeed: Add AST2700 support
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240718064925.1846074-1-jamin_lin@aspeedtech.com>
 <20240718064925.1846074-10-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240718064925.1846074-10-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=3riu=OS=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 7/18/24 08:49, Jamin Lin wrote:
> Introduce a new ast2700 class to support AST2700.
> The I2C bus register memory regions and
> I2C bus pool buffer memory regions are discontinuous
> and they do not back compatible AST2600.
> 
> Add a new ast2700 i2c class init function to match the
> address of I2C bus register and pool buffer from the datasheet.
> 
> An I2C controller registers owns 8KB address space.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/i2c/aspeed_i2c.c         | 62 +++++++++++++++++++++++++++++++++++++
>   include/hw/i2c/aspeed_i2c.h |  1 +
>   2 files changed, 63 insertions(+)
> 
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index c0d3ac3867..29d400ac93 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -1101,6 +1101,41 @@ static void aspeed_i2c_instance_init(Object *obj)
>    *   0xDA0 ... 0xDBF: Device 14 buffer
>    *   0xDC0 ... 0xDDF: Device 15 buffer (15 and 16 unused in AST1030)
>    *   0xDE0 ... 0xDFF: Device 16 buffer
> + *
> + * Address Definitions (AST2700)
> + *   0x000 ... 0x0FF: Global Register
> + *   0x100 ... 0x17F: Device 0
> + *   0x1A0 ... 0x1BF: Device 0 buffer
> + *   0x200 ... 0x27F: Device 1
> + *   0x2A0 ... 0x2BF: Device 1 buffer
> + *   0x300 ... 0x37F: Device 2
> + *   0x3A0 ... 0x3BF: Device 2 buffer
> + *   0x400 ... 0x47F: Device 3
> + *   0x4A0 ... 0x4BF: Device 3 buffer
> + *   0x500 ... 0x57F: Device 4
> + *   0x5A0 ... 0x5BF: Device 4 buffer
> + *   0x600 ... 0x67F: Device 5
> + *   0x6A0 ... 0x6BF: Device 5 buffer
> + *   0x700 ... 0x77F: Device 6
> + *   0x7A0 ... 0x7BF: Device 6 buffer
> + *   0x800 ... 0x87F: Device 7
> + *   0x8A0 ... 0x8BF: Device 7 buffer
> + *   0x900 ... 0x97F: Device 8
> + *   0x9A0 ... 0x9BF: Device 8 buffer
> + *   0xA00 ... 0xA7F: Device 9
> + *   0xAA0 ... 0xABF: Device 9 buffer
> + *   0xB00 ... 0xB7F: Device 10
> + *   0xBA0 ... 0xBBF: Device 10 buffer
> + *   0xC00 ... 0xC7F: Device 11
> + *   0xCA0 ... 0xCBF: Device 11 buffer
> + *   0xD00 ... 0xD7F: Device 12
> + *   0xDA0 ... 0xDBF: Device 12 buffer
> + *   0xE00 ... 0xE7F: Device 13
> + *   0xEA0 ... 0xEBF: Device 13 buffer
> + *   0xF00 ... 0xF7F: Device 14
> + *   0xFA0 ... 0xFBF: Device 14 buffer
> + *   0x1000 ... 0x107F: Device 15
> + *   0x10A0 ... 0x10BF: Device 15 buffer
>    */
>   static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
>   {
> @@ -1500,6 +1535,32 @@ static const TypeInfo aspeed_1030_i2c_info = {
>       .class_init = aspeed_1030_i2c_class_init,
>   };
>   
> +static void aspeed_2700_i2c_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    AspeedI2CClass *aic = ASPEED_I2C_CLASS(klass);
> +
> +    dc->desc = "ASPEED 2700 I2C Controller";
> +
> +    aic->num_busses = 16;
> +    aic->reg_size = 0x80;
> +    aic->reg_gap_size = 0x80;
> +    aic->gap = -1; /* no gap */
> +    aic->bus_get_irq = aspeed_2600_i2c_bus_get_irq;
> +    aic->pool_size = 0x20;
> +    aic->pool_gap_size = 0xe0;
> +    aic->pool_base = 0x1a0;
> +    aic->bus_pool_base = aspeed_2500_i2c_bus_pool_base;
> +    aic->has_dma = true;
> +    aic->mem_size = 0x10000;

I see an overlap the SLI model. Is this value correct ?

  

Thanks,

C.


  
> +}
> +
> +static const TypeInfo aspeed_2700_i2c_info = {
> +    .name = TYPE_ASPEED_2700_I2C,
> +    .parent = TYPE_ASPEED_I2C,
> +    .class_init = aspeed_2700_i2c_class_init,
> +};
> +
>   static void aspeed_i2c_register_types(void)
>   {
>       type_register_static(&aspeed_i2c_bus_info);
> @@ -1509,6 +1570,7 @@ static void aspeed_i2c_register_types(void)
>       type_register_static(&aspeed_2500_i2c_info);
>       type_register_static(&aspeed_2600_i2c_info);
>       type_register_static(&aspeed_1030_i2c_info);
> +    type_register_static(&aspeed_2700_i2c_info);
>   }
>   
>   type_init(aspeed_i2c_register_types)
> diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
> index bdaea3207d..4f23dc10c3 100644
> --- a/include/hw/i2c/aspeed_i2c.h
> +++ b/include/hw/i2c/aspeed_i2c.h
> @@ -31,6 +31,7 @@
>   #define TYPE_ASPEED_2500_I2C TYPE_ASPEED_I2C "-ast2500"
>   #define TYPE_ASPEED_2600_I2C TYPE_ASPEED_I2C "-ast2600"
>   #define TYPE_ASPEED_1030_I2C TYPE_ASPEED_I2C "-ast1030"
> +#define TYPE_ASPEED_2700_I2C TYPE_ASPEED_I2C "-ast2700"
>   OBJECT_DECLARE_TYPE(AspeedI2CState, AspeedI2CClass, ASPEED_I2C)
>   
>   #define ASPEED_I2C_NR_BUSSES 16


