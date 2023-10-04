Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B9C7B7EC3
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:09:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo0gT-00063Q-NI; Wed, 04 Oct 2023 08:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qo0gO-000638-FF
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:08:54 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qo0gM-00068O-9k
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:08:52 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 60C0674632B;
 Wed,  4 Oct 2023 14:08:02 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 220CF7456AA; Wed,  4 Oct 2023 14:08:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1FDFD745681;
 Wed,  4 Oct 2023 14:08:02 +0200 (CEST)
Date: Wed, 4 Oct 2023 14:08:02 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Huacai Chen <chenhuacai@kernel.org>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH] hw/isa/vt82c686: Respect SCI interrupt assignment
In-Reply-To: <20231003214437.29302-1-shentey@gmail.com>
Message-ID: <f5b9d133-864a-fd13-9bc5-523e1ad77efe@eik.bme.hu>
References: <20231003214437.29302-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Tue, 3 Oct 2023, Bernhard Beschow wrote:
> According to the datasheet, SCI interrupts of the power management function
> aren't triggered through the PCI pins but rather directly to the integrated PIC.
> The routing is configurable through the ACPI interrupt select register at offset
> 42 in the PCI configuration space of the ISA function.

This should be config reg 42 of the PM function 4 not ISA function 0 but 
the code seems to do it right just this description is wrong.

>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

You could cc me on vt82c686 too as now I have two machines using these 
(one is not yet upstream).

> ---
> hw/isa/vt82c686.c | 43 +++++++++++++++++++++++++++++++------------
> 1 file changed, 31 insertions(+), 12 deletions(-)
>
> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
> index 57bdfb4e78..2988ad1eda 100644
> --- a/hw/isa/vt82c686.c
> +++ b/hw/isa/vt82c686.c
> @@ -46,6 +46,8 @@ struct ViaPMState {
>     ACPIREGS ar;
>     APMState apm;
>     PMSMBus smb;
> +

No empty line needed here. It you want to, you could add an empty line 
after the first member and rename that to parent_obj as per new convention 
while you're changing this object state.

> +    qemu_irq irq;
> };
>
> static void pm_io_space_update(ViaPMState *s)
> @@ -148,18 +150,7 @@ static void pm_update_sci(ViaPMState *s)
>                    ACPI_BITMASK_POWER_BUTTON_ENABLE |
>                    ACPI_BITMASK_GLOBAL_LOCK_ENABLE |
>                    ACPI_BITMASK_TIMER_ENABLE)) != 0);
> -    if (pci_get_byte(s->dev.config + PCI_INTERRUPT_PIN)) {
> -        /*
> -         * FIXME:
> -         * Fix device model that realizes this PM device and remove
> -         * this work around.
> -         * The device model should wire SCI and setup
> -         * PCI_INTERRUPT_PIN properly.
> -         * If PIN# = 0(interrupt pin isn't used), don't raise SCI as
> -         * work around.
> -         */
> -        pci_set_irq(&s->dev, sci_level);
> -    }
> +    qemu_set_irq(s->irq, sci_level);
>     /* schedule a timer interruption if needed */
>     acpi_pm_tmr_update(&s->ar, (s->ar.pm1.evt.en & ACPI_BITMASK_TIMER_ENABLE) &&
>                        !(pmsts & ACPI_BITMASK_TIMER_STATUS));
> @@ -213,6 +204,13 @@ static void via_pm_realize(PCIDevice *dev, Error **errp)
>     acpi_pm1_cnt_init(&s->ar, &s->io, false, false, 2, false);
> }
>
> +static void via_pm_init(Object *obj)
> +{
> +    ViaPMState *s = VIA_PM(obj);
> +
> +    qdev_init_gpio_out(DEVICE(obj), &s->irq, 1);
> +}
> +
> typedef struct via_pm_init_info {
>     uint16_t device_id;
> } ViaPMInitInfo;
> @@ -238,6 +236,7 @@ static void via_pm_class_init(ObjectClass *klass, void *data)
> static const TypeInfo via_pm_info = {
>     .name          = TYPE_VIA_PM,
>     .parent        = TYPE_PCI_DEVICE,
> +    .instance_init = via_pm_init,
>     .instance_size = sizeof(ViaPMState),
>     .abstract      = true,
>     .interfaces = (InterfaceInfo[]) {
> @@ -568,9 +567,25 @@ static const VMStateDescription vmstate_via = {
>     }
> };
>
> +static void via_isa_set_pm_irq(void *opaque, int n, int level)
> +{
> +    ViaISAState *s = opaque;
> +    uint8_t irq = pci_get_byte(s->pm.dev.config + 0x42) & 0xf;
> +
> +    if (irq == 2) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "IRQ 2 for PM controller is reserved");
> +        return;
> +    }
> +
> +    if (irq != 0) {
> +        qemu_set_irq(s->isa_irqs_in[irq], level);
> +    }
> +}
> +
> static void via_isa_init(Object *obj)
> {
>     ViaISAState *s = VIA_ISA(obj);
> +    DeviceState *dev = DEVICE(s);

No need to add local variable for single use unless you expect to have 
more of these later but for single use you caould just use DEVICE(obj or 
s) in the call below.

Other than these small nits:

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

>
>     object_initialize_child(obj, "rtc", &s->rtc, TYPE_MC146818_RTC);
>     object_initialize_child(obj, "ide", &s->ide, TYPE_VIA_IDE);
> @@ -578,6 +593,8 @@ static void via_isa_init(Object *obj)
>     object_initialize_child(obj, "uhci2", &s->uhci[1], TYPE_VT82C686B_USB_UHCI);
>     object_initialize_child(obj, "ac97", &s->ac97, TYPE_VIA_AC97);
>     object_initialize_child(obj, "mc97", &s->mc97, TYPE_VIA_MC97);
> +
> +    qdev_init_gpio_in_named(dev, via_isa_set_pm_irq, "sci", 1);
> }
>
> static const TypeInfo via_isa_info = {
> @@ -704,6 +721,8 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
>     if (!qdev_realize(DEVICE(&s->pm), BUS(pci_bus), errp)) {
>         return;
>     }
> +    qdev_connect_gpio_out(DEVICE(&s->pm), 0,
> +                          qdev_get_gpio_in_named(DEVICE(d), "sci", 0));
>
>     /* Function 5: AC97 Audio */
>     qdev_prop_set_int32(DEVICE(&s->ac97), "addr", d->devfn + 5);
>

