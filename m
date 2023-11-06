Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 157627E2781
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:48:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00jI-0004Ll-V5; Mon, 06 Nov 2023 09:37:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org>)
 id 1r00j9-0003jt-1E
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:37:20 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org>)
 id 1r00j3-0000pm-GW
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:37:18 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SPDT33XXDz4xk6;
 Tue,  7 Nov 2023 01:37:11 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SPDT144Wlz4xjN;
 Tue,  7 Nov 2023 01:37:09 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 04/22] virtio-iommu: Rename reserved_regions into
 prop_resv_regions
Date: Mon,  6 Nov 2023 15:36:35 +0100
Message-ID: <20231106143653.302391-5-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106143653.302391-1-clg@redhat.com>
References: <20231106143653.302391-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Rename VirtIOIOMMU (nb_)reserved_regions fields with the "prop_" prefix
to highlight those fields are set through a property, at machine level.
They are IOMMU wide.

A subsequent patch will introduce per IOMMUDevice reserved regions
that will include both those IOMMU wide property reserved
regions plus, sometimes, host reserved regions, if the device is
backed by a host device protected by a physical IOMMU. Also change
nb_ prefix by nr_.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/virtio/virtio-iommu.h |  4 ++--
 hw/virtio/virtio-iommu-pci.c     |  8 ++++----
 hw/virtio/virtio-iommu.c         | 15 ++++++++-------
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
index a93fc5383e0ffee52494134fa3ec894c1324010e..eea4564782215dac7205557c241e5ce2d7e40713 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -55,8 +55,8 @@ struct VirtIOIOMMU {
     GHashTable *as_by_busptr;
     IOMMUPciBus *iommu_pcibus_by_bus_num[PCI_BUS_MAX];
     PCIBus *primary_bus;
-    ReservedRegion *reserved_regions;
-    uint32_t nb_reserved_regions;
+    ReservedRegion *prop_resv_regions;
+    uint32_t nr_prop_resv_regions;
     GTree *domains;
     QemuRecMutex mutex;
     GTree *endpoints;
diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
index 7ef2f9dcdbacbac8fe6f1d7d5c075d90f3993003..9459fbf6edfe84d80b3d90150a94bb77418194e5 100644
--- a/hw/virtio/virtio-iommu-pci.c
+++ b/hw/virtio/virtio-iommu-pci.c
@@ -37,7 +37,7 @@ struct VirtIOIOMMUPCI {
 static Property virtio_iommu_pci_properties[] = {
     DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
     DEFINE_PROP_ARRAY("reserved-regions", VirtIOIOMMUPCI,
-                      vdev.nb_reserved_regions, vdev.reserved_regions,
+                      vdev.nr_prop_resv_regions, vdev.prop_resv_regions,
                       qdev_prop_reserved_region, ReservedRegion),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -54,9 +54,9 @@ static void virtio_iommu_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
                          "for the virtio-iommu-pci device");
         return;
     }
-    for (int i = 0; i < s->nb_reserved_regions; i++) {
-        if (s->reserved_regions[i].type != VIRTIO_IOMMU_RESV_MEM_T_RESERVED &&
-            s->reserved_regions[i].type != VIRTIO_IOMMU_RESV_MEM_T_MSI) {
+    for (int i = 0; i < s->nr_prop_resv_regions; i++) {
+        if (s->prop_resv_regions[i].type != VIRTIO_IOMMU_RESV_MEM_T_RESERVED &&
+            s->prop_resv_regions[i].type != VIRTIO_IOMMU_RESV_MEM_T_MSI) {
             error_setg(errp, "reserved region %d has an invalid type", i);
             error_append_hint(errp, "Valid values are 0 and 1\n");
             return;
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index e5e46e1b557e19edc461b117dbfddcfd8f1dcc5d..979cdb56483c7de5d79a7a3f4c1fe996fc261c64 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -631,22 +631,23 @@ static ssize_t virtio_iommu_fill_resv_mem_prop(VirtIOIOMMU *s, uint32_t ep,
     size_t size = sizeof(prop), length = size - sizeof(prop.head), total;
     int i;
 
-    total = size * s->nb_reserved_regions;
+    total = size * s->nr_prop_resv_regions;
 
     if (total > free) {
         return -ENOSPC;
     }
 
-    for (i = 0; i < s->nb_reserved_regions; i++) {
-        unsigned subtype = s->reserved_regions[i].type;
+    for (i = 0; i < s->nr_prop_resv_regions; i++) {
+        unsigned subtype = s->prop_resv_regions[i].type;
+        Range *range = &s->prop_resv_regions[i].range;
 
         assert(subtype == VIRTIO_IOMMU_RESV_MEM_T_RESERVED ||
                subtype == VIRTIO_IOMMU_RESV_MEM_T_MSI);
         prop.head.type = cpu_to_le16(VIRTIO_IOMMU_PROBE_T_RESV_MEM);
         prop.head.length = cpu_to_le16(length);
         prop.subtype = subtype;
-        prop.start = cpu_to_le64(range_lob(&s->reserved_regions[i].range));
-        prop.end = cpu_to_le64(range_upb(&s->reserved_regions[i].range));
+        prop.start = cpu_to_le64(range_lob(range));
+        prop.end = cpu_to_le64(range_upb(range));
 
         memcpy(buf, &prop, size);
 
@@ -894,8 +895,8 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
         goto unlock;
     }
 
-    for (i = 0; i < s->nb_reserved_regions; i++) {
-        ReservedRegion *reg = &s->reserved_regions[i];
+    for (i = 0; i < s->nr_prop_resv_regions; i++) {
+        ReservedRegion *reg = &s->prop_resv_regions[i];
 
         if (range_contains(&reg->range, addr)) {
             switch (reg->type) {
-- 
2.41.0


