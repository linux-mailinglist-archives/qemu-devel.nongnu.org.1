Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A81057DAE6F
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 22:10:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxD1t-0002hu-Up; Sun, 29 Oct 2023 17:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxD1r-0002h5-SP
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 17:09:03 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxD1n-0005F1-Dw
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 17:09:03 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6ba172c5f3dso3272708b3a.0
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 14:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698613738; x=1699218538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5QlzNeO/gyaDAQVm9+ab1KqZ/KrOBJrn/W3IjB0WabU=;
 b=UlFGMiYfSaFJaZLLr0yO6GAHJ+4joo7F7tRe+PqMinUHx0FXp9SYu7vqPMXyttGceu
 1TjfzftbJYqcqfEzKlv7AxiKWLpKFQt0wur8TAiEcWWgezM66scWEKvZb6SZ/PuRm2BX
 vfVBEUIfKwzLYvLLGdEbLAQCbSmwC69BE2ByeKdmygZeBfxMNwzel0f/qUTRbn+WYK9O
 kwWTgKBqB8P4ZGSQTHRH4/8e45GTpGUlP51mxEoXpZuU0A7BgP43F5LHTMWyuxKRZzke
 1U8vS6rskxNbz16qEddNJPbCT78k6xf/aEbQ5W64SOyg3Ry+Cz6v0nMQ3ZkZOa1u+SmY
 xSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698613738; x=1699218538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5QlzNeO/gyaDAQVm9+ab1KqZ/KrOBJrn/W3IjB0WabU=;
 b=DTCkoJ4yJ0RyKMXE964NzdZc3osXdKzxXmVLWHvfDgAhlAkpEhncDNSUSv0RL94m5q
 HgzuqQwoHtkEQiEbI7ge+OrAZOLwr8FCRRY2/A4dPwED6p964KkS2NGuabThBHEfwZUX
 zKaEInPWme3N9FnW0WkHjCYPfskUsc0kVWhJebnZLTqdQyWkC0L1sc2iH/EBaAm6LnBe
 RcGFyGzKHQUgyma77kiV62BLYl9Tkxv1/F/trtBDEWUJ3/xBqgXSHKXy4NYsxrFxz8q/
 syH5twQM47FQTEBq/R4te9jSP2OWMDcJhNb2KXQSz8CVikU8GoVD7t/7aMXtzLQn+S+0
 Vdiw==
X-Gm-Message-State: AOJu0YyNzMTzohgFJmpWAvZXfDD7nN7LIDDvvNqqLErS7C2qO2C+xgKm
 yogZ84UopbXkx1B92xlZeJ5/rdNI5cl+Jk6iV+U=
X-Google-Smtp-Source: AGHT+IFUtYez4yToAhmx2zdMGVts0lPak+1KLcKWtEIbvDPyL/7kCMjJ9HClT2WkQ1U2VoCNp3NhwQ==
X-Received: by 2002:a05:6a00:1255:b0:691:2d4:2389 with SMTP id
 u21-20020a056a00125500b0069102d42389mr6577983pfi.21.1698613738054; 
 Sun, 29 Oct 2023 14:08:58 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 z11-20020aa785cb000000b006c0685422e0sm4622847pfn.214.2023.10.29.14.08.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 14:08:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/11] tcg: Move tcg_constant_* out of line
Date: Sun, 29 Oct 2023 14:08:46 -0700
Message-Id: <20231029210848.78234-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231029210848.78234-1-richard.henderson@linaro.org>
References: <20231029210848.78234-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
index a9282cdcc6..a5ecab3cb3 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -937,32 +937,6 @@ void tcg_remove_ops_after(TCGOp *op);
 
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
index 58b431b579..c77b1fd943 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1802,6 +1802,21 @@ TCGTemp *tcg_constant_internal(TCGType type, int64_t val)
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


