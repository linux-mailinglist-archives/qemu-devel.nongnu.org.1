Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D8E758A1B
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 02:34:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLv7p-0000Sr-Rl; Tue, 18 Jul 2023 20:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qLv7m-0000OZ-Dk; Tue, 18 Jul 2023 20:33:02 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qLv7j-0006az-De; Tue, 18 Jul 2023 20:33:02 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id AB602748FF4;
 Wed, 19 Jul 2023 02:32:56 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8CEA3748FF3; Wed, 19 Jul 2023 02:32:56 +0200 (CEST)
Message-Id: <808ade37aa141563d1ee349254151672bf7a5d59.1689725688.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1689725688.git.balaton@eik.bme.hu>
References: <cover.1689725688.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 3/3] ppc/pegasos2: Fix naming of device tree nodes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Wed, 19 Jul 2023 02:32:56 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

The board firmware names devices by their class so match that for
common devices. Also make sure the /rtas node has a name. This is
needed because VOF otherwise does not include it in results got by
nextprop which is how AmigaOS queries it and fails if no name property
is found.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/pegasos2.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 8ed13a42a2..6475acfbed 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -739,6 +739,13 @@ static void add_pci_device(PCIBus *bus, PCIDevice *d, void *opaque)
                                      pci_get_word(&d->config[PCI_VENDOR_ID]),
                                      pci_get_word(&d->config[PCI_DEVICE_ID]));
 
+    if (pci_get_word(&d->config[PCI_CLASS_DEVICE])  ==
+        PCI_CLASS_NETWORK_ETHERNET) {
+        name = "ethernet";
+    } else if (pci_get_word(&d->config[PCI_CLASS_DEVICE]) >> 8 ==
+        PCI_BASE_CLASS_DISPLAY) {
+        name = "display";
+    }
     for (i = 0; device_map[i].id; i++) {
         if (!strcmp(pn, device_map[i].id)) {
             name = device_map[i].name;
@@ -929,6 +936,7 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
     qemu_fdt_setprop_cell(fdt, "/rtas", "rtas-display-device", 0);
     qemu_fdt_setprop_cell(fdt, "/rtas", "rtas-size", 20);
     qemu_fdt_setprop_cell(fdt, "/rtas", "rtas-version", 1);
+    qemu_fdt_setprop_string(fdt, "/rtas", "name", "rtas");
 
     /* cpus */
     qemu_fdt_add_subnode(fdt, "/cpus");
-- 
2.30.9


