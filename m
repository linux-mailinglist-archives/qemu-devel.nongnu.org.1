Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3FE7D271E
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:34:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhwb-0003ie-Fh; Sun, 22 Oct 2023 19:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwY-0003h9-BH
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:14 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwW-0007RY-D7
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:14 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6bd73395bceso1935247b3a.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017589; x=1698622389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eE084um7eMxb5xsw5GDPD2HdM5UNzLcKYENQW8yHEfc=;
 b=he6ZO7ddi2SczQBX6uGk9nYM7uVwvkwoA0bEMbBpMZYilNz1dp0iVa+e2i60ROmQjx
 O3KrdNBwoS1n88Odyyakwczqu3XTOFpzWfcXDT+OA08FDir/Ozd+aWeMLNpeLGEKErDo
 C330vgD1TyhWxJSNGTiCvSWvFbI0QTE6QzMh9byC7pTIhr06xBUhFlijjviX9fSloVQs
 zjqMesn40b6xHVWXCIYG+ZVCX54SvGqtzkVMvrwxxMfIPDe5iEJTfD7lipI1k99JyMMz
 Qi32un5lejd80GsUDPeAdKp/vhwPeNnDewE5wi2fa9cYApCJkFMaupjn9zvpKhglYHqK
 b+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017589; x=1698622389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eE084um7eMxb5xsw5GDPD2HdM5UNzLcKYENQW8yHEfc=;
 b=Ygy/XCgLodd9AO97SjHHFx1dTWC1CjlEKRSrxgDzNkKaYsYs+/dQ28DmwukAPhVitq
 1UaIQ2Ok8rkzBgtI2S1EtSlXtDc7n+n6ZFBU/B7eQFTeTJQ57Dg5ZiAmRQhfg4LkjjIe
 TF9QLLnX5AmBnx7DtCRHJ3E40EHZN8xw4d6xPl04s2prK9M3MYrmDihyotQ1RPSUE61L
 rwQyOgiHN8XtSLpNobcwuPP9BcE5tR2uIfrl1AwhbcmhA2Hr/WU5QRFWFL388RZ531Q3
 gOkvnJMtKw2mMZRT7tK9jbD0Hqb+NxU1z5NMMIsL4m/kItS68/lvX20IgTaCdwjrqCgj
 KdUg==
X-Gm-Message-State: AOJu0YwRMriGLF19Eo747qPQMw9lCsyvedop0ZABGgi1wUah8dDEExfA
 guf4ABKaZA4K9KyUPTuMd2EQG7nFXxq2XUxEqo8=
X-Google-Smtp-Source: AGHT+IGziK2ZfcupppYauevoG6jLLkHZKHL14WwnMVAkTk78q3bimP/Esr9qvP52T+tBTov1qJEQtA==
X-Received: by 2002:a05:6a20:5481:b0:15d:1646:285a with SMTP id
 i1-20020a056a20548100b0015d1646285amr11275528pzk.21.1698017588698; 
 Sun, 22 Oct 2023 16:33:08 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fe12-20020a056a002f0c00b0066a4e561beesm5182855pfb.173.2023.10.22.16.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:33:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 40/94] target/sparc: Move TADD, TSUB, MULS to decodetree
Date: Sun, 22 Oct 2023 16:28:38 -0700
Message-Id: <20231022232932.80507-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  7 ++++++
 target/sparc/helper.c     |  4 ----
 target/sparc/translate.c  | 47 +++++++++++++++++----------------------
 3 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 4415d03858..b35921aabb 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -32,6 +32,7 @@ CALL    01 i:s30
 &r_r_ri_cc  rd rs1 rs2_or_imm imm:bool cc:bool
 @r_r_ri_cc  .. rd:5  . cc:1 .... rs1:5 imm:1 rs2_or_imm:s13    &r_r_ri_cc
 @r_r_ri_cc0 .. rd:5  ...... rs1:5 imm:1 rs2_or_imm:s13         &r_r_ri_cc cc=0
+@r_r_ri_cc1 .. rd:5  ...... rs1:5 imm:1 rs2_or_imm:s13         &r_r_ri_cc cc=1
 
 {
   [
@@ -170,12 +171,18 @@ SUBC        10 ..... 0.1100 ..... . .............          @r_r_ri_cc
 MULX        10 ..... 001001 ..... . .............          @r_r_ri_cc0
 UMUL        10 ..... 0.1010 ..... . .............          @r_r_ri_cc
 SMUL        10 ..... 0.1011 ..... . .............          @r_r_ri_cc
+MULScc      10 ..... 100100 ..... . .............          @r_r_ri_cc1
 
 UDIVX       10 ..... 001101 ..... . .............          @r_r_ri_cc0
 SDIVX       10 ..... 101101 ..... . .............          @r_r_ri_cc0
 UDIV        10 ..... 0.1110 ..... . .............          @r_r_ri_cc
 SDIV        10 ..... 0.1111 ..... . .............          @r_r_ri_cc
 
+TADDcc      10 ..... 100000 ..... . .............          @r_r_ri_cc1
+TSUBcc      10 ..... 100001 ..... . .............          @r_r_ri_cc1
+TADDccTV    10 ..... 100010 ..... . .............          @r_r_ri_cc1
+TSUBccTV    10 ..... 100011 ..... . .............          @r_r_ri_cc1
+
 Tcc_r       10 0 cond:4 111010 rs1:5 0 cc:1 0000000 rs2:5
 {
   # For v7, the entire simm13 field is present, but masked to 7 bits.
diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index e25fdaeedd..2bcdc81d54 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -198,10 +198,8 @@ target_ulong helper_taddcctv(CPUSPARCState *env, target_ulong src1,
     }
 
     /* Only modify the CC after any exceptions have been generated.  */
-    env->cc_op = CC_OP_TADDTV;
     env->cc_src = src1;
     env->cc_src2 = src2;
-    env->cc_dst = dst;
     return dst;
 
  tag_overflow:
@@ -226,10 +224,8 @@ target_ulong helper_tsubcctv(CPUSPARCState *env, target_ulong src1,
     }
 
     /* Only modify the CC after any exceptions have been generated.  */
-    env->cc_op = CC_OP_TSUBTV;
     env->cc_src = src1;
     env->cc_src2 = src2;
-    env->cc_dst = dst;
     return dst;
 
  tag_overflow:
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index e5430af973..672eb20c1e 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -730,6 +730,16 @@ static void gen_op_sdivcc(TCGv dst, TCGv src1, TCGv src2)
     gen_helper_sdiv_cc(dst, tcg_env, src1, src2);
 }
 
+static void gen_op_taddcctv(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_helper_taddcctv(dst, tcg_env, src1, src2);
+}
+
+static void gen_op_tsubcctv(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_helper_tsubcctv(dst, tcg_env, src1, src2);
+}
+
 // 1
 static void gen_op_eval_ba(TCGv dst)
 {
@@ -4153,6 +4163,10 @@ TRANS(UDIVX, 64, do_arith, a, -1, gen_op_udivx, NULL, NULL)
 TRANS(SDIVX, 64, do_arith, a, -1, gen_op_sdivx, NULL, NULL)
 TRANS(UDIV, DIV, do_arith, a, CC_OP_DIV, gen_op_udiv, NULL, gen_op_udivcc)
 TRANS(SDIV, DIV, do_arith, a, CC_OP_DIV, gen_op_sdiv, NULL, gen_op_sdivcc)
+TRANS(TADDcc, ALL, do_arith, a, CC_OP_TADD, NULL, NULL, gen_op_add_cc)
+TRANS(TSUBcc, ALL, do_arith, a, CC_OP_TSUB, NULL, NULL, gen_op_sub_cc)
+TRANS(TADDccTV, ALL, do_arith, a, CC_OP_TADDTV, NULL, NULL, gen_op_taddcctv)
+TRANS(TSUBccTV, ALL, do_arith, a, CC_OP_TSUBTV, NULL, NULL, gen_op_tsubcctv)
 
 static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
 {
@@ -4224,6 +4238,12 @@ static bool trans_SUBC(DisasContext *dc, arg_r_r_ri_cc *a)
     }
 }
 
+static bool trans_MULScc(DisasContext *dc, arg_r_r_ri_cc *a)
+{
+    update_psr(dc);
+    return do_arith(dc, a, CC_OP_ADD, NULL, NULL, gen_op_mulscc);
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -4651,36 +4671,11 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     cpu_src2 = get_src2(dc, insn);
                     switch (xop) {
                     case 0x20: /* taddcc */
-                        gen_op_add_cc(cpu_dst, cpu_src1, cpu_src2);
-                        gen_store_gpr(dc, rd, cpu_dst);
-                        tcg_gen_movi_i32(cpu_cc_op, CC_OP_TADD);
-                        dc->cc_op = CC_OP_TADD;
-                        break;
                     case 0x21: /* tsubcc */
-                        gen_op_sub_cc(cpu_dst, cpu_src1, cpu_src2);
-                        gen_store_gpr(dc, rd, cpu_dst);
-                        tcg_gen_movi_i32(cpu_cc_op, CC_OP_TSUB);
-                        dc->cc_op = CC_OP_TSUB;
-                        break;
                     case 0x22: /* taddcctv */
-                        gen_helper_taddcctv(cpu_dst, tcg_env,
-                                            cpu_src1, cpu_src2);
-                        gen_store_gpr(dc, rd, cpu_dst);
-                        dc->cc_op = CC_OP_TADDTV;
-                        break;
                     case 0x23: /* tsubcctv */
-                        gen_helper_tsubcctv(cpu_dst, tcg_env,
-                                            cpu_src1, cpu_src2);
-                        gen_store_gpr(dc, rd, cpu_dst);
-                        dc->cc_op = CC_OP_TSUBTV;
-                        break;
                     case 0x24: /* mulscc */
-                        update_psr(dc);
-                        gen_op_mulscc(cpu_dst, cpu_src1, cpu_src2);
-                        gen_store_gpr(dc, rd, cpu_dst);
-                        tcg_gen_movi_i32(cpu_cc_op, CC_OP_ADD);
-                        dc->cc_op = CC_OP_ADD;
-                        break;
+                        goto illegal_insn;  /* in decodetree */
 #ifndef TARGET_SPARC64
                     case 0x25:  /* sll */
                         if (IS_IMM) { /* immediate */
-- 
2.34.1


