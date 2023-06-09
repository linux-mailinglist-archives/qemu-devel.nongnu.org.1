Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BF572A29E
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 20:52:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7hDJ-00011z-3v; Fri, 09 Jun 2023 14:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q7hDG-00011H-Vb; Fri, 09 Jun 2023 14:51:55 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q7hDF-0002vl-99; Fri, 09 Jun 2023 14:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BjIXwPrt4L4/BuNkHvOZ69CiJDN7mTCQ/Qs0TuUfOgM=; b=jBlfasiRs19XtRnaUGye42j8RK
 eBMbNUvl5H3sYgVgjawiMhewpfbeXRxNGp9wdBcY8p2a4ay4tP088SEaZjpnre8e9Oc7YXn8oFx9b
 w7QkiRWCgK1YuEQnKa/mWNQZagUXnaGhd1xM4GMQb31Ajnciara1peZORxIPaJNzIReYjNE459bFa
 xbJ2G56iUn3jrQ0R0Jyf/3MSA577l36K7cp8CqwnMU5DVlvk3BZ8Yn2nxQ/B1HZ5gJoCdE+YTXvpB
 YTBBJt6yCjTsm8UFaOtZlTtbKNUlSonAzTsxumWZOH98b2r+7RCtM6sDp6lZgJaYsj2eg2IwjygNJ
 kvK7AQMThXbuG3vcjjx7cu8Z5tDwMcX1VXPRW+UUHFMQDi14fvHwo+Z+xNkYvpPK6rbOCvXlWf0Hi
 FtVJJgob+ZYKTBlL6oBLP6x3uboPa/aSaEYA5DlWjzmZVeanC7CodTe/7erKhSCWvZ+8OWc/Q7C8B
 He3X2Fb78A1KJlc0EWWnDBGnnhlmFIC9iqArB0J2f/1R1Teot6j+xO6GGGGOtwNwvdVrPPZEnZ3ut
 +UYJk9s4hPqbuH4c+mt5R74nFOuLKKsV2tYrQFnPC2So8gnIZULssorzrgkk/jvpuj0kWtURz2Bmi
 72eEHDbtSGxagA6iE42eSQGKkI9lz8C1H4A502dWk=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q7hD6-0000p5-Ra; Fri, 09 Jun 2023 19:51:48 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: jsnow@redhat.com, shentey@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Date: Fri,  9 Jun 2023 19:51:19 +0100
Message-Id: <20230609185119.691152-6-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230609185119.691152-1-mark.cave-ayland@ilande.co.uk>
References: <20230609185119.691152-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 5/5] cmd646: move device-specific BMDMA registers to separate
 memory region
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

The aim here is to eliminate any device-specific registers from the main BMDMA
bar memory region so it can potentially be moved into the shared PCI IDE device.

For each BMDMA bus create a new cmd646-bmdma-specific memory region representing
the device-specific BMDMA registers and then map them using aliases onto the
existing BMDMAState memory region.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ide/cmd646.c         | 111 +++++++++++++++++++++++++++++++---------
 include/hw/ide/cmd646.h |   4 ++
 2 files changed, 90 insertions(+), 25 deletions(-)

diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index 9103da581f..dd495f2e1b 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -90,7 +90,6 @@ static uint64_t bmdma_read(void *opaque, hwaddr addr,
                            unsigned size)
 {
     BMDMAState *bm = opaque;
-    PCIDevice *pci_dev = PCI_DEVICE(bm->pci_dev);
     uint32_t val;
 
     if (size != 1) {
@@ -101,19 +100,9 @@ static uint64_t bmdma_read(void *opaque, hwaddr addr,
     case 0:
         val = bm->cmd;
         break;
-    case 1:
-        val = pci_dev->config[MRDMODE];
-        break;
     case 2:
         val = bm->status;
         break;
-    case 3:
-        if (bm == &bm->pci_dev->bmdma[0]) {
-            val = pci_dev->config[UDIDETCR0];
-        } else {
-            val = pci_dev->config[UDIDETCR1];
-        }
-        break;
     default:
         val = 0xff;
         break;
@@ -127,7 +116,6 @@ static void bmdma_write(void *opaque, hwaddr addr,
                         uint64_t val, unsigned size)
 {
     BMDMAState *bm = opaque;
-    PCIDevice *pci_dev = PCI_DEVICE(bm->pci_dev);
 
     if (size != 1) {
         return;
@@ -138,23 +126,10 @@ static void bmdma_write(void *opaque, hwaddr addr,
     case 0:
         bmdma_cmd_writeb(bm, val);
         break;
-    case 1:
-        pci_dev->config[MRDMODE] =
-            (pci_dev->config[MRDMODE] & ~0x30) | (val & 0x30);
-        cmd646_update_dma_interrupts(pci_dev);
-        cmd646_update_irq(pci_dev);
-        break;
     case 2:
         bm->status = (val & 0x60) | (bm->status & 1) |
                      (bm->status & ~val & 0x06);
         break;
-    case 3:
-        if (bm == &bm->pci_dev->bmdma[0]) {
-            pci_dev->config[UDIDETCR0] = val;
-        } else {
-            pci_dev->config[UDIDETCR1] = val;
-        }
-        break;
     }
 }
 
@@ -181,6 +156,91 @@ static void bmdma_setup_bar(PCIIDEState *d)
     }
 }
 
+static uint64_t cmd646_bmdma_read(void *opaque, hwaddr addr, unsigned size)
+{
+    BMDMAState *bm = opaque;
+    PCIDevice *pci_dev = PCI_DEVICE(bm->pci_dev);
+    uint32_t val;
+
+    if (size != 1) {
+        return ((uint64_t)1 << (size * 8)) - 1;
+    }
+
+    switch (addr & 3) {
+    case 1:
+        val = pci_dev->config[MRDMODE];
+        break;
+    case 3:
+        if (bm == &bm->pci_dev->bmdma[0]) {
+            val = pci_dev->config[UDIDETCR0];
+        } else {
+            val = pci_dev->config[UDIDETCR1];
+        }
+        break;
+    default:
+        val = 0xff;
+        break;
+    }
+
+    trace_bmdma_read_cmd646(addr, val);
+    return val;
+}
+
+static void cmd646_bmdma_write(void *opaque, hwaddr addr, uint64_t val,
+                               unsigned size)
+{
+    BMDMAState *bm = opaque;
+    PCIDevice *pci_dev = PCI_DEVICE(bm->pci_dev);
+
+    if (size != 1) {
+        return;
+    }
+
+    trace_bmdma_write_cmd646(addr, val);
+    switch (addr & 3) {
+    case 1:
+        pci_dev->config[MRDMODE] =
+            (pci_dev->config[MRDMODE] & ~0x30) | (val & 0x30);
+        cmd646_update_dma_interrupts(pci_dev);
+        cmd646_update_irq(pci_dev);
+        break;
+    case 3:
+        if (bm == &bm->pci_dev->bmdma[0]) {
+            pci_dev->config[UDIDETCR0] = val;
+        } else {
+            pci_dev->config[UDIDETCR1] = val;
+        }
+        break;
+    }
+}
+
+static const MemoryRegionOps cmd646_bmdma_ops = {
+    .read = cmd646_bmdma_read,
+    .write = cmd646_bmdma_write,
+};
+
+static void cmd646_bmdma_setup(PCIIDEState *d)
+{
+    CMD646IDEState *s = CMD646_IDE(d);
+    BMDMAState *bm;
+    int i;
+
+    /* Setup aliases for device-specific BMDMA registers */
+    for (i = 0; i < 2; i++) {
+        bm = &d->bmdma[i];
+        memory_region_init_io(&s->bmdma_mem[i], OBJECT(d), &cmd646_bmdma_ops,
+                              bm, "cmd646-bmdma", 4);
+        memory_region_init_alias(&s->bmdma_mem_alias[i][0], OBJECT(d),
+                                 "cmd646-bmdma[1]", &s->bmdma_mem[i], 0x1, 1);
+        memory_region_add_subregion(&bm->extra_io, 0x1,
+                                    &s->bmdma_mem_alias[i][0]);
+        memory_region_init_alias(&s->bmdma_mem_alias[i][1], OBJECT(d),
+                                 "cmd646-bmdma[3]", &s->bmdma_mem[i], 0x3, 1);
+        memory_region_add_subregion(&bm->extra_io, 0x3,
+                                    &s->bmdma_mem_alias[i][1]);
+    }
+}
+
 static void cmd646_update_irq(PCIDevice *pd)
 {
     int pci_level;
@@ -289,6 +349,7 @@ static void pci_cmd646_ide_realize(PCIDevice *dev, Error **errp)
 
     bmdma_setup_bar(d);
     pci_register_bar(dev, 4, PCI_BASE_ADDRESS_SPACE_IO, &d->bmdma_bar);
+    cmd646_bmdma_setup(d);
 
     /* TODO: RST# value should be 0 */
     pci_conf[PCI_INTERRUPT_PIN] = 0x01; /* interrupt on pin 1 */
diff --git a/include/hw/ide/cmd646.h b/include/hw/ide/cmd646.h
index 4780b1132c..5329964533 100644
--- a/include/hw/ide/cmd646.h
+++ b/include/hw/ide/cmd646.h
@@ -29,10 +29,14 @@
 #define TYPE_CMD646_IDE "cmd646-ide"
 OBJECT_DECLARE_SIMPLE_TYPE(CMD646IDEState, CMD646_IDE)
 
+#include "exec/memory.h"
 #include "hw/ide/pci.h"
 
 struct CMD646IDEState {
     PCIIDEState parent_obj;
+
+    MemoryRegion bmdma_mem[2];
+    MemoryRegion bmdma_mem_alias[2][2];
 };
 
 #endif
-- 
2.30.2


