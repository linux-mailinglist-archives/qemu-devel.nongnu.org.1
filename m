Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A1A742248
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 10:37:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEn95-0005nx-0k; Thu, 29 Jun 2023 04:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qEn8q-0005mm-AA; Thu, 29 Jun 2023 04:36:40 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qEn8m-0007Od-5E; Thu, 29 Jun 2023 04:36:39 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id E7F05746361;
 Thu, 29 Jun 2023 10:36:08 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B3E7774632B; Thu, 29 Jun 2023 10:36:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B1392745720;
 Thu, 29 Jun 2023 10:36:08 +0200 (CEST)
Date: Thu, 29 Jun 2023 10:36:08 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
cc: Daniel Henrique Barboza <danielhb413@gmail.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>
Subject: Re: [PATCH] mv64361: Add dummy gigabit ethernet PHY access registers
In-Reply-To: <c1bcb719-bede-45d0-c8ca-7362be78bce6@eik.bme.hu>
Message-ID: <2182bdfb-785d-88c0-51ff-e4c0a9eb4de6@eik.bme.hu>
References: <20230605215145.29458746335@zero.eik.bme.hu>
 <a56d91b8-696f-a56e-904d-cda8a2ec3a16@eik.bme.hu>
 <c1bcb719-bede-45d0-c8ca-7362be78bce6@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Wed, 21 Jun 2023, BALATON Zoltan wrote:
> On Wed, 14 Jun 2023, BALATON Zoltan wrote:
>> On Mon, 5 Jun 2023, BALATON Zoltan wrote:
>>> We don't emulate the gigabit ethernet part of the chip but the MorphOS
>>> driver accesses these and expects to get some valid looking result
>>> otherwise it hangs. Add some minimal dummy implementation to avoid rhis.
>>> 
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>> This is only used by MorphOS on pegasos2 so most likely could go via
>>> the ppc queue.
>> 
>> Ping?
>
> Ping?

Ping?
https://patchew.org/QEMU/20230605215145.29458746335@zero.eik.bme.hu/
It's unlikely this will get a review so can you please just merge it? It's 
my code so if I break it I'll fix it but this was tested a bit and no 
problem reported so far.

Regards,
BALATON Zoltan

>>> hw/pci-host/mv64361.c | 6 ++++++
>>> hw/pci-host/mv643xx.h | 3 +++
>>> 2 files changed, 9 insertions(+)
>>> 
>>> diff --git a/hw/pci-host/mv64361.c b/hw/pci-host/mv64361.c
>>> index 19e8031a3f..01bd8c887f 100644
>>> --- a/hw/pci-host/mv64361.c
>>> +++ b/hw/pci-host/mv64361.c
>>> @@ -541,6 +541,12 @@ static uint64_t mv64361_read(void *opaque, hwaddr 
>>> addr, unsigned int size)
>>>             }
>>>         }
>>>         break;
>>> +    case MV64340_ETH_PHY_ADDR:
>>> +        ret = 0x98;
>>> +        break;
>>> +    case MV64340_ETH_SMI:
>>> +        ret = BIT(27);
>>> +        break;
>>>     case MV64340_CUNIT_ARBITER_CONTROL_REG:
>>>         ret = 0x11ff0000 | (s->gpp_int_level << 10);
>>>         break;
>>> diff --git a/hw/pci-host/mv643xx.h b/hw/pci-host/mv643xx.h
>>> index cd26a43f18..f2e1baea88 100644
>>> --- a/hw/pci-host/mv643xx.h
>>> +++ b/hw/pci-host/mv643xx.h
>>> @@ -656,6 +656,9 @@
>>> /*        Ethernet Unit Registers       */
>>> /****************************************/
>>> 
>>> +#define MV64340_ETH_PHY_ADDR 
>>> 0x2000
>>> +#define MV64340_ETH_SMI 
>>> 0x2004
>>> +
>>> /*******************************************/
>>> /*          CUNIT  Registers               */
>>> /*******************************************/
>>> 
>> 
>> 
>
>

