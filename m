Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF187A2DBD
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:37:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM1A-000691-F1; Fri, 15 Sep 2023 23:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM18-00066W-Dv
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:46 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM16-00085q-HW
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:46 -0400
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-41215efeb1aso17101141cf.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835043; x=1695439843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aBqBQXzJtJdHMtNfnf/zOtS9LKrThM7LhRLI4QTpRQ8=;
 b=I3qqBGIzlfkPNufNpuI8QdfIW0wNKFNBYak9t0M6+kgQ9KxQeeUN5KIgNeGYTXH/m2
 IwkeGzWYSkTOoIRHDarOkQIfyhuhwQw2PZ8RHKLKetMQKYI3yVHbfZCk7bK548RQQZnQ
 OyPZEfoFZE24TMWUzjltvvm8Z9YTJVck7QnG0in+ScGSpl1CNY8GyCWZn51OLhIuFv0K
 Xy1ZwwLGcoYzEXEx7XDRB9DSnJIm8ev1x+Reo7UaC5OjMax3pqFEpnS1LKetWmGzdRwH
 nerY/+JJjG9PKz5xdPoiQyhpSTsUmSZL2hja+pMz0hWSLxrA8zLPD64qMPU5RvCZ1vjH
 HAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835043; x=1695439843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aBqBQXzJtJdHMtNfnf/zOtS9LKrThM7LhRLI4QTpRQ8=;
 b=P0mTkWy2zzVAwzix0s8t1g0sx2n/MHj8EktgUtfj5GG9JvDneRdcTBXymmTmKrPXyr
 wctTJE2kiDLQ2Z1ZPPESz9zv3VO1XApsKSxd87pNCwCnEYywHu0L4h9+dngmsgR4rCgu
 xiq8+1fQSfho87h8XZZXu5+No3Sl37cF6qUkd2etIK9I4sI1cFK/SPlXby9JTr5w4gMr
 9sWV71egBKDu83eryy1JfX+WZp30p6F+JoFyaWbBcq0/LhrVYPT/rJzL4qgsYNAluHrO
 hvE32WOn1AZMKD7USIq04nE+MXrmH00BCpjtaufiVoLMeL7M5VuTDmO4JPOyXSX+NpDO
 i1wA==
X-Gm-Message-State: AOJu0YyV89QBrlM5Xd9M60N9+DLfNq1tXpkaDvpIBjWGQhB5Av4FZ9Y7
 VL1O+IdVxaToHA1exazIG5MiTvXHd8xVjEt+OIw=
X-Google-Smtp-Source: AGHT+IFMP3mxaEz28WUNHGh7Ux8qQF6Nmr0LZFG/eO6MHE694mFJk6NTXyDecPBwFNyqOLhr1mttqQ==
X-Received: by 2002:a05:620a:3905:b0:76f:6c6:f0be with SMTP id
 qr5-20020a05620a390500b0076f06c6f0bemr4114977qkn.53.1694835043444; 
 Fri, 15 Sep 2023 20:30:43 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/39] accel/tcg: Introduce do_st16_mmio_leN
Date: Fri, 15 Sep 2023 20:30:05 -0700
Message-Id: <20230916033011.479144-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82a.google.com
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

Split out int_st_mmio_leN, to be used by both do_st_mmio_leN
and do_st16_mmio_leN.  Move the locks down into the two
functions, since each one now covers all accesses to once page.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 88 ++++++++++++++++++++++++++++++----------------
 1 file changed, 58 insertions(+), 30 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 7f6ccdecb1..3270f65c20 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2681,21 +2681,11 @@ Int128 cpu_ld16_mmu(CPUArchState *env, abi_ptr addr,
  * The bytes to store are extracted in little-endian order from @val_le;
  * return the bytes of @val_le beyond @p->size that have not been stored.
  */
-static uint64_t do_st_mmio_leN(CPUArchState *env, CPUTLBEntryFull *full,
-                               uint64_t val_le, vaddr addr, int size,
-                               int mmu_idx, uintptr_t ra)
+static uint64_t int_st_mmio_leN(CPUArchState *env, CPUTLBEntryFull *full,
+                                uint64_t val_le, vaddr addr, int size,
+                                int mmu_idx, uintptr_t ra,
+                                MemoryRegion *mr, hwaddr mr_offset)
 {
-    MemoryRegionSection *section;
-    hwaddr mr_offset;
-    MemoryRegion *mr;
-    MemTxAttrs attrs;
-
-    tcg_debug_assert(size > 0 && size <= 8);
-
-    attrs = full->attrs;
-    section = io_prepare(&mr_offset, env, full->xlat_section, attrs, addr, ra);
-    mr = section->mr;
-
     do {
         MemOp this_mop;
         unsigned this_size;
@@ -2707,7 +2697,7 @@ static uint64_t do_st_mmio_leN(CPUArchState *env, CPUTLBEntryFull *full,
         this_mop |= MO_LE;
 
         r = memory_region_dispatch_write(mr, mr_offset, val_le,
-                                         this_mop, attrs);
+                                         this_mop, full->attrs);
         if (unlikely(r != MEMTX_OK)) {
             io_failed(env, full, addr, this_size, MMU_DATA_STORE,
                       mmu_idx, r, ra);
@@ -2725,6 +2715,56 @@ static uint64_t do_st_mmio_leN(CPUArchState *env, CPUTLBEntryFull *full,
     return val_le;
 }
 
+static uint64_t do_st_mmio_leN(CPUArchState *env, CPUTLBEntryFull *full,
+                               uint64_t val_le, vaddr addr, int size,
+                               int mmu_idx, uintptr_t ra)
+{
+    MemoryRegionSection *section;
+    hwaddr mr_offset;
+    MemoryRegion *mr;
+    MemTxAttrs attrs;
+    uint64_t ret;
+
+    tcg_debug_assert(size > 0 && size <= 8);
+
+    attrs = full->attrs;
+    section = io_prepare(&mr_offset, env, full->xlat_section, attrs, addr, ra);
+    mr = section->mr;
+
+    qemu_mutex_lock_iothread();
+    ret = int_st_mmio_leN(env, full, val_le, addr, size, mmu_idx,
+                          ra, mr, mr_offset);
+    qemu_mutex_unlock_iothread();
+
+    return ret;
+}
+
+static uint64_t do_st16_mmio_leN(CPUArchState *env, CPUTLBEntryFull *full,
+                                 Int128 val_le, vaddr addr, int size,
+                                 int mmu_idx, uintptr_t ra)
+{
+    MemoryRegionSection *section;
+    MemoryRegion *mr;
+    hwaddr mr_offset;
+    MemTxAttrs attrs;
+    uint64_t ret;
+
+    tcg_debug_assert(size > 8 && size <= 16);
+
+    attrs = full->attrs;
+    section = io_prepare(&mr_offset, env, full->xlat_section, attrs, addr, ra);
+    mr = section->mr;
+
+    qemu_mutex_lock_iothread();
+    int_st_mmio_leN(env, full, int128_getlo(val_le), addr, 8,
+                    mmu_idx, ra, mr, mr_offset);
+    ret = int_st_mmio_leN(env, full, int128_gethi(val_le), addr + 8,
+                          size - 8, mmu_idx, ra, mr, mr_offset + 8);
+    qemu_mutex_unlock_iothread();
+
+    return ret;
+}
+
 /*
  * Wrapper for the above.
  */
@@ -2736,7 +2776,6 @@ static uint64_t do_st_leN(CPUArchState *env, MMULookupPageData *p,
     unsigned tmp, half_size;
 
     if (unlikely(p->flags & TLB_MMIO)) {
-        QEMU_IOTHREAD_LOCK_GUARD();
         return do_st_mmio_leN(env, p->full, val_le, p->addr,
                               p->size, mmu_idx, ra);
     } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
@@ -2791,11 +2830,8 @@ static uint64_t do_st16_leN(CPUArchState *env, MMULookupPageData *p,
     MemOp atom;
 
     if (unlikely(p->flags & TLB_MMIO)) {
-        QEMU_IOTHREAD_LOCK_GUARD();
-        do_st_mmio_leN(env, p->full, int128_getlo(val_le),
-                       p->addr, 8, mmu_idx, ra);
-        return do_st_mmio_leN(env, p->full, int128_gethi(val_le),
-                              p->addr + 8, size - 8, mmu_idx, ra);
+        return do_st16_mmio_leN(env, p->full, val_le, p->addr,
+                                size, mmu_idx, ra);
     } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
         return int128_gethi(val_le) >> ((size - 8) * 8);
     }
@@ -2839,7 +2875,6 @@ static void do_st_1(CPUArchState *env, MMULookupPageData *p, uint8_t val,
                     int mmu_idx, uintptr_t ra)
 {
     if (unlikely(p->flags & TLB_MMIO)) {
-        QEMU_IOTHREAD_LOCK_GUARD();
         do_st_mmio_leN(env, p->full, val, p->addr, 1, mmu_idx, ra);
     } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
         /* nothing */
@@ -2855,7 +2890,6 @@ static void do_st_2(CPUArchState *env, MMULookupPageData *p, uint16_t val,
         if ((memop & MO_BSWAP) != MO_LE) {
             val = bswap16(val);
         }
-        QEMU_IOTHREAD_LOCK_GUARD();
         do_st_mmio_leN(env, p->full, val, p->addr, 2, mmu_idx, ra);
     } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
         /* nothing */
@@ -2875,7 +2909,6 @@ static void do_st_4(CPUArchState *env, MMULookupPageData *p, uint32_t val,
         if ((memop & MO_BSWAP) != MO_LE) {
             val = bswap32(val);
         }
-        QEMU_IOTHREAD_LOCK_GUARD();
         do_st_mmio_leN(env, p->full, val, p->addr, 4, mmu_idx, ra);
     } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
         /* nothing */
@@ -2895,7 +2928,6 @@ static void do_st_8(CPUArchState *env, MMULookupPageData *p, uint64_t val,
         if ((memop & MO_BSWAP) != MO_LE) {
             val = bswap64(val);
         }
-        QEMU_IOTHREAD_LOCK_GUARD();
         do_st_mmio_leN(env, p->full, val, p->addr, 8, mmu_idx, ra);
     } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
         /* nothing */
@@ -3023,11 +3055,7 @@ static void do_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
             if ((l.memop & MO_BSWAP) != MO_LE) {
                 val = bswap128(val);
             }
-            a = int128_getlo(val);
-            b = int128_gethi(val);
-            QEMU_IOTHREAD_LOCK_GUARD();
-            do_st_mmio_leN(env, l.page[0].full, a, addr, 8, l.mmu_idx, ra);
-            do_st_mmio_leN(env, l.page[0].full, b, addr + 8, 8, l.mmu_idx, ra);
+            do_st16_mmio_leN(env, l.page[0].full, val, addr, 16, l.mmu_idx, ra);
         } else if (unlikely(l.page[0].flags & TLB_DISCARD_WRITE)) {
             /* nothing */
         } else {
-- 
2.34.1


