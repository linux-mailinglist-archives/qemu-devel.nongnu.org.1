Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B052B7C7F2E
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:00:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCxg-0008Oc-41; Fri, 13 Oct 2023 03:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCww-0006AT-S4
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:51:11 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCwh-0004t5-Ci
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:51:09 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4054f790190so20880385e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183453; x=1697788253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZZoxu2fQjlSrHAg6BVR82z3xBTX4HSZAJalvN6ykP5U=;
 b=aMjila57uCtfxHVQxEGRVKSHR8anZJGrqkZjuRTk6kNyGmQedNNMjJ+qTWkLQyqGYm
 hYWhpzYNUeD/SdFGqliSAnuYupVBuus7iQY+PJRkyxddQ168D9NQxQjYlaPzY/IrLzk7
 3WqtXae7JEFlUZ3fDI2wsEu5A/TVgmSdsicbAXgK7+fjY5m4JYeLPQuAIkwbGrpOflu7
 MdyzKMBUQy9P14my8nwdiTOrJdN2eK0tAU3tR7lCrXa9JVklOm6ltk4NUXEzBNCMlnun
 MyaKMpITERVJ1E/khlpM2dBLDKpx8DVv7Ef/5xjx/mZODHNPNC13gx3IpdwBSsG2c2E2
 slyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183453; x=1697788253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZZoxu2fQjlSrHAg6BVR82z3xBTX4HSZAJalvN6ykP5U=;
 b=lYJ4ygd69SZVa8jQe7usbOpyuhGEg7UhtwVGYjOdDUrJcTsg7cwSjKINztbDjif+xZ
 VugHpSwjHejMm9SSDhbqjFzzyDW0RzvCFOe9aJGIBUPkCHk7BA+oHl4ekSzYCoY2k1vy
 2RtXOzobH7KxtunEM7KjLzMN7kkvD3tXZH5IrGVnuE2aBQv9R6egmwhR2uxmUg+cheWG
 dj5phbZUbvL/mpCpZOiF/eEBcSf1oqQtgYhTKVwdqueDLrd4yEujV5jLfyhFRX+2zPID
 EfsCERmv9KQSOCxw8pmUjT+Q0805BP3IyLeEatjBe162yA9XFhzipCRVb87QFe0nKcFe
 lbdg==
X-Gm-Message-State: AOJu0YxeKZGy7VEYerWb9hmgHfZPFPVsD7F9gMhb0Vgrjn8l/abOONSr
 fxWYS4sYcssuVo1NHfNljhR/gx7gfMesZCpiQxI=
X-Google-Smtp-Source: AGHT+IGbgiJdf7kXcdyGpwJGGjsia/DdiJKWsNpD2ki/zxZBaEbpueoQMkwAJem+5X15SM655zEI8Q==
X-Received: by 2002:adf:a41e:0:b0:32d:3e9d:fddf with SMTP id
 d30-20020adfa41e000000b0032d3e9dfddfmr7888113wra.50.1697183453159; 
 Fri, 13 Oct 2023 00:50:53 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:50:52 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: [RFC PATCH 34/78] target/tricore: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:47:38 +0300
Message-Id: <367c842370fcabd0d61ec69646d49ad120bf34f7.1697183082.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 target/tricore/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index dd812ec0f0..4e42f06ec8 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -2899,259 +2899,259 @@ static void gen_fret(DisasContext *ctx)
 static void gen_compute_branch(DisasContext *ctx, uint32_t opc, int r1,
                                int r2 , int32_t constant , int32_t offset)
 {
     TCGv temp, temp2;
     int n;
 
     switch (opc) {
 /* SB-format jumps */
     case OPC1_16_SB_J:
     case OPC1_32_B_J:
         gen_goto_tb(ctx, 0, ctx->base.pc_next + offset * 2);
         break;
     case OPC1_32_B_CALL:
     case OPC1_16_SB_CALL:
         gen_helper_1arg(call, ctx->pc_succ_insn);
         gen_goto_tb(ctx, 0, ctx->base.pc_next + offset * 2);
         break;
     case OPC1_16_SB_JZ:
         gen_branch_condi(ctx, TCG_COND_EQ, cpu_gpr_d[15], 0, offset);
         break;
     case OPC1_16_SB_JNZ:
         gen_branch_condi(ctx, TCG_COND_NE, cpu_gpr_d[15], 0, offset);
         break;
 /* SBC-format jumps */
     case OPC1_16_SBC_JEQ:
         gen_branch_condi(ctx, TCG_COND_EQ, cpu_gpr_d[15], constant, offset);
         break;
     case OPC1_16_SBC_JEQ2:
         gen_branch_condi(ctx, TCG_COND_EQ, cpu_gpr_d[15], constant,
                          offset + 16);
         break;
     case OPC1_16_SBC_JNE:
         gen_branch_condi(ctx, TCG_COND_NE, cpu_gpr_d[15], constant, offset);
         break;
     case OPC1_16_SBC_JNE2:
         gen_branch_condi(ctx, TCG_COND_NE, cpu_gpr_d[15],
                          constant, offset + 16);
         break;
 /* SBRN-format jumps */
     case OPC1_16_SBRN_JZ_T:
         temp = tcg_temp_new();
         tcg_gen_andi_tl(temp, cpu_gpr_d[15], 0x1u << constant);
         gen_branch_condi(ctx, TCG_COND_EQ, temp, 0, offset);
         break;
     case OPC1_16_SBRN_JNZ_T:
         temp = tcg_temp_new();
         tcg_gen_andi_tl(temp, cpu_gpr_d[15], 0x1u << constant);
         gen_branch_condi(ctx, TCG_COND_NE, temp, 0, offset);
         break;
 /* SBR-format jumps */
     case OPC1_16_SBR_JEQ:
         gen_branch_cond(ctx, TCG_COND_EQ, cpu_gpr_d[r1], cpu_gpr_d[15],
                         offset);
         break;
     case OPC1_16_SBR_JEQ2:
         gen_branch_cond(ctx, TCG_COND_EQ, cpu_gpr_d[r1], cpu_gpr_d[15],
                         offset + 16);
         break;
     case OPC1_16_SBR_JNE:
         gen_branch_cond(ctx, TCG_COND_NE, cpu_gpr_d[r1], cpu_gpr_d[15],
                         offset);
         break;
     case OPC1_16_SBR_JNE2:
         gen_branch_cond(ctx, TCG_COND_NE, cpu_gpr_d[r1], cpu_gpr_d[15],
                         offset + 16);
         break;
     case OPC1_16_SBR_JNZ:
         gen_branch_condi(ctx, TCG_COND_NE, cpu_gpr_d[r1], 0, offset);
         break;
     case OPC1_16_SBR_JNZ_A:
         gen_branch_condi(ctx, TCG_COND_NE, cpu_gpr_a[r1], 0, offset);
         break;
     case OPC1_16_SBR_JGEZ:
         gen_branch_condi(ctx, TCG_COND_GE, cpu_gpr_d[r1], 0, offset);
         break;
     case OPC1_16_SBR_JGTZ:
         gen_branch_condi(ctx, TCG_COND_GT, cpu_gpr_d[r1], 0, offset);
         break;
     case OPC1_16_SBR_JLEZ:
         gen_branch_condi(ctx, TCG_COND_LE, cpu_gpr_d[r1], 0, offset);
         break;
     case OPC1_16_SBR_JLTZ:
         gen_branch_condi(ctx, TCG_COND_LT, cpu_gpr_d[r1], 0, offset);
         break;
     case OPC1_16_SBR_JZ:
         gen_branch_condi(ctx, TCG_COND_EQ, cpu_gpr_d[r1], 0, offset);
         break;
     case OPC1_16_SBR_JZ_A:
         gen_branch_condi(ctx, TCG_COND_EQ, cpu_gpr_a[r1], 0, offset);
         break;
     case OPC1_16_SBR_LOOP:
         gen_loop(ctx, r1, offset * 2 - 32);
         break;
 /* SR-format jumps */
     case OPC1_16_SR_JI:
         tcg_gen_andi_tl(cpu_PC, cpu_gpr_a[r1], 0xfffffffe);
         ctx->base.is_jmp = DISAS_EXIT;
         break;
     case OPC2_32_SYS_RET:
     case OPC2_16_SR_RET:
         gen_helper_ret(tcg_env);
         ctx->base.is_jmp = DISAS_EXIT;
         break;
 /* B-format */
     case OPC1_32_B_CALLA:
         gen_helper_1arg(call, ctx->pc_succ_insn);
         gen_goto_tb(ctx, 0, EA_B_ABSOLUT(offset));
         break;
     case OPC1_32_B_FCALL:
         gen_fcall_save_ctx(ctx);
         gen_goto_tb(ctx, 0, ctx->base.pc_next + offset * 2);
         break;
     case OPC1_32_B_FCALLA:
         gen_fcall_save_ctx(ctx);
         gen_goto_tb(ctx, 0, EA_B_ABSOLUT(offset));
         break;
     case OPC1_32_B_JLA:
         tcg_gen_movi_tl(cpu_gpr_a[11], ctx->pc_succ_insn);
-        /* fall through */
+        fallthrough;
     case OPC1_32_B_JA:
         gen_goto_tb(ctx, 0, EA_B_ABSOLUT(offset));
         break;
     case OPC1_32_B_JL:
         tcg_gen_movi_tl(cpu_gpr_a[11], ctx->pc_succ_insn);
         gen_goto_tb(ctx, 0, ctx->base.pc_next + offset * 2);
         break;
 /* BOL format */
     case OPCM_32_BRC_EQ_NEQ:
          if (MASK_OP_BRC_OP2(ctx->opcode) == OPC2_32_BRC_JEQ) {
             gen_branch_condi(ctx, TCG_COND_EQ, cpu_gpr_d[r1], constant, offset);
          } else {
             gen_branch_condi(ctx, TCG_COND_NE, cpu_gpr_d[r1], constant, offset);
          }
          break;
     case OPCM_32_BRC_GE:
          if (MASK_OP_BRC_OP2(ctx->opcode) == OP2_32_BRC_JGE) {
             gen_branch_condi(ctx, TCG_COND_GE, cpu_gpr_d[r1], constant, offset);
          } else {
             constant = MASK_OP_BRC_CONST4(ctx->opcode);
             gen_branch_condi(ctx, TCG_COND_GEU, cpu_gpr_d[r1], constant,
                              offset);
          }
          break;
     case OPCM_32_BRC_JLT:
          if (MASK_OP_BRC_OP2(ctx->opcode) == OPC2_32_BRC_JLT) {
             gen_branch_condi(ctx, TCG_COND_LT, cpu_gpr_d[r1], constant, offset);
          } else {
             constant = MASK_OP_BRC_CONST4(ctx->opcode);
             gen_branch_condi(ctx, TCG_COND_LTU, cpu_gpr_d[r1], constant,
                              offset);
          }
          break;
     case OPCM_32_BRC_JNE:
         temp = tcg_temp_new();
         if (MASK_OP_BRC_OP2(ctx->opcode) == OPC2_32_BRC_JNED) {
             tcg_gen_mov_tl(temp, cpu_gpr_d[r1]);
             /* subi is unconditional */
             tcg_gen_subi_tl(cpu_gpr_d[r1], cpu_gpr_d[r1], 1);
             gen_branch_condi(ctx, TCG_COND_NE, temp, constant, offset);
         } else {
             tcg_gen_mov_tl(temp, cpu_gpr_d[r1]);
             /* addi is unconditional */
             tcg_gen_addi_tl(cpu_gpr_d[r1], cpu_gpr_d[r1], 1);
             gen_branch_condi(ctx, TCG_COND_NE, temp, constant, offset);
         }
         break;
 /* BRN format */
     case OPCM_32_BRN_JTT:
         n = MASK_OP_BRN_N(ctx->opcode);
 
         temp = tcg_temp_new();
         tcg_gen_andi_tl(temp, cpu_gpr_d[r1], (1 << n));
 
         if (MASK_OP_BRN_OP2(ctx->opcode) == OPC2_32_BRN_JNZ_T) {
             gen_branch_condi(ctx, TCG_COND_NE, temp, 0, offset);
         } else {
             gen_branch_condi(ctx, TCG_COND_EQ, temp, 0, offset);
         }
         break;
 /* BRR Format */
     case OPCM_32_BRR_EQ_NEQ:
         if (MASK_OP_BRR_OP2(ctx->opcode) == OPC2_32_BRR_JEQ) {
             gen_branch_cond(ctx, TCG_COND_EQ, cpu_gpr_d[r1], cpu_gpr_d[r2],
                             offset);
         } else {
             gen_branch_cond(ctx, TCG_COND_NE, cpu_gpr_d[r1], cpu_gpr_d[r2],
                             offset);
         }
         break;
     case OPCM_32_BRR_ADDR_EQ_NEQ:
         if (MASK_OP_BRR_OP2(ctx->opcode) == OPC2_32_BRR_JEQ_A) {
             gen_branch_cond(ctx, TCG_COND_EQ, cpu_gpr_a[r1], cpu_gpr_a[r2],
                             offset);
         } else {
             gen_branch_cond(ctx, TCG_COND_NE, cpu_gpr_a[r1], cpu_gpr_a[r2],
                             offset);
         }
         break;
     case OPCM_32_BRR_GE:
         if (MASK_OP_BRR_OP2(ctx->opcode) == OPC2_32_BRR_JGE) {
             gen_branch_cond(ctx, TCG_COND_GE, cpu_gpr_d[r1], cpu_gpr_d[r2],
                             offset);
         } else {
             gen_branch_cond(ctx, TCG_COND_GEU, cpu_gpr_d[r1], cpu_gpr_d[r2],
                             offset);
         }
         break;
     case OPCM_32_BRR_JLT:
         if (MASK_OP_BRR_OP2(ctx->opcode) == OPC2_32_BRR_JLT) {
             gen_branch_cond(ctx, TCG_COND_LT, cpu_gpr_d[r1], cpu_gpr_d[r2],
                             offset);
         } else {
             gen_branch_cond(ctx, TCG_COND_LTU, cpu_gpr_d[r1], cpu_gpr_d[r2],
                             offset);
         }
         break;
     case OPCM_32_BRR_LOOP:
         if (MASK_OP_BRR_OP2(ctx->opcode) == OPC2_32_BRR_LOOP) {
             gen_loop(ctx, r2, offset * 2);
         } else {
             /* OPC2_32_BRR_LOOPU */
             gen_goto_tb(ctx, 0, ctx->base.pc_next + offset * 2);
         }
         break;
     case OPCM_32_BRR_JNE:
         temp = tcg_temp_new();
         temp2 = tcg_temp_new();
         if (MASK_OP_BRC_OP2(ctx->opcode) == OPC2_32_BRR_JNED) {
             tcg_gen_mov_tl(temp, cpu_gpr_d[r1]);
             /* also save r2, in case of r1 == r2, so r2 is not decremented */
             tcg_gen_mov_tl(temp2, cpu_gpr_d[r2]);
             /* subi is unconditional */
             tcg_gen_subi_tl(cpu_gpr_d[r1], cpu_gpr_d[r1], 1);
             gen_branch_cond(ctx, TCG_COND_NE, temp, temp2, offset);
         } else {
             tcg_gen_mov_tl(temp, cpu_gpr_d[r1]);
             /* also save r2, in case of r1 == r2, so r2 is not decremented */
             tcg_gen_mov_tl(temp2, cpu_gpr_d[r2]);
             /* addi is unconditional */
             tcg_gen_addi_tl(cpu_gpr_d[r1], cpu_gpr_d[r1], 1);
             gen_branch_cond(ctx, TCG_COND_NE, temp, temp2, offset);
         }
         break;
     case OPCM_32_BRR_JNZ:
         if (MASK_OP_BRR_OP2(ctx->opcode) == OPC2_32_BRR_JNZ_A) {
             gen_branch_condi(ctx, TCG_COND_NE, cpu_gpr_a[r1], 0, offset);
         } else {
             gen_branch_condi(ctx, TCG_COND_EQ, cpu_gpr_a[r1], 0, offset);
         }
         break;
     default:
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
     }
 }
 
 
 /*
  * Functions for decoding instructions
  */
@@ -8445,23 +8445,23 @@ static void tricore_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 static void tricore_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
     switch (ctx->base.is_jmp) {
     case DISAS_TOO_MANY:
         gen_goto_tb(ctx, 0, ctx->base.pc_next);
         break;
     case DISAS_EXIT_UPDATE:
         gen_save_pc(ctx->base.pc_next);
-        /* fall through */
+        fallthrough;
     case DISAS_EXIT:
         tcg_gen_exit_tb(NULL, 0);
         break;
     case DISAS_JUMP:
         tcg_gen_lookup_and_goto_ptr();
         break;
     case DISAS_NORETURN:
         break;
     default:
         g_assert_not_reached();
     }
 }
-- 
2.39.2


