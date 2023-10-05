Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BCB7B9B40
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 09:11:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoIVX-00085Y-7z; Thu, 05 Oct 2023 03:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qoIVU-000843-8k
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 03:10:48 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qoIVS-0001Iy-0V
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 03:10:48 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9adb9fa7200so153014166b.0
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 00:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696489844; x=1697094644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zK1M8wb+zLexpKlDsDjn7CeRZ/0LOepOQZwe6n1951o=;
 b=OXLUr55Y9YoZjNEL37u+DTqRRAp5tNKiTK2Gq+MqQchY98kwkgwVk7ClNTZ5AFh9h5
 znl3fMtV+4QAIZuyvQov/YYBKl7oQlUZZA6e3NH4MTykAw1kHZJXNmd3cIajA7OGfk0D
 GQZfBepmf4nV8FW2V/jqvs7GQ6sJ68ttOBTiSEXl7w0Blbrjo0OhT2lgh8DkGaFgRuFU
 eCakQT9rQ38qEm/7eb0CH27/c/PseM42My4aa6PN4g8dpXxDDL3ZcKvMnII/7qwcn2sQ
 p0bYTDbHvU7qvQWGRgPeVCGfuTRyw4LgqcCXFpZa6kReCk/mABP9qZgktBSJBadI5ESj
 FOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696489844; x=1697094644;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zK1M8wb+zLexpKlDsDjn7CeRZ/0LOepOQZwe6n1951o=;
 b=GHD9jRzCrNXmU1qXWGf2zXAEHo8PtdbbZPrZ4YIUal3iRpBzw+4ZbJtOd50pGzis9r
 9Svo/GZpGwA05D2ge6H1aBLRw7NRP96NCXcySRyVLN9cQLddhsjB/XsbT6V1M5w3TLUx
 qhkIqx+ReUR4AVbs5HP2iy2wO66I7ADDpixfXYvloMzskAlxsIP30yOk9mmFB3AYGTEV
 1zfWe/AXOC1pyzky9cH7D9E2auvzgF7rgbXw9Yks90dbeL31UVr76Gty2FoDGcGIv3q+
 xE6KzGaXgD1AnoTJhBpauDY0BcDZNPU5DaRalU6BOrGsU9KkdN4Bm7FV6FGLOBqAvUCC
 UDzw==
X-Gm-Message-State: AOJu0Yygs4TSWsOrB/0kB0LBMZsStXbpRF0Pb8EqJjmNqvR2xJBM2g9E
 GHbO+JsDoFSHlN9jZgu6xr4=
X-Google-Smtp-Source: AGHT+IHo9hFh80jJCb+3x6SSzWhk+VA1QEm7vBUmO7/yg3fmvMJoi2QWOq57R73KTasnPAEBcHWbIg==
X-Received: by 2002:a17:906:3109:b0:9b6:3be9:a8f with SMTP id
 9-20020a170906310900b009b63be90a8fmr1599836ejx.20.1696489843646; 
 Thu, 05 Oct 2023 00:10:43 -0700 (PDT)
Received: from ?IPv6:::1?
 (p200300faaf2af200ad058901f594a09a.dip0.t-ipconnect.de.
 [2003:fa:af2a:f200:ad05:8901:f594:a09a])
 by smtp.gmail.com with ESMTPSA id
 dx8-20020a170906a84800b0099bd7b26639sm672727ejb.6.2023.10.05.00.10.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 00:10:42 -0700 (PDT)
Date: Thu, 05 Oct 2023 07:10:36 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Huacai Chen <chenhuacai@kernel.org>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH] hw/isa/vt82c686: Respect SCI interrupt assignment
In-Reply-To: <93e48abe-b6d4-af1a-f40f-728c8d215bbb@eik.bme.hu>
References: <20231003214437.29302-1-shentey@gmail.com>
 <f5b9d133-864a-fd13-9bc5-523e1ad77efe@eik.bme.hu>
 <B7E8646E-A72B-419D-A427-D132F66289F7@gmail.com>
 <93e48abe-b6d4-af1a-f40f-728c8d215bbb@eik.bme.hu>
Message-ID: <741F3E86-BFD2-440F-93C5-010A81CD90FC@gmail.com>
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



Am 4=2E Oktober 2023 14:52:14 UTC schrieb BALATON Zoltan <balaton@eik=2Ebm=
e=2Ehu>:
>On Wed, 4 Oct 2023, Bernhard Beschow wrote:
>> Am 4=2E Oktober 2023 12:08:02 UTC schrieb BALATON Zoltan <balaton@eik=
=2Ebme=2Ehu>:
>>> On Tue, 3 Oct 2023, Bernhard Beschow wrote:
>>>> According to the datasheet, SCI interrupts of the power management fu=
nction
>>>> aren't triggered through the PCI pins but rather directly to the inte=
grated PIC=2E
>>>> The routing is configurable through the ACPI interrupt select registe=
r at offset
>>>> 42 in the PCI configuration space of the ISA function=2E
>>>=20
>>> This should be config reg 42 of the PM function 4 not ISA function 0 b=
ut the code seems to do it right just this description is wrong=2E
>>=20
>> Notice via_isa_set_pm_irq() using ViaISAState for routing the SCI to th=
e PIC=2E Hence, the description seems correct to me=2E
>
>It uses s->pm=2Edev=2Econfig + 0x42 so that's the PM device not s->dev=2E=
config which is a different register so I think the description should also=
 talk about offset 0x42 of PCI configuration of the PM function, shouldn't =
it?

Oh right, I'll fix the commit message=2E

>
>>>>=20
>>>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>>=20
>>> You could cc me on vt82c686 too as now I have two machines using these=
 (one is not yet upstream)=2E
>>=20
>> Usually I let git-publish handle the cc which derives it from the MAINT=
AINERS file=2E You could add yourself there to get cc'ed automatically=2E
>
>I thought about sending a patch splitting off vt82c686 from fuloong2e so =
I can add myself as reviewer there=2E I may do that later=2E
>
>> I'm curious what the other machine not yet upstreamed is?
>
>Tou can read about it here:
>
>https://www=2Eamigans=2Enet/modules/newbb/viewtopic=2Ephp?topic_id=3D9282
>
>I'll plan to send it when it's better tested but it needs a firmware imag=
e that I could not yet solve=2E
>
>>>> ---
>>>> hw/isa/vt82c686=2Ec | 43 +++++++++++++++++++++++++++++++------------
>>>> 1 file changed, 31 insertions(+), 12 deletions(-)
>>>>=20
>>>> diff --git a/hw/isa/vt82c686=2Ec b/hw/isa/vt82c686=2Ec
>>>> index 57bdfb4e78=2E=2E2988ad1eda 100644
>>>> --- a/hw/isa/vt82c686=2Ec
>>>> +++ b/hw/isa/vt82c686=2Ec
>>>> @@ -46,6 +46,8 @@ struct ViaPMState {
>>>>     ACPIREGS ar;
>>>>     APMState apm;
>>>>     PMSMBus smb;
>>>> +
>>>=20
>>> No empty line needed here=2E
>>=20
>> Here I took inspiration from struct PIIX4PMState which separates the qe=
mu_irqs, too=2E The long term plan is to also add an smi_irq attribute in o=
rder to bring both device models to feature parity=2E So I'd rather leave i=
t as is=2E
>
>Maybe better name it sci_irq then to avoid confusion=2E

Will do=2E And I'll turn it into a named GPIO=2E

> If you add smi later as well then maybe it's time to think now how to be=
st model this=2E Does sci needs to be exposed as named qemu_gpio on functio=
n 0 or should that be smi and sci routed to smi optionally whcch seems to b=
e what the real chip does? I don't know how these work just looked at the d=
ata sheet briefly so I have more questions than answers but looks like expo=
sing sci is not needed and this patch could just add an irq to PM func only=
 that could set ISA IRQ and then later when smi_irq is added that might nee=
d a qemu_gpio in func 0 modelling the SMI pin of the chip=2E

Right, I think the SCI doesn't need to be exposed since it is handled inte=
rnally in the chip=2E This is what this patch implements=2E

The SMI will need to be exposed since it puts an x86 CPU in system managem=
ent mode via a dedicated pin=2E

Best regards,
Bernhard

>
>>> It you want to, you could add an empty line after the first member and=
 rename that to parent_obj as per new convention while you're changing this=
 object state=2E
>>=20
>> I didn't want to add this style fix in this single commit series=2E I t=
hink this would deserve its own commit where all device models in this file=
 are fixed=2E
>
>That works for me too, no need to do it here, just mentioned that's where=
 I think a new line may be acceptable but not really needed elsewhere=2E
>
>>>=20
>>>> +    qemu_irq irq;
>>>> };
>>>>=20
>>>> static void pm_io_space_update(ViaPMState *s)
>>>> @@ -148,18 +150,7 @@ static void pm_update_sci(ViaPMState *s)
>>>>                    ACPI_BITMASK_POWER_BUTTON_ENABLE |
>>>>                    ACPI_BITMASK_GLOBAL_LOCK_ENABLE |
>>>>                    ACPI_BITMASK_TIMER_ENABLE)) !=3D 0);
>>>> -    if (pci_get_byte(s->dev=2Econfig + PCI_INTERRUPT_PIN)) {
>>>> -        /*
>>>> -         * FIXME:
>>>> -         * Fix device model that realizes this PM device and remove
>>>> -         * this work around=2E
>>>> -         * The device model should wire SCI and setup
>>>> -         * PCI_INTERRUPT_PIN properly=2E
>>>> -         * If PIN# =3D 0(interrupt pin isn't used), don't raise SCI =
as
>>>> -         * work around=2E
>>>> -         */
>>>> -        pci_set_irq(&s->dev, sci_level);
>>>> -    }
>>>> +    qemu_set_irq(s->irq, sci_level);
>>>>     /* schedule a timer interruption if needed */
>>>>     acpi_pm_tmr_update(&s->ar, (s->ar=2Epm1=2Eevt=2Een & ACPI_BITMASK=
_TIMER_ENABLE) &&
>>>>                        !(pmsts & ACPI_BITMASK_TIMER_STATUS));
>>>> @@ -213,6 +204,13 @@ static void via_pm_realize(PCIDevice *dev, Error=
 **errp)
>>>>     acpi_pm1_cnt_init(&s->ar, &s->io, false, false, 2, false);
>>>> }
>>>>=20
>>>> +static void via_pm_init(Object *obj)
>>>> +{
>>>> +    ViaPMState *s =3D VIA_PM(obj);
>>>> +
>>>> +    qdev_init_gpio_out(DEVICE(obj), &s->irq, 1);
>>>> +}
>>>> +
>>>> typedef struct via_pm_init_info {
>>>>     uint16_t device_id;
>>>> } ViaPMInitInfo;
>>>> @@ -238,6 +236,7 @@ static void via_pm_class_init(ObjectClass *klass,=
 void *data)
>>>> static const TypeInfo via_pm_info =3D {
>>>>     =2Ename          =3D TYPE_VIA_PM,
>>>>     =2Eparent        =3D TYPE_PCI_DEVICE,
>>>> +    =2Einstance_init =3D via_pm_init,
>>>>     =2Einstance_size =3D sizeof(ViaPMState),
>>>>     =2Eabstract      =3D true,
>>>>     =2Einterfaces =3D (InterfaceInfo[]) {
>>>> @@ -568,9 +567,25 @@ static const VMStateDescription vmstate_via =3D =
{
>>>>     }
>>>> };
>>>>=20
>>>> +static void via_isa_set_pm_irq(void *opaque, int n, int level)
>>>> +{
>>>> +    ViaISAState *s =3D opaque;
>>>> +    uint8_t irq =3D pci_get_byte(s->pm=2Edev=2Econfig + 0x42) & 0xf;
>>>> +
>>>> +    if (irq =3D=3D 2) {
>>>> +        qemu_log_mask(LOG_GUEST_ERROR, "IRQ 2 for PM controller is r=
eserved");
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    if (irq !=3D 0) {
>>>> +        qemu_set_irq(s->isa_irqs_in[irq], level);
>>>> +    }
>>>> +}
>>>> +
>>>> static void via_isa_init(Object *obj)
>>>> {
>>>>     ViaISAState *s =3D VIA_ISA(obj);
>>>> +    DeviceState *dev =3D DEVICE(s);
>>>=20
>>> No need to add local variable for single use unless you expect to have=
 more of these later but for single use you caould just use DEVICE(obj or s=
) in the call below=2E
>>=20
>> I have one more user on my pc-via branch for wiring the ISA interrupts=
=2E
>
>OK as said if you expect more usages then a local variable can be useful =
just seems unnecessary for a single use but if you'll follow up with someth=
ing that will use it it can be added now=2E
>
>Regards,
>BALATON Zoltan
>
>> Best regards,
>> Bernhard
>>=20
>>>=20
>>> Other than these small nits:
>>>=20
>>> Reviewed-by: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>>>=20
>>>>=20
>>>>     object_initialize_child(obj, "rtc", &s->rtc, TYPE_MC146818_RTC);
>>>>     object_initialize_child(obj, "ide", &s->ide, TYPE_VIA_IDE);
>>>> @@ -578,6 +593,8 @@ static void via_isa_init(Object *obj)
>>>>     object_initialize_child(obj, "uhci2", &s->uhci[1], TYPE_VT82C686B=
_USB_UHCI);
>>>>     object_initialize_child(obj, "ac97", &s->ac97, TYPE_VIA_AC97);
>>>>     object_initialize_child(obj, "mc97", &s->mc97, TYPE_VIA_MC97);
>>>> +
>>>> +    qdev_init_gpio_in_named(dev, via_isa_set_pm_irq, "sci", 1);
>>>> }
>>>>=20
>>>> static const TypeInfo via_isa_info =3D {
>>>> @@ -704,6 +721,8 @@ static void via_isa_realize(PCIDevice *d, Error *=
*errp)
>>>>     if (!qdev_realize(DEVICE(&s->pm), BUS(pci_bus), errp)) {
>>>>         return;
>>>>     }
>>>> +    qdev_connect_gpio_out(DEVICE(&s->pm), 0,
>>>> +                          qdev_get_gpio_in_named(DEVICE(d), "sci", 0=
));
>>>>=20
>>>>     /* Function 5: AC97 Audio */
>>>>     qdev_prop_set_int32(DEVICE(&s->ac97), "addr", d->devfn + 5);
>>>>=20
>>=20
>>=20

