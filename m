Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1BC7CFB49
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:38:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTCh-0003BU-M7; Thu, 19 Oct 2023 09:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBs-0001sP-Pe
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:57 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBj-0001Dn-Ak
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:55 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4084e49a5e5so465885e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697722545; x=1698327345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GZd0Sp79j4a2EdYyRqKY/xWbpD0HX364iiDAlt9cITU=;
 b=Bth19nMlJEViACDzYZqsKdzzxGm0j7mNJgvVr44laVjHuY2UcJL1CSTd8K0XAj4w7Q
 DYg0Bl9xTSMwavuwxigcEsG/GpLfYZzVaKYwEdAIUqccjuZ3NYApxgNmVKbgFfIzWLIA
 8paNxwwA2wEIPCkmI07MOhkgBK2y/mH4qDug8fImJ8wgaMWx64cYCjWYxVQSfV3TAvVh
 dLtcYRZ8hDuFVxl7JhUHKLWNS+7wJiEoiZOlDR4hgjg5Ay+r9UubE6jAnp3ea9c46D3T
 V0Pqs0oMfm7uvmknitro+avWCA5IyuekFdQ0FUVbTNFwp2EPYSfEhQdwh6KIDIUp9CBD
 HPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697722545; x=1698327345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GZd0Sp79j4a2EdYyRqKY/xWbpD0HX364iiDAlt9cITU=;
 b=YboDUQSr6YoHnt55T4Tlxm9JFGvJqaVoCaDRas0k3PKPMD3B+DbqU/GawGcxZEcV7R
 nT5owsPC9y30j4o3BqWCQ6W/irJ971hkiLOiTpAstUt1xuQRor93dqt47/JT7Vn2FPEh
 ygxFDV0YF3y0GTulwUrn8q/GKoAc1ccqDz4plmFWbkbB6ZPaCMNPzPnNn9inlRA8Nj8z
 WN59kYeE74irNvyEJIOFvI7XBeak1oK0obutLAL7OvY+o/Fnf/PpVO22j7VapKEFRLRb
 m/CzXXAGo2tn5xGhac5yxpEhtKL9HuBsytzCY5fFei2Z8CSQmK4P0Qpd3g4jvKT8AP2f
 cNtQ==
X-Gm-Message-State: AOJu0Yz7DoAPAUZy40wsTGigdiMFRosYkRp7trCcM15+qbp6142xJiu9
 OdZUqHAcTyQ7r9yXImylnOYEhfQ44MDP52LIRs0=
X-Google-Smtp-Source: AGHT+IGzAjyYcxNLqnXq6wNSsD2eLT68h6jQI4IVJ+mclNfVNXnS1IrmiKblk3lQAs6MzacWiGlO5w==
X-Received: by 2002:a05:6000:71e:b0:32d:9701:90e5 with SMTP id
 bs30-20020a056000071e00b0032d970190e5mr1666075wrb.34.1697722545311; 
 Thu, 19 Oct 2023 06:35:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d28-20020adf9b9c000000b0031f3ad17b2csm4512690wrc.52.2023.10.19.06.35.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 06:35:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/24] arm/kvm: convert to kvm_get_one_reg
Date: Thu, 19 Oct 2023 14:35:27 +0100
Message-Id: <20231019133537.2114929-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133537.2114929-1-peter.maydell@linaro.org>
References: <20231019133537.2114929-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Cornelia Huck <cohuck@redhat.com>

We can neaten the code by switching the callers that work on a
CPUstate to the kvm_get_one_reg function.

Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20231010142453.224369-3-cohuck@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm.c   | 15 +++---------
 target/arm/kvm64.c | 57 ++++++++++++----------------------------------
 2 files changed, 18 insertions(+), 54 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 1a8084c4601..7903e2ddde1 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -553,24 +553,19 @@ bool write_kvmstate_to_list(ARMCPU *cpu)
     bool ok = true;
 
     for (i = 0; i < cpu->cpreg_array_len; i++) {
-        struct kvm_one_reg r;
         uint64_t regidx = cpu->cpreg_indexes[i];
         uint32_t v32;
         int ret;
 
-        r.id = regidx;
-
         switch (regidx & KVM_REG_SIZE_MASK) {
         case KVM_REG_SIZE_U32:
-            r.addr = (uintptr_t)&v32;
-            ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &r);
+            ret = kvm_get_one_reg(cs, regidx, &v32);
             if (!ret) {
                 cpu->cpreg_values[i] = v32;
             }
             break;
         case KVM_REG_SIZE_U64:
-            r.addr = (uintptr_t)(cpu->cpreg_values + i);
-            ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &r);
+            ret = kvm_get_one_reg(cs, regidx, cpu->cpreg_values + i);
             break;
         default:
             g_assert_not_reached();
@@ -706,17 +701,13 @@ int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu)
 void kvm_arm_get_virtual_time(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
-    struct kvm_one_reg reg = {
-        .id = KVM_REG_ARM_TIMER_CNT,
-        .addr = (uintptr_t)&cpu->kvm_vtime,
-    };
     int ret;
 
     if (cpu->kvm_vtime_dirty) {
         return;
     }
 
-    ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+    ret = kvm_get_one_reg(cs, KVM_REG_ARM_TIMER_CNT, &cpu->kvm_vtime);
     if (ret) {
         error_report("Failed to get KVM_REG_ARM_TIMER_CNT");
         abort();
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 047b269a791..558c0b88dd6 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -909,14 +909,11 @@ int kvm_arch_put_registers(CPUState *cs, int level)
 static int kvm_arch_get_fpsimd(CPUState *cs)
 {
     CPUARMState *env = &ARM_CPU(cs)->env;
-    struct kvm_one_reg reg;
     int i, ret;
 
     for (i = 0; i < 32; i++) {
         uint64_t *q = aa64_vfp_qreg(env, i);
-        reg.id = AARCH64_SIMD_CORE_REG(fp_regs.vregs[i]);
-        reg.addr = (uintptr_t)q;
-        ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+        ret = kvm_get_one_reg(cs, AARCH64_SIMD_CORE_REG(fp_regs.vregs[i]), q);
         if (ret) {
             return ret;
         } else {
@@ -940,15 +937,12 @@ static int kvm_arch_get_sve(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
-    struct kvm_one_reg reg;
     uint64_t *r;
     int n, ret;
 
     for (n = 0; n < KVM_ARM64_SVE_NUM_ZREGS; ++n) {
         r = &env->vfp.zregs[n].d[0];
-        reg.addr = (uintptr_t)r;
-        reg.id = KVM_REG_ARM64_SVE_ZREG(n, 0);
-        ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+        ret = kvm_get_one_reg(cs, KVM_REG_ARM64_SVE_ZREG(n, 0), r);
         if (ret) {
             return ret;
         }
@@ -957,9 +951,7 @@ static int kvm_arch_get_sve(CPUState *cs)
 
     for (n = 0; n < KVM_ARM64_SVE_NUM_PREGS; ++n) {
         r = &env->vfp.pregs[n].p[0];
-        reg.addr = (uintptr_t)r;
-        reg.id = KVM_REG_ARM64_SVE_PREG(n, 0);
-        ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+        ret = kvm_get_one_reg(cs, KVM_REG_ARM64_SVE_PREG(n, 0), r);
         if (ret) {
             return ret;
         }
@@ -967,9 +959,7 @@ static int kvm_arch_get_sve(CPUState *cs)
     }
 
     r = &env->vfp.pregs[FFR_PRED_NUM].p[0];
-    reg.addr = (uintptr_t)r;
-    reg.id = KVM_REG_ARM64_SVE_FFR(0);
-    ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+    ret = kvm_get_one_reg(cs, KVM_REG_ARM64_SVE_FFR(0), r);
     if (ret) {
         return ret;
     }
@@ -980,7 +970,6 @@ static int kvm_arch_get_sve(CPUState *cs)
 
 int kvm_arch_get_registers(CPUState *cs)
 {
-    struct kvm_one_reg reg;
     uint64_t val;
     unsigned int el;
     uint32_t fpr;
@@ -990,31 +979,24 @@ int kvm_arch_get_registers(CPUState *cs)
     CPUARMState *env = &cpu->env;
 
     for (i = 0; i < 31; i++) {
-        reg.id = AARCH64_CORE_REG(regs.regs[i]);
-        reg.addr = (uintptr_t) &env->xregs[i];
-        ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+        ret = kvm_get_one_reg(cs, AARCH64_CORE_REG(regs.regs[i]),
+                              &env->xregs[i]);
         if (ret) {
             return ret;
         }
     }
 
-    reg.id = AARCH64_CORE_REG(regs.sp);
-    reg.addr = (uintptr_t) &env->sp_el[0];
-    ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+    ret = kvm_get_one_reg(cs, AARCH64_CORE_REG(regs.sp), &env->sp_el[0]);
     if (ret) {
         return ret;
     }
 
-    reg.id = AARCH64_CORE_REG(sp_el1);
-    reg.addr = (uintptr_t) &env->sp_el[1];
-    ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+    ret = kvm_get_one_reg(cs, AARCH64_CORE_REG(sp_el1), &env->sp_el[1]);
     if (ret) {
         return ret;
     }
 
-    reg.id = AARCH64_CORE_REG(regs.pstate);
-    reg.addr = (uintptr_t) &val;
-    ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+    ret = kvm_get_one_reg(cs, AARCH64_CORE_REG(regs.pstate), &val);
     if (ret) {
         return ret;
     }
@@ -1031,9 +1013,7 @@ int kvm_arch_get_registers(CPUState *cs)
      */
     aarch64_restore_sp(env, 1);
 
-    reg.id = AARCH64_CORE_REG(regs.pc);
-    reg.addr = (uintptr_t) &env->pc;
-    ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+    ret = kvm_get_one_reg(cs, AARCH64_CORE_REG(regs.pc), &env->pc);
     if (ret) {
         return ret;
     }
@@ -1047,9 +1027,7 @@ int kvm_arch_get_registers(CPUState *cs)
         aarch64_sync_64_to_32(env);
     }
 
-    reg.id = AARCH64_CORE_REG(elr_el1);
-    reg.addr = (uintptr_t) &env->elr_el[1];
-    ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+    ret = kvm_get_one_reg(cs, AARCH64_CORE_REG(elr_el1), &env->elr_el[1]);
     if (ret) {
         return ret;
     }
@@ -1059,9 +1037,8 @@ int kvm_arch_get_registers(CPUState *cs)
      * KVM SPSRs 0-4 map to QEMU banks 1-5
      */
     for (i = 0; i < KVM_NR_SPSR; i++) {
-        reg.id = AARCH64_CORE_REG(spsr[i]);
-        reg.addr = (uintptr_t) &env->banked_spsr[i + 1];
-        ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+        ret = kvm_get_one_reg(cs, AARCH64_CORE_REG(spsr[i]),
+                              &env->banked_spsr[i + 1]);
         if (ret) {
             return ret;
         }
@@ -1082,17 +1059,13 @@ int kvm_arch_get_registers(CPUState *cs)
         return ret;
     }
 
-    reg.addr = (uintptr_t)(&fpr);
-    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpsr);
-    ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+    ret = kvm_get_one_reg(cs, AARCH64_SIMD_CTRL_REG(fp_regs.fpsr), &fpr);
     if (ret) {
         return ret;
     }
     vfp_set_fpsr(env, fpr);
 
-    reg.addr = (uintptr_t)(&fpr);
-    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpcr);
-    ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+    ret = kvm_get_one_reg(cs, AARCH64_SIMD_CTRL_REG(fp_regs.fpcr), &fpr);
     if (ret) {
         return ret;
     }
-- 
2.34.1


