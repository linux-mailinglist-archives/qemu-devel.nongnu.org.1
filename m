Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6357DAA52
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 02:06:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwuFI-0002FI-CK; Sat, 28 Oct 2023 21:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qwuFG-0002F5-OB
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 21:05:38 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qwuFE-00089E-K6
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 21:05:38 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5079f9675c6so5076007e87.2
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 18:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698541534; x=1699146334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x8GTBIx5nyCyiVccIoOlvZQ+B0scpu8tR5K+LILrMfc=;
 b=HoLC7+4hzrg/5kAuQGbAKD1ktDZcvmxlvX/ce8LOfyk6LkVKLmBULMUi/acd6sZCRA
 goGnzg8IoHKwiC5m6NFdY55Krj6crjU6Cgf54H7YNEVoFE7QLXuEmgYjQfN0FZJt9zvH
 gXh9JM4wCnolPI/Uw//tyDz9T2/6YVRRypvRITcD3rzGWbpn7+sDLkZw6CB76kl/5WOD
 Si5VsJgD8Y066rkO7gvMdXlNVUAtO5u+O+DDJnkhEaFUb8Yq9f0klawISMzSjrRo1rUX
 L+8xNAJe4UoETNX9OVhYaR4ndysbVc0ElnZIGHMy8hcFAPP1ymhe39WGPmgjpIsboZlz
 5HLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698541534; x=1699146334;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x8GTBIx5nyCyiVccIoOlvZQ+B0scpu8tR5K+LILrMfc=;
 b=sqhURA/cwz/LcTPwwherLgB+nk26U1M9gMVESc0J09NCulvT7bMFUEhjexbaHfelBr
 nIhXnFLUXXcv2sdywH2KQyKq7I/QMogvRsNs0ZC0oJCR4oVpQ77hjkpfSgjxMfhMsg/N
 J7Yk8cf7/JHns2T13vtqllH8gRpMqszKUqeGTLPDfPoJ/iNXKCtU5sM5oKUpvyEUc/g2
 N8uOtMU8NP0oBRJF5q4cClxIjoqeOxHIft8chyT1rN5fxw07Ejub7h9Ze7XuhCTXp/NW
 YoStcWMg87lQ9V8mNU+cGG68mgx/ZaYiStSOR3Q7zFfA1A3kYpi/CWgjVo4LnQSqfztP
 cTLA==
X-Gm-Message-State: AOJu0YxZXENbCpqcyIBYgntPkmxmqJ+zfktlR7OBqILuBdWxym4ajoB6
 Wvby/T8WBl1kehxaFTQE+fk=
X-Google-Smtp-Source: AGHT+IGSRRLFKAO3mlqNWF7WPBwzM8kXNuZ+Ido4ck8bk9m5/dVneBNhvu7k2OFN7C3eCj7f5Esdkg==
X-Received: by 2002:a19:c211:0:b0:507:975f:6ccb with SMTP id
 l17-20020a19c211000000b00507975f6ccbmr3997734lfc.2.1698541533927; 
 Sat, 28 Oct 2023 18:05:33 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-013-030-128.77.13.pool.telefonica.de.
 [77.13.30.128]) by smtp.gmail.com with ESMTPSA id
 q17-20020a17090622d100b0098921e1b064sm3479903eja.181.2023.10.28.18.05.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 18:05:33 -0700 (PDT)
Date: Sun, 29 Oct 2023 01:05:28 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v5 0/5] VIA PM: Implement basic ACPI support
In-Reply-To: <56ec4e09-9c81-7d9c-69bf-16a23a0969bd@eik.bme.hu>
References: <20231028091606.23700-1-shentey@gmail.com>
 <999122a1-7790-f77c-8826-cd143191f6fb@eik.bme.hu>
 <FE0C5B55-83DE-466F-B555-124B3936E3DE@gmail.com>
 <56ec4e09-9c81-7d9c-69bf-16a23a0969bd@eik.bme.hu>
Message-ID: <9317ABD0-0C39-492C-8408-2EF5580AD7EF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x12a.google.com
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



Am 28=2E Oktober 2023 17:47:15 UTC schrieb BALATON Zoltan <balaton@eik=2Eb=
me=2Ehu>:
>On Sat, 28 Oct 2023, Bernhard Beschow wrote:
>> Am 28=2E Oktober 2023 12:58:32 UTC schrieb BALATON Zoltan <balaton@eik=
=2Ebme=2Ehu>:
>>> Hello,
>>>=20
>>> On Sat, 28 Oct 2023, Bernhard Beschow wrote:
>>>> This series is part of my work to bring the VIA south bridges to the =
PC machine
>>>> [1]=2E It implements missing ACPI functionality which ACPI-aware x86 =
guests
>>>> expect for a smooth experience=2E The implementation is heavily inspi=
red by PIIX4=2E
>>>=20
>>> I think first the interrupt routing should be fixed because that may c=
hange a few things in this series so that should be the next step and then =
rebase this series on top of that=2E
>>>=20
>>> What I mean by fixing interrupt routing? You may remember this discuss=
ion:
>>>=20
>>> https://patchew=2Eorg/QEMU/cover=2E1677004414=2Egit=2Ebalaton@eik=2Ebm=
e=2Ehu/
>>>=20
>>> With pegasos2 your (over)simplification worked only because the firmwa=
re of that machine maps everythnig to one ISA IRQ and guests were happy wit=
h that=2E I told you that back then but could not convince you and Mark abo=
ut that=2E Now with the amigaone machine the firmware maps VIA devices and =
PCI interuupt pins to different ISA IRQs so we need to go back either to my=
 otiginal implementation or something else you come up with=2E You can test=
 this trying to use USB devices with amigaone machine which only works afte=
r reverting 4e5a20b6da9b1 and 422a6e8075752=2E So please either propose som=
ething to fix that first or wait with this series until I can update my pat=
hches to solve interrupt routing=2E I think this series should wait until a=
fter that because it adds more interrupt handling which should follow whate=
ver way we come up with for that so it's too early fir this series yet=2E (=
If you want to try fixing it keep in mind that in both amigaone and pegasos=
2 the PCI buses are in the north brid
>ge not in the VIA south bridge so don't try to force the IRQ mapping into=
 the PCI bus=2E All the VIA chip needs to do is mapping its PIRQ/PINT pins =
to ISA IRQs as the VIA is only handling ISA IRQs and all other pci stuff is=
 handled in the north bridge=2E So I think we need a via_set_isa_irq functi=
on but we could change it according to Mark's idea to pass the PCI device a=
nd use its function number to select itq source instead of the enum I had i=
n my original series=2E)
>>>=20
>>> I have some other comments that I'll add in reply to individual patche=
s for the future/
>>=20
>> Hi Zoltan,
>>=20
>> The interrupt handling introduced in this series is not related to PCI =
interrupt routing: The SMI is a dedicated pin on the device and the SCI is =
mapped internally to an ISA interrupt (note how the power management functi=
on lacks the registers for PCI interrupt information)=2E Hence, PCI interru=
pt routing isn't changed in this series and therefore seems off-topic to me=
=2E
>>=20
>> Moreover, the SMI is a new interrupt which is therefore not used in any=
 machine yet=2E The SCI is deactivated if set to IRQ 0 which is the default=
 even=2E If a guest configures it, it shall be aware to receive an *ISA* in=
terrupt=2E
>>=20
>> So I think this series shouldn't conflict with any previous work and sh=
ould not be blocked by the PCI IRQ routing topic=2E
>
>The topic I've raised is not about routing PCI interrupts but routing dif=
ferent IRQ sources in VIA chip (such as different functions plus the PIRQ/P=
INT pins) to ISA interrupts so that would conflict with how the PM func int=
errupts are routed=2E I think only the isa function should have qemu_irqs a=
nd it should handle mapping of the different sources to the appropriate ISA=
 IRQ so the different sources (functions) should not have their own qemu_ir=
qs or gpios but they would just call via_isa_set_irq with their PCIDevice, =
pun and level and then the isa model would do the routing=2E I plan to do t=
his eventually but it you're adding more things that would need to be rever=
ted then it becomes more difficult=2E

We've had lenghty discussions about this topic before and we -- together -=
- ended up with the current solution=2E This series adds the last missing f=
eature to the VIA south bridges before they can be integrated into the PC m=
achine=2E Delaying progress by reopening the same topics over and over agai=
n really seems unfair to me=2E Instead, let's be optimistic that we'll end =
up with a solution that suits all needs well=2E

That said, I've ran both the pegasos2=2Erom and the u-boot=2Ebin for amiga=
one that is used in the Avocado test=2E I've traced both with '-trace "pci_=
cfg_*"'=2E The result is that neither BIOS pokes the SCI routing register i=
n the ISA function which means that the interrupt stays deactivated=2E Henc=
e, it is very unlikely that the changes introduced in this series would int=
erfer with guests on these machines=2E

In summary, I don't see any blockers so far for merging this series for th=
e upcoming release=2E

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan

