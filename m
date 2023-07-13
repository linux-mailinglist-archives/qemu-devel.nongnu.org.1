Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3453E752C0B
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 23:19:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK3eK-0000Ik-Jb; Thu, 13 Jul 2023 17:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eF-0000HU-8U
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:14:51 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3e9-00015r-Od
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:14:50 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3143b72c5ffso1381132f8f.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 14:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689282884; x=1691874884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ECUmLrNCqZ555vv9lbCs7tRpJNSGqq32nj0uXtVER3w=;
 b=Hv8oVkwOKaCPvjob4KH39+wO4CMkpG4G7b2cLB/nEgUopWSn1CxrY5NVHuvn88iI3e
 hLuILbBpANTIw/Ro7RXzM0hXQI3MKOF3b8O6QWSN5BrkLgc4VM48uTQEFWmi01iodu0L
 NSiXETdZ4CgE8TTDO2+/gjGD7XvYvltedD0BTYKZpRz+HaMt7AGeKHbIO7kkGwymm2tR
 ClCLyNutfy9yZ4g50p74OfnvFmMGEnqDrxWMCY7LZ6PUze1yYrWZNRVNpPtLtqAz/Et/
 byqST9UbISZ7yzBnPRK1FZHveop3nLFoK3mfMuOC37i0LdDYSJ/Htk0FpCv0jVWsMMaQ
 w5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689282884; x=1691874884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ECUmLrNCqZ555vv9lbCs7tRpJNSGqq32nj0uXtVER3w=;
 b=Ezp5axgzFdVy6+qlAIITqfnpb8Fjw26a87bq4w73sZC+yWTvfOUdxrd2JMyWrhVQPt
 fr1Hv2mIk88/4xSc4qVXU8T+O56TPKdYee36WUHD43JWHJC2TEt7wcOe9Jqbf/FiCHZ+
 5tyGam0xfF5O+P7Tvj+QuAQaSX26b3whXeA9GerRss30HTuZfWNdf1d7Z534DggUdVa7
 6eoPutoBeAZxVciQMNod6aDNloe/Xce2MdedjNG+aT8ZHtUpGkisfEescbYgmvxYpkZr
 ok1jUmbKCktmRYxVdvsgQqxGQUBeN+FuYo4GtFms9lImtNPq7CdC0z80fCaW3W9YXIfW
 ohfg==
X-Gm-Message-State: ABy/qLaCxRcEvSQU1IvwCAWehyFGW8nMynWUxRM0IXFtfGX82zfAo5yR
 t3Qro2zJoyZeKa1dTRiirOq5XXu6JMq37ouQDU9oBuZu
X-Google-Smtp-Source: APBJJlHduO1/NOHHkA0B+G1bmgpglSFCFQT21Vz3rlnVMQKONPiBC6yfLzmZijeaGzj2ZG5aH75Piw==
X-Received: by 2002:adf:cf11:0:b0:313:e520:936f with SMTP id
 o17-20020adfcf11000000b00313e520936fmr2864031wrj.17.1689282884324; 
 Thu, 13 Jul 2023 14:14:44 -0700 (PDT)
Received: from stoup.. ([85.193.156.66]) by smtp.gmail.com with ESMTPSA id
 n12-20020adff08c000000b0030ada01ca78sm8973747wro.10.2023.07.13.14.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 14:14:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH 02/18] target/arm: Use clmul_8* routines
Date: Thu, 13 Jul 2023 22:14:19 +0100
Message-Id: <20230713211435.13505-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713211435.13505-1-richard.henderson@linaro.org>
References: <20230713211435.13505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_internal.h |  5 ---
 target/arm/tcg/mve_helper.c   |  8 ++---
 target/arm/tcg/vec_helper.c   | 63 +++++++----------------------------
 3 files changed, 15 insertions(+), 61 deletions(-)

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
index f59d3b26ea..4384b6c188 100644
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
@@ -2067,30 +2042,14 @@ uint64_t pmull_w(uint64_t op1, uint64_t op2)
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
-    uint64_t nn = n[hi], mm = m[hi];
-
-    d[0] = pmull_h(expand_byte_to_half(nn), expand_byte_to_half(mm));
-    nn >>= 32;
-    mm >>= 32;
-    d[1] = pmull_h(expand_byte_to_half(nn), expand_byte_to_half(mm));
+    Int128 r = clmul_8x8_packed(n[hi], m[hi]);
 
+    d[0] = int128_getlo(r);
+    d[1] = int128_gethi(r);
     clear_tail(d, 16, simd_maxsz(desc));
 }
 
@@ -2101,11 +2060,13 @@ void HELPER(sve2_pmull_h)(void *vd, void *vn, void *vm, uint32_t desc)
     intptr_t i, opr_sz = simd_oprsz(desc);
     uint64_t *d = vd, *n = vn, *m = vm;
 
-    for (i = 0; i < opr_sz / 8; ++i) {
-        uint64_t nn = (n[i] >> shift) & 0x00ff00ff00ff00ffull;
-        uint64_t mm = (m[i] >> shift) & 0x00ff00ff00ff00ffull;
+    for (i = 0; i < opr_sz / 8; i += 2) {
+        Int128 nn = int128_make128(n[i] >> shift, n[i + 1] >> shift);
+        Int128 mm = int128_make128(m[i] >> shift, m[i + 1] >> shift);
+        Int128 r = clmul_8x8_even(nn, mm);
 
-        d[i] = pmull_h(nn, mm);
+        d[0] = int128_getlo(r);
+        d[1] = int128_gethi(r);
     }
 }
 
-- 
2.34.1


