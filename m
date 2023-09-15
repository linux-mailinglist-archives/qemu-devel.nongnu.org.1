Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A3C7A23D2
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:45:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBtv-0004Qh-7u; Fri, 15 Sep 2023 12:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBtt-0004QN-NE
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:37 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBtr-0004sy-OT
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:37 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68c576d35feso2118524b3a.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694796154; x=1695400954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0e/zp7VtlxeASFRSSj/wbgTxg8eFq50bfESp96aa+Vg=;
 b=nznHy4yvS/+/CVlcHBCQyb5mr6F0ku8JnasA+UUo98x21HSqg/W9jsZCh7MEE7PHp8
 NyN9Izgff7ny0iE3gJGTSgGR68+IAjZqSkZfImol8nGFwn/GjxixUiMMBwtU5/8jNfmp
 rTbmS1wYDc60FjPpztvM7wVlqa1z++3sOOGHIBWn0DrernO2u184UImwPCL8EuygJ0zC
 t8PipW7pI4g6zGb+EV376hDXM+sfPrcBS/9o+9zc2o0pKtX1q8azMEa0aBqAjkmS5YwZ
 2KGSZcqunA77sYH7QcK31e4xaFzmZBcO4MgBEaqDbKV6Bbg1TiLSitkgRist93GIHr9/
 pPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694796154; x=1695400954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0e/zp7VtlxeASFRSSj/wbgTxg8eFq50bfESp96aa+Vg=;
 b=EMYzSdUBlojTW+ku7h+SX69qpSpQP+gE95BIeRYW8YhY+oAR/dkgL5RrGyUeR1BU04
 simEcJvdbvD+CQFsiCfdGxiV4V5bGCAsyNcBwT7naURx0jhspyiwPXfYSXin3lS2xqOq
 wwodlatR5p67sBSDyZypiVVxnrj2OSimbuZoam2UVBbtS7aV+5qGj9NUIW6QI8RvAtbi
 fzYjwoXanett+tYHRq0y9flZu6ZD23Qbk7/JHVf6mpA0lMKdkZM01crGIwNFshnqOFjg
 niuNgRGd6/loyXd8vPsTmwhzG/MWP9/2RnNL2/pR5rvz3coKlTwUDUjkueXWP9UKD8uM
 IXdA==
X-Gm-Message-State: AOJu0YxbN3H5axlxfXDCcRHZQ19eInBZ///XyWVtVT+HQiGiG269z6lN
 u4hIBK1AtdgFI9DfJJkDwfwky2+F7rX6KxSK1l0=
X-Google-Smtp-Source: AGHT+IHdxJvFou9raWMLJEcPFd50ZHXagAQ8oABVWgR5VArRaMi7bx12D+hFdWB/oljq+dw//ErzZw==
X-Received: by 2002:a05:6a21:2720:b0:157:609f:6012 with SMTP id
 rm32-20020a056a21272000b00157609f6012mr2153268pzb.61.1694796154461; 
 Fri, 15 Sep 2023 09:42:34 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 s187-20020a6377c4000000b00577f55e4a4esm3010087pgc.20.2023.09.15.09.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 09:42:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/19] target/arm: Use clmul_8* routines
Date: Fri, 15 Sep 2023 09:42:14 -0700
Message-Id: <20230915164231.123580-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915164231.123580-1-richard.henderson@linaro.org>
References: <20230915164231.123580-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Use generic routines for 8-bit carry-less multiply.
Remove our local version of pmull_h.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_internal.h |  5 ----
 target/arm/tcg/mve_helper.c   |  8 ++----
 target/arm/tcg/vec_helper.c   | 53 ++++-------------------------------
 3 files changed, 9 insertions(+), 57 deletions(-)

diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index 1f4ed80ff7..c4afba6d9f 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -219,11 +219,6 @@ int16_t do_sqrdmlah_h(int16_t, int16_t, int16_t, bool, bool, uint32_t *);
 int32_t do_sqrdmlah_s(int32_t, int32_t, int32_t, bool, bool, uint32_t *);
 int64_t do_sqrdmlah_d(int64_t, int64_t, int64_t, bool, bool);
 
-/*
- * 8 x 8 -> 16 vector polynomial multiply where the inputs are
- * in the low 8 bits of each 16-bit element
-*/
-uint64_t pmull_h(uint64_t op1, uint64_t op2);
 /*
  * 16 x 16 -> 32 vector polynomial multiply where the inputs are
  * in the low 16 bits of each 32-bit element
diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 403b345ea3..96ddfb4b3a 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -26,6 +26,7 @@
 #include "exec/exec-all.h"
 #include "tcg/tcg.h"
 #include "fpu/softfloat.h"
+#include "crypto/clmul.h"
 
 static uint16_t mve_eci_mask(CPUARMState *env)
 {
@@ -984,15 +985,12 @@ DO_2OP_L(vmulltuw, 1, 4, uint32_t, 8, uint64_t, DO_MUL)
  * Polynomial multiply. We can always do this generating 64 bits
  * of the result at a time, so we don't need to use DO_2OP_L.
  */
-#define VMULLPH_MASK 0x00ff00ff00ff00ffULL
 #define VMULLPW_MASK 0x0000ffff0000ffffULL
-#define DO_VMULLPBH(N, M) pmull_h((N) & VMULLPH_MASK, (M) & VMULLPH_MASK)
-#define DO_VMULLPTH(N, M) DO_VMULLPBH((N) >> 8, (M) >> 8)
 #define DO_VMULLPBW(N, M) pmull_w((N) & VMULLPW_MASK, (M) & VMULLPW_MASK)
 #define DO_VMULLPTW(N, M) DO_VMULLPBW((N) >> 16, (M) >> 16)
 
-DO_2OP(vmullpbh, 8, uint64_t, DO_VMULLPBH)
-DO_2OP(vmullpth, 8, uint64_t, DO_VMULLPTH)
+DO_2OP(vmullpbh, 8, uint64_t, clmul_8x4_even)
+DO_2OP(vmullpth, 8, uint64_t, clmul_8x4_odd)
 DO_2OP(vmullpbw, 8, uint64_t, DO_VMULLPBW)
 DO_2OP(vmullptw, 8, uint64_t, DO_VMULLPTW)
 
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 6712a2c790..cd630ff905 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -23,6 +23,7 @@
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
 #include "qemu/int128.h"
+#include "crypto/clmul.h"
 #include "vec_internal.h"
 
 /*
@@ -1986,21 +1987,11 @@ void HELPER(gvec_ushl_h)(void *vd, void *vn, void *vm, uint32_t desc)
  */
 void HELPER(gvec_pmul_b)(void *vd, void *vn, void *vm, uint32_t desc)
 {
-    intptr_t i, j, opr_sz = simd_oprsz(desc);
+    intptr_t i, opr_sz = simd_oprsz(desc);
     uint64_t *d = vd, *n = vn, *m = vm;
 
     for (i = 0; i < opr_sz / 8; ++i) {
-        uint64_t nn = n[i];
-        uint64_t mm = m[i];
-        uint64_t rr = 0;
-
-        for (j = 0; j < 8; ++j) {
-            uint64_t mask = (nn & 0x0101010101010101ull) * 0xff;
-            rr ^= mm & mask;
-            mm = (mm << 1) & 0xfefefefefefefefeull;
-            nn >>= 1;
-        }
-        d[i] = rr;
+        d[i] = clmul_8x8_low(n[i], m[i]);
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
@@ -2038,22 +2029,6 @@ void HELPER(gvec_pmull_q)(void *vd, void *vn, void *vm, uint32_t desc)
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
-/*
- * 8x8->16 polynomial multiply.
- *
- * The byte inputs are expanded to (or extracted from) half-words.
- * Note that neon and sve2 get the inputs from different positions.
- * This allows 4 bytes to be processed in parallel with uint64_t.
- */
-
-static uint64_t expand_byte_to_half(uint64_t x)
-{
-    return  (x & 0x000000ff)
-         | ((x & 0x0000ff00) << 8)
-         | ((x & 0x00ff0000) << 16)
-         | ((x & 0xff000000) << 24);
-}
-
 uint64_t pmull_w(uint64_t op1, uint64_t op2)
 {
     uint64_t result = 0;
@@ -2067,29 +2042,16 @@ uint64_t pmull_w(uint64_t op1, uint64_t op2)
     return result;
 }
 
-uint64_t pmull_h(uint64_t op1, uint64_t op2)
-{
-    uint64_t result = 0;
-    int i;
-    for (i = 0; i < 8; ++i) {
-        uint64_t mask = (op1 & 0x0001000100010001ull) * 0xffff;
-        result ^= op2 & mask;
-        op1 >>= 1;
-        op2 <<= 1;
-    }
-    return result;
-}
-
 void HELPER(neon_pmull_h)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     int hi = simd_data(desc);
     uint64_t *d = vd, *n = vn, *m = vm;
     uint64_t nn = n[hi], mm = m[hi];
 
-    d[0] = pmull_h(expand_byte_to_half(nn), expand_byte_to_half(mm));
+    d[0] = clmul_8x4_packed(nn, mm);
     nn >>= 32;
     mm >>= 32;
-    d[1] = pmull_h(expand_byte_to_half(nn), expand_byte_to_half(mm));
+    d[1] = clmul_8x4_packed(nn, mm);
 
     clear_tail(d, 16, simd_maxsz(desc));
 }
@@ -2102,10 +2064,7 @@ void HELPER(sve2_pmull_h)(void *vd, void *vn, void *vm, uint32_t desc)
     uint64_t *d = vd, *n = vn, *m = vm;
 
     for (i = 0; i < opr_sz / 8; ++i) {
-        uint64_t nn = (n[i] >> shift) & 0x00ff00ff00ff00ffull;
-        uint64_t mm = (m[i] >> shift) & 0x00ff00ff00ff00ffull;
-
-        d[i] = pmull_h(nn, mm);
+        d[i] = clmul_8x4_even(n[i] >> shift, m[i] >> shift);
     }
 }
 
-- 
2.34.1


