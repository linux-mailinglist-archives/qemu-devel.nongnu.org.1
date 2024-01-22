Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AC8835DF5
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 10:19:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRqRk-0002Yf-MN; Mon, 22 Jan 2024 04:18:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rRqRh-0002YJ-BC
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 04:18:21 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rRqRc-0004kV-Sf
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 04:18:20 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxbOnTMq5lF30DAA--.4101S3;
 Mon, 22 Jan 2024 17:18:11 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxRMzQMq5lmk4RAA--.5534S2; 
 Mon, 22 Jan 2024 17:18:08 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, philmd@linaro.org, maobibo@loongson.cn,
 zhaotianrui@loongson.cn
Subject: [PATCH v2] target/loongarch/kvm: Enable LSX/LASX extension
Date: Mon, 22 Jan 2024 17:02:06 +0800
Message-Id: <20240122090206.1083584-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxRMzQMq5lmk4RAA--.5534S2
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

The kernel had already support LSX and LASX [1],
but QEMU is disable LSX/LASX for kvm. This patch adds
kvm_check_cpucfg2() to check CPUCFG2.

[1]: https://lore.kernel.org/all/CABgObfZHRf7E_7Jk4uPRmSyxTy3EiuuYwHC35jQncNL9s-zTDA@mail.gmail.com/

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 linux-headers/asm-loongarch/kvm.h |  1 +
 target/loongarch/kvm/kvm.c        | 45 ++++++++++++++++++++++++++-----
 2 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/linux-headers/asm-loongarch/kvm.h b/linux-headers/asm-loongarch/kvm.h
index c6ad2ee610..923d0bd382 100644
--- a/linux-headers/asm-loongarch/kvm.h
+++ b/linux-headers/asm-loongarch/kvm.h
@@ -79,6 +79,7 @@ struct kvm_fpu {
 #define LOONGARCH_REG_64(TYPE, REG)	(TYPE | KVM_REG_SIZE_U64 | (REG << LOONGARCH_REG_SHIFT))
 #define KVM_IOC_CSRID(REG)		LOONGARCH_REG_64(KVM_REG_LOONGARCH_CSR, REG)
 #define KVM_IOC_CPUCFG(REG)		LOONGARCH_REG_64(KVM_REG_LOONGARCH_CPUCFG, REG)
+#define KVM_LOONGARCH_VCPU_CPUCFG	0
 
 struct kvm_debug_exit_arch {
 };
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 84bcdf5f86..2712bb7ab6 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -537,6 +537,38 @@ static int kvm_loongarch_get_cpucfg(CPUState *cs)
     return ret;
 }
 
+static int kvm_check_cpucfg2(CPUState *cs)
+{
+    int ret;
+    uint64_t val;
+    struct kvm_device_attr attr = {
+        .group = KVM_LOONGARCH_VCPU_CPUCFG,
+        .attr = 2,
+        .addr = (uint64_t)&val,
+    };
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    CPULoongArchState *env = &cpu->env;
+
+    ret = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, &attr);
+
+    if (!ret) {
+        kvm_vcpu_ioctl(cs, KVM_GET_DEVICE_ATTR, &attr);
+        env->cpucfg[2] &= val;
+
+        if (FIELD_EX32(env->cpucfg[2], CPUCFG2, FP)) {
+            /* The FP minimal version is 1. */
+            env->cpucfg[2] = FIELD_DP32(env->cpucfg[2], CPUCFG2, FP_VER, 1);
+        }
+
+        if (FIELD_EX32(env->cpucfg[2], CPUCFG2, LLFTP)) {
+            /* The LLFTP minimal version is 1. */
+            env->cpucfg[2] = FIELD_DP32(env->cpucfg[2], CPUCFG2, LLFTP_VER, 1);
+        }
+    }
+
+    return ret;
+}
+
 static int kvm_loongarch_put_cpucfg(CPUState *cs)
 {
     int i, ret = 0;
@@ -545,14 +577,13 @@ static int kvm_loongarch_put_cpucfg(CPUState *cs)
     uint64_t val;
 
     for (i = 0; i < 21; i++) {
+	if (i == 2) {
+            ret = kvm_check_cpucfg2(cs);
+            if (ret) {
+                return ret;
+            }
+	}
         val = env->cpucfg[i];
-        /* LSX and LASX and LBT are not supported in kvm now */
-        if (i == 2) {
-            val &= ~(BIT(R_CPUCFG2_LSX_SHIFT) | BIT(R_CPUCFG2_LASX_SHIFT));
-            val &= ~(BIT(R_CPUCFG2_LBT_X86_SHIFT) |
-                     BIT(R_CPUCFG2_LBT_ARM_SHIFT) |
-                     BIT(R_CPUCFG2_LBT_MIPS_SHIFT));
-        }
         ret = kvm_set_one_reg(cs, KVM_IOC_CPUCFG(i), &val);
         if (ret < 0) {
             trace_kvm_failed_put_cpucfg(strerror(errno));
-- 
2.25.1


