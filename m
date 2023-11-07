Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0267E3336
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:50:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0C9I-0008KO-Ec; Mon, 06 Nov 2023 21:49:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9F-0008Id-2S
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:01 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9D-0005sK-2K
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:00 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6c39ad730aaso1899700b3a.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699325338; x=1699930138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fJ/xY0iUs9P73AiIEfKXEfuW9trQF9ga4siF3shzUGM=;
 b=NcyzqWf3a/dXpp1jIZOGbb0MWBzbt47S6Doza1OWkePjsOFtpnMy/sglCdYXTLpNCm
 5oAzEauqIvYG9VcpXt1nMo8ZohbtZA5guGk90PoJRN34BRSUngR0RKkeGDyU1wAlvFpy
 FD1S6JzYBEyFZhEq4adz9Sw9dSZ5yP5Oc3rRBotYzZ8qhWDMxP6xIqci4VhHxmMxrWXq
 b+iVJTOP0kthdQwPx2l6ZwgmoiVkvqWLdFPGjMZyiLEz+Kygp+pjgFWHa0bZPHDX/i0J
 JJ/8RiEcLs9Un0CrmtVTa2bjE1li5O61OPjSpCrhP8UANIvhzY078howBbw3Fcn0YJCx
 IJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699325338; x=1699930138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fJ/xY0iUs9P73AiIEfKXEfuW9trQF9ga4siF3shzUGM=;
 b=cf/XgX1ke9GOTo7SR+FhgWMuZq0TEuKvidIj7tFcS5dUp+z+QGyOjTcTNJbOTKP9gR
 XzFEkXHpTHT99kuAiE3nPdL8beMh0HGeyrvuDgsXLCy6xaUJGjqVYJJcX6iwDHGktt+k
 jl0aORpE56THYmALM8ECAzXgkyLV3V2mE+LwMfq/MBnnbbQz2jImBaOPHcvRbSzvzG3p
 2axCDJr792DIszxL+/KjAS02mmnfpjd9drXc8P4fUzrNOCgPFC15MKZbWEhhrZmBju/s
 pUI07ggViasS5ExbS1iRt0dGHWKhe87lFvaP693VfmLjAz/oDouMNpPW7h90XiYBWDH6
 5Hgw==
X-Gm-Message-State: AOJu0Yzv+Pf+pHMUckPt/wb3CBCnvr2fHy00itVUfg+BcFvNVHh0cK8O
 qvHOspTwiEPst1J0brUXEyZv1PSC/FEInNHZWL4=
X-Google-Smtp-Source: AGHT+IHhWqAUWvvemVCWiypueaNjBAhQwYnYE369iBwS9cGf1k/LYvY3WEaM9kz42S8F3M/8iRyD9A==
X-Received: by 2002:aa7:8881:0:b0:691:2d4:23b2 with SMTP id
 z1-20020aa78881000000b0069102d423b2mr28134427pfe.15.1699325337796; 
 Mon, 06 Nov 2023 18:48:57 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fn11-20020a056a002fcb00b006bff7c36fb3sm6367478pfb.95.2023.11.06.18.48.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:48:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/35] tcg: Move tcg_temp_new_*,
 tcg_global_mem_new_* out of line
Date: Mon,  6 Nov 2023 18:48:25 -0800
Message-Id: <20231107024842.7650-19-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231029210848.78234-11-richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h     | 11 ++++++
 include/tcg/tcg-temp-internal.h | 27 +++-----------
 include/tcg/tcg.h               | 51 --------------------------
 tcg/tcg.c                       | 64 +++++++++++++++++++++++++++++++--
 4 files changed, 76 insertions(+), 77 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index dddf93067e..2d932a515e 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -17,6 +17,17 @@ TCGv_i64 tcg_constant_i64(int64_t val);
 TCGv_vec tcg_constant_vec(TCGType type, unsigned vece, int64_t val);
 TCGv_vec tcg_constant_vec_matching(TCGv_vec match, unsigned vece, int64_t val);
 
+TCGv_i32 tcg_temp_new_i32(void);
+TCGv_i64 tcg_temp_new_i64(void);
+TCGv_ptr tcg_temp_new_ptr(void);
+TCGv_i128 tcg_temp_new_i128(void);
+TCGv_vec tcg_temp_new_vec(TCGType type);
+TCGv_vec tcg_temp_new_vec_matching(TCGv_vec match);
+
+TCGv_i32 tcg_global_mem_new_i32(TCGv_ptr reg, intptr_t off, const char *name);
+TCGv_i64 tcg_global_mem_new_i64(TCGv_ptr reg, intptr_t off, const char *name);
+TCGv_ptr tcg_global_mem_new_ptr(TCGv_ptr reg, intptr_t off, const char *name);
+
 /* Generic ops.  */
 
 void gen_set_label(TCGLabel *l);
diff --git a/include/tcg/tcg-temp-internal.h b/include/tcg/tcg-temp-internal.h
index dded2917e5..2d45cc45d2 100644
--- a/include/tcg/tcg-temp-internal.h
+++ b/include/tcg/tcg-temp-internal.h
@@ -56,28 +56,9 @@ static inline void tcg_temp_free_vec(TCGv_vec arg)
     tcg_temp_free_internal(tcgv_vec_temp(arg));
 }
 
-static inline TCGv_i32 tcg_temp_ebb_new_i32(void)
-{
-    TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_I32, TEMP_EBB);
-    return temp_tcgv_i32(t);
-}
-
-static inline TCGv_i64 tcg_temp_ebb_new_i64(void)
-{
-    TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
-    return temp_tcgv_i64(t);
-}
-
-static inline TCGv_i128 tcg_temp_ebb_new_i128(void)
-{
-    TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_I128, TEMP_EBB);
-    return temp_tcgv_i128(t);
-}
-
-static inline TCGv_ptr tcg_temp_ebb_new_ptr(void)
-{
-    TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_PTR, TEMP_EBB);
-    return temp_tcgv_ptr(t);
-}
+TCGv_i32 tcg_temp_ebb_new_i32(void);
+TCGv_i64 tcg_temp_ebb_new_i64(void);
+TCGv_ptr tcg_temp_ebb_new_ptr(void);
+TCGv_i128 tcg_temp_ebb_new_i128(void);
 
 #endif /* TCG_TEMP_FREE_H */
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 1ae131c242..fc218fd381 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -795,57 +795,6 @@ void tb_target_set_jmp_target(const TranslationBlock *, int,
 
 void tcg_set_frame(TCGContext *s, TCGReg reg, intptr_t start, intptr_t size);
 
-TCGTemp *tcg_global_mem_new_internal(TCGType, TCGv_ptr,
-                                     intptr_t, const char *);
-TCGTemp *tcg_temp_new_internal(TCGType, TCGTempKind);
-TCGv_vec tcg_temp_new_vec(TCGType type);
-TCGv_vec tcg_temp_new_vec_matching(TCGv_vec match);
-
-static inline TCGv_i32 tcg_global_mem_new_i32(TCGv_ptr reg, intptr_t offset,
-                                              const char *name)
-{
-    TCGTemp *t = tcg_global_mem_new_internal(TCG_TYPE_I32, reg, offset, name);
-    return temp_tcgv_i32(t);
-}
-
-static inline TCGv_i32 tcg_temp_new_i32(void)
-{
-    TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_I32, TEMP_TB);
-    return temp_tcgv_i32(t);
-}
-
-static inline TCGv_i64 tcg_global_mem_new_i64(TCGv_ptr reg, intptr_t offset,
-                                              const char *name)
-{
-    TCGTemp *t = tcg_global_mem_new_internal(TCG_TYPE_I64, reg, offset, name);
-    return temp_tcgv_i64(t);
-}
-
-static inline TCGv_i64 tcg_temp_new_i64(void)
-{
-    TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_TB);
-    return temp_tcgv_i64(t);
-}
-
-static inline TCGv_i128 tcg_temp_new_i128(void)
-{
-    TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_I128, TEMP_TB);
-    return temp_tcgv_i128(t);
-}
-
-static inline TCGv_ptr tcg_global_mem_new_ptr(TCGv_ptr reg, intptr_t offset,
-                                              const char *name)
-{
-    TCGTemp *t = tcg_global_mem_new_internal(TCG_TYPE_PTR, reg, offset, name);
-    return temp_tcgv_ptr(t);
-}
-
-static inline TCGv_ptr tcg_temp_new_ptr(void)
-{
-    TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_PTR, TEMP_TB);
-    return temp_tcgv_ptr(t);
-}
-
 #define TCG_CT_CONST  1 /* any constant of register size */
 
 typedef struct TCGArgConstraint {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index ab0d227c00..ec358ce5c0 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1572,8 +1572,8 @@ void tcg_set_frame(TCGContext *s, TCGReg reg, intptr_t start, intptr_t size)
         = tcg_global_reg_new_internal(s, TCG_TYPE_PTR, reg, "_frame");
 }
 
-TCGTemp *tcg_global_mem_new_internal(TCGType type, TCGv_ptr base,
-                                     intptr_t offset, const char *name)
+static TCGTemp *tcg_global_mem_new_internal(TCGv_ptr base, intptr_t offset,
+                                            const char *name, TCGType type)
 {
     TCGContext *s = tcg_ctx;
     TCGTemp *base_ts = tcgv_ptr_temp(base);
@@ -1632,7 +1632,25 @@ TCGTemp *tcg_global_mem_new_internal(TCGType type, TCGv_ptr base,
     return ts;
 }
 
-TCGTemp *tcg_temp_new_internal(TCGType type, TCGTempKind kind)
+TCGv_i32 tcg_global_mem_new_i32(TCGv_ptr reg, intptr_t off, const char *name)
+{
+    TCGTemp *ts = tcg_global_mem_new_internal(reg, off, name, TCG_TYPE_I32);
+    return temp_tcgv_i32(ts);
+}
+
+TCGv_i64 tcg_global_mem_new_i64(TCGv_ptr reg, intptr_t off, const char *name)
+{
+    TCGTemp *ts = tcg_global_mem_new_internal(reg, off, name, TCG_TYPE_I64);
+    return temp_tcgv_i64(ts);
+}
+
+TCGv_ptr tcg_global_mem_new_ptr(TCGv_ptr reg, intptr_t off, const char *name)
+{
+    TCGTemp *ts = tcg_global_mem_new_internal(reg, off, name, TCG_TYPE_PTR);
+    return temp_tcgv_ptr(ts);
+}
+
+static TCGTemp *tcg_temp_new_internal(TCGType type, TCGTempKind kind)
 {
     TCGContext *s = tcg_ctx;
     TCGTemp *ts;
@@ -1696,6 +1714,46 @@ TCGTemp *tcg_temp_new_internal(TCGType type, TCGTempKind kind)
     return ts;
 }
 
+TCGv_i32 tcg_temp_new_i32(void)
+{
+    return temp_tcgv_i32(tcg_temp_new_internal(TCG_TYPE_I32, TEMP_TB));
+}
+
+TCGv_i32 tcg_temp_ebb_new_i32(void)
+{
+    return temp_tcgv_i32(tcg_temp_new_internal(TCG_TYPE_I32, TEMP_EBB));
+}
+
+TCGv_i64 tcg_temp_new_i64(void)
+{
+    return temp_tcgv_i64(tcg_temp_new_internal(TCG_TYPE_I64, TEMP_TB));
+}
+
+TCGv_i64 tcg_temp_ebb_new_i64(void)
+{
+    return temp_tcgv_i64(tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB));
+}
+
+TCGv_ptr tcg_temp_new_ptr(void)
+{
+    return temp_tcgv_ptr(tcg_temp_new_internal(TCG_TYPE_PTR, TEMP_TB));
+}
+
+TCGv_ptr tcg_temp_ebb_new_ptr(void)
+{
+    return temp_tcgv_ptr(tcg_temp_new_internal(TCG_TYPE_PTR, TEMP_EBB));
+}
+
+TCGv_i128 tcg_temp_new_i128(void)
+{
+    return temp_tcgv_i128(tcg_temp_new_internal(TCG_TYPE_I128, TEMP_TB));
+}
+
+TCGv_i128 tcg_temp_ebb_new_i128(void)
+{
+    return temp_tcgv_i128(tcg_temp_new_internal(TCG_TYPE_I128, TEMP_EBB));
+}
+
 TCGv_vec tcg_temp_new_vec(TCGType type)
 {
     TCGTemp *t;
-- 
2.34.1


