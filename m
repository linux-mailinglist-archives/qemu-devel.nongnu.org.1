Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 665FF9B9DD9
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Nov 2024 09:07:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t799C-0007LI-GI; Sat, 02 Nov 2024 04:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1t7999-0007Jo-Lr
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 04:06:11 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1t7995-0001zT-Mg
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 04:06:11 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxmeFr3SVndH0nAA--.16444S3;
 Sat, 02 Nov 2024 16:06:03 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMAx7uBh3SVnzZA1AA--.18827S10;
 Sat, 02 Nov 2024 16:06:02 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PULL v2 8/8] target/loongarch: Add steal time support on migration
Date: Sat,  2 Nov 2024 15:47:37 +0800
Message-Id: <20241102074737.1394884-9-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20241102074737.1394884-1-gaosong@loongson.cn>
References: <20241102074737.1394884-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAx7uBh3SVnzZA1AA--.18827S10
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

With pv steal time supported, VM machine needs get physical address
of each vcpu and notify new host during migration. Here two
functions kvm_get_stealtime/kvm_set_stealtime, and guest steal time
physical address is only updated on KVM_PUT_FULL_STATE stage.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240930064040.753929-1-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.h     |  3 ++
 target/loongarch/kvm/kvm.c | 65 ++++++++++++++++++++++++++++++++++++++
 target/loongarch/machine.c |  6 ++--
 3 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 95be58dd66..86c86c6c95 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -364,6 +364,9 @@ typedef struct CPUArchState {
     uint64_t CSR_DBG;
     uint64_t CSR_DERA;
     uint64_t CSR_DSAVE;
+    struct {
+        uint64_t guest_addr;
+    } stealtime;
 
 #ifdef CONFIG_TCG
     float_status fp_status;
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 8bda8ae540..ff81806ca3 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -34,6 +34,55 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_LAST_INFO
 };
 
+static int kvm_get_stealtime(CPUState *cs)
+{
+    CPULoongArchState *env = cpu_env(cs);
+    int err;
+    struct kvm_device_attr attr = {
+        .group = KVM_LOONGARCH_VCPU_PVTIME_CTRL,
+        .attr = KVM_LOONGARCH_VCPU_PVTIME_GPA,
+        .addr = (uint64_t)&env->stealtime.guest_addr,
+    };
+
+    err = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, attr);
+    if (err) {
+        return 0;
+    }
+
+    err = kvm_vcpu_ioctl(cs, KVM_GET_DEVICE_ATTR, attr);
+    if (err) {
+        error_report("PVTIME: KVM_GET_DEVICE_ATTR: %s", strerror(errno));
+        return err;
+    }
+
+    return 0;
+}
+
+static int kvm_set_stealtime(CPUState *cs)
+{
+    CPULoongArchState *env = cpu_env(cs);
+    int err;
+    struct kvm_device_attr attr = {
+        .group = KVM_LOONGARCH_VCPU_PVTIME_CTRL,
+        .attr = KVM_LOONGARCH_VCPU_PVTIME_GPA,
+        .addr = (uint64_t)&env->stealtime.guest_addr,
+    };
+
+    err = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, attr);
+    if (err) {
+        return 0;
+    }
+
+    err = kvm_vcpu_ioctl(cs, KVM_SET_DEVICE_ATTR, attr);
+    if (err) {
+        error_report("PVTIME: KVM_SET_DEVICE_ATTR %s with gpa "TARGET_FMT_lx,
+                      strerror(errno), env->stealtime.guest_addr);
+        return err;
+    }
+
+    return 0;
+}
+
 static int kvm_loongarch_get_regs_core(CPUState *cs)
 {
     int ret = 0;
@@ -670,6 +719,11 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
         return ret;
     }
 
+    ret = kvm_get_stealtime(cs);
+    if (ret) {
+        return ret;
+    }
+
     ret = kvm_loongarch_get_mpstate(cs);
     return ret;
 }
@@ -703,6 +757,17 @@ int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
         return ret;
     }
 
+    if (level >= KVM_PUT_FULL_STATE) {
+        /*
+         * only KVM_PUT_FULL_STATE is required, kvm kernel will clear
+         * guest_addr for KVM_PUT_RESET_STATE
+         */
+        ret = kvm_set_stealtime(cs);
+        if (ret) {
+            return ret;
+        }
+    }
+
     ret = kvm_loongarch_put_mpstate(cs);
     return ret;
 }
diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
index 3d5c84ae9c..efb20e2fbe 100644
--- a/target/loongarch/machine.c
+++ b/target/loongarch/machine.c
@@ -168,8 +168,8 @@ static const VMStateDescription vmstate_tlb = {
 /* LoongArch CPU state */
 const VMStateDescription vmstate_loongarch_cpu = {
     .name = "cpu",
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .fields = (const VMStateField[]) {
         VMSTATE_UINTTL_ARRAY(env.gpr, LoongArchCPU, 32),
         VMSTATE_UINTTL(env.pc, LoongArchCPU),
@@ -232,6 +232,8 @@ const VMStateDescription vmstate_loongarch_cpu = {
         VMSTATE_UINT64(env.CSR_DSAVE, LoongArchCPU),
 
         VMSTATE_UINT64(kvm_state_counter, LoongArchCPU),
+        /* PV steal time */
+        VMSTATE_UINT64(env.stealtime.guest_addr, LoongArchCPU),
 
         VMSTATE_END_OF_LIST()
     },
-- 
2.34.1


