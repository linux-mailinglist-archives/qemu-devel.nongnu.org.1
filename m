Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1043739898
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 09:56:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCFAm-0004FC-8j; Thu, 22 Jun 2023 03:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAf-00042j-RM
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:02 -0400
Received: from mout.kundenserver.de ([212.227.126.134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAa-0002sw-3G
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:01 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1McGtA-1pgC8a30qC-00cdfW; Thu, 22
 Jun 2023 09:55:52 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/24] q800: move VIA2 device to Q800MachineState
Date: Thu, 22 Jun 2023 09:55:33 +0200
Message-Id: <20230622075544.210899-14-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622075544.210899-1-laurent@vivier.eu>
References: <20230622075544.210899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IzKaGmqgnoJafGW2Jn2mb9il9CLOouHSgX407iZJdWvrKN9XpJ1
 lgUQ8MF4Bqpl6FSSjkcZb9xlQAkKgB0DFYoGDHSVXztS9I0rwVKRDXSNVSQNp3jcF+96RyR
 Jdybo7JZT5MBzvDPwoqKxGrwvE3nHLX+jMdvFj4xYyDPV9toePM1yoqYc/qRbiSi8ghBjDu
 kerAOHSx7klWb5W7ynUNg==
UI-OutboundReport: notjunk:1;M01:P0:ClDTT/s/dyA=;Q03zmL7ojn6fkRbaf/vsnUzbE65
 ER4nGEmOKcgaExrpcHsE641QuxkIkc5Me5t6t8xU3ZCqiFnwBXBm6Ft4KE4KHMfAnOid1F/vj
 8YYJZNy0ik7575KpSfjyI7Y+8NTjc4mY2a3lVv3BTnLnxTGlSDVbuR/F69+rkvnlgnbdXx3s7
 Yc9bQ8MbZACvm/ToHb6dPBckwpFmAqEKku6VCv3L988XsobRZwvJRVpNRm0Re+d/dXWHYhvk6
 SLY7vxnyb9F9dqgZsPYRIM3CLvG9xbwFu66bZIR748PeUJbr4cE7+GzoHybrYEwkhsr3fq7R8
 ZNtS4n2EiYmtjOHxuBYE9/N02ws8IDHp0x94sAdHbU8644SRbMLfQ0uoBfg0dLit74PTvOjjO
 obzEdcxyVQxOvOJtkacqYfrKAspe+UmBzVeczUUBCjMKhjTeVzN+mTtSEguakhBJL0Pw8Yzpg
 +msZUrS+NOMwmg0t5Rse5p//db2FGztsmYQypHIm7Ky8iFsUQiTVTCx71+jP1wpPGsbkyC9hu
 /+J7b1qO5t18cEXPHi8177vUCejqCRt+WTuU0qqntTmbjXIZnTQ9s7qymrZVL7Ft4drXiuYx3
 +ihYb4zI9KKLpglWcT3BsVK0h6I+UxTdprmz5ogbxDYUAKKy2oRHf5/P/CD3gSfLN5w7rIjPA
 fLhhYgo4qO2FYt6AKS33UVr26HP3Pm9ygsSBAqDb/g==
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Also change the instantiation of the VIA2 device to use object_initialize_child().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20230621085353.113233-14-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/m68k/q800.h |  1 +
 hw/m68k/q800.c         | 27 ++++++++++++++++-----------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 5cf66d08a094..06c771635b3f 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -41,6 +41,7 @@ struct Q800MachineState {
     MemoryRegion rom;
     GLUEState glue;
     MOS6522Q800VIA1State via1;
+    MOS6522Q800VIA2State via2;
     MemoryRegion macio;
     MemoryRegion macio_alias;
 };
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index fccdad5f3c90..988b4981b830 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -212,7 +212,6 @@ static void q800_machine_init(MachineState *machine)
     hwaddr parameters_base;
     CPUState *cs;
     DeviceState *dev;
-    DeviceState *via2_dev;
     DeviceState *escc_orgate;
     SysBusESPState *sysbus_esp;
     ESPState *esp;
@@ -285,9 +284,10 @@ static void q800_machine_init(MachineState *machine)
     qdev_realize_and_unref(dev, adb_bus, &error_fatal);
 
     /* VIA 2 */
-    via2_dev = qdev_new(TYPE_MOS6522_Q800_VIA2);
-    sysbus = SYS_BUS_DEVICE(via2_dev);
-    sysbus_realize_and_unref(sysbus, &error_fatal);
+    object_initialize_child(OBJECT(machine), "via2", &m->via2,
+                            TYPE_MOS6522_Q800_VIA2);
+    sysbus = SYS_BUS_DEVICE(&m->via2);
+    sysbus_realize(sysbus, &error_fatal);
     memory_region_add_subregion(&m->macio, VIA_BASE - IO_BASE + VIA_SIZE,
                                 sysbus_mmio_get_region(sysbus, 1));
     sysbus_connect_irq(sysbus, 0,
@@ -382,10 +382,14 @@ static void q800_machine_init(MachineState *machine)
     sysbus = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(sysbus, &error_fatal);
     /* SCSI and SCSI data IRQs are negative edge triggered */
-    sysbus_connect_irq(sysbus, 0, qemu_irq_invert(qdev_get_gpio_in(via2_dev,
-                                                  VIA2_IRQ_SCSI_BIT)));
-    sysbus_connect_irq(sysbus, 1, qemu_irq_invert(qdev_get_gpio_in(via2_dev,
-                                                  VIA2_IRQ_SCSI_DATA_BIT)));
+    sysbus_connect_irq(sysbus, 0,
+                       qemu_irq_invert(
+                           qdev_get_gpio_in(DEVICE(&m->via2),
+                                                   VIA2_IRQ_SCSI_BIT)));
+    sysbus_connect_irq(sysbus, 1,
+                       qemu_irq_invert(
+                           qdev_get_gpio_in(DEVICE(&m->via2),
+                                                   VIA2_IRQ_SCSI_DATA_BIT)));
     memory_region_add_subregion(&m->macio, ESP_BASE - IO_BASE,
                                 sysbus_mmio_get_region(sysbus, 0));
     memory_region_add_subregion(&m->macio, ESP_PDMA - IO_BASE,
@@ -411,11 +415,12 @@ static void q800_machine_init(MachineState *machine)
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, NUBUS_SLOT_BASE +
                     MAC_NUBUS_FIRST_SLOT * NUBUS_SLOT_SIZE);
     qdev_connect_gpio_out(dev, 9,
-                          qdev_get_gpio_in_named(via2_dev, "nubus-irq",
+                          qdev_get_gpio_in_named(DEVICE(&m->via2), "nubus-irq",
                           VIA2_NUBUS_IRQ_INTVIDEO));
     for (i = 1; i < VIA2_NUBUS_IRQ_NB; i++) {
         qdev_connect_gpio_out(dev, 9 + i,
-                              qdev_get_gpio_in_named(via2_dev, "nubus-irq",
+                              qdev_get_gpio_in_named(DEVICE(&m->via2),
+                                                     "nubus-irq",
                                                      VIA2_NUBUS_IRQ_9 + i));
     }
 
@@ -424,7 +429,7 @@ static void q800_machine_init(MachineState *machine)
      * IRQ via GLUE for use by SONIC Ethernet in classic mode
      */
     qdev_connect_gpio_out(DEVICE(&m->glue), GLUE_IRQ_NUBUS_9,
-                          qdev_get_gpio_in_named(via2_dev, "nubus-irq",
+                          qdev_get_gpio_in_named(DEVICE(&m->via2), "nubus-irq",
                                                  VIA2_NUBUS_IRQ_9));
 
     nubus = &NUBUS_BRIDGE(dev)->bus;
-- 
2.40.1


