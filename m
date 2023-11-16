Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9047EDE98
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 11:34:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3ZhY-0004Pv-Mv; Thu, 16 Nov 2023 05:34:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r3ZhW-0004Og-DB; Thu, 16 Nov 2023 05:34:22 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r3ZhO-0006Lc-Hf; Thu, 16 Nov 2023 05:34:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CiN4h1qsP5vRi5c4mVA8ggMwb5ErMsk+qleIttZAGPM=; b=qPjLQILmSRRKabyqfhwbcXPRUK
 YYdttJReg977MNlb5U9PjqlEE8pygy2teYrFtV0gCi+ygaWL2/ST216vRk6SwW8a3mdDQpajmQ9AK
 LXBw3phfQIkKX1axgmmue46r/m/TiE3/unAxS7yhJmCgORmPr7dJQBQyj0CvQ2D6M5R7JIf0Mrbro
 x/YZeFdpO1dgh9Wk2R7bm7E6laPpiN6nV/tAwFS5edbIeMtjnxHrm7D5ANv9fDBYt5Mn02xrkEH9a
 shAuKqx7Pr+d1wDyzlAZZN3b4As9jmNIgBV3c4fZqexI+u4J/PR5/TlGse31w5Zb/SrM2RgdhMUpg
 6+3OttEmewXIAVcmziqFczDXdRAmf9RVnJDsV3rJY3/SV0WYEJEO677KaqhI/zYXlXzaGxV6EX2ZO
 BE1zj3a8dQXx0SdPAB8adQ/0hFj1pEWxhrG8l4JYqQhvj8IHSt9MbpQqE95u15iec8PMz72CZ+f4d
 RcnOOE31I5/6T69KYdY8nbj94usC0Se9byj41UFqcvxf9PjeKm2CcCHmhSni69cjOUHkwwJwcReq8
 0WO/KeagV3Vla572eKyN949lIWIiGpif+k7L8P9yLM4I0kxy1aKyMD+laflPATpKi/5Y5UmszDnn1
 o3/MCIgy1HdeH36i5K0fudF3cKlD57RVzwK3TuCz0=;
Received: from host86-130-37-248.range86-130.btcentralplus.com
 ([86.130.37.248] helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r3Zh5-0001bP-8V; Thu, 16 Nov 2023 10:33:59 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, balaton@eik.bme.hu, philmd@linaro.org,
 shentey@gmail.com
Date: Thu, 16 Nov 2023 10:33:53 +0000
Message-Id: <20231116103355.588580-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231116103355.588580-1-mark.cave-ayland@ilande.co.uk>
References: <20231116103355.588580-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.248
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 2/4] ide/pci: introduce pci_ide_update_mode() function
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

This function reads the value of the PCI_CLASS_PROG register for PCI IDE
controllers and configures the PCI BARs and/or IDE ioports accordingly.

In the case where we switch to legacy mode, the PCI BARs are set to return zero
(as suggested in the "PCI IDE Controller" specification), the legacy IDE ioports
are enabled, and the PCI interrupt pin cleared to indicate legacy IRQ routing.

Conversely when we switch to native mode, the legacy IDE ioports are disabled
and the PCI interrupt pin set to indicate native IRQ routing. The contents of
the PCI BARs are unspecified, but this is not an issue since if a PCI IDE
controller has been switched to native mode then its BARs will need to be
programmed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ide/pci.c         | 84 ++++++++++++++++++++++++++++++++++++++++++++
 include/hw/ide/pci.h |  1 +
 2 files changed, 85 insertions(+)

diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index a25b352537..810c6b6d98 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -104,6 +104,90 @@ const MemoryRegionOps pci_ide_data_le_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
+void pci_ide_update_mode(PCIIDEState *s)
+{
+    PCIDevice *d = PCI_DEVICE(s);
+    uint8_t mode = d->config[PCI_CLASS_PROG];
+
+    /*
+     * This function only configures the BARs/ioports for now: PCI IDE
+     * controllers must manage their own IRQ routing
+     */
+
+    switch (mode & 0xf) {
+    case 0xa:
+        /* Both channels legacy mode */
+
+        /*
+         * TODO: according to the PCI IDE specification the BARs should
+         * be completely disabled, however Linux for the pegasos2
+         * machine stil accesses the BAR addresses after switching to legacy
+         * mode. Hence we leave them active for now.
+         */
+
+        /* Clear interrupt pin */
+        pci_config_set_interrupt_pin(d->config, 0);
+
+        /* Add legacy IDE ports */
+        if (!s->bus[0].portio_list.owner) {
+            portio_list_init(&s->bus[0].portio_list, OBJECT(d),
+                             ide_portio_list, &s->bus[0], "ide");
+            portio_list_add(&s->bus[0].portio_list,
+                            pci_address_space_io(d), 0x1f0);
+        }
+
+        if (!s->bus[0].portio2_list.owner) {
+            portio_list_init(&s->bus[0].portio2_list, OBJECT(d),
+                             ide_portio2_list, &s->bus[0], "ide");
+            portio_list_add(&s->bus[0].portio2_list,
+                            pci_address_space_io(d), 0x3f6);
+        }
+
+        if (!s->bus[1].portio_list.owner) {
+            portio_list_init(&s->bus[1].portio_list, OBJECT(d),
+                                ide_portio_list, &s->bus[1], "ide");
+            portio_list_add(&s->bus[1].portio_list,
+                            pci_address_space_io(d), 0x170);
+        }
+
+        if (!s->bus[1].portio2_list.owner) {
+            portio_list_init(&s->bus[1].portio2_list, OBJECT(d),
+                             ide_portio2_list, &s->bus[1], "ide");
+            portio_list_add(&s->bus[1].portio2_list,
+                            pci_address_space_io(d), 0x376);
+        }
+        break;
+
+    case 0xf:
+        /* Both channels native mode */
+
+        /* Set interrupt pin */
+        pci_config_set_interrupt_pin(d->config, 1);
+
+        /* Remove legacy IDE ports */
+        if (s->bus[0].portio_list.owner) {
+            portio_list_del(&s->bus[0].portio_list);
+            portio_list_destroy(&s->bus[0].portio_list);
+        }
+
+        if (s->bus[0].portio2_list.owner) {
+            portio_list_del(&s->bus[0].portio2_list);
+            portio_list_destroy(&s->bus[0].portio2_list);
+        }
+
+        if (s->bus[1].portio_list.owner) {
+            portio_list_del(&s->bus[1].portio_list);
+            portio_list_destroy(&s->bus[1].portio_list);
+        }
+
+        if (s->bus[1].portio2_list.owner) {
+            portio_list_del(&s->bus[1].portio2_list);
+            portio_list_destroy(&s->bus[1].portio2_list);
+        }
+        break;
+    }
+}
+
 static IDEState *bmdma_active_if(BMDMAState *bmdma)
 {
     assert(bmdma->bus->retry_unit != (uint8_t)-1);
diff --git a/include/hw/ide/pci.h b/include/hw/ide/pci.h
index 1ff469de87..a814a0a7c3 100644
--- a/include/hw/ide/pci.h
+++ b/include/hw/ide/pci.h
@@ -61,6 +61,7 @@ void bmdma_cmd_writeb(BMDMAState *bm, uint32_t val);
 void bmdma_status_writeb(BMDMAState *bm, uint32_t val);
 extern MemoryRegionOps bmdma_addr_ioport_ops;
 void pci_ide_create_devs(PCIDevice *dev);
+void pci_ide_update_mode(PCIIDEState *s);
 
 extern const VMStateDescription vmstate_ide_pci;
 extern const MemoryRegionOps pci_ide_cmd_le_ops;
-- 
2.39.2


