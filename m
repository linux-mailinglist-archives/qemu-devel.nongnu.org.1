Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F49E7E276D
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:45:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00jO-00056j-87; Mon, 06 Nov 2023 09:37:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org>)
 id 1r00jK-0004fd-7A
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:37:30 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org>)
 id 1r00jI-0000th-2c
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:37:29 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SPDTK5CQhz4xjN;
 Tue,  7 Nov 2023 01:37:25 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SPDTH1pvkz4xkL;
 Tue,  7 Nov 2023 01:37:22 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanghang Liu <yanghliu@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 09/22] virtio-iommu: Record whether a probe request has been
 issued
Date: Mon,  6 Nov 2023 15:36:40 +0100
Message-ID: <20231106143653.302391-10-clg@redhat.com>
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

Add an IOMMUDevice 'probe_done' flag to record that the driver
already issued a probe request on that device.

This will be useful to double check host reserved regions aren't
notified after the probe and hence are not taken into account
by the driver.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: "Michael S. Tsirkin" <mst@redhat.com>
Tested-by: Yanghang Liu <yanghliu@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/virtio/virtio-iommu.h |  1 +
 hw/virtio/virtio-iommu.c         | 20 +++++++++++---------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
index 70b8ace34dfb7f24ff6cf41a21ecd283ca9ee512..1dd11ae81aeac25410f6f0a9bff89414b8edd48c 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -40,6 +40,7 @@ typedef struct IOMMUDevice {
     MemoryRegion root;          /* The root container of the device */
     MemoryRegion bypass_mr;     /* The alias of shared memory MR */
     GList *resv_regions;
+    bool probe_done;
 } IOMMUDevice;
 
 typedef struct IOMMUPciBus {
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 0e2370663d348e60678343dabd1f943792051315..13c3c087fe2ed7a4163ade5b40e11e6c8ea90b6e 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -639,19 +639,13 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
     return ret;
 }
 
-static ssize_t virtio_iommu_fill_resv_mem_prop(VirtIOIOMMU *s, uint32_t ep,
+static ssize_t virtio_iommu_fill_resv_mem_prop(IOMMUDevice *sdev, uint32_t ep,
                                                uint8_t *buf, size_t free)
 {
     struct virtio_iommu_probe_resv_mem prop = {};
     size_t size = sizeof(prop), length = size - sizeof(prop.head), total;
-    IOMMUDevice *sdev;
     GList *l;
 
-    sdev = container_of(virtio_iommu_mr(s, ep), IOMMUDevice, iommu_mr);
-    if (!sdev) {
-        return -EINVAL;
-    }
-
     total = size * g_list_length(sdev->resv_regions);
     if (total > free) {
         return -ENOSPC;
@@ -688,19 +682,27 @@ static int virtio_iommu_probe(VirtIOIOMMU *s,
                               uint8_t *buf)
 {
     uint32_t ep_id = le32_to_cpu(req->endpoint);
+    IOMMUMemoryRegion *iommu_mr = virtio_iommu_mr(s, ep_id);
     size_t free = VIOMMU_PROBE_SIZE;
+    IOMMUDevice *sdev;
     ssize_t count;
 
-    if (!virtio_iommu_mr(s, ep_id)) {
+    if (!iommu_mr) {
         return VIRTIO_IOMMU_S_NOENT;
     }
 
-    count = virtio_iommu_fill_resv_mem_prop(s, ep_id, buf, free);
+    sdev = container_of(iommu_mr, IOMMUDevice, iommu_mr);
+    if (!sdev) {
+        return -EINVAL;
+    }
+
+    count = virtio_iommu_fill_resv_mem_prop(sdev, ep_id, buf, free);
     if (count < 0) {
         return VIRTIO_IOMMU_S_INVAL;
     }
     buf += count;
     free -= count;
+    sdev->probe_done = true;
 
     return VIRTIO_IOMMU_S_OK;
 }
-- 
2.41.0


