Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4E27CFB42
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:37:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTCl-0003H1-Ma; Thu, 19 Oct 2023 09:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBw-0001zO-9C
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:36:02 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBq-0001Dh-F3
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:59 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40839652b97so18275995e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697722545; x=1698327345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JjwEGCnWRdnzpw2/wu0zwaRKL9Af9lEaMljStQ4GHxU=;
 b=VOPlsts7P4ZfLZrqHVMz9DC0Y6duX7ZdW7BxaYO/13p+fBOVPvgj7BBO+ksl5JCIOI
 giOB9n2UhLfKbTSSqdI3npD+vfmrA/plX2eX9zkRbOHlP44yytaRihZBZZJGQctpRUfa
 D7nf2DJEDgIhimjgSeSi+fdryD3g/qwYuqv+joIgcMQxDWjyvephsNMIbqjFFF8+sxmJ
 CapHIi+An0R9P6yqxsKmy/hpfgD6/A07nZNXsnAyppjLBotG8PdQksms+EFbSuO2i6MW
 cbeD7WnSAPuMp8+0pCTg268PThLjkcRHp91UIDYG0U0d+/0fsiALELMtxcmBFWttegQ0
 jM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697722545; x=1698327345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JjwEGCnWRdnzpw2/wu0zwaRKL9Af9lEaMljStQ4GHxU=;
 b=nb/HOm/ApyRFlWsGj/0YT4FOrbafMRnoGD1cedsBiBPesa5V9cjGy7lTWXbBdPmDKc
 ni4OOh56/81yBNM3H9oXICeszMHqmh3HfwemxeBpaLdHWNbxlt7FrN/4Gype4BgHGF1W
 IC/u2+2wdZxuT27hBATZokUf1W/pH5+xnGqX8ZNoLHEwVhph57HkNhsHly0Do8zPWXCI
 AQCj8Pro7v+b8SJQwZ5lvG+aK7pI0Cl66/ux9uokNG5hg1gAi0QohrkdGyT6m/gg9/4B
 b/Wxa3FsrotSeV1nVhE24IIw7idGFyNKHT4OEorLmGVvi2KIMSSpU5ZE24jDN6tJGiBT
 NExQ==
X-Gm-Message-State: AOJu0YysC/KjunzH/ddCKJid2wRVMHRCQgCQw/AEurjO47x8a71h5Ecg
 j8d6KeBXCS+jk8Fe5YGQxcO2lt4VrKhViDtKUV0=
X-Google-Smtp-Source: AGHT+IHIAYG/DuLyzL5PjpHPxO0ANVzt3BvpWR8rrEheFnfszxJpGWRzBuJjYAMLTbxtFc10PSHjZw==
X-Received: by 2002:a5d:4fcc:0:b0:32d:ad8b:2a04 with SMTP id
 h12-20020a5d4fcc000000b0032dad8b2a04mr1498546wrw.14.1697722544848; 
 Thu, 19 Oct 2023 06:35:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d28-20020adf9b9c000000b0031f3ad17b2csm4512690wrc.52.2023.10.19.06.35.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 06:35:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/24] arm/kvm: convert to kvm_set_one_reg
Date: Thu, 19 Oct 2023 14:35:26 +0100
Message-Id: <20231019133537.2114929-14-peter.maydell@linaro.org>
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

We can neaten the code by switching to the kvm_set_one_reg function.

Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20231010142453.224369-2-cohuck@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm.c   | 13 +++------
 target/arm/kvm64.c | 66 +++++++++++++---------------------------------
 2 files changed, 21 insertions(+), 58 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b66b936a958..1a8084c4601 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -589,7 +589,6 @@ bool write_list_to_kvmstate(ARMCPU *cpu, int level)
     bool ok = true;
 
     for (i = 0; i < cpu->cpreg_array_len; i++) {
-        struct kvm_one_reg r;
         uint64_t regidx = cpu->cpreg_indexes[i];
         uint32_t v32;
         int ret;
@@ -598,19 +597,17 @@ bool write_list_to_kvmstate(ARMCPU *cpu, int level)
             continue;
         }
 
-        r.id = regidx;
         switch (regidx & KVM_REG_SIZE_MASK) {
         case KVM_REG_SIZE_U32:
             v32 = cpu->cpreg_values[i];
-            r.addr = (uintptr_t)&v32;
+            ret = kvm_set_one_reg(cs, regidx, &v32);
             break;
         case KVM_REG_SIZE_U64:
-            r.addr = (uintptr_t)(cpu->cpreg_values + i);
+            ret = kvm_set_one_reg(cs, regidx, cpu->cpreg_values + i);
             break;
         default:
             g_assert_not_reached();
         }
-        ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &r);
         if (ret) {
             /* We might fail for "unknown register" and also for
              * "you tried to set a register which is constant with
@@ -731,17 +728,13 @@ void kvm_arm_get_virtual_time(CPUState *cs)
 void kvm_arm_put_virtual_time(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
-    struct kvm_one_reg reg = {
-        .id = KVM_REG_ARM_TIMER_CNT,
-        .addr = (uintptr_t)&cpu->kvm_vtime,
-    };
     int ret;
 
     if (!cpu->kvm_vtime_dirty) {
         return;
     }
 
-    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+    ret = kvm_set_one_reg(cs, KVM_REG_ARM_TIMER_CNT, &cpu->kvm_vtime);
     if (ret) {
         error_report("Failed to set KVM_REG_ARM_TIMER_CNT");
         abort();
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 5e95c496bb9..047b269a791 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -540,14 +540,10 @@ static int kvm_arm_sve_set_vls(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     uint64_t vls[KVM_ARM64_SVE_VLS_WORDS] = { cpu->sve_vq.map };
-    struct kvm_one_reg reg = {
-        .id = KVM_REG_ARM64_SVE_VLS,
-        .addr = (uint64_t)&vls[0],
-    };
 
     assert(cpu->sve_max_vq <= KVM_ARM64_SVE_VQ_MAX);
 
-    return kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+    return kvm_set_one_reg(cs, KVM_REG_ARM64_SVE_VLS, &vls[0]);
 }
 
 #define ARM_CPU_ID_MPIDR       3, 0, 0, 0, 5
@@ -726,19 +722,17 @@ static void kvm_inject_arm_sea(CPUState *c)
 static int kvm_arch_put_fpsimd(CPUState *cs)
 {
     CPUARMState *env = &ARM_CPU(cs)->env;
-    struct kvm_one_reg reg;
     int i, ret;
 
     for (i = 0; i < 32; i++) {
         uint64_t *q = aa64_vfp_qreg(env, i);
 #if HOST_BIG_ENDIAN
         uint64_t fp_val[2] = { q[1], q[0] };
-        reg.addr = (uintptr_t)fp_val;
+        ret = kvm_set_one_reg(cs, AARCH64_SIMD_CORE_REG(fp_regs.vregs[i]),
+                                                        fp_val);
 #else
-        reg.addr = (uintptr_t)q;
+        ret = kvm_set_one_reg(cs, AARCH64_SIMD_CORE_REG(fp_regs.vregs[i]), q);
 #endif
-        reg.id = AARCH64_SIMD_CORE_REG(fp_regs.vregs[i]);
-        ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
         if (ret) {
             return ret;
         }
@@ -759,14 +753,11 @@ static int kvm_arch_put_sve(CPUState *cs)
     CPUARMState *env = &cpu->env;
     uint64_t tmp[ARM_MAX_VQ * 2];
     uint64_t *r;
-    struct kvm_one_reg reg;
     int n, ret;
 
     for (n = 0; n < KVM_ARM64_SVE_NUM_ZREGS; ++n) {
         r = sve_bswap64(tmp, &env->vfp.zregs[n].d[0], cpu->sve_max_vq * 2);
-        reg.addr = (uintptr_t)r;
-        reg.id = KVM_REG_ARM64_SVE_ZREG(n, 0);
-        ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+        ret = kvm_set_one_reg(cs, KVM_REG_ARM64_SVE_ZREG(n, 0), r);
         if (ret) {
             return ret;
         }
@@ -775,9 +766,7 @@ static int kvm_arch_put_sve(CPUState *cs)
     for (n = 0; n < KVM_ARM64_SVE_NUM_PREGS; ++n) {
         r = sve_bswap64(tmp, r = &env->vfp.pregs[n].p[0],
                         DIV_ROUND_UP(cpu->sve_max_vq * 2, 8));
-        reg.addr = (uintptr_t)r;
-        reg.id = KVM_REG_ARM64_SVE_PREG(n, 0);
-        ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+        ret = kvm_set_one_reg(cs, KVM_REG_ARM64_SVE_PREG(n, 0), r);
         if (ret) {
             return ret;
         }
@@ -785,9 +774,7 @@ static int kvm_arch_put_sve(CPUState *cs)
 
     r = sve_bswap64(tmp, &env->vfp.pregs[FFR_PRED_NUM].p[0],
                     DIV_ROUND_UP(cpu->sve_max_vq * 2, 8));
-    reg.addr = (uintptr_t)r;
-    reg.id = KVM_REG_ARM64_SVE_FFR(0);
-    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+    ret = kvm_set_one_reg(cs, KVM_REG_ARM64_SVE_FFR(0), r);
     if (ret) {
         return ret;
     }
@@ -797,7 +784,6 @@ static int kvm_arch_put_sve(CPUState *cs)
 
 int kvm_arch_put_registers(CPUState *cs, int level)
 {
-    struct kvm_one_reg reg;
     uint64_t val;
     uint32_t fpr;
     int i, ret;
@@ -814,9 +800,8 @@ int kvm_arch_put_registers(CPUState *cs, int level)
     }
 
     for (i = 0; i < 31; i++) {
-        reg.id = AARCH64_CORE_REG(regs.regs[i]);
-        reg.addr = (uintptr_t) &env->xregs[i];
-        ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+        ret = kvm_set_one_reg(cs, AARCH64_CORE_REG(regs.regs[i]),
+                              &env->xregs[i]);
         if (ret) {
             return ret;
         }
@@ -827,16 +812,12 @@ int kvm_arch_put_registers(CPUState *cs, int level)
      */
     aarch64_save_sp(env, 1);
 
-    reg.id = AARCH64_CORE_REG(regs.sp);
-    reg.addr = (uintptr_t) &env->sp_el[0];
-    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+    ret = kvm_set_one_reg(cs, AARCH64_CORE_REG(regs.sp), &env->sp_el[0]);
     if (ret) {
         return ret;
     }
 
-    reg.id = AARCH64_CORE_REG(sp_el1);
-    reg.addr = (uintptr_t) &env->sp_el[1];
-    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+    ret = kvm_set_one_reg(cs, AARCH64_CORE_REG(sp_el1), &env->sp_el[1]);
     if (ret) {
         return ret;
     }
@@ -847,23 +828,17 @@ int kvm_arch_put_registers(CPUState *cs, int level)
     } else {
         val = cpsr_read(env);
     }
-    reg.id = AARCH64_CORE_REG(regs.pstate);
-    reg.addr = (uintptr_t) &val;
-    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+    ret = kvm_set_one_reg(cs, AARCH64_CORE_REG(regs.pstate), &val);
     if (ret) {
         return ret;
     }
 
-    reg.id = AARCH64_CORE_REG(regs.pc);
-    reg.addr = (uintptr_t) &env->pc;
-    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+    ret = kvm_set_one_reg(cs, AARCH64_CORE_REG(regs.pc), &env->pc);
     if (ret) {
         return ret;
     }
 
-    reg.id = AARCH64_CORE_REG(elr_el1);
-    reg.addr = (uintptr_t) &env->elr_el[1];
-    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+    ret = kvm_set_one_reg(cs, AARCH64_CORE_REG(elr_el1), &env->elr_el[1]);
     if (ret) {
         return ret;
     }
@@ -882,9 +857,8 @@ int kvm_arch_put_registers(CPUState *cs, int level)
 
     /* KVM 0-4 map to QEMU banks 1-5 */
     for (i = 0; i < KVM_NR_SPSR; i++) {
-        reg.id = AARCH64_CORE_REG(spsr[i]);
-        reg.addr = (uintptr_t) &env->banked_spsr[i + 1];
-        ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+        ret = kvm_set_one_reg(cs, AARCH64_CORE_REG(spsr[i]),
+                              &env->banked_spsr[i + 1]);
         if (ret) {
             return ret;
         }
@@ -899,18 +873,14 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         return ret;
     }
 
-    reg.addr = (uintptr_t)(&fpr);
     fpr = vfp_get_fpsr(env);
-    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpsr);
-    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+    ret = kvm_set_one_reg(cs, AARCH64_SIMD_CTRL_REG(fp_regs.fpsr), &fpr);
     if (ret) {
         return ret;
     }
 
-    reg.addr = (uintptr_t)(&fpr);
     fpr = vfp_get_fpcr(env);
-    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpcr);
-    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+    ret = kvm_set_one_reg(cs, AARCH64_SIMD_CTRL_REG(fp_regs.fpcr), &fpr);
     if (ret) {
         return ret;
     }
-- 
2.34.1


