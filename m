Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5DF773787
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 05:18:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTD8Z-0000Da-Li; Mon, 07 Aug 2023 23:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTD8Y-0000C3-3f
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:11:58 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTD8Q-00009b-Hl
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:11:57 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-686efa1804eso3761938b3a.3
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 20:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691464309; x=1692069109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZfPoEwU2O4IK9AqxqstJxMdbJLfYwviBA2IVblhOckE=;
 b=CYy0zxEgPdbPeNcZuGP69o6VeEYuvsty2f4ROFOJ90mZsLLrkgA6Art9rAOOSsXJws
 o6tXLUdxlG0DhMwE/criK95ovC/ncOfkU4/0Deih/j2uFOjVHCrIiZVIndxJx7UtqRWo
 Trkv+G4JThfcJV2hkhKI8MY+IpsDKaW2kGUQfW4tc3Wqoql94PfRWDEu6fmVGzOYrVWG
 RmhEMkJNUn4w33TupHt+BTB9XaGAn64KlFopd28D9RXnQdIOYbgmDu0XTiwJMz4Sa02Q
 D/C0zGxmC14P1QwtiubvAy1VmZtfwIYqEndenTKDgw+LkHp2qaoh2TThkbdlLY13Xy/P
 x6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691464309; x=1692069109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZfPoEwU2O4IK9AqxqstJxMdbJLfYwviBA2IVblhOckE=;
 b=afhGQn/GJAknV2Z8JWmtqC7iq2km4iZnTmeltmZtF/nEm5SI7lL+ezLYuAFWg0Gqwj
 89iZ35uMb6z4ghLbmWEZ3SwR57fFW3Wz7ERf/HPp5Zkkp4YY0ykMKX/yHM9bySoPOXIk
 CCCUQf0DNjFbIY59LlU1zI3xEIok4vaX4uu1bWZSTLWfOMhabgiVh9YIc4SXIvSilL2/
 GmWd5zAAZ1HQVBbNb2cmSHVrIKl+9aGXhhE598qygeoUeMx+DRQ8sfz/hHeVGAPAAqEV
 lFSe1y+Lbbu+zD2CihE9F2Owh0lZitvZIyhAceTHlqQdAi3Ed19Mk3BKXhMoOvM2ckMn
 rmig==
X-Gm-Message-State: AOJu0Yztq9zhS40HbESfURTT+fSwzwFTNY5bTuNAVeSYBCsr0tD+CqVR
 pDKV/+tVyfg+yBP0EmbK5PbRK8DfPpfogZxByD0=
X-Google-Smtp-Source: AGHT+IFZ8g8ozpVXqVj7zEJGFeLKkkJ/l8JrOKqZ1F31o9lDyN/7HwvBOpZ0xGedNzppYEOdGt8R4Q==
X-Received: by 2002:a05:6a20:4312:b0:140:f1d2:4fc with SMTP id
 h18-20020a056a20431200b00140f1d204fcmr4154408pzk.45.1691464309192; 
 Mon, 07 Aug 2023 20:11:49 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 g64-20020a636b43000000b0055bf96b11d9sm5639087pgc.89.2023.08.07.20.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 20:11:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
Subject: [PATCH 05/24] target/m68k: Use tcg_gen_negsetcond_*
Date: Mon,  7 Aug 2023 20:11:24 -0700
Message-Id: <20230808031143.50925-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808031143.50925-1-richard.henderson@linaro.org>
References: <20230808031143.50925-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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
 target/m68k/translate.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index e07161d76f..37954d11a6 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -1357,8 +1357,7 @@ static void gen_cc_cond(DisasCompare *c, DisasContext *s, int cond)
     case 14: /* GT (!(Z || (N ^ V))) */
     case 15: /* LE (Z || (N ^ V)) */
         c->v1 = tmp = tcg_temp_new();
-        tcg_gen_setcond_i32(TCG_COND_EQ, tmp, QREG_CC_Z, c->v2);
-        tcg_gen_neg_i32(tmp, tmp);
+        tcg_gen_negsetcond_i32(TCG_COND_EQ, tmp, QREG_CC_Z, c->v2);
         tmp2 = tcg_temp_new();
         tcg_gen_xor_i32(tmp2, QREG_CC_N, QREG_CC_V);
         tcg_gen_or_i32(tmp, tmp, tmp2);
@@ -1437,9 +1436,8 @@ DISAS_INSN(scc)
     gen_cc_cond(&c, s, cond);
 
     tmp = tcg_temp_new();
-    tcg_gen_setcond_i32(c.tcond, tmp, c.v1, c.v2);
+    tcg_gen_negsetcond_i32(c.tcond, tmp, c.v1, c.v2);
 
-    tcg_gen_neg_i32(tmp, tmp);
     DEST_EA(env, insn, OS_BYTE, tmp, NULL);
 }
 
@@ -2771,13 +2769,14 @@ DISAS_INSN(mull)
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
@@ -3346,14 +3345,13 @@ static inline void shift_im(DisasContext *s, uint16_t insn, int opsize)
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
@@ -3437,9 +3435,8 @@ static inline void shift_reg(DisasContext *s, uint16_t insn, int opsize)
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
@@ -5318,9 +5315,8 @@ DISAS_INSN(fscc)
     gen_fcc_cond(&c, s, cond);
 
     tmp = tcg_temp_new();
-    tcg_gen_setcond_i32(c.tcond, tmp, c.v1, c.v2);
+    tcg_gen_negsetcond_i32(c.tcond, tmp, c.v1, c.v2);
 
-    tcg_gen_neg_i32(tmp, tmp);
     DEST_EA(env, insn, OS_BYTE, tmp, NULL);
 }
 
-- 
2.34.1


