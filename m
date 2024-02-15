Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC638566D6
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Feb 2024 16:03:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1radGS-000506-Mw; Thu, 15 Feb 2024 10:03:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1radG4-0004sX-DM
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 10:02:42 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1radG0-000235-45
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 10:02:39 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbJ9k5Fzbz6K8kJ;
 Thu, 15 Feb 2024 22:59:06 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 83BF3140D1D;
 Thu, 15 Feb 2024 23:02:34 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 15:02:34 +0000
To: <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Gregory
 Price <gregory.price@memverge.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Sajjan Rao <sajjanr@gmail.com>, Dimitrios Palyvos
 <dimitrios.palyvos@zptcorp.com>, <richard.henderson@linaro.org>, Paolo
 Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
CC: <linux-cxl@vger.kernel.org>
Subject: [PATCH 2/3] target/i386: Enable page walking from MMIO memory
Date: Thu, 15 Feb 2024 15:01:32 +0000
Message-ID: <20240215150133.2088-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215150133.2088-1-Jonathan.Cameron@huawei.com>
References: <20240215150133.2088-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Gregory Price <gregory.price@memverge.com>

CXL emulation of interleave requires read and write hooks due to
requirement for subpage granularity. The Linux kernel stack now enables
using this memory as conventional memory in a separate NUMA node. If a
process is deliberately forced to run from that node
$ numactl --membind=1 ls
the page table walk on i386 fails.

Useful part of backtrace:

    (cpu=cpu@entry=0x555556fd9000, fmt=fmt@entry=0x555555fe3378 "cpu_io_recompile: could not find TB for pc=%p")
    at ../../cpu-target.c:359
    (retaddr=0, addr=19595792376, attrs=..., xlat=<optimized out>, cpu=0x555556fd9000, out_offset=<synthetic pointer>)
    at ../../accel/tcg/cputlb.c:1339
    (cpu=0x555556fd9000, full=0x7fffee0d96e0, ret_be=ret_be@entry=0, addr=19595792376, size=size@entry=8, mmu_idx=4, type=MMU_DATA_LOAD, ra=0) at ../../accel/tcg/cputlb.c:2030
    (cpu=cpu@entry=0x555556fd9000, p=p@entry=0x7ffff56fddc0, mmu_idx=<optimized out>, type=type@entry=MMU_DATA_LOAD, memop=<optimized out>, ra=ra@entry=0) at ../../accel/tcg/cputlb.c:2356
    (cpu=cpu@entry=0x555556fd9000, addr=addr@entry=19595792376, oi=oi@entry=52, ra=ra@entry=0, access_type=access_type@entry=MMU_DATA_LOAD) at ../../accel/tcg/cputlb.c:2439
    at ../../accel/tcg/ldst_common.c.inc:301
    at ../../target/i386/tcg/sysemu/excp_helper.c:173
    (err=0x7ffff56fdf80, out=0x7ffff56fdf70, mmu_idx=0, access_type=MMU_INST_FETCH, addr=18446744072116178925, env=0x555556fdb7c0)
    at ../../target/i386/tcg/sysemu/excp_helper.c:578
    (cs=0x555556fd9000, addr=18446744072116178925, size=<optimized out>, access_type=MMU_INST_FETCH, mmu_idx=0, probe=<optimized out>, retaddr=0) at ../../target/i386/tcg/sysemu/excp_helper.c:604

Avoid this by plumbing the address all the way down from
x86_cpu_tlb_fill() where is available as retaddr to the actual accessors
which provide it to probe_access_full() which already handles MMIO accesses.

Signed-off-by: Gregory Price <gregory.price@memverge.com>

---
Patch posted in reply to thread:
https://lore.kernel.org/qemu-devel/ZbvpSaOXzZkqDd6c@memverge.com/

I checked Gregory was fine with me adding Sign-off / author via the CXL discord.
---
 target/i386/tcg/sysemu/excp_helper.c | 57 +++++++++++++++-------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 5b86f439ad..b3bce020f4 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -59,14 +59,14 @@ typedef struct PTETranslate {
     hwaddr gaddr;
 } PTETranslate;
 
-static bool ptw_translate(PTETranslate *inout, hwaddr addr)
+static bool ptw_translate(PTETranslate *inout, hwaddr addr, uint64_t ra)
 {
     CPUTLBEntryFull *full;
     int flags;
 
     inout->gaddr = addr;
     flags = probe_access_full(inout->env, addr, 0, MMU_DATA_STORE,
-                              inout->ptw_idx, true, &inout->haddr, &full, 0);
+                              inout->ptw_idx, true, &inout->haddr, &full, ra);
 
     if (unlikely(flags & TLB_INVALID_MASK)) {
         TranslateFault *err = inout->err;
@@ -82,20 +82,20 @@ static bool ptw_translate(PTETranslate *inout, hwaddr addr)
     return true;
 }
 
-static inline uint32_t ptw_ldl(const PTETranslate *in)
+static inline uint32_t ptw_ldl(const PTETranslate *in, uint64_t ra)
 {
     if (likely(in->haddr)) {
         return ldl_p(in->haddr);
     }
-    return cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, 0);
+    return cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, ra);
 }
 
-static inline uint64_t ptw_ldq(const PTETranslate *in)
+static inline uint64_t ptw_ldq(const PTETranslate *in, uint64_t ra)
 {
     if (likely(in->haddr)) {
         return ldq_p(in->haddr);
     }
-    return cpu_ldq_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, 0);
+    return cpu_ldq_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, ra);
 }
 
 /*
@@ -132,7 +132,8 @@ static inline bool ptw_setl(const PTETranslate *in, uint32_t old, uint32_t set)
 }
 
 static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
-                          TranslateResult *out, TranslateFault *err)
+                          TranslateResult *out, TranslateFault *err,
+                          uint64_t ra)
 {
     const int32_t a20_mask = x86_get_a20_mask(env);
     const target_ulong addr = in->addr;
@@ -166,11 +167,11 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
                  */
                 pte_addr = ((in->cr3 & ~0xfff) +
                             (((addr >> 48) & 0x1ff) << 3)) & a20_mask;
-                if (!ptw_translate(&pte_trans, pte_addr)) {
+                if (!ptw_translate(&pte_trans, pte_addr, ra)) {
                     return false;
                 }
             restart_5:
-                pte = ptw_ldq(&pte_trans);
+                pte = ptw_ldq(&pte_trans, ra);
                 if (!(pte & PG_PRESENT_MASK)) {
                     goto do_fault;
                 }
@@ -191,11 +192,11 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
              */
             pte_addr = ((pte & PG_ADDRESS_MASK) +
                         (((addr >> 39) & 0x1ff) << 3)) & a20_mask;
-            if (!ptw_translate(&pte_trans, pte_addr)) {
+            if (!ptw_translate(&pte_trans, pte_addr, ra)) {
                 return false;
             }
         restart_4:
-            pte = ptw_ldq(&pte_trans);
+            pte = ptw_ldq(&pte_trans, ra);
             if (!(pte & PG_PRESENT_MASK)) {
                 goto do_fault;
             }
@@ -212,11 +213,11 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
              */
             pte_addr = ((pte & PG_ADDRESS_MASK) +
                         (((addr >> 30) & 0x1ff) << 3)) & a20_mask;
-            if (!ptw_translate(&pte_trans, pte_addr)) {
+            if (!ptw_translate(&pte_trans, pte_addr, ra)) {
                 return false;
             }
         restart_3_lma:
-            pte = ptw_ldq(&pte_trans);
+            pte = ptw_ldq(&pte_trans, ra);
             if (!(pte & PG_PRESENT_MASK)) {
                 goto do_fault;
             }
@@ -239,12 +240,12 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
              * Page table level 3
              */
             pte_addr = ((in->cr3 & ~0x1f) + ((addr >> 27) & 0x18)) & a20_mask;
-            if (!ptw_translate(&pte_trans, pte_addr)) {
+            if (!ptw_translate(&pte_trans, pte_addr, ra)) {
                 return false;
             }
             rsvd_mask |= PG_HI_USER_MASK;
         restart_3_nolma:
-            pte = ptw_ldq(&pte_trans);
+            pte = ptw_ldq(&pte_trans, ra);
             if (!(pte & PG_PRESENT_MASK)) {
                 goto do_fault;
             }
@@ -262,11 +263,11 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
          */
         pte_addr = ((pte & PG_ADDRESS_MASK) +
                     (((addr >> 21) & 0x1ff) << 3)) & a20_mask;
-        if (!ptw_translate(&pte_trans, pte_addr)) {
+        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
             return false;
         }
     restart_2_pae:
-        pte = ptw_ldq(&pte_trans);
+        pte = ptw_ldq(&pte_trans, ra);
         if (!(pte & PG_PRESENT_MASK)) {
             goto do_fault;
         }
@@ -289,10 +290,10 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
          */
         pte_addr = ((pte & PG_ADDRESS_MASK) +
                     (((addr >> 12) & 0x1ff) << 3)) & a20_mask;
-        if (!ptw_translate(&pte_trans, pte_addr)) {
+        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
             return false;
         }
-        pte = ptw_ldq(&pte_trans);
+        pte = ptw_ldq(&pte_trans, ra);
         if (!(pte & PG_PRESENT_MASK)) {
             goto do_fault;
         }
@@ -307,11 +308,11 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
          * Page table level 2
          */
         pte_addr = ((in->cr3 & ~0xfff) + ((addr >> 20) & 0xffc)) & a20_mask;
-        if (!ptw_translate(&pte_trans, pte_addr)) {
+        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
             return false;
         }
     restart_2_nopae:
-        pte = ptw_ldl(&pte_trans);
+        pte = ptw_ldl(&pte_trans, ra);
         if (!(pte & PG_PRESENT_MASK)) {
             goto do_fault;
         }
@@ -336,10 +337,10 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
          * Page table level 1
          */
         pte_addr = ((pte & ~0xfffu) + ((addr >> 10) & 0xffc)) & a20_mask;
-        if (!ptw_translate(&pte_trans, pte_addr)) {
+        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
             return false;
         }
-        pte = ptw_ldl(&pte_trans);
+        pte = ptw_ldl(&pte_trans, ra);
         if (!(pte & PG_PRESENT_MASK)) {
             goto do_fault;
         }
@@ -529,7 +530,8 @@ static G_NORETURN void raise_stage2(CPUX86State *env, TranslateFault *err,
 
 static bool get_physical_address(CPUX86State *env, vaddr addr,
                                  MMUAccessType access_type, int mmu_idx,
-                                 TranslateResult *out, TranslateFault *err)
+                                 TranslateResult *out, TranslateFault *err,
+                                 uint64_t ra)
 {
     TranslateParams in;
     bool use_stage2 = env->hflags2 & HF2_NPT_MASK;
@@ -548,7 +550,7 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
             in.mmu_idx = MMU_USER_IDX;
             in.ptw_idx = MMU_PHYS_IDX;
 
-            if (!mmu_translate(env, &in, out, err)) {
+            if (!mmu_translate(env, &in, out, err, ra)) {
                 err->stage2 = S2_GPA;
                 return false;
             }
@@ -575,7 +577,7 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
                     return false;
                 }
             }
-            return mmu_translate(env, &in, out, err);
+            return mmu_translate(env, &in, out, err, ra);
         }
         break;
     }
@@ -601,7 +603,8 @@ bool x86_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
     TranslateResult out;
     TranslateFault err;
 
-    if (get_physical_address(env, addr, access_type, mmu_idx, &out, &err)) {
+    if (get_physical_address(env, addr, access_type, mmu_idx, &out, &err,
+                             retaddr)) {
         /*
          * Even if 4MB pages, we map only one 4KB page in the cache to
          * avoid filling it too fast.
-- 
2.39.2


