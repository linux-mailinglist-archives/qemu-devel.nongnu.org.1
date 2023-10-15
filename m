Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5BE7C98A8
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 12:24:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qryHF-00041N-6L; Sun, 15 Oct 2023 06:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qryHD-00040v-8V; Sun, 15 Oct 2023 06:23:15 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qryH8-0000Xl-2F; Sun, 15 Oct 2023 06:23:15 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-53df747cfe5so6277046a12.2; 
 Sun, 15 Oct 2023 03:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697365388; x=1697970188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rw7lS+ohjqUkSHKT12XYG+b1i4hqAXQ9Djh+8O3O2O0=;
 b=h6wiIcqI+ItE0Gc6OHldYt14yZvMJjHadyr8O7UAUZ3H3bQSubb1t7yM75Ctgv1iM/
 oPXF7Whh/uuTdtenW91VwAwME1wYpTsN6i0WRzcNMTqDL7xGMYVDbTnAVadQ1/50zMy4
 ohfEGgBnZU9nsW6u4mGxsUSGFtW93pa7gB584ICe6D6nGAchxpt+y8XBFhUhIrdnhF+L
 T373OKyL67ftSVyF/gF3TOw/aF2Nq0ppreL69dlpq/FaoOLB+fYSWdwUxpWKBfawOf5R
 WXEmf5O+pA7ZLxe/dZsuW9ZmFtAW+cl3/NKy+EDHuayAON4mqgJCcSboEpg7N62u/eKq
 ynJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697365388; x=1697970188;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rw7lS+ohjqUkSHKT12XYG+b1i4hqAXQ9Djh+8O3O2O0=;
 b=QXnQvGbObrPqON1/xLexRmljOsLvy/6ihOPw13pBwhFG2Z1e2W6i/ZcUJZDChKBjmD
 oZW2KOhounjmW7ruDghm9sN9UgDAjhYq8hAi16GcRkLQyqD7U1SuQqwCVeAZsKSPqtDU
 o8EFLgRSHNBb6P9ABQ6ciIkL1Lru7ZCVkVuhv9sTeOIrgV0ThtNA1kx7DZEYxIwrovQ4
 lusS1nzlBVEksf5ZobmKYaVkPMlMDyyNkxW82BXazvP6fiBrqjjyrldKafSqHJqCkI0Z
 GbsZqAHjsKNrmoci7yNWJAHaCilNg3zCdYoW2P4K7+9g5e1z99IS5qKU0+0GmVZhkUGq
 J+3g==
X-Gm-Message-State: AOJu0Yz4CGWAHEvPH5LEkTfD4QMaW/A5ai4czoEFT3zQkQIavHGzhYW7
 FQa2/vCFQIyuOkjYGqYPh5Cbe3IfHj8=
X-Google-Smtp-Source: AGHT+IFs5Wtl0Xm2nZJVBmBAY7o+Ea5nstqiIaGdEt5AAmTwbAQs63rETNmbd2LqgZo4N0oP2ots9A==
X-Received: by 2002:a05:6402:354c:b0:53e:5a90:e57 with SMTP id
 f12-20020a056402354c00b0053e5a900e57mr5161373edd.37.1697365387686; 
 Sun, 15 Oct 2023 03:23:07 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-191-089-197.77.191.pool.telefonica.de.
 [77.191.89.197]) by smtp.gmail.com with ESMTPSA id
 co25-20020a0564020c1900b0053e36dd75dfsm3372304edb.35.2023.10.15.03.23.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 03:23:07 -0700 (PDT)
Date: Sun, 15 Oct 2023 10:23:03 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
CC: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org,
 philmd@linaro.org, Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
Subject: Re: [PATCH v2 1/3] via-ide: Fix legacy mode emulation
In-Reply-To: <alpine.LMD.2.03.2310141748380.3555@eik.bme.hu>
References: <cover.1696880742.git.balaton@eik.bme.hu>
 <f27e2af1a17e62ead8eda1e9e417f0f87f9c65f5.1696880742.git.balaton@eik.bme.hu>
 <af270749-a36f-4803-9d40-ad24521c4ea4@ilande.co.uk>
 <alpine.LMD.2.03.2310141748380.3555@eik.bme.hu>
Message-ID: <73D2ACAB-83C4-4EB6-BBD9-F025D9E8A533@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



Am 14=2E Oktober 2023 16:13:19 UTC schrieb BALATON Zoltan <balaton@eik=2Eb=
me=2Ehu>:
>On Sat, 14 Oct 2023, Mark Cave-Ayland wrote:
>> On 09/10/2023 20:54, BALATON Zoltan wrote:
>>=20
>>> The initial value for BARs were set in reset method for emulating
>>> legacy mode at start but this does not work because PCI code resets
>>> BARs after calling device reset method=2E Remove this ineffective
>>> default to avoid confusion=2E
>>>=20
>>> Instead move setting the BARs to a callback on writing the PCI config
>>> regsiter that sets legacy mode (which firmwares needing this mode seem
>>> to do) and fix their values to program it to use legacy port numbers
>>> in this case=2E This does not fully emulate what the data sheet says
>>> (which is not very clear on this) but it implements enogh to allow
>>> both modes as used by firmwares of machines we emulate=2E
>>>=20
>>> Signed-off-by: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>>> ---
>>>   hw/ide/via=2Ec | 41 ++++++++++++++++++++++++++++++++++++-----
>>>   1 file changed, 36 insertions(+), 5 deletions(-)
>>>=20
>>> diff --git a/hw/ide/via=2Ec b/hw/ide/via=2Ec
>>> index fff23803a6=2E=2E43e8af8d69 100644
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
>>> @@ -159,6 +154,41 @@ static void via_ide_reset(DeviceState *dev)
>>>       pci_set_long(pci_conf + 0xc0, 0x00020001);
>>>   }
>>>   +static void via_ide_cfg_write(PCIDevice *pd, uint32_t addr,
>>> +                              uint32_t val, int len)
>>> +{
>>> +    pci_default_write_config(pd, addr, val, len);
>>> +    /*
>>> +     * Bits 0 and 2 of the PCI programming interface register select =
between
>>> +     * legacy and native mode for the two IDE channels=2E We don't em=
ulate this
>>> +     * because we cannot easily switch between ISA and PCI in QEMU so=
 instead
>>=20
>> As per my previous email, this statement is demonstrably false: this is=
 now achievable using the portio_list*() APIs=2E
>>=20
>>> +     * when guest selects legacy mode we set the PCI BARs to legacy p=
orts which
>>> +     * works the same=2E We also don't care about setting each channe=
l separately
>>> +     * as no guest is known to do or need that=2E We only do this whe=
n BARs are
>>> +     * unset when writing this register as logs from real hardware sh=
ow that
>>> +     * setting legacy mode after BARs were set it will still use port=
s set by
>>> +     * BARs not ISA ports (e=2Eg=2E pegasos2 Linux does this after fi=
rmware set
>>> +     * native mode and programmed BARs and calls it non-100% native m=
ode)=2E
>>> +     * But if 0x8a is written righr after reset without setting BARs =
then we
>>> +     * want legacy ports (this is done by the AmigaOne firmware)=2E
>>> +     */
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
>> Another hint that this is not the right way to be doing this: the value=
s you are placing in BARS 1 and 3 are illegal=2E PCI IO BARs have bit 1 for=
ced to 0 and bit 0 set to 1 which forces a minimum alignment of 4, so eithe=
r the addresses 0x3f6/0x376 are being rounded internally to 0x3f4/0x374 and=
/or you're lucky that this just happens to work on QEMU=2E
>
>The data sheet lists these values for legacy mode bur it seems that bit 1=
 is ignored for BAR here and it ends up set to 0x3x4 with the actual reg ma=
pped to 0x3x7 for both values ending in 4 or 6 here and both works the same=
 with AmigaOS even if I change the values here to 0x3[7f]4 so I can do that=
 and that should then match the default values for these regs but not match=
 the values listed for legacy mode so the data sheet is wrong either way=2E

The datasheet lists the command BARs to be mapped to 0x3x4=2E The command =
registers (legacy 0x3x6) are mapped at offset 2 in those BARs=2E So mapping=
 the BARs to 0x3x4 would map the registers to their respective legacy addre=
sses, no?

> It still does not make sense to set these in reset method which will be =
overwritten so only works if I set them here=2E
>
>> Using the portio_list*() APIs really is the right way to implement this=
 to avoid being affected by such issues=2E
>
>Can you provide an alternative patch using portio_list? I don't know how =
to do that and have no example to follow either so it would be hard for me =
to figure out=2E Or give some pointers on how to do this if I missed someth=
ing=2E
>
>Regards,
>BALATON Zoltan
>
>>>   static void via_ide_realize(PCIDevice *dev, Error **errp)
>>>   {
>>>       PCIIDEState *d =3D PCI_IDE(dev);
>>> @@ -221,6 +251,7 @@ static void via_ide_class_init(ObjectClass *klass,=
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

