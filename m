Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8FD73E3DF
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 17:47:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDoKb-0000nq-Nr; Mon, 26 Jun 2023 11:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJn-0000Gt-T8
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:39:56 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJk-0002nu-Lh
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:39:55 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-313f2a24cb6so1143951f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 08:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687793989; x=1690385989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GTdw/D0Q1k/vjceZwO5951lDd93hL4ZhKXzyOnsHC0Q=;
 b=FACvpUF2uuMrrYSbO2Y1RQy8nHV/CaO7bSLtAMi8huw9I0P5R40LXjqsmPZ5CYtH1u
 HuIHkG23/aRM5D2JyB+IaAEQTSRZwvr1mrENT6oqsgc1EOR48s+MHnfhulTijog6LYGn
 nIDTvjgeQrrqQNG6RZUTvs6SLWRJxaowgr6tYom7OPg3cprhhaJKzNw4vf71sG8Fgq3a
 8v8EoU7EIZF8/+2MfkS/qVAsd6fne0bz2RdBZyjdwXnG1hI2mk50SFM4+qWPpbYnn/I7
 ZFsASLFqJthVEklvjebwFm31fmDXyANKnLZ7d3pWJOFnQtXBPJbTvgW0TBkPpSjntvGu
 UlFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687793989; x=1690385989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GTdw/D0Q1k/vjceZwO5951lDd93hL4ZhKXzyOnsHC0Q=;
 b=g6+sj6B+u/+CFpcfD+Kciom6p+bKPVnVwhBsacB0Euv4pX68WnIFYxzbbvZ5o2bWXW
 IjecaVXXr+MoKRocp6DhTWA7L1w7Ggzq640JTtQ2ASVgJK05j2MIyOisMbW1cEqkqJNA
 lKw0QWb+mlc0sS4qWqVE+2JRnbOmGX0IMT/K66KOE+z2W/npOawuqy2hb9/6tel8EoOh
 a/2vZKxjQIlHtpR2d0IHm5br0mh2ci70d6g0oiIl+69Z2LT8ZyqhqqQL3j7rNkepaMw7
 C9Zcv1EhTNdIXJPx7VJlQ3UrXk1nVBCD6og9BAkQ0uBIqimgFjZzFMRJ1B276liCBuzp
 Lnxw==
X-Gm-Message-State: AC+VfDzLSNH8hw4iAys3Rxatxa+2rDpg4lO2v4xMT2sQSkjy9V95EPdz
 GPfvYuo80QeeOBV+H2G2oPE/wdbAKY3O7oBIOkfm1ZbE
X-Google-Smtp-Source: ACHHUZ7EZ+Y4up8ihpTGybTgM18F3mzQ6ev6Obdevl/m05D3j99wYhahCFQsUTCfYeMy0QYigbNi0w==
X-Received: by 2002:a5d:424d:0:b0:313:f2c6:a4f1 with SMTP id
 s13-20020a5d424d000000b00313f2c6a4f1mr2193687wrr.36.1687793989095; 
 Mon, 26 Jun 2023 08:39:49 -0700 (PDT)
Received: from localhost.localdomain ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 t1-20020adfe441000000b00313f45f74a8sm2164178wrm.103.2023.06.26.08.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 08:39:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 04/22] accel/tcg/cputlb.c: Widen CPUTLBEntry access functions
Date: Mon, 26 Jun 2023 17:39:27 +0200
Message-Id: <20230626153945.76180-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626153945.76180-1-richard.henderson@linaro.org>
References: <20230626153945.76180-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Anton Johansson <anjo@rev.ng>

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230621135633.1649-5-anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h | 10 +++++-----
 accel/tcg/cputlb.c      |  8 ++++----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 896f305ff3..645476f0e5 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -328,8 +328,8 @@ static inline void clear_helper_retaddr(void)
 
 #include "tcg/oversized-guest.h"
 
-static inline target_ulong tlb_read_idx(const CPUTLBEntry *entry,
-                                        MMUAccessType access_type)
+static inline uint64_t tlb_read_idx(const CPUTLBEntry *entry,
+                                    MMUAccessType access_type)
 {
     /* Do not rearrange the CPUTLBEntry structure members. */
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_read) !=
@@ -355,14 +355,14 @@ static inline target_ulong tlb_read_idx(const CPUTLBEntry *entry,
 #endif
 }
 
-static inline target_ulong tlb_addr_write(const CPUTLBEntry *entry)
+static inline uint64_t tlb_addr_write(const CPUTLBEntry *entry)
 {
     return tlb_read_idx(entry, MMU_DATA_STORE);
 }
 
 /* Find the TLB index corresponding to the mmu_idx + address pair.  */
 static inline uintptr_t tlb_index(CPUArchState *env, uintptr_t mmu_idx,
-                                  target_ulong addr)
+                                  vaddr addr)
 {
     uintptr_t size_mask = env_tlb(env)->f[mmu_idx].mask >> CPU_TLB_ENTRY_BITS;
 
@@ -371,7 +371,7 @@ static inline uintptr_t tlb_index(CPUArchState *env, uintptr_t mmu_idx,
 
 /* Find the TLB entry corresponding to the mmu_idx + address pair.  */
 static inline CPUTLBEntry *tlb_entry(CPUArchState *env, uintptr_t mmu_idx,
-                                     target_ulong addr)
+                                     vaddr addr)
 {
     return &env_tlb(env)->f[mmu_idx].table[tlb_index(env, mmu_idx, addr)];
 }
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 5caeccb52d..ac990a1526 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1453,7 +1453,7 @@ static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
     assert_cpu_is_self(env_cpu(env));
     for (vidx = 0; vidx < CPU_VTLB_SIZE; ++vidx) {
         CPUTLBEntry *vtlb = &env_tlb(env)->d[mmu_idx].vtable[vidx];
-        target_ulong cmp = tlb_read_idx(vtlb, access_type);
+        uint64_t cmp = tlb_read_idx(vtlb, access_type);
 
         if (cmp == page) {
             /* Found entry in victim tlb, swap tlb and iotlb.  */
@@ -1507,7 +1507,7 @@ static int probe_access_internal(CPUArchState *env, target_ulong addr,
 {
     uintptr_t index = tlb_index(env, mmu_idx, addr);
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
-    target_ulong tlb_addr = tlb_read_idx(entry, access_type);
+    uint64_t tlb_addr = tlb_read_idx(entry, access_type);
     target_ulong page_addr = addr & TARGET_PAGE_MASK;
     int flags = TLB_FLAGS_MASK;
 
@@ -1694,7 +1694,7 @@ bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, int mmu_idx,
     CPUArchState *env = cpu->env_ptr;
     CPUTLBEntry *tlbe = tlb_entry(env, mmu_idx, addr);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
-    vaddr tlb_addr = is_store ? tlb_addr_write(tlbe) : tlbe->addr_read;
+    uint64_t tlb_addr = is_store ? tlb_addr_write(tlbe) : tlbe->addr_read;
 
     if (likely(tlb_hit(tlb_addr, addr))) {
         /* We must have an iotlb entry for MMIO */
@@ -1759,7 +1759,7 @@ static bool mmu_lookup1(CPUArchState *env, MMULookupPageData *data,
     target_ulong addr = data->addr;
     uintptr_t index = tlb_index(env, mmu_idx, addr);
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
-    target_ulong tlb_addr = tlb_read_idx(entry, access_type);
+    uint64_t tlb_addr = tlb_read_idx(entry, access_type);
     bool maybe_resized = false;
 
     /* If the TLB entry is for a different page, reload and try again.  */
-- 
2.34.1


