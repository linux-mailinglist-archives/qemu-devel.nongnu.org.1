Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 087F7925481
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jul 2024 09:17:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOuD9-0005CV-TL; Wed, 03 Jul 2024 03:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1sOuD7-0005CB-Uo
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 03:15:25 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1sOuD4-0007DZ-4N
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 03:15:25 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-58ba3e38027so1789050a12.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 00:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719990914; x=1720595714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gUKyUvkQElCQ85CdBPUC6d9/T9BEKnHfylk1p7V0BbA=;
 b=Pj7rNPFl2xWE5aOOl7GSPA9yzcPFNqsX0H3wxIJkeq8Q1/X5Ragn+4ek1nCJVPUUha
 B+BmFq2VfVS/f46XHdx8BxVVpP4wuvgAao+2QH8ppYV8JbjBxwqcQQMRyl+92BfeEXQt
 W/Olxd467MUmYeJEXSyJjJf/uW0LKwdgWT6ujwJSdjnhGx8RbctyE19x3pSq6G/2ULe/
 c5Qe+XslXpJAoyUwPdgVjt0zJjlaa+HYwXdBLt6yb0xfdp38WS+CNSdwLJyXCrchpnf5
 EFZ9LV6g1E2AmpRnXxtRfipP5WaF3oF+ytS2Y6tCAysoal87PzCZa7Cbnf3hORvWoASU
 HUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719990914; x=1720595714;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gUKyUvkQElCQ85CdBPUC6d9/T9BEKnHfylk1p7V0BbA=;
 b=WLQH/lvbhWMH9ZHEsVLtHUYK3VGQJFMPKkFvbvVqOulij4IUOvveg/1gkgu2DRu4dl
 n3opyCQWUxjTms1gC/+5lFx+JiLvfbrq790PCWF83wOePUAVaF5jK5VhfC+WJwPYYPRS
 k3xldprnODmzN5Vjy9CrfQmn/MSJHAxUS+X3W9ALNufhnRW8JLBDiEsSUP2wWV4Si1ft
 OIJYL5yNkwcP6XodVxISV2/aeNVnrOC3CsMeym1MlGmq7676qOg4uqfbbdc6k1zfe8rN
 0xeSJKZFomQHIBGCTGGf2Zm0dRO8pIW7eBTAIwZRWf+tc0nVzWhcm7vJ94BC37gXDf1+
 pFEA==
X-Gm-Message-State: AOJu0Yy1te93T9wXslwIDyu5JF+fO9NO4jRoVEMbQ6IUrS2robpBMoK5
 4TyTiWsA81CuuPPUKqdBqxtOeBcR1ylh5K8OKCo4nilyMWZ4/94k
X-Google-Smtp-Source: AGHT+IFQ7FQ3TMaLFMLyZuFVd7KOG4oA3R/w/l1hDglu8sOZ1nPfm9fSbfUN0miuJGKH1KdogfevVg==
X-Received: by 2002:a17:906:1350:b0:a6f:dc10:6534 with SMTP id
 a640c23a62f3a-a751449e587mr711712366b.34.1719990913788; 
 Wed, 03 Jul 2024 00:15:13 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-013-032-035.77.13.pool.telefonica.de.
 [77.13.32.35]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab08fe92sm480249866b.167.2024.07.03.00.15.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 00:15:13 -0700 (PDT)
Date: Wed, 03 Jul 2024 07:15:11 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 philmd@linaro.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/2=5D_hw/isa/vt82c686=2Ec=3A_Embed_i82?=
 =?US-ASCII?Q?59_irq_in_device_state_instead_of_allocating?=
In-Reply-To: <cf46b29f-b36f-37b8-373f-72ad487ee749@eik.bme.hu>
References: <cover.1719690591.git.balaton@eik.bme.hu>
 <b70b9e72063b4dd4005bf4bc040b84f2bb617bf4.1719690591.git.balaton@eik.bme.hu>
 <CAFEAcA_tBjQrJMpjbzVUVcrTWghr4v=MHB0qpWx=xjML6ek9mg@mail.gmail.com>
 <4CBF639B-CC3E-4644-9F87-481B9147F2A9@gmail.com>
 <00311AC8-D02C-4C3A-85A7-8FB3B51DDE9C@gmail.com>
 <cf46b29f-b36f-37b8-373f-72ad487ee749@eik.bme.hu>
Message-ID: <69FF1605-8E74-44CA-BE43-8D85AAC89EBE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



Am 3=2E Juli 2024 00:09:45 UTC schrieb BALATON Zoltan <balaton@eik=2Ebme=
=2Ehu>:
>On Tue, 2 Jul 2024, Bernhard Beschow wrote:
>> Am 2=2E Juli 2024 18:42:23 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>>> Am 1=2E Juli 2024 12:58:15 UTC schrieb Peter Maydell <peter=2Emaydell@=
linaro=2Eorg>:
>>>> On Sat, 29 Jun 2024 at 21:01, BALATON Zoltan <balaton@eik=2Ebme=2Ehu>=
 wrote:
>>>>>=20
>>>>> To avoid a warning about unfreed qemu_irq embed the i8259 irq in the
>>>>> device state instead of allocating it=2E
>>>>>=20
>>>>> Signed-off-by: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>>>>> ---
>>>>>  hw/isa/vt82c686=2Ec | 7 ++++---
>>>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>>>=20
>>>>> diff --git a/hw/isa/vt82c686=2Ec b/hw/isa/vt82c686=2Ec
>>>>> index 8582ac0322=2E=2E834051abeb 100644
>>>>> --- a/hw/isa/vt82c686=2Ec
>>>>> +++ b/hw/isa/vt82c686=2Ec
>>>>> @@ -592,6 +592,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(ViaISAState, VIA_ISA)
>>>>>=20
>>>>>  struct ViaISAState {
>>>>>      PCIDevice dev;
>>>>> +
>>>>> +    IRQState i8259_irq;
>>>>>      qemu_irq cpu_intr;
>>>>>      qemu_irq *isa_irqs_in;
>>>>>      uint16_t irq_state[ISA_NUM_IRQS];
>>>>> @@ -715,13 +717,12 @@ static void via_isa_realize(PCIDevice *d, Erro=
r **errp)
>>>>>      ViaISAState *s =3D VIA_ISA(d);
>>>>>      DeviceState *dev =3D DEVICE(d);
>>>>>      PCIBus *pci_bus =3D pci_get_bus(d);
>>>>> -    qemu_irq *isa_irq;
>>>>>      ISABus *isa_bus;
>>>>>      int i;
>>>>>=20
>>>>>      qdev_init_gpio_out(dev, &s->cpu_intr, 1);
>>>>>      qdev_init_gpio_in_named(dev, via_isa_pirq, "pirq", PCI_NUM_PINS=
);
>>>>> -    isa_irq =3D qemu_allocate_irqs(via_isa_request_i8259_irq, s, 1)=
;
>>>>> +    qemu_init_irq(&s->i8259_irq, via_isa_request_i8259_irq, s, 0);
>>>>>      isa_bus =3D isa_bus_new(dev, pci_address_space(d), pci_address_=
space_io(d),
>>>>>                            errp);
>>>>=20
>>>> So if I understand correctly, this IRQ line isn't visible
>>>> from outside this chip,
>>>=20
>>> Actally it is, in the form of the INTR pin=2E Assuming similar naming
>
>The INTR pin corresponds to qemu_irq cpu_intr not the i8259_irq=2E
>
>>> conventions in vt82xx and piix, one can confirm this by consulting the=
 piix4 datasheet, "Figure 5=2E Interrupt Controller Block Diagram"=2E Moreo=
ver, the pegasos2 schematics (linked in the QEMU documentation) suggest tha=
t this pin is actually used there, although not modeled in QEMU=2E
>>=20
>> Well, QEMU does actually wire the intr pin in the pegasos2 board code, =
except that it isn't a named gpio like in piix4=2E If we allow this pin to
>
>I could make that named to make it clearer, now it's the only output gpio=
 so did not name it as usually devices that only have one output don't use =
named gpios for that=2E
>
>> be wired before the south bridge's realize we might be able to eliminat=
e the "intermediate irq forwarder" as Phil used to name it, resulting in le=
ss and more efficient code=2E This solution would basically follow the patt=
ern I outlined under below link=2E
>
>I think the problem here is that i8259 does not provide an output gpio fo=
r this interrupt that the VT82xx could pass on but instead i8259_init() nee=
ds a qemu_irq to be passed rhat the i8259 model will set=2E This seems to b=
e a legacy init function so the fix may be to Qdev-ify i8259 and add an out=
put irq to it then its users could instantiate and connect its IRQs as usua=
l and we don't need to create a qemu_irq to pass it to i8259_init()=2E

I've implemented the approach avoiding the intermediate IRQ forwarders her=
e: https://github=2Ecom/shentok/qemu/commits/upstream/vt82c686-irq/ =2E I'd=
 send this series to the list as soon as I resolve some email authenticatio=
n issues=2E

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan
>
>> Best regards,
>> Bernhard
>>=20
>>> Compare this to how the "intr" pin is exposed by the piix4 device mode=
l and wired in the Malta board=2E
>>>=20
>>>> we're just trying to wire together
>>>> two internal components of the chip? If so, I agree that
>>>> this seems a better way than creating a named GPIO that
>>>> we then have to document as a "not really an external
>>>> connection, don't try to use this" line=2E (We've done that
>>>> before I think in other devices, and it works but it's
>>>> a bit odd-looking=2E)
>>>>=20
>>>> That said, I do notice that the via_isa_request_i8259_irq()
>>>> function doesn't do anything except pass the level onto
>>>> another qemu_irq, so I think the theoretical ideal would be
>>>> if we could arrange to plumb things directly through rather
>>>> than needing this extra qemu_irq and function=2E There's
>>>> probably a reason (order of device creation/connection?)
>>>> that doesn't work though=2E
>>>=20
>>> I think there could be a general pattern of device creation/connection=
 which I've outlined here: https://lore=2Ekernel=2Eorg/qemu-devel/0FFB5FD2-=
08CE-4CEC-9001-E7AC24407A44@gmail=2Ecom/
>>>=20
>>> Best regards,
>>> Bernhard
>>>=20
>>>>=20
>>>> -- PMM
>>>>=20
>>=20
>>=20

