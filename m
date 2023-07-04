Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80428746DBF
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 11:38:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGcU0-0003bu-Qf; Tue, 04 Jul 2023 05:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qGcTy-0003bh-U3; Tue, 04 Jul 2023 05:38:02 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qGcTx-0007q1-D7; Tue, 04 Jul 2023 05:38:02 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 31BDC74635C;
 Tue,  4 Jul 2023 11:37:44 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id ACE70746335; Tue,  4 Jul 2023 11:37:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id ABE2A745720;
 Tue,  4 Jul 2023 11:37:43 +0200 (CEST)
Date: Tue, 4 Jul 2023 11:37:43 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 12/13] ppc440_pcix: Don't use iomem for regs
In-Reply-To: <01cd4046-1f7e-beb5-d999-84db6ae23d3e@linaro.org>
Message-ID: <bc068e12-9a87-23fa-e39e-dd28a233a5b3@eik.bme.hu>
References: <cover.1688421085.git.balaton@eik.bme.hu>
 <576b54159060392c8bc12a63c665928053b58f24.1688421085.git.balaton@eik.bme.hu>
 <01cd4046-1f7e-beb5-d999-84db6ae23d3e@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-303919976-1688463463=:43117"
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

--3866299591-303919976-1688463463=:43117
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 4 Jul 2023, Philippe Mathieu-Daudé wrote:
> On 4/7/23 00:02, BALATON Zoltan wrote:
>> The iomem memory region is better used for the PCI IO space but
>> currently used for registers. Stop using it for that to allow this to
>> be cleaned up in the next patch.
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/ppc/ppc440_pcix.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>> 
>> diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
>> index adfecf1e76..ee2dc44f67 100644
>> --- a/hw/ppc/ppc440_pcix.c
>> +++ b/hw/ppc/ppc440_pcix.c
>> @@ -484,6 +484,7 @@ static void ppc440_pcix_realize(DeviceState *dev, Error 
>> **errp)
>>       SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>>       PPC440PCIXState *s;
>>       PCIHostState *h;
>> +    MemoryRegion *regs = g_new(MemoryRegion, 1);
>
> Why not hold it within PPC440PCIXState?

Because it's never needed after this function.

Regards,
BALATON Zoltan

>>       h = PCI_HOST_BRIDGE(dev);
>>       s = PPC440_PCIX_HOST(dev);
>> @@ -507,11 +508,11 @@ static void ppc440_pcix_realize(DeviceState *dev, 
>> Error **errp)
>>                             h, "pci-conf-idx", 4);
>>       memory_region_init_io(&h->data_mem, OBJECT(s), &pci_host_data_le_ops,
>>                             h, "pci-conf-data", 4);
>> -    memory_region_init_io(&s->iomem, OBJECT(s), &pci_reg_ops, s,
>> -                          "pci.reg", PPC440_REG_SIZE);
>> +    memory_region_init_io(regs, OBJECT(s), &pci_reg_ops, s, "pci-reg",
>> +                          PPC440_REG_SIZE);
>>       memory_region_add_subregion(&s->container, PCIC0_CFGADDR, 
>> &h->conf_mem);
>>       memory_region_add_subregion(&s->container, PCIC0_CFGDATA, 
>> &h->data_mem);
>> -    memory_region_add_subregion(&s->container, PPC440_REG_BASE, 
>> &s->iomem);
>> +    memory_region_add_subregion(&s->container, PPC440_REG_BASE, regs);
>>       sysbus_init_mmio(sbd, &s->container);
>>   }
>> 
>
>
>
--3866299591-303919976-1688463463=:43117--

