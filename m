Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6077174C5
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:07:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D4D-0007Zy-0u; Wed, 31 May 2023 00:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D43-0007LX-RR
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:59 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3x-0006F8-OV
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:59 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6af78ce91b1so4019364a34.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685505832; x=1688097832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FpsiEKfnqW5NbDGhLSvOzaFmUVIfxdNdu/8iXWH9zvk=;
 b=WC3WgmJaafaWePmN0gtPh8gnuVswjP5jnltw7UfES7qBvdkwO0flAUgTT7wwd8/w39
 gO9x4bkXLDksm3HZZWZ5pwBpcFTsKEV5jNL0+8Fg/eySkFYTzMHvU7fJMYFscj0VoJpH
 cC0LnJlHKufuxUlGFUvcsLovMgwzz+4pA09pV2W5IQ0Ykq/NeBlaTlaCA4q66iOmSYGg
 moa+6WRl1+oZSE5slfJGpDICWTW3OUzyKCz1S96ZYTw4oZYNxgRXsnK5DlEHWggAVZPe
 WnPEj122Dv6R0ZX4V8yATLL1w9R9J0SOr9bwmw+u0LvEhHzH2Is2p7gtZ/EsPtg2/XtU
 gADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685505832; x=1688097832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FpsiEKfnqW5NbDGhLSvOzaFmUVIfxdNdu/8iXWH9zvk=;
 b=YNQNh9uussIVsKuBuavfD8lGEVjOAHtotBA5CkKp0+5hsVmXSytteMsozlkx2Wj+kZ
 69ztGYigRQbKlDOHSMaN47DeFFAeJFhuRBNUhU2RCnKR0dzz6b5V+lZjWPNKXDSKEWgk
 jsZ3ufbQFsgF/FmS6WFxn7ULH5hBsv8qQW8Au2g1PeuC3Q+iUXLKyYOZ+YoWGSv4Or2t
 TJPzeRidMHho4UdEfEdSQe1noaeus+ZiXyqIxjxYFo1R3V7uaEwfCDQCeB6bEn2MDQUg
 S7ie8wfce7q7tHAk98hrAGu+RtSUWNzT12MNfVvk63qwAQnqJb0dBGChsedDl0s4XVY5
 zqQQ==
X-Gm-Message-State: AC+VfDwCggABtoJa/DAf+Hr1MP3hUyk++9gO89+FcjreM0klNwG3IAge
 FEyjr+j2mUB5lqhC+GwmkXJg7jIyQQPVLL3mp2U=
X-Google-Smtp-Source: ACHHUZ5FpQjU3/sLk2xJ+KdJeNEmHRzhKYbUkI8baUV6nUmMbZMEyLtDFpjnqfU7eSEgG2u8g+/nCA==
X-Received: by 2002:a54:4419:0:b0:396:3969:a4a6 with SMTP id
 k25-20020a544419000000b003963969a4a6mr2601882oiw.18.1685505832250; 
 Tue, 30 May 2023 21:03:52 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a63fc0c000000b005348af1b84csm194814pgi.74.2023.05.30.21.03.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:03:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 27/48] tcg: Move TLB_FLAGS_MASK check out of
 get_alignment_bits
Date: Tue, 30 May 2023 21:03:09 -0700
Message-Id: <20230531040330.8950-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


