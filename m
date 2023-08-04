Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BC2770BA2
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 00:02:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS2rC-0004np-Ka; Fri, 04 Aug 2023 18:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qi-0004X9-O1
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:46 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qe-0001hr-BA
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:43 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bc02bd4eafso22144355ad.1
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 15:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691186437; x=1691791237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ogyDL6MEqk+X9fxmfimDp67js4GEaptZ9YAfaG485E=;
 b=HpqjF1o3iOX6U5byC6UMA9GaSJ8NkLiHi99cbJwMcOCpBM7deVgo08ExrxHBzXyglE
 wMixkZiha8YH6UGuuNeXJvmjmQaxI5iZC/DhODxpVuZOfybbFDSwbLZhfJ1ZcBaroy6O
 uze6QVho7TUtS6uHgBCCvvvFcpfnLaHcQzagkLuPMyrUbHPWAYpeBLqi2kQW66jZfOK+
 9AwRBOzdT1zvUB2fu/Wz89cUNsgOFuvb9c8OaPmba793kSr7sKyN9he863YBzC8/WDKi
 1fP7GpBjAelCvR0ERQ0J0vHOsgez4xsGGP0BMR2vknNse01LrgQ7Qr6aSOGyci6a7y1A
 BUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691186437; x=1691791237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ogyDL6MEqk+X9fxmfimDp67js4GEaptZ9YAfaG485E=;
 b=XkurZGysPswuJmFapp2HjqKAPJt6YncNDuyATwtrYHXyobQlm/cqCe9YlbpoR5sy4i
 US4CVQlxF+4ROapwCCcPTbVvLu+fi4oGxKfQpjvOEkkYLr3OWjI5L85wjyw4GLDUvUvT
 KguGCn6el2IocKnye1HXMCzW5TvBT/IdTV2mCUzuY7O0UDxuXqaRSFfiA8hkgX6+cGWH
 PWTHVibFiRA4Eg8umnI2C240QH6QxWioPVcoEO9ae/W6aTj8/QmqoZOotR2Ytla46YZX
 bM6pX0gRl7I857xyrBtjt+y2ZcU3vRLMGfIoE5F6zdk/MQ5G5Cu3DgF7GSXItoz9X2Ck
 zJsg==
X-Gm-Message-State: AOJu0YyjpG4JiMJkT3VJ39VXjKKBI5exkbzTbVU9h7paoWKf2XA1z7Zl
 BaZe9GcjpWVe11abUgACm/mihix9u95oyGfGq7o=
X-Google-Smtp-Source: AGHT+IF7AsxcITUBHCPNRmtgRektt+H31HiN7X+vaIeUjV4p0dLO3LwaK/Zm0TNYckVBcceXWH0iGQ==
X-Received: by 2002:a17:903:32d0:b0:1bb:9b29:20d9 with SMTP id
 i16-20020a17090332d000b001bb9b2920d9mr3731002plr.20.1691186436677; 
 Fri, 04 Aug 2023 15:00:36 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a17090282c100b001bbf7fd354csm2185568plz.213.2023.08.04.15.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 15:00:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v9 03/24] accel/tcg: Do not issue misaligned i/o
Date: Fri,  4 Aug 2023 15:00:11 -0700
Message-Id: <20230804220032.295411-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804220032.295411-1-richard.henderson@linaro.org>
References: <20230804220032.295411-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

In the single-page case we were issuing misaligned i/o to
the memory subsystem, which does not handle it properly.
Split such accesses via do_{ld,st}_mmio_*.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1800
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 118 +++++++++++++++++++++++++++------------------
 1 file changed, 72 insertions(+), 46 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index a308cb7534..4b1bfaa53d 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2370,16 +2370,20 @@ static uint8_t do_ld_1(CPUArchState *env, MMULookupPageData *p, int mmu_idx,
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
@@ -2390,13 +2394,17 @@ static uint32_t do_ld_4(CPUArchState *env, MMULookupPageData *p, int mmu_idx,
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
@@ -2407,13 +2415,17 @@ static uint64_t do_ld_8(CPUArchState *env, MMULookupPageData *p, int mmu_idx,
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
@@ -2561,20 +2573,22 @@ static Int128 do_ld16_mmu(CPUArchState *env, vaddr addr,
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
@@ -2874,7 +2888,11 @@ static void do_st_2(CPUArchState *env, MMULookupPageData *p, uint16_t val,
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
@@ -2890,7 +2908,11 @@ static void do_st_4(CPUArchState *env, MMULookupPageData *p, uint32_t val,
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
@@ -2906,7 +2928,11 @@ static void do_st_8(CPUArchState *env, MMULookupPageData *p, uint64_t val,
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
@@ -3029,22 +3055,22 @@ static void do_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
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


