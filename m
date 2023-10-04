Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 663BD7B803F
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 15:10:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo1cE-0003cS-PE; Wed, 04 Oct 2023 09:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qo1c6-0003b7-Tj
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:08:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qo1c5-0000Sg-B5
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696424908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3km9WgMJMBDYx4GSd/AoetH8/KDTne0nMk4m9oKxwpA=;
 b=BAHh17c98SWj2+R2zDtq3DnKslu3JAEcp8STFPzKCtoCX/FHnXYCItepgltAUFYyvZWdSk
 rWk63Lzqg6lqBr6LHRlhTn0XQGn56jlbHCWKmTI5jvo1htO4bwKg+WnoQQGK9sUxcEzd54
 0QSm9ZUNDTskzY+/2AAK3Sa869Ypnz0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-195-wAYwQ4ARNCK41T7YIRBT_Q-1; Wed, 04 Oct 2023 09:08:25 -0400
X-MC-Unique: wAYwQ4ARNCK41T7YIRBT_Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2909811E91;
 Wed,  4 Oct 2023 13:08:24 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 959422026D4B;
 Wed,  4 Oct 2023 13:08:23 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
	qemu-trivial@nongnu.org
Subject: [PATCH v2] hw/usb: Silence compiler warnings in USB code when
 compiling with -Wshadow
Date: Wed,  4 Oct 2023 15:08:22 +0200
Message-ID: <20231004130822.113343-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Rename variables or remove nested definitions where it makes sense,
so that we can finally compile the USB code with "-Wshadow", too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Fix the warning in host-libusb.c, too

 hw/usb/desc.c        |  2 +-
 hw/usb/dev-hub.c     |  8 ++++----
 hw/usb/dev-storage.c |  6 +++---
 hw/usb/hcd-xhci.c    | 10 +++++-----
 hw/usb/host-libusb.c |  2 +-
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/usb/desc.c b/hw/usb/desc.c
index 7f6cc2f99b..f2bdc05a95 100644
--- a/hw/usb/desc.c
+++ b/hw/usb/desc.c
@@ -227,7 +227,7 @@ int usb_desc_endpoint(const USBDescEndpoint *ep, int flags,
     }
 
     if (superlen) {
-        USBDescriptor *d = (void *)(dest + bLength);
+        d = (void *)(dest + bLength);
 
         d->bLength                       = 0x06;
         d->bDescriptorType               = USB_DT_ENDPOINT_COMPANION;
diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index a6b50dbc8d..5703e0e826 100644
--- a/hw/usb/dev-hub.c
+++ b/hw/usb/dev-hub.c
@@ -402,7 +402,7 @@ static void usb_hub_handle_control(USBDevice *dev, USBPacket *p,
         {
             unsigned int n = index - 1;
             USBHubPort *port;
-            USBDevice *dev;
+            USBDevice *pdev;
 
             trace_usb_hub_set_port_feature(s->dev.addr, index,
                                            feature_name(value));
@@ -411,7 +411,7 @@ static void usb_hub_handle_control(USBDevice *dev, USBPacket *p,
                 goto fail;
             }
             port = &s->ports[n];
-            dev = port->port.dev;
+            pdev = port->port.dev;
             switch(value) {
             case PORT_SUSPEND:
                 port->wPortStatus |= PORT_STAT_SUSPEND;
@@ -419,8 +419,8 @@ static void usb_hub_handle_control(USBDevice *dev, USBPacket *p,
             case PORT_RESET:
                 usb_hub_port_set(port, PORT_STAT_RESET);
                 usb_hub_port_clear(port, PORT_STAT_RESET);
-                if (dev && dev->attached) {
-                    usb_device_reset(dev);
+                if (pdev && pdev->attached) {
+                    usb_device_reset(pdev);
                     usb_hub_port_set(port, PORT_STAT_ENABLE);
                 }
                 usb_wakeup(s->intr, 0);
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index e3bcffb3e0..a496c811a7 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -403,7 +403,7 @@ static void usb_msd_handle_data(USBDevice *dev, USBPacket *p)
     struct usb_msd_cbw cbw;
     uint8_t devep = p->ep->nr;
     SCSIDevice *scsi_dev;
-    uint32_t len;
+    int len;
 
     if (s->needs_reset) {
         p->status = USB_RET_STALL;
@@ -465,7 +465,7 @@ static void usb_msd_handle_data(USBDevice *dev, USBPacket *p)
                 usb_msd_copy_data(s, p);
             }
             if (le32_to_cpu(s->csw.residue)) {
-                int len = p->iov.size - p->actual_length;
+                len = p->iov.size - p->actual_length;
                 if (len) {
                     usb_packet_skip(p, len);
                     if (len > s->data_len) {
@@ -526,7 +526,7 @@ static void usb_msd_handle_data(USBDevice *dev, USBPacket *p)
                 usb_msd_copy_data(s, p);
             }
             if (le32_to_cpu(s->csw.residue)) {
-                int len = p->iov.size - p->actual_length;
+                len = p->iov.size - p->actual_length;
                 if (len) {
                     usb_packet_skip(p, len);
                     if (len > s->data_len) {
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 324177ad5d..4b60114207 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -217,10 +217,10 @@ enum {
     (((data) >> field##_SHIFT) & field##_MASK)
 
 #define set_field(data, newval, field) do {                     \
-        uint32_t val = *data;                                   \
-        val &= ~(field##_MASK << field##_SHIFT);                \
-        val |= ((newval) & field##_MASK) << field##_SHIFT;      \
-        *data = val;                                            \
+        uint32_t val_ = *data;                                  \
+        val_ &= ~(field##_MASK << field##_SHIFT);               \
+        val_ |= ((newval) & field##_MASK) << field##_SHIFT;     \
+        *data = val_;                                           \
     } while (0)
 
 typedef enum EPType {
@@ -1894,7 +1894,7 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
     }
 
     if (epctx->retry) {
-        XHCITransfer *xfer = epctx->retry;
+        xfer = epctx->retry;
 
         trace_usb_xhci_xfer_retry(xfer);
         assert(xfer->running_retry);
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index f500db85ab..d7060a42d5 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -1010,7 +1010,7 @@ static int usb_host_open(USBHostDevice *s, libusb_device *dev, int hostfd)
          * Speeds are defined in linux/usb/ch9.h, file not included
          * due to name conflicts.
          */
-        int rc = ioctl(hostfd, USBDEVFS_GET_SPEED, NULL);
+        rc = ioctl(hostfd, USBDEVFS_GET_SPEED, NULL);
         switch (rc) {
         case 1: /* low */
             libusb_speed = LIBUSB_SPEED_LOW;
-- 
2.41.0


