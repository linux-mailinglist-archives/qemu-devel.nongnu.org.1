Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 766F9716BD9
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 20:03:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q43f9-0003Na-Au; Tue, 30 May 2023 14:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q43ei-0002Wp-8T
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:01:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q43ed-0002mK-Tp
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:01:09 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34UE4juV021715; Tue, 30 May 2023 18:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=MCVvu0ZT0Efg7fIZpsFsdi88Rn/1HAZ8J63Xek+QgJQ=;
 b=YLc34s/Hj/5FoIkBXtvRFBiDlaHX+k0rUtClfJ7UExCn5RJZHr+/7NcJNESo+z8pmnN1
 7I9APSbwztGWA8/lHEykoNYbfFizMd90nXRPhHc3zsQPhaK1eQ4yHrZ5P1WcrDkdcJrH
 UgjwHQGPTg+0RL2wLId9u1V+ObjObGuSWbAtU6WZ2u4XsKEe2jDzONTz41urG2II3qIL
 DWWFSPFFVQcDpcmEG1iXdXMcAe0W6gM+PuowdcZHT4sVQQVw7Ea8EeR8scvAT77+fFeB
 GGCBujhFjK7HYeJFGH3AuCnWWckb7JOxDJ1TQ8DXv+KMI9Vz7dgGHWJ/nrwDoW2fugfA tA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhjh3emy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 18:01:04 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34UGjDqD014692; Tue, 30 May 2023 18:01:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qu8a48vjw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 18:01:03 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UHxspd011459;
 Tue, 30 May 2023 18:01:02 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-191-61.vpn.oracle.com
 [10.175.191.61])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3qu8a48srr-15; Tue, 30 May 2023 18:01:02 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Avihai Horon <avihaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v3 14/15] vfio/common: Optimize device dirty page tracking
 with vIOMMU
Date: Tue, 30 May 2023 18:59:36 +0100
Message-Id: <20230530175937.24202-15-joao.m.martins@oracle.com>
In-Reply-To: <20230530175937.24202-1-joao.m.martins@oracle.com>
References: <20230530175937.24202-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_13,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=780 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305300144
X-Proofpoint-GUID: Gz7CqUk9Nrwm2XtUVwL2CgX4RiPxpcBb
X-Proofpoint-ORIG-GUID: Gz7CqUk9Nrwm2XtUVwL2CgX4RiPxpcBb
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

From: Avihai Horon <avihaih@nvidia.com>

When vIOMMU is enabled, syncing dirty page bitmaps is done by replaying
the vIOMMU mappings and querying the dirty bitmap for each mapping.

With device dirty tracking this causes a lot of overhead, since the HW
is queried many times (even with small idle guest this can end up with
thousands of calls to HW).

Optimize this by de-coupling dirty bitmap query from vIOMMU replay.
Now a single dirty bitmap is queried per vIOMMU MR section, which is
then used for all corresponding vIOMMU mappings within that MR section.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 hw/vfio/common.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 733f0bd7825f..5b211380306a 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1857,8 +1857,36 @@ out:
 typedef struct {
     IOMMUNotifier n;
     VFIOGuestIOMMU *giommu;
+    VFIOBitmap vbmap;
 } vfio_giommu_dirty_notifier;
 
+static int vfio_iommu_set_dirty_bitmap(VFIOContainer *container,
+                                       vfio_giommu_dirty_notifier *gdn,
+                                       hwaddr iova, hwaddr size,
+                                       ram_addr_t ram_addr)
+{
+    VFIOBitmap *vbmap = &gdn->vbmap;
+    VFIOBitmap dst_vbmap;
+    hwaddr start_iova = REAL_HOST_PAGE_ALIGN(gdn->n.start);
+    hwaddr copy_offset;
+    int ret;
+
+    ret = vfio_bitmap_alloc(&dst_vbmap, size);
+    if (ret) {
+        return -ENOMEM;
+    }
+
+    copy_offset = (iova - start_iova) / qemu_real_host_page_size();
+    bitmap_copy_with_src_offset(dst_vbmap.bitmap, vbmap->bitmap, copy_offset,
+                                dst_vbmap.pages);
+
+    cpu_physical_memory_set_dirty_lebitmap(dst_vbmap.bitmap, ram_addr,
+                                           dst_vbmap.pages);
+    g_free(dst_vbmap.bitmap);
+
+    return 0;
+}
+
 static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
 {
     vfio_giommu_dirty_notifier *gdn = container_of(n,
@@ -1879,8 +1907,15 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
 
     rcu_read_lock();
     if (vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL)) {
-        ret = vfio_get_dirty_bitmap(container, iova, iotlb->addr_mask + 1,
-                                    translated_addr);
+        if (gdn->vbmap.bitmap) {
+            ret = vfio_iommu_set_dirty_bitmap(container, gdn, iova,
+                                              iotlb->addr_mask + 1,
+                                              translated_addr);
+        } else {
+            ret = vfio_get_dirty_bitmap(container, iova, iotlb->addr_mask + 1,
+                                        translated_addr);
+        }
+
         if (ret) {
             error_report("vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx") = %d (%s)",
@@ -1961,6 +1996,7 @@ static int vfio_sync_iommu_dirty_bitmap(VFIOContainer *container,
     }
 
     gdn.giommu = giommu;
+    gdn.vbmap.bitmap = NULL;
     idx = memory_region_iommu_attrs_to_index(giommu->iommu_mr,
                                              MEMTXATTRS_UNSPECIFIED);
 
@@ -1968,10 +2004,44 @@ static int vfio_sync_iommu_dirty_bitmap(VFIOContainer *container,
                        section->size);
     llend = int128_sub(llend, int128_one());
 
+    /*
+     * Optimize device dirty tracking if the MR section is at least partially
+     * tracked. Optimization is done by querying a single dirty bitmap for the
+     * entire range instead of querying dirty bitmap for each vIOMMU mapping.
+     */
+    if (vfio_devices_all_device_dirty_tracking(container)) {
+        hwaddr start = REAL_HOST_PAGE_ALIGN(section->offset_within_region);
+        hwaddr end = int128_get64(llend);
+        hwaddr iommu_max_iova;
+        hwaddr size;
+        int ret;
+
+        ret = vfio_viommu_get_max_iova(&iommu_max_iova);
+        if (ret) {
+            return -EINVAL;
+        }
+
+        size = REAL_HOST_PAGE_ALIGN(MIN(iommu_max_iova, end) - start);
+
+        ret = vfio_bitmap_alloc(&gdn.vbmap, size);
+        if (ret) {
+            return -ENOMEM;
+        }
+
+        ret = vfio_devices_query_dirty_bitmap(container, &gdn.vbmap,
+                                              start, size);
+        if (ret) {
+            g_free(gdn.vbmap.bitmap);
+
+            return ret;
+        }
+    }
+
     iommu_notifier_init(&gdn.n, vfio_iommu_map_dirty_notify, IOMMU_NOTIFIER_MAP,
                         section->offset_within_region, int128_get64(llend),
                         idx);
     memory_region_iommu_replay(giommu->iommu_mr, &gdn.n);
+    g_free(gdn.vbmap.bitmap);
 
     return 0;
 }
-- 
2.39.3


