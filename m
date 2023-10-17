Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 858927CCC33
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 21:26:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsph8-0001gt-KE; Tue, 17 Oct 2023 15:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qsph3-0001bK-Jb
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 15:25:30 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qspgw-0005lH-VT
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 15:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697570719; x=1698175519; i=deller@gmx.de;
 bh=KiIyQWF5rq+FspdAyEHbueHS3NnE/b3k11OpVGktVaU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=rtKAw8zBghD+0UswXXsy2BigIOqcXJlkXWw2E98AyM9Jbx/05HuCPgfG5cKFDl2Z
 zJvaY2bzjDmYaIVG81B83YaWEAmXVvBLhBKOUVx/v8BH0lkNl1pWn4fHXHW1nNhKL
 VdJ34gy3OVp5ZPpskLA/Rl3iBI18/07sI/+dEzyOMlvzK2kynJN5zAq7S2Dpaz2Kd
 RZQ5t5FbnyhEjMcQhq6F2/bY0qeQgdwLgaaMg+iMn9Zol06uqVjd1rejWk0/5Qbr6
 omtHEHyb3MSnF6HIVnNrxziAX9flHmgDkAjjEesBDhgJm4fSEA9WdzJj4Fhgmxq3j
 NTI1KfBwUgSMZYzC1Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.144.254]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNKhs-1rBz890wtW-00Op4S; Tue, 17
 Oct 2023 21:25:19 +0200
Message-ID: <e939ce05-387e-4952-beba-84d566fff0c0@gmx.de>
Date: Tue, 17 Oct 2023 21:25:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] pci_ids/tulip: Add PCI vendor ID for HP and use
 it in tulip
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: deller@kernel.org, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20231017154645.95844-1-deller@kernel.org>
 <20231017154645.95844-3-deller@kernel.org>
 <df5da806-4b08-5034-1b80-93d583efd86b@eik.bme.hu>
 <3425e5f9-f2d4-428b-96d2-5e0760871837@gmx.de>
 <5e17898a-c70c-4f79-9bd8-fc20a6179b42@eik.bme.hu>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <5e17898a-c70c-4f79-9bd8-fc20a6179b42@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dWndAvfZf9lMLGfHkGznb8v8ITQ2J2JlMrRAvHQxc/nRMgYChmB
 h7CCDp1QzaLtdBGuVGIyiqxn9xvhciaKJk4yMVr1aTJYOoD9FGPRu7ukFDuuc5coNiO7plj
 SN1sEI/3jx7t0FUf4nDwC+D6dzxQpccrpFbJxcsVI/+Eu4zdQFh/ubZ/7I+oDy3wGXbcPEj
 X8Xs+HRO6nUULdNasf6Fw==
UI-OutboundReport: notjunk:1;M01:P0:bO1/HH1PMSc=;Db1AXr+0BUo0in76IwiN2Hz3yra
 sU69xCsCY1V3fMUQAw8z+wioERsguaGsrmtL20069XB3u0d1GVzWVsAAGPyCRKbH5/n7ZOFMi
 LCRa3nJZjOJp32M3nsqdaRDxkbe4xZC3r21YKBlmEsdC4RSfsSUIrG9BXfNVzOXu0M3LLwpOa
 +pMAFVvvbGr8sE7Tn4MNGVJkkbtnr95zy2BXm0HEBNs+XQa7nViII9OjUpMMXaOfkd7yVC0LD
 Wt78xBpLSTf7qCBsFr5tQuQAt+QFT7hNNufIWG7XgbxDlqfabROI7Fmo012/X32fmjTuBDZld
 uSL1iJY40Ysr1jKSf7KAri8JgXDt5r3y9ppZPxUN+UoaYttRH9VlKhP5djpfGedz2LxBXWzLu
 zcidA7Jt8sDclKbw2TCJqykmzPSpGXQ1Pj7KSy2u8yw1i8DCgnRuyDjf7j7pVKnr6MYb5xuA7
 aT2G0RYh32sb0lJAR7FhiSuqZwjCqdyML27OZrARJQw5fKQu0QUTwiRpStUaaKSYvQg5Wkztq
 VvlCbdzONlx0K3XVaaSmp8aeGn4RaE7OovFS70WSZdknep/502V87DniLiJh7z2p172YC24Aj
 hu0dSzfBl0jGepMHqBoKLgTCk6gGpcc7BxH2xa/NG8Hq20oB93YF1s8ZtI2PKxvQQUVgQxgiA
 ouonHfdJwpo2EgapnO8EVhiucpZW6DpVjeDlDCD1DjPJZCKU7dvs4irqRs9lDLYdEjG4xpt01
 5WC5Np6PMDJ+6ith6pyJs+To2aGVCq2mk9ei+pedePvL9J2ZFWROJvrmbmUuVxUNIgpxwsa2b
 UInozl1pdUbTuBsvs1uhYMsmwSfHaee/j20OOrM/zr+eShep9PKV8ke76oFY4q6cyNJoHFV2c
 HsA8dsHrld8jsTDSTL2xATuXMgM4MhkfuYXAgVV9L5RQPFu6vueRG7VE3oIc95LWwNRMyw22L
 dlpOkhBn5Wk8OX+ujCI+GJjfOTU=
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On 10/17/23 21:19, BALATON Zoltan wrote:
> On Tue, 17 Oct 2023, Helge Deller wrote:
>> On 10/17/23 18:13, BALATON Zoltan wrote:
>>> On Tue, 17 Oct 2023, deller@kernel.org wrote:
>>>> From: Helge Deller <deller@gmx.de>
>>>>
>>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>>> ---
>>>> hw/net/tulip.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 2 +-
>>>> include/hw/pci/pci_ids.h | 2 ++
>>>> 2 files changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/net/tulip.c b/hw/net/tulip.c
>>>> index 915e5fb595..11d866e431 100644
>>>> --- a/hw/net/tulip.c
>>>> +++ b/hw/net/tulip.c
>>>> @@ -1020,7 +1020,7 @@ static void tulip_class_init(ObjectClass *klass=
, void *data)
>>>> =C2=A0=C2=A0=C2=A0 k->exit =3D pci_tulip_exit;
>>>> =C2=A0=C2=A0=C2=A0 k->vendor_id =3D PCI_VENDOR_ID_DEC;
>>>> =C2=A0=C2=A0=C2=A0 k->device_id =3D PCI_DEVICE_ID_DEC_21143;
>>>> -=C2=A0=C2=A0=C2=A0 k->subsystem_vendor_id =3D 0x103c;
>>>> +=C2=A0=C2=A0=C2=A0 k->subsystem_vendor_id =3D PCI_VENDOR_ID_HP;
>>>> =C2=A0=C2=A0=C2=A0 k->subsystem_id =3D 0x104f;
>>>> =C2=A0=C2=A0=C2=A0 k->class_id =3D PCI_CLASS_NETWORK_ETHERNET;
>>>> =C2=A0=C2=A0=C2=A0 dc->vmsd =3D &vmstate_pci_tulip;
>>>> diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
>>>> index 85469b9b53..3c0e72df0e 100644
>>>> --- a/include/hw/pci/pci_ids.h
>>>> +++ b/include/hw/pci/pci_ids.h
>>>> @@ -171,6 +171,8 @@
>>>> #define PCI_VENDOR_ID_DEC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x1011
>>>> #define PCI_DEVICE_ID_DEC_21143=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0x0019
>>>>
>>>> +#define PCI_VENDOR_ID_HP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x103c
>>>> +
>>>
>>> Did not notice this in first round, sorry. These seems to be sorted
>>> (there's a comment further up about that) so this should be between
>>> AMD and TI a bit more down.
>>
>> The list isn't sorted at all. I think the comment just wants to
>
> It is still mostly sorted except where people did not get how. Try
>
> grep PCI_VENDOR_ID_ pci_ids.h
>
>> say that you should mention the vendor before the devices.
>
> I think it says that PCI_VENDOR_IDs should be sorted and then DEVICE_IDs=
 within them should also be sorted but device IDs intervene VENDOR_IDs so =
the sorting of VENDOR_IDs may not be obvious at first sight.
>
>> Anyway, as the list currently is, there are multiple positions
>> where HP could be added...
>
> Yes, some IDs already break this sorting but we could still avoid breaki=
ng it more. [...]

... that's why I added "HP" it after "DEC" :-)

Helge


