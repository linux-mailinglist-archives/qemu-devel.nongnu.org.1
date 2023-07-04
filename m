Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B079746DFC
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 11:50:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGceu-0006po-KI; Tue, 04 Jul 2023 05:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qGcer-0006pY-LU; Tue, 04 Jul 2023 05:49:17 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qGcep-0001xb-Fd; Tue, 04 Jul 2023 05:49:17 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id C8F26746361;
 Tue,  4 Jul 2023 11:48:52 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 936C674632B; Tue,  4 Jul 2023 11:48:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 91D5B74633D;
 Tue,  4 Jul 2023 11:48:52 +0200 (CEST)
Date: Tue, 4 Jul 2023 11:48:52 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 05/13] ppc440: Stop using system io region for PCIe buses
In-Reply-To: <5cea0f52-32d1-afbb-9845-b7bc41222470@linaro.org>
Message-ID: <0a3422ad-67c7-6088-3ec8-c8fed90ea988@eik.bme.hu>
References: <cover.1688421085.git.balaton@eik.bme.hu>
 <2d1159457cd395dafbc5de3c4b4e3c5137af5e1a.1688421085.git.balaton@eik.bme.hu>
 <5cea0f52-32d1-afbb-9845-b7bc41222470@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-661284354-1688464132=:43117"
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

--3866299591-661284354-1688464132=:43117
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 4 Jul 2023, Philippe Mathieu-Daudé wrote:
> On 4/7/23 00:02, BALATON Zoltan wrote:
>> Add separate memory regions for the mem and io spaces of the PCIe bus
>> to avoid different buses using the same system io region.
>
> "Reduce the I/O space to 64K."

Unlike the other similar patch this does not reduce the IO space size 
because get_system_io() was that size already. I've changed the size below 
to use KiB.

Regards,
BALATON Zoltan

>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/ppc/ppc440_uc.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>> 
>> diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
>> index 38ee27f437..0c5d999878 100644
>> --- a/hw/ppc/ppc440_uc.c
>> +++ b/hw/ppc/ppc440_uc.c
>> @@ -776,6 +776,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(PPC460EXPCIEState, 
>> PPC460EX_PCIE_HOST)
>>   struct PPC460EXPCIEState {
>>       PCIExpressHost host;
>>   +    MemoryRegion busmem;
>>       MemoryRegion iomem;
>>       qemu_irq irq[4];
>>       int32_t dcrn_base;
>> @@ -1056,15 +1057,17 @@ static void ppc460ex_pcie_realize(DeviceState *dev, 
>> Error **errp)
>>           error_setg(errp, "invalid PCIe DCRN base");
>>           return;
>>       }
>> +    snprintf(buf, sizeof(buf), "pcie%d-mem", id);
>> +    memory_region_init(&s->busmem, OBJECT(s), buf, UINT64_MAX);
>>       snprintf(buf, sizeof(buf), "pcie%d-io", id);
>> -    memory_region_init(&s->iomem, OBJECT(s), buf, UINT64_MAX);
>> +    memory_region_init(&s->iomem, OBJECT(s), buf, 0x10000);
>
> 64 * KiB
>
>>       for (i = 0; i < 4; i++) {
>>           sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[i]);
>>       }
>>       snprintf(buf, sizeof(buf), "pcie.%d", id);
>>       pci->bus = pci_register_root_bus(DEVICE(s), buf, ppc460ex_set_irq,
>> -                                pci_swizzle_map_irq_fn, s, &s->iomem,
>> -                                get_system_io(), 0, 4, TYPE_PCIE_BUS);
>> +                                pci_swizzle_map_irq_fn, s, &s->busmem,
>> +                                &s->iomem, 0, 4, TYPE_PCIE_BUS);
>>       ppc460ex_pcie_register_dcrs(s);
>>   }
>> 
>
> With the changes addressed:
>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>
>
>
--3866299591-661284354-1688464132=:43117--

