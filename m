Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0BC7174D8
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:08:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D44-0007L4-5Y; Wed, 31 May 2023 00:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3v-000786-P9
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:51 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3t-0006DM-Ou
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:51 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-38e04d1b2b4so3145814b6e.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685505827; x=1688097827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JkfCVYtOQPSZwEFrSi7JnvJQTXM32d4BcQySbfTzPFo=;
 b=gS2mA6UhWdAKyLxvlk+X++WHX6c+cE7zoU+gfBEzrM7yBsxZeIUJvgWelMsD+DOmyz
 zFAc34PFDs2Y8YnXeOwEKhwuKD6yyymMFJg8TKhBoF8Pie8lxhDjuxygQha/HmI108GQ
 Mr7vMtXgK5Ay/yADy6JqQf4wXJEQjnbZkjFfJ+eKAlpAUKEqGYycOcQHbtf0wUHyBu1d
 GP3daDpX2a46/7Wes3vvv3zCc1gCPtM5lSApHOREbi9X0hKetJ3fzYaGME+esA5ptHsy
 vPs8fxrccvRC1xqXt0ElErGDs/Z5b6jqVztTz0d9SFNWQ9yYjO0ogEByv9m5SD3DZKxN
 5U5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685505827; x=1688097827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JkfCVYtOQPSZwEFrSi7JnvJQTXM32d4BcQySbfTzPFo=;
 b=hURRI0oaYdrakYPitHP8k0VUAENK91VMaXCLXgZdP9QjcvhUMERUXuc+oyO2e11/1y
 1AABYre9CuxJo/FgV/BJjgtLezTR5eCoRqg4tuyG0JCMeo7AbpkuSQWQ0ao2tOLf6mVn
 LXMH4Qt/slJsbzgyhad0dn+bbPVnLjR7BOpPjEpZlizXo240g3eRxAEmTCuqLK4uMSfa
 KIwAXt60W+0kC8MYmbxgQkXtAnywv10z+79sBuwp1E8XGi7qJQaGhACN8u4Q0d6Bf4mb
 PJY0/H0YwTQ0Z/Z7d7cCT2mO7eJUDbR+t+98uf1vzMC0X9BkLNG/7ocaVQOYbWLuswpc
 Q3nw==
X-Gm-Message-State: AC+VfDyMw9OMBc9go179UftMwv4FFkd25fK7qW92WMhWC2B5S/Nprds0
 Mci/ym1OMANlAZZM9Jldb3yJI0OQD42ugnRdFJw=
X-Google-Smtp-Source: ACHHUZ4m6itFJWeREIUFZ7H52D1mHtttTsDot7idG/2uYrMbNk97rh7zXJV/Thd26rlN9ZVyTs4Jvg==
X-Received: by 2002:a54:450c:0:b0:38c:c177:a6bb with SMTP id
 l12-20020a54450c000000b0038cc177a6bbmr2769269oil.23.1685505827553; 
 Tue, 30 May 2023 21:03:47 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a63fc0c000000b005348af1b84csm194814pgi.74.2023.05.30.21.03.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:03:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 21/48] tcg: Move temp_idx and tcgv_i32_temp debug out of
 line
Date: Tue, 30 May 2023 21:03:03 -0700
Message-Id: <20230531040330.8950-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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
index ffd3ccaff7..59624fceec 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1800,6 +1800,25 @@ TCGv_vec tcg_constant_vec_matching(TCGv_vec match, unsigned vece, int64_t val)
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


