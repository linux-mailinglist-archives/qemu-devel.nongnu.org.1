Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 982AE786171
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:27:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOl-0000Pn-4d; Wed, 23 Aug 2023 16:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOV-0008L0-7u
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:59 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOK-0005Ug-Tf
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:56 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c06f6f98c0so28091525ad.3
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822225; x=1693427025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gMdPzlTqXIVuvEs7JarBjvvs+ZKTDEbeaSAObbNwgl4=;
 b=zlPpja1gGc6nrGkTLzyh4qCgpRGZEl0TklNg6p0+jXikHFUu5uw6GDboyCJWCtX9Iw
 lEDpijV7vpFvOaCv8hVwsz7nezvqIDZjLRUVbEtEz2ZJkevXGyHrVd1HRvLrpn8hfLLM
 5xOiUUPnhecu/jIh7pb0IBbfNSCC2kE+O0RLtj8ULFLrp0GXzbt2bRRGzLojeSPaz1Ne
 tjUiuKVL/8o3TyKKsXVBL5EErCaWedl61O9ahZ6awMf6Ooho9jUXYCaV1qIl1JI+xtf1
 /mKlaTUhTLIR/9G328Ry4n7UbJttb5Af25YmtBBD1PrWtHuJN7iXHN7G5Igvgrc0npv1
 pDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822225; x=1693427025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gMdPzlTqXIVuvEs7JarBjvvs+ZKTDEbeaSAObbNwgl4=;
 b=R6YeZiHY2HSIaUUY45LQuIA+rwQ3MTFjb4YKLUHU52mFpBrOALjpZYCWqWDETNsG5l
 fXEk/8Wv7YdEmwqVYeLOOcTU/Hg/EMTa3o9/3dg92L6eV5+p8dkO4TFKXDrRpZoPWvRz
 vjy5msJbXc5XOPMiJ+h/Xda+VtohHWDpeAMPyIg0iinLOTj1dictoLh6seWi7qB5fD8J
 AL5AIgIMgF8xRBKwpoBVeATbv+LgS86uYxf9etiq3lRla8ap2m69b34jnJJw0nKnMzT9
 bAh6tC8cwibvhwp5KcO4met3eWrlP3wC36JQOY/zDv3is04OFvKs5KwjiFoGCl6y9S2V
 jirA==
X-Gm-Message-State: AOJu0Yysj1eq4FNNQR24Yslbwi2IfMQPC8Xn2jbS0fiqjKRrZzR98DSz
 5WeL3+O1YdS5dXEvjqI3bYbgJAbXNAcwvNfIuLI=
X-Google-Smtp-Source: AGHT+IGVvTk3B1TNL8Mpmo6yKxCk1OaD1SPop0bZxjiQSM6Sw51rhONJYnwgy3ZYxMtnQPcuAFtxrg==
X-Received: by 2002:a17:902:d342:b0:1bf:4a1f:2b57 with SMTP id
 l2-20020a170902d34200b001bf4a1f2b57mr9064433plk.13.1692822225522; 
 Wed, 23 Aug 2023 13:23:45 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:23:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 19/48] target/arm: Use tcg_gen_negsetcond_*
Date: Wed, 23 Aug 2023 13:22:57 -0700
Message-Id: <20230823202326.1353645-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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


