Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1597B31BC
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 13:48:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmByX-0002Xv-VM; Fri, 29 Sep 2023 07:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qmBy9-0002TJ-RR
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 07:47:42 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qmBxz-0004OX-9t
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 07:47:40 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 63B69748FF4;
 Fri, 29 Sep 2023 13:46:55 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id EAF8974632B; Fri, 29 Sep 2023 13:46:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E96677456AA;
 Fri, 29 Sep 2023 13:46:54 +0200 (CEST)
Date: Fri, 29 Sep 2023 13:46:54 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: qemu-devel@nongnu.org, berrange@redhat.com
Subject: Re: [PATCH v3 11/14] vt82c686: Support machine-default audiodev with
 fallback
In-Reply-To: <20230929085112.983957-12-pbonzini@redhat.com>
Message-ID: <6cf045a5-d5f4-1c75-ae25-18710c8d8874@eik.bme.hu>
References: <20230929085112.983957-1-pbonzini@redhat.com>
 <20230929085112.983957-12-pbonzini@redhat.com>
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

On Fri, 29 Sep 2023, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

This does not touch vt82c686 any more so maybe subject line could be 
changed to via-ac97: to be more specific. I like to keep all via stuff 
together with empty lines only between different components so I think 
empty lines added here are unnecessary but that's a minor thing.

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

Regards,
BALATON Zoltan

> ---
> hw/mips/fuloong2e.c | 15 ++++++++++++---
> hw/ppc/pegasos2.c   | 12 ++++++++++--
> 2 files changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
> index c827f615f3b..c6109633fee 100644
> --- a/hw/mips/fuloong2e.c
> +++ b/hw/mips/fuloong2e.c
> @@ -295,9 +295,17 @@ static void mips_fuloong2e_init(MachineState *machine)
>     pci_bus = bonito_init((qemu_irq *)&(env->irq[2]));
>
>     /* South bridge -> IP5 */
> -    pci_dev = pci_create_simple_multifunction(pci_bus,
> -                                              PCI_DEVFN(FULOONG2E_VIA_SLOT, 0),
> -                                              TYPE_VT82C686B_ISA);
> +    pci_dev = pci_new_multifunction(PCI_DEVFN(FULOONG2E_VIA_SLOT, 0),
> +                                    TYPE_VT82C686B_ISA);
> +
> +    /* Set properties on individual devices before realizing the south bridge */
> +    if (machine->audiodev) {
> +        dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ac97"));
> +        qdev_prop_set_string(dev, "audiodev", machine->audiodev);
> +    }
> +
> +    pci_realize_and_unref(pci_dev, pci_bus, &error_abort);
> +
>     object_property_add_alias(OBJECT(machine), "rtc-time",
>                               object_resolve_path_component(OBJECT(pci_dev),
>                                                             "rtc"),
> @@ -337,6 +345,7 @@ static void mips_fuloong2e_machine_init(MachineClass *mc)
>     mc->default_ram_size = 256 * MiB;
>     mc->default_ram_id = "fuloong2e.ram";
>     mc->minimum_page_bits = 14;
> +    machine_add_audiodev_property(mc);
> }
>
> DEFINE_MACHINE("fuloong2e", mips_fuloong2e_machine_init)
> diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
> index bd397cf2b5c..3203a4a7289 100644
> --- a/hw/ppc/pegasos2.c
> +++ b/hw/ppc/pegasos2.c
> @@ -180,8 +180,15 @@ static void pegasos2_init(MachineState *machine)
>     pci_bus_irqs(pci_bus, pegasos2_pci_irq, pm, PCI_NUM_PINS);
>
>     /* VIA VT8231 South Bridge (multifunction PCI device) */
> -    via = OBJECT(pci_create_simple_multifunction(pci_bus, PCI_DEVFN(12, 0),
> -                                                 TYPE_VT8231_ISA));
> +    via = OBJECT(pci_new_multifunction(PCI_DEVFN(12, 0), TYPE_VT8231_ISA));
> +
> +    /* Set properties on individual devices before realizing the south bridge */
> +    if (machine->audiodev) {
> +        dev = PCI_DEVICE(object_resolve_path_component(via, "ac97"));
> +        qdev_prop_set_string(DEVICE(dev), "audiodev", machine->audiodev);
> +    }
> +
> +    pci_realize_and_unref(PCI_DEVICE(via), pci_bus, &error_abort);
>     for (i = 0; i < PCI_NUM_PINS; i++) {
>         pm->via_pirq[i] = qdev_get_gpio_in_named(DEVICE(via), "pirq", i);
>     }
> @@ -556,6 +563,7 @@ static void pegasos2_machine_class_init(ObjectClass *oc, void *data)
>     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("7457_v1.2");
>     mc->default_ram_id = "pegasos2.ram";
>     mc->default_ram_size = 512 * MiB;
> +    machine_add_audiodev_property(mc);
>
>     vhc->cpu_in_nested = pegasos2_cpu_in_nested;
>     vhc->hypercall = pegasos2_hypercall;
>

