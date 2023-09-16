Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF6B7A2DA7
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:31:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM19-000676-QX; Fri, 15 Sep 2023 23:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM15-00064l-NS
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:43 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM14-00085D-3e
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:43 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68fac346f6aso2577509b3a.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835041; x=1695439841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ubygpiVeUMd0fcLsHm6UxwLECdzjZTk+vbU50/H9Zgo=;
 b=UzbQay9oiC/QDLSXpj6wz2EvWGTyim/j2d4GtFRVL06lGCqHk86tgzf3GFi3iF9C8T
 Go9BMOszYagT7gjCQjXLnx90gs/QaSzLb/IAN7qeC1VWMyK9HNqpz1HD47jpSR8iMsAm
 4djK4BG4R1fBQVXwqYC487b5faqxvY14hc1B7z6POkn8QOapQK/OkKGL05iQRfKQv6uR
 obN8kPD1IxYiDbImuBI5kXJJV4tThMOlGcO57cvNoniefnoJrJz8oAVB47C0pR+uddgu
 7NESMOhJeGhiY6HhJSJ9hKaRNOZ2b76ClRBNfn4wWRw1vpoI4kl3UwowWqjGp75B5OSj
 FOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835041; x=1695439841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ubygpiVeUMd0fcLsHm6UxwLECdzjZTk+vbU50/H9Zgo=;
 b=XGzI4itnQFs0jodjuH1q4j+MttHn4YWct9GtUGnLhOyX4oWR86/NfNM20rlu3FsySm
 QM1q5LxyS/B+PVdYwmXKqsHbXn74MuF07BIBVIVdVMW9F663B11C4buId8L20t7Btqun
 Mh16Qj6nL5cpgIqkccEAKA/2ruvn/cwaIR+90eRsYMO2tHaoRvcQLxXzic1E2hRGNSzW
 BO5YiR7rWLcnOWJxdl+Xa34mUNFiRpbS6otFYoloSO7lVZvDqGpanP6j5ECL1A/35Czv
 bVVCm5Q6kMo/beDeD2KlkksYNTvr8qejG9PubQtXYEQxHIsg6qMD+bYkzcXbDO4pQ0eB
 kKMQ==
X-Gm-Message-State: AOJu0Yz9BRgteIb77P3vfGFF8ITHjq0nsFWfOrIWTRHcchPSe47WQAIH
 SoNslLxI9AeO6hab/mzmRs3kjs8EFUhHDUfkS68=
X-Google-Smtp-Source: AGHT+IFao0XVaEd493TWBl7S5uThHM28pRedFaa71LTBVdVNWjqly8Kb0+D7hXoZDXMBbAlNBWXX0g==
X-Received: by 2002:a05:6a00:1594:b0:68a:6305:a4cc with SMTP id
 u20-20020a056a00159400b0068a6305a4ccmr4035728pfk.5.1694835040879; 
 Fri, 15 Sep 2023 20:30:40 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/39] accel/tcg: Merge io_readx into do_ld_mmio_beN
Date: Fri, 15 Sep 2023 20:30:02 -0700
Message-Id: <20230916033011.479144-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
One call to do_ld_mmio_beN will never cross pages.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 84 +++++++++++++++++-----------------------------
 1 file changed, 30 insertions(+), 54 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index cc36e681a7..6cf69bd79d 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1388,32 +1388,6 @@ static void io_failed(CPUArchState *env, CPUTLBEntryFull *full, vaddr addr,
     }
 }
 
-static uint64_t io_readx(CPUArchState *env, CPUTLBEntryFull *full,
-                         int mmu_idx, vaddr addr, uintptr_t retaddr,
-                         MMUAccessType access_type, MemOp op)
-{
-    MemoryRegionSection *section;
-    hwaddr mr_offset;
-    MemoryRegion *mr;
-    MemTxResult r;
-    uint64_t val;
-
-    section = io_prepare(&mr_offset, env, full->xlat_section,
-                         full->attrs, addr, retaddr);
-    mr = section->mr;
-
-    {
-        QEMU_IOTHREAD_LOCK_GUARD();
-        r = memory_region_dispatch_read(mr, mr_offset, &val, op, full->attrs);
-    }
-
-    if (r != MEMTX_OK) {
-        io_failed(env, full, addr, memop_size(op), access_type, mmu_idx,
-                  r, retaddr);
-    }
-    return val;
-}
-
 static void io_writex(CPUArchState *env, CPUTLBEntryFull *full,
                       int mmu_idx, uint64_t val, vaddr addr,
                       uintptr_t retaddr, MemOp op)
@@ -2062,40 +2036,42 @@ static uint64_t do_ld_mmio_beN(CPUArchState *env, CPUTLBEntryFull *full,
                                uint64_t ret_be, vaddr addr, int size,
                                int mmu_idx, MMUAccessType type, uintptr_t ra)
 {
-    uint64_t t;
+    MemoryRegionSection *section;
+    hwaddr mr_offset;
+    MemoryRegion *mr;
+    MemTxAttrs attrs;
 
     tcg_debug_assert(size > 0 && size <= 8);
+
+    attrs = full->attrs;
+    section = io_prepare(&mr_offset, env, full->xlat_section, attrs, addr, ra);
+    mr = section->mr;
+
     do {
+        MemOp this_mop;
+        unsigned this_size;
+        uint64_t val;
+        MemTxResult r;
+
         /* Read aligned pieces up to 8 bytes. */
-        switch ((size | (int)addr) & 7) {
-        case 1:
-        case 3:
-        case 5:
-        case 7:
-            t = io_readx(env, full, mmu_idx, addr, ra, type, MO_UB);
-            ret_be = (ret_be << 8) | t;
-            size -= 1;
-            addr += 1;
-            break;
-        case 2:
-        case 6:
-            t = io_readx(env, full, mmu_idx, addr, ra, type, MO_BEUW);
-            ret_be = (ret_be << 16) | t;
-            size -= 2;
-            addr += 2;
-            break;
-        case 4:
-            t = io_readx(env, full, mmu_idx, addr, ra, type, MO_BEUL);
-            ret_be = (ret_be << 32) | t;
-            size -= 4;
-            addr += 4;
-            break;
-        case 0:
-            return io_readx(env, full, mmu_idx, addr, ra, type, MO_BEUQ);
-        default:
-            qemu_build_not_reached();
+        this_mop = ctz32(size | (int)addr | 8);
+        this_size = 1 << this_mop;
+        this_mop |= MO_BE;
+
+        r = memory_region_dispatch_read(mr, mr_offset, &val, this_mop, attrs);
+        if (unlikely(r != MEMTX_OK)) {
+            io_failed(env, full, addr, this_size, type, mmu_idx, r, ra);
         }
+        if (this_size == 8) {
+            return val;
+        }
+
+        ret_be = (ret_be << (this_size * 8)) | val;
+        addr += this_size;
+        mr_offset += this_size;
+        size -= this_size;
     } while (size);
+
     return ret_be;
 }
 
-- 
2.34.1


