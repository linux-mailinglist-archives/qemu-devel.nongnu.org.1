Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6303F781547
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 00:15:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX7it-0004vj-C5; Fri, 18 Aug 2023 18:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7iq-0004u5-FZ
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:36 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7io-0004MB-25
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:36 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bdc19b782aso10991575ad.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 15:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692396812; x=1693001612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gMdPzlTqXIVuvEs7JarBjvvs+ZKTDEbeaSAObbNwgl4=;
 b=fJkkx8zN2LMW3vReIt2FETei1xOAyviaMFA/nXkQUZkYH4awOL4qTDbvQt+IvYsLni
 yUt6B88pI7lp8WmbwjibdcDnctg32RP6cA/+yFb6+swpgWSIJEmpK9Qd+Xrcm/xpDVAz
 NbCmuXBr11vPMCZqZUvMbwS0wnQM79zVpMnf1jiX6mK4kUZ0dCxOImIS15wAb6tnJr89
 qPfTzD2zH61+S1x+aWtv+ral+58zmIbGngwDFgBJMuVe5ivRe+nr2ACRk9+35p2QPUP4
 rcrY4raYZNorf4jtbfpzN2D4NT4iI8LGDrnOcxKphjcQTrhTEDR2M+kIH5VfsxnWo3j9
 oPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692396812; x=1693001612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gMdPzlTqXIVuvEs7JarBjvvs+ZKTDEbeaSAObbNwgl4=;
 b=Xt9BCg+jEbSr2nbQhvurg8y0D3rJd2Imzldtmi9oqmvBwJO6g1UUXASND0WPvcCM15
 RZ/B/0TR+5NUpxZCaTgt56maYA41Gyl/qMAbOLJhNtsqDNAfIasIImkl+/kUrjzxm6PR
 zY/ARa0JHeeJ8LBc/ETB8xCobveo+3gIEznLFTxTKzW85PPfU/od08ntAf9zzpU8P4fR
 9Y061ZkZvFPcJlNrMNShzoPr1NniRf0nQmM2yBmll6HHqr/mCx1SalB8ehfTXr4a5ZfG
 fCMFqKtqh9xLOQlecXZ+rPc8fH/eM4ilzRiWMA7tHEj2LIlfzctTVr9F4/Oz4dqkK+vi
 rIaQ==
X-Gm-Message-State: AOJu0Yy9x3StnUKLnyCw/naDRnl30ciPjLcbMk7Dy1TZwIomSyutYErk
 7l78wY2qkatUOpXDWes/8gLgZwVaZto43pLWR6Q=
X-Google-Smtp-Source: AGHT+IFLmMJih0FWkYFMHGLWmtYtHdBgInIlaw8mBO/jg2rJXWDk2hOZFTVGRPwhdK2eguNZ73VOxg==
X-Received: by 2002:a17:902:ea8b:b0:1bb:25bd:d09c with SMTP id
 x11-20020a170902ea8b00b001bb25bdd09cmr544233plb.1.1692396812488; 
 Fri, 18 Aug 2023 15:13:32 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090322c700b001bdb85291casm2231417plg.208.2023.08.18.15.13.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 15:13:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 04/23] target/arm: Use tcg_gen_negsetcond_*
Date: Fri, 18 Aug 2023 15:13:08 -0700
Message-Id: <20230818221327.150194-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818221327.150194-1-richard.henderson@linaro.org>
References: <20230818221327.150194-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 22 +++++++++-------------
 target/arm/tcg/translate.c     | 12 ++++--------
 2 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5fa1257d32..da686cc953 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4935,9 +4935,12 @@ static void disas_cond_select(DisasContext *s, uint32_t insn)
 
     if (rn == 31 && rm == 31 && (else_inc ^ else_inv)) {
         /* CSET & CSETM.  */
-        tcg_gen_setcond_i64(tcg_invert_cond(c.cond), tcg_rd, c.value, zero);
         if (else_inv) {
-            tcg_gen_neg_i64(tcg_rd, tcg_rd);
+            tcg_gen_negsetcond_i64(tcg_invert_cond(c.cond),
+                                   tcg_rd, c.value, zero);
+        } else {
+            tcg_gen_setcond_i64(tcg_invert_cond(c.cond),
+                                tcg_rd, c.value, zero);
         }
     } else {
         TCGv_i64 t_true = cpu_reg(s, rn);
@@ -8670,13 +8673,10 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
         }
         break;
     case 0x6: /* CMGT, CMHI */
-        /* 64 bit integer comparison, result = test ? (2^64 - 1) : 0.
-         * We implement this using setcond (test) and then negating.
-         */
         cond = u ? TCG_COND_GTU : TCG_COND_GT;
     do_cmop:
-        tcg_gen_setcond_i64(cond, tcg_rd, tcg_rn, tcg_rm);
-        tcg_gen_neg_i64(tcg_rd, tcg_rd);
+        /* 64 bit integer comparison, result = test ? -1 : 0. */
+        tcg_gen_negsetcond_i64(cond, tcg_rd, tcg_rn, tcg_rm);
         break;
     case 0x7: /* CMGE, CMHS */
         cond = u ? TCG_COND_GEU : TCG_COND_GE;
@@ -9265,14 +9265,10 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
         }
         break;
     case 0xa: /* CMLT */
-        /* 64 bit integer comparison against zero, result is
-         * test ? (2^64 - 1) : 0. We implement via setcond(!test) and
-         * subtracting 1.
-         */
         cond = TCG_COND_LT;
     do_cmop:
-        tcg_gen_setcondi_i64(cond, tcg_rd, tcg_rn, 0);
-        tcg_gen_neg_i64(tcg_rd, tcg_rd);
+        /* 64 bit integer comparison against zero, result is test ? -1 : 0. */
+        tcg_gen_negsetcond_i64(cond, tcg_rd, tcg_rn, tcg_constant_i64(0));
         break;
     case 0x8: /* CMGT, CMGE */
         cond = u ? TCG_COND_GE : TCG_COND_GT;
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index b71ac2d0d5..31d3130e4c 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -2946,13 +2946,11 @@ void gen_gvec_sqrdmlsh_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
 #define GEN_CMP0(NAME, COND)                                            \
     static void gen_##NAME##0_i32(TCGv_i32 d, TCGv_i32 a)               \
     {                                                                   \
-        tcg_gen_setcondi_i32(COND, d, a, 0);                            \
-        tcg_gen_neg_i32(d, d);                                          \
+        tcg_gen_negsetcond_i32(COND, d, a, tcg_constant_i32(0));        \
     }                                                                   \
     static void gen_##NAME##0_i64(TCGv_i64 d, TCGv_i64 a)               \
     {                                                                   \
-        tcg_gen_setcondi_i64(COND, d, a, 0);                            \
-        tcg_gen_neg_i64(d, d);                                          \
+        tcg_gen_negsetcond_i64(COND, d, a, tcg_constant_i64(0));        \
     }                                                                   \
     static void gen_##NAME##0_vec(unsigned vece, TCGv_vec d, TCGv_vec a) \
     {                                                                   \
@@ -3863,15 +3861,13 @@ void gen_gvec_mls(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
 static void gen_cmtst_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
 {
     tcg_gen_and_i32(d, a, b);
-    tcg_gen_setcondi_i32(TCG_COND_NE, d, d, 0);
-    tcg_gen_neg_i32(d, d);
+    tcg_gen_negsetcond_i32(TCG_COND_NE, d, d, tcg_constant_i32(0));
 }
 
 void gen_cmtst_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 {
     tcg_gen_and_i64(d, a, b);
-    tcg_gen_setcondi_i64(TCG_COND_NE, d, d, 0);
-    tcg_gen_neg_i64(d, d);
+    tcg_gen_negsetcond_i64(TCG_COND_NE, d, d, tcg_constant_i64(0));
 }
 
 static void gen_cmtst_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
-- 
2.34.1


