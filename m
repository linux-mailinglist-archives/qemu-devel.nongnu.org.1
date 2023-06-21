Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 344DE7385E2
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 15:58:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qByKQ-0004DY-62; Wed, 21 Jun 2023 09:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qByKK-0004B5-Jx
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:56:52 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qByKH-00057U-TM
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cpGDj7LukaW1PTt4Cr05bqDZC/jV4cra/q1aKjJRZXk=; b=JXglxqgw7htAAt4zQaizkf6qZb
 soTEP9nkibcuU2NhIhhGFNX9Bks30hPeXpF62W1Cxb4ZoCBg9vvGGx7Be5DPM5QyMdw09Ui8uE6Oh
 v2TPglF29eiAhC2iK9UM9+NpgxN/96lkUQkLscsqdniW62gBN9dOvTkkIFEc8xt7Ccu4=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, pbonzini@redhat.com,
 eduardo@habkost.net, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com
Subject: [PATCH v3 05/12] accel/tcg/cputlb.c: Widen addr in MMULookupPageData
Date: Wed, 21 Jun 2023 15:56:26 +0200
Message-ID: <20230621135633.1649-6-anjo@rev.ng>
In-Reply-To: <20230621135633.1649-1-anjo@rev.ng>
References: <20230621135633.1649-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Functions accessing MMULookupPageData are also updated.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index ac990a1526..cc53d0fb64 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1729,7 +1729,7 @@ bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, int mmu_idx,
 typedef struct MMULookupPageData {
     CPUTLBEntryFull *full;
     void *haddr;
-    target_ulong addr;
+    vaddr addr;
     int flags;
     int size;
 } MMULookupPageData;
@@ -1756,7 +1756,7 @@ typedef struct MMULookupLocals {
 static bool mmu_lookup1(CPUArchState *env, MMULookupPageData *data,
                         int mmu_idx, MMUAccessType access_type, uintptr_t ra)
 {
-    target_ulong addr = data->addr;
+    vaddr addr = data->addr;
     uintptr_t index = tlb_index(env, mmu_idx, addr);
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
     uint64_t tlb_addr = tlb_read_idx(entry, access_type);
@@ -1796,7 +1796,7 @@ static void mmu_watch_or_dirty(CPUArchState *env, MMULookupPageData *data,
                                MMUAccessType access_type, uintptr_t ra)
 {
     CPUTLBEntryFull *full = data->full;
-    target_ulong addr = data->addr;
+    vaddr addr = data->addr;
     int flags = data->flags;
     int size = data->size;
 
@@ -1827,7 +1827,7 @@ static void mmu_watch_or_dirty(CPUArchState *env, MMULookupPageData *data,
  * Resolve the translation for the page(s) beginning at @addr, for MemOp.size
  * bytes.  Return true if the lookup crosses a page boundary.
  */
-static bool mmu_lookup(CPUArchState *env, target_ulong addr, MemOpIdx oi,
+static bool mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
                        uintptr_t ra, MMUAccessType type, MMULookupLocals *l)
 {
     unsigned a_bits;
@@ -2024,7 +2024,7 @@ static uint64_t do_ld_mmio_beN(CPUArchState *env, MMULookupPageData *p,
                                MMUAccessType type, uintptr_t ra)
 {
     CPUTLBEntryFull *full = p->full;
-    target_ulong addr = p->addr;
+    vaddr addr = p->addr;
     int i, size = p->size;
 
     QEMU_IOTHREAD_LOCK_GUARD();
@@ -2333,7 +2333,7 @@ static uint64_t do_ld_8(CPUArchState *env, MMULookupPageData *p, int mmu_idx,
     return ret;
 }
 
-static uint8_t do_ld1_mmu(CPUArchState *env, target_ulong addr, MemOpIdx oi,
+static uint8_t do_ld1_mmu(CPUArchState *env, vaddr addr, MemOpIdx oi,
                           uintptr_t ra, MMUAccessType access_type)
 {
     MMULookupLocals l;
@@ -2352,7 +2352,7 @@ tcg_target_ulong helper_ldub_mmu(CPUArchState *env, uint64_t addr,
     return do_ld1_mmu(env, addr, oi, retaddr, MMU_DATA_LOAD);
 }
 
-static uint16_t do_ld2_mmu(CPUArchState *env, target_ulong addr, MemOpIdx oi,
+static uint16_t do_ld2_mmu(CPUArchState *env, vaddr addr, MemOpIdx oi,
                            uintptr_t ra, MMUAccessType access_type)
 {
     MMULookupLocals l;
@@ -2383,7 +2383,7 @@ tcg_target_ulong helper_lduw_mmu(CPUArchState *env, uint64_t addr,
     return do_ld2_mmu(env, addr, oi, retaddr, MMU_DATA_LOAD);
 }
 
-static uint32_t do_ld4_mmu(CPUArchState *env, target_ulong addr, MemOpIdx oi,
+static uint32_t do_ld4_mmu(CPUArchState *env, vaddr addr, MemOpIdx oi,
                            uintptr_t ra, MMUAccessType access_type)
 {
     MMULookupLocals l;
@@ -2410,7 +2410,7 @@ tcg_target_ulong helper_ldul_mmu(CPUArchState *env, uint64_t addr,
     return do_ld4_mmu(env, addr, oi, retaddr, MMU_DATA_LOAD);
 }
 
-static uint64_t do_ld8_mmu(CPUArchState *env, target_ulong addr, MemOpIdx oi,
+static uint64_t do_ld8_mmu(CPUArchState *env, vaddr addr, MemOpIdx oi,
                            uintptr_t ra, MMUAccessType access_type)
 {
     MMULookupLocals l;
@@ -2460,7 +2460,7 @@ tcg_target_ulong helper_ldsl_mmu(CPUArchState *env, uint64_t addr,
     return (int32_t)helper_ldul_mmu(env, addr, oi, retaddr);
 }
 
-static Int128 do_ld16_mmu(CPUArchState *env, target_ulong addr,
+static Int128 do_ld16_mmu(CPUArchState *env, vaddr addr,
                           MemOpIdx oi, uintptr_t ra)
 {
     MMULookupLocals l;
@@ -2617,7 +2617,7 @@ static uint64_t do_st_mmio_leN(CPUArchState *env, MMULookupPageData *p,
                                uint64_t val_le, int mmu_idx, uintptr_t ra)
 {
     CPUTLBEntryFull *full = p->full;
-    target_ulong addr = p->addr;
+    vaddr addr = p->addr;
     int i, size = p->size;
 
     QEMU_IOTHREAD_LOCK_GUARD();
@@ -2808,7 +2808,7 @@ void helper_stb_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
     do_st_1(env, &l.page[0], val, l.mmu_idx, ra);
 }
 
-static void do_st2_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
+static void do_st2_mmu(CPUArchState *env, vaddr addr, uint16_t val,
                        MemOpIdx oi, uintptr_t ra)
 {
     MMULookupLocals l;
@@ -2837,7 +2837,7 @@ void helper_stw_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
     do_st2_mmu(env, addr, val, oi, retaddr);
 }
 
-static void do_st4_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
+static void do_st4_mmu(CPUArchState *env, vaddr addr, uint32_t val,
                        MemOpIdx oi, uintptr_t ra)
 {
     MMULookupLocals l;
@@ -2864,7 +2864,7 @@ void helper_stl_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
     do_st4_mmu(env, addr, val, oi, retaddr);
 }
 
-static void do_st8_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
+static void do_st8_mmu(CPUArchState *env, vaddr addr, uint64_t val,
                        MemOpIdx oi, uintptr_t ra)
 {
     MMULookupLocals l;
@@ -2891,7 +2891,7 @@ void helper_stq_mmu(CPUArchState *env, uint64_t addr, uint64_t val,
     do_st8_mmu(env, addr, val, oi, retaddr);
 }
 
-static void do_st16_mmu(CPUArchState *env, target_ulong addr, Int128 val,
+static void do_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
                         MemOpIdx oi, uintptr_t ra)
 {
     MMULookupLocals l;
-- 
2.41.0


