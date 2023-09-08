Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 249D3798323
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 09:16:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeVhe-0003s3-CE; Fri, 08 Sep 2023 03:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=UKRc=EY=redhat.com=clg@ozlabs.org>)
 id 1qeVhc-0003rk-Iu
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 03:14:52 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=UKRc=EY=redhat.com=clg@ozlabs.org>)
 id 1qeVhZ-00030d-M3
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 03:14:52 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RhnRm2qYFz4xFR;
 Fri,  8 Sep 2023 17:14:44 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RhnRk1l5Xz4x5l;
 Fri,  8 Sep 2023 17:14:41 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC PATCH] vfio/common: Separate vfio-pci ranges
Date: Fri,  8 Sep 2023 09:14:38 +0200
Message-ID: <20230908071438.86136-1-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=UKRc=EY=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Joao Martins <joao.m.martins@oracle.com>

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
 hw/vfio/common.c     | 51 +++++++++++++++++++++++++++++++++++++++-----
 hw/vfio/trace-events |  2 +-
 2 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 237101d03844273f653d98b6d053a1ae9c05a247..a5548e3bebf999e6d9cef08bdaf1fbc3b437e5eb 100644
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
+    hwaddr minpci;
+    hwaddr maxpci;
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
@@ -1434,9 +1462,14 @@ static void vfio_dirty_tracking_update(MemoryListener *listener,
      * would be an IOVATree but that has a much bigger runtime overhead and
      * unnecessary complexity.
      */
-    min = (end <= UINT32_MAX) ? &range->min32 : &range->min64;
-    max = (end <= UINT32_MAX) ? &range->max32 : &range->max64;
-
+    if (vfio_section_is_vfio_pci(section, dirty->container) &&
+        iova >= UINT32_MAX) {
+        min = &range->minpci;
+        max = &range->maxpci;
+    } else {
+        min = (end <= UINT32_MAX) ? &range->min32 : &range->min64;
+        max = (end <= UINT32_MAX) ? &range->max32 : &range->max64;
+    }
     if (*min > iova) {
         *min = iova;
     }
@@ -1461,6 +1494,7 @@ static void vfio_dirty_tracking_init(VFIOContainer *container,
     memset(&dirty, 0, sizeof(dirty));
     dirty.ranges.min32 = UINT32_MAX;
     dirty.ranges.min64 = UINT64_MAX;
+    dirty.ranges.minpci = UINT64_MAX;
     dirty.listener = vfio_dirty_tracking_listener;
     dirty.container = container;
 
@@ -1531,7 +1565,8 @@ vfio_device_feature_dma_logging_start_create(VFIOContainer *container,
      * DMA logging uAPI guarantees to support at least a number of ranges that
      * fits into a single host kernel base page.
      */
-    control->num_ranges = !!tracking->max32 + !!tracking->max64;
+    control->num_ranges = !!tracking->max32 + !!tracking->max64 +
+        !!tracking->maxpci;
     ranges = g_try_new0(struct vfio_device_feature_dma_logging_range,
                         control->num_ranges);
     if (!ranges) {
@@ -1550,11 +1585,17 @@ vfio_device_feature_dma_logging_start_create(VFIOContainer *container,
     if (tracking->max64) {
         ranges->iova = tracking->min64;
         ranges->length = (tracking->max64 - tracking->min64) + 1;
+        ranges++;
+    }
+    if (tracking->maxpci) {
+        ranges->iova = tracking->minpci;
+        ranges->length = (tracking->maxpci - tracking->minpci) + 1;
     }
 
     trace_vfio_device_dirty_tracking_start(control->num_ranges,
                                            tracking->min32, tracking->max32,
-                                           tracking->min64, tracking->max64);
+                                           tracking->min64, tracking->max64,
+                                           tracking->minpci, tracking->maxpci);
 
     return feature;
 }
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index ce61b10827b6a1203a5fe1a87a76d96f25c11345..ab52c6bb7f0c11e51fefef231c108d0c9381547e 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -104,7 +104,7 @@ vfio_known_safe_misalignment(const char *name, uint64_t iova, uint64_t offset_wi
 vfio_listener_region_add_no_dma_map(const char *name, uint64_t iova, uint64_t size, uint64_t page_size) "Region \"%s\" 0x%"PRIx64" size=0x%"PRIx64" is not aligned to 0x%"PRIx64" and cannot be mapped for DMA"
 vfio_listener_region_del(uint64_t start, uint64_t end) "region_del 0x%"PRIx64" - 0x%"PRIx64
 vfio_device_dirty_tracking_update(uint64_t start, uint64_t end, uint64_t min, uint64_t max) "section 0x%"PRIx64" - 0x%"PRIx64" -> update [0x%"PRIx64" - 0x%"PRIx64"]"
-vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t max32, uint64_t min64, uint64_t max64) "nr_ranges %d 32:[0x%"PRIx64" - 0x%"PRIx64"], 64:[0x%"PRIx64" - 0x%"PRIx64"]"
+vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t max32, uint64_t min64, uint64_t max64, uint64_t minpci, uint64_t maxpci) "nr_ranges %d 32:[0x%"PRIx64" - 0x%"PRIx64"], 64:[0x%"PRIx64" - 0x%"PRIx64"], pci:[0x%"PRIx64" - 0x%"PRIx64"]"
 vfio_disconnect_container(int fd) "close container->fd=%d"
 vfio_put_group(int fd) "close group->fd=%d"
 vfio_get_device(const char * name, unsigned int flags, unsigned int num_regions, unsigned int num_irqs) "Device %s flags: %u, regions: %u, irqs: %u"
-- 
2.41.0


