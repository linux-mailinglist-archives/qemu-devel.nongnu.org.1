Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D92773772
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 05:14:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTD9d-0004Lk-SC; Mon, 07 Aug 2023 23:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTD90-0001nf-Cj
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:12:29 -0400
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTD8h-0000Ne-5p
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:12:26 -0400
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-765942d497fso423808685a.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 20:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691464326; x=1692069126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K5i2/ldl7oLGbxu7tue5+kLhhv2CxQ17wq9IIxK3hMA=;
 b=rq6GfIBSn8q26VHWWcVpOp63Z6yqUH7lxMNEzQzg5udClimbeV+FhXscctljZbSjpq
 x7sv3cOsnok6V8APwC/KF8DOr9ss6PSodi2UAP/76ne8XJkNYSUs/9F6quwj5Opcerdd
 a+IIgOvCs95RUy9gIHdiwxplnmeb3Hi3dB85JvL5Mgz8fcdkm4w7Acag6cpxCDVOC9Ls
 69eODX0DE5KDlPCiJTduWpWooFKR54qlPRP8ht5yxd5bMFbiyaBf/HiJRmqL6othTS0/
 y2Gm3aIzq9ftQIwNOGvFTVJP3X+nU0nhYq4INIITOIl0ns+nq4DNJ8oT5Rk7h4whRgwT
 GkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691464326; x=1692069126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K5i2/ldl7oLGbxu7tue5+kLhhv2CxQ17wq9IIxK3hMA=;
 b=PvlFc9eYqfukIqLI6gewYVONcdQybyI+FoF2RHz5YIPT740Z1Lu7iZhEUQ6t84LNww
 n4x9NnMNi8hNIDkaEXpE6+I3IwxesM9vqehmjZevJ7OuqzRHRgH4OatrCYK+/B7qJO5Q
 JSzgxrRXGsxZW3i3acZyX95XF46wt579LfTJssF88ovq7LIKV802P/hwi/8SG5o1ImNE
 EBReM+m2+Kjl206M5dMB9AsgvsflYxcvmiM9LWl+7cbTdh61qGkFErkZe34iz3VmDN2b
 sBClmUXB1iMkjzkBZbTyCZ116R6QSGNkNtcKUBOJmYTIkq32p4P0AvdA0vAoTFLaxJWk
 O1pw==
X-Gm-Message-State: AOJu0Yx0206iZT2E2yYz6R0OowvnjIg32tkCJYz8ODO/6KCd6riHazti
 wKY5k++rMNWJ5qfgiZMIwFF41Obb7lv5NZHs0eM=
X-Google-Smtp-Source: AGHT+IGb3tEfWoDCjBfBDsbI4zoPCneYvzOE+kaZWiJhh0UGMEZ3w1171PfNavDEzK6oPbWv4flx/Q==
X-Received: by 2002:a05:620a:450b:b0:76c:9cb6:fe0 with SMTP id
 t11-20020a05620a450b00b0076c9cb60fe0mr15624251qkp.61.1691464325836; 
 Mon, 07 Aug 2023 20:12:05 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 g64-20020a636b43000000b0055bf96b11d9sm5639087pgc.89.2023.08.07.20.12.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 20:12:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
Subject: [PATCH 24/24] tcg/i386: Implement negsetcond_*
Date: Mon,  7 Aug 2023 20:11:43 -0700
Message-Id: <20230808031143.50925-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808031143.50925-1-richard.henderson@linaro.org>
References: <20230808031143.50925-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72c.google.com
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
 tcg/i386/tcg-target.h     |  4 ++--
 tcg/i386/tcg-target.c.inc | 27 +++++++++++++++++++--------
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 41df0e5ae1..1a9025d786 100644
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
index f68722b8a5..cc75653bb8 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1526,7 +1526,7 @@ static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
 
 static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
                             TCGArg dest, TCGArg arg1, TCGArg arg2,
-                            int const_arg2)
+                            int const_arg2, bool neg)
 {
     bool inv = false;
     bool cleared;
@@ -1567,11 +1567,13 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
          * This is always smaller than the SETCC expansion.
          */
         tcg_out_cmp(s, rexw, arg1, arg2, const_arg2, true);
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
 
@@ -1585,7 +1587,8 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
             if (inv) {
                 tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_NOT, dest);
             }
-            tcg_out_shifti(s, SHIFT_SHR + rexw, dest, rexw ? 63 : 31);
+            tcg_out_shifti(s, (neg ? SHIFT_SAR : SHIFT_SHR) + rexw,
+                           dest, rexw ? 63 : 31);
             return;
         }
         break;
@@ -1611,6 +1614,9 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
     if (!cleared) {
         tcg_out_ext8u(s, dest, dest);
     }
+    if (neg) {
+        tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_NEG, dest);
+    }
 }
 
 #if TCG_TARGET_REG_BITS == 32
@@ -2629,7 +2635,10 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
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
@@ -3357,6 +3366,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
+    case INDEX_op_negsetcond_i32:
+    case INDEX_op_negsetcond_i64:
         return C_O1_I2(q, r, re);
 
     case INDEX_op_movcond_i32:
-- 
2.34.1


