Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 966DABDB48F
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Oct 2025 22:39:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8lhm-0000qM-M0; Tue, 14 Oct 2025 16:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v8lhg-0000oC-KI
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:33:04 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v8lhY-0000Pb-Ka
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=nWJ5GmAlqkTRFlYLntDLAfOkhxKK8h9UaWBSF0uCw8g=; b=BSB8G8CGZ8tciG5
 F1mk94oGKlkv3x29DeJZwU5Q64PRu8hIx4HyULg2zJ1jYF8PexbkCo+ca+Z6dWS74fKpIURY31IAu
 wmMaLlPf/yESxzIIvcItoPvJW6qUW913sPg4ak9jjRPsvWI+JgIHLYwJzXdAQxv5weHXjeV/IaZC2
 Mc=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 palmer@dabbelt.com
Subject: [PATCH v3 04/34] target/riscv: Bugfix
 riscv_pmu_ctr_get_fixed_counters_val()
Date: Tue, 14 Oct 2025 22:34:41 +0200
Message-ID: <20251014203512.26282-5-anjo@rev.ng>
In-Reply-To: <20251014203512.26282-1-anjo@rev.ng>
References: <20251014203512.26282-1-anjo@rev.ng>
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

From my understanding the upper_half argument only indicates whether the
upper or lower 32 bits should be returned, and upper_half will only ever
be set when MXLEN == 32.  However, the function also uses upper_half to
determine whether the inhibit flags are located in mcyclecfgh or
mcyclecfg, but this misses the case where MXLEN == 32, upper_half == false
for TARGET_RISCV32 where we would also need to read the upper half field.

Minor simplifications are also made along with some formatting fixes.

Signed-off-by: Anton Johansson <anjo@rev.ng>

---
NOTE: I've not included any reviewed-bys or modified this patch as it's
still unclear to me whether this change is correct or not.  Alistair
mentioned that this can get called for MXLEN == 32 and upper_half ==
false, meaning the lower field would be accessed.  I'm sure I'm missing
something but this is still not clear to me, it seems to me like we
always want to access the upper half for MXLEN == 32 since that's were
the inhibit flags are stored.
---
 target/riscv/csr.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5c91658c3d..657179a983 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -17,6 +17,7 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include "cpu_bits.h"
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/timer.h"
@@ -1243,18 +1244,21 @@ static target_ulong riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
     int inst = riscv_pmu_ctr_monitor_instructions(env, counter_idx);
     uint64_t *counter_arr_virt = env->pmu_fixed_ctrs[inst].counter_virt;
     uint64_t *counter_arr = env->pmu_fixed_ctrs[inst].counter;
-    target_ulong result = 0;
     uint64_t curr_val = 0;
     uint64_t cfg_val = 0;
+    bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
+
+    /* Ensure upper_half is only set for MXL_RV32 */
+    g_assert(rv32 || !upper_half);
 
     if (counter_idx == 0) {
-        cfg_val = upper_half ? ((uint64_t)env->mcyclecfgh << 32) :
+        cfg_val = rv32 ? ((uint64_t)env->mcyclecfgh << 32) :
                   env->mcyclecfg;
     } else if (counter_idx == 2) {
-        cfg_val = upper_half ? ((uint64_t)env->minstretcfgh << 32) :
+        cfg_val = rv32 ? ((uint64_t)env->minstretcfgh << 32) :
                   env->minstretcfg;
     } else {
-        cfg_val = upper_half ?
+        cfg_val = rv32 ?
                   ((uint64_t)env->mhpmeventh_val[counter_idx] << 32) :
                   env->mhpmevent_val[counter_idx];
         cfg_val &= MHPMEVENT_FILTER_MASK;
@@ -1262,7 +1266,7 @@ static target_ulong riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
 
     if (!cfg_val) {
         if (icount_enabled()) {
-                curr_val = inst ? icount_get_raw() : icount_get();
+            curr_val = inst ? icount_get_raw() : icount_get();
         } else {
             curr_val = cpu_get_host_ticks();
         }
@@ -1294,13 +1298,7 @@ static target_ulong riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
     }
 
 done:
-    if (riscv_cpu_mxl(env) == MXL_RV32) {
-        result = upper_half ? curr_val >> 32 : curr_val;
-    } else {
-        result = curr_val;
-    }
-
-    return result;
+    return upper_half ? curr_val >> 32 : curr_val;
 }
 
 static RISCVException riscv_pmu_write_ctr(CPURISCVState *env, target_ulong val,
-- 
2.51.0


