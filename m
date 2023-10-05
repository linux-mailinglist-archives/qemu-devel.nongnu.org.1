Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3F07B9D10
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 14:47:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoNk6-0002nR-TO; Thu, 05 Oct 2023 08:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qoNjw-0002nD-CC
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:46:05 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qoNjj-0003Cg-UC
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:46:01 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 8E7E274632B;
 Thu,  5 Oct 2023 14:45:02 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4BC4F7456A7; Thu,  5 Oct 2023 14:45:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4A11B745681;
 Thu,  5 Oct 2023 14:45:02 +0200 (CEST)
Date: Thu, 5 Oct 2023 14:45:02 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH v3] hw/isa/vt82c686: Respect SCI interrupt assignment
In-Reply-To: <20231005115159.81202-1-shentey@gmail.com>
Message-ID: <7f0a480e-3b30-36d8-daaf-cb817dcad3ca@eik.bme.hu>
References: <20231005115159.81202-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-563672084-1696509902=:3294"
X-Spam-Probability: 9%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-563672084-1696509902=:3294
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 5 Oct 2023, Bernhard Beschow wrote:
> According to the datasheet, SCI interrupts of the power management function
> aren't routed through the PCI pins but rather directly to the integrated PIC.
> The routing is configurable through the ACPI interrupt select register at offset
> 0x42 in the PCI configuration space of the power management function.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>
> ---
>
> v3:
> * Rename SCI irq attribute to sci_irq (Zoltan)
> * Fix confusion about location of ACPI interrupt select register (Zoltan)
> * Model SCI as named GPIO (Bernhard)
> * Perform upcast via macro rather than sub structure selection (Bernhard)
>
> v2:
> * Introduce named constants for the ACPI interrupt select register at offset
>  0x42 (Phil)
> ---
> hw/isa/vt82c686.c | 48 +++++++++++++++++++++++++++++++++++------------
> 1 file changed, 36 insertions(+), 12 deletions(-)
>
> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
> index 57bdfb4e78..aeb9434a46 100644
> --- a/hw/isa/vt82c686.c
> +++ b/hw/isa/vt82c686.c
> @@ -40,12 +40,17 @@
> #define TYPE_VIA_PM "via-pm"
> OBJECT_DECLARE_SIMPLE_TYPE(ViaPMState, VIA_PM)
>
> +#define VIA_PM_SCI_SELECT_OFS 0x42
> +#define VIA_PM_SCI_SELECT_MASK 0xf
> +
> struct ViaPMState {
>     PCIDevice dev;
>     MemoryRegion io;
>     ACPIREGS ar;
>     APMState apm;
>     PMSMBus smb;
> +
> +    qemu_irq sci_irq;
> };
>
> static void pm_io_space_update(ViaPMState *s)
> @@ -148,18 +153,7 @@ static void pm_update_sci(ViaPMState *s)
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
> +    qemu_set_irq(s->sci_irq, sci_level);

I still think this it more complex that it should be and what's in 
via_isa_set_pm_irq() below should be here instead and drop all the named 
gpio wizardry that's just unneeded complication here.

Regards.
BALATON Zoltan

>     /* schedule a timer interruption if needed */
>     acpi_pm_tmr_update(&s->ar, (s->ar.pm1.evt.en & ACPI_BITMASK_TIMER_ENABLE) &&
>                        !(pmsts & ACPI_BITMASK_TIMER_STATUS));
> @@ -213,6 +207,13 @@ static void via_pm_realize(PCIDevice *dev, Error **errp)
>     acpi_pm1_cnt_init(&s->ar, &s->io, false, false, 2, false);
> }
>
> +static void via_pm_init(Object *obj)
> +{
> +    ViaPMState *s = VIA_PM(obj);
> +
> +    qdev_init_gpio_out_named(DEVICE(obj), &s->sci_irq, "sci", 1);
> +}
> +
> typedef struct via_pm_init_info {
>     uint16_t device_id;
> } ViaPMInitInfo;
> @@ -238,6 +239,7 @@ static void via_pm_class_init(ObjectClass *klass, void *data)
> static const TypeInfo via_pm_info = {
>     .name          = TYPE_VIA_PM,
>     .parent        = TYPE_PCI_DEVICE,
> +    .instance_init = via_pm_init,
>     .instance_size = sizeof(ViaPMState),
>     .abstract      = true,
>     .interfaces = (InterfaceInfo[]) {
> @@ -568,9 +570,27 @@ static const VMStateDescription vmstate_via = {
>     }
> };
>
> +static void via_isa_set_pm_irq(void *opaque, int n, int level)
> +{
> +    ViaISAState *s = opaque;
> +    PCIDevice *pci_dev = PCI_DEVICE(&s->pm);
> +    uint8_t irq = pci_get_byte(pci_dev->config + VIA_PM_SCI_SELECT_OFS)
> +                  & VIA_PM_SCI_SELECT_MASK;
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
>
>     object_initialize_child(obj, "rtc", &s->rtc, TYPE_MC146818_RTC);
>     object_initialize_child(obj, "ide", &s->ide, TYPE_VIA_IDE);
> @@ -578,6 +598,8 @@ static void via_isa_init(Object *obj)
>     object_initialize_child(obj, "uhci2", &s->uhci[1], TYPE_VT82C686B_USB_UHCI);
>     object_initialize_child(obj, "ac97", &s->ac97, TYPE_VIA_AC97);
>     object_initialize_child(obj, "mc97", &s->mc97, TYPE_VIA_MC97);
> +
> +    qdev_init_gpio_in_named(dev, via_isa_set_pm_irq, "sci", 1);
> }
>
> static const TypeInfo via_isa_info = {
> @@ -704,6 +726,8 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
>     if (!qdev_realize(DEVICE(&s->pm), BUS(pci_bus), errp)) {
>         return;
>     }
> +    qdev_connect_gpio_out_named(DEVICE(&s->pm), "sci", 0,
> +                                qdev_get_gpio_in_named(DEVICE(d), "sci", 0));
>
>     /* Function 5: AC97 Audio */
>     qdev_prop_set_int32(DEVICE(&s->ac97), "addr", d->devfn + 5);
>
--3866299591-563672084-1696509902=:3294--

