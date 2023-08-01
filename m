Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C50E76BCB4
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 20:43:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQuKL-0002Ym-EJ; Tue, 01 Aug 2023 14:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQuKB-0002Vj-DX
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 14:42:28 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQuK9-0008BR-0d
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 14:42:26 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1b8b4749013so47536615ad.2
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 11:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690915343; x=1691520143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GzpgU1UxAIReBoSrAXaDZGeNL1XIMo9Amk3ScSiPQdQ=;
 b=qK931mW2UtVw5JljT7JEsU0lKcUsiea5oUoMN9CjHnxcg9sgn6+TxkLUlr+7pklb9/
 4JZUxKIQi2HD5WmTfl0SElNhm8LuyG+wriHB+Z38ENRGDBeT1oC0391917rUrzlud7s3
 XTGtPEgr9X+U+EVwax59w8TrdNIf6UW98DjrrWDG+3gc4KGSqMl7UCWwygOqFU7bSzbk
 ZB+4K93UNlPFxxcCg2v+NKjdJzXexDtC4OdUDB+bDc7HMx7H9MSwP+e0DIFNrwclyprW
 GeDQXkGvq4y9yLKP42xhAmBNQh26XasLQdxuZ3ynAUP8Bzd6QPaFOWRYhWEpXdDUKDLk
 m9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690915343; x=1691520143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GzpgU1UxAIReBoSrAXaDZGeNL1XIMo9Amk3ScSiPQdQ=;
 b=gXFOUGwlNQhldBzvm0SW9WWqpTN/4TaiguaTsFcHh1fNip/YlwYjOAcxTMvr7jQF9Y
 B1sx0pnRDa4FE8NkEI8Gw0dZFnGdNflBH/RXmEgy55Kcq791VCVPi/9mpc49hfi0AV1h
 NNw/OzGrNhOe29186qoAj3PUXEE1ZThBcBPIcf9De1hCnEUCVH3vmf5hkr0UqtTcL/17
 y/35XLHAt2MkUThQcfWWowjuMiPVd8cmZUyyUzBdY+8fN5cMqD1+k14C/NLTCu5I01B+
 ECiIXPf+vg5u2x9PMIHqrQHC/jZDmSMZRvo1lZnsOn3ImeiYRr7gw3gHIiguZFq3LjBI
 Ow6Q==
X-Gm-Message-State: ABy/qLa8gHdmJdEEqwZbG8Gh1YPmyibamT8U9xTuzjH4JEm2IO2HPIqw
 Wdf9vPepCIFA1fnAVDKQdy9TcpgRb2m3qy4lJz4=
X-Google-Smtp-Source: APBJJlFOcinqJ9Ohs9yrT70qlu9ipzWfDU/DjQhGZzC1IpOBCYcmdG9QwHU7JA7QDXyTa8Lnfc3ySA==
X-Received: by 2002:a17:902:820c:b0:1b8:4b87:20dc with SMTP id
 x12-20020a170902820c00b001b84b8720dcmr12972509pln.37.1690915343003; 
 Tue, 01 Aug 2023 11:42:23 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:67b4:35b2:87e2:dccc])
 by smtp.gmail.com with ESMTPSA id
 jn13-20020a170903050d00b001b80ed7b66fsm10797037plb.94.2023.08.01.11.42.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Aug 2023 11:42:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] accel/tcg: Adjust parameters and locking with do_{ld,
 st}_mmio_*
Date: Tue,  1 Aug 2023 11:42:18 -0700
Message-Id: <20230801184220.75224-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801184220.75224-1-richard.henderson@linaro.org>
References: <20230801184220.75224-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Replace MMULookupPageData* with CPUTLBEntryFull, addr, size.
Move QEMU_IOTHREAD_LOCK_GUARD to the caller.

This simplifies the usage from do_ld16_beN and do_st16_leN, where
we weren't locking the entire operation, and required hoop jumping
for passing addr and size.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 65 +++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index ba44501a7c..d28606b93e 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2066,24 +2066,21 @@ static void *atomic_mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
 /**
  * do_ld_mmio_beN:
  * @env: cpu context
- * @p: translation parameters
+ * @full: page parameters
  * @ret_be: accumulated data
+ * @addr: virtual address
+ * @size: number of bytes
  * @mmu_idx: virtual address context
  * @ra: return address into tcg generated code, or 0
  *
- * Load @p->size bytes from @p->addr, which is memory-mapped i/o.
+ * Load @size bytes from @addr, which is memory-mapped i/o.
  * The bytes are concatenated in big-endian order with @ret_be.
  */
-static uint64_t do_ld_mmio_beN(CPUArchState *env, MMULookupPageData *p,
-                               uint64_t ret_be, int mmu_idx,
-                               MMUAccessType type, uintptr_t ra)
+static uint64_t do_ld_mmio_beN(CPUArchState *env, CPUTLBEntryFull *full,
+                               uint64_t ret_be, vaddr addr, int size,
+                               int mmu_idx, MMUAccessType type, uintptr_t ra)
 {
-    CPUTLBEntryFull *full = p->full;
-    vaddr addr = p->addr;
-    int i, size = p->size;
-
-    QEMU_IOTHREAD_LOCK_GUARD();
-    for (i = 0; i < size; i++) {
+    for (int i = 0; i < size; i++) {
         uint8_t x = io_readx(env, full, mmu_idx, addr + i, ra, type, MO_UB);
         ret_be = (ret_be << 8) | x;
     }
@@ -2232,7 +2229,9 @@ static uint64_t do_ld_beN(CPUArchState *env, MMULookupPageData *p,
     unsigned tmp, half_size;
 
     if (unlikely(p->flags & TLB_MMIO)) {
-        return do_ld_mmio_beN(env, p, ret_be, mmu_idx, type, ra);
+        QEMU_IOTHREAD_LOCK_GUARD();
+        return do_ld_mmio_beN(env, p->full, ret_be, p->addr, p->size,
+                              mmu_idx, type, ra);
     }
 
     /*
@@ -2281,11 +2280,11 @@ static Int128 do_ld16_beN(CPUArchState *env, MMULookupPageData *p,
     MemOp atom;
 
     if (unlikely(p->flags & TLB_MMIO)) {
-        p->size = size - 8;
-        a = do_ld_mmio_beN(env, p, a, mmu_idx, MMU_DATA_LOAD, ra);
-        p->addr += p->size;
-        p->size = 8;
-        b = do_ld_mmio_beN(env, p, 0, mmu_idx, MMU_DATA_LOAD, ra);
+        QEMU_IOTHREAD_LOCK_GUARD();
+        a = do_ld_mmio_beN(env, p->full, a, p->addr, size - 8,
+                           mmu_idx, MMU_DATA_LOAD, ra);
+        b = do_ld_mmio_beN(env, p->full, 0, p->addr + 8, 8,
+                           mmu_idx, MMU_DATA_LOAD, ra);
         return int128_make128(b, a);
     }
 
@@ -2664,24 +2663,22 @@ Int128 cpu_ld16_mmu(CPUArchState *env, abi_ptr addr,
 /**
  * do_st_mmio_leN:
  * @env: cpu context
- * @p: translation parameters
+ * @full: page parameters
  * @val_le: data to store
+ * @addr: virtual address
+ * @size: number of bytes
  * @mmu_idx: virtual address context
  * @ra: return address into tcg generated code, or 0
  *
- * Store @p->size bytes at @p->addr, which is memory-mapped i/o.
+ * Store @size bytes at @addr, which is memory-mapped i/o.
  * The bytes to store are extracted in little-endian order from @val_le;
  * return the bytes of @val_le beyond @p->size that have not been stored.
  */
-static uint64_t do_st_mmio_leN(CPUArchState *env, MMULookupPageData *p,
-                               uint64_t val_le, int mmu_idx, uintptr_t ra)
+static uint64_t do_st_mmio_leN(CPUArchState *env, CPUTLBEntryFull *full,
+                               uint64_t val_le, vaddr addr, int size,
+                               int mmu_idx, uintptr_t ra)
 {
-    CPUTLBEntryFull *full = p->full;
-    vaddr addr = p->addr;
-    int i, size = p->size;
-
-    QEMU_IOTHREAD_LOCK_GUARD();
-    for (i = 0; i < size; i++, val_le >>= 8) {
+    for (int i = 0; i < size; i++, val_le >>= 8) {
         io_writex(env, full, mmu_idx, val_le, addr + i, ra, MO_UB);
     }
     return val_le;
@@ -2698,7 +2695,9 @@ static uint64_t do_st_leN(CPUArchState *env, MMULookupPageData *p,
     unsigned tmp, half_size;
 
     if (unlikely(p->flags & TLB_MMIO)) {
-        return do_st_mmio_leN(env, p, val_le, mmu_idx, ra);
+        QEMU_IOTHREAD_LOCK_GUARD();
+        return do_st_mmio_leN(env, p->full, val_le, p->addr,
+                              p->size, mmu_idx, ra);
     } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
         return val_le >> (p->size * 8);
     }
@@ -2751,11 +2750,11 @@ static uint64_t do_st16_leN(CPUArchState *env, MMULookupPageData *p,
     MemOp atom;
 
     if (unlikely(p->flags & TLB_MMIO)) {
-        p->size = 8;
-        do_st_mmio_leN(env, p, int128_getlo(val_le), mmu_idx, ra);
-        p->size = size - 8;
-        p->addr += 8;
-        return do_st_mmio_leN(env, p, int128_gethi(val_le), mmu_idx, ra);
+        QEMU_IOTHREAD_LOCK_GUARD();
+        do_st_mmio_leN(env, p->full, int128_getlo(val_le),
+                       p->addr, 8, mmu_idx, ra);
+        return do_st_mmio_leN(env, p->full, int128_gethi(val_le),
+                              p->addr + 8, size - 8, mmu_idx, ra);
     } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
         return int128_gethi(val_le) >> ((size - 8) * 8);
     }
-- 
2.34.1


