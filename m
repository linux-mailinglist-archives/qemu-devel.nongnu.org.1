Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9143C7E7096
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 18:44:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r193w-0003cQ-E0; Thu, 09 Nov 2023 12:43:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r193u-0003aW-61
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:43:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r193p-0004q7-Ho
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:43:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699551801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tpeg1EgzDYiRM+fPvkfHgZDZ7GEolOc59ZCeVbB2RRY=;
 b=hRx+YnDjYYkESzYEeig0SLNEvUsxKoyLa3NNHc3VeoGRuHpKOB7vaYn6G2WistKPuDpgbQ
 bgy/e4ca0C5PtpuQnpVBUdlZ0QA/GXnkmTNINd7MAOshiD73VPaWvWHBDp2+F6WeIIQmdP
 mX/uapExpYbd9m0BX6T5s+5jV84ww+4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-CHl4heuFP3uSF58KA2hQ7Q-1; Thu, 09 Nov 2023 12:43:17 -0500
X-MC-Unique: CHl4heuFP3uSF58KA2hQ7Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D353863E98;
 Thu,  9 Nov 2023 17:43:17 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22C6220268F8;
 Thu,  9 Nov 2023 17:43:16 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v3 06/11] hw/arm/virt: Use qdev_prop_set_array()
Date: Thu,  9 Nov 2023 18:42:35 +0100
Message-ID: <20231109174240.72376-7-kwolf@redhat.com>
In-Reply-To: <20231109174240.72376-1-kwolf@redhat.com>
References: <20231109174240.72376-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Instead of manually setting "foo-len" and "foo[i]" properties, build a
QList and use the new qdev_prop_set_array() helper to set the whole
array property with a single call.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0a16ab3095..85e3c5ba9d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -69,6 +69,7 @@
 #include "hw/firmware/smbios.h"
 #include "qapi/visitor.h"
 #include "qapi/qapi-visit-common.h"
+#include "qapi/qmp/qlist.h"
 #include "standard-headers/linux/input.h"
 #include "hw/arm/smmuv3.h"
 #include "hw/acpi/acpi.h"
@@ -752,14 +753,23 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
     }
 
     if (vms->gic_version != VIRT_GIC_VERSION_2) {
+        QList *redist_region_count;
         uint32_t redist0_capacity = virt_redist_capacity(vms, VIRT_GIC_REDIST);
         uint32_t redist0_count = MIN(smp_cpus, redist0_capacity);
 
         nb_redist_regions = virt_gicv3_redist_region_count(vms);
 
-        qdev_prop_set_uint32(vms->gic, "len-redist-region-count",
-                             nb_redist_regions);
-        qdev_prop_set_uint32(vms->gic, "redist-region-count[0]", redist0_count);
+        redist_region_count = qlist_new();
+        qlist_append_int(redist_region_count, redist0_count);
+        if (nb_redist_regions == 2) {
+            uint32_t redist1_capacity =
+                virt_redist_capacity(vms, VIRT_HIGH_GIC_REDIST2);
+
+            qlist_append_int(redist_region_count,
+                MIN(smp_cpus - redist0_count, redist1_capacity));
+        }
+        qdev_prop_set_array(vms->gic, "redist-region-count",
+                            redist_region_count);
 
         if (!kvm_irqchip_in_kernel()) {
             if (vms->tcg_its) {
@@ -768,14 +778,6 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
                 qdev_prop_set_bit(vms->gic, "has-lpi", true);
             }
         }
-
-        if (nb_redist_regions == 2) {
-            uint32_t redist1_capacity =
-                virt_redist_capacity(vms, VIRT_HIGH_GIC_REDIST2);
-
-            qdev_prop_set_uint32(vms->gic, "redist-region-count[1]",
-                MIN(smp_cpus - redist0_count, redist1_capacity));
-        }
     } else {
         if (!kvm_irqchip_in_kernel()) {
             qdev_prop_set_bit(vms->gic, "has-virtualization-extensions",
@@ -2748,6 +2750,7 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
         virtio_md_pci_pre_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
         hwaddr db_start = 0, db_end = 0;
+        QList *reserved_regions;
         char *resv_prop_str;
 
         if (vms->iommu != VIRT_IOMMU_NONE) {
@@ -2774,9 +2777,9 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
                                         db_start, db_end,
                                         VIRTIO_IOMMU_RESV_MEM_T_MSI);
 
-        object_property_set_uint(OBJECT(dev), "len-reserved-regions", 1, errp);
-        object_property_set_str(OBJECT(dev), "reserved-regions[0]",
-                                resv_prop_str, errp);
+        reserved_regions = qlist_new();
+        qlist_append_str(reserved_regions, resv_prop_str);
+        qdev_prop_set_array(dev, "reserved-regions", reserved_regions);
         g_free(resv_prop_str);
     }
 }
-- 
2.41.0


