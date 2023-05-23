Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D07970DE3D
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:57:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1ST7-0006Xr-2p; Tue, 23 May 2023 09:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSP-0004zm-AB
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:46 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSN-00034Z-K9
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:45 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-64d3fbb8c1cso4743710b3a.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850022; x=1687442022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=f6ed1FqxBisHvzO2Ats72ofMAbjCaP6iPUvqaHHft5E=;
 b=oruelD3sU3wSANPCy3BUHVkx8CSpEfNcG2MAWyYYJt06dvNqLSv9sFO5rdN6wPgIgK
 txqQVv+m9Npnhq65XnQFwhONo3mnrIFJ4IqNdniKYdYVmjpJcMo3ALvNPZP3BQUY+JxC
 VjPcV3e3p97HIqRfOF6MQbIRyDZZQGDPsvxURnLJNw56aNe57ucxS89K1qKC8XqwqgJC
 YtlKzwu6/pkSNnYfS3Q2AQ7JQD4u2YpTknoJxXdWt+IJoDl8fksrn0ufNEkW1CBAeHCs
 yL3n3+dRL7z4J6Vmk5mbabES6IfX2R2uCv2mPPyvaAHSk1EVp4EyMtFhjyiOBeONaGEa
 b0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850022; x=1687442022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f6ed1FqxBisHvzO2Ats72ofMAbjCaP6iPUvqaHHft5E=;
 b=htx4oaqtfAvgWVoTH2kUX6nBYCM/fExhT7frxoz9U0LY5yOe5lSMCNj8scnUn3jJYw
 jroesa11aJp3IoYUPmvzDCJ9Imiq7SL202pw6aQPoHbUJzxVm1gm5Je+f9RpGxYsS7FD
 YMiMJpefTp5Ewlrm+eldaR4YFTqF4Yf2E4372a8PUIfah+dtr0F28UowoeHhg9zpv9KI
 DdHNEsP0dpiLZVJrfpKG6i/hGJQd2GxjgZ9pWJtVYD5q3yFhnT/O6HROvIBzqOrSi7n0
 zoJ6z7rl+g1gm+Qcr9ieGX29ZJ96+kl6KmaugnJCc2WV/bWaotdZXGa2UfvmCGJiYM9Z
 XsdQ==
X-Gm-Message-State: AC+VfDwvmuJQCSllCJ2t0xHweRu0sODumT8i1KYd4TeRmwomkkHDRbki
 roIGwbcgO0RhmFmsuCbBN3IsPX3uW2d00GwkPhc=
X-Google-Smtp-Source: ACHHUZ5snvS5JfNINxtUBvL+CTTq0nZpNnyP2wv437+SxtlLmPeqvF14BBdFulzIlCrAMPf4A8Ua4A==
X-Received: by 2002:a05:6a20:3947:b0:10c:7916:f9f6 with SMTP id
 r7-20020a056a20394700b0010c7916f9f6mr2687163pzg.52.1684850022193; 
 Tue, 23 May 2023 06:53:42 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020aa78708000000b0064d27a28451sm5796111pfo.100.2023.05.23.06.53.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:53:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 22/52] tcg: Move temp_idx and tcgv_i32_temp debug out of
 line
Date: Tue, 23 May 2023 06:52:52 -0700
Message-Id: <20230523135322.678948-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Removes a multiplicty of calls to __assert_fail, saving up
to 360kiB of .text space as measured on an x86_64 host.

Old     New     Less    %Change
9257272	8888680	368592	3.98%	qemu-system-aarch64
6100968	5911832	189136	3.10%	qemu-system-riscv64
5839112	5707032	132080	2.26%	qemu-system-mips
4447608	4341752	105856	2.38%	qemu-system-s390x

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h | 30 ++++++++++++++++--------------
 tcg/tcg.c         | 19 +++++++++++++++++++
 2 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 34035dab81..64c10a63f3 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -630,13 +630,6 @@ static inline void *tcg_splitwx_to_rw(const void *rx)
 }
 #endif
 
-static inline size_t temp_idx(TCGTemp *ts)
-{
-    ptrdiff_t n = ts - tcg_ctx->temps;
-    tcg_debug_assert(n >= 0 && n < tcg_ctx->nb_temps);
-    return n;
-}
-
 static inline TCGArg temp_arg(TCGTemp *ts)
 {
     return (uintptr_t)ts;
@@ -647,16 +640,25 @@ static inline TCGTemp *arg_temp(TCGArg a)
     return (TCGTemp *)(uintptr_t)a;
 }
 
-/* Using the offset of a temporary, relative to TCGContext, rather than
-   its index means that we don't use 0.  That leaves offset 0 free for
-   a NULL representation without having to leave index 0 unused.  */
+#ifdef CONFIG_DEBUG_TCG
+size_t temp_idx(TCGTemp *ts);
+TCGTemp *tcgv_i32_temp(TCGv_i32 v);
+#else
+static inline size_t temp_idx(TCGTemp *ts)
+{
+    return ts - tcg_ctx->temps;
+}
+
+/*
+ * Using the offset of a temporary, relative to TCGContext, rather than
+ * its index means that we don't use 0.  That leaves offset 0 free for
+ * a NULL representation without having to leave index 0 unused.
+ */
 static inline TCGTemp *tcgv_i32_temp(TCGv_i32 v)
 {
-    uintptr_t o = (uintptr_t)v;
-    TCGTemp *t = (void *)tcg_ctx + o;
-    tcg_debug_assert(offsetof(TCGContext, temps[temp_idx(t)]) == o);
-    return t;
+    return (void *)tcg_ctx + (uintptr_t)v;
 }
+#endif
 
 static inline TCGTemp *tcgv_i64_temp(TCGv_i64 v)
 {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 7c5cc6c800..bd276f1d32 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1805,6 +1805,25 @@ TCGv_vec tcg_constant_vec_matching(TCGv_vec match, unsigned vece, int64_t val)
     return tcg_constant_vec(t->base_type, vece, val);
 }
 
+#ifdef CONFIG_DEBUG_TCG
+size_t temp_idx(TCGTemp *ts)
+{
+    ptrdiff_t n = ts - tcg_ctx->temps;
+    assert(n >= 0 && n < tcg_ctx->nb_temps);
+    return n;
+}
+
+TCGTemp *tcgv_i32_temp(TCGv_i32 v)
+{
+    uintptr_t o = (uintptr_t)v - offsetof(TCGContext, temps);
+
+    assert(o < sizeof(TCGTemp) * tcg_ctx->nb_temps);
+    assert(o % sizeof(TCGTemp) == 0);
+
+    return (void *)tcg_ctx + (uintptr_t)v;
+}
+#endif /* CONFIG_DEBUG_TCG */
+
 /* Return true if OP may appear in the opcode stream.
    Test the runtime variable that controls each opcode.  */
 bool tcg_op_supported(TCGOpcode op)
-- 
2.34.1


