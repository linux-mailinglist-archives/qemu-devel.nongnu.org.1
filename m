Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7071C7EDE97
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 11:34:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Zhc-0004Tu-9W; Thu, 16 Nov 2023 05:34:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r3ZhY-0004TN-Sm; Thu, 16 Nov 2023 05:34:24 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r3ZhX-0006Mw-7Y; Thu, 16 Nov 2023 05:34:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A1do6B7C6RUKP3/eJDsTVMNi3wGlkehd5XlPDy0atpA=; b=dNdi0XFlYxUmq/n/QlF/kGpgVp
 CXKrWrr4fgYDE7DlH9KKaFTnxeBpAwcFJ61PpZwUb8vwLuey4hVOrrWqHg17/fFQb5oGzaR7uuMXh
 t1Yo2hj5b7Hdn2HZ7PGvLk8X8eDBF3OR+BJLkFTzUVOHtP8saiIipNSgb7mAhwpT1IZU1urGjmgvM
 Gb3hTuyfjqXg5V6EWHFJpiWIKeuo7kscA4X9vBa+4A48DhSXRU4DKkTq2tEK6bBnNbGlyxhAcDbG2
 OtERF005WKbYmmcCVRBcbl4Gv8bx+/JQFvsxtQf0mhB8MrXYysswRiXOZqjcL/kPJPZttLOpeD3Vv
 mAPYRXD3OcSZaGCtQSypzt5gtaNuiRuaRnh1aUOE2wTz39gNSNdYl3Zdf2PeexweszoRoYeungemV
 z1iz/wXgzLH2rBQv3UKKcNmIk4ByYiuJIilySiWHEnwBilLNMSYPhUo+wHEuqUryiPMoxaA9hfui/
 u7in8moCLfoEV9MSUujFHBzqvYNfcODPt81eZANpFSFNXPEkflIWtJTkKDc0rWFE6l5TJYpiv15MM
 qUPDdng79haUzbX35PuIRclbtP4oOk1TW3RHW5pIFnru+L7b6LCq4M3Nv/q1BeBjCYOPFs/BMWJ8b
 ZuZNkBDATYD2wnDBGOd7jaWG9abLRki2KoNf72lLs=;
Received: from host86-130-37-248.range86-130.btcentralplus.com
 ([86.130.37.248] helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r3ZhE-0001bP-2E; Thu, 16 Nov 2023 10:34:08 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, balaton@eik.bme.hu, philmd@linaro.org,
 shentey@gmail.com
Date: Thu, 16 Nov 2023 10:33:55 +0000
Message-Id: <20231116103355.588580-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231116103355.588580-1-mark.cave-ayland@ilande.co.uk>
References: <20231116103355.588580-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.248
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 4/4] hw/ide/via: implement legacy/native mode switching
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Allow the VIA IDE controller to switch between both legacy and native modes by
calling pci_ide_update_mode() to reconfigure the device whenever PCI_CLASS_PROG
is updated.

This patch moves the initial setting of PCI_CLASS_PROG from via_ide_realize() to
via_ide_reset(), and removes the direct setting of PCI_INTERRUPT_PIN during PCI
bus reset since this is now managed by pci_ide_update_mode(). This ensures that
the device configuration is always consistent with respect to the currently
selected mode.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ide/via.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/hw/ide/via.c b/hw/ide/via.c
index 87b134083a..47223b1268 100644
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
@@ -128,11 +129,14 @@ static void via_ide_reset(DeviceState *dev)
         ide_bus_reset(&d->bus[i]);
     }
 
+    pci_config_set_prog_interface(pci_conf, 0x8a); /* legacy mode */
+    pci_ide_update_mode(d);
+
     pci_set_word(pci_conf + PCI_COMMAND, PCI_COMMAND_IO | PCI_COMMAND_WAIT);
     pci_set_word(pci_conf + PCI_STATUS, PCI_STATUS_FAST_BACK |
                  PCI_STATUS_DEVSEL_MEDIUM);
 
-    pci_set_long(pci_conf + PCI_INTERRUPT_LINE, 0x0000010e);
+    pci_set_byte(pci_conf + PCI_INTERRUPT_LINE, 0xe);
 
     /* IDE chip enable, IDE configuration 1/2, IDE FIFO Configuration*/
     pci_set_long(pci_conf + 0x40, 0x0a090600);
@@ -154,6 +158,36 @@ static void via_ide_reset(DeviceState *dev)
     pci_set_long(pci_conf + 0xc0, 0x00020001);
 }
 
+static uint32_t via_ide_cfg_read(PCIDevice *pd, uint32_t addr, int len)
+{
+    uint32_t val = pci_default_read_config(pd, addr, len);
+    uint8_t mode = pd->config[PCI_CLASS_PROG];
+
+    if ((mode & 0xf) == 0xa && ranges_overlap(addr, len,
+                                              PCI_BASE_ADDRESS_0, 24)) {
+        /* BARs always read back zero in legacy mode */
+        for (int i = addr; i < addr + len; i++) {
+            if (i >= PCI_BASE_ADDRESS_0 && i < PCI_BASE_ADDRESS_0 + 24) {
+                val &= ~(0xffULL << ((i - addr) << 3));
+            }
+        }
+    }
+
+    return val;
+}
+
+static void via_ide_cfg_write(PCIDevice *pd, uint32_t addr,
+                              uint32_t val, int len)
+{
+    PCIIDEState *d = PCI_IDE(pd);
+
+    pci_default_write_config(pd, addr, val, len);
+
+    if (range_covers_byte(addr, len, PCI_CLASS_PROG)) {
+        pci_ide_update_mode(d);
+    }
+}
+
 static void via_ide_realize(PCIDevice *dev, Error **errp)
 {
     PCIIDEState *d = PCI_IDE(dev);
@@ -161,7 +195,6 @@ static void via_ide_realize(PCIDevice *dev, Error **errp)
     uint8_t *pci_conf = dev->config;
     int i;
 
-    pci_config_set_prog_interface(pci_conf, 0x8a); /* legacy mode */
     pci_set_long(pci_conf + PCI_CAPABILITY_LIST, 0x000000c0);
     dev->wmask[PCI_INTERRUPT_LINE] = 0;
     dev->wmask[PCI_CLASS_PROG] = 5;
@@ -216,6 +249,8 @@ static void via_ide_class_init(ObjectClass *klass, void *data)
     /* Reason: only works as function of VIA southbridge */
     dc->user_creatable = false;
 
+    k->config_read = via_ide_cfg_read;
+    k->config_write = via_ide_cfg_write;
     k->realize = via_ide_realize;
     k->exit = via_ide_exitfn;
     k->vendor_id = PCI_VENDOR_ID_VIA;
-- 
2.39.2


