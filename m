Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F13978498
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Sep 2024 17:21:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp806-0001mO-Cw; Fri, 13 Sep 2024 11:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp803-0001fI-4v
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:19 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp800-0007lP-9I
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:18 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42cb5b3c57eso21723455e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 08:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726240455; x=1726845255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=r15eh9lNLOdNiVsh42jBthlzs3PVFqaGiHiaiewjtac=;
 b=cBJlcpXip76PofgZu51QU/qc6T/Fq+NRZ5pNG8TTioE1LQdvf0BaNY7R+kSe6YrLh8
 YEyJyMxoiG+A308UexEz8Bag3dYF2oUFEckbEvMt3fKqfep2XMVcj4fLDUNPgkkaj6ts
 fQWJ+ngkNINffyNJWPByyqBbjLh58m6hWruFJ+CW4U0Ia2U+6NhwiAtgEXrjbeCZh9PU
 f31PVfARinua7e3jXto8PBjaoQIwilMHqnCIlR/aGvMIcGCBVrM2T7ucSB18h1baCpsX
 kdwiZVA1dUcFeXFORqIROVbUXE1K1KUHIwnWQc8Ryit4Bo4R029Nme/VtheGNzT3aBV2
 +yCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726240455; x=1726845255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r15eh9lNLOdNiVsh42jBthlzs3PVFqaGiHiaiewjtac=;
 b=LQoHEYU5dUQNOt9hhzccCQkfoY8fhvpMek4yT7vobc1Zp6u4wepLQeMZSQlT40hcwW
 D87y7n4XAAFa6Rh5n17fNDOzFkVlCayXsh9iUL6gfGto/lbqD67GZySBPXwuROuJqsai
 0u69EtYZQ8NXt44VrKWcnaldROT/LTG6wuk4LnvDDV3q579iP6Yv/qxXKi2pIYFW/tsd
 RyUBkY0ctbGKReGWJny2omjViNPQejfwxzrBf8CAj1e8gN4PIWKHX+wVZoXSbHpdi8EJ
 rh5Ez3qq1o27EE7ZoERG0vBuYI1aBcb4cv8BMJRFeBoxF3jfMg5SKPCAlIoUpu8KnprL
 pJuw==
X-Gm-Message-State: AOJu0Yzeb0Wuc4HPb1uE4gICbcEAyoa47YmKuunEYZJbMyB9ZksQe9+3
 nEtVcyxvG78TW+5wj6eZge8jLKz7emrw8tMYHLaT8MCUzzRM/OBlVevW6DGIrNknaUyW2qhbILh
 E
X-Google-Smtp-Source: AGHT+IEdHEAERMxQ8DaOuG6tuFCdHNym0zlk3iYrp1H0ARfMmY7i2/F1FdjWk348fM7dGUh6N9cghA==
X-Received: by 2002:a05:600c:3581:b0:42c:b995:20b6 with SMTP id
 5b1f17b1804b1-42cdb5385b2mr53928185e9.2.1726240454472; 
 Fri, 13 Sep 2024 08:14:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b16bfbfsm29152325e9.22.2024.09.13.08.14.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 08:14:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/27] target/s390: Convert CPU to Resettable interface
Date: Fri, 13 Sep 2024 16:13:47 +0100
Message-Id: <20240913151411.2167922-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913151411.2167922-1-peter.maydell@linaro.org>
References: <20240913151411.2167922-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Convert the s390 CPU to the Resettable interface.  This is slightly
more involved than the other CPU types were (see commits
9130cade5fc22..d66e64dd006df) because S390 has its own set of
different kinds of reset with different behaviours that it needs to
trigger.

We handle this by adding these reset types to the Resettable
ResetType enum.  Now instead of having an underlying implementation
of reset that is s390-specific and which might be called either
directly or via the DeviceClass::reset method, we can implement only
the Resettable hold phase method, and have the places that need to
trigger an s390-specific reset type do so by calling
resettable_reset().

The other option would have been to smuggle in the s390 reset
type via, for instance, a field in the CPU state that we set
in s390_do_cpu_initial_reset() etc and then examined in the
reset method, but doing it this way seems cleaner.

The motivation for this change is that this is the last caller
of the legacy device_class_set_parent_reset() function, and
removing that will let us clean up some glue code that we added
for the transition to three-phase reset.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Thomas Huth <thuth@redhat.com>
Message-id: 20240830145812.1967042-4-peter.maydell@linaro.org
---
 docs/devel/reset.rst    | 10 ++++++++++
 include/hw/resettable.h |  2 ++
 target/s390x/cpu.h      | 21 ++++-----------------
 target/s390x/cpu.c      | 38 +++++++++++++++++---------------------
 target/s390x/sigp.c     |  8 ++------
 5 files changed, 35 insertions(+), 44 deletions(-)

diff --git a/docs/devel/reset.rst b/docs/devel/reset.rst
index 9746a4e8a0b..ed41e09f16d 100644
--- a/docs/devel/reset.rst
+++ b/docs/devel/reset.rst
@@ -44,6 +44,16 @@ The Resettable interface handles reset types with an enum ``ResetType``:
   value on each cold reset, such as RNG seed information, and which they
   must not reinitialize on a snapshot-load reset.
 
+``RESET_TYPE_S390_CPU_NORMAL``
+  This is only used for S390 CPU objects; it clears interrupts, stops
+  processing, and clears the TLB, but does not touch register contents.
+
+``RESET_TYPE_S390_CPU_INITIAL``
+  This is only used for S390 CPU objects; it does everything
+  ``RESET_TYPE_S390_CPU_NORMAL`` does and also clears the PSW, prefix,
+  FPC, timer and control registers. It does not touch gprs, fprs or acrs.
+
+
 Devices which implement reset methods must treat any unknown ``ResetType``
 as equivalent to ``RESET_TYPE_COLD``; this will reduce the amount of
 existing code we need to change if we add more types in future.
diff --git a/include/hw/resettable.h b/include/hw/resettable.h
index 7e249deb8b5..83b561fc830 100644
--- a/include/hw/resettable.h
+++ b/include/hw/resettable.h
@@ -36,6 +36,8 @@ typedef struct ResettableState ResettableState;
 typedef enum ResetType {
     RESET_TYPE_COLD,
     RESET_TYPE_SNAPSHOT_LOAD,
+    RESET_TYPE_S390_CPU_INITIAL,
+    RESET_TYPE_S390_CPU_NORMAL,
 } ResetType;
 
 /*
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 6cbd77dfdf6..5ef61b1f750 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -177,19 +177,11 @@ struct ArchCPU {
     uint32_t irqstate_saved_size;
 };
 
-typedef enum cpu_reset_type {
-    S390_CPU_RESET_NORMAL,
-    S390_CPU_RESET_INITIAL,
-    S390_CPU_RESET_CLEAR,
-} cpu_reset_type;
-
 /**
  * S390CPUClass:
  * @parent_realize: The parent class' realize handler.
- * @parent_reset: The parent class' reset handler.
+ * @parent_phases: The parent class' reset phase handlers.
  * @load_normal: Performs a load normal.
- * @cpu_reset: Performs a CPU reset.
- * @initial_cpu_reset: Performs an initial CPU reset.
  *
  * An S/390 CPU model.
  */
@@ -203,9 +195,8 @@ struct S390CPUClass {
     const char *desc;
 
     DeviceRealize parent_realize;
-    DeviceReset parent_reset;
+    ResettablePhases parent_phases;
     void (*load_normal)(CPUState *cpu);
-    void (*reset)(CPUState *cpu, cpu_reset_type type);
 };
 
 #ifndef CONFIG_USER_ONLY
@@ -872,16 +863,12 @@ static inline void s390_do_cpu_full_reset(CPUState *cs, run_on_cpu_data arg)
 
 static inline void s390_do_cpu_reset(CPUState *cs, run_on_cpu_data arg)
 {
-    S390CPUClass *scc = S390_CPU_GET_CLASS(cs);
-
-    scc->reset(cs, S390_CPU_RESET_NORMAL);
+    resettable_reset(OBJECT(cs), RESET_TYPE_S390_CPU_NORMAL);
 }
 
 static inline void s390_do_cpu_initial_reset(CPUState *cs, run_on_cpu_data arg)
 {
-    S390CPUClass *scc = S390_CPU_GET_CLASS(cs);
-
-    scc->reset(cs, S390_CPU_RESET_INITIAL);
+    resettable_reset(OBJECT(cs), RESET_TYPE_S390_CPU_INITIAL);
 }
 
 static inline void s390_do_cpu_load_normal(CPUState *cs, run_on_cpu_data arg)
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 0fbfcd35d83..4e41a3dff59 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -32,6 +32,7 @@
 #include "sysemu/hw_accel.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
+#include "hw/resettable.h"
 #include "fpu/softfloat-helpers.h"
 #include "disas/capstone.h"
 #include "sysemu/tcg.h"
@@ -162,23 +163,25 @@ static void s390_query_cpu_fast(CPUState *cpu, CpuInfoFast *value)
 #endif
 }
 
-/* S390CPUClass::reset() */
-static void s390_cpu_reset(CPUState *s, cpu_reset_type type)
+/* S390CPUClass Resettable reset_hold phase method */
+static void s390_cpu_reset_hold(Object *obj, ResetType type)
 {
-    S390CPU *cpu = S390_CPU(s);
+    S390CPU *cpu = S390_CPU(obj);
     S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
     CPUS390XState *env = &cpu->env;
-    DeviceState *dev = DEVICE(s);
 
-    scc->parent_reset(dev);
+    if (scc->parent_phases.hold) {
+        scc->parent_phases.hold(obj, type);
+    }
     cpu->env.sigp_order = 0;
     s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
 
     switch (type) {
-    case S390_CPU_RESET_CLEAR:
+    default:
+        /* RESET_TYPE_COLD: power on or "clear" reset */
         memset(env, 0, offsetof(CPUS390XState, start_initial_reset_fields));
         /* fall through */
-    case S390_CPU_RESET_INITIAL:
+    case RESET_TYPE_S390_CPU_INITIAL:
         /* initial reset does not clear everything! */
         memset(&env->start_initial_reset_fields, 0,
                offsetof(CPUS390XState, start_normal_reset_fields) -
@@ -203,7 +206,7 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_type type)
         set_float_detect_tininess(float_tininess_before_rounding,
                                   &env->fpu_status);
        /* fall through */
-    case S390_CPU_RESET_NORMAL:
+    case RESET_TYPE_S390_CPU_NORMAL:
         env->psw.mask &= ~PSW_MASK_RI;
         memset(&env->start_normal_reset_fields, 0,
                offsetof(CPUS390XState, end_reset_fields) -
@@ -212,20 +215,18 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_type type)
         env->pfault_token = -1UL;
         env->bpbc = false;
         break;
-    default:
-        g_assert_not_reached();
     }
 
     /* Reset state inside the kernel that we cannot access yet from QEMU. */
     if (kvm_enabled()) {
         switch (type) {
-        case S390_CPU_RESET_CLEAR:
+        default:
             kvm_s390_reset_vcpu_clear(cpu);
             break;
-        case S390_CPU_RESET_INITIAL:
+        case RESET_TYPE_S390_CPU_INITIAL:
             kvm_s390_reset_vcpu_initial(cpu);
             break;
-        case S390_CPU_RESET_NORMAL:
+        case RESET_TYPE_S390_CPU_NORMAL:
             kvm_s390_reset_vcpu_normal(cpu);
             break;
         }
@@ -315,12 +316,6 @@ static Property s390x_cpu_properties[] = {
     DEFINE_PROP_END_OF_LIST()
 };
 
-static void s390_cpu_reset_full(DeviceState *dev)
-{
-    CPUState *s = CPU(dev);
-    return s390_cpu_reset(s, S390_CPU_RESET_CLEAR);
-}
-
 #ifdef CONFIG_TCG
 #include "hw/core/tcg-cpu-ops.h"
 
@@ -383,15 +378,16 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     S390CPUClass *scc = S390_CPU_CLASS(oc);
     CPUClass *cc = CPU_CLASS(scc);
     DeviceClass *dc = DEVICE_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
 
     device_class_set_parent_realize(dc, s390_cpu_realizefn,
                                     &scc->parent_realize);
     device_class_set_props(dc, s390x_cpu_properties);
     dc->user_creatable = true;
 
-    device_class_set_parent_reset(dc, s390_cpu_reset_full, &scc->parent_reset);
+    resettable_class_set_parent_phases(rc, NULL, s390_cpu_reset_hold, NULL,
+                                       &scc->parent_phases);
 
-    scc->reset = s390_cpu_reset;
     cc->class_by_name = s390_cpu_class_by_name,
     cc->has_work = s390_cpu_has_work;
     cc->mmu_index = s390x_cpu_mmu_index;
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index ad0ad61177d..08aaecf12bc 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -251,24 +251,20 @@ static void sigp_restart(CPUState *cs, run_on_cpu_data arg)
 
 static void sigp_initial_cpu_reset(CPUState *cs, run_on_cpu_data arg)
 {
-    S390CPU *cpu = S390_CPU(cs);
-    S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
     SigpInfo *si = arg.host_ptr;
 
     cpu_synchronize_state(cs);
-    scc->reset(cs, S390_CPU_RESET_INITIAL);
+    resettable_reset(OBJECT(cs), RESET_TYPE_S390_CPU_INITIAL);
     cpu_synchronize_post_reset(cs);
     si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
 }
 
 static void sigp_cpu_reset(CPUState *cs, run_on_cpu_data arg)
 {
-    S390CPU *cpu = S390_CPU(cs);
-    S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
     SigpInfo *si = arg.host_ptr;
 
     cpu_synchronize_state(cs);
-    scc->reset(cs, S390_CPU_RESET_NORMAL);
+    resettable_reset(OBJECT(cs), RESET_TYPE_S390_CPU_NORMAL);
     cpu_synchronize_post_reset(cs);
     si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
 }
-- 
2.34.1


