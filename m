Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43264813823
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 18:16:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDpIa-0006h8-Os; Thu, 14 Dec 2023 12:15:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDpIX-0006gJ-DL
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 12:14:57 -0500
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDpIT-0007Me-T1
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 12:14:57 -0500
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-67f02843e91so8969366d6.0
 for <qemu-devel@nongnu.org>; Thu, 14 Dec 2023 09:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702574092; x=1703178892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ybFjpmrQhoMzGt+cU1/IIP+BUJDHHqNKMtENaaJvu/s=;
 b=bx+6yabwHPDt0FjBzqMtc2klflMG8Ykjs9vbpzloclCZBE72dBzJ+sQ4qBpNJ3q9PR
 98mvQ4vxxFtq2iQvPnSbjQpnzEhP5fsUnRK56/o1XAuEsgmVTVayy7F9yslq3MbOmH+W
 CkTyLVX802xQCmVyLXhjxfHTYsW9DW7Ohtg6asYCc5/+wyTjF1htwtWnSTduY+/7uCwY
 OEqIJlrpYqo7Osiqv4W/Hx11LpMMo5eayu0KNTCiBU+lPTJ39VYW+VsTGgtR8siw3ZFe
 ZzrNoFBX6KDUPPzXJGymShFf+oox9BqTQJr5H7t28Zsf9QvGPKrG3CWaNgnbBxdL3fNJ
 eGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702574092; x=1703178892;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ybFjpmrQhoMzGt+cU1/IIP+BUJDHHqNKMtENaaJvu/s=;
 b=pKRyvVD5/70nTPu+qkk6TRj2vVC8F+QNNWdYIUrSH2pKM31p232xFa7W70U9K9jl4r
 vkvpC6Qv88zOUBrLvmlzwLkDRqKN6RnNp1l3fF8g9E4AAWof6BGGlYZbLftfpkOKn+cG
 OC0Cn94pu9pEARMaL6cWe6wd+zC3A4RtVDZ9pPUzPEysHadYI7aYcrasRPeDre8TADFE
 ZL+7EsOLDJlDorhG6entQukFU1svZvJGyPB5uXKstlEqYpLhKcJaKkvwAbtgKagp8d0a
 DwNe/svPK8rBGIDjchECDKwATlARq5aFbmntx7e0zC4AiZHlF9H39Df/+dJbEQb/6NBQ
 vW0Q==
X-Gm-Message-State: AOJu0YzDBSP55k2LwA6XFIMeFBpMLg8HahxXT8jazwSi2sYc7oEBKm4d
 LCjvlYEzkEEe/mpQyEHq08rhd2N/7h1Q24mG4aqq/w==
X-Google-Smtp-Source: AGHT+IG2n/mkkrzU6O/7FEa2IagQJ2ZThg/CzYjwQY5mkZy28sYU219Jw2K1kBO+hgF/bpS+R3vJ6w==
X-Received: by 2002:ad4:5cc1:0:b0:67a:a721:caf6 with SMTP id
 iu1-20020ad45cc1000000b0067aa721caf6mr13054985qvb.87.1702574092148; 
 Thu, 14 Dec 2023 09:14:52 -0800 (PST)
Received: from M1X.pond.sub.org (p50902f8f.dip0.t-ipconnect.de.
 [80.144.47.143]) by smtp.gmail.com with ESMTPSA id
 de4-20020ad45844000000b0067a97f6b0c6sm6122862qvb.32.2023.12.14.09.14.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Dec 2023 09:14:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org,
 Leif Lindholm <quic_llindhol@quicinc.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH] hw/arm: Prefer arm_feature() over object_property_find()
Date: Thu, 14 Dec 2023 18:14:47 +0100
Message-ID: <20231214171447.44025-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f35;
 envelope-from=philmd@linaro.org; helo=mail-qv1-xf35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

QOM properties are added on the ARM vCPU object when a
feature is present. Rather than checking the property
is present, check the feature.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
RFC: If there is no objection on this patch, I can split
     as a per-feature series if necessary.

Based-on: <20231123143813.42632-1-philmd@linaro.org>
  "hw: Simplify accesses to CPUState::'start-powered-off' property"
---
 hw/arm/armv7m.c       | 21 ++++++++++++---------
 hw/arm/exynos4210.c   |  4 ++--
 hw/arm/highbank.c     |  3 ++-
 hw/arm/integratorcp.c |  5 ++---
 hw/arm/realview.c     |  2 +-
 hw/arm/sbsa-ref.c     |  3 ++-
 hw/arm/versatilepb.c  |  5 ++---
 hw/arm/vexpress.c     |  6 ++++--
 hw/arm/virt.c         | 27 +++++++++++++++------------
 hw/arm/xilinx_zynq.c  |  2 +-
 hw/cpu/a15mpcore.c    | 17 +++++++++++------
 hw/cpu/a9mpcore.c     |  6 +++---
 12 files changed, 57 insertions(+), 44 deletions(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 3a6d72b0f3..932061c11a 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -302,28 +302,29 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
 
     object_property_set_link(OBJECT(s->cpu), "memory", OBJECT(&s->container),
                              &error_abort);
-    if (object_property_find(OBJECT(s->cpu), "idau")) {
+    if (arm_feature(&s->cpu->env, ARM_FEATURE_M_SECURITY)) {
         object_property_set_link(OBJECT(s->cpu), "idau", s->idau,
                                  &error_abort);
-    }
-    if (object_property_find(OBJECT(s->cpu), "init-svtor")) {
         if (!object_property_set_uint(OBJECT(s->cpu), "init-svtor",
                                       s->init_svtor, errp)) {
             return;
         }
     }
-    if (object_property_find(OBJECT(s->cpu), "init-nsvtor")) {
+    if (arm_feature(&s->cpu->env, ARM_FEATURE_M)) {
         if (!object_property_set_uint(OBJECT(s->cpu), "init-nsvtor",
                                       s->init_nsvtor, errp)) {
             return;
         }
     }
-    if (object_property_find(OBJECT(s->cpu), "vfp")) {
-        if (!object_property_set_bool(OBJECT(s->cpu), "vfp", s->vfp, errp)) {
-            return;
+    if (arm_feature(&s->cpu->env, ARM_FEATURE_AARCH64)) {
+        if (cpu_isar_feature(aa64_fp_simd, s->cpu)) {
+            if (!object_property_set_bool(OBJECT(s->cpu), "vfp", s->vfp, errp)) {
+                return;
+            }
         }
     }
-    if (object_property_find(OBJECT(s->cpu), "dsp")) {
+    if (arm_feature(&s->cpu->env, ARM_FEATURE_M) &&
+        arm_feature(&s->cpu->env, ARM_FEATURE_THUMB_DSP)) {
         if (!object_property_set_bool(OBJECT(s->cpu), "dsp", s->dsp, errp)) {
             return;
         }
@@ -342,12 +343,14 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
         return;
     }
     if (s->mpu_ns_regions != UINT_MAX &&
-        object_property_find(OBJECT(s->cpu), "pmsav7-dregion")) {
+        arm_feature(&s->cpu->env, ARM_FEATURE_PMSA)) {
+        if (arm_feature(&s->cpu->env, ARM_FEATURE_V7)) {
         if (!object_property_set_uint(OBJECT(s->cpu), "pmsav7-dregion",
                                       s->mpu_ns_regions, errp)) {
             return;
         }
     }
+    }
 
     /*
      * Tell the CPU where the NVIC is; it will fail realize if it doesn't
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index de39fb0ece..5efaa538cd 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -554,14 +554,14 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
     for (n = 0; n < EXYNOS4210_NCPUS; n++) {
         Object *cpuobj = object_new(ARM_CPU_TYPE_NAME("cortex-a9"));
 
+        s->cpu[n] = ARM_CPU(cpuobj);
         /* By default A9 CPUs have EL3 enabled.  This board does not currently
          * support EL3 so the CPU EL3 property is disabled before realization.
          */
-        if (object_property_find(cpuobj, "has_el3")) {
+        if (arm_feature(&s->cpu[n]->env, ARM_FEATURE_EL3)) {
             object_property_set_bool(cpuobj, "has_el3", false, &error_fatal);
         }
 
-        s->cpu[n] = ARM_CPU(cpuobj);
         object_property_set_int(cpuobj, "mp-affinity",
                                 exynos4210_calc_affinity(n), &error_abort);
         object_property_set_int(cpuobj, "reset-cbar",
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index f12aacea6b..0b5def8015 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -211,7 +211,8 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
         object_property_set_int(cpuobj, "psci-conduit", QEMU_PSCI_CONDUIT_SMC,
                                 &error_abort);
 
-        if (object_property_find(cpuobj, "reset-cbar")) {
+        if (arm_feature(&cpu->env, ARM_FEATURE_CBAR) ||
+            arm_feature(&cpu->env, ARM_FEATURE_CBAR_RO)) {
             object_property_set_int(cpuobj, "reset-cbar", MPCORE_PERIPHBASE,
                                     &error_abort);
         }
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index d176e9af7e..5ec840ce89 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -599,19 +599,18 @@ static void integratorcp_init(MachineState *machine)
     int i;
 
     cpuobj = object_new(machine->cpu_type);
+    cpu = ARM_CPU(cpuobj);
 
     /* By default ARM1176 CPUs have EL3 enabled.  This board does not
      * currently support EL3 so the CPU EL3 property is disabled before
      * realization.
      */
-    if (object_property_find(cpuobj, "has_el3")) {
+    if (arm_feature(&cpu->env, ARM_FEATURE_EL3)) {
         object_property_set_bool(cpuobj, "has_el3", false, &error_fatal);
     }
 
     qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
 
-    cpu = ARM_CPU(cpuobj);
-
     /* ??? On a real system the first 1Mb is mapped as SSRAM or boot flash.  */
     /* ??? RAM should repeat to fill physical memory space.  */
     /* SDRAM at address zero*/
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 132217b2ed..433fe72ced 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -123,7 +123,7 @@ static void realview_init(MachineState *machine,
          * does not currently support EL3 so the CPU EL3 property is disabled
          * before realization.
          */
-        if (object_property_find(cpuobj, "has_el3")) {
+        if (arm_feature(&cpu->env, ARM_FEATURE_EL3)) {
             object_property_set_bool(cpuobj, "has_el3", false, &error_fatal);
         }
 
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index f3c9704693..ecb05f6007 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -796,7 +796,8 @@ static void sbsa_ref_init(MachineState *machine)
         numa_cpu_pre_plug(&possible_cpus->cpus[cs->cpu_index], DEVICE(cpuobj),
                           &error_fatal);
 
-        if (object_property_find(cpuobj, "reset-cbar")) {
+        if (arm_feature(cpu_env(cs), ARM_FEATURE_CBAR) ||
+            arm_feature(cpu_env(cs), ARM_FEATURE_CBAR_RO)) {
             object_property_set_int(cpuobj, "reset-cbar",
                                     sbsa_ref_memmap[SBSA_CPUPERIPHS].base,
                                     &error_abort);
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 2f22dc890f..addd7a6988 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -208,19 +208,18 @@ static void versatile_init(MachineState *machine, int board_id)
     }
 
     cpuobj = object_new(machine->cpu_type);
+    cpu = ARM_CPU(cpuobj);
 
     /* By default ARM1176 CPUs have EL3 enabled.  This board does not
      * currently support EL3 so the CPU EL3 property is disabled before
      * realization.
      */
-    if (object_property_find(cpuobj, "has_el3")) {
+    if (arm_feature(&cpu->env, ARM_FEATURE_EL3)) {
         object_property_set_bool(cpuobj, "has_el3", false, &error_fatal);
     }
 
     qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
 
-    cpu = ARM_CPU(cpuobj);
-
     /* ??? RAM should repeat to fill physical memory space.  */
     /* SDRAM at address zero.  */
     memory_region_add_subregion(sysmem, 0, machine->ram);
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index fd981f4c33..ea3c76f3e1 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -218,17 +218,19 @@ static void init_cpus(MachineState *ms, const char *cpu_type,
     /* Create the actual CPUs */
     for (n = 0; n < smp_cpus; n++) {
         Object *cpuobj = object_new(cpu_type);
+        ARMCPU *cpu = ARM_CPU(cpuobj);
 
         if (!secure) {
             object_property_set_bool(cpuobj, "has_el3", false, NULL);
         }
         if (!virt) {
-            if (object_property_find(cpuobj, "has_el2")) {
+            if (arm_feature(&cpu->env, ARM_FEATURE_EL2)) {
                 object_property_set_bool(cpuobj, "has_el2", false, NULL);
             }
         }
 
-        if (object_property_find(cpuobj, "reset-cbar")) {
+        if (arm_feature(&cpu->env, ARM_FEATURE_CBAR) ||
+            arm_feature(&cpu->env, ARM_FEATURE_CBAR_RO)) {
             object_property_set_int(cpuobj, "reset-cbar", periphbase,
                                     &error_abort);
         }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index be2856c018..e5d883c4c3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2182,21 +2182,22 @@ static void machvirt_init(MachineState *machine)
             object_property_set_bool(cpuobj, "has_el3", false, NULL);
         }
 
-        if (!vms->virt && object_property_find(cpuobj, "has_el2")) {
+        if (!vms->virt &&  arm_feature(cpu_env(cs), ARM_FEATURE_EL2)) {
             object_property_set_bool(cpuobj, "has_el2", false, NULL);
         }
 
-        if (vmc->kvm_no_adjvtime &&
-            object_property_find(cpuobj, "kvm-no-adjvtime")) {
-            object_property_set_bool(cpuobj, "kvm-no-adjvtime", true, NULL);
+        if (kvm_enabled()) {
+            if (arm_feature(cpu_env(cs), ARM_FEATURE_GENERIC_TIMER)) {
+                object_property_set_bool(cpuobj, "kvm-no-adjvtime",
+                                         vmc->kvm_no_adjvtime, NULL);
+            }
+
+            if (vmc->no_kvm_steal_time) {
+                object_property_set_bool(cpuobj, "kvm-steal-time", false, NULL);
+            }
         }
 
-        if (vmc->no_kvm_steal_time &&
-            object_property_find(cpuobj, "kvm-steal-time")) {
-            object_property_set_bool(cpuobj, "kvm-steal-time", false, NULL);
-        }
-
-        if (vmc->no_pmu && object_property_find(cpuobj, "pmu")) {
+        if (arm_feature(cpu_env(cs), ARM_FEATURE_PMU) && vmc->no_pmu) {
             object_property_set_bool(cpuobj, "pmu", false, NULL);
         }
 
@@ -2204,7 +2205,8 @@ static void machvirt_init(MachineState *machine)
             object_property_set_bool(cpuobj, "lpa2", false, NULL);
         }
 
-        if (object_property_find(cpuobj, "reset-cbar")) {
+        if (arm_feature(cpu_env(cs), ARM_FEATURE_CBAR) ||
+            arm_feature(cpu_env(cs), ARM_FEATURE_CBAR_RO)) {
             object_property_set_int(cpuobj, "reset-cbar",
                                     vms->memmap[VIRT_CPUPERIPHS].base,
                                     &error_abort);
@@ -2224,7 +2226,8 @@ static void machvirt_init(MachineState *machine)
                  * The property exists only if MemTag is supported.
                  * If it is, we must allocate the ram to back that up.
                  */
-                if (!object_property_find(cpuobj, "tag-memory")) {
+                if (!(arm_feature(cpu_env(cs), ARM_FEATURE_AARCH64)
+                      && cpu_isar_feature(aa64_mte, ARM_CPU(cs)))) {
                     error_report("MTE requested, but not supported "
                                  "by the guest CPU");
                     exit(1);
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index dbb9793aa1..33e57dceef 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -198,7 +198,7 @@ static void zynq_init(MachineState *machine)
      * currently support EL3 so the CPU EL3 property is disabled before
      * realization.
      */
-    if (object_property_find(OBJECT(cpu), "has_el3")) {
+    if (arm_feature(&cpu->env, ARM_FEATURE_EL3)) {
         object_property_set_bool(OBJECT(cpu), "has_el3", false, &error_fatal);
     }
 
diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index bfd8aa5644..1fa079b3b8 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -53,7 +53,6 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
     DeviceState *gicdev;
     SysBusDevice *busdev;
     int i;
-    bool has_el3;
     bool has_el2 = false;
     Object *cpuobj;
 
@@ -62,17 +61,23 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
     qdev_prop_set_uint32(gicdev, "num-irq", s->num_irq);
 
     if (!kvm_irqchip_in_kernel()) {
+        CPUState *cpu;
+
         /* Make the GIC's TZ support match the CPUs. We assume that
          * either all the CPUs have TZ, or none do.
          */
-        cpuobj = OBJECT(qemu_get_cpu(0));
-        has_el3 = object_property_find(cpuobj, "has_el3") &&
+        cpu = qemu_get_cpu(0);
+        cpuobj = OBJECT(cpu);
+        if (arm_feature(cpu_env(cpu), ARM_FEATURE_EL3)) {
             object_property_get_bool(cpuobj, "has_el3", &error_abort);
-        qdev_prop_set_bit(gicdev, "has-security-extensions", has_el3);
+            qdev_prop_set_bit(gicdev, "has-security-extensions", true);
+        }
         /* Similarly for virtualization support */
-        has_el2 = object_property_find(cpuobj, "has_el2") &&
+        has_el2 = arm_feature(cpu_env(cpu), ARM_FEATURE_EL2);
+        if (has_el2) {
             object_property_get_bool(cpuobj, "has_el2", &error_abort);
-        qdev_prop_set_bit(gicdev, "has-virtualization-extensions", has_el2);
+            qdev_prop_set_bit(gicdev, "has-virtualization-extensions", true);
+        }
     }
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), errp)) {
diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index d03f57e579..9355e8443b 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -52,7 +52,6 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
     SysBusDevice *scubusdev, *gicbusdev, *gtimerbusdev, *mptimerbusdev,
                  *wdtbusdev;
     int i;
-    bool has_el3;
     CPUState *cpu0;
     Object *cpuobj;
 
@@ -81,9 +80,10 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
     /* Make the GIC's TZ support match the CPUs. We assume that
      * either all the CPUs have TZ, or none do.
      */
-    has_el3 = object_property_find(cpuobj, "has_el3") &&
+    if (arm_feature(cpu_env(cpu0), ARM_FEATURE_EL3)) {
         object_property_get_bool(cpuobj, "has_el3", &error_abort);
-    qdev_prop_set_bit(gicdev, "has-security-extensions", has_el3);
+        qdev_prop_set_bit(gicdev, "has-security-extensions", true);
+    }
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), errp)) {
         return;
-- 
2.41.0


