Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 131618D1557
	for <lists+qemu-devel@lfdr.de>; Tue, 28 May 2024 09:26:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBrDY-0007mE-1W; Tue, 28 May 2024 03:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <duchao@eswincomputing.com>)
 id 1sBrDT-0007kf-Fr; Tue, 28 May 2024 03:25:51 -0400
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net ([206.189.79.184])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <duchao@eswincomputing.com>)
 id 1sBrDN-0000UW-NM; Tue, 28 May 2024 03:25:51 -0400
Received: from localhost.localdomain (unknown [10.12.130.31])
 by app2 (Coremail) with SMTP id TQJkCgCHjLlhhlVmgzQNAA--.46423S5;
 Tue, 28 May 2024 15:23:20 +0800 (CST)
From: Chao Du <duchao@eswincomputing.com>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 ajones@ventanamicro.com, alistair23@gmail.com, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, anup@brainfault.org,
 duchao713@qq.com
Subject: [PATCH v2 1/3] target/riscv/kvm: add software breakpoints support
Date: Tue, 28 May 2024 07:20:46 +0000
Message-Id: <20240528072048.25529-2-duchao@eswincomputing.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240528072048.25529-1-duchao@eswincomputing.com>
References: <20240528072048.25529-1-duchao@eswincomputing.com>
X-CM-TRANSID: TQJkCgCHjLlhhlVmgzQNAA--.46423S5
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4xAr48Cw1ftrykWr18uFg_yoW5XF4DpF
 sxWrs5Jr4rJa43G34fJrsrAF13Zrs7u39rG34fZa4fGFy3Jr15urykKwsFyry5Ar10gr1a
 yrn0vFWfua4jq3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUP2b7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
 8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
 64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcV
 CY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv
 6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
 02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
 4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2
 xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0wL
 05UUUUU==
X-CM-SenderInfo: xgxfxt3r6h245lqf0zpsxwx03jof0z/
Received-SPF: pass client-ip=206.189.79.184;
 envelope-from=duchao@eswincomputing.com;
 helo=zg8tmja2lje4os43os4xodqa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This patch implements insert/remove software breakpoint process.

For RISC-V, GDB treats single-step similarly to breakpoint: add a
breakpoint at the next step address, then continue. So this also
works for single-step debugging.

Implement kvm_arch_update_guest_debug(): Set the control flag
when there are active breakpoints. This will help KVM to know
the status in the userspace.

Add some stubs which are necessary for building, and will be
implemented later.

Signed-off-by: Chao Du <duchao@eswincomputing.com>
---
 target/riscv/kvm/kvm-cpu.c | 69 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 235e2cdaca..c50f058aff 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1969,3 +1969,72 @@ static const TypeInfo riscv_kvm_cpu_type_infos[] = {
 };
 
 DEFINE_TYPES(riscv_kvm_cpu_type_infos)
+
+static const uint32_t ebreak_insn = 0x00100073;
+static const uint16_t c_ebreak_insn = 0x9002;
+
+int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
+{
+    if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 2, 0)) {
+        return -EINVAL;
+    }
+
+    if ((bp->saved_insn & 0x3) == 0x3) {
+        if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 4, 0)
+            || cpu_memory_rw_debug(cs, bp->pc, &ebreak_insn, 4, 1)) {
+            return -EINVAL;
+        }
+    } else {
+        if (cpu_memory_rw_debug(cs, bp->pc, &c_ebreak_insn, 2, 1)) {
+            return -EINVAL;
+        }
+    }
+
+    return 0;
+}
+
+int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
+{
+    uint32_t ebreak;
+    uint16_t c_ebreak;
+
+    if ((bp->saved_insn & 0x3) == 0x3) {
+        if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&ebreak, 4, 0) ||
+            ebreak != ebreak_insn ||
+            cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 4, 1)) {
+            return -EINVAL;
+        }
+    } else {
+        if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&c_ebreak, 2, 0) ||
+            c_ebreak != c_ebreak_insn ||
+            cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 2, 1)) {
+            return -EINVAL;
+        }
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
+    if (kvm_sw_breakpoints_active(cs)) {
+        dbg->control |= KVM_GUESTDBG_ENABLE;
+    }
+}
-- 
2.17.1


