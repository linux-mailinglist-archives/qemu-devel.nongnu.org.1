Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2637934A38
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jul 2024 10:45:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMlF-0000nZ-Qa; Thu, 18 Jul 2024 04:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=3riu=OS=kaod.org=clg@ozlabs.org>)
 id 1sUMlA-0000Zg-SM; Thu, 18 Jul 2024 04:45:08 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=3riu=OS=kaod.org=clg@ozlabs.org>)
 id 1sUMl8-0006Mf-FU; Thu, 18 Jul 2024 04:45:08 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WPmb33tplz4w2Q;
 Thu, 18 Jul 2024 18:45:03 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WPmZz30z8z4wxk;
 Thu, 18 Jul 2024 18:44:59 +1000 (AEST)
Message-ID: <de851b5c-5983-44f6-955a-6ba71f966c71@kaod.org>
Date: Thu, 18 Jul 2024 10:44:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/15] hw/i2c/aspeed: support discontinuous register
 memory region of I2C bus
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240718064925.1846074-1-jamin_lin@aspeedtech.com>
 <20240718064925.1846074-5-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240718064925.1846074-5-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
> It only support continuous register memory region for all I2C bus.
> However, the register address of all I2c bus are discontinuous
> for AST2700.
> 
> Ex: the register address of I2C bus for ast2700 as following.
> 0x100 - 0x17F: Device 0
> 0x200 - 0x27F: Device 1
> 0x300 - 0x37F: Device 2
> 0x400 - 0x47F: Device 3
> 0x500 - 0x57F: Device 4
> 0x600 - 0x67F: Device 5
> 0x700 - 0x77F: Device 6
> 0x800 - 0x87F: Device 7
> 0x900 - 0x97F: Device 8
> 0xA00 - 0xA7F: Device 9
> 0xB00 - 0xB7F: Device 10
> 0xC00 - 0xC7F: Device 11
> 0xD00 - 0xD7F: Device 12
> 0xE00 - 0xE7F: Device 13
> 0xF00 – 0xF7F: Device 14
> 0x1000 – 0x107F: Device 15
> 
> Introduce a new class attribute to make user set each I2C bus gap size.
> Update formula to create all I2C bus register memory regions.

I don't think this is necessary to model. Could we simply increase
tge register MMIO size for the AST2700 bus model and rely on the
memops to catch invalid register offsets ?


Thanks,

C.



> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/i2c/aspeed_i2c.c         | 3 ++-
>   include/hw/i2c/aspeed_i2c.h | 1 +
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index 7d5a53c4c0..462ad78a13 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -1011,6 +1011,7 @@ static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
>       SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>       AspeedI2CState *s = ASPEED_I2C(dev);
>       AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(s);
> +    uint32_t reg_offset = aic->reg_size + aic->reg_gap_size;
>   
>       sysbus_init_irq(sbd, &s->irq);
>       memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_i2c_ctrl_ops, s,
> @@ -1033,7 +1034,7 @@ static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
>               return;
>           }
>   
> -        memory_region_add_subregion(&s->iomem, aic->reg_size * (i + offset),
> +        memory_region_add_subregion(&s->iomem, reg_offset * (i + offset),
>                                       &s->busses[i].mr);
>       }
>   
> diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
> index 065b636d29..422ee0e298 100644
> --- a/include/hw/i2c/aspeed_i2c.h
> +++ b/include/hw/i2c/aspeed_i2c.h
> @@ -275,6 +275,7 @@ struct AspeedI2CClass {
>   
>       uint8_t num_busses;
>       uint8_t reg_size;
> +    uint32_t reg_gap_size;
>       uint8_t gap;
>       qemu_irq (*bus_get_irq)(AspeedI2CBus *);
>   


