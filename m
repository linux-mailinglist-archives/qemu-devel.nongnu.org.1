Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8237A2DCC
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:38:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM15-000640-Am; Fri, 15 Sep 2023 23:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM10-000629-Uc
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:38 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0z-000840-7q
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:38 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1d598ba1b74so1635283fac.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835036; x=1695439836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kogStVxEkZ6+al3jaQ2seiYkkIym7tfS+b2x1Hll9jc=;
 b=w0s/a2xEtj8C2sqLk0QM1bAW+qBkQthXgE7a7NjLRqCDcvAbPwkPd0DDPKAWfaQ1HL
 fPD9BKC+GG4f/Cy6DbmJKeGYTbbT8oTL5SHMqoBQZV1TGGNB9orsxBdFXVdp8YQCovx8
 Tj0L2Kvx2MRUBdmKZaEiygvOlj6df8ShooxLD8eMOtOfEBMwfWFUYHl7f7jUaCxDXKDt
 elqYieknhd+Lz8JE8NgvxhPay6VXGgl0MI/GMoAv3QPOArmOIaYDwtnRZWlWtdUzBYcl
 crdrCvGvxDKj4G6XUhb+3U+2rA46h/xL88280Wv/PvDsSutD2Yzb5kAKKmhtKSp12Q1A
 iwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835036; x=1695439836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kogStVxEkZ6+al3jaQ2seiYkkIym7tfS+b2x1Hll9jc=;
 b=m3VHNvCB5oGzd+Kosm1xqeqVlLxWSRVv8yaoEb5dcL3QtRjx0u6sCB7IBY5eSlEYJS
 3Jl9JMnf5gMdhjHanGv3z5OW+vo4ILiUIL4u+8HTq8GAR/yY2C7LroHr7pESZHEmmoJA
 /3lO2zsomb7mK/+BEK+8OSgtYJoZIbvticqld+1FRXpy7GcPUz0GB0HcUjhqcggXC/Zj
 K0GAolZOYfjQ5b+h0Wz+PFB7KW9tGwrD1heegMEBsuB6dZUqetHRMBZyS8jEC76CAk0g
 DzQtEMg2QrEc8jfiPXQkKCjs7xQQzAcMiolCuf7rcZgxLeoptu6V9SwpzVIUD0uq4HxA
 kGsA==
X-Gm-Message-State: AOJu0Yy6gqSPLLa517QYn4iWxidL4vQvctaJdPyBLBRHCjb7iODYhzv7
 4TkG5268IlQ72psR9lh5M+iGD1qIlhMPbtC6lnw=
X-Google-Smtp-Source: AGHT+IHIJh2BikbCy2f/qaq1eFWU4VArsqTOep9ni2FjVC9B/7lTMbuGT/wBtLqM55V7OjnW24xpPQ==
X-Received: by 2002:a05:6870:e390:b0:1d5:9451:d4da with SMTP id
 x16-20020a056870e39000b001d59451d4damr4237944oad.17.1694835036233; 
 Fri, 15 Sep 2023 20:30:36 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 25/39] accel/tcg: Split out io_prepare and io_failed
Date: Fri, 15 Sep 2023 20:29:57 -0700
Message-Id: <20230916033011.479144-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
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

These are common code from io_readx and io_writex.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 77 +++++++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 32 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 9cbcd202d2..ae4ad591fe 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1267,7 +1267,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
      * (non-page-aligned) vaddr of the eventual memory access to get
      * the MemoryRegion offset for the access. Note that the vaddr we
      * subtract here is that of the page base, and not the same as the
-     * vaddr we add back in io_readx()/io_writex()/get_page_addr_code().
+     * vaddr we add back in io_prepare()/get_page_addr_code().
      */
     desc->fulltlb[index] = *full;
     full = &desc->fulltlb[index];
@@ -1367,37 +1367,60 @@ static inline void cpu_transaction_failed(CPUState *cpu, hwaddr physaddr,
     }
 }
 
-static uint64_t io_readx(CPUArchState *env, CPUTLBEntryFull *full,
-                         int mmu_idx, vaddr addr, uintptr_t retaddr,
-                         MMUAccessType access_type, MemOp op)
+static MemoryRegionSection *
+io_prepare(hwaddr *out_offset, CPUArchState *env, hwaddr xlat,
+           MemTxAttrs attrs, vaddr addr, uintptr_t retaddr)
 {
     CPUState *cpu = env_cpu(env);
-    hwaddr mr_offset;
     MemoryRegionSection *section;
-    MemoryRegion *mr;
-    uint64_t val;
-    MemTxResult r;
+    hwaddr mr_offset;
 
-    section = iotlb_to_section(cpu, full->xlat_section, full->attrs);
-    mr = section->mr;
-    mr_offset = (full->xlat_section & TARGET_PAGE_MASK) + addr;
+    section = iotlb_to_section(cpu, xlat, attrs);
+    mr_offset = (xlat & TARGET_PAGE_MASK) + addr;
     cpu->mem_io_pc = retaddr;
     if (!cpu->can_do_io) {
         cpu_io_recompile(cpu, retaddr);
     }
 
+    *out_offset = mr_offset;
+    return section;
+}
+
+static void io_failed(CPUArchState *env, CPUTLBEntryFull *full, vaddr addr,
+                      unsigned size, MMUAccessType access_type, int mmu_idx,
+                      MemTxResult response, uintptr_t retaddr,
+                      MemoryRegionSection *section, hwaddr mr_offset)
+{
+    hwaddr physaddr = (mr_offset +
+                       section->offset_within_address_space -
+                       section->offset_within_region);
+
+    cpu_transaction_failed(env_cpu(env), physaddr, addr, size, access_type,
+                           mmu_idx, full->attrs, response, retaddr);
+}
+
+static uint64_t io_readx(CPUArchState *env, CPUTLBEntryFull *full,
+                         int mmu_idx, vaddr addr, uintptr_t retaddr,
+                         MMUAccessType access_type, MemOp op)
+{
+    MemoryRegionSection *section;
+    hwaddr mr_offset;
+    MemoryRegion *mr;
+    MemTxResult r;
+    uint64_t val;
+
+    section = io_prepare(&mr_offset, env, full->xlat_section,
+                         full->attrs, addr, retaddr);
+    mr = section->mr;
+
     {
         QEMU_IOTHREAD_LOCK_GUARD();
         r = memory_region_dispatch_read(mr, mr_offset, &val, op, full->attrs);
     }
 
     if (r != MEMTX_OK) {
-        hwaddr physaddr = mr_offset +
-            section->offset_within_address_space -
-            section->offset_within_region;
-
-        cpu_transaction_failed(cpu, physaddr, addr, memop_size(op), access_type,
-                               mmu_idx, full->attrs, r, retaddr);
+        io_failed(env, full, addr, memop_size(op), access_type, mmu_idx,
+                  r, retaddr, section, mr_offset);
     }
     return val;
 }
@@ -1406,19 +1429,14 @@ static void io_writex(CPUArchState *env, CPUTLBEntryFull *full,
                       int mmu_idx, uint64_t val, vaddr addr,
                       uintptr_t retaddr, MemOp op)
 {
-    CPUState *cpu = env_cpu(env);
-    hwaddr mr_offset;
     MemoryRegionSection *section;
+    hwaddr mr_offset;
     MemoryRegion *mr;
     MemTxResult r;
 
-    section = iotlb_to_section(cpu, full->xlat_section, full->attrs);
+    section = io_prepare(&mr_offset, env, full->xlat_section,
+                         full->attrs, addr, retaddr);
     mr = section->mr;
-    mr_offset = (full->xlat_section & TARGET_PAGE_MASK) + addr;
-    if (!cpu->can_do_io) {
-        cpu_io_recompile(cpu, retaddr);
-    }
-    cpu->mem_io_pc = retaddr;
 
     {
         QEMU_IOTHREAD_LOCK_GUARD();
@@ -1426,13 +1444,8 @@ static void io_writex(CPUArchState *env, CPUTLBEntryFull *full,
     }
 
     if (r != MEMTX_OK) {
-        hwaddr physaddr = mr_offset +
-            section->offset_within_address_space -
-            section->offset_within_region;
-
-        cpu_transaction_failed(cpu, physaddr, addr, memop_size(op),
-                               MMU_DATA_STORE, mmu_idx, full->attrs, r,
-                               retaddr);
+        io_failed(env, full, addr, memop_size(op), MMU_DATA_STORE, mmu_idx,
+                  r, retaddr, section, mr_offset);
     }
 }
 
-- 
2.34.1


