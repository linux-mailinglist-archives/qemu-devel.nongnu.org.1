Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE961748EAF
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 22:15:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH8st-00034n-OC; Wed, 05 Jul 2023 16:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qH8sN-0002tX-5N; Wed, 05 Jul 2023 16:13:23 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qH8sK-00067C-DE; Wed, 05 Jul 2023 16:13:22 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 70B9E748A5C;
 Wed,  5 Jul 2023 22:12:58 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 53F0C748A55; Wed,  5 Jul 2023 22:12:58 +0200 (CEST)
Message-Id: <3def68f200edd4540393d6b3b03baabe15d649f2.1688586835.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1688586835.git.balaton@eik.bme.hu>
References: <cover.1688586835.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 13/14] ppc440_pcix: Don't use iomem for regs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <"danielhb413@gmail.com>, philmd"@linaro.org>
Date: Wed,  5 Jul 2023 22:12:58 +0200 (CEST)
X-Spam-Probability: 10%
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
index adfecf1e76..cf932e4b25 100644
--- a/hw/ppc/ppc440_pcix.c
+++ b/hw/ppc/ppc440_pcix.c
@@ -63,6 +63,7 @@ struct PPC440PCIXState {
     MemoryRegion container;
     MemoryRegion iomem;
     MemoryRegion busmem;
+    MemoryRegion regs;
 };
 
 #define PPC440_REG_BASE     0x80000
@@ -507,11 +508,11 @@ static void ppc440_pcix_realize(DeviceState *dev, Error **errp)
                           h, "pci-conf-idx", 4);
     memory_region_init_io(&h->data_mem, OBJECT(s), &pci_host_data_le_ops,
                           h, "pci-conf-data", 4);
-    memory_region_init_io(&s->iomem, OBJECT(s), &pci_reg_ops, s,
-                          "pci.reg", PPC440_REG_SIZE);
+    memory_region_init_io(&s->regs, OBJECT(s), &pci_reg_ops, s, "pci-reg",
+                          PPC440_REG_SIZE);
     memory_region_add_subregion(&s->container, PCIC0_CFGADDR, &h->conf_mem);
     memory_region_add_subregion(&s->container, PCIC0_CFGDATA, &h->data_mem);
-    memory_region_add_subregion(&s->container, PPC440_REG_BASE, &s->iomem);
+    memory_region_add_subregion(&s->container, PPC440_REG_BASE, &s->regs);
     sysbus_init_mmio(sbd, &s->container);
 }
 
-- 
2.30.9


