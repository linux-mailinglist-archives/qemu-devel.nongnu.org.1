Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD648738AAB
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 18:16:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC0VB-0008WR-Ta; Wed, 21 Jun 2023 12:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qC0V6-0008Nc-Jq
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 12:16:08 -0400
Received: from shirlock.uni-paderborn.de ([2001:638:502:c003::15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qC0V4-0007zS-Rt
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 12:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nlc0ZNAasekDd1GKZQXApEIB0yfFl1cp0KLLmIEVn88=; b=MPVwjlUw1+Sqwu1zeKt5WK4pBc
 wYy95K6uVBA+cFKB6QtChL26LLAQggjVeAHDz94BKK/3bmhB8r3j8bqyQGkOL4f+FonOCttkDKUMi
 vESUVwTUl5I3GAwN7wvOu4gsJWC/LAUlbSOoMOZndbM+6yDpZ4CU/EzL6+VOea3ktdjo=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 17/20] target/tricore: Introduce priv tb flag
Date: Wed, 21 Jun 2023 18:14:19 +0200
Message-Id: <20230621161422.1652151-18-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621161422.1652151-1-kbastian@mail.uni-paderborn.de>
References: <20230621161422.1652151-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.6.21.160616, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.6.6.600001
X-Sophos-SenderHistory: ip=79.202.219.6, fs=1209056, da=174973229, mc=175, sc=0,
 hc=175, sp=0, fso=1209056, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::15;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=shirlock.uni-paderborn.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-Id: <20230621142302.1648383-6-kbastian@mail.uni-paderborn.de>
---
 target/tricore/cpu.h       | 17 ++++++++++++-----
 target/tricore/translate.c | 14 ++++++++------
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 041fc0b6e5..257fcf3cee 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -263,10 +263,11 @@ void icr_set_ie(CPUTriCoreState *env, uint32_t val);
 #define MASK_DBGSR_PEVT 0x40
 #define MASK_DBGSR_EVTSRC 0x1f00
 
-#define TRICORE_HFLAG_KUU     0x3
-#define TRICORE_HFLAG_UM0     0x00002 /* user mode-0 flag          */
-#define TRICORE_HFLAG_UM1     0x00001 /* user mode-1 flag          */
-#define TRICORE_HFLAG_SM      0x00000 /* kernel mode flag          */
+enum tricore_priv_levels {
+    TRICORE_PRIV_UM0 = 0x0, /* user mode-0 flag */
+    TRICORE_PRIV_UM1 = 0x1, /* user mode-1 flag */
+    TRICORE_PRIV_SM  = 0x2, /* kernel mode flag */
+};
 
 enum tricore_features {
     TRICORE_FEATURE_13,
@@ -378,15 +379,21 @@ static inline int cpu_mmu_index(CPUTriCoreState *env, bool ifetch)
 
 #include "exec/cpu-all.h"
 
+FIELD(TB_FLAGS, PRIV, 0, 2)
+
 void cpu_state_reset(CPUTriCoreState *s);
 void tricore_tcg_init(void);
 
 static inline void cpu_get_tb_cpu_state(CPUTriCoreState *env, target_ulong *pc,
                                         target_ulong *cs_base, uint32_t *flags)
 {
+    uint32_t new_flags = 0;
     *pc = env->PC;
     *cs_base = 0;
-    *flags = 0;
+
+    new_flags |= FIELD_DP32(new_flags, TB_FLAGS, PRIV,
+            extract32(env->PSW, 10, 2));
+    *flags = new_flags;
 }
 
 #define TRICORE_CPU_TYPE_SUFFIX "-" TYPE_TRICORE_CPU
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index fb6f0caa24..6932a54663 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -76,7 +76,7 @@ typedef struct DisasContext {
     uint32_t opcode;
     /* Routine used to access memory */
     int mem_idx;
-    uint32_t hflags, saved_hflags;
+    int priv;
     uint64_t features;
     uint32_t icr_ie_mask, icr_ie_offset;
 } DisasContext;
@@ -378,7 +378,7 @@ static inline void gen_mfcr(DisasContext *ctx, TCGv ret, int32_t offset)
 static inline void gen_mtcr(DisasContext *ctx, TCGv r1,
                             int32_t offset)
 {
-    if ((ctx->hflags & TRICORE_HFLAG_KUU) == TRICORE_HFLAG_SM) {
+    if (ctx->priv == TRICORE_PRIV_SM) {
         /* since we're caching PSW make this a special case */
         if (offset == 0xfe04) {
             gen_helper_psw_write(cpu_env, r1);
@@ -7920,7 +7920,7 @@ static void decode_sys_interrupts(DisasContext *ctx)
         ctx->base.is_jmp = DISAS_EXIT;
         break;
     case OPC2_32_SYS_RFM:
-        if ((ctx->hflags & TRICORE_HFLAG_KUU) == TRICORE_HFLAG_SM) {
+        if (ctx->priv  == TRICORE_PRIV_SM) {
             tmp = tcg_temp_new();
             l1 = gen_new_label();
 
@@ -7942,8 +7942,7 @@ static void decode_sys_interrupts(DisasContext *ctx)
         break;
     case OPC2_32_SYS_RESTORE:
         if (has_feature(ctx, TRICORE_FEATURE_16)) {
-            if ((ctx->hflags & TRICORE_HFLAG_KUU) == TRICORE_HFLAG_SM ||
-                (ctx->hflags & TRICORE_HFLAG_KUU) == TRICORE_HFLAG_UM1) {
+            if (ctx->priv == TRICORE_PRIV_SM || ctx->priv == TRICORE_PRIV_UM1) {
                 tcg_gen_deposit_tl(cpu_ICR, cpu_ICR, cpu_gpr_d[r1], 8, 1);
             } /* else raise privilege trap */
         } else {
@@ -8313,7 +8312,10 @@ static void tricore_tr_init_disas_context(DisasContextBase *dcbase,
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPUTriCoreState *env = cs->env_ptr;
     ctx->mem_idx = cpu_mmu_index(env, false);
-    ctx->hflags = (uint32_t)ctx->base.tb->flags;
+
+    uint32_t tb_flags = (uint32_t)ctx->base.tb->flags;
+    ctx->priv = FIELD_EX32(tb_flags, TB_FLAGS, PRIV);
+
     ctx->features = env->features;
     if (has_feature(ctx, TRICORE_FEATURE_161)) {
         ctx->icr_ie_mask = R_ICR_IE_161_MASK;
-- 
2.40.1


