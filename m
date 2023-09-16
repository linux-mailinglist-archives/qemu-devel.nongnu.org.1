Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 816BE7A2DC9
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:38:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM18-00065b-7H; Fri, 15 Sep 2023 23:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM16-000653-HJ
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:44 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM14-00085P-Rz
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:44 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-68fb79ef55eso2599174b3a.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835042; x=1695439842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aQmuVNpbNzOt+88tUDt69vKjmgR3TuBLRL0kUprNkEc=;
 b=BMweGFA6op1tGl7ndmlmupo1VZJBjeV5wSqNWs9+MCR9vFtt/UuuueXus+p8pEmwNB
 576cJNaQEXhzaA99+N67Gez7rYFN45IFxBvGQwQ7CStfv6zCAE0C0NpgqWVdDBB0C19k
 DwGxDZuQAJm9WxSdBVtUVNX693AnktNTiiPtEBghqchhOlM34nYupvgmkXxNLCvjqEFm
 xpxfj12sbBWNdRjh/yzTNlaWpxQC9aomnGQpr5zeZNlx7zT9rODl37nkRIA4XxzNEbkZ
 tBQ16OxD7LqrugE6KC9/ahNgN71hmC+KeKqjpadaazBeYlGqjMSGT2gg72QmFz0BOitL
 ZDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835042; x=1695439842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aQmuVNpbNzOt+88tUDt69vKjmgR3TuBLRL0kUprNkEc=;
 b=PpWH5G4enVvlciQ0J2QRuZ+vBVaf+Gs+EiR7L+HYlbqDCYJBgEu9okAm8l9NJBEBkE
 cUvm239cNlfkRI1ciPXfCTTz3MmvrnrfKQ6OvBxUSVBLfg+LC3w72Is4/VYxAz7WNM2K
 kollWBAcrsDLF2H12K4p+Pa0WBf0DBVTRg1KEamDd4MIZf8N714CmdS7JKcUIoh0w0Po
 y3tnvcEzN9E9DV6w5t0+wRSeLbDnzr5gPsaqeOl0EcIR0g/b4Fg34okKRurXVNdln2xh
 117lS1v1lFhdo8zdg8alOqoRrg8m8ds8HfmtRZHQ5MG88uAAu7+nS5/KfYRhe1fSkKSL
 dGzA==
X-Gm-Message-State: AOJu0Yy4YuUiMcxmfa7g4yIUAvgAWbKniDgzua/483jfTOhtLW/ZMjVu
 A2l46iTH9TDUoymcGcw2eDvLgvAbecYLn4VEc3M=
X-Google-Smtp-Source: AGHT+IEg64bzUVci6+NtScKnswKS2R5AlKIGjalGcCOen9Oo85PooEwGbKmp+sagNQK88dZ1i5nvyQ==
X-Received: by 2002:a05:6a00:1789:b0:690:33d6:11e7 with SMTP id
 s9-20020a056a00178900b0069033d611e7mr3909290pfg.12.1694835041724; 
 Fri, 15 Sep 2023 20:30:41 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/39] accel/tcg: Merge io_writex into do_st_mmio_leN
Date: Fri, 15 Sep 2023 20:30:03 -0700
Message-Id: <20230916033011.479144-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Avoid multiple calls to io_prepare for unaligned acceses.
One call to do_st_mmio_leN will never cross pages.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 82 +++++++++++++++++-----------------------------
 1 file changed, 30 insertions(+), 52 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 6cf69bd79d..1d56e3ec0c 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1388,30 +1388,6 @@ static void io_failed(CPUArchState *env, CPUTLBEntryFull *full, vaddr addr,
     }
 }
 
-static void io_writex(CPUArchState *env, CPUTLBEntryFull *full,
-                      int mmu_idx, uint64_t val, vaddr addr,
-                      uintptr_t retaddr, MemOp op)
-{
-    MemoryRegionSection *section;
-    hwaddr mr_offset;
-    MemoryRegion *mr;
-    MemTxResult r;
-
-    section = io_prepare(&mr_offset, env, full->xlat_section,
-                         full->attrs, addr, retaddr);
-    mr = section->mr;
-
-    {
-        QEMU_IOTHREAD_LOCK_GUARD();
-        r = memory_region_dispatch_write(mr, mr_offset, val, op, full->attrs);
-    }
-
-    if (r != MEMTX_OK) {
-        io_failed(env, full, addr, memop_size(op), MMU_DATA_STORE, mmu_idx,
-                  r, retaddr);
-    }
-}
-
 /* Return true if ADDR is present in the victim tlb, and has been copied
    back to the main tlb.  */
 static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
@@ -2682,39 +2658,41 @@ static uint64_t do_st_mmio_leN(CPUArchState *env, CPUTLBEntryFull *full,
                                uint64_t val_le, vaddr addr, int size,
                                int mmu_idx, uintptr_t ra)
 {
+    MemoryRegionSection *section;
+    hwaddr mr_offset;
+    MemoryRegion *mr;
+    MemTxAttrs attrs;
+
     tcg_debug_assert(size > 0 && size <= 8);
 
+    attrs = full->attrs;
+    section = io_prepare(&mr_offset, env, full->xlat_section, attrs, addr, ra);
+    mr = section->mr;
+
     do {
+        MemOp this_mop;
+        unsigned this_size;
+        MemTxResult r;
+
         /* Store aligned pieces up to 8 bytes. */
-        switch ((size | (int)addr) & 7) {
-        case 1:
-        case 3:
-        case 5:
-        case 7:
-            io_writex(env, full, mmu_idx, val_le, addr, ra, MO_UB);
-            val_le >>= 8;
-            size -= 1;
-            addr += 1;
-            break;
-        case 2:
-        case 6:
-            io_writex(env, full, mmu_idx, val_le, addr, ra, MO_LEUW);
-            val_le >>= 16;
-            size -= 2;
-            addr += 2;
-            break;
-        case 4:
-            io_writex(env, full, mmu_idx, val_le, addr, ra, MO_LEUL);
-            val_le >>= 32;
-            size -= 4;
-            addr += 4;
-            break;
-        case 0:
-            io_writex(env, full, mmu_idx, val_le, addr, ra, MO_LEUQ);
-            return 0;
-        default:
-            qemu_build_not_reached();
+        this_mop = ctz32(size | (int)addr | 8);
+        this_size = 1 << this_mop;
+        this_mop |= MO_LE;
+
+        r = memory_region_dispatch_write(mr, mr_offset, val_le,
+                                         this_mop, attrs);
+        if (unlikely(r != MEMTX_OK)) {
+            io_failed(env, full, addr, this_size, MMU_DATA_STORE,
+                      mmu_idx, r, ra);
         }
+        if (this_size == 8) {
+            return 0;
+        }
+
+        val_le >>= this_size * 8;
+        addr += this_size;
+        mr_offset += this_size;
+        size -= this_size;
     } while (size);
 
     return val_le;
-- 
2.34.1


