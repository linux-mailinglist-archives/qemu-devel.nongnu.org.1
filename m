Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA737B9CE9
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 14:12:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoNBY-0008VK-Qd; Thu, 05 Oct 2023 08:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qoNBW-0008LU-FF
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:10:30 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qoNBU-0007Qx-Dv
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:10:30 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9a6190af24aso164190766b.0
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 05:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696507825; x=1697112625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oEOCb2Q+lg+B3Shnz+xNonBCNaAHfM+U8spfebZHf/M=;
 b=C75pUyIBhnTEQtt37unYrAa4OHs4tjsbT82KOkqtdGNTCztQ533XM8ClaiEH9kM8GO
 IPAhuLMCcL83S/tyfOnyG8JHokQNcCUqJHu0IdzYmEhVemT4xKuHkrnCzxOF0ah2yEOR
 IDk//XMzuC3EsBbJi+tFpohf4Nst2FJ3uHj1nfyissJfVk1/Nwdl0KdVKPHufdczdvkK
 p6Ge/44pi5qST55+sGMm31+hUWDqE7KCWCXDq/T0rkJl0UlJqkvoLFDc7npUG6lpRlIP
 bq7FntZY+wGbcT98dmSas4NlROw2ewsFK51kDh4kOTpddny2mFjJmULAOG69spmkJi/f
 EtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696507825; x=1697112625;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oEOCb2Q+lg+B3Shnz+xNonBCNaAHfM+U8spfebZHf/M=;
 b=r/vRFJME14YHZ2+GDjFhetlqdypeJEcADN2cP0iaB7RY5lIhLquRpXMOXceV7c/QGl
 kyNsRy2M8TVhEPLChjYOwgdwiFGIkQryPKwegIcELmIle0cfLHzNr97reZbto7EQgX+g
 QdOa7E/IfMZVgkeLgI03lJhM57oG7FrSbAuQJIGUKKusA7eblbTr2lRkWK64d4Qkj283
 GlHpHpKnXyaz7XWw2kPDgY+UeqVzFLwSyKi02Jw5IoEkpP54nyKs2z1O1vu12W4T9eLx
 bFWjZ7K2spkhRI+R5tBo002vW6oJFLOpszx6ECtbYu90YX/n6a9Vxji/iNWYzTSYnE7b
 1QPA==
X-Gm-Message-State: AOJu0Yzcvdjmx9Z8RPzDjQtz/fYqarC9XjBrKjTODWdzkqM1L2wt33aM
 Li4m1PLAoklETLKlYUPWXa8=
X-Google-Smtp-Source: AGHT+IHM1QuTfvjQ4LoV0R/6uycWlqYmJi20/tHlXxilzKLFAXTytxmvFqIqbC2Akvb4INgzSoi5aQ==
X-Received: by 2002:a17:906:5341:b0:9b8:7709:6360 with SMTP id
 j1-20020a170906534100b009b877096360mr5243167ejo.40.1696507824895; 
 Thu, 05 Oct 2023 05:10:24 -0700 (PDT)
Received: from ?IPv6:::1?
 (p200300faaf2af200ad058901f594a09a.dip0.t-ipconnect.de.
 [2003:fa:af2a:f200:ad05:8901:f594:a09a])
 by smtp.gmail.com with ESMTPSA id
 rv18-20020a17090710d200b0099364d9f0e6sm1094769ejb.117.2023.10.05.05.10.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 05:10:24 -0700 (PDT)
Date: Thu, 05 Oct 2023 12:10:18 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2] hw/isa/vt82c686: Respect SCI interrupt assignment
In-Reply-To: <9bedc976-9d10-90e0-f1d6-dff9618854e5@eik.bme.hu>
References: <20231004105709.16994-1-shentey@gmail.com>
 <c786c82e-88bb-5333-1b74-a1bf0fd2cad5@eik.bme.hu>
 <4D35354B-1289-4B67-B913-7EC5F4D6D07F@gmail.com>
 <9bedc976-9d10-90e0-f1d6-dff9618854e5@eik.bme.hu>
Message-ID: <425EE8A1-749B-445E-95B0-45614D95BF3C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x635.google.com
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



Am 5=2E Oktober 2023 11:26:56 UTC schrieb BALATON Zoltan <balaton@eik=2Ebm=
e=2Ehu>:
>On Thu, 5 Oct 2023, Bernhard Beschow wrote:
>> Am 4=2E Oktober 2023 12:28:58 UTC schrieb BALATON Zoltan <balaton@eik=
=2Ebme=2Ehu>:
>>> On Wed, 4 Oct 2023, Bernhard Beschow wrote:
>>>> According to the datasheet, SCI interrupts of the power management fu=
nction
>>>> aren't routed through the PCI pins but rather directly to the integra=
ted PIC=2E
>>>> The routing is configurable through the ACPI interrupt select registe=
r at offset
>>>> 0x42 in the PCI configuration space of the ISA function=2E
>>>>=20
>>>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>>>=20
>>>> ---
>>>>=20
>>>> v2:
>>>> * Introduce named constants for the ACPI interrupt select register at=
 offset
>>>>  0x42 (Phil)
>>>> ---
>>>> hw/isa/vt82c686=2Ec | 47 +++++++++++++++++++++++++++++++++++---------=
---
>>>> 1 file changed, 35 insertions(+), 12 deletions(-)
>>>>=20
>>>> diff --git a/hw/isa/vt82c686=2Ec b/hw/isa/vt82c686=2Ec
>>>> index 57bdfb4e78=2E=2E93ffaaf706 100644
>>>> --- a/hw/isa/vt82c686=2Ec
>>>> +++ b/hw/isa/vt82c686=2Ec
>>>> @@ -46,6 +46,8 @@ struct ViaPMState {
>>>>     ACPIREGS ar;
>>>>     APMState apm;
>>>>     PMSMBus smb;
>>>> +
>>>> +    qemu_irq irq;
>>>=20
>>> Is it better to name this sci_irq because there seems to be an smi_irq=
 too? Also there seems to be no SCI pin but there's an SMI pin so does this=
 sci_irq need to be forwaeded to the ISA bridge and exposed as a qemu_gpio =
or could it just set the ISA IRQ within its own handler in the via_pm objec=
t?
>>=20
>> Triggering the PIC in the PM function seems more complicated since ISA =
function embeds PM function and also PM function is implemented before ISA =
function, so this would create nesting problems in the code=2E Either
>
>Where PM function is implemented is just because it was there before or t=
hat's how I went through the functions when cleaning it up and ended up the=
re but it could be moved, it's not bolted down=2E=2E=2E
>
>However even if it comes before, we had the pattern before for via-ide an=
d usb that they can look up function 0 of their own devfn to find the ISA b=
ridge and sinve we're in vt82b686=2Ec here you can consider these to be fri=
end classes so pm func could access the ISA irq's directly (or bring back t=
he via_isa_set_irq func I had before for this)=2E That way it's simpler and=
 does not need QOM wizardry in ISA function that does not even model what r=
eal chip does so I think this should be implemented in an irq handler func =
within the PM object that matches what happens in the real chip=2E

This would require container_of() to be used which violates QOM best pract=
ices where a device should only know about its (transitive) children=2E Giv=
en the current nesting of devices I prefer to keep the PIC triggering in th=
e ISA function where the PIC resides=2E

Best regards,
Bernhard

>
>> way, both approaches need to sneak into the other PCI function's data, =
so I'd keep via_isa_set_pm_irq() and just update the constants=2E
>>=20
>>> There are also other registers that select between SMI and SCI, do tho=
se need to be taken into account?
>>=20
>> Maybe later=2E The current code already made the decision to use SCI by=
 triggering the PIC, so I'd declare this to be out of scope for now=2E
>
>Yes, if you're now just handling sci with one wpecific mapping then those=
 can wait until adding smi, just found them now and asked if they need to b=
e considered for sci now=2E
>
>Regards,
>BALATON Zoltan

