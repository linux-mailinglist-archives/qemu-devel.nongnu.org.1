Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE8E8896A1
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Mar 2024 09:54:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rog4i-0003bM-Jx; Mon, 25 Mar 2024 04:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rog41-00034u-J3; Mon, 25 Mar 2024 04:52:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rog3w-0007R9-Gk; Mon, 25 Mar 2024 04:52:16 -0400
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4V367C3QSWz1R83N;
 Mon, 25 Mar 2024 16:49:27 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id 8272C1400D4;
 Mon, 25 Mar 2024 16:52:05 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 25 Mar
 2024 16:52:04 +0800
To: <peter.maydell@linaro.org>, <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, <wangyanan55@huawei.com>,
 <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v10 18/23] hw/intc/arm_gicv3: Handle icv_nmiar1_read() for
 icc_nmiar1_read()
Date: Mon, 25 Mar 2024 08:48:49 +0000
Message-ID: <20240325084854.3010562-19-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325084854.3010562-1-ruanjinjie@huawei.com>
References: <20240325084854.3010562-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.35; envelope-from=ruanjinjie@huawei.com;
 helo=szxga07-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Implement icv_nmiar1_read() for icc_nmiar1_read(), so add definition for
ICH_LR_EL2.NMI and ICH_AP1R_EL2.NMI bit.

If FEAT_GICv3_NMI is supported, ich_ap_write() should consider ICV_AP1R_EL1.NMI
bit. In icv_activate_irq() and icv_eoir_write(), the ICV_AP1R_EL1.NMI bit
should be set or clear according to the Non-maskable property. And the RPR
priority should also update the NMI bit according to the APR priority NMI bit.

By the way, add gicv3_icv_nmiar1_read trace event.

If the hpp irq is a NMI, the icv iar read should return 1022 and trap for
NMI again

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v10:
- Rename ICH_AP1R_EL2_NMI to ICV_AP1R_EL1_NMI.
- Add ICV_RPR_EL1_NMI definition.
- Set ICV_RPR_EL1.NMI according to the ICV_AP1R<n>_EL1.NMI in
  ich_highest_active_virt_prio().
v9:
- Correct the INTID_NMI logic.
v8:
- Fix an unexpected interrupt bug when sending VNMI by running qemu VM.
v7:
- Add Reviewed-by.
v6:
- Implement icv_nmiar1_read().
---
 hw/intc/arm_gicv3_cpuif.c | 79 +++++++++++++++++++++++++++++++++------
 hw/intc/gicv3_internal.h  |  4 ++
 hw/intc/trace-events      |  1 +
 3 files changed, 73 insertions(+), 11 deletions(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 76e2286e70..e0dc76df2f 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -149,12 +149,13 @@ static uint32_t icv_fullprio_mask(GICv3CPUState *cs)
     return (~0U << (8 - cs->vpribits)) & 0xff;
 }
 
-static int ich_highest_active_virt_prio(GICv3CPUState *cs)
+static uint64_t ich_highest_active_virt_prio(GICv3CPUState *cs)
 {
     /* Calculate the current running priority based on the set bits
      * in the ICH Active Priority Registers.
      */
     int i;
+    uint64_t prio;
     int aprmax = ich_num_aprs(cs);
 
     for (i = 0; i < aprmax; i++) {
@@ -164,7 +165,15 @@ static int ich_highest_active_virt_prio(GICv3CPUState *cs)
         if (!apr) {
             continue;
         }
-        return (i * 32 + ctz32(apr)) << (icv_min_vbpr(cs) + 1);
+        prio = (i * 32 + ctz32(apr)) << (icv_min_vbpr(cs) + 1);
+
+        if (cs->gic->nmi_support &&
+            cs->ich_apr[GICV3_G1NS][i] & ICV_AP1R_EL1_NMI) {
+            prio |= ICV_RPR_EL1_NMI;
+        }
+
+        return prio;
+
     }
     /* No current active interrupts: return idle priority */
     return 0xff;
@@ -289,7 +298,8 @@ static bool icv_hppi_can_preempt(GICv3CPUState *cs, uint64_t lr)
      * equivalent of these checks.
      */
     int grp;
-    uint32_t mask, prio, rprio, vpmr;
+    uint32_t mask, prio, vpmr;
+    uint64_t rprio;
 
     if (!(cs->ich_hcr_el2 & ICH_HCR_EL2_EN)) {
         /* Virtual interface disabled */
@@ -336,7 +346,8 @@ static bool icv_hppvlpi_can_preempt(GICv3CPUState *cs)
      * We can assume we're Non-secure because hppvi_index() already
      * tested for that.
      */
-    uint32_t mask, rprio, vpmr;
+    uint32_t mask, vpmr;
+    uint64_t rprio;
 
     if (!(cs->ich_hcr_el2 & ICH_HCR_EL2_EN)) {
         /* Virtual interface disabled */
@@ -550,7 +561,11 @@ static void icv_ap_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     trace_gicv3_icv_ap_write(ri->crm & 1, regno, gicv3_redist_affid(cs), value);
 
-    cs->ich_apr[grp][regno] = value & 0xFFFFFFFFU;
+    if (cs->gic->nmi_support) {
+        cs->ich_apr[grp][regno] = value & (0xFFFFFFFFU | ICV_AP1R_EL1_NMI);
+    } else {
+        cs->ich_apr[grp][regno] = value & 0xFFFFFFFFU;
+    }
 
     gicv3_cpuif_virt_irq_fiq_update(cs);
     return;
@@ -697,7 +712,7 @@ static void icv_ctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static uint64_t icv_rpr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     GICv3CPUState *cs = icc_cs_from_env(env);
-    int prio = ich_highest_active_virt_prio(cs);
+    uint64_t prio = ich_highest_active_virt_prio(cs);
 
     trace_gicv3_icv_rpr_read(gicv3_redist_affid(cs), prio);
     return prio;
@@ -728,7 +743,7 @@ static uint64_t icv_hppir_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return value;
 }
 
-static void icv_activate_irq(GICv3CPUState *cs, int idx, int grp)
+static void icv_activate_irq(GICv3CPUState *cs, int idx, int grp, bool nmi)
 {
     /* Activate the interrupt in the specified list register
      * by moving it from Pending to Active state, and update the
@@ -742,7 +757,12 @@ static void icv_activate_irq(GICv3CPUState *cs, int idx, int grp)
 
     cs->ich_lr_el2[idx] &= ~ICH_LR_EL2_STATE_PENDING_BIT;
     cs->ich_lr_el2[idx] |= ICH_LR_EL2_STATE_ACTIVE_BIT;
-    cs->ich_apr[grp][regno] |= (1 << regbit);
+
+    if (cs->gic->nmi_support) {
+        cs->ich_apr[grp][regno] |= (1 << regbit) | (nmi ? ICV_AP1R_EL1_NMI : 0);
+    } else {
+        cs->ich_apr[grp][regno] |= (1 << regbit);
+    }
 }
 
 static void icv_activate_vlpi(GICv3CPUState *cs)
@@ -776,7 +796,11 @@ static uint64_t icv_iar_read(CPUARMState *env, const ARMCPRegInfo *ri)
         if (thisgrp == grp && icv_hppi_can_preempt(cs, lr)) {
             intid = ich_lr_vintid(lr);
             if (!gicv3_intid_is_special(intid)) {
-                icv_activate_irq(cs, idx, grp);
+                if (!(lr & ICH_LR_EL2_NMI)) {
+                    icv_activate_irq(cs, idx, grp, false);
+                } else {
+                    intid = INTID_NMI;
+                }
             } else {
                 /* Interrupt goes from Pending to Invalid */
                 cs->ich_lr_el2[idx] &= ~ICH_LR_EL2_STATE_PENDING_BIT;
@@ -797,8 +821,32 @@ static uint64_t icv_iar_read(CPUARMState *env, const ARMCPRegInfo *ri)
 
 static uint64_t icv_nmiar1_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    /* todo */
+    GICv3CPUState *cs = icc_cs_from_env(env);
+    int idx = hppvi_index(cs);
     uint64_t intid = INTID_SPURIOUS;
+
+    if (idx >= 0 && idx != HPPVI_INDEX_VLPI) {
+        uint64_t lr = cs->ich_lr_el2[idx];
+        int thisgrp = (lr & ICH_LR_EL2_GROUP) ? GICV3_G1NS : GICV3_G0;
+
+        if ((thisgrp == GICV3_G1NS) && (lr & ICH_LR_EL2_NMI)) {
+            intid = ich_lr_vintid(lr);
+            if (!gicv3_intid_is_special(intid)) {
+                icv_activate_irq(cs, idx, GICV3_G1NS, true);
+            } else {
+                /* Interrupt goes from Pending to Invalid */
+                cs->ich_lr_el2[idx] &= ~ICH_LR_EL2_STATE_PENDING_BIT;
+                /* We will now return the (bogus) ID from the list register,
+                 * as per the pseudocode.
+                 */
+            }
+        }
+    }
+
+    trace_gicv3_icv_nmiar1_read(gicv3_redist_affid(cs), intid);
+
+    gicv3_cpuif_virt_update(cs);
+
     return intid;
 }
 
@@ -1439,6 +1487,11 @@ static int icv_drop_prio(GICv3CPUState *cs)
             return (apr0count + i * 32) << (icv_min_vbpr(cs) + 1);
         } else {
             *papr1 &= *papr1 - 1;
+
+            if (cs->gic->nmi_support && (*papr1 & ICV_AP1R_EL1_NMI)) {
+                *papr1 &= (~ICV_AP1R_EL1_NMI);
+            }
+
             return (apr1count + i * 32) << (icv_min_vbpr(cs) + 1);
         }
     }
@@ -2592,7 +2645,11 @@ static void ich_ap_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     trace_gicv3_ich_ap_write(ri->crm & 1, regno, gicv3_redist_affid(cs), value);
 
-    cs->ich_apr[grp][regno] = value & 0xFFFFFFFFU;
+    if (cs->gic->nmi_support) {
+        cs->ich_apr[grp][regno] = value & (0xFFFFFFFFU | ICV_AP1R_EL1_NMI);
+    } else {
+        cs->ich_apr[grp][regno] = value & 0xFFFFFFFFU;
+    }
     gicv3_cpuif_virt_irq_fiq_update(cs);
 }
 
diff --git a/hw/intc/gicv3_internal.h b/hw/intc/gicv3_internal.h
index 81200eb90e..bc9f518fe8 100644
--- a/hw/intc/gicv3_internal.h
+++ b/hw/intc/gicv3_internal.h
@@ -246,6 +246,7 @@ FIELD(GICR_VPENDBASER, VALID, 63, 1)
 #define ICH_LR_EL2_PRIORITY_SHIFT 48
 #define ICH_LR_EL2_PRIORITY_LENGTH 8
 #define ICH_LR_EL2_PRIORITY_MASK (0xffULL << ICH_LR_EL2_PRIORITY_SHIFT)
+#define ICH_LR_EL2_NMI (1ULL << 59)
 #define ICH_LR_EL2_GROUP (1ULL << 60)
 #define ICH_LR_EL2_HW (1ULL << 61)
 #define ICH_LR_EL2_STATE_SHIFT 62
@@ -277,6 +278,9 @@ FIELD(GICR_VPENDBASER, VALID, 63, 1)
 #define ICH_VTR_EL2_PREBITS_SHIFT 26
 #define ICH_VTR_EL2_PRIBITS_SHIFT 29
 
+#define ICV_AP1R_EL1_NMI (1ULL << 63)
+#define ICV_RPR_EL1_NMI (1ULL << 63)
+
 /* ITS Registers */
 
 FIELD(GITS_BASER, SIZE, 0, 8)
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 94030550d5..47340b5bc1 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -152,6 +152,7 @@ gicv3_icv_rpr_read(uint32_t cpu, uint64_t val) "GICv3 ICV_RPR read cpu 0x%x valu
 gicv3_icv_hppir_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_HPPIR%d read cpu 0x%x value 0x%" PRIx64
 gicv3_icv_dir_write(uint32_t cpu, uint64_t val) "GICv3 ICV_DIR write cpu 0x%x value 0x%" PRIx64
 gicv3_icv_iar_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_IAR%d read cpu 0x%x value 0x%" PRIx64
+gicv3_icv_nmiar1_read(uint32_t cpu, uint64_t val) "GICv3 ICV_NMIAR1 read cpu 0x%x value 0x%" PRIx64
 gicv3_icv_eoir_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_EOIR%d write cpu 0x%x value 0x%" PRIx64
 gicv3_cpuif_virt_update(uint32_t cpuid, int idx, int hppvlpi, int grp, int prio) "GICv3 CPU i/f 0x%x virt HPPI update LR index %d HPPVLPI %d grp %d prio %d"
 gicv3_cpuif_virt_set_irqs(uint32_t cpuid, int fiqlevel, int irqlevel) "GICv3 CPU i/f 0x%x virt HPPI update: setting FIQ %d IRQ %d"
-- 
2.34.1


