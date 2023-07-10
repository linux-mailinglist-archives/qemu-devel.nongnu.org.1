Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FEC74D2E2
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 12:08:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qInny-0003qo-3P; Mon, 10 Jul 2023 06:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qInnw-0003ok-7z
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 06:07:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qInnu-0004nT-MX
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 06:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688983658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xfL8k0pPXx9PsE1cz1/9G0cs3ii5MC5h6YnO0QPX1Y0=;
 b=GOje1jIpNWOqGV+rk3CKJNgZud94BDAWJt/G0CKdunGgWXbiDP7rFfzhDr/I3mbI5Gyloz
 bFzq4fCVNCixm0fgKF/3r8gaS4NBlLSPOLj+XbNcw9NujAGUUO7K4pMjzZck2XK9bS3wgO
 l4GlHULaPk/kz8lqD4A9a/SufeyPC4w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-58QOYagYMUuTOmbb3jYjfQ-1; Mon, 10 Jul 2023 06:07:36 -0400
X-MC-Unique: 58QOYagYMUuTOmbb3jYjfQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 77AA73C10145;
 Mon, 10 Jul 2023 10:07:36 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2815C111CA01;
 Mon, 10 Jul 2023 10:07:34 +0000 (UTC)
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
Subject: [PATCH v3 5/7] virtio-md-pci: Support unplug requests for compatible
 devices
Date: Mon, 10 Jul 2023 12:07:12 +0200
Message-ID: <20230710100714.228867-6-david@redhat.com>
In-Reply-To: <20230710100714.228867-1-david@redhat.com>
References: <20230710100714.228867-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Let's support unplug requests for virtio-md-pci devices that provide
a unplug_request_check() callback.

We'll wire that up for virtio-mem-pci next.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-md-pci.c         | 38 +++++++++++++++++++++++++++++--
 include/hw/virtio/virtio-md-pci.h |  3 +++
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-md-pci.c b/hw/virtio/virtio-md-pci.c
index a22a259e2d..62bfb7920b 100644
--- a/hw/virtio/virtio-md-pci.c
+++ b/hw/virtio/virtio-md-pci.c
@@ -69,8 +69,42 @@ void virtio_md_pci_plug(VirtIOMDPCI *vmd, MachineState *ms, Error **errp)
 void virtio_md_pci_unplug_request(VirtIOMDPCI *vmd, MachineState *ms,
                                   Error **errp)
 {
-    /* We don't support hot unplug of virtio based memory devices */
-    error_setg(errp, "virtio based memory devices cannot be unplugged.");
+    VirtIOMDPCIClass *vmdc = VIRTIO_MD_PCI_GET_CLASS(vmd);
+    DeviceState *dev = DEVICE(vmd);
+    HotplugHandler *bus_handler = qdev_get_bus_hotplug_handler(dev);
+    HotplugHandlerClass *hdc;
+    Error *local_err = NULL;
+
+    if (!vmdc->unplug_request_check) {
+        error_setg(errp, "this virtio based memory devices cannot be unplugged");
+        return;
+    }
+
+    if (!bus_handler) {
+        error_setg(errp, "hotunplug of virtio based memory devices not"
+                   "supported on this bus");
+        return;
+    }
+
+    vmdc->unplug_request_check(vmd, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    /*
+     * Forward the async request or turn it into a sync request (handling it
+     * like qdev_unplug()).
+     */
+    hdc = HOTPLUG_HANDLER_GET_CLASS(bus_handler);
+    if (hdc->unplug_request) {
+        hotplug_handler_unplug_request(bus_handler, dev, &local_err);
+    } else {
+        virtio_md_pci_unplug(vmd, ms, &local_err);
+        if (!local_err) {
+            object_unparent(OBJECT(dev));
+        }
+    }
 }
 
 void virtio_md_pci_unplug(VirtIOMDPCI *vmd, MachineState *ms, Error **errp)
diff --git a/include/hw/virtio/virtio-md-pci.h b/include/hw/virtio/virtio-md-pci.h
index f9fa857aec..5912e16674 100644
--- a/include/hw/virtio/virtio-md-pci.h
+++ b/include/hw/virtio/virtio-md-pci.h
@@ -26,6 +26,9 @@ OBJECT_DECLARE_TYPE(VirtIOMDPCI, VirtIOMDPCIClass, VIRTIO_MD_PCI)
 struct VirtIOMDPCIClass {
     /* private */
     VirtioPCIClass parent;
+
+    /* public */
+    void (*unplug_request_check)(VirtIOMDPCI *vmd, Error **errp);
 };
 
 struct VirtIOMDPCI {
-- 
2.41.0


