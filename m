Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB813781634
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 03:03:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXAMI-0008QS-O9; Fri, 18 Aug 2023 21:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAMF-0008Pk-NB
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:28 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAMC-0007Kt-O2
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:27 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bf55a81eeaso2263395ad.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 18:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692406942; x=1693011742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y9w0S/pc005a7b816dzSReKj9icWPRL/k+/UuSXXFEo=;
 b=LJ9EY7UwyLgzVBBTfKdQGQxWSptb5GEpGbzqyTk4LuvspyCR9Jt2vC5XwXmyALnlWO
 nS+fF4Asmg9cYML3xZSQ/tqICsXZ9PJ0YGgV/CBwN6AoDkEf7wX7USEUvx/OS3lmQZgf
 mxpBrHP8DOl1WYzmwqJVRzYjnIoRBNRc7HA0dpv17ieo5bJpj+tyFDV8vSZavHpiG2yq
 JjMb34qdERaC7ClQSidxEvsWpK2pfqCGd7ROVmQaBorMwakKy5xkbzb5sT9H60T0poKN
 6xML3kjTZDSHygHE/ZKjZBB4MH1tJbBKB9HPuwmWaOkVmpDFho359KOIxD9cLJptVBA0
 JCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692406942; x=1693011742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y9w0S/pc005a7b816dzSReKj9icWPRL/k+/UuSXXFEo=;
 b=ILzAWkn4FMPSVbqT8KF7A5wQNAmfd2fbLMNBJy+/YpHJhPIiCgg2GU986ilcYGRula
 ciFiVeUyKUvo3DhznRR28ATTrsidjEdDhDtU84t2kO/j7KbQp0Zwkqrs3yqScnlmsqSk
 PlTLuJSttn/Pddpii7iYLiHxzZAPLBvbewpIt6029xr9TUwlXEmYJ09w/Gjc3De1wxSm
 2xC8jpoABjeb10ZKP6mQwe/BuDRqUKdH5LpT6ycqDA5Qx7/5VKAXJ0NdlVW4wd1BVpUv
 HDkPmWublsWdlN0qvDyeM6wv+zN3XGhnZkIHEH/dNmm9OCaoOmYYHCSSiAnxvKI/MifL
 X9EA==
X-Gm-Message-State: AOJu0YxOGiIvTJOFksKOKD1mqUHnwbcBgsGm4YDIhrTmxsPJEmOs4o+e
 Lvp5jUtrvpRHSbefb3ClMS0RLVrnbZkP7p89KhE=
X-Google-Smtp-Source: AGHT+IFwqr1baeCWcBN1Y5GF2odlcD3oHjUZzu89iIgVcoKmgghDQszqpQSt/dzbDiJIF+SLsBddgg==
X-Received: by 2002:a17:903:124e:b0:1bd:b8c0:b57e with SMTP id
 u14-20020a170903124e00b001bdb8c0b57emr855050plh.40.1692406942375; 
 Fri, 18 Aug 2023 18:02:22 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 b13-20020a170902d50d00b001b87bedcc6fsm2372019plg.93.2023.08.18.18.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 18:02:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH v2 02/18] target/arm: Use clmul_8* routines
Date: Fri, 18 Aug 2023 18:02:02 -0700
Message-Id: <20230819010218.192706-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230819010218.192706-1-richard.henderson@linaro.org>
References: <20230819010218.192706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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


