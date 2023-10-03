Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1FD7B6FFB
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:37:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjF8-0008Ut-U0; Tue, 03 Oct 2023 13:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjF4-0008Sp-7c
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:31 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjF0-0007W9-K3
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:29 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-57b811a6ce8so651749eaf.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354284; x=1696959084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qW54hCoTAvx/Z0R8zzoqjJQHmhjcOZWUd1CkyEKZiYI=;
 b=JPz3edoaNKCcpk1TON8l8EnAr4sDvAXXcplLxhsvuymmEYLdsE8kmLBZcEeKdPwxT5
 9PiNuwrgs3NU40MJVTIKx6aKkXgtrm5MJsSUwgrjPpGAX6Vw4AOaoIbTrk9PzwRuDmfF
 WjB7TF/kTaLrNc+DOcknzO+vC/krY+Th4xpjqJVCc+gDfzahBPGabIOjA/VU2QcxmaLz
 8eZUgSlGxSFeTLSdE4B3KWVXbV5Az/f+CgfIvXkQKIAbVojVJnZl0LyzKtjQdL2bOGUn
 KXFdOB+V/AxO6ht+6EZhdPqjkmVB6ZVh/BBZWxkHPUffohtuysgtSho2SipN1mIW0vDL
 yWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354284; x=1696959084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qW54hCoTAvx/Z0R8zzoqjJQHmhjcOZWUd1CkyEKZiYI=;
 b=SFWPkp+RVzaPMQkcjMmqVBOyk//qLTdaY4LhqoEIFBTkEDnCU0MnFSd47L7okFDgAQ
 NGBdS7HyiUm3q+P68o4DvJbdxAiNTbDftNQYhygdz6IdPm06lttsngINbGCJvxgUYNlV
 j/PzU5YtClPyPhYOfOmDBImKv1tobBWnLWlWHG3XZYHP/w7JGL5N/WEy1hsYC3tjsNe7
 VaM3qJiTY/fZwHltSVf0a2djlgjmk9xKI9yOie3dVFe3Ww63FyaOsmyhssUkdWoUAtP4
 fJdQHW/KS1PHjJnoXxCx4iSqg5JUFSp3F9bHviDhw4fwfO+1CNqx7k1pqmPob8XOAcuZ
 aYYQ==
X-Gm-Message-State: AOJu0YzFtakC8Gmioad6IJOI7Q6huuJyWy/AX6QVsPP8k8RNIKW/InyL
 xxJ2SIjkpENQVB5tRYkQ04zxMonuSTRpCFz2Mqs=
X-Google-Smtp-Source: AGHT+IGZsBJY/mYVc2TwHcA9EACwHjXuvSTJYh1Bex/MeqxYr0D8LkTiA3xr9wsNCRrYyYZ8AUqiUg==
X-Received: by 2002:a05:6358:2904:b0:141:bfc:b11d with SMTP id
 y4-20020a056358290400b001410bfcb11dmr130504rwb.16.1696354284071; 
 Tue, 03 Oct 2023 10:31:24 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa78a47000000b00692c5b1a731sm1620195pfa.186.2023.10.03.10.31.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:31:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 27/47] accel/tcg: Use CPUState in atomicity helpers
Date: Tue,  3 Oct 2023 10:30:32 -0700
Message-Id: <20231003173052.1601813-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
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

From: Anton Johansson <anjo@rev.ng>

Makes ldst_atomicity.c.inc almost target-independent, with the exception
of TARGET_PAGE_MASK, which will be addressed in a future patch.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20230912153428.17816-8-anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c             | 20 ++++----
 accel/tcg/user-exec.c          | 16 +++----
 accel/tcg/ldst_atomicity.c.inc | 88 +++++++++++++++++-----------------
 3 files changed, 62 insertions(+), 62 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 3703443b5c..17fa7a514c 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2172,7 +2172,7 @@ static uint64_t do_ld_whole_be8(CPUState *cpu, uintptr_t ra,
                                 MMULookupPageData *p, uint64_t ret_be)
 {
     int o = p->addr & 7;
-    uint64_t x = load_atomic8_or_exit(cpu_env(cpu), ra, p->haddr - o);
+    uint64_t x = load_atomic8_or_exit(cpu, ra, p->haddr - o);
 
     x = cpu_to_be64(x);
     x <<= o * 8;
@@ -2192,7 +2192,7 @@ static Int128 do_ld_whole_be16(CPUState *cpu, uintptr_t ra,
                                MMULookupPageData *p, uint64_t ret_be)
 {
     int o = p->addr & 15;
-    Int128 x, y = load_atomic16_or_exit(cpu_env(cpu), ra, p->haddr - o);
+    Int128 x, y = load_atomic16_or_exit(cpu, ra, p->haddr - o);
     int size = p->size;
 
     if (!HOST_BIG_ENDIAN) {
@@ -2329,7 +2329,7 @@ static uint16_t do_ld_2(CPUState *cpu, MMULookupPageData *p, int mmu_idx,
         }
     } else {
         /* Perform the load host endian, then swap if necessary. */
-        ret = load_atom_2(cpu_env(cpu), ra, p->haddr, memop);
+        ret = load_atom_2(cpu, ra, p->haddr, memop);
         if (memop & MO_BSWAP) {
             ret = bswap16(ret);
         }
@@ -2349,7 +2349,7 @@ static uint32_t do_ld_4(CPUState *cpu, MMULookupPageData *p, int mmu_idx,
         }
     } else {
         /* Perform the load host endian. */
-        ret = load_atom_4(cpu_env(cpu), ra, p->haddr, memop);
+        ret = load_atom_4(cpu, ra, p->haddr, memop);
         if (memop & MO_BSWAP) {
             ret = bswap32(ret);
         }
@@ -2369,7 +2369,7 @@ static uint64_t do_ld_8(CPUState *cpu, MMULookupPageData *p, int mmu_idx,
         }
     } else {
         /* Perform the load host endian. */
-        ret = load_atom_8(cpu_env(cpu), ra, p->haddr, memop);
+        ret = load_atom_8(cpu, ra, p->haddr, memop);
         if (memop & MO_BSWAP) {
             ret = bswap64(ret);
         }
@@ -2528,7 +2528,7 @@ static Int128 do_ld16_mmu(CPUState *cpu, vaddr addr,
             }
         } else {
             /* Perform the load host endian. */
-            ret = load_atom_16(cpu_env(cpu), ra, l.page[0].haddr, l.memop);
+            ret = load_atom_16(cpu, ra, l.page[0].haddr, l.memop);
             if (l.memop & MO_BSWAP) {
                 ret = bswap128(ret);
             }
@@ -2880,7 +2880,7 @@ static void do_st_2(CPUState *cpu, MMULookupPageData *p, uint16_t val,
         if (memop & MO_BSWAP) {
             val = bswap16(val);
         }
-        store_atom_2(cpu_env(cpu), ra, p->haddr, memop, val);
+        store_atom_2(cpu, ra, p->haddr, memop, val);
     }
 }
 
@@ -2899,7 +2899,7 @@ static void do_st_4(CPUState *cpu, MMULookupPageData *p, uint32_t val,
         if (memop & MO_BSWAP) {
             val = bswap32(val);
         }
-        store_atom_4(cpu_env(cpu), ra, p->haddr, memop, val);
+        store_atom_4(cpu, ra, p->haddr, memop, val);
     }
 }
 
@@ -2918,7 +2918,7 @@ static void do_st_8(CPUState *cpu, MMULookupPageData *p, uint64_t val,
         if (memop & MO_BSWAP) {
             val = bswap64(val);
         }
-        store_atom_8(cpu_env(cpu), ra, p->haddr, memop, val);
+        store_atom_8(cpu, ra, p->haddr, memop, val);
     }
 }
 
@@ -3045,7 +3045,7 @@ static void do_st16_mmu(CPUState *cpu, vaddr addr, Int128 val,
             if (l.memop & MO_BSWAP) {
                 val = bswap128(val);
             }
-            store_atom_16(cpu_env(cpu), ra, l.page[0].haddr, l.memop, val);
+            store_atom_16(cpu, ra, l.page[0].haddr, l.memop, val);
         }
         return;
     }
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index d2daeafbab..f9f5cd1770 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -1002,7 +1002,7 @@ static uint16_t do_ld2_mmu(CPUArchState *env, abi_ptr addr,
     tcg_debug_assert((mop & MO_SIZE) == MO_16);
     cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     haddr = cpu_mmu_lookup(env, addr, mop, ra, MMU_DATA_LOAD);
-    ret = load_atom_2(env, ra, haddr, mop);
+    ret = load_atom_2(env_cpu(env), ra, haddr, mop);
     clear_helper_retaddr();
 
     if (mop & MO_BSWAP) {
@@ -1040,7 +1040,7 @@ static uint32_t do_ld4_mmu(CPUArchState *env, abi_ptr addr,
     tcg_debug_assert((mop & MO_SIZE) == MO_32);
     cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     haddr = cpu_mmu_lookup(env, addr, mop, ra, MMU_DATA_LOAD);
-    ret = load_atom_4(env, ra, haddr, mop);
+    ret = load_atom_4(env_cpu(env), ra, haddr, mop);
     clear_helper_retaddr();
 
     if (mop & MO_BSWAP) {
@@ -1078,7 +1078,7 @@ static uint64_t do_ld8_mmu(CPUArchState *env, abi_ptr addr,
     tcg_debug_assert((mop & MO_SIZE) == MO_64);
     cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     haddr = cpu_mmu_lookup(env, addr, mop, ra, MMU_DATA_LOAD);
-    ret = load_atom_8(env, ra, haddr, mop);
+    ret = load_atom_8(env_cpu(env), ra, haddr, mop);
     clear_helper_retaddr();
 
     if (mop & MO_BSWAP) {
@@ -1110,7 +1110,7 @@ static Int128 do_ld16_mmu(CPUArchState *env, abi_ptr addr,
     tcg_debug_assert((mop & MO_SIZE) == MO_128);
     cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     haddr = cpu_mmu_lookup(env, addr, mop, ra, MMU_DATA_LOAD);
-    ret = load_atom_16(env, ra, haddr, mop);
+    ret = load_atom_16(env_cpu(env), ra, haddr, mop);
     clear_helper_retaddr();
 
     if (mop & MO_BSWAP) {
@@ -1175,7 +1175,7 @@ static void do_st2_mmu(CPUArchState *env, abi_ptr addr, uint16_t val,
     if (mop & MO_BSWAP) {
         val = bswap16(val);
     }
-    store_atom_2(env, ra, haddr, mop, val);
+    store_atom_2(env_cpu(env), ra, haddr, mop, val);
     clear_helper_retaddr();
 }
 
@@ -1204,7 +1204,7 @@ static void do_st4_mmu(CPUArchState *env, abi_ptr addr, uint32_t val,
     if (mop & MO_BSWAP) {
         val = bswap32(val);
     }
-    store_atom_4(env, ra, haddr, mop, val);
+    store_atom_4(env_cpu(env), ra, haddr, mop, val);
     clear_helper_retaddr();
 }
 
@@ -1233,7 +1233,7 @@ static void do_st8_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
     if (mop & MO_BSWAP) {
         val = bswap64(val);
     }
-    store_atom_8(env, ra, haddr, mop, val);
+    store_atom_8(env_cpu(env), ra, haddr, mop, val);
     clear_helper_retaddr();
 }
 
@@ -1262,7 +1262,7 @@ static void do_st16_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
     if (mop & MO_BSWAP) {
         val = bswap128(val);
     }
-    store_atom_16(env, ra, haddr, mop, val);
+    store_atom_16(env_cpu(env), ra, haddr, mop, val);
     clear_helper_retaddr();
 }
 
diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
index 1b793e6935..1cf5b92166 100644
--- a/accel/tcg/ldst_atomicity.c.inc
+++ b/accel/tcg/ldst_atomicity.c.inc
@@ -26,7 +26,7 @@
  * If the operation must be split into two operations to be
  * examined separately for atomicity, return -lg2.
  */
-static int required_atomicity(CPUArchState *env, uintptr_t p, MemOp memop)
+static int required_atomicity(CPUState *cpu, uintptr_t p, MemOp memop)
 {
     MemOp atom = memop & MO_ATOM_MASK;
     MemOp size = memop & MO_SIZE;
@@ -93,7 +93,7 @@ static int required_atomicity(CPUArchState *env, uintptr_t p, MemOp memop)
      * host atomicity in order to avoid racing.  This reduction
      * avoids looping with cpu_loop_exit_atomic.
      */
-    if (cpu_in_serial_context(env_cpu(env))) {
+    if (cpu_in_serial_context(cpu)) {
         return MO_8;
     }
     return atmax;
@@ -139,14 +139,14 @@ static inline uint64_t load_atomic8(void *pv)
 
 /**
  * load_atomic8_or_exit:
- * @env: cpu context
+ * @cpu: generic cpu state
  * @ra: host unwind address
  * @pv: host address
  *
  * Atomically load 8 aligned bytes from @pv.
  * If this is not possible, longjmp out to restart serially.
  */
-static uint64_t load_atomic8_or_exit(CPUArchState *env, uintptr_t ra, void *pv)
+static uint64_t load_atomic8_or_exit(CPUState *cpu, uintptr_t ra, void *pv)
 {
     if (HAVE_al8) {
         return load_atomic8(pv);
@@ -168,19 +168,19 @@ static uint64_t load_atomic8_or_exit(CPUArchState *env, uintptr_t ra, void *pv)
 #endif
 
     /* Ultimate fallback: re-execute in serial context. */
-    cpu_loop_exit_atomic(env_cpu(env), ra);
+    cpu_loop_exit_atomic(cpu, ra);
 }
 
 /**
  * load_atomic16_or_exit:
- * @env: cpu context
+ * @cpu: generic cpu state
  * @ra: host unwind address
  * @pv: host address
  *
  * Atomically load 16 aligned bytes from @pv.
  * If this is not possible, longjmp out to restart serially.
  */
-static Int128 load_atomic16_or_exit(CPUArchState *env, uintptr_t ra, void *pv)
+static Int128 load_atomic16_or_exit(CPUState *cpu, uintptr_t ra, void *pv)
 {
     Int128 *p = __builtin_assume_aligned(pv, 16);
 
@@ -212,7 +212,7 @@ static Int128 load_atomic16_or_exit(CPUArchState *env, uintptr_t ra, void *pv)
     }
 
     /* Ultimate fallback: re-execute in serial context. */
-    cpu_loop_exit_atomic(env_cpu(env), ra);
+    cpu_loop_exit_atomic(cpu, ra);
 }
 
 /**
@@ -263,7 +263,7 @@ static uint64_t load_atom_extract_al8x2(void *pv)
 
 /**
  * load_atom_extract_al8_or_exit:
- * @env: cpu context
+ * @cpu: generic cpu state
  * @ra: host unwind address
  * @pv: host address
  * @s: object size in bytes, @s <= 4.
@@ -273,7 +273,7 @@ static uint64_t load_atom_extract_al8x2(void *pv)
  * 8-byte load and extract.
  * The value is returned in the low bits of a uint32_t.
  */
-static uint32_t load_atom_extract_al8_or_exit(CPUArchState *env, uintptr_t ra,
+static uint32_t load_atom_extract_al8_or_exit(CPUState *cpu, uintptr_t ra,
                                               void *pv, int s)
 {
     uintptr_t pi = (uintptr_t)pv;
@@ -281,12 +281,12 @@ static uint32_t load_atom_extract_al8_or_exit(CPUArchState *env, uintptr_t ra,
     int shr = (HOST_BIG_ENDIAN ? 8 - s - o : o) * 8;
 
     pv = (void *)(pi & ~7);
-    return load_atomic8_or_exit(env, ra, pv) >> shr;
+    return load_atomic8_or_exit(cpu, ra, pv) >> shr;
 }
 
 /**
  * load_atom_extract_al16_or_exit:
- * @env: cpu context
+ * @cpu: generic cpu state
  * @ra: host unwind address
  * @p: host address
  * @s: object size in bytes, @s <= 8.
@@ -299,7 +299,7 @@ static uint32_t load_atom_extract_al8_or_exit(CPUArchState *env, uintptr_t ra,
  *
  * If this is not possible, longjmp out to restart serially.
  */
-static uint64_t load_atom_extract_al16_or_exit(CPUArchState *env, uintptr_t ra,
+static uint64_t load_atom_extract_al16_or_exit(CPUState *cpu, uintptr_t ra,
                                                void *pv, int s)
 {
     uintptr_t pi = (uintptr_t)pv;
@@ -312,7 +312,7 @@ static uint64_t load_atom_extract_al16_or_exit(CPUArchState *env, uintptr_t ra,
      * Provoke SIGBUS if possible otherwise.
      */
     pv = (void *)(pi & ~7);
-    r = load_atomic16_or_exit(env, ra, pv);
+    r = load_atomic16_or_exit(cpu, ra, pv);
 
     r = int128_urshift(r, shr);
     return int128_getlo(r);
@@ -394,7 +394,7 @@ static inline uint64_t load_atom_8_by_8_or_4(void *pv)
  *
  * Load 2 bytes from @p, honoring the atomicity of @memop.
  */
-static uint16_t load_atom_2(CPUArchState *env, uintptr_t ra,
+static uint16_t load_atom_2(CPUState *cpu, uintptr_t ra,
                             void *pv, MemOp memop)
 {
     uintptr_t pi = (uintptr_t)pv;
@@ -410,7 +410,7 @@ static uint16_t load_atom_2(CPUArchState *env, uintptr_t ra,
         }
     }
 
-    atmax = required_atomicity(env, pi, memop);
+    atmax = required_atomicity(cpu, pi, memop);
     switch (atmax) {
     case MO_8:
         return lduw_he_p(pv);
@@ -421,9 +421,9 @@ static uint16_t load_atom_2(CPUArchState *env, uintptr_t ra,
             return load_atomic4(pv - 1) >> 8;
         }
         if ((pi & 15) != 7) {
-            return load_atom_extract_al8_or_exit(env, ra, pv, 2);
+            return load_atom_extract_al8_or_exit(cpu, ra, pv, 2);
         }
-        return load_atom_extract_al16_or_exit(env, ra, pv, 2);
+        return load_atom_extract_al16_or_exit(cpu, ra, pv, 2);
     default:
         g_assert_not_reached();
     }
@@ -436,7 +436,7 @@ static uint16_t load_atom_2(CPUArchState *env, uintptr_t ra,
  *
  * Load 4 bytes from @p, honoring the atomicity of @memop.
  */
-static uint32_t load_atom_4(CPUArchState *env, uintptr_t ra,
+static uint32_t load_atom_4(CPUState *cpu, uintptr_t ra,
                             void *pv, MemOp memop)
 {
     uintptr_t pi = (uintptr_t)pv;
@@ -452,7 +452,7 @@ static uint32_t load_atom_4(CPUArchState *env, uintptr_t ra,
         }
     }
 
-    atmax = required_atomicity(env, pi, memop);
+    atmax = required_atomicity(cpu, pi, memop);
     switch (atmax) {
     case MO_8:
     case MO_16:
@@ -466,9 +466,9 @@ static uint32_t load_atom_4(CPUArchState *env, uintptr_t ra,
         return load_atom_extract_al4x2(pv);
     case MO_32:
         if (!(pi & 4)) {
-            return load_atom_extract_al8_or_exit(env, ra, pv, 4);
+            return load_atom_extract_al8_or_exit(cpu, ra, pv, 4);
         }
-        return load_atom_extract_al16_or_exit(env, ra, pv, 4);
+        return load_atom_extract_al16_or_exit(cpu, ra, pv, 4);
     default:
         g_assert_not_reached();
     }
@@ -481,7 +481,7 @@ static uint32_t load_atom_4(CPUArchState *env, uintptr_t ra,
  *
  * Load 8 bytes from @p, honoring the atomicity of @memop.
  */
-static uint64_t load_atom_8(CPUArchState *env, uintptr_t ra,
+static uint64_t load_atom_8(CPUState *cpu, uintptr_t ra,
                             void *pv, MemOp memop)
 {
     uintptr_t pi = (uintptr_t)pv;
@@ -498,12 +498,12 @@ static uint64_t load_atom_8(CPUArchState *env, uintptr_t ra,
         return load_atom_extract_al16_or_al8(pv, 8);
     }
 
-    atmax = required_atomicity(env, pi, memop);
+    atmax = required_atomicity(cpu, pi, memop);
     if (atmax == MO_64) {
         if (!HAVE_al8 && (pi & 7) == 0) {
-            load_atomic8_or_exit(env, ra, pv);
+            load_atomic8_or_exit(cpu, ra, pv);
         }
-        return load_atom_extract_al16_or_exit(env, ra, pv, 8);
+        return load_atom_extract_al16_or_exit(cpu, ra, pv, 8);
     }
     if (HAVE_al8_fast) {
         return load_atom_extract_al8x2(pv);
@@ -519,7 +519,7 @@ static uint64_t load_atom_8(CPUArchState *env, uintptr_t ra,
         if (HAVE_al8) {
             return load_atom_extract_al8x2(pv);
         }
-        cpu_loop_exit_atomic(env_cpu(env), ra);
+        cpu_loop_exit_atomic(cpu, ra);
     default:
         g_assert_not_reached();
     }
@@ -532,7 +532,7 @@ static uint64_t load_atom_8(CPUArchState *env, uintptr_t ra,
  *
  * Load 16 bytes from @p, honoring the atomicity of @memop.
  */
-static Int128 load_atom_16(CPUArchState *env, uintptr_t ra,
+static Int128 load_atom_16(CPUState *cpu, uintptr_t ra,
                            void *pv, MemOp memop)
 {
     uintptr_t pi = (uintptr_t)pv;
@@ -548,7 +548,7 @@ static Int128 load_atom_16(CPUArchState *env, uintptr_t ra,
         return atomic16_read_ro(pv);
     }
 
-    atmax = required_atomicity(env, pi, memop);
+    atmax = required_atomicity(cpu, pi, memop);
     switch (atmax) {
     case MO_8:
         memcpy(&r, pv, 16);
@@ -563,20 +563,20 @@ static Int128 load_atom_16(CPUArchState *env, uintptr_t ra,
         break;
     case MO_64:
         if (!HAVE_al8) {
-            cpu_loop_exit_atomic(env_cpu(env), ra);
+            cpu_loop_exit_atomic(cpu, ra);
         }
         a = load_atomic8(pv);
         b = load_atomic8(pv + 8);
         break;
     case -MO_64:
         if (!HAVE_al8) {
-            cpu_loop_exit_atomic(env_cpu(env), ra);
+            cpu_loop_exit_atomic(cpu, ra);
         }
         a = load_atom_extract_al8x2(pv);
         b = load_atom_extract_al8x2(pv + 8);
         break;
     case MO_128:
-        return load_atomic16_or_exit(env, ra, pv);
+        return load_atomic16_or_exit(cpu, ra, pv);
     default:
         g_assert_not_reached();
     }
@@ -857,7 +857,7 @@ static uint64_t store_whole_le16(void *pv, int size, Int128 val_le)
  *
  * Store 2 bytes to @p, honoring the atomicity of @memop.
  */
-static void store_atom_2(CPUArchState *env, uintptr_t ra,
+static void store_atom_2(CPUState *cpu, uintptr_t ra,
                          void *pv, MemOp memop, uint16_t val)
 {
     uintptr_t pi = (uintptr_t)pv;
@@ -868,7 +868,7 @@ static void store_atom_2(CPUArchState *env, uintptr_t ra,
         return;
     }
 
-    atmax = required_atomicity(env, pi, memop);
+    atmax = required_atomicity(cpu, pi, memop);
     if (atmax == MO_8) {
         stw_he_p(pv, val);
         return;
@@ -897,7 +897,7 @@ static void store_atom_2(CPUArchState *env, uintptr_t ra,
         g_assert_not_reached();
     }
 
-    cpu_loop_exit_atomic(env_cpu(env), ra);
+    cpu_loop_exit_atomic(cpu, ra);
 }
 
 /**
@@ -908,7 +908,7 @@ static void store_atom_2(CPUArchState *env, uintptr_t ra,
  *
  * Store 4 bytes to @p, honoring the atomicity of @memop.
  */
-static void store_atom_4(CPUArchState *env, uintptr_t ra,
+static void store_atom_4(CPUState *cpu, uintptr_t ra,
                          void *pv, MemOp memop, uint32_t val)
 {
     uintptr_t pi = (uintptr_t)pv;
@@ -919,7 +919,7 @@ static void store_atom_4(CPUArchState *env, uintptr_t ra,
         return;
     }
 
-    atmax = required_atomicity(env, pi, memop);
+    atmax = required_atomicity(cpu, pi, memop);
     switch (atmax) {
     case MO_8:
         stl_he_p(pv, val);
@@ -961,7 +961,7 @@ static void store_atom_4(CPUArchState *env, uintptr_t ra,
                 return;
             }
         }
-        cpu_loop_exit_atomic(env_cpu(env), ra);
+        cpu_loop_exit_atomic(cpu, ra);
     default:
         g_assert_not_reached();
     }
@@ -975,7 +975,7 @@ static void store_atom_4(CPUArchState *env, uintptr_t ra,
  *
  * Store 8 bytes to @p, honoring the atomicity of @memop.
  */
-static void store_atom_8(CPUArchState *env, uintptr_t ra,
+static void store_atom_8(CPUState *cpu, uintptr_t ra,
                          void *pv, MemOp memop, uint64_t val)
 {
     uintptr_t pi = (uintptr_t)pv;
@@ -986,7 +986,7 @@ static void store_atom_8(CPUArchState *env, uintptr_t ra,
         return;
     }
 
-    atmax = required_atomicity(env, pi, memop);
+    atmax = required_atomicity(cpu, pi, memop);
     switch (atmax) {
     case MO_8:
         stq_he_p(pv, val);
@@ -1029,7 +1029,7 @@ static void store_atom_8(CPUArchState *env, uintptr_t ra,
     default:
         g_assert_not_reached();
     }
-    cpu_loop_exit_atomic(env_cpu(env), ra);
+    cpu_loop_exit_atomic(cpu, ra);
 }
 
 /**
@@ -1040,7 +1040,7 @@ static void store_atom_8(CPUArchState *env, uintptr_t ra,
  *
  * Store 16 bytes to @p, honoring the atomicity of @memop.
  */
-static void store_atom_16(CPUArchState *env, uintptr_t ra,
+static void store_atom_16(CPUState *cpu, uintptr_t ra,
                           void *pv, MemOp memop, Int128 val)
 {
     uintptr_t pi = (uintptr_t)pv;
@@ -1052,7 +1052,7 @@ static void store_atom_16(CPUArchState *env, uintptr_t ra,
         return;
     }
 
-    atmax = required_atomicity(env, pi, memop);
+    atmax = required_atomicity(cpu, pi, memop);
 
     a = HOST_BIG_ENDIAN ? int128_gethi(val) : int128_getlo(val);
     b = HOST_BIG_ENDIAN ? int128_getlo(val) : int128_gethi(val);
@@ -1111,5 +1111,5 @@ static void store_atom_16(CPUArchState *env, uintptr_t ra,
     default:
         g_assert_not_reached();
     }
-    cpu_loop_exit_atomic(env_cpu(env), ra);
+    cpu_loop_exit_atomic(cpu, ra);
 }
-- 
2.34.1


