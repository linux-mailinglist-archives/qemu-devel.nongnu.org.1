Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D834781549
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 00:15:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX7iu-0004wb-Dk; Fri, 18 Aug 2023 18:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7ir-0004uk-Mn
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:37 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7io-0004Mb-QK
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:37 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-68872cadc7cso1242340b3a.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 15:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692396813; x=1693001613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eYRbHTB9gdchW7+1WJjqbxhXOCnAT/+AEAo1n2VeIuk=;
 b=eIx8+C62T5iX9UB2mnlFRq+IAM3ozCPgTgENYKQh3mNIlAQ1REjoOeT2HUmAmkm3az
 YB/edtqss4gm43GPUqwsWU6IL5WfDpgx/aQWsygOMrmz1xN/+K8eZkH+2aZkkpGGcN1U
 Phj+XobtCU4dTLJNOdlMvq9eJfFwOVV+RsI1TFRMzYrhdwivmtUm3gEc1MJAUWJXfKAb
 V/6Ig3smOIirNxy4GBz8p7rgVLicBYCCAYfK+8o8kq5fjzkqN2HduSmXKl7F/c1TgOMg
 IN/0JETV1yeA6Me6olBq9pifFUCKnBx8ZQuA/+0TqRnZR6QsA5M1Vb5nEtfhcYXmM2au
 5jiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692396813; x=1693001613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eYRbHTB9gdchW7+1WJjqbxhXOCnAT/+AEAo1n2VeIuk=;
 b=EM/Tj7R+p+oXhOgpv1OJU4ETSiRREVfgtFlf8F7E5jh+ErvHgdea1iFOhIQLsXH636
 iXWTrCQVRWayVXqZGqYHVgwcngIvN+Jy5360FY3FfLEhtAfykMQr5h9ULvYiFUCIma68
 V9ZVtUwBZxlaTVWHZyz54KOSyKBn2oIdq0u12iFgAEgjBht1mcmTRudoh/MO/yQMiKXV
 iTS+K4+rg0W9OddsDzweY6w66aMFOObbzheuGdpsOOWhCL5ljYOcdW1MTHO0rcqSHnH4
 Wb0eV/9BzZUTCUgxYF+viVjwrLr1zVXrGID03CXpPfqwVddARMtyQ83IQLa4f7RpjmY3
 hXFw==
X-Gm-Message-State: AOJu0YxVngvTogl+Bf3uTMlPEzczp5GlBEsFCK0liF6C/ky5A7+jHpgW
 9y/xvpXp8W33ANxcb87CzcbNl1O6RIA5MwlUTQ4=
X-Google-Smtp-Source: AGHT+IGfk+n38ThRDnzuyRClTYn9pfkq5zBtc8iVzbC26JBaHy5mZIY3kVKjeIXfCBAeXgIWfsrijQ==
X-Received: by 2002:a05:6a20:1019:b0:133:6b64:c92 with SMTP id
 gs25-20020a056a20101900b001336b640c92mr496899pzc.44.1692396813376; 
 Fri, 18 Aug 2023 15:13:33 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090322c700b001bdb85291casm2231417plg.208.2023.08.18.15.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 15:13:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 05/23] target/m68k: Use tcg_gen_negsetcond_*
Date: Fri, 18 Aug 2023 15:13:09 -0700
Message-Id: <20230818221327.150194-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818221327.150194-1-richard.henderson@linaro.org>
References: <20230818221327.150194-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
 target/m68k/translate.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index d08e823b6c..15b3701b8f 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -1350,8 +1350,7 @@ static void gen_cc_cond(DisasCompare *c, DisasContext *s, int cond)
     case 14: /* GT (!(Z || (N ^ V))) */
     case 15: /* LE (Z || (N ^ V)) */
         c->v1 = tmp = tcg_temp_new();
-        tcg_gen_setcond_i32(TCG_COND_EQ, tmp, QREG_CC_Z, c->v2);
-        tcg_gen_neg_i32(tmp, tmp);
+        tcg_gen_negsetcond_i32(TCG_COND_EQ, tmp, QREG_CC_Z, c->v2);
         tmp2 = tcg_temp_new();
         tcg_gen_xor_i32(tmp2, QREG_CC_N, QREG_CC_V);
         tcg_gen_or_i32(tmp, tmp, tmp2);
@@ -1430,9 +1429,8 @@ DISAS_INSN(scc)
     gen_cc_cond(&c, s, cond);
 
     tmp = tcg_temp_new();
-    tcg_gen_setcond_i32(c.tcond, tmp, c.v1, c.v2);
+    tcg_gen_negsetcond_i32(c.tcond, tmp, c.v1, c.v2);
 
-    tcg_gen_neg_i32(tmp, tmp);
     DEST_EA(env, insn, OS_BYTE, tmp, NULL);
 }
 
@@ -2764,13 +2762,14 @@ DISAS_INSN(mull)
             tcg_gen_muls2_i32(QREG_CC_N, QREG_CC_V, src1, DREG(ext, 12));
             /* QREG_CC_V is -(QREG_CC_V != (QREG_CC_N >> 31)) */
             tcg_gen_sari_i32(QREG_CC_Z, QREG_CC_N, 31);
-            tcg_gen_setcond_i32(TCG_COND_NE, QREG_CC_V, QREG_CC_V, QREG_CC_Z);
+            tcg_gen_negsetcond_i32(TCG_COND_NE, QREG_CC_V,
+                                   QREG_CC_V, QREG_CC_Z);
         } else {
             tcg_gen_mulu2_i32(QREG_CC_N, QREG_CC_V, src1, DREG(ext, 12));
             /* QREG_CC_V is -(QREG_CC_V != 0), use QREG_CC_C as 0 */
-            tcg_gen_setcond_i32(TCG_COND_NE, QREG_CC_V, QREG_CC_V, QREG_CC_C);
+            tcg_gen_negsetcond_i32(TCG_COND_NE, QREG_CC_V,
+                                   QREG_CC_V, QREG_CC_C);
         }
-        tcg_gen_neg_i32(QREG_CC_V, QREG_CC_V);
         tcg_gen_mov_i32(DREG(ext, 12), QREG_CC_N);
 
         tcg_gen_mov_i32(QREG_CC_Z, QREG_CC_N);
@@ -3339,14 +3338,13 @@ static inline void shift_im(DisasContext *s, uint16_t insn, int opsize)
         if (!logical && m68k_feature(s->env, M68K_FEATURE_M68K)) {
             /* if shift count >= bits, V is (reg != 0) */
             if (count >= bits) {
-                tcg_gen_setcond_i32(TCG_COND_NE, QREG_CC_V, reg, QREG_CC_V);
+                tcg_gen_negsetcond_i32(TCG_COND_NE, QREG_CC_V, reg, QREG_CC_V);
             } else {
                 TCGv t0 = tcg_temp_new();
                 tcg_gen_sari_i32(QREG_CC_V, reg, bits - 1);
                 tcg_gen_sari_i32(t0, reg, bits - count - 1);
-                tcg_gen_setcond_i32(TCG_COND_NE, QREG_CC_V, QREG_CC_V, t0);
+                tcg_gen_negsetcond_i32(TCG_COND_NE, QREG_CC_V, QREG_CC_V, t0);
             }
-            tcg_gen_neg_i32(QREG_CC_V, QREG_CC_V);
         }
     } else {
         tcg_gen_shri_i32(QREG_CC_C, reg, count - 1);
@@ -3430,9 +3428,8 @@ static inline void shift_reg(DisasContext *s, uint16_t insn, int opsize)
             /* Ignore the bits below the sign bit.  */
             tcg_gen_andi_i64(t64, t64, -1ULL << (bits - 1));
             /* If any bits remain set, we have overflow.  */
-            tcg_gen_setcondi_i64(TCG_COND_NE, t64, t64, 0);
+            tcg_gen_negsetcond_i64(TCG_COND_NE, t64, t64, tcg_constant_i64(0));
             tcg_gen_extrl_i64_i32(QREG_CC_V, t64);
-            tcg_gen_neg_i32(QREG_CC_V, QREG_CC_V);
         }
     } else {
         tcg_gen_shli_i64(t64, t64, 32);
@@ -5311,9 +5308,8 @@ DISAS_INSN(fscc)
     gen_fcc_cond(&c, s, cond);
 
     tmp = tcg_temp_new();
-    tcg_gen_setcond_i32(c.tcond, tmp, c.v1, c.v2);
+    tcg_gen_negsetcond_i32(c.tcond, tmp, c.v1, c.v2);
 
-    tcg_gen_neg_i32(tmp, tmp);
     DEST_EA(env, insn, OS_BYTE, tmp, NULL);
 }
 
-- 
2.34.1


