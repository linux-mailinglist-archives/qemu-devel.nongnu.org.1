Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2123470EA09
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 02:07:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1bu7-0004O9-Nd; Tue, 23 May 2023 19:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btl-0004JA-Ik
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:37 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1bta-0001rX-T4
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:37 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-64d44b198baso104091b3a.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 16:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684886305; x=1687478305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b5v8Jw3T9w8HbbAUjH4p5nPo8yur91Ib1kP6ESGvdT8=;
 b=SAZ95qdo2K2OaAuWf2wnqkyNwkdBMdn1qAMkOHs0ZYjsoeagJ745LCfhnWsmRgwPET
 5unrCNAb3a2oL4F+eMmzKJ3ZDUwE7pSoLLMznLWnYrG7cMJvw6g0L02BFaEfhPVuiu3S
 GUj7kJJj9AWZqliQQCkAG8v2J0cl1D1A2RtQwcNZ3RpO5qkscNtjyIq52nZpoXeJfWw/
 r/32cwlzOQPOUGTONxJJszvcNXQxjO2xPf7xCMmPAGsnQvwiTVzH7RnYq+hRUhb5JYu8
 jcUyEj8kQgOq9k/zuZvH3rpw5LdwrjADG0ZlfcZnQr0WlqJuG+Um1xM6cPsnJASdQYgL
 6a/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684886305; x=1687478305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b5v8Jw3T9w8HbbAUjH4p5nPo8yur91Ib1kP6ESGvdT8=;
 b=XQ3AF2+NhqVUAKq+KStKWH4dC6WyemcNtr6JUSgt3h7RH/fvW3i2sbjk9crArVB09l
 rPkkC0bYnxrSxvlEoRs035gT6Kbg3BU0cW8xF6DqVxyoPfzVdIpAyPQVpyQF/BQfIkR/
 KxUNpMjzVcF6Mp+tygRQB3gaMRsKkDbHHJnUiHnl/+7u3eR0RIR3XIiis3rJ4O3AGDir
 Zs9xqQztmZjWJEDffaWMMIepH432NYnDqbbAEipf7xnRGhxJBbW69subte5h0D0kIXis
 H74B0W5cqIcqSkFRTEpTG3XoA3T0pvNRdakSBcmGHZQCZ+xtN+cax/lZRO7mA8O+5Vh0
 VRew==
X-Gm-Message-State: AC+VfDwotjDGqGPWauL3frUT2MzF8mvhh7xAU0EZFWmCb+8tRvZW/oiA
 fo3SEDfLKNsj/bUEozIOSRcpXRqbGUymo/mu9rg=
X-Google-Smtp-Source: ACHHUZ5T4+tyoxLiy2XCQ5bcNgPpTriORlTKa1nJlna3A3/JdzxI9g73LSGN6Osg/Xp9u7GwvmRBmA==
X-Received: by 2002:a05:6a00:24c8:b0:64f:31cd:4e4a with SMTP id
 d8-20020a056a0024c800b0064f31cd4e4amr708123pfv.12.1684886305488; 
 Tue, 23 May 2023 16:58:25 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 p18-20020aa78612000000b0063b7c42a070sm6285041pfn.68.2023.05.23.16.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 16:58:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 23/28] accel/tcg: Correctly use atomic128.h in
 ldst_atomicity.c.inc
Date: Tue, 23 May 2023 16:57:59 -0700
Message-Id: <20230523235804.747803-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523235804.747803-1-richard.henderson@linaro.org>
References: <20230523235804.747803-1-richard.henderson@linaro.org>
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

Remove the locally defined load_atomic16 and store_atomic16,
along with HAVE_al16 and HAVE_al16_fast in favor of the
routines defined in atomic128.h.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c             |   2 +-
 accel/tcg/ldst_atomicity.c.inc | 118 +++++++--------------------------
 2 files changed, 24 insertions(+), 96 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 0bd06bf894..90c72c9940 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2712,7 +2712,7 @@ static uint64_t do_st16_leN(CPUArchState *env, MMULookupPageData *p,
 
     case MO_ATOM_WITHIN16_PAIR:
         /* Since size > 8, this is the half that must be atomic. */
-        if (!HAVE_al16) {
+        if (!HAVE_ATOMIC128_RW) {
             cpu_loop_exit_atomic(env_cpu(env), ra);
         }
         return store_whole_le16(p->haddr, p->size, val_le);
diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
index b89631bbef..0f6b3f8ab6 100644
--- a/accel/tcg/ldst_atomicity.c.inc
+++ b/accel/tcg/ldst_atomicity.c.inc
@@ -16,18 +16,6 @@
 #endif
 #define HAVE_al8_fast      (ATOMIC_REG_SIZE >= 8)
 
-#if defined(CONFIG_ATOMIC128)
-# define HAVE_al16_fast    true
-#else
-# define HAVE_al16_fast    false
-#endif
-#if defined(CONFIG_ATOMIC128) || defined(CONFIG_CMPXCHG128)
-# define HAVE_al16         true
-#else
-# define HAVE_al16         false
-#endif
-
-
 /**
  * required_atomicity:
  *
@@ -146,26 +134,6 @@ static inline uint64_t load_atomic8(void *pv)
     return qatomic_read__nocheck(p);
 }
 
-/**
- * load_atomic16:
- * @pv: host address
- *
- * Atomically load 16 aligned bytes from @pv.
- */
-static inline Int128 ATTRIBUTE_ATOMIC128_OPT
-load_atomic16(void *pv)
-{
-#ifdef CONFIG_ATOMIC128
-    __uint128_t *p = __builtin_assume_aligned(pv, 16);
-    Int128Alias r;
-
-    r.u = qatomic_read__nocheck(p);
-    return r.s;
-#else
-    qemu_build_not_reached();
-#endif
-}
-
 /**
  * load_atomic8_or_exit:
  * @env: cpu context
@@ -211,8 +179,8 @@ static Int128 load_atomic16_or_exit(CPUArchState *env, uintptr_t ra, void *pv)
 {
     Int128 *p = __builtin_assume_aligned(pv, 16);
 
-    if (HAVE_al16_fast) {
-        return load_atomic16(p);
+    if (HAVE_ATOMIC128_RO) {
+        return atomic16_read_ro(p);
     }
 
 #ifdef CONFIG_USER_ONLY
@@ -232,14 +200,9 @@ static Int128 load_atomic16_or_exit(CPUArchState *env, uintptr_t ra, void *pv)
      * In system mode all guest pages are writable, and for user-only
      * we have just checked writability.  Try cmpxchg.
      */
-#if defined(CONFIG_CMPXCHG128)
-    /* Swap 0 with 0, with the side-effect of returning the old value. */
-    {
-        Int128Alias r;
-        r.u = __sync_val_compare_and_swap_16((__uint128_t *)p, 0, 0);
-        return r.s;
+    if (HAVE_ATOMIC128_RW) {
+        return atomic16_read_rw(p);
     }
-#endif
 
     /* Ultimate fallback: re-execute in serial context. */
     cpu_loop_exit_atomic(env_cpu(env), ra);
@@ -360,11 +323,10 @@ static uint64_t load_atom_extract_al16_or_exit(CPUArchState *env, uintptr_t ra,
 static inline uint64_t ATTRIBUTE_ATOMIC128_OPT
 load_atom_extract_al16_or_al8(void *pv, int s)
 {
-#if defined(CONFIG_ATOMIC128)
     uintptr_t pi = (uintptr_t)pv;
     int o = pi & 7;
     int shr = (HOST_BIG_ENDIAN ? 16 - s - o : o) * 8;
-    __uint128_t r;
+    Int128 r;
 
     pv = (void *)(pi & ~7);
     if (pi & 8) {
@@ -373,18 +335,14 @@ load_atom_extract_al16_or_al8(void *pv, int s)
         uint64_t b = qatomic_read__nocheck(p8 + 1);
 
         if (HOST_BIG_ENDIAN) {
-            r = ((__uint128_t)a << 64) | b;
+            r = int128_make128(b, a);
         } else {
-            r = ((__uint128_t)b << 64) | a;
+            r = int128_make128(a, b);
         }
     } else {
-        __uint128_t *p16 = __builtin_assume_aligned(pv, 16, 0);
-        r = qatomic_read__nocheck(p16);
+        r = atomic16_read_ro(pv);
     }
-    return r >> shr;
-#else
-    qemu_build_not_reached();
-#endif
+    return int128_getlo(int128_urshift(r, shr));
 }
 
 /**
@@ -472,7 +430,7 @@ static uint16_t load_atom_2(CPUArchState *env, uintptr_t ra,
     if (likely((pi & 1) == 0)) {
         return load_atomic2(pv);
     }
-    if (HAVE_al16_fast) {
+    if (HAVE_ATOMIC128_RO) {
         return load_atom_extract_al16_or_al8(pv, 2);
     }
 
@@ -511,7 +469,7 @@ static uint32_t load_atom_4(CPUArchState *env, uintptr_t ra,
     if (likely((pi & 3) == 0)) {
         return load_atomic4(pv);
     }
-    if (HAVE_al16_fast) {
+    if (HAVE_ATOMIC128_RO) {
         return load_atom_extract_al16_or_al8(pv, 4);
     }
 
@@ -557,7 +515,7 @@ static uint64_t load_atom_8(CPUArchState *env, uintptr_t ra,
     if (HAVE_al8 && likely((pi & 7) == 0)) {
         return load_atomic8(pv);
     }
-    if (HAVE_al16_fast) {
+    if (HAVE_ATOMIC128_RO) {
         return load_atom_extract_al16_or_al8(pv, 8);
     }
 
@@ -607,8 +565,8 @@ static Int128 load_atom_16(CPUArchState *env, uintptr_t ra,
      * If the host does not support 16-byte atomics, wait until we have
      * examined the atomicity parameters below.
      */
-    if (HAVE_al16_fast && likely((pi & 15) == 0)) {
-        return load_atomic16(pv);
+    if (HAVE_ATOMIC128_RO && likely((pi & 15) == 0)) {
+        return atomic16_read_ro(pv);
     }
 
     atmax = required_atomicity(env, pi, memop);
@@ -687,36 +645,6 @@ static inline void store_atomic8(void *pv, uint64_t val)
     qatomic_set__nocheck(p, val);
 }
 
-/**
- * store_atomic16:
- * @pv: host address
- * @val: value to store
- *
- * Atomically store 16 aligned bytes to @pv.
- */
-static inline void ATTRIBUTE_ATOMIC128_OPT
-store_atomic16(void *pv, Int128Alias val)
-{
-#if defined(CONFIG_ATOMIC128)
-    __uint128_t *pu = __builtin_assume_aligned(pv, 16);
-    qatomic_set__nocheck(pu, val.u);
-#elif defined(CONFIG_CMPXCHG128)
-    __uint128_t *pu = __builtin_assume_aligned(pv, 16);
-    __uint128_t o;
-
-    /*
-     * Without CONFIG_ATOMIC128, __atomic_compare_exchange_n will always
-     * defer to libatomic, so we must use __sync_*_compare_and_swap_16
-     * and accept the sequential consistency that comes with it.
-     */
-    do {
-        o = *pu;
-    } while (!__sync_bool_compare_and_swap_16(pu, o, val.u));
-#else
-    qemu_build_not_reached();
-#endif
-}
-
 /**
  * store_atom_4x2
  */
@@ -957,7 +885,7 @@ static uint64_t store_whole_le16(void *pv, int size, Int128 val_le)
     int sh = o * 8;
     Int128 m, v;
 
-    qemu_build_assert(HAVE_al16);
+    qemu_build_assert(HAVE_ATOMIC128_RW);
 
     /* Like MAKE_64BIT_MASK(0, sz), but larger. */
     if (sz <= 64) {
@@ -1017,7 +945,7 @@ static void store_atom_2(CPUArchState *env, uintptr_t ra,
             return;
         }
     } else if ((pi & 15) == 7) {
-        if (HAVE_al16) {
+        if (HAVE_ATOMIC128_RW) {
             Int128 v = int128_lshift(int128_make64(val), 56);
             Int128 m = int128_lshift(int128_make64(0xffff), 56);
             store_atom_insert_al16(pv - 7, v, m);
@@ -1086,7 +1014,7 @@ static void store_atom_4(CPUArchState *env, uintptr_t ra,
                 return;
             }
         } else {
-            if (HAVE_al16) {
+            if (HAVE_ATOMIC128_RW) {
                 store_whole_le16(pv, 4, int128_make64(cpu_to_le32(val)));
                 return;
             }
@@ -1151,7 +1079,7 @@ static void store_atom_8(CPUArchState *env, uintptr_t ra,
         }
         break;
     case MO_64:
-        if (HAVE_al16) {
+        if (HAVE_ATOMIC128_RW) {
             store_whole_le16(pv, 8, int128_make64(cpu_to_le64(val)));
             return;
         }
@@ -1177,8 +1105,8 @@ static void store_atom_16(CPUArchState *env, uintptr_t ra,
     uint64_t a, b;
     int atmax;
 
-    if (HAVE_al16_fast && likely((pi & 15) == 0)) {
-        store_atomic16(pv, val);
+    if (HAVE_ATOMIC128_RW && likely((pi & 15) == 0)) {
+        atomic16_set(pv, val);
         return;
     }
 
@@ -1206,7 +1134,7 @@ static void store_atom_16(CPUArchState *env, uintptr_t ra,
         }
         break;
     case -MO_64:
-        if (HAVE_al16) {
+        if (HAVE_ATOMIC128_RW) {
             uint64_t val_le;
             int s2 = pi & 15;
             int s1 = 16 - s2;
@@ -1233,8 +1161,8 @@ static void store_atom_16(CPUArchState *env, uintptr_t ra,
         }
         break;
     case MO_128:
-        if (HAVE_al16) {
-            store_atomic16(pv, val);
+        if (HAVE_ATOMIC128_RW) {
+            atomic16_set(pv, val);
             return;
         }
         break;
-- 
2.34.1


