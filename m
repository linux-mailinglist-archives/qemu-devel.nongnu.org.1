Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F38B98877
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Sep 2025 09:26:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Jn2-0005RK-W1; Wed, 24 Sep 2025 03:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v1Jmy-0005O9-Pj
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:19:45 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v1Jmq-0003OZ-0V
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=xQUfxNFEDlvBS35PtAvGNNw8/B9rYjS0FdRgpiMJAHE=; b=mGQOOBoLU3beLWt
 LAXdk9IFXmAyIfFkbh1O7qKHTq+hJSydtr6hkQr3TIJAk/UWC+QdoIGNQKipsmhCEC66sB5NXnhfg
 CB2CnkibC5ac+BB+LHIW1wLz95HhKBNALkdsoR1NHkyMymp99GW/yY+NZqxRtTLwDyZhL7n/Zhegv
 Gc=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 palmer@dabbelt.com
Subject: [RFC PATCH 07/34] target/riscv: Combine mcyclecfg and mcyclecfgh
Date: Wed, 24 Sep 2025 09:20:57 +0200
Message-ID: <20250924072124.6493-8-anjo@rev.ng>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

According to version 20250508 of the privileged specification, mcyclecfg
is a 64-bit register and mcyclecfgh refers to the top 32 bits of this
register when XLEN == 32.  No real advantage is gained by keeping
them separate, and combining them allows for slight simplification.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/cpu.h |  3 +--
 target/riscv/csr.c | 28 +++++++++++++++++-----------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index f0f4d71fdf..4b80daf117 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -419,8 +419,7 @@ struct CPUArchState {
     uint32_t mcountinhibit;
 
     /* PMU cycle & instret privilege mode filtering */
-    target_ulong mcyclecfg;
-    target_ulong mcyclecfgh;
+    uint64_t mcyclecfg;
     target_ulong minstretcfg;
     target_ulong minstretcfgh;
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 35f296954f..867f8efe83 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1061,7 +1061,8 @@ static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
 static RISCVException read_mcyclecfg(CPURISCVState *env, int csrno,
                                      target_ulong *val)
 {
-    *val = env->mcyclecfg;
+    bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
+    *val = extract64(env->mcyclecfg, 0, rv32 ? 32 : 64);
     return RISCV_EXCP_NONE;
 }
 
@@ -1071,7 +1072,7 @@ static RISCVException write_mcyclecfg(CPURISCVState *env, int csrno,
     uint64_t inh_avail_mask;
 
     if (riscv_cpu_mxl(env) == MXL_RV32) {
-        env->mcyclecfg = val;
+        env->mcyclecfg = deposit64(env->mcyclecfg, 0, 32, val);
     } else {
         /* Set xINH fields if priv mode supported */
         inh_avail_mask = ~MHPMEVENT_FILTER_MASK | MCYCLECFG_BIT_MINH;
@@ -1090,7 +1091,7 @@ static RISCVException write_mcyclecfg(CPURISCVState *env, int csrno,
 static RISCVException read_mcyclecfgh(CPURISCVState *env, int csrno,
                                       target_ulong *val)
 {
-    *val = env->mcyclecfgh;
+    *val = extract64(env->mcyclecfg, 32, 32);
     return RISCV_EXCP_NONE;
 }
 
@@ -1108,7 +1109,7 @@ static RISCVException write_mcyclecfgh(CPURISCVState *env, int csrno,
     inh_avail_mask |= (riscv_has_ext(env, RVH) &&
                        riscv_has_ext(env, RVS)) ? MCYCLECFGH_BIT_VSINH : 0;
 
-    env->mcyclecfgh = val & inh_avail_mask;
+    env->mcyclecfg = deposit64(env->mcyclecfg, 32, 32, val & inh_avail_mask);
     return RISCV_EXCP_NONE;
 }
 
@@ -1247,8 +1248,7 @@ static target_ulong riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
     g_assert(rv32 || !upper_half);
 
     if (counter_idx == 0) {
-        cfg_val = rv32 ? ((uint64_t)env->mcyclecfgh << 32) :
-                  env->mcyclecfg;
+        cfg_val = env->mcyclecfg;
     } else if (counter_idx == 2) {
         cfg_val = rv32 ? ((uint64_t)env->minstretcfgh << 32) :
                   env->minstretcfg;
@@ -1522,8 +1522,12 @@ static int rmw_cd_mhpmeventh(CPURISCVState *env, int evt_index,
 }
 
 static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ulong *val,
-                            target_ulong new_val, target_ulong wr_mask)
+                          target_ulong new_val, uint64_t wr_mask)
 {
+    /*
+     * wr_mask is 64-bit so upper 32 bits of mcyclecfg and minstretcfg
+     * are retained.
+     */
     switch (cfg_index) {
     case 0:             /* CYCLECFG */
         if (wr_mask) {
@@ -1549,8 +1553,9 @@ static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ulong *val,
 }
 
 static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_ulong *val,
-                            target_ulong new_val, target_ulong wr_mask)
+                           target_ulong new_val, target_ulong wr_mask)
 {
+    uint64_t cfgh;
 
     if (riscv_cpu_mxl(env) != MXL_RV32) {
         return RISCV_EXCP_ILLEGAL_INST;
@@ -1558,12 +1563,13 @@ static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_ulong *val,
 
     switch (cfg_index) {
     case 0:         /* CYCLECFGH */
+        cfgh = extract64(env->mcyclecfg, 32, 32);
         if (wr_mask) {
             wr_mask &= ~MCYCLECFGH_BIT_MINH;
-            env->mcyclecfgh = (new_val & wr_mask) |
-                              (env->mcyclecfgh & ~wr_mask);
+            cfgh = (new_val & wr_mask) | (cfgh & ~wr_mask);
+            env->mcyclecfg = deposit64(env->mcyclecfg, 32, 32, cfgh);
         } else {
-            *val = env->mcyclecfgh;
+            *val = cfgh;
         }
         break;
     case 2:          /* INSTRETCFGH */
-- 
2.51.0


