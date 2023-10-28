Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 471B07DAA37
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 01:57:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwtAO-0007dB-Nw; Sat, 28 Oct 2023 19:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qwtAH-0007b8-Pc
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 19:56:25 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qwtAE-0006Jb-P0
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 19:56:25 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 316C37560A7;
 Sun, 29 Oct 2023 01:56:24 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 14FF5756082; Sun, 29 Oct 2023 01:56:24 +0200 (CEST)
Message-Id: <a25ed5ec682f0037d57f957cc07547a0263bd876.1698536342.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1698536342.git.balaton@eik.bme.hu>
References: <cover.1698536342.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 2/4] hw/usb/vt82c686-uhci-pci: Use ISA instead of PCI
 interrupts
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>, vr_qemu@t-online.de
Date: Sun, 29 Oct 2023 01:56:24 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

This device is part of a superio/ISA bridge chip and IRQs from it are
routed to an ISA interrupt. Use via_isa_set_irq() function to implement
this in a vt82c686-uhci-pci specific irq handler.

This reverts commit 422a6e8075752bc5342afd3eace23a4990dd7d98.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/usb/vt82c686-uhci-pci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/usb/vt82c686-uhci-pci.c b/hw/usb/vt82c686-uhci-pci.c
index b4884c9011..6162806172 100644
--- a/hw/usb/vt82c686-uhci-pci.c
+++ b/hw/usb/vt82c686-uhci-pci.c
@@ -1,7 +1,14 @@
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/isa/vt82c686.h"
 #include "hcd-uhci.h"
 
+static void uhci_isa_set_irq(void *opaque, int irq_num, int level)
+{
+    UHCIState *s = opaque;
+    via_isa_set_irq(&s->dev, 0, level);
+}
+
 static void usb_uhci_vt82c686b_realize(PCIDevice *dev, Error **errp)
 {
     UHCIState *s = UHCI(dev);
@@ -15,6 +22,8 @@ static void usb_uhci_vt82c686b_realize(PCIDevice *dev, Error **errp)
     pci_set_long(pci_conf + 0xc0, 0x00002000);
 
     usb_uhci_common_realize(dev, errp);
+    object_unref(s->irq);
+    s->irq = qemu_allocate_irq(uhci_isa_set_irq, s, 0);
 }
 
 static UHCIInfo uhci_info[] = {
-- 
2.30.9


