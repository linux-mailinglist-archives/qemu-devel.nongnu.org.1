Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A96B987FE
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Sep 2025 09:22:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Jn2-0005Pd-KU; Wed, 24 Sep 2025 03:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v1Jmz-0005Og-Gj
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:19:45 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v1Jmp-0003OT-Br
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=6/Gip0PjX+Q6V9utA2F2/HpLe4jVvlI12xxQ8AaRq88=; b=Z5kWt4VlNmjnjIE
 35Eh5CLqbSsfawwW4kDEJVV8ORyjBNJwyzAV+5SQG2LXVUFhbX93Rypuaq+IvD+e4VXAZgVyJddqk
 2VJezsJQYDPv8WMGJEa8EfQ7Ls1CyUuVFuSxscXmwJ1piZcp5wYpVwT0VYoteLWBdygqgdziIaMxS
 Fk=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 palmer@dabbelt.com
Subject: [RFC PATCH 06/34] target/riscv: Combine mhpmevent and mhpmeventh
Date: Wed, 24 Sep 2025 09:20:56 +0200
Message-ID: <20250924072124.6493-7-anjo@rev.ng>
In-Reply-To: <20250924072124.6493-1-anjo@rev.ng>
References: <20250924072124.6493-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

According to version 20250508 of the privileged specification,
mhpmeventn is 64 bits in size and mhpmeventnh is only ever used
when XLEN == 32 and accesses the top 32 bits of the 64-bit
mhpmeventn registers. Combine the two arrays of target_ulong
mhpmeventh[] and mhpmevent[] to a single array of uint64_t.

This also allows for some minor code simplification where branches
handling either mhpmeventh[] or mhpmevent[] could be combined.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/cpu.h     | 10 +++----
 target/riscv/csr.c     | 67 +++++++++++++++---------------------------
 target/riscv/machine.c |  3 +-
 target/riscv/pmu.c     | 53 ++++++++-------------------------
 4 files changed, 42 insertions(+), 91 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index f94f773a84..f0f4d71fdf 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -427,11 +427,11 @@ struct CPUArchState {
     /* PMU counter state */
     PMUCTRState pmu_ctrs[RV_MAX_MHPMCOUNTERS];
 
-    /* PMU event selector configured values. First three are unused */
-    target_ulong mhpmevent_val[RV_MAX_MHPMEVENTS];
-
-    /* PMU event selector configured values for RV32 */
-    target_ulong mhpmeventh_val[RV_MAX_MHPMEVENTS];
+    /*
+     * PMU event selector configured values. First three are unused.
+     * For RV32 top 32 bits are accessed via the mhpmeventh CSR.
+     */
+    uint64_t mhpmevent_val[RV_MAX_MHPMEVENTS];
 
     PMUFixedCtrState pmu_fixed_ctrs[2];
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5997b71b43..35f296954f 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1167,8 +1167,9 @@ static RISCVException read_mhpmevent(CPURISCVState *env, int csrno,
                                      target_ulong *val)
 {
     int evt_index = csrno - CSR_MCOUNTINHIBIT;
+    bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
 
-    *val = env->mhpmevent_val[evt_index];
+    *val = extract64(env->mhpmevent_val[evt_index], 0, rv32 ? 32 : 64);
 
     return RISCV_EXCP_NONE;
 }
@@ -1177,13 +1178,11 @@ static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
                                       target_ulong val, uintptr_t ra)
 {
     int evt_index = csrno - CSR_MCOUNTINHIBIT;
-    uint64_t mhpmevt_val = val;
+    uint64_t mhpmevt_val;
     uint64_t inh_avail_mask;
 
     if (riscv_cpu_mxl(env) == MXL_RV32) {
-        env->mhpmevent_val[evt_index] = val;
-        mhpmevt_val = mhpmevt_val |
-                      ((uint64_t)env->mhpmeventh_val[evt_index] << 32);
+        mhpmevt_val = deposit64(env->mhpmevent_val[evt_index], 0, 32, val);
     } else {
         inh_avail_mask = ~MHPMEVENT_FILTER_MASK | MHPMEVENT_BIT_MINH;
         inh_avail_mask |= riscv_has_ext(env, RVU) ? MHPMEVENT_BIT_UINH : 0;
@@ -1193,9 +1192,9 @@ static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
         inh_avail_mask |= (riscv_has_ext(env, RVH) &&
                            riscv_has_ext(env, RVS)) ? MHPMEVENT_BIT_VSINH : 0;
         mhpmevt_val = val & inh_avail_mask;
-        env->mhpmevent_val[evt_index] = mhpmevt_val;
     }
 
+    env->mhpmevent_val[evt_index] = mhpmevt_val;
     riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
 
     return RISCV_EXCP_NONE;
@@ -1206,7 +1205,7 @@ static RISCVException read_mhpmeventh(CPURISCVState *env, int csrno,
 {
     int evt_index = csrno - CSR_MHPMEVENT3H + 3;
 
-    *val = env->mhpmeventh_val[evt_index];
+    *val = extract64(env->mhpmevent_val[evt_index], 32, 32);
 
     return RISCV_EXCP_NONE;
 }
@@ -1215,8 +1214,6 @@ static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
                                        target_ulong val, uintptr_t ra)
 {
     int evt_index = csrno - CSR_MHPMEVENT3H + 3;
-    uint64_t mhpmevth_val;
-    uint64_t mhpmevt_val = env->mhpmevent_val[evt_index];
     target_ulong inh_avail_mask = (target_ulong)(~MHPMEVENTH_FILTER_MASK |
                                                   MHPMEVENTH_BIT_MINH);
 
@@ -1227,11 +1224,10 @@ static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
     inh_avail_mask |= (riscv_has_ext(env, RVH) &&
                        riscv_has_ext(env, RVS)) ? MHPMEVENTH_BIT_VSINH : 0;
 
-    mhpmevth_val = val & inh_avail_mask;
-    mhpmevt_val = mhpmevt_val | (mhpmevth_val << 32);
-    env->mhpmeventh_val[evt_index] = mhpmevth_val;
+    env->mhpmevent_val[evt_index] = deposit64(env->mhpmevent_val[evt_index],
+                                              32, 32, val & inh_avail_mask);
 
-    riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
+    riscv_pmu_update_event_map(env, env->mhpmevent_val[evt_index], evt_index);
 
     return RISCV_EXCP_NONE;
 }
@@ -1257,9 +1253,7 @@ static target_ulong riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
         cfg_val = rv32 ? ((uint64_t)env->minstretcfgh << 32) :
                   env->minstretcfg;
     } else {
-        cfg_val = rv32 ?
-                  ((uint64_t)env->mhpmeventh_val[counter_idx] << 32) :
-                  env->mhpmevent_val[counter_idx];
+        cfg_val = env->mhpmevent_val[counter_idx];
         cfg_val &= MHPMEVENT_FILTER_MASK;
     }
 
@@ -1472,27 +1466,23 @@ static int rmw_cd_mhpmcounterh(CPURISCVState *env, int ctr_idx,
 
 static int rmw_cd_mhpmevent(CPURISCVState *env, int evt_index,
                             target_ulong *val, target_ulong new_val,
-                            target_ulong wr_mask)
+                            uint64_t wr_mask)
 {
-    uint64_t mhpmevt_val = new_val;
+    uint64_t mhpmevt_val = env->mhpmevent_val[evt_index];
 
     if (wr_mask != 0 && wr_mask != -1) {
         return -EINVAL;
     }
 
     if (!wr_mask && val) {
-        *val = env->mhpmevent_val[evt_index];
+        *val = mhpmevt_val;
         if (riscv_cpu_cfg(env)->ext_sscofpmf) {
             *val &= ~MHPMEVENT_BIT_MINH;
         }
     } else if (wr_mask) {
         wr_mask &= ~MHPMEVENT_BIT_MINH;
-        mhpmevt_val = (new_val & wr_mask) |
-                      (env->mhpmevent_val[evt_index] & ~wr_mask);
-        if (riscv_cpu_mxl(env) == MXL_RV32) {
-            mhpmevt_val = mhpmevt_val |
-                          ((uint64_t)env->mhpmeventh_val[evt_index] << 32);
-        }
+        /* wr_mask is 64-bit so upper 32 bits of mhpmevt_val are retained */
+        mhpmevt_val = (new_val & wr_mask) | (mhpmevt_val & ~wr_mask);
         env->mhpmevent_val[evt_index] = mhpmevt_val;
         riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
     } else {
@@ -1506,24 +1496,23 @@ static int rmw_cd_mhpmeventh(CPURISCVState *env, int evt_index,
                              target_ulong *val, target_ulong new_val,
                              target_ulong wr_mask)
 {
-    uint64_t mhpmevth_val;
     uint64_t mhpmevt_val = env->mhpmevent_val[evt_index];
+    uint32_t mhpmevth_val = extract64(mhpmevt_val, 32, 32);
 
     if (wr_mask != 0 && wr_mask != -1) {
         return -EINVAL;
     }
 
     if (!wr_mask && val) {
-        *val = env->mhpmeventh_val[evt_index];
+        *val = mhpmevth_val;
         if (riscv_cpu_cfg(env)->ext_sscofpmf) {
             *val &= ~MHPMEVENTH_BIT_MINH;
         }
     } else if (wr_mask) {
         wr_mask &= ~MHPMEVENTH_BIT_MINH;
-        env->mhpmeventh_val[evt_index] =
-            (new_val & wr_mask) | (env->mhpmeventh_val[evt_index] & ~wr_mask);
-        mhpmevth_val = env->mhpmeventh_val[evt_index];
-        mhpmevt_val = mhpmevt_val | (mhpmevth_val << 32);
+        mhpmevth_val = (new_val & wr_mask) | (mhpmevth_val & ~wr_mask);
+        mhpmevt_val = deposit64(mhpmevt_val, 32, 32, mhpmevth_val);
+        env->mhpmevent_val[evt_index] = mhpmevt_val;
         riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
     } else {
         return -EINVAL;
@@ -1599,8 +1588,6 @@ static RISCVException read_scountovf(CPURISCVState *env, int csrno,
     int mhpmevt_start = CSR_MHPMEVENT3 - CSR_MCOUNTINHIBIT;
     int i;
     *val = 0;
-    target_ulong *mhpm_evt_val;
-    uint64_t of_bit_mask;
 
     /* Virtualize scountovf for counter delegation */
     if (riscv_cpu_cfg(env)->ext_sscofpmf &&
@@ -1610,19 +1597,11 @@ static RISCVException read_scountovf(CPURISCVState *env, int csrno,
         return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
     }
 
-    if (riscv_cpu_mxl(env) == MXL_RV32) {
-        mhpm_evt_val = env->mhpmeventh_val;
-        of_bit_mask = MHPMEVENTH_BIT_OF;
-    } else {
-        mhpm_evt_val = env->mhpmevent_val;
-        of_bit_mask = MHPMEVENT_BIT_OF;
-    }
-
     for (i = mhpmevt_start; i < RV_MAX_MHPMEVENTS; i++) {
         if ((get_field(env->mcounteren, BIT(i))) &&
-            (mhpm_evt_val[i] & of_bit_mask)) {
-                    *val |= BIT(i);
-            }
+            (env->mhpmevent_val[i] & MHPMEVENT_BIT_OF)) {
+            *val |= BIT(i);
+        }
     }
 
     return RISCV_EXCP_NONE;
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 32cc94858d..c476bb0089 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -452,8 +452,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINT32(env.mcountinhibit, RISCVCPU),
         VMSTATE_STRUCT_ARRAY(env.pmu_ctrs, RISCVCPU, RV_MAX_MHPMCOUNTERS, 0,
                              vmstate_pmu_ctr_state, PMUCTRState),
-        VMSTATE_UINTTL_ARRAY(env.mhpmevent_val, RISCVCPU, RV_MAX_MHPMEVENTS),
-        VMSTATE_UINTTL_ARRAY(env.mhpmeventh_val, RISCVCPU, RV_MAX_MHPMEVENTS),
+        VMSTATE_UINT64_ARRAY(env.mhpmevent_val, RISCVCPU, RV_MAX_MHPMEVENTS),
         VMSTATE_UINT64(env.sscratch, RISCVCPU),
         VMSTATE_UINT64(env.mscratch, RISCVCPU),
         VMSTATE_UINT64(env.stimecmp, RISCVCPU),
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index a68809eef3..273822e921 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -110,15 +110,15 @@ static int riscv_pmu_incr_ctr_rv32(RISCVCPU *cpu, uint32_t ctr_idx)
 
     /* Privilege mode filtering */
     if ((env->priv == PRV_M &&
-        (env->mhpmeventh_val[ctr_idx] & MHPMEVENTH_BIT_MINH)) ||
+        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_MINH)) ||
         (env->priv == PRV_S && virt_on &&
-        (env->mhpmeventh_val[ctr_idx] & MHPMEVENTH_BIT_VSINH)) ||
+        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_VSINH)) ||
         (env->priv == PRV_U && virt_on &&
-        (env->mhpmeventh_val[ctr_idx] & MHPMEVENTH_BIT_VUINH)) ||
+        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_VUINH)) ||
         (env->priv == PRV_S && !virt_on &&
-        (env->mhpmeventh_val[ctr_idx] & MHPMEVENTH_BIT_SINH)) ||
+        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_SINH)) ||
         (env->priv == PRV_U && !virt_on &&
-        (env->mhpmeventh_val[ctr_idx] & MHPMEVENTH_BIT_UINH))) {
+        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_UINH))) {
         return 0;
     }
 
@@ -128,8 +128,8 @@ static int riscv_pmu_incr_ctr_rv32(RISCVCPU *cpu, uint32_t ctr_idx)
             counter->mhpmcounter_val = 0;
             counter->mhpmcounterh_val = 0;
             /* Generate interrupt only if OF bit is clear */
-            if (!(env->mhpmeventh_val[ctr_idx] & MHPMEVENTH_BIT_OF)) {
-                env->mhpmeventh_val[ctr_idx] |= MHPMEVENTH_BIT_OF;
+            if (!(env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_OF)) {
+                env->mhpmevent_val[ctr_idx] |= MHPMEVENT_BIT_OF;
                 riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
             }
         } else {
@@ -420,41 +420,14 @@ int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
     return 0;
 }
 
-static bool pmu_hpmevent_is_of_set(CPURISCVState *env, uint32_t ctr_idx)
-{
-    target_ulong mhpmevent_val;
-    uint64_t of_bit_mask;
-
-    if (riscv_cpu_mxl(env) == MXL_RV32) {
-        mhpmevent_val = env->mhpmeventh_val[ctr_idx];
-        of_bit_mask = MHPMEVENTH_BIT_OF;
-     } else {
-        mhpmevent_val = env->mhpmevent_val[ctr_idx];
-        of_bit_mask = MHPMEVENT_BIT_OF;
-    }
-
-    return get_field(mhpmevent_val, of_bit_mask);
-}
-
 static bool pmu_hpmevent_set_of_if_clear(CPURISCVState *env, uint32_t ctr_idx)
 {
-    target_ulong *mhpmevent_val;
-    uint64_t of_bit_mask;
-
-    if (riscv_cpu_mxl(env) == MXL_RV32) {
-        mhpmevent_val = &env->mhpmeventh_val[ctr_idx];
-        of_bit_mask = MHPMEVENTH_BIT_OF;
-     } else {
-        mhpmevent_val = &env->mhpmevent_val[ctr_idx];
-        of_bit_mask = MHPMEVENT_BIT_OF;
-    }
-
-    if (!get_field(*mhpmevent_val, of_bit_mask)) {
-        *mhpmevent_val |= of_bit_mask;
+    if (!get_field(env->mhpmevent_val[ctr_idx], MHPMEVENT_BIT_OF)) {
+        env->mhpmevent_val[ctr_idx] |= MHPMEVENT_BIT_OF;
         return true;
+    } else {
+        return false;
     }
-
-    return false;
 }
 
 static void pmu_timer_trigger_irq(RISCVCPU *cpu,
@@ -479,7 +452,7 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
     }
 
     /* Generate interrupt only if OF bit is clear */
-    if (pmu_hpmevent_is_of_set(env, ctr_idx)) {
+    if (get_field(env->mhpmevent_val[ctr_idx], MHPMEVENT_BIT_OF)) {
         return;
     }
 
@@ -538,7 +511,7 @@ int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value, uint32_t ctr_idx)
 
     /* No need to setup a timer if LCOFI is disabled when OF is set */
     if (!riscv_pmu_counter_valid(cpu, ctr_idx) || !cpu->cfg.ext_sscofpmf ||
-        pmu_hpmevent_is_of_set(env, ctr_idx)) {
+        get_field(env->mhpmevent_val[ctr_idx], MHPMEVENT_BIT_OF)) {
         return -1;
     }
 
-- 
2.51.0


