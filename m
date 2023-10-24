Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 039B37D5E59
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 00:42:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvQ5b-0002ps-4L; Tue, 24 Oct 2023 18:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qvQ5Y-0002oa-DR; Tue, 24 Oct 2023 18:41:28 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qvQ5V-0002i3-Ck; Tue, 24 Oct 2023 18:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uapmb6Iva2k9i03Ok2G/HL/4d0ldYlLsnNDYQrsnrMQ=; b=gV1kOqBI2t7CA1xva8smtl6hLv
 Ui1BxyYUnUc17re/lkZnf6Ld47RxJ9myRhn2AzdKDxHVCQE1ztS/60SnVhWj0R2z9N0gHA59byBvK
 t3ElvsHcWdzcXTVc+1nNPz2RKqF9KuMwPJhgp0WTOh9upIr/X93OFV15Eom9efZ7lYn3gK5kWb41v
 O2jK2/cQ0NTBs5DbdqkEIplKGSzb2h+vbF7j75LYr7nCQOitsfsflKrZ/DdMIcfSEJ82Xku3GyJgx
 eCVs84D/uzq8/P3IT8t9l4lRRSav4kMPSMVj1nUpjAXO6t3vWnyd9TW8U7hBJ3XZAgMNvtt/b7Fn6
 WGCW7MKVzCsxTw4J+dUgGlw4Az8jZEcP4+IMNZsIYzKtdLYdT6Fjqx8TBgXpgcAwKV5/FZ+TI4Ox+
 FVcBizfRi2CERwp+FPi75yQfEl7ywIQCINAK4XtmVHdJf1uGZ2IwdWYLLMoFEp6HKqXTXtt6eo9OD
 M2ojwhdOslPvD6Ls5Gj82MslacwgbcTd8dJ/juqUA/+2xljDUtaru4dBCg38C+r21tDKUXRyLpnO5
 fHWWq2Ddu9vsbTFF+guDJFkEb3hc+VDr8bLoi++oWbPD3n3HYRXlQ6SY295K9c0lGJWVcJs73el/q
 ZPZXDuxDmBC1hSdW7x9WEr5zX02Txo1rp55gvOJTE=;
Received: from [2a00:23c4:8bb0:5400:d6f1:6571:2310:5e57]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qvQ5H-0002va-Cj; Tue, 24 Oct 2023 23:41:15 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: jsnow@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 balaton@eik.bme.hu, philmd@linaro.org, shentey@gmail.com
Date: Tue, 24 Oct 2023 23:40:56 +0100
Message-Id: <20231024224056.842607-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231024224056.842607-1-mark.cave-ayland@ilande.co.uk>
References: <20231024224056.842607-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:5400:d6f1:6571:2310:5e57
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 3/3] hw/ide/via: implement legacy/native mode switching
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

This patch moves the initial setting of PCI_CLASS_PROG from via_ide_realize() to
via_ide_reset(), and removes the direct setting of PCI_INTERRUPT_PIN during PCI
bus reset since this is now managed by pci_ide_update_mode(). This ensures that
the device configuration is always consistent with respect to the currently
selected mode.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Tested-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ide/via.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/ide/via.c b/hw/ide/via.c
index 87b134083a..0cb65c8a3d 100644
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
@@ -154,6 +158,18 @@ static void via_ide_reset(DeviceState *dev)
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
@@ -161,7 +177,6 @@ static void via_ide_realize(PCIDevice *dev, Error **errp)
     uint8_t *pci_conf = dev->config;
     int i;
 
-    pci_config_set_prog_interface(pci_conf, 0x8a); /* legacy mode */
     pci_set_long(pci_conf + PCI_CAPABILITY_LIST, 0x000000c0);
     dev->wmask[PCI_INTERRUPT_LINE] = 0;
     dev->wmask[PCI_CLASS_PROG] = 5;
@@ -216,6 +231,7 @@ static void via_ide_class_init(ObjectClass *klass, void *data)
     /* Reason: only works as function of VIA southbridge */
     dc->user_creatable = false;
 
+    k->config_write = via_ide_cfg_write;
     k->realize = via_ide_realize;
     k->exit = via_ide_exitfn;
     k->vendor_id = PCI_VENDOR_ID_VIA;
-- 
2.39.2


