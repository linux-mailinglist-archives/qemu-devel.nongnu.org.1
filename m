Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E5A7424A3
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 13:05:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEpSH-0006LX-E5; Thu, 29 Jun 2023 07:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=1kQ5=CR=kaod.org=clg@ozlabs.org>)
 id 1qEpSG-0006LA-1l; Thu, 29 Jun 2023 07:04:52 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=1kQ5=CR=kaod.org=clg@ozlabs.org>)
 id 1qEpSD-0001kw-Fj; Thu, 29 Jun 2023 07:04:51 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QsFvv3LWqz4wbg;
 Thu, 29 Jun 2023 21:04:43 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QsFvt0LVjz4wbP;
 Thu, 29 Jun 2023 21:04:39 +1000 (AEST)
Message-ID: <a5d1c249-1922-d4b3-6249-d591f10a251f@kaod.org>
Date: Thu, 29 Jun 2023 13:04:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mv64361: Add dummy gigabit ethernet PHY access registers
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20230605215145.29458746335@zero.eik.bme.hu>
 <a56d91b8-696f-a56e-904d-cda8a2ec3a16@eik.bme.hu>
 <c1bcb719-bede-45d0-c8ca-7362be78bce6@eik.bme.hu>
 <2182bdfb-785d-88c0-51ff-e4c0a9eb4de6@eik.bme.hu>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <2182bdfb-785d-88c0-51ff-e4c0a9eb4de6@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=1kQ5=CR=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/29/23 10:36, BALATON Zoltan wrote:
> On Wed, 21 Jun 2023, BALATON Zoltan wrote:
>> On Wed, 14 Jun 2023, BALATON Zoltan wrote:
>>> On Mon, 5 Jun 2023, BALATON Zoltan wrote:
>>>> We don't emulate the gigabit ethernet part of the chip but the MorphOS
>>>> driver accesses these and expects to get some valid looking result
>>>> otherwise it hangs. Add some minimal dummy implementation to avoid rhis.
>>>>
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> ---
>>>> This is only used by MorphOS on pegasos2 so most likely could go via
>>>> the ppc queue.
>>>
>>> Ping?
>>
>> Ping?
> 
> Ping?
> https://patchew.org/QEMU/20230605215145.29458746335@zero.eik.bme.hu/
> It's unlikely this will get a review so can you please just merge it? It's my code so if I break it I'll fix it but this was tested a bit and no problem reported so far.

Acked-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.

> 
> Regards,
> BALATON Zoltan
> 
>>>> hw/pci-host/mv64361.c | 6 ++++++
>>>> hw/pci-host/mv643xx.h | 3 +++
>>>> 2 files changed, 9 insertions(+)
>>>>
>>>> diff --git a/hw/pci-host/mv64361.c b/hw/pci-host/mv64361.c
>>>> index 19e8031a3f..01bd8c887f 100644
>>>> --- a/hw/pci-host/mv64361.c
>>>> +++ b/hw/pci-host/mv64361.c
>>>> @@ -541,6 +541,12 @@ static uint64_t mv64361_read(void *opaque, hwaddr addr, unsigned int size)
>>>>             }
>>>>         }
>>>>         break;
>>>> +    case MV64340_ETH_PHY_ADDR:
>>>> +        ret = 0x98;
>>>> +        break;
>>>> +    case MV64340_ETH_SMI:
>>>> +        ret = BIT(27);
>>>> +        break;
>>>>     case MV64340_CUNIT_ARBITER_CONTROL_REG:
>>>>         ret = 0x11ff0000 | (s->gpp_int_level << 10);
>>>>         break;
>>>> diff --git a/hw/pci-host/mv643xx.h b/hw/pci-host/mv643xx.h
>>>> index cd26a43f18..f2e1baea88 100644
>>>> --- a/hw/pci-host/mv643xx.h
>>>> +++ b/hw/pci-host/mv643xx.h
>>>> @@ -656,6 +656,9 @@
>>>> /*        Ethernet Unit Registers       */
>>>> /****************************************/
>>>>
>>>> +#define MV64340_ETH_PHY_ADDR 0x2000
>>>> +#define MV64340_ETH_SMI 0x2004
>>>> +
>>>> /*******************************************/
>>>> /*          CUNIT  Registers               */
>>>> /*******************************************/
>>>>
>>>
>>>
>>
>>


