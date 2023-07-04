Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF6F746DB9
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 11:37:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGcT6-0002td-CQ; Tue, 04 Jul 2023 05:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qGcT1-0002tH-Vn; Tue, 04 Jul 2023 05:37:04 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qGcT0-0007hs-C9; Tue, 04 Jul 2023 05:37:03 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 30958746335;
 Tue,  4 Jul 2023 11:36:45 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id ED15474632B; Tue,  4 Jul 2023 11:36:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EBE92746361;
 Tue,  4 Jul 2023 11:36:44 +0200 (CEST)
Date: Tue, 4 Jul 2023 11:36:44 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 10/13] ppc4xx_pci: Add define for ppc4xx-host-bridge type
 name
In-Reply-To: <9058d248-1fe5-f47b-30ab-0ef3bcbef5cf@linaro.org>
Message-ID: <e8a1f4b6-ad2e-bae2-bc45-8b075694f810@eik.bme.hu>
References: <cover.1688421085.git.balaton@eik.bme.hu>
 <eecc7ae1c5f576f74c1b919e8d7f798fc8a7e6ac.1688421085.git.balaton@eik.bme.hu>
 <9058d248-1fe5-f47b-30ab-0ef3bcbef5cf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1503393403-1688463404=:43117"
X-Spam-Probability: 9%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1503393403-1688463404=:43117
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 4 Jul 2023, Philippe Mathieu-Daudé wrote:
> On 4/7/23 00:02, BALATON Zoltan wrote:
>> Add a QOM type name define for ppc4xx-host-bridge in the common header
>> and replace direct use of the string name with the constant.
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/ppc/ppc440_pcix.c    | 3 ++-
>>   hw/ppc/ppc4xx_pci.c     | 4 ++--
>>   include/hw/ppc/ppc4xx.h | 1 +
>>   3 files changed, 5 insertions(+), 3 deletions(-)
>> 
>> diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
>> index f10f93c533..dfec25ac83 100644
>> --- a/hw/ppc/ppc440_pcix.c
>> +++ b/hw/ppc/ppc440_pcix.c
>> @@ -495,7 +495,8 @@ static void ppc440_pcix_realize(DeviceState *dev, Error 
>> **errp)
>>                            ppc440_pcix_map_irq, &s->irq, &s->busmem,
>>                            get_system_io(), PCI_DEVFN(0, 0), 1, 
>> TYPE_PCI_BUS);
>>   -    s->dev = pci_create_simple(h->bus, PCI_DEVFN(0, 0), 
>> "ppc4xx-host-bridge");
>> +    s->dev = pci_create_simple(h->bus, PCI_DEVFN(0, 0),
>> +                               TYPE_PPC4xx_HOST_BRIDGE);
>>         memory_region_init(&s->bm, OBJECT(s), "bm-ppc440-pcix", 
>> UINT64_MAX);
>>       memory_region_add_subregion(&s->bm, 0x0, &s->busmem);
>> diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
>> index fbdf8266d8..6652119008 100644
>> --- a/hw/ppc/ppc4xx_pci.c
>> +++ b/hw/ppc/ppc4xx_pci.c
>> @@ -333,7 +333,7 @@ static void ppc4xx_pcihost_realize(DeviceState *dev, 
>> Error **errp)
>>                                 TYPE_PCI_BUS);
>>       h->bus = b;
>>   -    pci_create_simple(b, 0, "ppc4xx-host-bridge");
>> +    pci_create_simple(b, 0, TYPE_PPC4xx_HOST_BRIDGE);
>>         /* XXX split into 2 memory regions, one for config space, one for 
>> regs */
>>       memory_region_init(&s->container, OBJECT(s), "pci-container", 
>> PCI_ALL_SIZE);
>> @@ -367,7 +367,7 @@ static void ppc4xx_host_bridge_class_init(ObjectClass 
>> *klass, void *data)
>>   }
>>     static const TypeInfo ppc4xx_host_bridge_info = {
>> -    .name          = "ppc4xx-host-bridge",
>> +    .name          = TYPE_PPC4xx_HOST_BRIDGE,
>>       .parent        = TYPE_PCI_DEVICE,
>>       .instance_size = sizeof(PCIDevice),
>>       .class_init    = ppc4xx_host_bridge_class_init,
>> diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
>> index e053b9751b..766d575e86 100644
>> --- a/include/hw/ppc/ppc4xx.h
>> +++ b/include/hw/ppc/ppc4xx.h
>> @@ -29,6 +29,7 @@
>>   #include "exec/memory.h"
>>   #include "hw/sysbus.h"
>>   +#define TYPE_PPC4xx_HOST_BRIDGE "ppc4xx-host-bridge"
>
> This is the function #0 of the host bridge, maybe:
>
> #define TYPE_PPC4xx_HOST_BRIDGE_FN0 "ppc4xx-pci-host-bridge-fn0"

That's way too long so I'd drop bridge from all of these and maybe name 
this ppc4xx-pci-host-fn0 or ppc4xx-pci-host-func (there are no other 
functions of the bridge so this shows this is the PCI side of it). I'd 
still go for shorted defines and not changing the string types too much. 
Would that be acceptable?

Regards,
BALATON Zoltan

>>   #define TYPE_PPC4xx_PCI_HOST "ppc4xx-pci-host"
>>   #define TYPE_PPC460EX_PCIE_HOST "ppc460ex-pcie-host"
>> 
>
>
>
--3866299591-1503393403-1688463404=:43117--

