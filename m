Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 486DFB064B7
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Jul 2025 18:56:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubiwE-0002dZ-RS; Tue, 15 Jul 2025 12:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubier-000700-Ai
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:37:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubieo-0003f0-8m
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752597449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eWvp09WB6lMOzqGEV4dEXfhYU5uV9bqjVNjJ1qbvNg8=;
 b=LjpqteqOaW3pd4jtudArsKOSSa4CfrfwzHWTnukvvhrBTSwHYufL6OH9LHg3SPaJMZgUjk
 zC5U3Bb1fVCCiAtp06WLxeamYsv0vHAMa01Tez3sRn0BUOQg3JfAzZCCAnAqtuJlZS5Enq
 Sb16PmlmauSFpiG9m8Gnrz/ZQagXCsQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-212-W7J13_hYPr2UPkW1pN2F2Q-1; Tue,
 15 Jul 2025 12:37:26 -0400
X-MC-Unique: W7J13_hYPr2UPkW1pN2F2Q-1
X-Mimecast-MFC-AGG-ID: W7J13_hYPr2UPkW1pN2F2Q_1752597445
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60A0319560AA; Tue, 15 Jul 2025 16:37:25 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.160])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AE0153000198; Tue, 15 Jul 2025 16:37:23 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 5/7] vfio/pci: Introduce x-pci-class-code option
Date: Tue, 15 Jul 2025 18:37:01 +0200
Message-ID: <20250715163703.243975-6-clg@redhat.com>
In-Reply-To: <20250715163703.243975-1-clg@redhat.com>
References: <20250715163703.243975-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Tomita Moeko <tomitamoeko@gmail.com>

Introduce x-pci-class-code option to allow users to override PCI class
code of a device, similar to the existing x-pci-vendor-id option. Only
the lower 24 bits of this option are used, though a uint32 is used here
for determining whether the value is valid and set by user.

Additionally, to ensure VGA ranges are only exposed on VGA devices,
pci_register_vga() is now called in vfio_pci_config_setup(), after
the class code override is completed.

This is mainly intended for IGD devices that expose themselves either
as VGA controller (primary display) or Display controller (non-primary
display). The UEFI GOP driver depends on the device reporting a VGA
controller class code (0x030000).

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250708145211.6179-1-tomitamoeko@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h        |  6 ++----
 hw/vfio/pci.c        | 29 +++++++++++++++++++++++++----
 hw/vfio/trace-events |  1 +
 3 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 495fae737d3a2e455e1cc04e062b9860196899be..4aa64611171d310de73d00d6c5be059dcb7bfe49 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -157,6 +157,7 @@ struct VFIOPCIDevice {
     uint32_t device_id;
     uint32_t sub_vendor_id;
     uint32_t sub_device_id;
+    uint32_t class_code;
     uint32_t features;
 #define VFIO_FEATURE_ENABLE_VGA_BIT 0
 #define VFIO_FEATURE_ENABLE_VGA (1 << VFIO_FEATURE_ENABLE_VGA_BIT)
@@ -205,10 +206,7 @@ static inline bool vfio_pci_is(VFIOPCIDevice *vdev, uint32_t vendor, uint32_t de
 
 static inline bool vfio_is_vga(VFIOPCIDevice *vdev)
 {
-    PCIDevice *pdev = &vdev->pdev;
-    uint16_t class = pci_get_word(pdev->config + PCI_CLASS_DEVICE);
-
-    return class == PCI_CLASS_DISPLAY_VGA;
+    return (vdev->class_code >> 8) == PCI_CLASS_DISPLAY_VGA;
 }
 
 /* MSI/MSI-X/INTx */
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 1093b28df7c3f5f37e622e6d76a99ad8d2b7e01e..910042c6c2049fc5ee1e635cc74989769b965b76 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2893,10 +2893,6 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
                           "vfio-vga-io@0x3c0",
                           QEMU_PCI_VGA_IO_HI_SIZE);
 
-    pci_register_vga(&vdev->pdev, &vdev->vga->region[QEMU_PCI_VGA_MEM].mem,
-                     &vdev->vga->region[QEMU_PCI_VGA_IO_LO].mem,
-                     &vdev->vga->region[QEMU_PCI_VGA_IO_HI].mem);
-
     return true;
 }
 
@@ -3228,6 +3224,23 @@ bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
                                               vdev->sub_device_id);
     }
 
+    /*
+     * Class code is a 24-bit value at config space 0x09. Allow overriding it
+     * with any 24-bit value.
+     */
+    if (vdev->class_code != PCI_ANY_ID) {
+        if (vdev->class_code > 0xffffff) {
+            error_setg(errp, "invalid PCI class code provided");
+            return false;
+        }
+        /* Higher 24 bits of PCI_CLASS_REVISION are class code */
+        vfio_add_emulated_long(vdev, PCI_CLASS_REVISION,
+                               vdev->class_code << 8, ~0xff);
+        trace_vfio_pci_emulated_class_code(vbasedev->name, vdev->class_code);
+    } else {
+        vdev->class_code = pci_get_long(pdev->config + PCI_CLASS_REVISION) >> 8;
+    }
+
     /* QEMU can change multi-function devices to single function, or reverse */
     vdev->emulated_config_bits[PCI_HEADER_TYPE] =
                                               PCI_HEADER_TYPE_MULTI_FUNCTION;
@@ -3257,6 +3270,12 @@ bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
 
     vfio_bars_register(vdev);
 
+    if (vdev->vga && vfio_is_vga(vdev)) {
+        pci_register_vga(&vdev->pdev, &vdev->vga->region[QEMU_PCI_VGA_MEM].mem,
+                         &vdev->vga->region[QEMU_PCI_VGA_IO_LO].mem,
+                         &vdev->vga->region[QEMU_PCI_VGA_IO_HI].mem);
+    }
+
     return true;
 }
 
@@ -3643,6 +3662,8 @@ static const Property vfio_pci_dev_properties[] = {
                        sub_vendor_id, PCI_ANY_ID),
     DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
                        sub_device_id, PCI_ANY_ID),
+    DEFINE_PROP_UINT32("x-pci-class-code", VFIOPCIDevice,
+                       class_code, PCI_ANY_ID),
     DEFINE_PROP_UINT32("x-igd-gms", VFIOPCIDevice, igd_gms, 0),
     DEFINE_PROP_UNSIGNED_NODEFAULT("x-nv-gpudirect-clique", VFIOPCIDevice,
                                    nv_gpudirect_clique,
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 8ec0ad0cde064927f58fbd8459413b303d155979..fc6ed230d0c89d4b94e5878043bc23d94dcfe737 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -48,6 +48,7 @@ vfio_pci_emulated_vendor_id(const char *name, uint16_t val) "%s 0x%04x"
 vfio_pci_emulated_device_id(const char *name, uint16_t val) "%s 0x%04x"
 vfio_pci_emulated_sub_vendor_id(const char *name, uint16_t val) "%s 0x%04x"
 vfio_pci_emulated_sub_device_id(const char *name, uint16_t val) "%s 0x%04x"
+vfio_pci_emulated_class_code(const char *name, uint32_t val) "%s 0x%06x"
 
 # pci-quirks.c
 vfio_quirk_rom_in_denylist(const char *name, uint16_t vid, uint16_t did) "%s %04x:%04x"
-- 
2.50.1


