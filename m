Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13428746598
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 00:04:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGRdS-0003lB-G5; Mon, 03 Jul 2023 18:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qGRdP-0003gV-NO; Mon, 03 Jul 2023 18:03:03 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qGRdO-0004Cc-1O; Mon, 03 Jul 2023 18:03:03 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 39715748A5C;
 Tue,  4 Jul 2023 00:02:45 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1DECF748A4D; Tue,  4 Jul 2023 00:02:45 +0200 (CEST)
Message-Id: <576b54159060392c8bc12a63c665928053b58f24.1688421085.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1688421085.git.balaton@eik.bme.hu>
References: <cover.1688421085.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 12/13] ppc440_pcix: Don't use iomem for regs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Tue,  4 Jul 2023 00:02:45 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

The iomem memory region is better used for the PCI IO space but
currently used for registers. Stop using it for that to allow this to
be cleaned up in the next patch.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/ppc440_pcix.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
index adfecf1e76..ee2dc44f67 100644
--- a/hw/ppc/ppc440_pcix.c
+++ b/hw/ppc/ppc440_pcix.c
@@ -484,6 +484,7 @@ static void ppc440_pcix_realize(DeviceState *dev, Error **errp)
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     PPC440PCIXState *s;
     PCIHostState *h;
+    MemoryRegion *regs = g_new(MemoryRegion, 1);
 
     h = PCI_HOST_BRIDGE(dev);
     s = PPC440_PCIX_HOST(dev);
@@ -507,11 +508,11 @@ static void ppc440_pcix_realize(DeviceState *dev, Error **errp)
                           h, "pci-conf-idx", 4);
     memory_region_init_io(&h->data_mem, OBJECT(s), &pci_host_data_le_ops,
                           h, "pci-conf-data", 4);
-    memory_region_init_io(&s->iomem, OBJECT(s), &pci_reg_ops, s,
-                          "pci.reg", PPC440_REG_SIZE);
+    memory_region_init_io(regs, OBJECT(s), &pci_reg_ops, s, "pci-reg",
+                          PPC440_REG_SIZE);
     memory_region_add_subregion(&s->container, PCIC0_CFGADDR, &h->conf_mem);
     memory_region_add_subregion(&s->container, PCIC0_CFGDATA, &h->data_mem);
-    memory_region_add_subregion(&s->container, PPC440_REG_BASE, &s->iomem);
+    memory_region_add_subregion(&s->container, PPC440_REG_BASE, regs);
     sysbus_init_mmio(sbd, &s->container);
 }
 
-- 
2.30.9


