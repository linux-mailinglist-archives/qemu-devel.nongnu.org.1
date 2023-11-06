Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BD47E2783
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:48:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00jN-0004lg-P4; Mon, 06 Nov 2023 09:37:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org>)
 id 1r00jG-0004C4-V3
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:37:27 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org>)
 id 1r00jB-0000sm-Pz
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:37:26 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SPDTC3PdGz4xkK;
 Tue,  7 Nov 2023 01:37:19 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SPDT91xnYz4xkG;
 Tue,  7 Nov 2023 01:37:16 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Yanghang Liu <yanghliu@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 07/22] virtio-iommu: Introduce per IOMMUDevice reserved regions
Date: Mon,  6 Nov 2023 15:36:38 +0100
Message-ID: <20231106143653.302391-8-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106143653.302391-1-clg@redhat.com>
References: <20231106143653.302391-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

From: Eric Auger <eric.auger@redhat.com>

For the time being the per device reserved regions are
just a duplicate of IOMMU wide reserved regions. Subsequent
patches will combine those with host reserved regions, if any.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Yanghang Liu <yanghliu@redhat.com>
Reviewed-by: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/virtio/virtio-iommu.h |  1 +
 hw/virtio/virtio-iommu.c         | 37 +++++++++++++++++++++++++-------
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
index eea4564782215dac7205557c241e5ce2d7e40713..70b8ace34dfb7f24ff6cf41a21ecd283ca9ee512 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -39,6 +39,7 @@ typedef struct IOMMUDevice {
     AddressSpace  as;
     MemoryRegion root;          /* The root container of the device */
     MemoryRegion bypass_mr;     /* The alias of shared memory MR */
+    GList *resv_regions;
 } IOMMUDevice;
 
 typedef struct IOMMUPciBus {
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 979cdb56483c7de5d79a7a3f4c1fe996fc261c64..0e2370663d348e60678343dabd1f943792051315 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -26,6 +26,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
+#include "qemu/reserved-region.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "trace.h"
@@ -378,6 +379,19 @@ static void virtio_iommu_put_domain(gpointer data)
     g_free(domain);
 }
 
+static void add_prop_resv_regions(IOMMUDevice *sdev)
+{
+    VirtIOIOMMU *s = sdev->viommu;
+    int i;
+
+    for (i = 0; i < s->nr_prop_resv_regions; i++) {
+        ReservedRegion *reg = g_new0(ReservedRegion, 1);
+
+        *reg = s->prop_resv_regions[i];
+        sdev->resv_regions = resv_region_list_insert(sdev->resv_regions, reg);
+    }
+}
+
 static AddressSpace *virtio_iommu_find_add_as(PCIBus *bus, void *opaque,
                                               int devfn)
 {
@@ -408,6 +422,7 @@ static AddressSpace *virtio_iommu_find_add_as(PCIBus *bus, void *opaque,
 
         memory_region_init(&sdev->root, OBJECT(s), name, UINT64_MAX);
         address_space_init(&sdev->as, &sdev->root, TYPE_VIRTIO_IOMMU);
+        add_prop_resv_regions(sdev);
 
         /*
          * Build the IOMMU disabled container with aliases to the
@@ -629,17 +644,23 @@ static ssize_t virtio_iommu_fill_resv_mem_prop(VirtIOIOMMU *s, uint32_t ep,
 {
     struct virtio_iommu_probe_resv_mem prop = {};
     size_t size = sizeof(prop), length = size - sizeof(prop.head), total;
-    int i;
+    IOMMUDevice *sdev;
+    GList *l;
 
-    total = size * s->nr_prop_resv_regions;
+    sdev = container_of(virtio_iommu_mr(s, ep), IOMMUDevice, iommu_mr);
+    if (!sdev) {
+        return -EINVAL;
+    }
 
+    total = size * g_list_length(sdev->resv_regions);
     if (total > free) {
         return -ENOSPC;
     }
 
-    for (i = 0; i < s->nr_prop_resv_regions; i++) {
-        unsigned subtype = s->prop_resv_regions[i].type;
-        Range *range = &s->prop_resv_regions[i].range;
+    for (l = sdev->resv_regions; l; l = l->next) {
+        ReservedRegion *reg = l->data;
+        unsigned subtype = reg->type;
+        Range *range = &reg->range;
 
         assert(subtype == VIRTIO_IOMMU_RESV_MEM_T_RESERVED ||
                subtype == VIRTIO_IOMMU_RESV_MEM_T_MSI);
@@ -857,7 +878,7 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     bool bypass_allowed;
     int granule;
     bool found;
-    int i;
+    GList *l;
 
     interval.low = addr;
     interval.high = addr + 1;
@@ -895,8 +916,8 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
         goto unlock;
     }
 
-    for (i = 0; i < s->nr_prop_resv_regions; i++) {
-        ReservedRegion *reg = &s->prop_resv_regions[i];
+    for (l = sdev->resv_regions; l; l = l->next) {
+        ReservedRegion *reg = l->data;
 
         if (range_contains(&reg->range, addr)) {
             switch (reg->type) {
-- 
2.41.0


