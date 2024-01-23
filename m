Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 407168393A0
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 16:49:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSJ1k-0006EU-LC; Tue, 23 Jan 2024 10:49:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rSJ0m-0003Ss-1C; Tue, 23 Jan 2024 10:48:28 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rSJ0k-0000r1-9F; Tue, 23 Jan 2024 10:48:27 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F17074692D;
 Tue, 23 Jan 2024 18:47:52 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0BF6E69EBC;
 Tue, 23 Jan 2024 18:47:12 +0300 (MSK)
Received: (nullmailer pid 3847942 invoked by uid 1000);
 Tue, 23 Jan 2024 15:47:08 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.1 54/54] s390x/pci: drive ISM reset from subsystem reset
Date: Tue, 23 Jan 2024 18:46:55 +0300
Message-Id: <20240123154708.3847837-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.1-20240123123124@cover.tls.msk.ru>
References: <qemu-stable-8.2.1-20240123123124@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Matthew Rosato <mjrosato@linux.ibm.com>

ISM devices are sensitive to manipulation of the IOMMU, so the ISM device
needs to be reset before the vfio-pci device is reset (triggering a full
UNMAP).  In order to ensure this occurs, trigger ISM device resets from
subsystem_reset before triggering the PCI bus reset (which will also
trigger vfio-pci reset).  This only needs to be done for ISM devices
which were enabled for use by the guest.
Further, ensure that AIF is disabled as part of the reset event.

Fixes: ef1535901a ("s390x: do a subsystem reset before the unprotect on reboot")
Fixes: 03451953c7 ("s390x/pci: reset ISM passthrough devices on shutdown and system reset")
Reported-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <20240118185151.265329-4-mjrosato@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 68c691ca99a2538d6a53a70ce8a9ce06ee307ff1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 347580ebac..3e57d5faca 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -151,20 +151,12 @@ static void s390_pci_shutdown_notifier(Notifier *n, void *opaque)
     pci_device_reset(pbdev->pdev);
 }
 
-static void s390_pci_reset_cb(void *opaque)
-{
-    S390PCIBusDevice *pbdev = opaque;
-
-    pci_device_reset(pbdev->pdev);
-}
-
 static void s390_pci_perform_unplug(S390PCIBusDevice *pbdev)
 {
     HotplugHandler *hotplug_ctrl;
 
     if (pbdev->pft == ZPCI_PFT_ISM) {
         notifier_remove(&pbdev->shutdown_notifier);
-        qemu_unregister_reset(s390_pci_reset_cb, pbdev);
     }
 
     /* Unplug the PCI device */
@@ -1132,7 +1124,6 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
             if (pbdev->pft == ZPCI_PFT_ISM) {
                 pbdev->shutdown_notifier.notify = s390_pci_shutdown_notifier;
                 qemu_register_shutdown_notifier(&pbdev->shutdown_notifier);
-                qemu_register_reset(s390_pci_reset_cb, pbdev);
             }
         } else {
             pbdev->fh |= FH_SHM_EMUL;
@@ -1279,6 +1270,23 @@ static void s390_pci_enumerate_bridge(PCIBus *bus, PCIDevice *pdev,
     pci_default_write_config(pdev, PCI_SUBORDINATE_BUS, s->bus_no, 1);
 }
 
+void s390_pci_ism_reset(void)
+{
+    S390pciState *s = s390_get_phb();
+
+    S390PCIBusDevice *pbdev, *next;
+
+    /* Trigger reset event for each passthrough ISM device currently in-use */
+    QTAILQ_FOREACH_SAFE(pbdev, &s->zpci_devs, link, next) {
+        if (pbdev->interp && pbdev->pft == ZPCI_PFT_ISM &&
+            pbdev->fh & FH_MASK_ENABLE) {
+            s390_pci_kvm_aif_disable(pbdev);
+
+            pci_device_reset(pbdev->pdev);
+        }
+    }
+}
+
 static void s390_pcihost_reset(DeviceState *dev)
 {
     S390pciState *s = S390_PCI_HOST_BRIDGE(dev);
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 7262725d2e..2d6b86624f 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -118,6 +118,14 @@ static void subsystem_reset(void)
     DeviceState *dev;
     int i;
 
+    /*
+     * ISM firmware is sensitive to unexpected changes to the IOMMU, which can
+     * occur during reset of the vfio-pci device (unmap of entire aperture).
+     * Ensure any passthrough ISM devices are reset now, while CPUs are paused
+     * but before vfio-pci cleanup occurs.
+     */
+    s390_pci_ism_reset();
+
     for (i = 0; i < ARRAY_SIZE(reset_dev_types); i++) {
         dev = DEVICE(object_resolve_path_type("", reset_dev_types[i], NULL));
         if (dev) {
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 435e788867..2c43ea123f 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -401,5 +401,6 @@ S390PCIBusDevice *s390_pci_find_dev_by_target(S390pciState *s,
                                               const char *target);
 S390PCIBusDevice *s390_pci_find_next_avail_dev(S390pciState *s,
                                                S390PCIBusDevice *pbdev);
+void s390_pci_ism_reset(void);
 
 #endif
-- 
2.39.2


