Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F8172E6AC
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 17:06:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q95Z2-0005SW-Kn; Tue, 13 Jun 2023 11:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q95Y5-0003x8-85
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 11:03:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q95Xb-00006E-Jg
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 11:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686668558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SLByoKSRUNv3dV7dNizYLggVY51+m+xD/k+DONQgaeA=;
 b=WBmAVLYP4HgmaedWZXlDD1JpB5uyHiOxJzQmS8vCoyxYC3VN+NDSkVvCXBqgJNB0b4mVlD
 TacDiQHSyydbSXqx+9gv3qieoa/RXid2ebt/YtfKCTtOuHg7dLSq0fGjL/VBlGHS1bLFkJ
 DJkIIE4zb0x28MyZZNb8MQhDNfPgcFk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-9lta-VWbPByDon_FjtwYdA-1; Tue, 13 Jun 2023 11:02:32 -0400
X-MC-Unique: 9lta-VWbPByDon_FjtwYdA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2637E38117F8;
 Tue, 13 Jun 2023 15:02:22 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.192.249])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7BE9940B4CD6;
 Tue, 13 Jun 2023 15:02:20 +0000 (UTC)
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
Subject: [PATCH v1 5/5] arm/virt: Support unplug of virtio-mem-pci devices
Date: Tue, 13 Jun 2023 17:02:10 +0200
Message-Id: <20230613150210.449406-6-david@redhat.com>
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

Let's support unplug of virtio-mem-pci devices by granting (forwarding)
unplug requests if it's safe to unplug a virtio-mem device.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/arm/virt.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ed5c3c8fc4..08d4eef4c1 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2821,10 +2821,38 @@ static void virt_virtio_md_pci_unplug(HotplugHandler *hotplug_dev,
 static void virt_virtio_md_pci_unplug_request(HotplugHandler *hotplug_dev,
                                               DeviceState *dev, Error **errp)
 {
-    /* We don't support hot unplug of virtio based memory devices */
-    error_setg(errp, "virtio based memory devices cannot be unplugged.");
-}
+    HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
+    HotplugHandlerClass *hdc;
+    Error *local_err = NULL;
+
+    if (!hotplug_dev2) {
+        error_setg(errp, "hotunplug of virtio based memory devices not"
+                   "supported on this bus");
+        return;
+    }
+
+    /* Verify whether it is *currently* safe to unplug the virtio-mem device. */
+    g_assert(object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI));
+    virtio_mem_pci_unplug_request_check(VIRTIO_MEM_PCI(dev), &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
+    /*
+     * Forward the async request or turn it into a sync request (handling it
+     * like qdev_unplug()).
+     */
+    hdc = HOTPLUG_HANDLER_GET_CLASS(hotplug_dev2);
+    if (hdc->unplug_request) {
+        hotplug_handler_unplug_request(hotplug_dev2, dev, &local_err);
+    } else {
+        virt_virtio_md_pci_unplug(hotplug_dev, dev, &local_err);
+        if (!local_err) {
+            object_unparent(OBJECT(dev));
+        }
+    }
+}
 
 static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
                                             DeviceState *dev, Error **errp)
-- 
2.40.1


