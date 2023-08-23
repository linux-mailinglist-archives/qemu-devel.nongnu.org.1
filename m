Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A0278616D
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:26:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOk-0000KA-BF; Wed, 23 Aug 2023 16:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOV-0008Kz-6q
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:59 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOK-0005Ul-M8
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:51 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bf078d5fb7so41366105ad.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822226; x=1693427026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AT1qChCBl3ylCJc51IzPShNGnRnN6UDaf4m0aaMcNpE=;
 b=WeGk6U7dBvoAN1XWWyExWkfIBXbS8gAUS1BS75JvoI6lPeiOCUCDPhlDBHYClx8aAs
 VkAPfc8GJdaSIX3HWSb/oyVRUt/EgpgH5+CYF59KwoB6b8K4XQBVLHadpWQwLZdAKM3C
 LJNlA8b9FsYrD5qPhMAadB394GD+QGvk+cnjTqGFheej4Go/LT+BN5H67xiP5RJT9u/d
 ywT4/UunZXmGDrdoTlNovLZqXMxLBlUmmw1G2LIK32cWVERf7J9uZtBhOXjc7f4KcR3n
 3uXrNJhFdIVg/XGnYovGEipfyCOn1y33fnrXDiCkmkO5YxujtlD2gB0TYQqO8O+CTcB0
 tO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822226; x=1693427026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AT1qChCBl3ylCJc51IzPShNGnRnN6UDaf4m0aaMcNpE=;
 b=L8GdGww0B42LkmFjePvl9gdSReOi6nkHKOqujdqRtJZarfxvjb9TOyo18Tbow3MxEK
 kM/VzLJtVlT/SSplXDZ6/rflN1yr7K35PEpae9Awt5ucJ8J3/NzF44zUDu/apmUa3msD
 TvovVNKZ1PkAwjHx25Rdvi1xF+U87W4DGedsXY1Z9xefVEQB6soeDCsg8vSr54qJ3Vr3
 vZoXULrtjEqIxE2WeIe3kKeteQsJU2t+r46YmQTI11/J1jK33IYxXLv3qWdgh9a6jqj+
 zX4jq4H0MU9HHqyryf6/tucUVRGZcaLnswEIFdBmeZU9GXWCK1ucDCN0z9OSKMEP4KZe
 GITw==
X-Gm-Message-State: AOJu0YyInjUx9TjefY4+CuEbwdDe2VVdNQjeP1oripyC61Xjc8k/ouei
 qfHvso//905MJ5CgHjjTpXQJp/UEGr9IpKDz+Yg=
X-Google-Smtp-Source: AGHT+IEUTNlj40nsuzlzWA5Eoff1jQA91yy+6XSvcxTP3JDJzqjPq1vyvIW/jmYL8hekw94jMOf9ug==
X-Received: by 2002:a17:903:1212:b0:1b0:3df7:5992 with SMTP id
 l18-20020a170903121200b001b03df75992mr13728413plh.32.1692822226532; 
 Wed, 23 Aug 2023 13:23:46 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.23.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:23:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 20/48] target/m68k: Use tcg_gen_negsetcond_*
Date: Wed, 23 Aug 2023 13:22:58 -0700
Message-Id: <20230823202326.1353645-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


