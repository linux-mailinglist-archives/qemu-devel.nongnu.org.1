Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB1D75D73B
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Jul 2023 00:15:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMyNP-0007iv-Hg; Fri, 21 Jul 2023 18:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qMyNN-0007iQ-GP; Fri, 21 Jul 2023 18:13:29 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qMyNL-0004Bi-7q; Fri, 21 Jul 2023 18:13:29 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 42AEA7456AC;
 Sat, 22 Jul 2023 00:13:20 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1311E7456AB; Sat, 22 Jul 2023 00:13:20 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] ppc/pegasos2: Fix reg property of 64 bit BARs in device tree
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20230721221320.1311E7456AB@zero.eik.bme.hu>
Date: Sat, 22 Jul 2023 00:13:20 +0200 (CEST)
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

The board firmware handles this correctly following the Open Firmware
standard which we missed. This fixes 64 bit BARs when using VOF.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/pegasos2.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 6475acfbed..075367d94d 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -781,7 +781,11 @@ static void add_pci_device(PCIBus *bus, PCIDevice *d, void *opaque)
         if (d->io_regions[i].type & PCI_BASE_ADDRESS_SPACE_IO) {
             cells[j] |= cpu_to_be32(1 << 24);
         } else {
-            cells[j] |= cpu_to_be32(2 << 24);
+            if (d->io_regions[i].type & PCI_BASE_ADDRESS_MEM_TYPE_64) {
+                cells[j] |= cpu_to_be32(3 << 24);
+            } else {
+                cells[j] |= cpu_to_be32(2 << 24);
+            }
             if (d->io_regions[i].type & PCI_BASE_ADDRESS_MEM_PREFETCH) {
                 cells[j] |= cpu_to_be32(4 << 28);
             }
-- 
2.30.9


