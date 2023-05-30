Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF39716BCA
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 20:01:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q43ef-00026e-2G; Tue, 30 May 2023 14:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q43eU-0001vs-JG
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:00:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q43eS-0002jh-4K
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:00:58 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34UE54jf020902; Tue, 30 May 2023 18:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=hHvviXGKXz7/JvAkgQz3l7QwnqzLJhzckRGwXC/3Pmg=;
 b=YzOkA8/I0hn/bNMv1kb/UMi7g1Jf/+Q/FsQEgqXgGI2qupz9AKeg3WyApkg3dSrv6O/x
 9NrWPhnRAEQb65LovxLXYm+Ie6xGnm4Yb/44urH13+x6mSJ1rNj0fCp65av5laWTcIX+
 5W83vpepuPB4J3/HnP9LygoGJVCq0yVUqoIalCDHWsTWym84ckAmClFCbpUt1KjetPjX
 8NzPYzoM2dQ2DmlZr7LirvjJ2QSwS3jdqP3tz8PYPs4pit/JklXuxJmyBdup4ZAWVwYX
 VcvsmcIZIYrC+WEA6eXFGc4aqT1E4MXc85ln3UPEd1sDd4u6B0MZsNBS9wqu4IBiG5rL dw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhb93gfv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 18:00:51 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34UHfg5K014618; Tue, 30 May 2023 18:00:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qu8a48v34-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 18:00:50 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UHxspZ011459;
 Tue, 30 May 2023 18:00:50 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-191-61.vpn.oracle.com
 [10.175.191.61])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3qu8a48srr-13; Tue, 30 May 2023 18:00:49 +0000
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
Subject: [PATCH v3 12/15] vfio/common: Support device dirty page tracking with
 vIOMMU
Date: Tue, 30 May 2023 18:59:34 +0100
Message-Id: <20230530175937.24202-13-joao.m.martins@oracle.com>
In-Reply-To: <20230530175937.24202-1-joao.m.martins@oracle.com>
References: <20230530175937.24202-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_13,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305300144
X-Proofpoint-GUID: gvG2qt7Ghnse6XfhqvrkWZ4taSyibWv2
X-Proofpoint-ORIG-GUID: gvG2qt7Ghnse6XfhqvrkWZ4taSyibWv2
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

Currently, device dirty page tracking with vIOMMU is not supported,
and a blocker is added and the migration is prevented.

When vIOMMU is used, IOVA ranges are DMA mapped/unmapped on the fly as
requesting by the vIOMMU. These IOVA ranges can potentially be mapped
anywhere in the vIOMMU IOVA space as advertised by the VMM.

To support device dirty tracking when vIOMMU enabled instead create the
dirty ranges based on the vIOMMU provided limits, which leads to the
tracking of the whole IOVA space regardless of what devices use.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 hw/vfio/common.c | 64 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 10 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index b8d97577f856..d2897aceedae 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -447,6 +447,31 @@ static bool vfio_viommu_preset(void)
     return false;
 }
 
+static int vfio_viommu_get_max_iova(hwaddr *max_iova)
+{
+    VFIOAddressSpace *space;
+    int ret = -EINVAL;
+
+    QLIST_FOREACH(space, &vfio_address_spaces, list) {
+        if (space->as == &address_space_memory) {
+            continue;
+        }
+
+        if (!space->iommu_mr) {
+            break;
+        }
+
+        ret = memory_region_iommu_get_attr(space->iommu_mr,
+                                           IOMMU_ATTR_MAX_IOVA,
+                                           max_iova);
+        if (ret) {
+            break;
+        }
+    }
+
+    return ret;
+}
+
 int vfio_block_giommu_migration(Error **errp)
 {
     int ret;
@@ -1483,10 +1508,11 @@ static const MemoryListener vfio_dirty_tracking_listener = {
     .region_add = vfio_listener_dirty_tracking_update,
 };
 
-static void vfio_dirty_tracking_init(VFIOContainer *container,
+static int vfio_dirty_tracking_init(VFIOContainer *container,
                                      VFIODirtyRanges *ranges)
 {
     VFIODirtyRangesListener dirty;
+    int ret;
 
     memset(&dirty, 0, sizeof(dirty));
     dirty.ranges.min32 = UINT32_MAX;
@@ -1494,17 +1520,29 @@ static void vfio_dirty_tracking_init(VFIOContainer *container,
     dirty.listener = vfio_dirty_tracking_listener;
     dirty.container = container;
 
-    memory_listener_register(&dirty.listener,
-                             container->space->as);
+    if (vfio_viommu_preset()) {
+        hwaddr iommu_max_iova;
+
+        ret = vfio_viommu_get_max_iova(&iommu_max_iova);
+        if (ret) {
+            return ret;
+        }
+
+        vfio_dirty_tracking_update(0, iommu_max_iova, &dirty.ranges);
+    } else {
+        memory_listener_register(&dirty.listener,
+                                 container->space->as);
+        /*
+         * The memory listener is synchronous, and used to calculate the range
+         * to dirty tracking. Unregister it after we are done as we are not
+         * interested in any follow-up updates.
+         */
+        memory_listener_unregister(&dirty.listener);
+    }
 
     *ranges = dirty.ranges;
 
-    /*
-     * The memory listener is synchronous, and used to calculate the range
-     * to dirty tracking. Unregister it after we are done as we are not
-     * interested in any follow-up updates.
-     */
-    memory_listener_unregister(&dirty.listener);
+    return 0;
 }
 
 static void vfio_devices_dma_logging_stop(VFIOContainer *container)
@@ -1609,7 +1647,13 @@ static int vfio_devices_dma_logging_start(VFIOContainer *container)
     VFIOGroup *group;
     int ret = 0;
 
-    vfio_dirty_tracking_init(container, &ranges);
+    ret = vfio_dirty_tracking_init(container, &ranges);
+    if (ret) {
+        error_report("Failed to init DMA logging ranges, err %d",
+                      ret);
+        return -EOPNOTSUPP;
+    }
+
     feature = vfio_device_feature_dma_logging_start_create(container,
                                                            &ranges);
     if (!feature) {
-- 
2.39.3


