Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A21786170
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:27:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOm-0000W0-5C; Wed, 23 Aug 2023 16:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOd-00005k-KM
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:07 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOa-0005ZK-SD
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:06 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bee82fad0fso40070915ad.2
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822243; x=1693427043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wG5QxLCPCygmOeXAqyBKDVStp+bJY2vk6G2jyk8UbZc=;
 b=L+hu/WKPxmVg5yhileK3dC+nPTEDqBlf+uzVMwmvJdxVn0KUFNqw3qFJrNgREWaegn
 4V5ysGeXh4C1bKGaybyRZ6xQHQNsJGF7ErDy/iwlf5RsaMI8SIr0Ozy6D6ZaQnLxSJtm
 fN+eNDVBuusk86gcAiTtmAiAvPNVpThSygSBCD7nbvgWSGxKgT7QYEZGkhnPMRn+Fzow
 pVniUczsOc4jLcbzHS+vZeVwiVF6/uw+KSdzy2gU1xu+6nGgkaHhGV7c364bwwWczixe
 qK7sfnFsOvIsMbNbPPT18wNfcIIE6rZsyMF+OeroqJa+5VOfDbzjv9h/9TAW3eHr4LEI
 YIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822243; x=1693427043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wG5QxLCPCygmOeXAqyBKDVStp+bJY2vk6G2jyk8UbZc=;
 b=Ko4jvWsDJQJ3rJTG9amIzeY7NPwKIN99wmUQFJrtE7qbU1DIGGAHpxmYHDJ3EE4YGE
 v1S7MUK9R3yZ4tivzmOaepPr0ZdOBQaMLUFeaVtIWAbvZgx/UsDHqgROyoIwZ7/afWmn
 IRhI41jXr+o8RIbQUEcgwTNqwS3XUElnaH28FPt4Sovb/ZQHhLCS9Jlh0NUqFDbXmr72
 49TDBLz1TU8iiEjgQ6jkygaW9aRvNreXgcqp/6nAdpsZuKXRtk/kXEwiY62wQliFL/zB
 Ax0W9V2n3Qq0lXZSDpgTpk4EnppVzpI7t97c97cJGIEq2iWe+rz1JGWYRQ1ECEm4MZ+Q
 1vhw==
X-Gm-Message-State: AOJu0Yx5YlCaK5Rjx01FkpmQAKpeP+lz+NZzS8vFzQjwJMdN4nZl//Bj
 POfZHN5Hr4npSSkZTqavREYoe2rbD6VhJre8zDs=
X-Google-Smtp-Source: AGHT+IGIRgcd3Zg1OnDFR8PBqOV8704Vwnjic7aPRWxZeiJsRcPiSsW2P1UE/vSozcOU7TTOJPpGUQ==
X-Received: by 2002:a17:902:b582:b0:1b9:e591:db38 with SMTP id
 a2-20020a170902b58200b001b9e591db38mr10239624pls.8.1692822242814; 
 Wed, 23 Aug 2023 13:24:02 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:24:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 38/48] tcg/i386: Implement negsetcond_*
Date: Wed, 23 Aug 2023 13:23:16 -0700
Message-Id: <20230823202326.1353645-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
 tcg/i386/tcg-target.h     |  4 ++--
 tcg/i386/tcg-target.c.inc | 32 ++++++++++++++++++++++++--------
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index ebc0b1a6ce..8417ea4899 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -150,7 +150,7 @@ typedef enum {
 #define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_movcond_i32      1
-#define TCG_TARGET_HAS_negsetcond_i32   0
+#define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
 #define TCG_TARGET_HAS_mulu2_i32        1
@@ -187,7 +187,7 @@ typedef enum {
 #define TCG_TARGET_HAS_sextract_i64     0
 #define TCG_TARGET_HAS_extract2_i64     1
 #define TCG_TARGET_HAS_movcond_i64      1
-#define TCG_TARGET_HAS_negsetcond_i64   0
+#define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
 #define TCG_TARGET_HAS_mulu2_i64        1
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 16e830051d..0c3d1e4cef 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1529,7 +1529,7 @@ static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
 
 static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
                             TCGArg dest, TCGArg arg1, TCGArg arg2,
-                            int const_arg2)
+                            int const_arg2, bool neg)
 {
     bool inv = false;
     bool cleared;
@@ -1570,11 +1570,18 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
          * This is always smaller than the SETCC expansion.
          */
         tcg_out_cmp(s, arg1, arg2, const_arg2, rexw);
-        tgen_arithr(s, ARITH_SBB, dest, dest);              /* T:-1 F:0 */
-        if (inv) {
-            tgen_arithi(s, ARITH_ADD, dest, 1, 0);          /* T:0  F:1 */
-        } else {
-            tcg_out_modrm(s, OPC_GRP3_Ev, EXT3_NEG, dest);  /* T:1  F:0 */
+
+        /* X - X - C = -C = (C ? -1 : 0) */
+        tgen_arithr(s, ARITH_SBB + (neg ? rexw : 0), dest, dest);
+        if (inv && neg) {
+            /* ~(C ? -1 : 0) = (C ? 0 : -1) */
+            tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_NOT, dest);
+        } else if (inv) {
+            /* (C ? -1 : 0) + 1 = (C ? 0 : 1) */
+            tgen_arithi(s, ARITH_ADD, dest, 1, 0);
+        } else if (!neg) {
+            /* -(C ? -1 : 0) = (C ? 1 : 0) */
+            tcg_out_modrm(s, OPC_GRP3_Ev, EXT3_NEG, dest);
         }
         return;
 
@@ -1588,7 +1595,8 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
             if (inv) {
                 tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_NOT, dest);
             }
-            tcg_out_shifti(s, SHIFT_SHR + rexw, dest, rexw ? 63 : 31);
+            tcg_out_shifti(s, (neg ? SHIFT_SAR : SHIFT_SHR) + rexw,
+                           dest, rexw ? 63 : 31);
             return;
         }
         break;
@@ -1614,6 +1622,9 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
     if (!cleared) {
         tcg_out_ext8u(s, dest, dest);
     }
+    if (neg) {
+        tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_NEG, dest);
+    }
 }
 
 #if TCG_TARGET_REG_BITS == 32
@@ -2632,7 +2643,10 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
                        arg_label(args[3]), 0);
         break;
     OP_32_64(setcond):
-        tcg_out_setcond(s, rexw, args[3], a0, a1, a2, const_a2);
+        tcg_out_setcond(s, rexw, args[3], a0, a1, a2, const_a2, false);
+        break;
+    OP_32_64(negsetcond):
+        tcg_out_setcond(s, rexw, args[3], a0, a1, a2, const_a2, true);
         break;
     OP_32_64(movcond):
         tcg_out_movcond(s, rexw, args[5], a0, a1, a2, const_a2, args[3]);
@@ -3377,6 +3391,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
+    case INDEX_op_negsetcond_i32:
+    case INDEX_op_negsetcond_i64:
         return C_O1_I2(q, r, re);
 
     case INDEX_op_movcond_i32:
-- 
2.34.1


