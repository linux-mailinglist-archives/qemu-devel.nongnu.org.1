Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9DA7E3342
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:52:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0C9E-0008Hl-IA; Mon, 06 Nov 2023 21:49:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9C-0008GU-9s
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:48:58 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C99-0005rN-LZ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:48:58 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6b2018a11efso5352520b3a.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699325334; x=1699930134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2sloVrILa/y8th+MYnXLRzVd29BChrb1tBcv1TtA6mo=;
 b=MoK4ol1+4C7wNIDtdsQCuWnvDhR9Jaoq4S7Rb0RoQc/DR0p65xag8mwXNqokKBnx1k
 OmrYJbianrvzwfBEa3ohco6z3iBNg4PVzqsphD+LdZqtyIsvwkfOqRM1ccR4zx+cfWrQ
 1esh7Jdb1V6a4QO4QKW1R126AUn4RZOIUMXOuhB5X4jCmKgZXLam+hqaHRNYw0GWs08D
 Jd2CC7xq1xYm6aU3uERohdUbLGjNHUarDKWKDmMQjcFZMalXxfEvE2e3/AcS1IWrDN4u
 IgtvSrClGxdEJFm9zkO7oU5yDkTgctjBKE+UpbGVAMMCtURSz+XV/5TeLIWERi5XWaKh
 X+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699325334; x=1699930134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2sloVrILa/y8th+MYnXLRzVd29BChrb1tBcv1TtA6mo=;
 b=Ht+KVis4t+biIMnoq10glvpiiTec6NjOON8xjthinIV7IdaNWnnDUOK64wsMNsK7RV
 lg5J+C1cTYvu8qatYZJ+PFilUSWhlunAkMQERAr2010/F0Qz73bOGFwgr2G77X1CWmLq
 4A2x4Yw5nSugtIIvbQnMoH+AqYoZk9L6sxepmPnpXYTHOAcSLKUlgLYgCrNGGbi7Hk5x
 g5GOHoDnBfYjblzH6lT+CRkNxl5WtaSvBr0x9D0UP9BLqu847NybglyzE6p0R3gEaL1u
 2z4oOmg3sj2O7pHbPaXWjGGGd8E16exhV6K93v2EG2yiIdrt0YO4m+MaWRlrwrRM+4u9
 rM5g==
X-Gm-Message-State: AOJu0YycjmtI+f3j22i8qAT5sI6nWrdkRZMrlP+hvI9AVek92iW5qAjA
 3GM9aHeWu5m3G3pwPZ6qfwwd3JP9y3fXzWgJ92A=
X-Google-Smtp-Source: AGHT+IHU+wOi0QbCcya1dLxQB73At0G8V6Cp+ybrOi3yXOqaTMMH+Eag7ZqB/rFERPLigku2WDlk4g==
X-Received: by 2002:a05:6a21:3290:b0:17b:129b:196f with SMTP id
 yt16-20020a056a21329000b0017b129b196fmr37566397pzb.11.1699325334139; 
 Mon, 06 Nov 2023 18:48:54 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fn11-20020a056a002fcb00b006bff7c36fb3sm6367478pfb.95.2023.11.06.18.48.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:48:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/35] tcg: Move 64-bit expanders out of line
Date: Mon,  6 Nov 2023 18:48:20 -0800
Message-Id: <20231107024842.7650-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107024842.7650-1-richard.henderson@linaro.org>
References: <20231107024842.7650-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This one is more complicated, combining 32-bit and 64-bit
expansion with C if instead of preprocessor #if.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231029210848.78234-6-richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h | 144 +---------------------
 tcg/tcg-op.c                | 231 +++++++++++++++++++++++++-----------
 2 files changed, 169 insertions(+), 206 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index cdaa1415d1..f5ec54f874 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -305,130 +305,6 @@ void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in);
 
-#if TCG_TARGET_REG_BITS == 64
-static inline void tcg_gen_discard_i64(TCGv_i64 arg)
-{
-    tcg_gen_op1_i64(INDEX_op_discard, arg);
-}
-
-static inline void tcg_gen_mov_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    if (ret != arg) {
-        tcg_gen_op2_i64(INDEX_op_mov_i64, ret, arg);
-    }
-}
-
-static inline void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2,
-                                    tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_ld8u_i64, ret, arg2, offset);
-}
-
-static inline void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2,
-                                    tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_ld8s_i64, ret, arg2, offset);
-}
-
-static inline void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2,
-                                     tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_ld16u_i64, ret, arg2, offset);
-}
-
-static inline void tcg_gen_ld16s_i64(TCGv_i64 ret, TCGv_ptr arg2,
-                                     tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_ld16s_i64, ret, arg2, offset);
-}
-
-static inline void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2,
-                                     tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_ld32u_i64, ret, arg2, offset);
-}
-
-static inline void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2,
-                                     tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_ld32s_i64, ret, arg2, offset);
-}
-
-static inline void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2,
-                                  tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_ld_i64, ret, arg2, offset);
-}
-
-static inline void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2,
-                                   tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_st8_i64, arg1, arg2, offset);
-}
-
-static inline void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2,
-                                    tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_st16_i64, arg1, arg2, offset);
-}
-
-static inline void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2,
-                                    tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_st32_i64, arg1, arg2, offset);
-}
-
-static inline void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2,
-                                  tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_st_i64, arg1, arg2, offset);
-}
-
-static inline void tcg_gen_add_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_add_i64, ret, arg1, arg2);
-}
-
-static inline void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_sub_i64, ret, arg1, arg2);
-}
-
-static inline void tcg_gen_and_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_and_i64, ret, arg1, arg2);
-}
-
-static inline void tcg_gen_or_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_or_i64, ret, arg1, arg2);
-}
-
-static inline void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_xor_i64, ret, arg1, arg2);
-}
-
-static inline void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_shl_i64, ret, arg1, arg2);
-}
-
-static inline void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_shr_i64, ret, arg1, arg2);
-}
-
-static inline void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_sar_i64, ret, arg1, arg2);
-}
-
-static inline void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_mul_i64, ret, arg1, arg2);
-}
-#else /* TCG_TARGET_REG_BITS == 32 */
 void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
@@ -453,16 +329,8 @@ void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
-#endif /* TCG_TARGET_REG_BITS */
+void tcg_gen_neg_i64(TCGv_i64 ret, TCGv_i64 arg);
 
-static inline void tcg_gen_neg_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    if (TCG_TARGET_HAS_neg_i64) {
-        tcg_gen_op2_i64(INDEX_op_neg_i64, ret, arg);
-    } else {
-        tcg_gen_subfi_i64(ret, 0, arg);
-    }
-}
 
 /* Size changing operations.  */
 
@@ -473,19 +341,17 @@ void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg);
 void tcg_gen_extrh_i64_i32(TCGv_i32 ret, TCGv_i64 arg);
 void tcg_gen_extr_i64_i32(TCGv_i32 lo, TCGv_i32 hi, TCGv_i64 arg);
 void tcg_gen_extr32_i64(TCGv_i64 lo, TCGv_i64 hi, TCGv_i64 arg);
+void tcg_gen_concat32_i64(TCGv_i64 ret, TCGv_i64 lo, TCGv_i64 hi);
 
-void tcg_gen_mov_i128(TCGv_i128 dst, TCGv_i128 src);
 void tcg_gen_extr_i128_i64(TCGv_i64 lo, TCGv_i64 hi, TCGv_i128 arg);
 void tcg_gen_concat_i64_i128(TCGv_i128 ret, TCGv_i64 lo, TCGv_i64 hi);
 
+/* 128 bit ops */
+
+void tcg_gen_mov_i128(TCGv_i128 dst, TCGv_i128 src);
 void tcg_gen_ld_i128(TCGv_i128 ret, TCGv_ptr base, tcg_target_long offset);
 void tcg_gen_st_i128(TCGv_i128 val, TCGv_ptr base, tcg_target_long offset);
 
-static inline void tcg_gen_concat32_i64(TCGv_i64 ret, TCGv_i64 lo, TCGv_i64 hi)
-{
-    tcg_gen_deposit_i64(ret, lo, hi, 32, 32);
-}
-
 /* Local load/store bit ops */
 
 void tcg_gen_qemu_ld_i32_chk(TCGv_i32, TCGTemp *, TCGArg, MemOp, TCGType);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ab6281ebec..579a2aab15 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1503,152 +1503,238 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 
 /* 64-bit ops */
 
-#if TCG_TARGET_REG_BITS == 32
-/* These are all inline for TCG_TARGET_REG_BITS == 64.  */
-
 void tcg_gen_discard_i64(TCGv_i64 arg)
 {
-    tcg_gen_discard_i32(TCGV_LOW(arg));
-    tcg_gen_discard_i32(TCGV_HIGH(arg));
+    if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_op1_i64(INDEX_op_discard, arg);
+    } else {
+        tcg_gen_discard_i32(TCGV_LOW(arg));
+        tcg_gen_discard_i32(TCGV_HIGH(arg));
+    }
 }
 
 void tcg_gen_mov_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
-    TCGTemp *ts = tcgv_i64_temp(arg);
-
-    /* Canonicalize TCGv_i64 TEMP_CONST into TCGv_i32 TEMP_CONST. */
-    if (ts->kind == TEMP_CONST) {
-        tcg_gen_movi_i64(ret, ts->val);
+    if (ret == arg) {
+        return;
+    }
+    if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_op2_i64(INDEX_op_mov_i64, ret, arg);
     } else {
-        tcg_gen_mov_i32(TCGV_LOW(ret), TCGV_LOW(arg));
-        tcg_gen_mov_i32(TCGV_HIGH(ret), TCGV_HIGH(arg));
+        TCGTemp *ts = tcgv_i64_temp(arg);
+
+        /* Canonicalize TCGv_i64 TEMP_CONST into TCGv_i32 TEMP_CONST. */
+        if (ts->kind == TEMP_CONST) {
+            tcg_gen_movi_i64(ret, ts->val);
+        } else {
+            tcg_gen_mov_i32(TCGV_LOW(ret), TCGV_LOW(arg));
+            tcg_gen_mov_i32(TCGV_HIGH(ret), TCGV_HIGH(arg));
+        }
     }
 }
 
 void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg)
 {
-    tcg_gen_movi_i32(TCGV_LOW(ret), arg);
-    tcg_gen_movi_i32(TCGV_HIGH(ret), arg >> 32);
+    if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_mov_i64(ret, tcg_constant_i64(arg));
+    } else {
+        tcg_gen_movi_i32(TCGV_LOW(ret), arg);
+        tcg_gen_movi_i32(TCGV_HIGH(ret), arg >> 32);
+    }
 }
 
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
-    tcg_gen_ld8u_i32(TCGV_LOW(ret), arg2, offset);
-    tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
+    if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_ldst_op_i64(INDEX_op_ld8u_i64, ret, arg2, offset);
+    } else {
+        tcg_gen_ld8u_i32(TCGV_LOW(ret), arg2, offset);
+        tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
+    }
 }
 
 void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
-    tcg_gen_ld8s_i32(TCGV_LOW(ret), arg2, offset);
-    tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_LOW(ret), 31);
+    if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_ldst_op_i64(INDEX_op_ld8s_i64, ret, arg2, offset);
+    } else {
+        tcg_gen_ld8s_i32(TCGV_LOW(ret), arg2, offset);
+        tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_LOW(ret), 31);
+    }
 }
 
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
-    tcg_gen_ld16u_i32(TCGV_LOW(ret), arg2, offset);
-    tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
+    if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_ldst_op_i64(INDEX_op_ld16u_i64, ret, arg2, offset);
+    } else {
+        tcg_gen_ld16u_i32(TCGV_LOW(ret), arg2, offset);
+        tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
+    }
 }
 
 void tcg_gen_ld16s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
-    tcg_gen_ld16s_i32(TCGV_LOW(ret), arg2, offset);
-    tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_LOW(ret), 31);
+    if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_ldst_op_i64(INDEX_op_ld16s_i64, ret, arg2, offset);
+    } else {
+        tcg_gen_ld16s_i32(TCGV_LOW(ret), arg2, offset);
+        tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_LOW(ret), 31);
+    }
 }
 
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
-    tcg_gen_ld_i32(TCGV_LOW(ret), arg2, offset);
-    tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
+    if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_ldst_op_i64(INDEX_op_ld32u_i64, ret, arg2, offset);
+    } else {
+        tcg_gen_ld_i32(TCGV_LOW(ret), arg2, offset);
+        tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
+    }
 }
 
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
-    tcg_gen_ld_i32(TCGV_LOW(ret), arg2, offset);
-    tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_LOW(ret), 31);
+    if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_ldst_op_i64(INDEX_op_ld32s_i64, ret, arg2, offset);
+    } else {
+        tcg_gen_ld_i32(TCGV_LOW(ret), arg2, offset);
+        tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_LOW(ret), 31);
+    }
 }
 
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
-    /* Since arg2 and ret have different types,
-       they cannot be the same temporary */
-#if HOST_BIG_ENDIAN
-    tcg_gen_ld_i32(TCGV_HIGH(ret), arg2, offset);
-    tcg_gen_ld_i32(TCGV_LOW(ret), arg2, offset + 4);
-#else
-    tcg_gen_ld_i32(TCGV_LOW(ret), arg2, offset);
-    tcg_gen_ld_i32(TCGV_HIGH(ret), arg2, offset + 4);
-#endif
+    /*
+     * For 32-bit host, since arg2 and ret have different types,
+     * they cannot be the same temporary -- no chance of overlap.
+     */
+    if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_ldst_op_i64(INDEX_op_ld_i64, ret, arg2, offset);
+    } else if (HOST_BIG_ENDIAN) {
+        tcg_gen_ld_i32(TCGV_HIGH(ret), arg2, offset);
+        tcg_gen_ld_i32(TCGV_LOW(ret), arg2, offset + 4);
+    } else {
+        tcg_gen_ld_i32(TCGV_LOW(ret), arg2, offset);
+        tcg_gen_ld_i32(TCGV_HIGH(ret), arg2, offset + 4);
+    }
 }
 
 void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
-    tcg_gen_st8_i32(TCGV_LOW(arg1), arg2, offset);
+    if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_ldst_op_i64(INDEX_op_st8_i64, arg1, arg2, offset);
+    } else {
+        tcg_gen_st8_i32(TCGV_LOW(arg1), arg2, offset);
+    }
 }
 
 void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
-    tcg_gen_st16_i32(TCGV_LOW(arg1), arg2, offset);
+    if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_ldst_op_i64(INDEX_op_st16_i64, arg1, arg2, offset);
+    } else {
+        tcg_gen_st16_i32(TCGV_LOW(arg1), arg2, offset);
+    }
 }
 
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
-    tcg_gen_st_i32(TCGV_LOW(arg1), arg2, offset);
+    if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_ldst_op_i64(INDEX_op_st32_i64, arg1, arg2, offset);
+    } else {
+        tcg_gen_st_i32(TCGV_LOW(arg1), arg2, offset);
+    }
 }
 
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
-#if HOST_BIG_ENDIAN
-    tcg_gen_st_i32(TCGV_HIGH(arg1), arg2, offset);
-    tcg_gen_st_i32(TCGV_LOW(arg1), arg2, offset + 4);
-#else
-    tcg_gen_st_i32(TCGV_LOW(arg1), arg2, offset);
-    tcg_gen_st_i32(TCGV_HIGH(arg1), arg2, offset + 4);
-#endif
+    if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_ldst_op_i64(INDEX_op_st_i64, arg1, arg2, offset);
+    } else if (HOST_BIG_ENDIAN) {
+        tcg_gen_st_i32(TCGV_HIGH(arg1), arg2, offset);
+        tcg_gen_st_i32(TCGV_LOW(arg1), arg2, offset + 4);
+    } else {
+        tcg_gen_st_i32(TCGV_LOW(arg1), arg2, offset);
+        tcg_gen_st_i32(TCGV_HIGH(arg1), arg2, offset + 4);
+    }
 }
 
 void tcg_gen_add_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    tcg_gen_add2_i32(TCGV_LOW(ret), TCGV_HIGH(ret), TCGV_LOW(arg1),
-                     TCGV_HIGH(arg1), TCGV_LOW(arg2), TCGV_HIGH(arg2));
+    if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_op3_i64(INDEX_op_add_i64, ret, arg1, arg2);
+    } else {
+        tcg_gen_add2_i32(TCGV_LOW(ret), TCGV_HIGH(ret), TCGV_LOW(arg1),
+                         TCGV_HIGH(arg1), TCGV_LOW(arg2), TCGV_HIGH(arg2));
+    }
 }
 
 void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    tcg_gen_sub2_i32(TCGV_LOW(ret), TCGV_HIGH(ret), TCGV_LOW(arg1),
-                     TCGV_HIGH(arg1), TCGV_LOW(arg2), TCGV_HIGH(arg2));
+    if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_op3_i64(INDEX_op_sub_i64, ret, arg1, arg2);
+    } else {
+        tcg_gen_sub2_i32(TCGV_LOW(ret), TCGV_HIGH(ret), TCGV_LOW(arg1),
+                         TCGV_HIGH(arg1), TCGV_LOW(arg2), TCGV_HIGH(arg2));
+    }
 }
 
 void tcg_gen_and_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    tcg_gen_and_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
-    tcg_gen_and_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
+    if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_op3_i64(INDEX_op_and_i64, ret, arg1, arg2);
+    } else {
+        tcg_gen_and_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
+        tcg_gen_and_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
+    }
 }
 
 void tcg_gen_or_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    tcg_gen_or_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
-    tcg_gen_or_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
+    if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_op3_i64(INDEX_op_or_i64, ret, arg1, arg2);
+    } else {
+        tcg_gen_or_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
+        tcg_gen_or_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
+    }
 }
 
 void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    tcg_gen_xor_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
-    tcg_gen_xor_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
+    if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_op3_i64(INDEX_op_xor_i64, ret, arg1, arg2);
+    } else {
+        tcg_gen_xor_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
+        tcg_gen_xor_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
+    }
 }
 
 void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    gen_helper_shl_i64(ret, arg1, arg2);
+    if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_op3_i64(INDEX_op_shl_i64, ret, arg1, arg2);
+    } else {
+        gen_helper_shl_i64(ret, arg1, arg2);
+    }
 }
 
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    gen_helper_shr_i64(ret, arg1, arg2);
+    if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_op3_i64(INDEX_op_shr_i64, ret, arg1, arg2);
+    } else {
+        gen_helper_shr_i64(ret, arg1, arg2);
+    }
 }
 
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    gen_helper_sar_i64(ret, arg1, arg2);
+    if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_op3_i64(INDEX_op_sar_i64, ret, arg1, arg2);
+    } else {
+        gen_helper_sar_i64(ret, arg1, arg2);
+    }
 }
 
 void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
@@ -1656,6 +1742,12 @@ void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     TCGv_i64 t0;
     TCGv_i32 t1;
 
+    if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_op3_i64(INDEX_op_mul_i64, ret, arg1, arg2);
+        return;
+    }
+
+
     t0 = tcg_temp_ebb_new_i64();
     t1 = tcg_temp_ebb_new_i32();
 
@@ -1672,15 +1764,6 @@ void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_temp_free_i32(t1);
 }
 
-#else
-
-void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg)
-{
-    tcg_gen_mov_i64(ret, tcg_constant_i64(arg));
-}
-
-#endif /* TCG_TARGET_REG_SIZE == 32 */
-
 void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     /* some cases can be optimized here */
@@ -1723,6 +1806,15 @@ void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     }
 }
 
+void tcg_gen_neg_i64(TCGv_i64 ret, TCGv_i64 arg)
+{
+    if (TCG_TARGET_HAS_neg_i64) {
+        tcg_gen_op2_i64(INDEX_op_neg_i64, ret, arg);
+    } else {
+        tcg_gen_subfi_i64(ret, 0, arg);
+    }
+}
+
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     if (TCG_TARGET_REG_BITS == 32) {
@@ -3218,6 +3310,11 @@ void tcg_gen_extr32_i64(TCGv_i64 lo, TCGv_i64 hi, TCGv_i64 arg)
     tcg_gen_shri_i64(hi, arg, 32);
 }
 
+void tcg_gen_concat32_i64(TCGv_i64 ret, TCGv_i64 lo, TCGv_i64 hi)
+{
+    tcg_gen_deposit_i64(ret, lo, hi, 32, 32);
+}
+
 void tcg_gen_extr_i128_i64(TCGv_i64 lo, TCGv_i64 hi, TCGv_i128 arg)
 {
     tcg_gen_mov_i64(lo, TCGV128_LOW(arg));
-- 
2.34.1


