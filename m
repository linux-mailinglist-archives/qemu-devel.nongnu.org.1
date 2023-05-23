Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE8070DE5C
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:00:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1STB-0006eC-Ct; Tue, 23 May 2023 09:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSV-00056D-FU
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:52 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSS-00037m-1v
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:51 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-64d604cc0aaso2243932b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850027; x=1687442027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Mi17CjRnKz4wPdo7CNg1kS18indd07wo46SSX6kjRvg=;
 b=XUmaNWEDS7d31gEkK6by98OdvVyfgFx0kORiLM1SCNcB4QeqT2IwLx3XsUp8Oia/zp
 S82pZjFkNerHkG8uVlIVApc17jyhHEELiNVYaN9EIYho4W0nLGZ2Md1KZgs6Ys/fkVyq
 4BfiIPJfChtJkuqmL9SrFjitOwU7yTot1+0cz8HxNjrNZ9L5hQ1Lavmp+PSD4+4rK/T/
 2GDnGwGRuN7bBgz00CmfM+yX4NZg2x9pwnWuI2lh670YaoaZF6F0Zc9he3ERPKuCSHdO
 81grwIfCCY5gJgLtMhJxpX5Sn4NrkVaTLG/y+eu69HGJANrHkyONHRYhjwP89Pb+Wreg
 AM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850027; x=1687442027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mi17CjRnKz4wPdo7CNg1kS18indd07wo46SSX6kjRvg=;
 b=W2GH7HgMtaI+MSUCsiVFW1V0XRmmIpnICHtPZt54J1IITqzgCxSZnQOeRf/XCimhY3
 4Jf/PCIxiBdGAAiiSvqzt0QqCViqLPOyyZw0klpJABan8SxA3J2oZz4UJ9oTcH68CpkP
 kPp5NpXd+xbqF9GK7diSrejXjUSNK48kUwNFZhunQtu/DeA74Ha5fYAv3Z5sQRfBS2Eq
 vMxN/CD5ix/AVI1rZ8pPeniBoUQYEK1h3PDdmoD7ErnAXFHASinWV13/GsEp8unOtiCI
 VFjaqzNvI0FV5hWaLbW08fNWyWyT9n2jEhysDFV20rQXDH9dxOuMV4TmTQrhlzDin+Gp
 zv0A==
X-Gm-Message-State: AC+VfDxhqvjdiN43bD+G6orsS7no1poM+oFpko9z/FL/cSq5mTKGnxi/
 WvrNED+atqukLromtUz3fxxXGz27bqQf4kefI/U=
X-Google-Smtp-Source: ACHHUZ7OLeDl0CgYeNhJuhtKlOpZ/FwTl/wdkNSINNC43wQ2Yni8tq4w3n8UYOTN4qpiB60ZSaOfSw==
X-Received: by 2002:a05:6a20:8f14:b0:10b:27d0:70cc with SMTP id
 b20-20020a056a208f1400b0010b27d070ccmr10045239pzk.20.1684850026874; 
 Tue, 23 May 2023 06:53:46 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020aa78708000000b0064d27a28451sm5796111pfo.100.2023.05.23.06.53.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:53:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 28/52] tcg: Move TLB_FLAGS_MASK check out of
 get_alignment_bits
Date: Tue, 23 May 2023 06:52:58 -0700
Message-Id: <20230523135322.678948-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
index 55338ef0d7..02827b96cc 100644
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


