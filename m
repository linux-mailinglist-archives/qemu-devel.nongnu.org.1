Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A48832C4B
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 16:26:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQqkD-0002I0-JM; Fri, 19 Jan 2024 10:25:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQqkB-0002HK-0r
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 10:25:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQqk9-00018i-5B
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 10:25:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705677916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ue6V2H5LKkHuW7rlbvehMGymtu+nZnNJfZcVVMBMdug=;
 b=Q1A8A4ddMX5d4X3NZLcAKUZ9rLsGgpySxEnaaKC5V4G7NkHZtzLyfA8v4QX6VYppwqOnoy
 MSRu6WMQ27tlM04qPyf6wKSrRZcZvE9mGXFScI6bYRfY4xF6ISNkBcFt7RZdjzmvQkGHnD
 dmbVz1u/yF/qU/Q5W/5adAVCPLH1naM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-X6G5Ll0SMQKVYSR2defAwg-1; Fri, 19 Jan 2024 10:25:14 -0500
X-MC-Unique: X6G5Ll0SMQKVYSR2defAwg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A79B868A0D;
 Fri, 19 Jan 2024 15:25:13 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.235])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F70E40D1B60;
 Fri, 19 Jan 2024 15:25:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 03/11] s390x/pci: drive ISM reset from subsystem reset
Date: Fri, 19 Jan 2024 16:24:59 +0100
Message-ID: <20240119152507.55182-4-thuth@redhat.com>
In-Reply-To: <20240119152507.55182-1-thuth@redhat.com>
References: <20240119152507.55182-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
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
---
 include/hw/s390x/s390-pci-bus.h |  1 +
 hw/s390x/s390-pci-bus.c         | 26 +++++++++++++++++---------
 hw/s390x/s390-virtio-ccw.c      |  8 ++++++++
 3 files changed, 26 insertions(+), 9 deletions(-)

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
index eaf61d3640..c99682b07d 100644
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
-- 
2.43.0


