Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEA5713999
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 15:22:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3GL6-0000c1-VM; Sun, 28 May 2023 09:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q3GL4-0000RZ-8Y
 for qemu-devel@nongnu.org; Sun, 28 May 2023 09:21:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q3GL2-0008JX-LS
 for qemu-devel@nongnu.org; Sun, 28 May 2023 09:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685280095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HgTsG3H8WXNj2yhkjmMhgawp1vfYqsJbnxDReRjTWIU=;
 b=Z1JUkYRiLHx8QwA1X8a21CCoyqpgnSQ4iOFDx1zaIKC0i2ioBy/PhIsmb4Iy+SyXDcmNPd
 E0/am+DjM4hSQ8mDSuaBkbdVm7NEW/Ecs3nInFzWt/4r5HPLpse4kuqEvsMfJXFC+taIbO
 sfNeYa31+gAeUDdDH1Hyq+OD26kJL7M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-IHNZrIoUOPCH7jPP4Q5WTw-1; Sun, 28 May 2023 09:21:32 -0400
X-MC-Unique: IHNZrIoUOPCH7jPP4Q5WTw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F7E4185A78B;
 Sun, 28 May 2023 13:21:32 +0000 (UTC)
Received: from localhost (unknown [10.39.208.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D97040C6CCC;
 Sun, 28 May 2023 13:21:30 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, berrange@redhat.com,
 Eric Blake <eblake@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>
Subject: [PULL 17/19] virtio-input-pci: add virtio-multitouch-pci
Date: Sun, 28 May 2023 17:20:14 +0400
Message-Id: <20230528132016.3218152-18-marcandre.lureau@redhat.com>
In-Reply-To: <20230528132016.3218152-1-marcandre.lureau@redhat.com>
References: <20230528132016.3218152-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.164,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Sergio Lopez <slp@redhat.com>

Add virtio-multitouch-pci, a Multitouch-capable input device, to the
list of devices that can be provided by virtio-input-pci.

Signed-off-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230526112925.38794-5-slp@redhat.com>
---
 hw/virtio/virtio-input-pci.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/virtio-input-pci.c b/hw/virtio/virtio-input-pci.c
index a9d0992389..a53edf46c4 100644
--- a/hw/virtio/virtio-input-pci.c
+++ b/hw/virtio/virtio-input-pci.c
@@ -25,10 +25,11 @@ struct VirtIOInputPCI {
     VirtIOInput vdev;
 };
 
-#define TYPE_VIRTIO_INPUT_HID_PCI "virtio-input-hid-pci"
-#define TYPE_VIRTIO_KEYBOARD_PCI  "virtio-keyboard-pci"
-#define TYPE_VIRTIO_MOUSE_PCI     "virtio-mouse-pci"
-#define TYPE_VIRTIO_TABLET_PCI    "virtio-tablet-pci"
+#define TYPE_VIRTIO_INPUT_HID_PCI  "virtio-input-hid-pci"
+#define TYPE_VIRTIO_KEYBOARD_PCI   "virtio-keyboard-pci"
+#define TYPE_VIRTIO_MOUSE_PCI      "virtio-mouse-pci"
+#define TYPE_VIRTIO_TABLET_PCI     "virtio-tablet-pci"
+#define TYPE_VIRTIO_MULTITOUCH_PCI "virtio-multitouch-pci"
 OBJECT_DECLARE_SIMPLE_TYPE(VirtIOInputHIDPCI, VIRTIO_INPUT_HID_PCI)
 
 struct VirtIOInputHIDPCI {
@@ -102,6 +103,14 @@ static void virtio_tablet_initfn(Object *obj)
                                 TYPE_VIRTIO_TABLET);
 }
 
+static void virtio_multitouch_initfn(Object *obj)
+{
+    VirtIOInputHIDPCI *dev = VIRTIO_INPUT_HID_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_MULTITOUCH);
+}
+
 static const TypeInfo virtio_input_pci_info = {
     .name          = TYPE_VIRTIO_INPUT_PCI,
     .parent        = TYPE_VIRTIO_PCI,
@@ -140,6 +149,13 @@ static const VirtioPCIDeviceTypeInfo virtio_tablet_pci_info = {
     .instance_init = virtio_tablet_initfn,
 };
 
+static const VirtioPCIDeviceTypeInfo virtio_multitouch_pci_info = {
+    .generic_name  = TYPE_VIRTIO_MULTITOUCH_PCI,
+    .parent        = TYPE_VIRTIO_INPUT_HID_PCI,
+    .instance_size = sizeof(VirtIOInputHIDPCI),
+    .instance_init = virtio_multitouch_initfn,
+};
+
 static void virtio_pci_input_register(void)
 {
     /* Base types: */
@@ -150,6 +166,7 @@ static void virtio_pci_input_register(void)
     virtio_pci_types_register(&virtio_keyboard_pci_info);
     virtio_pci_types_register(&virtio_mouse_pci_info);
     virtio_pci_types_register(&virtio_tablet_pci_info);
+    virtio_pci_types_register(&virtio_multitouch_pci_info);
 }
 
 type_init(virtio_pci_input_register)
-- 
2.40.1


