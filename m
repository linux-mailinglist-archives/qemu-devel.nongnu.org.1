Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99627A5C691
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Mar 2025 16:26:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts1Ty-0001h8-GW; Tue, 11 Mar 2025 11:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1ts1Ti-0001RO-Lg
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:25:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1ts1Td-0007af-8J
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:25:10 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BDMv3n003218;
 Tue, 11 Mar 2025 15:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2023-11-20; bh=WfzWR
 NUj4uKvBewqa75d0NazeWRlMLeWbgqDd6RFiTU=; b=I9fW9myL9dPYCiRcHJyY8
 7MuPVxfORQLEJxbg5fvb9/UplOl6XmW46fcP2hcb0t3OYoHZ1z6HKNTxssekktSH
 zNG73X1PwdAUSO7VNMDNih8RleUCuxqnmqttJhswpjSZ45J4ToFTCM5BMbNorLri
 INCicsTksoRh7Bbw6nduoy8/V6/NcYICFPndD3G3GHl/CdA72hSbFR1kdZKQdeYv
 xhL3gKlgsz2/735MCMv9q7MzzAde0OmLZqYzapq+ectQUF3fE0GKy68chRS0e/wq
 b5Vu9VyY7wl+3qMtJcNIQiu/7arPXnKBUmqckigdXu+P69npu3IFl38gT6Ibhndu
 A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458cg0w5pe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Mar 2025 15:25:01 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52BF3IIU019363; Tue, 11 Mar 2025 15:25:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 458cbfqns4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Mar 2025 15:25:00 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52BFMCsD035998;
 Tue, 11 Mar 2025 15:24:59 GMT
Received: from alaljime-e5-test-20240903-1847.osdevelopmeniad.oraclevcn.com
 (alaljime-e5-test-20240903-1847.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.250.206])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 458cbfqngj-7; Tue, 11 Mar 2025 15:24:59 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, mjt@tls.msk.ru,
 marcel.apfelbaum@gmail.com, vasant.hegde@amd.com,
 suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 sarunkod@amd.com, Wei.Huang2@amd.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [PATCH 6/6] amd_iommu: Do not assume passthrough translation for
 devices with DTE[TV]=0
Date: Tue, 11 Mar 2025 15:24:46 +0000
Message-ID: <20250311152446.45086-7-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250311152446.45086-1-alejandro.j.jimenez@oracle.com>
References: <20250311152446.45086-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_04,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503110096
X-Proofpoint-GUID: nB3M8_J5Z8Vjf-RHuXW1FwyMRBGmFYSR
X-Proofpoint-ORIG-GUID: nB3M8_J5Z8Vjf-RHuXW1FwyMRBGmFYSR
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

The AMD I/O Virtualization Technology (IOMMU) Specification (see Table 8: V,
TV, and GV Fields in Device Table Entry), specifies that a DTE with V=0,
TV=1 does not contain a valid address translation information.  If a request
requires a table walk, the walk is terminated when this condition is
encountered.

Do not assume that addresses for a device with DTE[TV]=0 are passed through
(i.e. not remapped) and instead terminate the page table walk early.

Cc: qemu-stable@nongnu.org
Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 88 +++++++++++++++++++++++++--------------------
 1 file changed, 49 insertions(+), 39 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index cf00450ebe..31d5522a62 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -932,51 +932,61 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
     uint64_t pte = dte[0], pte_addr, page_mask;
 
     /* make sure the DTE has TV = 1 */
-    if (pte & AMDVI_DEV_TRANSLATION_VALID) {
-        level = get_pte_translation_mode(pte);
-        if (level >= 7) {
-            trace_amdvi_mode_invalid(level, addr);
+    if (!(pte & AMDVI_DEV_TRANSLATION_VALID)) {
+        /*
+         * A DTE with V=1, TV=0 does not have a valid Page Table Root Pointer.
+         * An IOMMU processing a request that requires a table walk terminates
+         * the walk when it encounters this condition. Do the same and return
+         * instead of assuming that the address is forwarded without translation
+         * i.e. the passthrough case, as it is done for the case where DTE[V]=0.
+         */
+        return;
+    }
+
+    level = get_pte_translation_mode(pte);
+    if (level >= 7) {
+        trace_amdvi_mode_invalid(level, addr);
+        return;
+    }
+    if (level == 0) {
+        goto no_remap;
+    }
+
+    /* we are at the leaf page table or page table encodes a huge page */
+    do {
+        pte_perms = amdvi_get_perms(pte);
+        present = pte & 1;
+        if (!present || perms != (perms & pte_perms)) {
+            amdvi_page_fault(as->iommu_state, as->devfn, addr, perms);
+            trace_amdvi_page_fault(addr);
             return;
         }
-        if (level == 0) {
-            goto no_remap;
-        }
 
-        /* we are at the leaf page table or page table encodes a huge page */
-        do {
-            pte_perms = amdvi_get_perms(pte);
-            present = pte & 1;
-            if (!present || perms != (perms & pte_perms)) {
-                amdvi_page_fault(as->iommu_state, as->devfn, addr, perms);
-                trace_amdvi_page_fault(addr);
-                return;
-            }
-
-            /* go to the next lower level */
-            pte_addr = pte & AMDVI_DEV_PT_ROOT_MASK;
-            /* add offset and load pte */
-            pte_addr += ((addr >> (3 + 9 * level)) & 0x1FF) << 3;
-            pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
-            if (!pte) {
-                return;
-            }
-            oldlevel = level;
-            level = get_pte_translation_mode(pte);
-        } while (level > 0 && level < 7);
-
-        if (level == 0x7) {
-            page_mask = pte_override_page_mask(pte);
-        } else {
-            page_mask = pte_get_page_mask(oldlevel);
+        /* go to the next lower level */
+        pte_addr = pte & AMDVI_DEV_PT_ROOT_MASK;
+        /* add offset and load pte */
+        pte_addr += ((addr >> (3 + 9 * level)) & 0x1FF) << 3;
+        pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
+        if (!pte) {
+            return;
         }
+        oldlevel = level;
+        level = get_pte_translation_mode(pte);
+    } while (level > 0 && level < 7);
 
-        /* get access permissions from pte */
-        ret->iova = addr & page_mask;
-        ret->translated_addr = (pte & AMDVI_DEV_PT_ROOT_MASK) & page_mask;
-        ret->addr_mask = ~page_mask;
-        ret->perm = amdvi_get_perms(pte);
-        return;
+    if (level == 0x7) {
+        page_mask = pte_override_page_mask(pte);
+    } else {
+        page_mask = pte_get_page_mask(oldlevel);
     }
+
+    /* get access permissions from pte */
+    ret->iova = addr & page_mask;
+    ret->translated_addr = (pte & AMDVI_DEV_PT_ROOT_MASK) & page_mask;
+    ret->addr_mask = ~page_mask;
+    ret->perm = amdvi_get_perms(pte);
+    return;
+
 no_remap:
     ret->iova = addr & AMDVI_PAGE_MASK_4K;
     ret->translated_addr = addr & AMDVI_PAGE_MASK_4K;
-- 
2.43.5


