Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C4E78F84F
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 08:02:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbxEj-0000X1-9r; Fri, 01 Sep 2023 02:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1qbxEg-0000Wt-Mp
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 02:02:26 -0400
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1qbxEd-0004Al-HN
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 02:02:26 -0400
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R581e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046051;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0Vr1M3Ks_1693548128; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0Vr1M3Ks_1693548128) by smtp.aliyun-inc.com;
 Fri, 01 Sep 2023 14:02:09 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 1/1] accel/tcg: Fix the comment for CPUTLBEntryFull
Date: Fri,  1 Sep 2023 14:01:18 +0800
Message-Id: <20230901060118.379-1-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.101;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-101.freemail.mail.aliyun.com
X-Spam_score_int: -98
X-Spam_score: -9.9
X-Spam_bar: ---------
X-Spam_report: (-9.9 / 5.0 requ) BAYES_00=-1.9, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

When memory region is ram, the lower TARGET_PAGE_BITS is not the
physical section number. Instead, its value is always 0.

Add comment and assert to make it clear.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 accel/tcg/cputlb.c      | 11 +++++++----
 include/exec/cpu-defs.h | 12 ++++++------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index d68fa6867c..a1ebf75068 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1192,6 +1192,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     write_flags = read_flags;
     if (is_ram) {
         iotlb = memory_region_get_ram_addr(section->mr) + xlat;
+        assert(!(iotlb & ~TARGET_PAGE_MASK));
         /*
          * Computing is_clean is expensive; avoid all that unless
          * the page is actually writable.
@@ -1254,10 +1255,12 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
 
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
 
-- 
2.17.1


