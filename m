Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA3D7CFA8D
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:13:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSjA-0006xi-FP; Thu, 19 Oct 2023 09:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qtSiD-00067h-NH; Thu, 19 Oct 2023 09:05:18 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qtSiB-0005hq-EP; Thu, 19 Oct 2023 09:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VRRbRVpnG45VT30RoNT9iVwXDIgnElwwGsandZ69zOU=; b=RK0Bu0aRC3QPXbdGiXPlbMQGk9
 ysHBpNi5DxZ+WapqUoBRJZT/x1Qh58uTOSyQgdIseTf9rcTzH5VKWtMkRrnzyzcjXFKL2+tl7rexf
 v/WV4FGv6w7t3DIJAhQwKj9vkqmr9hif+9MyCABymPFffFv7LVshYoeA77/YOJZP+/tRkcz2V/d7E
 2fOCoyFl//kwJYawUxBzS9xg+EhZz/uzgt0Yi2D84FeJTVPQLdvpDglckqSJ0EUWr7PbuuOWTrfbE
 v3/dWX230XsqO96oree5cmPaeDN0/7pMVT8noQLEKs7EuYA06+ND/ha6FGXe2motzsgyyxYw17Jty
 spnMNFmA/dyeAAeUDYGsKtVIVYp2lmnoT8kxn0qxQpZN53EOR93R7fUXQKgmpi58KQfSpxnN7lTmM
 1qTKCucP9QpISZrgEJuE5AT5vtc6A/6n9t3iXb/SXr15ECiStCVK4CZrkgZ09czB0BJiZkkO9ldF8
 v6Cr6ueelgjz+L6HKfGNLyqGG4GLIsdgy5FRGTyhG7+Q7XKJGO9tOvjIOHfW+iD8rLWp//+ix9is/
 awBmS6GNUC2nOqB3nquKiGY0UlPqZ49YUXKYwbEhmnC50aYgnU0pVJFMlYyYHbCDbxnDQMi3Lqcbh
 1NT8FrkInFQGUwNyu+UKVb8VtE0BgCY+q0CRjXlTE=;
Received: from host86-130-37-248.range86-130.btcentralplus.com
 ([86.130.37.248] helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qtSi1-0006iW-1k; Thu, 19 Oct 2023 14:05:09 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: jsnow@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 balaton@eik.bme.hu, philmd@linaro.org, shentey@gmail.com
Date: Thu, 19 Oct 2023 14:04:52 +0100
Message-Id: <20231019130452.508426-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231019130452.508426-1-mark.cave-ayland@ilande.co.uk>
References: <20231019130452.508426-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.248
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 2/2] hw/ide/via: implement legacy/native mode switching
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Allow the VIA IDE controller to switch between both legacy and native modes by
calling pci_ide_update_mode() to reconfigure the device whenever PCI_CLASS_PROG
is updated.

This patch also moves the setting of PCI_CLASS_PROG from via_ide_realize() to
via_ide_reset() and clears PCI_INTERRUPT_PIN to ensure that if a PCI device
reset occurs then the device configuration is always consistent.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ide/via.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/ide/via.c b/hw/ide/via.c
index fff23803a6..e6278dd419 100644
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
@@ -128,6 +129,9 @@ static void via_ide_reset(DeviceState *dev)
         ide_bus_reset(&d->bus[i]);
     }
 
+    pci_config_set_prog_interface(pci_conf, 0x8a); /* legacy mode */
+    pci_ide_update_mode(d);
+
     pci_set_word(pci_conf + PCI_COMMAND, PCI_COMMAND_IO | PCI_COMMAND_WAIT);
     pci_set_word(pci_conf + PCI_STATUS, PCI_STATUS_FAST_BACK |
                  PCI_STATUS_DEVSEL_MEDIUM);
@@ -137,7 +141,7 @@ static void via_ide_reset(DeviceState *dev)
     pci_set_long(pci_conf + PCI_BASE_ADDRESS_2, 0x00000170);
     pci_set_long(pci_conf + PCI_BASE_ADDRESS_3, 0x00000374);
     pci_set_long(pci_conf + PCI_BASE_ADDRESS_4, 0x0000cc01); /* BMIBA: 20-23h */
-    pci_set_long(pci_conf + PCI_INTERRUPT_LINE, 0x0000010e);
+    pci_set_long(pci_conf + PCI_INTERRUPT_LINE, 0x0000000e);
 
     /* IDE chip enable, IDE configuration 1/2, IDE FIFO Configuration*/
     pci_set_long(pci_conf + 0x40, 0x0a090600);
@@ -159,6 +163,18 @@ static void via_ide_reset(DeviceState *dev)
     pci_set_long(pci_conf + 0xc0, 0x00020001);
 }
 
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
@@ -166,7 +182,6 @@ static void via_ide_realize(PCIDevice *dev, Error **errp)
     uint8_t *pci_conf = dev->config;
     int i;
 
-    pci_config_set_prog_interface(pci_conf, 0x8a); /* legacy mode */
     pci_set_long(pci_conf + PCI_CAPABILITY_LIST, 0x000000c0);
     dev->wmask[PCI_INTERRUPT_LINE] = 0;
     dev->wmask[PCI_CLASS_PROG] = 5;
@@ -221,6 +236,7 @@ static void via_ide_class_init(ObjectClass *klass, void *data)
     /* Reason: only works as function of VIA southbridge */
     dc->user_creatable = false;
 
+    k->config_write = via_ide_cfg_write;
     k->realize = via_ide_realize;
     k->exit = via_ide_exitfn;
     k->vendor_id = PCI_VENDOR_ID_VIA;
-- 
2.39.2


