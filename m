Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5787BAEAB
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 00:15:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoWbS-0000pt-4M; Thu, 05 Oct 2023 18:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qoWbP-0000oY-AR; Thu, 05 Oct 2023 18:13:51 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qoWbM-0005tb-P8; Thu, 05 Oct 2023 18:13:51 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 26713757233;
 Fri,  6 Oct 2023 00:13:01 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id F37F675721D; Fri,  6 Oct 2023 00:13:00 +0200 (CEST)
Message-Id: <12ce9caa682545cd43318c4679530202140117c0.1696542537.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1696542537.git.balaton@eik.bme.hu>
References: <cover.1696542537.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 1/3] via-ide: Fix legacy mode emulation
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org,
 philmd@linaro.org, Bernhard Beschow <shentey@gmail.com>,
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
Date: Fri,  6 Oct 2023 00:13:00 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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
BARs after calling device reset method. Additionally the values
written to BARs were also wrong.

Move setting the BARs to a callback on writing the PCI config regsiter
that sets the compatibility mode (which firmwares needing this mode
seem to do) and fix their values to program it to use legacy port
numbers. As noted in a comment, we only do this when the BARs were
unset before, because logs from real machine show this is how real
chip works, even if it contradicts the data sheet which is not very
clear about this.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ide/via.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/hw/ide/via.c b/hw/ide/via.c
index fff23803a6..8186190207 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -132,11 +132,6 @@ static void via_ide_reset(DeviceState *dev)
     pci_set_word(pci_conf + PCI_STATUS, PCI_STATUS_FAST_BACK |
                  PCI_STATUS_DEVSEL_MEDIUM);
 
-    pci_set_long(pci_conf + PCI_BASE_ADDRESS_0, 0x000001f0);
-    pci_set_long(pci_conf + PCI_BASE_ADDRESS_1, 0x000003f4);
-    pci_set_long(pci_conf + PCI_BASE_ADDRESS_2, 0x00000170);
-    pci_set_long(pci_conf + PCI_BASE_ADDRESS_3, 0x00000374);
-    pci_set_long(pci_conf + PCI_BASE_ADDRESS_4, 0x0000cc01); /* BMIBA: 20-23h */
     pci_set_long(pci_conf + PCI_INTERRUPT_LINE, 0x0000010e);
 
     /* IDE chip enable, IDE configuration 1/2, IDE FIFO Configuration*/
@@ -159,6 +154,35 @@ static void via_ide_reset(DeviceState *dev)
     pci_set_long(pci_conf + 0xc0, 0x00020001);
 }
 
+static void via_ide_cfg_write(PCIDevice *pd, uint32_t addr,
+                              uint32_t val, int len)
+{
+    pci_default_write_config(pd, addr, val, len);
+    /*
+     * Only set BARs if they are unset. Logs from real hardware show that
+     * writing class_prog to enable compatibility mode after BARs were set
+     * (possibly by firmware) it will use ports set by BARs not ISA ports
+     * (e.g. pegasos2 Linux does this and calls it non-100% native mode).
+     * But if 0x8a is written after reset without setting BARs then we want
+     * legacy ports (this is done by AmigaOne firmware for example).
+     */
+    if (addr == PCI_CLASS_PROG && val == 0x8a &&
+        pci_get_long(pd->config + PCI_BASE_ADDRESS_0) ==
+        PCI_BASE_ADDRESS_SPACE_IO) {
+        pci_set_long(pd->config + PCI_BASE_ADDRESS_0, 0x1f0
+                     | PCI_BASE_ADDRESS_SPACE_IO);
+        pci_set_long(pd->config + PCI_BASE_ADDRESS_1, 0x3f6
+                     | PCI_BASE_ADDRESS_SPACE_IO);
+        pci_set_long(pd->config + PCI_BASE_ADDRESS_2, 0x170
+                     | PCI_BASE_ADDRESS_SPACE_IO);
+        pci_set_long(pd->config + PCI_BASE_ADDRESS_3, 0x376
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
@@ -221,6 +245,7 @@ static void via_ide_class_init(ObjectClass *klass, void *data)
     /* Reason: only works as function of VIA southbridge */
     dc->user_creatable = false;
 
+    k->config_write = via_ide_cfg_write;
     k->realize = via_ide_realize;
     k->exit = via_ide_exitfn;
     k->vendor_id = PCI_VENDOR_ID_VIA;
-- 
2.30.9


