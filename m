Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7FD799727
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 11:50:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeuaB-0005fC-GE; Sat, 09 Sep 2023 05:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeua4-0005eR-2n
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 05:48:44 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeua1-0005FK-Tr
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 05:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PxxutsydlhpHvWGlrq0rCh/TdYydT1jYART7hBd326U=; b=bxak8P/FghzkoXhn+vBdIXChgR
 KtBE2TJgpPHWE0E4BzJeiN5Zek5aP9yVOp+Y0JnKq7wOBkeNVPqX9BSgB9DFUYUsYi5mcIguqi1pY
 fnmVVphzsjGTsQPXEkJgCos9kly7Me1f3xTgGvIpOhYyhENeXWTFYrVJW8YqPPnSxP/ZIxpXvZTN3
 bazC/pLRAAF0Elvcg2LrMBaEen6nPMRfPGvdqcKHHUbH03qFKcXuEhDd9WVy07Th9P0NGii8kvx4j
 fa7ST2KtAAjeZMujVW5mYyEzaKNBVoEvcPfnIRmMvsLCxHPV0/ssuY0Aw9lfWx+snCgpoj2vpV2ZH
 lL0rK3cqBxG4WCSyOGC0knoaOVda8ZT4UAbfBId/I5NPOeU+5u0R+M4lp+ubXxvHFSV4N22Fqm6VX
 ik9UXi+ljNewbrCMTTzz8HaNAuHa07mwg6RoAm6DbYgTyB9fGrYHaT9n9+XQXSge0tso6iVPFWUno
 2nCnEYWIhZqrWH8V784MQ+EpfIFdk0Y7VHh82qesJQPhan0eOeXKbXw3t8JjlN/JIgUOn7E1SUCDz
 HAgGJ8CBqYEMv6Ia4bHHRHZTvpcFR5BYzlyTKEma5WoAPR0mGz/wn5CiK1ADzQyD4QLw3tVx+80Fm
 XhtcRtNBa9uXQM+gJFgu5KMGJdwuaK5QVGn8YAVFw=;
Received: from [2a00:23c4:8baf:5f00:e007:7058:31bc:5be9]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeuZu-0000uO-FL; Sat, 09 Sep 2023 10:48:38 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sat,  9 Sep 2023 10:48:08 +0100
Message-Id: <20230909094827.33871-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
References: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:5f00:e007:7058:31bc:5be9
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 01/20] q800-glue.c: convert to Resettable interface
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

Convert the GLUE device to 3-phase reset. The legacy method
doesn't do anything that's invalid in the hold phase, so the
conversion is simple and not a behaviour change.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.39.2


