Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC5D74F3A2
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 17:36:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJFOe-0007y3-O9; Tue, 11 Jul 2023 11:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qJFOP-0007rS-T1
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 11:35:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qJFOL-0005n9-U2
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 11:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689089703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YuSCIQO9rXBFSfOOQlk2HmFXz7anBKMb7iNXVP+qRqU=;
 b=I24Q76mpYT6WLaziHNLn2/Y0i/P2DUo+B4fQkSip0Yqn/fV/kDWT3t5Qgb97fxbal95pxn
 a20Xo+pl8tl8tr8oaULZZMAy5qd+0YR2CR4AKVl++UnhrIs84jrmps6GJ91c7QCgFX/Pdc
 zeelupVe1V7YE6sm6tT8yzFfPpy8GVM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-1A2A0k3dNAynIhHkTdXDcA-1; Tue, 11 Jul 2023 11:35:00 -0400
X-MC-Unique: 1A2A0k3dNAynIhHkTdXDcA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB6391C08786;
 Tue, 11 Jul 2023 15:34:59 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6EEC1C09A09;
 Tue, 11 Jul 2023 15:34:57 +0000 (UTC)
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
 Gavin Shan <gshan@redhat.com>, Mario Casquero <mcasquer@redhat.com>
Subject: [PATCH v4 4/7] virtio-md-pci: Handle unplug of virtio based memory
 devices
Date: Tue, 11 Jul 2023 17:34:42 +0200
Message-ID: <20230711153445.514112-5-david@redhat.com>
In-Reply-To: <20230711153445.514112-1-david@redhat.com>
References: <20230711153445.514112-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
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

While we fence unplug requests from the outside, the VM can still
trigger unplug of virtio based memory devices, for example, in Linux
doing on a virtio-mem-pci device:
    # echo 0 > /sys/bus/pci/slots/3/power

While doing that is not really expected to work without harming the
guest OS (e.g., removing a virtio-mem device while it still provides
memory), let's make sure that we properly handle it on the QEMU side.

We'll add support for unplugging of virtio-mem devices in some
configurations next.

Tested-by: Mario Casquero <mcasquer@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-md-pci.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-md-pci.c b/hw/virtio/virtio-md-pci.c
index e849c3131d..a22a259e2d 100644
--- a/hw/virtio/virtio-md-pci.c
+++ b/hw/virtio/virtio-md-pci.c
@@ -14,6 +14,7 @@
 #include "hw/virtio/virtio-md-pci.h"
 #include "hw/mem/memory-device.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 
 void virtio_md_pci_pre_plug(VirtIOMDPCI *vmd, MachineState *ms, Error **errp)
 {
@@ -74,7 +75,27 @@ void virtio_md_pci_unplug_request(VirtIOMDPCI *vmd, MachineState *ms,
 
 void virtio_md_pci_unplug(VirtIOMDPCI *vmd, MachineState *ms, Error **errp)
 {
-    /* We don't support hot unplug of virtio based memory devices */
+    DeviceState *dev = DEVICE(vmd);
+    HotplugHandler *bus_handler = qdev_get_bus_hotplug_handler(dev);
+    MemoryDeviceState *md = MEMORY_DEVICE(vmd);
+    Error *local_err = NULL;
+
+    /* Unplug the memory device while it is still realized. */
+    memory_device_unplug(md, ms);
+
+    if (bus_handler) {
+        hotplug_handler_unplug(bus_handler, dev, &local_err);
+        if (local_err) {
+            /* Not expected to fail ... but still try to recover. */
+            memory_device_plug(md, ms);
+            error_propagate(errp, local_err);
+            return;
+        }
+    } else {
+        /* Very unexpected, but let's just try to do the right thing. */
+        warn_report("Unexpected unplug of virtio based memory device");
+        qdev_unrealize(dev);
+    }
 }
 
 static const TypeInfo virtio_md_pci_info = {
-- 
2.41.0


