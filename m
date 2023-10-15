Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6DB7C98B1
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 12:36:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrySw-0006tb-Id; Sun, 15 Oct 2023 06:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qrySu-0006tE-FF
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 06:35:20 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qrySp-00033L-D1
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 06:35:20 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9b9a494cc59so527655166b.3
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 03:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697366113; x=1697970913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pQE0HoZ577wz+WUreR7XMr5R1gx3DLcRoEdoRRRvLsU=;
 b=OYBvpiZAtJUQ1/ceLL6xJHrBjATrf4/IzYzFDaWB0T2GMt187f/ZZFRCnGVbqF78C9
 zT3xW2CauotFpZz6LB26IA5HmdzlnOx2Eq0iOd3nzDd+oRq9hcsBbAwOgIuMC7Ch+vXu
 peUYB902ZcTI3ghehtQ0gMPk+2UQm8JZsTGZGv6pib7QbYkMTvYozVeRQUYdBt9xGuvz
 1bS8VhHyz7ZVmJPDYXNG18K03or/v/21Hm0DzI9r/9BEAcPOZTknwGJbP3BRXf7W6440
 5QgP0Bb+dzC74ZmHpUdhlfMprlsrjnB1GTEI+sLRcXpOko/pj4MKEKmDchgNXfGQTZmK
 oupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697366113; x=1697970913;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pQE0HoZ577wz+WUreR7XMr5R1gx3DLcRoEdoRRRvLsU=;
 b=qWjT9lR3jsdy07eLCmII10l6dE5EqRnwBX2NfNc290CGJruH0UW1cq8KeIJRQMVMGo
 0vo6XKUQBHVNXvKgiZ4gJ20b6nrqoUh6W9uJ7V+cXKMmvbikDGauYwY4S4Ocu3/VTXJx
 CtkaLhalL8UTR4MjgzyPxTcsE9qFoHN28Uy0Umal5P3FSvlLX3Ymk2KVjqKAxeG4b1FO
 BbqMTTy4abhaFf3iBw0wO6Su9KklzrBKy/BCM3hriISOSmPjIg8NMaCRQh35CA0KDnnL
 5K1i1EUEUuO9rHBY4n2TYrvC/z3pm/66S+zi8LjVh+YP/HsBH4w//bkClPFAMH3RYbc5
 rLvg==
X-Gm-Message-State: AOJu0YwSSlEOVcC0fe8gBilucawpbFN5JjAnm88eNDT+Io6uWA/iKbTk
 vF1VIKGT2rQkJy9KCDE7O04=
X-Google-Smtp-Source: AGHT+IE/wUDyTGrhFGFUGhTet2wfFZUhUtuAM5J1L8NvJvkXcx0AouZznUyLChJ4waXfCauAJEOlVQ==
X-Received: by 2002:a17:907:3f20:b0:9c1:9bc5:c260 with SMTP id
 hq32-20020a1709073f2000b009c19bc5c260mr900587ejc.14.1697366112769; 
 Sun, 15 Oct 2023 03:35:12 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-191-089-197.77.191.pool.telefonica.de.
 [77.191.89.197]) by smtp.gmail.com with ESMTPSA id
 j22-20020a170906411600b00993664a9987sm2098380ejk.103.2023.10.15.03.35.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 03:35:12 -0700 (PDT)
Date: Sun, 15 Oct 2023 10:35:09 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH v3] hw/isa/vt82c686: Respect SCI interrupt assignment
In-Reply-To: <7f0a480e-3b30-36d8-daaf-cb817dcad3ca@eik.bme.hu>
References: <20231005115159.81202-1-shentey@gmail.com>
 <7f0a480e-3b30-36d8-daaf-cb817dcad3ca@eik.bme.hu>
Message-ID: <BB6997B6-FC5D-4CD3-B135-FE146919B0E1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



Am 5=2E Oktober 2023 12:45:02 UTC schrieb BALATON Zoltan <balaton@eik=2Ebm=
e=2Ehu>:
>On Thu, 5 Oct 2023, Bernhard Beschow wrote:
>> According to the datasheet, SCI interrupts of the power management func=
tion
>> aren't routed through the PCI pins but rather directly to the integrate=
d PIC=2E
>> The routing is configurable through the ACPI interrupt select register =
at offset
>> 0x42 in the PCI configuration space of the power management function=2E
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>>=20
>> ---
>>=20
>> v3:
>> * Rename SCI irq attribute to sci_irq (Zoltan)
>> * Fix confusion about location of ACPI interrupt select register (Zolta=
n)
>> * Model SCI as named GPIO (Bernhard)
>> * Perform upcast via macro rather than sub structure selection (Bernhar=
d)
>>=20
>> v2:
>> * Introduce named constants for the ACPI interrupt select register at o=
ffset
>>  0x42 (Phil)
>> ---
>> hw/isa/vt82c686=2Ec | 48 +++++++++++++++++++++++++++++++++++-----------=
-
>> 1 file changed, 36 insertions(+), 12 deletions(-)
>>=20
>> diff --git a/hw/isa/vt82c686=2Ec b/hw/isa/vt82c686=2Ec
>> index 57bdfb4e78=2E=2Eaeb9434a46 100644
>> --- a/hw/isa/vt82c686=2Ec
>> +++ b/hw/isa/vt82c686=2Ec
>> @@ -40,12 +40,17 @@
>> #define TYPE_VIA_PM "via-pm"
>> OBJECT_DECLARE_SIMPLE_TYPE(ViaPMState, VIA_PM)
>>=20
>> +#define VIA_PM_SCI_SELECT_OFS 0x42
>> +#define VIA_PM_SCI_SELECT_MASK 0xf
>> +
>> struct ViaPMState {
>>     PCIDevice dev;
>>     MemoryRegion io;
>>     ACPIREGS ar;
>>     APMState apm;
>>     PMSMBus smb;
>> +
>> +    qemu_irq sci_irq;
>> };
>>=20
>> static void pm_io_space_update(ViaPMState *s)
>> @@ -148,18 +153,7 @@ static void pm_update_sci(ViaPMState *s)
>>                    ACPI_BITMASK_POWER_BUTTON_ENABLE |
>>                    ACPI_BITMASK_GLOBAL_LOCK_ENABLE |
>>                    ACPI_BITMASK_TIMER_ENABLE)) !=3D 0);
>> -    if (pci_get_byte(s->dev=2Econfig + PCI_INTERRUPT_PIN)) {
>> -        /*
>> -         * FIXME:
>> -         * Fix device model that realizes this PM device and remove
>> -         * this work around=2E
>> -         * The device model should wire SCI and setup
>> -         * PCI_INTERRUPT_PIN properly=2E
>> -         * If PIN# =3D 0(interrupt pin isn't used), don't raise SCI as
>> -         * work around=2E
>> -         */
>> -        pci_set_irq(&s->dev, sci_level);
>> -    }
>> +    qemu_set_irq(s->sci_irq, sci_level);
>
>I still think this it more complex that it should be and what's in via_is=
a_set_pm_irq() below should be here instead and drop all the named gpio wiz=
ardry that's just unneeded complication here=2E

The bigger picture of this patch is to render pm_update_sci() redundant to=
 acpi_update_sci() and use that=2E It wants a qemu_irq as one of its parame=
ters which this patch provides=2E

There is one obstacle before acpi_update_sci() can be reused but that shou=
ld be fixable=2E I'll send a v5 later=2E

Best regards,
Bernhard

>
>Regards=2E
>BALATON Zoltan
>
>>     /* schedule a timer interruption if needed */
>>     acpi_pm_tmr_update(&s->ar, (s->ar=2Epm1=2Eevt=2Een & ACPI_BITMASK_T=
IMER_ENABLE) &&
>>                        !(pmsts & ACPI_BITMASK_TIMER_STATUS));
>> @@ -213,6 +207,13 @@ static void via_pm_realize(PCIDevice *dev, Error *=
*errp)
>>     acpi_pm1_cnt_init(&s->ar, &s->io, false, false, 2, false);
>> }
>>=20
>> +static void via_pm_init(Object *obj)
>> +{
>> +    ViaPMState *s =3D VIA_PM(obj);
>> +
>> +    qdev_init_gpio_out_named(DEVICE(obj), &s->sci_irq, "sci", 1);
>> +}
>> +
>> typedef struct via_pm_init_info {
>>     uint16_t device_id;
>> } ViaPMInitInfo;
>> @@ -238,6 +239,7 @@ static void via_pm_class_init(ObjectClass *klass, v=
oid *data)
>> static const TypeInfo via_pm_info =3D {
>>     =2Ename          =3D TYPE_VIA_PM,
>>     =2Eparent        =3D TYPE_PCI_DEVICE,
>> +    =2Einstance_init =3D via_pm_init,
>>     =2Einstance_size =3D sizeof(ViaPMState),
>>     =2Eabstract      =3D true,
>>     =2Einterfaces =3D (InterfaceInfo[]) {
>> @@ -568,9 +570,27 @@ static const VMStateDescription vmstate_via =3D {
>>     }
>> };
>>=20
>> +static void via_isa_set_pm_irq(void *opaque, int n, int level)
>> +{
>> +    ViaISAState *s =3D opaque;
>> +    PCIDevice *pci_dev =3D PCI_DEVICE(&s->pm);
>> +    uint8_t irq =3D pci_get_byte(pci_dev->config + VIA_PM_SCI_SELECT_O=
FS)
>> +                  & VIA_PM_SCI_SELECT_MASK;
>> +
>> +    if (irq =3D=3D 2) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "IRQ 2 for PM controller is res=
erved");
>> +        return;
>> +    }
>> +
>> +    if (irq !=3D 0) {
>> +        qemu_set_irq(s->isa_irqs_in[irq], level);
>> +    }
>> +}
>> +
>> static void via_isa_init(Object *obj)
>> {
>>     ViaISAState *s =3D VIA_ISA(obj);
>> +    DeviceState *dev =3D DEVICE(s);
>>=20
>>     object_initialize_child(obj, "rtc", &s->rtc, TYPE_MC146818_RTC);
>>     object_initialize_child(obj, "ide", &s->ide, TYPE_VIA_IDE);
>> @@ -578,6 +598,8 @@ static void via_isa_init(Object *obj)
>>     object_initialize_child(obj, "uhci2", &s->uhci[1], TYPE_VT82C686B_U=
SB_UHCI);
>>     object_initialize_child(obj, "ac97", &s->ac97, TYPE_VIA_AC97);
>>     object_initialize_child(obj, "mc97", &s->mc97, TYPE_VIA_MC97);
>> +
>> +    qdev_init_gpio_in_named(dev, via_isa_set_pm_irq, "sci", 1);
>> }
>>=20
>> static const TypeInfo via_isa_info =3D {
>> @@ -704,6 +726,8 @@ static void via_isa_realize(PCIDevice *d, Error **e=
rrp)
>>     if (!qdev_realize(DEVICE(&s->pm), BUS(pci_bus), errp)) {
>>         return;
>>     }
>> +    qdev_connect_gpio_out_named(DEVICE(&s->pm), "sci", 0,
>> +                                qdev_get_gpio_in_named(DEVICE(d), "sci=
", 0));
>>=20
>>     /* Function 5: AC97 Audio */
>>     qdev_prop_set_int32(DEVICE(&s->ac97), "addr", d->devfn + 5);
>> 

