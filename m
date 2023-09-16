Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 470E77A2DAA
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:31:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM1B-00069Q-5k; Fri, 15 Sep 2023 23:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM17-00065d-Hi
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:45 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM15-00085a-Mg
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:45 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-68a3ced3ec6so2589599b3a.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835042; x=1695439842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fpZ6qHSjdH6pbNwZiU9W3OMzv7SdQw41yXI9/4srW0o=;
 b=MTcm6M3CvHmUpoaElPZ/eHvGUBvfky9IlReVYIN/G8GQBCJQ9VM680LQN890i50jlv
 T5IVr6WskHFwhHNfGWrzRj/WR8DNCVC7H9FAqgaQ3/5+WCXz90MRbsoVl0Xi9Z4+/Ec8
 k80KHC8Xuy/kG5TCGjx5ELgleQc0R0XnY3TwfvGv2AkpEi/wJi211qjrrvBahhrNpMua
 s77V0qmC4kbX523sMAo3Iv0OMMnUqYrcrv90mzHSOpfYkWDKTm91ZR9SPrXcE33PJ9Aq
 JIvYQU5GA40KRNuSg397OmvAyOvdPDHryMOeuvDhzjCRAzbgsxcxXzuhjh0OieW9a4Th
 vyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835042; x=1695439842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fpZ6qHSjdH6pbNwZiU9W3OMzv7SdQw41yXI9/4srW0o=;
 b=T4Whab17sM8mdJvQO5n9LXqC/7a3VijKm959Ne7Ni/lK3C22hCKW6MAPgWVgx7Pmsn
 lxJh4g0cSv1I/TYwjlEBaZ5qUKPzAENAmwNOBOqfh4Cc72iG8j7zn57BiVSEew3ofn7y
 2fGMEmtmiSp5e7zNSOJyXKD0a1Fs8jdcTmaeVpn9fPQFQkeWrDwcjyVEMRmTpfWhgJwx
 +jFstqZY3mxvMoCEgVmuN8CQgbEg5m5GjuFrpWd/qfNhf4CyaHuXDPlGUwawh4GwVflW
 sFGH1boMhC4Inlmzh0/U+7yvZ28grYJbWPKDH636cUl0pyieSH8+hNFS6roCeTBv2DQC
 +XsA==
X-Gm-Message-State: AOJu0YzJqaIpIdqs37/UF5Q804nUKnYM19ITG8Ppz3WBpduUNEeiIqG1
 eMN763eqIpEwFA8IQvJnJJR65WlXVVEUaEgHpm8=
X-Google-Smtp-Source: AGHT+IE/BW4/DH7SFFLbmd5UoJzLnDYJuqyXg7VHNgHI3mueGU0uUUl6TUObc7hXPy6gFDUozlme8A==
X-Received: by 2002:a05:6a21:3e0b:b0:154:9943:732c with SMTP id
 bk11-20020a056a213e0b00b001549943732cmr3307387pzc.30.1694835042500; 
 Fri, 15 Sep 2023 20:30:42 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/39] accel/tcg: Introduce do_ld16_mmio_beN
Date: Fri, 15 Sep 2023 20:30:04 -0700
Message-Id: <20230916033011.479144-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
index 1d56e3ec0c..7f6ccdecb1 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2008,21 +2008,11 @@ static void *atomic_mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
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
@@ -2034,7 +2024,8 @@ static uint64_t do_ld_mmio_beN(CPUArchState *env, CPUTLBEntryFull *full,
         this_size = 1 << this_mop;
         this_mop |= MO_BE;
 
-        r = memory_region_dispatch_read(mr, mr_offset, &val, this_mop, attrs);
+        r = memory_region_dispatch_read(mr, mr_offset, &val,
+                                        this_mop, full->attrs);
         if (unlikely(r != MEMTX_OK)) {
             io_failed(env, full, addr, this_size, type, mmu_idx, r, ra);
         }
@@ -2051,6 +2042,56 @@ static uint64_t do_ld_mmio_beN(CPUArchState *env, CPUTLBEntryFull *full,
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
@@ -2193,7 +2234,6 @@ static uint64_t do_ld_beN(CPUArchState *env, MMULookupPageData *p,
     unsigned tmp, half_size;
 
     if (unlikely(p->flags & TLB_MMIO)) {
-        QEMU_IOTHREAD_LOCK_GUARD();
         return do_ld_mmio_beN(env, p->full, ret_be, p->addr, p->size,
                               mmu_idx, type, ra);
     }
@@ -2244,12 +2284,7 @@ static Int128 do_ld16_beN(CPUArchState *env, MMULookupPageData *p,
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
@@ -2294,7 +2329,6 @@ static uint8_t do_ld_1(CPUArchState *env, MMULookupPageData *p, int mmu_idx,
                        MMUAccessType type, uintptr_t ra)
 {
     if (unlikely(p->flags & TLB_MMIO)) {
-        QEMU_IOTHREAD_LOCK_GUARD();
         return do_ld_mmio_beN(env, p->full, 0, p->addr, 1, mmu_idx, type, ra);
     } else {
         return *(uint8_t *)p->haddr;
@@ -2307,7 +2341,6 @@ static uint16_t do_ld_2(CPUArchState *env, MMULookupPageData *p, int mmu_idx,
     uint16_t ret;
 
     if (unlikely(p->flags & TLB_MMIO)) {
-        QEMU_IOTHREAD_LOCK_GUARD();
         ret = do_ld_mmio_beN(env, p->full, 0, p->addr, 2, mmu_idx, type, ra);
         if ((memop & MO_BSWAP) == MO_LE) {
             ret = bswap16(ret);
@@ -2328,7 +2361,6 @@ static uint32_t do_ld_4(CPUArchState *env, MMULookupPageData *p, int mmu_idx,
     uint32_t ret;
 
     if (unlikely(p->flags & TLB_MMIO)) {
-        QEMU_IOTHREAD_LOCK_GUARD();
         ret = do_ld_mmio_beN(env, p->full, 0, p->addr, 4, mmu_idx, type, ra);
         if ((memop & MO_BSWAP) == MO_LE) {
             ret = bswap32(ret);
@@ -2349,7 +2381,6 @@ static uint64_t do_ld_8(CPUArchState *env, MMULookupPageData *p, int mmu_idx,
     uint64_t ret;
 
     if (unlikely(p->flags & TLB_MMIO)) {
-        QEMU_IOTHREAD_LOCK_GUARD();
         ret = do_ld_mmio_beN(env, p->full, 0, p->addr, 8, mmu_idx, type, ra);
         if ((memop & MO_BSWAP) == MO_LE) {
             ret = bswap64(ret);
@@ -2508,12 +2539,8 @@ static Int128 do_ld16_mmu(CPUArchState *env, vaddr addr,
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


