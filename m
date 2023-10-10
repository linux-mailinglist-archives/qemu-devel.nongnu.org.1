Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3E47BFF24
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 16:25:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqDfp-000227-8T; Tue, 10 Oct 2023 10:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1qqDfb-0001xK-MW
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 10:25:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1qqDfW-0000E5-Ud
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 10:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696947905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2rhL/1dKBJ7I7XG88xbTal3/xTAn672281HftEnuaUA=;
 b=E1cXy6MH2NiOuJBB14Rmxuq1FPjKBB9MOBYoMwvAO8YT1K6vVnsE6RrYom9JwY/c1wYknp
 O/ZEJaNKb7cvghsKA1e7wSd5rWZyTPKAc6DRUkuSQRFxN7dkZB0DmDp86vHVKqqoQGBxmi
 5VHPgC753DS+fe+giyqZDtSrjayMzZg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-BdP-E0pTPfuoW1UX2CxwUA-1; Tue, 10 Oct 2023 10:25:00 -0400
X-MC-Unique: BdP-E0pTPfuoW1UX2CxwUA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A215F185A7B3;
 Tue, 10 Oct 2023 14:24:59 +0000 (UTC)
Received: from gondolin.str.redhat.com (dhcp-192-239.str.redhat.com
 [10.33.192.239])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B778521CAC6B;
 Tue, 10 Oct 2023 14:24:58 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v2 2/3] arm/kvm: convert to kvm_get_one_reg
Date: Tue, 10 Oct 2023 16:24:52 +0200
Message-ID: <20231010142453.224369-3-cohuck@redhat.com>
In-Reply-To: <20231010142453.224369-1-cohuck@redhat.com>
References: <20231010142453.224369-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We can neaten the code by switching the callers that work on a
CPUstate to the kvm_get_one_reg function.

Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/arm/kvm.c   | 15 +++---------
 target/arm/kvm64.c | 57 ++++++++++++----------------------------------
 2 files changed, 18 insertions(+), 54 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 1a8084c4601c..7903e2ddde1b 100644
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
index 047b269a7918..558c0b88dd69 100644
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
2.41.0


