Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A86CF73ABE6
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 23:53:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCSF9-0004GJ-5J; Thu, 22 Jun 2023 17:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qCSF7-0004G4-78
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 17:53:29 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qCSF5-0000qm-Bc
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 17:53:28 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35ML7LUS015246; Thu, 22 Jun 2023 21:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=CtbV7jP++Ydqd322B7U0VwYChw7FX8rCFSPVusynzhM=;
 b=lu5fCYSmmYZ67QHPxK5gPSHSRRzXk0VgZBgIfq2EE3LcHrvLdCbSMOoUg3wRR0jo9w2U
 Dv8o3MeFFmpwPKfd55cCqK0y09GkD8sXqzgk2T0cXnIkch0h3xlqUCn5APvj4j7DGxXq
 EIeFXmkv2tq6JzhJTDDHuDEefClMi2PlED5PccTaApLFj0HNjwj+1QfAwqFX6v2CeDug
 VH5M1rcH/dKOR5y7tB1T9sTUPBGQ8u7tNxg+hSwT4Xp6M9EQXQaN5d9iwrAdVvt9uNvp
 HP2ZypM5Zb1Rd77FWYWPx7Pr+b+7JmEJfgAR/wEjocJ2Z4EDnbRvZhZlweyYFkTY7lhx AA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r95cu2upj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jun 2023 21:53:20 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35MKvXxP008371; Thu, 22 Jun 2023 21:50:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r9398eq1v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jun 2023 21:50:08 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35MLn77C035791;
 Thu, 22 Jun 2023 21:50:08 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-180-251.vpn.oracle.com
 [10.175.180.251])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3r9398ep1g-13; Thu, 22 Jun 2023 21:50:08 +0000
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
Subject: [PATCH v4 12/15] vfio/common: Support device dirty page tracking with
 vIOMMU
Date: Thu, 22 Jun 2023 22:48:42 +0100
Message-Id: <20230622214845.3980-13-joao.m.martins@oracle.com>
In-Reply-To: <20230622214845.3980-1-joao.m.martins@oracle.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_16,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220186
X-Proofpoint-GUID: jKx3rXMJ6WCQrp1O3Cr69SLkXbIuH8rb
X-Proofpoint-ORIG-GUID: jKx3rXMJ6WCQrp1O3Cr69SLkXbIuH8rb
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
 include/hw/vfio/vfio-common.h |  1 +
 hw/vfio/common.c              | 58 +++++++++++++++++++++++++++++------
 hw/vfio/pci.c                 |  7 +++++
 3 files changed, 56 insertions(+), 10 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index f41860988d6b..c4bafad084b4 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -71,6 +71,7 @@ typedef struct VFIOMigration {
 typedef struct VFIOAddressSpace {
     AddressSpace *as;
     bool no_dma_translation;
+    hwaddr max_iova;
     QLIST_HEAD(, VFIOContainer) containers;
     QLIST_ENTRY(VFIOAddressSpace) list;
 } VFIOAddressSpace;
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index ecfb9afb3fb6..85fddef24026 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -428,6 +428,25 @@ static bool vfio_viommu_preset(void)
     return false;
 }
 
+static int vfio_viommu_get_max_iova(hwaddr *max_iova)
+{
+    VFIOAddressSpace *space;
+
+    *max_iova = 0;
+
+    QLIST_FOREACH(space, &vfio_address_spaces, list) {
+        if (space->as == &address_space_memory) {
+            continue;
+        }
+
+        if (*max_iova < space->max_iova) {
+            *max_iova = space->max_iova;
+        }
+    }
+
+    return *max_iova == 0;
+}
+
 int vfio_block_giommu_migration(Error **errp)
 {
     int ret;
@@ -1464,10 +1483,11 @@ static const MemoryListener vfio_dirty_tracking_listener = {
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
@@ -1475,17 +1495,29 @@ static void vfio_dirty_tracking_init(VFIOContainer *container,
     dirty.listener = vfio_dirty_tracking_listener;
     dirty.container = container;
 
-    memory_listener_register(&dirty.listener,
-                             container->space->as);
+    if (vfio_viommu_preset()) {
+        hwaddr iommu_max_iova;
+
+        ret = vfio_viommu_get_max_iova(&iommu_max_iova);
+        if (ret) {
+            return -EINVAL;
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
@@ -1590,7 +1622,13 @@ static int vfio_devices_dma_logging_start(VFIOContainer *container)
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
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 8a98e6ffc480..3bda5618c5b5 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2974,6 +2974,13 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
                               &dma_translation);
     space->no_dma_translation = !dma_translation;
 
+    /*
+     * Support for advertised IOMMU address space boundaries is optional.
+     * By default, it is not advertised i.e. space::max_iova is 0.
+     */
+    pci_device_iommu_get_attr(pdev, IOMMU_ATTR_MAX_IOVA,
+                              &space->max_iova);
+
     QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
         if (strcmp(vbasedev_iter->name, vbasedev->name) == 0) {
             error_setg(errp, "device is already attached");
-- 
2.17.2


