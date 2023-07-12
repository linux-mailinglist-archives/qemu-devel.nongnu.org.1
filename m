Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB237500AA
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 10:03:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJUng-00088b-4s; Wed, 12 Jul 2023 04:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=PzZY=C6=redhat.com=clg@ozlabs.org>)
 id 1qJUnd-00087m-Ms; Wed, 12 Jul 2023 04:02:13 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=PzZY=C6=redhat.com=clg@ozlabs.org>)
 id 1qJUna-0001HZ-9I; Wed, 12 Jul 2023 04:02:13 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4R19Dz6gm5z4wy8;
 Wed, 12 Jul 2023 18:01:55 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4R19Dw5BJdz4wxR;
 Wed, 12 Jul 2023 18:01:52 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v4] kconfig: Add PCIe devices to s390x machines
Date: Wed, 12 Jul 2023 10:01:46 +0200
Message-ID: <20230712080146.839113-1-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=PzZY=C6=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

It is useful to extend the number of available PCIe devices to KVM guests
for passthrough scenarios and also to expose these models to a different
(big endian) architecture. Introduce a new config PCIE_DEVICES to select
models, Intel Ethernet adapters and one USB controller. These devices all
support MSI-X which is a requirement on s390x as legacy INTx are not
supported.

Cc: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---

 There could be a more general use of PCIE_DEVICES

 v4: Introduce PCIE_DEVICES
 v3: PCI -> PCI_EXPRESS
 v2: select -> imply
 
 configs/devices/s390x-softmmu/default.mak | 1 +
 hw/net/Kconfig                            | 4 ++--
 hw/pci/Kconfig                            | 3 +++
 hw/s390x/Kconfig                          | 3 ++-
 hw/usb/Kconfig                            | 2 +-
 5 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/configs/devices/s390x-softmmu/default.mak b/configs/devices/s390x-softmmu/default.mak
index f2287a133f36..2d5ff476e32a 100644
--- a/configs/devices/s390x-softmmu/default.mak
+++ b/configs/devices/s390x-softmmu/default.mak
@@ -7,6 +7,7 @@
 #CONFIG_VFIO_CCW=n
 #CONFIG_VIRTIO_PCI=n
 #CONFIG_WDT_DIAG288=n
+#CONFIG_PCIE_DEVICE=n
 
 # Boards:
 #
diff --git a/hw/net/Kconfig b/hw/net/Kconfig
index 98e00be4f937..7fcc0d7faa29 100644
--- a/hw/net/Kconfig
+++ b/hw/net/Kconfig
@@ -41,12 +41,12 @@ config E1000_PCI
 
 config E1000E_PCI_EXPRESS
     bool
-    default y if PCI_DEVICES
+    default y if PCI_DEVICES || PCIE_DEVICES
     depends on PCI_EXPRESS && MSI_NONBROKEN
 
 config IGB_PCI_EXPRESS
     bool
-    default y if PCI_DEVICES
+    default y if PCI_DEVICES || PCIE_DEVICES
     depends on PCI_EXPRESS && MSI_NONBROKEN
 
 config RTL8139_PCI
diff --git a/hw/pci/Kconfig b/hw/pci/Kconfig
index 77f8b005ffb1..fe70902cd821 100644
--- a/hw/pci/Kconfig
+++ b/hw/pci/Kconfig
@@ -8,6 +8,9 @@ config PCI_EXPRESS
 config PCI_DEVICES
     bool
 
+config PCIE_DEVICES
+    bool
+
 config MSI_NONBROKEN
     # selected by interrupt controllers that do not support MSI,
     # or support it and have a good implementation. See commit
diff --git a/hw/s390x/Kconfig b/hw/s390x/Kconfig
index 454e0ff4b613..4c068d7960b9 100644
--- a/hw/s390x/Kconfig
+++ b/hw/s390x/Kconfig
@@ -5,7 +5,8 @@ config S390_CCW_VIRTIO
     imply VFIO_AP
     imply VFIO_CCW
     imply WDT_DIAG288
-    select PCI
+    imply PCIE_DEVICES
+    select PCI_EXPRESS
     select S390_FLIC
     select S390_FLIC_KVM if KVM
     select SCLPCONSOLE
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index 0ec6def4b8b8..0f486764ed69 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -36,7 +36,7 @@ config USB_XHCI
 
 config USB_XHCI_PCI
     bool
-    default y if PCI_DEVICES
+    default y if PCI_DEVICES || PCIE_DEVICES
     depends on PCI
     select USB_XHCI
 
-- 
2.41.0


