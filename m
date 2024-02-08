Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E63A84DDE5
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Feb 2024 11:13:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY1Nl-0003zr-MI; Thu, 08 Feb 2024 05:11:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rY1Nj-0003z0-6N
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 05:11:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rY1Nh-0000Sf-K6
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 05:11:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707387105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DPrDVIdiESOiMapBfh0CtAjDydyyKmrnXSgaW0nkP/k=;
 b=XdfWLztLoIlXiWBo+XX68xNrcsXREPrsWFbIfy7q0q4IlHBxYGk/0VDXABbRhxcDGVv/rY
 JtN+7YOctqfC1X3WUkIaGzMPnF1u1ygPA22/tzcP3gy9Ax0tHmcmdrJlZuLooedDU45+29
 3fgkDiDH4vh5bAeHUnkiFrP7NnMTOz4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-0OlgeajHOEa3Qb3qMnwsiw-1; Thu, 08 Feb 2024 05:11:41 -0500
X-MC-Unique: 0OlgeajHOEa3Qb3qMnwsiw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 698B5101FA0B;
 Thu,  8 Feb 2024 10:11:41 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1238BC08EF7;
 Thu,  8 Feb 2024 10:11:38 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, jean-philippe@linaro.org, mst@redhat.com,
 peter.maydell@linaro.org, clg@redhat.com, zhenzhong.duan@intel.com,
 yanghliu@redhat.com
Cc: alex.williamson@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v3 3/3] hw: Set virtio-iommu aw-bits default value on pc_q35
 and arm virt
Date: Thu,  8 Feb 2024 11:10:19 +0100
Message-ID: <20240208101128.655167-4-eric.auger@redhat.com>
In-Reply-To: <20240208101128.655167-1-eric.auger@redhat.com>
References: <20240208101128.655167-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Currently the default input range can extend to 64 bits. On x86,
when the virtio-iommu protects vfio devices, the physical iommu
may support only 39 bits. Let's set the default to 39, as done
for the intel-iommu. On ARM we set 48b as a default (matching
SMMUv3 SMMU_IDR5.VAX == 0).

We use hw_compat_8_2 to handle the compatibility for machines
before 9.0 which used to have a virtio-iommu default input range
of 64 bits.

Of course if aw-bits is set from the command line, the default
is overriden.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Tested-by: Yanghang Liu<yanghliu@redhat.com>

---

v2 -> v3:
- collected Zhenzhong's R-b
- use &error_abort instead of NULL error handle
  on object_property_get_uint() call (Cédric)
- use VTD_HOST_AW_39BIT (Cédric)

v1 -> v2:
- set aw-bits to 48b on ARM
- use hw_compat_8_2 to handle the compat for older machines
  which used 64b as a default
---
 hw/arm/virt.c            | 6 ++++++
 hw/core/machine.c        | 5 ++++-
 hw/i386/pc.c             | 6 ++++++
 hw/virtio/virtio-iommu.c | 2 +-
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 368c2a415a..0994f2a560 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2716,10 +2716,16 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
         virtio_md_pci_pre_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
+        uint8_t aw_bits = object_property_get_uint(OBJECT(dev),
+                                                   "aw-bits", &error_abort);
         hwaddr db_start = 0, db_end = 0;
         QList *reserved_regions;
         char *resv_prop_str;
 
+        if (!aw_bits) {
+            qdev_prop_set_uint8(dev, "aw-bits", 48);
+        }
+
         if (vms->iommu != VIRT_IOMMU_NONE) {
             error_setg(errp, "virt machine does not support multiple IOMMUs");
             return;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index fb5afdcae4..70ac96954c 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -30,9 +30,12 @@
 #include "exec/confidential-guest-support.h"
 #include "hw/virtio/virtio-pci.h"
 #include "hw/virtio/virtio-net.h"
+#include "hw/virtio/virtio-iommu.h"
 #include "audio/audio.h"
 
-GlobalProperty hw_compat_8_2[] = {};
+GlobalProperty hw_compat_8_2[] = {
+    { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "64" },
+};
 const size_t hw_compat_8_2_len = G_N_ELEMENTS(hw_compat_8_2);
 
 GlobalProperty hw_compat_8_1[] = {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 196827531a..ee2d379c90 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1456,6 +1456,8 @@ static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
         virtio_md_pci_pre_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
+        uint8_t aw_bits = object_property_get_uint(OBJECT(dev),
+                                                   "aw-bits", &error_abort);
         /* Declare the APIC range as the reserved MSI region */
         char *resv_prop_str = g_strdup_printf("0xfee00000:0xfeefffff:%d",
                                               VIRTIO_IOMMU_RESV_MEM_T_MSI);
@@ -1464,6 +1466,10 @@ static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
         qlist_append_str(reserved_regions, resv_prop_str);
         qdev_prop_set_array(dev, "reserved-regions", reserved_regions);
 
+        if (!aw_bits) {
+            qdev_prop_set_uint8(dev, "aw-bits", VTD_HOST_AW_39BIT);
+        }
+
         g_free(resv_prop_str);
     }
 
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 7870bdbeee..c468e9b13b 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -1529,7 +1529,7 @@ static Property virtio_iommu_properties[] = {
     DEFINE_PROP_LINK("primary-bus", VirtIOIOMMU, primary_bus,
                      TYPE_PCI_BUS, PCIBus *),
     DEFINE_PROP_BOOL("boot-bypass", VirtIOIOMMU, boot_bypass, true),
-    DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 64),
+    DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.41.0


