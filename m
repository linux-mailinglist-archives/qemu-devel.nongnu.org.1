Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8989BA3F6C9
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Feb 2025 15:06:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlTez-0001zp-Mz; Fri, 21 Feb 2025 09:05:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ENLZ=VM=kaod.org=clg@ozlabs.org>)
 id 1tlTeT-0001U2-2i; Fri, 21 Feb 2025 09:05:14 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ENLZ=VM=kaod.org=clg@ozlabs.org>)
 id 1tlTeP-0002xz-55; Fri, 21 Feb 2025 09:05:12 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4YzsMg1qTRz4wy6;
 Sat, 22 Feb 2025 01:05:03 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4YzsMb4zdMz4wby;
 Sat, 22 Feb 2025 01:04:59 +1100 (AEDT)
Message-ID: <de3c13e9-f0e0-4c4b-8a31-457c84628119@kaod.org>
Date: Fri, 21 Feb 2025 15:04:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/28] hw/arm/aspeed: Rename IRQ table and machine name
 for AST2700 A0
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20250213033531.3367697-1-jamin_lin@aspeedtech.com>
 <20250213033531.3367697-5-jamin_lin@aspeedtech.com>
 <f3dd3423-8f6d-48ce-80f2-3381550948b7@kaod.org>
 <SI2PR06MB50418E5359B59E7902B84A05FCC72@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <SI2PR06MB50418E5359B59E7902B84A05FCC72@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=ENLZ=VM=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 2/21/25 03:23, Jamin Lin wrote:
> Hi Cedric,
> 
>> Cc: Troy Lee <troy_lee@aspeedtech.com>
>> Subject: Re: [PATCH v3 04/28] hw/arm/aspeed: Rename IRQ table and machine
>> name for AST2700 A0
>>
>> On 2/13/25 04:35, Jamin Lin wrote:
>>> Currently, AST2700 SoC only supports A0. To support AST2700 A1, rename
>>> its IRQ table and machine name.
>>>
>>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>>> ---
>>>    hw/arm/aspeed.c         | 8 ++++----
>>>    hw/arm/aspeed_ast27x0.c | 8 ++++----
>>>    2 files changed, 8 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c index
>>> d9418e2b9f..6ddfdbdeba 100644
>>> --- a/hw/arm/aspeed.c
>>> +++ b/hw/arm/aspeed.c
>>> @@ -1654,12 +1654,12 @@ static void
>> ast2700_evb_i2c_init(AspeedMachineState *bmc)
>>>                                TYPE_TMP105, 0x4d);
>>>    }
>>>
>>> -static void aspeed_machine_ast2700_evb_class_init(ObjectClass *oc,
>>> void *data)
>>> +static void aspeed_machine_ast2700a0_evb_class_init(ObjectClass *oc,
>>> +void *data)
>>>    {
>>>        MachineClass *mc = MACHINE_CLASS(oc);
>>>        AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
>>>
>>> -    mc->desc = "Aspeed AST2700 EVB (Cortex-A35)";
>>> +    mc->desc = "Aspeed AST2700 A0 EVB (Cortex-A35)";
>>>        amc->soc_name  = "ast2700-a0";
>>>        amc->hw_strap1 = AST2700_EVB_HW_STRAP1;
>>>        amc->hw_strap2 = AST2700_EVB_HW_STRAP2; @@ -1795,9 +1795,9
>> @@
>>> static const TypeInfo aspeed_machine_types[] = {
>>>            .class_init     =
>> aspeed_minibmc_machine_ast1030_evb_class_init,
>>>    #ifdef TARGET_AARCH64
>>>        }, {
>>> -        .name          = MACHINE_TYPE_NAME("ast2700-evb"),
>>> +        .name          = MACHINE_TYPE_NAME("ast2700a0-evb"),
>>
>> machine "ast2700-evb" has now disappeared from QEMU. You need to add an
>> alias with "mc->alias" to restore the initial machine name, or follow the
> 
> 
> Will add
> 
>> deprecation process :
>>
>>     https://qemu.readthedocs.io/en/v9.2.0/about/deprecated.html
>>
> Thanks for letting me know about the machine deprecation rules.
> I understand why you suggest aliasing the initial machine "ast2700-evb" to "ast2700a0-evb."

yes. This to maintain compatibility for the user.

Also, this change is breaking the tests. Please run 'make check'
  
> To follow the machine deprecation rule, the initial machine "ast2700-evb" is aliased to "ast2700a0-evb."

You don't need the alias to deprecate a machine. You need the alias
to maintain compatibility when renaming a machine.

To deprecate, you should update docs/about/deprecated.rst.

> In the future, we will alias "ast2700-evb" to new SoCs, such as "ast2700a1-evb."

Yes we could do that.

Or we could keep the ast2700a0-evb and ast2700a1-evb machines,
change the alias to point to ast2700a1-evb first and later on
deprecate ast2700a0-evb.


Thanks,

C.



> Does this progress meet your expectations?
> 
> Thanks-Jamin
> 
>> Thanks,
>>
>> C.
>>
>>
>>
>>>            .parent        = TYPE_ASPEED_MACHINE,
>>> -        .class_init    = aspeed_machine_ast2700_evb_class_init,
>>> +        .class_init    = aspeed_machine_ast2700a0_evb_class_init,
>>>    #endif
>>>        }, {
>>>            .name          = TYPE_ASPEED_MACHINE,
>>> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c index
>>> 2d0c99f159..6e3375f5d3 100644
>>> --- a/hw/arm/aspeed_ast27x0.c
>>> +++ b/hw/arm/aspeed_ast27x0.c
>>> @@ -72,7 +72,7 @@ static const hwaddr aspeed_soc_ast2700_memmap[] =
>> {
>>>    #define AST2700_MAX_IRQ 256
>>>
>>>    /* Shared Peripheral Interrupt values below are offset by -32 from
>>> datasheet */ -static const int aspeed_soc_ast2700_irqmap[] = {
>>> +static const int aspeed_soc_ast2700a0_irqmap[] = {
>>>        [ASPEED_DEV_UART0]     = 132,
>>>        [ASPEED_DEV_UART1]     = 132,
>>>        [ASPEED_DEV_UART2]     = 132,
>>> @@ -740,7 +740,7 @@ static void aspeed_soc_ast2700_realize(DeviceState
>> *dev, Error **errp)
>>>        create_unimplemented_device("ast2700.io", 0x0, 0x4000000);
>>>    }
>>>
>>> -static void aspeed_soc_ast2700_class_init(ObjectClass *oc, void
>>> *data)
>>> +static void aspeed_soc_ast2700a0_class_init(ObjectClass *oc, void
>>> +*data)
>>>    {
>>>        static const char * const valid_cpu_types[] = {
>>>            ARM_CPU_TYPE_NAME("cortex-a35"), @@ -763,7 +763,7 @@
>> static
>>> void aspeed_soc_ast2700_class_init(ObjectClass *oc, void *data)
>>>        sc->uarts_num    = 13;
>>>        sc->num_cpus     = 4;
>>>        sc->uarts_base   = ASPEED_DEV_UART0;
>>> -    sc->irqmap       = aspeed_soc_ast2700_irqmap;
>>> +    sc->irqmap       = aspeed_soc_ast2700a0_irqmap;
>>>        sc->memmap       = aspeed_soc_ast2700_memmap;
>>>        sc->get_irq      = aspeed_soc_ast2700_get_irq;
>>>    }
>>> @@ -778,7 +778,7 @@ static const TypeInfo aspeed_soc_ast27x0_types[] = {
>>>            .name           = "ast2700-a0",
>>>            .parent         = TYPE_ASPEED27X0_SOC,
>>>            .instance_init  = aspeed_soc_ast2700_init,
>>> -        .class_init     = aspeed_soc_ast2700_class_init,
>>> +        .class_init     = aspeed_soc_ast2700a0_class_init,
>>>        },
>>>    };
>>>
> 


