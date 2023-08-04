Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD455770BA0
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 00:02:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS2rC-0004nF-Em; Fri, 04 Aug 2023 18:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qg-0004Vb-0q
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:44 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qb-0001co-Fs
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:41 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bba04b9df3so22272815ad.0
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 15:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691186435; x=1691791235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jsOBWOFossCHszj7zLjYTuH7ZUTZ9Rn/iuADRRkhtM4=;
 b=yXscK9b9r6KNgNehdsdctpn8c7t/Kb6ORtI6SYzTSb4bhdHdiPyVv3uqHJYv9mvk8n
 K7gDxYs7hH4+RT0Co24U9elqtZGHrHYc99q2cu26E0NPUkaOhQ1GN9Xnl+TfKmnp7RyG
 3NGMOWS3eI3POH8Al7TwnZPFSvAvMag0Knic/zRhdYD44cJxSxSAZCTlaYNzwNvgD7NS
 a6KAZDNkZtYaNrYo/JOhXPneQatOmCeN2GRREOxBz64Ohi4bJTz2PGEA6wrbEOTxR23f
 YC/pvAfWfkshLPUwGpnkwVL+dlF9rsb874eWmGs7Vvh5ABmAgVIH7LTnl9n8KO/zjloo
 O+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691186435; x=1691791235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jsOBWOFossCHszj7zLjYTuH7ZUTZ9Rn/iuADRRkhtM4=;
 b=KcaGMRFmjhP+dNYwJFJu0v4jNGpG84iOBLPQXVPvhWM3vEqIk/yALGVaagAmuxH9lB
 QhwcB2hHturXoXlTxnsn6ahAnzIG2cFJGeOfN4ZGzlmz4JytPkGFgFyvdzCJnsb1CD0G
 7MjaBSk3ikrYLcZOZUavDb6vVHi82eU/Oqj9lx1lUc++gPdNO2JLrCevrU/nVzzo2Fm8
 gBGlGOIHmsOFsp6IrRqf/Tm50rLtEWf1cim67yi8dlW3UHFW5rsM2jr1NfBHb98118xB
 t5Uy335ik8oOC9t7dQNLoSUN1B6T1UoBr11OhiVYHMwwcSD79J2bA/Wn9pUeYFy9SWiV
 m+dA==
X-Gm-Message-State: AOJu0YzFC3xXaz2VsVmOOqmq7Ovee4pCKvpNighrgSkc7j8HZXyNTxvR
 EPyttmajPabBzclJRM3vxBpoaLJv9p7OAS5MfHY=
X-Google-Smtp-Source: AGHT+IFEeXIqiTPMF9/MKl6L+UpoKJLhPCg/4vTSW7vvkOgruZXUsQS5qCbOITcqif525+7Pgw1U9Q==
X-Received: by 2002:a17:903:41c6:b0:1bb:ab0d:4f76 with SMTP id
 u6-20020a17090341c600b001bbab0d4f76mr3880221ple.58.1691186435018; 
 Fri, 04 Aug 2023 15:00:35 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a17090282c100b001bbf7fd354csm2185568plz.213.2023.08.04.15.00.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 15:00:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v9 01/24] accel/tcg: Adjust parameters and locking with do_{ld,
 st}_mmio_*
Date: Fri,  4 Aug 2023 15:00:09 -0700
Message-Id: <20230804220032.295411-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804220032.295411-1-richard.henderson@linaro.org>
References: <20230804220032.295411-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Replace MMULookupPageData* with CPUTLBEntryFull, addr, size.
Move QEMU_IOTHREAD_LOCK_GUARD to the caller.

This simplifies the usage from do_ld16_beN and do_st16_leN, where
we weren't locking the entire operation, and required hoop jumping
for passing addr and size.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 67 +++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 33 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index ba44501a7c..23386ecfde 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2066,24 +2066,22 @@ static void *atomic_mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
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
+ * Context: iothread lock held
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
@@ -2232,7 +2230,9 @@ static uint64_t do_ld_beN(CPUArchState *env, MMULookupPageData *p,
     unsigned tmp, half_size;
 
     if (unlikely(p->flags & TLB_MMIO)) {
-        return do_ld_mmio_beN(env, p, ret_be, mmu_idx, type, ra);
+        QEMU_IOTHREAD_LOCK_GUARD();
+        return do_ld_mmio_beN(env, p->full, ret_be, p->addr, p->size,
+                              mmu_idx, type, ra);
     }
 
     /*
@@ -2281,11 +2281,11 @@ static Int128 do_ld16_beN(CPUArchState *env, MMULookupPageData *p,
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
 
@@ -2664,24 +2664,23 @@ Int128 cpu_ld16_mmu(CPUArchState *env, abi_ptr addr,
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
+ * Context: iothread lock held
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
@@ -2698,7 +2697,9 @@ static uint64_t do_st_leN(CPUArchState *env, MMULookupPageData *p,
     unsigned tmp, half_size;
 
     if (unlikely(p->flags & TLB_MMIO)) {
-        return do_st_mmio_leN(env, p, val_le, mmu_idx, ra);
+        QEMU_IOTHREAD_LOCK_GUARD();
+        return do_st_mmio_leN(env, p->full, val_le, p->addr,
+                              p->size, mmu_idx, ra);
     } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
         return val_le >> (p->size * 8);
     }
@@ -2751,11 +2752,11 @@ static uint64_t do_st16_leN(CPUArchState *env, MMULookupPageData *p,
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


