Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7B8A875B8
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Apr 2025 04:06:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u49BE-0007Oe-5f; Sun, 13 Apr 2025 22:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u49Ao-0007Gc-SR
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 22:03:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u49Am-0007UJ-US
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 22:03:46 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E0qECW023750;
 Mon, 14 Apr 2025 02:03:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2023-11-20; bh=oQaVH
 C0XxeZdAHTxf/QdS0CQmPN0iCKScxcStswVJ8w=; b=Tblk3Z45B5Krml5ZSabYx
 NYfK84lqI/TKG5mcj+McNRkjbqhKHRRjzB5uacazHM8FcpRYYr/yBwk2ZxP6ek99
 sBwZVOJG78Qreh4KLELKscdqGT9sKgQst1mX4GK3RAkcyGc/oEL1iuKAtvS99+ZB
 EgWx76Iuo074IjLyuEr3ZraevrLWCfvEtiVdGcoguYL4V1qGduSZSu8ng/cMCvEU
 mM5U8Y3rrvN38GDqGpEkaWx38tauDhaflW/cfeuHsteo2vhHIAl6OJnD2ZEG2SqD
 26IW2K5uT2o8lyhbIGQJoXW3RGETe/2Hz4PzCToteBL2V482yEIvE2LJo1J3OfKH
 Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 460r6qg1tt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 02:03:39 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53DN0R6H009188; Mon, 14 Apr 2025 02:03:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 460d3fvqt0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 02:03:38 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53E22tYe035550;
 Mon, 14 Apr 2025 02:03:38 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 460d3fvqg0-10; Mon, 14 Apr 2025 02:03:37 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH 09/18] amd_iommu: Add helpers to walk AMD v1 Page Table format
Date: Mon, 14 Apr 2025 02:02:44 +0000
Message-ID: <20250414020253.443831-10-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
References: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-13_12,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504140014
X-Proofpoint-GUID: 0mPBRl5jJKwpp-oDW43lMiCdSbb9DPEr
X-Proofpoint-ORIG-GUID: 0mPBRl5jJKwpp-oDW43lMiCdSbb9DPEr
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.266,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The current amdvi_page_walk() is designed to be called by the replay()
method. Rather than drastically altering it, introduce helpers to fetch
guest PTEs that will be used by a page walker implementation.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 125 ++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/amd_iommu.h |  42 +++++++++++++++
 2 files changed, 167 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 0af873b66a31..d089fdc28ef1 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1563,6 +1563,131 @@ static const MemoryRegionOps amdvi_ir_ops = {
     }
 };
 
+/*
+ * For a PTE encoding a large page, return the page size it encodes as described
+ * by the AMD IOMMU Specification Table 14: Example Page Size Encodings.
+ * No need to adjust the value of the PTE to point to the first PTE in the large
+ * page since the encoding guarantees all "base" PTEs in the large page are the
+ * same.
+ */
+static uint64_t large_pte_page_size(uint64_t pte)
+{
+    assert(PTE_NEXT_LEVEL(pte) == 7);
+
+    /* Determine size of the large/contiguous page encoded in the PTE */
+    return PTE_LARGE_PAGE_SIZE(pte);
+}
+
+/*
+ * Helper function to fetch a PTE using AMD v1 pgtable format.
+ * Returns:
+ * -2:  The Page Table Root could not be read from DTE, or IOVA is larger than
+ *      supported by current page table level encodedin DTE[Mode].
+ * -1:  PTE could not be read from guest memory during a page table walk.
+ *      This means that the DTE has valid data, and one of the lower level
+ *      entries in the Page Table could not be read.
+ *  0:  PTE is marked not present, or entry is 0.
+ * >0:  Leaf PTE value resolved from walking Guest IO Page Table.
+ */
+static uint64_t __attribute__((unused))
+fetch_pte(AMDVIAddressSpace *as, const hwaddr address, uint64_t dte,
+          hwaddr *page_size)
+{
+    IOMMUAccessFlags perms = amdvi_get_perms(dte);
+
+    uint8_t level, mode;
+    uint64_t pte = dte, pte_addr;
+
+    *page_size = 0;
+
+    if (perms == IOMMU_NONE) {
+        return (uint64_t)-2;
+    }
+
+    /*
+     * The Linux kernel driver initializes the default mode to 3, corresponding
+     * to a 39-bit GPA space, where each entry in the pagetable translates to a
+     * 1GB (2^30) page size.
+     */
+    level = mode = get_pte_translation_mode(dte);
+    assert(mode > 0 && mode < 7);
+
+    /*
+     * If IOVA is larger than the max supported by the current pgtable level,
+     * there is nothing to do. This signals that the pagetable level should be
+     * increased, or is an address meant to have special behavior like
+     * invalidating the entire cache.
+     */
+    if (address > PT_LEVEL_MAX_ADDR(mode - 1)) {
+        /* IOVA too large for the current DTE */
+        return (uint64_t)-2;
+    }
+
+    do {
+        level -= 1;
+
+        /* Update the page_size */
+        *page_size = PTE_LEVEL_PAGE_SIZE(level);
+
+        /* Permission bits are ANDed at every level, including the DTE */
+        perms &= amdvi_get_perms(pte);
+        if (perms == IOMMU_NONE) {
+            return pte;
+        }
+
+        /* Not Present */
+        if (!IOMMU_PTE_PRESENT(pte)) {
+            return 0;
+        }
+
+        /* Large or Leaf PTE found */
+        if (PTE_NEXT_LEVEL(pte) == 7 || PTE_NEXT_LEVEL(pte) == 0) {
+            /* Leaf PTE found */
+            break;
+        }
+
+        /*
+         * Index the pgtable using the IOVA bits corresponding to current level
+         * and walk down to the lower level.
+         */
+        pte_addr = NEXT_PTE_ADDR(pte, level, address);
+        pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
+
+        if (pte == (uint64_t)-1) {
+            /*
+             * A returned PTE of -1 indicates a failure to read the page table
+             * entry from guest memory.
+             */
+            if (level == mode - 1) {
+                /* Failure to retrieve the Page Table from Root Pointer */
+                *page_size = 0;
+                return (uint64_t)-2;
+            } else {
+                /* Failure to read PTE. Page walk skips a page_size chunk */
+                return pte;
+            }
+        }
+    } while (level > 0);
+
+    /*
+     * Page walk ends when Next Level field on PTE shows that either a leaf PTE
+     * or a series of large PTEs have been reached. In the latter case, return
+     * the pointer to the first PTE of the series.
+     */
+    assert(level == 0 || PTE_NEXT_LEVEL(pte) == 0 || PTE_NEXT_LEVEL(pte) == 7);
+
+    /*
+     * In case the range starts in the middle of a contiguous page, need to
+     * return the first PTE
+     */
+    if (PTE_NEXT_LEVEL(pte) == 7) {
+        /* Update page_size with the large PTE page size */
+        *page_size = large_pte_page_size(pte);
+    }
+
+    return pte;
+}
+
 /*
  * Toggle between address translation and passthrough modes by enabling the
  * corresponding memory regions.
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index c89e7dc9947d..fc4d2f7a4575 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -25,6 +25,8 @@
 #include "hw/i386/x86-iommu.h"
 #include "qom/object.h"
 
+#define GENMASK64(h, l)  (((~0ULL) >> (63 - (h) + (l))) << (l))
+
 /* Capability registers */
 #define AMDVI_CAPAB_BAR_LOW           0x04
 #define AMDVI_CAPAB_BAR_HIGH          0x08
@@ -174,6 +176,46 @@
 #define AMDVI_GATS_MODE                 (2ULL <<  12)
 #define AMDVI_HATS_MODE                 (2ULL <<  10)
 
+/* Page Table format */
+
+#define AMDVI_PTE_PR                    (1ULL << 0)
+#define AMDVI_PTE_NEXT_LEVEL_MASK       GENMASK64(11, 9)
+
+#define IOMMU_PTE_PRESENT(pte)          ((pte) & AMDVI_PTE_PR)
+
+/* Using level=0 for leaf PTE at 4K page size */
+#define PT_LEVEL_SHIFT(level)           (12 + ((level) * 9))
+
+/* Return IOVA bit group used to index the Page Table at specific level */
+#define PT_LEVEL_INDEX(level, iova)     (((iova) >> PT_LEVEL_SHIFT(level)) & \
+                                        GENMASK64(8, 0))
+
+/* Return the max address for a specified level i.e. max_oaddr */
+#define PT_LEVEL_MAX_ADDR(x)    (((x) < 5) ? \
+                                ((1ULL << PT_LEVEL_SHIFT((x + 1))) - 1) : \
+                                (~(0ULL)))
+
+/* Extract the NextLevel field from PTE/PDE */
+#define PTE_NEXT_LEVEL(pte)     (((pte) & AMDVI_PTE_NEXT_LEVEL_MASK) >> 9)
+
+/* Take page table level and return default pagetable size for level */
+#define PTE_LEVEL_PAGE_SIZE(level)      (1ULL << (PT_LEVEL_SHIFT(level)))
+
+/*
+ * Return address of lower level page table encoded in PTE and specified by
+ * current level and corresponding IOVA bit group at such level.
+ */
+#define NEXT_PTE_ADDR(pte, level, iova) (((pte) & AMDVI_DEV_PT_ROOT_MASK) + \
+                                        (PT_LEVEL_INDEX(level, iova) * 8))
+
+/*
+ * Take a PTE value with mode=0x07 and return the page size it encodes.
+ */
+#define PTE_LARGE_PAGE_SIZE(pte)    (1ULL << (1 + cto64(((pte) | 0xfffULL))))
+
+/* Return number of PTEs to use for a given page size (expected power of 2) */
+#define PAGE_SIZE_PTE_COUNT(pgsz)       (1ULL << ((ctz64(pgsz) - 12) % 9))
+
 /* IOTLB */
 #define AMDVI_IOTLB_MAX_SIZE 1024
 #define AMDVI_DEVID_SHIFT    36
-- 
2.43.5


