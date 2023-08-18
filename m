Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0F0781546
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 00:15:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX7j2-00052z-Rt; Fri, 18 Aug 2023 18:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7j1-00051t-EU
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:47 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7iy-0004Pa-OA
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:47 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68879c4cadeso1190409b3a.2
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 15:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692396823; x=1693001623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rwaiAtYClnFVQIjVXpnnVfvxmL8NPXxhbpjMxaInfSQ=;
 b=q+XZkk/rHzIycmsIHi8X8UtWWLz6z/44oekhBWOZkszQbQvHS5UuGm8fGQ8W6aUKXd
 mbC+ntFmbnrGLxaLRtab22ccvNT7qaFeZRI53iXEO3+ADaNVU0/GeTPv9EklWy7ELH99
 cuPSpF61+Jiq6ImUnzo4lsbSnwYuL7BvRIpBhHAbLj/wuJEAuddlSraShc5Jlpdg5H56
 DxP0afJa+o9CaFoCd1BXnzvH8inep11ZMEzRP2hZ9+FKLa9dn2Y+miudF0X3Ohpyr5fq
 m9A007KRgEE4WJbimHCNoDFXJt/OuVVk4CFnE9GjQJtFChNACNjnVP+WuowyQyR1ylUj
 0K0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692396823; x=1693001623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rwaiAtYClnFVQIjVXpnnVfvxmL8NPXxhbpjMxaInfSQ=;
 b=FIcRh3pU4cb4v0JMySuyyJNFoD20z38ezd3VvnQGtv8KwrXHaFxOMWUWeMHw2RJRkf
 Asf7RYa+4/kqNWWjB7qGOh3N42AIGdf2fLUDzpiYnDKtabtTB/IIhf4ZfHFklJM0ivmk
 kBVWm30/Jmj4icpYpuSDfaGOrzuXBSAH60uf1jO55v2Xck4SKZ7rnCKzaBecJcUoFN7q
 ZMWwusdthhSQYrVHDpPd9Jm4LbuIUAVwQap517Oc7ofqjUjoqybwuSRSmQA+ofO2xn9b
 75jSrc/yl4TOK3kU2pnrAPVSIG1R5AKBnRHYqNk65pwF4ixrAmpcENbSQWIdfHp2b3uI
 cN0w==
X-Gm-Message-State: AOJu0Yx+Let6ecwngRKEaoTyGgRaVV4pIA4e0eO8t1g3X4PS775jXdyY
 ubEt2ETwNYKK2FwfDfZNXlrLo6Y/TxHL9uMQPCc=
X-Google-Smtp-Source: AGHT+IGYVXzC64bjqmor/ConGqaoZzpxr9wZCFsHNcvvd3Sak8NPbVSXcwdxSwMNKi9WlOc51ayrBg==
X-Received: by 2002:a05:6a20:7da2:b0:12f:c0c1:d70 with SMTP id
 v34-20020a056a207da200b0012fc0c10d70mr638274pzj.40.1692396823479; 
 Fri, 18 Aug 2023 15:13:43 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090322c700b001bdb85291casm2231417plg.208.2023.08.18.15.13.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 15:13:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 17/23] tcg/i386: Merge tcg_out_brcond{32,64}
Date: Fri, 18 Aug 2023 15:13:21 -0700
Message-Id: <20230818221327.150194-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818221327.150194-1-richard.henderson@linaro.org>
References: <20230818221327.150194-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Pass a rexw parameter instead of duplicating the functions.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 110 +++++++++++++++++---------------------
 1 file changed, 49 insertions(+), 61 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 3045b56002..33f66ba204 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1436,99 +1436,89 @@ static void tcg_out_cmp(TCGContext *s, TCGArg arg1, TCGArg arg2,
     }
 }
 
-static void tcg_out_brcond32(TCGContext *s, TCGCond cond,
-                             TCGArg arg1, TCGArg arg2, int const_arg2,
-                             TCGLabel *label, int small)
+static void tcg_out_brcond(TCGContext *s, int rexw, TCGCond cond,
+                           TCGArg arg1, TCGArg arg2, int const_arg2,
+                           TCGLabel *label, bool small)
 {
-    tcg_out_cmp(s, arg1, arg2, const_arg2, 0);
+    tcg_out_cmp(s, arg1, arg2, const_arg2, rexw);
     tcg_out_jxx(s, tcg_cond_to_jcc[cond], label, small);
 }
 
-#if TCG_TARGET_REG_BITS == 64
-static void tcg_out_brcond64(TCGContext *s, TCGCond cond,
-                             TCGArg arg1, TCGArg arg2, int const_arg2,
-                             TCGLabel *label, int small)
-{
-    tcg_out_cmp(s, arg1, arg2, const_arg2, P_REXW);
-    tcg_out_jxx(s, tcg_cond_to_jcc[cond], label, small);
-}
-#else
-/* XXX: we implement it at the target level to avoid having to
-   handle cross basic blocks temporaries */
+#if TCG_TARGET_REG_BITS == 32
 static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
-                            const int *const_args, int small)
+                            const int *const_args, bool small)
 {
     TCGLabel *label_next = gen_new_label();
     TCGLabel *label_this = arg_label(args[5]);
 
     switch(args[4]) {
     case TCG_COND_EQ:
-        tcg_out_brcond32(s, TCG_COND_NE, args[0], args[2], const_args[2],
-                         label_next, 1);
-        tcg_out_brcond32(s, TCG_COND_EQ, args[1], args[3], const_args[3],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_NE, args[0], args[2], const_args[2],
+                       label_next, 1);
+        tcg_out_brcond(s, 0, TCG_COND_EQ, args[1], args[3], const_args[3],
+                       label_this, small);
         break;
     case TCG_COND_NE:
-        tcg_out_brcond32(s, TCG_COND_NE, args[0], args[2], const_args[2],
-                         label_this, small);
-        tcg_out_brcond32(s, TCG_COND_NE, args[1], args[3], const_args[3],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_NE, args[0], args[2], const_args[2],
+                       label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_NE, args[1], args[3], const_args[3],
+                       label_this, small);
         break;
     case TCG_COND_LT:
-        tcg_out_brcond32(s, TCG_COND_LT, args[1], args[3], const_args[3],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_LT, args[1], args[3], const_args[3],
+                       label_this, small);
         tcg_out_jxx(s, JCC_JNE, label_next, 1);
-        tcg_out_brcond32(s, TCG_COND_LTU, args[0], args[2], const_args[2],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_LTU, args[0], args[2], const_args[2],
+                       label_this, small);
         break;
     case TCG_COND_LE:
-        tcg_out_brcond32(s, TCG_COND_LT, args[1], args[3], const_args[3],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_LT, args[1], args[3], const_args[3],
+                       label_this, small);
         tcg_out_jxx(s, JCC_JNE, label_next, 1);
-        tcg_out_brcond32(s, TCG_COND_LEU, args[0], args[2], const_args[2],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_LEU, args[0], args[2], const_args[2],
+                       label_this, small);
         break;
     case TCG_COND_GT:
-        tcg_out_brcond32(s, TCG_COND_GT, args[1], args[3], const_args[3],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_GT, args[1], args[3], const_args[3],
+                       label_this, small);
         tcg_out_jxx(s, JCC_JNE, label_next, 1);
-        tcg_out_brcond32(s, TCG_COND_GTU, args[0], args[2], const_args[2],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_GTU, args[0], args[2], const_args[2],
+                       label_this, small);
         break;
     case TCG_COND_GE:
-        tcg_out_brcond32(s, TCG_COND_GT, args[1], args[3], const_args[3],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_GT, args[1], args[3], const_args[3],
+                       label_this, small);
         tcg_out_jxx(s, JCC_JNE, label_next, 1);
-        tcg_out_brcond32(s, TCG_COND_GEU, args[0], args[2], const_args[2],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_GEU, args[0], args[2], const_args[2],
+                       label_this, small);
         break;
     case TCG_COND_LTU:
-        tcg_out_brcond32(s, TCG_COND_LTU, args[1], args[3], const_args[3],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_LTU, args[1], args[3], const_args[3],
+                       label_this, small);
         tcg_out_jxx(s, JCC_JNE, label_next, 1);
-        tcg_out_brcond32(s, TCG_COND_LTU, args[0], args[2], const_args[2],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_LTU, args[0], args[2], const_args[2],
+                       label_this, small);
         break;
     case TCG_COND_LEU:
-        tcg_out_brcond32(s, TCG_COND_LTU, args[1], args[3], const_args[3],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_LTU, args[1], args[3], const_args[3],
+                       label_this, small);
         tcg_out_jxx(s, JCC_JNE, label_next, 1);
-        tcg_out_brcond32(s, TCG_COND_LEU, args[0], args[2], const_args[2],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_LEU, args[0], args[2], const_args[2],
+                       label_this, small);
         break;
     case TCG_COND_GTU:
-        tcg_out_brcond32(s, TCG_COND_GTU, args[1], args[3], const_args[3],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_GTU, args[1], args[3], const_args[3],
+                       label_this, small);
         tcg_out_jxx(s, JCC_JNE, label_next, 1);
-        tcg_out_brcond32(s, TCG_COND_GTU, args[0], args[2], const_args[2],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_GTU, args[0], args[2], const_args[2],
+                       label_this, small);
         break;
     case TCG_COND_GEU:
-        tcg_out_brcond32(s, TCG_COND_GTU, args[1], args[3], const_args[3],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_GTU, args[1], args[3], const_args[3],
+                       label_this, small);
         tcg_out_jxx(s, JCC_JNE, label_next, 1);
-        tcg_out_brcond32(s, TCG_COND_GEU, args[0], args[2], const_args[2],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_GEU, args[0], args[2], const_args[2],
+                       label_this, small);
         break;
     default:
         g_assert_not_reached();
@@ -2574,8 +2564,9 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_modrm(s, OPC_POPCNT + rexw, a0, a1);
         break;
 
-    case INDEX_op_brcond_i32:
-        tcg_out_brcond32(s, a2, a0, a1, const_args[1], arg_label(args[3]), 0);
+    OP_32_64(brcond):
+        tcg_out_brcond(s, rexw, a2, a0, a1, const_args[1],
+                       arg_label(args[3]), 0);
         break;
     case INDEX_op_setcond_i32:
         tcg_out_setcond32(s, args[3], a0, a1, a2, const_a2);
@@ -2730,9 +2721,6 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
-    case INDEX_op_brcond_i64:
-        tcg_out_brcond64(s, a2, a0, a1, const_args[1], arg_label(args[3]), 0);
-        break;
     case INDEX_op_setcond_i64:
         tcg_out_setcond64(s, args[3], a0, a1, a2, const_a2);
         break;
-- 
2.34.1


