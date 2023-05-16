Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDD97057D5
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:48:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0Yb-0006dE-4r; Tue, 16 May 2023 15:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0YV-0006Yt-Iy
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:41:55 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0YS-0002jf-C1
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:41:55 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-643a1fed360so9087754b3a.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266111; x=1686858111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OKbilkd0PwAQW9asTHpPZblhMxzcNmkGSyUJS+Fmjz4=;
 b=Q6XI5eLtQzDB0NZGG9feTHsC8dt3v9I32bsgl4oKp6CUwJzQBLMlMQ7xxTdsOlWlhh
 ZJ4i4x0SV/d80xIPfVv5j36vAf+xehMW8nWBHpph+L8qdCZeFuJSNh3F/AGPttRQChnq
 6yMRJqUJiIb5lUQg/g/KSsyJ5BOoJAAXUBI1AIQCYEZwyhRDJgF6I2tsF44pLgpUo7fR
 1JX1vuL+ecIGAWwkrRSx2jUPVWMk71L2Fs6uHvb75EXb0ZGzl6YIrzNTQ8jdzbtE3gCp
 S2cHLGEGvJBNMCFzz9feQMRPPqwqv9cPkQxjbOiRF/dw0fLsb7IPehsFIsstTkkEvLcX
 hPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266111; x=1686858111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OKbilkd0PwAQW9asTHpPZblhMxzcNmkGSyUJS+Fmjz4=;
 b=iOMEIyf2rOX2BrzbAnx+lkox4W1iO+j/L0WSO1IiqWjigdxXyT0DbH6+HHad5OYV82
 4r0corFSvNJZDNgKMDXZD6Hfjuj1hY3X2O+uFrdjwGidv2rCmyBShCVTE8GYcaz1lTpI
 ysk4fzEkL6LT0gvPRIKUQxLxH7iks81U+0TTx2K2Ki+ie8o7QYQ1y5belQIsZc2J2t2a
 unj5ZyOclBoZPC7VzpS4RNtgna+j4L1bXjcDywzs4racTM20jYYKu+XMDrkpmZcBka3u
 mNKwvbwd6alOIS6psEiTreKL2TdGPw9wkpnatkhASoPLp/wKWmslLZH4XD+vbPhUKaMn
 HTAg==
X-Gm-Message-State: AC+VfDxLbhv+JaC6mlNradVhmxISX/yoca8HzgIRzfkq0UcAKnnDY+hX
 DGFdMy7qd/tJuW5nheOgGMvOLA2aGqY9IaSycBk=
X-Google-Smtp-Source: ACHHUZ4O+HWtlrrKzvy7hn5DgA5XDmXRocGDpkjb7UNVMl7CB8MHnmicYy2Z4JkzfHBnH0tNpDDpUg==
X-Received: by 2002:a05:6a00:21d0:b0:644:8172:3ea9 with SMTP id
 t16-20020a056a0021d000b0064481723ea9mr42263062pfj.15.1684266110913; 
 Tue, 16 May 2023 12:41:50 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 z21-20020aa791d5000000b006260526cf0csm13771165pfa.116.2023.05.16.12.41.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:41:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 04/80] accel/tcg: Honor atomicity of stores
Date: Tue, 16 May 2023 12:40:29 -0700
Message-Id: <20230516194145.1749305-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c             | 108 ++++----
 accel/tcg/user-exec.c          |  12 +-
 accel/tcg/ldst_atomicity.c.inc | 491 +++++++++++++++++++++++++++++++++
 3 files changed, 545 insertions(+), 66 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 33e75ae962..d910464c36 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2599,36 +2599,6 @@ Int128 cpu_ld16_le_mmu(CPUArchState *env, abi_ptr addr,
  * Store Helpers
  */
 
-static inline void QEMU_ALWAYS_INLINE
-store_memop(void *haddr, uint64_t val, MemOp op)
-{
-    switch (op) {
-    case MO_UB:
-        stb_p(haddr, val);
-        break;
-    case MO_BEUW:
-        stw_be_p(haddr, val);
-        break;
-    case MO_LEUW:
-        stw_le_p(haddr, val);
-        break;
-    case MO_BEUL:
-        stl_be_p(haddr, val);
-        break;
-    case MO_LEUL:
-        stl_le_p(haddr, val);
-        break;
-    case MO_BEUQ:
-        stq_be_p(haddr, val);
-        break;
-    case MO_LEUQ:
-        stq_le_p(haddr, val);
-        break;
-    default:
-        qemu_build_not_reached();
-    }
-}
-
 /**
  * do_st_mmio_leN:
  * @env: cpu context
@@ -2655,38 +2625,56 @@ static uint64_t do_st_mmio_leN(CPUArchState *env, MMULookupPageData *p,
     return val_le;
 }
 
-/**
- * do_st_bytes_leN:
- * @p: translation parameters
- * @val_le: data to store
- *
- * Store @p->size bytes at @p->haddr, which is RAM.
- * The bytes to store are extracted in little-endian order from @val_le;
- * return the bytes of @val_le beyond @p->size that have not been stored.
- */
-static uint64_t do_st_bytes_leN(MMULookupPageData *p, uint64_t val_le)
-{
-    uint8_t *haddr = p->haddr;
-    int i, size = p->size;
-
-    for (i = 0; i < size; i++, val_le >>= 8) {
-        haddr[i] = val_le;
-    }
-    return val_le;
-}
-
 /*
  * Wrapper for the above.
  */
 static uint64_t do_st_leN(CPUArchState *env, MMULookupPageData *p,
-                          uint64_t val_le, int mmu_idx, uintptr_t ra)
+                          uint64_t val_le, int mmu_idx,
+                          MemOp mop, uintptr_t ra)
 {
+    MemOp atom;
+    unsigned tmp, half_size;
+
     if (unlikely(p->flags & TLB_MMIO)) {
         return do_st_mmio_leN(env, p, val_le, mmu_idx, ra);
     } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
         return val_le >> (p->size * 8);
-    } else {
-        return do_st_bytes_leN(p, val_le);
+    }
+
+    /*
+     * It is a given that we cross a page and therefore there is no atomicity
+     * for the store as a whole, but subobjects may need attention.
+     */
+    atom = mop & MO_ATOM_MASK;
+    switch (atom) {
+    case MO_ATOM_SUBALIGN:
+        return store_parts_leN(p->haddr, p->size, val_le);
+
+    case MO_ATOM_IFALIGN_PAIR:
+    case MO_ATOM_WITHIN16_PAIR:
+        tmp = mop & MO_SIZE;
+        tmp = tmp ? tmp - 1 : 0;
+        half_size = 1 << tmp;
+        if (atom == MO_ATOM_IFALIGN_PAIR
+            ? p->size == half_size
+            : p->size >= half_size) {
+            if (!HAVE_al8_fast && p->size <= 4) {
+                return store_whole_le4(p->haddr, p->size, val_le);
+            } else if (HAVE_al8) {
+                return store_whole_le8(p->haddr, p->size, val_le);
+            } else {
+                cpu_loop_exit_atomic(env_cpu(env), ra);
+            }
+        }
+        /* fall through */
+
+    case MO_ATOM_IFALIGN:
+    case MO_ATOM_WITHIN16:
+    case MO_ATOM_NONE:
+        return store_bytes_leN(p->haddr, p->size, val_le);
+
+    default:
+        g_assert_not_reached();
     }
 }
 
@@ -2714,7 +2702,7 @@ static void do_st_2(CPUArchState *env, MMULookupPageData *p, uint16_t val,
         if (memop & MO_BSWAP) {
             val = bswap16(val);
         }
-        store_memop(p->haddr, val, MO_UW);
+        store_atom_2(env, ra, p->haddr, memop, val);
     }
 }
 
@@ -2730,7 +2718,7 @@ static void do_st_4(CPUArchState *env, MMULookupPageData *p, uint32_t val,
         if (memop & MO_BSWAP) {
             val = bswap32(val);
         }
-        store_memop(p->haddr, val, MO_UL);
+        store_atom_4(env, ra, p->haddr, memop, val);
     }
 }
 
@@ -2746,7 +2734,7 @@ static void do_st_8(CPUArchState *env, MMULookupPageData *p, uint64_t val,
         if (memop & MO_BSWAP) {
             val = bswap64(val);
         }
-        store_memop(p->haddr, val, MO_UQ);
+        store_atom_8(env, ra, p->haddr, memop, val);
     }
 }
 
@@ -2815,8 +2803,8 @@ static void do_st4_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
     if ((l.memop & MO_BSWAP) != MO_LE) {
         val = bswap32(val);
     }
-    val = do_st_leN(env, &l.page[0], val, l.mmu_idx, ra);
-    (void) do_st_leN(env, &l.page[1], val, l.mmu_idx, ra);
+    val = do_st_leN(env, &l.page[0], val, l.mmu_idx, l.memop, ra);
+    (void) do_st_leN(env, &l.page[1], val, l.mmu_idx, l.memop, ra);
 }
 
 void helper_le_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
@@ -2849,8 +2837,8 @@ static void do_st8_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
     if ((l.memop & MO_BSWAP) != MO_LE) {
         val = bswap64(val);
     }
-    val = do_st_leN(env, &l.page[0], val, l.mmu_idx, ra);
-    (void) do_st_leN(env, &l.page[1], val, l.mmu_idx, ra);
+    val = do_st_leN(env, &l.page[0], val, l.mmu_idx, l.memop, ra);
+    (void) do_st_leN(env, &l.page[1], val, l.mmu_idx, l.memop, ra);
 }
 
 void helper_le_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index fefc83cc8c..b89fa35a83 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -1086,7 +1086,7 @@ void cpu_stw_be_mmu(CPUArchState *env, abi_ptr addr, uint16_t val,
 
     validate_memop(oi, MO_BEUW);
     haddr = cpu_mmu_lookup(env, addr, oi, ra, MMU_DATA_STORE);
-    stw_be_p(haddr, val);
+    store_atom_2(env, ra, haddr, get_memop(oi), be16_to_cpu(val));
     clear_helper_retaddr();
     qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
 }
@@ -1098,7 +1098,7 @@ void cpu_stl_be_mmu(CPUArchState *env, abi_ptr addr, uint32_t val,
 
     validate_memop(oi, MO_BEUL);
     haddr = cpu_mmu_lookup(env, addr, oi, ra, MMU_DATA_STORE);
-    stl_be_p(haddr, val);
+    store_atom_4(env, ra, haddr, get_memop(oi), be32_to_cpu(val));
     clear_helper_retaddr();
     qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
 }
@@ -1110,7 +1110,7 @@ void cpu_stq_be_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
 
     validate_memop(oi, MO_BEUQ);
     haddr = cpu_mmu_lookup(env, addr, oi, ra, MMU_DATA_STORE);
-    stq_be_p(haddr, val);
+    store_atom_8(env, ra, haddr, get_memop(oi), be64_to_cpu(val));
     clear_helper_retaddr();
     qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
 }
@@ -1122,7 +1122,7 @@ void cpu_stw_le_mmu(CPUArchState *env, abi_ptr addr, uint16_t val,
 
     validate_memop(oi, MO_LEUW);
     haddr = cpu_mmu_lookup(env, addr, oi, ra, MMU_DATA_STORE);
-    stw_le_p(haddr, val);
+    store_atom_2(env, ra, haddr, get_memop(oi), le16_to_cpu(val));
     clear_helper_retaddr();
     qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
 }
@@ -1134,7 +1134,7 @@ void cpu_stl_le_mmu(CPUArchState *env, abi_ptr addr, uint32_t val,
 
     validate_memop(oi, MO_LEUL);
     haddr = cpu_mmu_lookup(env, addr, oi, ra, MMU_DATA_STORE);
-    stl_le_p(haddr, val);
+    store_atom_4(env, ra, haddr, get_memop(oi), le32_to_cpu(val));
     clear_helper_retaddr();
     qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
 }
@@ -1146,7 +1146,7 @@ void cpu_stq_le_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
 
     validate_memop(oi, MO_LEUQ);
     haddr = cpu_mmu_lookup(env, addr, oi, ra, MMU_DATA_STORE);
-    stq_le_p(haddr, val);
+    store_atom_8(env, ra, haddr, get_memop(oi), le64_to_cpu(val));
     clear_helper_retaddr();
     qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
 }
diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
index a5bce641f8..1f39e43896 100644
--- a/accel/tcg/ldst_atomicity.c.inc
+++ b/accel/tcg/ldst_atomicity.c.inc
@@ -21,6 +21,12 @@
 #else
 # define HAVE_al16_fast    false
 #endif
+#if defined(CONFIG_ATOMIC128) || defined(CONFIG_CMPXCHG128)
+# define HAVE_al16         true
+#else
+# define HAVE_al16         false
+#endif
+
 
 /**
  * required_atomicity:
@@ -564,3 +570,488 @@ static uint64_t load_atom_8(CPUArchState *env, uintptr_t ra,
         g_assert_not_reached();
     }
 }
+
+/**
+ * store_atomic2:
+ * @pv: host address
+ * @val: value to store
+ *
+ * Atomically store 2 aligned bytes to @pv.
+ */
+static inline void store_atomic2(void *pv, uint16_t val)
+{
+    uint16_t *p = __builtin_assume_aligned(pv, 2);
+    qatomic_set(p, val);
+}
+
+/**
+ * store_atomic4:
+ * @pv: host address
+ * @val: value to store
+ *
+ * Atomically store 4 aligned bytes to @pv.
+ */
+static inline void store_atomic4(void *pv, uint32_t val)
+{
+    uint32_t *p = __builtin_assume_aligned(pv, 4);
+    qatomic_set(p, val);
+}
+
+/**
+ * store_atomic8:
+ * @pv: host address
+ * @val: value to store
+ *
+ * Atomically store 8 aligned bytes to @pv.
+ */
+static inline void store_atomic8(void *pv, uint64_t val)
+{
+    uint64_t *p = __builtin_assume_aligned(pv, 8);
+
+    qemu_build_assert(HAVE_al8);
+    qatomic_set__nocheck(p, val);
+}
+
+/**
+ * store_atom_4x2
+ */
+static inline void store_atom_4_by_2(void *pv, uint32_t val)
+{
+    store_atomic2(pv, val >> (HOST_BIG_ENDIAN ? 16 : 0));
+    store_atomic2(pv + 2, val >> (HOST_BIG_ENDIAN ? 0 : 16));
+}
+
+/**
+ * store_atom_8_by_2
+ */
+static inline void store_atom_8_by_2(void *pv, uint64_t val)
+{
+    store_atom_4_by_2(pv, val >> (HOST_BIG_ENDIAN ? 32 : 0));
+    store_atom_4_by_2(pv + 4, val >> (HOST_BIG_ENDIAN ? 0 : 32));
+}
+
+/**
+ * store_atom_8_by_4
+ */
+static inline void store_atom_8_by_4(void *pv, uint64_t val)
+{
+    store_atomic4(pv, val >> (HOST_BIG_ENDIAN ? 32 : 0));
+    store_atomic4(pv + 4, val >> (HOST_BIG_ENDIAN ? 0 : 32));
+}
+
+/**
+ * store_atom_insert_al4:
+ * @p: host address
+ * @val: shifted value to store
+ * @msk: mask for value to store
+ *
+ * Atomically store @val to @p, masked by @msk.
+ */
+static void store_atom_insert_al4(uint32_t *p, uint32_t val, uint32_t msk)
+{
+    uint32_t old, new;
+
+    p = __builtin_assume_aligned(p, 4);
+    old = qatomic_read(p);
+    do {
+        new = (old & ~msk) | val;
+    } while (!__atomic_compare_exchange_n(p, &old, new, true,
+                                          __ATOMIC_RELAXED, __ATOMIC_RELAXED));
+}
+
+/**
+ * store_atom_insert_al8:
+ * @p: host address
+ * @val: shifted value to store
+ * @msk: mask for value to store
+ *
+ * Atomically store @val to @p masked by @msk.
+ */
+static void store_atom_insert_al8(uint64_t *p, uint64_t val, uint64_t msk)
+{
+    uint64_t old, new;
+
+    qemu_build_assert(HAVE_al8);
+    p = __builtin_assume_aligned(p, 8);
+    old = qatomic_read__nocheck(p);
+    do {
+        new = (old & ~msk) | val;
+    } while (!__atomic_compare_exchange_n(p, &old, new, true,
+                                          __ATOMIC_RELAXED, __ATOMIC_RELAXED));
+}
+
+/**
+ * store_atom_insert_al16:
+ * @p: host address
+ * @val: shifted value to store
+ * @msk: mask for value to store
+ *
+ * Atomically store @val to @p masked by @msk.
+ */
+static void store_atom_insert_al16(Int128 *ps, Int128Alias val, Int128Alias msk)
+{
+#if defined(CONFIG_ATOMIC128)
+    __uint128_t *pu, old, new;
+
+    /* With CONFIG_ATOMIC128, we can avoid the memory barriers. */
+    pu = __builtin_assume_aligned(ps, 16);
+    old = *pu;
+    do {
+        new = (old & ~msk.u) | val.u;
+    } while (!__atomic_compare_exchange_n(pu, &old, new, true,
+                                          __ATOMIC_RELAXED, __ATOMIC_RELAXED));
+#elif defined(CONFIG_CMPXCHG128)
+    __uint128_t *pu, old, new;
+
+    /*
+     * Without CONFIG_ATOMIC128, __atomic_compare_exchange_n will always
+     * defer to libatomic, so we must use __sync_*_compare_and_swap_16
+     * and accept the sequential consistency that comes with it.
+     */
+    pu = __builtin_assume_aligned(ps, 16);
+    do {
+        old = *pu;
+        new = (old & ~msk.u) | val.u;
+    } while (!__sync_bool_compare_and_swap_16(pu, old, new));
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+/**
+ * store_bytes_leN:
+ * @pv: host address
+ * @size: number of bytes to store
+ * @val_le: data to store
+ *
+ * Store @size bytes at @p.  The bytes to store are extracted in little-endian order
+ * from @val_le; return the bytes of @val_le beyond @size that have not been stored.
+ */
+static uint64_t store_bytes_leN(void *pv, int size, uint64_t val_le)
+{
+    uint8_t *p = pv;
+    for (int i = 0; i < size; i++, val_le >>= 8) {
+        p[i] = val_le;
+    }
+    return val_le;
+}
+
+/**
+ * store_parts_leN
+ * @pv: host address
+ * @size: number of bytes to store
+ * @val_le: data to store
+ *
+ * As store_bytes_leN, but atomically on each aligned part.
+ */
+G_GNUC_UNUSED
+static uint64_t store_parts_leN(void *pv, int size, uint64_t val_le)
+{
+    do {
+        int n;
+
+        /* Find minimum of alignment and size */
+        switch (((uintptr_t)pv | size) & 7) {
+        case 4:
+            store_atomic4(pv, le32_to_cpu(val_le));
+            val_le >>= 32;
+            n = 4;
+            break;
+        case 2:
+        case 6:
+            store_atomic2(pv, le16_to_cpu(val_le));
+            val_le >>= 16;
+            n = 2;
+            break;
+        default:
+            *(uint8_t *)pv = val_le;
+            val_le >>= 8;
+            n = 1;
+            break;
+        case 0:
+            g_assert_not_reached();
+        }
+        pv += n;
+        size -= n;
+    } while (size != 0);
+
+    return val_le;
+}
+
+/**
+ * store_whole_le4
+ * @pv: host address
+ * @size: number of bytes to store
+ * @val_le: data to store
+ *
+ * As store_bytes_leN, but atomically as a whole.
+ * Four aligned bytes are guaranteed to cover the store.
+ */
+static uint64_t store_whole_le4(void *pv, int size, uint64_t val_le)
+{
+    int sz = size * 8;
+    int o = (uintptr_t)pv & 3;
+    int sh = o * 8;
+    uint32_t m = MAKE_64BIT_MASK(0, sz);
+    uint32_t v;
+
+    if (HOST_BIG_ENDIAN) {
+        v = bswap32(val_le) >> sh;
+        m = bswap32(m) >> sh;
+    } else {
+        v = val_le << sh;
+        m <<= sh;
+    }
+    store_atom_insert_al4(pv - o, v, m);
+    return val_le >> sz;
+}
+
+/**
+ * store_whole_le8
+ * @pv: host address
+ * @size: number of bytes to store
+ * @val_le: data to store
+ *
+ * As store_bytes_leN, but atomically as a whole.
+ * Eight aligned bytes are guaranteed to cover the store.
+ */
+static uint64_t store_whole_le8(void *pv, int size, uint64_t val_le)
+{
+    int sz = size * 8;
+    int o = (uintptr_t)pv & 7;
+    int sh = o * 8;
+    uint64_t m = MAKE_64BIT_MASK(0, sz);
+    uint64_t v;
+
+    qemu_build_assert(HAVE_al8);
+    if (HOST_BIG_ENDIAN) {
+        v = bswap64(val_le) >> sh;
+        m = bswap64(m) >> sh;
+    } else {
+        v = val_le << sh;
+        m <<= sh;
+    }
+    store_atom_insert_al8(pv - o, v, m);
+    return val_le >> sz;
+}
+
+/**
+ * store_whole_le16
+ * @pv: host address
+ * @size: number of bytes to store
+ * @val_le: data to store
+ *
+ * As store_bytes_leN, but atomically as a whole.
+ * 16 aligned bytes are guaranteed to cover the store.
+ */
+static uint64_t store_whole_le16(void *pv, int size, Int128 val_le)
+{
+    int sz = size * 8;
+    int o = (uintptr_t)pv & 15;
+    int sh = o * 8;
+    Int128 m, v;
+
+    qemu_build_assert(HAVE_al16);
+
+    /* Like MAKE_64BIT_MASK(0, sz), but larger. */
+    if (sz <= 64) {
+        m = int128_make64(MAKE_64BIT_MASK(0, sz));
+    } else {
+        m = int128_make128(-1, MAKE_64BIT_MASK(0, sz - 64));
+    }
+
+    if (HOST_BIG_ENDIAN) {
+        v = int128_urshift(bswap128(val_le), sh);
+        m = int128_urshift(bswap128(m), sh);
+    } else {
+        v = int128_lshift(val_le, sh);
+        m = int128_lshift(m, sh);
+    }
+    store_atom_insert_al16(pv - o, v, m);
+
+    /* Unused if sz <= 64. */
+    return int128_gethi(val_le) >> (sz - 64);
+}
+
+/**
+ * store_atom_2:
+ * @p: host address
+ * @val: the value to store
+ * @memop: the full memory op
+ *
+ * Store 2 bytes to @p, honoring the atomicity of @memop.
+ */
+static void store_atom_2(CPUArchState *env, uintptr_t ra,
+                         void *pv, MemOp memop, uint16_t val)
+{
+    uintptr_t pi = (uintptr_t)pv;
+    int atmax;
+
+    if (likely((pi & 1) == 0)) {
+        store_atomic2(pv, val);
+        return;
+    }
+
+    atmax = required_atomicity(env, pi, memop);
+    if (atmax == MO_8) {
+        stw_he_p(pv, val);
+        return;
+    }
+
+    /*
+     * The only case remaining is MO_ATOM_WITHIN16.
+     * Big or little endian, we want the middle two bytes in each test.
+     */
+    if ((pi & 3) == 1) {
+        store_atom_insert_al4(pv - 1, (uint32_t)val << 8, MAKE_64BIT_MASK(8, 16));
+        return;
+    } else if ((pi & 7) == 3) {
+        if (HAVE_al8) {
+            store_atom_insert_al8(pv - 3, (uint64_t)val << 24, MAKE_64BIT_MASK(24, 16));
+            return;
+        }
+    } else if ((pi & 15) == 7) {
+        if (HAVE_al16) {
+            Int128 v = int128_lshift(int128_make64(val), 56);
+            Int128 m = int128_lshift(int128_make64(0xffff), 56);
+            store_atom_insert_al16(pv - 7, v, m);
+            return;
+        }
+    } else {
+        g_assert_not_reached();
+    }
+
+    cpu_loop_exit_atomic(env_cpu(env), ra);
+}
+
+/**
+ * store_atom_4:
+ * @p: host address
+ * @val: the value to store
+ * @memop: the full memory op
+ *
+ * Store 4 bytes to @p, honoring the atomicity of @memop.
+ */
+static void store_atom_4(CPUArchState *env, uintptr_t ra,
+                         void *pv, MemOp memop, uint32_t val)
+{
+    uintptr_t pi = (uintptr_t)pv;
+    int atmax;
+
+    if (likely((pi & 3) == 0)) {
+        store_atomic4(pv, val);
+        return;
+    }
+
+    atmax = required_atomicity(env, pi, memop);
+    switch (atmax) {
+    case MO_8:
+        stl_he_p(pv, val);
+        return;
+    case MO_16:
+        store_atom_4_by_2(pv, val);
+        return;
+    case -MO_16:
+        {
+            uint32_t val_le = cpu_to_le32(val);
+            int s2 = pi & 3;
+            int s1 = 4 - s2;
+
+            switch (s2) {
+            case 1:
+                val_le = store_whole_le4(pv, s1, val_le);
+                *(uint8_t *)(pv + 3) = val_le;
+                break;
+            case 3:
+                *(uint8_t *)pv = val_le;
+                store_whole_le4(pv + 1, s2, val_le >> 8);
+                break;
+            case 0: /* aligned */
+            case 2: /* atmax MO_16 */
+            default:
+                g_assert_not_reached();
+            }
+        }
+        return;
+    case MO_32:
+        if ((pi & 7) < 4) {
+            if (HAVE_al8) {
+                store_whole_le8(pv, 4, cpu_to_le32(val));
+                return;
+            }
+        } else {
+            if (HAVE_al16) {
+                store_whole_le16(pv, 4, int128_make64(cpu_to_le32(val)));
+                return;
+            }
+        }
+        cpu_loop_exit_atomic(env_cpu(env), ra);
+    default:
+        g_assert_not_reached();
+    }
+}
+
+/**
+ * store_atom_8:
+ * @p: host address
+ * @val: the value to store
+ * @memop: the full memory op
+ *
+ * Store 8 bytes to @p, honoring the atomicity of @memop.
+ */
+static void store_atom_8(CPUArchState *env, uintptr_t ra,
+                         void *pv, MemOp memop, uint64_t val)
+{
+    uintptr_t pi = (uintptr_t)pv;
+    int atmax;
+
+    if (HAVE_al8 && likely((pi & 7) == 0)) {
+        store_atomic8(pv, val);
+        return;
+    }
+
+    atmax = required_atomicity(env, pi, memop);
+    switch (atmax) {
+    case MO_8:
+        stq_he_p(pv, val);
+        return;
+    case MO_16:
+        store_atom_8_by_2(pv, val);
+        return;
+    case MO_32:
+        store_atom_8_by_4(pv, val);
+        return;
+    case -MO_32:
+        if (HAVE_al8) {
+            uint64_t val_le = cpu_to_le64(val);
+            int s2 = pi & 7;
+            int s1 = 8 - s2;
+
+            switch (s2) {
+            case 1 ... 3:
+                val_le = store_whole_le8(pv, s1, val_le);
+                store_bytes_leN(pv + s1, s2, val_le);
+                break;
+            case 5 ... 7:
+                val_le = store_bytes_leN(pv, s1, val_le);
+                store_whole_le8(pv + s1, s2, val_le);
+                break;
+            case 0: /* aligned */
+            case 4: /* atmax MO_32 */
+            default:
+                g_assert_not_reached();
+            }
+            return;
+        }
+        break;
+    case MO_64:
+        if (HAVE_al16) {
+            store_whole_le16(pv, 8, int128_make64(cpu_to_le64(val)));
+            return;
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    cpu_loop_exit_atomic(env_cpu(env), ra);
+}
-- 
2.34.1


