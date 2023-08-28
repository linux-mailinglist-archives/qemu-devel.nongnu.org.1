Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C886178B7AA
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 20:57:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qahPC-0000sc-GE; Mon, 28 Aug 2023 14:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qahPA-0000rb-J9
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:56:04 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qahP8-0002Sn-1z
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:56:04 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-26d50a832a9so1857731a91.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 11:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693248961; x=1693853761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cS4vlm8y6MqQ8ErQLX0t/96y+gcpjdiVv6UfrIIxZbo=;
 b=EKjbNHz4SXq67JnJFEotkal0Y0+t1ZmKBS6vctZQ/TqHPTRP/MLDQW+jW/xCgqM9zs
 0yYOQjmO/j9nKf479bbUWaqfSVcQVL63KD8nd9dEBGaWPjnhc7arqpasVxmee87ypz4f
 mdnPnzSO+bX1JvPvPxJxItmzNu3v/gDeLJFsEfhzXbz2r73mNDYg4Kbaoij0Fd3htMI3
 1xRpkzjknjPsWEUiDGODr2thB2Q27MMr7wyKma2W5cfRs0Lm8CKyWFpDVevmYFTZ3vS4
 e0QTVvqMW4Z6Vw66C15olGS0lUQD94VXSVlJcCBs5PHKkTHj6R/p0+HxHw10NNBgEoi6
 KK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693248961; x=1693853761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cS4vlm8y6MqQ8ErQLX0t/96y+gcpjdiVv6UfrIIxZbo=;
 b=Vn+RcMfyBDCvqwh4PVstCXGwUgbMEOfO5AUoS1JYVHaXIkcButLES+rLBvf+oL6dU/
 e5qvPpFc6BY2GovoGH+wyBTvyD9khid5s8gNHvvVeaGpvYRxB5Gcns6OlaOMzbDgOlYq
 mJfgTVnI5fAcuRT6vOrI98r2U1L9xJzlI6Qm8xFlzAB+cvW2qBujBf5DYLAj5fAtEopO
 kz5KnRUvtLVvaTllDzHenrSXKS7M7WfuVQL4pGF+EHIvbarGwAxDpX9eVZ0LiXF4ZNNp
 KvyYD8gxgrwzuizU+Ul17WX6T/a8l6+6bakyBrFiMmVp3YN/Z6KJT4GZWr/0evT0k4VT
 11wg==
X-Gm-Message-State: AOJu0YzvmfHkZeuYvDKYfF7rAj42WwAxq1l0z2e/XNfhPwko4UcdZIEY
 mStrO1SR6+XQ2tw+DOCe9U7hI8VhKI0hRig95oo=
X-Google-Smtp-Source: AGHT+IFE27Ke4hGLJvqIY4R9VBDmCNoSaH4hvyVlsoccKZNiwk+qgZuAySfFzKF5v2ds9CDwpgcUog==
X-Received: by 2002:a17:90b:3110:b0:26b:36dc:2f08 with SMTP id
 gc16-20020a17090b311000b0026b36dc2f08mr20714299pjb.46.1693248960851; 
 Mon, 28 Aug 2023 11:56:00 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 4-20020a17090a190400b002680dfd368dsm7932835pjg.51.2023.08.28.11.56.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 11:56:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH 09/10] accel/tcg: Introduce do_ld16_mmio_beN
Date: Mon, 28 Aug 2023 11:55:49 -0700
Message-Id: <20230828185550.573653-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230828185550.573653-1-richard.henderson@linaro.org>
References: <20230828185550.573653-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Split out int_ld_mmio_beN, to be used by both do_ld_mmio_beN
and do_ld16_mmio_beN.  Move the locks down into the two
functions, since each one now covers all accesses to once page.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 91 ++++++++++++++++++++++++++++++----------------
 1 file changed, 59 insertions(+), 32 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index cf80add4b3..8a7e386415 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2005,21 +2005,11 @@ static void *atomic_mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
  * Load @size bytes from @addr, which is memory-mapped i/o.
  * The bytes are concatenated in big-endian order with @ret_be.
  */
-static uint64_t do_ld_mmio_beN(CPUArchState *env, CPUTLBEntryFull *full,
-                               uint64_t ret_be, vaddr addr, int size,
-                               int mmu_idx, MMUAccessType type, uintptr_t ra)
+static uint64_t int_ld_mmio_beN(CPUArchState *env, CPUTLBEntryFull *full,
+                                uint64_t ret_be, vaddr addr, int size,
+                                int mmu_idx, MMUAccessType type, uintptr_t ra,
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
@@ -2031,7 +2021,8 @@ static uint64_t do_ld_mmio_beN(CPUArchState *env, CPUTLBEntryFull *full,
         this_size = 1 << this_mop;
         this_mop |= MO_BE;
 
-        r = memory_region_dispatch_read(mr, mr_offset, &val, this_mop, attrs);
+        r = memory_region_dispatch_read(mr, mr_offset, &val,
+                                        this_mop, full->attrs);
         if (unlikely(r != MEMTX_OK)) {
             io_failed(env, full, addr, this_size, type, mmu_idx, r, ra);
         }
@@ -2048,6 +2039,56 @@ static uint64_t do_ld_mmio_beN(CPUArchState *env, CPUTLBEntryFull *full,
     return ret_be;
 }
 
+static uint64_t do_ld_mmio_beN(CPUArchState *env, CPUTLBEntryFull *full,
+                               uint64_t ret_be, vaddr addr, int size,
+                               int mmu_idx, MMUAccessType type, uintptr_t ra)
+{
+    MemoryRegionSection *section;
+    MemoryRegion *mr;
+    hwaddr mr_offset;
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
+    ret = int_ld_mmio_beN(env, full, ret_be, addr, size, mmu_idx,
+                          type, ra, mr, mr_offset);
+    qemu_mutex_unlock_iothread();
+
+    return ret;
+}
+
+static Int128 do_ld16_mmio_beN(CPUArchState *env, CPUTLBEntryFull *full,
+                               uint64_t ret_be, vaddr addr, int size,
+                               int mmu_idx, uintptr_t ra)
+{
+    MemoryRegionSection *section;
+    MemoryRegion *mr;
+    hwaddr mr_offset;
+    MemTxAttrs attrs;
+    uint64_t a, b;
+
+    tcg_debug_assert(size > 8 && size <= 16);
+
+    attrs = full->attrs;
+    section = io_prepare(&mr_offset, env, full->xlat_section, attrs, addr, ra);
+    mr = section->mr;
+
+    qemu_mutex_lock_iothread();
+    a = int_ld_mmio_beN(env, full, ret_be, addr, size - 8, mmu_idx,
+                        MMU_DATA_LOAD, ra, mr, mr_offset);
+    b = int_ld_mmio_beN(env, full, ret_be, addr + size - 8, 8, mmu_idx,
+                        MMU_DATA_LOAD, ra, mr, mr_offset + size - 8);
+    qemu_mutex_unlock_iothread();
+
+    return int128_make128(b, a);
+}
+
 /**
  * do_ld_bytes_beN
  * @p: translation parameters
@@ -2190,7 +2231,6 @@ static uint64_t do_ld_beN(CPUArchState *env, MMULookupPageData *p,
     unsigned tmp, half_size;
 
     if (unlikely(p->flags & TLB_MMIO)) {
-        QEMU_IOTHREAD_LOCK_GUARD();
         return do_ld_mmio_beN(env, p->full, ret_be, p->addr, p->size,
                               mmu_idx, type, ra);
     }
@@ -2241,12 +2281,7 @@ static Int128 do_ld16_beN(CPUArchState *env, MMULookupPageData *p,
     MemOp atom;
 
     if (unlikely(p->flags & TLB_MMIO)) {
-        QEMU_IOTHREAD_LOCK_GUARD();
-        a = do_ld_mmio_beN(env, p->full, a, p->addr, size - 8,
-                           mmu_idx, MMU_DATA_LOAD, ra);
-        b = do_ld_mmio_beN(env, p->full, 0, p->addr + 8, 8,
-                           mmu_idx, MMU_DATA_LOAD, ra);
-        return int128_make128(b, a);
+        return do_ld16_mmio_beN(env, p->full, a, p->addr, size, mmu_idx, ra);
     }
 
     /*
@@ -2291,7 +2326,6 @@ static uint8_t do_ld_1(CPUArchState *env, MMULookupPageData *p, int mmu_idx,
                        MMUAccessType type, uintptr_t ra)
 {
     if (unlikely(p->flags & TLB_MMIO)) {
-        QEMU_IOTHREAD_LOCK_GUARD();
         return do_ld_mmio_beN(env, p->full, 0, p->addr, 1, mmu_idx, type, ra);
     } else {
         return *(uint8_t *)p->haddr;
@@ -2304,7 +2338,6 @@ static uint16_t do_ld_2(CPUArchState *env, MMULookupPageData *p, int mmu_idx,
     uint16_t ret;
 
     if (unlikely(p->flags & TLB_MMIO)) {
-        QEMU_IOTHREAD_LOCK_GUARD();
         ret = do_ld_mmio_beN(env, p->full, 0, p->addr, 2, mmu_idx, type, ra);
         if ((memop & MO_BSWAP) == MO_LE) {
             ret = bswap16(ret);
@@ -2325,7 +2358,6 @@ static uint32_t do_ld_4(CPUArchState *env, MMULookupPageData *p, int mmu_idx,
     uint32_t ret;
 
     if (unlikely(p->flags & TLB_MMIO)) {
-        QEMU_IOTHREAD_LOCK_GUARD();
         ret = do_ld_mmio_beN(env, p->full, 0, p->addr, 4, mmu_idx, type, ra);
         if ((memop & MO_BSWAP) == MO_LE) {
             ret = bswap32(ret);
@@ -2346,7 +2378,6 @@ static uint64_t do_ld_8(CPUArchState *env, MMULookupPageData *p, int mmu_idx,
     uint64_t ret;
 
     if (unlikely(p->flags & TLB_MMIO)) {
-        QEMU_IOTHREAD_LOCK_GUARD();
         ret = do_ld_mmio_beN(env, p->full, 0, p->addr, 8, mmu_idx, type, ra);
         if ((memop & MO_BSWAP) == MO_LE) {
             ret = bswap64(ret);
@@ -2505,12 +2536,8 @@ static Int128 do_ld16_mmu(CPUArchState *env, vaddr addr,
     crosspage = mmu_lookup(env, addr, oi, ra, MMU_DATA_LOAD, &l);
     if (likely(!crosspage)) {
         if (unlikely(l.page[0].flags & TLB_MMIO)) {
-            QEMU_IOTHREAD_LOCK_GUARD();
-            a = do_ld_mmio_beN(env, l.page[0].full, 0, addr, 8,
-                               l.mmu_idx, MMU_DATA_LOAD, ra);
-            b = do_ld_mmio_beN(env, l.page[0].full, 0, addr + 8, 8,
-                               l.mmu_idx, MMU_DATA_LOAD, ra);
-            ret = int128_make128(b, a);
+            ret = do_ld16_mmio_beN(env, l.page[0].full, 0, addr, 16,
+                                   l.mmu_idx, ra);
             if ((l.memop & MO_BSWAP) == MO_LE) {
                 ret = bswap128(ret);
             }
-- 
2.34.1


