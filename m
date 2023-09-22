Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4117AB1FD
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 14:18:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjf5i-0003QI-3l; Fri, 22 Sep 2023 08:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qjf5V-0003OU-J1
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 08:16:49 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qjf5S-00077a-JB
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 08:16:49 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id C45EF7456AA;
 Fri, 22 Sep 2023 14:16:24 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 81F327456A7; Fri, 22 Sep 2023 14:16:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7EAD4745681;
 Fri, 22 Sep 2023 14:16:24 +0200 (CEST)
Date: Fri, 22 Sep 2023 14:16:24 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: qemu-devel@nongnu.org, mkletzan@redhat.com
Subject: Re: [PATCH 6/9] vt82c686: Support machine-default audiodev with
 fallback
In-Reply-To: <20230922094459.265509-7-pbonzini@redhat.com>
Message-ID: <fa8a8e3f-b17c-f5fc-a4ae-13a0fa233fb7@eik.bme.hu>
References: <20230922094459.265509-1-pbonzini@redhat.com>
 <20230922094459.265509-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Fri, 22 Sep 2023, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> hw/isa/vt82c686.c   |  2 ++
> hw/mips/fuloong2e.c | 12 +++++++++---
> hw/ppc/pegasos2.c   | 10 ++++++++--
> hw/ppc/sam460ex.c   |  2 ++
> 4 files changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
> index 57bdfb4e78c..3ec8e43708a 100644
> --- a/hw/isa/vt82c686.c
> +++ b/hw/isa/vt82c686.c
> @@ -578,6 +578,8 @@ static void via_isa_init(Object *obj)
>     object_initialize_child(obj, "uhci2", &s->uhci[1], TYPE_VT82C686B_USB_UHCI);
>     object_initialize_child(obj, "ac97", &s->ac97, TYPE_VIA_AC97);
>     object_initialize_child(obj, "mc97", &s->mc97, TYPE_VIA_MC97);
> +
> +    object_property_add_alias(obj, "audiodev", OBJECT(&s->ac97), "audiodev");
> }
>
> static const TypeInfo via_isa_info = {
> diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
> index c827f615f3b..d0671824f94 100644
> --- a/hw/mips/fuloong2e.c
> +++ b/hw/mips/fuloong2e.c
> @@ -41,6 +41,7 @@
> #include "sysemu/reset.h"
> #include "sysemu/sysemu.h"
> #include "qemu/error-report.h"
> +#include "audio/audio.h"
>
> #define ENVP_PADDR              0x2000
> #define ENVP_VADDR              cpu_mips_phys_to_kseg0(NULL, ENVP_PADDR)
> @@ -295,9 +296,12 @@ static void mips_fuloong2e_init(MachineState *machine)
>     pci_bus = bonito_init((qemu_irq *)&(env->irq[2]));
>
>     /* South bridge -> IP5 */
> -    pci_dev = pci_create_simple_multifunction(pci_bus,
> -                                              PCI_DEVFN(FULOONG2E_VIA_SLOT, 0),
> -                                              TYPE_VT82C686B_ISA);
> +    pci_dev = pci_new_multifunction(PCI_DEVFN(FULOONG2E_VIA_SLOT, 0),
> +                                    TYPE_VT82C686B_ISA);
> +    qdev_prop_set_string(DEVICE(pci_dev), "audiodev",
> +                         audio_maybe_init_dummy("fuloong2e.defaudio"));
> +    pci_realize_and_unref(pci_dev, pci_bus, &error_abort);
> +
>     object_property_add_alias(OBJECT(machine), "rtc-time",
>                               object_resolve_path_component(OBJECT(pci_dev),
>                                                             "rtc"),
> @@ -337,6 +341,8 @@ static void mips_fuloong2e_machine_init(MachineClass *mc)
>     mc->default_ram_size = 256 * MiB;
>     mc->default_ram_id = "fuloong2e.ram";
>     mc->minimum_page_bits = 14;
> +
> +    machine_add_audiodev_property(mc);
> }
>
> DEFINE_MACHINE("fuloong2e", mips_fuloong2e_machine_init)
> diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
> index bd397cf2b5c..45b94cab73a 100644
> --- a/hw/ppc/pegasos2.c
> +++ b/hw/ppc/pegasos2.c
> @@ -37,6 +37,7 @@
> #include "qemu/datadir.h"
> #include "sysemu/device_tree.h"
> #include "hw/ppc/vof.h"
> +#include "audio/audio.h"
>
> #include <libfdt.h>
>
> @@ -180,8 +181,11 @@ static void pegasos2_init(MachineState *machine)
>     pci_bus_irqs(pci_bus, pegasos2_pci_irq, pm, PCI_NUM_PINS);
>
>     /* VIA VT8231 South Bridge (multifunction PCI device) */
> -    via = OBJECT(pci_create_simple_multifunction(pci_bus, PCI_DEVFN(12, 0),
> -                                                 TYPE_VT8231_ISA));
> +    via = OBJECT(pci_new_multifunction(PCI_DEVFN(12, 0), TYPE_VT8231_ISA));
> +    qdev_prop_set_string(DEVICE(via), "audiodev",
> +                         audio_maybe_init_dummy("pegasos2.defaudio"));
> +    pci_realize_and_unref(PCI_DEVICE(via), pci_bus, &error_abort);
> +

Do not add blank line here, the rest is still part of via init.

>     for (i = 0; i < PCI_NUM_PINS; i++) {
>         pm->via_pirq[i] = qdev_get_gpio_in_named(DEVICE(via), "pirq", i);
>     }
> @@ -564,6 +568,8 @@ static void pegasos2_machine_class_init(ObjectClass *oc, void *data)
>     vhc->encode_hpt_for_kvm_pr = vhyp_encode_hpt_for_kvm_pr;
>
>     vmc->setprop = pegasos2_setprop;
> +
> +    machine_add_audiodev_property(mc);
> }
>
> static const TypeInfo pegasos2_machine_info = {
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 1e615b8d355..8c3abc67131 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -530,6 +530,8 @@ static void sam460ex_machine_init(MachineClass *mc)
>     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("460exb");
>     mc->default_ram_size = 512 * MiB;
>     mc->default_ram_id = "ppc4xx.sdram";
> +
> +    machine_add_audiodev_property(mc);

This hunk has nothing to do with vt82686 so probably should be in 
previoius patch. Also sam460ex embedded sound part is not emulated and can 
only use PCI sound cards. What this line is needed for? If every machine 
now needs this call, can it be added in some generic machine init func in 
hw/core/machine.c instead?

I'm not sure about this whole series. Looks like it gets rid of 71 lines 
but adding 158 and makes the users' life harder by requireing them to 
specify drivers they may not even know about. What's the point? Is there 
still a default to use the normally used audiodev for the platform or 
people will now get errors and no sound unless they change their command 
lines?

Regards,
BALATON Zoltan

> }
>
> DEFINE_MACHINE("sam460ex", sam460ex_machine_init)
>

