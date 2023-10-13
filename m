Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D677C7F87
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:09:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCwr-0005ZH-07; Fri, 13 Oct 2023 03:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCwT-00054h-50
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:50:41 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCwG-0004as-Ak
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:50:40 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31427ddd3fbso1636527f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183426; x=1697788226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JXmBuRino8F8XxkvGAy90ZuJZbQnwLvQ5Jnao6OEAng=;
 b=S0ZPt4vU4kwGnx+Qgd3PcNlp4S/ECalmnLeqSq1rgDMIaMq1r8S8EuCWqyS2ofgFSG
 YVoci7WCtrt6ZYnKXKKA/G6TNsrWFeiyPDZI6muE082FXhCMVU0WeCvzed6A6BPWTTB/
 XG5gyet9q7mpw2F9qylEm6cZIhWrajBofh8bvmHoH2XLuXywI01Kx6NjahPh7KPYwvFh
 A7oOiJm8AFGo2mkOy4DRaNRRHws0cVr3k/9GP1jRwWhMjJDAF0oWsPCp+dzs+xcy7lz+
 Wg6UnmHkIG9hU/4uTyY25nnVFCcu5nfdsYvdkHnPdvj4pXHkeLobGz6bvnSHarySyxox
 Pumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183426; x=1697788226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JXmBuRino8F8XxkvGAy90ZuJZbQnwLvQ5Jnao6OEAng=;
 b=ZUoEUEgVIqqG66gJDFHtBuI0qZNy25jUiy8Aew4dkeCiOeUumO2CLOHnMvJKmM27IB
 OfUuMChu6vF+c74wxfOLIaGT8SwDwr2RTVCMVxbMW7RF1N294iFYz4qr3i8neMgrSwdp
 SYjqMKDtq09U+Phf9sktxwHEj2RQJLS/lJonJZM3+1ChVQcc6WlUSF63wEqam+45BoXo
 KdstOgcyWE9TucZwVcOcrvRI8KY9WvRvZyQlQiUGrBGhvdsmqXDdz7e1VhZxVjW5gno3
 ulcgMOFiWlTXFvfyBe57+6umC6/KjXkueNPdfKmrpjiFCVZvuo8Uu03rkPEB6BKE3+FE
 X0gw==
X-Gm-Message-State: AOJu0YxnUtvW/gEvVBjVzcF9X1X8DaHIMYxJuAtzCnv24dEAA+ovsX9g
 l1EaJsVVGpCk1adPOkvLpWfM0Nuh1AJh0QZ7ALQ=
X-Google-Smtp-Source: AGHT+IHaZfdqxSiTvtcduedgxJkHiZpsOkt9FI4uhhukwaydW+Vm18UXos/vYCsanNiqesWCBMBfNw==
X-Received: by 2002:adf:e9c7:0:b0:320:b1b:86a9 with SMTP id
 l7-20020adfe9c7000000b003200b1b86a9mr22364618wrn.24.1697183425390; 
 Fri, 13 Oct 2023 00:50:25 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:50:24 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [RFC PATCH 20/78] target/mips: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:47:24 +0300
Message-Id: <43a474a9e424968e6c00504033b09c4f6afdec56.1697183082.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x432.google.com
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
@@ -24,52 +24,52 @@
 static int is_seg_am_mapped(unsigned int am, bool eu, int mmu_idx)
 {
     /*
      * Interpret access control mode and mmu_idx.
      *           AdE?     TLB?
      *      AM  K S U E  K S U E
      * UK    0  0 1 1 0  0 - - 0
      * MK    1  0 1 1 0  1 - - !eu
      * MSK   2  0 0 1 0  1 1 - !eu
      * MUSK  3  0 0 0 0  1 1 1 !eu
      * MUSUK 4  0 0 0 0  0 1 1 0
      * USK   5  0 0 1 0  0 0 - 0
      * -     6  - - - -  - - - -
      * UUSK  7  0 0 0 0  0 0 0 0
      */
     int32_t adetlb_mask;
 
     switch (mmu_idx) {
     case 3: /* ERL */
         /* If EU is set, always unmapped */
         if (eu) {
             return 0;
         }
-        /* fall through */
+        fallthrough;
     case MIPS_HFLAG_KM:
         /* Never AdE, TLB mapped if AM={1,2,3} */
         adetlb_mask = 0x70000000;
         goto check_tlb;
 
     case MIPS_HFLAG_SM:
         /* AdE if AM={0,1}, TLB mapped if AM={2,3,4} */
         adetlb_mask = 0xc0380000;
         goto check_ade;
 
     case MIPS_HFLAG_UM:
         /* AdE if AM={0,1,2,5}, TLB mapped if AM={3,4} */
         adetlb_mask = 0xe4180000;
         /* fall through */
     check_ade:
         /* does this AM cause AdE in current execution mode */
         if ((adetlb_mask << am) < 0) {
             return TLBRET_BADADDR;
         }
         adetlb_mask <<= 8;
         /* fall through */
     check_tlb:
         /* is this AM mapped in current execution mode */
         return ((adetlb_mask << am) < 0);
     default:
         g_assert_not_reached();
     };
 }
diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index 7510831701..00e96ce27a 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -1621,1353 +1621,1353 @@ static void gen_pool32fxf(DisasContext *ctx, int rt, int rs)
 static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
 {
     int32_t offset;
     uint16_t insn;
     int rt, rs, rd, rr;
     int16_t imm;
     uint32_t op, minor, minor2, mips32_op;
     uint32_t cond, fmt, cc;
 
     insn = translator_lduw(env, &ctx->base, ctx->base.pc_next + 2);
     ctx->opcode = (ctx->opcode << 16) | insn;
 
     rt = (ctx->opcode >> 21) & 0x1f;
     rs = (ctx->opcode >> 16) & 0x1f;
     rd = (ctx->opcode >> 11) & 0x1f;
     rr = (ctx->opcode >> 6) & 0x1f;
     imm = (int16_t) ctx->opcode;
 
     op = (ctx->opcode >> 26) & 0x3f;
     switch (op) {
     case POOL32A:
         minor = ctx->opcode & 0x3f;
         switch (minor) {
         case 0x00:
             minor = (ctx->opcode >> 6) & 0xf;
             switch (minor) {
             case SLL32:
                 mips32_op = OPC_SLL;
                 goto do_shifti;
             case SRA:
                 mips32_op = OPC_SRA;
                 goto do_shifti;
             case SRL32:
                 mips32_op = OPC_SRL;
                 goto do_shifti;
             case ROTR:
                 mips32_op = OPC_ROTR;
             do_shifti:
                 gen_shift_imm(ctx, mips32_op, rt, rs, rd);
                 break;
             case SELEQZ:
                 check_insn(ctx, ISA_MIPS_R6);
                 gen_cond_move(ctx, OPC_SELEQZ, rd, rs, rt);
                 break;
             case SELNEZ:
                 check_insn(ctx, ISA_MIPS_R6);
                 gen_cond_move(ctx, OPC_SELNEZ, rd, rs, rt);
                 break;
             case R6_RDHWR:
                 check_insn(ctx, ISA_MIPS_R6);
                 gen_rdhwr(ctx, rt, rs, extract32(ctx->opcode, 11, 3));
                 break;
             default:
                 goto pool32a_invalid;
             }
             break;
         case 0x10:
             minor = (ctx->opcode >> 6) & 0xf;
             switch (minor) {
                 /* Arithmetic */
             case ADD:
                 mips32_op = OPC_ADD;
                 goto do_arith;
             case ADDU32:
                 mips32_op = OPC_ADDU;
                 goto do_arith;
             case SUB:
                 mips32_op = OPC_SUB;
                 goto do_arith;
             case SUBU32:
                 mips32_op = OPC_SUBU;
                 goto do_arith;
             case MUL:
                 check_insn_opc_removed(ctx, ISA_MIPS_R6);
                 mips32_op = OPC_MUL;
             do_arith:
                 gen_arith(ctx, mips32_op, rd, rs, rt);
                 break;
                 /* Shifts */
             case SLLV:
                 mips32_op = OPC_SLLV;
                 goto do_shift;
             case SRLV:
                 mips32_op = OPC_SRLV;
                 goto do_shift;
             case SRAV:
                 mips32_op = OPC_SRAV;
                 goto do_shift;
             case ROTRV:
                 mips32_op = OPC_ROTRV;
             do_shift:
                 gen_shift(ctx, mips32_op, rd, rs, rt);
                 break;
                 /* Logical operations */
             case AND:
                 mips32_op = OPC_AND;
                 goto do_logic;
             case OR32:
                 mips32_op = OPC_OR;
                 goto do_logic;
             case NOR:
                 mips32_op = OPC_NOR;
                 goto do_logic;
             case XOR32:
                 mips32_op = OPC_XOR;
             do_logic:
                 gen_logic(ctx, mips32_op, rd, rs, rt);
                 break;
                 /* Set less than */
             case SLT:
                 mips32_op = OPC_SLT;
                 goto do_slt;
             case SLTU:
                 mips32_op = OPC_SLTU;
             do_slt:
                 gen_slt(ctx, mips32_op, rd, rs, rt);
                 break;
             default:
                 goto pool32a_invalid;
             }
             break;
         case 0x18:
             minor = (ctx->opcode >> 6) & 0xf;
             switch (minor) {
                 /* Conditional moves */
             case MOVN: /* MUL */
                 if (ctx->insn_flags & ISA_MIPS_R6) {
                     /* MUL */
                     gen_r6_muldiv(ctx, R6_OPC_MUL, rd, rs, rt);
                 } else {
                     /* MOVN */
                     gen_cond_move(ctx, OPC_MOVN, rd, rs, rt);
                 }
                 break;
             case MOVZ: /* MUH */
                 if (ctx->insn_flags & ISA_MIPS_R6) {
                     /* MUH */
                     gen_r6_muldiv(ctx, R6_OPC_MUH, rd, rs, rt);
                 } else {
                     /* MOVZ */
                     gen_cond_move(ctx, OPC_MOVZ, rd, rs, rt);
                 }
                 break;
             case MULU:
                 check_insn(ctx, ISA_MIPS_R6);
                 gen_r6_muldiv(ctx, R6_OPC_MULU, rd, rs, rt);
                 break;
             case MUHU:
                 check_insn(ctx, ISA_MIPS_R6);
                 gen_r6_muldiv(ctx, R6_OPC_MUHU, rd, rs, rt);
                 break;
             case LWXS: /* DIV */
                 if (ctx->insn_flags & ISA_MIPS_R6) {
                     /* DIV */
                     gen_r6_muldiv(ctx, R6_OPC_DIV, rd, rs, rt);
                 } else {
                     /* LWXS */
                     gen_ldxs(ctx, rs, rt, rd);
                 }
                 break;
             case MOD:
                 check_insn(ctx, ISA_MIPS_R6);
                 gen_r6_muldiv(ctx, R6_OPC_MOD, rd, rs, rt);
                 break;
             case R6_DIVU:
                 check_insn(ctx, ISA_MIPS_R6);
                 gen_r6_muldiv(ctx, R6_OPC_DIVU, rd, rs, rt);
                 break;
             case MODU:
                 check_insn(ctx, ISA_MIPS_R6);
                 gen_r6_muldiv(ctx, R6_OPC_MODU, rd, rs, rt);
                 break;
             default:
                 goto pool32a_invalid;
             }
             break;
         case INS:
             gen_bitops(ctx, OPC_INS, rt, rs, rr, rd);
             return;
         case LSA:
             check_insn(ctx, ISA_MIPS_R6);
             gen_lsa(ctx, rd, rt, rs, extract32(ctx->opcode, 9, 2));
             break;
         case ALIGN:
             check_insn(ctx, ISA_MIPS_R6);
             gen_align(ctx, 32, rd, rs, rt, extract32(ctx->opcode, 9, 2));
             break;
         case EXT:
             gen_bitops(ctx, OPC_EXT, rt, rs, rr, rd);
             return;
         case POOL32AXF:
             gen_pool32axf(env, ctx, rt, rs);
             break;
         case BREAK32:
             generate_exception_break(ctx, extract32(ctx->opcode, 6, 20));
             break;
         case SIGRIE:
             check_insn(ctx, ISA_MIPS_R6);
             gen_reserved_instruction(ctx);
             break;
         default:
         pool32a_invalid:
                 MIPS_INVAL("pool32a");
                 gen_reserved_instruction(ctx);
                 break;
         }
         break;
     case POOL32B:
         minor = (ctx->opcode >> 12) & 0xf;
         switch (minor) {
         case CACHE:
             check_cp0_enabled(ctx);
             if (ctx->hflags & MIPS_HFLAG_ITC_CACHE) {
                 gen_cache_operation(ctx, rt, rs, imm);
             }
             break;
         case LWC2:
         case SWC2:
             /* COP2: Not implemented. */
             generate_exception_err(ctx, EXCP_CpU, 2);
             break;
 #ifdef TARGET_MIPS64
         case LDP:
         case SDP:
             check_insn(ctx, ISA_MIPS3);
             check_mips_64(ctx);
 #endif
-            /* fall through */
+            fallthrough;
         case LWP:
         case SWP:
             gen_ldst_pair(ctx, minor, rt, rs, SIMM(ctx->opcode, 0, 12));
             break;
 #ifdef TARGET_MIPS64
         case LDM:
         case SDM:
             check_insn(ctx, ISA_MIPS3);
             check_mips_64(ctx);
 #endif
-            /* fall through */
+            fallthrough;
         case LWM32:
         case SWM32:
             gen_ldst_multiple(ctx, minor, rt, rs, SIMM(ctx->opcode, 0, 12));
             break;
         default:
             MIPS_INVAL("pool32b");
             gen_reserved_instruction(ctx);
             break;
         }
         break;
     case POOL32F:
         if (ctx->CP0_Config1 & (1 << CP0C1_FP)) {
             minor = ctx->opcode & 0x3f;
             check_cp1_enabled(ctx);
             switch (minor) {
             case ALNV_PS:
                 check_insn_opc_removed(ctx, ISA_MIPS_R6);
                 mips32_op = OPC_ALNV_PS;
                 goto do_madd;
             case MADD_S:
                 check_insn_opc_removed(ctx, ISA_MIPS_R6);
                 mips32_op = OPC_MADD_S;
                 goto do_madd;
             case MADD_D:
                 check_insn_opc_removed(ctx, ISA_MIPS_R6);
                 mips32_op = OPC_MADD_D;
                 goto do_madd;
             case MADD_PS:
                 check_insn_opc_removed(ctx, ISA_MIPS_R6);
                 mips32_op = OPC_MADD_PS;
                 goto do_madd;
             case MSUB_S:
                 check_insn_opc_removed(ctx, ISA_MIPS_R6);
                 mips32_op = OPC_MSUB_S;
                 goto do_madd;
             case MSUB_D:
                 check_insn_opc_removed(ctx, ISA_MIPS_R6);
                 mips32_op = OPC_MSUB_D;
                 goto do_madd;
             case MSUB_PS:
                 check_insn_opc_removed(ctx, ISA_MIPS_R6);
                 mips32_op = OPC_MSUB_PS;
                 goto do_madd;
             case NMADD_S:
                 check_insn_opc_removed(ctx, ISA_MIPS_R6);
                 mips32_op = OPC_NMADD_S;
                 goto do_madd;
             case NMADD_D:
                 check_insn_opc_removed(ctx, ISA_MIPS_R6);
                 mips32_op = OPC_NMADD_D;
                 goto do_madd;
             case NMADD_PS:
                 check_insn_opc_removed(ctx, ISA_MIPS_R6);
                 mips32_op = OPC_NMADD_PS;
                 goto do_madd;
             case NMSUB_S:
                 check_insn_opc_removed(ctx, ISA_MIPS_R6);
                 mips32_op = OPC_NMSUB_S;
                 goto do_madd;
             case NMSUB_D:
                 check_insn_opc_removed(ctx, ISA_MIPS_R6);
                 mips32_op = OPC_NMSUB_D;
                 goto do_madd;
             case NMSUB_PS:
                 check_insn_opc_removed(ctx, ISA_MIPS_R6);
                 mips32_op = OPC_NMSUB_PS;
             do_madd:
                 gen_flt3_arith(ctx, mips32_op, rd, rr, rs, rt);
                 break;
             case CABS_COND_FMT:
                 check_insn_opc_removed(ctx, ISA_MIPS_R6);
                 cond = (ctx->opcode >> 6) & 0xf;
                 cc = (ctx->opcode >> 13) & 0x7;
                 fmt = (ctx->opcode >> 10) & 0x3;
                 switch (fmt) {
                 case 0x0:
                     gen_cmpabs_s(ctx, cond, rt, rs, cc);
                     break;
                 case 0x1:
                     gen_cmpabs_d(ctx, cond, rt, rs, cc);
                     break;
                 case 0x2:
                     gen_cmpabs_ps(ctx, cond, rt, rs, cc);
                     break;
                 default:
                     goto pool32f_invalid;
                 }
                 break;
             case C_COND_FMT:
                 check_insn_opc_removed(ctx, ISA_MIPS_R6);
                 cond = (ctx->opcode >> 6) & 0xf;
                 cc = (ctx->opcode >> 13) & 0x7;
                 fmt = (ctx->opcode >> 10) & 0x3;
                 switch (fmt) {
                 case 0x0:
                     gen_cmp_s(ctx, cond, rt, rs, cc);
                     break;
                 case 0x1:
                     gen_cmp_d(ctx, cond, rt, rs, cc);
                     break;
                 case 0x2:
                     gen_cmp_ps(ctx, cond, rt, rs, cc);
                     break;
                 default:
                     goto pool32f_invalid;
                 }
                 break;
             case CMP_CONDN_S:
                 check_insn(ctx, ISA_MIPS_R6);
                 gen_r6_cmp_s(ctx, (ctx->opcode >> 6) & 0x1f, rt, rs, rd);
                 break;
             case CMP_CONDN_D:
                 check_insn(ctx, ISA_MIPS_R6);
                 gen_r6_cmp_d(ctx, (ctx->opcode >> 6) & 0x1f, rt, rs, rd);
                 break;
             case POOL32FXF:
                 gen_pool32fxf(ctx, rt, rs);
                 break;
             case 0x00:
                 /* PLL foo */
                 switch ((ctx->opcode >> 6) & 0x7) {
                 case PLL_PS:
                     mips32_op = OPC_PLL_PS;
                     goto do_ps;
                 case PLU_PS:
                     mips32_op = OPC_PLU_PS;
                     goto do_ps;
                 case PUL_PS:
                     mips32_op = OPC_PUL_PS;
                     goto do_ps;
                 case PUU_PS:
                     mips32_op = OPC_PUU_PS;
                     goto do_ps;
                 case CVT_PS_S:
                     check_insn_opc_removed(ctx, ISA_MIPS_R6);
                     mips32_op = OPC_CVT_PS_S;
                 do_ps:
                     gen_farith(ctx, mips32_op, rt, rs, rd, 0);
                     break;
                 default:
                     goto pool32f_invalid;
                 }
                 break;
             case MIN_FMT:
                 check_insn(ctx, ISA_MIPS_R6);
                 switch ((ctx->opcode >> 9) & 0x3) {
                 case FMT_SDPS_S:
                     gen_farith(ctx, OPC_MIN_S, rt, rs, rd, 0);
                     break;
                 case FMT_SDPS_D:
                     gen_farith(ctx, OPC_MIN_D, rt, rs, rd, 0);
                     break;
                 default:
                     goto pool32f_invalid;
                 }
                 break;
             case 0x08:
                 /* [LS][WDU]XC1 */
                 switch ((ctx->opcode >> 6) & 0x7) {
                 case LWXC1:
                     check_insn_opc_removed(ctx, ISA_MIPS_R6);
                     mips32_op = OPC_LWXC1;
                     goto do_ldst_cp1;
                 case SWXC1:
                     check_insn_opc_removed(ctx, ISA_MIPS_R6);
                     mips32_op = OPC_SWXC1;
                     goto do_ldst_cp1;
                 case LDXC1:
                     check_insn_opc_removed(ctx, ISA_MIPS_R6);
                     mips32_op = OPC_LDXC1;
                     goto do_ldst_cp1;
                 case SDXC1:
                     check_insn_opc_removed(ctx, ISA_MIPS_R6);
                     mips32_op = OPC_SDXC1;
                     goto do_ldst_cp1;
                 case LUXC1:
                     check_insn_opc_removed(ctx, ISA_MIPS_R6);
                     mips32_op = OPC_LUXC1;
                     goto do_ldst_cp1;
                 case SUXC1:
                     check_insn_opc_removed(ctx, ISA_MIPS_R6);
                     mips32_op = OPC_SUXC1;
                 do_ldst_cp1:
                     gen_flt3_ldst(ctx, mips32_op, rd, rd, rt, rs);
                     break;
                 default:
                     goto pool32f_invalid;
                 }
                 break;
             case MAX_FMT:
                 check_insn(ctx, ISA_MIPS_R6);
                 switch ((ctx->opcode >> 9) & 0x3) {
                 case FMT_SDPS_S:
                     gen_farith(ctx, OPC_MAX_S, rt, rs, rd, 0);
                     break;
                 case FMT_SDPS_D:
                     gen_farith(ctx, OPC_MAX_D, rt, rs, rd, 0);
                     break;
                 default:
                     goto pool32f_invalid;
                 }
                 break;
             case 0x18:
                 /* 3D insns */
                 check_insn_opc_removed(ctx, ISA_MIPS_R6);
                 fmt = (ctx->opcode >> 9) & 0x3;
                 switch ((ctx->opcode >> 6) & 0x7) {
                 case RSQRT2_FMT:
                     switch (fmt) {
                     case FMT_SDPS_S:
                         mips32_op = OPC_RSQRT2_S;
                         goto do_3d;
                     case FMT_SDPS_D:
                         mips32_op = OPC_RSQRT2_D;
                         goto do_3d;
                     case FMT_SDPS_PS:
                         mips32_op = OPC_RSQRT2_PS;
                         goto do_3d;
                     default:
                         goto pool32f_invalid;
                     }
                     break;
                 case RECIP2_FMT:
                     switch (fmt) {
                     case FMT_SDPS_S:
                         mips32_op = OPC_RECIP2_S;
                         goto do_3d;
                     case FMT_SDPS_D:
                         mips32_op = OPC_RECIP2_D;
                         goto do_3d;
                     case FMT_SDPS_PS:
                         mips32_op = OPC_RECIP2_PS;
                         goto do_3d;
                     default:
                         goto pool32f_invalid;
                     }
                     break;
                 case ADDR_PS:
                     mips32_op = OPC_ADDR_PS;
                     goto do_3d;
                 case MULR_PS:
                     mips32_op = OPC_MULR_PS;
                 do_3d:
                     gen_farith(ctx, mips32_op, rt, rs, rd, 0);
                     break;
                 default:
                     goto pool32f_invalid;
                 }
                 break;
             case 0x20:
                 /* MOV[FT].fmt, PREFX, RINT.fmt, CLASS.fmt*/
                 cc = (ctx->opcode >> 13) & 0x7;
                 fmt = (ctx->opcode >> 9) & 0x3;
                 switch ((ctx->opcode >> 6) & 0x7) {
                 case MOVF_FMT: /* RINT_FMT */
                     if (ctx->insn_flags & ISA_MIPS_R6) {
                         /* RINT_FMT */
                         switch (fmt) {
                         case FMT_SDPS_S:
                             gen_farith(ctx, OPC_RINT_S, 0, rt, rs, 0);
                             break;
                         case FMT_SDPS_D:
                             gen_farith(ctx, OPC_RINT_D, 0, rt, rs, 0);
                             break;
                         default:
                             goto pool32f_invalid;
                         }
                     } else {
                         /* MOVF_FMT */
                         switch (fmt) {
                         case FMT_SDPS_S:
                             gen_movcf_s(ctx, rs, rt, cc, 0);
                             break;
                         case FMT_SDPS_D:
                             gen_movcf_d(ctx, rs, rt, cc, 0);
                             break;
                         case FMT_SDPS_PS:
                             check_ps(ctx);
                             gen_movcf_ps(ctx, rs, rt, cc, 0);
                             break;
                         default:
                             goto pool32f_invalid;
                         }
                     }
                     break;
                 case MOVT_FMT: /* CLASS_FMT */
                     if (ctx->insn_flags & ISA_MIPS_R6) {
                         /* CLASS_FMT */
                         switch (fmt) {
                         case FMT_SDPS_S:
                             gen_farith(ctx, OPC_CLASS_S, 0, rt, rs, 0);
                             break;
                         case FMT_SDPS_D:
                             gen_farith(ctx, OPC_CLASS_D, 0, rt, rs, 0);
                             break;
                         default:
                             goto pool32f_invalid;
                         }
                     } else {
                         /* MOVT_FMT */
                         switch (fmt) {
                         case FMT_SDPS_S:
                             gen_movcf_s(ctx, rs, rt, cc, 1);
                             break;
                         case FMT_SDPS_D:
                             gen_movcf_d(ctx, rs, rt, cc, 1);
                             break;
                         case FMT_SDPS_PS:
                             check_ps(ctx);
                             gen_movcf_ps(ctx, rs, rt, cc, 1);
                             break;
                         default:
                             goto pool32f_invalid;
                         }
                     }
                     break;
                 case PREFX:
                     check_insn_opc_removed(ctx, ISA_MIPS_R6);
                     break;
                 default:
                     goto pool32f_invalid;
                 }
                 break;
 #define FINSN_3ARG_SDPS(prfx)                           \
                 switch ((ctx->opcode >> 8) & 0x3) {     \
                 case FMT_SDPS_S:                        \
                     mips32_op = OPC_##prfx##_S;         \
                     goto do_fpop;                       \
                 case FMT_SDPS_D:                        \
                     mips32_op = OPC_##prfx##_D;         \
                     goto do_fpop;                       \
                 case FMT_SDPS_PS:                       \
                     check_ps(ctx);                      \
                     mips32_op = OPC_##prfx##_PS;        \
                     goto do_fpop;                       \
                 default:                                \
                     goto pool32f_invalid;               \
                 }
             case MINA_FMT:
                 check_insn(ctx, ISA_MIPS_R6);
                 switch ((ctx->opcode >> 9) & 0x3) {
                 case FMT_SDPS_S:
                     gen_farith(ctx, OPC_MINA_S, rt, rs, rd, 0);
                     break;
                 case FMT_SDPS_D:
                     gen_farith(ctx, OPC_MINA_D, rt, rs, rd, 0);
                     break;
                 default:
                     goto pool32f_invalid;
                 }
                 break;
             case MAXA_FMT:
                 check_insn(ctx, ISA_MIPS_R6);
                 switch ((ctx->opcode >> 9) & 0x3) {
                 case FMT_SDPS_S:
                     gen_farith(ctx, OPC_MAXA_S, rt, rs, rd, 0);
                     break;
                 case FMT_SDPS_D:
                     gen_farith(ctx, OPC_MAXA_D, rt, rs, rd, 0);
                     break;
                 default:
                     goto pool32f_invalid;
                 }
                 break;
             case 0x30:
                 /* regular FP ops */
                 switch ((ctx->opcode >> 6) & 0x3) {
                 case ADD_FMT:
                     FINSN_3ARG_SDPS(ADD);
                     break;
                 case SUB_FMT:
                     FINSN_3ARG_SDPS(SUB);
                     break;
                 case MUL_FMT:
                     FINSN_3ARG_SDPS(MUL);
                     break;
                 case DIV_FMT:
                     fmt = (ctx->opcode >> 8) & 0x3;
                     if (fmt == 1) {
                         mips32_op = OPC_DIV_D;
                     } else if (fmt == 0) {
                         mips32_op = OPC_DIV_S;
                     } else {
                         goto pool32f_invalid;
                     }
                     goto do_fpop;
                 default:
                     goto pool32f_invalid;
                 }
                 break;
             case 0x38:
                 /* cmovs */
                 switch ((ctx->opcode >> 6) & 0x7) {
                 case MOVN_FMT: /* SELEQZ_FMT */
                     if (ctx->insn_flags & ISA_MIPS_R6) {
                         /* SELEQZ_FMT */
                         switch ((ctx->opcode >> 9) & 0x3) {
                         case FMT_SDPS_S:
                             gen_sel_s(ctx, OPC_SELEQZ_S, rd, rt, rs);
                             break;
                         case FMT_SDPS_D:
                             gen_sel_d(ctx, OPC_SELEQZ_D, rd, rt, rs);
                             break;
                         default:
                             goto pool32f_invalid;
                         }
                     } else {
                         /* MOVN_FMT */
                         FINSN_3ARG_SDPS(MOVN);
                     }
                     break;
                 case MOVN_FMT_04:
                     check_insn_opc_removed(ctx, ISA_MIPS_R6);
                     FINSN_3ARG_SDPS(MOVN);
                     break;
                 case MOVZ_FMT: /* SELNEZ_FMT */
                     if (ctx->insn_flags & ISA_MIPS_R6) {
                         /* SELNEZ_FMT */
                         switch ((ctx->opcode >> 9) & 0x3) {
                         case FMT_SDPS_S:
                             gen_sel_s(ctx, OPC_SELNEZ_S, rd, rt, rs);
                             break;
                         case FMT_SDPS_D:
                             gen_sel_d(ctx, OPC_SELNEZ_D, rd, rt, rs);
                             break;
                         default:
                             goto pool32f_invalid;
                         }
                     } else {
                         /* MOVZ_FMT */
                         FINSN_3ARG_SDPS(MOVZ);
                     }
                     break;
                 case MOVZ_FMT_05:
                     check_insn_opc_removed(ctx, ISA_MIPS_R6);
                     FINSN_3ARG_SDPS(MOVZ);
                     break;
                 case SEL_FMT:
                     check_insn(ctx, ISA_MIPS_R6);
                     switch ((ctx->opcode >> 9) & 0x3) {
                     case FMT_SDPS_S:
                         gen_sel_s(ctx, OPC_SEL_S, rd, rt, rs);
                         break;
                     case FMT_SDPS_D:
                         gen_sel_d(ctx, OPC_SEL_D, rd, rt, rs);
                         break;
                     default:
                         goto pool32f_invalid;
                     }
                     break;
                 case MADDF_FMT:
                     check_insn(ctx, ISA_MIPS_R6);
                     switch ((ctx->opcode >> 9) & 0x3) {
                     case FMT_SDPS_S:
                         mips32_op = OPC_MADDF_S;
                         goto do_fpop;
                     case FMT_SDPS_D:
                         mips32_op = OPC_MADDF_D;
                         goto do_fpop;
                     default:
                         goto pool32f_invalid;
                     }
                     break;
                 case MSUBF_FMT:
                     check_insn(ctx, ISA_MIPS_R6);
                     switch ((ctx->opcode >> 9) & 0x3) {
                     case FMT_SDPS_S:
                         mips32_op = OPC_MSUBF_S;
                         goto do_fpop;
                     case FMT_SDPS_D:
                         mips32_op = OPC_MSUBF_D;
                         goto do_fpop;
                     default:
                         goto pool32f_invalid;
                     }
                     break;
                 default:
                     goto pool32f_invalid;
                 }
                 break;
             do_fpop:
                 gen_farith(ctx, mips32_op, rt, rs, rd, 0);
                 break;
             default:
             pool32f_invalid:
                 MIPS_INVAL("pool32f");
                 gen_reserved_instruction(ctx);
                 break;
             }
         } else {
             generate_exception_err(ctx, EXCP_CpU, 1);
         }
         break;
     case POOL32I:
         minor = (ctx->opcode >> 21) & 0x1f;
         switch (minor) {
         case BLTZ:
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
             gen_compute_branch(ctx, OPC_BLTZ, 4, rs, -1, imm << 1, 4);
             break;
         case BLTZAL:
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
             gen_compute_branch(ctx, OPC_BLTZAL, 4, rs, -1, imm << 1, 4);
             ctx->hflags |= MIPS_HFLAG_BDS_STRICT;
             break;
         case BLTZALS:
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
             gen_compute_branch(ctx, OPC_BLTZAL, 4, rs, -1, imm << 1, 2);
             ctx->hflags |= MIPS_HFLAG_BDS_STRICT;
             break;
         case BGEZ:
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
             gen_compute_branch(ctx, OPC_BGEZ, 4, rs, -1, imm << 1, 4);
             break;
         case BGEZAL:
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
             gen_compute_branch(ctx, OPC_BGEZAL, 4, rs, -1, imm << 1, 4);
             ctx->hflags |= MIPS_HFLAG_BDS_STRICT;
             break;
         case BGEZALS:
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
             gen_compute_branch(ctx, OPC_BGEZAL, 4, rs, -1, imm << 1, 2);
             ctx->hflags |= MIPS_HFLAG_BDS_STRICT;
             break;
         case BLEZ:
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
             gen_compute_branch(ctx, OPC_BLEZ, 4, rs, -1, imm << 1, 4);
             break;
         case BGTZ:
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
             gen_compute_branch(ctx, OPC_BGTZ, 4, rs, -1, imm << 1, 4);
             break;
 
             /* Traps */
         case TLTI: /* BC1EQZC */
             if (ctx->insn_flags & ISA_MIPS_R6) {
                 /* BC1EQZC */
                 check_cp1_enabled(ctx);
                 gen_compute_branch1_r6(ctx, OPC_BC1EQZ, rs, imm << 1, 0);
             } else {
                 /* TLTI */
                 mips32_op = OPC_TLTI;
                 goto do_trapi;
             }
             break;
         case TGEI: /* BC1NEZC */
             if (ctx->insn_flags & ISA_MIPS_R6) {
                 /* BC1NEZC */
                 check_cp1_enabled(ctx);
                 gen_compute_branch1_r6(ctx, OPC_BC1NEZ, rs, imm << 1, 0);
             } else {
                 /* TGEI */
                 mips32_op = OPC_TGEI;
                 goto do_trapi;
             }
             break;
         case TLTIU:
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
             mips32_op = OPC_TLTIU;
             goto do_trapi;
         case TGEIU:
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
             mips32_op = OPC_TGEIU;
             goto do_trapi;
         case TNEI: /* SYNCI */
             if (ctx->insn_flags & ISA_MIPS_R6) {
                 /* SYNCI */
                 /*
                  * Break the TB to be able to sync copied instructions
                  * immediately.
                  */
                 ctx->base.is_jmp = DISAS_STOP;
             } else {
                 /* TNEI */
                 mips32_op = OPC_TNEI;
                 goto do_trapi;
             }
             break;
         case TEQI:
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
             mips32_op = OPC_TEQI;
         do_trapi:
             gen_trap(ctx, mips32_op, rs, -1, imm, 0);
             break;
 
         case BNEZC:
         case BEQZC:
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
             gen_compute_branch(ctx, minor == BNEZC ? OPC_BNE : OPC_BEQ,
                                4, rs, 0, imm << 1, 0);
             /*
              * Compact branches don't have a delay slot, so just let
              * the normal delay slot handling take us to the branch
              * target.
              */
             break;
         case LUI:
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
             gen_logic_imm(ctx, OPC_LUI, rs, 0, imm);
             break;
         case SYNCI:
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
             /*
              * Break the TB to be able to sync copied instructions
              * immediately.
              */
             ctx->base.is_jmp = DISAS_STOP;
             break;
         case BC2F:
         case BC2T:
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
             /* COP2: Not implemented. */
             generate_exception_err(ctx, EXCP_CpU, 2);
             break;
         case BC1F:
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
             mips32_op = (ctx->opcode & (1 << 16)) ? OPC_BC1FANY2 : OPC_BC1F;
             goto do_cp1branch;
         case BC1T:
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
             mips32_op = (ctx->opcode & (1 << 16)) ? OPC_BC1TANY2 : OPC_BC1T;
             goto do_cp1branch;
         case BC1ANY4F:
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
             mips32_op = OPC_BC1FANY4;
             goto do_cp1mips3d;
         case BC1ANY4T:
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
             mips32_op = OPC_BC1TANY4;
         do_cp1mips3d:
             check_cop1x(ctx);
             check_insn(ctx, ASE_MIPS3D);
             /* Fall through */
         do_cp1branch:
             if (env->CP0_Config1 & (1 << CP0C1_FP)) {
                 check_cp1_enabled(ctx);
                 gen_compute_branch1(ctx, mips32_op,
                                     (ctx->opcode >> 18) & 0x7, imm << 1);
             } else {
                 generate_exception_err(ctx, EXCP_CpU, 1);
             }
             break;
         default:
             MIPS_INVAL("pool32i");
             gen_reserved_instruction(ctx);
             break;
         }
         break;
     case POOL32C:
         minor = (ctx->opcode >> 12) & 0xf;
         offset = sextract32(ctx->opcode, 0,
                             (ctx->insn_flags & ISA_MIPS_R6) ? 9 : 12);
         switch (minor) {
         case LWL:
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
             mips32_op = OPC_LWL;
             goto do_ld_lr;
         case SWL:
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
             mips32_op = OPC_SWL;
             goto do_st_lr;
         case LWR:
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
             mips32_op = OPC_LWR;
             goto do_ld_lr;
         case SWR:
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
             mips32_op = OPC_SWR;
             goto do_st_lr;
 #if defined(TARGET_MIPS64)
         case LDL:
             check_insn(ctx, ISA_MIPS3);
             check_mips_64(ctx);
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
             mips32_op = OPC_LDL;
             goto do_ld_lr;
         case SDL:
             check_insn(ctx, ISA_MIPS3);
             check_mips_64(ctx);
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
             mips32_op = OPC_SDL;
             goto do_st_lr;
         case LDR:
             check_insn(ctx, ISA_MIPS3);
             check_mips_64(ctx);
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
             mips32_op = OPC_LDR;
             goto do_ld_lr;
         case SDR:
             check_insn(ctx, ISA_MIPS3);
             check_mips_64(ctx);
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
             mips32_op = OPC_SDR;
             goto do_st_lr;
         case LWU:
             check_insn(ctx, ISA_MIPS3);
             check_mips_64(ctx);
             mips32_op = OPC_LWU;
             goto do_ld_lr;
         case LLD:
             check_insn(ctx, ISA_MIPS3);
             check_mips_64(ctx);
             mips32_op = OPC_LLD;
             goto do_ld_lr;
 #endif
         case LL:
             mips32_op = OPC_LL;
             goto do_ld_lr;
         do_ld_lr:
             gen_ld(ctx, mips32_op, rt, rs, offset);
             break;
         do_st_lr:
             gen_st(ctx, mips32_op, rt, rs, offset);
             break;
         case SC:
             gen_st_cond(ctx, rt, rs, offset, MO_TESL, false);
             break;
 #if defined(TARGET_MIPS64)
         case SCD:
             check_insn(ctx, ISA_MIPS3);
             check_mips_64(ctx);
             gen_st_cond(ctx, rt, rs, offset, MO_TEUQ, false);
             break;
 #endif
         case LD_EVA:
             if (!ctx->eva) {
                 MIPS_INVAL("pool32c ld-eva");
                 gen_reserved_instruction(ctx);
                 break;
             }
             check_cp0_enabled(ctx);
 
             minor2 = (ctx->opcode >> 9) & 0x7;
             offset = sextract32(ctx->opcode, 0, 9);
             switch (minor2) {
             case LBUE:
                 mips32_op = OPC_LBUE;
                 goto do_ld_lr;
             case LHUE:
                 mips32_op = OPC_LHUE;
                 goto do_ld_lr;
             case LWLE:
                 check_insn_opc_removed(ctx, ISA_MIPS_R6);
                 mips32_op = OPC_LWLE;
                 goto do_ld_lr;
             case LWRE:
                 check_insn_opc_removed(ctx, ISA_MIPS_R6);
                 mips32_op = OPC_LWRE;
                 goto do_ld_lr;
             case LBE:
                 mips32_op = OPC_LBE;
                 goto do_ld_lr;
             case LHE:
                 mips32_op = OPC_LHE;
                 goto do_ld_lr;
             case LLE:
                 mips32_op = OPC_LLE;
                 goto do_ld_lr;
             case LWE:
                 mips32_op = OPC_LWE;
                 goto do_ld_lr;
             };
             break;
         case ST_EVA:
             if (!ctx->eva) {
                 MIPS_INVAL("pool32c st-eva");
                 gen_reserved_instruction(ctx);
                 break;
             }
             check_cp0_enabled(ctx);
 
             minor2 = (ctx->opcode >> 9) & 0x7;
             offset = sextract32(ctx->opcode, 0, 9);
             switch (minor2) {
             case SWLE:
                 check_insn_opc_removed(ctx, ISA_MIPS_R6);
                 mips32_op = OPC_SWLE;
                 goto do_st_lr;
             case SWRE:
                 check_insn_opc_removed(ctx, ISA_MIPS_R6);
                 mips32_op = OPC_SWRE;
                 goto do_st_lr;
             case PREFE:
                 /* Treat as no-op */
                 if ((ctx->insn_flags & ISA_MIPS_R6) && (rt >= 24)) {
                     /* hint codes 24-31 are reserved and signal RI */
                     generate_exception(ctx, EXCP_RI);
                 }
                 break;
             case CACHEE:
                 /* Treat as no-op */
                 if (ctx->hflags & MIPS_HFLAG_ITC_CACHE) {
                     gen_cache_operation(ctx, rt, rs, offset);
                 }
                 break;
             case SBE:
                 mips32_op = OPC_SBE;
                 goto do_st_lr;
             case SHE:
                 mips32_op = OPC_SHE;
                 goto do_st_lr;
             case SCE:
                 gen_st_cond(ctx, rt, rs, offset, MO_TESL, true);
                 break;
             case SWE:
                 mips32_op = OPC_SWE;
                 goto do_st_lr;
             };
             break;
         case PREF:
             /* Treat as no-op */
             if ((ctx->insn_flags & ISA_MIPS_R6) && (rt >= 24)) {
                 /* hint codes 24-31 are reserved and signal RI */
                 generate_exception(ctx, EXCP_RI);
             }
             break;
         default:
             MIPS_INVAL("pool32c");
             gen_reserved_instruction(ctx);
             break;
         }
         break;
     case ADDI32: /* AUI, LUI */
         if (ctx->insn_flags & ISA_MIPS_R6) {
             /* AUI, LUI */
             gen_logic_imm(ctx, OPC_LUI, rt, rs, imm);
         } else {
             /* ADDI32 */
             mips32_op = OPC_ADDI;
             goto do_addi;
         }
         break;
     case ADDIU32:
         mips32_op = OPC_ADDIU;
     do_addi:
         gen_arith_imm(ctx, mips32_op, rt, rs, imm);
         break;
 
         /* Logical operations */
     case ORI32:
         mips32_op = OPC_ORI;
         goto do_logici;
     case XORI32:
         mips32_op = OPC_XORI;
         goto do_logici;
     case ANDI32:
         mips32_op = OPC_ANDI;
     do_logici:
         gen_logic_imm(ctx, mips32_op, rt, rs, imm);
         break;
 
         /* Set less than immediate */
     case SLTI32:
         mips32_op = OPC_SLTI;
         goto do_slti;
     case SLTIU32:
         mips32_op = OPC_SLTIU;
     do_slti:
         gen_slt_imm(ctx, mips32_op, rt, rs, imm);
         break;
     case JALX32:
         check_insn_opc_removed(ctx, ISA_MIPS_R6);
         offset = (int32_t)(ctx->opcode & 0x3FFFFFF) << 2;
         gen_compute_branch(ctx, OPC_JALX, 4, rt, rs, offset, 4);
         ctx->hflags |= MIPS_HFLAG_BDS_STRICT;
         break;
     case JALS32: /* BOVC, BEQC, BEQZALC */
         if (ctx->insn_flags & ISA_MIPS_R6) {
             if (rs >= rt) {
                 /* BOVC */
                 mips32_op = OPC_BOVC;
             } else if (rs < rt && rs == 0) {
                 /* BEQZALC */
                 mips32_op = OPC_BEQZALC;
             } else {
                 /* BEQC */
                 mips32_op = OPC_BEQC;
             }
             gen_compute_compact_branch(ctx, mips32_op, rs, rt, imm << 1);
         } else {
             /* JALS32 */
             offset = (int32_t)(ctx->opcode & 0x3FFFFFF) << 1;
             gen_compute_branch(ctx, OPC_JAL, 4, rt, rs, offset, 2);
             ctx->hflags |= MIPS_HFLAG_BDS_STRICT;
         }
         break;
     case BEQ32: /* BC */
         if (ctx->insn_flags & ISA_MIPS_R6) {
             /* BC */
             gen_compute_compact_branch(ctx, OPC_BC, 0, 0,
                                        sextract32(ctx->opcode << 1, 0, 27));
         } else {
             /* BEQ32 */
             gen_compute_branch(ctx, OPC_BEQ, 4, rt, rs, imm << 1, 4);
         }
         break;
     case BNE32: /* BALC */
         if (ctx->insn_flags & ISA_MIPS_R6) {
             /* BALC */
             gen_compute_compact_branch(ctx, OPC_BALC, 0, 0,
                                        sextract32(ctx->opcode << 1, 0, 27));
         } else {
             /* BNE32 */
             gen_compute_branch(ctx, OPC_BNE, 4, rt, rs, imm << 1, 4);
         }
         break;
     case J32: /* BGTZC, BLTZC, BLTC */
         if (ctx->insn_flags & ISA_MIPS_R6) {
             if (rs == 0 && rt != 0) {
                 /* BGTZC */
                 mips32_op = OPC_BGTZC;
             } else if (rs != 0 && rt != 0 && rs == rt) {
                 /* BLTZC */
                 mips32_op = OPC_BLTZC;
             } else {
                 /* BLTC */
                 mips32_op = OPC_BLTC;
             }
             gen_compute_compact_branch(ctx, mips32_op, rs, rt, imm << 1);
         } else {
             /* J32 */
             gen_compute_branch(ctx, OPC_J, 4, rt, rs,
                                (int32_t)(ctx->opcode & 0x3FFFFFF) << 1, 4);
         }
         break;
     case JAL32: /* BLEZC, BGEZC, BGEC */
         if (ctx->insn_flags & ISA_MIPS_R6) {
             if (rs == 0 && rt != 0) {
                 /* BLEZC */
                 mips32_op = OPC_BLEZC;
             } else if (rs != 0 && rt != 0 && rs == rt) {
                 /* BGEZC */
                 mips32_op = OPC_BGEZC;
             } else {
                 /* BGEC */
                 mips32_op = OPC_BGEC;
             }
             gen_compute_compact_branch(ctx, mips32_op, rs, rt, imm << 1);
         } else {
             /* JAL32 */
             gen_compute_branch(ctx, OPC_JAL, 4, rt, rs,
                                (int32_t)(ctx->opcode & 0x3FFFFFF) << 1, 4);
             ctx->hflags |= MIPS_HFLAG_BDS_STRICT;
         }
         break;
         /* Floating point (COP1) */
     case LWC132:
         mips32_op = OPC_LWC1;
         goto do_cop1;
     case LDC132:
         mips32_op = OPC_LDC1;
         goto do_cop1;
     case SWC132:
         mips32_op = OPC_SWC1;
         goto do_cop1;
     case SDC132:
         mips32_op = OPC_SDC1;
     do_cop1:
         gen_cop1_ldst(ctx, mips32_op, rt, rs, imm);
         break;
     case ADDIUPC: /* PCREL: ADDIUPC, AUIPC, ALUIPC, LWPC */
         if (ctx->insn_flags & ISA_MIPS_R6) {
             /* PCREL: ADDIUPC, AUIPC, ALUIPC, LWPC */
             switch ((ctx->opcode >> 16) & 0x1f) {
             case ADDIUPC_00:
             case ADDIUPC_01:
             case ADDIUPC_02:
             case ADDIUPC_03:
             case ADDIUPC_04:
             case ADDIUPC_05:
             case ADDIUPC_06:
             case ADDIUPC_07:
                 gen_pcrel(ctx, OPC_ADDIUPC, ctx->base.pc_next & ~0x3, rt);
                 break;
             case AUIPC:
                 gen_pcrel(ctx, OPC_AUIPC, ctx->base.pc_next, rt);
                 break;
             case ALUIPC:
                 gen_pcrel(ctx, OPC_ALUIPC, ctx->base.pc_next, rt);
                 break;
             case LWPC_08:
             case LWPC_09:
             case LWPC_0A:
             case LWPC_0B:
             case LWPC_0C:
             case LWPC_0D:
             case LWPC_0E:
             case LWPC_0F:
                 gen_pcrel(ctx, R6_OPC_LWPC, ctx->base.pc_next & ~0x3, rt);
                 break;
             default:
                 generate_exception(ctx, EXCP_RI);
                 break;
             }
         } else {
             /* ADDIUPC */
             int reg = mmreg(ZIMM(ctx->opcode, 23, 3));
             offset = SIMM(ctx->opcode, 0, 23) << 2;
 
             gen_addiupc(ctx, reg, offset, 0, 0);
         }
         break;
     case BNVC: /* BNEC, BNEZALC */
         check_insn(ctx, ISA_MIPS_R6);
         if (rs >= rt) {
             /* BNVC */
             mips32_op = OPC_BNVC;
         } else if (rs < rt && rs == 0) {
             /* BNEZALC */
             mips32_op = OPC_BNEZALC;
         } else {
             /* BNEC */
             mips32_op = OPC_BNEC;
         }
         gen_compute_compact_branch(ctx, mips32_op, rs, rt, imm << 1);
         break;
     case R6_BNEZC: /* JIALC */
         check_insn(ctx, ISA_MIPS_R6);
         if (rt != 0) {
             /* BNEZC */
             gen_compute_compact_branch(ctx, OPC_BNEZC, rt, 0,
                                        sextract32(ctx->opcode << 1, 0, 22));
         } else {
             /* JIALC */
             gen_compute_compact_branch(ctx, OPC_JIALC, 0, rs, imm);
         }
         break;
     case R6_BEQZC: /* JIC */
         check_insn(ctx, ISA_MIPS_R6);
         if (rt != 0) {
             /* BEQZC */
             gen_compute_compact_branch(ctx, OPC_BEQZC, rt, 0,
                                        sextract32(ctx->opcode << 1, 0, 22));
         } else {
             /* JIC */
             gen_compute_compact_branch(ctx, OPC_JIC, 0, rs, imm);
         }
         break;
     case BLEZALC: /* BGEZALC, BGEUC */
         check_insn(ctx, ISA_MIPS_R6);
         if (rs == 0 && rt != 0) {
             /* BLEZALC */
             mips32_op = OPC_BLEZALC;
         } else if (rs != 0 && rt != 0 && rs == rt) {
             /* BGEZALC */
             mips32_op = OPC_BGEZALC;
         } else {
             /* BGEUC */
             mips32_op = OPC_BGEUC;
         }
         gen_compute_compact_branch(ctx, mips32_op, rs, rt, imm << 1);
         break;
     case BGTZALC: /* BLTZALC, BLTUC */
         check_insn(ctx, ISA_MIPS_R6);
         if (rs == 0 && rt != 0) {
             /* BGTZALC */
             mips32_op = OPC_BGTZALC;
         } else if (rs != 0 && rt != 0 && rs == rt) {
             /* BLTZALC */
             mips32_op = OPC_BLTZALC;
         } else {
             /* BLTUC */
             mips32_op = OPC_BLTUC;
         }
         gen_compute_compact_branch(ctx, mips32_op, rs, rt, imm << 1);
         break;
         /* Loads and stores */
     case LB32:
         mips32_op = OPC_LB;
         goto do_ld;
     case LBU32:
         mips32_op = OPC_LBU;
         goto do_ld;
     case LH32:
         mips32_op = OPC_LH;
         goto do_ld;
     case LHU32:
         mips32_op = OPC_LHU;
         goto do_ld;
     case LW32:
         mips32_op = OPC_LW;
         goto do_ld;
 #ifdef TARGET_MIPS64
     case LD32:
         check_insn(ctx, ISA_MIPS3);
         check_mips_64(ctx);
         mips32_op = OPC_LD;
         goto do_ld;
     case SD32:
         check_insn(ctx, ISA_MIPS3);
         check_mips_64(ctx);
         mips32_op = OPC_SD;
         goto do_st;
 #endif
     case SB32:
         mips32_op = OPC_SB;
         goto do_st;
     case SH32:
         mips32_op = OPC_SH;
         goto do_st;
     case SW32:
         mips32_op = OPC_SW;
         goto do_st;
     do_ld:
         gen_ld(ctx, mips32_op, rt, rs, imm);
         break;
     do_st:
         gen_st(ctx, mips32_op, rt, rs, imm);
         break;
     default:
         gen_reserved_instruction(ctx);
         break;
     }
 }
diff --git a/target/mips/tcg/mips16e_translate.c.inc b/target/mips/tcg/mips16e_translate.c.inc
index 5cffe0e412..b8bdd6a7f2 100644
--- a/target/mips/tcg/mips16e_translate.c.inc
+++ b/target/mips/tcg/mips16e_translate.c.inc
@@ -130,159 +130,159 @@ static int xlat(int r)
 static void gen_mips16_save(DisasContext *ctx,
                             int xsregs, int aregs,
                             int do_ra, int do_s0, int do_s1,
                             int framesize)
 {
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
     TCGv t2 = tcg_temp_new();
     int args, astatic;
 
     switch (aregs) {
     case 0:
     case 1:
     case 2:
     case 3:
     case 11:
         args = 0;
         break;
     case 4:
     case 5:
     case 6:
     case 7:
         args = 1;
         break;
     case 8:
     case 9:
     case 10:
         args = 2;
         break;
     case 12:
     case 13:
         args = 3;
         break;
     case 14:
         args = 4;
         break;
     default:
         gen_reserved_instruction(ctx);
         return;
     }
 
     switch (args) {
     case 4:
         gen_base_offset_addr(ctx, t0, 29, 12);
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
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUL |
                            ctx->default_tcg_memop_mask);
     }
 
     gen_load_gpr(t0, 29);
 
 #define DECR_AND_STORE(reg) do {                                 \
         tcg_gen_movi_tl(t2, -4);                                 \
         gen_op_addr_add(ctx, t0, t0, t2);                        \
         gen_load_gpr(t1, reg);                                   \
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUL |       \
                            ctx->default_tcg_memop_mask);         \
     } while (0)
 
     if (do_ra) {
         DECR_AND_STORE(31);
     }
 
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
 
     if (do_s1) {
         DECR_AND_STORE(17);
     }
     if (do_s0) {
         DECR_AND_STORE(16);
     }
 
     switch (aregs) {
     case 0:
     case 4:
     case 8:
     case 12:
     case 14:
         astatic = 0;
         break;
     case 1:
     case 5:
     case 9:
     case 13:
         astatic = 1;
         break;
     case 2:
     case 6:
     case 10:
         astatic = 2;
         break;
     case 3:
     case 7:
         astatic = 3;
         break;
     case 11:
         astatic = 4;
         break;
     default:
         gen_reserved_instruction(ctx);
         return;
     }
 
     if (astatic > 0) {
         DECR_AND_STORE(7);
         if (astatic > 1) {
             DECR_AND_STORE(6);
             if (astatic > 2) {
                 DECR_AND_STORE(5);
                 if (astatic > 3) {
                     DECR_AND_STORE(4);
                 }
             }
         }
     }
 #undef DECR_AND_STORE
 
     tcg_gen_movi_tl(t2, -framesize);
     gen_op_addr_add(ctx, cpu_gpr[29], cpu_gpr[29], t2);
 }
@@ -290,105 +290,105 @@ static void gen_mips16_save(DisasContext *ctx,
 static void gen_mips16_restore(DisasContext *ctx,
                                int xsregs, int aregs,
                                int do_ra, int do_s0, int do_s1,
                                int framesize)
 {
     int astatic;
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
     TCGv t2 = tcg_temp_new();
 
     tcg_gen_movi_tl(t2, framesize);
     gen_op_addr_add(ctx, t0, cpu_gpr[29], t2);
 
 #define DECR_AND_LOAD(reg) do {                            \
         tcg_gen_movi_tl(t2, -4);                           \
         gen_op_addr_add(ctx, t0, t0, t2);                  \
         tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TESL | \
                            ctx->default_tcg_memop_mask);   \
         gen_store_gpr(t1, reg);                            \
     } while (0)
 
     if (do_ra) {
         DECR_AND_LOAD(31);
     }
 
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
 
     if (do_s1) {
         DECR_AND_LOAD(17);
     }
     if (do_s0) {
         DECR_AND_LOAD(16);
     }
 
     switch (aregs) {
     case 0:
     case 4:
     case 8:
     case 12:
     case 14:
         astatic = 0;
         break;
     case 1:
     case 5:
     case 9:
     case 13:
         astatic = 1;
         break;
     case 2:
     case 6:
     case 10:
         astatic = 2;
         break;
     case 3:
     case 7:
         astatic = 3;
         break;
     case 11:
         astatic = 4;
         break;
     default:
         gen_reserved_instruction(ctx);
         return;
     }
 
     if (astatic > 0) {
         DECR_AND_LOAD(7);
         if (astatic > 1) {
             DECR_AND_LOAD(6);
             if (astatic > 2) {
                 DECR_AND_LOAD(5);
                 if (astatic > 3) {
                     DECR_AND_LOAD(4);
                 }
             }
         }
     }
 #undef DECR_AND_LOAD
 
     tcg_gen_movi_tl(t2, framesize);
     gen_op_addr_add(ctx, cpu_gpr[29], cpu_gpr[29], t2);
 }
 
 #if defined(TARGET_MIPS64)
diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index c517258ac5..3811ac0d54 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -4564,19 +4564,19 @@ static void decode_opc_mxu__pool05(DisasContext *ctx)
 static void decode_opc_mxu__pool06(DisasContext *ctx)
 {
     uint32_t opcode = extract32(ctx->opcode, 10, 4);
     uint32_t strd2  = extract32(ctx->opcode, 14, 2);
 
     switch (opcode) {
     case OPC_MXU_S32LDST:
     case OPC_MXU_S32LDSTR:
         if (strd2 <= 2) {
             gen_mxu_s32ldxvx(ctx, opcode, false, strd2);
             break;
         }
-        /* fallthrough */
+        fallthrough;
     default:
         MIPS_INVAL("decode_opc_mxu");
         gen_reserved_instruction(ctx);
         break;
     }
 }
@@ -4584,19 +4584,19 @@ static void decode_opc_mxu__pool06(DisasContext *ctx)
 static void decode_opc_mxu__pool07(DisasContext *ctx)
 {
     uint32_t opcode = extract32(ctx->opcode, 10, 4);
     uint32_t strd2  = extract32(ctx->opcode, 14, 2);
 
     switch (opcode) {
     case OPC_MXU_S32LDST:
     case OPC_MXU_S32LDSTR:
         if (strd2 <= 2) {
             gen_mxu_s32stxvx(ctx, opcode, false, strd2);
             break;
         }
-        /* fallthrough */
+        fallthrough;
     default:
         MIPS_INVAL("decode_opc_mxu");
         gen_reserved_instruction(ctx);
         break;
     }
 }
@@ -4630,19 +4630,19 @@ static void decode_opc_mxu__pool09(DisasContext *ctx)
 static void decode_opc_mxu__pool10(DisasContext *ctx)
 {
     uint32_t opcode = extract32(ctx->opcode, 10, 4);
     uint32_t strd2  = extract32(ctx->opcode, 14, 2);
 
     switch (opcode) {
     case OPC_MXU_S32LDST:
     case OPC_MXU_S32LDSTR:
         if (strd2 <= 2) {
             gen_mxu_s32ldxvx(ctx, opcode, true, strd2);
             break;
         }
-        /* fallthrough */
+        fallthrough;
     default:
         MIPS_INVAL("decode_opc_mxu");
         gen_reserved_instruction(ctx);
         break;
     }
 }
@@ -4650,19 +4650,19 @@ static void decode_opc_mxu__pool10(DisasContext *ctx)
 static void decode_opc_mxu__pool11(DisasContext *ctx)
 {
     uint32_t opcode = extract32(ctx->opcode, 10, 4);
     uint32_t strd2  = extract32(ctx->opcode, 14, 2);
 
     switch (opcode) {
     case OPC_MXU_S32LDST:
     case OPC_MXU_S32LDSTR:
         if (strd2 <= 2) {
             gen_mxu_s32stxvx(ctx, opcode, true, strd2);
             break;
         }
-        /* fallthrough */
+        fallthrough;
     default:
         MIPS_INVAL("decode_opc_mxu");
         gen_reserved_instruction(ctx);
         break;
     }
 }
diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index b4b746d418..3e5f4f4e58 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -2604,121 +2604,121 @@ static void gen_compute_branch_cp1_nm(DisasContext *ctx, uint32_t op,
 static void gen_p_lsx(DisasContext *ctx, int rd, int rs, int rt)
 {
     TCGv t0, t1;
     t0 = tcg_temp_new();
     t1 = tcg_temp_new();
 
     gen_load_gpr(t0, rs);
     gen_load_gpr(t1, rt);
 
     if ((extract32(ctx->opcode, 6, 1)) == 1) {
         /* PP.LSXS instructions require shifting */
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
             tcg_gen_shli_tl(t0, t0, 2);
             break;
         case NM_LDC1XS:
         case NM_SDC1XS:
             tcg_gen_shli_tl(t0, t0, 3);
             break;
         default:
             gen_reserved_instruction(ctx);
             return;
         }
     }
     gen_op_addr_add(ctx, t0, t0, t1);
 
     switch (extract32(ctx->opcode, 7, 4)) {
     case NM_LBX:
         tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_SB);
         gen_store_gpr(t0, rd);
         break;
     case NM_LHX:
     /*case NM_LHXS:*/
         tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx,
                            MO_TESW | ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rd);
         break;
     case NM_LWX:
     /*case NM_LWXS:*/
         tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx,
                            MO_TESL | ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rd);
         break;
     case NM_LBUX:
         tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_UB);
         gen_store_gpr(t0, rd);
         break;
     case NM_LHUX:
     /*case NM_LHUXS:*/
         tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx,
                            MO_TEUW | ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rd);
         break;
     case NM_SBX:
         check_nms(ctx);
         gen_load_gpr(t1, rd);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_8);
         break;
     case NM_SHX:
     /*case NM_SHXS:*/
         check_nms(ctx);
         gen_load_gpr(t1, rd);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
                            MO_TEUW | ctx->default_tcg_memop_mask);
         break;
     case NM_SWX:
     /*case NM_SWXS:*/
         check_nms(ctx);
         gen_load_gpr(t1, rd);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
                            MO_TEUL | ctx->default_tcg_memop_mask);
         break;
     case NM_LWC1X:
     /*case NM_LWC1XS:*/
     case NM_LDC1X:
     /*case NM_LDC1XS:*/
     case NM_SWC1X:
     /*case NM_SWC1XS:*/
     case NM_SDC1X:
     /*case NM_SDC1XS:*/
         if (ctx->CP0_Config1 & (1 << CP0C1_FP)) {
             check_cp1_enabled(ctx);
             switch (extract32(ctx->opcode, 7, 4)) {
             case NM_LWC1X:
             /*case NM_LWC1XS:*/
                 gen_flt_ldst(ctx, OPC_LWC1, rd, t0);
                 break;
             case NM_LDC1X:
             /*case NM_LDC1XS:*/
                 gen_flt_ldst(ctx, OPC_LDC1, rd, t0);
                 break;
             case NM_SWC1X:
             /*case NM_SWC1XS:*/
                 gen_flt_ldst(ctx, OPC_SWC1, rd, t0);
                 break;
             case NM_SDC1X:
             /*case NM_SDC1XS:*/
                 gen_flt_ldst(ctx, OPC_SDC1, rd, t0);
                 break;
             }
         } else {
             generate_exception_err(ctx, EXCP_CpU, 1);
         }
         break;
     default:
         gen_reserved_instruction(ctx);
         break;
     }
 }
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index 98935b5e64..b53f4fa694 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -233,28 +233,28 @@ target_ulong helper_rdhwr_xnp(CPUMIPSState *env)
 void helper_pmon(CPUMIPSState *env, int function)
 {
     function /= 2;
     switch (function) {
     case 2: /* TODO: char inbyte(int waitflag); */
         if (env->active_tc.gpr[4] == 0) {
             env->active_tc.gpr[2] = -1;
         }
-        /* Fall through */
+        fallthrough;
     case 11: /* TODO: char inbyte (void); */
         env->active_tc.gpr[2] = -1;
         break;
     case 3:
     case 12:
         printf("%c", (char)(env->active_tc.gpr[4] & 0xFF));
         break;
     case 17:
         break;
     case 158:
         {
             unsigned char *fmt = (void *)(uintptr_t)env->active_tc.gpr[4];
             printf("%s", fmt);
         }
         break;
     }
 }
 
 #ifdef TARGET_MIPS64
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 13e43fa3b6..c6cbc05400 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -2054,191 +2054,191 @@ static void gen_lxr(DisasContext *ctx, TCGv reg, TCGv addr,
 /* Load */
 static void gen_ld(DisasContext *ctx, uint32_t opc,
                    int rt, int base, int offset)
 {
     TCGv t0, t1;
     int mem_idx = ctx->mem_idx;
 
     if (rt == 0 && ctx->insn_flags & (INSN_LOONGSON2E | INSN_LOONGSON2F |
                                       INSN_LOONGSON3A)) {
         /*
          * Loongson CPU uses a load to zero register for prefetch.
          * We emulate it as a NOP. On other CPU we must perform the
          * actual memory access.
          */
         return;
     }
 
     t0 = tcg_temp_new();
     gen_base_offset_addr(ctx, t0, base, offset);
 
     switch (opc) {
 #if defined(TARGET_MIPS64)
     case OPC_LWU:
         tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TEUL |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rt);
         break;
     case OPC_LD:
         tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TEUQ |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rt);
         break;
     case OPC_LLD:
     case R6_OPC_LLD:
         op_ld_lld(t0, t0, mem_idx, ctx);
         gen_store_gpr(t0, rt);
         break;
     case OPC_LDL:
         t1 = tcg_temp_new();
         gen_load_gpr(t1, rt);
         gen_lxl(ctx, t1, t0, mem_idx, MO_TEUQ);
         gen_store_gpr(t1, rt);
         break;
     case OPC_LDR:
         t1 = tcg_temp_new();
         gen_load_gpr(t1, rt);
         gen_lxr(ctx, t1, t0, mem_idx, MO_TEUQ);
         gen_store_gpr(t1, rt);
         break;
     case OPC_LDPC:
         t1 = tcg_constant_tl(pc_relative_pc(ctx));
         gen_op_addr_add(ctx, t0, t0, t1);
         tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TEUQ);
         gen_store_gpr(t0, rt);
         break;
 #endif
     case OPC_LWPC:
         t1 = tcg_constant_tl(pc_relative_pc(ctx));
         gen_op_addr_add(ctx, t0, t0, t1);
         tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TESL);
         gen_store_gpr(t0, rt);
         break;
     case OPC_LWE:
         mem_idx = MIPS_HFLAG_UM;
-        /* fall through */
+        fallthrough;
     case OPC_LW:
         tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TESL |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rt);
         break;
     case OPC_LHE:
         mem_idx = MIPS_HFLAG_UM;
-        /* fall through */
+        fallthrough;
     case OPC_LH:
         tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TESW |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rt);
         break;
     case OPC_LHUE:
         mem_idx = MIPS_HFLAG_UM;
-        /* fall through */
+        fallthrough;
     case OPC_LHU:
         tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TEUW |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rt);
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
         gen_lxl(ctx, t1, t0, mem_idx, MO_TEUL);
         tcg_gen_ext32s_tl(t1, t1);
         gen_store_gpr(t1, rt);
         break;
     case OPC_LWRE:
         mem_idx = MIPS_HFLAG_UM;
-        /* fall through */
+        fallthrough;
     case OPC_LWR:
         t1 = tcg_temp_new();
         gen_load_gpr(t1, rt);
         gen_lxr(ctx, t1, t0, mem_idx, MO_TEUL);
         tcg_gen_ext32s_tl(t1, t1);
         gen_store_gpr(t1, rt);
         break;
     case OPC_LLE:
         mem_idx = MIPS_HFLAG_UM;
-        /* fall through */
+        fallthrough;
     case OPC_LL:
     case R6_OPC_LL:
         op_ld_ll(t0, t0, mem_idx, ctx);
         gen_store_gpr(t0, rt);
         break;
     }
 }
 
 /* Store */
 static void gen_st(DisasContext *ctx, uint32_t opc, int rt,
                    int base, int offset)
 {
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
     int mem_idx = ctx->mem_idx;
 
     gen_base_offset_addr(ctx, t0, base, offset);
     gen_load_gpr(t1, rt);
     switch (opc) {
 #if defined(TARGET_MIPS64)
     case OPC_SD:
         tcg_gen_qemu_st_tl(t1, t0, mem_idx, MO_TEUQ |
                            ctx->default_tcg_memop_mask);
         break;
     case OPC_SDL:
         gen_helper_0e2i(sdl, t1, t0, mem_idx);
         break;
     case OPC_SDR:
         gen_helper_0e2i(sdr, t1, t0, mem_idx);
         break;
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
     }
 }
 
 
 /* Store conditional */
@@ -2321,22 +2321,22 @@ static void gen_flt_ldst(DisasContext *ctx, uint32_t opc, int ft,
 static void gen_cop1_ldst(DisasContext *ctx, uint32_t op, int rt,
                           int rs, int16_t imm)
 {
     TCGv t0 = tcg_temp_new();
 
     if (ctx->CP0_Config1 & (1 << CP0C1_FP)) {
         check_cp1_enabled(ctx);
         switch (op) {
         case OPC_LDC1:
         case OPC_SDC1:
             check_insn(ctx, ISA_MIPS2);
-            /* Fallthrough */
+            fallthrough;
         default:
             gen_base_offset_addr(ctx, t0, rs, imm);
             gen_flt_ldst(ctx, op, rt, t0);
         }
     } else {
         generate_exception_err(ctx, EXCP_CpU, 1);
     }
 }
 
 /* Arithmetic with immediate operand */
@@ -3441,119 +3441,119 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
 /*
  * These MULT[U] and MADD[U] instructions implemented in for example
  * the Toshiba/Sony R5900 and the Toshiba TX19, TX39 and TX79 core
  * architectures are special three-operand variants with the syntax
  *
  *     MULT[U][1] rd, rs, rt
  *
  * such that
  *
  *     (rd, LO, HI) <- rs * rt
  *
  * and
  *
  *     MADD[U][1] rd, rs, rt
  *
  * such that
  *
  *     (rd, LO, HI) <- (LO, HI) + rs * rt
  *
  * where the low-order 32-bits of the result is placed into both the
  * GPR rd and the special register LO. The high-order 32-bits of the
  * result is placed into the special register HI.
  *
  * If the GPR rd is omitted in assembly language, it is taken to be 0,
  * which is the zero register that always reads as 0.
  */
 static void gen_mul_txx9(DisasContext *ctx, uint32_t opc,
                          int rd, int rs, int rt)
 {
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
     int acc = 0;
 
     gen_load_gpr(t0, rs);
     gen_load_gpr(t1, rt);
 
     switch (opc) {
     case MMI_OPC_MULT1:
         acc = 1;
-        /* Fall through */
+        fallthrough;
     case OPC_MULT:
         {
             TCGv_i32 t2 = tcg_temp_new_i32();
             TCGv_i32 t3 = tcg_temp_new_i32();
             tcg_gen_trunc_tl_i32(t2, t0);
             tcg_gen_trunc_tl_i32(t3, t1);
             tcg_gen_muls2_i32(t2, t3, t2, t3);
             if (rd) {
                 tcg_gen_ext_i32_tl(cpu_gpr[rd], t2);
             }
             tcg_gen_ext_i32_tl(cpu_LO[acc], t2);
             tcg_gen_ext_i32_tl(cpu_HI[acc], t3);
         }
         break;
     case MMI_OPC_MULTU1:
         acc = 1;
-        /* Fall through */
+        fallthrough;
     case OPC_MULTU:
         {
             TCGv_i32 t2 = tcg_temp_new_i32();
             TCGv_i32 t3 = tcg_temp_new_i32();
             tcg_gen_trunc_tl_i32(t2, t0);
             tcg_gen_trunc_tl_i32(t3, t1);
             tcg_gen_mulu2_i32(t2, t3, t2, t3);
             if (rd) {
                 tcg_gen_ext_i32_tl(cpu_gpr[rd], t2);
             }
             tcg_gen_ext_i32_tl(cpu_LO[acc], t2);
             tcg_gen_ext_i32_tl(cpu_HI[acc], t3);
         }
         break;
     case MMI_OPC_MADD1:
         acc = 1;
-        /* Fall through */
+        fallthrough;
     case MMI_OPC_MADD:
         {
             TCGv_i64 t2 = tcg_temp_new_i64();
             TCGv_i64 t3 = tcg_temp_new_i64();
 
             tcg_gen_ext_tl_i64(t2, t0);
             tcg_gen_ext_tl_i64(t3, t1);
             tcg_gen_mul_i64(t2, t2, t3);
             tcg_gen_concat_tl_i64(t3, cpu_LO[acc], cpu_HI[acc]);
             tcg_gen_add_i64(t2, t2, t3);
             gen_move_low32(cpu_LO[acc], t2);
             gen_move_high32(cpu_HI[acc], t2);
             if (rd) {
                 gen_move_low32(cpu_gpr[rd], t2);
             }
         }
         break;
     case MMI_OPC_MADDU1:
         acc = 1;
-        /* Fall through */
+        fallthrough;
     case MMI_OPC_MADDU:
         {
             TCGv_i64 t2 = tcg_temp_new_i64();
             TCGv_i64 t3 = tcg_temp_new_i64();
 
             tcg_gen_ext32u_tl(t0, t0);
             tcg_gen_ext32u_tl(t1, t1);
             tcg_gen_extu_tl_i64(t2, t0);
             tcg_gen_extu_tl_i64(t3, t1);
             tcg_gen_mul_i64(t2, t2, t3);
             tcg_gen_concat_tl_i64(t3, cpu_LO[acc], cpu_HI[acc]);
             tcg_gen_add_i64(t2, t2, t3);
             gen_move_low32(cpu_LO[acc], t2);
             gen_move_high32(cpu_HI[acc], t2);
             if (rd) {
                 gen_move_low32(cpu_gpr[rd], t2);
             }
         }
         break;
     default:
         MIPS_INVAL("mul/madd TXx9");
         gen_reserved_instruction(ctx);
         break;
     }
 }
@@ -3782,363 +3782,364 @@ static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
 /* Loongson multimedia instructions */
 static void gen_loongson_multimedia(DisasContext *ctx, int rd, int rs, int rt)
 {
     uint32_t opc, shift_max;
     TCGv_i64 t0, t1;
     TCGCond cond;
 
     opc = MASK_LMMI(ctx->opcode);
     check_cp1_enabled(ctx);
 
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
     gen_load_fpr64(ctx, t0, rs);
     gen_load_fpr64(ctx, t1, rt);
 
     switch (opc) {
     case OPC_PADDSH:
         gen_helper_paddsh(t0, t0, t1);
         break;
     case OPC_PADDUSH:
         gen_helper_paddush(t0, t0, t1);
         break;
     case OPC_PADDH:
         gen_helper_paddh(t0, t0, t1);
         break;
     case OPC_PADDW:
         gen_helper_paddw(t0, t0, t1);
         break;
     case OPC_PADDSB:
         gen_helper_paddsb(t0, t0, t1);
         break;
     case OPC_PADDUSB:
         gen_helper_paddusb(t0, t0, t1);
         break;
     case OPC_PADDB:
         gen_helper_paddb(t0, t0, t1);
         break;
 
     case OPC_PSUBSH:
         gen_helper_psubsh(t0, t0, t1);
         break;
     case OPC_PSUBUSH:
         gen_helper_psubush(t0, t0, t1);
         break;
     case OPC_PSUBH:
         gen_helper_psubh(t0, t0, t1);
         break;
     case OPC_PSUBW:
         gen_helper_psubw(t0, t0, t1);
         break;
     case OPC_PSUBSB:
         gen_helper_psubsb(t0, t0, t1);
         break;
     case OPC_PSUBUSB:
         gen_helper_psubusb(t0, t0, t1);
         break;
     case OPC_PSUBB:
         gen_helper_psubb(t0, t0, t1);
         break;
 
     case OPC_PSHUFH:
         gen_helper_pshufh(t0, t0, t1);
         break;
     case OPC_PACKSSWH:
         gen_helper_packsswh(t0, t0, t1);
         break;
     case OPC_PACKSSHB:
         gen_helper_packsshb(t0, t0, t1);
         break;
     case OPC_PACKUSHB:
         gen_helper_packushb(t0, t0, t1);
         break;
 
     case OPC_PUNPCKLHW:
         gen_helper_punpcklhw(t0, t0, t1);
         break;
     case OPC_PUNPCKHHW:
         gen_helper_punpckhhw(t0, t0, t1);
         break;
     case OPC_PUNPCKLBH:
         gen_helper_punpcklbh(t0, t0, t1);
         break;
     case OPC_PUNPCKHBH:
         gen_helper_punpckhbh(t0, t0, t1);
         break;
     case OPC_PUNPCKLWD:
         gen_helper_punpcklwd(t0, t0, t1);
         break;
     case OPC_PUNPCKHWD:
         gen_helper_punpckhwd(t0, t0, t1);
         break;
 
     case OPC_PAVGH:
         gen_helper_pavgh(t0, t0, t1);
         break;
     case OPC_PAVGB:
         gen_helper_pavgb(t0, t0, t1);
         break;
     case OPC_PMAXSH:
         gen_helper_pmaxsh(t0, t0, t1);
         break;
     case OPC_PMINSH:
         gen_helper_pminsh(t0, t0, t1);
         break;
     case OPC_PMAXUB:
         gen_helper_pmaxub(t0, t0, t1);
         break;
     case OPC_PMINUB:
         gen_helper_pminub(t0, t0, t1);
         break;
 
     case OPC_PCMPEQW:
         gen_helper_pcmpeqw(t0, t0, t1);
         break;
     case OPC_PCMPGTW:
         gen_helper_pcmpgtw(t0, t0, t1);
         break;
     case OPC_PCMPEQH:
         gen_helper_pcmpeqh(t0, t0, t1);
         break;
     case OPC_PCMPGTH:
         gen_helper_pcmpgth(t0, t0, t1);
         break;
     case OPC_PCMPEQB:
         gen_helper_pcmpeqb(t0, t0, t1);
         break;
     case OPC_PCMPGTB:
         gen_helper_pcmpgtb(t0, t0, t1);
         break;
 
     case OPC_PSLLW:
         gen_helper_psllw(t0, t0, t1);
         break;
     case OPC_PSLLH:
         gen_helper_psllh(t0, t0, t1);
         break;
     case OPC_PSRLW:
         gen_helper_psrlw(t0, t0, t1);
         break;
     case OPC_PSRLH:
         gen_helper_psrlh(t0, t0, t1);
         break;
     case OPC_PSRAW:
         gen_helper_psraw(t0, t0, t1);
         break;
     case OPC_PSRAH:
         gen_helper_psrah(t0, t0, t1);
         break;
 
     case OPC_PMULLH:
         gen_helper_pmullh(t0, t0, t1);
         break;
     case OPC_PMULHH:
         gen_helper_pmulhh(t0, t0, t1);
         break;
     case OPC_PMULHUH:
         gen_helper_pmulhuh(t0, t0, t1);
         break;
     case OPC_PMADDHW:
         gen_helper_pmaddhw(t0, t0, t1);
         break;
 
     case OPC_PASUBUB:
         gen_helper_pasubub(t0, t0, t1);
         break;
     case OPC_BIADD:
         gen_helper_biadd(t0, t0);
         break;
     case OPC_PMOVMSKB:
         gen_helper_pmovmskb(t0, t0);
         break;
 
     case OPC_PADDD:
         tcg_gen_add_i64(t0, t0, t1);
         break;
     case OPC_PSUBD:
         tcg_gen_sub_i64(t0, t0, t1);
         break;
     case OPC_XOR_CP2:
         tcg_gen_xor_i64(t0, t0, t1);
         break;
     case OPC_NOR_CP2:
         tcg_gen_nor_i64(t0, t0, t1);
         break;
     case OPC_AND_CP2:
         tcg_gen_and_i64(t0, t0, t1);
         break;
     case OPC_OR_CP2:
         tcg_gen_or_i64(t0, t0, t1);
         break;
 
     case OPC_PANDN:
         tcg_gen_andc_i64(t0, t1, t0);
         break;
 
     case OPC_PINSRH_0:
         tcg_gen_deposit_i64(t0, t0, t1, 0, 16);
         break;
     case OPC_PINSRH_1:
         tcg_gen_deposit_i64(t0, t0, t1, 16, 16);
         break;
     case OPC_PINSRH_2:
         tcg_gen_deposit_i64(t0, t0, t1, 32, 16);
         break;
     case OPC_PINSRH_3:
         tcg_gen_deposit_i64(t0, t0, t1, 48, 16);
         break;
 
     case OPC_PEXTRH:
         tcg_gen_andi_i64(t1, t1, 3);
         tcg_gen_shli_i64(t1, t1, 4);
         tcg_gen_shr_i64(t0, t0, t1);
         tcg_gen_ext16u_i64(t0, t0);
         break;
 
     case OPC_ADDU_CP2:
         tcg_gen_add_i64(t0, t0, t1);
         tcg_gen_ext32s_i64(t0, t0);
         break;
     case OPC_SUBU_CP2:
         tcg_gen_sub_i64(t0, t0, t1);
         tcg_gen_ext32s_i64(t0, t0);
         break;
 
     case OPC_SLL_CP2:
         shift_max = 32;
         goto do_shift;
     case OPC_SRL_CP2:
         shift_max = 32;
         goto do_shift;
     case OPC_SRA_CP2:
         shift_max = 32;
         goto do_shift;
     case OPC_DSLL_CP2:
         shift_max = 64;
         goto do_shift;
     case OPC_DSRL_CP2:
         shift_max = 64;
         goto do_shift;
     case OPC_DSRA_CP2:
         shift_max = 64;
         goto do_shift;
     do_shift:
         /* Make sure shift count isn't TCG undefined behaviour.  */
         tcg_gen_andi_i64(t1, t1, shift_max - 1);
 
         switch (opc) {
         case OPC_SLL_CP2:
         case OPC_DSLL_CP2:
             tcg_gen_shl_i64(t0, t0, t1);
             break;
         case OPC_SRA_CP2:
         case OPC_DSRA_CP2:
             /*
              * Since SRA is UndefinedResult without sign-extended inputs,
              * we can treat SRA and DSRA the same.
              */
             tcg_gen_sar_i64(t0, t0, t1);
             break;
         case OPC_SRL_CP2:
             /* We want to shift in zeros for SRL; zero-extend first.  */
             tcg_gen_ext32u_i64(t0, t0);
             /* FALLTHRU */
+            fallthrough;
         case OPC_DSRL_CP2:
             tcg_gen_shr_i64(t0, t0, t1);
             break;
         }
 
         if (shift_max == 32) {
             tcg_gen_ext32s_i64(t0, t0);
         }
 
         /* Shifts larger than MAX produce zero.  */
         tcg_gen_setcondi_i64(TCG_COND_LTU, t1, t1, shift_max);
         tcg_gen_neg_i64(t1, t1);
         tcg_gen_and_i64(t0, t0, t1);
         break;
 
     case OPC_ADD_CP2:
     case OPC_DADD_CP2:
         {
             TCGv_i64 t2 = tcg_temp_new_i64();
             TCGLabel *lab = gen_new_label();
 
             tcg_gen_mov_i64(t2, t0);
             tcg_gen_add_i64(t0, t1, t2);
             if (opc == OPC_ADD_CP2) {
                 tcg_gen_ext32s_i64(t0, t0);
             }
             tcg_gen_xor_i64(t1, t1, t2);
             tcg_gen_xor_i64(t2, t2, t0);
             tcg_gen_andc_i64(t1, t2, t1);
             tcg_gen_brcondi_i64(TCG_COND_GE, t1, 0, lab);
             generate_exception(ctx, EXCP_OVERFLOW);
             gen_set_label(lab);
             break;
         }
 
     case OPC_SUB_CP2:
     case OPC_DSUB_CP2:
         {
             TCGv_i64 t2 = tcg_temp_new_i64();
             TCGLabel *lab = gen_new_label();
 
             tcg_gen_mov_i64(t2, t0);
             tcg_gen_sub_i64(t0, t1, t2);
             if (opc == OPC_SUB_CP2) {
                 tcg_gen_ext32s_i64(t0, t0);
             }
             tcg_gen_xor_i64(t1, t1, t2);
             tcg_gen_xor_i64(t2, t2, t0);
             tcg_gen_and_i64(t1, t1, t2);
             tcg_gen_brcondi_i64(TCG_COND_GE, t1, 0, lab);
             generate_exception(ctx, EXCP_OVERFLOW);
             gen_set_label(lab);
             break;
         }
 
     case OPC_PMULUW:
         tcg_gen_ext32u_i64(t0, t0);
         tcg_gen_ext32u_i64(t1, t1);
         tcg_gen_mul_i64(t0, t0, t1);
         break;
 
     case OPC_SEQU_CP2:
     case OPC_SEQ_CP2:
         cond = TCG_COND_EQ;
         goto do_cc_cond;
         break;
     case OPC_SLTU_CP2:
         cond = TCG_COND_LTU;
         goto do_cc_cond;
         break;
     case OPC_SLT_CP2:
         cond = TCG_COND_LT;
         goto do_cc_cond;
         break;
     case OPC_SLEU_CP2:
         cond = TCG_COND_LEU;
         goto do_cc_cond;
         break;
     case OPC_SLE_CP2:
         cond = TCG_COND_LE;
     do_cc_cond:
         {
             int cc = (ctx->opcode >> 8) & 0x7;
             TCGv_i64 t64 = tcg_temp_new_i64();
             TCGv_i32 t32 = tcg_temp_new_i32();
 
             tcg_gen_setcond_i64(cond, t64, t0, t1);
             tcg_gen_extrl_i64_i32(t32, t64);
             tcg_gen_deposit_i32(fpu_fcr31, fpu_fcr31, t32,
                                 get_fp_bit(cc), 1);
         }
         return;
     default:
         MIPS_INVAL("loongson_cp2");
         gen_reserved_instruction(ctx);
         return;
     }
 
     gen_store_fpr64(ctx, t0, rd);
 }
@@ -4574,324 +4575,326 @@ static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
 /* Branches (before delay slot) */
 static void gen_compute_branch(DisasContext *ctx, uint32_t opc,
                                int insn_bytes,
                                int rs, int rt, int32_t offset,
                                int delayslot_size)
 {
     target_ulong btgt = -1;
     int blink = 0;
     int bcond_compute = 0;
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
 
     if (ctx->hflags & MIPS_HFLAG_BMASK) {
 #ifdef MIPS_DEBUG_DISAS
         LOG_DISAS("Branch in delay / forbidden slot at PC 0x"
                   TARGET_FMT_lx "\n", ctx->base.pc_next);
 #endif
         gen_reserved_instruction(ctx);
         goto out;
     }
 
     /* Load needed operands */
     switch (opc) {
     case OPC_BEQ:
     case OPC_BEQL:
     case OPC_BNE:
     case OPC_BNEL:
         /* Compare two registers */
         if (rs != rt) {
             gen_load_gpr(t0, rs);
             gen_load_gpr(t1, rt);
             bcond_compute = 1;
         }
         btgt = ctx->base.pc_next + insn_bytes + offset;
         break;
     case OPC_BGEZ:
     case OPC_BGEZAL:
     case OPC_BGEZALL:
     case OPC_BGEZL:
     case OPC_BGTZ:
     case OPC_BGTZL:
     case OPC_BLEZ:
     case OPC_BLEZL:
     case OPC_BLTZ:
     case OPC_BLTZAL:
     case OPC_BLTZALL:
     case OPC_BLTZL:
         /* Compare to zero */
         if (rs != 0) {
             gen_load_gpr(t0, rs);
             bcond_compute = 1;
         }
         btgt = ctx->base.pc_next + insn_bytes + offset;
         break;
     case OPC_BPOSGE32:
 #if defined(TARGET_MIPS64)
     case OPC_BPOSGE64:
         tcg_gen_andi_tl(t0, cpu_dspctrl, 0x7F);
 #else
         tcg_gen_andi_tl(t0, cpu_dspctrl, 0x3F);
 #endif
         bcond_compute = 1;
         btgt = ctx->base.pc_next + insn_bytes + offset;
         break;
     case OPC_J:
     case OPC_JAL:
         {
             /* Jump to immediate */
             int jal_mask = ctx->hflags & MIPS_HFLAG_M16 ? 0xF8000000
                                                         : 0xF0000000;
             btgt = ((ctx->base.pc_next + insn_bytes) & jal_mask)
                    | (uint32_t)offset;
             break;
         }
     case OPC_JALX:
         /* Jump to immediate */
         btgt = ((ctx->base.pc_next + insn_bytes) & (int32_t)0xF0000000) |
             (uint32_t)offset;
         break;
     case OPC_JR:
     case OPC_JALR:
         /* Jump to register */
         if (offset != 0 && offset != 16) {
             /*
              * Hint = 0 is JR/JALR, hint 16 is JR.HB/JALR.HB, the
              * others are reserved.
              */
             MIPS_INVAL("jump hint");
             gen_reserved_instruction(ctx);
             goto out;
         }
         gen_load_gpr(btarget, rs);
         break;
     default:
         MIPS_INVAL("branch/jump");
         gen_reserved_instruction(ctx);
         goto out;
     }
     if (bcond_compute == 0) {
         /* No condition to be computed */
         switch (opc) {
         case OPC_BEQ:     /* rx == rx        */
         case OPC_BEQL:    /* rx == rx likely */
         case OPC_BGEZ:    /* 0 >= 0          */
         case OPC_BGEZL:   /* 0 >= 0 likely   */
         case OPC_BLEZ:    /* 0 <= 0          */
         case OPC_BLEZL:   /* 0 <= 0 likely   */
             /* Always take */
             ctx->hflags |= MIPS_HFLAG_B;
             break;
         case OPC_BGEZAL:  /* 0 >= 0          */
         case OPC_BGEZALL: /* 0 >= 0 likely   */
             /* Always take and link */
             blink = 31;
             ctx->hflags |= MIPS_HFLAG_B;
             break;
         case OPC_BNE:     /* rx != rx        */
         case OPC_BGTZ:    /* 0 > 0           */
         case OPC_BLTZ:    /* 0 < 0           */
             /* Treat as NOP. */
             goto out;
         case OPC_BLTZAL:  /* 0 < 0           */
             /*
              * Handle as an unconditional branch to get correct delay
              * slot checking.
              */
             blink = 31;
             btgt = ctx->base.pc_next + insn_bytes + delayslot_size;
             ctx->hflags |= MIPS_HFLAG_B;
             break;
         case OPC_BLTZALL: /* 0 < 0 likely */
             tcg_gen_movi_tl(cpu_gpr[31], ctx->base.pc_next + 8);
             /* Skip the instruction in the delay slot */
             ctx->base.pc_next += 4;
             goto out;
         case OPC_BNEL:    /* rx != rx likely */
         case OPC_BGTZL:   /* 0 > 0 likely */
         case OPC_BLTZL:   /* 0 < 0 likely */
             /* Skip the instruction in the delay slot */
             ctx->base.pc_next += 4;
             goto out;
         case OPC_J:
             ctx->hflags |= MIPS_HFLAG_B;
             break;
         case OPC_JALX:
             ctx->hflags |= MIPS_HFLAG_BX;
-            /* Fallthrough */
+            fallthrough;
         case OPC_JAL:
             blink = 31;
             ctx->hflags |= MIPS_HFLAG_B;
             break;
         case OPC_JR:
             ctx->hflags |= MIPS_HFLAG_BR;
             break;
         case OPC_JALR:
             blink = rt;
             ctx->hflags |= MIPS_HFLAG_BR;
             break;
         default:
             MIPS_INVAL("branch/jump");
             gen_reserved_instruction(ctx);
             goto out;
         }
     } else {
         switch (opc) {
         case OPC_BEQ:
             tcg_gen_setcond_tl(TCG_COND_EQ, bcond, t0, t1);
             goto not_likely;
         case OPC_BEQL:
             tcg_gen_setcond_tl(TCG_COND_EQ, bcond, t0, t1);
             goto likely;
         case OPC_BNE:
             tcg_gen_setcond_tl(TCG_COND_NE, bcond, t0, t1);
             goto not_likely;
         case OPC_BNEL:
             tcg_gen_setcond_tl(TCG_COND_NE, bcond, t0, t1);
             goto likely;
         case OPC_BGEZ:
             tcg_gen_setcondi_tl(TCG_COND_GE, bcond, t0, 0);
             goto not_likely;
         case OPC_BGEZL:
             tcg_gen_setcondi_tl(TCG_COND_GE, bcond, t0, 0);
             goto likely;
         case OPC_BGEZAL:
             tcg_gen_setcondi_tl(TCG_COND_GE, bcond, t0, 0);
             blink = 31;
             goto not_likely;
         case OPC_BGEZALL:
             tcg_gen_setcondi_tl(TCG_COND_GE, bcond, t0, 0);
             blink = 31;
             goto likely;
         case OPC_BGTZ:
             tcg_gen_setcondi_tl(TCG_COND_GT, bcond, t0, 0);
             goto not_likely;
         case OPC_BGTZL:
             tcg_gen_setcondi_tl(TCG_COND_GT, bcond, t0, 0);
             goto likely;
         case OPC_BLEZ:
             tcg_gen_setcondi_tl(TCG_COND_LE, bcond, t0, 0);
             goto not_likely;
         case OPC_BLEZL:
             tcg_gen_setcondi_tl(TCG_COND_LE, bcond, t0, 0);
             goto likely;
         case OPC_BLTZ:
             tcg_gen_setcondi_tl(TCG_COND_LT, bcond, t0, 0);
             goto not_likely;
         case OPC_BLTZL:
             tcg_gen_setcondi_tl(TCG_COND_LT, bcond, t0, 0);
             goto likely;
         case OPC_BPOSGE32:
             tcg_gen_setcondi_tl(TCG_COND_GE, bcond, t0, 32);
             goto not_likely;
 #if defined(TARGET_MIPS64)
         case OPC_BPOSGE64:
             tcg_gen_setcondi_tl(TCG_COND_GE, bcond, t0, 64);
             goto not_likely;
 #endif
         case OPC_BLTZAL:
             tcg_gen_setcondi_tl(TCG_COND_LT, bcond, t0, 0);
             blink = 31;
         not_likely:
             ctx->hflags |= MIPS_HFLAG_BC;
             break;
         case OPC_BLTZALL:
             tcg_gen_setcondi_tl(TCG_COND_LT, bcond, t0, 0);
             blink = 31;
         likely:
             ctx->hflags |= MIPS_HFLAG_BL;
             break;
         default:
             MIPS_INVAL("conditional branch/jump");
             gen_reserved_instruction(ctx);
             goto out;
         }
     }
 
     ctx->btarget = btgt;
 
     switch (delayslot_size) {
     case 2:
         ctx->hflags |= MIPS_HFLAG_BDS16;
         break;
     case 4:
         ctx->hflags |= MIPS_HFLAG_BDS32;
         break;
     }
 
     if (blink > 0) {
         int post_delay = insn_bytes + delayslot_size;
         int lowbit = !!(ctx->hflags & MIPS_HFLAG_M16);
 
         tcg_gen_movi_tl(cpu_gpr[blink],
                         ctx->base.pc_next + post_delay + lowbit);
     }
 
  out:
     if (insn_bytes == 2) {
         ctx->hflags |= MIPS_HFLAG_B16;
     }
 }
 
 
 /* special3 bitfield operations */
 static void gen_bitops(DisasContext *ctx, uint32_t opc, int rt,
                        int rs, int lsb, int msb)
 {
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
 
     gen_load_gpr(t1, rs);
     switch (opc) {
     case OPC_EXT:
         if (lsb + msb > 31) {
             goto fail;
         }
         if (msb != 31) {
             tcg_gen_extract_tl(t0, t1, lsb, msb + 1);
         } else {
             /*
              * The two checks together imply that lsb == 0,
              * so this is a simple sign-extension.
              */
             tcg_gen_ext32s_tl(t0, t1);
         }
         break;
 #if defined(TARGET_MIPS64)
     case OPC_DEXTU:
         lsb += 32;
         goto do_dext;
     case OPC_DEXTM:
         msb += 32;
         goto do_dext;
     case OPC_DEXT:
     do_dext:
         if (lsb + msb > 63) {
             goto fail;
         }
         tcg_gen_extract_tl(t0, t1, lsb, msb + 1);
         break;
 #endif
     case OPC_INS:
         if (lsb > msb) {
             goto fail;
         }
         gen_load_gpr(t0, rt);
         tcg_gen_deposit_tl(t0, t0, t1, lsb, msb - lsb + 1);
         tcg_gen_ext32s_tl(t0, t0);
         break;
 #if defined(TARGET_MIPS64)
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
         }
         gen_load_gpr(t0, rt);
         tcg_gen_deposit_tl(t0, t0, t1, lsb, msb - lsb + 1);
         break;
 #endif
     default:
@@ -8343,218 +8346,218 @@ cp0_unimplemented:
 static void gen_mftr(CPUMIPSState *env, DisasContext *ctx, int rt, int rd,
                      int u, int sel, int h)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     TCGv t0 = tcg_temp_new();
 
     if ((env->CP0_VPEConf0 & (1 << CP0VPEC0_MVP)) == 0 &&
         ((env->tcs[other_tc].CP0_TCBind & (0xf << CP0TCBd_CurVPE)) !=
          (env->active_tc.CP0_TCBind & (0xf << CP0TCBd_CurVPE)))) {
         tcg_gen_movi_tl(t0, -1);
     } else if ((env->CP0_VPEControl & (0xff << CP0VPECo_TargTC)) >
                (env->mvp->CP0_MVPConf0 & (0xff << CP0MVPC0_PTC))) {
         tcg_gen_movi_tl(t0, -1);
     } else if (u == 0) {
         switch (rt) {
         case 1:
             switch (sel) {
             case 1:
                 gen_helper_mftc0_vpecontrol(t0, tcg_env);
                 break;
             case 2:
                 gen_helper_mftc0_vpeconf0(t0, tcg_env);
                 break;
             default:
                 goto die;
                 break;
             }
             break;
         case 2:
             switch (sel) {
             case 1:
                 gen_helper_mftc0_tcstatus(t0, tcg_env);
                 break;
             case 2:
                 gen_helper_mftc0_tcbind(t0, tcg_env);
                 break;
             case 3:
                 gen_helper_mftc0_tcrestart(t0, tcg_env);
                 break;
             case 4:
                 gen_helper_mftc0_tchalt(t0, tcg_env);
                 break;
             case 5:
                 gen_helper_mftc0_tccontext(t0, tcg_env);
                 break;
             case 6:
                 gen_helper_mftc0_tcschedule(t0, tcg_env);
                 break;
             case 7:
                 gen_helper_mftc0_tcschefback(t0, tcg_env);
                 break;
             default:
                 gen_mfc0(ctx, t0, rt, sel);
                 break;
             }
             break;
         case 10:
             switch (sel) {
             case 0:
                 gen_helper_mftc0_entryhi(t0, tcg_env);
                 break;
             default:
                 gen_mfc0(ctx, t0, rt, sel);
                 break;
             }
             break;
         case 12:
             switch (sel) {
             case 0:
                 gen_helper_mftc0_status(t0, tcg_env);
                 break;
             default:
                 gen_mfc0(ctx, t0, rt, sel);
                 break;
             }
             break;
         case 13:
             switch (sel) {
             case 0:
                 gen_helper_mftc0_cause(t0, tcg_env);
                 break;
             default:
                 goto die;
                 break;
             }
             break;
         case 14:
             switch (sel) {
             case 0:
                 gen_helper_mftc0_epc(t0, tcg_env);
                 break;
             default:
                 goto die;
                 break;
             }
             break;
         case 15:
             switch (sel) {
             case 1:
                 gen_helper_mftc0_ebase(t0, tcg_env);
                 break;
             default:
                 goto die;
                 break;
             }
             break;
         case 16:
             switch (sel) {
             case 0:
             case 1:
             case 2:
             case 3:
             case 4:
             case 5:
             case 6:
             case 7:
                 gen_helper_mftc0_configx(t0, tcg_env, tcg_constant_tl(sel));
                 break;
             default:
                 goto die;
                 break;
             }
             break;
         case 23:
             switch (sel) {
             case 0:
                 gen_helper_mftc0_debug(t0, tcg_env);
                 break;
             default:
                 gen_mfc0(ctx, t0, rt, sel);
                 break;
             }
             break;
         default:
             gen_mfc0(ctx, t0, rt, sel);
         }
     } else {
         switch (sel) {
         /* GPR registers. */
         case 0:
             gen_helper_1e0i(mftgpr, t0, rt);
             break;
         /* Auxiliary CPU registers */
         case 1:
             switch (rt) {
             case 0:
                 gen_helper_1e0i(mftlo, t0, 0);
                 break;
             case 1:
                 gen_helper_1e0i(mfthi, t0, 0);
                 break;
             case 2:
                 gen_helper_1e0i(mftacx, t0, 0);
                 break;
             case 4:
                 gen_helper_1e0i(mftlo, t0, 1);
                 break;
             case 5:
                 gen_helper_1e0i(mfthi, t0, 1);
                 break;
             case 6:
                 gen_helper_1e0i(mftacx, t0, 1);
                 break;
             case 8:
                 gen_helper_1e0i(mftlo, t0, 2);
                 break;
             case 9:
                 gen_helper_1e0i(mfthi, t0, 2);
                 break;
             case 10:
                 gen_helper_1e0i(mftacx, t0, 2);
                 break;
             case 12:
                 gen_helper_1e0i(mftlo, t0, 3);
                 break;
             case 13:
                 gen_helper_1e0i(mfthi, t0, 3);
                 break;
             case 14:
                 gen_helper_1e0i(mftacx, t0, 3);
                 break;
             case 16:
                 gen_helper_mftdsp(t0, tcg_env);
                 break;
             default:
                 goto die;
             }
             break;
         /* Floating point (COP1). */
         case 2:
             /* XXX: For now we support only a single FPU context. */
             if (h == 0) {
                 TCGv_i32 fp0 = tcg_temp_new_i32();
 
                 gen_load_fpr32(ctx, fp0, rt);
                 tcg_gen_ext_i32_tl(t0, fp0);
             } else {
                 TCGv_i32 fp0 = tcg_temp_new_i32();
 
                 gen_load_fpr32h(ctx, fp0, rt);
                 tcg_gen_ext_i32_tl(t0, fp0);
             }
             break;
         case 3:
             /* XXX: For now we support only a single FPU context. */
             gen_helper_1e0i(cfc1, t0, rt);
             break;
         /* COP2: Not implemented. */
         case 4:
         case 5:
-            /* fall through */
+            fallthrough;
         default:
             goto die;
         }
     }
     trace_mips_translate_tr("mftr", rt, u, sel, h);
     gen_store_gpr(t0, rd);
     return;
@@ -8567,195 +8570,195 @@ die:
 static void gen_mttr(CPUMIPSState *env, DisasContext *ctx, int rd, int rt,
                      int u, int sel, int h)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     TCGv t0 = tcg_temp_new();
 
     gen_load_gpr(t0, rt);
     if ((env->CP0_VPEConf0 & (1 << CP0VPEC0_MVP)) == 0 &&
         ((env->tcs[other_tc].CP0_TCBind & (0xf << CP0TCBd_CurVPE)) !=
          (env->active_tc.CP0_TCBind & (0xf << CP0TCBd_CurVPE)))) {
         /* NOP */
         ;
     } else if ((env->CP0_VPEControl & (0xff << CP0VPECo_TargTC)) >
              (env->mvp->CP0_MVPConf0 & (0xff << CP0MVPC0_PTC))) {
         /* NOP */
         ;
     } else if (u == 0) {
         switch (rd) {
         case 1:
             switch (sel) {
             case 1:
                 gen_helper_mttc0_vpecontrol(tcg_env, t0);
                 break;
             case 2:
                 gen_helper_mttc0_vpeconf0(tcg_env, t0);
                 break;
             default:
                 goto die;
                 break;
             }
             break;
         case 2:
             switch (sel) {
             case 1:
                 gen_helper_mttc0_tcstatus(tcg_env, t0);
                 break;
             case 2:
                 gen_helper_mttc0_tcbind(tcg_env, t0);
                 break;
             case 3:
                 gen_helper_mttc0_tcrestart(tcg_env, t0);
                 break;
             case 4:
                 gen_helper_mttc0_tchalt(tcg_env, t0);
                 break;
             case 5:
                 gen_helper_mttc0_tccontext(tcg_env, t0);
                 break;
             case 6:
                 gen_helper_mttc0_tcschedule(tcg_env, t0);
                 break;
             case 7:
                 gen_helper_mttc0_tcschefback(tcg_env, t0);
                 break;
             default:
                 gen_mtc0(ctx, t0, rd, sel);
                 break;
             }
             break;
         case 10:
             switch (sel) {
             case 0:
                 gen_helper_mttc0_entryhi(tcg_env, t0);
                 break;
             default:
                 gen_mtc0(ctx, t0, rd, sel);
                 break;
             }
             break;
         case 12:
             switch (sel) {
             case 0:
                 gen_helper_mttc0_status(tcg_env, t0);
                 break;
             default:
                 gen_mtc0(ctx, t0, rd, sel);
                 break;
             }
             break;
         case 13:
             switch (sel) {
             case 0:
                 gen_helper_mttc0_cause(tcg_env, t0);
                 break;
             default:
                 goto die;
                 break;
             }
             break;
         case 15:
             switch (sel) {
             case 1:
                 gen_helper_mttc0_ebase(tcg_env, t0);
                 break;
             default:
                 goto die;
                 break;
             }
             break;
         case 23:
             switch (sel) {
             case 0:
                 gen_helper_mttc0_debug(tcg_env, t0);
                 break;
             default:
                 gen_mtc0(ctx, t0, rd, sel);
                 break;
             }
             break;
         default:
             gen_mtc0(ctx, t0, rd, sel);
         }
     } else {
         switch (sel) {
         /* GPR registers. */
         case 0:
             gen_helper_0e1i(mttgpr, t0, rd);
             break;
         /* Auxiliary CPU registers */
         case 1:
             switch (rd) {
             case 0:
                 gen_helper_0e1i(mttlo, t0, 0);
                 break;
             case 1:
                 gen_helper_0e1i(mtthi, t0, 0);
                 break;
             case 2:
                 gen_helper_0e1i(mttacx, t0, 0);
                 break;
             case 4:
                 gen_helper_0e1i(mttlo, t0, 1);
                 break;
             case 5:
                 gen_helper_0e1i(mtthi, t0, 1);
                 break;
             case 6:
                 gen_helper_0e1i(mttacx, t0, 1);
                 break;
             case 8:
                 gen_helper_0e1i(mttlo, t0, 2);
                 break;
             case 9:
                 gen_helper_0e1i(mtthi, t0, 2);
                 break;
             case 10:
                 gen_helper_0e1i(mttacx, t0, 2);
                 break;
             case 12:
                 gen_helper_0e1i(mttlo, t0, 3);
                 break;
             case 13:
                 gen_helper_0e1i(mtthi, t0, 3);
                 break;
             case 14:
                 gen_helper_0e1i(mttacx, t0, 3);
                 break;
             case 16:
                 gen_helper_mttdsp(tcg_env, t0);
                 break;
             default:
                 goto die;
             }
             break;
         /* Floating point (COP1). */
         case 2:
             /* XXX: For now we support only a single FPU context. */
             if (h == 0) {
                 TCGv_i32 fp0 = tcg_temp_new_i32();
 
                 tcg_gen_trunc_tl_i32(fp0, t0);
                 gen_store_fpr32(ctx, fp0, rd);
             } else {
                 TCGv_i32 fp0 = tcg_temp_new_i32();
 
                 tcg_gen_trunc_tl_i32(fp0, t0);
                 gen_store_fpr32h(ctx, fp0, rd);
             }
             break;
         case 3:
             /* XXX: For now we support only a single FPU context. */
             gen_helper_0e2i(ctc1, t0, tcg_constant_i32(rd), rt);
             /* Stop translation as we may have changed hflags */
             ctx->base.is_jmp = DISAS_STOP;
             break;
         /* COP2: Not implemented. */
         case 4:
         case 5:
-            /* fall through */
+            fallthrough;
         default:
             goto die;
         }
     }
     trace_mips_translate_tr("mttr", rd, u, sel, h);
     return;
@@ -11266,224 +11269,224 @@ static void gen_branch(DisasContext *ctx, int insn_bytes)
 /* Compact Branches */
 static void gen_compute_compact_branch(DisasContext *ctx, uint32_t opc,
                                        int rs, int rt, int32_t offset)
 {
     int bcond_compute = 0;
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
     int m16_lowbit = (ctx->hflags & MIPS_HFLAG_M16) != 0;
 
     if (ctx->hflags & MIPS_HFLAG_BMASK) {
 #ifdef MIPS_DEBUG_DISAS
         LOG_DISAS("Branch in delay / forbidden slot at PC 0x" TARGET_FMT_lx
                   "\n", ctx->base.pc_next);
 #endif
         gen_reserved_instruction(ctx);
         return;
     }
 
     /* Load needed operands and calculate btarget */
     switch (opc) {
     /* compact branch */
     case OPC_BOVC: /* OPC_BEQZALC, OPC_BEQC */
     case OPC_BNVC: /* OPC_BNEZALC, OPC_BNEC */
         gen_load_gpr(t0, rs);
         gen_load_gpr(t1, rt);
         bcond_compute = 1;
         ctx->btarget = addr_add(ctx, ctx->base.pc_next + 4, offset);
         if (rs <= rt && rs == 0) {
             /* OPC_BEQZALC, OPC_BNEZALC */
             tcg_gen_movi_tl(cpu_gpr[31], ctx->base.pc_next + 4 + m16_lowbit);
         }
         break;
     case OPC_BLEZC: /* OPC_BGEZC, OPC_BGEC */
     case OPC_BGTZC: /* OPC_BLTZC, OPC_BLTC */
         gen_load_gpr(t0, rs);
         gen_load_gpr(t1, rt);
         bcond_compute = 1;
         ctx->btarget = addr_add(ctx, ctx->base.pc_next + 4, offset);
         break;
     case OPC_BLEZALC: /* OPC_BGEZALC, OPC_BGEUC */
     case OPC_BGTZALC: /* OPC_BLTZALC, OPC_BLTUC */
         if (rs == 0 || rs == rt) {
             /* OPC_BLEZALC, OPC_BGEZALC */
             /* OPC_BGTZALC, OPC_BLTZALC */
             tcg_gen_movi_tl(cpu_gpr[31], ctx->base.pc_next + 4 + m16_lowbit);
         }
         gen_load_gpr(t0, rs);
         gen_load_gpr(t1, rt);
         bcond_compute = 1;
         ctx->btarget = addr_add(ctx, ctx->base.pc_next + 4, offset);
         break;
     case OPC_BC:
     case OPC_BALC:
         ctx->btarget = addr_add(ctx, ctx->base.pc_next + 4, offset);
         break;
     case OPC_BEQZC:
     case OPC_BNEZC:
         if (rs != 0) {
             /* OPC_BEQZC, OPC_BNEZC */
             gen_load_gpr(t0, rs);
             bcond_compute = 1;
             ctx->btarget = addr_add(ctx, ctx->base.pc_next + 4, offset);
         } else {
             /* OPC_JIC, OPC_JIALC */
             TCGv tbase = tcg_temp_new();
             TCGv toffset = tcg_constant_tl(offset);
 
             gen_load_gpr(tbase, rt);
             gen_op_addr_add(ctx, btarget, tbase, toffset);
         }
         break;
     default:
         MIPS_INVAL("Compact branch/jump");
         gen_reserved_instruction(ctx);
         return;
     }
 
     if (bcond_compute == 0) {
         /* Unconditional compact branch */
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
         default:
             MIPS_INVAL("Compact branch/jump");
             gen_reserved_instruction(ctx);
             return;
         }
 
         /* Generating branch here as compact branches don't have delay slot */
         gen_branch(ctx, 4);
     } else {
         /* Conditional compact branch */
         TCGLabel *fs = gen_new_label();
         save_cpu_state(ctx, 0);
 
         switch (opc) {
         case OPC_BLEZALC: /* OPC_BGEZALC, OPC_BGEUC */
             if (rs == 0 && rt != 0) {
                 /* OPC_BLEZALC */
                 tcg_gen_brcondi_tl(tcg_invert_cond(TCG_COND_LE), t1, 0, fs);
             } else if (rs != 0 && rt != 0 && rs == rt) {
                 /* OPC_BGEZALC */
                 tcg_gen_brcondi_tl(tcg_invert_cond(TCG_COND_GE), t1, 0, fs);
             } else {
                 /* OPC_BGEUC */
                 tcg_gen_brcond_tl(tcg_invert_cond(TCG_COND_GEU), t0, t1, fs);
             }
             break;
         case OPC_BGTZALC: /* OPC_BLTZALC, OPC_BLTUC */
             if (rs == 0 && rt != 0) {
                 /* OPC_BGTZALC */
                 tcg_gen_brcondi_tl(tcg_invert_cond(TCG_COND_GT), t1, 0, fs);
             } else if (rs != 0 && rt != 0 && rs == rt) {
                 /* OPC_BLTZALC */
                 tcg_gen_brcondi_tl(tcg_invert_cond(TCG_COND_LT), t1, 0, fs);
             } else {
                 /* OPC_BLTUC */
                 tcg_gen_brcond_tl(tcg_invert_cond(TCG_COND_LTU), t0, t1, fs);
             }
             break;
         case OPC_BLEZC: /* OPC_BGEZC, OPC_BGEC */
             if (rs == 0 && rt != 0) {
                 /* OPC_BLEZC */
                 tcg_gen_brcondi_tl(tcg_invert_cond(TCG_COND_LE), t1, 0, fs);
             } else if (rs != 0 && rt != 0 && rs == rt) {
                 /* OPC_BGEZC */
                 tcg_gen_brcondi_tl(tcg_invert_cond(TCG_COND_GE), t1, 0, fs);
             } else {
                 /* OPC_BGEC */
                 tcg_gen_brcond_tl(tcg_invert_cond(TCG_COND_GE), t0, t1, fs);
             }
             break;
         case OPC_BGTZC: /* OPC_BLTZC, OPC_BLTC */
             if (rs == 0 && rt != 0) {
                 /* OPC_BGTZC */
                 tcg_gen_brcondi_tl(tcg_invert_cond(TCG_COND_GT), t1, 0, fs);
             } else if (rs != 0 && rt != 0 && rs == rt) {
                 /* OPC_BLTZC */
                 tcg_gen_brcondi_tl(tcg_invert_cond(TCG_COND_LT), t1, 0, fs);
             } else {
                 /* OPC_BLTC */
                 tcg_gen_brcond_tl(tcg_invert_cond(TCG_COND_LT), t0, t1, fs);
             }
             break;
         case OPC_BOVC: /* OPC_BEQZALC, OPC_BEQC */
         case OPC_BNVC: /* OPC_BNEZALC, OPC_BNEC */
             if (rs >= rt) {
                 /* OPC_BOVC, OPC_BNVC */
                 TCGv t2 = tcg_temp_new();
                 TCGv t3 = tcg_temp_new();
                 TCGv t4 = tcg_temp_new();
                 TCGv input_overflow = tcg_temp_new();
 
                 gen_load_gpr(t0, rs);
                 gen_load_gpr(t1, rt);
                 tcg_gen_ext32s_tl(t2, t0);
                 tcg_gen_setcond_tl(TCG_COND_NE, input_overflow, t2, t0);
                 tcg_gen_ext32s_tl(t3, t1);
                 tcg_gen_setcond_tl(TCG_COND_NE, t4, t3, t1);
                 tcg_gen_or_tl(input_overflow, input_overflow, t4);
 
                 tcg_gen_add_tl(t4, t2, t3);
                 tcg_gen_ext32s_tl(t4, t4);
                 tcg_gen_xor_tl(t2, t2, t3);
                 tcg_gen_xor_tl(t3, t4, t3);
                 tcg_gen_andc_tl(t2, t3, t2);
                 tcg_gen_setcondi_tl(TCG_COND_LT, t4, t2, 0);
                 tcg_gen_or_tl(t4, t4, input_overflow);
                 if (opc == OPC_BOVC) {
                     /* OPC_BOVC */
                     tcg_gen_brcondi_tl(tcg_invert_cond(TCG_COND_NE), t4, 0, fs);
                 } else {
                     /* OPC_BNVC */
                     tcg_gen_brcondi_tl(tcg_invert_cond(TCG_COND_EQ), t4, 0, fs);
                 }
             } else if (rs < rt && rs == 0) {
                 /* OPC_BEQZALC, OPC_BNEZALC */
                 if (opc == OPC_BEQZALC) {
                     /* OPC_BEQZALC */
                     tcg_gen_brcondi_tl(tcg_invert_cond(TCG_COND_EQ), t1, 0, fs);
                 } else {
                     /* OPC_BNEZALC */
                     tcg_gen_brcondi_tl(tcg_invert_cond(TCG_COND_NE), t1, 0, fs);
                 }
             } else {
                 /* OPC_BEQC, OPC_BNEC */
                 if (opc == OPC_BEQC) {
                     /* OPC_BEQC */
                     tcg_gen_brcond_tl(tcg_invert_cond(TCG_COND_EQ), t0, t1, fs);
                 } else {
                     /* OPC_BNEC */
                     tcg_gen_brcond_tl(tcg_invert_cond(TCG_COND_NE), t0, t1, fs);
                 }
             }
             break;
         case OPC_BEQZC:
             tcg_gen_brcondi_tl(tcg_invert_cond(TCG_COND_EQ), t0, 0, fs);
             break;
         case OPC_BNEZC:
             tcg_gen_brcondi_tl(tcg_invert_cond(TCG_COND_NE), t0, 0, fs);
             break;
         default:
             MIPS_INVAL("Compact conditional branch/jump");
             gen_reserved_instruction(ctx);
             return;
         }
 
         /* Generating branch here as compact branches don't have delay slot */
         gen_goto_tb(ctx, 1, ctx->btarget);
         gen_set_label(fs);
 
         ctx->hflags |= MIPS_HFLAG_FBNSLOT;
     }
 }
@@ -13486,198 +13489,198 @@ static void decode_opc_special_legacy(CPUMIPSState *env, DisasContext *ctx)
 static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
 {
     int rs, rt, rd, sa;
     uint32_t op1;
 
     rs = (ctx->opcode >> 21) & 0x1f;
     rt = (ctx->opcode >> 16) & 0x1f;
     rd = (ctx->opcode >> 11) & 0x1f;
     sa = (ctx->opcode >> 6) & 0x1f;
 
     op1 = MASK_SPECIAL(ctx->opcode);
     switch (op1) {
     case OPC_SLL:          /* Shift with immediate */
         if (sa == 5 && rd == 0 &&
             rs == 0 && rt == 0) { /* PAUSE */
             if ((ctx->insn_flags & ISA_MIPS_R6) &&
                 (ctx->hflags & MIPS_HFLAG_BMASK)) {
                 gen_reserved_instruction(ctx);
                 break;
             }
         }
-        /* Fallthrough */
+        fallthrough;
     case OPC_SRA:
         gen_shift_imm(ctx, op1, rd, rt, sa);
         break;
     case OPC_SRL:
         switch ((ctx->opcode >> 21) & 0x1f) {
         case 1:
             /* rotr is decoded as srl on non-R2 CPUs */
             if (ctx->insn_flags & ISA_MIPS_R2) {
                 op1 = OPC_ROTR;
             }
-            /* Fallthrough */
+            fallthrough;
         case 0:
             gen_shift_imm(ctx, op1, rd, rt, sa);
             break;
         default:
             gen_reserved_instruction(ctx);
             break;
         }
         break;
     case OPC_ADD:
     case OPC_ADDU:
     case OPC_SUB:
     case OPC_SUBU:
         gen_arith(ctx, op1, rd, rs, rt);
         break;
     case OPC_SLLV:         /* Shifts */
     case OPC_SRAV:
         gen_shift(ctx, op1, rd, rs, rt);
         break;
     case OPC_SRLV:
         switch ((ctx->opcode >> 6) & 0x1f) {
         case 1:
             /* rotrv is decoded as srlv on non-R2 CPUs */
             if (ctx->insn_flags & ISA_MIPS_R2) {
                 op1 = OPC_ROTRV;
             }
-            /* Fallthrough */
+            fallthrough;
         case 0:
             gen_shift(ctx, op1, rd, rs, rt);
             break;
         default:
             gen_reserved_instruction(ctx);
             break;
         }
         break;
     case OPC_SLT:          /* Set on less than */
     case OPC_SLTU:
         gen_slt(ctx, op1, rd, rs, rt);
         break;
     case OPC_AND:          /* Logic*/
     case OPC_OR:
     case OPC_NOR:
     case OPC_XOR:
         gen_logic(ctx, op1, rd, rs, rt);
         break;
     case OPC_JALR:
         gen_compute_branch(ctx, op1, 4, rs, rd, sa, 4);
         break;
     case OPC_TGE: /* Traps */
     case OPC_TGEU:
     case OPC_TLT:
     case OPC_TLTU:
     case OPC_TEQ:
     case OPC_TNE:
         check_insn(ctx, ISA_MIPS2);
         gen_trap(ctx, op1, rs, rt, -1, extract32(ctx->opcode, 6, 10));
         break;
     case OPC_PMON:
         /* Pmon entry point, also R4010 selsl */
 #ifdef MIPS_STRICT_STANDARD
         MIPS_INVAL("PMON / selsl");
         gen_reserved_instruction(ctx);
 #else
         gen_helper_pmon(tcg_env, tcg_constant_i32(sa));
 #endif
         break;
     case OPC_SYSCALL:
         generate_exception_end(ctx, EXCP_SYSCALL);
         break;
     case OPC_BREAK:
         generate_exception_break(ctx, extract32(ctx->opcode, 6, 20));
         break;
     case OPC_SYNC:
         check_insn(ctx, ISA_MIPS2);
         gen_sync(extract32(ctx->opcode, 6, 5));
         break;
 
 #if defined(TARGET_MIPS64)
         /* MIPS64 specific opcodes */
     case OPC_DSLL:
     case OPC_DSRA:
     case OPC_DSLL32:
     case OPC_DSRA32:
         check_insn(ctx, ISA_MIPS3);
         check_mips_64(ctx);
         gen_shift_imm(ctx, op1, rd, rt, sa);
         break;
     case OPC_DSRL:
         switch ((ctx->opcode >> 21) & 0x1f) {
         case 1:
             /* drotr is decoded as dsrl on non-R2 CPUs */
             if (ctx->insn_flags & ISA_MIPS_R2) {
                 op1 = OPC_DROTR;
             }
-            /* Fallthrough */
+            fallthrough;
         case 0:
             check_insn(ctx, ISA_MIPS3);
             check_mips_64(ctx);
             gen_shift_imm(ctx, op1, rd, rt, sa);
             break;
         default:
             gen_reserved_instruction(ctx);
             break;
         }
         break;
     case OPC_DSRL32:
         switch ((ctx->opcode >> 21) & 0x1f) {
         case 1:
             /* drotr32 is decoded as dsrl32 on non-R2 CPUs */
             if (ctx->insn_flags & ISA_MIPS_R2) {
                 op1 = OPC_DROTR32;
             }
-            /* Fallthrough */
+            fallthrough;
         case 0:
             check_insn(ctx, ISA_MIPS3);
             check_mips_64(ctx);
             gen_shift_imm(ctx, op1, rd, rt, sa);
             break;
         default:
             gen_reserved_instruction(ctx);
             break;
         }
         break;
     case OPC_DADD:
     case OPC_DADDU:
     case OPC_DSUB:
     case OPC_DSUBU:
         check_insn(ctx, ISA_MIPS3);
         check_mips_64(ctx);
         gen_arith(ctx, op1, rd, rs, rt);
         break;
     case OPC_DSLLV:
     case OPC_DSRAV:
         check_insn(ctx, ISA_MIPS3);
         check_mips_64(ctx);
         gen_shift(ctx, op1, rd, rs, rt);
         break;
     case OPC_DSRLV:
         switch ((ctx->opcode >> 6) & 0x1f) {
         case 1:
             /* drotrv is decoded as dsrlv on non-R2 CPUs */
             if (ctx->insn_flags & ISA_MIPS_R2) {
                 op1 = OPC_DROTRV;
             }
-            /* Fallthrough */
+            fallthrough;
         case 0:
             check_insn(ctx, ISA_MIPS3);
             check_mips_64(ctx);
             gen_shift(ctx, op1, rd, rs, rt);
             break;
         default:
             gen_reserved_instruction(ctx);
             break;
         }
         break;
 #endif
     default:
         if (ctx->insn_flags & ISA_MIPS_R6) {
             decode_opc_special_r6(env, ctx);
         } else if (ctx->insn_flags & INSN_R5900) {
             decode_opc_special_tx79(env, ctx);
         } else {
             decode_opc_special_legacy(env, ctx);
         }
     }
 }
@@ -14621,700 +14624,700 @@ static void decode_opc_special3(CPUMIPSState *env, DisasContext *ctx)
 static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
 {
     int32_t offset;
     int rs, rt, rd, sa;
     uint32_t op, op1;
     int16_t imm;
 
     op = MASK_OP_MAJOR(ctx->opcode);
     rs = (ctx->opcode >> 21) & 0x1f;
     rt = (ctx->opcode >> 16) & 0x1f;
     rd = (ctx->opcode >> 11) & 0x1f;
     sa = (ctx->opcode >> 6) & 0x1f;
     imm = (int16_t)ctx->opcode;
     switch (op) {
     case OPC_SPECIAL:
         decode_opc_special(env, ctx);
         break;
     case OPC_SPECIAL2:
 #if defined(TARGET_MIPS64)
         if ((ctx->insn_flags & INSN_R5900) && (ctx->insn_flags & ASE_MMI)) {
             decode_mmi(env, ctx);
             break;
         }
 #endif
         if (TARGET_LONG_BITS == 32 && (ctx->insn_flags & ASE_MXU)) {
             if (decode_ase_mxu(ctx, ctx->opcode)) {
                 break;
             }
         }
         decode_opc_special2_legacy(env, ctx);
         break;
     case OPC_SPECIAL3:
 #if defined(TARGET_MIPS64)
         if (ctx->insn_flags & INSN_R5900) {
             decode_mmi_sq(env, ctx);    /* MMI_OPC_SQ */
         } else {
             decode_opc_special3(env, ctx);
         }
 #else
         decode_opc_special3(env, ctx);
 #endif
         break;
     case OPC_REGIMM:
         op1 = MASK_REGIMM(ctx->opcode);
         switch (op1) {
         case OPC_BLTZL: /* REGIMM branches */
         case OPC_BGEZL:
         case OPC_BLTZALL:
         case OPC_BGEZALL:
             check_insn(ctx, ISA_MIPS2);
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
-            /* Fallthrough */
+            fallthrough;
         case OPC_BLTZ:
         case OPC_BGEZ:
             gen_compute_branch(ctx, op1, 4, rs, -1, imm << 2, 4);
             break;
         case OPC_BLTZAL:
         case OPC_BGEZAL:
             if (ctx->insn_flags & ISA_MIPS_R6) {
                 if (rs == 0) {
                     /* OPC_NAL, OPC_BAL */
                     gen_compute_branch(ctx, op1, 4, 0, -1, imm << 2, 4);
                 } else {
                     gen_reserved_instruction(ctx);
                 }
             } else {
                 gen_compute_branch(ctx, op1, 4, rs, -1, imm << 2, 4);
             }
             break;
         case OPC_TGEI: /* REGIMM traps */
         case OPC_TGEIU:
         case OPC_TLTI:
         case OPC_TLTIU:
         case OPC_TEQI:
         case OPC_TNEI:
             check_insn(ctx, ISA_MIPS2);
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
             gen_trap(ctx, op1, rs, -1, imm, 0);
             break;
         case OPC_SIGRIE:
             check_insn(ctx, ISA_MIPS_R6);
             gen_reserved_instruction(ctx);
             break;
         case OPC_SYNCI:
             check_insn(ctx, ISA_MIPS_R2);
             /*
              * Break the TB to be able to sync copied instructions
              * immediately.
              */
             ctx->base.is_jmp = DISAS_STOP;
             break;
         case OPC_BPOSGE32:    /* MIPS DSP branch */
 #if defined(TARGET_MIPS64)
         case OPC_BPOSGE64:
 #endif
             check_dsp(ctx);
             gen_compute_branch(ctx, op1, 4, -1, -2, (int32_t)imm << 2, 4);
             break;
 #if defined(TARGET_MIPS64)
         case OPC_DAHI:
             check_insn(ctx, ISA_MIPS_R6);
             check_mips_64(ctx);
             if (rs != 0) {
                 tcg_gen_addi_tl(cpu_gpr[rs], cpu_gpr[rs], (int64_t)imm << 32);
             }
             break;
         case OPC_DATI:
             check_insn(ctx, ISA_MIPS_R6);
             check_mips_64(ctx);
             if (rs != 0) {
                 tcg_gen_addi_tl(cpu_gpr[rs], cpu_gpr[rs], (int64_t)imm << 48);
             }
             break;
 #endif
         default:            /* Invalid */
             MIPS_INVAL("regimm");
             gen_reserved_instruction(ctx);
             break;
         }
         break;
     case OPC_CP0:
         check_cp0_enabled(ctx);
         op1 = MASK_CP0(ctx->opcode);
         switch (op1) {
         case OPC_MFC0:
         case OPC_MTC0:
         case OPC_MFTR:
         case OPC_MTTR:
         case OPC_MFHC0:
         case OPC_MTHC0:
 #if defined(TARGET_MIPS64)
         case OPC_DMFC0:
         case OPC_DMTC0:
 #endif
 #ifndef CONFIG_USER_ONLY
             gen_cp0(env, ctx, op1, rt, rd);
 #endif /* !CONFIG_USER_ONLY */
             break;
         case OPC_C0:
         case OPC_C0_1:
         case OPC_C0_2:
         case OPC_C0_3:
         case OPC_C0_4:
         case OPC_C0_5:
         case OPC_C0_6:
         case OPC_C0_7:
         case OPC_C0_8:
         case OPC_C0_9:
         case OPC_C0_A:
         case OPC_C0_B:
         case OPC_C0_C:
         case OPC_C0_D:
         case OPC_C0_E:
         case OPC_C0_F:
 #ifndef CONFIG_USER_ONLY
             gen_cp0(env, ctx, MASK_C0(ctx->opcode), rt, rd);
 #endif /* !CONFIG_USER_ONLY */
             break;
         case OPC_MFMC0:
 #ifndef CONFIG_USER_ONLY
             {
                 uint32_t op2;
                 TCGv t0 = tcg_temp_new();
 
                 op2 = MASK_MFMC0(ctx->opcode);
                 switch (op2) {
                 case OPC_DMT:
                     check_cp0_mt(ctx);
                     gen_helper_dmt(t0);
                     gen_store_gpr(t0, rt);
                     break;
                 case OPC_EMT:
                     check_cp0_mt(ctx);
                     gen_helper_emt(t0);
                     gen_store_gpr(t0, rt);
                     break;
                 case OPC_DVPE:
                     check_cp0_mt(ctx);
                     gen_helper_dvpe(t0, tcg_env);
                     gen_store_gpr(t0, rt);
                     break;
                 case OPC_EVPE:
                     check_cp0_mt(ctx);
                     gen_helper_evpe(t0, tcg_env);
                     gen_store_gpr(t0, rt);
                     break;
                 case OPC_DVP:
                     check_insn(ctx, ISA_MIPS_R6);
                     if (ctx->vp) {
                         gen_helper_dvp(t0, tcg_env);
                         gen_store_gpr(t0, rt);
                     }
                     break;
                 case OPC_EVP:
                     check_insn(ctx, ISA_MIPS_R6);
                     if (ctx->vp) {
                         gen_helper_evp(t0, tcg_env);
                         gen_store_gpr(t0, rt);
                     }
                     break;
                 case OPC_DI:
                     check_insn(ctx, ISA_MIPS_R2);
                     save_cpu_state(ctx, 1);
                     gen_helper_di(t0, tcg_env);
                     gen_store_gpr(t0, rt);
                     /*
                      * Stop translation as we may have switched
                      * the execution mode.
                      */
                     ctx->base.is_jmp = DISAS_STOP;
                     break;
                 case OPC_EI:
                     check_insn(ctx, ISA_MIPS_R2);
                     save_cpu_state(ctx, 1);
                     gen_helper_ei(t0, tcg_env);
                     gen_store_gpr(t0, rt);
                     /*
                      * DISAS_STOP isn't sufficient, we need to ensure we break
                      * out of translated code to check for pending interrupts.
                      */
                     gen_save_pc(ctx->base.pc_next + 4);
                     ctx->base.is_jmp = DISAS_EXIT;
                     break;
                 default:            /* Invalid */
                     MIPS_INVAL("mfmc0");
                     gen_reserved_instruction(ctx);
                     break;
                 }
             }
 #endif /* !CONFIG_USER_ONLY */
             break;
         case OPC_RDPGPR:
             check_insn(ctx, ISA_MIPS_R2);
             gen_load_srsgpr(rt, rd);
             break;
         case OPC_WRPGPR:
             check_insn(ctx, ISA_MIPS_R2);
             gen_store_srsgpr(rt, rd);
             break;
         default:
             MIPS_INVAL("cp0");
             gen_reserved_instruction(ctx);
             break;
         }
         break;
     case OPC_BOVC: /* OPC_BEQZALC, OPC_BEQC, OPC_ADDI */
         if (ctx->insn_flags & ISA_MIPS_R6) {
             /* OPC_BOVC, OPC_BEQZALC, OPC_BEQC */
             gen_compute_compact_branch(ctx, op, rs, rt, imm << 2);
         } else {
             /* OPC_ADDI */
             /* Arithmetic with immediate opcode */
             gen_arith_imm(ctx, op, rt, rs, imm);
         }
         break;
     case OPC_ADDIU:
          gen_arith_imm(ctx, op, rt, rs, imm);
          break;
     case OPC_SLTI: /* Set on less than with immediate opcode */
     case OPC_SLTIU:
          gen_slt_imm(ctx, op, rt, rs, imm);
          break;
     case OPC_ANDI: /* Arithmetic with immediate opcode */
     case OPC_LUI: /* OPC_AUI */
     case OPC_ORI:
     case OPC_XORI:
          gen_logic_imm(ctx, op, rt, rs, imm);
          break;
     case OPC_J: /* Jump */
     case OPC_JAL:
          offset = (int32_t)(ctx->opcode & 0x3FFFFFF) << 2;
          gen_compute_branch(ctx, op, 4, rs, rt, offset, 4);
          break;
     /* Branch */
     case OPC_BLEZC: /* OPC_BGEZC, OPC_BGEC, OPC_BLEZL */
         if (ctx->insn_flags & ISA_MIPS_R6) {
             if (rt == 0) {
                 gen_reserved_instruction(ctx);
                 break;
             }
             /* OPC_BLEZC, OPC_BGEZC, OPC_BGEC */
             gen_compute_compact_branch(ctx, op, rs, rt, imm << 2);
         } else {
             /* OPC_BLEZL */
             gen_compute_branch(ctx, op, 4, rs, rt, imm << 2, 4);
         }
         break;
     case OPC_BGTZC: /* OPC_BLTZC, OPC_BLTC, OPC_BGTZL */
         if (ctx->insn_flags & ISA_MIPS_R6) {
             if (rt == 0) {
                 gen_reserved_instruction(ctx);
                 break;
             }
             /* OPC_BGTZC, OPC_BLTZC, OPC_BLTC */
             gen_compute_compact_branch(ctx, op, rs, rt, imm << 2);
         } else {
             /* OPC_BGTZL */
             gen_compute_branch(ctx, op, 4, rs, rt, imm << 2, 4);
         }
         break;
     case OPC_BLEZALC: /* OPC_BGEZALC, OPC_BGEUC, OPC_BLEZ */
         if (rt == 0) {
             /* OPC_BLEZ */
             gen_compute_branch(ctx, op, 4, rs, rt, imm << 2, 4);
         } else {
             check_insn(ctx, ISA_MIPS_R6);
             /* OPC_BLEZALC, OPC_BGEZALC, OPC_BGEUC */
             gen_compute_compact_branch(ctx, op, rs, rt, imm << 2);
         }
         break;
     case OPC_BGTZALC: /* OPC_BLTZALC, OPC_BLTUC, OPC_BGTZ */
         if (rt == 0) {
             /* OPC_BGTZ */
             gen_compute_branch(ctx, op, 4, rs, rt, imm << 2, 4);
         } else {
             check_insn(ctx, ISA_MIPS_R6);
             /* OPC_BGTZALC, OPC_BLTZALC, OPC_BLTUC */
             gen_compute_compact_branch(ctx, op, rs, rt, imm << 2);
         }
         break;
     case OPC_BEQL:
     case OPC_BNEL:
         check_insn(ctx, ISA_MIPS2);
          check_insn_opc_removed(ctx, ISA_MIPS_R6);
-        /* Fallthrough */
+        fallthrough;
     case OPC_BEQ:
     case OPC_BNE:
          gen_compute_branch(ctx, op, 4, rs, rt, imm << 2, 4);
          break;
     case OPC_LL: /* Load and stores */
         check_insn(ctx, ISA_MIPS2);
         if (ctx->insn_flags & INSN_R5900) {
             check_insn_opc_user_only(ctx, INSN_R5900);
         }
-        /* Fallthrough */
+        fallthrough;
     case OPC_LWL:
     case OPC_LWR:
     case OPC_LB:
     case OPC_LH:
     case OPC_LW:
     case OPC_LWPC:
     case OPC_LBU:
     case OPC_LHU:
          gen_ld(ctx, op, rt, rs, imm);
          break;
     case OPC_SWL:
     case OPC_SWR:
     case OPC_SB:
     case OPC_SH:
     case OPC_SW:
          gen_st(ctx, op, rt, rs, imm);
          break;
     case OPC_SC:
         check_insn(ctx, ISA_MIPS2);
         if (ctx->insn_flags & INSN_R5900) {
             check_insn_opc_user_only(ctx, INSN_R5900);
         }
         gen_st_cond(ctx, rt, rs, imm, MO_TESL, false);
         break;
     case OPC_CACHE:
         check_cp0_enabled(ctx);
         check_insn(ctx, ISA_MIPS3 | ISA_MIPS_R1);
         if (ctx->hflags & MIPS_HFLAG_ITC_CACHE) {
             gen_cache_operation(ctx, rt, rs, imm);
         }
         /* Treat as NOP. */
         break;
     case OPC_PREF:
         check_insn(ctx, ISA_MIPS4 | ISA_MIPS_R1 | INSN_R5900);
         /* Treat as NOP. */
         break;
 
     /* Floating point (COP1). */
     case OPC_LWC1:
     case OPC_LDC1:
     case OPC_SWC1:
     case OPC_SDC1:
         gen_cop1_ldst(ctx, op, rt, rs, imm);
         break;
 
     case OPC_CP1:
         op1 = MASK_CP1(ctx->opcode);
 
         switch (op1) {
         case OPC_MFHC1:
         case OPC_MTHC1:
             check_cp1_enabled(ctx);
             check_insn(ctx, ISA_MIPS_R2);
-            /* fall through */
+            fallthrough;
         case OPC_MFC1:
         case OPC_CFC1:
         case OPC_MTC1:
         case OPC_CTC1:
             check_cp1_enabled(ctx);
             gen_cp1(ctx, op1, rt, rd);
             break;
 #if defined(TARGET_MIPS64)
         case OPC_DMFC1:
         case OPC_DMTC1:
             check_cp1_enabled(ctx);
             check_insn(ctx, ISA_MIPS3);
             check_mips_64(ctx);
             gen_cp1(ctx, op1, rt, rd);
             break;
 #endif
         case OPC_BC1EQZ: /* OPC_BC1ANY2 */
             check_cp1_enabled(ctx);
             if (ctx->insn_flags & ISA_MIPS_R6) {
                 /* OPC_BC1EQZ */
                 gen_compute_branch1_r6(ctx, MASK_CP1(ctx->opcode),
                                        rt, imm << 2, 4);
             } else {
                 /* OPC_BC1ANY2 */
                 check_cop1x(ctx);
                 check_insn(ctx, ASE_MIPS3D);
                 gen_compute_branch1(ctx, MASK_BC1(ctx->opcode),
                                     (rt >> 2) & 0x7, imm << 2);
             }
             break;
         case OPC_BC1NEZ:
             check_cp1_enabled(ctx);
             check_insn(ctx, ISA_MIPS_R6);
             gen_compute_branch1_r6(ctx, MASK_CP1(ctx->opcode),
                                    rt, imm << 2, 4);
             break;
         case OPC_BC1ANY4:
             check_cp1_enabled(ctx);
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
             check_cop1x(ctx);
             check_insn(ctx, ASE_MIPS3D);
-            /* fall through */
+            fallthrough;
         case OPC_BC1:
             check_cp1_enabled(ctx);
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
             gen_compute_branch1(ctx, MASK_BC1(ctx->opcode),
                                 (rt >> 2) & 0x7, imm << 2);
             break;
         case OPC_PS_FMT:
             check_ps(ctx);
-            /* fall through */
+            fallthrough;
         case OPC_S_FMT:
         case OPC_D_FMT:
             check_cp1_enabled(ctx);
             gen_farith(ctx, ctx->opcode & FOP(0x3f, 0x1f), rt, rd, sa,
                        (imm >> 8) & 0x7);
             break;
         case OPC_W_FMT:
         case OPC_L_FMT:
         {
             int r6_op = ctx->opcode & FOP(0x3f, 0x1f);
             check_cp1_enabled(ctx);
             if (ctx->insn_flags & ISA_MIPS_R6) {
                 switch (r6_op) {
                 case R6_OPC_CMP_AF_S:
                 case R6_OPC_CMP_UN_S:
                 case R6_OPC_CMP_EQ_S:
                 case R6_OPC_CMP_UEQ_S:
                 case R6_OPC_CMP_LT_S:
                 case R6_OPC_CMP_ULT_S:
                 case R6_OPC_CMP_LE_S:
                 case R6_OPC_CMP_ULE_S:
                 case R6_OPC_CMP_SAF_S:
                 case R6_OPC_CMP_SUN_S:
                 case R6_OPC_CMP_SEQ_S:
                 case R6_OPC_CMP_SEUQ_S:
                 case R6_OPC_CMP_SLT_S:
                 case R6_OPC_CMP_SULT_S:
                 case R6_OPC_CMP_SLE_S:
                 case R6_OPC_CMP_SULE_S:
                 case R6_OPC_CMP_OR_S:
                 case R6_OPC_CMP_UNE_S:
                 case R6_OPC_CMP_NE_S:
                 case R6_OPC_CMP_SOR_S:
                 case R6_OPC_CMP_SUNE_S:
                 case R6_OPC_CMP_SNE_S:
                     gen_r6_cmp_s(ctx, ctx->opcode & 0x1f, rt, rd, sa);
                     break;
                 case R6_OPC_CMP_AF_D:
                 case R6_OPC_CMP_UN_D:
                 case R6_OPC_CMP_EQ_D:
                 case R6_OPC_CMP_UEQ_D:
                 case R6_OPC_CMP_LT_D:
                 case R6_OPC_CMP_ULT_D:
                 case R6_OPC_CMP_LE_D:
                 case R6_OPC_CMP_ULE_D:
                 case R6_OPC_CMP_SAF_D:
                 case R6_OPC_CMP_SUN_D:
                 case R6_OPC_CMP_SEQ_D:
                 case R6_OPC_CMP_SEUQ_D:
                 case R6_OPC_CMP_SLT_D:
                 case R6_OPC_CMP_SULT_D:
                 case R6_OPC_CMP_SLE_D:
                 case R6_OPC_CMP_SULE_D:
                 case R6_OPC_CMP_OR_D:
                 case R6_OPC_CMP_UNE_D:
                 case R6_OPC_CMP_NE_D:
                 case R6_OPC_CMP_SOR_D:
                 case R6_OPC_CMP_SUNE_D:
                 case R6_OPC_CMP_SNE_D:
                     gen_r6_cmp_d(ctx, ctx->opcode & 0x1f, rt, rd, sa);
                     break;
                 default:
                     gen_farith(ctx, ctx->opcode & FOP(0x3f, 0x1f),
                                rt, rd, sa, (imm >> 8) & 0x7);
 
                     break;
                 }
             } else {
                 gen_farith(ctx, ctx->opcode & FOP(0x3f, 0x1f), rt, rd, sa,
                            (imm >> 8) & 0x7);
             }
             break;
         }
         default:
             MIPS_INVAL("cp1");
             gen_reserved_instruction(ctx);
             break;
         }
         break;
 
     /* Compact branches [R6] and COP2 [non-R6] */
     case OPC_BC: /* OPC_LWC2 */
     case OPC_BALC: /* OPC_SWC2 */
         if (ctx->insn_flags & ISA_MIPS_R6) {
             /* OPC_BC, OPC_BALC */
             gen_compute_compact_branch(ctx, op, 0, 0,
                                        sextract32(ctx->opcode << 2, 0, 28));
         } else if (ctx->insn_flags & ASE_LEXT) {
             gen_loongson_lswc2(ctx, rt, rs, rd);
         } else {
             /* OPC_LWC2, OPC_SWC2 */
             /* COP2: Not implemented. */
             generate_exception_err(ctx, EXCP_CpU, 2);
         }
         break;
     case OPC_BEQZC: /* OPC_JIC, OPC_LDC2 */
     case OPC_BNEZC: /* OPC_JIALC, OPC_SDC2 */
         if (ctx->insn_flags & ISA_MIPS_R6) {
             if (rs != 0) {
                 /* OPC_BEQZC, OPC_BNEZC */
                 gen_compute_compact_branch(ctx, op, rs, 0,
                                            sextract32(ctx->opcode << 2, 0, 23));
             } else {
                 /* OPC_JIC, OPC_JIALC */
                 gen_compute_compact_branch(ctx, op, 0, rt, imm);
             }
         } else if (ctx->insn_flags & ASE_LEXT) {
             gen_loongson_lsdc2(ctx, rt, rs, rd);
         } else {
             /* OPC_LWC2, OPC_SWC2 */
             /* COP2: Not implemented. */
             generate_exception_err(ctx, EXCP_CpU, 2);
         }
         break;
     case OPC_CP2:
         check_insn(ctx, ASE_LMMI);
         /* Note that these instructions use different fields.  */
         gen_loongson_multimedia(ctx, sa, rd, rt);
         break;
 
     case OPC_CP3:
         if (ctx->CP0_Config1 & (1 << CP0C1_FP)) {
             check_cp1_enabled(ctx);
             op1 = MASK_CP3(ctx->opcode);
             switch (op1) {
             case OPC_LUXC1:
             case OPC_SUXC1:
                 check_insn(ctx, ISA_MIPS5 | ISA_MIPS_R2);
-                /* Fallthrough */
+                fallthrough;
             case OPC_LWXC1:
             case OPC_LDXC1:
             case OPC_SWXC1:
             case OPC_SDXC1:
                 check_insn(ctx, ISA_MIPS4 | ISA_MIPS_R2);
                 gen_flt3_ldst(ctx, op1, sa, rd, rs, rt);
                 break;
             case OPC_PREFX:
                 check_insn(ctx, ISA_MIPS4 | ISA_MIPS_R2);
                 /* Treat as NOP. */
                 break;
             case OPC_ALNV_PS:
                 check_insn(ctx, ISA_MIPS5 | ISA_MIPS_R2);
-                /* Fallthrough */
+                fallthrough;
             case OPC_MADD_S:
             case OPC_MADD_D:
             case OPC_MADD_PS:
             case OPC_MSUB_S:
             case OPC_MSUB_D:
             case OPC_MSUB_PS:
             case OPC_NMADD_S:
             case OPC_NMADD_D:
             case OPC_NMADD_PS:
             case OPC_NMSUB_S:
             case OPC_NMSUB_D:
             case OPC_NMSUB_PS:
                 check_insn(ctx, ISA_MIPS4 | ISA_MIPS_R2);
                 gen_flt3_arith(ctx, op1, sa, rs, rd, rt);
                 break;
             default:
                 MIPS_INVAL("cp3");
                 gen_reserved_instruction(ctx);
                 break;
             }
         } else {
             generate_exception_err(ctx, EXCP_CpU, 1);
         }
         break;
 
 #if defined(TARGET_MIPS64)
     /* MIPS64 opcodes */
     case OPC_LLD:
         if (ctx->insn_flags & INSN_R5900) {
             check_insn_opc_user_only(ctx, INSN_R5900);
         }
-        /* fall through */
+        fallthrough;
     case OPC_LDL:
     case OPC_LDR:
     case OPC_LWU:
     case OPC_LD:
         check_insn(ctx, ISA_MIPS3);
         check_mips_64(ctx);
         gen_ld(ctx, op, rt, rs, imm);
         break;
     case OPC_SDL:
     case OPC_SDR:
     case OPC_SD:
         check_insn(ctx, ISA_MIPS3);
         check_mips_64(ctx);
         gen_st(ctx, op, rt, rs, imm);
         break;
     case OPC_SCD:
         check_insn(ctx, ISA_MIPS3);
         if (ctx->insn_flags & INSN_R5900) {
             check_insn_opc_user_only(ctx, INSN_R5900);
         }
         check_mips_64(ctx);
         gen_st_cond(ctx, rt, rs, imm, MO_TEUQ, false);
         break;
     case OPC_BNVC: /* OPC_BNEZALC, OPC_BNEC, OPC_DADDI */
         if (ctx->insn_flags & ISA_MIPS_R6) {
             /* OPC_BNVC, OPC_BNEZALC, OPC_BNEC */
             gen_compute_compact_branch(ctx, op, rs, rt, imm << 2);
         } else {
             /* OPC_DADDI */
             check_insn(ctx, ISA_MIPS3);
             check_mips_64(ctx);
             gen_arith_imm(ctx, op, rt, rs, imm);
         }
         break;
     case OPC_DADDIU:
         check_insn(ctx, ISA_MIPS3);
         check_mips_64(ctx);
         gen_arith_imm(ctx, op, rt, rs, imm);
         break;
 #else
     case OPC_BNVC: /* OPC_BNEZALC, OPC_BNEC */
         if (ctx->insn_flags & ISA_MIPS_R6) {
             gen_compute_compact_branch(ctx, op, rs, rt, imm << 2);
         } else {
             MIPS_INVAL("major opcode");
             gen_reserved_instruction(ctx);
         }
         break;
 #endif
     case OPC_DAUI: /* OPC_JALX */
         if (ctx->insn_flags & ISA_MIPS_R6) {
 #if defined(TARGET_MIPS64)
             /* OPC_DAUI */
             check_mips_64(ctx);
             if (rs == 0) {
                 generate_exception(ctx, EXCP_RI);
             } else if (rt != 0) {
                 TCGv t0 = tcg_temp_new();
                 gen_load_gpr(t0, rs);
                 tcg_gen_addi_tl(cpu_gpr[rt], t0, imm << 16);
             }
 #else
             gen_reserved_instruction(ctx);
             MIPS_INVAL("major opcode");
 #endif
         } else {
             /* OPC_JALX */
             check_insn(ctx, ASE_MIPS16 | ASE_MICROMIPS);
             offset = (int32_t)(ctx->opcode & 0x3FFFFFF) << 2;
             gen_compute_branch(ctx, op, 4, rs, rt, offset, 4);
         }
         break;
     case OPC_MDMX:
         /* MDMX: Not implemented. */
         break;
     case OPC_PCREL:
         check_insn(ctx, ISA_MIPS_R6);
         gen_pcrel(ctx, ctx->opcode, ctx->base.pc_next, rs);
         break;
     default:            /* Invalid */
         MIPS_INVAL("major opcode");
         return false;
     }
     return true;
 }
-- 
2.39.2


