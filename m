Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE759B9DDB
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Nov 2024 09:07:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7999-0007Iz-JG; Sat, 02 Nov 2024 04:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1t7997-0007Id-1T
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 04:06:09 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1t7994-0001z2-3L
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 04:06:08 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Dxfa9o3SVnXn0nAA--.56367S3;
 Sat, 02 Nov 2024 16:06:00 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMAx7uBh3SVnzZA1AA--.18827S4;
 Sat, 02 Nov 2024 16:05:59 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PULL v2 2/8] target/loongarch: Implement lbt registers save/restore
 function
Date: Sat,  2 Nov 2024 15:47:31 +0800
Message-Id: <20241102074737.1394884-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20241102074737.1394884-1-gaosong@loongson.cn>
References: <20241102074737.1394884-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAx7uBh3SVnzZA1AA--.18827S4
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Bibo Mao <maobibo@loongson.cn>

Six registers scr0 - scr3, eflags and ftop are added in percpu vmstate.
And two functions kvm_loongarch_get_lbt/kvm_loongarch_put_lbt are added
to save/restore lbt registers.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240929070405.235200-3-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.h     | 12 ++++++++
 target/loongarch/kvm/kvm.c | 62 ++++++++++++++++++++++++++++++++++++++
 target/loongarch/machine.c | 24 +++++++++++++++
 3 files changed, 98 insertions(+)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 2b3f2758f6..136866b7b8 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -286,6 +286,17 @@ enum loongarch_features {
     LOONGARCH_FEATURE_LBT, /* loongson binary translation extension */
 };
 
+typedef struct  LoongArchBT {
+    /* scratch registers */
+    uint64_t scr0;
+    uint64_t scr1;
+    uint64_t scr2;
+    uint64_t scr3;
+    /* loongarch eflags */
+    uint32_t eflags;
+    uint32_t ftop;
+} lbt_t;
+
 typedef struct CPUArchState {
     uint64_t gpr[32];
     uint64_t pc;
@@ -293,6 +304,7 @@ typedef struct CPUArchState {
     fpr_t fpr[32];
     bool cf[8];
     uint32_t fcsr0;
+    lbt_t  lbt;
 
     uint32_t cpucfg[21];
 
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 079f8ca5d7..40115aff56 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -477,6 +477,58 @@ static int kvm_loongarch_put_regs_fp(CPUState *cs)
     return ret;
 }
 
+static int kvm_loongarch_put_lbt(CPUState *cs)
+{
+    CPULoongArchState *env = cpu_env(cs);
+    uint64_t val;
+    int ret;
+
+    /* check whether vm support LBT firstly */
+    if (FIELD_EX32(env->cpucfg[2], CPUCFG2, LBT_ALL) != 7) {
+        return 0;
+    }
+
+    /* set six LBT registers including scr0-scr3, eflags, ftop */
+    ret = kvm_set_one_reg(cs, KVM_REG_LOONGARCH_LBT_SCR0, &env->lbt.scr0);
+    ret |= kvm_set_one_reg(cs, KVM_REG_LOONGARCH_LBT_SCR1, &env->lbt.scr1);
+    ret |= kvm_set_one_reg(cs, KVM_REG_LOONGARCH_LBT_SCR2, &env->lbt.scr2);
+    ret |= kvm_set_one_reg(cs, KVM_REG_LOONGARCH_LBT_SCR3, &env->lbt.scr3);
+    /*
+     * Be cautious, KVM_REG_LOONGARCH_LBT_FTOP is defined as 64-bit however
+     * lbt.ftop is 32-bit; the same with KVM_REG_LOONGARCH_LBT_EFLAGS register
+     */
+    val = env->lbt.eflags;
+    ret |= kvm_set_one_reg(cs, KVM_REG_LOONGARCH_LBT_EFLAGS, &val);
+    val = env->lbt.ftop;
+    ret |= kvm_set_one_reg(cs, KVM_REG_LOONGARCH_LBT_FTOP, &val);
+
+    return ret;
+}
+
+static int kvm_loongarch_get_lbt(CPUState *cs)
+{
+    CPULoongArchState *env = cpu_env(cs);
+    uint64_t val;
+    int ret;
+
+    /* check whether vm support LBT firstly */
+    if (FIELD_EX32(env->cpucfg[2], CPUCFG2, LBT_ALL) != 7) {
+        return 0;
+    }
+
+    /* get six LBT registers including scr0-scr3, eflags, ftop */
+    ret = kvm_get_one_reg(cs, KVM_REG_LOONGARCH_LBT_SCR0, &env->lbt.scr0);
+    ret |= kvm_get_one_reg(cs, KVM_REG_LOONGARCH_LBT_SCR1, &env->lbt.scr1);
+    ret |= kvm_get_one_reg(cs, KVM_REG_LOONGARCH_LBT_SCR2, &env->lbt.scr2);
+    ret |= kvm_get_one_reg(cs, KVM_REG_LOONGARCH_LBT_SCR3, &env->lbt.scr3);
+    ret |= kvm_get_one_reg(cs, KVM_REG_LOONGARCH_LBT_EFLAGS, &val);
+    env->lbt.eflags = (uint32_t)val;
+    ret |= kvm_get_one_reg(cs, KVM_REG_LOONGARCH_LBT_FTOP, &val);
+    env->lbt.ftop = (uint32_t)val;
+
+    return ret;
+}
+
 void kvm_arch_reset_vcpu(CPUState *cs)
 {
     CPULoongArchState *env = cpu_env(cs);
@@ -613,6 +665,11 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
         return ret;
     }
 
+    ret = kvm_loongarch_get_lbt(cs);
+    if (ret) {
+        return ret;
+    }
+
     ret = kvm_loongarch_get_mpstate(cs);
     return ret;
 }
@@ -641,6 +698,11 @@ int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
         return ret;
     }
 
+    ret = kvm_loongarch_put_lbt(cs);
+    if (ret) {
+        return ret;
+    }
+
     ret = kvm_loongarch_put_mpstate(cs);
     return ret;
 }
diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
index 08a7fa5370..3d5c84ae9c 100644
--- a/target/loongarch/machine.c
+++ b/target/loongarch/machine.c
@@ -110,6 +110,29 @@ static const VMStateDescription vmstate_lasx = {
     },
 };
 
+static bool lbt_needed(void *opaque)
+{
+    LoongArchCPU *cpu = opaque;
+
+    return !!FIELD_EX64(cpu->env.cpucfg[2], CPUCFG2, LBT_ALL);
+}
+
+static const VMStateDescription vmstate_lbt = {
+    .name = "cpu/lbt",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .needed = lbt_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(env.lbt.scr0,   LoongArchCPU),
+        VMSTATE_UINT64(env.lbt.scr1,   LoongArchCPU),
+        VMSTATE_UINT64(env.lbt.scr2,   LoongArchCPU),
+        VMSTATE_UINT64(env.lbt.scr3,   LoongArchCPU),
+        VMSTATE_UINT32(env.lbt.eflags, LoongArchCPU),
+        VMSTATE_UINT32(env.lbt.ftop,   LoongArchCPU),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
 static bool tlb_needed(void *opaque)
 {
@@ -219,6 +242,7 @@ const VMStateDescription vmstate_loongarch_cpu = {
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
         &vmstate_tlb,
 #endif
+        &vmstate_lbt,
         NULL
     }
 };
-- 
2.34.1


