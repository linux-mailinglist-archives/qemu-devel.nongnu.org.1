Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4547F7CE944
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 22:43:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtDNp-0005OT-9S; Wed, 18 Oct 2023 16:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qtDNN-0004XV-LJ; Wed, 18 Oct 2023 16:42:48 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qtDNK-0001C4-NT; Wed, 18 Oct 2023 16:42:45 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id C98D175607A;
 Wed, 18 Oct 2023 22:42:39 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9F4CE756078; Wed, 18 Oct 2023 22:42:39 +0200 (CEST)
Message-Id: <4095e01f4596e77a478759161ae736f0c398600a.1697661160.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1697661160.git.balaton@eik.bme.hu>
References: <cover.1697661160.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v5 1/4] via-ide: Fix legacy mode emulation
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org,
 philmd@linaro.org, Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
Date: Wed, 18 Oct 2023 22:42:39 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The initial value for BARs were set in reset method for emulating
legacy mode at start but this does not work because PCI code resets
BARs after calling device reset method. Remove this ineffective
default to avoid confusion.

Instead move setting the BARs to a callback on writing the PCI config
regsiter that sets legacy mode (which firmwares needing this mode seem
to do). This does not fully emulate what the data sheet says (which is
not very clear on this) but it implements enough to allow both modes
as used by firmwares and guests on machines we emulate.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ide/via.c | 43 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/hw/ide/via.c b/hw/ide/via.c
index fff23803a6..5a1fe38fb8 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -28,6 +28,7 @@
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
+#include "qemu/range.h"
 #include "sysemu/dma.h"
 #include "hw/isa/vt82c686.h"
 #include "hw/ide/pci.h"
@@ -132,11 +133,6 @@ static void via_ide_reset(DeviceState *dev)
     pci_set_word(pci_conf + PCI_STATUS, PCI_STATUS_FAST_BACK |
                  PCI_STATUS_DEVSEL_MEDIUM);
 
-    pci_set_long(pci_conf + PCI_BASE_ADDRESS_0, 0x000001f0);
-    pci_set_long(pci_conf + PCI_BASE_ADDRESS_1, 0x000003f4);
-    pci_set_long(pci_conf + PCI_BASE_ADDRESS_2, 0x00000170);
-    pci_set_long(pci_conf + PCI_BASE_ADDRESS_3, 0x00000374);
-    pci_set_long(pci_conf + PCI_BASE_ADDRESS_4, 0x0000cc01); /* BMIBA: 20-23h */
     pci_set_long(pci_conf + PCI_INTERRUPT_LINE, 0x0000010e);
 
     /* IDE chip enable, IDE configuration 1/2, IDE FIFO Configuration*/
@@ -159,6 +155,42 @@ static void via_ide_reset(DeviceState *dev)
     pci_set_long(pci_conf + 0xc0, 0x00020001);
 }
 
+static void via_ide_cfg_write(PCIDevice *pd, uint32_t addr,
+                              uint32_t val, int len)
+{
+    pci_default_write_config(pd, addr, val, len);
+    /*
+     * Bits 0 and 2 of the PCI programming interface register are documented to
+     * select between legacy and native mode for the two IDE channels. when the
+     * guest selects legacy mode we reset the PCI BARs to legacy ports which is
+     * their default value. We don't care about setting each channel separately
+     * as no guest is known to do or need that. But only do this when BARs are
+     * unset when writing this register as logs from real hardware show that
+     * setting legacy mode after BARs were set will still use ports set by BARs
+     * not ISA ports (Linux on pegasos2 does this after firmware set native
+     * mode and programmed BARs). If 0x8a is written after reset without
+     * setting BARs then we want legacy ports (this is done by the AmigaOne
+     * firmware). We can't set these in via_ide_reset() because PCI code clears
+     * BARs after calling device reset method.
+     */
+    if (range_covers_byte(addr, len, PCI_CLASS_PROG) &&
+        pd->config[PCI_CLASS_PROG] == 0x8a &&
+        pci_get_long(pd->config + PCI_BASE_ADDRESS_0) ==
+        PCI_BASE_ADDRESS_SPACE_IO) {
+        pci_set_long(pd->config + PCI_BASE_ADDRESS_0, 0x1f0
+                     | PCI_BASE_ADDRESS_SPACE_IO);
+        pci_set_long(pd->config + PCI_BASE_ADDRESS_1, 0x3f4
+                     | PCI_BASE_ADDRESS_SPACE_IO);
+        pci_set_long(pd->config + PCI_BASE_ADDRESS_2, 0x170
+                     | PCI_BASE_ADDRESS_SPACE_IO);
+        pci_set_long(pd->config + PCI_BASE_ADDRESS_3, 0x374
+                     | PCI_BASE_ADDRESS_SPACE_IO);
+        /* BMIBA: 20-23h */
+        pci_set_long(pd->config + PCI_BASE_ADDRESS_4, 0xcc00
+                     | PCI_BASE_ADDRESS_SPACE_IO);
+    }
+}
+
 static void via_ide_realize(PCIDevice *dev, Error **errp)
 {
     PCIIDEState *d = PCI_IDE(dev);
@@ -221,6 +253,7 @@ static void via_ide_class_init(ObjectClass *klass, void *data)
     /* Reason: only works as function of VIA southbridge */
     dc->user_creatable = false;
 
+    k->config_write = via_ide_cfg_write;
     k->realize = via_ide_realize;
     k->exit = via_ide_exitfn;
     k->vendor_id = PCI_VENDOR_ID_VIA;
-- 
2.30.9


