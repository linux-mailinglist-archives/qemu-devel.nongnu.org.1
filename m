Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C25DA781540
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 00:15:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX7j8-00056r-DU; Fri, 18 Aug 2023 18:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7j5-00055a-RZ
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:51 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7j3-0004R7-Bk
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:51 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bdcb800594so11418025ad.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 15:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692396828; x=1693001628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rHihCY1+Gt7MEUwLK92P49s3A0ddHA08RG6gNlnoj30=;
 b=ba7RNMYIvduUi8SHzWAz2qNIlDnXVwp26F0eaVcrEXr9tsYKXJVtI1OXaSG/O7qOHw
 q0qxYQRvbsGY/ySYLwbG/YobI8qo0+Dg7Jfc6K5UNwCbz5SBwUiLMXlJ2Y5F4m7TW44S
 gDYx0cWXjgvjAsgkkg6QAIeeFjmYG6r1x05PsTmpKtbULGm57QrcIOkRmXnHiTvGsLuZ
 Ei4Zdm4tuRy4B8groxcARrM24SNJ7n3GhiljjBGTeH3z1TTPrix8oO9IFQkTS3FncRkU
 JoHtdh1i5CXgNKdRDvySAeYa6GHrUYFWxtDu5KwoiBGziy7vNdCJ4XRV8VU7yzQY86ke
 KPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692396828; x=1693001628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rHihCY1+Gt7MEUwLK92P49s3A0ddHA08RG6gNlnoj30=;
 b=LTiDugyEkoQ6ToV5fnzA+SAnTtpeRfTw8hIMQx3cvOFNOGCxFtVSqc8Se0X0rBU1Fe
 UCOiUcVi7lrtI8+11JHtc3smGa/2UDi1MeOtYNYUWQsp8jSmIbHlsSQ51bmOZVX6Xm0s
 10wlNdW5bWguzAzwCkqO5tF3LM6NZQsoFzevZ9tzJop3TNRq4dUV8mHvWI5/JmSGERre
 OkOg4EuMBzscEYTlBD4RJdJqHcwzPNmUJKpMf9StgSoEZoi79wjYCrlP3L/jaGZShAkl
 sICMCTP9LdJ4en3FjN5hvOxxxatmHMCwnhLV27OvNcZlgevPsJsoLBg8seuQd8ns+HA7
 U/kg==
X-Gm-Message-State: AOJu0Yx3i+kiPnySi4k6nyQWAq4T4Kifo9bksz4Ug3XpIPaPJeaKfN8T
 i7ela87mpPR7DAeCT26Apm6dqXwVUR+m8EE3gmE=
X-Google-Smtp-Source: AGHT+IGGjKTalAWb/03wRCHS1YW7KZEfXX8lVTNlzbAY1UkPvAnnCx23PVXbYy8T2hsgWfysMvH0sw==
X-Received: by 2002:a17:903:2589:b0:1bd:aebc:134f with SMTP id
 jb9-20020a170903258900b001bdaebc134fmr432659plb.13.1692396828153; 
 Fri, 18 Aug 2023 15:13:48 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090322c700b001bdb85291casm2231417plg.208.2023.08.18.15.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 15:13:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 23/23] tcg/i386: Implement negsetcond_*
Date: Fri, 18 Aug 2023 15:13:27 -0700
Message-Id: <20230818221327.150194-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818221327.150194-1-richard.henderson@linaro.org>
References: <20230818221327.150194-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
 tcg/i386/tcg-target.c.inc | 27 +++++++++++++++++++--------
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index f3cdc6927a..efc5ff8f9d 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -156,7 +156,7 @@ typedef enum {
 #define TCG_TARGET_HAS_muls2_i32        1
 #define TCG_TARGET_HAS_muluh_i32        0
 #define TCG_TARGET_HAS_mulsh_i32        0
-#define TCG_TARGET_HAS_negsetcond_i32   0
+#define TCG_TARGET_HAS_negsetcond_i32   1
 
 #if TCG_TARGET_REG_BITS == 64
 /* Keep 32-bit values zero-extended in a register.  */
@@ -194,7 +194,7 @@ typedef enum {
 #define TCG_TARGET_HAS_muls2_i64        1
 #define TCG_TARGET_HAS_muluh_i64        0
 #define TCG_TARGET_HAS_mulsh_i64        0
-#define TCG_TARGET_HAS_negsetcond_i64   0
+#define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 #else
 #define TCG_TARGET_HAS_qemu_st8_i32     1
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 16e830051d..e778dc642f 100644
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
@@ -1570,11 +1570,13 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
          * This is always smaller than the SETCC expansion.
          */
         tcg_out_cmp(s, arg1, arg2, const_arg2, rexw);
-        tgen_arithr(s, ARITH_SBB, dest, dest);              /* T:-1 F:0 */
-        if (inv) {
-            tgen_arithi(s, ARITH_ADD, dest, 1, 0);          /* T:0  F:1 */
-        } else {
-            tcg_out_modrm(s, OPC_GRP3_Ev, EXT3_NEG, dest);  /* T:1  F:0 */
+        tgen_arithr(s, ARITH_SBB + (neg ? rexw : 0), dest, dest); /* T:-1 F:0 */
+        if (inv && neg) {
+            tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_NOT, dest); /* T:0 F:-1 */
+        } else if (inv) {
+            tgen_arithi(s, ARITH_ADD, dest, 1, 0);                /* T:0  F:1 */
+        } else if (!neg) {
+            tcg_out_modrm(s, OPC_GRP3_Ev, EXT3_NEG, dest);        /* T:1  F:0 */
         }
         return;
 
@@ -1588,7 +1590,8 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
             if (inv) {
                 tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_NOT, dest);
             }
-            tcg_out_shifti(s, SHIFT_SHR + rexw, dest, rexw ? 63 : 31);
+            tcg_out_shifti(s, (neg ? SHIFT_SAR : SHIFT_SHR) + rexw,
+                           dest, rexw ? 63 : 31);
             return;
         }
         break;
@@ -1614,6 +1617,9 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
     if (!cleared) {
         tcg_out_ext8u(s, dest, dest);
     }
+    if (neg) {
+        tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_NEG, dest);
+    }
 }
 
 #if TCG_TARGET_REG_BITS == 32
@@ -2632,7 +2638,10 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
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
@@ -3377,6 +3386,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
+    case INDEX_op_negsetcond_i32:
+    case INDEX_op_negsetcond_i64:
         return C_O1_I2(q, r, re);
 
     case INDEX_op_movcond_i32:
-- 
2.34.1


