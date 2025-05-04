Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F12FEAA8791
	for <lists+qemu-devel@lfdr.de>; Sun,  4 May 2025 18:02:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBbmw-0005S7-VN; Sun, 04 May 2025 12:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uBbmg-0004zX-Fb; Sun, 04 May 2025 12:01:44 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uBbme-0004CF-PA; Sun, 04 May 2025 12:01:42 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0AFD355D22E;
 Sun, 04 May 2025 18:01:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id gMeVB5h61AKH; Sun,  4 May 2025 18:01:37 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1A72C55D23A; Sun, 04 May 2025 18:01:37 +0200 (CEST)
Message-ID: <6205b7eb571626ccc7fb017132e705a49fa3a6ff.1746374076.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1746374076.git.balaton@eik.bme.hu>
References: <cover.1746374076.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 10/16] hw/pci-host/raven: Use correct parameter in direct
 access ops
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
Date: Sun, 04 May 2025 18:01:37 +0200 (CEST)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

Instead of passing unneeded enclosing objects to the config direct
access ops that only need the bus we can pass that directly thus
simplifying the functions.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/pci-host/raven.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index d7a0bde382..c39e95b45f 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -65,16 +65,12 @@ static inline uint32_t raven_idsel_to_addr(hwaddr addr)
 static void raven_mmcfg_write(void *opaque, hwaddr addr, uint64_t val,
                               unsigned int size)
 {
-    PREPPCIState *s = opaque;
-    PCIHostState *phb = PCI_HOST_BRIDGE(s);
-    pci_data_write(phb->bus, raven_idsel_to_addr(addr), val, size);
+    pci_data_write(opaque, raven_idsel_to_addr(addr), val, size);
 }
 
 static uint64_t raven_mmcfg_read(void *opaque, hwaddr addr, unsigned int size)
 {
-    PREPPCIState *s = opaque;
-    PCIHostState *phb = PCI_HOST_BRIDGE(s);
-    return pci_data_read(phb->bus, raven_idsel_to_addr(addr), size);
+    return pci_data_read(opaque, raven_idsel_to_addr(addr), size);
 }
 
 static const MemoryRegionOps raven_mmcfg_ops = {
@@ -233,7 +229,7 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
                           "pci-conf-data", 4);
     memory_region_add_subregion(&s->pci_io, 0xcfc, &h->data_mem);
 
-    memory_region_init_io(&h->mmcfg, OBJECT(s), &raven_mmcfg_ops, s,
+    memory_region_init_io(&h->mmcfg, OBJECT(h), &raven_mmcfg_ops, h->bus,
                           "pci-mmcfg", 0x00400000);
     memory_region_add_subregion(address_space_mem, 0x80800000, &h->mmcfg);
 
-- 
2.41.3


