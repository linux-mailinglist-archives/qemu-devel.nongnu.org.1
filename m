Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC34A7A2DA6
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:31:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM0i-0005sj-Rz; Fri, 15 Sep 2023 23:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0h-0005sI-65
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:19 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0e-0007yP-SZ
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:18 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68fb79ef55eso2598939b3a.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835015; x=1695439815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bw6itF1Uknpm4DtF+K1DJWMJ4/HW9rR4t/tDfUwyoM4=;
 b=KBCj6LhRcbO6pDEhtpq82pT/wd8Dfvyns2FwYGvLGonI7/odbGYTgMlIEtjWukrf2c
 OzARzZw5H5Rmk/XAKPjVtmzt1yDooKDd9TH9xjjwzRx/RsLDDZomUThgALKsc2I8Yt9P
 cbUEz8xOw1pmdUqNNXZYVxI4nijnO7mXwlIrhZa2PoZ+NssHntNtYWazykzMSNgZ2q91
 KVYRJzK9nDmRvJ+FMdSy0VauUH5WvsZCijHjrJKPyW7EibuKW60viLxU8FLu5mOqUWZQ
 ogrBY0lAqKrcrneHgTKvmZH2YpZJU39xwAzoC+7E1CIdnjBZu3MhtVcjWSN6GDpreIy5
 UtnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835015; x=1695439815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bw6itF1Uknpm4DtF+K1DJWMJ4/HW9rR4t/tDfUwyoM4=;
 b=cBIs52dqqHkMS6jSGXA2pqbR7A8kcfXCtAHQWohP3E3h/HNBhwTOHnFqfcEhAl1emR
 Ku+beylIGBfCbEYzsKK/WvvS5dDkMTK9xiR6N6SMy7oSX1JOm76Qc8PBryUyugn5M67f
 528D4iE+02AGTLsFizAtoI24zFn8FwMMw4WBNa5eSbzemFfiGu0KpbGbqIExnAxdQas+
 Axq7YsWbnR9LcBwVT3yDOdXViYg+HF0J3rn9MeCBuu4QATkl6Tb0KhD4jJYlL1HBFEVx
 oxhHQNHE5jInkb0oXtZmqKKjawi9a/G0euUj4mz3qUumI5cxDFESU5eAEhBydqUALY6r
 QsYQ==
X-Gm-Message-State: AOJu0YxU4oztfXBi+AJ8DJEo6W5tZ1WRdAq6v98jKfVX4uGiRrivyCa/
 ze7iGI0BfsAuMUuExBibUBNXc2tXR6XrC4NyO5Y=
X-Google-Smtp-Source: AGHT+IFg1ekRpHewY3EOE+mSSrB1T+tW6jhiQeEj6Y9Em1YKEh/SZ2Y0yr4MLXR6ZfMYsZtEoPOlng==
X-Received: by 2002:a05:6a00:14c2:b0:690:2ecd:a59e with SMTP id
 w2-20020a056a0014c200b006902ecda59emr4334081pfu.31.1694835015343; 
 Fri, 15 Sep 2023 20:30:15 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL 02/39] accel/tcg: Fix the comment for CPUTLBEntryFull
Date: Fri, 15 Sep 2023 20:29:34 -0700
Message-Id: <20230916033011.479144-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

When memory region is ram, the lower TARGET_PAGE_BITS is not the
physical section number. Instead, its value is always 0.

Add comment and assert to make it clear.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Message-Id: <20230901060118.379-1-zhiwei_liu@linux.alibaba.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-defs.h | 12 ++++++------
 accel/tcg/cputlb.c      | 11 +++++++----
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index fb4c8d480f..350287852e 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -100,12 +100,12 @@
 typedef struct CPUTLBEntryFull {
     /*
      * @xlat_section contains:
-     *  - in the lower TARGET_PAGE_BITS, a physical section number
-     *  - with the lower TARGET_PAGE_BITS masked off, an offset which
-     *    must be added to the virtual address to obtain:
-     *     + the ram_addr_t of the target RAM (if the physical section
-     *       number is PHYS_SECTION_NOTDIRTY or PHYS_SECTION_ROM)
-     *     + the offset within the target MemoryRegion (otherwise)
+     *  - For ram, an offset which must be added to the virtual address
+     *    to obtain the ram_addr_t of the target RAM
+     *  - For other memory regions,
+     *     + in the lower TARGET_PAGE_BITS, the physical section number
+     *     + with the TARGET_PAGE_BITS masked off, the offset within
+     *       the target MemoryRegion
      */
     hwaddr xlat_section;
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index c643d66190..03e27b2a38 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1193,6 +1193,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     write_flags = read_flags;
     if (is_ram) {
         iotlb = memory_region_get_ram_addr(section->mr) + xlat;
+        assert(!(iotlb & ~TARGET_PAGE_MASK));
         /*
          * Computing is_clean is expensive; avoid all that unless
          * the page is actually writable.
@@ -1255,10 +1256,12 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
 
     /* refill the tlb */
     /*
-     * At this point iotlb contains a physical section number in the lower
-     * TARGET_PAGE_BITS, and either
-     *  + the ram_addr_t of the page base of the target RAM (RAM)
-     *  + the offset within section->mr of the page base (I/O, ROMD)
+     * When memory region is ram, iotlb contains a TARGET_PAGE_BITS
+     * aligned ram_addr_t of the page base of the target RAM.
+     * Otherwise, iotlb contains
+     *  - a physical section number in the lower TARGET_PAGE_BITS
+     *  - the offset within section->mr of the page base (I/O, ROMD) with the
+     *    TARGET_PAGE_BITS masked off.
      * We subtract addr_page (which is page aligned and thus won't
      * disturb the low bits) to give an offset which can be added to the
      * (non-page-aligned) vaddr of the eventual memory access to get
-- 
2.34.1


