Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F6284B675
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Feb 2024 14:33:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXLWJ-0000pz-Mo; Tue, 06 Feb 2024 08:29:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXLWB-0000aq-K8
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:29:43 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXLW6-0008Ep-KX
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:29:43 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33b2960ff60so366378f8f.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 05:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707226177; x=1707830977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ggn5L22e93CND5ondADlE8/JR7HzOuNvJpvjSBhq8tQ=;
 b=rxm77YxmxMkcZDT8LozJeTvxEtvrtKCUfne0AKELt6iaxq3T86ZzdtG249tNAYgTWO
 q3OOuHZWegfuvcdkm1znssvjZK8yHohTcLMG5u+uUvVhJoJEfzjySiCFPt+R7srWJ/sr
 sLsbyYtTdDM+C0E1rJM/f22qLHOynlXU+O8wpD7Oc5bUrCfw+Cw7QA1o5NDkDr8JMVLX
 jWSuQBdqgWxlm11RYoXX5IoA4i0BeJtgULHjsbzweDD7zMmB6i8M7lsIE24+31p1y9UK
 W6czsInM8TPTf7y9ofTVFzsBNIq24r5ebTmp5JMGeA7c/Jenr3AaN1uM0N/tU+IHtO5h
 pXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707226177; x=1707830977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ggn5L22e93CND5ondADlE8/JR7HzOuNvJpvjSBhq8tQ=;
 b=BnIuMB99i/JJIczVBlTSXadm6bxk0aj4ZW1frxkf6OqEmOHs5IwjJsZgqz9f3l8RUE
 zMWhNIS+mTIk62d+HMJzTzrEiZMFXAGGbLkoKPGXx9+8A68iBKmFR/rjvdPrXaxrSrnM
 BZ0qrxUvswgkFe4U70aNfBcGJfPTvpn07AYlAc3tk/JwcBSds0VcufqTAGU41WfmChp1
 qIbTNzohFDtMHi9et9KUmId0UIc7kWijjQxOUGFC5AkojB1d0YeV24wgwQ9T119M6wLQ
 yN75kU4MueTkIPu/o5s34JQn++KUbUdopKEMadkqSmSsBv2gWIcmm9T4qd3hJzSdrYXz
 SJaA==
X-Gm-Message-State: AOJu0YxLCmVwGKCUxhMhj5apE7OHx44zw8m3+mjE6KUj4PpugLeZ+cTl
 Eb0oVgv3pChyX0bye7mMK0DI4YMwqpiiFiU2ilbDQpVlLS4bg9ZpXQWfH6qLCps=
X-Google-Smtp-Source: AGHT+IHfxYlHj4qmQuzavbLMudZkxiF84JSJcd71A8mF1EyhovJ0S6SegfsxOvfFXwpY9yDGVZ2gmQ==
X-Received: by 2002:a5d:6e49:0:b0:33a:fe4a:90be with SMTP id
 j9-20020a5d6e49000000b0033afe4a90bemr1198815wrz.23.1707226177019; 
 Tue, 06 Feb 2024 05:29:37 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVcoOzlr159A7/0k0w6XzNZmMFBGgp+i9cBxTw2DeOzMC6hWnVfjAqBy2xbEjgoiWXfe5tVGFumjolDD8wlRSZwSJ0vlvM=
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a056000108700b0033b470a137esm1492932wrw.79.2024.02.06.05.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 05:29:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 09/13] hw/arm/mps3r: Add CPUs, GIC, and per-CPU RAM
Date: Tue,  6 Feb 2024 13:29:27 +0000
Message-Id: <20240206132931.38376-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206132931.38376-1-peter.maydell@linaro.org>
References: <20240206132931.38376-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Create the CPUs, the GIC, and the per-CPU RAM block for
the mps3-an536 board.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Some parts of this might need to end up parameterisable if/when
we add another machine type to this source file, but rather than
trying to guess which parts, I stuck with the simple code for now.

I thought about creating a "wrapper" device like our hw/cpu/a15mpcore.c
etc for the Cortex-R52 and GIC, since in hardware the GIC is part
of the CPU proper, not an external device. However given the need
for some of the devices in this system to be per-CPU and have
per-CPU interrupts, this seemed too awkward, so I have open
coded the creation of the CPUs and GIC here. We can always
consider refactoring later if we get another Cortex-R52 board.
---
 hw/arm/mps3r.c | 180 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 177 insertions(+), 3 deletions(-)

diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index 888a846d23c..6473f62d677 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -27,10 +27,14 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qlist.h"
 #include "exec/address-spaces.h"
 #include "cpu.h"
 #include "hw/boards.h"
+#include "hw/qdev-properties.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/bsa.h"
+#include "hw/intc/arm_gicv3.h"
 
 /* Define the layout of RAM and ROM in a board */
 typedef struct RAMInfo {
@@ -60,6 +64,10 @@ typedef struct RAMInfo {
 #define IS_ROM 2
 
 #define MPS3R_RAM_MAX 9
+#define MPS3R_CPU_MAX 2
+
+#define PERIPHBASE 0xf0000000
+#define NUM_SPIS 96
 
 typedef enum MPS3RFPGAType {
     FPGA_AN536,
@@ -69,11 +77,18 @@ struct MPS3RMachineClass {
     MachineClass parent;
     MPS3RFPGAType fpga_type;
     const RAMInfo *raminfo;
+    hwaddr loader_start;
 };
 
 struct MPS3RMachineState {
     MachineState parent;
+    struct arm_boot_info bootinfo;
     MemoryRegion ram[MPS3R_RAM_MAX];
+    Object *cpu[MPS3R_CPU_MAX];
+    MemoryRegion cpu_sysmem[MPS3R_CPU_MAX];
+    MemoryRegion sysmem_alias[MPS3R_CPU_MAX];
+    MemoryRegion cpu_ram[MPS3R_CPU_MAX];
+    GICv3State gic;
 };
 
 #define TYPE_MPS3R_MACHINE "mps3r"
@@ -163,6 +178,107 @@ static MemoryRegion *mr_for_raminfo(MPS3RMachineState *mms,
     return ram;
 }
 
+/*
+ * There is no defined secondary boot protocol for Linux for the AN536,
+ * because real hardware has a restriction that atomic operations between
+ * the two CPUs do not function correctly, and so true SMP is not
+ * possible. Therefore for cases where the user is directly booting
+ * a kernel, we treat the system as essentially uniprocessor, and
+ * put the secondary CPU into power-off state (as if the user on the
+ * real hardware had configured the secondary to be halted via the
+ * SCC config registers).
+ *
+ * Note that the default secondary boot code would not work here anyway
+ * as it assumes a GICv2, and we have a GICv3.
+ */
+static void mps3r_write_secondary_boot(ARMCPU *cpu,
+                                       const struct arm_boot_info *info)
+{
+    /*
+     * Power the secondary CPU off. This means we don't need to write any
+     * boot code into guest memory. Note that the 'cpu' argument to this
+     * function is the primary CPU we passed to arm_load_kernel(), not
+     * the secondary. Loop around all the other CPUs, as the boot.c
+     * code does for the "disable secondaries if PSCI is enabled" case.
+     */
+    for (CPUState *cs = first_cpu; cs; cs = CPU_NEXT(cs)) {
+        if (cs != first_cpu) {
+            object_property_set_bool(OBJECT(cs), "start-powered-off", true,
+                                     &error_abort);
+        }
+    }
+}
+
+static void mps3r_secondary_cpu_reset(ARMCPU *cpu,
+                                      const struct arm_boot_info *info)
+{
+    /* We don't need to do anything here because the CPU will be off */
+}
+
+static void create_gic(MPS3RMachineState *mms, MemoryRegion *sysmem)
+{
+    MachineState *machine = MACHINE(mms);
+    DeviceState *gicdev;
+    QList *redist_region_count;
+
+    object_initialize_child(OBJECT(mms), "gic", &mms->gic, TYPE_ARM_GICV3);
+    gicdev = DEVICE(&mms->gic);
+    qdev_prop_set_uint32(gicdev, "num-cpu", machine->smp.cpus);
+    qdev_prop_set_uint32(gicdev, "num-irq", NUM_SPIS + GIC_INTERNAL);
+    redist_region_count = qlist_new();
+    qlist_append_int(redist_region_count, machine->smp.cpus);
+    qdev_prop_set_array(gicdev, "redist-region-count", redist_region_count);
+    object_property_set_link(OBJECT(&mms->gic), "sysmem",
+                             OBJECT(sysmem), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&mms->gic), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&mms->gic), 0, PERIPHBASE);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&mms->gic), 1, PERIPHBASE + 0x100000);
+    /*
+     * Wire the outputs from each CPU's generic timer and the GICv3
+     * maintenance interrupt signal to the appropriate GIC PPI inputs,
+     * and the GIC's IRQ/FIQ/VIRQ/VFIQ interrupt outputs to the CPU's inputs.
+     */
+    for (int i = 0; i < machine->smp.cpus; i++) {
+        DeviceState *cpudev = DEVICE(mms->cpu[i]);
+        SysBusDevice *gicsbd = SYS_BUS_DEVICE(&mms->gic);
+        int intidbase = NUM_SPIS + i * GIC_INTERNAL;
+        int irq;
+        /*
+         * Mapping from the output timer irq lines from the CPU to the
+         * GIC PPI inputs used for this board. This isn't a BSA board,
+         * but it uses the standard convention for the PPI numbers.
+         */
+        const int timer_irq[] = {
+            [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
+            [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
+            [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
+        };
+
+        for (irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
+            qdev_connect_gpio_out(cpudev, irq,
+                                  qdev_get_gpio_in(gicdev,
+                                                   intidbase + timer_irq[irq]));
+        }
+
+        qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt", 0,
+                                    qdev_get_gpio_in(gicdev,
+                                                     intidbase + ARCH_GIC_MAINT_IRQ));
+
+        qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
+                                    qdev_get_gpio_in(gicdev,
+                                                     intidbase + VIRTUAL_PMU_IRQ));
+
+        sysbus_connect_irq(gicsbd, i,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
+        sysbus_connect_irq(gicsbd, i + machine->smp.cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
+        sysbus_connect_irq(gicsbd, i + 2 * machine->smp.cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
+        sysbus_connect_irq(gicsbd, i + 3 * machine->smp.cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
+    }
+}
+
 static void mps3r_common_init(MachineState *machine)
 {
     MPS3RMachineState *mms = MPS3R_MACHINE(machine);
@@ -173,6 +289,50 @@ static void mps3r_common_init(MachineState *machine)
         MemoryRegion *mr = mr_for_raminfo(mms, ri);
         memory_region_add_subregion(sysmem, ri->base, mr);
     }
+
+    assert(machine->smp.cpus <= MPS3R_CPU_MAX);
+    for (int i = 0; i < machine->smp.cpus; i++) {
+        g_autofree char *sysmem_name = g_strdup_printf("cpu-%d-memory", i);
+        g_autofree char *ramname = g_strdup_printf("cpu-%d-memory", i);
+        g_autofree char *alias_name = g_strdup_printf("sysmem-alias-%d", i);
+
+        /*
+         * Each CPU has some private RAM/peripherals, so create the container
+         * which will house those, with the whole-machine system memory being
+         * used where there's no CPU-specific device. Note that we need the
+         * sysmem_alias aliases because we can't put one MR (the original
+         * 'sysmem') into more than one other MR.
+         */
+        memory_region_init(&mms->cpu_sysmem[i], OBJECT(machine),
+                           sysmem_name, UINT64_MAX);
+        memory_region_init_alias(&mms->sysmem_alias[i], OBJECT(machine),
+                                 alias_name, sysmem, 0, UINT64_MAX);
+        memory_region_add_subregion_overlap(&mms->cpu_sysmem[i], 0,
+                                            &mms->sysmem_alias[i], -1);
+
+        mms->cpu[i] = object_new(machine->cpu_type);
+        object_property_set_link(mms->cpu[i], "memory",
+                                 OBJECT(&mms->cpu_sysmem[i]), &error_abort);
+        object_property_set_int(mms->cpu[i], "reset-cbar",
+                                PERIPHBASE, &error_abort);
+        qdev_realize(DEVICE(mms->cpu[i]), NULL, &error_fatal);
+        object_unref(mms->cpu[i]);
+
+        /* Per-CPU RAM */
+        memory_region_init_ram(&mms->cpu_ram[i], NULL, ramname,
+                               0x1000, &error_fatal);
+        memory_region_add_subregion(&mms->cpu_sysmem[i], 0xe7c01000,
+                                    &mms->cpu_ram[i]);
+    }
+
+    create_gic(mms, sysmem);
+
+    mms->bootinfo.ram_size = machine->ram_size;
+    mms->bootinfo.board_id = -1;
+    mms->bootinfo.loader_start = mmc->loader_start;
+    mms->bootinfo.write_secondary_boot = mps3r_write_secondary_boot;
+    mms->bootinfo.secondary_cpu_reset_hook = mps3r_secondary_cpu_reset;
+    arm_load_kernel(ARM_CPU(mms->cpu[0]), machine, &mms->bootinfo);
 }
 
 static void mps3r_set_default_ram_info(MPS3RMachineClass *mmc)
@@ -189,6 +349,7 @@ static void mps3r_set_default_ram_info(MPS3RMachineClass *mmc)
             /* Found the entry for "system memory" */
             mc->default_ram_size = p->size;
             mc->default_ram_id = p->name;
+            mmc->loader_start = p->base;
             return;
         }
     }
@@ -212,9 +373,22 @@ static void mps3r_an536_class_init(ObjectClass *oc, void *data)
     };
 
     mc->desc = "ARM MPS3 with AN536 FPGA image for Cortex-R52";
-    mc->default_cpus = 2;
-    mc->min_cpus = mc->default_cpus;
-    mc->max_cpus = mc->default_cpus;
+    /*
+     * In the real FPGA image there are always two cores, but the standard
+     * initial setting for the SCC SYSCON 0x000 register is 0x21, meaning
+     * that the second core is held in reset and halted. Many images built for
+     * the board do not expect the second core to run at startup (especially
+     * since on the real FPGA image it is not possible to use LDREX/STREX
+     * in RAM between the two cores, so a true SMP setup isn't supported).
+     *
+     * As QEMU's equivalent of this, we support both -smp 1 and -smp 2,
+     * with the default being -smp 1. This seems a more intuitive UI for
+     * QEMU users than, for instance, having a machine property to allow
+     * the user to set the initial value of the SYSCON 0x000 register.
+     */
+    mc->default_cpus = 1;
+    mc->min_cpus = 1;
+    mc->max_cpus = 2;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-r52");
     mc->valid_cpu_types = valid_cpu_types;
     mmc->raminfo = an536_raminfo;
-- 
2.34.1


