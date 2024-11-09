Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D359C2ACB
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Nov 2024 07:43:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9fAO-000676-B9; Sat, 09 Nov 2024 01:41:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9f8r-00046W-4H; Sat, 09 Nov 2024 01:40:17 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9f8o-0002U1-VH; Sat, 09 Nov 2024 01:40:16 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 88DC1A12F8;
 Sat,  9 Nov 2024 09:38:10 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E661C167DDC;
 Sat,  9 Nov 2024 09:39:04 +0300 (MSK)
Received: (nullmailer pid 3272543 invoked by uid 1000);
 Sat, 09 Nov 2024 06:39:03 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alexander Graf <graf@amazon.com>,
 Eduard Vlad <evlad@amazon.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.15 17/33] target/i386: Walk NPT in guest real mode
Date: Sat,  9 Nov 2024 09:38:43 +0300
Message-Id: <20241109063903.3272404-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.15-20241109093832@cover.tls.msk.ru>
References: <qemu-stable-7.2.15-20241109093832@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alexander Graf <graf@amazon.com>

When translating virtual to physical address with a guest CPU that
supports nested paging (NPT), we need to perform every page table walk
access indirectly through the NPT, which we correctly do.

However, we treat real mode (no page table walk) special: In that case,
we currently just skip any walks and translate VA -> PA. With NPT
enabled, we also need to then perform NPT walk to do GVA -> GPA -> HPA
which we fail to do so far.

The net result of that is that TCG VMs with NPT enabled that execute
real mode code (like SeaBIOS) end up with GPA==HPA mappings which means
the guest accesses host code and data. This typically shows as failure
to boot guests.

This patch changes the page walk logic for NPT enabled guests so that we
always perform a GVA -> GPA translation and then skip any logic that
requires an actual PTE.

That way, all remaining logic to walk the NPT stays and we successfully
walk the NPT in real mode.

Cc: qemu-stable@nongnu.org
Fixes: fe441054bb3f0 ("target-i386: Add NPT support")
Signed-off-by: Alexander Graf <graf@amazon.com>
Reported-by: Eduard Vlad <evlad@amazon.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240921085712.28902-1-graf@amazon.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit b56617bbcb473c25815d1bf475e326f84563b1de)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index eb78fcba11..a52a5b417e 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -147,6 +147,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
     uint32_t pkr;
     int page_size;
     int error_code;
+    int prot;
 
  restart_all:
     rsvd_mask = ~MAKE_64BIT_MASK(0, env_archcpu(env)->phys_bits);
@@ -295,7 +296,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
         /* combine pde and pte nx, user and rw protections */
         ptep &= pte ^ PG_NX_MASK;
         page_size = 4096;
-    } else {
+    } else if (pg_mode) {
         /*
          * Page table level 2
          */
@@ -340,6 +341,15 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
         ptep &= pte | PG_NX_MASK;
         page_size = 4096;
         rsvd_mask = 0;
+    } else {
+        /*
+         * No paging (real mode), let's tentatively resolve the address as 1:1
+         * here, but conditionally still perform an NPT walk on it later.
+         */
+        page_size = 0x40000000;
+        paddr = in->addr;
+        prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+        goto stage2;
     }
 
 do_check_protect:
@@ -355,7 +365,7 @@ do_check_protect_pse36:
         goto do_fault_protect;
     }
 
-    int prot = 0;
+    prot = 0;
     if (!is_mmu_index_smap(in->mmu_idx) || !(ptep & PG_USER_MASK)) {
         prot |= PAGE_READ;
         if ((ptep & PG_RW_MASK) || !(is_user || (pg_mode & PG_MODE_WP))) {
@@ -417,6 +427,7 @@ do_check_protect_pse36:
 
     /* merge offset within page */
     paddr = (pte & PG_ADDRESS_MASK & ~(page_size - 1)) | (addr & (page_size - 1));
+ stage2:
 
     /*
      * Note that NPT is walked (for both paging structures and final guest
@@ -558,7 +569,7 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
             addr = (uint32_t)addr;
         }
 
-        if (likely(env->cr[0] & CR0_PG_MASK)) {
+        if (likely(env->cr[0] & CR0_PG_MASK || use_stage2)) {
             in.cr3 = env->cr[3];
             in.mmu_idx = mmu_idx;
             in.ptw_idx = use_stage2 ? MMU_NESTED_IDX : MMU_PHYS_IDX;
-- 
2.39.5


