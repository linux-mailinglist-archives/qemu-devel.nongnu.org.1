Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7F47B810B
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 15:34:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo210-0002zZ-3o; Wed, 04 Oct 2023 09:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qo20c-0002rR-39
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:33:54 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qo20T-00030m-4M
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:33:48 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9b96c3b4be4so26681066b.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 06:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696426419; x=1697031219; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x+uP3/2CvOC+n7FL+aUMgFW5jSKd4lUO3yFqeK9iyi4=;
 b=I/vijMTVfywFOiRQD+ZN1KbmI8ecNhMQryY4TGS5EH9IeKK258BCqA6JxrUjwm9/q1
 KOYG4Y+Zel5XhmX8qGQ5Zhf05TxzLNDsqzN6RcjMC0pd1HPgmk40/ps87lGtVEyHIW3q
 toQOPnOlMf3iO5tuXVmJiNIIe5Wq8/ahX7LlCHqE0wGLjmPEOsmO0zLVjPXmSP7eochX
 20C/E2r1uj/GwgCumQvwgCv+kaIHz1KasFBtC4Idsuv3JCUlkOH9VrfaEWA36P+e+6cl
 K1vJVtwpObx5yODlhB1MlUb14WqPqyEuT210cDn4sjy3hLCYqfq8Z3rMY9zjMv72wPnF
 3Mlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696426419; x=1697031219;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x+uP3/2CvOC+n7FL+aUMgFW5jSKd4lUO3yFqeK9iyi4=;
 b=CzGGTTBxf2NNnvCeSKU1sut84b6mDwM/wPcZd4ybvHlRgfOU2+fmesbC7mXzlJKfkt
 ZhyulsHsUdgZWnfs+0owiDJZl+A2O+2h56gGqZteAy4ZRyM7/SFxE+aheWaZPCaQTfVX
 wz6EwYRtwNOWUTpZStozs+Fk+t8pPSj87GoTHUzDUH/4Cry5WKXkVYgQZ9fF7TlHMCNJ
 qo8bzs3iROTIdOODfPDvJzLEdj7YnY9Yu21ItAxXpOJDG+x9b898mok/VeqNHbZxMb+l
 g5S3CQnp/EjHUonWYj1iWgH9YhKuegMnNgfY/AH0nXPeTMUhA5wvWNBPJrcOI6geCNGq
 o6MQ==
X-Gm-Message-State: AOJu0YzZ9LxSefKOq8BX7LM1q7ImkGIEHAsI++VAIrdrHGBkTMTiHA22
 UjFdKTvZho+HL/bQpxo08os+sqd0bRQ=
X-Google-Smtp-Source: AGHT+IElkaWevO5nT64qu5ARRT223cVLZ+K+NcDnC9YutAmFAVSBAo6JSfKmW4rXyfScm47nQiqNQA==
X-Received: by 2002:a17:906:300f:b0:9a5:7f99:be54 with SMTP id
 15-20020a170906300f00b009a57f99be54mr1839798ejz.67.1696426418494; 
 Wed, 04 Oct 2023 06:33:38 -0700 (PDT)
Received: from ?IPv6:::1?
 (p200300faaf2af200e89e5c3401969328.dip0.t-ipconnect.de.
 [2003:fa:af2a:f200:e89e:5c34:196:9328])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a1709064e4600b00991faf3810esm2836748ejw.146.2023.10.04.06.33.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 06:33:38 -0700 (PDT)
Date: Wed, 04 Oct 2023 13:33:25 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Huacai Chen <chenhuacai@kernel.org>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH] hw/isa/vt82c686: Respect SCI interrupt assignment
In-Reply-To: <f5b9d133-864a-fd13-9bc5-523e1ad77efe@eik.bme.hu>
References: <20231003214437.29302-1-shentey@gmail.com>
 <f5b9d133-864a-fd13-9bc5-523e1ad77efe@eik.bme.hu>
Message-ID: <B7E8646E-A72B-419D-A427-D132F66289F7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62b.google.com
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



Am 4=2E Oktober 2023 12:08:02 UTC schrieb BALATON Zoltan <balaton@eik=2Ebm=
e=2Ehu>:
>On Tue, 3 Oct 2023, Bernhard Beschow wrote:
>> According to the datasheet, SCI interrupts of the power management func=
tion
>> aren't triggered through the PCI pins but rather directly to the integr=
ated PIC=2E
>> The routing is configurable through the ACPI interrupt select register =
at offset
>> 42 in the PCI configuration space of the ISA function=2E
>
>This should be config reg 42 of the PM function 4 not ISA function 0 but =
the code seems to do it right just this description is wrong=2E

Notice via_isa_set_pm_irq() using ViaISAState for routing the SCI to the P=
IC=2E Hence, the description seems correct to me=2E

>
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>
>You could cc me on vt82c686 too as now I have two machines using these (o=
ne is not yet upstream)=2E

Usually I let git-publish handle the cc which derives it from the MAINTAIN=
ERS file=2E You could add yourself there to get cc'ed automatically=2E

I'm curious what the other machine not yet upstreamed is?

>
>> ---
>> hw/isa/vt82c686=2Ec | 43 +++++++++++++++++++++++++++++++------------
>> 1 file changed, 31 insertions(+), 12 deletions(-)
>>=20
>> diff --git a/hw/isa/vt82c686=2Ec b/hw/isa/vt82c686=2Ec
>> index 57bdfb4e78=2E=2E2988ad1eda 100644
>> --- a/hw/isa/vt82c686=2Ec
>> +++ b/hw/isa/vt82c686=2Ec
>> @@ -46,6 +46,8 @@ struct ViaPMState {
>>     ACPIREGS ar;
>>     APMState apm;
>>     PMSMBus smb;
>> +
>
>No empty line needed here=2E

Here I took inspiration from struct PIIX4PMState which separates the qemu_=
irqs, too=2E The long term plan is to also add an smi_irq attribute in orde=
r to bring both device models to feature parity=2E So I'd rather leave it a=
s is=2E

> It you want to, you could add an empty line after the first member and r=
ename that to parent_obj as per new convention while you're changing this o=
bject state=2E

I didn't want to add this style fix in this single commit series=2E I thin=
k this would deserve its own commit where all device models in this file ar=
e fixed=2E

>
>> +    qemu_irq irq;
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
>> @@ -568,9 +567,25 @@ static const VMStateDescription vmstate_via =3D {
>>     }
>> };
>>=20
>> +static void via_isa_set_pm_irq(void *opaque, int n, int level)
>> +{
>> +    ViaISAState *s =3D opaque;
>> +    uint8_t irq =3D pci_get_byte(s->pm=2Edev=2Econfig + 0x42) & 0xf;
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
>
>No need to add local variable for single use unless you expect to have mo=
re of these later but for single use you caould just use DEVICE(obj or s) i=
n the call below=2E

I have one more user on my pc-via branch for wiring the ISA interrupts=2E

Best regards,
Bernhard

>
>Other than these small nits:
>
>Reviewed-by: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>
>>=20
>>     object_initialize_child(obj, "rtc", &s->rtc, TYPE_MC146818_RTC);
>>     object_initialize_child(obj, "ide", &s->ide, TYPE_VIA_IDE);
>> @@ -578,6 +593,8 @@ static void via_isa_init(Object *obj)
>>     object_initialize_child(obj, "uhci2", &s->uhci[1], TYPE_VT82C686B_U=
SB_UHCI);
>>     object_initialize_child(obj, "ac97", &s->ac97, TYPE_VIA_AC97);
>>     object_initialize_child(obj, "mc97", &s->mc97, TYPE_VIA_MC97);
>> +
>> +    qdev_init_gpio_in_named(dev, via_isa_set_pm_irq, "sci", 1);
>> }
>>=20
>> static const TypeInfo via_isa_info =3D {
>> @@ -704,6 +721,8 @@ static void via_isa_realize(PCIDevice *d, Error **e=
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

