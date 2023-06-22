Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D17FF7398CD
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 10:00:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCFBI-0004m5-KZ; Thu, 22 Jun 2023 03:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAf-00042m-Uc
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:02 -0400
Received: from mout.kundenserver.de ([212.227.126.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAa-0002tU-Sn
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:01 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mi2aH-1pYDWd37dR-00e2J5; Thu, 22
 Jun 2023 09:55:54 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/24] q800: move escc_orgate device to Q800MachineState
Date: Thu, 22 Jun 2023 09:55:37 +0200
Message-Id: <20230622075544.210899-18-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622075544.210899-1-laurent@vivier.eu>
References: <20230622075544.210899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oBZ2MWvC3s7DHW5P16pH8wSgi3VrCWT1P0Qy8IDxtNy0XpAKS2R
 OwwE7fDi15K3O8t2jmHR50iZ/oL0gLvcjTWdR1pG+tyC4RUFEEE5ScOt8aSSa/HAB3XnvQH
 gj7h7WIyQPMHv1TssmC3l2h2T9ZLYDeiukoJuqDCUgRz8cKqkI+C21mdF6+GY1v+l9iUHVm
 ez8+liNUxxfT8kfw0G9Lg==
UI-OutboundReport: notjunk:1;M01:P0:M6U5CpwuyNM=;1mWO9JE2G8PpNzEZ5DNCEONnw6n
 buQ0zTKfsWk4HbBGASRelKznX9H6JYxo0Mt0Nkj1ZQGCdkHhbumfOCoY5Evii83IZZjK70XZz
 xPHimEGv/Vk1l10mfMlib4Iq0nFhd7AKZiPlEHf4dipfgNUnSrv60pRU+3RG0GK+MFmBPQxJV
 bnH74fJHfx+J+Weyo6wYqHw3kUbIBgI1WDRCSfLVLwrNUKkATLuvCPPcU1+o8YXK1rAtBLWbU
 3sM7bTsHrmrc71qwbaSBl2kSPHwk06pMm33FSZWvLr6qfR3XTe6624A9AKxrmOkKAfiS0WeAc
 DUdjQfl736MTEbyRPscaLmJnXPedyoUrwV78sgs5UTwsn1irCmWYz8sO2F+qvhox+yYLSFTNW
 4DPW8MCha21uRVpmGoHU0u3tcj+f5t2KMxSQtntOfBpeb4SMixPybXwbueMi0Lq+skxET1zCc
 wtZU+A3qDbBjRcD8azS5nFEuvaZJDOq2kf2BJLr79JnIzUKGfv5R1x25q8gEgn+5e2pe+20i2
 By96u3aDo231HxzdQ8/QoDuDv8gQw5S8pkpke5D8g0INPJEKDuo6TdwSsHnd1/QMPzQwqe3Sf
 xxBQQ63VtZBdivmbp26o5PNfV6dl60VlfELHxXOtVWKcMaiHYgneNVd50uJ9mULoh4N3Z1Gwd
 M26n/5Z9hhWEwCIOszlM9A09wkJEn7vHDo/lbD3zAg==
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
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

Also change the instantiation of the escc_orgate device to use object_initialize_child().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20230621085353.113233-18-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/m68k/q800.h |  2 ++
 hw/m68k/q800.c         | 16 +++++++++-------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 9e76a3fe7c0c..36e1bd8e4e4d 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -31,6 +31,7 @@
 #include "hw/misc/mac_via.h"
 #include "hw/net/dp8393x.h"
 #include "hw/char/escc.h"
+#include "hw/or-irq.h"
 
 /*
  * The main Q800 machine
@@ -46,6 +47,7 @@ struct Q800MachineState {
     MOS6522Q800VIA2State via2;
     dp8393xState dp8393x;
     ESCCState escc;
+    OrIRQState escc_orgate;
     MemoryRegion macio;
     MemoryRegion macio_alias;
 };
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 8bf94b2511c1..c6314c6bf937 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -212,7 +212,6 @@ static void q800_machine_init(MachineState *machine)
     hwaddr parameters_base;
     CPUState *cs;
     DeviceState *dev;
-    DeviceState *escc_orgate;
     SysBusESPState *sysbus_esp;
     ESPState *esp;
     SysBusDevice *sysbus;
@@ -361,12 +360,15 @@ static void q800_machine_init(MachineState *machine)
     sysbus_realize(sysbus, &error_fatal);
 
     /* Logically OR both its IRQs together */
-    escc_orgate = DEVICE(object_new(TYPE_OR_IRQ));
-    object_property_set_int(OBJECT(escc_orgate), "num-lines", 2, &error_fatal);
-    qdev_realize_and_unref(escc_orgate, NULL, &error_fatal);
-    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(escc_orgate, 0));
-    sysbus_connect_irq(sysbus, 1, qdev_get_gpio_in(escc_orgate, 1));
-    qdev_connect_gpio_out(escc_orgate, 0,
+    object_initialize_child(OBJECT(machine), "escc_orgate", &m->escc_orgate,
+                            TYPE_OR_IRQ);
+    object_property_set_int(OBJECT(&m->escc_orgate), "num-lines", 2,
+                            &error_fatal);
+    dev = DEVICE(&m->escc_orgate);
+    qdev_realize(dev, NULL, &error_fatal);
+    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(dev, 0));
+    sysbus_connect_irq(sysbus, 1, qdev_get_gpio_in(dev, 1));
+    qdev_connect_gpio_out(dev, 0,
                           qdev_get_gpio_in(DEVICE(&m->glue),
                                            GLUE_IRQ_IN_ESCC));
     memory_region_add_subregion(&m->macio, SCC_BASE - IO_BASE,
-- 
2.40.1


