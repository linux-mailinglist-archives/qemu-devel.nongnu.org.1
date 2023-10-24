Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A367D4802
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 09:09:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvBWy-0000S3-4P; Tue, 24 Oct 2023 03:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qvBWo-0000QX-IC; Tue, 24 Oct 2023 03:08:39 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qvBWl-0002Je-JC; Tue, 24 Oct 2023 03:08:37 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9c773ac9b15so523662366b.2; 
 Tue, 24 Oct 2023 00:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698131313; x=1698736113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=bkHrkCAETsExZnAJgB7UGDqEE810OuGSAxdYPV/tCAk=;
 b=U5wOEm/CYlqvaof4S4e6Fdi4jI5SXiQk6Ro7JlHXAnSNj94p0KLnvtVaIkKQFU9iSG
 6OYqHmC1adJHRlhtkmN2bNP2Ta8Ht+BVh47Or+wrQF1bT/UjL1YY2XYFBfMzHHNGuKlx
 Nny2yE2YiaidxNUecyf6NrhpGr9ts6g0dg5U7wAKs2ewyfX/x/ekYdJE+8c75aP4NG0v
 r//unLaiE3yvnjd1O86UwlblSNKNu7ibPgAUyPc9+sunvR1hPeJpMHUfZei+knWn5U8t
 t4+NbP+QSbmkOkiDCjGhzPBub8+WTkCRpoZnNKVrH8tASIB/xqrzbJzgUMnyqNWxWxOa
 oZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698131313; x=1698736113;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bkHrkCAETsExZnAJgB7UGDqEE810OuGSAxdYPV/tCAk=;
 b=OT8gfH/B0h8z0EJYrrLGXSOqs0Yb/Y3ccEGNubookD4ehhj4sMBHWXUa7EVouMg4RO
 IwYOZ1QF9H949YUwbieoEkrfykSKNFR7IfhPByFXrdOtbfrC9o6qHnm5WZJ3gkV96RDn
 fL6dKraRHlhxhe7z4C2qbppMB/vDV5tJFVL8xQuXpC7QGGbQ4l9cOenmGvHjaXQvMCOZ
 2He2rCo+4SJJiczRQzyU+jQUUluauK3qksEIYqvhOgWqAlaEXCKEaCLGwnlHijha8Zpl
 OgM1sDgLbxEEzOTOEqEw1MVqtUfZSOdpqp7f8pWq33Fhkpntmy6Sso6vgt+uxwnzKM18
 oeAQ==
X-Gm-Message-State: AOJu0Yx3Tu+Nt47Fh0pz5HjAQ1nlPzH9ILWRYnjnwDORVlpO2rJ3Qn1J
 dAuPfLtEOxgJSSEfUMEICusFmMUapps=
X-Google-Smtp-Source: AGHT+IEyFAtz8gW7ETGtSWoGdFCLo4/Uzc0dds6sbm092XEjOZi/yp2FWkIKtyJPjA41ksXOnb4hqQ==
X-Received: by 2002:a17:907:5cb:b0:9bd:a34b:eed with SMTP id
 wg11-20020a17090705cb00b009bda34b0eedmr9536845ejb.59.1698131312747; 
 Tue, 24 Oct 2023 00:08:32 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-078-055-147-137.78.55.pool.telefonica.de.
 [78.55.147.137]) by smtp.gmail.com with ESMTPSA id
 ze15-20020a170906ef8f00b009bf7a4d591bsm7692946ejb.45.2023.10.24.00.08.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 00:08:32 -0700 (PDT)
Date: Tue, 24 Oct 2023 07:08:23 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, jsnow@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, balaton@eik.bme.hu,
 philmd@linaro.org
Subject: Re: [PATCH 1/2] ide/pci.c: introduce pci_ide_update_mode() function
In-Reply-To: <2601c66e-bd00-4df6-8a74-c8b2f81b052d@ilande.co.uk>
References: <20231019130452.508426-1-mark.cave-ayland@ilande.co.uk>
 <20231019130452.508426-2-mark.cave-ayland@ilande.co.uk>
 <B2C0A4CE-0382-48F0-A513-8AD69960F2BF@gmail.com>
 <4C3F58DB-2AAA-43CA-8576-07CFBB66066D@gmail.com>
 <2601c66e-bd00-4df6-8a74-c8b2f81b052d@ilande.co.uk>
Message-ID: <15CDD7B3-CDCC-4E41-B35C-4EC510CFBA0D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



Am 23=2E Oktober 2023 21:06:11 UTC schrieb Mark Cave-Ayland <mark=2Ecave-a=
yland@ilande=2Eco=2Euk>:
>On 23/10/2023 18:19, Bernhard Beschow wrote:
>
>> Am 22=2E Oktober 2023 22:06:30 UTC schrieb Bernhard Beschow <shentey@gm=
ail=2Ecom>:
>>>=20
>>>=20
>>> Am 19=2E Oktober 2023 13:04:51 UTC schrieb Mark Cave-Ayland <mark=2Eca=
ve-ayland@ilande=2Eco=2Euk>:
>>>> This function reads the value of the PCI_CLASS_PROG register for PCI =
IDE
>>>> controllers and configures the PCI BARs and/or IDE ioports accordingl=
y=2E
>>>>=20
>>>> In the case where we switch to legacy mode, the PCI BARs are set to r=
eturn zero
>>>> (as suggested in the "PCI IDE Controller" specification), the legacy =
IDE ioports
>>>> are enabled, and the PCI interrupt pin cleared to indicate legacy IRQ=
 routing=2E
>>>>=20
>>>> Conversely when we switch to native mode, the legacy IDE ioports are =
disabled
>>>> and the PCI interrupt pin set to indicate native IRQ routing=2E The c=
ontents of
>>>> the PCI BARs are unspecified, but this is not an issue since if a PCI=
 IDE
>>>> controller has been switched to native mode then its BARs will need t=
o be
>>>> programmed=2E
>>>>=20
>>>> Signed-off-by: Mark Cave-Ayland <mark=2Ecave-ayland@ilande=2Eco=2Euk>
>>>> ---
>>>> hw/ide/pci=2Ec         | 90 +++++++++++++++++++++++++++++++++++++++++=
+++
>>>> include/hw/ide/pci=2Eh |  1 +
>>>> 2 files changed, 91 insertions(+)
>>>>=20
>>>> diff --git a/hw/ide/pci=2Ec b/hw/ide/pci=2Ec
>>>> index a25b352537=2E=2E9eb30af632 100644
>>>> --- a/hw/ide/pci=2Ec
>>>> +++ b/hw/ide/pci=2Ec
>>>> @@ -104,6 +104,96 @@ const MemoryRegionOps pci_ide_data_le_ops =3D {
>>>>      =2Eendianness =3D DEVICE_LITTLE_ENDIAN,
>>>> };
>>>>=20
>>>> +static const MemoryRegionPortio ide_portio_list[] =3D {
>>>> +    { 0, 8, 1, =2Eread =3D ide_ioport_read, =2Ewrite =3D ide_ioport_=
write },
>>>> +    { 0, 1, 2, =2Eread =3D ide_data_readw, =2Ewrite =3D ide_data_wri=
tew },
>>>> +    { 0, 1, 4, =2Eread =3D ide_data_readl, =2Ewrite =3D ide_data_wri=
tel },
>>>> +    PORTIO_END_OF_LIST(),
>>>> +};
>>>> +
>>>> +static const MemoryRegionPortio ide_portio2_list[] =3D {
>>=20
>> Although the naming seems familiar: What about renaming both lists to s=
omething like ide_portio_primary_list resp=2E ide_portio_secondary_list? Ha=
ving one list carrying a number in its name while omitting it for the other=
 I find rather confusing=2E
>
>The two different portio_lists don't represent the primary and secondary =
interfaces though: they represent the command and data ports for a single i=
nterface=2E

Ah, right=2E

> I've left the naming as-is (at least for now) so that all of the IDEBus =
fields, ISA IDE ioports and PCI IDE ioports all share the same naming conve=
ntion=2E

Okay=2E At some point we should really harmonize the names to avoid above =
confusion=2E The PCI IDE BAR code does a much better job at naming and coul=
d serve as a template=2E Then all IDE code would clearly communicate that t=
hese are all the same concepts=2E I could send a patch for it once this ser=
ies is in=2E

>
>>>> +    { 0, 1, 1, =2Eread =3D ide_status_read, =2Ewrite =3D ide_ctrl_wr=
ite },
>>>> +    PORTIO_END_OF_LIST(),
>>>> +};
>>>> +
>>>> +void pci_ide_update_mode(PCIIDEState *s)
>>>> +{
>>>> +    PCIDevice *d =3D PCI_DEVICE(s);
>>>> +    uint8_t mode =3D d->config[PCI_CLASS_PROG];
>>>> +
>>>> +    switch (mode) {
>>>=20
>>> Maybe
>>>=20
>>>   switch (mode & 0xf) {
>>>=20
>>> here such that only the bits relevant to the PCI IDE controller specif=
ication are analyzed?

Due to the above conversation I realize that s->bus[] could be iterated ov=
er such that only the two bits of each bus could be switch()ed over=2E This=
 would avoid some duplicate code, model the specification closer and allow =
for catching illegal states=2E Illegal states could be logged as guest erro=
rs=2E But it would also complicate dealing with the interrupt pin=2E So thi=
s might be a future extension=2E

Best regards,
Bernhard

>>> Then we can omit the high '8' nibble in the case labels which indicate=
 bus master capability which is obviously out of scope of the switch statem=
ent (since you're not touching the BM DMA BAR)=2E
>>>=20
>>>> +    case 0x8a:
>>>=20
>>> Perhaps we could add a
>>>=20
>>>   case 0x0:
>>>=20
>>> in front of the above label for compatibility with PIIX-IDE? That way,=
 this function could be reused in the future for resetting PIIX-IDE=2E
>>>=20
>>>> +        /* Both channels legacy mode */
>>>> +
>>>> +        /* Zero BARs */
>>>> +        pci_set_long(d->config + PCI_BASE_ADDRESS_0, 0x0);
>>>> +        pci_set_long(d->config + PCI_BASE_ADDRESS_1, 0x0);
>>>> +        pci_set_long(d->config + PCI_BASE_ADDRESS_2, 0x0);
>>>> +        pci_set_long(d->config + PCI_BASE_ADDRESS_3, 0x0);
>>>> +
>>>> +        /* Clear interrupt pin */
>>>> +        pci_config_set_interrupt_pin(d->config, 0);
>>>=20
>>> Do we really need to toggle the interrupt pin in this function? Or is =
this VIA-specific? This byte isn't even defined for PIIX-IDE=2E
>>>=20
>>> Best regards,
>>> Bernhard
>>>=20
>>>> +
>>>> +        /* Add legacy IDE ports */
>>>> +        if (!s->bus[0]=2Eportio_list=2Eowner) {
>>>> +            portio_list_init(&s->bus[0]=2Eportio_list, OBJECT(d),
>>>> +                             ide_portio_list, &s->bus[0], "ide");
>>>> +            portio_list_add(&s->bus[0]=2Eportio_list,
>>>> +                            pci_address_space_io(d), 0x1f0);
>>>> +        }
>>>> +
>>>> +        if (!s->bus[0]=2Eportio2_list=2Eowner) {
>>>> +            portio_list_init(&s->bus[0]=2Eportio2_list, OBJECT(d),
>>>> +                             ide_portio2_list, &s->bus[0], "ide");
>>>> +            portio_list_add(&s->bus[0]=2Eportio2_list,
>>>> +                            pci_address_space_io(d), 0x3f6);
>>>> +        }
>>>> +
>>>> +        if (!s->bus[1]=2Eportio_list=2Eowner) {
>>>> +            portio_list_init(&s->bus[1]=2Eportio_list, OBJECT(d),
>>>> +                                ide_portio_list, &s->bus[1], "ide");
>>>> +            portio_list_add(&s->bus[1]=2Eportio_list,
>>>> +                            pci_address_space_io(d), 0x170);
>>>> +        }
>>>> +
>>>> +        if (!s->bus[1]=2Eportio2_list=2Eowner) {
>>>> +            portio_list_init(&s->bus[1]=2Eportio2_list, OBJECT(d),
>>>> +                             ide_portio2_list, &s->bus[1], "ide");
>>>> +            portio_list_add(&s->bus[1]=2Eportio2_list,
>>>> +                            pci_address_space_io(d), 0x376);
>>>> +        }
>>>> +        break;
>>>> +
>>>> +    case 0x8f:
>>>> +        /* Both channels native mode */
>>>> +
>>>> +        /* Set interrupt pin */
>>>> +        pci_config_set_interrupt_pin(d->config, 1);
>>>> +
>>>> +        /* Remove legacy IDE ports */
>>>> +        if (s->bus[0]=2Eportio_list=2Eowner) {
>>>> +            portio_list_del(&s->bus[0]=2Eportio_list);
>>>> +            portio_list_destroy(&s->bus[0]=2Eportio_list);
>>>> +        }
>>>> +
>>>> +        if (s->bus[0]=2Eportio2_list=2Eowner) {
>>>> +            portio_list_del(&s->bus[0]=2Eportio2_list);
>>>> +            portio_list_destroy(&s->bus[0]=2Eportio2_list);
>>>> +        }
>>>> +
>>>> +        if (s->bus[1]=2Eportio_list=2Eowner) {
>>>> +            portio_list_del(&s->bus[1]=2Eportio_list);
>>>> +            portio_list_destroy(&s->bus[1]=2Eportio_list);
>>>> +        }
>>>> +
>>>> +        if (s->bus[1]=2Eportio2_list=2Eowner) {
>>>> +            portio_list_del(&s->bus[1]=2Eportio2_list);
>>>> +            portio_list_destroy(&s->bus[1]=2Eportio2_list);
>>>> +        }
>>>> +        break;
>>>> +    }
>>>> +}
>>>> +
>>>> static IDEState *bmdma_active_if(BMDMAState *bmdma)
>>>> {
>>>>      assert(bmdma->bus->retry_unit !=3D (uint8_t)-1);
>>>> diff --git a/include/hw/ide/pci=2Eh b/include/hw/ide/pci=2Eh
>>>> index 1ff469de87=2E=2Ea814a0a7c3 100644
>>>> --- a/include/hw/ide/pci=2Eh
>>>> +++ b/include/hw/ide/pci=2Eh
>>>> @@ -61,6 +61,7 @@ void bmdma_cmd_writeb(BMDMAState *bm, uint32_t val)=
;
>>>> void bmdma_status_writeb(BMDMAState *bm, uint32_t val);
>>>> extern MemoryRegionOps bmdma_addr_ioport_ops;
>>>> void pci_ide_create_devs(PCIDevice *dev);
>>>> +void pci_ide_update_mode(PCIIDEState *s);
>>>>=20
>>>> extern const VMStateDescription vmstate_ide_pci;
>>>> extern const MemoryRegionOps pci_ide_cmd_le_ops;
>
>
>ATB,
>
>Mark=2E
>

