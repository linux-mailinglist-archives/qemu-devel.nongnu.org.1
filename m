Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFAC738ACF
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 18:19:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC0VF-0000fk-83; Wed, 21 Jun 2023 12:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qC0VC-0000Re-Jx
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 12:16:14 -0400
Received: from shirlock.uni-paderborn.de ([2001:638:502:c003::15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qC0VA-00080v-MC
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 12:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EQpWpQnLiomynqxhE3cr7hwHoEhqu0WqAa0Qf1eRA+U=; b=OdqOR4yEuVL/ujN4CZ7yzucGDo
 a9ZGlG/CH9i3olThwz0NssAq4ZfA6omdQQx3IRhaCPUofnMbA1cpmJdKKNhIUBxw4+mm4NqVMJH0S
 WiOBM3/mTB8Hzu/cQWg6rJWKxbmXjD2u8EOSdNhgr+CNWyS22wR+ZsrpPm/iYJcPhUeM=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 18/20] target/tricore: Implement privilege level for all insns
Date: Wed, 21 Jun 2023 18:14:20 +0200
Message-Id: <20230621161422.1652151-19-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621161422.1652151-1-kbastian@mail.uni-paderborn.de>
References: <20230621161422.1652151-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.6.21.160616, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.6.6.600001
X-Sophos-SenderHistory: ip=79.202.219.6, fs=1209061, da=174973234, mc=177, sc=0,
 hc=177, sp=0, fso=1209061, re=0, sd=0, hd=0
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
Message-Id: <20230621142302.1648383-7-kbastian@mail.uni-paderborn.de>
---
 target/tricore/translate.c | 43 +++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 6932a54663..82b61e912e 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -388,7 +388,7 @@ static inline void gen_mtcr(DisasContext *ctx, TCGv r1,
             }
         }
     } else {
-        /* generate privilege trap */
+        generate_trap(ctx, TRAPC_PROT, TIN1_PRIV);
     }
 }
 
@@ -3375,7 +3375,11 @@ static void decode_sc_opc(DisasContext *ctx, int op1)
         tcg_gen_andi_tl(cpu_gpr_d[15], cpu_gpr_d[15], const16);
         break;
     case OPC1_16_SC_BISR:
-        gen_helper_1arg(bisr, const16 & 0xff);
+        if (ctx->priv == TRICORE_PRIV_SM) {
+            gen_helper_1arg(bisr, const16 & 0xff);
+        } else {
+            generate_trap(ctx, TRAPC_PROT, TIN1_PRIV);
+        }
         break;
     case OPC1_16_SC_LD_A:
         gen_offset_ld(ctx, cpu_gpr_a[15], cpu_gpr_a[10], const16 * 4, MO_LESL);
@@ -5236,7 +5240,11 @@ static void decode_rc_serviceroutine(DisasContext *ctx)
 
     switch (op2) {
     case OPC2_32_RC_BISR:
-        gen_helper_1arg(bisr, const9);
+        if (ctx->priv == TRICORE_PRIV_SM) {
+            gen_helper_1arg(bisr, const9);
+        } else {
+            generate_trap(ctx, TRAPC_PROT, TIN1_PRIV);
+        }
         break;
     case OPC2_32_RC_SYSCALL:
         generate_trap(ctx, TRAPC_SYSCALL, const9 & 0xff);
@@ -7890,20 +7898,33 @@ static void decode_sys_interrupts(DisasContext *ctx)
         /* raise EXCP_DEBUG */
         break;
     case OPC2_32_SYS_DISABLE:
-        tcg_gen_andi_tl(cpu_ICR, cpu_ICR, ~ctx->icr_ie_mask);
+        if (ctx->priv == TRICORE_PRIV_SM || ctx->priv == TRICORE_PRIV_UM1) {
+            tcg_gen_andi_tl(cpu_ICR, cpu_ICR, ~ctx->icr_ie_mask);
+        } else {
+            generate_trap(ctx, TRAPC_PROT, TIN1_PRIV);
+        }
         break;
     case OPC2_32_SYS_DISABLE_D:
         if (has_feature(ctx, TRICORE_FEATURE_16)) {
-            tcg_gen_extract_tl(cpu_gpr_d[r1], cpu_ICR, ctx->icr_ie_offset, 1);
-            tcg_gen_andi_tl(cpu_ICR, cpu_ICR, ~ctx->icr_ie_mask);
+            if (ctx->priv == TRICORE_PRIV_SM || ctx->priv == TRICORE_PRIV_UM1) {
+                tcg_gen_extract_tl(cpu_gpr_d[r1], cpu_ICR,
+                        ctx->icr_ie_offset, 1);
+                tcg_gen_andi_tl(cpu_ICR, cpu_ICR, ~ctx->icr_ie_mask);
+            } else {
+                generate_trap(ctx, TRAPC_PROT, TIN1_PRIV);
+            }
         } else {
             generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
         }
     case OPC2_32_SYS_DSYNC:
         break;
     case OPC2_32_SYS_ENABLE:
-        tcg_gen_ori_tl(cpu_ICR, cpu_ICR, ctx->icr_ie_mask);
-        ctx->base.is_jmp = DISAS_EXIT_UPDATE;
+        if (ctx->priv == TRICORE_PRIV_SM || ctx->priv == TRICORE_PRIV_UM1) {
+            tcg_gen_ori_tl(cpu_ICR, cpu_ICR, ctx->icr_ie_mask);
+            ctx->base.is_jmp = DISAS_EXIT_UPDATE;
+        } else {
+            generate_trap(ctx, TRAPC_PROT, TIN1_PRIV);
+        }
         break;
     case OPC2_32_SYS_ISYNC:
         break;
@@ -7931,7 +7952,7 @@ static void decode_sys_interrupts(DisasContext *ctx)
             gen_set_label(l1);
             ctx->base.is_jmp = DISAS_EXIT;
         } else {
-            /* generate privilege trap */
+            generate_trap(ctx, TRAPC_PROT, TIN1_PRIV);
         }
         break;
     case OPC2_32_SYS_RSLCX:
@@ -7944,7 +7965,9 @@ static void decode_sys_interrupts(DisasContext *ctx)
         if (has_feature(ctx, TRICORE_FEATURE_16)) {
             if (ctx->priv == TRICORE_PRIV_SM || ctx->priv == TRICORE_PRIV_UM1) {
                 tcg_gen_deposit_tl(cpu_ICR, cpu_ICR, cpu_gpr_d[r1], 8, 1);
-            } /* else raise privilege trap */
+            } else {
+                generate_trap(ctx, TRAPC_PROT, TIN1_PRIV);
+            }
         } else {
             generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
         }
-- 
2.40.1


