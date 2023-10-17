Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 131AB7CCDD4
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 22:23:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsqaT-0003Ro-TT; Tue, 17 Oct 2023 16:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qsqaN-0003Jo-6Z
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 16:22:39 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qsqaK-0008C8-Ge
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 16:22:38 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 2CD0274632B;
 Tue, 17 Oct 2023 22:21:24 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E0B407456AA; Tue, 17 Oct 2023 22:21:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DEC1B745681;
 Tue, 17 Oct 2023 22:21:23 +0200 (CEST)
Date: Tue, 17 Oct 2023 22:21:23 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Helge Deller <deller@gmx.de>
cc: deller@kernel.org, qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 02/11] pci_ids/tulip: Add PCI vendor ID for HP and
 use it in tulip
In-Reply-To: <e939ce05-387e-4952-beba-84d566fff0c0@gmx.de>
Message-ID: <dc2f4220-78b1-4555-897c-3c91cf1d933f@eik.bme.hu>
References: <20231017154645.95844-1-deller@kernel.org>
 <20231017154645.95844-3-deller@kernel.org>
 <df5da806-4b08-5034-1b80-93d583efd86b@eik.bme.hu>
 <3425e5f9-f2d4-428b-96d2-5e0760871837@gmx.de>
 <5e17898a-c70c-4f79-9bd8-fc20a6179b42@eik.bme.hu>
 <e939ce05-387e-4952-beba-84d566fff0c0@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1146477983-1697574083=:50058"
X-Spam-Probability: 9%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--3866299591-1146477983-1697574083=:50058
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 17 Oct 2023, Helge Deller wrote:
> On 10/17/23 21:19, BALATON Zoltan wrote:
>> On Tue, 17 Oct 2023, Helge Deller wrote:
>>> On 10/17/23 18:13, BALATON Zoltan wrote:
>>>> On Tue, 17 Oct 2023, deller@kernel.org wrote:
>>>>> From: Helge Deller <deller@gmx.de>
>>>>> 
>>>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>>>> ---
>>>>> hw/net/tulip.c           | 2 +-
>>>>> include/hw/pci/pci_ids.h | 2 ++
>>>>> 2 files changed, 3 insertions(+), 1 deletion(-)
>>>>> 
>>>>> diff --git a/hw/net/tulip.c b/hw/net/tulip.c
>>>>> index 915e5fb595..11d866e431 100644
>>>>> --- a/hw/net/tulip.c
>>>>> +++ b/hw/net/tulip.c
>>>>> @@ -1020,7 +1020,7 @@ static void tulip_class_init(ObjectClass *klass, 
>>>>> void *data)
>>>>>     k->exit = pci_tulip_exit;
>>>>>     k->vendor_id = PCI_VENDOR_ID_DEC;
>>>>>     k->device_id = PCI_DEVICE_ID_DEC_21143;
>>>>> -    k->subsystem_vendor_id = 0x103c;
>>>>> +    k->subsystem_vendor_id = PCI_VENDOR_ID_HP;
>>>>>     k->subsystem_id = 0x104f;
>>>>>     k->class_id = PCI_CLASS_NETWORK_ETHERNET;
>>>>>     dc->vmsd = &vmstate_pci_tulip;
>>>>> diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
>>>>> index 85469b9b53..3c0e72df0e 100644
>>>>> --- a/include/hw/pci/pci_ids.h
>>>>> +++ b/include/hw/pci/pci_ids.h
>>>>> @@ -171,6 +171,8 @@
>>>>> #define PCI_VENDOR_ID_DEC                0x1011
>>>>> #define PCI_DEVICE_ID_DEC_21143          0x0019
>>>>> 
>>>>> +#define PCI_VENDOR_ID_HP                 0x103c
>>>>> +
>>>> 
>>>> Did not notice this in first round, sorry. These seems to be sorted
>>>> (there's a comment further up about that) so this should be between
>>>> AMD and TI a bit more down.
>>> 
>>> The list isn't sorted at all. I think the comment just wants to
>> 
>> It is still mostly sorted except where people did not get how. Try
>> 
>> grep PCI_VENDOR_ID_ pci_ids.h
>> 
>>> say that you should mention the vendor before the devices.
>> 
>> I think it says that PCI_VENDOR_IDs should be sorted and then DEVICE_IDs 
>> within them should also be sorted but device IDs intervene VENDOR_IDs so 
>> the sorting of VENDOR_IDs may not be obvious at first sight.
>> 
>>> Anyway, as the list currently is, there are multiple positions
>>> where HP could be added...
>> 
>> Yes, some IDs already break this sorting but we could still avoid breaking 
>> it more. [...]
>
> ... that's why I added "HP" it after "DEC" :-)

But it should be sorted by ID number not name that's why it should be 
between AMD 0x1022 and TI 0x104c.

Regards,
BALATON Zoltan
--3866299591-1146477983-1697574083=:50058--

