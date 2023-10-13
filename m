Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BF97C80A2
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:48:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqB-00083U-W1; Fri, 13 Oct 2023 04:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDps-0007hL-TT
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:59 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpo-0000qL-2y
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:55 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-31f71b25a99so1738589f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186868; x=1697791668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gfyCPP00drOhTXiq127LUfywHVe+SRVdqbV86unN+Cw=;
 b=J9Lbxixz9EM1hXwnUBB4v1L/xobeY/2OzHdM8QLv5zx2aAO4YGP7V6uW2Mha+NXpYV
 T1bdr/u8DpfisVy9CQJyIakmJptn8gsZBPwds6sMuIhWg1R2OpoeQ7GX8VmPi4ZkTqYd
 US/y2bMPOEbKFES2GHCbES4/0A3hERtpZwZ8aNwsQLRdmqh4C2wlt6VK03uiMcv0x8a1
 OX95LTPBnUHQKmQOjyyKFFFhoI1b7kIW4m/QVRX1GkO6/jNAiPfnantz2ri346fcDhR9
 2yuyifdOe4ub8fxNak+4PLqNw2+jWc/ezbAWV7MSElYS8R6SRbVDWRiOsKBqtDyauN1V
 n7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186868; x=1697791668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gfyCPP00drOhTXiq127LUfywHVe+SRVdqbV86unN+Cw=;
 b=ChaTbvbuM8GNlwuLNPlFj49ZuuOS1kP8dibT8RWEEUfyWrYsR07kzApcenglV5uG1Q
 srfRmSk3EJqtsnhX2SbmKDsnd1sDgUIE+1/xubXtKytQKVSa74+aNmnevr1NGPFOtXcx
 Lr+oTD733sPvsfDLW2o3iimwKjxoWogIyB0Ppz/qof66pjVO92DU8DAwZCXm/rJuQ4zI
 L3ua55vd0AA+xW4+RN6sE7EKURllBY1V/HLTfO6WPwiUQqainDMRzF+GIfQGzFBI/mZm
 ZjYQRKYxqhfiKEsfy/+Dcp7mSFMkvAOlnkMivRI2k5uI288jXyq+3huKTY+cwZ3lUUdH
 BXSQ==
X-Gm-Message-State: AOJu0YxM8cmUczzXbnAGjS6fIImqicfhFKcC9SRgn8NKUb9x6V1ia6NT
 f6ujDuqqlo6CdLSkL1We7oPaOsEJuA80rLELPvg=
X-Google-Smtp-Source: AGHT+IFQWqkNFcBwFrnaS5xkHbcb4uPgnH0x4Q9Qx3dsGr8b2FG2rkxyqxpFRgKTBAvS7j4jfjsfAQ==
X-Received: by 2002:a05:6000:120f:b0:327:e073:d5fe with SMTP id
 e15-20020a056000120f00b00327e073d5femr22025189wrx.38.1697186868367; 
 Fri, 13 Oct 2023 01:47:48 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.47.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:47:47 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [RFC PATCH v3 20/78] target/mips: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:45:48 +0300
Message-Id: <cd89d16dcaf6d8015ed3f317c30ff2fd6ae0bff1.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x434.google.com
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
 target/mips/sysemu/physaddr.c             |  2 +-
 target/mips/tcg/micromips_translate.c.inc |  4 +-
 target/mips/tcg/mips16e_translate.c.inc   | 30 ++++-----
 target/mips/tcg/mxu_translate.c           |  8 +--
 target/mips/tcg/nanomips_translate.c.inc  |  4 +-
 target/mips/tcg/op_helper.c               |  2 +-
 target/mips/tcg/translate.c               | 79 ++++++++++++-----------
 7 files changed, 66 insertions(+), 63 deletions(-)

diff --git a/target/mips/sysemu/physaddr.c b/target/mips/sysemu/physaddr.c
index 05990aa5bb..ebcaeea1bc 100644
--- a/target/mips/sysemu/physaddr.c
+++ b/target/mips/sysemu/physaddr.c
@@ -44,7 +44,7 @@ static int is_seg_am_mapped(unsigned int am, bool eu, int mmu_idx)
         if (eu) {
             return 0;
         }
-        /* fall through */
+        fallthrough;
     case MIPS_HFLAG_KM:
         /* Never AdE, TLB mapped if AM={1,2,3} */
         adetlb_mask = 0x70000000;
diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index 7510831701..00e96ce27a 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -1845,7 +1845,7 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
             check_insn(ctx, ISA_MIPS3);
             check_mips_64(ctx);
 #endif
-            /* fall through */
+            fallthrough;
         case LWP:
         case SWP:
             gen_ldst_pair(ctx, minor, rt, rs, SIMM(ctx->opcode, 0, 12));
@@ -1856,7 +1856,7 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
             check_insn(ctx, ISA_MIPS3);
             check_mips_64(ctx);
 #endif
-            /* fall through */
+            fallthrough;
         case LWM32:
         case SWM32:
             gen_ldst_multiple(ctx, minor, rt, rs, SIMM(ctx->opcode, 0, 12));
diff --git a/target/mips/tcg/mips16e_translate.c.inc b/target/mips/tcg/mips16e_translate.c.inc
index 5cffe0e412..b8bdd6a7f2 100644
--- a/target/mips/tcg/mips16e_translate.c.inc
+++ b/target/mips/tcg/mips16e_translate.c.inc
@@ -174,19 +174,19 @@ static void gen_mips16_save(DisasContext *ctx,
         gen_load_gpr(t1, 7);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUL |
                            ctx->default_tcg_memop_mask);
-        /* Fall through */
+        fallthrough;
     case 3:
         gen_base_offset_addr(ctx, t0, 29, 8);
         gen_load_gpr(t1, 6);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUL |
                            ctx->default_tcg_memop_mask);
-        /* Fall through */
+        fallthrough;
     case 2:
         gen_base_offset_addr(ctx, t0, 29, 4);
         gen_load_gpr(t1, 5);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUL |
                            ctx->default_tcg_memop_mask);
-        /* Fall through */
+        fallthrough;
     case 1:
         gen_base_offset_addr(ctx, t0, 29, 0);
         gen_load_gpr(t1, 4);
@@ -211,22 +211,22 @@ static void gen_mips16_save(DisasContext *ctx,
     switch (xsregs) {
     case 7:
         DECR_AND_STORE(30);
-        /* Fall through */
+        fallthrough;
     case 6:
         DECR_AND_STORE(23);
-        /* Fall through */
+        fallthrough;
     case 5:
         DECR_AND_STORE(22);
-        /* Fall through */
+        fallthrough;
     case 4:
         DECR_AND_STORE(21);
-        /* Fall through */
+        fallthrough;
     case 3:
         DECR_AND_STORE(20);
-        /* Fall through */
+        fallthrough;
     case 2:
         DECR_AND_STORE(19);
-        /* Fall through */
+        fallthrough;
     case 1:
         DECR_AND_STORE(18);
     }
@@ -315,22 +315,22 @@ static void gen_mips16_restore(DisasContext *ctx,
     switch (xsregs) {
     case 7:
         DECR_AND_LOAD(30);
-        /* Fall through */
+        fallthrough;
     case 6:
         DECR_AND_LOAD(23);
-        /* Fall through */
+        fallthrough;
     case 5:
         DECR_AND_LOAD(22);
-        /* Fall through */
+        fallthrough;
     case 4:
         DECR_AND_LOAD(21);
-        /* Fall through */
+        fallthrough;
     case 3:
         DECR_AND_LOAD(20);
-        /* Fall through */
+        fallthrough;
     case 2:
         DECR_AND_LOAD(19);
-        /* Fall through */
+        fallthrough;
     case 1:
         DECR_AND_LOAD(18);
     }
diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index c517258ac5..3811ac0d54 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -4573,7 +4573,7 @@ static void decode_opc_mxu__pool06(DisasContext *ctx)
             gen_mxu_s32ldxvx(ctx, opcode, false, strd2);
             break;
         }
-        /* fallthrough */
+        fallthrough;
     default:
         MIPS_INVAL("decode_opc_mxu");
         gen_reserved_instruction(ctx);
@@ -4593,7 +4593,7 @@ static void decode_opc_mxu__pool07(DisasContext *ctx)
             gen_mxu_s32stxvx(ctx, opcode, false, strd2);
             break;
         }
-        /* fallthrough */
+        fallthrough;
     default:
         MIPS_INVAL("decode_opc_mxu");
         gen_reserved_instruction(ctx);
@@ -4639,7 +4639,7 @@ static void decode_opc_mxu__pool10(DisasContext *ctx)
             gen_mxu_s32ldxvx(ctx, opcode, true, strd2);
             break;
         }
-        /* fallthrough */
+        fallthrough;
     default:
         MIPS_INVAL("decode_opc_mxu");
         gen_reserved_instruction(ctx);
@@ -4659,7 +4659,7 @@ static void decode_opc_mxu__pool11(DisasContext *ctx)
             gen_mxu_s32stxvx(ctx, opcode, true, strd2);
             break;
         }
-        /* fallthrough */
+        fallthrough;
     default:
         MIPS_INVAL("decode_opc_mxu");
         gen_reserved_instruction(ctx);
diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index b4b746d418..3e5f4f4e58 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -2615,14 +2615,14 @@ static void gen_p_lsx(DisasContext *ctx, int rd, int rs, int rt)
         switch (extract32(ctx->opcode, 7, 4)) {
         case NM_SHXS:
             check_nms(ctx);
-            /* fall through */
+            fallthrough;
         case NM_LHXS:
         case NM_LHUXS:
             tcg_gen_shli_tl(t0, t0, 1);
             break;
         case NM_SWXS:
             check_nms(ctx);
-            /* fall through */
+            fallthrough;
         case NM_LWXS:
         case NM_LWC1XS:
         case NM_SWC1XS:
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index 98935b5e64..b53f4fa694 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -238,7 +238,7 @@ void helper_pmon(CPUMIPSState *env, int function)
         if (env->active_tc.gpr[4] == 0) {
             env->active_tc.gpr[2] = -1;
         }
-        /* Fall through */
+        fallthrough;
     case 11: /* TODO: char inbyte (void); */
         env->active_tc.gpr[2] = -1;
         break;
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 13e43fa3b6..c6cbc05400 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -2115,7 +2115,7 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
         break;
     case OPC_LWE:
         mem_idx = MIPS_HFLAG_UM;
-        /* fall through */
+        fallthrough;
     case OPC_LW:
         tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TESL |
                            ctx->default_tcg_memop_mask);
@@ -2123,7 +2123,7 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
         break;
     case OPC_LHE:
         mem_idx = MIPS_HFLAG_UM;
-        /* fall through */
+        fallthrough;
     case OPC_LH:
         tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TESW |
                            ctx->default_tcg_memop_mask);
@@ -2131,7 +2131,7 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
         break;
     case OPC_LHUE:
         mem_idx = MIPS_HFLAG_UM;
-        /* fall through */
+        fallthrough;
     case OPC_LHU:
         tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TEUW |
                            ctx->default_tcg_memop_mask);
@@ -2139,21 +2139,21 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
         break;
     case OPC_LBE:
         mem_idx = MIPS_HFLAG_UM;
-        /* fall through */
+        fallthrough;
     case OPC_LB:
         tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_SB);
         gen_store_gpr(t0, rt);
         break;
     case OPC_LBUE:
         mem_idx = MIPS_HFLAG_UM;
-        /* fall through */
+        fallthrough;
     case OPC_LBU:
         tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_UB);
         gen_store_gpr(t0, rt);
         break;
     case OPC_LWLE:
         mem_idx = MIPS_HFLAG_UM;
-        /* fall through */
+        fallthrough;
     case OPC_LWL:
         t1 = tcg_temp_new();
         gen_load_gpr(t1, rt);
@@ -2163,7 +2163,7 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
         break;
     case OPC_LWRE:
         mem_idx = MIPS_HFLAG_UM;
-        /* fall through */
+        fallthrough;
     case OPC_LWR:
         t1 = tcg_temp_new();
         gen_load_gpr(t1, rt);
@@ -2173,7 +2173,7 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
         break;
     case OPC_LLE:
         mem_idx = MIPS_HFLAG_UM;
-        /* fall through */
+        fallthrough;
     case OPC_LL:
     case R6_OPC_LL:
         op_ld_ll(t0, t0, mem_idx, ctx);
@@ -2207,33 +2207,33 @@ static void gen_st(DisasContext *ctx, uint32_t opc, int rt,
 #endif
     case OPC_SWE:
         mem_idx = MIPS_HFLAG_UM;
-        /* fall through */
+        fallthrough;
     case OPC_SW:
         tcg_gen_qemu_st_tl(t1, t0, mem_idx, MO_TEUL |
                            ctx->default_tcg_memop_mask);
         break;
     case OPC_SHE:
         mem_idx = MIPS_HFLAG_UM;
-        /* fall through */
+        fallthrough;
     case OPC_SH:
         tcg_gen_qemu_st_tl(t1, t0, mem_idx, MO_TEUW |
                            ctx->default_tcg_memop_mask);
         break;
     case OPC_SBE:
         mem_idx = MIPS_HFLAG_UM;
-        /* fall through */
+        fallthrough;
     case OPC_SB:
         tcg_gen_qemu_st_tl(t1, t0, mem_idx, MO_8);
         break;
     case OPC_SWLE:
         mem_idx = MIPS_HFLAG_UM;
-        /* fall through */
+        fallthrough;
     case OPC_SWL:
         gen_helper_0e2i(swl, t1, t0, mem_idx);
         break;
     case OPC_SWRE:
         mem_idx = MIPS_HFLAG_UM;
-        /* fall through */
+        fallthrough;
     case OPC_SWR:
         gen_helper_0e2i(swr, t1, t0, mem_idx);
         break;
@@ -2329,7 +2329,7 @@ static void gen_cop1_ldst(DisasContext *ctx, uint32_t op, int rt,
         case OPC_LDC1:
         case OPC_SDC1:
             check_insn(ctx, ISA_MIPS2);
-            /* Fallthrough */
+            fallthrough;
         default:
             gen_base_offset_addr(ctx, t0, rs, imm);
             gen_flt_ldst(ctx, op, rt, t0);
@@ -3477,7 +3477,7 @@ static void gen_mul_txx9(DisasContext *ctx, uint32_t opc,
     switch (opc) {
     case MMI_OPC_MULT1:
         acc = 1;
-        /* Fall through */
+        fallthrough;
     case OPC_MULT:
         {
             TCGv_i32 t2 = tcg_temp_new_i32();
@@ -3494,7 +3494,7 @@ static void gen_mul_txx9(DisasContext *ctx, uint32_t opc,
         break;
     case MMI_OPC_MULTU1:
         acc = 1;
-        /* Fall through */
+        fallthrough;
     case OPC_MULTU:
         {
             TCGv_i32 t2 = tcg_temp_new_i32();
@@ -3511,7 +3511,7 @@ static void gen_mul_txx9(DisasContext *ctx, uint32_t opc,
         break;
     case MMI_OPC_MADD1:
         acc = 1;
-        /* Fall through */
+        fallthrough;
     case MMI_OPC_MADD:
         {
             TCGv_i64 t2 = tcg_temp_new_i64();
@@ -3531,7 +3531,7 @@ static void gen_mul_txx9(DisasContext *ctx, uint32_t opc,
         break;
     case MMI_OPC_MADDU1:
         acc = 1;
-        /* Fall through */
+        fallthrough;
     case MMI_OPC_MADDU:
         {
             TCGv_i64 t2 = tcg_temp_new_i64();
@@ -4042,6 +4042,7 @@ static void gen_loongson_multimedia(DisasContext *ctx, int rd, int rs, int rt)
             /* We want to shift in zeros for SRL; zero-extend first.  */
             tcg_gen_ext32u_i64(t0, t0);
             /* FALLTHRU */
+            fallthrough;
         case OPC_DSRL_CP2:
             tcg_gen_shr_i64(t0, t0, t1);
             break;
@@ -4717,7 +4718,7 @@ static void gen_compute_branch(DisasContext *ctx, uint32_t opc,
             break;
         case OPC_JALX:
             ctx->hflags |= MIPS_HFLAG_BX;
-            /* Fallthrough */
+            fallthrough;
         case OPC_JAL:
             blink = 31;
             ctx->hflags |= MIPS_HFLAG_B;
@@ -4883,9 +4884,11 @@ static void gen_bitops(DisasContext *ctx, uint32_t opc, int rt,
     case OPC_DINSU:
         lsb += 32;
         /* FALLTHRU */
+        fallthrough;
     case OPC_DINSM:
         msb += 32;
         /* FALLTHRU */
+        fallthrough;
     case OPC_DINS:
         if (lsb > msb) {
             goto fail;
@@ -8550,7 +8553,7 @@ static void gen_mftr(CPUMIPSState *env, DisasContext *ctx, int rt, int rd,
         /* COP2: Not implemented. */
         case 4:
         case 5:
-            /* fall through */
+            fallthrough;
         default:
             goto die;
         }
@@ -8752,7 +8755,7 @@ static void gen_mttr(CPUMIPSState *env, DisasContext *ctx, int rd, int rt,
         /* COP2: Not implemented. */
         case 4:
         case 5:
-            /* fall through */
+            fallthrough;
         default:
             goto die;
         }
@@ -11345,13 +11348,13 @@ static void gen_compute_compact_branch(DisasContext *ctx, uint32_t opc,
         switch (opc) {
         case OPC_JIALC:
             tcg_gen_movi_tl(cpu_gpr[31], ctx->base.pc_next + 4 + m16_lowbit);
-            /* Fallthrough */
+            fallthrough;
         case OPC_JIC:
             ctx->hflags |= MIPS_HFLAG_BR;
             break;
         case OPC_BALC:
             tcg_gen_movi_tl(cpu_gpr[31], ctx->base.pc_next + 4 + m16_lowbit);
-            /* Fallthrough */
+            fallthrough;
         case OPC_BC:
             ctx->hflags |= MIPS_HFLAG_B;
             break;
@@ -13504,7 +13507,7 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
                 break;
             }
         }
-        /* Fallthrough */
+        fallthrough;
     case OPC_SRA:
         gen_shift_imm(ctx, op1, rd, rt, sa);
         break;
@@ -13515,7 +13518,7 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
             if (ctx->insn_flags & ISA_MIPS_R2) {
                 op1 = OPC_ROTR;
             }
-            /* Fallthrough */
+            fallthrough;
         case 0:
             gen_shift_imm(ctx, op1, rd, rt, sa);
             break;
@@ -13541,7 +13544,7 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
             if (ctx->insn_flags & ISA_MIPS_R2) {
                 op1 = OPC_ROTRV;
             }
-            /* Fallthrough */
+            fallthrough;
         case 0:
             gen_shift(ctx, op1, rd, rs, rt);
             break;
@@ -13609,7 +13612,7 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
             if (ctx->insn_flags & ISA_MIPS_R2) {
                 op1 = OPC_DROTR;
             }
-            /* Fallthrough */
+            fallthrough;
         case 0:
             check_insn(ctx, ISA_MIPS3);
             check_mips_64(ctx);
@@ -13627,7 +13630,7 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
             if (ctx->insn_flags & ISA_MIPS_R2) {
                 op1 = OPC_DROTR32;
             }
-            /* Fallthrough */
+            fallthrough;
         case 0:
             check_insn(ctx, ISA_MIPS3);
             check_mips_64(ctx);
@@ -13659,7 +13662,7 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
             if (ctx->insn_flags & ISA_MIPS_R2) {
                 op1 = OPC_DROTRV;
             }
-            /* Fallthrough */
+            fallthrough;
         case 0:
             check_insn(ctx, ISA_MIPS3);
             check_mips_64(ctx);
@@ -14669,7 +14672,7 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
         case OPC_BGEZALL:
             check_insn(ctx, ISA_MIPS2);
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
-            /* Fallthrough */
+            fallthrough;
         case OPC_BLTZ:
         case OPC_BGEZ:
             gen_compute_branch(ctx, op1, 4, rs, -1, imm << 2, 4);
@@ -14942,7 +14945,7 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
     case OPC_BNEL:
         check_insn(ctx, ISA_MIPS2);
          check_insn_opc_removed(ctx, ISA_MIPS_R6);
-        /* Fallthrough */
+        fallthrough;
     case OPC_BEQ:
     case OPC_BNE:
          gen_compute_branch(ctx, op, 4, rs, rt, imm << 2, 4);
@@ -14952,7 +14955,7 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
         if (ctx->insn_flags & INSN_R5900) {
             check_insn_opc_user_only(ctx, INSN_R5900);
         }
-        /* Fallthrough */
+        fallthrough;
     case OPC_LWL:
     case OPC_LWR:
     case OPC_LB:
@@ -15006,7 +15009,7 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
         case OPC_MTHC1:
             check_cp1_enabled(ctx);
             check_insn(ctx, ISA_MIPS_R2);
-            /* fall through */
+            fallthrough;
         case OPC_MFC1:
         case OPC_CFC1:
         case OPC_MTC1:
@@ -15048,7 +15051,7 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
             check_cop1x(ctx);
             check_insn(ctx, ASE_MIPS3D);
-            /* fall through */
+            fallthrough;
         case OPC_BC1:
             check_cp1_enabled(ctx);
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
@@ -15057,7 +15060,7 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
             break;
         case OPC_PS_FMT:
             check_ps(ctx);
-            /* fall through */
+            fallthrough;
         case OPC_S_FMT:
         case OPC_D_FMT:
             check_cp1_enabled(ctx);
@@ -15186,7 +15189,7 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
             case OPC_LUXC1:
             case OPC_SUXC1:
                 check_insn(ctx, ISA_MIPS5 | ISA_MIPS_R2);
-                /* Fallthrough */
+                fallthrough;
             case OPC_LWXC1:
             case OPC_LDXC1:
             case OPC_SWXC1:
@@ -15200,7 +15203,7 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
                 break;
             case OPC_ALNV_PS:
                 check_insn(ctx, ISA_MIPS5 | ISA_MIPS_R2);
-                /* Fallthrough */
+                fallthrough;
             case OPC_MADD_S:
             case OPC_MADD_D:
             case OPC_MADD_PS:
@@ -15232,7 +15235,7 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
         if (ctx->insn_flags & INSN_R5900) {
             check_insn_opc_user_only(ctx, INSN_R5900);
         }
-        /* fall through */
+        fallthrough;
     case OPC_LDL:
     case OPC_LDR:
     case OPC_LWU:
-- 
2.39.2


