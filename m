Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A4A7B2EA7
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:57:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9Dm-0005J5-3U; Fri, 29 Sep 2023 04:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9Dh-0005Ek-5k
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DF-0005ee-Bk
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HwpHxK4G0HNzcwEl8e+YKuNMHJXerkGYwDjFt5d4jK8=;
 b=IDiRiukd2JTtd1L1N/n8uF7MYgU2UO7+jjJAFRyLO4s2fWEUv3fjml9RXFFzFsSlrMqBEz
 VYJQn1sUwqUJgwBbY9Gnb0A95NCHM4DsMjsTN9uwt8Xm3Nx+TSxGLbRLkZ4gMwv8nI2V9e
 ippnO4+7Z5t/qor6K+t1g88Az6xuj7E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-538-ZXULGJfePkOtwbK_egpK3Q-1; Fri, 29 Sep 2023 04:50:58 -0400
X-MC-Unique: ZXULGJfePkOtwbK_egpK3Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BFE08803470;
 Fri, 29 Sep 2023 08:50:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DC82C15BB8;
 Fri, 29 Sep 2023 08:50:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D436621E68A1; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 44/56] aspeed: Clean up local variable shadowing
Date: Fri, 29 Sep 2023 10:50:41 +0200
Message-ID: <20230929085053.2789105-45-armbru@redhat.com>
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Cédric Le Goater <clg@kaod.org>

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
Message-ID: <20230922155924.1172019-3-clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/arm/aspeed_ast2600.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index a8b3a8065a..e122e1c32d 100644
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


