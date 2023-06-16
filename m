Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B397334C4
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 17:29:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qABNI-0004al-0g; Fri, 16 Jun 2023 11:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qABNG-0004WM-3z
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 11:28:30 -0400
Received: from doohan.uni-paderborn.de ([2001:638:502:c003::16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qABNE-0000lj-C8
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 11:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Kzvo8ysZObzbW1ktzp/oQv3CPD8KvdGjF7Qlr2NVheo=; b=Az6vvgATXHPlaUQZhsFzbM4tve
 4HnaX6ebm/jH/EhcTEd+yWCDmf+93dfx6y0jEuYHzxh/A/jEG2FMAXzlSlqQB6fMQK718AoQFglnb
 tdkARJtX1uCipWQIOesHEIiAgwBf70vFShKn/ijH00Qq44M27MpSb9oIkUwYu0gYQ9aA=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de,
	richard.henderson@linaro.org
Subject: [PATCH v2 2/8] target/tricore: Introduce DISAS_TARGET_EXIT
Date: Fri, 16 Jun 2023 17:28:02 +0200
Message-Id: <20230616152808.1499082-3-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230616152808.1499082-1-kbastian@mail.uni-paderborn.de>
References: <20230616152808.1499082-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.6.16.151517, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.6.6.600001
X-Sophos-SenderHistory: ip=79.202.219.6, fs=774195, da=174538368, mc=88, sc=0,
 hc=88, sp=0, fso=774195, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::16;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=doohan.uni-paderborn.de
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

this replaces all calls to tcg_gen_exit_tb() and moves them to
tricore_tb_stop().

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/translate.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 1d522d3b50..d4f7415158 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -37,6 +37,7 @@
 #include "exec/helper-info.c.inc"
 #undef  HELPER_H
 
+#define DISAS_EXIT        DISAS_TARGET_0
 
 /*
  * TCG registers
@@ -2835,6 +2836,7 @@ static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
         gen_save_pc(dest);
         tcg_gen_lookup_and_goto_ptr();
     }
+    ctx->base.is_jmp = DISAS_NORETURN;
 }
 
 static void generate_trap(DisasContext *ctx, int class, int tin)
@@ -2895,8 +2897,7 @@ static void gen_fret(DisasContext *ctx)
     tcg_gen_qemu_ld_tl(cpu_gpr_a[11], cpu_gpr_a[10], ctx->mem_idx, MO_LESL);
     tcg_gen_addi_tl(cpu_gpr_a[10], cpu_gpr_a[10], 4);
     tcg_gen_mov_tl(cpu_PC, temp);
-    tcg_gen_exit_tb(NULL, 0);
-    ctx->base.is_jmp = DISAS_NORETURN;
+    ctx->base.is_jmp = DISAS_EXIT;
 }
 
 static void gen_compute_branch(DisasContext *ctx, uint32_t opc, int r1,
@@ -2995,12 +2996,12 @@ static void gen_compute_branch(DisasContext *ctx, uint32_t opc, int r1,
 /* SR-format jumps */
     case OPC1_16_SR_JI:
         tcg_gen_andi_tl(cpu_PC, cpu_gpr_a[r1], 0xfffffffe);
-        tcg_gen_exit_tb(NULL, 0);
+        ctx->base.is_jmp = DISAS_EXIT;
         break;
     case OPC2_32_SYS_RET:
     case OPC2_16_SR_RET:
         gen_helper_ret(cpu_env);
-        tcg_gen_exit_tb(NULL, 0);
+        ctx->base.is_jmp = DISAS_EXIT;
         break;
 /* B-format */
     case OPC1_32_B_CALLA:
@@ -3152,7 +3153,6 @@ static void gen_compute_branch(DisasContext *ctx, uint32_t opc, int r1,
     default:
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
     }
-    ctx->base.is_jmp = DISAS_NORETURN;
 }
 
 
@@ -3493,8 +3493,7 @@ static void decode_sr_system(DisasContext *ctx)
         break;
     case OPC2_16_SR_RFE:
         gen_helper_rfe(cpu_env);
-        tcg_gen_exit_tb(NULL, 0);
-        ctx->base.is_jmp = DISAS_NORETURN;
+        ctx->base.is_jmp = DISAS_EXIT;
         break;
     case OPC2_16_SR_DEBUG:
         /* raise EXCP_DEBUG */
@@ -6075,8 +6074,7 @@ static void decode_rr_idirect(DisasContext *ctx)
     default:
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
     }
-    tcg_gen_exit_tb(NULL, 0);
-    ctx->base.is_jmp = DISAS_NORETURN;
+    ctx->base.is_jmp = DISAS_EXIT;
 }
 
 static void decode_rr_divide(DisasContext *ctx)
@@ -7907,8 +7905,7 @@ static void decode_sys_interrupts(DisasContext *ctx)
         break;
     case OPC2_32_SYS_RFE:
         gen_helper_rfe(cpu_env);
-        tcg_gen_exit_tb(NULL, 0);
-        ctx->base.is_jmp = DISAS_NORETURN;
+        ctx->base.is_jmp = DISAS_EXIT;
         break;
     case OPC2_32_SYS_RFM:
         if ((ctx->hflags & TRICORE_HFLAG_KUU) == TRICORE_HFLAG_SM) {
@@ -7920,8 +7917,7 @@ static void decode_sys_interrupts(DisasContext *ctx)
             tcg_gen_brcondi_tl(TCG_COND_NE, tmp, 1, l1);
             gen_helper_rfm(cpu_env);
             gen_set_label(l1);
-            tcg_gen_exit_tb(NULL, 0);
-            ctx->base.is_jmp = DISAS_NORETURN;
+            ctx->base.is_jmp = DISAS_EXIT;
         } else {
             /* generate privilege trap */
         }
@@ -8383,6 +8379,9 @@ static void tricore_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
     case DISAS_TOO_MANY:
         gen_goto_tb(ctx, 0, ctx->base.pc_next);
         break;
+    case DISAS_EXIT:
+        tcg_gen_exit_tb(NULL, 0);
+        break;
     case DISAS_NORETURN:
         break;
     default:
-- 
2.40.1


