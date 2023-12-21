Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7262081B2E6
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 10:52:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGFhl-0006OX-7g; Thu, 21 Dec 2023 04:51:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <duchao@eswincomputing.com>)
 id 1rGFhb-0006NK-RS; Thu, 21 Dec 2023 04:50:53 -0500
Received: from azure-sdnproxy.icoremail.net ([20.231.56.155])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <duchao@eswincomputing.com>)
 id 1rGFhY-0002WV-Ho; Thu, 21 Dec 2023 04:50:51 -0500
Received: from localhost.localdomain (unknown [10.12.130.31])
 by app1 (Coremail) with SMTP id TAJkCgAHk_0TCoRlUowCAA--.24821S5;
 Thu, 21 Dec 2023 17:49:09 +0800 (CST)
From: Chao Du <duchao@eswincomputing.com>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 alistair23@gmail.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 palmer@dabbelt.com, anup@brainfault.org, atishp@atishpatra.org
Subject: [RFC PATCH 1/4] target/riscv/kvm: add software breakpoints support
Date: Thu, 21 Dec 2023 09:49:20 +0000
Message-Id: <20231221094923.7349-2-duchao@eswincomputing.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231221094923.7349-1-duchao@eswincomputing.com>
References: <20231221094923.7349-1-duchao@eswincomputing.com>
X-CM-TRANSID: TAJkCgAHk_0TCoRlUowCAA--.24821S5
X-Coremail-Antispam: 1UD129KBjvJXoWxKF1UZr4fJF1kuw1DJw43Jrb_yoWfZr4rpF
 45ZrnYkr45J347G3s3Jw4qyF43Arsa9wsrC34Sq3yakFyqgrn8Xrn2krsFyrW5Cr1kWw1a
 yr1aqF1ru3Wqgr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUP2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
 8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
 64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcV
 CY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv
 6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
 02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
 4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2
 xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5Nj
 jDUUUUU==
X-CM-SenderInfo: xgxfxt3r6h245lqf0zpsxwx03jof0z/
Received-SPF: pass client-ip=20.231.56.155;
 envelope-from=duchao@eswincomputing.com; helo=azure-sdnproxy.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

This patch implements insert/remove software breakpoint process:

Add an input parameter for kvm_arch_insert_sw_breakpoint() and
kvm_arch_remove_sw_breakpoint() to pass the length information,
which helps us to know whether it is a compressed instruction.
For some remove cases, we do not have the length info, so we need
to judge by ourselves.

For RISC-V, GDB treats single-step similarly to breakpoint: add a
breakpoint at the next step address, then continue. So this also
works for single-step debugging.

Add some stubs which are necessary for building, and will be
implemented later.

Signed-off-by: Chao Du <duchao@eswincomputing.com>
---
 accel/kvm/kvm-all.c        |  8 ++--
 include/sysemu/kvm.h       |  6 ++-
 target/arm/kvm64.c         |  6 ++-
 target/i386/kvm/kvm.c      |  6 ++-
 target/mips/kvm.c          |  6 ++-
 target/ppc/kvm.c           |  6 ++-
 target/riscv/kvm/kvm-cpu.c | 79 ++++++++++++++++++++++++++++++++++++++
 target/s390x/kvm/kvm.c     |  6 ++-
 8 files changed, 107 insertions(+), 16 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index e39a810a4e..ccc505d0c2 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3231,7 +3231,7 @@ int kvm_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
         bp = g_new(struct kvm_sw_breakpoint, 1);
         bp->pc = addr;
         bp->use_count = 1;
-        err = kvm_arch_insert_sw_breakpoint(cpu, bp);
+        err = kvm_arch_insert_sw_breakpoint(cpu, bp, len);
         if (err) {
             g_free(bp);
             return err;
@@ -3270,7 +3270,7 @@ int kvm_remove_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
             return 0;
         }
 
-        err = kvm_arch_remove_sw_breakpoint(cpu, bp);
+        err = kvm_arch_remove_sw_breakpoint(cpu, bp, len);
         if (err) {
             return err;
         }
@@ -3300,10 +3300,10 @@ void kvm_remove_all_breakpoints(CPUState *cpu)
     CPUState *tmpcpu;
 
     QTAILQ_FOREACH_SAFE(bp, &s->kvm_sw_breakpoints, entry, next) {
-        if (kvm_arch_remove_sw_breakpoint(cpu, bp) != 0) {
+        if (kvm_arch_remove_sw_breakpoint(cpu, bp, 0) != 0) {
             /* Try harder to find a CPU that currently sees the breakpoint. */
             CPU_FOREACH(tmpcpu) {
-                if (kvm_arch_remove_sw_breakpoint(tmpcpu, bp) == 0) {
+                if (kvm_arch_remove_sw_breakpoint(tmpcpu, bp, 0) == 0) {
                     break;
                 }
             }
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index d614878164..ab38c23def 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -391,9 +391,11 @@ struct kvm_sw_breakpoint *kvm_find_sw_breakpoint(CPUState *cpu,
 int kvm_sw_breakpoints_active(CPUState *cpu);
 
 int kvm_arch_insert_sw_breakpoint(CPUState *cpu,
-                                  struct kvm_sw_breakpoint *bp);
+                                  struct kvm_sw_breakpoint *bp,
+                                  vaddr len);
 int kvm_arch_remove_sw_breakpoint(CPUState *cpu,
-                                  struct kvm_sw_breakpoint *bp);
+                                  struct kvm_sw_breakpoint *bp,
+                                  vaddr len);
 int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type);
 int kvm_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type);
 void kvm_arch_remove_all_hw_breakpoints(void);
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 3c175c93a7..023e92b577 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -1139,7 +1139,8 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
 /* C6.6.29 BRK instruction */
 static const uint32_t brk_insn = 0xd4200000;
 
-int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
+int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
+                                  vaddr len)
 {
     if (have_guest_debug) {
         if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 4, 0) ||
@@ -1153,7 +1154,8 @@ int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
     }
 }
 
-int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
+int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
+                                  vaddr len)
 {
     static uint32_t brk;
 
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 4ce80555b4..742b7c8296 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4935,7 +4935,8 @@ static int kvm_handle_tpr_access(X86CPU *cpu)
     return 1;
 }
 
-int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
+int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
+                                  vaddr len)
 {
     static const uint8_t int3 = 0xcc;
 
@@ -4946,7 +4947,8 @@ int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
     return 0;
 }
 
-int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
+int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
+                                  vaddr len)
 {
     uint8_t int3;
 
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index e22e24ed97..2f68938cdf 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -112,13 +112,15 @@ void kvm_mips_reset_vcpu(MIPSCPU *cpu)
     DPRINTF("%s\n", __func__);
 }
 
-int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
+int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
+                                  vaddr len)
 {
     DPRINTF("%s\n", __func__);
     return 0;
 }
 
-int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
+int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
+                                  vaddr len)
 {
     DPRINTF("%s\n", __func__);
     return 0;
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 9b1abe2fc4..a99c85b2f3 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1375,7 +1375,8 @@ static int kvmppc_handle_dcr_write(CPUPPCState *env,
     return 0;
 }
 
-int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
+int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
+                                  vaddr len)
 {
     /* Mixed endian case is not handled */
     uint32_t sc = debug_inst_opcode;
@@ -1389,7 +1390,8 @@ int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
     return 0;
 }
 
-int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
+int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
+                                  vaddr len)
 {
     uint32_t sc;
 
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 45b6cf1cfa..e9110006b0 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1521,3 +1521,82 @@ static const TypeInfo riscv_kvm_cpu_type_infos[] = {
 };
 
 DEFINE_TYPES(riscv_kvm_cpu_type_infos)
+
+static const uint32_t ebreak_insn = 0x00100073;
+static const uint16_t c_ebreak_insn = 0x9002;
+
+int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
+                                  vaddr len)
+{
+    if (len != 4 && len != 2) {
+        return -EINVAL;
+    }
+
+    uint8_t * insn = (len == 4) ? (uint8_t *)&ebreak_insn :
+                                  (uint8_t *)&c_ebreak_insn;
+
+    if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, len, 0) ||
+        cpu_memory_rw_debug(cs, bp->pc, insn, len, 1)) {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
+                                  vaddr len)
+{
+    uint8_t length;
+
+    if (len == 4 || len == 2) {
+        length = (uint8_t)len;
+    } else if (len == 0) {
+        /* Need to decide the instruction length in this case. */
+        uint32_t read_4_bytes;
+        uint16_t read_2_bytes;
+
+        if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&read_4_bytes, 4, 0) ||
+            cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&read_2_bytes, 2, 0)) {
+            return -EINVAL;
+        }
+
+        if (read_4_bytes == ebreak_insn) {
+            length = 4;
+        } else if (read_2_bytes == c_ebreak_insn) {
+            length = 2;
+        } else {
+            return -EINVAL;
+        }
+    } else {
+        return -EINVAL;
+    }
+
+    if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn,
+                            length, 1)) {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
+{
+    /* TODO; To be implemented later. */
+    return -EINVAL;
+}
+
+int kvm_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type)
+{
+    /* TODO; To be implemented later. */
+    return -EINVAL;
+}
+
+void kvm_arch_remove_all_hw_breakpoints(void)
+{
+    /* TODO; To be implemented later. */
+}
+
+void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *dbg)
+{
+    /* TODO; To be implemented later. */
+}
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 33ab3551f4..fafacedd6a 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -867,7 +867,8 @@ static void determine_sw_breakpoint_instr(void)
         }
 }
 
-int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
+int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
+                                  vaddr len)
 {
     determine_sw_breakpoint_instr();
 
@@ -879,7 +880,8 @@ int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
     return 0;
 }
 
-int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
+int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
+                                  vaddr len)
 {
     uint8_t t[MAX_ILEN];
 
-- 
2.17.1


