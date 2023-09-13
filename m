Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 818C679E351
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 11:15:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgLx1-00041T-3t; Wed, 13 Sep 2023 05:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <18622748025@163.com>)
 id 1qgLwy-00041I-P7
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:14:21 -0400
Received: from m12.mail.163.com ([220.181.12.217])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <18622748025@163.com>) id 1qgLwu-0005OM-4r
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=YjjFF
 UF4Ty0sj0nLnqI2sWfp3L3j/8ptH7XkZeuY1gs=; b=qXLPuEk5QVl1IOeaCds7Y
 VxiRh9dBAeMxPX2EgYkLT025SBtyUIVfnRRsfhomeo45ThZoOAamBb+MS4UekvXX
 UTQ6kFp4lU+EMHT8QJ9EOdVZNN95whZrSZDV0m3WLpGjhExWrn26ThwQ5uzUHQ4T
 gSremOaE3I9VflYlSmsumE=
Received: from localhost.localdomain (unknown [218.69.55.90])
 by zwqz-smtp-mta-g4-2 (Coremail) with SMTP id _____wCntfZYfQFldvvTBw--.48069S2;
 Wed, 13 Sep 2023 17:14:01 +0800 (CST)
From: "liguang.zhang" <18622748025@163.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	"liguang.zhang" <liguang.zhang@hexintek.com>
Subject: [PATCH v4] target/riscv: Clearing the CSR values at reset and syncing
 the MPSTATE with the host
Date: Wed, 13 Sep 2023 17:13:21 +0800
Message-ID: <20230913091332.17355-1-18622748025@163.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230913083728.16935-1-18622748025@163.com>
References: <20230913083728.16935-1-18622748025@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCntfZYfQFldvvTBw--.48069S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw1rWF1ktr13XF1rCw18AFb_yoW5Zr1rpr
 s5C39xCrs7tryxJw1fJFyDJF1rC3yIgrsxAr12krW2ka15JrW5ur4vg3y7trs5Gry8CFWa
 9F43uF43Ca1UtFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j9dbUUUUUU=
X-Originating-IP: [218.69.55.90]
X-CM-SenderInfo: bpryljasxumiisv6il2tof0z/1tbiVxvpWVetsUEM4QAAsb
Received-SPF: pass client-ip=220.181.12.217; envelope-from=18622748025@163.com;
 helo=m12.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FROM_LOCAL_DIGITS=0.001,
 FROM_LOCAL_HEX=0.006, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_BL=0.001,
 RCVD_IN_MSPIKE_L4=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

v4 update:
rebase on riscv-to-apply

Signed-off-by: liguang.zhang <liguang.zhang@hexintek.com>
---
 target/riscv/kvm.c       | 42 ++++++++++++++++++++++++++++++++++++++++
 target/riscv/kvm_riscv.h |  1 +
 2 files changed, 43 insertions(+)

diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index c01cfb03f4..8ee410b9b1 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -51,6 +51,8 @@ void riscv_kvm_aplic_request(void *opaque, int irq, int level)
     kvm_set_irq(kvm_state, irq, !!level);
 }
 
+static bool cap_has_mp_state;
+
 static uint64_t kvm_riscv_reg_id(CPURISCVState *env, uint64_t type,
                                  uint64_t idx)
 {
@@ -797,6 +799,24 @@ int kvm_arch_get_registers(CPUState *cs)
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
@@ -816,6 +836,18 @@ int kvm_arch_put_registers(CPUState *cs, int level)
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
 
@@ -928,6 +960,7 @@ int kvm_arch_get_default_type(MachineState *ms)
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
+    cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
     return 0;
 }
 
@@ -1014,10 +1047,19 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
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
index de8c209ebc..8f8c1f969a 100644
--- a/target/riscv/kvm_riscv.h
+++ b/target/riscv/kvm_riscv.h
@@ -27,5 +27,6 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
                           uint64_t aplic_base, uint64_t imsic_base,
                           uint64_t guest_num);
 void riscv_kvm_aplic_request(void *opaque, int irq, int level);
+int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state);
 
 #endif
-- 
2.41.0


