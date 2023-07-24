Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ED975FE1F
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 19:45:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNzb8-0007EF-AT; Mon, 24 Jul 2023 13:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNzb0-0007AV-QI
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 13:43:49 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNzaw-0004Hk-NQ
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 13:43:46 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2b9352ff1aeso67464231fa.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 10:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690220619; x=1690825419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a2KWVSQCGmikjbNSEBz2hoiYwpNVnu1J1WGWnTVXVm4=;
 b=kBZUTiWxCmq20F5AW6pUUGPD1UQ2MxgRAHC5TBqkwekzVtFkC4XWFM1JLJDdtmuMA5
 tA3nukCWlmUhD/BbaLw/ITVwcVq6z9g54k4hdhfciQzithmoKCujE7/M5W68FmHuZczO
 XBEAddijoluZjG02Vnt4FUG1RDRKxF8yI3X7M1cP5KjgLbMR2eONCxtngtkhmKZIx5ru
 0kKLnwlvrfzG2AFaZdgChJ6wYhYnFDjo/vTr9zZjKyrZE3WuN7vJ942S/Ic5C4bHKVZH
 xc3sJOMYrYcFKigp7e9gCwW8vP7MvY7xCYDUYnw1H4c27eLz03cuHEOCp6EOneoPE/j4
 RsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690220619; x=1690825419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a2KWVSQCGmikjbNSEBz2hoiYwpNVnu1J1WGWnTVXVm4=;
 b=gC9GzQ3ZOt8RaNVFb0rHJSqg9GAasxAOrl9Xv9rjvUp/ho36wW0sPFlesaGYxWunKz
 IySn7AzSaaPf65RCLM29FDpZQQpHUgcJ8G2moBM4SsQ0JjcZ3G8i1y3OBp9Hoa9KO3T1
 +T3bIYwPW0kPKg5WPq4mPjkSMTdsVdLaPLyyTehhv/sLDvjKO09j6k6gWR3zxgc1mwHe
 s/fYSDVp/cTQUkuYu9OmoEupGC4kVVPiegu61+MaO5pVTzSIT+98tZMr9u+oB0caDyit
 8sjFAGXaJzIuyqIi0PXFqH2YtXoTc1PHJ3fMnbl32fN7fYBxa3pz67IUmpxw2I+/ICTB
 s0Tw==
X-Gm-Message-State: ABy/qLZ1jsWLg1UUCGbiWjOwD5K+3+tMYaTZz+SlKWo+8LXNIMqWUchB
 7mKG93AKGZjbshlfDEv6IKIHzw==
X-Google-Smtp-Source: APBJJlGhetFN7aaWd7g0D6+4zdD2bdMHQa9r6BZq9NmIPCrqAss3JB6UvrgGDIhxNco7r+ebiPSQHQ==
X-Received: by 2002:a2e:3c11:0:b0:2b1:ed29:7c47 with SMTP id
 j17-20020a2e3c11000000b002b1ed297c47mr6030465lja.8.1690220619303; 
 Mon, 24 Jul 2023 10:43:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a0560001b0300b0030e52d4c1bcsm13687423wrz.71.2023.07.24.10.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 10:43:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-8.2 3/3] hw/arm: Set number of MPU regions correctly for
 an505, an521, an524
Date: Mon, 24 Jul 2023 18:43:35 +0100
Message-Id: <20230724174335.2150499-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724174335.2150499-1-peter.maydell@linaro.org>
References: <20230724174335.2150499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x232.google.com
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

The IoTKit, SSE200 and SSE300 all default to 8 MPU regions.  The
MPS2/MPS3 FPGA images don't override these except in the case of
AN547, which uses 16 MPU regions.

Define properties on the ARMSSE object for the MPU regions (using the
same names as the documented RTL configuration settings, and
following the pattern we already have for this device of using
all-caps names as the RTL does), and set them in the board code.

We don't actually need to override the default except on AN547,
but it's simpler code to have the board code set them always
rather than tracking which board subtypes want to set them to
a non-default value separately from what that value is.

Tho overall effect is that for mps2-an505, mps2-an521 and mps3-an524
we now correctly use 8 MPU regions, while mps3-an547 stays at its
current 16 regions.

It's possible some guest code wrongly depended on the previous
incorrectly modeled number of memory regions. (Such guest code
should ideally check the number of regions via the MPU_TYPE
register.) The old behaviour can be obtained with additional
-global arguments to QEMU:

For mps2-an521 and mps2-an524:
 -global sse-200.CPU0_MPU_NS=16 -global sse-200.CPU0_MPU_S=16 -global sse-200.CPU1_MPU_NS=16 -global sse-200.CPU1_MPU_S=16

For mps2-an505:
 -global sse-200.CPU0_MPU_NS=16 -global sse-200.CPU0_MPU_S=16

NB that the way the implementation allows this use of -global
is slightly fragile: if the board code explicitly sets the
properties on the sse-200 object, this overrides the -global
command line option. So we rely on:
 - the boards that need fixing all happen to use the SSE defaults
 - we can write the board code to only set the property if it
   is different from the default, rather than having all boards
   explicitly set the property
 - the board that does need to use a non-default value happens
   to need to set it to the same value (16) we previously used
This works, but there are some kinds of refactoring of the
mps2-tz.c code that would break the support for -global here.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1772
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I'm not super-enthusiastic about the -global handling here, as you
may have guessed from the wording above, though it does avoid having
explicit back-compat code.  The other option for back-compat would be
to add an explicit board property to say "use the old values".
---
 include/hw/arm/armsse.h |  5 +++++
 hw/arm/armsse.c         | 16 ++++++++++++++++
 hw/arm/mps2-tz.c        | 29 +++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/include/hw/arm/armsse.h b/include/hw/arm/armsse.h
index cd0931d0a0b..88b3b759c5a 100644
--- a/include/hw/arm/armsse.h
+++ b/include/hw/arm/armsse.h
@@ -56,6 +56,9 @@
  *    (matching the hardware) is that for CPU0 in an IoTKit and CPU1 in an
  *    SSE-200 both are present; CPU0 in an SSE-200 has neither.
  *    Since the IoTKit has only one CPU, it does not have the CPU1_* properties.
+ *  + QOM properties "CPU0_MPU_NS", "CPU0_MPU_S", "CPU1_MPU_NS" and "CPU1_MPU_S"
+ *    which set the number of MPU regions on the CPUs. If there is only one
+ *    CPU the CPU1 properties are not present.
  *  + Named GPIO inputs "EXP_IRQ" 0..n are the expansion interrupts for CPU 0,
  *    which are wired to its NVIC lines 32 .. n+32
  *  + Named GPIO inputs "EXP_CPU1_IRQ" 0..n are the expansion interrupts for
@@ -221,6 +224,8 @@ struct ARMSSE {
     uint32_t exp_numirq;
     uint32_t sram_addr_width;
     uint32_t init_svtor;
+    uint32_t cpu_mpu_ns[SSE_MAX_CPUS];
+    uint32_t cpu_mpu_s[SSE_MAX_CPUS];
     bool cpu_fpu[SSE_MAX_CPUS];
     bool cpu_dsp[SSE_MAX_CPUS];
 };
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 0202bad787b..11cd08b6c1e 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -85,6 +85,8 @@ static Property iotkit_properties[] = {
     DEFINE_PROP_UINT32("init-svtor", ARMSSE, init_svtor, 0x10000000),
     DEFINE_PROP_BOOL("CPU0_FPU", ARMSSE, cpu_fpu[0], true),
     DEFINE_PROP_BOOL("CPU0_DSP", ARMSSE, cpu_dsp[0], true),
+    DEFINE_PROP_UINT32("CPU0_MPU_NS", ARMSSE, cpu_mpu_ns[0], 8),
+    DEFINE_PROP_UINT32("CPU0_MPU_S", ARMSSE, cpu_mpu_s[0], 8),
     DEFINE_PROP_END_OF_LIST()
 };
 
@@ -98,6 +100,10 @@ static Property sse200_properties[] = {
     DEFINE_PROP_BOOL("CPU0_DSP", ARMSSE, cpu_dsp[0], false),
     DEFINE_PROP_BOOL("CPU1_FPU", ARMSSE, cpu_fpu[1], true),
     DEFINE_PROP_BOOL("CPU1_DSP", ARMSSE, cpu_dsp[1], true),
+    DEFINE_PROP_UINT32("CPU0_MPU_NS", ARMSSE, cpu_mpu_ns[0], 8),
+    DEFINE_PROP_UINT32("CPU0_MPU_S", ARMSSE, cpu_mpu_s[0], 8),
+    DEFINE_PROP_UINT32("CPU1_MPU_NS", ARMSSE, cpu_mpu_ns[1], 8),
+    DEFINE_PROP_UINT32("CPU1_MPU_S", ARMSSE, cpu_mpu_s[1], 8),
     DEFINE_PROP_END_OF_LIST()
 };
 
@@ -109,6 +115,8 @@ static Property sse300_properties[] = {
     DEFINE_PROP_UINT32("init-svtor", ARMSSE, init_svtor, 0x10000000),
     DEFINE_PROP_BOOL("CPU0_FPU", ARMSSE, cpu_fpu[0], true),
     DEFINE_PROP_BOOL("CPU0_DSP", ARMSSE, cpu_dsp[0], true),
+    DEFINE_PROP_UINT32("CPU0_MPU_NS", ARMSSE, cpu_mpu_ns[0], 8),
+    DEFINE_PROP_UINT32("CPU0_MPU_S", ARMSSE, cpu_mpu_s[0], 8),
     DEFINE_PROP_END_OF_LIST()
 };
 
@@ -1029,6 +1037,14 @@ static void armsse_realize(DeviceState *dev, Error **errp)
                 return;
             }
         }
+        if (!object_property_set_uint(cpuobj, "mpu-ns-regions",
+                                      s->cpu_mpu_ns[i], errp)) {
+            return;
+        }
+        if (!object_property_set_uint(cpuobj, "mpu-s-regions",
+                                      s->cpu_mpu_s[i], errp)) {
+            return;
+        }
 
         if (i > 0) {
             memory_region_add_subregion_overlap(&s->cpu_container[i], 0,
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 07aecd9497d..9cda3c86388 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -124,6 +124,10 @@ struct MPS2TZMachineClass {
     int uart_overflow_irq; /* number of the combined UART overflow IRQ */
     uint32_t init_svtor; /* init-svtor setting for SSE */
     uint32_t sram_addr_width; /* SRAM_ADDR_WIDTH setting for SSE */
+    uint32_t cpu0_mpu_ns; /* CPU0_MPU_NS setting for SSE */
+    uint32_t cpu0_mpu_s; /* CPU0_MPU_S setting for SSE */
+    uint32_t cpu1_mpu_ns; /* CPU1_MPU_NS setting for SSE */
+    uint32_t cpu1_mpu_s; /* CPU1_MPU_S setting for SSE */
     const RAMInfo *raminfo;
     const char *armsse_type;
     uint32_t boot_ram_size; /* size of ram at address 0; 0 == find in raminfo */
@@ -183,6 +187,9 @@ OBJECT_DECLARE_TYPE(MPS2TZMachineState, MPS2TZMachineClass, MPS2TZ_MACHINE)
 #define MPS3_DDR_SIZE (2 * GiB)
 #endif
 
+/* For cpu{0,1}_mpu_{ns,s}, means "leave at SSE's default value" */
+#define MPU_REGION_DEFAULT UINT32_MAX
+
 static const uint32_t an505_oscclk[] = {
     40000000,
     24580000,
@@ -828,6 +835,20 @@ static void mps2tz_common_init(MachineState *machine)
                              OBJECT(system_memory), &error_abort);
     qdev_prop_set_uint32(iotkitdev, "EXP_NUMIRQ", mmc->numirq);
     qdev_prop_set_uint32(iotkitdev, "init-svtor", mmc->init_svtor);
+    if (mmc->cpu0_mpu_ns != MPU_REGION_DEFAULT) {
+        qdev_prop_set_uint32(iotkitdev, "CPU0_MPU_NS", mmc->cpu0_mpu_ns);
+    }
+    if (mmc->cpu0_mpu_s != MPU_REGION_DEFAULT) {
+        qdev_prop_set_uint32(iotkitdev, "CPU0_MPU_S", mmc->cpu0_mpu_s);
+    }
+    if (object_property_find(OBJECT(iotkitdev), "CPU1_MPU_NS")) {
+        if (mmc->cpu1_mpu_ns != MPU_REGION_DEFAULT) {
+            qdev_prop_set_uint32(iotkitdev, "CPU1_MPU_NS", mmc->cpu1_mpu_ns);
+        }
+        if (mmc->cpu1_mpu_s != MPU_REGION_DEFAULT) {
+            qdev_prop_set_uint32(iotkitdev, "CPU1_MPU_S", mmc->cpu1_mpu_s);
+        }
+    }
     qdev_prop_set_uint32(iotkitdev, "SRAM_ADDR_WIDTH", mmc->sram_addr_width);
     qdev_connect_clock_in(iotkitdev, "MAINCLK", mms->sysclk);
     qdev_connect_clock_in(iotkitdev, "S32KCLK", mms->s32kclk);
@@ -1256,10 +1277,17 @@ static void mps2tz_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     IDAUInterfaceClass *iic = IDAU_INTERFACE_CLASS(oc);
+    MPS2TZMachineClass *mmc = MPS2TZ_MACHINE_CLASS(oc);
 
     mc->init = mps2tz_common_init;
     mc->reset = mps2_machine_reset;
     iic->check = mps2_tz_idau_check;
+
+    /* Most machines leave these at the SSE defaults */
+    mmc->cpu0_mpu_ns = MPU_REGION_DEFAULT;
+    mmc->cpu0_mpu_s = MPU_REGION_DEFAULT;
+    mmc->cpu1_mpu_ns = MPU_REGION_DEFAULT;
+    mmc->cpu1_mpu_s = MPU_REGION_DEFAULT;
 }
 
 static void mps2tz_set_default_ram_info(MPS2TZMachineClass *mmc)
@@ -1396,6 +1424,7 @@ static void mps3tz_an547_class_init(ObjectClass *oc, void *data)
     mmc->numirq = 96;
     mmc->uart_overflow_irq = 48;
     mmc->init_svtor = 0x00000000;
+    mmc->cpu0_mpu_s = mmc->cpu0_mpu_ns = 16;
     mmc->sram_addr_width = 21;
     mmc->raminfo = an547_raminfo;
     mmc->armsse_type = TYPE_SSE300;
-- 
2.34.1


