Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5F57984D3
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 11:31:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeXoh-0000sT-W7; Fri, 08 Sep 2023 05:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qeXoY-0000rw-Rm
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 05:30:12 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qeXoU-00064Q-Nv
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 05:30:10 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3888t1Ub030085; Fri, 8 Sep 2023 09:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=UvyDNuLc0858mdnpR43dQdLfoePgqp20LHToyyaDedA=;
 b=j0n7yjIOGXpduz3xwGA0pF04tDeMGM/ffD73W0dIN/X6pQn4+sjXJc7BpowQOZWIa8ae
 zRMvFcF8D6CcfnEHrrqXKQGwTKxPO6MjmLLNgvZ1kosp0uovJBQJVDixzwz5F2TtgNWf
 PjK0hC6ZuzrjBeEL0/k1nrJJ98p+6ebkoOYUx57oV32///ERDNwkyqvZiV0i/arpXSDy
 kMz9PIak99bjxh8OzVY+zVbJ36RBzx+fGLt9Z728hNsOwpERZilG3zj0UN/BEXVMMT0v
 w+gpVlA9jGnStPCZCD3mecStNIdvNAgqn7Rc6UidAJIKP9wBprxCDKEdjzF89AF+0He6 GQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t00h0g23m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Sep 2023 09:30:04 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3888DYQc017647; Fri, 8 Sep 2023 09:30:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3suug9dr1c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Sep 2023 09:30:03 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3889U3Rv022099;
 Fri, 8 Sep 2023 09:30:03 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-173-55.vpn.oracle.com
 [10.175.173.55])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3suug9dqxs-1; Fri, 08 Sep 2023 09:30:03 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v1] vfio/common: Separate vfio-pci ranges
Date: Fri,  8 Sep 2023 10:29:44 +0100
Message-Id: <20230908092944.47589-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309080087
X-Proofpoint-GUID: VS57iednRbrmHXNNtGbE_OtDU0w_xpZN
X-Proofpoint-ORIG-GUID: VS57iednRbrmHXNNtGbE_OtDU0w_xpZN
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

QEMU computes the DMA logging ranges for two predefined ranges: 32-bit
and 64-bit. In the OVMF case, when the dynamic MMIO window is enabled,
QEMU includes in the 64-bit range the RAM regions at the lower part
and vfio-pci device RAM regions which are at the top of the address
space. This range contains a large gap and the size can be bigger than
the dirty tracking HW limits of some devices (MLX5 has a 2^42 limit).

To avoid such large ranges, introduce a new PCI range covering the
vfio-pci device RAM regions, this only if the addresses are above 4GB
to avoid breaking potential SeaBIOS guests.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
[ clg: - wrote commit log
       - fixed overlapping 32-bit and PCI ranges when using SeaBIOS ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
v2:
* s/minpci/minpci64/
* s/maxpci/maxpci64/
* Expand comment to cover the pci-hole64 and why we don't do special
  handling of pci-hole32.
---
 hw/vfio/common.c     | 71 +++++++++++++++++++++++++++++++++++++-------
 hw/vfio/trace-events |  2 +-
 2 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 237101d03844..134649226d43 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -27,6 +27,7 @@
 
 #include "hw/vfio/vfio-common.h"
 #include "hw/vfio/vfio.h"
+#include "hw/vfio/pci.h"
 #include "exec/address-spaces.h"
 #include "exec/memory.h"
 #include "exec/ram_addr.h"
@@ -1400,6 +1401,8 @@ typedef struct VFIODirtyRanges {
     hwaddr max32;
     hwaddr min64;
     hwaddr max64;
+    hwaddr minpci64;
+    hwaddr maxpci64;
 } VFIODirtyRanges;
 
 typedef struct VFIODirtyRangesListener {
@@ -1408,6 +1411,31 @@ typedef struct VFIODirtyRangesListener {
     MemoryListener listener;
 } VFIODirtyRangesListener;
 
+static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
+                                     VFIOContainer *container)
+{
+    VFIOPCIDevice *pcidev;
+    VFIODevice *vbasedev;
+    VFIOGroup *group;
+    Object *owner;
+
+    owner = memory_region_owner(section->mr);
+
+    QLIST_FOREACH(group, &container->group_list, container_next) {
+        QLIST_FOREACH(vbasedev, &group->device_list, next) {
+            if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
+                continue;
+            }
+            pcidev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
+            if (OBJECT(pcidev) == owner) {
+                return true;
+            }
+        }
+    }
+
+    return false;
+}
+
 static void vfio_dirty_tracking_update(MemoryListener *listener,
                                        MemoryRegionSection *section)
 {
@@ -1424,19 +1452,32 @@ static void vfio_dirty_tracking_update(MemoryListener *listener,
     }
 
     /*
-     * The address space passed to the dirty tracker is reduced to two ranges:
-     * one for 32-bit DMA ranges, and another one for 64-bit DMA ranges.
+     * The address space passed to the dirty tracker is reduced to three ranges:
+     * one for 32-bit DMA ranges, one for 64-bit DMA ranges and one for the
+     * PCI 64-bit hole.
+     *
      * The underlying reports of dirty will query a sub-interval of each of
      * these ranges.
      *
-     * The purpose of the dual range handling is to handle known cases of big
-     * holes in the address space, like the x86 AMD 1T hole. The alternative
-     * would be an IOVATree but that has a much bigger runtime overhead and
-     * unnecessary complexity.
+     * The purpose of the three range handling is to handle known cases of big
+     * holes in the address space, like the x86 AMD 1T hole, and firmware (like
+     * OVMF) which may relocate the pci-hole64 to the end of the address space.
+     * The latter would otherwise generate large ranges for tracking, stressing
+     * the limits of supported hardware. The pci-hole32 will always be below 4G
+     * (overlapping or not) so it doesn't need special handling and is part of
+     * the 32-bit range.
+     *
+     * The alternative would be an IOVATree but that has a much bigger runtime
+     * overhead and unnecessary complexity.
      */
-    min = (end <= UINT32_MAX) ? &range->min32 : &range->min64;
-    max = (end <= UINT32_MAX) ? &range->max32 : &range->max64;
-
+    if (vfio_section_is_vfio_pci(section, dirty->container) &&
+        iova >= UINT32_MAX) {
+        min = &range->minpci64;
+        max = &range->maxpci64;
+    } else {
+        min = (end <= UINT32_MAX) ? &range->min32 : &range->min64;
+        max = (end <= UINT32_MAX) ? &range->max32 : &range->max64;
+    }
     if (*min > iova) {
         *min = iova;
     }
@@ -1461,6 +1502,7 @@ static void vfio_dirty_tracking_init(VFIOContainer *container,
     memset(&dirty, 0, sizeof(dirty));
     dirty.ranges.min32 = UINT32_MAX;
     dirty.ranges.min64 = UINT64_MAX;
+    dirty.ranges.minpci64 = UINT64_MAX;
     dirty.listener = vfio_dirty_tracking_listener;
     dirty.container = container;
 
@@ -1531,7 +1573,8 @@ vfio_device_feature_dma_logging_start_create(VFIOContainer *container,
      * DMA logging uAPI guarantees to support at least a number of ranges that
      * fits into a single host kernel base page.
      */
-    control->num_ranges = !!tracking->max32 + !!tracking->max64;
+    control->num_ranges = !!tracking->max32 + !!tracking->max64 +
+        !!tracking->maxpci64;
     ranges = g_try_new0(struct vfio_device_feature_dma_logging_range,
                         control->num_ranges);
     if (!ranges) {
@@ -1550,11 +1593,17 @@ vfio_device_feature_dma_logging_start_create(VFIOContainer *container,
     if (tracking->max64) {
         ranges->iova = tracking->min64;
         ranges->length = (tracking->max64 - tracking->min64) + 1;
+        ranges++;
+    }
+    if (tracking->maxpci64) {
+        ranges->iova = tracking->minpci64;
+        ranges->length = (tracking->maxpci64 - tracking->minpci64) + 1;
     }
 
     trace_vfio_device_dirty_tracking_start(control->num_ranges,
                                            tracking->min32, tracking->max32,
-                                           tracking->min64, tracking->max64);
+                                           tracking->min64, tracking->max64,
+                                           tracking->minpci64, tracking->maxpci64);
 
     return feature;
 }
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index ce61b10827b6..cc7c21365c92 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -104,7 +104,7 @@ vfio_known_safe_misalignment(const char *name, uint64_t iova, uint64_t offset_wi
 vfio_listener_region_add_no_dma_map(const char *name, uint64_t iova, uint64_t size, uint64_t page_size) "Region \"%s\" 0x%"PRIx64" size=0x%"PRIx64" is not aligned to 0x%"PRIx64" and cannot be mapped for DMA"
 vfio_listener_region_del(uint64_t start, uint64_t end) "region_del 0x%"PRIx64" - 0x%"PRIx64
 vfio_device_dirty_tracking_update(uint64_t start, uint64_t end, uint64_t min, uint64_t max) "section 0x%"PRIx64" - 0x%"PRIx64" -> update [0x%"PRIx64" - 0x%"PRIx64"]"
-vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t max32, uint64_t min64, uint64_t max64) "nr_ranges %d 32:[0x%"PRIx64" - 0x%"PRIx64"], 64:[0x%"PRIx64" - 0x%"PRIx64"]"
+vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t max32, uint64_t min64, uint64_t max64, uint64_t minpci, uint64_t maxpci) "nr_ranges %d 32:[0x%"PRIx64" - 0x%"PRIx64"], 64:[0x%"PRIx64" - 0x%"PRIx64"], pci64:[0x%"PRIx64" - 0x%"PRIx64"]"
 vfio_disconnect_container(int fd) "close container->fd=%d"
 vfio_put_group(int fd) "close group->fd=%d"
 vfio_get_device(const char * name, unsigned int flags, unsigned int num_regions, unsigned int num_irqs) "Device %s flags: %u, regions: %u, irqs: %u"
-- 
2.39.3


