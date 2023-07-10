Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D9874E1FB
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:09:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzwg-0003jt-Kd; Mon, 10 Jul 2023 19:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwM-0002W8-UB
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwI-0004Z8-0X
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A/513T7kroKOQx8pSM4wAJX3w8Juwbgshwbra6tnmIM=;
 b=ZbBtui5LGvNhP+4A/8FsrFMICr0PKg//+51uis7+yFAEeNqZ/Wr183GGBHKRHXNo8WhsUo
 bVc8J700F2O5ysi+Sojdwcp7Nz3jzCTL31KwcjYS8j4HEHQAn3tzCl85hoTzIM5plifr11
 I1BGL+ZtSpn1mvbidSVkmjRfIS5P46Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-Rw4wXgWUN1OAiBMIHoa6Sw-1; Mon, 10 Jul 2023 19:04:42 -0400
X-MC-Unique: Rw4wXgWUN1OAiBMIHoa6Sw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fbdf341934so37078835e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030281; x=1691622281;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A/513T7kroKOQx8pSM4wAJX3w8Juwbgshwbra6tnmIM=;
 b=KnwtwqIFu0LBHYVL1A5yNOSKvc5NK/wCrTsO4XdeC8/X+EL62szY389xJcKatjgMkc
 97r1U7Ov3eeAuEKwyVzRpP7zIoRgQKmbF6MuApcUYGw+c1f1CBAQtiLBWNAVVxSERjxn
 MgVNyGirocsB6xQlPuuq6yafvDVmMeiijxiL9XaEl2Ikj/WkqbiPSeevisycpPUNGr/c
 cusji13yu9NU9PFa5F6e5QW/EXaBBypf8UDhpsjZP9FAv58WmQkDJBBekWPFoTnD2QNH
 r0YgeJkLzCuWswoqFLvBEdX+TiIT+BINsebOFrrKgx6plA8YQsWrqXxy/xHDsCseLdnY
 RecA==
X-Gm-Message-State: ABy/qLaOGc3fu68iLzJN7l+COBIG40YtKXUbwMC+qyfw54ND1eaVdRje
 HUIbg8a8L8lWanG9ycm2eUCbTDJZwYAzj3IN3dFUYbq5PVd19cqXJJCr783FwD5uUWLijdlYTOM
 TWLfqj7PXyTe7vz990aajNgCoA2nXdCTBGu7/Q49OGGCQ7BVhEoPvQNEHjVaOqIPoC/yZ
X-Received: by 2002:a05:600c:247:b0:3fc:65:8dff with SMTP id
 7-20020a05600c024700b003fc00658dffmr14667211wmj.4.1689030280919; 
 Mon, 10 Jul 2023 16:04:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGTCl+MuxiHIqO0lV6NA8mf6j6Mfq+K1TsP0Uq/4M6xPdAKi6R8ZMgPLFWnd9/AB+WDS3UvZw==
X-Received: by 2002:a05:600c:247:b0:3fc:65:8dff with SMTP id
 7-20020a05600c024700b003fc00658dffmr14667185wmj.4.1689030280572; 
 Mon, 10 Jul 2023 16:04:40 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 b16-20020a5d5510000000b0031417b0d338sm574460wrv.87.2023.07.10.16.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:04:40 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:04:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PULL 46/66] virtio-iommu: Fix 64kB host page size VFIO device
 assignment
Message-ID: <94df5b2180d61fb2ee2b04cc007981e58b6479a9.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

From: Eric Auger <eric.auger@redhat.com>

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

Message-Id: <20230705165118.28194-2-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/virtio/virtio-iommu.h |  2 ++
 hw/virtio/virtio-iommu.c         | 31 +++++++++++++++++++++++++++++--
 hw/virtio/trace-events           |  1 +
 3 files changed, 32 insertions(+), 2 deletions(-)

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
index 1bbad23f4a..8d0c5e3f32 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -25,6 +25,7 @@
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
 
@@ -1146,6 +1147,28 @@ static void virtio_iommu_system_reset(void *opaque)
 
 }
 
+static void virtio_iommu_freeze_granule(Notifier *notifier, void *data)
+{
+    VirtIOIOMMU *s = container_of(notifier, VirtIOIOMMU, machine_done);
+    int granule;
+
+    if (likely(s->config.bypass)) {
+        /*
+         * Transient IOMMU MR enable to collect page_size_mask requirements
+         * through memory_region_iommu_set_page_size_mask() called by
+         * VFIO region_add() callback
+         */
+         s->config.bypass = false;
+         virtio_iommu_switch_address_space_all(s);
+         /* restore default */
+         s->config.bypass = true;
+         virtio_iommu_switch_address_space_all(s);
+    }
+    s->granule_frozen = true;
+    granule = ctz64(s->config.page_size_mask);
+    trace_virtio_iommu_freeze_granule(BIT(granule));
+}
+
 static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -1189,6 +1212,9 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "VIRTIO-IOMMU is not attached to any PCI bus!");
     }
 
+    s->machine_done.notify = virtio_iommu_freeze_granule;
+    qemu_add_machine_init_done_notifier(&s->machine_done);
+
     qemu_register_reset(virtio_iommu_system_reset, s);
 }
 
@@ -1198,6 +1224,7 @@ static void virtio_iommu_device_unrealize(DeviceState *dev)
     VirtIOIOMMU *s = VIRTIO_IOMMU(dev);
 
     qemu_unregister_reset(virtio_iommu_system_reset, s);
+    qemu_remove_machine_init_done_notifier(&s->machine_done);
 
     g_hash_table_destroy(s->as_by_busptr);
     if (s->domains) {
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 4e39ed8a95..7109cf1a3b 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -133,6 +133,7 @@ virtio_iommu_set_page_size_mask(const char *name, uint64_t old, uint64_t new) "m
 virtio_iommu_notify_flag_add(const char *name) "add notifier to mr %s"
 virtio_iommu_notify_flag_del(const char *name) "del notifier from mr %s"
 virtio_iommu_switch_address_space(uint8_t bus, uint8_t slot, uint8_t fn, bool on) "Device %02x:%02x.%x switching address space (iommu enabled=%d)"
+virtio_iommu_freeze_granule(uint64_t page_size_mask) "granule set to 0x%"PRIx64
 
 # virtio-mem.c
 virtio_mem_send_response(uint16_t type) "type=%" PRIu16
-- 
MST


