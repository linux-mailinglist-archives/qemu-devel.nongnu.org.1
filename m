Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F51869CF7
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Feb 2024 17:59:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf0mC-0005LJ-GV; Tue, 27 Feb 2024 11:57:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rf0mA-0005Jw-Fq
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 11:57:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rf0m8-00055Y-Sx
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 11:57:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709053071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eDJe/aPZ6+8PhtBvRWgSvpnf8VSRQJ/3USTGhGWlcOo=;
 b=YdzHEdS2tg7uGHGgLS9XkjckRzR2/GP2meVGrraGScfbYAFrTfxajUgq3Jb5gMCjL1ZwLE
 edN7uyzV0WXeoPabT3YSFc/9CA1oDS0ssuBeoKIKXayW58XIlv68DvRCSwBs2C7KJ3Ezh8
 Wm+cvNJQuQnx2LzNdAJRK2dnT9y4nbE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-_Bpvx-yZOwmetsmj2iI6BQ-1; Tue, 27 Feb 2024 11:57:48 -0500
X-MC-Unique: _Bpvx-yZOwmetsmj2iI6BQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B02FE85A588;
 Tue, 27 Feb 2024 16:57:47 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C637C2166AE2;
 Tue, 27 Feb 2024 16:57:43 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 peter.maydell@linaro.org, clg@redhat.com, yanghliu@redhat.com
Cc: alex.williamson@redhat.com, zhenzhong.duan@intel.com, jasowang@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com
Subject: [PATCH v6 2/3] virtio-iommu: Add a granule property
Date: Tue, 27 Feb 2024 17:55:49 +0100
Message-ID: <20240227165730.14099-3-eric.auger@redhat.com>
In-Reply-To: <20240227165730.14099-1-eric.auger@redhat.com>
References: <20240227165730.14099-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

This allows to choose which granule will be used by
default by the virtio-iommu. Current page size mask
default is qemu_target_page_mask so this translates
into a 4K granule.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

---
v4 -> v5:
- use -(n * KiB) (Phild)

v3 -> v4:
- granule_mode introduction moved to that patch
---
 include/hw/virtio/virtio-iommu.h |  2 ++
 hw/virtio/virtio-iommu.c         | 28 +++++++++++++++++++++++++---
 qemu-options.hx                  |  3 +++
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
index 5fbe4677c2..f2785f7997 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -24,6 +24,7 @@
 #include "hw/virtio/virtio.h"
 #include "hw/pci/pci.h"
 #include "qom/object.h"
+#include "qapi/qapi-types-virtio.h"
 
 #define TYPE_VIRTIO_IOMMU "virtio-iommu-device"
 #define TYPE_VIRTIO_IOMMU_PCI "virtio-iommu-pci"
@@ -67,6 +68,7 @@ struct VirtIOIOMMU {
     Notifier machine_done;
     bool granule_frozen;
     uint8_t aw_bits;
+    GranuleMode granule_mode;
 };
 
 #endif
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 2ec5ef3cd1..33e0520bc8 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -29,6 +29,7 @@
 #include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
 #include "qemu/reserved-region.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "trace.h"
@@ -1115,8 +1116,8 @@ static int virtio_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu_mr,
 }
 
 /*
- * The default mask (TARGET_PAGE_MASK) is the smallest supported guest granule,
- * for example 0xfffffffffffff000. When an assigned device has page size
+ * The default mask depends on the "granule" property. For example, with
+ * 4K granule, it is -(4 * KiB). When an assigned device has page size
  * restrictions due to the hardware IOMMU configuration, apply this restriction
  * to the mask.
  */
@@ -1313,7 +1314,26 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
      * in vfio realize
      */
     s->config.bypass = s->boot_bypass;
-    s->config.page_size_mask = qemu_target_page_mask();
+
+    switch (s->granule_mode) {
+    case GRANULE_MODE_4K:
+        s->config.page_size_mask = -(4 * KiB);
+        break;
+    case GRANULE_MODE_8K:
+        s->config.page_size_mask = -(8 * KiB);
+        break;
+    case GRANULE_MODE_16K:
+        s->config.page_size_mask = -(16 * KiB);
+        break;
+    case GRANULE_MODE_64K:
+        s->config.page_size_mask = -(64 * KiB);
+        break;
+    case GRANULE_MODE_HOST:
+        s->config.page_size_mask = qemu_real_host_page_mask();
+        break;
+    default:
+        error_setg(errp, "Unsupported granule mode");
+    }
     if (s->aw_bits < 32 || s->aw_bits > 64) {
         error_setg(errp, "aw-bits must be within [32,64]");
     }
@@ -1527,6 +1547,8 @@ static Property virtio_iommu_properties[] = {
                      TYPE_PCI_BUS, PCIBus *),
     DEFINE_PROP_BOOL("boot-bypass", VirtIOIOMMU, boot_bypass, true),
     DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 0),
+    DEFINE_PROP_GRANULE_MODE("granule", VirtIOIOMMU, granule_mode,
+                             GRANULE_MODE_4K),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 3b670758b0..c7b43b67d5 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1179,6 +1179,9 @@ SRST
     ``aw-bits=val`` (val between 32 and 64, default depends on machine)
         This decides the address width of IOVA address space. It defaults
         to 39 bits on q35 machines and 48 bits on ARM virt machines.
+    ``granule=val`` (possible values are 4K, 8K, 16K, 64K and host)
+        This decides the default granule to be be exposed by the
+        virtio-iommu. If host, the granule matches the host page size.
 
 ERST
 
-- 
2.41.0


