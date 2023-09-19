Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA75D7A653E
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 15:34:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiaqo-0005vL-57; Tue, 19 Sep 2023 09:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1qiaqi-0005u0-NP; Tue, 19 Sep 2023 09:33:08 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1qiaqe-0006D0-Ni; Tue, 19 Sep 2023 09:33:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 7373DCE11DF;
 Tue, 19 Sep 2023 13:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A018AC433C8;
 Tue, 19 Sep 2023 13:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695130375;
 bh=+9WBwKO4/WRAwh3EviZ9SjRM+d1/lBTPriTxhSBbZOc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=c/vOU4p6RyDMNggHnfBDZJxHdogehr+iJoXtREerBGQAxunlpVMvHW3K+0+jEZlBm
 g2W7y5sWzignspnbBFdzmdmDBGrK4ZFJk9BoKZikc8tYZCRuveaQAZn/nDDN+bc0NB
 Uyc1p674hEBhHSsv0OHYeUNOyBOoKALIWHvO4teP0Uh2/edp2ulqHU9sHFdCVGey5W
 vC6uwnbFr/FIkQaTOCeaczs3thwwematevn3wkDbps51BIFFpDofedqLd1R3RUnT3R
 GE0D/RzH4757snGFUx1SudDZJSxmBtayzZwdbaf+41R2vZvNYPWJ4oXtA8wgpmhffW
 dl0ufzLKQT/Sg==
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-2bf5bf33bcdso94867481fa.0; 
 Tue, 19 Sep 2023 06:32:55 -0700 (PDT)
X-Gm-Message-State: AOJu0YyL/WDSTq2KcZszPDRuQ12sVakOL95hWNHucrX7XCJxyJk5xaGT
 9ox+QkYb3IqD3allTFNbGMqKTZkH4bHhlpw6KT0=
X-Google-Smtp-Source: AGHT+IF5mUT7ztVgyKGN3JLdZ9PpfkbdGh0+LqPr0gKSAtzC0VvMm1a029BDMf6NiT+xHFA9cldMGCI0ssOfTCiFIMQ=
X-Received: by 2002:a05:651c:2c2:b0:2c0:10ed:431b with SMTP id
 f2-20020a05651c02c200b002c010ed431bmr4201647ljo.23.1695130373701; Tue, 19 Sep
 2023 06:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230919101240.2569334-1-peter.maydell@linaro.org>
 <20230919101240.2569334-3-peter.maydell@linaro.org>
In-Reply-To: <20230919101240.2569334-3-peter.maydell@linaro.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 19 Sep 2023 15:32:41 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF30=hokB8kBNeWYXhr=gCoq7fHuNz6q8sKYuWK+X8stw@mail.gmail.com>
Message-ID: <CAMj1kXF30=hokB8kBNeWYXhr=gCoq7fHuNz6q8sKYuWK+X8stw@mail.gmail.com>
Subject: Re: [RFC 2/3] hw/arm/virt: Wire up non-secure EL2 virtual timer IRQ
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Leif Lindholm <quic_llindhol@quicinc.com>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=ardb@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Tue, 19 Sept 2023 at 12:12, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Armv8.1+ CPUs have the Virtual Host Extension (VHE) which adds
> a non-secure EL2 virtual timer. We implemented the timer itself
> in the CPU model, but never wired up its IRQ line to the GIC.
>
> Wire up the IRQ line (this is always safe whether the CPU has the
> interrupt or not, since it always creates the outbound IRQ line).
> Report it to the guest via dtb and ACPI if the CPU has the feature.
>
> The DTB binding is documented in the kernel's
> Documentation/devicetree/bindings/timer/arm\,arch_timer.yaml
> and the ACPI table entries are documented in the ACPI
> specification version 6.3 or later.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

As mentioned in reply to the cover letter, this needs the hunk below
to avoid using ACPI 6.3 features while claiming compatibility with
ACPI 6.0

With that added,

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>


--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -811,10 +811,10 @@ build_madt(GArray *table_data, BIOSLinker
*linker, VirtMachineState *vms)
 static void build_fadt_rev6(GArray *table_data, BIOSLinker *linker,
                             VirtMachineState *vms, unsigned dsdt_tbl_offset)
 {
-    /* ACPI v6.0 */
+    /* ACPI v6.3 */
     AcpiFadtData fadt = {
         .rev = 6,
-        .minor_ver = 0,
+        .minor_ver = 3,
         .flags = 1 << ACPI_FADT_F_HW_REDUCED_ACPI,
         .xdsdt_tbl_offset = &dsdt_tbl_offset,
     };


> ---
>  include/hw/arm/virt.h    |  2 ++
>  hw/arm/virt-acpi-build.c | 16 ++++++++++++----
>  hw/arm/virt.c            | 29 ++++++++++++++++++++++++++++-
>  3 files changed, 42 insertions(+), 5 deletions(-)
>
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index e1ddbea96be..79b1f9b737d 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -49,6 +49,7 @@
>  #define ARCH_TIMER_S_EL1_IRQ  13
>  #define ARCH_TIMER_NS_EL1_IRQ 14
>  #define ARCH_TIMER_NS_EL2_IRQ 10
> +#define ARCH_TIMER_NS_EL2_VIRT_IRQ 12
>
>  #define VIRTUAL_PMU_IRQ 7
>
> @@ -183,6 +184,7 @@ struct VirtMachineState {
>      PCIBus *bus;
>      char *oem_id;
>      char *oem_table_id;
> +    bool ns_el2_virt_timer_present;
>  };
>
>  #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 6b674231c27..7bc120a0f13 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -573,8 +573,8 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  }
>
>  /*
> - * ACPI spec, Revision 5.1
> - * 5.2.24 Generic Timer Description Table (GTDT)
> + * ACPI spec, Revision 6.5
> + * 5.2.25 Generic Timer Description Table (GTDT)
>   */
>  static void
>  build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> @@ -588,7 +588,7 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      uint32_t irqflags = vmc->claim_edge_triggered_timers ?
>          1 : /* Interrupt is Edge triggered */
>          0;  /* Interrupt is Level triggered  */
> -    AcpiTable table = { .sig = "GTDT", .rev = 2, .oem_id = vms->oem_id,
> +    AcpiTable table = { .sig = "GTDT", .rev = 3, .oem_id = vms->oem_id,
>                          .oem_table_id = vms->oem_table_id };
>
>      acpi_table_begin(&table, table_data);
> @@ -624,7 +624,15 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      build_append_int_noprefix(table_data, 0, 4);
>      /* Platform Timer Offset */
>      build_append_int_noprefix(table_data, 0, 4);
> -
> +    if (vms->ns_el2_virt_timer_present) {
> +        /* Virtual EL2 Timer GSIV */
> +        build_append_int_noprefix(table_data, ARCH_TIMER_NS_EL2_VIRT_IRQ + 16, 4);
> +        /* Virtual EL2 Timer Flags */
> +        build_append_int_noprefix(table_data, irqflags, 4);
> +    } else {
> +        build_append_int_noprefix(table_data, 0, 4);
> +        build_append_int_noprefix(table_data, 0, 4);
> +    }
>      acpi_table_end(linker, &table);
>  }
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 8ad78b23c24..4df7cd0a366 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -248,6 +248,19 @@ static void create_randomness(MachineState *ms, const char *node)
>      qemu_fdt_setprop(ms->fdt, node, "rng-seed", seed.rng, sizeof(seed.rng));
>  }
>
> +/*
> + * The CPU object always exposes the NS EL2 virt timer IRQ line,
> + * but we don't want to advertise it to the guest in the dtb or ACPI
> + * table unless it's really going to do something.
> + */
> +static bool ns_el2_virt_timer_present(void)
> +{
> +    ARMCPU *cpu = ARM_CPU(qemu_get_cpu(0));
> +    CPUARMState *env = &cpu->env;
> +
> +    return arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, cpu);
> +}
> +
>  static void create_fdt(VirtMachineState *vms)
>  {
>      MachineState *ms = MACHINE(vms);
> @@ -365,11 +378,20 @@ static void fdt_add_timer_nodes(const VirtMachineState *vms)
>                                  "arm,armv7-timer");
>      }
>      qemu_fdt_setprop(ms->fdt, "/timer", "always-on", NULL, 0);
> -    qemu_fdt_setprop_cells(ms->fdt, "/timer", "interrupts",
> +    if (vms->ns_el2_virt_timer_present) {
> +        qemu_fdt_setprop_cells(ms->fdt, "/timer", "interrupts",
> +                       GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_S_EL1_IRQ, irqflags,
> +                       GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_NS_EL1_IRQ, irqflags,
> +                       GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_VIRT_IRQ, irqflags,
> +                       GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_NS_EL2_IRQ, irqflags,
> +                       GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_NS_EL2_VIRT_IRQ, irqflags);
> +    } else {
> +        qemu_fdt_setprop_cells(ms->fdt, "/timer", "interrupts",
>                         GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_S_EL1_IRQ, irqflags,
>                         GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_NS_EL1_IRQ, irqflags,
>                         GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_VIRT_IRQ, irqflags,
>                         GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_NS_EL2_IRQ, irqflags);
> +    }
>  }
>
>  static void fdt_add_cpu_nodes(const VirtMachineState *vms)
> @@ -810,6 +832,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
>              [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
>              [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
>              [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
> +            [GTIMER_HYPVIRT] = ARCH_TIMER_NS_EL2_VIRT_IRQ,
>          };
>
>          for (irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
> @@ -2249,6 +2272,10 @@ static void machvirt_init(MachineState *machine)
>          qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
>          object_unref(cpuobj);
>      }
> +
> +    /* Now we've created the CPUs we can see if they have the hypvirt timer */
> +    vms->ns_el2_virt_timer_present = ns_el2_virt_timer_present();
> +
>      fdt_add_timer_nodes(vms);
>      fdt_add_cpu_nodes(vms);
>
> --
> 2.34.1
>

