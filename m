Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 349DA9FA5AB
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Dec 2024 14:09:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPLdl-0004GR-1s; Sun, 22 Dec 2024 08:05:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLb8-0006N1-NY
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:02:19 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLb6-0000t7-Pd
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:02:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=fn8EjiAwmeAdr8NdfHCg0vwfcy5sjWx+LFca0K+b2Nk=; b=TAMw3+EvG7mIbo4FyRlJDrGek7
 dAZp9Y11QchMKtcMcGhKZ8khI0iDmTa/7daID3xI0QHo68oQtIZHcI3FZflfNQOBi4uBxki8Vf1Ik
 WK+g/ou1NBxSMnpmg1qQEkyFpOiTgG4uWnp4TmV5tdOhtG0NTQSkCbJccv4oEfDGJA0ze9ovgpCrg
 0zd0qZOs3T43m6lpaO78qi9JnA0ksE63nvBSUdDCKRjdpNbURfqr2jUfPlR8ggZiVeuEWUxyGDij+
 qm1l4u/t7Re/uGdclbXT0zSxR+DyVsBOycarFU10u/vgUXJ17oisbUrZbYWpNjpQkxiOkJS6iz4pq
 1/b0Xjt6pcR0cYvN6Ho+gjZAybYsABIj2Hd/hDTkdFRw/wUkiUwLZdqBdai8XODQKFqohBqAZaCVo
 Iu1ZrZgY1tttlT3xHEd06lThytHOr3UaECbpEUaqBpIHDPU3MLpguOr6BofEz3EX7eaNryF1vR7bI
 Twb+ZSluS3wKKS4qfB8JSke1vvIJPmT2zUSB9v0Hs/lf67zeV+U5UbdPeWTvRIMySLiu6u2P4xlKa
 U7n2wNeuZD7qigjutpAljxzL5iPobV0Qwds/rcwzCa7JQCebjv9CcvKtpfyEBmOrDmlI2aS2RGk1z
 /2lGCiJaTkli3OJIzeSAKi3JKE6yfce/oqZQpde78=;
Received: from [2a02:8012:2f01:0:33a9:475d:1cd9:884]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLaJ-0002L7-Hu; Sun, 22 Dec 2024 13:01:31 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Sun, 22 Dec 2024 13:00:06 +0000
Message-Id: <20241222130012.1013374-28-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
References: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:33a9:475d:1cd9:884
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 27/33] next-cube: move rtc-data-in gpio from next-pc to
 next-rtc device
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

Add a new rtc-data-out gpio to the next-pc device and wire it up to the next-rtc
rtc-data-in gpio using the standard qdev gpio APIs.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index a279754643..83154a3661 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -105,6 +105,7 @@ struct NeXTPC {
 
     NeXTRTC rtc;
     qemu_irq rtc_power_irq;
+    qemu_irq rtc_data_irq;
 };
 
 typedef struct next_dma {
@@ -179,8 +180,8 @@ static bool next_rtc_cmd_is_write(uint8_t cmd)
 
 static void next_rtc_data_in_irq(void *opaque, int n, int level)
 {
-    NeXTPC *s = NEXT_PC(opaque);
-    NeXTRTC *rtc = &s->rtc;
+    NeXTRTC *rtc = NEXT_RTC(opaque);
+    NeXTPC *s = NEXT_PC(container_of(rtc, NeXTPC, rtc));
 
     if (rtc->phase < 8) {
         rtc->command = (rtc->command << 1) | level;
@@ -274,13 +275,10 @@ static void next_scr2_rtc_update(NeXTPC *s)
         /* If we are in going down clock... do something */
         if (((old_scr2 & SCR2_RTCLK) != (scr2_2 & SCR2_RTCLK)) &&
                 ((scr2_2 & SCR2_RTCLK) == 0)) {
-            qemu_irq rtc_data_in_irq = qdev_get_gpio_in_named(
-                DEVICE(s), "rtc-data-in", 0);
-
             if (scr2_2 & SCR2_RTDATA) {
-                qemu_irq_raise(rtc_data_in_irq);
+                qemu_irq_raise(s->rtc_data_irq);
             } else {
-                qemu_irq_lower(rtc_data_in_irq);
+                qemu_irq_lower(s->rtc_data_irq);
             }
         }
     } else {
@@ -1028,6 +1026,12 @@ static void next_rtc_reset_hold(Object *obj, ResetType type)
     memcpy(rtc->ram, rtc_ram2, 32);
 }
 
+static void next_rtc_init(Object *obj)
+{
+    qdev_init_gpio_in_named(DEVICE(obj), next_rtc_data_in_irq,
+                            "rtc-data-in", 1);
+}
+
 static const VMStateDescription next_rtc_vmstate = {
     .name = "next-rtc",
     .version_id = 3,
@@ -1057,6 +1061,7 @@ static void next_rtc_class_init(ObjectClass *klass, void *data)
 static const TypeInfo next_rtc_info = {
     .name = TYPE_NEXT_RTC,
     .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_init = next_rtc_init,
     .instance_size = sizeof(NeXTRTC),
     .class_init = next_rtc_class_init,
 };
@@ -1128,6 +1133,9 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(d), errp)) {
         return;
     }
+    /* Data from NeXTPC to RTC */
+    qdev_connect_gpio_out_named(dev, "rtc-data-out", 0,
+                                qdev_get_gpio_in_named(d, "rtc-data-in", 0));
 }
 
 static void next_pc_init(Object *obj)
@@ -1166,8 +1174,8 @@ static void next_pc_init(Object *obj)
     s->rtc_power_irq = qdev_get_gpio_in(DEVICE(obj), NEXT_PWR_I);
     qdev_init_gpio_in_named(DEVICE(obj), next_pc_rtc_data_in_irq,
                             "pc-rtc-data-in", 1);
-    qdev_init_gpio_in_named(DEVICE(obj), next_rtc_data_in_irq,
-                            "rtc-data-in", 1);
+    qdev_init_gpio_out_named(DEVICE(obj), &s->rtc_data_irq,
+                             "rtc-data-out", 1);
 }
 
 /*
-- 
2.39.5


