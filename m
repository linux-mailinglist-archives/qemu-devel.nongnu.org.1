Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FD28D459F
	for <lists+qemu-devel@lfdr.de>; Thu, 30 May 2024 08:50:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCZbo-0007RE-Ix; Thu, 30 May 2024 02:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sCZbm-0007Qj-5j
 for qemu-devel@nongnu.org; Thu, 30 May 2024 02:49:54 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sCZbj-0000ib-Va
 for qemu-devel@nongnu.org; Thu, 30 May 2024 02:49:53 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxOuqLIVhme4gBAA--.6376S3;
 Thu, 30 May 2024 14:49:47 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bx28aFIVhm5+8NAA--.36650S4; 
 Thu, 30 May 2024 14:49:45 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: [RFC v3 2/2] target/loongarch: Implement lbt registers save/restore
 function
Date: Thu, 30 May 2024 14:49:41 +0800
Message-Id: <20240530064941.1289573-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240530064941.1289573-1-maobibo@loongson.cn>
References: <20240530064941.1289573-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx28aFIVhm5+8NAA--.36650S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Six registers scr0 - scr3, eflags and ftop are added in percpu vmstate.
And two functions kvm_loongarch_get_lbt/kvm_loongarch_put_lbt are added
to save/restore lbt registers.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.h     | 12 +++++++++
 target/loongarch/kvm/kvm.c | 52 ++++++++++++++++++++++++++++++++++++++
 target/loongarch/machine.c | 24 ++++++++++++++++++
 3 files changed, 88 insertions(+)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 623b96b184..93c97d5e23 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -285,6 +285,17 @@ enum loongarch_features {
     LOONGARCH_FEATURE_LBT, /* loongson binary translation extension */
 };
 
+typedef struct  LoongArchBT {
+    /* scratch registers */
+    uint64_t scr0;
+    uint64_t scr1;
+    uint64_t scr2;
+    uint64_t scr3;
+    /* loongarch eflags */
+    uint64_t eflags;
+    uint64_t ftop;
+} lbt_t;
+
 typedef struct CPUArchState {
     uint64_t gpr[32];
     uint64_t pc;
@@ -292,6 +303,7 @@ typedef struct CPUArchState {
     fpr_t fpr[32];
     bool cf[8];
     uint32_t fcsr0;
+    lbt_t  lbt;
 
     uint32_t cpucfg[21];
 
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 55e85eff15..c9c240a573 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -475,6 +475,48 @@ static int kvm_loongarch_put_regs_fp(CPUState *cs)
     return ret;
 }
 
+static int kvm_loongarch_put_lbt(CPUState *cs)
+{
+    CPULoongArchState *env = cpu_env(cs);
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
+    ret |= kvm_set_one_reg(cs, KVM_REG_LOONGARCH_LBT_EFLAGS, &env->lbt.eflags);
+    ret |= kvm_set_one_reg(cs, KVM_REG_LOONGARCH_LBT_FTOP, &env->lbt.ftop);
+
+    return ret;
+}
+
+static int kvm_loongarch_get_lbt(CPUState *cs)
+{
+    CPULoongArchState *env = cpu_env(cs);
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
+    ret |= kvm_get_one_reg(cs, KVM_REG_LOONGARCH_LBT_EFLAGS, &env->lbt.eflags);
+    ret |= kvm_get_one_reg(cs, KVM_REG_LOONGARCH_LBT_FTOP, &env->lbt.ftop);
+
+    return ret;
+}
+
 void kvm_arch_reset_vcpu(CPULoongArchState *env)
 {
     env->mp_state = KVM_MP_STATE_RUNNABLE;
@@ -608,6 +650,11 @@ int kvm_arch_get_registers(CPUState *cs)
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
@@ -636,6 +683,11 @@ int kvm_arch_put_registers(CPUState *cs, int level)
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
index 08a7fa5370..a371d5a2ab 100644
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
+        VMSTATE_UINT64(env.lbt.eflags, LoongArchCPU),
+        VMSTATE_UINT64(env.lbt.ftop,   LoongArchCPU),
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
2.39.3


