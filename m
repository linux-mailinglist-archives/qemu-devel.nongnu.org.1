Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC13A9AC29D
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Oct 2024 11:02:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3XDJ-00083X-P4; Wed, 23 Oct 2024 04:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XDG-00082X-DF
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:59:30 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XDF-0000KP-5o
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=3SBc2+R0d1hoqyhlw2wky4q4tWg4lI9UIXLFOUt9RNY=; b=V3r1koirn+TK5KJB+2SoCJ2nLv
 aoLa3WQioyeRrt2OfDdTnZxstCPcn2qg7k8QFulnJ/IeYaEHTTnQWxyiWWLc9ALqFUFMjeHcFp7BK
 ZkhP2rZ8rNgLY/noMFCtUslJxsjBFsI+sVTZZvUwAB5tIq2DGzCLLXpsjfnVqIZlUF+x6tUNbN/jO
 14NiaXUmWtUlyOapjx2VxhWoSJjsS2vTFKGc4h0iYPX4q1VoGkzvbh3mx4GEVljMD2OPFXqj1Vc2i
 98KfUvTvBSTNb6ahE/nDPw+PMwGxm3rUOv9M6f50jDFt46IqmHe+LaiWDgnG3L5bYg1JzTmLI9jRL
 TNB0LYn4fr/GjZbs7PLHD9yCGNkVzGs0szDIDYF6Mt2ttU/Qd7gYoJD/sMvV3F4nx7Ew6et64OTFM
 +u6OuOpEZy3CmR+qvORE2FZQkzZbi2+3Amgl/SuugA12ZJZyAUpZa0R+kx6Eoowcce/7cqlLiwiKV
 al5p3ebxk/izIrL0ESzqO9sxt/WbNjLIT0ggHhvIOB+ft45g8gzaAy7FigTBd61dBaqNPjxQ4mdLf
 Yl53FaLvA1M4R4YQzc0UUVSUo+XHSkBRp8tWtQJwvA/EHcRT7zrqfCsPAgAz56W7HGsu6siAbkphy
 3mVFuERX77t4GJJOLz+PfBo6nrPQO9R8t3rMG4EuI=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XCy-0008EL-Pa; Wed, 23 Oct 2024 09:59:13 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 23 Oct 2024 09:58:23 +0100
Message-Id: <20241023085852.1061031-8-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 07/36] next-cube: introduce next_pc_init() object init function
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Move initialisation of the memory regions and GPIOs from next_pc_realize() to
the new next_pc_init() function.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/next-cube.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 0c3f8780a1..3b4c361156 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -897,20 +897,24 @@ static void next_pc_reset(DeviceState *dev)
 
 static void next_pc_realize(DeviceState *dev, Error **errp)
 {
-    NeXTPC *s = NEXT_PC(dev);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    /* SCSI */
+    next_scsi_init(dev);
+}
+
+static void next_pc_init(Object *obj)
+{
+    NeXTPC *s = NEXT_PC(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
-    qdev_init_gpio_in(dev, next_irq, NEXT_NUM_IRQS);
+    qdev_init_gpio_in(DEVICE(obj), next_irq, NEXT_NUM_IRQS);
 
     memory_region_init_io(&s->mmiomem, OBJECT(s), &next_mmio_ops, s,
                           "next.mmio", 0x9000);
     memory_region_init_io(&s->scrmem, OBJECT(s), &next_scr_ops, s,
                           "next.scr", 0x20000);
+
     sysbus_init_mmio(sbd, &s->mmiomem);
     sysbus_init_mmio(sbd, &s->scrmem);
-
-    /* SCSI */
-    next_scsi_init(dev);
 }
 
 /*
@@ -972,6 +976,7 @@ static void next_pc_class_init(ObjectClass *klass, void *data)
 static const TypeInfo next_pc_info = {
     .name = TYPE_NEXT_PC,
     .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_init = next_pc_init,
     .instance_size = sizeof(NeXTPC),
     .class_init = next_pc_class_init,
 };
-- 
2.39.5


