Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 175107398B7
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 09:58:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCFBK-0004t2-1X; Thu, 22 Jun 2023 03:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAh-00044U-Aj
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:03 -0400
Received: from mout.kundenserver.de ([212.227.17.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAe-0002uG-Q8
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:02 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N8XDT-1pyVqv4881-014RC6; Thu, 22
 Jun 2023 09:55:57 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/24] q800: move SWIM device to Q800MachineState
Date: Thu, 22 Jun 2023 09:55:39 +0200
Message-Id: <20230622075544.210899-20-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622075544.210899-1-laurent@vivier.eu>
References: <20230622075544.210899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gVhnhMc3L5eB41slMJftQn96t0LiIxyNkrKLQm9hK2czVxzxMXj
 8MUoYblwgGMSdsH2eW+EsCewXBkNCtgbNlku6unVeQyhHr89Wf0r0e5DUex4C9dXbhpTdGY
 QTCQ59lmYXn9LQl8nv6fD3zVpvg/jeVrhOCp9s2XL76GbuEFDpjgOqGciEIfMYUhE6vyGck
 zWdUKrohQ05EtjP/r6org==
UI-OutboundReport: notjunk:1;M01:P0:8iJcMGzIFg0=;X1EPU3p0AUSAcrrBIyirqLqrpBe
 f3mYPhkRgUfwgK/FM/DSwB6gNLHc/IG1q1dW452Cpptx/Ggqs90aVM22i7NLMryPTdy2qaaKv
 1J+HctKk7KXsPQp+LtjRai5G7p6tHcM9eVk82k6I+3jHPFr0fM+4MFerBvvZ0kIQy12TkxWdL
 pAfDhlRiYfcUDnSY2zm+unXE78kPATlhZgyEJiWCVcajICYmOmlRr3Cx+m3AgzvaU4LCbbMxy
 HoNSctzp3Jfkt6xsmrDfUjujRtsl1eLOU/pqcREoMycOmhHV2Sb86ZYdxRgJHqauqEkpfH3io
 9KIwivmhzbJZWRzLKnxdNE+W+aHbXt7ChJhAcFXLndCDa5PW6u+5hdRKLWFUR1Y+zqUE2FLyj
 uAf7eDxeeNRYYnutu9BHm6V1OhbIe51fMZnjefPpku4qSf0Z6zzPIJH40V9P7of7Wodcc1Kj8
 ai9S5EF04f0ehdiuJzkHXrwwMni9xSeBdxzUjYTYIMxc91mjs3AsJKbZf9KvR5jtNF/FanoEs
 AxgNbe/JrD+HC7kidKijIWdGtvNIebq/y5tGMzgM5ZnQ/WGxV+hrBont2TIlsM8B3hVYJtUW7
 WEaCfZz4MmYCL9kehyp1UfILjDc8gZx2Owoh4k6iVyahAHnQaNLbYcRh7X/gq3l/0qXfCIZrS
 geKE8N6ozCKz+2RIv8Hd5mSCMYQT9QicI2cKDmqBIQ==
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Also change the instantiation of the SWIM device to use object_initialize_child().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20230621085353.113233-20-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/m68k/q800.h | 2 ++
 hw/m68k/q800.c         | 8 +++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 8f23e0c4c6a6..06e095ae293f 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -33,6 +33,7 @@
 #include "hw/char/escc.h"
 #include "hw/or-irq.h"
 #include "hw/scsi/esp.h"
+#include "hw/block/swim.h"
 
 /*
  * The main Q800 machine
@@ -50,6 +51,7 @@ struct Q800MachineState {
     ESCCState escc;
     OrIRQState escc_orgate;
     SysBusESPState esp;
+    Swim swim;
     MemoryRegion macio;
     MemoryRegion macio_alias;
 };
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 9da46f445615..50fc7de9a20b 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -406,10 +406,12 @@ static void q800_machine_init(MachineState *machine)
 
     /* SWIM floppy controller */
 
-    dev = qdev_new(TYPE_SWIM);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    object_initialize_child(OBJECT(machine), "swim", &m->swim,
+                            TYPE_SWIM);
+    sysbus = SYS_BUS_DEVICE(&m->swim);
+    sysbus_realize(sysbus, &error_fatal);
     memory_region_add_subregion(&m->macio, SWIM_BASE - IO_BASE,
-                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
+                                sysbus_mmio_get_region(sysbus, 0));
 
     /* NuBus */
 
-- 
2.40.1


