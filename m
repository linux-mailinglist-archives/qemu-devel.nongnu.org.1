Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 030B87F2C21
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 12:54:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5PK8-0003ho-Au; Tue, 21 Nov 2023 06:53:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r5PK2-0003da-C8
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 06:53:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r5PJd-0004Ih-5i
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 06:53:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700567596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uzh7TKgZwwpn2x94O8CB5r9U+Gff10u+dlzoGFMO9hE=;
 b=D0llMB1eqvVYNnv+ND3LM+qFyr/U553p765WekC8GKXwklDs6+EtW1OZRgoV70wMD+iaPS
 3njl2ffUbIycsY9b7SW3j8nl3in+qsfZgzLSB6ioWhVmTXu/f/55dbxaAQZ+3UmYW6j3Re
 4g4AtV4T+Dbt9f+eByTMHMSxbpjXloA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-o7aA0YwDN7iSrqsailYykQ-1; Tue, 21 Nov 2023 06:53:15 -0500
X-MC-Unique: o7aA0YwDN7iSrqsailYykQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1D60185A7A3;
 Tue, 21 Nov 2023 11:53:14 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4268A492BFD;
 Tue, 21 Nov 2023 11:53:14 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 9/9] hw/ide/via: implement legacy/native mode switching
Date: Tue, 21 Nov 2023 12:53:02 +0100
Message-ID: <20231121115302.52214-10-kwolf@redhat.com>
In-Reply-To: <20231121115302.52214-1-kwolf@redhat.com>
References: <20231121115302.52214-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Allow the VIA IDE controller to switch between both legacy and native modes by
calling pci_ide_update_mode() to reconfigure the device whenever PCI_CLASS_PROG
is updated.

This patch moves the initial setting of PCI_CLASS_PROG from via_ide_realize() to
via_ide_reset(), and removes the direct setting of PCI_INTERRUPT_PIN during PCI
bus reset since this is now managed by pci_ide_update_mode(). This ensures that
the device configuration is always consistent with respect to the currently
selected mode.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20231116103355.588580-5-mark.cave-ayland@ilande.co.uk>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/ide/via.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/hw/ide/via.c b/hw/ide/via.c
index 87b134083a..2d3124ebd7 100644
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
+                                              PCI_BASE_ADDRESS_0, 16)) {
+        /* BARs always read back zero in legacy mode */
+        for (int i = addr; i < addr + len; i++) {
+            if (i >= PCI_BASE_ADDRESS_0 && i < PCI_BASE_ADDRESS_0 + 16) {
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
2.42.0


