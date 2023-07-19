Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C89B3758A1D
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 02:34:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLv7n-0000PC-Aa; Tue, 18 Jul 2023 20:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qLv7l-0000MR-BV; Tue, 18 Jul 2023 20:33:01 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qLv7i-0006ao-Qy; Tue, 18 Jul 2023 20:33:00 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 9527B748FF0;
 Wed, 19 Jul 2023 02:32:55 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7A19A748A55; Wed, 19 Jul 2023 02:32:55 +0200 (CEST)
Message-Id: <6abd73b1211f9d0776dfa5d71d6294f17eecb426.1689725688.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1689725688.git.balaton@eik.bme.hu>
References: <cover.1689725688.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 2/3] ppc/pegasos2: Fix reg property of ROM BARs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Wed, 19 Jul 2023 02:32:55 +0200 (CEST)
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

The register offset of the ROM BAR is 0x30 not 0x28. This fixes the
reg property entry of the ROM region in the device tree.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/pegasos2.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 4a2ab35f19..8ed13a42a2 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -766,7 +766,11 @@ static void add_pci_device(PCIBus *bus, PCIDevice *d, void *opaque)
         if (!d->io_regions[i].size) {
             continue;
         }
-        cells[j] = cpu_to_be32(d->devfn << 8 | (PCI_BASE_ADDRESS_0 + i * 4));
+        cells[j] = PCI_BASE_ADDRESS_0 + i * 4;
+        if (cells[j] == 0x28) {
+            cells[j] = 0x30;
+        }
+        cells[j] = cpu_to_be32(d->devfn << 8 | cells[j]);
         if (d->io_regions[i].type & PCI_BASE_ADDRESS_SPACE_IO) {
             cells[j] |= cpu_to_be32(1 << 24);
         } else {
-- 
2.30.9


