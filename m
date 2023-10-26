Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C17F67D7946
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:22:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo6F-0000tx-5X; Wed, 25 Oct 2023 20:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo5y-0000oN-BO
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:31 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo5s-0006bH-67
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:30 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c434c33ec0so2284665ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279563; x=1698884363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1RxoerkT+NW6NNN31T+6nx4K1n73GgW/XA4Cu7hakcY=;
 b=wU9LH+couZfWkzvfoVy4rXoiUqeBErKRRxNREIvmtqjLgc/TNYbS3qDJJzyufyAe1N
 PDQjGzTBJsSH8xsswscGRv/FoBTYFn1DeJuFShVUe2zcauHYgV/kPVpXBZInZv+12MqO
 wLJN7glcsBnnN8Uc3SDnBkCsBqRHvMPsmvF+4YFnO96iy6a4HqitBimuJnAp493eFd5s
 w1mGjysgi8MYk/NjhqxJVJ65PrLas8VSss2taawE6TwV/jOqKjcAKsfy9Oh5KzQdtlTd
 Sf/kKvwbSM9jWSUFqSMOPW9YviCUkJJPHGTfQSIyJmgedHzz7Bx1F07LhKMqKdtzTiaj
 e1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279563; x=1698884363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1RxoerkT+NW6NNN31T+6nx4K1n73GgW/XA4Cu7hakcY=;
 b=iZigFnxrqnP+7jUMRRURIP3HBU7ouZiveNsXvqCNGl15eU8yS59IdT3g8abPR6hUyv
 Ayw/jbAOIbk1K+EcN2HvFMXuDDM+N2F74ACPtQGslzNwdQkTnDfzDxgQqKFNY7MklYGm
 f/80Mtw3GA5Z+3Pv6RY8sRJQt62ButMR8f1p4JrYFbL53l+iU9elprgs5eEJU0NqRgaB
 gJdeSJ9emGlLo2snqMoCOCDVmpJETTycuXnlUajx6++6U2AFVVyBY0YEGZ7AF2nG1QQa
 KaDs0wLBOPqRGnA0ezL8QOmo5fwLjyq+dKTyW7LTxLGP5vzTHq/U44XLX7XE/N6pGP8A
 38/A==
X-Gm-Message-State: AOJu0YwfjLyHwEE28sfBoCb6bBRCZ12/nhtExvxRbrpjTjSuvbmUnw7j
 Hob8X2QcILvJpSfcmqC3vYWDs4GwlmWAUIOG8O8=
X-Google-Smtp-Source: AGHT+IFDGKyl0sLRb1S4IjEkiXsDYS2HHiY82rE6ju0s5SjLNT0nZ851EXrOZzrKNc0x+Spj+O4szQ==
X-Received: by 2002:a17:902:d48f:b0:1c9:dff6:58e8 with SMTP id
 c15-20020a170902d48f00b001c9dff658e8mr14737692plg.54.1698279562675; 
 Wed, 25 Oct 2023 17:19:22 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jh1-20020a170903328100b001c5fc291ef9sm9754655plb.209.2023.10.25.17.19.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:19:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 23/29] tcg/ppc: Create tcg_out_and_rc
Date: Wed, 25 Oct 2023 17:14:25 -0700
Message-Id: <20231026001542.1141412-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Merge tcg_out_andi32, tcg_out_andi64, and code to handle
two register inputs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 86 +++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 46 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 3c2ec4db4b..fe141a26f9 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -1363,44 +1363,44 @@ static bool mask64_operand(uint64_t c, int *mb, int *me)
     return false;
 }
 
-static void tcg_out_andi32(TCGContext *s, TCGReg dst, TCGReg src, uint32_t c)
+static void tcg_out_and_rc(TCGContext *s, TCGType type, TCGReg dst,
+                           TCGReg arg1, TCGArg arg2, bool const_arg2, bool rc)
 {
-    int mb, me;
-
-    if (mask_operand(c, &mb, &me)) {
-        tcg_out_rlw(s, RLWINM, dst, src, 0, mb, me);
-    } else if ((c & 0xffff) == c) {
-        tcg_out32(s, ANDI | SAI(src, dst, c));
+    if (!const_arg2) {
+        tcg_out32(s, AND | SAB(arg1, dst, arg2) | rc);
         return;
-    } else if ((c & 0xffff0000) == c) {
-        tcg_out32(s, ANDIS | SAI(src, dst, c >> 16));
-        return;
-    } else {
-        tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_R0, c);
-        tcg_out32(s, AND | SAB(src, dst, TCG_REG_R0));
     }
-}
 
-static void tcg_out_andi64(TCGContext *s, TCGReg dst, TCGReg src, uint64_t c)
-{
-    int mb, me;
+    if (!rc) {
+        int mb, me;
 
-    tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
-    if (mask64_operand(c, &mb, &me)) {
-        if (mb == 0) {
-            tcg_out_rld(s, RLDICR, dst, src, 0, me);
+        if (TCG_TARGET_REG_BITS == 32 || type == TCG_TYPE_I32) {
+            if (mask_operand(arg2, &mb, &me)) {
+                tcg_out_rlw(s, RLWINM, dst, arg1, 0, mb, me);
+                return;
+            }
         } else {
-            tcg_out_rld(s, RLDICL, dst, src, 0, mb);
+            if (mask64_operand(arg2, &mb, &me)) {
+                if (mb == 0) {
+                    tcg_out_rld(s, RLDICR, dst, arg1, 0, me);
+                } else {
+                    tcg_out_rld(s, RLDICL, dst, arg1, 0, mb);
+                }
+                return;
+            }
         }
-    } else if ((c & 0xffff) == c) {
-        tcg_out32(s, ANDI | SAI(src, dst, c));
-        return;
-    } else if ((c & 0xffff0000) == c) {
-        tcg_out32(s, ANDIS | SAI(src, dst, c >> 16));
-        return;
+    }
+
+    if (type == TCG_TYPE_I32) {
+        arg2 = (uint32_t)arg2;
+    }
+    if ((arg2 & 0xffff) == arg2) {
+        tcg_out32(s, ANDI | SAI(arg1, dst, arg2));
+    } else if ((arg2 & 0xffff0000u) == arg2) {
+        tcg_out32(s, ANDIS | SAI(arg1, dst, arg2 >> 16));
     } else {
-        tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_R0, c);
-        tcg_out32(s, AND | SAB(src, dst, TCG_REG_R0));
+        tcg_out_movi(s, type, TCG_REG_R0, arg2);
+        tcg_out32(s, AND | SAB(arg1, dst, TCG_REG_R0) | rc);
     }
 }
 
@@ -2892,20 +2892,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
 
     case INDEX_op_and_i32:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_andi32(s, a0, a1, a2);
-        } else {
-            tcg_out32(s, AND | SAB(a1, a0, a2));
-        }
+        tcg_out_and_rc(s, TCG_TYPE_I32, args[0], args[1],
+                       args[2], const_args[2], false);
         break;
     case INDEX_op_and_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_andi64(s, a0, a1, a2);
-        } else {
-            tcg_out32(s, AND | SAB(a1, a0, a2));
-        }
+        tcg_out_and_rc(s, TCG_TYPE_I64, args[0], args[1],
+                       args[2], const_args[2], false);
         break;
     case INDEX_op_or_i64:
     case INDEX_op_or_i32:
@@ -2928,7 +2920,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_andc_i32:
         a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
-            tcg_out_andi32(s, a0, a1, ~a2);
+            tcg_out_and_rc(s, TCG_TYPE_I32, a0, a1, ~a2, true, false);
         } else {
             tcg_out32(s, ANDC | SAB(a1, a0, a2));
         }
@@ -2936,7 +2928,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_andc_i64:
         a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
-            tcg_out_andi64(s, a0, a1, ~a2);
+            tcg_out_and_rc(s, TCG_TYPE_I64, a0, a1, ~a2, true, false);
         } else {
             tcg_out32(s, ANDC | SAB(a1, a0, a2));
         }
@@ -3270,7 +3262,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_deposit_i32:
         if (const_args[2]) {
             uint32_t mask = ((2u << (args[4] - 1)) - 1) << args[3];
-            tcg_out_andi32(s, args[0], args[0], ~mask);
+            tcg_out_and_rc(s, TCG_TYPE_I32, args[0], args[0],
+                           ~mask, true, false);
         } else {
             tcg_out_rlw(s, RLWIMI, args[0], args[2], args[3],
                         32 - args[3] - args[4], 31 - args[3]);
@@ -3279,7 +3272,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_deposit_i64:
         if (const_args[2]) {
             uint64_t mask = ((2ull << (args[4] - 1)) - 1) << args[3];
-            tcg_out_andi64(s, args[0], args[0], ~mask);
+            tcg_out_and_rc(s, TCG_TYPE_I64, args[0], args[0],
+                           ~mask, true, false);
         } else {
             tcg_out_rld(s, RLDIMI, args[0], args[2], args[3],
                         64 - args[3] - args[4]);
-- 
2.34.1


