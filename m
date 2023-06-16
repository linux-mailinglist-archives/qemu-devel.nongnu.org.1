Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E37097334D3
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 17:30:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qABNd-00052n-T2; Fri, 16 Jun 2023 11:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qABNb-00052E-J0
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 11:28:51 -0400
Received: from nylar.uni-paderborn.de ([2001:638:502:c003::18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qABNZ-0000sd-QZ
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 11:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yNf4tbUyLyP6JB+uE70atwxQodpocSJZippgY4iTZ8M=; b=UCV8MuIcERlA9mxKCF82jjkKl6
 XNbhHRJPKlFS0XMSoaLiVH1zyfReQ0up2Sr4YDmF8kspFMSFDYcQ56vAYqySIMvTcnCTZbZN4vunB
 Q2Aq/HDyVY8yX0cbEHWn3/909sCCVsWN0IRoL9Uq95c3W6zZGU1Oo/RBRdF4NsTaFurk=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de,
	richard.henderson@linaro.org
Subject: [PATCH v2 6/8] target/tricore: Implement privilege level for all insns
Date: Fri, 16 Jun 2023 17:28:06 +0200
Message-Id: <20230616152808.1499082-7-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230616152808.1499082-1-kbastian@mail.uni-paderborn.de>
References: <20230616152808.1499082-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.6.16.151517, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.6.16.600001
X-Sophos-SenderHistory: ip=79.202.219.6, fs=774218, da=174538391, mc=96, sc=0,
 hc=96, sp=0, fso=774218, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::18;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=nylar.uni-paderborn.de
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
---
 target/tricore/translate.c | 47 ++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 44f1c1022f..71e3842601 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -387,7 +387,7 @@ static inline void gen_mtcr(DisasContext *ctx, TCGv r1,
             }
         }
     } else {
-        /* generate privilege trap */
+        generate_trap(ctx, TRAPC_PROT, TIN1_PRIV);
     }
 }
 
@@ -3373,7 +3373,11 @@ static void decode_sc_opc(DisasContext *ctx, int op1)
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
@@ -5234,7 +5238,11 @@ static void decode_rc_serviceroutine(DisasContext *ctx)
 
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
@@ -7881,22 +7889,35 @@ static void decode_sys_interrupts(DisasContext *ctx)
         /* raise EXCP_DEBUG */
         break;
     case OPC2_32_SYS_DISABLE:
-        tcg_gen_andi_tl(cpu_ICR, cpu_ICR, ~ctx->icr_ie_mask);
-        ctx->base.is_jmp = DISAS_EXIT_UPDATE;
+        if (ctx->priv == TRICORE_PRIV_SM || ctx->priv == TRICORE_PRIV_UM1) {
+            tcg_gen_andi_tl(cpu_ICR, cpu_ICR, ~ctx->icr_ie_mask);
+            ctx->base.is_jmp = DISAS_EXIT_UPDATE;
+        } else {
+            generate_trap(ctx, TRAPC_PROT, TIN1_PRIV);
+        }
         break;
     case OPC2_32_SYS_DISABLE_D:
         if (has_feature(ctx, TRICORE_FEATURE_16)) {
-            tcg_gen_extract_tl(cpu_gpr_d[r1], cpu_ICR, ctx->icr_ie_offset, 1);
-            tcg_gen_andi_tl(cpu_ICR, cpu_ICR, ~ctx->icr_ie_mask);
-            ctx->base.is_jmp = DISAS_EXIT_UPDATE;
+            if (ctx->priv == TRICORE_PRIV_SM || ctx->priv == TRICORE_PRIV_UM1) {
+                tcg_gen_extract_tl(cpu_gpr_d[r1], cpu_ICR,
+                        ctx->icr_ie_offset, 1);
+                tcg_gen_andi_tl(cpu_ICR, cpu_ICR, ~ctx->icr_ie_mask);
+                ctx->base.is_jmp = DISAS_EXIT_UPDATE;
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
@@ -7924,7 +7945,7 @@ static void decode_sys_interrupts(DisasContext *ctx)
             gen_set_label(l1);
             ctx->base.is_jmp = DISAS_EXIT;
         } else {
-            /* generate privilege trap */
+            generate_trap(ctx, TRAPC_PROT, TIN1_PRIV);
         }
         break;
     case OPC2_32_SYS_RSLCX:
@@ -7937,7 +7958,9 @@ static void decode_sys_interrupts(DisasContext *ctx)
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


