Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C363B7E3340
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:51:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0C9G-0008JM-49; Mon, 06 Nov 2023 21:49:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9E-0008Hg-0A
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:00 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9C-0005s8-8j
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:48:59 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6c320a821c4so4636817b3a.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699325337; x=1699930137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cAcMZdXb3don662dWVOxxMEXAdoPbTxWOBUJh8uey/k=;
 b=c2Ah3n0YVl1nC8UZ7fSLcwcUQpMA+mQHVnac133DwnsqKe5lmcBHMfEknvRlsrZ+OG
 yKErZV1T82ASgunCrFtfVpL6m9gjgiTX6OyggZ6ZRQiyfNiR81mWoJvQygMAvxtGivzv
 wi+EevH4+oTYE5hRUJhf4x9+aDCZ7PLTtIIBt4fwr48yF4ihmiiHZzZoiPgLpPRNl1Bh
 2ZojzjngsH75LDqBFg91cJV+CJ7XjptyZnzngohf54vwvF3CZxeAKo1yc5C2b3+VP7F2
 Mc/GZPzXuBUTClZE0Pe6578LnzwDy0gJWd1HMki+evFJ+LK90pFaJyQBU65hviUtqCHJ
 mR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699325337; x=1699930137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cAcMZdXb3don662dWVOxxMEXAdoPbTxWOBUJh8uey/k=;
 b=kxYznhBeQq1jwxobWzhD0n2HFfEH0AS8Jb4gTssaN9/pLMDXg3JFP+hosQHTRTCz1N
 I0q3QVcpVq+jkOU3IOYvIDHa1womq2Da4ssYZ8gVXatLUC7H35osRk4TD4luOfOae2jU
 0G/GO0tI6q38trAcDE642n92iSroybAK+fWmm8/+776GhxKSkUD3HR3ke0afZbn2HhNw
 KCQydAomPo9dlq0gvBOP6CscuNyBkGcBcGyykXnAE4ghMb5JR4FjRHKT3od3mrgZ6eya
 S/Rz4YXKq8c49UJ2t7l6PwygxijJG8UgSqG5COSPRQtOngdME5I0jjyV9CGgGu2VVnQG
 WW3w==
X-Gm-Message-State: AOJu0YwFTjmgE4ExXm2LYPRny+w2zcYthK8sOCSe3xCGG95rPvb0xGY+
 QfRJQt/KW085QKFf4pwLFxKQ5SBf1FGnjyWUyIQ=
X-Google-Smtp-Source: AGHT+IHWCPsV/Z0FBVq1fparvn/nREUIqFBRQfOXzGjs9pMv+zBSudivgJeqGaUeYU12VkQmVJnIrg==
X-Received: by 2002:a05:6a00:1345:b0:6bd:f760:6ab1 with SMTP id
 k5-20020a056a00134500b006bdf7606ab1mr29534190pfu.14.1699325336974; 
 Mon, 06 Nov 2023 18:48:56 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fn11-20020a056a002fcb00b006bff7c36fb3sm6367478pfb.95.2023.11.06.18.48.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:48:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/35] tcg: Move tcg_constant_* out of line
Date: Mon,  6 Nov 2023 18:48:24 -0800
Message-Id: <20231107024842.7650-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107024842.7650-1-richard.henderson@linaro.org>
References: <20231107024842.7650-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
Message-Id: <20231029210848.78234-10-richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h |  8 ++++++++
 include/tcg/tcg.h           | 26 --------------------------
 tcg/tcg-internal.h          |  7 +++++++
 tcg/tcg.c                   | 15 +++++++++++++++
 4 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 760c67683b..dddf93067e 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -12,6 +12,11 @@
 #include "exec/helper-proto-common.h"
 #include "exec/helper-gen-common.h"
 
+TCGv_i32 tcg_constant_i32(int32_t val);
+TCGv_i64 tcg_constant_i64(int64_t val);
+TCGv_vec tcg_constant_vec(TCGType type, unsigned vece, int64_t val);
+TCGv_vec tcg_constant_vec_matching(TCGv_vec match, unsigned vece, int64_t val);
+
 /* Generic ops.  */
 
 void gen_set_label(TCGLabel *l);
@@ -459,6 +464,9 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
 # define NAT  TCGv_i64
 #endif
 
+TCGv_ptr tcg_constant_ptr_int(intptr_t x);
+#define tcg_constant_ptr(X)  tcg_constant_ptr_int((intptr_t)(X))
+
 static inline void tcg_gen_ld_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
 {
     glue(tcg_gen_ld_,PTR)((NAT)r, a, o);
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 3a4c0f124f..1ae131c242 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -934,32 +934,6 @@ void tcg_remove_ops_after(TCGOp *op);
 
 void tcg_optimize(TCGContext *s);
 
-/*
- * Locate or create a read-only temporary that is a constant.
- * This kind of temporary need not be freed, but for convenience
- * will be silently ignored by tcg_temp_free_*.
- */
-TCGTemp *tcg_constant_internal(TCGType type, int64_t val);
-
-static inline TCGv_i32 tcg_constant_i32(int32_t val)
-{
-    return temp_tcgv_i32(tcg_constant_internal(TCG_TYPE_I32, val));
-}
-
-static inline TCGv_i64 tcg_constant_i64(int64_t val)
-{
-    return temp_tcgv_i64(tcg_constant_internal(TCG_TYPE_I64, val));
-}
-
-TCGv_vec tcg_constant_vec(TCGType type, unsigned vece, int64_t val);
-TCGv_vec tcg_constant_vec_matching(TCGv_vec match, unsigned vece, int64_t val);
-
-#if UINTPTR_MAX == UINT32_MAX
-# define tcg_constant_ptr(x)     ((TCGv_ptr)tcg_constant_i32((intptr_t)(x)))
-#else
-# define tcg_constant_ptr(x)     ((TCGv_ptr)tcg_constant_i64((intptr_t)(x)))
-#endif
-
 TCGLabel *gen_new_label(void);
 
 /**
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index c9ac34fc3d..6c9d9e48db 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -83,6 +83,13 @@ static inline TCGv_i64 TCGV128_HIGH(TCGv_i128 t)
 
 bool tcg_target_has_memory_bswap(MemOp memop);
 
+/*
+ * Locate or create a read-only temporary that is a constant.
+ * This kind of temporary need not be freed, but for convenience
+ * will be silently ignored by tcg_temp_free_*.
+ */
+TCGTemp *tcg_constant_internal(TCGType type, int64_t val);
+
 void tcg_gen_op1(TCGOpcode, TCGArg);
 void tcg_gen_op2(TCGOpcode, TCGArg, TCGArg);
 void tcg_gen_op3(TCGOpcode, TCGArg, TCGArg, TCGArg);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 6766b60b8a..ab0d227c00 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1806,6 +1806,21 @@ TCGTemp *tcg_constant_internal(TCGType type, int64_t val)
     return ts;
 }
 
+TCGv_i32 tcg_constant_i32(int32_t val)
+{
+    return temp_tcgv_i32(tcg_constant_internal(TCG_TYPE_I32, val));
+}
+
+TCGv_i64 tcg_constant_i64(int64_t val)
+{
+    return temp_tcgv_i64(tcg_constant_internal(TCG_TYPE_I64, val));
+}
+
+TCGv_ptr tcg_constant_ptr_int(intptr_t val)
+{
+    return temp_tcgv_ptr(tcg_constant_internal(TCG_TYPE_PTR, val));
+}
+
 TCGv_vec tcg_constant_vec(TCGType type, unsigned vece, int64_t val)
 {
     val = dup_const(vece, val);
-- 
2.34.1


