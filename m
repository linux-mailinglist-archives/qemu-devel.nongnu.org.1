Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D228758A1C
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 02:34:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLv7o-0000QV-0l; Tue, 18 Jul 2023 20:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qLv7m-0000OV-Ci; Tue, 18 Jul 2023 20:33:02 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qLv7i-0006aa-QX; Tue, 18 Jul 2023 20:33:02 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 8515374763D;
 Wed, 19 Jul 2023 02:32:54 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 68DA6746F30; Wed, 19 Jul 2023 02:32:54 +0200 (CEST)
Message-Id: <06a2b864431425f23d1f2b5abf0c027819ac11c6.1689725688.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1689725688.git.balaton@eik.bme.hu>
References: <cover.1689725688.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 1/3] ppc/pegasos2: Fix reset state of USB functions
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Wed, 19 Jul 2023 02:32:54 +0200 (CEST)
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

The original non-free board firmware sets the command register of the
USB functions to 7 and some guests rely on this for working USB. Match
what the board firmware does when using VOF instead.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/pegasos2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 4447bbe8ec..4a2ab35f19 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -324,9 +324,13 @@ static void pegasos2_machine_reset(MachineState *machine, ShutdownCause reason)
 
     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 2) << 8) |
                               PCI_INTERRUPT_LINE, 2, 0x409);
+    pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 2) << 8) |
+                              PCI_COMMAND, 2, 0x7);
 
     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 3) << 8) |
                               PCI_INTERRUPT_LINE, 2, 0x409);
+    pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 3) << 8) |
+                              PCI_COMMAND, 2, 0x7);
 
     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 4) << 8) |
                               PCI_INTERRUPT_LINE, 2, 0x9);
-- 
2.30.9


