Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A700710B52
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 13:44:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q29Nw-00044l-IA; Thu, 25 May 2023 07:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q29Nk-00043l-A1
 for qemu-devel@nongnu.org; Thu, 25 May 2023 07:43:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q29Nh-0004Ck-Ir
 for qemu-devel@nongnu.org; Thu, 25 May 2023 07:43:47 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34PBfP1t032034; Thu, 25 May 2023 11:43:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=1InsrUBLtGmpfitOhqSpWKGQkmGugN7faWScOAV/SEk=;
 b=NErUDe5PDj5CDQbUVB0TBckBmYFX483H0bllGMc4vsJ0NALggg8tslbTr1JW4lV/KU1R
 YrisWxSCGi/6hbLeoheg+24PmCfhZ0NgakCiKKcgW7YHM5Yj5dz63M1drJ9PD2ewGW4I
 y3ABpWw06dAiWfeUed0UKRkyWjZcnsmJcWQNHDBI3VfVBNor8HAlmvDlgtbM6E9JZv8Z
 ZtrgabOdMahcp2qlXU9xDUuuzg+RhCMQwG5jdXAtsSSCBvrW3JN1uG8rqypIo3PJIDoo
 9a0oZia25zYQL0jrwTb5y206nInlRZa0r/T8r1T6Q2yLGDlIQKA4ujgbL+R/E4zvu6oD sg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qt712804s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 May 2023 11:43:41 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34PAdM04027127; Thu, 25 May 2023 11:43:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qqk2g84n3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 May 2023 11:43:40 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34PBe13H020951;
 Thu, 25 May 2023 11:43:39 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-196-224.vpn.oracle.com
 [10.175.196.224])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3qqk2g84e8-3; Thu, 25 May 2023 11:43:39 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v2 2/2] hw/vfio: Add nr of dirty pages to
 vfio_get_dirty_bitmap tracepoint
Date: Thu, 25 May 2023 12:43:21 +0100
Message-Id: <20230525114321.71066-3-joao.m.martins@oracle.com>
In-Reply-To: <20230525114321.71066-1-joao.m.martins@oracle.com>
References: <20230525114321.71066-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_06,2023-05-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=931 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305250098
X-Proofpoint-ORIG-GUID: ysXEunIU2e9OElK4HW1ImbV4yaD8TZHY
X-Proofpoint-GUID: ysXEunIU2e9OElK4HW1ImbV4yaD8TZHY
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Include the number of dirty pages on the vfio_get_dirty_bitmap tracepoint.
These are fetched from the newly added return value in
cpu_physical_memory_set_lebitmap().

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 hw/vfio/common.c     | 7 ++++---
 hw/vfio/trace-events | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 4d01ea351515..3c9af2fed1b1 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1747,6 +1747,7 @@ static int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
     bool all_device_dirty_tracking =
         vfio_devices_all_device_dirty_tracking(container);
     VFIOBitmap vbmap;
+    uint64_t dirty;
     int ret;
 
     if (!container->dirty_pages_supported && !all_device_dirty_tracking) {
@@ -1771,11 +1772,11 @@ static int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
         goto out;
     }
 
-    cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
-                                           vbmap.pages);
+    dirty = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
+                                                   vbmap.pages);
 
     trace_vfio_get_dirty_bitmap(container->fd, iova, size, vbmap.size,
-                                ram_addr);
+                                ram_addr, dirty);
 out:
     g_free(vbmap.bitmap);
 
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 646e42fd27f9..9265a406eda1 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -120,7 +120,7 @@ vfio_region_sparse_mmap_header(const char *name, int index, int nr_areas) "Devic
 vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end) "sparse entry %d [0x%lx - 0x%lx]"
 vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%08x"
 vfio_dma_unmap_overflow_workaround(void) ""
-vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start) "container fd=%d, iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64
+vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty) "container fd=%d, iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty=%"PRIu64
 vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
 
 # platform.c
-- 
2.31.1


