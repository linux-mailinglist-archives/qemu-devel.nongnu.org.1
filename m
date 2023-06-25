Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF39773CE23
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 04:50:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDFoI-0000pS-Kz; Sat, 24 Jun 2023 22:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <18622748025@163.com>)
 id 1qDFoD-0000ov-5b
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 22:49:01 -0400
Received: from m12.mail.163.com ([220.181.12.199])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <18622748025@163.com>) id 1qDFoA-0007zx-Eu
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 22:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=/oThOCj9SvEkYEE8Un
 EJeiAabcL3BWqNpZWHh263r6M=; b=BfFUPY4FbNSxq+G/2ev0qwKrNhsBwQwQ8Y
 jGIn/MCePQfdOGYreUtuK0XZchfdKgfDg4UYrSaiJDfubj2ekw4oLSahBd+gn4zr
 teUh5owcvjk6+OJHiXRx61KKc03dIkl6KRxOwWeBbwRyQitHklyQRNo1t3RNzDO/
 YED8KWPEc=
Received: from localhost.localdomain (unknown [103.3.97.171])
 by zwqz-smtp-mta-g0-3 (Coremail) with SMTP id _____wB3gwQOq5dkeY9gAw--.7417S2; 
 Sun, 25 Jun 2023 10:48:46 +0800 (CST)
From: "liguang.zhang" <18622748025@163.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, alistair23@gmail.com,
 "liguang.zhang" <liguang.zhang@hexintek.com>
Subject: [PATCH] target/riscv: fix the issue of guest reboot then no response
 or crash in kvm-mode
Date: Sun, 25 Jun 2023 10:48:41 +0800
Message-Id: <20230625024841.26708-1-18622748025@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wB3gwQOq5dkeY9gAw--.7417S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw17AF1xWr4fJrW3CFyfJFb_yoWruw13pF
 ZrCa9xCr48t3s7Jw1ftFyDXr1rW3yI9FsrArZrur4SyF45JrZ8J3WkK3y7Ar98GFyUuFWa
 kFW5GF13u3yDtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07beSoXUUUUU=
X-Originating-IP: [103.3.97.171]
X-CM-SenderInfo: bpryljasxumiisv6il2tof0z/1tbiPQ2ZWWI0XglHxwABsw
Received-SPF: pass client-ip=220.181.12.199; envelope-from=18622748025@163.com;
 helo=m12.mail.163.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FROM_LOCAL_DIGITS=0.001,
 FROM_LOCAL_HEX=0.006, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

There have a issue of guest reboot bug in kvm-mode:
1. in guest shell just run the reboot, guest can't reboot success, and host kvm stop the vcpu schedual.
2. for smp guest, ctrl+a+c switch to qemu command, use system_reset command to reset the guest, then vcpu crash

kernel log
```shell
$reboot

The system is going down NOW!
Sent SIGTERM to all processes
logout
Sent SIGKILL to all processes
Requesting system reboot

```
then no response

for qemu command:
$system_reset:

kernel log:
```shell
[   53.739556] kvm [150]: VCPU exit error -95
[   53.739563] kvm [148]: VCPU exit error -95
[   53.739557] kvm [149]: VCPU exit error -95
[   53.740957] kvm [149]: SEPC=0x0 SSTATUS=0x200004120 HSTATUS=0x2002001c0
[   53.740957] kvm [148]: SEPC=0x0 SSTATUS=0x200004120 HSTATUS=0x2002001c0
[   53.741054] kvm [148]: SCAUSE=0x14 STVAL=0x0 HTVAL=0x0 HTINST=0x0
[   53.741058] kvm [149]: SCAUSE=0x14 STVAL=0x0 HTVAL=0x0 HTINST=0x0
[   53.756187] kvm [150]: SEPC=0x0 SSTATUS=0x200004120 HSTATUS=0x2002001c0
[   53.757797] kvm [150]: SCAUSE=0x14 STVAL=0x0 HTVAL=0x0 HTINST=0x0
```

solution:

add reset csr and context for riscv vcpu
qemu ioctl reset vcpu->arch.power_off state of kvm

tests:

qemu-system-riscv64 -M virt -bios none -kernel Image \
   -smp 4 -enable-kvm \
   -append "rootwait root=/dev/vda ro" \
   -drive file=rootfs.ext2,format=raw,id=hd0 \
   -device virtio-blk-device,drive=hd0

in guest shell:
$reboot

qemu command:
$system_reset

---
v3:
- change kvm_riscv_set_mpstate_to_kvm to kvm_riscv_sync_mpstate_to_kvm
- remove newline after if(cap_has_mp_state)

Signed-off-by: liguang.zhang <liguang.zhang@hexintek.com>
---
 target/riscv/kvm.c       | 44 +++++++++++++++++++++++++++++++++++++++-
 target/riscv/kvm_riscv.h |  1 +
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 0f932a5b96..c478c71905 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -42,6 +42,8 @@
 #include "migration/migration.h"
 #include "sysemu/runstate.h"
 
+static bool cap_has_mp_state;
+
 static uint64_t kvm_riscv_reg_id(CPURISCVState *env, uint64_t type,
                                  uint64_t idx)
 {
@@ -99,7 +101,7 @@ static uint64_t kvm_riscv_reg_id(CPURISCVState *env, uint64_t type,
 
 #define KVM_RISCV_SET_TIMER(cs, env, name, reg) \
     do { \
-        int ret = kvm_set_one_reg(cs, RISCV_TIMER_REG(env, time), &reg); \
+        int ret = kvm_set_one_reg(cs, RISCV_TIMER_REG(env, name), &reg); \
         if (ret) { \
             abort(); \
         } \
@@ -335,6 +337,24 @@ int kvm_arch_get_registers(CPUState *cs)
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
@@ -354,6 +374,18 @@ int kvm_arch_put_registers(CPUState *cs, int level)
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
 
@@ -428,6 +460,7 @@ int kvm_arch_add_msi_route_post(struct kvm_irq_routing_entry *route,
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
+    cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
     return 0;
 }
 
@@ -506,10 +539,19 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
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
index ed281bdce0..88aee902dd 100644
--- a/target/riscv/kvm_riscv.h
+++ b/target/riscv/kvm_riscv.h
@@ -21,5 +21,6 @@
 
 void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
 void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
+int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state);
 
 #endif
-- 
2.17.1


