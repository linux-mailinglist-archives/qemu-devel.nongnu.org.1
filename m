Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD25B77136B
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 05:39:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSUa2-0003bM-Vq; Sat, 05 Aug 2023 23:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUa0-0003ZH-8I
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:20 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUZy-0007Vj-DU
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:20 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-268b3ddc894so1826196a91.1
 for <qemu-devel@nongnu.org>; Sat, 05 Aug 2023 20:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691293037; x=1691897837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jsOBWOFossCHszj7zLjYTuH7ZUTZ9Rn/iuADRRkhtM4=;
 b=T4bIw9fD15LKS8IexBua3eZvM+LY9cFpmyNIxEuywgC+i4SMsp57LlYHJAeE2qUuY2
 IyLSeOfEfTEv7WxweZsMU1DNnBo71Bz+e+Z9Qm15Hw7RArLX+TzSpdrl8IkmL6JiyhsL
 Qum3jwLLWp8YU7u6xabL2rIMYiwpsXlVmZMOiK1NbEwobdCVP1Hs4FWSji+GtSRj6dQi
 /wlqNph1m/iIibr7R8H2mzEMFzaiSTWNWt4NCMuQPntkJmpWM7SWB/Ce72mzcS0S231z
 bvsoRAoFyVVq1motBEkTwMnRSn1jhSj3dclKTh51QxLy8bv+uN9kG2GHxbF9B2fyu72r
 JYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691293037; x=1691897837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jsOBWOFossCHszj7zLjYTuH7ZUTZ9Rn/iuADRRkhtM4=;
 b=X/M3zCXba+bj8prgZekp9lIoNdAZkRtOZwPqiTBhzV4dsLGflwClWOOJXZnF+HwT9Z
 TROkUMk1bLGrf3gOiM0VdnEsnHlzjmZ9TTm8SnODvEr3igFOjATXb+EIaIyFDnhsO69O
 vpbZIy6PjDrdebgOQ0eRhoYIl4cAdRtEApYVaZD064v9jkYg0QEL/E0Mtjm2ta8CECel
 b6qXkgxkgJOmqgYu3O+8dbwLeYN/V+A2XqTAId3npyhaKclro3dnsv8QX+N9xKEOjc9G
 fkwOL5Kn/yVj2Fv/y4XYD42InAgdUheiXlmbHzM8DapWcDHq5886fM2+Fm3tkEzDLiwH
 XpVQ==
X-Gm-Message-State: AOJu0YyMmoUXQ+7PjZUoecT5fmcYw4xTv3sgIjkY7erDXwctkrKCdCaM
 UOfkH2Qa23pkqNFVPqaKV7Aqhs0a8K7bvBBKPE4=
X-Google-Smtp-Source: AGHT+IFuND4AP6QjywiurQ6GITt0s2mrDhFY+8h3sMb5scKGG0dcaKy/dEHf6om2WHdT+zjy2IBSAw==
X-Received: by 2002:a17:90a:38e2:b0:268:557e:1848 with SMTP id
 x89-20020a17090a38e200b00268557e1848mr4245970pjb.2.1691293036982; 
 Sat, 05 Aug 2023 20:37:16 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:9454:a46f:1c22:a7c6])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a17090a740500b00262e604724dsm6306451pjg.50.2023.08.05.20.37.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Aug 2023 20:37:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/24] accel/tcg: Adjust parameters and locking with do_{ld,
 st}_mmio_*
Date: Sat,  5 Aug 2023 20:36:52 -0700
Message-Id: <20230806033715.244648-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230806033715.244648-1-richard.henderson@linaro.org>
References: <20230806033715.244648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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


