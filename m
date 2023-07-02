Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20670744E72
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 17:51:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFzJn-0004KK-Cq; Sun, 02 Jul 2023 11:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qFzJl-0004Jo-6b
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 11:48:53 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qFzJj-0007Nb-O9
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 11:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1PcuAptvkeB5YClylwv8vyT5N5x0JldzQusZF4870+c=; b=mAfWapXYRzdZ+qqzkcz1ylY7MU
 Xo1DM+J/x8pD89mI0/m/e2iC1yS1wyLUgi20n9LW0/mrmUVEonqvgTxWDRM4hMKJ/FHXVaR9CuvZQ
 wOvKlFeI/FDEfxyu8W9MM3hU8cJ2jcQh5Sl0fDi380Go7peTHVEJZg/oT0G14oCmp3OB6LdyKm159
 4eFdv5+i+tr1bZe5Qy7URQ70edfzCQoUGrPrr/BBTnHNqsDi2GPqazmCuUcbscwOH+ErUVqgOf/9N
 40XCrTrAW8MGvA6a7/YvJg7LzVI9qKkeW119TP4v7o9LXTgyEwfxTeqPjABTuaWjUbKQ/XwXoLE2F
 8H7D4n3VrQNVpKVimFQK3mCwjs6WuXpTQ6gxNbaOBovTcPoBVKtc6zp+RJ0brLSMbpuf4atOpIuFb
 SUmgLRwnmIRPjnHmpw/cYSZCrllRP/9lzKViHbtm/tKxczdelV/4bfHlx4orxdi6Jnyd78FVKXTDx
 h16XxdwgqgjeoVFvZHamXgGcggGzfcte2nAWegYOsT7ixudQ/eB63qTBmbdUy9Wbrrlbk2Rc/DhaJ
 sKeZBlC1hOzSUow+E9GZf4lIiBb+MgORZF7WNzUim2xCdHnzsTlzztPVzIPl1XsUWfB2Qcvi/RRks
 8Ip9FSVaQ7U8iYkFK30fqsnw+cjVWOlHj8YoH1y6c=;
Received: from [2a00:23c4:8bad:df00:f732:dd76:7417:d15b] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qFzJU-0001Ji-7p; Sun, 02 Jul 2023 16:48:40 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sun,  2 Jul 2023 16:48:18 +0100
Message-Id: <20230702154838.722809-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
References: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bad:df00:f732:dd76:7417:d15b
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 01/21] q800-glue.c: convert to Resettable interface
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

Convert the GLUE device to 3-phase reset. The legacy method
doesn't do anything that's invalid in the hold phase, so the
conversion is simple and not a behaviour change.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/q800-glue.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/m68k/q800-glue.c b/hw/m68k/q800-glue.c
index 34c4f0e987..710a5c331e 100644
--- a/hw/m68k/q800-glue.c
+++ b/hw/m68k/q800-glue.c
@@ -166,9 +166,9 @@ static void glue_nmi_release(void *opaque)
     GLUE_set_irq(s, GLUE_IRQ_IN_NMI, 0);
 }
 
-static void glue_reset(DeviceState *dev)
+static void glue_reset_hold(Object *obj)
 {
-    GLUEState *s = GLUE(dev);
+    GLUEState *s = GLUE(obj);
 
     s->ipr = 0;
     s->auxmode = 0;
@@ -223,11 +223,12 @@ static void glue_init(Object *obj)
 static void glue_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
     NMIClass *nc = NMI_CLASS(klass);
 
     dc->vmsd = &vmstate_glue;
-    dc->reset = glue_reset;
     device_class_set_props(dc, glue_properties);
+    rc->phases.hold = glue_reset_hold;
     nc->nmi_monitor_handler = glue_nmi;
 }
 
-- 
2.30.2


