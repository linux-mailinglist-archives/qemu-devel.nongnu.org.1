Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EE17DAE68
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 22:10:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxD1r-0002ge-N3; Sun, 29 Oct 2023 17:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxD1o-0002fb-13
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 17:09:00 -0400
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxD1k-0005ED-5t
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 17:08:59 -0400
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3574f99d236so13561235ab.2
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 14:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698613735; x=1699218535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ULm4CgZSvJeRSMZek6x39wvQHQZWb69IFqtSBX5Uhrg=;
 b=k/9SLURP01A4967+k3DDR5m7AAXTWuvqJIP2RWKyK19w9FeVwlWlNxalrRFG/jIsjn
 9hNFll9lXrqzjPBpM0jfge9TltGik1OzH8mol5WcsxcJpiKRAcmHnegY1zOFhDPHmTSX
 XN6GF7zWaGaOv08JnkPOie/9c/0IjwjiP2yPSp1uiHpoRAOCt41N19e/eHBDW6mcXHDD
 fxvDACRcEJHY9MXVrHq96EtSsPGppfnGCm3iP4TpIHJ8Ol2TXwHwmPCF/yr+3dLWPFkJ
 CJMuCbgqJVVO01M36Ai1d8h0sQ848DgD5tpx7+lhuhAeG5T1lnmDdMY1jD09EQOFjxsZ
 tzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698613735; x=1699218535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ULm4CgZSvJeRSMZek6x39wvQHQZWb69IFqtSBX5Uhrg=;
 b=uEisKhc7Vl29s4gT7t3lwScvB6qtjHVNOu5BdGKGbZgsea7BdABKnq/HKms9DjgPEU
 Xd1z+t3GtO2/zAAo5GIG9Hd3w61eY1TiJtVjtDiRLvxKEiZsSk4vH5fKKJG9rChYMiv5
 763sW9xn/NRRvLnk1tMypJ7qVptzSh+gLKAJA+EDRYxSVk3Ufx52rPaT8vvJ/BLsXjeA
 sydDIqXoA/Sg/8E6oCxImUmw5woHDC0yWxl95g+FI8GHIyudOxu3cO0bsdwRL1KZUGSu
 /x512hGIK4fBFz5TcKkgne/dNfkXnLtNj0ldTOf2i3erBSBQsA+3wOrZGBd8wPhzvFMN
 flRQ==
X-Gm-Message-State: AOJu0Yy9NwpQTukSKUdSb3G0F9OuYWalkFmFfAJPwYRSsZbQHxyjEcw7
 zynSttpk74Ujp7uIOweFWBwT1I2fTycbCxKV3eQ=
X-Google-Smtp-Source: AGHT+IHyoYMnNOLXFjE2fgZ08b0/cnGX1vkpiC8x+J6reanDnKXpBGT2SeYCoinVmgM3Ky8os7thMQ==
X-Received: by 2002:a05:6e02:1e0b:b0:357:f66c:9be8 with SMTP id
 g11-20020a056e021e0b00b00357f66c9be8mr12224090ila.30.1698613734820; 
 Sun, 29 Oct 2023 14:08:54 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 z11-20020aa785cb000000b006c0685422e0sm4622847pfn.214.2023.10.29.14.08.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 14:08:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/11] tcg: Move 64-bit expanders out of line
Date: Sun, 29 Oct 2023 14:08:42 -0700
Message-Id: <20231029210848.78234-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231029210848.78234-1-richard.henderson@linaro.org>
References: <20231029210848.78234-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12a;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12a.google.com
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

This one is more complicated, combining 32-bit and 64-bit
expansion with C if instead of preprocessor #if.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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


