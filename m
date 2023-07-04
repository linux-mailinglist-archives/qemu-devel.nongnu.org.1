Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0030A746FAF
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 13:16:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGe0b-0002h5-1I; Tue, 04 Jul 2023 07:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qGe0V-0002fv-Qn
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 07:15:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qGe0U-0007xz-2p
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 07:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688469341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XzL1+bAVr91n8fic68XSWcMtzYFJAdEtrb5hgT+HHxM=;
 b=cDCQBg3kMmWHYnx2/mk/u8CHe73Yk/PUDecevrRwB5iDGkQUgmYP/bMASYkTUP8NowQMcb
 lAgsx6S3iieRbHsEi4Ds7coDzkjkt14vSDDqRDaVFZiueBJbDH0ppnVh3h07s5yHTcelT9
 ukW9RuplUz2O7nfGSPsyt8ptWGpnQYE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-uMQO3GonOp27_Yli2eMq-A-1; Tue, 04 Jul 2023 07:15:38 -0400
X-MC-Unique: uMQO3GonOp27_Yli2eMq-A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6C9D185A78B;
 Tue,  4 Jul 2023 11:15:37 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.194.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C175E492C13;
 Tue,  4 Jul 2023 11:15:35 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 zhenzhong.duan@intel.com
Cc: alex.williamson@redhat.com, clg@redhap.com, bharat.bhushan@nxp.com,
 peter.maydell@linaro.org
Subject: [PATCH 1/2] virtio-iommu: Fix 64kB host page size VFIO device
 assignment
Date: Tue,  4 Jul 2023 13:15:26 +0200
Message-Id: <20230704111527.3424992-2-eric.auger@redhat.com>
In-Reply-To: <20230704111527.3424992-1-eric.auger@redhat.com>
References: <20230704111527.3424992-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When running on a 64kB page size host and protecting a VFIO device
with the virtio-iommu, qemu crashes with this kind of message:

qemu-kvm: virtio-iommu page mask 0xfffffffffffff000 is incompatible
with mask 0x20010000
qemu: hardware error: vfio: DMA mapping failed, unable to continue

This is due to the fact the IOMMU MR corresponding to the VFIO device
is enabled very late on domain attach, after the machine init.
The device reports a minimal 64kB page size but it is too late to be
applied. virtio_iommu_set_page_size_mask() fails and this causes
vfio_listener_region_add() to end up with hw_error();

To work around this issue, we transiently enable the IOMMU MR on
machine init to collect the page size requirements and then restore
the bypass state.

Fixes: 90519b9053 ("virtio-iommu: Add bypass mode support to assigned device")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/hw/virtio/virtio-iommu.h |  2 ++
 hw/virtio/virtio-iommu.c         | 30 ++++++++++++++++++++++++++++--
 hw/virtio/trace-events           |  1 +
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
index 2ad5ee320b..a93fc5383e 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -61,6 +61,8 @@ struct VirtIOIOMMU {
     QemuRecMutex mutex;
     GTree *endpoints;
     bool boot_bypass;
+    Notifier machine_done;
+    bool granule_frozen;
 };
 
 #endif
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 1cd258135d..1eaf81bab5 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -24,6 +24,7 @@
 #include "hw/virtio/virtio.h"
 #include "sysemu/kvm.h"
 #include "sysemu/reset.h"
+#include "sysemu/sysemu.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "trace.h"
@@ -1106,12 +1107,12 @@ static int virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
     }
 
     /*
-     * After the machine is finalized, we can't change the mask anymore. If by
+     * Once the granule is frozen we can't change the mask anymore. If by
      * chance the hotplugged device supports the same granule, we can still
      * accept it. Having a different masks is possible but the guest will use
      * sub-optimal block sizes, so warn about it.
      */
-    if (phase_check(PHASE_MACHINE_READY)) {
+    if (s->granule_frozen) {
         int new_granule = ctz64(new_mask);
         int cur_granule = ctz64(cur_mask);
 
@@ -1146,6 +1147,27 @@ static void virtio_iommu_system_reset(void *opaque)
 
 }
 
+static void virtio_iommu_freeze_granule(Notifier *notifier, void *data)
+{
+    VirtIOIOMMU *s = container_of(notifier, VirtIOIOMMU, machine_done);
+    bool boot_bypass = s->config.bypass;
+    int granule;
+
+    /*
+     * Transient IOMMU MR enable to collect page_size_mask requirement
+     * through memory_region_iommu_set_page_size_mask() called by
+     * VFIO region_add() callback
+     */
+    s->config.bypass = 0;
+    virtio_iommu_switch_address_space_all(s);
+    /* restore default */
+    s->config.bypass = boot_bypass;
+    virtio_iommu_switch_address_space_all(s);
+    s->granule_frozen = true;
+    granule = ctz64(s->config.page_size_mask);
+    trace_virtio_iommu_freeze_granule(BIT(granule));
+}
+
 static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -1189,6 +1211,9 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "VIRTIO-IOMMU is not attached to any PCI bus!");
     }
 
+    s->machine_done.notify = virtio_iommu_freeze_granule;
+    qemu_add_machine_init_done_notifier(&s->machine_done);
+
     qemu_register_reset(virtio_iommu_system_reset, s);
 }
 
@@ -1198,6 +1223,7 @@ static void virtio_iommu_device_unrealize(DeviceState *dev)
     VirtIOIOMMU *s = VIRTIO_IOMMU(dev);
 
     qemu_unregister_reset(virtio_iommu_system_reset, s);
+    qemu_remove_machine_init_done_notifier(&s->machine_done);
 
     g_hash_table_destroy(s->as_by_busptr);
     if (s->domains) {
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 8f8d05cf9b..68b752e304 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -131,6 +131,7 @@ virtio_iommu_set_page_size_mask(const char *name, uint64_t old, uint64_t new) "m
 virtio_iommu_notify_flag_add(const char *name) "add notifier to mr %s"
 virtio_iommu_notify_flag_del(const char *name) "del notifier from mr %s"
 virtio_iommu_switch_address_space(uint8_t bus, uint8_t slot, uint8_t fn, bool on) "Device %02x:%02x.%x switching address space (iommu enabled=%d)"
+virtio_iommu_freeze_granule(uint64_t page_size_mask) "granule set to 0x%"PRIx64
 
 # virtio-mem.c
 virtio_mem_send_response(uint16_t type) "type=%" PRIu16
-- 
2.38.1


