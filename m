Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C88CB85E1F3
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Feb 2024 16:53:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoY7-0004xp-IB; Wed, 21 Feb 2024 10:30:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rcoNK-0004vg-K0; Wed, 21 Feb 2024 10:19:10 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rcmM2-0004tm-KM; Wed, 21 Feb 2024 08:09:45 -0500
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4TfxQl2TDLz1Q8lf;
 Wed, 21 Feb 2024 21:07:59 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id D69E51404DB;
 Wed, 21 Feb 2024 21:09:38 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 21 Feb
 2024 21:09:38 +0800
To: <peter.maydell@linaro.org>, <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, <wangyanan55@huawei.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <ruanjinjie@huawei.com>
Subject: [RFC PATCH v2 20/22] hw/intc/arm_gicv3: Add NMI handling CPU
 interface registers
Date: Wed, 21 Feb 2024 13:08:21 +0000
Message-ID: <20240221130823.677762-21-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221130823.677762-1-ruanjinjie@huawei.com>
References: <20240221130823.677762-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.255;
 envelope-from=ruanjinjie@huawei.com; helo=szxga08-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jinjie Ruan <ruanjinjie@huawei.com>
From:  Jinjie Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Add the NMIAR CPU interface registers which deal with acknowledging NMI.

When introduce NMI interrupt, there are some updates to the semantics for the
register ICC_IAR1_EL1 and ICC_HPPIR1_EL1. For ICC_IAR1_EL1 register, it
should return 1022 if the intid has super priority. And for ICC_NMIAR1_EL1
register, it should return 1023 if the intid do not have super priority.
Howerever, these are not necessary for ICC_HPPIR1_EL1 register.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/intc/arm_gicv3_cpuif.c | 46 ++++++++++++++++++++++++++++++++++++---
 hw/intc/gicv3_internal.h  |  1 +
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index e1a60d8c15..f5bf8df32b 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -1097,7 +1097,8 @@ static uint64_t icc_hppir0_value(GICv3CPUState *cs, CPUARMState *env)
     return cs->hppi.irq;
 }
 
-static uint64_t icc_hppir1_value(GICv3CPUState *cs, CPUARMState *env)
+static uint64_t icc_hppir1_value(GICv3CPUState *cs, CPUARMState *env,
+                                 bool is_nmi, bool is_hppi)
 {
     /* Return the highest priority pending interrupt register value
      * for group 1.
@@ -1108,6 +1109,16 @@ static uint64_t icc_hppir1_value(GICv3CPUState *cs, CPUARMState *env)
         return INTID_SPURIOUS;
     }
 
+    if (!is_hppi) {
+        if (is_nmi && (!cs->hppi.superprio)) {
+            return INTID_SPURIOUS;
+        }
+
+        if ((!is_nmi) && cs->hppi.superprio) {
+            return INTID_NMI;
+        }
+    }
+
     /* Check whether we can return the interrupt or if we should return
      * a special identifier, as per the CheckGroup1ForSpecialIdentifiers
      * pseudocode. (We can simplify a little because for us ICC_SRE_EL1.RM
@@ -1168,7 +1179,30 @@ static uint64_t icc_iar1_read(CPUARMState *env, const ARMCPRegInfo *ri)
     if (!icc_hppi_can_preempt(cs)) {
         intid = INTID_SPURIOUS;
     } else {
-        intid = icc_hppir1_value(cs, env);
+        intid = icc_hppir1_value(cs, env, false, false);
+    }
+
+    if (!gicv3_intid_is_special(intid)) {
+        icc_activate_irq(cs, intid);
+    }
+
+    trace_gicv3_icc_iar1_read(gicv3_redist_affid(cs), intid);
+    return intid;
+}
+
+static uint64_t icc_nmiar1_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    GICv3CPUState *cs = icc_cs_from_env(env);
+    uint64_t intid;
+
+    if (icv_access(env, HCR_IMO)) {
+        return icv_iar_read(env, ri);
+    }
+
+    if (!icc_hppi_can_preempt(cs)) {
+        intid = INTID_SPURIOUS;
+    } else {
+        intid = icc_hppir1_value(cs, env, true, false);
     }
 
     if (!gicv3_intid_is_special(intid)) {
@@ -1555,7 +1589,7 @@ static uint64_t icc_hppir1_read(CPUARMState *env, const ARMCPRegInfo *ri)
         return icv_hppir_read(env, ri);
     }
 
-    value = icc_hppir1_value(cs, env);
+    value = icc_hppir1_value(cs, env, false, true);
     trace_gicv3_icc_hppir1_read(gicv3_redist_affid(cs), value);
     return value;
 }
@@ -2344,6 +2378,12 @@ static const ARMCPRegInfo gicv3_cpuif_reginfo[] = {
       .access = PL1_R, .accessfn = gicv3_irq_access,
       .readfn = icc_iar1_read,
     },
+    { .name = "ICC_NMIAR1_EL1", .state = ARM_CP_STATE_BOTH,
+      .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 9, .opc2 = 5,
+      .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .access = PL1_R, .accessfn = gicv3_irq_access,
+      .readfn = icc_nmiar1_read,
+    },
     { .name = "ICC_EOIR1_EL1", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 12, .opc2 = 1,
       .type = ARM_CP_IO | ARM_CP_NO_RAW,
diff --git a/hw/intc/gicv3_internal.h b/hw/intc/gicv3_internal.h
index 8d793243f4..93e56b3726 100644
--- a/hw/intc/gicv3_internal.h
+++ b/hw/intc/gicv3_internal.h
@@ -511,6 +511,7 @@ FIELD(VTE, RDBASE, 42, RDBASE_PROCNUM_LENGTH)
 /* Special interrupt IDs */
 #define INTID_SECURE 1020
 #define INTID_NONSECURE 1021
+#define INTID_NMI 1022
 #define INTID_SPURIOUS 1023
 
 /* Functions internal to the emulated GICv3 */
-- 
2.34.1


