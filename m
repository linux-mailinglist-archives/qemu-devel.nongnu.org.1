Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FDA7988FE
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 16:40:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qecce-0005uu-UY; Fri, 08 Sep 2023 10:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qeccO-0005kW-Mm
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:37:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qeccM-00079F-GI
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694183873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LIVQ//NnxGjyPy+YCbQ84aG0M7IFAZvAvmqP7j48JgE=;
 b=duztdAQUV6ogyIJNFz+Fyye/mZ68KGoDfyF10ziHGehk4YmJ5zri50g5ggUgt4oMr81g1a
 LTLX6pVPGLzc44E8RnGUBju+yAWNk1WwEOfoT4qYq76WBcTE2Y8FyjyU+bfme9Wx2Egz6B
 CwF3PmTSdm8lmt5YffDAMadB4NBJi8g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-KzcgjCD5Pn6tH4cIvHW-aA-1; Fri, 08 Sep 2023 10:37:51 -0400
X-MC-Unique: KzcgjCD5Pn6tH4cIvHW-aA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94311281CC20;
 Fri,  8 Sep 2023 14:37:51 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 87BD6140E962;
 Fri,  8 Sep 2023 14:37:50 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org, pbonzini@redhat.com
Subject: [PATCH 07/11] hw/arm/virt: Use qdev_prop_set_array()
Date: Fri,  8 Sep 2023 16:36:58 +0200
Message-ID: <20230908143703.172758-8-kwolf@redhat.com>
In-Reply-To: <20230908143703.172758-1-kwolf@redhat.com>
References: <20230908143703.172758-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 hw/arm/virt.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a13c658bbf..be04f68b48 100644
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
@@ -746,14 +747,23 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
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
@@ -762,14 +772,6 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
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
@@ -2743,6 +2745,7 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
         virtio_md_pci_pre_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
         hwaddr db_start = 0, db_end = 0;
+        QList *reserved_regions;
         char *resv_prop_str;
 
         if (vms->iommu != VIRT_IOMMU_NONE) {
@@ -2769,9 +2772,9 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
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


