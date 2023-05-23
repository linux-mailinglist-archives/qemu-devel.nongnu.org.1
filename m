Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B10D70E07D
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 17:31:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Th3-0007ZO-U6; Tue, 23 May 2023 11:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q1Tgm-0007XH-R6
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:12:40 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q1Tgk-0005tX-VG
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:12:40 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34NEnUIn011350; Tue, 23 May 2023 15:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=owV5hrEXNC1/eRmbY68FvG0YCROrtQcGY6zhPdxwk0U=;
 b=V8LtyDJnWqOY8ZDvK+lBGbNyUJuNsKskv/P0mb70p8wADrtek0fSc6yWzClcxGJWoMjt
 9Cl88lzPYnCVBac9OpdmQCExrocvLu2GFbbEIwCcNDZWSsN5PQpLFRh0DcfUS2mDXnrk
 yYr6qqu3i03U/floYrvbRQcein4n3YhyEey+DRX28aLLJ/NxXOQG4aOB4EAd0kNKv3/p
 NAC3MM3rh22dfVwYmSMCwW/L0OGEcMLGs9IJe+kIe2xImUFCw0viSXMUxaCbRXfzaLzB
 atDvDxO783hwEcKPTilB2OegQ6FFUNLUdCIed3RTdGoMTeHNwolPPgStM22BKY0notst Cg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp5bncjc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 May 2023 15:12:35 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34NEcYrs028906; Tue, 23 May 2023 15:12:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qqk2aymr0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 May 2023 15:12:35 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34NFA185023564;
 Tue, 23 May 2023 15:12:34 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-217-116.vpn.oracle.com
 [10.175.217.116])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3qqk2aymhr-2; Tue, 23 May 2023 15:12:34 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v1 1/2] exec/ram_addr: add dirty arg to
 cpu_physical_memory_set_dirty_lebitmap()
Date: Tue, 23 May 2023 16:12:16 +0100
Message-Id: <20230523151217.46427-2-joao.m.martins@oracle.com>
In-Reply-To: <20230523151217.46427-1-joao.m.martins@oracle.com>
References: <20230523151217.46427-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_10,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0
 mlxlogscore=863 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230119
X-Proofpoint-GUID: 7MxdI77ctrmNuA7hCYJNRKinaqxKXLNC
X-Proofpoint-ORIG-GUID: 7MxdI77ctrmNuA7hCYJNRKinaqxKXLNC
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

In preparation to including the number of dirty pages in the
vfio_get_dirty_bitmap() tracepoint, return the number of dirty pages in the
range passed by @dirty argument in cpu_physical_memory_set_dirty_lebitmap().

For now just set the callers to NULL, no functional change intended.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 accel/kvm/kvm-all.c     |  2 +-
 hw/vfio/common.c        |  4 ++--
 include/exec/ram_addr.h | 10 +++++++++-
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index cf3a88d90e92..1524a34f1786 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -559,7 +559,7 @@ static void kvm_slot_sync_dirty_pages(KVMSlot *slot)
     ram_addr_t start = slot->ram_start_offset;
     ram_addr_t pages = slot->memory_size / qemu_real_host_page_size();
 
-    cpu_physical_memory_set_dirty_lebitmap(slot->dirty_bmap, start, pages);
+    cpu_physical_memory_set_dirty_lebitmap(slot->dirty_bmap, start, pages, NULL);
 }
 
 static void kvm_slot_reset_dirty_pages(KVMSlot *slot)
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 78358ede2764..dcbf7c574d85 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -587,7 +587,7 @@ static int vfio_dma_unmap_bitmap(VFIOContainer *container,
     ret = ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, unmap);
     if (!ret) {
         cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap,
-                iotlb->translated_addr, vbmap.pages);
+                iotlb->translated_addr, vbmap.pages, NULL);
     } else {
         error_report("VFIO_UNMAP_DMA with DIRTY_BITMAP : %m");
     }
@@ -1773,7 +1773,7 @@ static int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
     }
 
     cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
-                                           vbmap.pages);
+                                           vbmap.pages, NULL);
 
     trace_vfio_get_dirty_bitmap(container->fd, iova, size, vbmap.size,
                                 ram_addr);
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index f4fb6a211175..07bf9e1502b6 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -335,7 +335,8 @@ static inline void cpu_physical_memory_set_dirty_range(ram_addr_t start,
 #if !defined(_WIN32)
 static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
                                                           ram_addr_t start,
-                                                          ram_addr_t pages)
+                                                          ram_addr_t pages,
+                                                          unsigned long *dirty)
 {
     unsigned long i, j;
     unsigned long page_number, c;
@@ -380,6 +381,10 @@ static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
                         }
                     }
 
+                    if (dirty) {
+                        *dirty += ctpopl(temp);
+                    }
+
                     if (tcg_enabled()) {
                         qatomic_or(&blocks[DIRTY_MEMORY_CODE][idx][offset],
                                    temp);
@@ -411,6 +416,9 @@ static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
                 if (unlikely(global_dirty_tracking & GLOBAL_DIRTY_DIRTY_RATE)) {
                     total_dirty_pages += ctpopl(c);
                 }
+                if (dirty) {
+                    *dirty += ctpopl(c);
+                }
                 do {
                     j = ctzl(c);
                     c &= ~(1ul << j);
-- 
2.31.1


