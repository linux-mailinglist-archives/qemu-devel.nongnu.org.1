Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF46E7AF019
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 17:57:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlAQK-0006HT-4K; Tue, 26 Sep 2023 11:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlAQF-0006Gx-Oj
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:56:27 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlAQC-0007CI-QC
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:56:27 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-405417465aaso81871515e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 08:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695743782; x=1696348582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=xCA2YOKYdmn/tsV09hQIawqHtpLl2aShgaJyEwU9YRw=;
 b=a89SYQE7KPEiOoGi4QdBF3Vxjrj/VrwEby8i0GdEm1uhnBcdx8a391gvhYzHPj6+uD
 WUog7Mounx8BuzvMP1XdsMK9A0PUOBiLncSagiq4Zoj7rlLZl80fmUpfpEYaH3EsSEyl
 BVuaJxkvUxBVwzUSA3XLIfyfOaoYQ3+bAK4L2W66sq4FZEfr3GTzcLhEh7npZDmknKL3
 1za3G9xPq6DdT/anHVOjcgySCBacduG+0Jw2Ens1pa6vnvxZsVJ0CYJ4A5uILDQILtow
 yx/zV1LM5DjdHEH1bur72aP/ERoDsAJNLpHWLXr3JZo+UBaTxr/63pxWiX5sTBJieEn2
 Z6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695743782; x=1696348582;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xCA2YOKYdmn/tsV09hQIawqHtpLl2aShgaJyEwU9YRw=;
 b=wQhhpqHkNpfnKLxBNkDRD/RtU+uxE0UH2pYqSMli9v5a/BSqQTf8nprE0QKhbFcLir
 ScJ1lSyICK2vli5YJbkY7RtP1C+vVn7whVaYLYyNEYl3FmK0x/J4lbNko5Q2iPdVERVP
 g7AlYgXwLL7KxWNl4p0nXAAWuK4zu83VeFLhaTvhcvz2NFTXrPfhsEeXkIZvHJR17Wa5
 kzmW/ueVXxq10JpqFaQxQOPG1KGK3qzPQBiiVf4ZpuTOm0LtoqegC+jaSKMoKaD9LOW7
 EwHN35Yh9nzwjQvAJfMxhvUxfLbM7YSdwKzgZPqO5Cs3ZJ9yM+wXnQqzCE4c9n4fUoY5
 uBDA==
X-Gm-Message-State: AOJu0Yy1rZnidkcaRGjn/VeSzqE1lIykcnyveQSaTMzYJlz2Eu8wA2jD
 DWXQ5M7zYHN/UJkpRwiEJ10iDw==
X-Google-Smtp-Source: AGHT+IFo76mC6D4IcrpVUnQh32yzTyA/tVMYoRs7hkBiE1Lw014rVn3HS7Py7qJT1PMLlm64lo2KJQ==
X-Received: by 2002:a7b:cd0a:0:b0:402:ea83:45cf with SMTP id
 f10-20020a7bcd0a000000b00402ea8345cfmr9906710wmj.2.1695743781720; 
 Tue, 26 Sep 2023 08:56:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 u8-20020a7bc048000000b003fe2b081661sm18295621wmc.30.2023.09.26.08.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 08:56:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm/arm-powerctl: Correctly init CPUs when powered on
 to lower EL
Date: Tue, 26 Sep 2023 16:56:19 +0100
Message-Id: <20230926155619.4028618-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

The code for powering on a CPU in arm-powerctl.c has two separate
use cases:
 * emulation of a real hardware power controller
 * emulation of firmware interfaces (primarily PSCI) with
   CPU on/off APIs

For the first case, we only need to reset the CPU and set its
starting PC and X0.  For the second case, because we're emulating the
firmware we need to ensure that it's in the state that the firmware
provides.  In particular, when we reset to a lower EL than the
highest one we are emulating, we need to put the CPU into a state
that permits correct running at that lower EL.  We already do a
little of this in arm-powerctl.c (for instance we set SCR_HCE to
enable the HVC insn) but we don't do enough of it.  This means that
in the case where we are emulating EL3 but also providing emulated
PSCI the guest will crash when a secondary core tries to use a
feature that needs an SCR_EL3 bit to be set, such as MTE or PAuth.

The hw/arm/boot.c code also has to support this "start guest code in
an EL that's lower than the highest emulated EL" case in order to do
direct guest kernel booting; it has all the necessary initialization
code to set the SCR_EL3 bits.  Pull the relevant boot.c code out into
a separate function so we can share it between there and
arm-powerctl.c.

This refactoring has a few code changes that look like they
might be behaviour changes but aren't:
 * if info->secure_boot is false and info->secure_board_setup is
   true, then the old code would start the first CPU in Hyp
   mode but without changing SCR.NS and NSACR.{CP11,CP10}.
   This was wrong behaviour because there's no such thing
   as Secure Hyp mode. The new code will leave the CPU in SVC.
   (There is no board which sets secure_boot to false and
   secure_board_setup to true, so this isn't a behaviour
   change for any of our boards.)
 * we don't explicitly clear SCR.NS when arm-powerctl.c
   does a CPU-on to EL3. This was a no-op because CPU reset
   will reset to NS == 0.

And some real behaviour changes:
 * we no longer set HCR_EL2.RW when booting into EL2: the guest
   can and should do that themselves before dropping into their
   EL1 code. (arm-powerctl and boot did this differently; I
   opted to use the logic from arm-powerctl, which only sets
   HCR_EL2.RW when it's directly starting the guest in EL1,
   because it's more correct, and I don't expect guests to be
   accidentally depending on our having set the RW bit for them.)
 * if we are booting a CPU into AArch32 Secure SVC then we won't
   set SCR.HCE any more. This affects only the vexpress-a15 and
   raspi2b machine types. Guests booting in this case will either:
    - be able to set SCR.HCE themselves as part of moving from
      Secure SVC into NS Hyp mode
    - will move from Secure SVC to NS SVC, and won't care about
      behaviour of the HVC insn
    - will stay in Secure SVC, and won't care about HVC
 * on an arm-powerctl CPU-on we will now set the SCR bits for
   pauth/mte/sve/sme/hcx/fgt features

The first two of these are very minor and I don't expect guest
code to trip over them, so I didn't judge it worth convoluting
the code in an attempt to keep exactly the same boot.c behaviour.
The third change fixes issue 1899.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1899
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h          | 22 +++++++++
 hw/arm/boot.c             | 95 ++++++++++-----------------------------
 target/arm/arm-powerctl.c | 53 +---------------------
 target/arm/cpu.c          | 95 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 141 insertions(+), 124 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index bd55c5dabfd..43d50ec712d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1150,6 +1150,28 @@ int arm_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
 int arm_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
                              int cpuid, DumpState *s);
 
+/**
+ * arm_emulate_firmware_reset: Emulate firmware CPU reset handling
+ * @cpu: CPU (which must have been freshly reset)
+ * @target_el: exception level to put the CPU into
+ * @secure: whether to put the CPU in secure state
+ *
+ * When QEMU is directly running a guest kernel at a lower level than
+ * EL3 it implicitly emulates some aspects of the guest firmware.
+ * This includes that on reset we need to configure the parts of the
+ * CPU corresponding to EL3 so that the real guest code can run at its
+ * lower exception level. This function does that post-reset CPU setup,
+ * for when we do direct boot of a guest kernel, and for when we
+ * emulate PSCI and similar firmware interfaces starting a CPU at a
+ * lower exception level.
+ *
+ * @target_el must be an EL implemented by the CPU between 1 and 3.
+ * We do not support dropping into a Secure EL other than 3.
+ *
+ * It is the responsibility of the caller to call arm_rebuild_hflags().
+ */
+void arm_emulate_firmware_reset(CPUState *cpustate, int target_el);
+
 #ifdef TARGET_AARCH64
 int aarch64_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int aarch64_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 24fa1690600..84ea6a807a4 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -722,84 +722,35 @@ static void do_cpu_reset(void *opaque)
 
             cpu_set_pc(cs, entry);
         } else {
-            /* If we are booting Linux then we need to check whether we are
-             * booting into secure or non-secure state and adjust the state
-             * accordingly.  Out of reset, ARM is defined to be in secure state
-             * (SCR.NS = 0), we change that here if non-secure boot has been
-             * requested.
+            /*
+             * If we are booting Linux then we might need to do so at:
+             *  - AArch64 NS EL2 or NS EL1
+             *  - AArch32 Secure SVC (EL3)
+             *  - AArch32 NS Hyp (EL2)
+             *  - AArch32 NS SVC (EL1)
+             * Configure the CPU in the way boot firmware would do to
+             * drop us down to the appropriate level.
              */
-            if (arm_feature(env, ARM_FEATURE_EL3)) {
-                /* AArch64 is defined to come out of reset into EL3 if enabled.
-                 * If we are booting Linux then we need to adjust our EL as
-                 * Linux expects us to be in EL2 or EL1.  AArch32 resets into
-                 * SVC, which Linux expects, so no privilege/exception level to
-                 * adjust.
-                 */
-                if (env->aarch64) {
-                    env->cp15.scr_el3 |= SCR_RW;
-                    if (arm_feature(env, ARM_FEATURE_EL2)) {
-                        env->cp15.hcr_el2 |= HCR_RW;
-                        env->pstate = PSTATE_MODE_EL2h;
-                    } else {
-                        env->pstate = PSTATE_MODE_EL1h;
-                    }
-                    if (cpu_isar_feature(aa64_pauth, cpu)) {
-                        env->cp15.scr_el3 |= SCR_API | SCR_APK;
-                    }
-                    if (cpu_isar_feature(aa64_mte, cpu)) {
-                        env->cp15.scr_el3 |= SCR_ATA;
-                    }
-                    if (cpu_isar_feature(aa64_sve, cpu)) {
-                        env->cp15.cptr_el[3] |= R_CPTR_EL3_EZ_MASK;
-                        env->vfp.zcr_el[3] = 0xf;
-                    }
-                    if (cpu_isar_feature(aa64_sme, cpu)) {
-                        env->cp15.cptr_el[3] |= R_CPTR_EL3_ESM_MASK;
-                        env->cp15.scr_el3 |= SCR_ENTP2;
-                        env->vfp.smcr_el[3] = 0xf;
-                    }
-                    if (cpu_isar_feature(aa64_hcx, cpu)) {
-                        env->cp15.scr_el3 |= SCR_HXEN;
-                    }
-                    if (cpu_isar_feature(aa64_fgt, cpu)) {
-                        env->cp15.scr_el3 |= SCR_FGTEN;
-                    }
+            int target_el = arm_feature(env, ARM_FEATURE_EL2) ? 2 : 1;
 
-                    /* AArch64 kernels never boot in secure mode */
-                    assert(!info->secure_boot);
-                    /* This hook is only supported for AArch32 currently:
-                     * bootloader_aarch64[] will not call the hook, and
-                     * the code above has already dropped us into EL2 or EL1.
-                     */
-                    assert(!info->secure_board_setup);
-                }
-
-                if (arm_feature(env, ARM_FEATURE_EL2)) {
-                    /* If we have EL2 then Linux expects the HVC insn to work */
-                    env->cp15.scr_el3 |= SCR_HCE;
-                }
-
-                /* Set to non-secure if not a secure boot */
-                if (!info->secure_boot &&
-                    (cs != first_cpu || !info->secure_board_setup)) {
-                    /* Linux expects non-secure state */
-                    env->cp15.scr_el3 |= SCR_NS;
-                    /* Set NSACR.{CP11,CP10} so NS can access the FPU */
-                    env->cp15.nsacr |= 3 << 10;
-                }
-            }
-
-            if (!env->aarch64 && !info->secure_boot &&
-                arm_feature(env, ARM_FEATURE_EL2)) {
+            if (env->aarch64) {
                 /*
-                 * This is an AArch32 boot not to Secure state, and
-                 * we have Hyp mode available, so boot the kernel into
-                 * Hyp mode. This is not how the CPU comes out of reset,
-                 * so we need to manually put it there.
+                 * AArch64 kernels never boot in secure mode, and we don't
+                 * support the secure_board_setup hook for AArch64.
                  */
-                cpsr_write(env, ARM_CPU_MODE_HYP, CPSR_M, CPSRWriteRaw);
+                assert(!info->secure_boot);
+                assert(!info->secure_board_setup);
+            } else {
+                if (arm_feature(env, ARM_FEATURE_EL3) &&
+                    (info->secure_boot ||
+                     (info->secure_board_setup && cs == first_cpu))) {
+                    /* Start this CPU in Secure SVC */
+                    target_el = 3;
+                }
             }
 
+            arm_emulate_firmware_reset(cs, target_el);
+
             if (cs == first_cpu) {
                 AddressSpace *as = arm_boot_address_space(cpu, info);
 
diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index 326a03153df..c078849403c 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -65,60 +65,9 @@ static void arm_set_cpu_on_async_work(CPUState *target_cpu_state,
 
     /* Initialize the cpu we are turning on */
     cpu_reset(target_cpu_state);
+    arm_emulate_firmware_reset(target_cpu_state, info->target_el);
     target_cpu_state->halted = 0;
 
-    if (info->target_aa64) {
-        if ((info->target_el < 3) && arm_feature(&target_cpu->env,
-                                                 ARM_FEATURE_EL3)) {
-            /*
-             * As target mode is AArch64, we need to set lower
-             * exception level (the requested level 2) to AArch64
-             */
-            target_cpu->env.cp15.scr_el3 |= SCR_RW;
-        }
-
-        if ((info->target_el < 2) && arm_feature(&target_cpu->env,
-                                                 ARM_FEATURE_EL2)) {
-            /*
-             * As target mode is AArch64, we need to set lower
-             * exception level (the requested level 1) to AArch64
-             */
-            target_cpu->env.cp15.hcr_el2 |= HCR_RW;
-        }
-
-        target_cpu->env.pstate = aarch64_pstate_mode(info->target_el, true);
-    } else {
-        /* We are requested to boot in AArch32 mode */
-        static const uint32_t mode_for_el[] = { 0,
-                                                ARM_CPU_MODE_SVC,
-                                                ARM_CPU_MODE_HYP,
-                                                ARM_CPU_MODE_SVC };
-
-        cpsr_write(&target_cpu->env, mode_for_el[info->target_el], CPSR_M,
-                   CPSRWriteRaw);
-    }
-
-    if (info->target_el == 3) {
-        /* Processor is in secure mode */
-        target_cpu->env.cp15.scr_el3 &= ~SCR_NS;
-    } else {
-        /* Processor is not in secure mode */
-        target_cpu->env.cp15.scr_el3 |= SCR_NS;
-
-        /* Set NSACR.{CP11,CP10} so NS can access the FPU */
-        target_cpu->env.cp15.nsacr |= 3 << 10;
-
-        /*
-         * If QEMU is providing the equivalent of EL3 firmware, then we need
-         * to make sure a CPU targeting EL2 comes out of reset with a
-         * functional HVC insn.
-         */
-        if (arm_feature(&target_cpu->env, ARM_FEATURE_EL3)
-            && info->target_el == 2) {
-            target_cpu->env.cp15.scr_el3 |= SCR_HCE;
-        }
-    }
-
     /* We check if the started CPU is now at the correct level */
     assert(info->target_el == arm_current_el(&target_cpu->env));
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b9e09a702d6..bc33ed07a44 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -553,6 +553,101 @@ static void arm_cpu_reset_hold(Object *obj)
     }
 }
 
+void arm_emulate_firmware_reset(CPUState *cpustate, int target_el)
+{
+    ARMCPU *cpu = ARM_CPU(cpustate);
+    CPUARMState *env = &cpu->env;
+    bool have_el3 = arm_feature(env, ARM_FEATURE_EL3);
+    bool have_el2 = arm_feature(env, ARM_FEATURE_EL2);
+
+    /*
+     * Check we have the EL we're aiming for. If that is the
+     * highest implemented EL, then cpu_reset has already done
+     * all the work.
+     */
+    switch (target_el) {
+    case 3:
+        assert(have_el3);
+        return;
+    case 2:
+        assert(have_el2);
+        if (!have_el3) {
+            return;
+        }
+        break;
+    case 1:
+        if (!have_el3 && !have_el2) {
+            return;
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (have_el3) {
+        /*
+         * Set the EL3 state so code can run at EL2. This should match
+         * the requirements set by Linux in its booting spec.
+         */
+        if (env->aarch64) {
+            env->cp15.scr_el3 |= SCR_RW;
+            if (cpu_isar_feature(aa64_pauth, cpu)) {
+                env->cp15.scr_el3 |= SCR_API | SCR_APK;
+            }
+            if (cpu_isar_feature(aa64_mte, cpu)) {
+                env->cp15.scr_el3 |= SCR_ATA;
+            }
+            if (cpu_isar_feature(aa64_sve, cpu)) {
+                env->cp15.cptr_el[3] |= R_CPTR_EL3_EZ_MASK;
+                env->vfp.zcr_el[3] = 0xf;
+            }
+            if (cpu_isar_feature(aa64_sme, cpu)) {
+                env->cp15.cptr_el[3] |= R_CPTR_EL3_ESM_MASK;
+                env->cp15.scr_el3 |= SCR_ENTP2;
+                env->vfp.smcr_el[3] = 0xf;
+            }
+            if (cpu_isar_feature(aa64_hcx, cpu)) {
+                env->cp15.scr_el3 |= SCR_HXEN;
+            }
+            if (cpu_isar_feature(aa64_fgt, cpu)) {
+                env->cp15.scr_el3 |= SCR_FGTEN;
+            }
+        }
+
+        if (target_el == 2) {
+            /* If the guest is at EL2 then Linux expects the HVC insn to work */
+            env->cp15.scr_el3 |= SCR_HCE;
+        }
+
+        /* Put CPU into non-secure state */
+        env->cp15.scr_el3 |= SCR_NS;
+        /* Set NSACR.{CP11,CP10} so NS can access the FPU */
+        env->cp15.nsacr |= 3 << 10;
+    }
+
+    if (have_el2 && target_el < 2) {
+        /* Set EL2 state so code can run at EL1. */
+        if (env->aarch64) {
+            env->cp15.hcr_el2 |= HCR_RW;
+        }
+    }
+
+    /* Set the CPU to the desired state */
+    if (env->aarch64) {
+        env->pstate = aarch64_pstate_mode(target_el, true);
+    } else {
+        static const uint32_t mode_for_el[] = {
+            0,
+            ARM_CPU_MODE_SVC,
+            ARM_CPU_MODE_HYP,
+            ARM_CPU_MODE_SVC,
+        };
+
+        cpsr_write(env, mode_for_el[target_el], CPSR_M, CPSRWriteRaw);
+    }
+}
+
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
 
 static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
-- 
2.34.1


