Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 494C572314C
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:27:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Gcv-0001xj-2o; Mon, 05 Jun 2023 16:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gck-0001vb-Lz
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:19 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gch-0003nm-1D
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:18 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-650c8cb68aeso3084570b3a.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996174; x=1688588174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N6gCotNJADYlI+Iq7qcqhdrgKIsALIeK+sX1hBJ35+c=;
 b=N5kI5gQWcK663zgbSDcfV6GeOzc1zbabB60uxt99Lytt9SoXflhCHFtk6j9ANt4574
 l4K3n+U55FPdV22h8igAwWMrs0pL/P9A1cXzpaliQ8K4YCFK9bLBt51Z6tVcf0AhliCG
 LPjPkIApLqT9qI5/TG6a1wykwUcbmkAIMG79ucv1Q/LkpcT9rLhKyVuSIX2S8S+G2Fqt
 ZAyjEKK9OKsKQT6lETYE1BRv6AtL1vWmQbettph7FVB+ECzrLNjFBO+ZoDOgrZ9QBoKR
 An8BLu8Z40EXeR0W//5zX7UkOW3KI0xfE44bOStTLAcAmpwYGpl1mK8hpwE+6uytqXse
 A1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996174; x=1688588174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N6gCotNJADYlI+Iq7qcqhdrgKIsALIeK+sX1hBJ35+c=;
 b=KB9qh/GiCOu/V3RSzCGV6tcr2aOOtuLWsQxQPVu4Tv1foN6aNQ4bRwSOyNn3gr5MDT
 My0VjL1EYXbxTNmgWxRUjsHZujYhBZAMdiQ59OvHZTyi1g2Kujc3V8xM7SUqIvG+iISR
 8fFn6TFvq9ZfroWMDLK0j+78xtabVYMxsyaxGCxBOEG+yiYSVSvxQqVPKAaR9GbTWnnk
 xlgLNqRv0I2CUu0lPft12KGC7eko/6kSw8a5ubJdSjmLemmtOATfhUpIRstECA4yGKTT
 gPrZNP4HA8cARHu38BiKuE1WqQnUfW7B1gzPGmRv1bmjt+PkrA4TGvFQhGqJNJ6z9Sz5
 lwHQ==
X-Gm-Message-State: AC+VfDyJeQD+rbIxVyIWt5jVNgZAQcrBikn4xzw3GXIF93GsmgKsADuY
 SJLDHx3poZjY+jtpQbFIhc6aQgY0VLfekKO1sds=
X-Google-Smtp-Source: ACHHUZ47m9loV5djPdwyEwLogUY0WXlHyWQT3Bz+mmHflvg2eEh8bHokhHHTb7iWTkNxeCwWi7Dudw==
X-Received: by 2002:a05:6a00:198c:b0:64d:6a78:1575 with SMTP id
 d12-20020a056a00198c00b0064d6a781575mr592131pfl.30.1685996174243; 
 Mon, 05 Jun 2023 13:16:14 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:16:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 28/52] tcg: Move TLB_FLAGS_MASK check out of get_alignment_bits
Date: Mon,  5 Jun 2023 13:15:24 -0700
Message-Id: <20230605201548.1596865-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

The replacement isn't ideal, as the raw count of bits
is not easily synced with exec/cpu-all.h, but it does
remove from tcg.h the target dependency on TARGET_PAGE_BITS_MIN
which is built into TLB_FLAGS_MASK.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h |  3 +++
 include/tcg/tcg.h      |  4 ----
 tcg/tcg-op-ldst.c      | 18 ++++++++++++++++--
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 78d258af44..09bf4c0cc6 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -314,6 +314,9 @@ CPUArchState *cpu_copy(CPUArchState *env);
  *
  * Use TARGET_PAGE_BITS_MIN so that these bits are constant
  * when TARGET_PAGE_BITS_VARY is in effect.
+ *
+ * The count, if not the placement of these bits is known
+ * to tcg/tcg-op-ldst.c, check_max_alignment().
  */
 /* Zero if TLB entry is valid.  */
 #define TLB_INVALID_MASK    (1 << (TARGET_PAGE_BITS_MIN - 1))
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 9f607e2664..635fa53fdb 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -305,10 +305,6 @@ static inline unsigned get_alignment_bits(MemOp memop)
         /* A specific alignment requirement.  */
         a = a >> MO_ASHIFT;
     }
-#if defined(CONFIG_SOFTMMU)
-    /* The requested alignment cannot overlap the TLB flags.  */
-    tcg_debug_assert((TLB_FLAGS_MASK & ((1 << a) - 1)) == 0);
-#endif
     return a;
 }
 
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 9bcf63b041..46a5977b35 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -32,11 +32,23 @@
 #include "tcg-internal.h"
 
 
-static inline MemOp tcg_canonicalize_memop(MemOp op, bool is64, bool st)
+static void check_max_alignment(unsigned a_bits)
+{
+#if defined(CONFIG_SOFTMMU)
+    /*
+     * The requested alignment cannot overlap the TLB flags.
+     * FIXME: Must keep the count up-to-date with "exec/cpu-all.h".
+     */
+    tcg_debug_assert(a_bits + 6 <= tcg_ctx->page_bits);
+#endif
+}
+
+static MemOp tcg_canonicalize_memop(MemOp op, bool is64, bool st)
 {
-    /* Trigger the asserts within as early as possible.  */
     unsigned a_bits = get_alignment_bits(op);
 
+    check_max_alignment(a_bits);
+
     /* Prefer MO_ALIGN+MO_XX over MO_ALIGN_XX+MO_XX */
     if (a_bits == (op & MO_SIZE)) {
         op = (op & ~MO_AMASK) | MO_ALIGN;
@@ -491,6 +503,7 @@ static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
     TCGv_i64 ext_addr = NULL;
     TCGOpcode opc;
 
+    check_max_alignment(get_alignment_bits(memop));
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
 
     /* TODO: For now, force 32-bit hosts to use the helper. */
@@ -599,6 +612,7 @@ static void tcg_gen_qemu_st_i128_int(TCGv_i128 val, TCGTemp *addr,
     TCGv_i64 ext_addr = NULL;
     TCGOpcode opc;
 
+    check_max_alignment(get_alignment_bits(memop));
     tcg_gen_req_mo(TCG_MO_ST_LD | TCG_MO_ST_ST);
 
     /* TODO: For now, force 32-bit hosts to use the helper. */
-- 
2.34.1


