Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E622582AD73
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:31:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNtFY-0007nk-6v; Thu, 11 Jan 2024 06:29:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rNtFK-0007le-C4
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:29:14 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rNtFD-0006rF-Vn
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:29:13 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bx3+v_0J9lkz8EAA--.12623S3;
 Thu, 11 Jan 2024 19:29:03 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bx34f80J9l6+4PAA--.41647S6; 
 Thu, 11 Jan 2024 19:29:02 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: 
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 Tianrui Zhao <zhaotianrui@loongson.cn>,
 xianglai li <lixianglai@loongson.cn>
Subject: [PULL  04/14] target/loongarch: Implement kvm get/set registers
Date: Thu, 11 Jan 2024 19:15:59 +0800
Message-Id: <20240111111609.899183-5-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240111111609.899183-1-gaosong@loongson.cn>
References: <20240111111609.899183-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx34f80J9l6+4PAA--.41647S6
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

From: Tianrui Zhao <zhaotianrui@loongson.cn>

Implement kvm_arch_get/set_registers interfaces, many regs
can be get/set in the function, such as core regs, csr regs,
fpu regs, mp state, etc.

Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
Signed-off-by: xianglai li <lixianglai@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Change-Id: Ia8fc48fe08b1768853f7729e77d37cdf270031e4
Message-Id: <20240105075804.1228596-5-zhaotianrui@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 meson.build                   |   1 +
 target/loongarch/cpu.c        |   3 +
 target/loongarch/cpu.h        |   1 +
 target/loongarch/internals.h  |   5 +-
 target/loongarch/kvm/kvm.c    | 580 +++++++++++++++++++++++++++++++++-
 target/loongarch/trace-events |  11 +
 target/loongarch/trace.h      |   1 +
 7 files changed, 599 insertions(+), 3 deletions(-)
 create mode 100644 target/loongarch/trace-events
 create mode 100644 target/loongarch/trace.h

diff --git a/meson.build b/meson.build
index 371edafae6..b0dd87b8f8 100644
--- a/meson.build
+++ b/meson.build
@@ -3329,6 +3329,7 @@ if have_system or have_user
     'target/hppa',
     'target/i386',
     'target/i386/kvm',
+    'target/loongarch',
     'target/mips/tcg',
     'target/nios2',
     'target/ppc',
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 9b768c9431..0c157bbd51 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -540,6 +540,9 @@ static void loongarch_cpu_reset_hold(Object *obj)
 #ifndef CONFIG_USER_ONLY
     env->pc = 0x1c000000;
     memset(env->tlb, 0, sizeof(env->tlb));
+    if (kvm_enabled()) {
+        kvm_arch_reset_vcpu(env);
+    }
 #endif
 
     restore_fp_status(env);
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 8022f44b44..a61c0405a2 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -360,6 +360,7 @@ typedef struct CPUArchState {
     MemoryRegion iocsr_mem;
     bool load_elf;
     uint64_t elf_address;
+    uint32_t mp_state;
     /* Store ipistate to access from this struct */
     DeviceState *ipistate;
 #endif
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index c492863cc5..0beb034748 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -31,8 +31,10 @@ void G_NORETURN do_raise_exception(CPULoongArchState *env,
 
 const char *loongarch_exception_name(int32_t exception);
 
+#ifdef CONFIG_TCG
 int ieee_ex_to_loongarch(int xcpt);
 void restore_fp_status(CPULoongArchState *env);
+#endif
 
 #ifndef CONFIG_USER_ONLY
 extern const VMStateDescription vmstate_loongarch_cpu;
@@ -44,12 +46,13 @@ uint64_t cpu_loongarch_get_constant_timer_counter(LoongArchCPU *cpu);
 uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu);
 void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
                                                uint64_t value);
-
+#ifdef CONFIG_TCG
 bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                             MMUAccessType access_type, int mmu_idx,
                             bool probe, uintptr_t retaddr);
 
 hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+#endif
 #endif /* !CONFIG_USER_ONLY */
 
 uint64_t read_fcc(CPULoongArchState *env);
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 0d67322fd9..e7c9ef830c 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -26,19 +26,595 @@
 #include "sysemu/runstate.h"
 #include "cpu-csr.h"
 #include "kvm_loongarch.h"
+#include "trace.h"
 
 static bool cap_has_mp_state;
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_LAST_INFO
 };
 
+static int kvm_loongarch_get_regs_core(CPUState *cs)
+{
+    int ret = 0;
+    int i;
+    struct kvm_regs regs;
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    CPULoongArchState *env = &cpu->env;
+
+    /* Get the current register set as KVM seems it */
+    ret = kvm_vcpu_ioctl(cs, KVM_GET_REGS, &regs);
+    if (ret < 0) {
+        trace_kvm_failed_get_regs_core(strerror(errno));
+        return ret;
+    }
+    /* gpr[0] value is always 0 */
+    env->gpr[0] = 0;
+    for (i = 1; i < 32; i++) {
+        env->gpr[i] = regs.gpr[i];
+    }
+
+    env->pc = regs.pc;
+    return ret;
+}
+
+static int kvm_loongarch_put_regs_core(CPUState *cs)
+{
+    int ret = 0;
+    int i;
+    struct kvm_regs regs;
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    CPULoongArchState *env = &cpu->env;
+
+    /* Set the registers based on QEMU's view of things */
+    for (i = 0; i < 32; i++) {
+        regs.gpr[i] = env->gpr[i];
+    }
+
+    regs.pc = env->pc;
+    ret = kvm_vcpu_ioctl(cs, KVM_SET_REGS, &regs);
+    if (ret < 0) {
+        trace_kvm_failed_put_regs_core(strerror(errno));
+    }
+
+    return ret;
+}
+
+static int kvm_loongarch_get_csr(CPUState *cs)
+{
+    int ret = 0;
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    CPULoongArchState *env = &cpu->env;
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_CRMD),
+                           &env->CSR_CRMD);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PRMD),
+                           &env->CSR_PRMD);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_EUEN),
+                           &env->CSR_EUEN);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MISC),
+                           &env->CSR_MISC);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_ECFG),
+                           &env->CSR_ECFG);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_ESTAT),
+                           &env->CSR_ESTAT);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_ERA),
+                           &env->CSR_ERA);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_BADV),
+                           &env->CSR_BADV);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_BADI),
+                           &env->CSR_BADI);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_EENTRY),
+                           &env->CSR_EENTRY);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBIDX),
+                           &env->CSR_TLBIDX);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBEHI),
+                           &env->CSR_TLBEHI);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBELO0),
+                           &env->CSR_TLBELO0);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBELO1),
+                           &env->CSR_TLBELO1);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_ASID),
+                           &env->CSR_ASID);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PGDL),
+                           &env->CSR_PGDL);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PGDH),
+                           &env->CSR_PGDH);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PGD),
+                           &env->CSR_PGD);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PWCL),
+                           &env->CSR_PWCL);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PWCH),
+                           &env->CSR_PWCH);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_STLBPS),
+                           &env->CSR_STLBPS);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_RVACFG),
+                           &env->CSR_RVACFG);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_CPUID),
+                           &env->CSR_CPUID);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PRCFG1),
+                           &env->CSR_PRCFG1);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PRCFG2),
+                           &env->CSR_PRCFG2);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PRCFG3),
+                           &env->CSR_PRCFG3);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(0)),
+                           &env->CSR_SAVE[0]);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(1)),
+                           &env->CSR_SAVE[1]);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(2)),
+                           &env->CSR_SAVE[2]);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(3)),
+                           &env->CSR_SAVE[3]);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(4)),
+                           &env->CSR_SAVE[4]);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(5)),
+                           &env->CSR_SAVE[5]);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(6)),
+                           &env->CSR_SAVE[6]);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(7)),
+                           &env->CSR_SAVE[7]);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TID),
+                           &env->CSR_TID);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_CNTC),
+                           &env->CSR_CNTC);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TICLR),
+                           &env->CSR_TICLR);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_LLBCTL),
+                           &env->CSR_LLBCTL);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_IMPCTL1),
+                           &env->CSR_IMPCTL1);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_IMPCTL2),
+                           &env->CSR_IMPCTL2);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRENTRY),
+                           &env->CSR_TLBRENTRY);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRBADV),
+                           &env->CSR_TLBRBADV);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRERA),
+                           &env->CSR_TLBRERA);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRSAVE),
+                           &env->CSR_TLBRSAVE);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRELO0),
+                           &env->CSR_TLBRELO0);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRELO1),
+                           &env->CSR_TLBRELO1);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBREHI),
+                           &env->CSR_TLBREHI);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRPRMD),
+                           &env->CSR_TLBRPRMD);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_DMW(0)),
+                           &env->CSR_DMW[0]);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_DMW(1)),
+                           &env->CSR_DMW[1]);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_DMW(2)),
+                           &env->CSR_DMW[2]);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_DMW(3)),
+                           &env->CSR_DMW[3]);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TVAL),
+                           &env->CSR_TVAL);
+
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TCFG),
+                           &env->CSR_TCFG);
+
+    return ret;
+}
+
+static int kvm_loongarch_put_csr(CPUState *cs)
+{
+    int ret = 0;
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    CPULoongArchState *env = &cpu->env;
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_CRMD),
+                           &env->CSR_CRMD);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PRMD),
+                           &env->CSR_PRMD);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_EUEN),
+                           &env->CSR_EUEN);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MISC),
+                           &env->CSR_MISC);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_ECFG),
+                           &env->CSR_ECFG);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_ESTAT),
+                           &env->CSR_ESTAT);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_ERA),
+                           &env->CSR_ERA);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_BADV),
+                           &env->CSR_BADV);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_BADI),
+                           &env->CSR_BADI);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_EENTRY),
+                           &env->CSR_EENTRY);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBIDX),
+                           &env->CSR_TLBIDX);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBEHI),
+                           &env->CSR_TLBEHI);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBELO0),
+                           &env->CSR_TLBELO0);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBELO1),
+                           &env->CSR_TLBELO1);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_ASID),
+                           &env->CSR_ASID);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PGDL),
+                           &env->CSR_PGDL);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PGDH),
+                           &env->CSR_PGDH);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PGD),
+                           &env->CSR_PGD);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PWCL),
+                           &env->CSR_PWCL);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PWCH),
+                           &env->CSR_PWCH);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_STLBPS),
+                           &env->CSR_STLBPS);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_RVACFG),
+                           &env->CSR_RVACFG);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_CPUID),
+                           &env->CSR_CPUID);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PRCFG1),
+                           &env->CSR_PRCFG1);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PRCFG2),
+                           &env->CSR_PRCFG2);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PRCFG3),
+                           &env->CSR_PRCFG3);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(0)),
+                           &env->CSR_SAVE[0]);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(1)),
+                           &env->CSR_SAVE[1]);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(2)),
+                           &env->CSR_SAVE[2]);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(3)),
+                           &env->CSR_SAVE[3]);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(4)),
+                           &env->CSR_SAVE[4]);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(5)),
+                           &env->CSR_SAVE[5]);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(6)),
+                           &env->CSR_SAVE[6]);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_SAVE(7)),
+                           &env->CSR_SAVE[7]);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TID),
+                           &env->CSR_TID);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_CNTC),
+                           &env->CSR_CNTC);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TICLR),
+                           &env->CSR_TICLR);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_LLBCTL),
+                           &env->CSR_LLBCTL);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_IMPCTL1),
+                           &env->CSR_IMPCTL1);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_IMPCTL2),
+                           &env->CSR_IMPCTL2);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRENTRY),
+                           &env->CSR_TLBRENTRY);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRBADV),
+                           &env->CSR_TLBRBADV);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRERA),
+                           &env->CSR_TLBRERA);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRSAVE),
+                           &env->CSR_TLBRSAVE);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRELO0),
+                           &env->CSR_TLBRELO0);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRELO1),
+                           &env->CSR_TLBRELO1);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBREHI),
+                           &env->CSR_TLBREHI);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TLBRPRMD),
+                           &env->CSR_TLBRPRMD);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_DMW(0)),
+                           &env->CSR_DMW[0]);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_DMW(1)),
+                           &env->CSR_DMW[1]);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_DMW(2)),
+                           &env->CSR_DMW[2]);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_DMW(3)),
+                           &env->CSR_DMW[3]);
+    /*
+     * timer cfg must be put at last since it is used to enable
+     * guest timer
+     */
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TVAL),
+                           &env->CSR_TVAL);
+
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TCFG),
+                           &env->CSR_TCFG);
+    return ret;
+}
+
+static int kvm_loongarch_get_regs_fp(CPUState *cs)
+{
+    int ret, i;
+    struct kvm_fpu fpu;
+
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    CPULoongArchState *env = &cpu->env;
+
+    ret = kvm_vcpu_ioctl(cs, KVM_GET_FPU, &fpu);
+    if (ret < 0) {
+        trace_kvm_failed_get_fpu(strerror(errno));
+        return ret;
+    }
+
+    env->fcsr0 = fpu.fcsr;
+    for (i = 0; i < 32; i++) {
+        env->fpr[i].vreg.UD[0] = fpu.fpr[i].val64[0];
+    }
+    for (i = 0; i < 8; i++) {
+        env->cf[i] = fpu.fcc & 0xFF;
+        fpu.fcc = fpu.fcc >> 8;
+    }
+
+    return ret;
+}
+
+static int kvm_loongarch_put_regs_fp(CPUState *cs)
+{
+    int ret, i;
+    struct kvm_fpu fpu;
+
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    CPULoongArchState *env = &cpu->env;
+
+    fpu.fcsr = env->fcsr0;
+    fpu.fcc = 0;
+    for (i = 0; i < 32; i++) {
+        fpu.fpr[i].val64[0] = env->fpr[i].vreg.UD[0];
+    }
+
+    for (i = 0; i < 8; i++) {
+        fpu.fcc |= env->cf[i] << (8 * i);
+    }
+
+    ret = kvm_vcpu_ioctl(cs, KVM_SET_FPU, &fpu);
+    if (ret < 0) {
+        trace_kvm_failed_put_fpu(strerror(errno));
+    }
+
+    return ret;
+}
+
+void kvm_arch_reset_vcpu(CPULoongArchState *env)
+{
+    env->mp_state = KVM_MP_STATE_RUNNABLE;
+}
+
+static int kvm_loongarch_get_mpstate(CPUState *cs)
+{
+    int ret = 0;
+    struct kvm_mp_state mp_state;
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    CPULoongArchState *env = &cpu->env;
+
+    if (cap_has_mp_state) {
+        ret = kvm_vcpu_ioctl(cs, KVM_GET_MP_STATE, &mp_state);
+        if (ret) {
+            trace_kvm_failed_get_mpstate(strerror(errno));
+            return ret;
+        }
+        env->mp_state = mp_state.mp_state;
+    }
+
+    return ret;
+}
+
+static int kvm_loongarch_put_mpstate(CPUState *cs)
+{
+    int ret = 0;
+
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    CPULoongArchState *env = &cpu->env;
+
+    struct kvm_mp_state mp_state = {
+        .mp_state = env->mp_state
+    };
+
+    if (cap_has_mp_state) {
+        ret = kvm_vcpu_ioctl(cs, KVM_SET_MP_STATE, &mp_state);
+        if (ret) {
+            trace_kvm_failed_put_mpstate(strerror(errno));
+        }
+    }
+
+    return ret;
+}
+
+static int kvm_loongarch_get_cpucfg(CPUState *cs)
+{
+    int i, ret = 0;
+    uint64_t val;
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    CPULoongArchState *env = &cpu->env;
+
+    for (i = 0; i < 21; i++) {
+        ret = kvm_get_one_reg(cs, KVM_IOC_CPUCFG(i), &val);
+        if (ret < 0) {
+            trace_kvm_failed_get_cpucfg(strerror(errno));
+        }
+        env->cpucfg[i] = (uint32_t)val;
+    }
+    return ret;
+}
+
+static int kvm_loongarch_put_cpucfg(CPUState *cs)
+{
+    int i, ret = 0;
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    CPULoongArchState *env = &cpu->env;
+    uint64_t val;
+
+    for (i = 0; i < 21; i++) {
+        val = env->cpucfg[i];
+        /* LSX and LASX and LBT are not supported in kvm now */
+        if (i == 2) {
+            val &= ~(BIT(R_CPUCFG2_LSX_SHIFT) | BIT(R_CPUCFG2_LASX_SHIFT));
+            val &= ~(BIT(R_CPUCFG2_LBT_X86_SHIFT) |
+                     BIT(R_CPUCFG2_LBT_ARM_SHIFT) |
+                     BIT(R_CPUCFG2_LBT_MIPS_SHIFT));
+        }
+        ret = kvm_set_one_reg(cs, KVM_IOC_CPUCFG(i), &val);
+        if (ret < 0) {
+            trace_kvm_failed_put_cpucfg(strerror(errno));
+        }
+    }
+    return ret;
+}
+
 int kvm_arch_get_registers(CPUState *cs)
 {
-    return 0;
+    int ret;
+
+    ret = kvm_loongarch_get_regs_core(cs);
+    if (ret) {
+        return ret;
+    }
+
+    ret = kvm_loongarch_get_csr(cs);
+    if (ret) {
+        return ret;
+    }
+
+    ret = kvm_loongarch_get_regs_fp(cs);
+    if (ret) {
+        return ret;
+    }
+
+    ret = kvm_loongarch_get_mpstate(cs);
+    if (ret) {
+        return ret;
+    }
+
+    ret = kvm_loongarch_get_cpucfg(cs);
+    return ret;
 }
+
 int kvm_arch_put_registers(CPUState *cs, int level)
 {
-    return 0;
+    int ret;
+
+    ret = kvm_loongarch_put_regs_core(cs);
+    if (ret) {
+        return ret;
+    }
+
+    ret = kvm_loongarch_put_csr(cs);
+    if (ret) {
+        return ret;
+    }
+
+    ret = kvm_loongarch_put_regs_fp(cs);
+    if (ret) {
+        return ret;
+    }
+
+    ret = kvm_loongarch_put_mpstate(cs);
+    if (ret) {
+        return ret;
+    }
+
+    ret = kvm_loongarch_put_cpucfg(cs);
+    return ret;
 }
 
 int kvm_arch_init_vcpu(CPUState *cs)
diff --git a/target/loongarch/trace-events b/target/loongarch/trace-events
new file mode 100644
index 0000000000..6827ab566a
--- /dev/null
+++ b/target/loongarch/trace-events
@@ -0,0 +1,11 @@
+# See docs/devel/tracing.rst for syntax documentation.
+
+#kvm.c
+kvm_failed_get_regs_core(const char *msg) "Failed to get core regs from KVM: %s"
+kvm_failed_put_regs_core(const char *msg) "Failed to put core regs into KVM: %s"
+kvm_failed_get_fpu(const char *msg) "Failed to get fpu from KVM: %s"
+kvm_failed_put_fpu(const char *msg) "Failed to put fpu into KVM: %s"
+kvm_failed_get_mpstate(const char *msg) "Failed to get mp_state from KVM: %s"
+kvm_failed_put_mpstate(const char *msg) "Failed to put mp_state into KVM: %s"
+kvm_failed_get_cpucfg(const char *msg) "Failed to get cpucfg from KVM: %s"
+kvm_failed_put_cpucfg(const char *msg) "Failed to put cpucfg into KVM: %s"
diff --git a/target/loongarch/trace.h b/target/loongarch/trace.h
new file mode 100644
index 0000000000..c2ecb78f08
--- /dev/null
+++ b/target/loongarch/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-target_loongarch.h"
-- 
2.25.1


