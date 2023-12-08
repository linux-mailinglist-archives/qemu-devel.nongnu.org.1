Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA586809905
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 03:09:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBQHS-0007KM-Ef; Thu, 07 Dec 2023 21:07:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rBQHH-0007K3-6h
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 21:07:44 -0500
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rBQHE-0006Ie-3D
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 21:07:42 -0500
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046060;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0Vy1Rweh_1702001245; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0Vy1Rweh_1702001245) by smtp.aliyun-inc.com;
 Fri, 08 Dec 2023 10:07:26 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, mark.cave-ayland@ilande.co.uk,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH for 8.2] accel/tcg/cputlb: Fix iotlb page alignment check
Date: Fri,  8 Dec 2023 10:06:19 +0800
Message-Id: <20231208020619.117-1-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.119;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-119.freemail.mail.aliyun.com
X-Spam_score_int: -98
X-Spam_score: -9.9
X-Spam_bar: ---------
X-Spam_report: (-9.9 / 5.0 requ) BAYES_00=-1.9, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001,
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

For ram memory region the iotlb(which will be filled into the xlat_section
of CPUTLBEntryFull) is calculated as:

iotlb = memory_region_get_ram_addr(section->mr) + xlat;

1) xlat here is the offset_within_region of a MemoryRegionSection, which maybe
not TARGET_PAGE_BITS aligned.
2) The ram_addr_t returned by memory_region_get_ram_addr is always
HOST PAGE ALIGNED.

So we cann't assert the sum of them is TARGET_PAGE_BITS aligend.
A fail case has been give by the link:
https://lore.kernel.org/all/b68ab7d3-d3d3-9f81-569d-454ae9c11b16@linaro.org/T/

Fixes: dff1ab68d8c5 ("accel/tcg: Fix the comment for CPUTLBEntryFull")
Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 accel/tcg/cputlb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index db3f93fda9..7a50a21a2e 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1168,7 +1168,6 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     write_flags = read_flags;
     if (is_ram) {
         iotlb = memory_region_get_ram_addr(section->mr) + xlat;
-        assert(!(iotlb & ~TARGET_PAGE_MASK));
         /*
          * Computing is_clean is expensive; avoid all that unless
          * the page is actually writable.
@@ -1231,9 +1230,8 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
 
     /* refill the tlb */
     /*
-     * When memory region is ram, iotlb contains a TARGET_PAGE_BITS
-     * aligned ram_addr_t of the page base of the target RAM.
-     * Otherwise, iotlb contains
+     * When memory region is ram, iotlb contains ram_addr_t of the page base
+     * of the target RAM. Otherwise, iotlb contains
      *  - a physical section number in the lower TARGET_PAGE_BITS
      *  - the offset within section->mr of the page base (I/O, ROMD) with the
      *    TARGET_PAGE_BITS masked off.
-- 
2.17.1


