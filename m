Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C137398B6
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 09:58:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCFBH-0004gP-Ny; Thu, 22 Jun 2023 03:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAh-00043p-0i
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:03 -0400
Received: from mout.kundenserver.de ([212.227.126.134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAb-0002te-8h
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:02 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N0Fh1-1pqI6m0sOl-00xMNF; Thu, 22
 Jun 2023 09:55:55 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/24] q800: move ESP device to Q800MachineState
Date: Thu, 22 Jun 2023 09:55:38 +0200
Message-Id: <20230622075544.210899-19-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622075544.210899-1-laurent@vivier.eu>
References: <20230622075544.210899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cqImZqtHm3pc+u+8T9QK0HPyVhJns5cvp/ws+OFP79te4JG+0IB
 gHf2CAxfJMsSbg4SuIgcW6oOigRY0wJerjcHTuk35Iky3BelnFy7gvD5xePhKMdEGSdD7Os
 6tVWjvCc+GAZM6PiR/z0OWfjyXfm8DKZ+3KzdNKW05GmVv+eYSwiLBQOkng3fPpN1oaHFRt
 3t09x9+fuajbdg7ho1gwg==
UI-OutboundReport: notjunk:1;M01:P0:3mW9R8Ygykw=;MDoMZOJVi5Tjb8YHOg5fdl4aA/9
 8//31qwtTsAZuM9qNl7MRIO5LWxWduUnTvuv5AUwcleXvHRFLhGw0Mu5ivu4Qkmo8wenlX9sy
 LLllPwnCdUHzIwz8m2NCZjQMg9kQIkrincuNmf3a32hs+aELPcalNxmEKG2KaUx2TBAo9q4nZ
 EpDVpNCzqUSI6eIM4Tup9UlDt2dG7FC9FUSA71lykxr1CxoXlywklKDQcf2ZhqCgchoDgyNk/
 1N50knAP0qCetiILXZhLElB9oAsjFl/2UO7WMyhIPoibuTsKZq5SVuzyoU9LBirJQDwpt1Sdd
 0DIAdkZ2urNEmQWBjd4i/BQyBIOqXlHf5GXTpoLr39dI4c0LumyROTZnNJBRHlkPgQhX/bctb
 3kfjrVmRYA8mLPA3q0gGfo8actWYVn/oujNdPV5oOVOEm1/iSLhSMDW1KQ6IHPQ1xQN2iOb5z
 P80EkfBX7OlHdQxUdPPuJ4ArKiJx6iixd/QJr5yNkqlTMWEmc7tX7AIuAP4isA+h5M2PB3l+r
 eP9BHPMcjBAUm2zYvmneorgYco9c4gLeENhkFzZUh0q5ATbXbnr0+li2E2imhONewsnRVfa/V
 /ai/rlSQ6Cs6EKji0k5mJhMWZyhV0+vglzTHW/zmVqvzzdyKcJpP47zfZ+bzBAeQWQ69VNAOG
 4aGb6gucnGm5UCMe8ySYUfe2r7goF8cdwhSS53wqqQ==
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

Also change the instantiation of the ESP device to use object_initialize_child().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20230621085353.113233-19-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/m68k/q800.h | 2 ++
 hw/m68k/q800.c         | 9 +++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 36e1bd8e4e4d..8f23e0c4c6a6 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -32,6 +32,7 @@
 #include "hw/net/dp8393x.h"
 #include "hw/char/escc.h"
 #include "hw/or-irq.h"
+#include "hw/scsi/esp.h"
 
 /*
  * The main Q800 machine
@@ -48,6 +49,7 @@ struct Q800MachineState {
     dp8393xState dp8393x;
     ESCCState escc;
     OrIRQState escc_orgate;
+    SysBusESPState esp;
     MemoryRegion macio;
     MemoryRegion macio_alias;
 };
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index c6314c6bf937..9da46f445615 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -376,8 +376,9 @@ static void q800_machine_init(MachineState *machine)
 
     /* SCSI */
 
-    dev = qdev_new(TYPE_SYSBUS_ESP);
-    sysbus_esp = SYSBUS_ESP(dev);
+    object_initialize_child(OBJECT(machine), "esp", &m->esp,
+                            TYPE_SYSBUS_ESP);
+    sysbus_esp = SYSBUS_ESP(&m->esp);
     esp = &sysbus_esp->esp;
     esp->dma_memory_read = NULL;
     esp->dma_memory_write = NULL;
@@ -385,8 +386,8 @@ static void q800_machine_init(MachineState *machine)
     sysbus_esp->it_shift = 4;
     esp->dma_enabled = 1;
 
-    sysbus = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(sysbus, &error_fatal);
+    sysbus = SYS_BUS_DEVICE(&m->esp);
+    sysbus_realize(sysbus, &error_fatal);
     /* SCSI and SCSI data IRQs are negative edge triggered */
     sysbus_connect_irq(sysbus, 0,
                        qemu_irq_invert(
-- 
2.40.1


