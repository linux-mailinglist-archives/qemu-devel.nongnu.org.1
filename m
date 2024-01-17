Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CD1830206
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 10:17:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ22C-0008TH-3I; Wed, 17 Jan 2024 04:16:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQ22A-0008T7-Cb
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 04:16:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQ228-0006d1-Cl
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 04:16:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705482987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WnWfoHy7+zLZw2Fi8Yxm9dlFqdV0ueomxrtZBCoFXMs=;
 b=A48WnUenL7JrfevIIYrhIxY44Z7TMoi4l0mwKY9sKyuPlDzL8AySpSklHPlsB4EQzn6qAV
 yFTFtE+x1Z2HEyYCnmMzpiBS9Ied0+sRCyJRxKSalwAu6/HkPj/KrvzKoDfPL0+BI248FL
 TQvdGM02sgwOd5hj0OCslQHIsesTd38=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-m77RcFeeOYmcmRH6b4PzxA-1; Wed, 17 Jan 2024 04:16:24 -0500
X-MC-Unique: m77RcFeeOYmcmRH6b4PzxA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE99D85A588
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 09:16:23 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B31F72166B32;
 Wed, 17 Jan 2024 09:16:19 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, peterx@redhat.com,
 YangHang Liu <yanghliu@redhat.com>
Subject: [PATCH 4/4] intel_iommu: Reset vIOMMU at the last stage of system
 reset
Date: Wed, 17 Jan 2024 17:15:59 +0800
Message-ID: <20240117091559.144730-5-peterx@redhat.com>
In-Reply-To: <20240117091559.144730-1-peterx@redhat.com>
References: <20240117091559.144730-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

From: Peter Xu <peterx@redhat.com>

We got report from Yanghang Liu on an unexpected host DMA error when system
resets with VFIO attached to vIOMMU in the VM context.  Alex Williamson
quickly spot that there can be ordering issues on resets.  A further test
verified that the issue is indeed caused by such wrong ordering.

vIOMMU is a fundamentally infrustructural device, its reset is currently
problematic because no ordering is guaranteed against other PCI devices
which may DMA through the vIOMMU device.

The reset order is tricky, not only because it's current representation as
a normal "-device" (so it kind of follow the qdev tree depth-first reset,
but at a wrong place in the qtree; ideally it should be the parent
somewhere for all pci buses, or just part of pci host bridge), but also
because customized device reset hooks registered over the system reset
framework, so that the ordering of the vIOMMU reset is not guaranteed.

For example, VFIO can register its reset hook with vfio_reset_handler() if
some device does not support FLR.  That will not so far follow the
depth-first travelsal reset mechanism provided by QEMU reset framework.

To remedy both of the issues with limited code changes, leverage the newly
introduced reset stage framework to reset vIOMMUs at the last stage of the
rest devices.  More information can be found in the comments in the patch,
which I decided to persist even with the code to make the problem even
clearer (with potential TODOs for the future, if possible).

Buglink: https://issues.redhat.com/browse/RHEL-7188
Analyzed-by: Alex Williamson <alex.williamson@redhat.com>
Reported-by: YangHang Liu <yanghliu@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 54 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 8b467cbbd2..5a8fbcad7a 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -35,6 +35,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/dma.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/reset.h"
 #include "hw/i386/apic_internal.h"
 #include "kvm/kvm_i386.h"
 #include "migration/vmstate.h"
@@ -4086,7 +4087,7 @@ static void vtd_init(IntelIOMMUState *s)
 /* Should not reset address_spaces when reset because devices will still use
  * the address space they got at first (won't ask the bus again).
  */
-static void vtd_reset(DeviceState *dev)
+static void vtd_reset(void *dev)
 {
     IntelIOMMUState *s = INTEL_IOMMU_DEVICE(dev);
 
@@ -4242,7 +4243,6 @@ static void vtd_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     X86IOMMUClass *x86_class = X86_IOMMU_DEVICE_CLASS(klass);
 
-    dc->reset = vtd_reset;
     dc->vmsd = &vtd_vmstate;
     device_class_set_props(dc, vtd_properties);
     dc->hotpluggable = false;
@@ -4254,10 +4254,60 @@ static void vtd_class_init(ObjectClass *klass, void *data)
     dc->desc = "Intel IOMMU (VT-d) DMA Remapping device";
 }
 
+static void vtd_instance_init(Object *obj)
+{
+    IntelIOMMUState *s = INTEL_IOMMU_DEVICE(obj);
+
+    /*
+     * vIOMMU reset may require proper ordering with other devices.  There
+     * are two complexities so that normal DeviceState.reset() may not
+     * work properly for vIOMMUs:
+     *
+     * (1) Device depth-first reset hierachy doesn't yet work for vIOMMUs
+     *     (reference: resettable_cold_reset_fn())
+     *
+     *     Currently, vIOMMU devices are created as normal '-device'
+     *     cmdlines.  It means in many ways it has the same attributes with
+     *     most of the rest devices, even if the rest devices should
+     *     logically be under control of the vIOMMU unit.
+     *
+     *     One side effect of it is vIOMMU devices will be currently put
+     *     randomly under qdev tree hierarchy, which is the source of
+     *     device reset ordering in current QEMU (depth-first traversal).
+     *     It means vIOMMU now can be reset before some devices.  For fully
+     *     emulated devices that's not a problem, because the traversal
+     *     holds BQL for the whole process.  However it is a problem if DMA
+     *     can happen without BQL, like VFIO, vDPA or remote device process.
+     *
+     *     TODO: one ideal solution can be that we make vIOMMU the parent
+     *     of the whole pci host bridge.  Hence vIOMMU can be reset after
+     *     all the devices are reset and quiesced.
+     *
+     * (2) Some devices register its own reset functions
+     *
+     *     Even if above issue solved, if devices register its own reset
+     *     functions for some reason via QEMU reset hooks, vIOMMU can still
+     *     be reset before the device. One example is vfio_reset_handler()
+     *     where FLR is not supported on the device.
+     *
+     *     TODO: merge relevant reset functions into the device tree reset
+     *     framework.
+     *
+     * Neither of the above TODO may be trivial.  To make it work for now,
+     * leverage reset stages and reset vIOMMU always at latter stage of the
+     * default.  It means it needs to be reset after at least:
+     *
+     *   - resettable_cold_reset_fn(): machine qdev tree reset
+     *   - vfio_reset_handler():       VFIO reset for !FLR
+     */
+    qemu_register_reset_one(vtd_reset, s, false, 1);
+}
+
 static const TypeInfo vtd_info = {
     .name          = TYPE_INTEL_IOMMU_DEVICE,
     .parent        = TYPE_X86_IOMMU_DEVICE,
     .instance_size = sizeof(IntelIOMMUState),
+    .instance_init = vtd_instance_init,
     .class_init    = vtd_class_init,
 };
 
-- 
2.43.0


