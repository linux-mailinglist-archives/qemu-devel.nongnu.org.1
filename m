Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6997C7F62
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:05:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD4p-0002pQ-2O; Fri, 13 Oct 2023 03:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4Y-00015l-Ok
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:02 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4V-0006wd-7r
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:02 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-406619b53caso19397375e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183936; x=1697788736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZZoxu2fQjlSrHAg6BVR82z3xBTX4HSZAJalvN6ykP5U=;
 b=HPzyUqvWHjD9cNMpAckaUs6l+f1Ik04dKEHeB6i+BB5J/0LZNjxraBSe+JGKco2LMM
 iWTWOl85tCSkMFvqyCZ7JoY9cPsKfRRnPLgnqV5pY7WP1OinLP/N5Ts4vNCbrMUFor6l
 cEeSnDy6ZHwYuX/8BxENsPXrkOXK8JjckLXzktzGIYJojM1rP8BPipDP2sgCifsfBNoy
 vsQhLCHU2o0g09s3nmsZgnuxJZ+lcLxt//PbrW4C62F8A3bM1rPhdg3jAztue52rL07c
 /KC3FUpGU+EXfKg1yPJlu/rjyA3SyLq76DachZGVy24R9117uGGNFijF1tU+nfa6PDIk
 dbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183936; x=1697788736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZZoxu2fQjlSrHAg6BVR82z3xBTX4HSZAJalvN6ykP5U=;
 b=QyfP/FyzZ8mswrUaazRaSV6nFuuH1qySNEGgktrvV22YuoFMZmK0wQZkH45vHpAgu3
 T09CjlvISs60eXcFw67g/wdFL1tdvJEh1Lm942mcD0EvbgxYki6omXJuorRZVg9ZLAUe
 7g7nxo8S2LPjKFMca4V3TxoKcsruz4QFnKTO1SKk4/f0zJSp22zpYJZiinfCE/ac/sN3
 bUvgicfHd5g/hZ36/BKC541CtWWqXbBWFY/brOeyQBsx5zqoHNOX4Ps1IhU5hJyl65lf
 xGwFZ796vahFSKaACPExRlzhX+IcVFRDQvll6YVWnBAA0vSXMmFS5DFsT+IH837tgM6w
 tuDA==
X-Gm-Message-State: AOJu0YxLdhntLGL1UJUt5kM0SnV61ViRM8/sPa0U+8MmIhYg9pQ8mk3Y
 Q19qNEVLHD2DkEeERp8WMWWA1w1T4F3SAjYh1/o=
X-Google-Smtp-Source: AGHT+IGFExJX8uMCtgQrDmzIXTHDdXmLgTfSw1W2OIxQx7BwHsNv6YQORIF3Vz26x8ayJaMuyHgtQQ==
X-Received: by 2002:a05:600c:332a:b0:407:59d2:7925 with SMTP id
 q42-20020a05600c332a00b0040759d27925mr7694290wmp.21.1697183936467; 
 Fri, 13 Oct 2023 00:58:56 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:58:55 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: [RFC PATCH v2 34/78] target/tricore: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:01 +0300
Message-Id: <367c842370fcabd0d61ec69646d49ad120bf34f7.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
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


