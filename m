Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E501578B7B0
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 20:57:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qahP9-0000qu-Ke; Mon, 28 Aug 2023 14:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qahP4-0000ot-7S
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:55:58 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qahP1-0002Qz-Ac
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:55:57 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1c8d895a602so2016419fac.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 11:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693248954; x=1693853754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7K3agjAj/5Z9V2az8Pltf/TZABQcnS/GDuSWWPrto4M=;
 b=FdiXYEtAuIOeWw0FEEU4pTlgXX6bL0Bucwv+mbpNY3N7olA45QBU3ycKPPhDlTqKYL
 +LUCx6C2CRvewBDUnNccnmTafAnasLzTlyz6rGxRszJ52N/hZVE/GdPei/MhACYKPyst
 NqFbMUI6nJXf21SaZO7UtZVBkiIeSQDpTfuwenfPw442F4NsV8J3euXN6oUYkfIm9ykA
 JJOahdO0azAo75+T21ikOUxPBKx+/xwLfusSDYjyvG4U7iB38fwPBSn3wUbi//JB9tqk
 2Zxytxxyw8bB2kyOklbhhsVU0zoheysg9hCGX7rnfjL3fwj21k3blKQungl6rA9ywk4q
 mWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693248954; x=1693853754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7K3agjAj/5Z9V2az8Pltf/TZABQcnS/GDuSWWPrto4M=;
 b=LVYMT0Me/Vc/0mDtZTs1Y1ojVZ9hu9Hmo81x/C34ngbnLi/MNG6/m2tZKFH06EG5e2
 pInovv97vIr+v7sXKcxFd9K2OIMSpnqt6oiSvi3lnjVigzFgKwcbBFxjqsuFp9KmD5N/
 BYzbyIi22gQeJPCkluJhI+ZGR7JGPmzdP84FP8pcLQx2sKot1UREieif7Bln5aoNaGnd
 vveZXjJAKtbt2yGcka1NB7wPXm3phEF+891mebsTSAAgEWXUTTCauncNumUlrnqPEu90
 r7VVMY57hEAQwRn6HYXgDYSAExub1VCgYt/fdhJsfXDmO0DLsRcRHp2s4IsTqGDH+4KC
 9WLg==
X-Gm-Message-State: AOJu0YxCkqMsVQrvIrIZZVa0CQgm8sPrVU2WKK17jYFKG/OHC9B3i/lR
 NBJEoXK7/wdqgNt8xWmUXPFNeSPjf6nqiugNNqQ=
X-Google-Smtp-Source: AGHT+IFNQcdw+N0i3wGp7ws/X/WbgJBPFV9FeL0ytDt+qIUzIsIXP2dXFP4M0QNr39+a79IdQPPBzg==
X-Received: by 2002:a05:6870:4706:b0:1c8:bfd1:ecc0 with SMTP id
 b6-20020a056870470600b001c8bfd1ecc0mr12897140oaq.0.1693248954008; 
 Mon, 28 Aug 2023 11:55:54 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 4-20020a17090a190400b002680dfd368dsm7932835pjg.51.2023.08.28.11.55.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 11:55:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH 02/10] accel/tcg: Split out io_prepare and io_failed
Date: Mon, 28 Aug 2023 11:55:42 -0700
Message-Id: <20230828185550.573653-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230828185550.573653-1-richard.henderson@linaro.org>
References: <20230828185550.573653-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 77 +++++++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 32 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index fcf6ccebff..17987f74e5 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1264,7 +1264,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
      * (non-page-aligned) vaddr of the eventual memory access to get
      * the MemoryRegion offset for the access. Note that the vaddr we
      * subtract here is that of the page base, and not the same as the
-     * vaddr we add back in io_readx()/io_writex()/get_page_addr_code().
+     * vaddr we add back in io_prepare()/get_page_addr_code().
      */
     desc->fulltlb[index] = *full;
     full = &desc->fulltlb[index];
@@ -1364,37 +1364,60 @@ static inline void cpu_transaction_failed(CPUState *cpu, hwaddr physaddr,
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
@@ -1403,19 +1426,14 @@ static void io_writex(CPUArchState *env, CPUTLBEntryFull *full,
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
@@ -1423,13 +1441,8 @@ static void io_writex(CPUArchState *env, CPUTLBEntryFull *full,
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


