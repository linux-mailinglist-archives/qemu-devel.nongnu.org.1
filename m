Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B795978B7A9
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 20:57:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qahPD-0000sl-Av; Mon, 28 Aug 2023 14:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qahPB-0000sG-Nk
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:56:05 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qahP9-0002Sv-8d
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:56:05 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-26f6b2c8e80so2265934a91.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 11:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693248962; x=1693853762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OOzEj3zxNXy+t9npCtUx1T/2sNWvJU9XlZEuj/GyRA4=;
 b=lMgrsc0OYG2gn7Jt4IJ6jHnLSC4cB+MpYs4BDa3LAlXfDCT7ZiJ1q3UQ921seQJXgp
 dem+w35mkzct0tDALgYZGZE9uZRP8jqR7pWveiehiJx+Wv8/PYWYJvnNmmPQuiwK915+
 4u6Sr2615UDsua+RjMoOrzaoHXRwBeZFPPVQk6bMWnalq+MvfTBZ21KbKaPilF8SUi1Y
 akg+OR7iWQwxCEj/4Sufy/PvTZxMoeax25hpZIgvBAGK7EJIDgsMhASKX3imzwV97T+i
 8MWi75xZ84CLFlpNy/fPX5MLjuRMHAX1gY1VcBrKvraBrQKEGa8rxGJ90fXirXXOJedF
 s8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693248962; x=1693853762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OOzEj3zxNXy+t9npCtUx1T/2sNWvJU9XlZEuj/GyRA4=;
 b=D7heM06TF5N6SNlhO5T0SZcHqTjagdAgZFQ7nUvJXOUE9QDCBcxl/MHbkJG91qbfVL
 8AYb6IgTQUMxAA81uYWqHDnFzV4Fk9Rt5sydhW+f3v2+pDYxubNA63fUJn2FrVh3fQ/6
 umP4i2Sqkmhtla5NfD4OmdlP7BU/2mYRJbFwc/wB7GdD2l6WsseyOAc+/N+s8QqnX8A/
 uPe8Ndi+ibPArfgC5zehimvILyeFwUVkBRUhJmcFXrevLdWBfX4r172afCOXa3VpDMbl
 JQV/xCzXM9wk+bkLZtD2GiZz4TVhbZBdG93PqxfN8csghGTu1tWFBW1/FPuJ4N5t4xfe
 UNDw==
X-Gm-Message-State: AOJu0YySZE0WUEx10nq9K2h8RqjKQ/+BcSiCtHVxYbrx1RDA1KD6aR/6
 LMXlorxaG/ErhSRcQ7fsFtnP80SxkMbpHYQYcbs=
X-Google-Smtp-Source: AGHT+IH69Uf+oLYNzqdE1XdZsf0SBZIkzRkOTO+bXqrgsBV3OF7BHW7jcED5FkcWRhzSiZYdv69RyQ==
X-Received: by 2002:a17:90b:1a89:b0:268:ca76:64a with SMTP id
 ng9-20020a17090b1a8900b00268ca76064amr21315364pjb.49.1693248961827; 
 Mon, 28 Aug 2023 11:56:01 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 4-20020a17090a190400b002680dfd368dsm7932835pjg.51.2023.08.28.11.56.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 11:56:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH 10/10] accel/tcg: Introduce do_st16_mmio_leN
Date: Mon, 28 Aug 2023 11:55:50 -0700
Message-Id: <20230828185550.573653-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230828185550.573653-1-richard.henderson@linaro.org>
References: <20230828185550.573653-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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
index 8a7e386415..ff253e78d2 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2678,21 +2678,11 @@ Int128 cpu_ld16_mmu(CPUArchState *env, abi_ptr addr,
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
@@ -2704,7 +2694,7 @@ static uint64_t do_st_mmio_leN(CPUArchState *env, CPUTLBEntryFull *full,
         this_mop |= MO_LE;
 
         r = memory_region_dispatch_write(mr, mr_offset, val_le,
-                                         this_mop, attrs);
+                                         this_mop, full->attrs);
         if (unlikely(r != MEMTX_OK)) {
             io_failed(env, full, addr, this_size, MMU_DATA_STORE,
                       mmu_idx, r, ra);
@@ -2722,6 +2712,56 @@ static uint64_t do_st_mmio_leN(CPUArchState *env, CPUTLBEntryFull *full,
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
@@ -2733,7 +2773,6 @@ static uint64_t do_st_leN(CPUArchState *env, MMULookupPageData *p,
     unsigned tmp, half_size;
 
     if (unlikely(p->flags & TLB_MMIO)) {
-        QEMU_IOTHREAD_LOCK_GUARD();
         return do_st_mmio_leN(env, p->full, val_le, p->addr,
                               p->size, mmu_idx, ra);
     } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
@@ -2788,11 +2827,8 @@ static uint64_t do_st16_leN(CPUArchState *env, MMULookupPageData *p,
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
@@ -2836,7 +2872,6 @@ static void do_st_1(CPUArchState *env, MMULookupPageData *p, uint8_t val,
                     int mmu_idx, uintptr_t ra)
 {
     if (unlikely(p->flags & TLB_MMIO)) {
-        QEMU_IOTHREAD_LOCK_GUARD();
         do_st_mmio_leN(env, p->full, val, p->addr, 1, mmu_idx, ra);
     } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
         /* nothing */
@@ -2852,7 +2887,6 @@ static void do_st_2(CPUArchState *env, MMULookupPageData *p, uint16_t val,
         if ((memop & MO_BSWAP) != MO_LE) {
             val = bswap16(val);
         }
-        QEMU_IOTHREAD_LOCK_GUARD();
         do_st_mmio_leN(env, p->full, val, p->addr, 2, mmu_idx, ra);
     } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
         /* nothing */
@@ -2872,7 +2906,6 @@ static void do_st_4(CPUArchState *env, MMULookupPageData *p, uint32_t val,
         if ((memop & MO_BSWAP) != MO_LE) {
             val = bswap32(val);
         }
-        QEMU_IOTHREAD_LOCK_GUARD();
         do_st_mmio_leN(env, p->full, val, p->addr, 4, mmu_idx, ra);
     } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
         /* nothing */
@@ -2892,7 +2925,6 @@ static void do_st_8(CPUArchState *env, MMULookupPageData *p, uint64_t val,
         if ((memop & MO_BSWAP) != MO_LE) {
             val = bswap64(val);
         }
-        QEMU_IOTHREAD_LOCK_GUARD();
         do_st_mmio_leN(env, p->full, val, p->addr, 8, mmu_idx, ra);
     } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
         /* nothing */
@@ -3020,11 +3052,7 @@ static void do_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
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


