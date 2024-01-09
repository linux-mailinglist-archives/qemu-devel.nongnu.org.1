Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF7D828C39
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 19:13:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNGZI-0004An-D4; Tue, 09 Jan 2024 13:11:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGYe-0002rf-LY
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:10:39 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGYb-0004Ni-Fh
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:10:36 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3374c693f92so2657087f8f.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 10:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704823832; x=1705428632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fs9yHmgYAN3jLkfd5xrkR/STV7YHc6sb5NlHxAOGVok=;
 b=TfNtrFZw4XKqWC/IhghOc4hTMuXy8S8G67tzbRDIHPqh6fVcTh5wjO+548tvi38jJy
 +aybB5jKNIG2wmhYS0QmgCSORaJYh6dcMKEjLl6QL71s1pIVy7s5UM5kkTSbErMXu1HE
 u2MsK93u8Xb2ohhJEgbiqnkmFvI8Rd/RI0S1+raR+uLP/hNdRic65nlEIwZTajXdfMBI
 f1jAlmHXR1vTNMglu6emE0luAScPmJ0XD9x17khsBLXx2Yz04mDKKRcDRnVoHrRcXey0
 qxJryintPIoCJTKHUocv7uaw/lg1G6097dqMR/6yzMkKvRPkExG4YXILnXNAc0fAZCqx
 N48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704823832; x=1705428632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fs9yHmgYAN3jLkfd5xrkR/STV7YHc6sb5NlHxAOGVok=;
 b=woPiLWXNsY6Et5+unJMjs5CLOQS5jRUv6JocE+dePvCiAMnrTRTMUJVD/jAs0SV8/d
 LbpoU8ESV4kBkslAcdyfMbA5L7PbzLkjlMh+W2GBzlKZoG2VJjua9Ry6sazs0i5YM53a
 wOPrIv+une5noeEJ01ydKmMw/zbyeIvfMH/204dR81rX0nh/FGneMZZ8LZu0UrLbWgOf
 RxcCBDKMlBEbZJlrZVwz8e4Gwq4RzVZG5P2kInToPfS5pFOz9QOLUxnUz7+RoCclObe/
 de31W79XafMSApJeUeWKzACMTC1eLYquwsjsDTLRUwcxrftEl89U0SL6JZ33cm0xxdxv
 hXew==
X-Gm-Message-State: AOJu0Yx2EhIUMIHxr8ottKUtehlEXW/VXvM7KLpAKwZC19U8+spnMGZ4
 Qu07DQLF18hKi1abDGZi/4lu70OARaN1KqugKW5DNw6nkwmZ7w==
X-Google-Smtp-Source: AGHT+IEPyIfAednS4+GDfQ49cgUJLQ1i/fUsFEriU2Oan+/NHOtQSVv2opbT0ciHGYHdvA3c3VO/wg==
X-Received: by 2002:a5d:4984:0:b0:336:787c:6236 with SMTP id
 r4-20020a5d4984000000b00336787c6236mr856976wrq.65.1704823831637; 
 Tue, 09 Jan 2024 10:10:31 -0800 (PST)
Received: from m1x-phil.lan (rsa59-h02-176-184-32-47.dsl.sta.abo.bbox.fr.
 [176.184.32.47]) by smtp.gmail.com with ESMTPSA id
 f16-20020adffcd0000000b003373ef060d5sm2990432wrs.113.2024.01.09.10.10.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Jan 2024 10:10:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 09/14] hw/arm: Prefer arm_feature(EL3) over
 object_property_find(has_el3)
Date: Tue,  9 Jan 2024 19:09:24 +0100
Message-ID: <20240109180930.90793-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240109180930.90793-1-philmd@linaro.org>
References: <20240109180930.90793-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
 hw/cpu/a15mpcore.c    | 11 +++++++----
 hw/cpu/a9mpcore.c     |  6 +++---
 7 files changed, 18 insertions(+), 17 deletions(-)

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
index bfd8aa5644..cebfe142cf 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -53,7 +53,6 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
     DeviceState *gicdev;
     SysBusDevice *busdev;
     int i;
-    bool has_el3;
     bool has_el2 = false;
     Object *cpuobj;
 
@@ -62,13 +61,17 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
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
         has_el2 = object_property_find(cpuobj, "has_el2") &&
             object_property_get_bool(cpuobj, "has_el2", &error_abort);
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


