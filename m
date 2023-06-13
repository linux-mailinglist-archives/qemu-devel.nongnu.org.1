Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 223F472E6A6
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 17:05:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q95Zx-00069m-67; Tue, 13 Jun 2023 11:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q95Y5-0003xL-87
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 11:03:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q95Xf-00007L-Hq
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 11:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686668562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bahah386mm2D+G3KkVQO5tZBeu6vtnpcbnvTurX56Iw=;
 b=PX3Jojt3KF9hn2AdDc80a1j3GKGrRjhzyRhQR9yuRQJD7jdQF7mWeJiuZegUvdfnb1T/k4
 6Kquj9R405cWPIz55ySUPjM7+HYfDZ5lyEI/qwzQdhhEdEinic9g0vU+CvtuyDfsylo74z
 9T6wsybw32r10mKd86FDU1lHnD87ExA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-gCXSHHdDMsmRNrSC_DHu6g-1; Tue, 13 Jun 2023 11:02:38 -0400
X-MC-Unique: gCXSHHdDMsmRNrSC_DHu6g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 738C98117B4;
 Tue, 13 Jun 2023 15:02:16 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.192.249])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C91A740C20F5;
 Tue, 13 Jun 2023 15:02:14 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 Gavin Shan <gshan@redhat.com>
Subject: [PATCH v1 2/5] arm/virt: Properly handle unplug of virtio based
 memory devices
Date: Tue, 13 Jun 2023 17:02:07 +0200
Message-Id: <20230613150210.449406-3-david@redhat.com>
In-Reply-To: <20230613150210.449406-1-david@redhat.com>
References: <20230613150210.449406-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

While we fence unplug requests from the outside, the VM can still
trigger unplug of virtio based memory devices, for example, in Linux
doing:
    # echo 0 > /sys/bus/pci/slots/3/power

While doing that is not really expected to work without harming the
guest OS (e.g., removing a virtio-mem device while it still provides
memory), let's make sure that we properly handle it on the QEMU side.

We'll support unplugging of virtio-mem devices in some configurations
next.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/arm/virt.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9b9f7d9c68..ed5c3c8fc4 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2794,6 +2794,30 @@ static void virt_virtio_md_pci_plug(HotplugHandler *hotplug_dev,
     error_propagate(errp, local_err);
 }
 
+static void virt_virtio_md_pci_unplug(HotplugHandler *hotplug_dev,
+                                      DeviceState *dev, Error **errp)
+{
+    HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
+    Error *local_err = NULL;
+
+    /* Unplug the memory device while it is still realized. */
+    memory_device_unplug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
+
+    if (hotplug_dev2) {
+        hotplug_handler_unplug(hotplug_dev2, dev, &local_err);
+        if (local_err) {
+            /* Not expected to fail ... but still try to recover. */
+            memory_device_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
+            error_propagate(errp, local_err);
+            return;
+        }
+    } else {
+        /* Very unexpected, but let's just try to do the right thing. */
+        warn_report("Unexpected unplug of virtio based memory device");
+        qdev_unrealize(dev);
+    }
+}
+
 static void virt_virtio_md_pci_unplug_request(HotplugHandler *hotplug_dev,
                                               DeviceState *dev, Error **errp)
 {
@@ -2932,6 +2956,8 @@ static void virt_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         virt_dimm_unplug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
+        virt_virtio_md_pci_unplug(hotplug_dev, dev, errp);
     } else {
         error_setg(errp, "virt: device unplug for unsupported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
-- 
2.40.1


