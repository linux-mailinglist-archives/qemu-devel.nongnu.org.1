Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 729C77CBADC
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:18:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdKR-0000jy-0v; Tue, 17 Oct 2023 02:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKO-0000hb-QJ
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:16 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKM-0003wk-5U
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:15 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c9d922c039so42633395ad.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523193; x=1698127993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JRi9/WS5MlVCFY4u9HII56g4/6G8PX4/Vkrfldrh7Jk=;
 b=wmcRI5H+8te1glQ2J6MecziQTwbnYHGkPabWVhU/QwPKFDqy4MR7oZzYBjG+GQIKq3
 RhiFpGFzOlYIi7V2d/Q9q+hzah60iPEiNH3DrKkQNei/XnM/s1AtHS+i3eJnIYbgOcJ9
 6pqaoMY1msL+BgJd/1ViAFRLB94JGsm+ZyuzH0YleJ4SscqjlKIdojEPpw4H/qAn60o3
 CSOu9ZhFgqldg8RR+Uy5BWXK8RGJINu5JdEs1d5ORgtBLAWeSndCt0bBijcPvwAI/zrp
 xinW1/K6x84HAM/C1oHLfS8rgmDSFW+MNoXg4uLQaDS4uMANoyDYI1yVxtEH0mH06l+5
 90Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523193; x=1698127993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JRi9/WS5MlVCFY4u9HII56g4/6G8PX4/Vkrfldrh7Jk=;
 b=Kgk85hsz3IKpzF5HXtfMwe9zrMe1hdG3TlhUA95j0JPcv0Tyxd5H2a5F/9DC/m1SYn
 gGhYcJPkPID6558OqTZgaq25KuyCCBDOtrrC7SkhVrP3EHy3UnIWcnkw0l08STsJ+kwo
 WCAA9mYIi6/dian71ZtM0D6PqCEoE8kRt91NqT2BdopzNhGRpbj+3v34Ls/N1zckwUI3
 1zAiYxWzMjM1OXmQ7ZEFQwplcfFCS8W2LYTsuNukRpAiyr0mn9ohfmi13ggbESy+YXy1
 K+rwQ2RTh5OgthXd3umUymqZO9bPbUHIwruyoTGGLP5q64jgtWhTXvgGfHaX063tyKt7
 1D/A==
X-Gm-Message-State: AOJu0YyGxIv+jXm7L9jyAOK5y2XuGKWS8PJN9pGuFsVh+RJkDzNQNfI7
 ZcnPOkwEIPbuintzrwGWdAXeBs2OBylYuHxLoIE=
X-Google-Smtp-Source: AGHT+IFhBVnb+kEw1khzsj5MxysdFtC+nsmQNbJc4J1nKXCCKYHLdKWCGOhci73TryHelAay5jV2Vw==
X-Received: by 2002:a17:902:f0cc:b0:1c6:1cd8:5b59 with SMTP id
 v12-20020a170902f0cc00b001c61cd85b59mr1445719pla.1.1697523192958; 
 Mon, 16 Oct 2023 23:13:12 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:13:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 32/90] target/sparc: Move UMUL, SMUL to decodetree
Date: Mon, 16 Oct 2023 23:11:46 -0700
Message-Id: <20231017061244.681584-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  4 ++++
 target/sparc/translate.c  | 23 +++++------------------
 2 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index d9474d2a20..c114a13f1d 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -172,5 +172,9 @@ XORNcc      10 ..... 010111 ..... . .............          @r_r_ri
 ADDC        10 ..... 001000 ..... . .............          @r_r_ri
 ADDCcc      10 ..... 011000 ..... . .............          @r_r_ri
 MULX        10 ..... 001001 ..... . .............          @r_r_ri
+UMUL        10 ..... 001010 ..... . .............          @r_r_ri
+UMULcc      10 ..... 011010 ..... . .............          @r_r_ri
+SMUL        10 ..... 001011 ..... . .............          @r_r_ri
+SMULcc      10 ..... 011011 ..... . .............          @r_r_ri
 
 Tcc         10 0 cond:4 111010 rs1:5 imm:1 cc:1 00000 rs2_or_imm:7
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index b3ce3947f3..b6ec7d5cfd 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2859,6 +2859,7 @@ static void gen_faligndata(TCGv dst, TCGv gsr, TCGv s1, TCGv s2)
 #define avail_ASR17(C)    ((C)->def->features & CPU_FEATURE_ASR17)
 #define avail_GL(C)       ((C)->def->features & CPU_FEATURE_GL)
 #define avail_HYPV(C)     ((C)->def->features & CPU_FEATURE_HYPV)
+#define avail_MUL(C)      ((C)->def->features & CPU_FEATURE_MUL)
 #define avail_POWERDOWN(C) ((C)->def->features & CPU_FEATURE_POWERDOWN)
 
 /* Default case for non jump instructions. */
@@ -4184,6 +4185,8 @@ TRANS(ANDN, ALL, do_arith, a, tcg_gen_andc_tl, NULL)
 TRANS(ORN, ALL, do_arith, a, tcg_gen_orc_tl, NULL)
 TRANS(XORN, ALL, do_arith, a, tcg_gen_eqv_tl, NULL)
 TRANS(MULX, 64, do_arith, a, tcg_gen_mul_tl, tcg_gen_muli_tl)
+TRANS(UMUL, MUL, do_arith, a, gen_op_umul, NULL)
+TRANS(SMUL, MUL, do_arith, a, gen_op_smul, NULL)
 
 TRANS(ADDcc, ALL, do_cc_arith, a, CC_OP_ADD, gen_op_add_cc, NULL)
 TRANS(ANDcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_and_tl, tcg_gen_andi_tl)
@@ -4193,6 +4196,8 @@ TRANS(SUBcc, ALL, do_cc_arith, a, CC_OP_SUB, gen_op_sub_cc, NULL)
 TRANS(ANDNcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_andc_tl, NULL)
 TRANS(ORNcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_orc_tl, NULL)
 TRANS(XORNcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_eqv_tl, NULL)
+TRANS(UMULcc, MUL, do_cc_arith, a, CC_OP_LOGIC, gen_op_umul, NULL)
+TRANS(SMULcc, MUL, do_cc_arith, a, CC_OP_LOGIC, gen_op_smul, NULL)
 
 static TCGv gen_rs2_or_imm(DisasContext *dc, bool imm, int rs2_or_imm)
 {
@@ -4655,24 +4660,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     cpu_src1 = get_src1(dc, insn);
                     cpu_src2 = get_src2(dc, insn);
                     switch (xop & ~0x10) {
-                    case 0xa: /* umul */
-                        CHECK_IU_FEATURE(dc, MUL);
-                        gen_op_umul(cpu_dst, cpu_src1, cpu_src2);
-                        if (xop & 0x10) {
-                            tcg_gen_mov_tl(cpu_cc_dst, cpu_dst);
-                            tcg_gen_movi_i32(cpu_cc_op, CC_OP_LOGIC);
-                            dc->cc_op = CC_OP_LOGIC;
-                        }
-                        break;
-                    case 0xb: /* smul */
-                        CHECK_IU_FEATURE(dc, MUL);
-                        gen_op_smul(cpu_dst, cpu_src1, cpu_src2);
-                        if (xop & 0x10) {
-                            tcg_gen_mov_tl(cpu_cc_dst, cpu_dst);
-                            tcg_gen_movi_i32(cpu_cc_op, CC_OP_LOGIC);
-                            dc->cc_op = CC_OP_LOGIC;
-                        }
-                        break;
                     case 0xc: /* subx, V9 subc */
                         gen_op_subx_int(dc, cpu_dst, cpu_src1, cpu_src2,
                                         (xop & 0x10));
-- 
2.34.1


