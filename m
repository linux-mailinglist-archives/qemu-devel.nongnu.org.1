Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD8C7CFA82
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:11:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSj8-0006uU-Ge; Thu, 19 Oct 2023 09:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qtSiA-0005sY-7C; Thu, 19 Oct 2023 09:05:15 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qtSi6-0005h2-F9; Thu, 19 Oct 2023 09:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2gEit6liHFCMLibqTayVSsv8R4xIMILqlK3LCzt4uHc=; b=EKlU4Y5v6aNUDjxJox8amLxczC
 BlNSQ9ajtgjUtv4aU3YZ2MLmlETI2FTDZmQ5qvMVesc3Jfn+JxXDORGX76LFf5k8dgilfxgJbADB2
 bhcilsioe5tWQ+Am5AHNsYt0ef24BJRPIjvb0cusOzyBsHJFZommuZQdxXw7EuXKxFGiwq9UbVX6n
 Cc7knNUFscYK2iVGL6wiwad/YUejvvC1GhRXKyQarA1k1+N4naJLgyXubcKDIHfbiW5tU2JQO5AQN
 wGtRN1ko00eUfZtz9Yd0ZndI+tEHFan+sS7I/G5KDcUq2P7SXGioGGzh3mI86kKh818u7wEZXOiP0
 tGYSABb7RUvxKG+RpG2dExH++X/H8/sdNL62XsUy7ShGMAyogH864X74DsXgQIMJP725JwwjjN44Z
 7vCIL5yNQXUftBZ5ybRDuRftYeHdrZuN/To+lBtqaSnW895ot5hczb2TBfBH9I4AjLONxfI4aoJw1
 q+jFkEX2TB0vJpBVg/8dDR7pDkC+4JqHE1bzSGPE6Dd2OCoR7PjPWzs9SiZiZemK7UhiCm5bHHBEG
 BdTZ2MpmJY2xL8yJsEOsfC7jcGbMG8Gf3H8FFcsUcpf2OqxwnDq6brJRpjVBJTQC1GpdazDofI1B5
 imTJo5eATA9G0RR5LEAPOV2OClgFgL8EhxMZDdWT4=;
Received: from host86-130-37-248.range86-130.btcentralplus.com
 ([86.130.37.248] helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qtShw-0006iW-Lx; Thu, 19 Oct 2023 14:05:04 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: jsnow@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 balaton@eik.bme.hu, philmd@linaro.org, shentey@gmail.com
Date: Thu, 19 Oct 2023 14:04:51 +0100
Message-Id: <20231019130452.508426-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231019130452.508426-1-mark.cave-ayland@ilande.co.uk>
References: <20231019130452.508426-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.248
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 1/2] ide/pci.c: introduce pci_ide_update_mode() function
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
 hw/ide/pci.c         | 90 ++++++++++++++++++++++++++++++++++++++++++++
 include/hw/ide/pci.h |  1 +
 2 files changed, 91 insertions(+)

diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index a25b352537..9eb30af632 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -104,6 +104,96 @@ const MemoryRegionOps pci_ide_data_le_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
+static const MemoryRegionPortio ide_portio_list[] = {
+    { 0, 8, 1, .read = ide_ioport_read, .write = ide_ioport_write },
+    { 0, 1, 2, .read = ide_data_readw, .write = ide_data_writew },
+    { 0, 1, 4, .read = ide_data_readl, .write = ide_data_writel },
+    PORTIO_END_OF_LIST(),
+};
+
+static const MemoryRegionPortio ide_portio2_list[] = {
+    { 0, 1, 1, .read = ide_status_read, .write = ide_ctrl_write },
+    PORTIO_END_OF_LIST(),
+};
+
+void pci_ide_update_mode(PCIIDEState *s)
+{
+    PCIDevice *d = PCI_DEVICE(s);
+    uint8_t mode = d->config[PCI_CLASS_PROG];
+
+    switch (mode) {
+    case 0x8a:
+        /* Both channels legacy mode */
+
+        /* Zero BARs */
+        pci_set_long(d->config + PCI_BASE_ADDRESS_0, 0x0);
+        pci_set_long(d->config + PCI_BASE_ADDRESS_1, 0x0);
+        pci_set_long(d->config + PCI_BASE_ADDRESS_2, 0x0);
+        pci_set_long(d->config + PCI_BASE_ADDRESS_3, 0x0);
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
+    case 0x8f:
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


