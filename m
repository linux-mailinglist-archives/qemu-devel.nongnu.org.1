Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E053757A3A
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 13:15:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLif6-0003U6-MR; Tue, 18 Jul 2023 07:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1qLif1-0003Ti-A2
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 07:14:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1qLiev-0003al-Vd
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 07:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689678865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i2OD4smg/ZvktuylTs1UWQ6Kcn05ZJ4begnPzWgRGK4=;
 b=KP/8d5dTAsH1zwu7+4hxssbp0uoXjC3w9YfBKM7YGwxXNz1NQncI6YFjq3OkdZnnC3D4EJ
 9o6uYl/mmeAkoliennDs7lSMf8Vkg7C/+54xYuJ5Lqx/7Sg9QtyfYw2KWg+WZMfpb4ecrp
 +cBYOz0yUfe0FQEFCSj+Xio7RyjYNFo=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-Uhqf_xZxO7SMb70xkQYFgw-1; Tue, 18 Jul 2023 07:14:18 -0400
X-MC-Unique: Uhqf_xZxO7SMb70xkQYFgw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7CD0738060ED;
 Tue, 18 Jul 2023 11:14:18 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.39.193.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C6ED40C6CCD;
 Tue, 18 Jul 2023 11:14:17 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH for-8.2 1/2] arm/kvm: convert to kvm_set_one_reg
Date: Tue, 18 Jul 2023 13:14:03 +0200
Message-ID: <20230718111404.23479-2-cohuck@redhat.com>
In-Reply-To: <20230718111404.23479-1-cohuck@redhat.com>
References: <20230718111404.23479-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

We can neaten the code by switching to the kvm_set_one_reg function.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/arm/kvm.c   | 13 +++------
 target/arm/kvm64.c | 66 +++++++++++++---------------------------------
 2 files changed, 21 insertions(+), 58 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b4c7654f4980..cdbffc3c6e0d 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -561,7 +561,6 @@ bool write_list_to_kvmstate(ARMCPU *cpu, int level)
     bool ok = true;
 
     for (i = 0; i < cpu->cpreg_array_len; i++) {
-        struct kvm_one_reg r;
         uint64_t regidx = cpu->cpreg_indexes[i];
         uint32_t v32;
         int ret;
@@ -570,19 +569,17 @@ bool write_list_to_kvmstate(ARMCPU *cpu, int level)
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
@@ -703,17 +700,13 @@ void kvm_arm_get_virtual_time(CPUState *cs)
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
index 94bbd9661fd3..b4d02dff5381 100644
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
@@ -725,19 +721,17 @@ static void kvm_inject_arm_sea(CPUState *c)
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
+                                                        &fp_val);
 #else
-        reg.addr = (uintptr_t)q;
+        ret = kvm_set_one_reg(cs, AARCH64_SIMD_CORE_REG(fp_regs.vregs[i]), &q);
 #endif
-        reg.id = AARCH64_SIMD_CORE_REG(fp_regs.vregs[i]);
-        ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
         if (ret) {
             return ret;
         }
@@ -758,14 +752,11 @@ static int kvm_arch_put_sve(CPUState *cs)
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
@@ -774,9 +765,7 @@ static int kvm_arch_put_sve(CPUState *cs)
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
@@ -784,9 +773,7 @@ static int kvm_arch_put_sve(CPUState *cs)
 
     r = sve_bswap64(tmp, &env->vfp.pregs[FFR_PRED_NUM].p[0],
                     DIV_ROUND_UP(cpu->sve_max_vq * 2, 8));
-    reg.addr = (uintptr_t)r;
-    reg.id = KVM_REG_ARM64_SVE_FFR(0);
-    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+    ret = kvm_set_one_reg(cs, KVM_REG_ARM64_SVE_FFR(0), r);
     if (ret) {
         return ret;
     }
@@ -796,7 +783,6 @@ static int kvm_arch_put_sve(CPUState *cs)
 
 int kvm_arch_put_registers(CPUState *cs, int level)
 {
-    struct kvm_one_reg reg;
     uint64_t val;
     uint32_t fpr;
     int i, ret;
@@ -813,9 +799,8 @@ int kvm_arch_put_registers(CPUState *cs, int level)
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
@@ -826,16 +811,12 @@ int kvm_arch_put_registers(CPUState *cs, int level)
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
@@ -846,23 +827,17 @@ int kvm_arch_put_registers(CPUState *cs, int level)
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
@@ -881,9 +856,8 @@ int kvm_arch_put_registers(CPUState *cs, int level)
 
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
@@ -898,18 +872,14 @@ int kvm_arch_put_registers(CPUState *cs, int level)
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
2.41.0


