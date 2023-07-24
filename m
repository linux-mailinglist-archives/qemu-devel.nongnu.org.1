Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9245175EB7B
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 08:27:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNp1Z-0006gT-Px; Mon, 24 Jul 2023 02:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <18622748025@163.com>)
 id 1qNp1U-0006g8-Ua
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 02:26:25 -0400
Received: from m12.mail.163.com ([220.181.12.217])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <18622748025@163.com>) id 1qNp1O-0003V1-JK
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 02:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=4GeUT
 bBCm6yLgq9zV1m7CPaAt4GqJuMU0GSyxtUn+Jo=; b=VcApLPav+MQXGiq2hx5h0
 dIecrGvrAvvli3r1TmGskjfmJAYrPrEMoh9lHD5BIs4WUGvIflT2kgYV4oddtAD+
 JAwJwD1D/ugeM4nVmOWljd3BV2JpDErML5Rq+V1H+Ju+SGQ1lyUOH16t8uiKeNW0
 0wbwU78TwGhti2amQLrJUU=
Received: from localhost.localdomain (unknown [211.94.245.77])
 by zwqz-smtp-mta-g2-1 (Coremail) with SMTP id _____wCnHBp4Gb5k_xuwBA--.15858S2;
 Mon, 24 Jul 2023 14:26:01 +0800 (CST)
From: "liguang.zhang" <18622748025@163.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	"liguang.zhang" <liguang.zhang@hexintek.com>
Subject: [PATCH v3] target/riscv: Clearing the CSR values at reset and syncing
 the MPSTATE with the host
Date: Mon, 24 Jul 2023 14:25:19 +0800
Message-ID: <20230724062534.5634-1-18622748025@163.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <CAKmqyKMLU-D6C2BA5LjDjKg_t-xAh9kg+WgmfRxkxDbtujkBBw@mail.gmail.com>
References: <CAKmqyKMLU-D6C2BA5LjDjKg_t-xAh9kg+WgmfRxkxDbtujkBBw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCnHBp4Gb5k_xuwBA--.15858S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw1rWF1ktr4kArW8ZFyfXrb_yoW5Cr4kpF
 s5C39xCws7trWxJw1ftFWDJF1ru3yxWrsxA3y7CrWaya15JrW5Xws2g3y7tr95Gry0yFWa
 kF43uFy3Ca1UKFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j9eOLUUUUU=
X-Originating-IP: [211.94.245.77]
X-CM-SenderInfo: bpryljasxumiisv6il2tof0z/1tbiPQm2WWI0X2Os0QABsN
Received-SPF: pass client-ip=220.181.12.217; envelope-from=18622748025@163.com;
 helo=m12.mail.163.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FROM_LOCAL_DIGITS=0.001,
 FROM_LOCAL_HEX=0.006, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_BL=0.01,
 RCVD_IN_MSPIKE_L4=1.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: "liguang.zhang" <liguang.zhang@hexintek.com>

Fix the guest reboot error when using KVM
There are two issues when rebooting a guest using KVM
1. When the guest initiates a reboot the host is unable to stop the vcpu
2. When running a SMP guest the qemu monitor system_reset causes a vcpu crash

This can be fixed by clearing the CSR values at reset and syncing the
MPSTATE with the host.

Signed-off-by: liguang.zhang <liguang.zhang@hexintek.com>
---
 target/riscv/kvm.c       | 42 ++++++++++++++++++++++++++++++++++++++++
 target/riscv/kvm_riscv.h |  1 +
 2 files changed, 43 insertions(+)

diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 9d8a8982f9..ecc8ab8238 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -44,6 +44,8 @@
 #include "migration/migration.h"
 #include "sysemu/runstate.h"
 
+static bool cap_has_mp_state;
+
 static uint64_t kvm_riscv_reg_id(CPURISCVState *env, uint64_t type,
                                  uint64_t idx)
 {
@@ -790,6 +792,24 @@ int kvm_arch_get_registers(CPUState *cs)
     return ret;
 }
 
+int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state)
+{
+    if (cap_has_mp_state) {
+        struct kvm_mp_state mp_state = {
+            .mp_state = state
+        };
+
+        int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MP_STATE, &mp_state);
+        if (ret) {
+            fprintf(stderr, "%s: failed to sync MP_STATE %d/%s\n",
+                    __func__, ret, strerror(-ret));
+            return -1;
+        }
+    }
+
+    return 0;
+}
+
 int kvm_arch_put_registers(CPUState *cs, int level)
 {
     int ret = 0;
@@ -809,6 +829,18 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         return ret;
     }
 
+    if (KVM_PUT_RESET_STATE == level) {
+        RISCVCPU *cpu = RISCV_CPU(cs);
+        if (cs->cpu_index == 0) {
+            ret = kvm_riscv_sync_mpstate_to_kvm(cpu, KVM_MP_STATE_RUNNABLE);
+        } else {
+            ret = kvm_riscv_sync_mpstate_to_kvm(cpu, KVM_MP_STATE_STOPPED);
+        }
+        if (ret) {
+            return ret;
+        }
+    }
+
     return ret;
 }
 
@@ -909,6 +941,7 @@ int kvm_arch_add_msi_route_post(struct kvm_irq_routing_entry *route,
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
+    cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
     return 0;
 }
 
@@ -987,10 +1020,19 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
     if (!kvm_enabled()) {
         return;
     }
+    for (int i=0; i<32; i++)
+        env->gpr[i] = 0;
     env->pc = cpu->env.kernel_addr;
     env->gpr[10] = kvm_arch_vcpu_id(CPU(cpu)); /* a0 */
     env->gpr[11] = cpu->env.fdt_addr;          /* a1 */
     env->satp = 0;
+    env->mie = 0;
+    env->stvec = 0;
+    env->sscratch = 0;
+    env->sepc = 0;
+    env->scause = 0;
+    env->stval = 0;
+    env->mip = 0;
 }
 
 void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level)
diff --git a/target/riscv/kvm_riscv.h b/target/riscv/kvm_riscv.h
index e3ba935808..3ea68c38e3 100644
--- a/target/riscv/kvm_riscv.h
+++ b/target/riscv/kvm_riscv.h
@@ -22,5 +22,6 @@
 void kvm_riscv_init_user_properties(Object *cpu_obj);
 void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
 void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
+int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state);
 
 #endif
-- 
2.41.0


