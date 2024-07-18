Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0557E934DF0
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jul 2024 15:20:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUR3L-0005YN-HR; Thu, 18 Jul 2024 09:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=3riu=OS=kaod.org=clg@ozlabs.org>)
 id 1sUR3I-0005Qq-M4; Thu, 18 Jul 2024 09:20:08 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=3riu=OS=kaod.org=clg@ozlabs.org>)
 id 1sUR3E-00043P-WA; Thu, 18 Jul 2024 09:20:08 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WPthD6WrRz4x1V;
 Thu, 18 Jul 2024 23:19:56 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WPth74BGGz4x0C;
 Thu, 18 Jul 2024 23:19:51 +1000 (AEST)
Message-ID: <5f6efa7b-0ed9-4cf3-b8e5-b6b0656394fd@kaod.org>
Date: Thu, 18 Jul 2024 15:19:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/15] hw/i2c/aspeed: support to set the different
 memory size
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:STM32F205" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>,
 Yunlin Tang <yunlin.tang@aspeedtech.com>
References: <20240718064925.1846074-1-jamin_lin@aspeedtech.com>
 <20240718064925.1846074-4-jamin_lin@aspeedtech.com>
 <311c3893-4e27-4472-8356-889fdaaade6f@kaod.org>
 <SI2PR06MB5041287D9E64F7D0E25968EEFCAC2@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <SI2PR06MB5041287D9E64F7D0E25968EEFCAC2@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
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

On 7/18/24 11:42, Jamin Lin wrote:
> Hi Cedric,
> 
>> Subject: Re: [PATCH v1 03/15] hw/i2c/aspeed: support to set the different
>> memory size
>>
>> On 7/18/24 08:49, Jamin Lin wrote:
>>> According to the datasheet of ASPEED SOCs, an I2C controller owns 8KB
>>> of register space for AST2700, owns 4KB of register space for AST2600,
>>> AST2500 and AST2400, and owns 64KB of register space for AST1030.
>>>
>>> It set the memory region size 4KB by default and it does not
>>> compatible register space for AST2700.
>>>
>>> Introduce a new class attribute to set the I2C controller memory size
>>> for different ASPEED SOCs.
>>>
>>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>>> ---
>>>    hw/i2c/aspeed_i2c.c         | 6 +++++-
>>>    include/hw/i2c/aspeed_i2c.h | 2 +-
>>>    2 files changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c index
>>> b43afd250d..7d5a53c4c0 100644
>>> --- a/hw/i2c/aspeed_i2c.c
>>> +++ b/hw/i2c/aspeed_i2c.c
>>> @@ -1014,7 +1014,7 @@ static void aspeed_i2c_realize(DeviceState *dev,
>>> Error **errp)
>>>
>>>        sysbus_init_irq(sbd, &s->irq);
>>>        memory_region_init_io(&s->iomem, OBJECT(s),
>> &aspeed_i2c_ctrl_ops, s,
>>> -                          "aspeed.i2c", 0x1000);
>>> +                          "aspeed.i2c", aic->mem_size);
>>>        sysbus_init_mmio(sbd, &s->iomem);
>>>
>>>        for (i = 0; i < aic->num_busses; i++) { @@ -1286,6 +1286,7 @@
>>> static void aspeed_2400_i2c_class_init(ObjectClass *klass, void *data)
>>>        aic->pool_size = 0x800;
>>>        aic->pool_base = 0x800;
>>>        aic->bus_pool_base = aspeed_2400_i2c_bus_pool_base;
>>> +    aic->mem_size = 0x1000;
>>>    }
>>>
>>>    static const TypeInfo aspeed_2400_i2c_info = { @@ -1320,6 +1321,7 @@
>>> static void aspeed_2500_i2c_class_init(ObjectClass *klass, void *data)
>>>        aic->bus_pool_base = aspeed_2500_i2c_bus_pool_base;
>>>        aic->check_sram = true;
>>>        aic->has_dma = true;
>>> +    aic->mem_size = 0x1000;
>>>    }
>>>
>>>    static const TypeInfo aspeed_2500_i2c_info = { @@ -1353,6 +1355,7 @@
>>> static void aspeed_2600_i2c_class_init(ObjectClass *klass, void *data)
>>>        aic->pool_base = 0xC00;
>>>        aic->bus_pool_base = aspeed_2600_i2c_bus_pool_base;
>>>        aic->has_dma = true;
>>> +    aic->mem_size = 0x1000;
>>>    }
>>>
>>>    static const TypeInfo aspeed_2600_i2c_info = { @@ -1376,6 +1379,7 @@
>>> static void aspeed_1030_i2c_class_init(ObjectClass *klass, void *data)
>>>        aic->pool_base = 0xC00;
>>>        aic->bus_pool_base = aspeed_2600_i2c_bus_pool_base;
>>>        aic->has_dma = true;
>>> +    aic->mem_size = 0x10000;
>>
> Thanks for review.
> 
> According to the datasheet of AST1030 in chapter 7 (Memory Space Allocation Table)
> , the register address space of I2C Controller range is start from 7E7B0000 to
> 7E7BFFFF and its register address space is 64KB(0x10000).

OK.
  
> The firmware only use 4KB address space. We can change mem_size either 4KB or 64KB.
> Could you tell me which size you prefer?

I would keep the larger value for the model and let FW decide to resize or not.

Thanks,

C.







