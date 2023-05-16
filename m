Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1D070582C
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:59:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0Yc-0006dY-H2; Tue, 16 May 2023 15:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0YZ-0006cR-GX
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:41:59 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0YW-0002kn-18
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:41:59 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-643a1656b79so10540543b3a.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266115; x=1686858115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IlW0xgIWcuqR7siElpNgCs7PK36ClUeHwwWlG1M+QvA=;
 b=aLBeiqT9QE8lRZ/g9Rp8hyQ+ppzofDGP04yuoXBPOcrvs9LUBynSRnWZk80uPgqC5q
 Udu+5cjJzYF1XTPMsVXeyoK5eJxQAcXXsR8CXSTbA+/y27gNfm8u83Vd/1bgg/RzDbff
 Q2X6iNuqbEUEanAGc63+3ZBW+2SFXI1troyCVT0qerM8OJmLVwFpUa4gvSBLOsI1J+AQ
 Da9zP7RA3MxQE411L5qo6X8aUj2jYo49KcaKcyfS2n9xRYDI94mwpWxdjxut9TzkWpfL
 FJ1MFsG8xdqcw/J7YecyNXDIgcLtdWvRqNeVgnzP+ItH4+RUPBD3ru7SoSRK4GGJurmI
 tn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266115; x=1686858115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IlW0xgIWcuqR7siElpNgCs7PK36ClUeHwwWlG1M+QvA=;
 b=DmTiQ1H6BsjL/m5fs42nosbg69LAJJN+brcAk5Fyki23IF9oqdS0Nqk6/IPIJ4acFK
 HunadMBPt2Ni8JqoiKRNREa2wQUsn74zdXYF8qHSxcMYXQFA8GWMdjsailen9ZGfdSmP
 JPKjDmAK8IuyqYICDGGBqCFBbqnPjqL14cQnPu6G6KaMTcNSsbSNoW5T0T3yxLfGuoNv
 fNsVtQ6ulAo553ybIdsahBhAXXBTpem8fxK2mlRO8bWMb/6ojLEbSdZ2w3oVY74yPw0P
 bbI5EU7u27bgWtf9Rz+aNCEBdEMLwNV8uXUyPWvUAw8hCYmfpnmhkh8Tv6t472QfekMJ
 wyzQ==
X-Gm-Message-State: AC+VfDwI3W73IcKP9EkS/yb0taPnhynMlxXHhSaSaVp7zS2+pGM5bbDi
 Y6bFQ9cXoBrUqpT8/nUFF8ifZU6rlgyta2ufuC4=
X-Google-Smtp-Source: ACHHUZ4m1il8SxjHf2KwJkaHL6jYng1MnH1q7o94WB/uC2dqt6s7ZNKd5eW2z2ZVPCOGP6KNpyWx2w==
X-Received: by 2002:a05:6a00:179b:b0:63b:62d1:d868 with SMTP id
 s27-20020a056a00179b00b0063b62d1d868mr58776361pfg.8.1684266114511; 
 Tue, 16 May 2023 12:41:54 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 z21-20020aa791d5000000b006260526cf0csm13771165pfa.116.2023.05.16.12.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:41:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 08/80] tcg: Add 128-bit guest memory primitives
Date: Tue, 16 May 2023 12:40:33 -0700
Message-Id: <20230516194145.1749305-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
 accel/tcg/tcg-runtime.h        |   3 +
 include/tcg/tcg-ldst.h         |   4 +
 accel/tcg/cputlb.c             | 399 +++++++++++++++++++++++++--------
 accel/tcg/user-exec.c          |  94 ++++++--
 tcg/tcg-op.c                   | 173 +++++++++-----
 accel/tcg/ldst_atomicity.c.inc | 184 +++++++++++++++
 6 files changed, 679 insertions(+), 178 deletions(-)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index b8e6421c8a..d9adc646c1 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -39,6 +39,9 @@ DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
 DEF_HELPER_FLAGS_3(memset, TCG_CALL_NO_RWG, ptr, ptr, int, ptr)
 #endif /* IN_HELPER_PROTO */
 
+DEF_HELPER_FLAGS_3(ld_i128, TCG_CALL_NO_WG, i128, env, tl, i32)
+DEF_HELPER_FLAGS_4(st_i128, TCG_CALL_NO_WG, void, env, tl, i128, i32)
+
 DEF_HELPER_FLAGS_5(atomic_cmpxchgb, TCG_CALL_NO_WG,
                    i32, env, tl, i32, i32, i32)
 DEF_HELPER_FLAGS_5(atomic_cmpxchgw_be, TCG_CALL_NO_WG,
diff --git a/include/tcg/tcg-ldst.h b/include/tcg/tcg-ldst.h
index 57fafa14b1..64f48e6990 100644
--- a/include/tcg/tcg-ldst.h
+++ b/include/tcg/tcg-ldst.h
@@ -34,6 +34,8 @@ tcg_target_ulong helper_ldul_mmu(CPUArchState *env, target_ulong addr,
                                  MemOpIdx oi, uintptr_t retaddr);
 uint64_t helper_ldq_mmu(CPUArchState *env, target_ulong addr,
                         MemOpIdx oi, uintptr_t retaddr);
+Int128 helper_ld16_mmu(CPUArchState *env, target_ulong addr,
+                       MemOpIdx oi, uintptr_t retaddr);
 
 /* Value sign-extended to tcg register size.  */
 tcg_target_ulong helper_ldsb_mmu(CPUArchState *env, target_ulong addr,
@@ -55,6 +57,8 @@ void helper_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
                     MemOpIdx oi, uintptr_t retaddr);
 void helper_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
                     MemOpIdx oi, uintptr_t retaddr);
+void helper_st16_mmu(CPUArchState *env, target_ulong addr, Int128 val,
+                     MemOpIdx oi, uintptr_t retaddr);
 
 #ifdef CONFIG_USER_ONLY
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 34796ef568..49e49f75a4 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -40,6 +40,7 @@
 #include "qemu/plugin-memory.h"
 #endif
 #include "tcg/tcg-ldst.h"
+#include "exec/helper-proto.h"
 
 /* DEBUG defines, enable DEBUG_TLB_LOG to log to the CPU_LOG_MMU target */
 /* #define DEBUG_TLB */
@@ -2162,6 +2163,31 @@ static uint64_t do_ld_whole_be8(CPUArchState *env, uintptr_t ra,
     return (ret_be << (p->size * 8)) | x;
 }
 
+/**
+ * do_ld_parts_be16
+ * @p: translation parameters
+ * @ret_be: accumulated data
+ *
+ * As do_ld_bytes_beN, but with one atomic load.
+ * 16 aligned bytes are guaranteed to cover the load.
+ */
+static Int128 do_ld_whole_be16(CPUArchState *env, uintptr_t ra,
+                               MMULookupPageData *p, uint64_t ret_be)
+{
+    int o = p->addr & 15;
+    Int128 x, y = load_atomic16_or_exit(env, ra, p->haddr - o);
+    int size = p->size;
+
+    if (!HOST_BIG_ENDIAN) {
+        y = bswap128(y);
+    }
+    y = int128_lshift(y, o * 8);
+    y = int128_urshift(y, (16 - size) * 8);
+    x = int128_make64(ret_be);
+    x = int128_lshift(x, size * 8);
+    return int128_or(x, y);
+}
+
 /*
  * Wrapper for the above.
  */
@@ -2211,6 +2237,63 @@ static uint64_t do_ld_beN(CPUArchState *env, MMULookupPageData *p,
     }
 }
 
+/*
+ * Wrapper for the above, for 8 < size < 16.
+ */
+static Int128 do_ld16_beN(CPUArchState *env, MMULookupPageData *p,
+                          uint64_t a, int mmu_idx, MemOp mop, uintptr_t ra)
+{
+    int size = p->size;
+    uint64_t b;
+    MemOp atom;
+
+    if (unlikely(p->flags & TLB_MMIO)) {
+        p->size = size - 8;
+        a = do_ld_mmio_beN(env, p, a, mmu_idx, MMU_DATA_LOAD, ra);
+        p->addr += p->size;
+        p->size = 8;
+        b = do_ld_mmio_beN(env, p, 0, mmu_idx, MMU_DATA_LOAD, ra);
+        return int128_make128(b, a);
+    }
+
+    /*
+     * It is a given that we cross a page and therefore there is no
+     * atomicity for the load as a whole, but subobjects may need attention.
+     */
+    atom = mop & MO_ATOM_MASK;
+    switch (atom) {
+    case MO_ATOM_SUBALIGN:
+        p->size = size - 8;
+        a = do_ld_parts_beN(p, a);
+        p->haddr += size - 8;
+        p->size = 8;
+        b = do_ld_parts_beN(p, 0);
+        break;
+
+    case MO_ATOM_WITHIN16_PAIR:
+        /* Since size > 8, this is the half that must be atomic. */
+        return do_ld_whole_be16(env, ra, p, a);
+
+    case MO_ATOM_IFALIGN_PAIR:
+        /*
+         * Since size > 8, both halves are misaligned,
+         * and so neither is atomic.
+         */
+    case MO_ATOM_IFALIGN:
+    case MO_ATOM_WITHIN16:
+    case MO_ATOM_NONE:
+        p->size = size - 8;
+        a = do_ld_bytes_beN(p, a);
+        b = ldq_be_p(p->haddr + size - 8);
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    return int128_make128(b, a);
+}
+
 static uint8_t do_ld_1(CPUArchState *env, MMULookupPageData *p, int mmu_idx,
                        MMUAccessType type, uintptr_t ra)
 {
@@ -2399,6 +2482,80 @@ tcg_target_ulong helper_ldsl_mmu(CPUArchState *env, target_ulong addr,
     return (int32_t)helper_ldul_mmu(env, addr, oi, retaddr);
 }
 
+static Int128 do_ld16_mmu(CPUArchState *env, target_ulong addr,
+                          MemOpIdx oi, uintptr_t ra)
+{
+    MMULookupLocals l;
+    bool crosspage;
+    uint64_t a, b;
+    Int128 ret;
+    int first;
+
+    crosspage = mmu_lookup(env, addr, oi, ra, MMU_DATA_LOAD, &l);
+    if (likely(!crosspage)) {
+        /* Perform the load host endian. */
+        if (unlikely(l.page[0].flags & TLB_MMIO)) {
+            QEMU_IOTHREAD_LOCK_GUARD();
+            a = io_readx(env, l.page[0].full, l.mmu_idx, addr,
+                         ra, MMU_DATA_LOAD, MO_64);
+            b = io_readx(env, l.page[0].full, l.mmu_idx, addr + 8,
+                         ra, MMU_DATA_LOAD, MO_64);
+            ret = int128_make128(HOST_BIG_ENDIAN ? b : a,
+                                 HOST_BIG_ENDIAN ? a : b);
+        } else {
+            ret = load_atom_16(env, ra, l.page[0].haddr, l.memop);
+        }
+        if (l.memop & MO_BSWAP) {
+            ret = bswap128(ret);
+        }
+        return ret;
+    }
+
+    first = l.page[0].size;
+    if (first == 8) {
+        MemOp mop8 = (l.memop & ~MO_SIZE) | MO_64;
+
+        a = do_ld_8(env, &l.page[0], l.mmu_idx, MMU_DATA_LOAD, mop8, ra);
+        b = do_ld_8(env, &l.page[1], l.mmu_idx, MMU_DATA_LOAD, mop8, ra);
+        if ((mop8 & MO_BSWAP) == MO_LE) {
+            ret = int128_make128(a, b);
+        } else {
+            ret = int128_make128(b, a);
+        }
+        return ret;
+    }
+
+    if (first < 8) {
+        a = do_ld_beN(env, &l.page[0], 0, l.mmu_idx,
+                      MMU_DATA_LOAD, l.memop, ra);
+        ret = do_ld16_beN(env, &l.page[1], a, l.mmu_idx, l.memop, ra);
+    } else {
+        ret = do_ld16_beN(env, &l.page[0], 0, l.mmu_idx, l.memop, ra);
+        b = int128_getlo(ret);
+        ret = int128_lshift(ret, l.page[1].size * 8);
+        a = int128_gethi(ret);
+        b = do_ld_beN(env, &l.page[1], b, l.mmu_idx,
+                      MMU_DATA_LOAD, l.memop, ra);
+        ret = int128_make128(b, a);
+    }
+    if ((l.memop & MO_BSWAP) == MO_LE) {
+        ret = bswap128(ret);
+    }
+    return ret;
+}
+
+Int128 helper_ld16_mmu(CPUArchState *env, target_ulong addr,
+                       uint32_t oi, uintptr_t retaddr)
+{
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
+    return do_ld16_mmu(env, addr, oi, retaddr);
+}
+
+Int128 helper_ld_i128(CPUArchState *env, target_ulong addr, uint32_t oi)
+{
+    return helper_ld16_mmu(env, addr, oi, GETPC());
+}
+
 /*
  * Load helpers for cpu_ldst.h.
  */
@@ -2487,59 +2644,23 @@ uint64_t cpu_ldq_le_mmu(CPUArchState *env, abi_ptr addr,
 Int128 cpu_ld16_be_mmu(CPUArchState *env, abi_ptr addr,
                        MemOpIdx oi, uintptr_t ra)
 {
-    MemOp mop = get_memop(oi);
-    int mmu_idx = get_mmuidx(oi);
-    MemOpIdx new_oi;
-    unsigned a_bits;
-    uint64_t h, l;
+    Int128 ret;
 
-    tcg_debug_assert((mop & (MO_BSWAP|MO_SSIZE)) == (MO_BE|MO_128));
-    a_bits = get_alignment_bits(mop);
-
-    /* Handle CPU specific unaligned behaviour */
-    if (addr & ((1 << a_bits) - 1)) {
-        cpu_unaligned_access(env_cpu(env), addr, MMU_DATA_LOAD,
-                             mmu_idx, ra);
-    }
-
-    /* Construct an unaligned 64-bit replacement MemOpIdx. */
-    mop = (mop & ~(MO_SIZE | MO_AMASK)) | MO_64 | MO_UNALN;
-    new_oi = make_memop_idx(mop, mmu_idx);
-
-    h = helper_ldq_mmu(env, addr, new_oi, ra);
-    l = helper_ldq_mmu(env, addr + 8, new_oi, ra);
-
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
-    return int128_make128(l, h);
+    tcg_debug_assert((get_memop(oi) & (MO_BSWAP|MO_SIZE)) == (MO_BE|MO_128));
+    ret = do_ld16_mmu(env, addr, oi, ra);
+    plugin_load_cb(env, addr, oi);
+    return ret;
 }
 
 Int128 cpu_ld16_le_mmu(CPUArchState *env, abi_ptr addr,
                        MemOpIdx oi, uintptr_t ra)
 {
-    MemOp mop = get_memop(oi);
-    int mmu_idx = get_mmuidx(oi);
-    MemOpIdx new_oi;
-    unsigned a_bits;
-    uint64_t h, l;
+    Int128 ret;
 
-    tcg_debug_assert((mop & (MO_BSWAP|MO_SSIZE)) == (MO_LE|MO_128));
-    a_bits = get_alignment_bits(mop);
-
-    /* Handle CPU specific unaligned behaviour */
-    if (addr & ((1 << a_bits) - 1)) {
-        cpu_unaligned_access(env_cpu(env), addr, MMU_DATA_LOAD,
-                             mmu_idx, ra);
-    }
-
-    /* Construct an unaligned 64-bit replacement MemOpIdx. */
-    mop = (mop & ~(MO_SIZE | MO_AMASK)) | MO_64 | MO_UNALN;
-    new_oi = make_memop_idx(mop, mmu_idx);
-
-    l = helper_ldq_mmu(env, addr, new_oi, ra);
-    h = helper_ldq_mmu(env, addr + 8, new_oi, ra);
-
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
-    return int128_make128(l, h);
+    tcg_debug_assert((get_memop(oi) & (MO_BSWAP|MO_SIZE)) == (MO_LE|MO_128));
+    ret = do_ld16_mmu(env, addr, oi, ra);
+    plugin_load_cb(env, addr, oi);
+    return ret;
 }
 
 /*
@@ -2625,6 +2746,60 @@ static uint64_t do_st_leN(CPUArchState *env, MMULookupPageData *p,
     }
 }
 
+/*
+ * Wrapper for the above, for 8 < size < 16.
+ */
+static uint64_t do_st16_leN(CPUArchState *env, MMULookupPageData *p,
+                            Int128 val_le, int mmu_idx,
+                            MemOp mop, uintptr_t ra)
+{
+    int size = p->size;
+    MemOp atom;
+
+    if (unlikely(p->flags & TLB_MMIO)) {
+        p->size = 8;
+        do_st_mmio_leN(env, p, int128_getlo(val_le), mmu_idx, ra);
+        p->size = size - 8;
+        p->addr += 8;
+        return do_st_mmio_leN(env, p, int128_gethi(val_le), mmu_idx, ra);
+    } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
+        return int128_gethi(val_le) >> ((size - 8) * 8);
+    }
+
+    /*
+     * It is a given that we cross a page and therefore there is no atomicity
+     * for the store as a whole, but subobjects may need attention.
+     */
+    atom = mop & MO_ATOM_MASK;
+    switch (atom) {
+    case MO_ATOM_SUBALIGN:
+        store_parts_leN(p->haddr, 8, int128_getlo(val_le));
+        return store_parts_leN(p->haddr + 8, p->size - 8,
+                               int128_gethi(val_le));
+
+    case MO_ATOM_WITHIN16_PAIR:
+        /* Since size > 8, this is the half that must be atomic. */
+        if (!HAVE_al16) {
+            cpu_loop_exit_atomic(env_cpu(env), ra);
+        }
+        return store_whole_le16(p->haddr, p->size, val_le);
+
+    case MO_ATOM_IFALIGN_PAIR:
+        /*
+         * Since size > 8, both halves are misaligned,
+         * and so neither is atomic.
+         */
+    case MO_ATOM_IFALIGN:
+    case MO_ATOM_NONE:
+        stq_le_p(p->haddr, int128_getlo(val_le));
+        return store_bytes_leN(p->haddr + 8, p->size - 8,
+                               int128_gethi(val_le));
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static void do_st_1(CPUArchState *env, MMULookupPageData *p, uint8_t val,
                     int mmu_idx, uintptr_t ra)
 {
@@ -2781,6 +2956,80 @@ void helper_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
     do_st8_mmu(env, addr, val, oi, retaddr);
 }
 
+static void do_st16_mmu(CPUArchState *env, target_ulong addr, Int128 val,
+                        MemOpIdx oi, uintptr_t ra)
+{
+    MMULookupLocals l;
+    bool crosspage;
+    uint64_t a, b;
+    int first;
+
+    crosspage = mmu_lookup(env, addr, oi, ra, MMU_DATA_STORE, &l);
+    if (likely(!crosspage)) {
+        /* Swap to host endian if necessary, then store. */
+        if (l.memop & MO_BSWAP) {
+            val = bswap128(val);
+        }
+        if (unlikely(l.page[0].flags & TLB_MMIO)) {
+            QEMU_IOTHREAD_LOCK_GUARD();
+            if (HOST_BIG_ENDIAN) {
+                b = int128_getlo(val), a = int128_gethi(val);
+            } else {
+                a = int128_getlo(val), b = int128_gethi(val);
+            }
+            io_writex(env, l.page[0].full, l.mmu_idx, a, addr, ra, MO_64);
+            io_writex(env, l.page[0].full, l.mmu_idx, b, addr + 8, ra, MO_64);
+        } else if (unlikely(l.page[0].flags & TLB_DISCARD_WRITE)) {
+            /* nothing */
+        } else {
+            store_atom_16(env, ra, l.page[0].haddr, l.memop, val);
+        }
+        return;
+    }
+
+    first = l.page[0].size;
+    if (first == 8) {
+        MemOp mop8 = (l.memop & ~(MO_SIZE | MO_BSWAP)) | MO_64;
+
+        if (l.memop & MO_BSWAP) {
+            val = bswap128(val);
+        }
+        if (HOST_BIG_ENDIAN) {
+            b = int128_getlo(val), a = int128_gethi(val);
+        } else {
+            a = int128_getlo(val), b = int128_gethi(val);
+        }
+        do_st_8(env, &l.page[0], a, l.mmu_idx, mop8, ra);
+        do_st_8(env, &l.page[1], b, l.mmu_idx, mop8, ra);
+        return;
+    }
+
+    if ((l.memop & MO_BSWAP) != MO_LE) {
+        val = bswap128(val);
+    }
+    if (first < 8) {
+        do_st_leN(env, &l.page[0], int128_getlo(val), l.mmu_idx, l.memop, ra);
+        val = int128_urshift(val, first * 8);
+        do_st16_leN(env, &l.page[1], val, l.mmu_idx, l.memop, ra);
+    } else {
+        b = do_st16_leN(env, &l.page[0], val, l.mmu_idx, l.memop, ra);
+        do_st_leN(env, &l.page[1], b, l.mmu_idx, l.memop, ra);
+    }
+}
+
+void helper_st16_mmu(CPUArchState *env, target_ulong addr, Int128 val,
+                     MemOpIdx oi, uintptr_t retaddr)
+{
+    tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
+    do_st16_mmu(env, addr, val, oi, retaddr);
+}
+
+void helper_st_i128(CPUArchState *env, target_ulong addr, Int128 val,
+                    MemOpIdx oi)
+{
+    helper_st16_mmu(env, addr, val, oi, GETPC());
+}
+
 /*
  * Store Helpers for cpu_ldst.h
  */
@@ -2845,58 +3094,20 @@ void cpu_stq_le_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
     plugin_store_cb(env, addr, oi);
 }
 
-void cpu_st16_be_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
-                     MemOpIdx oi, uintptr_t ra)
+void cpu_st16_be_mmu(CPUArchState *env, target_ulong addr, Int128 val,
+                     MemOpIdx oi, uintptr_t retaddr)
 {
-    MemOp mop = get_memop(oi);
-    int mmu_idx = get_mmuidx(oi);
-    MemOpIdx new_oi;
-    unsigned a_bits;
-
-    tcg_debug_assert((mop & (MO_BSWAP|MO_SSIZE)) == (MO_BE|MO_128));
-    a_bits = get_alignment_bits(mop);
-
-    /* Handle CPU specific unaligned behaviour */
-    if (addr & ((1 << a_bits) - 1)) {
-        cpu_unaligned_access(env_cpu(env), addr, MMU_DATA_STORE,
-                             mmu_idx, ra);
-    }
-
-    /* Construct an unaligned 64-bit replacement MemOpIdx. */
-    mop = (mop & ~(MO_SIZE | MO_AMASK)) | MO_64 | MO_UNALN;
-    new_oi = make_memop_idx(mop, mmu_idx);
-
-    helper_stq_mmu(env, addr, int128_gethi(val), new_oi, ra);
-    helper_stq_mmu(env, addr + 8, int128_getlo(val), new_oi, ra);
-
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
+    tcg_debug_assert((get_memop(oi) & (MO_BSWAP|MO_SIZE)) == (MO_BE|MO_128));
+    do_st16_mmu(env, addr, val, oi, retaddr);
+    plugin_store_cb(env, addr, oi);
 }
 
-void cpu_st16_le_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
-                     MemOpIdx oi, uintptr_t ra)
+void cpu_st16_le_mmu(CPUArchState *env, target_ulong addr, Int128 val,
+                     MemOpIdx oi, uintptr_t retaddr)
 {
-    MemOp mop = get_memop(oi);
-    int mmu_idx = get_mmuidx(oi);
-    MemOpIdx new_oi;
-    unsigned a_bits;
-
-    tcg_debug_assert((mop & (MO_BSWAP|MO_SSIZE)) == (MO_LE|MO_128));
-    a_bits = get_alignment_bits(mop);
-
-    /* Handle CPU specific unaligned behaviour */
-    if (addr & ((1 << a_bits) - 1)) {
-        cpu_unaligned_access(env_cpu(env), addr, MMU_DATA_STORE,
-                             mmu_idx, ra);
-    }
-
-    /* Construct an unaligned 64-bit replacement MemOpIdx. */
-    mop = (mop & ~(MO_SIZE | MO_AMASK)) | MO_64 | MO_UNALN;
-    new_oi = make_memop_idx(mop, mmu_idx);
-
-    helper_stq_mmu(env, addr, int128_getlo(val), new_oi, ra);
-    helper_stq_mmu(env, addr + 8, int128_gethi(val), new_oi, ra);
-
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
+    tcg_debug_assert((get_memop(oi) & (MO_BSWAP|MO_SIZE)) == (MO_LE|MO_128));
+    do_st16_mmu(env, addr, val, oi, retaddr);
+    plugin_store_cb(env, addr, oi);
 }
 
 #include "ldst_common.c.inc"
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index d9f9766b7f..8f86254eb4 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -1121,18 +1121,45 @@ uint64_t cpu_ldq_le_mmu(CPUArchState *env, abi_ptr addr,
     return cpu_to_le64(ret);
 }
 
-Int128 cpu_ld16_be_mmu(CPUArchState *env, abi_ptr addr,
-                       MemOpIdx oi, uintptr_t ra)
+static Int128 do_ld16_he_mmu(CPUArchState *env, abi_ptr addr,
+                             MemOp mop, uintptr_t ra)
 {
     void *haddr;
     Int128 ret;
 
-    tcg_debug_assert((get_memop(oi) & (MO_BSWAP | MO_SIZE)) == (MO_128 | MO_BE));
-    haddr = cpu_mmu_lookup(env, addr, oi, ra, MMU_DATA_LOAD);
-    memcpy(&ret, haddr, 16);
+    tcg_debug_assert((mop & MO_SIZE) == MO_128);
+    haddr = cpu_mmu_lookup(env, addr, mop, ra, MMU_DATA_LOAD);
+    ret = load_atom_16(env, ra, haddr, mop);
     clear_helper_retaddr();
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
+    return ret;
+}
 
+Int128 helper_ld16_mmu(CPUArchState *env, target_ulong addr,
+                       MemOpIdx oi, uintptr_t ra)
+{
+    MemOp mop = get_memop(oi);
+    Int128 ret = do_ld16_he_mmu(env, addr, mop, ra);
+
+    if (mop & MO_BSWAP) {
+        ret = bswap128(ret);
+    }
+    return ret;
+}
+
+Int128 helper_ld_i128(CPUArchState *env, target_ulong addr, MemOpIdx oi)
+{
+    return helper_ld16_mmu(env, addr, oi, GETPC());
+}
+
+Int128 cpu_ld16_be_mmu(CPUArchState *env, abi_ptr addr,
+                       MemOpIdx oi, uintptr_t ra)
+{
+    MemOp mop = get_memop(oi);
+    Int128 ret;
+
+    tcg_debug_assert((mop & MO_BSWAP) == MO_BE);
+    ret = do_ld16_he_mmu(env, addr, mop, ra);
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
     if (!HOST_BIG_ENDIAN) {
         ret = bswap128(ret);
     }
@@ -1142,15 +1169,12 @@ Int128 cpu_ld16_be_mmu(CPUArchState *env, abi_ptr addr,
 Int128 cpu_ld16_le_mmu(CPUArchState *env, abi_ptr addr,
                        MemOpIdx oi, uintptr_t ra)
 {
-    void *haddr;
+    MemOp mop = get_memop(oi);
     Int128 ret;
 
-    tcg_debug_assert((get_memop(oi) & (MO_BSWAP | MO_SIZE)) == (MO_128 | MO_LE));
-    haddr = cpu_mmu_lookup(env, addr, oi, ra, MMU_DATA_LOAD);
-    memcpy(&ret, haddr, 16);
-    clear_helper_retaddr();
+    tcg_debug_assert((mop & MO_BSWAP) == MO_LE);
+    ret = do_ld16_he_mmu(env, addr, mop, ra);
     qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
-
     if (HOST_BIG_ENDIAN) {
         ret = bswap128(ret);
     }
@@ -1307,33 +1331,57 @@ void cpu_stq_le_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
     qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
 }
 
-void cpu_st16_be_mmu(CPUArchState *env, abi_ptr addr,
-                     Int128 val, MemOpIdx oi, uintptr_t ra)
+static void do_st16_he_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
+                           MemOp mop, uintptr_t ra)
 {
     void *haddr;
 
-    tcg_debug_assert((get_memop(oi) & (MO_BSWAP | MO_SIZE)) == (MO_128 | MO_BE));
-    haddr = cpu_mmu_lookup(env, addr, oi, ra, MMU_DATA_STORE);
+    tcg_debug_assert((mop & MO_SIZE) == MO_128);
+    haddr = cpu_mmu_lookup(env, addr, mop, ra, MMU_DATA_STORE);
+    store_atom_16(env, ra, haddr, mop, val);
+    clear_helper_retaddr();
+}
+
+void helper_st16_mmu(CPUArchState *env, target_ulong addr, Int128 val,
+                     MemOpIdx oi, uintptr_t ra)
+{
+    MemOp mop = get_memop(oi);
+
+    if (mop & MO_BSWAP) {
+        val = bswap128(val);
+    }
+    do_st16_he_mmu(env, addr, val, mop, ra);
+}
+
+void helper_st_i128(CPUArchState *env, target_ulong addr,
+                    Int128 val, MemOpIdx oi)
+{
+    helper_st16_mmu(env, addr, val, oi, GETPC());
+}
+
+void cpu_st16_be_mmu(CPUArchState *env, abi_ptr addr,
+                     Int128 val, MemOpIdx oi, uintptr_t ra)
+{
+    MemOp mop = get_memop(oi);
+
+    tcg_debug_assert((mop & MO_BSWAP) == MO_BE);
     if (!HOST_BIG_ENDIAN) {
         val = bswap128(val);
     }
-    memcpy(haddr, &val, 16);
-    clear_helper_retaddr();
+    do_st16_he_mmu(env, addr, val, mop, ra);
     qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
 }
 
 void cpu_st16_le_mmu(CPUArchState *env, abi_ptr addr,
                      Int128 val, MemOpIdx oi, uintptr_t ra)
 {
-    void *haddr;
+    MemOp mop = get_memop(oi);
 
-    tcg_debug_assert((get_memop(oi) & (MO_BSWAP | MO_SIZE)) == (MO_128 | MO_LE));
-    haddr = cpu_mmu_lookup(env, addr, oi, ra, MMU_DATA_STORE);
+    tcg_debug_assert((mop & MO_BSWAP) == MO_LE);
     if (HOST_BIG_ENDIAN) {
         val = bswap128(val);
     }
-    memcpy(haddr, &val, 16);
-    clear_helper_retaddr();
+    do_st16_he_mmu(env, addr, val, mop, ra);
     qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
 }
 
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 3136cef81a..22481a344c 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -3119,6 +3119,37 @@ void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, MemOp memop)
     }
 }
 
+/*
+ * Return true if @mop, without knowledge of the pointer alignment,
+ * does not require 16-byte atomicity, and it would be adventagous
+ * to avoid a call to a helper function.
+ */
+static bool use_two_i64_for_i128(MemOp mop)
+{
+#ifdef CONFIG_SOFTMMU
+    /* Two softmmu tlb lookups is larger than one function call. */
+    return false;
+#else
+    /*
+     * For user-only, two 64-bit operations may well be smaller than a call.
+     * Determine if that would be legal for the requested atomicity.
+     */
+    switch (mop & MO_ATOM_MASK) {
+    case MO_ATOM_NONE:
+    case MO_ATOM_IFALIGN_PAIR:
+        return true;
+    case MO_ATOM_IFALIGN:
+    case MO_ATOM_SUBALIGN:
+    case MO_ATOM_WITHIN16:
+    case MO_ATOM_WITHIN16_PAIR:
+        /* In a serialized context, no atomicity is required. */
+        return !(tcg_ctx->gen_tb->cflags & CF_PARALLEL);
+    default:
+        g_assert_not_reached();
+    }
+#endif
+}
+
 static void canonicalize_memop_i128_as_i64(MemOp ret[2], MemOp orig)
 {
     MemOp mop_1 = orig, mop_2;
@@ -3164,93 +3195,113 @@ static void canonicalize_memop_i128_as_i64(MemOp ret[2], MemOp orig)
     ret[1] = mop_2;
 }
 
+#if TARGET_LONG_BITS == 64
+#define tcg_temp_ebb_new  tcg_temp_ebb_new_i64
+#else
+#define tcg_temp_ebb_new  tcg_temp_ebb_new_i32
+#endif
+
 void tcg_gen_qemu_ld_i128(TCGv_i128 val, TCGv addr, TCGArg idx, MemOp memop)
 {
-    MemOp mop[2];
-    TCGv addr_p8;
-    TCGv_i64 x, y;
+    MemOpIdx oi = make_memop_idx(memop, idx);
 
-    canonicalize_memop_i128_as_i64(mop, memop);
+    tcg_debug_assert((memop & MO_SIZE) == MO_128);
+    tcg_debug_assert((memop & MO_SIGN) == 0);
 
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     addr = plugin_prep_mem_callbacks(addr);
 
-    /* TODO: respect atomicity of the operation. */
     /* TODO: allow the tcg backend to see the whole operation. */
 
-    /*
-     * Since there are no global TCGv_i128, there is no visible state
-     * changed if the second load faults.  Load directly into the two
-     * subwords.
-     */
-    if ((memop & MO_BSWAP) == MO_LE) {
-        x = TCGV128_LOW(val);
-        y = TCGV128_HIGH(val);
+    if (use_two_i64_for_i128(memop)) {
+        MemOp mop[2];
+        TCGv addr_p8;
+        TCGv_i64 x, y;
+
+        canonicalize_memop_i128_as_i64(mop, memop);
+
+        /*
+         * Since there are no global TCGv_i128, there is no visible state
+         * changed if the second load faults.  Load directly into the two
+         * subwords.
+         */
+        if ((memop & MO_BSWAP) == MO_LE) {
+            x = TCGV128_LOW(val);
+            y = TCGV128_HIGH(val);
+        } else {
+            x = TCGV128_HIGH(val);
+            y = TCGV128_LOW(val);
+        }
+
+        gen_ldst_i64(INDEX_op_qemu_ld_i64, x, addr, mop[0], idx);
+
+        if ((mop[0] ^ memop) & MO_BSWAP) {
+            tcg_gen_bswap64_i64(x, x);
+        }
+
+        addr_p8 = tcg_temp_ebb_new();
+        tcg_gen_addi_tl(addr_p8, addr, 8);
+        gen_ldst_i64(INDEX_op_qemu_ld_i64, y, addr_p8, mop[1], idx);
+        tcg_temp_free(addr_p8);
+
+        if ((mop[0] ^ memop) & MO_BSWAP) {
+            tcg_gen_bswap64_i64(y, y);
+        }
     } else {
-        x = TCGV128_HIGH(val);
-        y = TCGV128_LOW(val);
+        gen_helper_ld_i128(val, cpu_env, addr, tcg_constant_i32(oi));
     }
 
-    gen_ldst_i64(INDEX_op_qemu_ld_i64, x, addr, mop[0], idx);
-
-    if ((mop[0] ^ memop) & MO_BSWAP) {
-        tcg_gen_bswap64_i64(x, x);
-    }
-
-    addr_p8 = tcg_temp_new();
-    tcg_gen_addi_tl(addr_p8, addr, 8);
-    gen_ldst_i64(INDEX_op_qemu_ld_i64, y, addr_p8, mop[1], idx);
-    tcg_temp_free(addr_p8);
-
-    if ((mop[0] ^ memop) & MO_BSWAP) {
-        tcg_gen_bswap64_i64(y, y);
-    }
-
-    plugin_gen_mem_callbacks(addr, make_memop_idx(memop, idx),
-                             QEMU_PLUGIN_MEM_R);
+    plugin_gen_mem_callbacks(addr, oi, QEMU_PLUGIN_MEM_R);
 }
 
 void tcg_gen_qemu_st_i128(TCGv_i128 val, TCGv addr, TCGArg idx, MemOp memop)
 {
-    MemOp mop[2];
-    TCGv addr_p8;
-    TCGv_i64 x, y;
+    MemOpIdx oi = make_memop_idx(memop, idx);
 
-    canonicalize_memop_i128_as_i64(mop, memop);
+    tcg_debug_assert((memop & MO_SIZE) == MO_128);
+    tcg_debug_assert((memop & MO_SIGN) == 0);
 
     tcg_gen_req_mo(TCG_MO_ST_LD | TCG_MO_ST_ST);
     addr = plugin_prep_mem_callbacks(addr);
 
-    /* TODO: respect atomicity of the operation. */
     /* TODO: allow the tcg backend to see the whole operation. */
 
-    if ((memop & MO_BSWAP) == MO_LE) {
-        x = TCGV128_LOW(val);
-        y = TCGV128_HIGH(val);
+    if (use_two_i64_for_i128(memop)) {
+        MemOp mop[2];
+        TCGv addr_p8;
+        TCGv_i64 x, y;
+
+        canonicalize_memop_i128_as_i64(mop, memop);
+
+        if ((memop & MO_BSWAP) == MO_LE) {
+            x = TCGV128_LOW(val);
+            y = TCGV128_HIGH(val);
+        } else {
+            x = TCGV128_HIGH(val);
+            y = TCGV128_LOW(val);
+        }
+
+        addr_p8 = tcg_temp_ebb_new();
+        if ((mop[0] ^ memop) & MO_BSWAP) {
+            TCGv_i64 t = tcg_temp_ebb_new_i64();
+
+            tcg_gen_bswap64_i64(t, x);
+            gen_ldst_i64(INDEX_op_qemu_st_i64, t, addr, mop[0], idx);
+            tcg_gen_bswap64_i64(t, y);
+            tcg_gen_addi_tl(addr_p8, addr, 8);
+            gen_ldst_i64(INDEX_op_qemu_st_i64, t, addr_p8, mop[1], idx);
+            tcg_temp_free_i64(t);
+        } else {
+            gen_ldst_i64(INDEX_op_qemu_st_i64, x, addr, mop[0], idx);
+            tcg_gen_addi_tl(addr_p8, addr, 8);
+            gen_ldst_i64(INDEX_op_qemu_st_i64, y, addr_p8, mop[1], idx);
+        }
+        tcg_temp_free(addr_p8);
     } else {
-        x = TCGV128_HIGH(val);
-        y = TCGV128_LOW(val);
+        gen_helper_st_i128(cpu_env, addr, val, tcg_constant_i32(oi));
     }
 
-    addr_p8 = tcg_temp_new();
-    if ((mop[0] ^ memop) & MO_BSWAP) {
-        TCGv_i64 t = tcg_temp_ebb_new_i64();
-
-        tcg_gen_bswap64_i64(t, x);
-        gen_ldst_i64(INDEX_op_qemu_st_i64, t, addr, mop[0], idx);
-        tcg_gen_bswap64_i64(t, y);
-        tcg_gen_addi_tl(addr_p8, addr, 8);
-        gen_ldst_i64(INDEX_op_qemu_st_i64, t, addr_p8, mop[1], idx);
-        tcg_temp_free_i64(t);
-    } else {
-        gen_ldst_i64(INDEX_op_qemu_st_i64, x, addr, mop[0], idx);
-        tcg_gen_addi_tl(addr_p8, addr, 8);
-        gen_ldst_i64(INDEX_op_qemu_st_i64, y, addr_p8, mop[1], idx);
-    }
-    tcg_temp_free(addr_p8);
-
-    plugin_gen_mem_callbacks(addr, make_memop_idx(memop, idx),
-                             QEMU_PLUGIN_MEM_W);
+    plugin_gen_mem_callbacks(addr, oi, QEMU_PLUGIN_MEM_W);
 }
 
 static void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc)
diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
index 1f39e43896..ce73b32def 100644
--- a/accel/tcg/ldst_atomicity.c.inc
+++ b/accel/tcg/ldst_atomicity.c.inc
@@ -439,6 +439,21 @@ static inline uint64_t load_atom_8_by_4(void *pv)
     }
 }
 
+/**
+ * load_atom_8_by_8_or_4:
+ * @pv: host address
+ *
+ * Load 8 bytes from aligned @pv, with at least 4-byte atomicity.
+ */
+static inline uint64_t load_atom_8_by_8_or_4(void *pv)
+{
+    if (HAVE_al8_fast) {
+        return load_atomic8(pv);
+    } else {
+        return load_atom_8_by_4(pv);
+    }
+}
+
 /**
  * load_atom_2:
  * @p: host address
@@ -571,6 +586,64 @@ static uint64_t load_atom_8(CPUArchState *env, uintptr_t ra,
     }
 }
 
+/**
+ * load_atom_16:
+ * @p: host address
+ * @memop: the full memory op
+ *
+ * Load 16 bytes from @p, honoring the atomicity of @memop.
+ */
+static Int128 load_atom_16(CPUArchState *env, uintptr_t ra,
+                           void *pv, MemOp memop)
+{
+    uintptr_t pi = (uintptr_t)pv;
+    int atmax;
+    Int128 r;
+    uint64_t a, b;
+
+    /*
+     * If the host does not support 16-byte atomics, wait until we have
+     * examined the atomicity parameters below.
+     */
+    if (HAVE_al16_fast && likely((pi & 15) == 0)) {
+        return load_atomic16(pv);
+    }
+
+    atmax = required_atomicity(env, pi, memop);
+    switch (atmax) {
+    case MO_8:
+        memcpy(&r, pv, 16);
+        return r;
+    case MO_16:
+        a = load_atom_8_by_2(pv);
+        b = load_atom_8_by_2(pv + 8);
+        break;
+    case MO_32:
+        a = load_atom_8_by_4(pv);
+        b = load_atom_8_by_4(pv + 8);
+        break;
+    case MO_64:
+        if (!HAVE_al8) {
+            cpu_loop_exit_atomic(env_cpu(env), ra);
+        }
+        a = load_atomic8(pv);
+        b = load_atomic8(pv + 8);
+        break;
+    case -MO_64:
+        if (!HAVE_al8) {
+            cpu_loop_exit_atomic(env_cpu(env), ra);
+        }
+        a = load_atom_extract_al8x2(pv);
+        b = load_atom_extract_al8x2(pv + 8);
+        break;
+    case MO_128:
+        return load_atomic16_or_exit(env, ra, pv);
+    default:
+        g_assert_not_reached();
+    }
+    return int128_make128(HOST_BIG_ENDIAN ? b : a, HOST_BIG_ENDIAN ? a : b);
+}
+
 /**
  * store_atomic2:
  * @pv: host address
@@ -612,6 +685,35 @@ static inline void store_atomic8(void *pv, uint64_t val)
     qatomic_set__nocheck(p, val);
 }
 
+/**
+ * store_atomic16:
+ * @pv: host address
+ * @val: value to store
+ *
+ * Atomically store 16 aligned bytes to @pv.
+ */
+static inline void store_atomic16(void *pv, Int128Alias val)
+{
+#if defined(CONFIG_ATOMIC128)
+    __uint128_t *pu = __builtin_assume_aligned(pv, 16);
+    qatomic_set__nocheck(pu, val.u);
+#elif defined(CONFIG_CMPXCHG128)
+    __uint128_t *pu = __builtin_assume_aligned(pv, 16);
+    __uint128_t o;
+
+    /*
+     * Without CONFIG_ATOMIC128, __atomic_compare_exchange_n will always
+     * defer to libatomic, so we must use __sync_*_compare_and_swap_16
+     * and accept the sequential consistency that comes with it.
+     */
+    do {
+        o = *pu;
+    } while (!__sync_bool_compare_and_swap_16(pu, o, val.u));
+#else
+    qemu_build_not_reached();
+#endif
+}
+
 /**
  * store_atom_4x2
  */
@@ -1055,3 +1157,85 @@ static void store_atom_8(CPUArchState *env, uintptr_t ra,
     }
     cpu_loop_exit_atomic(env_cpu(env), ra);
 }
+
+/**
+ * store_atom_16:
+ * @p: host address
+ * @val: the value to store
+ * @memop: the full memory op
+ *
+ * Store 16 bytes to @p, honoring the atomicity of @memop.
+ */
+static void store_atom_16(CPUArchState *env, uintptr_t ra,
+                          void *pv, MemOp memop, Int128 val)
+{
+    uintptr_t pi = (uintptr_t)pv;
+    uint64_t a, b;
+    int atmax;
+
+    if (HAVE_al16_fast && likely((pi & 15) == 0)) {
+        store_atomic16(pv, val);
+        return;
+    }
+
+    atmax = required_atomicity(env, pi, memop);
+
+    a = HOST_BIG_ENDIAN ? int128_gethi(val) : int128_getlo(val);
+    b = HOST_BIG_ENDIAN ? int128_getlo(val) : int128_gethi(val);
+    switch (atmax) {
+    case MO_8:
+        memcpy(pv, &val, 16);
+        return;
+    case MO_16:
+        store_atom_8_by_2(pv, a);
+        store_atom_8_by_2(pv + 8, b);
+        return;
+    case MO_32:
+        store_atom_8_by_4(pv, a);
+        store_atom_8_by_4(pv + 8, b);
+        return;
+    case MO_64:
+        if (HAVE_al8) {
+            store_atomic8(pv, a);
+            store_atomic8(pv + 8, b);
+            return;
+        }
+        break;
+    case -MO_64:
+        if (HAVE_al16) {
+            uint64_t val_le;
+            int s2 = pi & 15;
+            int s1 = 16 - s2;
+
+            if (HOST_BIG_ENDIAN) {
+                val = bswap128(val);
+            }
+            switch (s2) {
+            case 1 ... 7:
+                val_le = store_whole_le16(pv, s1, val);
+                store_bytes_leN(pv + s1, s2, val_le);
+                break;
+            case 9 ... 15:
+                store_bytes_leN(pv, s1, int128_getlo(val));
+                val = int128_urshift(val, s1 * 8);
+                store_whole_le16(pv + s1, s2, val);
+                break;
+            case 0: /* aligned */
+            case 8: /* atmax MO_64 */
+            default:
+                g_assert_not_reached();
+            }
+            return;
+        }
+        break;
+    case MO_128:
+        if (HAVE_al16) {
+            store_atomic16(pv, val);
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


