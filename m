Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F467AB55D
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 18:01:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjiZH-0001Cj-0D; Fri, 22 Sep 2023 11:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=/LOp=FG=kaod.org=clg@ozlabs.org>)
 id 1qjiZE-0001Aa-CB; Fri, 22 Sep 2023 11:59:44 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=/LOp=FG=kaod.org=clg@ozlabs.org>)
 id 1qjiZC-00063g-Md; Fri, 22 Sep 2023 11:59:44 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RscQx4QkDz4x2D;
 Sat, 23 Sep 2023 01:59:37 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RscQv4HNsz4wxQ;
 Sat, 23 Sep 2023 01:59:35 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 2/4] aspeed: Clean up local variable shadowing
Date: Fri, 22 Sep 2023 17:59:22 +0200
Message-ID: <20230922155924.1172019-3-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922155924.1172019-1-clg@kaod.org>
References: <20230922155924.1172019-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=/LOp=FG=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Remove superfluous local 'irq' variables and use the one define at the
top of the routine. This fixes warnings in aspeed_soc_ast2600_realize()
such as :

  ../hw/arm/aspeed_ast2600.c: In function ‘aspeed_soc_ast2600_realize’:
  ../hw/arm/aspeed_ast2600.c:420:18: warning: declaration of ‘irq’ shadows a previous local [-Wshadow=compatible-local]
    420 |         qemu_irq irq = aspeed_soc_get_irq(s, ASPEED_DEV_TIMER1 + i);
        |                  ^~~
  ../hw/arm/aspeed_ast2600.c:312:14: note: shadowed declaration is here
    312 |     qemu_irq irq;
        |              ^~~

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/arm/aspeed_ast2600.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index a8b3a8065a11..e122e1c32d42 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -388,7 +388,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->timerctrl), 0,
                     sc->memmap[ASPEED_DEV_TIMER1]);
     for (i = 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
-        qemu_irq irq = aspeed_soc_get_irq(s, ASPEED_DEV_TIMER1 + i);
+        irq = aspeed_soc_get_irq(s, ASPEED_DEV_TIMER1 + i);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->timerctrl), i, irq);
     }
 
@@ -413,8 +413,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     }
     aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->i2c), 0, sc->memmap[ASPEED_DEV_I2C]);
     for (i = 0; i < ASPEED_I2C_GET_CLASS(&s->i2c)->num_busses; i++) {
-        qemu_irq irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                        sc->irqmap[ASPEED_DEV_I2C] + i);
+        irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore),
+                               sc->irqmap[ASPEED_DEV_I2C] + i);
         /* The AST2600 I2C controller has one IRQ per bus. */
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c.busses[i]), 0, irq);
     }
@@ -611,8 +611,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     }
     aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->i3c), 0, sc->memmap[ASPEED_DEV_I3C]);
     for (i = 0; i < ASPEED_I3C_NR_DEVICES; i++) {
-        qemu_irq irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                        sc->irqmap[ASPEED_DEV_I3C] + i);
+        irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore),
+                               sc->irqmap[ASPEED_DEV_I3C] + i);
         /* The AST2600 I3C controller has one IRQ per bus. */
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->i3c.devices[i]), 0, irq);
     }
-- 
2.41.0


