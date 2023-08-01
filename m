Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D962976BCAE
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 20:42:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQuKN-0002bK-F9; Tue, 01 Aug 2023 14:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQuKD-0002Xx-QT
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 14:42:32 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQuKB-0008Bo-6e
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 14:42:29 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1b8b2886364so37226055ad.0
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 11:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690915344; x=1691520144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3hmx6n4YMJ0ZtCJB1FwiwXROlhS1n5qLC092dlmrtPA=;
 b=RtYEkwVRMJBZQWCQ9XjMR21i81DAEiaJj2BzUVy3IDgySlX+5VqLjHxpwy5nqjtE+K
 DfgV6SeVAUGgfqBaG365YyXIr19cFLR4ZaDr5R2GU2sAsSz2zGY/7ArbSiP13ZqD/SA4
 CezW1eihhqzstAX5B78e8bKn9NZWtIs8dc7at3wEW8POeg345CwkqZSU26AicWidRzfW
 UfHSpxm2KJDkSB4N6Giwnbwp7iSpot9gxPYzPL7zl7NVc0bhAtXjAaQ2c5xoWHj9pdUn
 4QTicGfwNeysuKFsDU4IEKh136uaDhzoTLC8vj1MgsZgMVxoKjUaLcrHjJIxsHwuatJU
 /cWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690915344; x=1691520144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3hmx6n4YMJ0ZtCJB1FwiwXROlhS1n5qLC092dlmrtPA=;
 b=l9rLSCpvQwXZpAMVwvkL7LNPJpdFJMAfSeQFW2eqZKmBhOtcfzTA8vBGzXI3kOPR9K
 g/BO5pRkEHlPbhal28YEqZu6ZzCRN2wnFqEvMW8JxOofNsIZ2xSpcbCKQnltMYmqbgGw
 igKCEkwWd1/8ToDgp+JxHUXIXCmMuEm8Xq/noKSMXZuGHVkO+6Mi9VbXwP8ylIDunqzy
 p6qPuxSytHcw8SrFM+VNMf9OBLCDJ/BRqQC46ze0qY4DtgthvhEVeQnyp1oUW3HxVRNO
 UjTgxnHd3rrAEpvyufbiOcYGteDp5WU41lUxfZ/ssB4haXEgZ8P8tvPPWH/tYylmXs9K
 tevQ==
X-Gm-Message-State: ABy/qLa47hqoFVLi4flCL1e4cxMegz4l5mcKjWYTauDHyDv3ay5jyjew
 EDCtBzvlAasyuENeYvPqioo4Y3eezzRD3D8pQdY=
X-Google-Smtp-Source: APBJJlGSq0gGjLmAsw9g5MVN19AQkc+40I+3Yr5Rxg5wZMrsrVDz/9IQt0rxNIiWsR0mCN1uzXzvEQ==
X-Received: by 2002:a17:902:ce8f:b0:1bb:c87d:756d with SMTP id
 f15-20020a170902ce8f00b001bbc87d756dmr14302757plg.42.1690915344464; 
 Tue, 01 Aug 2023 11:42:24 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:67b4:35b2:87e2:dccc])
 by smtp.gmail.com with ESMTPSA id
 jn13-20020a170903050d00b001b80ed7b66fsm10797037plb.94.2023.08.01.11.42.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Aug 2023 11:42:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] accel/tcg: Do not issue misaligned i/o
Date: Tue,  1 Aug 2023 11:42:20 -0700
Message-Id: <20230801184220.75224-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801184220.75224-1-richard.henderson@linaro.org>
References: <20230801184220.75224-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

In the single-page case we were issuing misaligned i/o to
the memory subsystem, which does not handle it properly.
Split such accesses via do_{ld,st}_mmio_*.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1800
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 118 +++++++++++++++++++++++++++------------------
 1 file changed, 72 insertions(+), 46 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index c3e1fdbf37..05d272f839 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2369,16 +2369,20 @@ static uint8_t do_ld_1(CPUArchState *env, MMULookupPageData *p, int mmu_idx,
 static uint16_t do_ld_2(CPUArchState *env, MMULookupPageData *p, int mmu_idx,
                         MMUAccessType type, MemOp memop, uintptr_t ra)
 {
-    uint64_t ret;
+    uint16_t ret;
 
     if (unlikely(p->flags & TLB_MMIO)) {
-        return io_readx(env, p->full, mmu_idx, p->addr, ra, type, memop);
-    }
-
-    /* Perform the load host endian, then swap if necessary. */
-    ret = load_atom_2(env, ra, p->haddr, memop);
-    if (memop & MO_BSWAP) {
-        ret = bswap16(ret);
+        QEMU_IOTHREAD_LOCK_GUARD();
+        ret = do_ld_mmio_beN(env, p->full, 0, p->addr, 2, mmu_idx, type, ra);
+        if ((memop & MO_BSWAP) == MO_LE) {
+            ret = bswap16(ret);
+        }
+    } else {
+        /* Perform the load host endian, then swap if necessary. */
+        ret = load_atom_2(env, ra, p->haddr, memop);
+        if (memop & MO_BSWAP) {
+            ret = bswap16(ret);
+        }
     }
     return ret;
 }
@@ -2389,13 +2393,17 @@ static uint32_t do_ld_4(CPUArchState *env, MMULookupPageData *p, int mmu_idx,
     uint32_t ret;
 
     if (unlikely(p->flags & TLB_MMIO)) {
-        return io_readx(env, p->full, mmu_idx, p->addr, ra, type, memop);
-    }
-
-    /* Perform the load host endian. */
-    ret = load_atom_4(env, ra, p->haddr, memop);
-    if (memop & MO_BSWAP) {
-        ret = bswap32(ret);
+        QEMU_IOTHREAD_LOCK_GUARD();
+        ret = do_ld_mmio_beN(env, p->full, 0, p->addr, 4, mmu_idx, type, ra);
+        if ((memop & MO_BSWAP) == MO_LE) {
+            ret = bswap32(ret);
+        }
+    } else {
+        /* Perform the load host endian. */
+        ret = load_atom_4(env, ra, p->haddr, memop);
+        if (memop & MO_BSWAP) {
+            ret = bswap32(ret);
+        }
     }
     return ret;
 }
@@ -2406,13 +2414,17 @@ static uint64_t do_ld_8(CPUArchState *env, MMULookupPageData *p, int mmu_idx,
     uint64_t ret;
 
     if (unlikely(p->flags & TLB_MMIO)) {
-        return io_readx(env, p->full, mmu_idx, p->addr, ra, type, memop);
-    }
-
-    /* Perform the load host endian. */
-    ret = load_atom_8(env, ra, p->haddr, memop);
-    if (memop & MO_BSWAP) {
-        ret = bswap64(ret);
+        QEMU_IOTHREAD_LOCK_GUARD();
+        ret = do_ld_mmio_beN(env, p->full, 0, p->addr, 8, mmu_idx, type, ra);
+        if ((memop & MO_BSWAP) == MO_LE) {
+            ret = bswap64(ret);
+        }
+    } else {
+        /* Perform the load host endian. */
+        ret = load_atom_8(env, ra, p->haddr, memop);
+        if (memop & MO_BSWAP) {
+            ret = bswap64(ret);
+        }
     }
     return ret;
 }
@@ -2560,20 +2572,22 @@ static Int128 do_ld16_mmu(CPUArchState *env, vaddr addr,
     cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     crosspage = mmu_lookup(env, addr, oi, ra, MMU_DATA_LOAD, &l);
     if (likely(!crosspage)) {
-        /* Perform the load host endian. */
         if (unlikely(l.page[0].flags & TLB_MMIO)) {
             QEMU_IOTHREAD_LOCK_GUARD();
-            a = io_readx(env, l.page[0].full, l.mmu_idx, addr,
-                         ra, MMU_DATA_LOAD, MO_64);
-            b = io_readx(env, l.page[0].full, l.mmu_idx, addr + 8,
-                         ra, MMU_DATA_LOAD, MO_64);
-            ret = int128_make128(HOST_BIG_ENDIAN ? b : a,
-                                 HOST_BIG_ENDIAN ? a : b);
+            a = do_ld_mmio_beN(env, l.page[0].full, 0, addr, 8,
+                               l.mmu_idx, MMU_DATA_LOAD, ra);
+            b = do_ld_mmio_beN(env, l.page[0].full, 0, addr + 8, 8,
+                               l.mmu_idx, MMU_DATA_LOAD, ra);
+            ret = int128_make128(b, a);
+            if ((l.memop & MO_BSWAP) == MO_LE) {
+                ret = bswap128(ret);
+            }
         } else {
+            /* Perform the load host endian. */
             ret = load_atom_16(env, ra, l.page[0].haddr, l.memop);
-        }
-        if (l.memop & MO_BSWAP) {
-            ret = bswap128(ret);
+            if (l.memop & MO_BSWAP) {
+                ret = bswap128(ret);
+            }
         }
         return ret;
     }
@@ -2872,7 +2886,11 @@ static void do_st_2(CPUArchState *env, MMULookupPageData *p, uint16_t val,
                     int mmu_idx, MemOp memop, uintptr_t ra)
 {
     if (unlikely(p->flags & TLB_MMIO)) {
-        io_writex(env, p->full, mmu_idx, val, p->addr, ra, memop);
+        if ((memop & MO_BSWAP) != MO_LE) {
+            val = bswap16(val);
+        }
+        QEMU_IOTHREAD_LOCK_GUARD();
+        do_st_mmio_leN(env, p->full, val, p->addr, 2, mmu_idx, ra);
     } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
         /* nothing */
     } else {
@@ -2888,7 +2906,11 @@ static void do_st_4(CPUArchState *env, MMULookupPageData *p, uint32_t val,
                     int mmu_idx, MemOp memop, uintptr_t ra)
 {
     if (unlikely(p->flags & TLB_MMIO)) {
-        io_writex(env, p->full, mmu_idx, val, p->addr, ra, memop);
+        if ((memop & MO_BSWAP) != MO_LE) {
+            val = bswap32(val);
+        }
+        QEMU_IOTHREAD_LOCK_GUARD();
+        do_st_mmio_leN(env, p->full, val, p->addr, 4, mmu_idx, ra);
     } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
         /* nothing */
     } else {
@@ -2904,7 +2926,11 @@ static void do_st_8(CPUArchState *env, MMULookupPageData *p, uint64_t val,
                     int mmu_idx, MemOp memop, uintptr_t ra)
 {
     if (unlikely(p->flags & TLB_MMIO)) {
-        io_writex(env, p->full, mmu_idx, val, p->addr, ra, memop);
+        if ((memop & MO_BSWAP) != MO_LE) {
+            val = bswap64(val);
+        }
+        QEMU_IOTHREAD_LOCK_GUARD();
+        do_st_mmio_leN(env, p->full, val, p->addr, 8, mmu_idx, ra);
     } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
         /* nothing */
     } else {
@@ -3027,22 +3053,22 @@ static void do_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
     cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     crosspage = mmu_lookup(env, addr, oi, ra, MMU_DATA_STORE, &l);
     if (likely(!crosspage)) {
-        /* Swap to host endian if necessary, then store. */
-        if (l.memop & MO_BSWAP) {
-            val = bswap128(val);
-        }
         if (unlikely(l.page[0].flags & TLB_MMIO)) {
-            QEMU_IOTHREAD_LOCK_GUARD();
-            if (HOST_BIG_ENDIAN) {
-                b = int128_getlo(val), a = int128_gethi(val);
-            } else {
-                a = int128_getlo(val), b = int128_gethi(val);
+            if ((l.memop & MO_BSWAP) != MO_LE) {
+                val = bswap128(val);
             }
-            io_writex(env, l.page[0].full, l.mmu_idx, a, addr, ra, MO_64);
-            io_writex(env, l.page[0].full, l.mmu_idx, b, addr + 8, ra, MO_64);
+            a = int128_getlo(val);
+            b = int128_gethi(val);
+            QEMU_IOTHREAD_LOCK_GUARD();
+            do_st_mmio_leN(env, l.page[0].full, a, addr, 8, l.mmu_idx, ra);
+            do_st_mmio_leN(env, l.page[0].full, b, addr + 8, 8, l.mmu_idx, ra);
         } else if (unlikely(l.page[0].flags & TLB_DISCARD_WRITE)) {
             /* nothing */
         } else {
+            /* Swap to host endian if necessary, then store. */
+            if (l.memop & MO_BSWAP) {
+                val = bswap128(val);
+            }
             store_atom_16(env, ra, l.page[0].haddr, l.memop, val);
         }
         return;
-- 
2.34.1


