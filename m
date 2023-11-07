Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5BF7E411E
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:50:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0MS9-0007yJ-Oe; Tue, 07 Nov 2023 08:49:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0MRq-0007rj-QB
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:48:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0MRp-0007L9-32
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:48:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699364932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3oPG8ghG0XBBbnrTpFlCljk7qZfDTeT88Kb2PJa6mb4=;
 b=COZYuxiCYIEOZFrsgWV3IDOcPvUM9CmoZ2TIj3GA6G9iN3id6TJ8Lje80B3r622R1skrMD
 QmNQFjHBgyRl7V8ae5THaBIBnX5mNBf0JLFlWBt+LeNlBBKu/IwaMucsoYT2U/u/VisXuU
 fWUD/duJxrxAYgL52LybLy7Fs5ElJFo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-vfdtOWmbMh2m6bX2HGm-0w-1; Tue,
 07 Nov 2023 08:48:50 -0500
X-MC-Unique: vfdtOWmbMh2m6bX2HGm-0w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59BA41DD35DA
 for <qemu-devel@nongnu.org>; Tue,  7 Nov 2023 13:48:50 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A04391C0005A;
 Tue,  7 Nov 2023 13:48:49 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com
Subject: [PULL 06/11] hw/arm/virt: Use qdev_prop_set_array()
Date: Tue,  7 Nov 2023 14:48:23 +0100
Message-ID: <20231107134828.35909-7-kwolf@redhat.com>
In-Reply-To: <20231107134828.35909-1-kwolf@redhat.com>
References: <20231107134828.35909-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

Instead of manually setting "foo-len" and "foo[i]" properties, build a
QList and use the new qdev_prop_set_array() helper to set the whole
array property with a single call.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20231030142658.182193-8-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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


