Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 716F67CFB69
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:41:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTCe-00036E-S7; Thu, 19 Oct 2023 09:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBr-0001sJ-JJ
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:57 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBj-0001DD-0T
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:53 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-32d80ae19f8so6155850f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697722543; x=1698327343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VLzkzH17g3g4aCNQ6TJgXCK/i2o/eb5PrBjVD/MgSis=;
 b=CQMGVvjeC5hQpcrdJQAy0eMhP3cA1MdVt1vYt/Vetl5604p/PwqIYKOyOovO0vDvhO
 2I739aYoQhzcFYoHG5dqIC6a/jbunsI+emTB4XZtt7+7LS1x81uMbLLbPIC4dzq1B2iL
 Qt20qGBp0xf6NIPPflesx0e7fNFhGOofW8zdAjP0cEd+QNVMHLW9IYLWX2wvfbrmELTD
 FiLyQUqUEJ02Z71yjCETNq3Sw7TIDqWDHKy5QfFT1MXWx2QwZvaCD2z9O+XaTsZhpkP9
 m3oFWcxXAc+sN3I5e8wYCNprdSLsOBkeBXYnmqeutFYCg3FKP2NrSNsup0nzfQLb073w
 0hcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697722543; x=1698327343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VLzkzH17g3g4aCNQ6TJgXCK/i2o/eb5PrBjVD/MgSis=;
 b=KIQV8XXf4/h7T+xLPvP2ApXP7SvdBPWnpDyN9EbIPgBwr3Jsy5KmFJVBC8ChJysuPq
 Kp3qlIoxjA384mcwzRD50YeHlxdNMppAW5OztkHfqnkH/k0BppYynRpeDCjLkLzqY7WM
 hLQSD+9h8XfcLIpKM9ZZL3QGFzN4bfro4yRKd8QYRmnpPm9ad/PMWdgznVtGUsR+bUFg
 bzLhGf5Vxgwiw20/XQjc8L0YTY8pzdGGq4ToFFlcwAl9X8AiAdGyCTIEmT7mvl6/zzFo
 Ntc6fKA2J0ZLuT0Yv7M1wRfAt8aa3T7G5MfNOozXCYlYsLax36LnP9e2FVjuxE1ydJPy
 y0xg==
X-Gm-Message-State: AOJu0YwTjeW/JJ2Tn/eV7wl0wCj0HN9ye1b5R/jaU/pB1c6ELmmzKQtx
 EP9ZeDk+TpDW6wW5nLLXnXDzg+KY8RUQGij0v30=
X-Google-Smtp-Source: AGHT+IGtBb1pSEkts+8/EdKXCKL3C5o7E+m85DU/SFEwkN+j8sHHWJqJiQBJrQe0JUfTS3ShMT/vlQ==
X-Received: by 2002:adf:ce07:0:b0:329:6662:ac1d with SMTP id
 p7-20020adfce07000000b003296662ac1dmr1590062wrn.24.1697722543550; 
 Thu, 19 Oct 2023 06:35:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d28-20020adf9b9c000000b0031f3ad17b2csm4512690wrc.52.2023.10.19.06.35.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 06:35:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/24] {include/}hw/arm: refactor virt PPI logic
Date: Thu, 19 Oct 2023 14:35:23 +0100
Message-Id: <20231019133537.2114929-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133537.2114929-1-peter.maydell@linaro.org>
References: <20231019133537.2114929-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Leif Lindholm <quic_llindhol@quicinc.com>

GIC Private Peripheral Interrupts (PPI) are defined as GIC INTID 16-31.
As in, PPI0 is INTID16 .. PPI15 is INTID31.
Arm's Base System Architecture specification (BSA) lists the mandated and
recommended private interrupt IDs by INTID, not by PPI index. But current
definitions in virt define them by PPI index, complicating cross
referencing.

Meanwhile, the PPI(x) macro counterintuitively adds 16 to the input value,
converting a PPI index to an INTID.

Resolve this by redefining the BSA-allocated PPIs by their INTIDs,
and replacing the PPI(x) macro with an INTID_TO_PPI(x) one where required.

Signed-off-by: Leif Lindholm <quic_llindhol@quicinc.com>
Message-id: 20230919090229.188092-2-quic_llindhol@quicinc.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt.h    | 14 +++++++-------
 hw/arm/virt-acpi-build.c | 12 ++++++------
 hw/arm/virt.c            | 24 ++++++++++++++----------
 3 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index e1ddbea96be..5704d95736d 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -43,16 +43,16 @@
 #define NUM_VIRTIO_TRANSPORTS 32
 #define NUM_SMMU_IRQS          4
 
-#define ARCH_GIC_MAINT_IRQ  9
+#define ARCH_GIC_MAINT_IRQ  25
 
-#define ARCH_TIMER_VIRT_IRQ   11
-#define ARCH_TIMER_S_EL1_IRQ  13
-#define ARCH_TIMER_NS_EL1_IRQ 14
-#define ARCH_TIMER_NS_EL2_IRQ 10
+#define ARCH_TIMER_VIRT_IRQ   27
+#define ARCH_TIMER_S_EL1_IRQ  29
+#define ARCH_TIMER_NS_EL1_IRQ 30
+#define ARCH_TIMER_NS_EL2_IRQ 26
 
-#define VIRTUAL_PMU_IRQ 7
+#define VIRTUAL_PMU_IRQ 23
 
-#define PPI(irq) ((irq) + 16)
+#define INTID_TO_PPI(irq) ((irq) - 16)
 
 /* See Linux kernel arch/arm64/include/asm/pvclock-abi.h */
 #define PVTIME_SIZE_PER_CPU 64
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 6b674231c27..9ce136cd88c 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -601,21 +601,21 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
      * The interrupt values are the same with the device tree when adding 16
      */
     /* Secure EL1 timer GSIV */
-    build_append_int_noprefix(table_data, ARCH_TIMER_S_EL1_IRQ + 16, 4);
+    build_append_int_noprefix(table_data, ARCH_TIMER_S_EL1_IRQ, 4);
     /* Secure EL1 timer Flags */
     build_append_int_noprefix(table_data, irqflags, 4);
     /* Non-Secure EL1 timer GSIV */
-    build_append_int_noprefix(table_data, ARCH_TIMER_NS_EL1_IRQ + 16, 4);
+    build_append_int_noprefix(table_data, ARCH_TIMER_NS_EL1_IRQ, 4);
     /* Non-Secure EL1 timer Flags */
     build_append_int_noprefix(table_data, irqflags |
                               1UL << 2, /* Always-on Capability */
                               4);
     /* Virtual timer GSIV */
-    build_append_int_noprefix(table_data, ARCH_TIMER_VIRT_IRQ + 16, 4);
+    build_append_int_noprefix(table_data, ARCH_TIMER_VIRT_IRQ, 4);
     /* Virtual Timer Flags */
     build_append_int_noprefix(table_data, irqflags, 4);
     /* Non-Secure EL2 timer GSIV */
-    build_append_int_noprefix(table_data, ARCH_TIMER_NS_EL2_IRQ + 16, 4);
+    build_append_int_noprefix(table_data, ARCH_TIMER_NS_EL2_IRQ, 4);
     /* Non-Secure EL2 timer Flags */
     build_append_int_noprefix(table_data, irqflags, 4);
     /* CntReadBase Physical address */
@@ -729,9 +729,9 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     for (i = 0; i < MACHINE(vms)->smp.cpus; i++) {
         ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(i));
         uint64_t physical_base_address = 0, gich = 0, gicv = 0;
-        uint32_t vgic_interrupt = vms->virt ? PPI(ARCH_GIC_MAINT_IRQ) : 0;
+        uint32_t vgic_interrupt = vms->virt ? ARCH_GIC_MAINT_IRQ : 0;
         uint32_t pmu_interrupt = arm_feature(&armcpu->env, ARM_FEATURE_PMU) ?
-                                             PPI(VIRTUAL_PMU_IRQ) : 0;
+                                             VIRTUAL_PMU_IRQ : 0;
 
         if (vms->gic_version == VIRT_GIC_VERSION_2) {
             physical_base_address = memmap[VIRT_GIC_CPU].base;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 15e74249f9d..ebc9f3fdb1d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -366,10 +366,14 @@ static void fdt_add_timer_nodes(const VirtMachineState *vms)
     }
     qemu_fdt_setprop(ms->fdt, "/timer", "always-on", NULL, 0);
     qemu_fdt_setprop_cells(ms->fdt, "/timer", "interrupts",
-                       GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_S_EL1_IRQ, irqflags,
-                       GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_NS_EL1_IRQ, irqflags,
-                       GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_VIRT_IRQ, irqflags,
-                       GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_NS_EL2_IRQ, irqflags);
+                           GIC_FDT_IRQ_TYPE_PPI,
+                           INTID_TO_PPI(ARCH_TIMER_S_EL1_IRQ), irqflags,
+                           GIC_FDT_IRQ_TYPE_PPI,
+                           INTID_TO_PPI(ARCH_TIMER_NS_EL1_IRQ), irqflags,
+                           GIC_FDT_IRQ_TYPE_PPI,
+                           INTID_TO_PPI(ARCH_TIMER_VIRT_IRQ), irqflags,
+                           GIC_FDT_IRQ_TYPE_PPI,
+                           INTID_TO_PPI(ARCH_TIMER_NS_EL2_IRQ), irqflags);
 }
 
 static void fdt_add_cpu_nodes(const VirtMachineState *vms)
@@ -800,7 +804,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
      */
     for (i = 0; i < smp_cpus; i++) {
         DeviceState *cpudev = DEVICE(qemu_get_cpu(i));
-        int ppibase = NUM_IRQS + i * GIC_INTERNAL + GIC_NR_SGIS;
+        int intidbase = NUM_IRQS + i * GIC_INTERNAL;
         /* Mapping from the output timer irq lines from the CPU to the
          * GIC PPI inputs we use for the virt board.
          */
@@ -814,22 +818,22 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
         for (unsigned irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
             qdev_connect_gpio_out(cpudev, irq,
                                   qdev_get_gpio_in(vms->gic,
-                                                   ppibase + timer_irq[irq]));
+                                                   intidbase + timer_irq[irq]));
         }
 
         if (vms->gic_version != VIRT_GIC_VERSION_2) {
             qemu_irq irq = qdev_get_gpio_in(vms->gic,
-                                            ppibase + ARCH_GIC_MAINT_IRQ);
+                                            intidbase + ARCH_GIC_MAINT_IRQ);
             qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
                                         0, irq);
         } else if (vms->virt) {
             qemu_irq irq = qdev_get_gpio_in(vms->gic,
-                                            ppibase + ARCH_GIC_MAINT_IRQ);
+                                            intidbase + ARCH_GIC_MAINT_IRQ);
             sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus, irq);
         }
 
         qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
-                                    qdev_get_gpio_in(vms->gic, ppibase
+                                    qdev_get_gpio_in(vms->gic, intidbase
                                                      + VIRTUAL_PMU_IRQ));
 
         sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
@@ -1989,7 +1993,7 @@ static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysmem)
             if (pmu) {
                 assert(arm_feature(&ARM_CPU(cpu)->env, ARM_FEATURE_PMU));
                 if (kvm_irqchip_in_kernel()) {
-                    kvm_arm_pmu_set_irq(cpu, PPI(VIRTUAL_PMU_IRQ));
+                    kvm_arm_pmu_set_irq(cpu, VIRTUAL_PMU_IRQ);
                 }
                 kvm_arm_pmu_init(cpu);
             }
-- 
2.34.1


