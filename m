Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD467BDB58
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 14:17:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qppB7-0001N5-7p; Mon, 09 Oct 2023 08:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qppB5-0001Mp-Ni; Mon, 09 Oct 2023 08:16:03 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qppB3-0001DT-NU; Mon, 09 Oct 2023 08:16:03 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9b275afb6abso1214712466b.1; 
 Mon, 09 Oct 2023 05:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696853759; x=1697458559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HbW2Zlhuxlh1oFRmdTNAW1sCUmE6X05Yu1vMIJUNc7g=;
 b=eTfoZzvOCUSpbOHC+bAFWxpYrYW4zaddASihBUIwigFLF26bQQNrSJVWjU9/OvqL1U
 Gdz2jgL2lP0+gk4LZh/3mT+GHqr7EzsLMakccjaSa/DL1pBHk0stRGcunfMksEJsPT/w
 zmoKzgbnFdH63SS6EQ7r9LN8P/yZyUjP7EOLiRCIAuHRwz87JJzgljOfyVtsmV6AVESH
 Vq8ZqWJVNagWXUMYttodnxmb7lKTUF6NPL6nobvAv1QDsi2HQWxPrT5dYTdvNXcSPsA+
 4MoVVaR1Tk4tiNmBFxJasLdWjQmoxbrhj/2x1Ta+Lc/Wiskt8H+C1P1JkvHj55N58Uvp
 ZBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696853759; x=1697458559;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HbW2Zlhuxlh1oFRmdTNAW1sCUmE6X05Yu1vMIJUNc7g=;
 b=wpSpVaWtFAKrfSZI6WzPMd6dk98RdH8FVbt4azVZDW1MwsvUas189YmelWBfGkysE1
 pfGl3xNzP8C15IB82Ero4vVJ8Mx8T+0L0q1eWmVLQdvkjbB3R0ZWiDleVEd1cvZ56FPp
 Dg2s9rkvF41SmLjG5k1cMJGxPeP3Pn3HZZp0juWG35rMKjWlmSvGfKVEalMPLXac//I9
 NYxirHirNrkt76z2akCTiRWDZNb6bdYKIoJWWYxYWvT5ean2cXyBhxsBy/JzgyBBvbEp
 m/Sz4KxeWC9m+sl33ieHTtDqo33jpMfT7p3YmDwdrf3x0cFqQSLJBJnxkey5rc1EVnEb
 YYpA==
X-Gm-Message-State: AOJu0YyzSB032K8Dor9ROfRzk1QZQQxMIIO7lV+KrIrEhHBGqKgcn+AN
 Xnx222OQNewZlGqQ1uPrKMg=
X-Google-Smtp-Source: AGHT+IEj/GMZac06vfPb4xNqIqUxJNrnmyktlxPcxzL87Yp16HY6Iskj4EECdFbzetzbYbS7bMQ4eg==
X-Received: by 2002:a17:907:1b1b:b0:9aa:1794:945b with SMTP id
 mp27-20020a1709071b1b00b009aa1794945bmr10284775ejc.22.1696853758663; 
 Mon, 09 Oct 2023 05:15:58 -0700 (PDT)
Received: from [127.0.0.1] (business-90-187-110-129.pool2.vodafone-ip.de.
 [90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 f13-20020a05640214cd00b0053821dbd4dasm5939588edx.22.2023.10.09.05.15.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 05:15:58 -0700 (PDT)
Date: Mon, 09 Oct 2023 10:03:26 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
CC: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org,
 philmd@linaro.org, Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
Subject: Re: [PATCH 1/3] via-ide: Fix legacy mode emulation
In-Reply-To: <a7821bf0-5d1f-ddda-f408-f4cd0432ddbf@eik.bme.hu>
References: <cover.1696542537.git.balaton@eik.bme.hu>
 <12ce9caa682545cd43318c4679530202140117c0.1696542537.git.balaton@eik.bme.hu>
 <33347356-be91-4dde-8535-5a59ee1c80f1@ilande.co.uk>
 <a7821bf0-5d1f-ddda-f408-f4cd0432ddbf@eik.bme.hu>
Message-ID: <4F17AF6B-22A5-4574-A3C0-40538F298CD5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x631.google.com
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



Am 8=2E Oktober 2023 11:08:58 UTC schrieb BALATON Zoltan <balaton@eik=2Ebm=
e=2Ehu>:
>On Sun, 8 Oct 2023, Mark Cave-Ayland wrote:
>> On 05/10/2023 23:13, BALATON Zoltan wrote:
>>=20
>>> The initial value for BARs were set in reset method for emulating
>>> legacy mode at start but this does not work because PCI code resets
>>> BARs after calling device reset method=2E
>>=20
>> This is certainly something I've noticed when testing previous versions=
 of the VIA patches=2E Perhaps it's worth a separate thread to the PCI devs=
?
>
>I think I brought up this back then but was told current PCI code won't c=
hange and since that could break everything else that makes sense so this i=
s something that we should take as given and accomodate that=2E
>
>>> Additionally the values
>>> written to BARs were also wrong=2E
>>=20
>> I don't believe this is correct: according to the datasheet the values =
on reset are the ones given in the current reset code, so even if the reset=
 function is overridden at a later data during PCI bus reset, I would leave=
 these for now since it is a different issue=2E
>
>Those values are missing the IO space bit for one so they can't be correc=
t as a BAR value no matter what the datasheet says=2E And since they are in=
effective now I think it's best to remove them to avoid confusion=2E
>
>>> Move setting the BARs to a callback on writing the PCI config regsiter
>>> that sets the compatibility mode (which firmwares needing this mode
>>> seem to do) and fix their values to program it to use legacy port
>>> numbers=2E As noted in a comment, we only do this when the BARs were
>>> unset before, because logs from real machine show this is how real
>>> chip works, even if it contradicts the data sheet which is not very
>>> clear about this=2E
>>>=20
>>> Signed-off-by: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>>> ---
>>>   hw/ide/via=2Ec | 35 ++++++++++++++++++++++++++++++-----
>>>   1 file changed, 30 insertions(+), 5 deletions(-)
>>>=20
>>> diff --git a/hw/ide/via=2Ec b/hw/ide/via=2Ec
>>> index fff23803a6=2E=2E8186190207 100644
>>> --- a/hw/ide/via=2Ec
>>> +++ b/hw/ide/via=2Ec
>>> @@ -132,11 +132,6 @@ static void via_ide_reset(DeviceState *dev)
>>>       pci_set_word(pci_conf + PCI_STATUS, PCI_STATUS_FAST_BACK |
>>>                    PCI_STATUS_DEVSEL_MEDIUM);
>>>   -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_0, 0x000001f0);
>>> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_1, 0x000003f4);
>>> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_2, 0x00000170);
>>> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_3, 0x00000374);
>>> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_4, 0x0000cc01); /* BMIBA=
: 20-23h */
>>>       pci_set_long(pci_conf + PCI_INTERRUPT_LINE, 0x0000010e);
>>>         /* IDE chip enable, IDE configuration 1/2, IDE FIFO Configurat=
ion*/
>>> @@ -159,6 +154,35 @@ static void via_ide_reset(DeviceState *dev)
>>>       pci_set_long(pci_conf + 0xc0, 0x00020001);
>>>   }
>>>   +static void via_ide_cfg_write(PCIDevice *pd, uint32_t addr,
>>> +                              uint32_t val, int len)
>>> +{
>>> +    pci_default_write_config(pd, addr, val, len);
>>> +    /*
>>> +     * Only set BARs if they are unset=2E Logs from real hardware sho=
w that
>>> +     * writing class_prog to enable compatibility mode after BARs wer=
e set
>>> +     * (possibly by firmware) it will use ports set by BARs not ISA p=
orts
>>> +     * (e=2Eg=2E pegasos2 Linux does this and calls it non-100% nativ=
e mode)=2E
>>=20
>> Can you remind me again where the references are to non-100% native mod=
e? The only thing I can find in Linux is https://github=2Ecom/torvalds/linu=
x/blob/master/arch/powerpc/platforms/chrp/pci=2Ec#L360 but that simply forc=
es a switch to legacy mode, with no mention of "non-100% native mode"=2E
>
>It was discussed somewhere in the via-ide thread we had when this was las=
t touched for pegasos2 in March 2020=2E Basically the non-100% native mode =
is when ports are set by BARs but IRQs are still hard coded to 14-15=2E Lin=
ux can work with all 3 possible modes: legacy (both ports and IRQs are hard=
 coded to ISA values), native (using BARs and PCI config 0x3c for a single =
interrupt for both channels, vt82c686 data sheet does not document this but=
 vt8231 has a comment saying native mode only) and non-100% native mode whe=
re BARs are effective to set port addresses but IRQs don't respect 0x3c but=
 use 14-15 as in legacy mode=2E Some machines only work in non-100% native =
mode such as pegasos2 and Linux has some quirks for this=2E Other OSes runn=
ing on this machine work with what the firmware has set up and can't work w=
ith anything else so we need to emulate what those OSes want (which matches=
 real hardware) because Linux can usually cope anyway=2E On pegasso2 MorphO=
S uses BARs but expects IRQ 14-15 which is what the firmware also sets up b=
y setting mode to native in the PCI config of the IDE func yet IRQs are fix=
ed at 14-15=2E Linux forces its driver to use legacy interrupts by setting =
mode back to legacy but it still uses BARs and this is what it calls non-10=
0% native mode=2E On amigaone firmware sets legacy mode and AmigaOS does no=
t change this but uses it with legacy ports and IRQs=2E Linux finds the sam=
e and uses legacy mode on amigaone=2E
>
>>> +     * But if 0x8a is written after reset without setting BARs then w=
e want
>>> +     * legacy ports (this is done by AmigaOne firmware for example)=
=2E
>>> +     */
>>=20
>> What should happen here is that writing 0x8a should *always* switch to =
legacy mode, so the BARs are unused=2E=2E=2E
>
>Yes, but as we've found before that can't be emulated in QEMU due to ISA =
emulation being static and only allows adding ports but not removing them l=
ater so we can't switch between legacy ISA and PCI here so we use the BARs =
for legacy ports as well to emulate that=2E The reason we only do this if B=
ARs are not yet set is because Linux changes this back to legacy mode on pe=
gasos2 but still uses BARs

Just curious: How can you tell the difference in real hardware whether "ra=
w" IO ports vs=2E BARs mapped to IO space are used?

> as shown in boot logs from real hardware

Could you provide links to such logs? That would be very helpful to have -=
- even in the code -- for documentation=2E

Best regards,
Bernhard

> so it seems BARs take priority over legacy mode on real chip and Linux o=
nly uses the mode reg to decide what IRQs to use=2E On amigaone firmware wr=
ites 0x8a right after reset in which case we want legacy mode so this works=
 for both machines=2E
>
>>> +    if (addr =3D=3D PCI_CLASS_PROG && val =3D=3D 0x8a &&
>>> +        pci_get_long(pd->config + PCI_BASE_ADDRESS_0) =3D=3D
>>> +        PCI_BASE_ADDRESS_SPACE_IO) {
>>> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_0, 0x1f0
>>> +                     | PCI_BASE_ADDRESS_SPACE_IO);
>>> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_1, 0x3f6
>>> +                     | PCI_BASE_ADDRESS_SPACE_IO);
>>> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_2, 0x170
>>> +                     | PCI_BASE_ADDRESS_SPACE_IO);
>>> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_3, 0x376
>>> +                     | PCI_BASE_ADDRESS_SPACE_IO);
>>> +        /* BMIBA: 20-23h */
>>> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_4, 0xcc00
>>> +                     | PCI_BASE_ADDRESS_SPACE_IO);
>>> +    }
>>> +}
>>=20
>> =2E=2E=2E but what you're doing here is effectively forcing the PCI BAR=
s to the legacy addresses=2E The reason we know this is because that is why=
 you have the off-by-2 error in BARs 1 and 3=2E
>>=20
>> I could live with this approach for now if you're willing to adjust the=
 comments accordingly clarifying that forcing the PCI BARs to the legacy ad=
dresses is a hack to be replaced in future with proper legacy ioports=2E At=
 some point I will revive my PoC series on top of Bernhard's last series th=
at implements this properly=2E
>
>That's fair enoough, I can try to clarify thid more in the comments and c=
ommit message=2E I'll try to come up with something for v2=2E
>
>Regards,
>BALATON Zoltan
>
>>>   static void via_ide_realize(PCIDevice *dev, Error **errp)
>>>   {
>>>       PCIIDEState *d =3D PCI_IDE(dev);
>>> @@ -221,6 +245,7 @@ static void via_ide_class_init(ObjectClass *klass,=
 void *data)
>>>       /* Reason: only works as function of VIA southbridge */
>>>       dc->user_creatable =3D false;
>>>   +    k->config_write =3D via_ide_cfg_write;
>>>       k->realize =3D via_ide_realize;
>>>       k->exit =3D via_ide_exitfn;
>>>       k->vendor_id =3D PCI_VENDOR_ID_VIA;
>>=20
>>=20
>> ATB,
>>=20
>> Mark=2E
>>=20
>>=20
>>=20

