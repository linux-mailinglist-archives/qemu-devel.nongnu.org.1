Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D9C7262A1
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 16:20:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6u1H-0003Me-7O; Wed, 07 Jun 2023 10:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=51561cf95=anthony.perard@citrix.com>)
 id 1q6u1E-0003Dx-Nk
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:20:12 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=51561cf95=anthony.perard@citrix.com>)
 id 1q6u1B-0003g5-Od
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1686147609;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FL0kczg1AEWFFnOGZrrfsv4UULDPFWhofp92N3+6x0s=;
 b=SDVICLXHMY2/pKOTpOWr2/0FPbb48+hnG+iMTHcrSYnpVgGsHbpHCp3g
 c9OGgLVOaQasIvYxQsqef+yWzXu1EJOMxbJ93OHigdQOsgVFbe1GmF5qU
 eQ/kkK7Y37QpvelgGm/BG3Pm9iigKmgY83MTSVdGXWGAIdNG+brzvlxG7 k=;
Authentication-Results: esa3.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 111938275
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:xv6ixqDF3YpUfhVW/yjjw5YqxClBgxIJ4kV8jS/XYbTApGl3hTUCy
 TMdWW2AMqyKM2DzKIh2Ydm19UIDuJbXnNFkQQY4rX1jcSlH+JHPbTi7wuUcHAvJd5GeExg3h
 yk6QoOdRCzhZiaE/n9BCpC48T8nk/nOHuGmYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArIs
 t7pyyHlEAbNNwVcbCRMs8pvlDs15K6p4G1A4QRkDRx2lAS2e0c9Xcp3yZ6ZdxMUcqEMdsamS
 uDKyq2O/2+x13/B3fv8z94X2mVTKlLjFVDmZkh+AsBOsTAbzsAG6Y4pNeJ0VKtio27hc+ada
 jl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CA6IoKvn3bEmp1T4E8K0YIwws1FJH5W7
 9ghNGowaUm/le2skeyJc7w57igjBJGD0II3v3hhyXfSDOo8QICFSKLPjTNa9G5u3IYUR6+YP
 pdHL2M1N3wsYDUWUrsTIJs4gOevgGi5azBCoUiZjaE2/3LS3Ep6172F3N/9I4XTFJ4FxBnFz
 o7A12LLJSkiHYGY8AKA3SiGr+vFlzngZatHQdVU8dY12QbOlwT/EiY+TFa+vLy1h1CzX/pZL
 Eob/DdoqrI9nGSwTtT7QxCpiHGBtx8YHdFXFoUHBBqlk/SOpVzDXy5dE2AHMYZ93CMredA0/
 meirfb2HSZLiaHPdHXEyqWbt2LsCxFAeAfuehQ4ZQcC5tDipqQ6gRTOUstvHcaJszHlJd3j6
 2vU9XZj3t3/meZOjvzmpg6f31pAs7CTFmYIChPrsnVJB++TTKqsfMSW5FfS9p6sx67JHwDa7
 BDodyVzhd3i7K1hdgTXGI3h/5nzvZ5p1QEwZnYxd6TNDxz3pxaekXl4uVmS3ntBPMceYiPOa
 0TOow5X75I7FCL0PfEvPNzrV597kfGI+THZuhb8NIImjn9ZLlbvwc2TTRTIgzCFfLYEz8nTx
 qt3ge7zVC1HWMyLPRK9RvsH0K9D+8zN7Tq7eHwP9Dz+ieD2TCfMGd843K6mMrhRAFWs/F+Er
 L6y9qKil31ibQEJSnePrN9Ndw1QdBDWx/ne8qRqSwJKGSI+cElJNhMb6e95E2C5t8y5Ttv1w
 0w=
IronPort-HdrOrdr: A9a23:Y6hsCqhzpCTaHPK2PCIl9BkOkHBQXtQji2hC6mlwRA09TyX4ra
 yTdZEgviMc5wx/ZJhNo7690cu7IU80hKQV3WB5B97LNmTbUQCTXeJfBOXZsljdMhy72ulB1b
 pxN4hSYeeAaWSSVPyKgjWFLw==
X-Talos-CUID: 9a23:Dx0RwmF9wxrF4tQ2qmJf33wxBdg/VkTBlkrXenOqBnw4Fo+sHAo=
X-Talos-MUID: 9a23:ADENMARPe3b4GfDmRXTqthZaDO415J2WDW9Xu7wCscOeLhFZbmI=
X-IronPort-AV: E=Sophos;i="6.00,224,1681185600"; d="scan'208";a="111938275"
To: <qemu-devel@nongnu.org>
CC: Bernhard Beschow <shentey@gmail.com>, Anthony PERARD
 <anthony.perard@citrix.com>
Subject: [PULL 08/12] hw/isa/piix3: Wire up Xen PCI IRQ handling outside of
 PIIX3
Date: Wed, 7 Jun 2023 15:18:35 +0100
Message-ID: <20230607141839.48422-9-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230607141839.48422-1-anthony.perard@citrix.com>
References: <20230607141839.48422-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=216.71.145.155;
 envelope-from=prvs=51561cf95=anthony.perard@citrix.com;
 helo=esa3.hc3370-68.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  Anthony PERARD <anthony.perard@citrix.com>
From:  Anthony PERARD via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Bernhard Beschow <shentey@gmail.com>

xen_intx_set_irq() doesn't depend on PIIX3State. In order to resolve
TYPE_PIIX3_XEN_DEVICE and in order to make Xen agnostic about the
precise south bridge being used, set up Xen's PCI IRQ handling of PIIX3
in the board.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
Tested-by: Chuck Zmudzinski <brchuckz@aol.com>
Message-Id: <20230312120221.99183-4-shentey@gmail.com>
Message-Id: <20230403074124.3925-5-shentey@gmail.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/i386/pc_piix.c | 13 +++++++++++++
 hw/isa/piix3.c    | 24 +-----------------------
 2 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index d5b0dcd1fe..11af191513 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -71,6 +71,7 @@
 #include "kvm/kvm-cpu.h"
 
 #define MAX_IDE_BUS 2
+#define XEN_IOAPIC_NUM_PIRQS 128ULL
 
 #ifdef CONFIG_IDE_ISA
 static const int ide_iobase[MAX_IDE_BUS] = { 0x1f0, 0x170 };
@@ -238,6 +239,18 @@ static void pc_init1(MachineState *machine,
         pcms->bus = pci_bus;
 
         pci_dev = pci_create_simple_multifunction(pci_bus, -1, true, type);
+
+        if (xen_enabled()) {
+            /*
+             * Xen supports additional interrupt routes from the PCI devices to
+             * the IOAPIC: the four pins of each PCI device on the bus are also
+             * connected to the IOAPIC directly.
+             * These additional routes can be discovered through ACPI.
+             */
+            pci_bus_irqs(pci_bus, xen_intx_set_irq, pci_dev,
+                         XEN_IOAPIC_NUM_PIRQS);
+        }
+
         piix3 = PIIX3_PCI_DEVICE(pci_dev);
         piix3->pic = x86ms->gsi;
         piix3_devfn = piix3->dev.devfn;
diff --git a/hw/isa/piix3.c b/hw/isa/piix3.c
index 800b80f2bb..0b7e9ade0d 100644
--- a/hw/isa/piix3.c
+++ b/hw/isa/piix3.c
@@ -35,8 +35,6 @@
 #include "migration/vmstate.h"
 #include "hw/acpi/acpi_aml_interface.h"
 
-#define XEN_IOAPIC_NUM_PIRQS    128ULL
-
 static void piix3_set_irq_pic(PIIX3State *piix3, int pic_irq)
 {
     qemu_set_irq(piix3->pic[pic_irq],
@@ -403,32 +401,12 @@ static const TypeInfo piix3_info = {
     .class_init    = piix3_class_init,
 };
 
-static void piix3_xen_realize(PCIDevice *dev, Error **errp)
-{
-    ERRP_GUARD();
-    PIIX3State *piix3 = PIIX3_PCI_DEVICE(dev);
-    PCIBus *pci_bus = pci_get_bus(dev);
-
-    piix3_realize(dev, errp);
-    if (*errp) {
-        return;
-    }
-
-    /*
-     * Xen supports additional interrupt routes from the PCI devices to
-     * the IOAPIC: the four pins of each PCI device on the bus are also
-     * connected to the IOAPIC directly.
-     * These additional routes can be discovered through ACPI.
-     */
-    pci_bus_irqs(pci_bus, xen_intx_set_irq, piix3, XEN_IOAPIC_NUM_PIRQS);
-}
-
 static void piix3_xen_class_init(ObjectClass *klass, void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->config_write = piix3_write_config_xen;
-    k->realize = piix3_xen_realize;
+    k->realize = piix3_realize;
 }
 
 static const TypeInfo piix3_xen_info = {
-- 
Anthony PERARD


