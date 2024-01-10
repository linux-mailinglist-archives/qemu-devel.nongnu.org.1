Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF42482A1A2
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 20:56:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNeer-0007qz-Bo; Wed, 10 Jan 2024 14:54:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNeen-0007Zs-DH
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 14:54:33 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNeel-0002Mw-9Z
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 14:54:32 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3374e332124so3641910f8f.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 11:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704916469; x=1705521269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OowX4efGlp2L11zIDE/JPwBjb6bv53ZLeGSFw+1liNI=;
 b=oLscmG8xYLmDR3xZC9UGHIBAd/A/5v4x6KhvbReF5J3Z0z7WBbSolwRjFVA5m1tX7t
 t0j40DM93z6hrYCt35bb3yVyMcR6TxFozvfBekw4/G5aznJ935IJVuyjDrz65k7SNvs3
 Qbjfjv9iXiHcD1zsq1GyvAI5vsyjOXU4LFL02TeMun/V4zNvpHizMgZZuN01Oe2alRML
 3yIDMoZfjTWJ8C0BsWYohSxHYkm9+o621TwzMfYN/wRIscZQEjlhTp3beQ0ne78intD6
 z5HWjY3+zKgQCOWJyCmE7YFJPPv74tpgkkGrwOeu5oMbYNJRMxkBO+4VnZS2+kkg5FMC
 zDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704916469; x=1705521269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OowX4efGlp2L11zIDE/JPwBjb6bv53ZLeGSFw+1liNI=;
 b=AUznf9+yCDGrwKpzr/sDxzEGOu7mDn32W0M8Lo+s0UEb1wossa91SdzQeRVejDpoyQ
 4WmK0LLLSbpDiMWrk5wz6nn1AZZDSkKGyCHx1cY6WCAaZSU4m3cBFfLysLtO64PwbigV
 CkYvWenbdaMkJYP+ZxYqxE3CS5wV7UC/6AnKYnhF0X/yPJlv48KhEktmBNkKDrjQXycY
 +MBlugGHCnTQ2bqXAOur2ZxIKcny+EBSTxlCidoQyzyICGkpQa12vgdvg4qQ39VQuTb0
 A/J2YqWhoP6p/4SDOm6WjzPFtUcq6mjD8FYTXMFu/KagvdmwJ78qx1RGyy7huUxucDZJ
 ftmw==
X-Gm-Message-State: AOJu0YwDc20B40Scj5ULBa862AsxCu/Fn9D7XexrsPER3ox9eD/+IfGR
 hfolikLn9x2LnKnsikCd53FGBzN9o8hLBTfnQNKsugdeI1Q=
X-Google-Smtp-Source: AGHT+IFWby61uJ0ne9sJLI7LEPySlIqlyEyfxcveQWgGiW6+NlQFSatSdvJvgCxT7CD5nZwLtOoy4Q==
X-Received: by 2002:a5d:5150:0:b0:337:6f4a:1238 with SMTP id
 u16-20020a5d5150000000b003376f4a1238mr3581wrt.103.1704916469496; 
 Wed, 10 Jan 2024 11:54:29 -0800 (PST)
Received: from m1x-phil.lan (vau06-h02-176-184-43-236.dsl.sta.abo.bbox.fr.
 [176.184.43.236]) by smtp.gmail.com with ESMTPSA id
 c6-20020adfed86000000b00336751cd4ebsm5631000wro.72.2024.01.10.11.54.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Jan 2024 11:54:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Rob Herring <robh@kernel.org>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 08/14] hw/arm: Prefer arm_feature(EL3) over
 object_property_find(has_el3)
Date: Wed, 10 Jan 2024 20:53:22 +0100
Message-ID: <20240110195329.3995-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240110195329.3995-1-philmd@linaro.org>
References: <20240110195329.3995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

The "has_el3" property is added to ARMCPU when the
ARM_FEATURE_EL3 feature is available. Rather than
checking whether the QOM property is present, directly
check the feature.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/exynos4210.c   |  4 ++--
 hw/arm/integratorcp.c |  5 ++---
 hw/arm/realview.c     |  2 +-
 hw/arm/versatilepb.c  |  5 ++---
 hw/arm/xilinx_zynq.c  |  2 +-
 hw/cpu/a15mpcore.c    | 14 +++++++++-----
 hw/cpu/a9mpcore.c     |  9 +++++----
 7 files changed, 22 insertions(+), 19 deletions(-)

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
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 1830e1d785..7685527eb2 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -596,19 +596,18 @@ static void integratorcp_init(MachineState *machine)
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
 
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 4b2257787b..1969bb4608 100644
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
index bfd8aa5644..afe3897901 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -53,7 +53,6 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
     DeviceState *gicdev;
     SysBusDevice *busdev;
     int i;
-    bool has_el3;
     bool has_el2 = false;
     Object *cpuobj;
 
@@ -62,13 +61,18 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
     qdev_prop_set_uint32(gicdev, "num-irq", s->num_irq);
 
     if (!kvm_irqchip_in_kernel()) {
+        CPUState *cpu;
+
         /* Make the GIC's TZ support match the CPUs. We assume that
          * either all the CPUs have TZ, or none do.
          */
-        cpuobj = OBJECT(qemu_get_cpu(0));
-        has_el3 = object_property_find(cpuobj, "has_el3") &&
-            object_property_get_bool(cpuobj, "has_el3", &error_abort);
-        qdev_prop_set_bit(gicdev, "has-security-extensions", has_el3);
+        cpu = qemu_get_cpu(0);
+        cpuobj = OBJECT(cpu);
+        if (arm_feature(cpu_env(cpu), ARM_FEATURE_EL3)) {
+            qdev_prop_set_bit(gicdev, "has-security-extensions",
+                              object_property_get_bool(cpuobj, "has_el3",
+                                                       &error_abort));
+        }
         /* Similarly for virtualization support */
         has_el2 = object_property_find(cpuobj, "has_el2") &&
             object_property_get_bool(cpuobj, "has_el2", &error_abort);
diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index d03f57e579..3e1fef149f 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -52,7 +52,6 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
     SysBusDevice *scubusdev, *gicbusdev, *gtimerbusdev, *mptimerbusdev,
                  *wdtbusdev;
     int i;
-    bool has_el3;
     CPUState *cpu0;
     Object *cpuobj;
 
@@ -81,9 +80,11 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
     /* Make the GIC's TZ support match the CPUs. We assume that
      * either all the CPUs have TZ, or none do.
      */
-    has_el3 = object_property_find(cpuobj, "has_el3") &&
-        object_property_get_bool(cpuobj, "has_el3", &error_abort);
-    qdev_prop_set_bit(gicdev, "has-security-extensions", has_el3);
+    if (arm_feature(cpu_env(cpu0), ARM_FEATURE_EL3)) {
+        qdev_prop_set_bit(gicdev, "has-security-extensions",
+                          object_property_get_bool(cpuobj, "has_el3",
+                                                   &error_abort));
+    }
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), errp)) {
         return;
-- 
2.41.0


