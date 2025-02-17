Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A36CDA37A43
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Feb 2025 04:59:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjsGL-0001Uc-LR; Sun, 16 Feb 2025 22:57:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tjsGB-0001SW-K1
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 22:57:31 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tjsG7-0006r0-VM
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 22:57:31 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxdXCgs7JnsV54AA--.12067S3;
 Mon, 17 Feb 2025 11:57:20 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxn8Wfs7JnbXwXAA--.24352S6;
 Mon, 17 Feb 2025 11:57:20 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org,
	lixianglai <lixianglai@loongson.cn>
Subject: [PATCH 4/8] target/loongarch: Add paravirt ipi feature detection
Date: Mon, 17 Feb 2025 11:57:14 +0800
Message-Id: <20250217035718.3977137-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250217035718.3977137-1-maobibo@loongson.cn>
References: <20250217035718.3977137-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxn8Wfs7JnbXwXAA--.24352S6
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
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

Paravirt ipi feature is OnOffAuto type, feature detection is added
to check whether it is supported by KVM host.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.h     |  2 ++
 target/loongarch/kvm/kvm.c | 36 +++++++++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index b09ca04bc1..38bb27a2b8 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -287,6 +287,7 @@ enum loongarch_features {
     LOONGARCH_FEATURE_LASX,
     LOONGARCH_FEATURE_LBT, /* loongson binary translation extension */
     LOONGARCH_FEATURE_PMU,
+    LOONGARCH_FEATURE_PV_IPI,
 };
 
 typedef struct  LoongArchBT {
@@ -310,6 +311,7 @@ typedef struct CPUArchState {
     lbt_t  lbt;
 
     uint32_t cpucfg[21];
+    uint32_t pv_features;
 
     /* LoongArch CSRs */
     uint64_t CSR_CRMD;
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index f0bcec1baf..85ab8d2856 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -8,7 +8,7 @@
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
 #include <linux/kvm.h>
-
+#include "asm-loongarch/kvm_para.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
@@ -875,6 +875,12 @@ static bool kvm_feature_supported(CPUState *cs, enum loongarch_features feature)
         ret = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
         return (ret == 0);
 
+    case LOONGARCH_FEATURE_PV_IPI:
+        attr.group = KVM_LOONGARCH_VM_FEAT_CTRL;
+        attr.attr = KVM_LOONGARCH_VM_FEAT_PV_IPI;
+        ret = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
+        return (ret == 0);
+
     default:
         return false;
     }
@@ -973,6 +979,29 @@ static int kvm_cpu_check_pmu(CPUState *cs, Error **errp)
     return 0;
 }
 
+static int kvm_cpu_check_pv_features(CPUState *cs, Error **errp)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    CPULoongArchState *env = cpu_env(cs);
+    bool kvm_supported;
+
+    kvm_supported = kvm_feature_supported(cs, LOONGARCH_FEATURE_PV_IPI);
+    if (cpu->kvm_pv_ipi == ON_OFF_AUTO_ON) {
+        if (!kvm_supported) {
+            error_setg(errp, "'pv_ipi' feature not supported by KVM host");
+            return -ENOTSUP;
+        }
+    } else if (cpu->kvm_pv_ipi != ON_OFF_AUTO_AUTO) {
+        kvm_supported = false;
+    }
+
+    if (kvm_supported) {
+        env->pv_features |= BIT(KVM_FEATURE_IPI);
+    }
+
+    return 0;
+}
+
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     uint64_t val;
@@ -1006,6 +1035,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
         error_report_err(local_err);
     }
 
+    ret = kvm_cpu_check_pv_features(cs, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+    }
+
     return ret;
 }
 
-- 
2.39.3


