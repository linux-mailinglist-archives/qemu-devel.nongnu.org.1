Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5014B7DAE70
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 22:11:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxD1q-0002gM-Bi; Sun, 29 Oct 2023 17:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxD1n-0002fY-Sj
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 17:08:59 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxD1k-0005E1-5E
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 17:08:59 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6be1bc5aa1cso3796223b3a.3
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 14:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698613734; x=1699218534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qEwpq61bisJxaUtSkO6gJqpIPE+/R7F0brUH6YprmrY=;
 b=e3XZk3HftMYOeWPQwPZ5iXEPH9QSl2LP6OhGOWNaSkH0h1K6FlT1ko2FXUrpkihbYE
 I1StLhdOeB5wjIfoy3blGrk+W2uVcYNg3FuMbDBLWaHY2dfqj/FLlSCffXlRRERvuhcN
 jxV/BhmKqhcviJAB9BFKbykG1Xwbl0aOJm5Ce2+BeBDIHqBprVSfAeFKKLI3s68/Xuax
 50Ewnm2IjKCmekjsF7j/MrxAXkTjOgqQycIdbRQcGGMP367gYHe0RU7SbpFJZLba2+Uj
 kr9zvjMzDhYyzNwSE6MbuZT5gYNVttbyBu3Lem0rqNc9IfEuNBIDqRVBZ0i+d/nKuPMm
 /RYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698613734; x=1699218534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qEwpq61bisJxaUtSkO6gJqpIPE+/R7F0brUH6YprmrY=;
 b=FOpuJeYOlwxc1qizMvMhEwyo1Y7REMA4XWkrop8TvTac2NzwDeJuthZ8YLLPbGS+Gi
 L34r4PydAL+TQv6xPLdXsa0jteqGxmI/If33VwcPtYWbP5m4liLVyPk3woNOXUyMtjdD
 N+bXkTkPGjO2H/rfHD93RodhTjQVHdvDGdQbD3kURWSotHUgPprDNrPdZWcrlUn/M/JP
 6kvhOcIZOjaO65xs8roHRsiCpUgd6+G9Rss/FWY6K2XqmmNWbLmJu6R7XfJfpe3sjmHx
 +aYOTyNx5r0tv2wKUpkKIV7AQGkStzstJWJmXYjCa2kqByznxek8KlpiWKmRwjGwIDIh
 o0VA==
X-Gm-Message-State: AOJu0Yx4kgbgArNRo9Ow7xHvkdMKyLXzXPsXtq7kRUR772i45rNL6c1F
 zL+nIiclgpkLJnKWJmSfjSKwJ+3RQRp1eMZlLJw=
X-Google-Smtp-Source: AGHT+IH5Y1/BKiJ4vn43GM2Lc0QgpUGGW2KH3PNd5DOplAKE4BshnrDrA4QYwbbf9dalmvrporewTA==
X-Received: by 2002:a05:6a00:a27:b0:6b5:26ef:3261 with SMTP id
 p39-20020a056a000a2700b006b526ef3261mr10311045pfh.16.1698613733934; 
 Sun, 29 Oct 2023 14:08:53 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 z11-20020aa785cb000000b006c0685422e0sm4622847pfn.214.2023.10.29.14.08.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 14:08:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/11] tcg: Move 32-bit expanders out of line
Date: Sun, 29 Oct 2023 14:08:41 -0700
Message-Id: <20231029210848.78234-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231029210848.78234-1-richard.henderson@linaro.org>
References: <20231029210848.78234-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h | 140 ++++++------------------------------
 tcg/tcg-op.c                | 116 ++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+), 119 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 2134961a98..cdaa1415d1 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -197,128 +197,30 @@ void tcg_gen_abs_i32(TCGv_i32, TCGv_i32);
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
-static inline void tcg_gen_discard_i32(TCGv_i32 arg)
-{
-    tcg_gen_op1_i32(INDEX_op_discard, arg);
-}
+void tcg_gen_discard_i32(TCGv_i32 arg);
+void tcg_gen_mov_i32(TCGv_i32 ret, TCGv_i32 arg);
 
-static inline void tcg_gen_mov_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    if (ret != arg) {
-        tcg_gen_op2_i32(INDEX_op_mov_i32, ret, arg);
-    }
-}
+void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
+void tcg_gen_ld8s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
+void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
+void tcg_gen_ld16s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
+void tcg_gen_ld_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 
-static inline void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2,
-                                    tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_ld8u_i32, ret, arg2, offset);
-}
+void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
+void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
+void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-static inline void tcg_gen_ld8s_i32(TCGv_i32 ret, TCGv_ptr arg2,
-                                    tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_ld8s_i32, ret, arg2, offset);
-}
-
-static inline void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2,
-                                     tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_ld16u_i32, ret, arg2, offset);
-}
-
-static inline void tcg_gen_ld16s_i32(TCGv_i32 ret, TCGv_ptr arg2,
-                                     tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_ld16s_i32, ret, arg2, offset);
-}
-
-static inline void tcg_gen_ld_i32(TCGv_i32 ret, TCGv_ptr arg2,
-                                  tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_ld_i32, ret, arg2, offset);
-}
-
-static inline void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2,
-                                   tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_st8_i32, arg1, arg2, offset);
-}
-
-static inline void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2,
-                                    tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_st16_i32, arg1, arg2, offset);
-}
-
-static inline void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2,
-                                  tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_st_i32, arg1, arg2, offset);
-}
-
-static inline void tcg_gen_add_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_add_i32, ret, arg1, arg2);
-}
-
-static inline void tcg_gen_sub_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_sub_i32, ret, arg1, arg2);
-}
-
-static inline void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_and_i32, ret, arg1, arg2);
-}
-
-static inline void tcg_gen_or_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_or_i32, ret, arg1, arg2);
-}
-
-static inline void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_xor_i32, ret, arg1, arg2);
-}
-
-static inline void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_shl_i32, ret, arg1, arg2);
-}
-
-static inline void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_shr_i32, ret, arg1, arg2);
-}
-
-static inline void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_sar_i32, ret, arg1, arg2);
-}
-
-static inline void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_mul_i32, ret, arg1, arg2);
-}
-
-static inline void tcg_gen_neg_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    if (TCG_TARGET_HAS_neg_i32) {
-        tcg_gen_op2_i32(INDEX_op_neg_i32, ret, arg);
-    } else {
-        tcg_gen_subfi_i32(ret, 0, arg);
-    }
-}
-
-static inline void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    if (TCG_TARGET_HAS_not_i32) {
-        tcg_gen_op2_i32(INDEX_op_not_i32, ret, arg);
-    } else {
-        tcg_gen_xori_i32(ret, arg, -1);
-    }
-}
+void tcg_gen_add_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
+void tcg_gen_sub_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
+void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
+void tcg_gen_or_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
+void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
+void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
+void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
+void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
+void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
+void tcg_gen_neg_i32(TCGv_i32 ret, TCGv_i32 arg);
+void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index a8cbad212d..ab6281ebec 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -351,11 +351,28 @@ void tcg_gen_plugin_cb_end(void)
 
 /* 32 bit ops */
 
+void tcg_gen_discard_i32(TCGv_i32 arg)
+{
+    tcg_gen_op1_i32(INDEX_op_discard, arg);
+}
+
+void tcg_gen_mov_i32(TCGv_i32 ret, TCGv_i32 arg)
+{
+    if (ret != arg) {
+        tcg_gen_op2_i32(INDEX_op_mov_i32, ret, arg);
+    }
+}
+
 void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg)
 {
     tcg_gen_mov_i32(ret, tcg_constant_i32(arg));
 }
 
+void tcg_gen_add_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
+{
+    tcg_gen_op3_i32(INDEX_op_add_i32, ret, arg1, arg2);
+}
+
 void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* some cases can be optimized here */
@@ -366,6 +383,11 @@ void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
+void tcg_gen_sub_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
+{
+    tcg_gen_op3_i32(INDEX_op_sub_i32, ret, arg1, arg2);
+}
+
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
 {
     if (arg1 == 0 && TCG_TARGET_HAS_neg_i32) {
@@ -386,6 +408,20 @@ void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
+void tcg_gen_neg_i32(TCGv_i32 ret, TCGv_i32 arg)
+{
+    if (TCG_TARGET_HAS_neg_i32) {
+        tcg_gen_op2_i32(INDEX_op_neg_i32, ret, arg);
+    } else {
+        tcg_gen_subfi_i32(ret, 0, arg);
+    }
+}
+
+void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
+{
+    tcg_gen_op3_i32(INDEX_op_and_i32, ret, arg1, arg2);
+}
+
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* Some cases can be optimized here.  */
@@ -414,6 +450,11 @@ void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     tcg_gen_and_i32(ret, arg1, tcg_constant_i32(arg2));
 }
 
+void tcg_gen_or_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
+{
+    tcg_gen_op3_i32(INDEX_op_or_i32, ret, arg1, arg2);
+}
+
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* Some cases can be optimized here.  */
@@ -426,6 +467,11 @@ void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
+void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
+{
+    tcg_gen_op3_i32(INDEX_op_xor_i32, ret, arg1, arg2);
+}
+
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* Some cases can be optimized here.  */
@@ -439,6 +485,20 @@ void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
+void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
+{
+    if (TCG_TARGET_HAS_not_i32) {
+        tcg_gen_op2_i32(INDEX_op_not_i32, ret, arg);
+    } else {
+        tcg_gen_xori_i32(ret, arg, -1);
+    }
+}
+
+void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
+{
+    tcg_gen_op3_i32(INDEX_op_shl_i32, ret, arg1, arg2);
+}
+
 void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -449,6 +509,11 @@ void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
+void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
+{
+    tcg_gen_op3_i32(INDEX_op_shr_i32, ret, arg1, arg2);
+}
+
 void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -459,6 +524,11 @@ void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
+void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
+{
+    tcg_gen_op3_i32(INDEX_op_sar_i32, ret, arg1, arg2);
+}
+
 void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -527,6 +597,11 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
+void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
+{
+    tcg_gen_op3_i32(INDEX_op_mul_i32, ret, arg1, arg2);
+}
+
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     if (arg2 == 0) {
@@ -1385,6 +1460,47 @@ void tcg_gen_abs_i32(TCGv_i32 ret, TCGv_i32 a)
     tcg_temp_free_i32(t);
 }
 
+void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
+{
+    tcg_gen_ldst_op_i32(INDEX_op_ld8u_i32, ret, arg2, offset);
+}
+
+void tcg_gen_ld8s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
+{
+    tcg_gen_ldst_op_i32(INDEX_op_ld8s_i32, ret, arg2, offset);
+}
+
+void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
+{
+    tcg_gen_ldst_op_i32(INDEX_op_ld16u_i32, ret, arg2, offset);
+}
+
+void tcg_gen_ld16s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
+{
+    tcg_gen_ldst_op_i32(INDEX_op_ld16s_i32, ret, arg2, offset);
+}
+
+void tcg_gen_ld_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
+{
+    tcg_gen_ldst_op_i32(INDEX_op_ld_i32, ret, arg2, offset);
+}
+
+void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
+{
+    tcg_gen_ldst_op_i32(INDEX_op_st8_i32, arg1, arg2, offset);
+}
+
+void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
+{
+    tcg_gen_ldst_op_i32(INDEX_op_st16_i32, arg1, arg2, offset);
+}
+
+void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
+{
+    tcg_gen_ldst_op_i32(INDEX_op_st_i32, arg1, arg2, offset);
+}
+
+
 /* 64-bit ops */
 
 #if TCG_TARGET_REG_BITS == 32
-- 
2.34.1


