Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C21D5711FC3
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 08:21:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Qoi-0008N9-MU; Fri, 26 May 2023 02:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q2QoL-0008Jl-DX
 for qemu-devel@nongnu.org; Fri, 26 May 2023 02:20:25 -0400
Received: from hoth.uni-paderborn.de ([2001:638:502:c003::19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q2QoH-0008NS-OS
 for qemu-devel@nongnu.org; Fri, 26 May 2023 02:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ILMhcvw1NAt63EGrBEZ272z0+3BV/di4/2AC5226mFY=; b=lyoKdNdsV43ePY8L8lGcHXMNSs
 D7MG/kvyYzMlTnc4j77k2DNJB7Slf2g32VdYRFgh0Qs/nJ8OabS1amxYTL5witHI90NmDDGL/HXPq
 W/4cs2vxxhf8NjqZWbjDEq58kqFsMqpey1/ktiISX/UoNjHY7094etLxNSDTTr5HOPQU=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de
Subject: [PATCH v2 4/6] target/tricore: Refactor PCXI/ICR register fields
Date: Fri, 26 May 2023 08:19:44 +0200
Message-Id: <20230526061946.54514-5-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526061946.54514-1-kbastian@mail.uni-paderborn.de>
References: <20230526061946.54514-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.5.26.60617, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.5.16.600001
X-Sophos-SenderHistory: ip=84.184.48.71, fs=405243, da=172691083, mc=9, sc=0,
 hc=9, sp=0, fso=405243, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::19;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=hoth.uni-paderborn.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

starting from ISA version 1.6.1 (previously known as 1.6P/E), some
bitfields in PCXI and ICR have changed. We also refactor these
registers using the register fields API.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1453
---
v1 -> v2:
    - Created ice_ie_mask for DisasCtx to simplify SYS_ENABLE and SYS_DISABLE
      insn translation.

 target/tricore/cpu.h       | 39 ++++++++++++-----
 target/tricore/helper.c    | 45 ++++++++++++++++++++
 target/tricore/op_helper.c | 85 +++++++++++++++++++-------------------
 target/tricore/translate.c | 10 ++++-
 4 files changed, 123 insertions(+), 56 deletions(-)

diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 47d0ffb745..d98a3fb671 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -21,6 +21,7 @@
 #define TRICORE_CPU_H
 
 #include "cpu-qom.h"
+#include "hw/registerfields.h"
 #include "exec/cpu-defs.h"
 #include "qemu/cpu-float.h"
 #include "tricore-defs.h"
@@ -199,13 +200,33 @@ struct ArchCPU {
 hwaddr tricore_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void tricore_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 
-
-#define MASK_PCXI_PCPN 0xff000000
-#define MASK_PCXI_PIE_1_3  0x00800000
-#define MASK_PCXI_PIE_1_6  0x00200000
-#define MASK_PCXI_UL   0x00400000
-#define MASK_PCXI_PCXS 0x000f0000
-#define MASK_PCXI_PCXO 0x0000ffff
+FIELD(PCXI, PCPN_13, 24, 8)
+FIELD(PCXI, PCPN_161, 22, 8)
+FIELD(PCXI, PIE_13, 23, 1)
+FIELD(PCXI, PIE_161, 21, 1)
+FIELD(PCXI, UL_13, 22, 1)
+FIELD(PCXI, UL_161, 20, 1)
+FIELD(PCXI, PCXS, 16, 4)
+FIELD(PCXI, PCXO, 0, 16)
+uint32_t pcxi_get_ul(CPUTriCoreState *env);
+uint32_t pcxi_get_pie(CPUTriCoreState *env);
+uint32_t pcxi_get_pcpn(CPUTriCoreState *env);
+uint32_t pcxi_get_pcxs(CPUTriCoreState *env);
+uint32_t pcxi_get_pcxo(CPUTriCoreState *env);
+void pcxi_set_ul(CPUTriCoreState *env, uint32_t val);
+void pcxi_set_pie(CPUTriCoreState *env, uint32_t val);
+void pcxi_set_pcpn(CPUTriCoreState *env, uint32_t val);
+
+FIELD(ICR, IE_161, 15, 1)
+FIELD(ICR, IE_13, 8, 1)
+FIELD(ICR, PIPN, 16, 8)
+FIELD(ICR, CCPN, 0, 8)
+
+uint32_t icr_get_ie(CPUTriCoreState *env);
+uint32_t icr_get_ccpn(CPUTriCoreState *env);
+
+void icr_set_ccpn(CPUTriCoreState *env, uint32_t val);
+void icr_set_ie(CPUTriCoreState *env, uint32_t val);
 
 #define MASK_PSW_USB 0xff000000
 #define MASK_USB_C   0x80000000
@@ -228,10 +249,6 @@ void tricore_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 #define MASK_CPUID_MOD_32B 0x0000ff00
 #define MASK_CPUID_REV     0x000000ff
 
-#define MASK_ICR_PIPN 0x00ff0000
-#define MASK_ICR_IE_1_3   0x00000100
-#define MASK_ICR_IE_1_6   0x00008000
-#define MASK_ICR_CCPN 0x000000ff
 
 #define MASK_FCX_FCXS 0x000f0000
 #define MASK_FCX_FCXO 0x0000ffff
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 114685cce4..284a749e50 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -17,6 +17,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "hw/registerfields.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "fpu/softfloat-helpers.h"
@@ -152,3 +153,47 @@ void psw_write(CPUTriCoreState *env, uint32_t val)
 
     fpu_set_state(env);
 }
+
+#define FIELD_GETTER_WITH_FEATURE(NAME, REG, FIELD, FEATURE)     \
+uint32_t NAME(CPUTriCoreState *env)                             \
+{                                                                \
+    if (tricore_feature(env, TRICORE_FEATURE_##FEATURE)) {       \
+        return FIELD_EX32(env->REG, REG, FIELD ## _ ## FEATURE); \
+    }                                                            \
+    return FIELD_EX32(env->REG, REG, FIELD ## _13);              \
+}
+
+#define FIELD_GETTER(NAME, REG, FIELD)       \
+uint32_t NAME(CPUTriCoreState *env)         \
+{                                            \
+    return FIELD_EX32(env->REG, REG, FIELD); \
+}
+
+#define FIELD_SETTER_WITH_FEATURE(NAME, REG, FIELD, FEATURE)              \
+void NAME(CPUTriCoreState *env, uint32_t val)                            \
+{                                                                         \
+    if (tricore_feature(env, TRICORE_FEATURE_##FEATURE)) {                \
+        env->REG = FIELD_DP32(env->REG, REG, FIELD ## _ ## FEATURE, val); \
+    }                                                                     \
+    env->REG = FIELD_DP32(env->REG, REG, FIELD ## _13, val);              \
+}
+
+#define FIELD_SETTER(NAME, REG, FIELD)                \
+void NAME(CPUTriCoreState *env, uint32_t val)        \
+{                                                     \
+    env->REG = FIELD_DP32(env->REG, REG, FIELD, val); \
+}
+
+FIELD_GETTER_WITH_FEATURE(pcxi_get_pcpn, PCXI, PCPN, 161)
+FIELD_SETTER_WITH_FEATURE(pcxi_set_pcpn, PCXI, PCPN, 161)
+FIELD_GETTER_WITH_FEATURE(pcxi_get_pie, PCXI, PIE, 161)
+FIELD_SETTER_WITH_FEATURE(pcxi_set_pie, PCXI, PIE, 161)
+FIELD_GETTER_WITH_FEATURE(pcxi_get_ul, PCXI, UL, 161)
+FIELD_SETTER_WITH_FEATURE(pcxi_set_ul, PCXI, UL, 161)
+FIELD_GETTER(pcxi_get_pcxs, PCXI, PCXS)
+FIELD_GETTER(pcxi_get_pcxo, PCXI, PCXO)
+
+FIELD_GETTER_WITH_FEATURE(icr_get_ie, ICR, IE, 161)
+FIELD_SETTER_WITH_FEATURE(icr_set_ie, ICR, IE, 161)
+FIELD_GETTER(icr_get_ccpn, ICR, CCPN)
+FIELD_SETTER(icr_set_ccpn, ICR, CCPN)
diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index 532ae6b74c..6fd2cbe20f 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -84,11 +84,10 @@ void raise_exception_sync_internal(CPUTriCoreState *env, uint32_t class, int tin
       ICR.IE and ICR.CCPN are saved */
 
     /* PCXI.PIE = ICR.IE */
-    env->PCXI = ((env->PCXI & ~MASK_PCXI_PIE_1_3) +
-                ((env->ICR & MASK_ICR_IE_1_3) << 15));
+    pcxi_set_pie(env, icr_get_ie(env));
+
     /* PCXI.PCPN = ICR.CCPN */
-    env->PCXI = (env->PCXI & 0xffffff) +
-                ((env->ICR & MASK_ICR_CCPN) << 24);
+    pcxi_set_pcpn(env, icr_get_ccpn(env));
     /* Update PC using the trap vector table */
     env->PC = env->BTV | (class << 5);
 
@@ -2461,13 +2460,11 @@ void helper_call(CPUTriCoreState *env, uint32_t next_pc)
     save_context_upper(env, ea);
 
     /* PCXI.PCPN = ICR.CCPN; */
-    env->PCXI = (env->PCXI & 0xffffff) +
-                ((env->ICR & MASK_ICR_CCPN) << 24);
+    pcxi_set_pcpn(env, icr_get_ccpn(env));
     /* PCXI.PIE = ICR.IE; */
-    env->PCXI = ((env->PCXI & ~MASK_PCXI_PIE_1_3) +
-                ((env->ICR & MASK_ICR_IE_1_3) << 15));
+    pcxi_set_pie(env, icr_get_ie(env));
     /* PCXI.UL = 1; */
-    env->PCXI |= MASK_PCXI_UL;
+    pcxi_set_ul(env, 1);
 
     /* PCXI[19: 0] = FCX[19: 0]; */
     env->PCXI = (env->PCXI & 0xfff00000) + (env->FCX & 0xfffff);
@@ -2506,7 +2503,7 @@ void helper_ret(CPUTriCoreState *env)
         raise_exception_sync_helper(env, TRAPC_CTX_MNG, TIN3_CSU, GETPC());
     }
     /* if (PCXI.UL == 0) then trap(CTYP); */
-    if ((env->PCXI & MASK_PCXI_UL) == 0) {
+    if (pcxi_get_ul(env) == 0) {
         /* CTYP trap */
         cdc_increment(&psw); /* restore to the start of helper */
         psw_write(env, psw);
@@ -2516,8 +2513,8 @@ void helper_ret(CPUTriCoreState *env)
     env->PC = env->gpr_a[11] & 0xfffffffe;
 
     /* EA = {PCXI.PCXS, 6'b0, PCXI.PCXO, 6'b0}; */
-    ea = ((env->PCXI & MASK_PCXI_PCXS) << 12) +
-         ((env->PCXI & MASK_PCXI_PCXO) << 6);
+    ea = (pcxi_get_pcxs(env) << 28) |
+         (pcxi_get_pcxo(env) << 6);
     /* {new_PCXI, new_PSW, A[10], A[11], D[8], D[9], D[10], D[11], A[12],
         A[13], A[14], A[15], D[12], D[13], D[14], D[15]} = M(EA, 16 * word); */
     restore_context_upper(env, ea, &new_PCXI, &new_PSW);
@@ -2559,21 +2556,21 @@ void helper_bisr(CPUTriCoreState *env, uint32_t const9)
 
 
     /* PCXI.PCPN = ICR.CCPN */
-    env->PCXI = (env->PCXI & 0xffffff) +
-                 ((env->ICR & MASK_ICR_CCPN) << 24);
+    pcxi_set_pcpn(env, icr_get_ccpn(env));
     /* PCXI.PIE  = ICR.IE */
-    env->PCXI = ((env->PCXI & ~MASK_PCXI_PIE_1_3) +
-                 ((env->ICR & MASK_ICR_IE_1_3) << 15));
+    pcxi_set_pie(env, icr_get_ie(env));
     /* PCXI.UL = 0 */
-    env->PCXI &= ~(MASK_PCXI_UL);
+    pcxi_set_ul(env, 0);
+
     /* PCXI[19: 0] = FCX[19: 0] */
     env->PCXI = (env->PCXI & 0xfff00000) + (env->FCX & 0xfffff);
     /* FXC[19: 0] = new_FCX[19: 0] */
     env->FCX = (env->FCX & 0xfff00000) + (new_FCX & 0xfffff);
+
     /* ICR.IE = 1 */
-    env->ICR |= MASK_ICR_IE_1_3;
+    icr_set_ie(env, 1);
 
-    env->ICR |= const9; /* ICR.CCPN = const9[7: 0];*/
+    icr_set_ccpn(env, const9);
 
     if (tmp_FCX == env->LCX) {
         /* FCD trap */
@@ -2592,7 +2589,7 @@ void helper_rfe(CPUTriCoreState *env)
         raise_exception_sync_helper(env, TRAPC_CTX_MNG, TIN3_CSU, GETPC());
     }
     /* if (PCXI.UL == 0) then trap(CTYP); */
-    if ((env->PCXI & MASK_PCXI_UL) == 0) {
+    if (pcxi_get_ul(env) == 0) {
         /* raise CTYP trap */
         raise_exception_sync_helper(env, TRAPC_CTX_MNG, TIN3_CTYP, GETPC());
     }
@@ -2603,14 +2600,15 @@ void helper_rfe(CPUTriCoreState *env)
     }
     env->PC = env->gpr_a[11] & ~0x1;
     /* ICR.IE = PCXI.PIE; */
-    env->ICR = (env->ICR & ~MASK_ICR_IE_1_3)
-            + ((env->PCXI & MASK_PCXI_PIE_1_3) >> 15);
+    icr_set_ie(env, pcxi_get_pie(env));
+
     /* ICR.CCPN = PCXI.PCPN; */
-    env->ICR = (env->ICR & ~MASK_ICR_CCPN) +
-               ((env->PCXI & MASK_PCXI_PCPN) >> 24);
+    icr_set_ccpn(env, pcxi_get_pcpn(env));
+
     /*EA = {PCXI.PCXS, 6'b0, PCXI.PCXO, 6'b0};*/
-    ea = ((env->PCXI & MASK_PCXI_PCXS) << 12) +
-         ((env->PCXI & MASK_PCXI_PCXO) << 6);
+    ea = (pcxi_get_pcxs(env) << 28) |
+         (pcxi_get_pcxo(env) << 6);
+
     /*{new_PCXI, PSW, A[10], A[11], D[8], D[9], D[10], D[11], A[12],
       A[13], A[14], A[15], D[12], D[13], D[14], D[15]} = M(EA, 16 * word); */
     restore_context_upper(env, ea, &new_PCXI, &new_PSW);
@@ -2628,11 +2626,10 @@ void helper_rfm(CPUTriCoreState *env)
 {
     env->PC = (env->gpr_a[11] & ~0x1);
     /* ICR.IE = PCXI.PIE; */
-    env->ICR = (env->ICR & ~MASK_ICR_IE_1_3)
-            | ((env->PCXI & MASK_PCXI_PIE_1_3) >> 15);
+    icr_set_ie(env, pcxi_get_pie(env));
     /* ICR.CCPN = PCXI.PCPN; */
-    env->ICR = (env->ICR & ~MASK_ICR_CCPN) |
-               ((env->PCXI & MASK_PCXI_PCPN) >> 24);
+    icr_set_ccpn(env, pcxi_get_pcpn(env));
+
     /* {PCXI, PSW, A[10], A[11]} = M(DCX, 4 * word); */
     env->PCXI = cpu_ldl_data(env, env->DCX);
     psw_write(env, cpu_ldl_data(env, env->DCX+4));
@@ -2691,13 +2688,13 @@ void helper_svlcx(CPUTriCoreState *env)
     save_context_lower(env, ea);
 
     /* PCXI.PCPN = ICR.CCPN; */
-    env->PCXI = (env->PCXI & 0xffffff) +
-                ((env->ICR & MASK_ICR_CCPN) << 24);
+    pcxi_set_pcpn(env, icr_get_ccpn(env));
+
     /* PCXI.PIE = ICR.IE; */
-    env->PCXI = ((env->PCXI & ~MASK_PCXI_PIE_1_3) +
-                ((env->ICR & MASK_ICR_IE_1_3) << 15));
+    pcxi_set_pie(env, icr_get_ie(env));
+
     /* PCXI.UL = 0; */
-    env->PCXI &= ~MASK_PCXI_UL;
+    pcxi_set_ul(env, 0);
 
     /* PCXI[19: 0] = FCX[19: 0]; */
     env->PCXI = (env->PCXI & 0xfff00000) + (env->FCX & 0xfffff);
@@ -2734,13 +2731,13 @@ void helper_svucx(CPUTriCoreState *env)
     save_context_upper(env, ea);
 
     /* PCXI.PCPN = ICR.CCPN; */
-    env->PCXI = (env->PCXI & 0xffffff) +
-                ((env->ICR & MASK_ICR_CCPN) << 24);
+    pcxi_set_pcpn(env, icr_get_ccpn(env));
+
     /* PCXI.PIE = ICR.IE; */
-    env->PCXI = ((env->PCXI & ~MASK_PCXI_PIE_1_3) +
-                ((env->ICR & MASK_ICR_IE_1_3) << 15));
+    pcxi_set_pie(env, icr_get_ie(env));
+
     /* PCXI.UL = 1; */
-    env->PCXI |= MASK_PCXI_UL;
+    pcxi_set_ul(env, 1);
 
     /* PCXI[19: 0] = FCX[19: 0]; */
     env->PCXI = (env->PCXI & 0xfff00000) + (env->FCX & 0xfffff);
@@ -2764,13 +2761,15 @@ void helper_rslcx(CPUTriCoreState *env)
         raise_exception_sync_helper(env, TRAPC_CTX_MNG, TIN3_CSU, GETPC());
     }
     /* if (PCXI.UL == 1) then trap(CTYP); */
-    if ((env->PCXI & MASK_PCXI_UL) != 0) {
+    if (pcxi_get_ul(env) == 1) {
         /* CTYP trap */
         raise_exception_sync_helper(env, TRAPC_CTX_MNG, TIN3_CTYP, GETPC());
     }
     /* EA = {PCXI.PCXS, 6'b0, PCXI.PCXO, 6'b0}; */
-    ea = ((env->PCXI & MASK_PCXI_PCXS) << 12) +
-         ((env->PCXI & MASK_PCXI_PCXO) << 6);
+    /* EA = {PCXI.PCXS, 6'b0, PCXI.PCXO, 6'b0}; */
+    ea = (pcxi_get_pcxs(env) << 28) |
+         (pcxi_get_pcxo(env) << 6);
+
     /* {new_PCXI, A[11], A[10], A[11], D[8], D[9], D[10], D[11], A[12],
         A[13], A[14], A[15], D[12], D[13], D[14], D[15]} = M(EA, 16 * word); */
     restore_context_lower(env, ea, &env->gpr_a[11], &new_PCXI);
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 2646cb3eb5..e7bbfb062d 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -72,6 +72,7 @@ typedef struct DisasContext {
     int mem_idx;
     uint32_t hflags, saved_hflags;
     uint64_t features;
+    uint32_t icr_ie_mask;
 } DisasContext;
 
 static int has_feature(DisasContext *ctx, int feature)
@@ -7847,12 +7848,12 @@ static void decode_sys_interrupts(DisasContext *ctx)
         /* raise EXCP_DEBUG */
         break;
     case OPC2_32_SYS_DISABLE:
-        tcg_gen_andi_tl(cpu_ICR, cpu_ICR, ~MASK_ICR_IE_1_3);
+        tcg_gen_andi_tl(cpu_ICR, cpu_ICR, ~ctx->icr_ie_mask);
         break;
     case OPC2_32_SYS_DSYNC:
         break;
     case OPC2_32_SYS_ENABLE:
-        tcg_gen_ori_tl(cpu_ICR, cpu_ICR, MASK_ICR_IE_1_3);
+        tcg_gen_ori_tl(cpu_ICR, cpu_ICR, ctx->icr_ie_mask);
         break;
     case OPC2_32_SYS_ISYNC:
         break;
@@ -8256,6 +8257,11 @@ static void tricore_tr_init_disas_context(DisasContextBase *dcbase,
     ctx->mem_idx = cpu_mmu_index(env, false);
     ctx->hflags = (uint32_t)ctx->base.tb->flags;
     ctx->features = env->features;
+    if (has_feature(ctx, TRICORE_FEATURE_161)) {
+        ctx->icr_ie_mask = R_ICR_IE_161_MASK;
+    } else {
+        ctx->icr_ie_mask = R_ICR_IE_13_MASK;
+    }
 }
 
 static void tricore_tr_tb_start(DisasContextBase *db, CPUState *cpu)
-- 
2.40.1


