Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D0F72A1BB
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 19:59:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7gNs-0002jb-Hj; Fri, 09 Jun 2023 13:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7gNq-0002jS-Jd
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 13:58:46 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7gNp-00065E-03
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 13:58:46 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1b038064d97so8695955ad.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 10:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686333523; x=1688925523;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=c/wl6AIRwCwLEE+eL/SEVevm1nVx7++ClIFkrg2643g=;
 b=spyaCQBQnr++ItQQiHzNf+sEe7jHyb2dIeVzUrQrmhxomgginQCMOVtr6YeifKA7AD
 M8Uod47n0yncCsdfne3bOsW8djVgokEk9WsooKdoX3H54/gTY+OuCXSbxXliHAyF46ud
 NLO2jRRfuWYD8DjgbGmvrsNMSuR7v1SbqpTblSE1tg8r5g3m8lddlS3q/MiO99LDSum7
 KGJoCrfNTsyDaDRmMHzElgtu7440czuxD8oxSlaVuToDd+U0pqQsxOMKNrNSbi09UZyA
 vme6zlytfpudKEn70AjivV8883GMtywQhbpH3U71W7QCpVRHZjYpoa78H5nGy7xYRDLy
 gI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686333523; x=1688925523;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c/wl6AIRwCwLEE+eL/SEVevm1nVx7++ClIFkrg2643g=;
 b=G+aoFhpyAlp7dYRhJD1MKjKoISS6ZV4O+LFN/1XfH8OQcq98f9q9j8YaEatlaSVG4A
 m2xZ5SSf9Ed5T7nqFw91TGAvRPUQ2t11V5DYkBYYkSRtUtnmQSWDDyNXx4nrTKJIR/wG
 BcEV7MTgepV8wvLqxUlPLKW28q+rxBTW4aymD+4yNwkGE2sh/5HpiJWDnC6GRlBhnaXv
 2xHMUAgZZnVvzuxGnMQ/7dESSZFO8HrjBi+PJC8HmVT1HFB2Qucqynbx1PchJHkzsfeY
 cheYTga9PlhBLvjy0YFYvJ1WEGb8fk68EhBJU9AD4oKD/iSeAG/Lu22hq9JPezAQIXDF
 5IzQ==
X-Gm-Message-State: AC+VfDwwvrIi4Np90Rtz9bS35M1l6q/CB5G5I2aoGkdDX6tzDW+ef2BG
 OpXBqpViaLWazssdkUUgBcn4NpHmsdhaAKpjE5c=
X-Google-Smtp-Source: ACHHUZ5tFoz8HnYJRQkALoxFNassS3f4gt0lyE7cCCWMR+GMFYXXabpxCMTB0BhUA1lgp5JTCUXi1g==
X-Received: by 2002:a17:903:32cd:b0:1af:e302:123 with SMTP id
 i13-20020a17090332cd00b001afe3020123mr3275309plr.3.1686333523241; 
 Fri, 09 Jun 2023 10:58:43 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:20be:c4cb:f609:8cca])
 by smtp.gmail.com with ESMTPSA id
 iy11-20020a170903130b00b001a260b5319bsm3565481plb.91.2023.06.09.10.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jun 2023 10:58:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH] host/include/x86_64: Use __m128i for "x" constraints
Date: Fri,  9 Jun 2023 10:58:41 -0700
Message-Id: <20230609175841.748017-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

The macOS catalina compiler produces an error for __int128_t
as the type for allocation with SSE inline asm constraint.
Create a new X86Int128Union type and use the vector type for
all SSE register inputs and outputs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/x86_64/host/atomic128-ldst.h     | 25 ++++++++++++-------
 .../x86_64/host/load-extract-al16-al8.h       |  8 +++---
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/host/include/x86_64/host/atomic128-ldst.h b/host/include/x86_64/host/atomic128-ldst.h
index adc9332f91..8d6f909d3c 100644
--- a/host/include/x86_64/host/atomic128-ldst.h
+++ b/host/include/x86_64/host/atomic128-ldst.h
@@ -8,12 +8,19 @@
  * atomic primitive is meant to provide.
  */
 
-#ifndef AARCH64_ATOMIC128_LDST_H
-#define AARCH64_ATOMIC128_LDST_H
+#ifndef X86_64_ATOMIC128_LDST_H
+#define X86_64_ATOMIC128_LDST_H
 
 #ifdef CONFIG_INT128_TYPE
 #include "host/cpuinfo.h"
 #include "tcg/debug-assert.h"
+#include <immintrin.h>
+
+typedef union {
+    __m128i v;
+    __int128_t i;
+    Int128 s;
+} X86Int128Union;
 
 /*
  * Through clang 16, with -mcx16, __atomic_load_n is incorrectly
@@ -25,10 +32,10 @@
 
 static inline Int128 atomic16_read_ro(const Int128 *ptr)
 {
-    Int128Alias r;
+    X86Int128Union r;
 
     tcg_debug_assert(HAVE_ATOMIC128_RO);
-    asm("vmovdqa %1, %0" : "=x" (r.i) : "m" (*ptr));
+    asm("vmovdqa %1, %0" : "=x" (r.v) : "m" (*ptr));
 
     return r.s;
 }
@@ -36,10 +43,10 @@ static inline Int128 atomic16_read_ro(const Int128 *ptr)
 static inline Int128 atomic16_read_rw(Int128 *ptr)
 {
     __int128_t *ptr_align = __builtin_assume_aligned(ptr, 16);
-    Int128Alias r;
+    X86Int128Union r;
 
     if (HAVE_ATOMIC128_RO) {
-        asm("vmovdqa %1, %0" : "=x" (r.i) : "m" (*ptr_align));
+        asm("vmovdqa %1, %0" : "=x" (r.v) : "m" (*ptr_align));
     } else {
         r.i = __sync_val_compare_and_swap_16(ptr_align, 0, 0);
     }
@@ -49,10 +56,10 @@ static inline Int128 atomic16_read_rw(Int128 *ptr)
 static inline void atomic16_set(Int128 *ptr, Int128 val)
 {
     __int128_t *ptr_align = __builtin_assume_aligned(ptr, 16);
-    Int128Alias new = { .s = val };
+    X86Int128Union new = { .s = val };
 
     if (HAVE_ATOMIC128_RO) {
-        asm("vmovdqa %1, %0" : "=m"(*ptr_align) : "x" (new.i));
+        asm("vmovdqa %1, %0" : "=m"(*ptr_align) : "x" (new.v));
     } else {
         __int128_t old;
         do {
@@ -65,4 +72,4 @@ static inline void atomic16_set(Int128 *ptr, Int128 val)
 #include "host/include/generic/host/atomic128-ldst.h"
 #endif
 
-#endif /* AARCH64_ATOMIC128_LDST_H */
+#endif /* X86_64_ATOMIC128_LDST_H */
diff --git a/host/include/x86_64/host/load-extract-al16-al8.h b/host/include/x86_64/host/load-extract-al16-al8.h
index 31b6fe8c45..baa506b7b5 100644
--- a/host/include/x86_64/host/load-extract-al16-al8.h
+++ b/host/include/x86_64/host/load-extract-al16-al8.h
@@ -9,7 +9,7 @@
 #define X86_64_LOAD_EXTRACT_AL16_AL8_H
 
 #ifdef CONFIG_INT128_TYPE
-#include "host/cpuinfo.h"
+#include "host/atomic128-ldst.h"
 
 /**
  * load_atom_extract_al16_or_al8:
@@ -26,7 +26,7 @@ load_atom_extract_al16_or_al8(void *pv, int s)
     uintptr_t pi = (uintptr_t)pv;
     __int128_t *ptr_align = (__int128_t *)(pi & ~7);
     int shr = (pi & 7) * 8;
-    Int128Alias r;
+    X86Int128Union r;
 
     /*
      * ptr_align % 16 is now only 0 or 8.
@@ -35,9 +35,9 @@ load_atom_extract_al16_or_al8(void *pv, int s)
      * when ptr_align % 16 == 0 for 16-byte atomicity.
      */
     if ((cpuinfo & CPUINFO_ATOMIC_VMOVDQU) || (pi & 8)) {
-        asm("vmovdqu %1, %0" : "=x" (r.i) : "m" (*ptr_align));
+        asm("vmovdqu %1, %0" : "=x" (r.v) : "m" (*ptr_align));
     } else {
-        asm("vmovdqa %1, %0" : "=x" (r.i) : "m" (*ptr_align));
+        asm("vmovdqa %1, %0" : "=x" (r.v) : "m" (*ptr_align));
     }
     return int128_getlo(int128_urshift(r.s, shr));
 }
-- 
2.34.1


