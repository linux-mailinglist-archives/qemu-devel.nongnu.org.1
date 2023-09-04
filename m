Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB207912EC
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 10:07:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd4ba-000134-FN; Mon, 04 Sep 2023 04:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qd4bC-0000vm-LN
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 04:06:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qd4bA-0006DV-1y
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 04:06:18 -0400
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-nRy1yXKhNM2ko5Cu-8N5LQ-1; Mon, 04 Sep 2023 04:05:08 -0400
X-MC-Unique: nRy1yXKhNM2ko5Cu-8N5LQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F34BE3C19365;
 Mon,  4 Sep 2023 08:05:07 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3598340ED412;
 Mon,  4 Sep 2023 08:05:05 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, alex.williamson@redhat.com, clg@redhat.com,
 jean-philippe@linaro.org, mst@redhat.com, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org
Subject: [PATCH 04/13] virtio-iommu: Rename reserved_regions into
 prop_resv_regions
Date: Mon,  4 Sep 2023 10:03:47 +0200
Message-ID: <20230904080451.424731-5-eric.auger@redhat.com>
In-Reply-To: <20230904080451.424731-1-eric.auger@redhat.com>
References: <20230904080451.424731-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Rename VirtIOIOMMU (nb_)reserved_regions fields with the "prop_" prefix
to highlight those fields are set through a property, at machine level.
They are IOMMU wide.

A subsequent patch will introduce per IOMMUDevice reserved regions
that will include both those IOMMU wide property reserved
regions plus, sometimes, host reserved regions, if the device is
backed by a host device protected by a physical IOMMU. Also change
nb_ prefix by nr_.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/hw/virtio/virtio-iommu.h |  4 ++--
 hw/virtio/virtio-iommu-pci.c     |  8 ++++----
 hw/virtio/virtio-iommu.c         | 15 ++++++++-------
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
index a93fc5383e..eea4564782 100644
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
index 7ef2f9dcdb..9459fbf6ed 100644
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
index e5e46e1b55..979cdb5648 100644
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


