Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8D678155A
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 00:18:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX7j2-000532-SO; Fri, 18 Aug 2023 18:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7j0-00050i-Dw
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:46 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7ix-0004PQ-U9
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:46 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bc0d39b52cso10960615ad.2
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 15:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692396822; x=1693001622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rH9kYuzwfqQwVhoLvPDezMMK6fzY2PUYkGYYUhMfg8U=;
 b=sFgel9tR9YZ3tf+54Q5jPRS6iF+BW3DgpMWDE9ivGfzRx2J14dX3qjYvvf6Dqlyy2W
 1WAfHKluS5g++3pWequ4WQ69NBBMgHFCv1zlljBAiizkQeWoTKN9pztmnYzjZxGivBCW
 lP86trhrtFetoTtT6lceeERPsdXV+3lvBcsp2GqeZl3GNhmNx/w/zOSbahbzQiKEWYgV
 6PnuCGz7zGi2d0MMabkDU72dBP0/9Yev4Bo4ZQmxqKlHxOGSrnLrs8vNVT0+DqIjWuvy
 XNkoOuTBQ7Pzd69kCBs/gEF3DJ4sVM9dz4xyCwnL/4oQEbz7fp1YjZvrKhIaagY53X/s
 pAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692396822; x=1693001622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rH9kYuzwfqQwVhoLvPDezMMK6fzY2PUYkGYYUhMfg8U=;
 b=edJLgN9icb4Fh4AwMcBisCBrg6OlyrQTbZ976EdVOYHTbCoW9TJwkU8AQBlcDpDjiT
 kF20B9/Myk6PFpdcW7mdaHKhn/3e5OSivxCmSkMswNvwmDRwGfnp5RGjURElSKdbC9KE
 flTIwgpXxVMReJ+2O7/p3BZCW3PFvVpBTXkXg8NLtFr0U4jg/crKwDZ3IFVrC5PEYbu5
 3Q9UoYiW1JLt80Jl3el1n8HPoxc4qiBpwFNqlfjaaPXRCmT8m1Im9H3lUgcN+GLIttdH
 hdwZOGneQkLCqoKyueH6XSwF/vaa2WEyaumVrHzKlhWS+zzmwLRsaGN19YsheElJKJGQ
 2LUQ==
X-Gm-Message-State: AOJu0YxThAVBQj4MIIc+QRY0esUYWWewIM5TxVYfcyI58YzvMY3gjwmE
 9WVjkSwGGXAr4OIeniYzuVz/fzm5EO5SYQv7UGU=
X-Google-Smtp-Source: AGHT+IFu9JOJPab5JTrUyiYSYNiy1XT5EdvfND7MKwlJ9k9V15B53DjKd5roH9iNPbPaPFd2PWy6jA==
X-Received: by 2002:a17:902:dac1:b0:1a6:74f6:fa92 with SMTP id
 q1-20020a170902dac100b001a674f6fa92mr638545plx.19.1692396822562; 
 Fri, 18 Aug 2023 15:13:42 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090322c700b001bdb85291casm2231417plg.208.2023.08.18.15.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 15:13:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 16/23] tcg/sparc64: Implement negsetcond_*
Date: Fri, 18 Aug 2023 15:13:20 -0700
Message-Id: <20230818221327.150194-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818221327.150194-1-richard.henderson@linaro.org>
References: <20230818221327.150194-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
 tcg/sparc64/tcg-target.h     |  4 ++--
 tcg/sparc64/tcg-target.c.inc | 36 ++++++++++++++++++++++++++----------
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/tcg/sparc64/tcg-target.h b/tcg/sparc64/tcg-target.h
index 1faadc704b..4bbd825bd8 100644
--- a/tcg/sparc64/tcg-target.h
+++ b/tcg/sparc64/tcg-target.h
@@ -112,7 +112,7 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_muls2_i32        1
 #define TCG_TARGET_HAS_muluh_i32        0
 #define TCG_TARGET_HAS_mulsh_i32        0
-#define TCG_TARGET_HAS_negsetcond_i32   0
+#define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_extrl_i64_i32    1
@@ -150,7 +150,7 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_muls2_i64        0
 #define TCG_TARGET_HAS_muluh_i64        use_vis3_instructions
 #define TCG_TARGET_HAS_mulsh_i64        0
-#define TCG_TARGET_HAS_negsetcond_i64   0
+#define TCG_TARGET_HAS_negsetcond_i64   1
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index ffcb879211..37839f9a21 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -720,7 +720,7 @@ static void tcg_out_movcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
 }
 
 static void tcg_out_setcond_i32(TCGContext *s, TCGCond cond, TCGReg ret,
-                                TCGReg c1, int32_t c2, int c2const)
+                                TCGReg c1, int32_t c2, int c2const, bool neg)
 {
     /* For 32-bit comparisons, we can play games with ADDC/SUBC.  */
     switch (cond) {
@@ -760,22 +760,30 @@ static void tcg_out_setcond_i32(TCGContext *s, TCGCond cond, TCGReg ret,
     default:
         tcg_out_cmp(s, c1, c2, c2const);
         tcg_out_movi_s13(s, ret, 0);
-        tcg_out_movcc(s, cond, MOVCC_ICC, ret, 1, 1);
+        tcg_out_movcc(s, cond, MOVCC_ICC, ret, neg ? -1 : 1, 1);
         return;
     }
 
     tcg_out_cmp(s, c1, c2, c2const);
     if (cond == TCG_COND_LTU) {
-        tcg_out_arithi(s, ret, TCG_REG_G0, 0, ARITH_ADDC);
+        if (neg) {
+            tcg_out_arithi(s, ret, TCG_REG_G0, 0, ARITH_SUBC);
+        } else {
+            tcg_out_arithi(s, ret, TCG_REG_G0, 0, ARITH_ADDC);
+        }
     } else {
-        tcg_out_arithi(s, ret, TCG_REG_G0, -1, ARITH_SUBC);
+        if (neg) {
+            tcg_out_arithi(s, ret, TCG_REG_G0, -1, ARITH_ADDC);
+        } else {
+            tcg_out_arithi(s, ret, TCG_REG_G0, -1, ARITH_SUBC);
+        }
     }
 }
 
 static void tcg_out_setcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
-                                TCGReg c1, int32_t c2, int c2const)
+                                TCGReg c1, int32_t c2, int c2const, bool neg)
 {
-    if (use_vis3_instructions) {
+    if (use_vis3_instructions && !neg) {
         switch (cond) {
         case TCG_COND_NE:
             if (c2 != 0) {
@@ -796,11 +804,11 @@ static void tcg_out_setcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
        if the input does not overlap the output.  */
     if (c2 == 0 && !is_unsigned_cond(cond) && c1 != ret) {
         tcg_out_movi_s13(s, ret, 0);
-        tcg_out_movr(s, cond, ret, c1, 1, 1);
+        tcg_out_movr(s, cond, ret, c1, neg ? -1 : 1, 1);
     } else {
         tcg_out_cmp(s, c1, c2, c2const);
         tcg_out_movi_s13(s, ret, 0);
-        tcg_out_movcc(s, cond, MOVCC_XCC, ret, 1, 1);
+        tcg_out_movcc(s, cond, MOVCC_XCC, ret, neg ? -1 : 1, 1);
     }
 }
 
@@ -1355,7 +1363,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_brcond_i32(s, a2, a0, a1, const_args[1], arg_label(args[3]));
         break;
     case INDEX_op_setcond_i32:
-        tcg_out_setcond_i32(s, args[3], a0, a1, a2, c2);
+        tcg_out_setcond_i32(s, args[3], a0, a1, a2, c2, false);
+        break;
+    case INDEX_op_negsetcond_i32:
+        tcg_out_setcond_i32(s, args[3], a0, a1, a2, c2, true);
         break;
     case INDEX_op_movcond_i32:
         tcg_out_movcond_i32(s, args[5], a0, a1, a2, c2, args[3], const_args[3]);
@@ -1437,7 +1448,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_brcond_i64(s, a2, a0, a1, const_args[1], arg_label(args[3]));
         break;
     case INDEX_op_setcond_i64:
-        tcg_out_setcond_i64(s, args[3], a0, a1, a2, c2);
+        tcg_out_setcond_i64(s, args[3], a0, a1, a2, c2, false);
+        break;
+    case INDEX_op_negsetcond_i64:
+        tcg_out_setcond_i64(s, args[3], a0, a1, a2, c2, true);
         break;
     case INDEX_op_movcond_i64:
         tcg_out_movcond_i64(s, args[5], a0, a1, a2, c2, args[3], const_args[3]);
@@ -1564,6 +1578,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_sar_i64:
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
+    case INDEX_op_negsetcond_i32:
+    case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, rZ, rJ);
 
     case INDEX_op_brcond_i32:
-- 
2.34.1


