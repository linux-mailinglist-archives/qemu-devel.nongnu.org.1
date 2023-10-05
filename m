Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A56797B9B5F
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 09:28:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoIly-0007Tw-1H; Thu, 05 Oct 2023 03:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qoIlr-0007TF-EZ
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 03:27:43 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qoIlo-0005tF-VY
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 03:27:42 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5347e657a11so981956a12.2
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 00:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696490859; x=1697095659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LPHGy8P90p2PQ8Yre+qXdBWq8DvQ5v28gr4h/yj9HzE=;
 b=UG9rGVjH8FHJdpgJ1tmpvWtLpPHu17fmNiLdfxCyfTSuNSiYxdq2E/YD5M4bhsYABi
 y1LZtKxvsAgcH3ccdAJxIdOZqXY8NRO+/ynLbFDE3pPolLnE9de24TkwEMgx1IVDWw3S
 TBmOo5ODA379ppmIRwvsVVEJEGq/yy+XZ3m1wxVLqCkY08wtkuChgJzHr19t9MVs+1BH
 JN5cvtplU6D9tDC2jObd2uXj1Wtz+hATrmphlEBsbHmOLTD6aChHyF9tR31sp7t6J8qZ
 VKmOGts4rN/E8BOaX+QSp3X3kMkNIc1wQc53h/CGKlXpVPeTNLvhR2LcvlxkQOnqBnU8
 TSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696490859; x=1697095659;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LPHGy8P90p2PQ8Yre+qXdBWq8DvQ5v28gr4h/yj9HzE=;
 b=OGyp0zXp4syTK7GuulHrc1nMHVt/ux2wnzekzby+oUzedPA5DHVz/Pocv2DIGO0Nqn
 l8QDrBjMpOd0270nO3NPPMhvar/OIDvbxuL8FnTqsJv1pVciBGzeVyi6+LvfHNt+Yw1r
 GSdyM2wcHByDRUo8ROfGFuc4jBkE+VT6lWhjvDtK4VtccDHfw5muDG6DEXjvYyNcpLhy
 nAmAUOFP3jDZw9GVA2CpINbZLZ4g12qv0osmSeJg4WElrJQ9ag/O4Lkbp353hKYSoNZS
 koRapzKV/la5yY5FqHy8ztmzEW8Hkif/2+S+LFCkT5BPjPp44GmT+S7xSVLdqyB8kzq5
 TiIA==
X-Gm-Message-State: AOJu0YzU6w8qxGIFLNcsere8+9J6+xYZKzEDDwgfxHMLmOPay/OfBonJ
 gGFPStgrK30I2iOPkm9T8zw=
X-Google-Smtp-Source: AGHT+IEtG8rU+3qhkYJN1UUve/BV1NPKev4YaT9ZXLlfUMc1VDajrAxMvWvNmBoWYyid3dhFTnYcyA==
X-Received: by 2002:a17:906:cd1:b0:992:c8d7:b66f with SMTP id
 l17-20020a1709060cd100b00992c8d7b66fmr3683139ejh.75.1696490859186; 
 Thu, 05 Oct 2023 00:27:39 -0700 (PDT)
Received: from ?IPv6:::1?
 (p200300faaf2af200ad058901f594a09a.dip0.t-ipconnect.de.
 [2003:fa:af2a:f200:ad05:8901:f594:a09a])
 by smtp.gmail.com with ESMTPSA id
 s10-20020a170906354a00b00997cce73cc7sm685734eja.29.2023.10.05.00.27.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 00:27:38 -0700 (PDT)
Date: Thu, 05 Oct 2023 07:27:34 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2] hw/isa/vt82c686: Respect SCI interrupt assignment
In-Reply-To: <c786c82e-88bb-5333-1b74-a1bf0fd2cad5@eik.bme.hu>
References: <20231004105709.16994-1-shentey@gmail.com>
 <c786c82e-88bb-5333-1b74-a1bf0fd2cad5@eik.bme.hu>
Message-ID: <4D35354B-1289-4B67-B913-7EC5F4D6D07F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52e.google.com
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



Am 4=2E Oktober 2023 12:28:58 UTC schrieb BALATON Zoltan <balaton@eik=2Ebm=
e=2Ehu>:
>On Wed, 4 Oct 2023, Bernhard Beschow wrote:
>> According to the datasheet, SCI interrupts of the power management func=
tion
>> aren't routed through the PCI pins but rather directly to the integrate=
d PIC=2E
>> The routing is configurable through the ACPI interrupt select register =
at offset
>> 0x42 in the PCI configuration space of the ISA function=2E
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>=20
>> ---
>>=20
>> v2:
>> * Introduce named constants for the ACPI interrupt select register at o=
ffset
>>  0x42 (Phil)
>> ---
>> hw/isa/vt82c686=2Ec | 47 +++++++++++++++++++++++++++++++++++-----------=
-
>> 1 file changed, 35 insertions(+), 12 deletions(-)
>>=20
>> diff --git a/hw/isa/vt82c686=2Ec b/hw/isa/vt82c686=2Ec
>> index 57bdfb4e78=2E=2E93ffaaf706 100644
>> --- a/hw/isa/vt82c686=2Ec
>> +++ b/hw/isa/vt82c686=2Ec
>> @@ -46,6 +46,8 @@ struct ViaPMState {
>>     ACPIREGS ar;
>>     APMState apm;
>>     PMSMBus smb;
>> +
>> +    qemu_irq irq;
>
>Is it better to name this sci_irq because there seems to be an smi_irq to=
o? Also there seems to be no SCI pin but there's an SMI pin so does this sc=
i_irq need to be forwaeded to the ISA bridge and exposed as a qemu_gpio or =
could it just set the ISA IRQ within its own handler in the via_pm object?

Triggering the PIC in the PM function seems more complicated since ISA fun=
ction embeds PM function and also PM function is implemented before ISA fun=
ction, so this would create nesting problems in the code=2E Either way, bot=
h approaches need to sneak into the other PCI function's data, so I'd keep =
via_isa_set_pm_irq() and just update the constants=2E

> There are also other registers that select between SMI and SCI, do those=
 need to be taken into account?

Maybe later=2E The current code already made the decision to use SCI by tr=
iggering the PIC, so I'd declare this to be out of scope for now=2E

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan
>
>> };
>>=20
>> static void pm_io_space_update(ViaPMState *s)
>> @@ -148,18 +150,7 @@ static void pm_update_sci(ViaPMState *s)
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
>> +    qemu_set_irq(s->irq, sci_level);
>>     /* schedule a timer interruption if needed */
>>     acpi_pm_tmr_update(&s->ar, (s->ar=2Epm1=2Eevt=2Een & ACPI_BITMASK_T=
IMER_ENABLE) &&
>>                        !(pmsts & ACPI_BITMASK_TIMER_STATUS));
>> @@ -213,6 +204,13 @@ static void via_pm_realize(PCIDevice *dev, Error *=
*errp)
>>     acpi_pm1_cnt_init(&s->ar, &s->io, false, false, 2, false);
>> }
>>=20
>> +static void via_pm_init(Object *obj)
>> +{
>> +    ViaPMState *s =3D VIA_PM(obj);
>> +
>> +    qdev_init_gpio_out(DEVICE(obj), &s->irq, 1);
>> +}
>> +
>> typedef struct via_pm_init_info {
>>     uint16_t device_id;
>> } ViaPMInitInfo;
>> @@ -238,6 +236,7 @@ static void via_pm_class_init(ObjectClass *klass, v=
oid *data)
>> static const TypeInfo via_pm_info =3D {
>>     =2Ename          =3D TYPE_VIA_PM,
>>     =2Eparent        =3D TYPE_PCI_DEVICE,
>> +    =2Einstance_init =3D via_pm_init,
>>     =2Einstance_size =3D sizeof(ViaPMState),
>>     =2Eabstract      =3D true,
>>     =2Einterfaces =3D (InterfaceInfo[]) {
>> @@ -545,6 +544,9 @@ static const TypeInfo vt8231_superio_info =3D {
>> #define TYPE_VIA_ISA "via-isa"
>> OBJECT_DECLARE_SIMPLE_TYPE(ViaISAState, VIA_ISA)
>>=20
>> +#define VIA_ISA_SCI_SELECT_OFS 0x42
>> +#define VIA_ISA_SCI_SELECT_MASK 0xf
>> +
>> struct ViaISAState {
>>     PCIDevice dev;
>>     qemu_irq cpu_intr;
>> @@ -568,9 +570,26 @@ static const VMStateDescription vmstate_via =3D {
>>     }
>> };
>>=20
>> +static void via_isa_set_pm_irq(void *opaque, int n, int level)
>> +{
>> +    ViaISAState *s =3D opaque;
>> +    uint8_t irq =3D pci_get_byte(s->pm=2Edev=2Econfig + VIA_ISA_SCI_SE=
LECT_OFS)
>> +                  & VIA_ISA_SCI_SELECT_MASK;
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
>> @@ -578,6 +597,8 @@ static void via_isa_init(Object *obj)
>>     object_initialize_child(obj, "uhci2", &s->uhci[1], TYPE_VT82C686B_U=
SB_UHCI);
>>     object_initialize_child(obj, "ac97", &s->ac97, TYPE_VIA_AC97);
>>     object_initialize_child(obj, "mc97", &s->mc97, TYPE_VIA_MC97);
>> +
>> +    qdev_init_gpio_in_named(dev, via_isa_set_pm_irq, "sci", 1);
>> }
>>=20
>> static const TypeInfo via_isa_info =3D {
>> @@ -704,6 +725,8 @@ static void via_isa_realize(PCIDevice *d, Error **e=
rrp)
>>     if (!qdev_realize(DEVICE(&s->pm), BUS(pci_bus), errp)) {
>>         return;
>>     }
>> +    qdev_connect_gpio_out(DEVICE(&s->pm), 0,
>> +                          qdev_get_gpio_in_named(DEVICE(d), "sci", 0))=
;
>>=20
>>     /* Function 5: AC97 Audio */
>>     qdev_prop_set_int32(DEVICE(&s->ac97), "addr", d->devfn + 5);
>>=20

