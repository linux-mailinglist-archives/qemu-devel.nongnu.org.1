Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C43C07A5F3A
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 12:14:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiXiz-0003Jh-1r; Tue, 19 Sep 2023 06:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qiXis-0003Fb-CI
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:12:50 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qiXio-0005M0-Qu
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:12:50 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31f737b8b69so5269959f8f.3
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 03:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695118364; x=1695723164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j8JmbSqEXt6UMOnruJcxa+Gd6UTGS29A+j/7/Q5TP94=;
 b=eDS4TC21ogB5QqxpQOBUftpGZl/vWPQM5H15xyAj7O8KKOl+bG3PAVMvGyEG8BWA+b
 Rf3gjZbLuKXzoqQqKC8QnWq9a0HOb4sn7DJo6fJ5UIdBWpocM/UpEEW3DQEhD8Q6R7Nm
 KLZaRP/3D2e30asarpJCZ6ndSMqoM5f6JYxrWQXugJH91HVkePVqrWAtfm94qww67yP0
 6vBmFzOmarcBzw4cv2mkgnb6riSkiG4nRU2EQp7hk0vsKiPP2awZwIdm5OWSqDtiCQPc
 +r5aE+saLpSt1K5eXRXcrEirwdncBnzKkZ29eb/qd+l9fDJPCxXKfoq6xY+L4ydL4tra
 6EKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695118364; x=1695723164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j8JmbSqEXt6UMOnruJcxa+Gd6UTGS29A+j/7/Q5TP94=;
 b=WDsezjG4p4/h5Z2Nd/ASdHg7q0Ybfako1pVg4PmlWJ1ggzSKUAu2n/X0wgHPGyyUbe
 mfM1WLVs6XzqG3kt4iV4xqwlwX5NpGEYIV780A2gkkrZhjYZfy32I9B1was6CnL5xGVw
 G1bZwYVe9IfrVfyjOIVhZumjMWN78uS8RSuB1O5l95AlYWDbBEwqqr4l5OXIvr8ZtQ/T
 q/3BVYPiA5rB23mjd1WTf3Ud3UpxNfH/8DaNRE7ys2aDbs9U5H8oDC1G8Eky2J9g1mx4
 E+VPEA4aAMBPvxMkE1dc14eAjnnS3cEwQ79PUnQoHwK0IoeCNnfhGU2gz2VX+lhCoA0H
 4SxA==
X-Gm-Message-State: AOJu0YyWVn6Xgj91B3BJ05Hj9A8boFZQkfn3Y3Tvk+JsY8E49J73ecRC
 ImJMPYqBh4vAvidcPMkU4B2zbQ==
X-Google-Smtp-Source: AGHT+IFYmpSsuq3jsmdel8xZkJKf5F7zoRW8vGP+ZIaYrFATPkfXsRLYrUOL9Oq55kZNt2jmGpsvtA==
X-Received: by 2002:a5d:66c7:0:b0:316:f24b:597a with SMTP id
 k7-20020a5d66c7000000b00316f24b597amr10388719wrw.46.1695118363947; 
 Tue, 19 Sep 2023 03:12:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ba13-20020a0560001c0d00b0031ddf6cc89csm12290136wrb.98.2023.09.19.03.12.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 03:12:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Ard Biesheuvel <ardb@kernel.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [RFC 2/3] hw/arm/virt: Wire up non-secure EL2 virtual timer IRQ
Date: Tue, 19 Sep 2023 11:12:39 +0100
Message-Id: <20230919101240.2569334-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919101240.2569334-1-peter.maydell@linaro.org>
References: <20230919101240.2569334-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Armv8.1+ CPUs have the Virtual Host Extension (VHE) which adds
a non-secure EL2 virtual timer. We implemented the timer itself
in the CPU model, but never wired up its IRQ line to the GIC.

Wire up the IRQ line (this is always safe whether the CPU has the
interrupt or not, since it always creates the outbound IRQ line).
Report it to the guest via dtb and ACPI if the CPU has the feature.

The DTB binding is documented in the kernel's
Documentation/devicetree/bindings/timer/arm\,arch_timer.yaml
and the ACPI table entries are documented in the ACPI
specification version 6.3 or later.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt.h    |  2 ++
 hw/arm/virt-acpi-build.c | 16 ++++++++++++----
 hw/arm/virt.c            | 29 ++++++++++++++++++++++++++++-
 3 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index e1ddbea96be..79b1f9b737d 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -49,6 +49,7 @@
 #define ARCH_TIMER_S_EL1_IRQ  13
 #define ARCH_TIMER_NS_EL1_IRQ 14
 #define ARCH_TIMER_NS_EL2_IRQ 10
+#define ARCH_TIMER_NS_EL2_VIRT_IRQ 12
 
 #define VIRTUAL_PMU_IRQ 7
 
@@ -183,6 +184,7 @@ struct VirtMachineState {
     PCIBus *bus;
     char *oem_id;
     char *oem_table_id;
+    bool ns_el2_virt_timer_present;
 };
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 6b674231c27..7bc120a0f13 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -573,8 +573,8 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 }
 
 /*
- * ACPI spec, Revision 5.1
- * 5.2.24 Generic Timer Description Table (GTDT)
+ * ACPI spec, Revision 6.5
+ * 5.2.25 Generic Timer Description Table (GTDT)
  */
 static void
 build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
@@ -588,7 +588,7 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     uint32_t irqflags = vmc->claim_edge_triggered_timers ?
         1 : /* Interrupt is Edge triggered */
         0;  /* Interrupt is Level triggered  */
-    AcpiTable table = { .sig = "GTDT", .rev = 2, .oem_id = vms->oem_id,
+    AcpiTable table = { .sig = "GTDT", .rev = 3, .oem_id = vms->oem_id,
                         .oem_table_id = vms->oem_table_id };
 
     acpi_table_begin(&table, table_data);
@@ -624,7 +624,15 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, 0, 4);
     /* Platform Timer Offset */
     build_append_int_noprefix(table_data, 0, 4);
-
+    if (vms->ns_el2_virt_timer_present) {
+        /* Virtual EL2 Timer GSIV */
+        build_append_int_noprefix(table_data, ARCH_TIMER_NS_EL2_VIRT_IRQ + 16, 4);
+        /* Virtual EL2 Timer Flags */
+        build_append_int_noprefix(table_data, irqflags, 4);
+    } else {
+        build_append_int_noprefix(table_data, 0, 4);
+        build_append_int_noprefix(table_data, 0, 4);
+    }
     acpi_table_end(linker, &table);
 }
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 8ad78b23c24..4df7cd0a366 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -248,6 +248,19 @@ static void create_randomness(MachineState *ms, const char *node)
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
+    return arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, cpu);
+}
+
 static void create_fdt(VirtMachineState *vms)
 {
     MachineState *ms = MACHINE(vms);
@@ -365,11 +378,20 @@ static void fdt_add_timer_nodes(const VirtMachineState *vms)
                                 "arm,armv7-timer");
     }
     qemu_fdt_setprop(ms->fdt, "/timer", "always-on", NULL, 0);
-    qemu_fdt_setprop_cells(ms->fdt, "/timer", "interrupts",
+    if (vms->ns_el2_virt_timer_present) {
+        qemu_fdt_setprop_cells(ms->fdt, "/timer", "interrupts",
+                       GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_S_EL1_IRQ, irqflags,
+                       GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_NS_EL1_IRQ, irqflags,
+                       GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_VIRT_IRQ, irqflags,
+                       GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_NS_EL2_IRQ, irqflags,
+                       GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_NS_EL2_VIRT_IRQ, irqflags);
+    } else {
+        qemu_fdt_setprop_cells(ms->fdt, "/timer", "interrupts",
                        GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_S_EL1_IRQ, irqflags,
                        GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_NS_EL1_IRQ, irqflags,
                        GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_VIRT_IRQ, irqflags,
                        GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_NS_EL2_IRQ, irqflags);
+    }
 }
 
 static void fdt_add_cpu_nodes(const VirtMachineState *vms)
@@ -810,6 +832,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
             [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
             [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
             [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
+            [GTIMER_HYPVIRT] = ARCH_TIMER_NS_EL2_VIRT_IRQ,
         };
 
         for (irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
@@ -2249,6 +2272,10 @@ static void machvirt_init(MachineState *machine)
         qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
         object_unref(cpuobj);
     }
+
+    /* Now we've created the CPUs we can see if they have the hypvirt timer */
+    vms->ns_el2_virt_timer_present = ns_el2_virt_timer_present();
+
     fdt_add_timer_nodes(vms);
     fdt_add_cpu_nodes(vms);
 
-- 
2.34.1


