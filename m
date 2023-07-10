Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F34074D2DF
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 12:08:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qInnz-0003r7-Qr; Mon, 10 Jul 2023 06:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qInnx-0003q7-6M
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 06:07:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qInnv-0004nj-RC
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 06:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688983659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yu36KmkVuZ8+kaM0iIdbgFGdigReU0ootcpoyySbSIU=;
 b=QT0IGN1woKXaJN3ytmPS9WrtI9OKyKADmqOej4wK+q7RSwgXWiiDcH7FiFKknitEwF/Kyf
 mZZH0FcqZLHD1CvsqhRk37BtoYLsH9Mp+oKMVe1ZFy+EU8HyD+NgFIIJqjjXGirkOGvejd
 c9hFjFaC0FGiRfYCvorJzpahnK4FM04=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-I-LOTxRlMA2qUNJtOjt9Sg-1; Mon, 10 Jul 2023 06:07:34 -0400
X-MC-Unique: I-LOTxRlMA2qUNJtOjt9Sg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB40E101A54E;
 Mon, 10 Jul 2023 10:07:33 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3FB47111CA01;
 Mon, 10 Jul 2023 10:07:31 +0000 (UTC)
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
Subject: [PATCH v3 4/7] virtio-md-pci: Handle unplug of virtio based memory
 devices
Date: Mon, 10 Jul 2023 12:07:11 +0200
Message-ID: <20230710100714.228867-5-david@redhat.com>
In-Reply-To: <20230710100714.228867-1-david@redhat.com>
References: <20230710100714.228867-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
doing on a virtio-mem-pci device:
    # echo 0 > /sys/bus/pci/slots/3/power

While doing that is not really expected to work without harming the
guest OS (e.g., removing a virtio-mem device while it still provides
memory), let's make sure that we properly handle it on the QEMU side.

We'll add support for unplugging of virtio-mem devices in some
configurations next.

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


