Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9F17E2771
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:46:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00jP-0005GG-S7; Mon, 06 Nov 2023 09:37:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org>)
 id 1r00jM-00055r-QC
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:37:33 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org>)
 id 1r00jK-0000vw-Ib
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:37:32 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SPDTN3RR8z4xj0;
 Tue,  7 Nov 2023 01:37:28 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SPDTL1zMzz4xk7;
 Tue,  7 Nov 2023 01:37:26 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yanghang Liu <yanghliu@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 10/22] virtio-iommu: Implement set_iova_ranges() callback
Date: Mon,  6 Nov 2023 15:36:41 +0100
Message-ID: <20231106143653.302391-11-clg@redhat.com>
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

The implementation populates the array of per IOMMUDevice
host reserved ranges.

It is forbidden to have conflicting sets of host IOVA ranges
to be applied onto the same IOMMU MR (implied by different
host devices).

In case the callback is called after the probe request has
been issues by the driver, a warning is issued.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: "Michael S. Tsirkin" <mst@redhat.com>
Tested-by: Yanghang Liu <yanghliu@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/virtio/virtio-iommu.h |  1 +
 hw/virtio/virtio-iommu.c         | 67 ++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
index 1dd11ae81aeac25410f6f0a9bff89414b8edd48c..781ebaea8fca196ea4b74a8f790484ca61b5d37d 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -40,6 +40,7 @@ typedef struct IOMMUDevice {
     MemoryRegion root;          /* The root container of the device */
     MemoryRegion bypass_mr;     /* The alias of shared memory MR */
     GList *resv_regions;
+    GList *host_resv_ranges;
     bool probe_done;
 } IOMMUDevice;
 
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 13c3c087fe2ed7a4163ade5b40e11e6c8ea90b6e..15aadd6fdd623a59eaaf56980857e0b7d0bf4ee0 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/iov.h"
+#include "qemu/range.h"
 #include "exec/target_page.h"
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio.h"
@@ -1155,6 +1156,71 @@ static int virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
     return 0;
 }
 
+/**
+ * virtio_iommu_set_iova_ranges: Conveys the usable IOVA ranges
+ *
+ * The function turns those into reserved ranges. Once some
+ * reserved ranges have been set, new reserved regions cannot be
+ * added outside of the original ones.
+ *
+ * @mr: IOMMU MR
+ * @iova_ranges: list of usable IOVA ranges
+ * @errp: error handle
+ */
+static int virtio_iommu_set_iova_ranges(IOMMUMemoryRegion *mr,
+                                        GList *iova_ranges,
+                                        Error **errp)
+{
+    IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
+    GList *current_ranges = sdev->host_resv_ranges;
+    GList *l, *tmp, *new_ranges = NULL;
+    int ret = -EINVAL;
+
+    /* check that each new resv region is included in an existing one */
+    if (sdev->host_resv_ranges) {
+        range_inverse_array(iova_ranges,
+                            &new_ranges,
+                            0, UINT64_MAX);
+
+        for (tmp = new_ranges; tmp; tmp = tmp->next) {
+            Range *newr = (Range *)tmp->data;
+            bool included = false;
+
+            for (l = current_ranges; l; l = l->next) {
+                Range * r = (Range *)l->data;
+
+                if (range_contains_range(r, newr)) {
+                    included = true;
+                    break;
+                }
+            }
+            if (!included) {
+                goto error;
+            }
+        }
+        /* all new reserved ranges are included in existing ones */
+        ret = 0;
+        goto out;
+    }
+
+    if (sdev->probe_done) {
+        warn_report("%s: Notified about new host reserved regions after probe",
+                    mr->parent_obj.name);
+    }
+
+    range_inverse_array(iova_ranges,
+                        &sdev->host_resv_ranges,
+                        0, UINT64_MAX);
+
+    return 0;
+error:
+    error_setg(errp, "IOMMU mr=%s Conflicting host reserved ranges set!",
+               mr->parent_obj.name);
+out:
+    g_list_free_full(new_ranges, g_free);
+    return ret;
+}
+
 static void virtio_iommu_system_reset(void *opaque)
 {
     VirtIOIOMMU *s = opaque;
@@ -1450,6 +1516,7 @@ static void virtio_iommu_memory_region_class_init(ObjectClass *klass,
     imrc->replay = virtio_iommu_replay;
     imrc->notify_flag_changed = virtio_iommu_notify_flag_changed;
     imrc->iommu_set_page_size_mask = virtio_iommu_set_page_size_mask;
+    imrc->iommu_set_iova_ranges = virtio_iommu_set_iova_ranges;
 }
 
 static const TypeInfo virtio_iommu_info = {
-- 
2.41.0


