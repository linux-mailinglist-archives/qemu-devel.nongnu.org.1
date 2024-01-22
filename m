Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC70836590
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 15:36:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRvOw-0006S2-A9; Mon, 22 Jan 2024 09:35:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRvOs-0006Ou-K8
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 09:35:47 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRvOo-0003a6-St
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 09:35:46 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40e86a9fc4bso41903035e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 06:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705934140; x=1706538940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qYoo8Fo+6PVAm2eNAIuBwXIrCE8bc+TGcnBab8pzE6U=;
 b=kqV8e6Lk6RdAFaBZBo45pYCNEquyz5U2rR3k56D23ngFCBvdnLjTQd0BLVWXqZKYCD
 Owm6xwO7MfPISMtchHtD2B0k2XRRtUQIE5nREwLpkL8tS+Cm1NzvQ+T7oX0ToQodyJbW
 tt77zC0lMKxSwDoDA+44/Hrzwr7JlZNqMsur+ayzBj+HXkklwkN+i51YPCdATBtFgEYw
 W7ix40JBIgt7V7LAbk5h3hKA9f93CG2xI9DVOyUuOhsGgHsl1OLlQg6U3mIJLwwMmNpO
 sGjklynd/adWrBLMP+ddmqWzjB6HjcO6VGlC9iLa/+bOP4AHtramMjnZAeKrOGhMhqFu
 t/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705934140; x=1706538940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qYoo8Fo+6PVAm2eNAIuBwXIrCE8bc+TGcnBab8pzE6U=;
 b=ut5bsDpnQ8E3Z3Vvhkd1ZIBcWkUTKEGzz8BRQLHZD25jTsbZwYSdzgaZ9xZ464hStP
 A/0aMbc9ozXdwqUfTRJgQaYZuGoSuIIKbvDfo1A2Mqf2isr5ifDxCfbBmDR2bA7lv5L1
 /Zf9y+taisf/qbhQnmH0cDhFZd3HdR2pxymm6/6JYg8miDhiQywCUlCRHfaU94czio3S
 ZWZEyng6VA+ax416odK8N83pTotZq9XHRnznZXiQ8ZJwaa2ThfkR7uGoMFDsFAVN7GFK
 5wvahQjqLfZzsueJEmhebJfmuFS6gPHKhOqvSzR9tCOBoeyklRW3ZjXzeWRBvoA9k1EY
 IlEQ==
X-Gm-Message-State: AOJu0Yw6LHixyeTUjKcgJS6bxi3vqhtToszdDvg73eFsLPgLT3Bs7u9f
 dpFMlJa6+JnyHpuxCQZHyN9JPop8R95em60P/HttJeK4aMTUGUHO+lihqoy6+7U=
X-Google-Smtp-Source: AGHT+IFWArmvhZKWNpAFOiCKERvH1OBCcdgav2Nh9SX+Am0KIU6Z7cXAJZXmSXgyBfUit4/CzdDGUA==
X-Received: by 2002:a05:600c:291:b0:40e:44de:d2a9 with SMTP id
 17-20020a05600c029100b0040e44ded2a9mr2566921wmk.208.1705934140027; 
 Mon, 22 Jan 2024 06:35:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 je6-20020a05600c1f8600b0040d8d11bf63sm39559584wmb.41.2024.01.22.06.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 06:35:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Ard Biesheuvel <ardb@kernel.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v2 2/3] hw/arm/virt: Wire up non-secure EL2 virtual timer IRQ
Date: Mon, 22 Jan 2024 14:35:36 +0000
Message-Id: <20240122143537.233498-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122143537.233498-1-peter.maydell@linaro.org>
References: <20240122143537.233498-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Armv8.1+ CPUs have the Virtual Host Extension (VHE) which adds a
non-secure EL2 virtual timer.  We implemented the timer itself in the
CPU model, but never wired up its IRQ line to the GIC.

Wire up the IRQ line (this is always safe whether the CPU has the
interrupt or not, since it always creates the outbound IRQ line).
Report it to the guest via dtb and ACPI if the CPU has the feature.

The DTB binding is documented in the kernel's
Documentation/devicetree/bindings/timer/arm\,arch_timer.yaml
and the ACPI table entries are documented in the ACPI specification
version 6.3 or later.

Because the IRQ line ACPI binding is new in 6.3, we need to bump the
FADT table rev to show that we might be using 6.3 features.

Note that exposing this IRQ in the DTB will trigger a bug in EDK2
versions prior to edk2-stable202311, for users who use the virt board
with 'virtualization=on' to enable EL2 emulation and are booting an
EDK2 guest BIOS, if that EDK2 has assertions enabled.  The effect is
that EDK2 will assert on bootup:

 ASSERT [ArmTimerDxe] /home/kraxel/projects/qemu/roms/edk2/ArmVirtPkg/Library/ArmVirtTimerFdtClientLib/ArmVirtTimerFdtClientLib.c(72): PropSize == 36 || PropSize == 48

If you see that assertion you should do one of:
 * update your EDK2 binaries to edk2-stable202311 or newer
 * use the 'virt-8.2' versioned machine type
 * not use 'virtualization=on'

(The versions shipped with QEMU itself have the fix.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt.h    |  2 ++
 hw/arm/virt-acpi-build.c | 20 ++++++++++----
 hw/arm/virt.c            | 60 ++++++++++++++++++++++++++++++++++------
 3 files changed, 67 insertions(+), 15 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index f69239850e6..bb486d36b14 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -130,6 +130,7 @@ struct VirtMachineClass {
     /* Machines < 6.2 have no support for describing cpu topology to guest */
     bool no_cpu_topology;
     bool no_tcg_lpa2;
+    bool no_ns_el2_virt_timer_irq;
 };
 
 struct VirtMachineState {
@@ -173,6 +174,7 @@ struct VirtMachineState {
     PCIBus *bus;
     char *oem_id;
     char *oem_table_id;
+    bool ns_el2_virt_timer_irq;
 };
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index a22a2f43a56..903ddf4a361 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -533,8 +533,8 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 }
 
 /*
- * ACPI spec, Revision 5.1
- * 5.2.24 Generic Timer Description Table (GTDT)
+ * ACPI spec, Revision 6.5
+ * 5.2.25 Generic Timer Description Table (GTDT)
  */
 static void
 build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
@@ -548,7 +548,7 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     uint32_t irqflags = vmc->claim_edge_triggered_timers ?
         1 : /* Interrupt is Edge triggered */
         0;  /* Interrupt is Level triggered  */
-    AcpiTable table = { .sig = "GTDT", .rev = 2, .oem_id = vms->oem_id,
+    AcpiTable table = { .sig = "GTDT", .rev = 3, .oem_id = vms->oem_id,
                         .oem_table_id = vms->oem_table_id };
 
     acpi_table_begin(&table, table_data);
@@ -584,7 +584,15 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, 0, 4);
     /* Platform Timer Offset */
     build_append_int_noprefix(table_data, 0, 4);
-
+    if (vms->ns_el2_virt_timer_irq) {
+        /* Virtual EL2 Timer GSIV */
+        build_append_int_noprefix(table_data, ARCH_TIMER_NS_EL2_VIRT_IRQ, 4);
+        /* Virtual EL2 Timer Flags */
+        build_append_int_noprefix(table_data, irqflags, 4);
+    } else {
+        build_append_int_noprefix(table_data, 0, 4);
+        build_append_int_noprefix(table_data, 0, 4);
+    }
     acpi_table_end(linker, &table);
 }
 
@@ -771,10 +779,10 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
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
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 5cbc69dff83..fa7c233346e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -218,6 +218,20 @@ static void create_randomness(MachineState *ms, const char *node)
     qemu_fdt_setprop(ms->fdt, node, "rng-seed", seed.rng, sizeof(seed.rng));
 }
 
+/*
+ * The CPU object always exposes the NS EL2 virt timer IRQ line,
+ * but we don't want to advertise it to the guest in the dtb or ACPI
+ * table unless it's really going to do something.
+ */
+static bool ns_el2_virt_timer_present(void)
+{
+    ARMCPU *cpu = ARM_CPU(qemu_get_cpu(0));
+    CPUARMState *env = &cpu->env;
+
+    return arm_feature(env, ARM_FEATURE_AARCH64) &&
+        arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, cpu);
+}
+
 static void create_fdt(VirtMachineState *vms)
 {
     MachineState *ms = MACHINE(vms);
@@ -335,15 +349,29 @@ static void fdt_add_timer_nodes(const VirtMachineState *vms)
                                 "arm,armv7-timer");
     }
     qemu_fdt_setprop(ms->fdt, "/timer", "always-on", NULL, 0);
-    qemu_fdt_setprop_cells(ms->fdt, "/timer", "interrupts",
-                           GIC_FDT_IRQ_TYPE_PPI,
-                           INTID_TO_PPI(ARCH_TIMER_S_EL1_IRQ), irqflags,
-                           GIC_FDT_IRQ_TYPE_PPI,
-                           INTID_TO_PPI(ARCH_TIMER_NS_EL1_IRQ), irqflags,
-                           GIC_FDT_IRQ_TYPE_PPI,
-                           INTID_TO_PPI(ARCH_TIMER_VIRT_IRQ), irqflags,
-                           GIC_FDT_IRQ_TYPE_PPI,
-                           INTID_TO_PPI(ARCH_TIMER_NS_EL2_IRQ), irqflags);
+    if (vms->ns_el2_virt_timer_irq) {
+        qemu_fdt_setprop_cells(ms->fdt, "/timer", "interrupts",
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(ARCH_TIMER_S_EL1_IRQ), irqflags,
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(ARCH_TIMER_NS_EL1_IRQ), irqflags,
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(ARCH_TIMER_VIRT_IRQ), irqflags,
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(ARCH_TIMER_NS_EL2_IRQ), irqflags,
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(ARCH_TIMER_NS_EL2_VIRT_IRQ), irqflags);
+    } else {
+        qemu_fdt_setprop_cells(ms->fdt, "/timer", "interrupts",
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(ARCH_TIMER_S_EL1_IRQ), irqflags,
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(ARCH_TIMER_NS_EL1_IRQ), irqflags,
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(ARCH_TIMER_VIRT_IRQ), irqflags,
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(ARCH_TIMER_NS_EL2_IRQ), irqflags);
+    }
 }
 
 static void fdt_add_cpu_nodes(const VirtMachineState *vms)
@@ -786,6 +814,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
             [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
             [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
             [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
+            [GTIMER_HYPVIRT] = ARCH_TIMER_NS_EL2_VIRT_IRQ,
         };
 
         for (unsigned irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
@@ -2221,6 +2250,11 @@ static void machvirt_init(MachineState *machine)
         qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
         object_unref(cpuobj);
     }
+
+    /* Now we've created the CPUs we can see if they have the hypvirt timer */
+    vms->ns_el2_virt_timer_irq = ns_el2_virt_timer_present() &&
+        !vmc->no_ns_el2_virt_timer_irq;
+
     fdt_add_timer_nodes(vms);
     fdt_add_cpu_nodes(vms);
 
@@ -3178,8 +3212,16 @@ DEFINE_VIRT_MACHINE_AS_LATEST(9, 0)
 
 static void virt_machine_8_2_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
     virt_machine_9_0_options(mc);
     compat_props_add(mc->compat_props, hw_compat_8_2, hw_compat_8_2_len);
+    /*
+     * Don't expose NS_EL2_VIRT timer IRQ in DTB on ACPI on 8.2 and
+     * earlier machines. (Exposing it tickles a bug in older EDK2
+     * guest BIOS binaries.)
+     */
+    vmc->no_ns_el2_virt_timer_irq = true;
 }
 DEFINE_VIRT_MACHINE(8, 2)
 
-- 
2.34.1


