Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D8274A72A
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 00:45:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHXh8-00050d-CO; Thu, 06 Jul 2023 18:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qHXh1-00050A-32; Thu, 06 Jul 2023 18:43:19 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qHXgy-00024d-CY; Thu, 06 Jul 2023 18:43:18 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id BB3B674635C;
 Fri,  7 Jul 2023 00:42:53 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0D403746335; Fri,  7 Jul 2023 00:42:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 09F4F745720;
 Fri,  7 Jul 2023 00:42:53 +0200 (CEST)
Date: Fri, 7 Jul 2023 00:42:53 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, philmd@linaro.org
Subject: Re: [RESEND PATCH v3 2/4] ppc4xx_pci: Rename QOM type name define
In-Reply-To: <a5716042-3cc0-2cb4-d35e-d29377bdf8d5@gmail.com>
Message-ID: <e63b12e7-d8e1-8ae4-225c-0c2c73ab1b57@eik.bme.hu>
References: <cover.1688641673.git.balaton@eik.bme.hu>
 <c59c28ef440633dbd1de0bda0a93b7862ef91104.1688641673.git.balaton@eik.bme.hu>
 <a5716042-3cc0-2cb4-d35e-d29377bdf8d5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 6 Jul 2023, Daniel Henrique Barboza wrote:
> On 7/6/23 08:16, BALATON Zoltan wrote:
>> Rename the TYPE_PPC4xx_PCI_HOST_BRIDGE define and its string value to
>> match each other and other similar types and to avoid confusion with
>> "ppc4xx-host-bridge" type defined in same file.
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>
> I struggled a bit to understand what's to gain with this change, but it makes
> more sense when we consider the changes made in the next patch (where a
> TYPE_PPC4xx_HOST_BRIDGE macro is introduced to match the "ppc4xx-host-bridge"
> name).
>
> I also understand the comments Phil made in version 1. We have several 
> QOM names that are too similar ("ppc4xx-pci-host", "ppc4xx-host-bridge" 
> in the next patch, "ppc440-pcix-host" in patch 4), all of them being PCI 
> host bridges. I am uncertain whether renaming the QOM name of these 
> devices to make them less similar is worth it.

These SoCs have slighlty different PCI hosts in them. I think it may 
started with a simple PCI controller in 405 then a PCIX controller in 440 
and finally PCIe controllers in addition to PCIX in 460EX (although there 
also exists a 405EX so later these were just mix and matched in different 
SoCs). These all work slightly differently but are also similar in some 
ways as likely these were designed based on the previous one. Also 
modeling them was probebly done independently and only partially so we 
ended up with these devices. Maybe at one point we can clean it up and 
refactor these but at least for the PCIe controller I could not find any 
docs so it's not easy to find out how could these be rationalised.

> Matching the macro names with the actual QOM name is a step in the right 
> direction though.

Originally I wanted to improve PCIe emulation for sam460ex but I could not 
yet make that work (missing some details on how it should work without 
docs) so for now only these clean ups came out of that which should be 
steps forward but not all the way there yet. I try to continue when I will 
have time for it again sometimes but I think these at least should clean 
it up this a bit and we can then continue from here.

> Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>

Thanks, Regards,
BALATON Zoltan


>>   hw/ppc/ppc440_bamboo.c  | 3 +--
>>   hw/ppc/ppc4xx_pci.c     | 6 +++---
>>   include/hw/ppc/ppc4xx.h | 2 +-
>>   3 files changed, 5 insertions(+), 6 deletions(-)
>> 
>> diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
>> index f061b8cf3b..45f409c838 100644
>> --- a/hw/ppc/ppc440_bamboo.c
>> +++ b/hw/ppc/ppc440_bamboo.c
>> @@ -205,8 +205,7 @@ static void bamboo_init(MachineState *machine)
>>       ppc4xx_sdram_ddr_enable(PPC4xx_SDRAM_DDR(dev));
>>         /* PCI */
>> -    dev = sysbus_create_varargs(TYPE_PPC4xx_PCI_HOST_BRIDGE,
>> -                                PPC440EP_PCI_CONFIG,
>> +    dev = sysbus_create_varargs(TYPE_PPC4xx_PCI_HOST, PPC440EP_PCI_CONFIG,
>>                                   qdev_get_gpio_in(uicdev, pci_irq_nrs[0]),
>>                                   qdev_get_gpio_in(uicdev, pci_irq_nrs[1]),
>>                                   qdev_get_gpio_in(uicdev, pci_irq_nrs[2]),
>> diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
>> index 1d4a50fa7c..fbdf8266d8 100644
>> --- a/hw/ppc/ppc4xx_pci.c
>> +++ b/hw/ppc/ppc4xx_pci.c
>> @@ -46,7 +46,7 @@ struct PCITargetMap {
>>       uint32_t la;
>>   };
>>   -OBJECT_DECLARE_SIMPLE_TYPE(PPC4xxPCIState, PPC4xx_PCI_HOST_BRIDGE)
>> +OBJECT_DECLARE_SIMPLE_TYPE(PPC4xxPCIState, PPC4xx_PCI_HOST)
>>     #define PPC4xx_PCI_NR_PMMS 3
>>   #define PPC4xx_PCI_NR_PTMS 2
>> @@ -321,7 +321,7 @@ static void ppc4xx_pcihost_realize(DeviceState *dev, 
>> Error **errp)
>>       int i;
>>         h = PCI_HOST_BRIDGE(dev);
>> -    s = PPC4xx_PCI_HOST_BRIDGE(dev);
>> +    s = PPC4xx_PCI_HOST(dev);
>>         for (i = 0; i < ARRAY_SIZE(s->irq); i++) {
>>           sysbus_init_irq(sbd, &s->irq[i]);
>> @@ -386,7 +386,7 @@ static void ppc4xx_pcihost_class_init(ObjectClass 
>> *klass, void *data)
>>   }
>>     static const TypeInfo ppc4xx_pcihost_info = {
>> -    .name          = TYPE_PPC4xx_PCI_HOST_BRIDGE,
>> +    .name          = TYPE_PPC4xx_PCI_HOST,
>>       .parent        = TYPE_PCI_HOST_BRIDGE,
>>       .instance_size = sizeof(PPC4xxPCIState),
>>       .class_init    = ppc4xx_pcihost_class_init,
>> diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
>> index 39ca602442..e053b9751b 100644
>> --- a/include/hw/ppc/ppc4xx.h
>> +++ b/include/hw/ppc/ppc4xx.h
>> @@ -29,7 +29,7 @@
>>   #include "exec/memory.h"
>>   #include "hw/sysbus.h"
>>   -#define TYPE_PPC4xx_PCI_HOST_BRIDGE "ppc4xx-pcihost"
>> +#define TYPE_PPC4xx_PCI_HOST "ppc4xx-pci-host"
>>   #define TYPE_PPC460EX_PCIE_HOST "ppc460ex-pcie-host"
>>     /*
>
>

