Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D03D9A06BE9
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Jan 2025 04:14:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tViyA-0008Rj-Ha; Wed, 08 Jan 2025 22:12:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1tViy7-0008RD-S4; Wed, 08 Jan 2025 22:12:23 -0500
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1tViy6-0001HK-1b; Wed, 08 Jan 2025 22:12:23 -0500
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
 by Atcsqr.andestech.com with ESMTP id 5092jXSf028543;
 Thu, 9 Jan 2025 10:45:33 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
 by Atcsqr.andestech.com with ESMTPS id 5092j0il027800
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Jan 2025 10:45:00 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from atcpcw16.andestech.com (10.0.1.106) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 9 Jan 2025
 10:45:00 +0800
To: <qemu-devel@nongnu.org>
CC: <richard.henderson@linaro.org>, <pbonzini@redhat.com>,
 <palmer@dabbelt.com>, <alistair.francis@wdc.com>, <bmeng.cn@gmail.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <peterx@redhat.com>,
 <david@redhat.com>, <philmd@linaro.org>, <qemu-riscv@nongnu.org>,
 Ethan Chen <ethan84@andestech.com>
Subject: [PATCH v9 3/8] system/physmem: Support IOMMU granularity smaller than
 TARGET_PAGE size
Date: Thu, 9 Jan 2025 10:44:36 +0800
Message-ID: <20250109024441.3283671-4-ethan84@andestech.com>
X-Mailer: git-send-email 2.42.0.345.gaab89be2eb.dirty
In-Reply-To: <20250109024441.3283671-1-ethan84@andestech.com>
References: <20250109024441.3283671-1-ethan84@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.1.106]
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 5092jXSf028543
Received-SPF: pass client-ip=60.248.80.70; envelope-from=ethan84@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
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
Reply-to:  Ethan Chen <ethan84@andestech.com>
From:  Ethan Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

If the IOMMU granularity is smaller than the TARGET_PAGE size, there may be
 multiple entries within the same page. To obtain the correct result, pass
the original address to the IOMMU.

Similar to the RISC-V PMP solution, the TLB_INVALID_MASK will be set when
there are multiple entries in the same page, ensuring that the IOMMU is
checked on every access.

Signed-off-by: Ethan Chen <ethan84@andestech.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 accel/tcg/cputlb.c | 20 ++++++++++++++++----
 system/physmem.c   |  4 ++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 71c16a1ac1..ed55f02eab 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1063,8 +1063,23 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
 
     prot = full->prot;
     asidx = cpu_asidx_from_attrs(cpu, full->attrs);
-    section = address_space_translate_for_iotlb(cpu, asidx, paddr_page,
+    section = address_space_translate_for_iotlb(cpu, asidx, full->phys_addr,
                                                 &xlat, &sz, full->attrs, &prot);
+    /* Update page size */
+    full->lg_page_size = ctz64(sz);
+    if (full->lg_page_size > TARGET_PAGE_BITS) {
+        full->lg_page_size = TARGET_PAGE_BITS;
+    } else {
+        sz = TARGET_PAGE_SIZE;
+    }
+
+    is_ram = memory_region_is_ram(section->mr);
+    is_romd = memory_region_is_romd(section->mr);
+    /* If the translated mr is ram/rom, make xlat align the TARGET_PAGE */
+    if (is_ram || is_romd) {
+        xlat &= TARGET_PAGE_MASK;
+    }
+
     assert(sz >= TARGET_PAGE_SIZE);
 
     tlb_debug("vaddr=%016" VADDR_PRIx " paddr=0x" HWADDR_FMT_plx
@@ -1077,9 +1092,6 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
         read_flags |= TLB_INVALID_MASK;
     }
 
-    is_ram = memory_region_is_ram(section->mr);
-    is_romd = memory_region_is_romd(section->mr);
-
     if (is_ram || is_romd) {
         /* RAM and ROMD both have associated host memory. */
         addend = (uintptr_t)memory_region_get_ram_ptr(section->mr) + xlat;
diff --git a/system/physmem.c b/system/physmem.c
index c76503aea8..d64543b413 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -702,6 +702,10 @@ address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr orig_addr,
         iotlb = imrc->translate(iommu_mr, addr, IOMMU_NONE, iommu_idx);
         addr = ((iotlb.translated_addr & ~iotlb.addr_mask)
                 | (addr & iotlb.addr_mask));
+        /* Update size */
+        if (iotlb.addr_mask != -1 && *plen > iotlb.addr_mask + 1) {
+            *plen = iotlb.addr_mask + 1;
+        }
         /* Update the caller's prot bits to remove permissions the IOMMU
          * is giving us a failure response for. If we get down to no
          * permissions left at all we can give up now.
-- 
2.34.1


