Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FAA74F3C6
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 17:39:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJFS0-0005fu-Ju; Tue, 11 Jul 2023 11:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qJFRy-0005fI-MP
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 11:38:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qJFRx-00071D-6L
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 11:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689089926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fi7JfruppMfky0aOjE2GJMkpq4aLQborK4itS9FQ3VQ=;
 b=F9d7uyHR9sfYjGduBKk3h1uFKsMU77GbLRXD7Quq5+amaG41X0PF2Eecfww3ROKINZLBsP
 JNaAnClLGzq9sXiMO3EqAS0/+qXm9yWLM/4Sjw4+WZpE/W3mfmVvsEEYvV0XVbmX+SpDp1
 xFbcBEhYITNXYXLWSXzKrIWhJIOjCJQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-Y1486YujMdiPyXoyhC5OvQ-1; Tue, 11 Jul 2023 11:35:31 -0400
X-MC-Unique: Y1486YujMdiPyXoyhC5OvQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 658B5185A794;
 Tue, 11 Jul 2023 15:35:08 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAEFDC51488;
 Tue, 11 Jul 2023 15:35:05 +0000 (UTC)
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
Subject: [PATCH v4 7/7] virtio-mem-pci: Device unplug support
Date: Tue, 11 Jul 2023 17:34:45 +0200
Message-ID: <20230711153445.514112-8-david@redhat.com>
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

Let's support device unplug by forwarding the unplug_request_check()
callback to the virtio-mem device.

Further, disallow changing the requested-size once an unplug request is
pending.

Disallowing requested-size changes handles corner cases such as
(1) pausing the VM (2) requesting device unplug and (3) adjusting the
requested size. If the VM would plug memory (due to the requested size
change) before processing the unplug request, we would be in trouble.

Tested-by: Mario Casquero <mcasquer@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-mem-pci.c | 49 +++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio-mem-pci.c b/hw/virtio/virtio-mem-pci.c
index 2ef0f07630..c4597e029e 100644
--- a/hw/virtio/virtio-mem-pci.c
+++ b/hw/virtio/virtio-mem-pci.c
@@ -93,12 +93,53 @@ static void virtio_mem_pci_size_change_notify(Notifier *notifier, void *data)
     g_free(qom_path);
 }
 
+static void virtio_mem_pci_unplug_request_check(VirtIOMDPCI *vmd, Error **errp)
+{
+    VirtIOMEMPCI *pci_mem = VIRTIO_MEM_PCI(vmd);
+    VirtIOMEM *vmem = &pci_mem->vdev;
+    VirtIOMEMClass *vpc = VIRTIO_MEM_GET_CLASS(vmem);
+
+    vpc->unplug_request_check(vmem, errp);
+}
+
+static void virtio_mem_pci_get_requested_size(Object *obj, Visitor *v,
+                                              const char *name, void *opaque,
+                                              Error **errp)
+{
+    VirtIOMEMPCI *pci_mem = VIRTIO_MEM_PCI(obj);
+
+    object_property_get(OBJECT(&pci_mem->vdev), name, v, errp);
+}
+
+static void virtio_mem_pci_set_requested_size(Object *obj, Visitor *v,
+                                              const char *name, void *opaque,
+                                              Error **errp)
+{
+    VirtIOMEMPCI *pci_mem = VIRTIO_MEM_PCI(obj);
+    DeviceState *dev = DEVICE(obj);
+
+    /*
+     * If we passed virtio_mem_pci_unplug_request_check(), making sure that
+     * the requested size is 0, don't allow modifying the requested size
+     * anymore, otherwise the VM might end up hotplugging memory before
+     * handling the unplug request.
+     */
+    if (dev->pending_deleted_event) {
+        error_setg(errp, "'%s' cannot be changed if the device is in the"
+                   " process of unplug", name);
+        return;
+    }
+
+    object_property_set(OBJECT(&pci_mem->vdev), name, v, errp);
+}
+
 static void virtio_mem_pci_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
     PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
     MemoryDeviceClass *mdc = MEMORY_DEVICE_CLASS(klass);
+    VirtIOMDPCIClass *vmdc = VIRTIO_MD_PCI_CLASS(klass);
 
     k->realize = virtio_mem_pci_realize;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
@@ -111,6 +152,8 @@ static void virtio_mem_pci_class_init(ObjectClass *klass, void *data)
     mdc->get_memory_region = virtio_mem_pci_get_memory_region;
     mdc->fill_device_info = virtio_mem_pci_fill_device_info;
     mdc->get_min_alignment = virtio_mem_pci_get_min_alignment;
+
+    vmdc->unplug_request_check = virtio_mem_pci_unplug_request_check;
 }
 
 static void virtio_mem_pci_instance_init(Object *obj)
@@ -135,9 +178,9 @@ static void virtio_mem_pci_instance_init(Object *obj)
                               OBJECT(&dev->vdev), VIRTIO_MEM_BLOCK_SIZE_PROP);
     object_property_add_alias(obj, VIRTIO_MEM_SIZE_PROP, OBJECT(&dev->vdev),
                               VIRTIO_MEM_SIZE_PROP);
-    object_property_add_alias(obj, VIRTIO_MEM_REQUESTED_SIZE_PROP,
-                              OBJECT(&dev->vdev),
-                              VIRTIO_MEM_REQUESTED_SIZE_PROP);
+    object_property_add(obj, VIRTIO_MEM_REQUESTED_SIZE_PROP, "size",
+                        virtio_mem_pci_get_requested_size,
+                        virtio_mem_pci_set_requested_size, NULL, NULL);
 }
 
 static const VirtioPCIDeviceTypeInfo virtio_mem_pci_info = {
-- 
2.41.0


