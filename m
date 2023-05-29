Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 329CF714926
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 14:13:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3biz-0006vs-8F; Mon, 29 May 2023 08:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q3biw-0006vP-7J
 for qemu-devel@nongnu.org; Mon, 29 May 2023 08:11:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q3biu-0003Ps-FX
 for qemu-devel@nongnu.org; Mon, 29 May 2023 08:11:41 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34T7TGrZ031492; Mon, 29 May 2023 12:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=1UAtNPKnpOQzqu8SkGp7lY1q+2CW6YybIezCRQzeQiw=;
 b=yakGilRutZtxhz8tlfpyqwqKpxpjC+ZZlu7sk844OySbDjjIdHB+S/tSd36pJ+lKuoXf
 pY4X2o9WTev1LUxcqHJbQw8q87OcqOw04Qh4DwiTz9mZMAxWAiM/G9LC5IPS/KoE+tUl
 oBAtaJzd3pgpzMWZQw6ZueE55QPsZfXwxTTNJ4ce3zlGztrlOBJ7TmChBefVQ+M+LBcz
 s89aOSFMWERUY+vjDvO1wFhuwrcec3MRaRngJySTU5iH8jFtkBObo0nyPcYATxPxAAh3
 4dUmKVYPW1UQzzkkbLIBiuX4gk4XKqRhW3Jna3Gbu48rvx7Ip12ep7EFpqKAelWwUwNj nA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhww8tp7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 May 2023 12:11:37 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34TAxLbm026022; Mon, 29 May 2023 12:11:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3qu8a92m9s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 May 2023 12:11:36 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34TCBVLS038099;
 Mon, 29 May 2023 12:11:36 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-183-111.vpn.oracle.com
 [10.175.183.111])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3qu8a92m66-3; Mon, 29 May 2023 12:11:35 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v3 2/2] hw/vfio: Add nr of dirty pages to
 vfio_get_dirty_bitmap tracepoint
Date: Mon, 29 May 2023 13:11:14 +0100
Message-Id: <20230529121114.5038-3-joao.m.martins@oracle.com>
In-Reply-To: <20230529121114.5038-1-joao.m.martins@oracle.com>
References: <20230529121114.5038-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-29_08,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=892 bulkscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305290105
X-Proofpoint-ORIG-GUID: -fKXX41wLISoIo4b25SZC_QzLp5qdf-S
X-Proofpoint-GUID: -fKXX41wLISoIo4b25SZC_QzLp5qdf-S
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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
index 78358ede2764..fa8fd949b1cf 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1747,6 +1747,7 @@ static int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
 {
     bool all_device_dirty_tracking =
         vfio_devices_all_device_dirty_tracking(container);
+    uint64_t dirty_pages;
     VFIOBitmap vbmap;
     int ret;
 
@@ -1772,11 +1773,11 @@ static int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
         goto out;
     }
 
-    cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
-                                           vbmap.pages);
+    dirty_pages = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
+                                                         vbmap.pages);
 
     trace_vfio_get_dirty_bitmap(container->fd, iova, size, vbmap.size,
-                                ram_addr);
+                                ram_addr, dirty_pages);
 out:
     g_free(vbmap.bitmap);
 
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 646e42fd27f9..cfb60c354de3 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -120,7 +120,7 @@ vfio_region_sparse_mmap_header(const char *name, int index, int nr_areas) "Devic
 vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end) "sparse entry %d [0x%lx - 0x%lx]"
 vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%08x"
 vfio_dma_unmap_overflow_workaround(void) ""
-vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start) "container fd=%d, iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64
+vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "container fd=%d, iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
 vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
 
 # platform.c
-- 
2.39.3


