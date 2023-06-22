Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2EC73989D
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 09:56:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCFBO-00059M-2q; Thu, 22 Jun 2023 03:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAi-00047z-UX
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:04 -0400
Received: from mout.kundenserver.de ([212.227.17.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAf-0002ul-Cn
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:04 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1Mzy6q-1pqZ5c1wSk-00x2wn; Thu, 22
 Jun 2023 09:55:58 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 22/24] q800: move macfb device to Q800MachineState
Date: Thu, 22 Jun 2023 09:55:42 +0200
Message-Id: <20230622075544.210899-23-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622075544.210899-1-laurent@vivier.eu>
References: <20230622075544.210899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3jlqllWOxDsuL3v784kdsbIcJ/Xxl5xwyrNZSkIDmgn4IfHGlYM
 LHD8oCRntERAw4KFd9wRiMGSzH5fpPmPT6nxRZyInOO6NQU/wAjl843toIQAFxAel19D3be
 Nty+stSi7XJ5AETju7XTY/LJ5r5tcsi1DzxqO5K2kblf2otuiQkBRK5WMr902EK9+C8wtq+
 xdwDNQsIjJiWzTUIcm1bg==
UI-OutboundReport: notjunk:1;M01:P0:09haBy0z8rY=;B3cO2BhZuUUuN4sRuOW2s5l6vba
 4O8w4C057L9E+J2lE8LBtsnn5H/euGfSD4E85vkApBdv5trGKGPpbn2eeuKryTurDYQHweFSF
 Dg+Mjzt1HDlGiSujx8ydmHeCrXjMjJyUYC1HZ5bhz8iuWVKQrfxn5BZOV9cSyZX8DFOLgnRJM
 MuVJaKX3DaBbCizHUc1RrXh7uQfKTXsgL29CbJg0eqgR9VPz9v1NlNyrr2K8Pk+eL++e5FUOR
 ja32WYO63n7ACl4FnzmuyV/uoPE7ZtJBssOdqBp/dAoqdBOziZ8umnpFRtGvetor6o92v4QMc
 2cl4TMPCenWzsXTzWai7S0Sy5pApqUUQokFZVhSvO44O1yOIEEuNFbrWM7yCMJTWOddsrWhCQ
 BzcEXIDEWfg8I4BVMBR1Cr8DUKzdSiJ6X06YTMekljUikhJ/JlZIE0grAajh+Js/CK+dSkmlK
 YuL7BzpOau/QySa8pZjFNjp+HwgIGF9HqrsTaZqKq2Da1p7GIwa+ga+fYht947pe5fv2NK+MT
 4231jWb3LVD3tlsRid02FEn1PuS1qTmw1AR6yRdofPwYQh66OxAYht91l6GoTJgnrBAGgPc3i
 4wqLB7PJWDeLOc54YwaAQ9yy2149OYKOLEwkBaGexaVeeTuffB7txL7nYlulWcPMX5n+EC83w
 5dEmucjdEpUOceg3gIo3sOICKg4kczhAIfPGmp2Oww==
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Also change the instantiation of the macfb device to use object_initialize_child().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20230621085353.113233-23-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/m68k/q800.h | 2 ++
 hw/m68k/q800.c         | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 8f2c572a81e0..b3d77f1cba6e 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -35,6 +35,7 @@
 #include "hw/scsi/esp.h"
 #include "hw/block/swim.h"
 #include "hw/nubus/mac-nubus-bridge.h"
+#include "hw/display/macfb.h"
 
 /*
  * The main Q800 machine
@@ -54,6 +55,7 @@ struct Q800MachineState {
     SysBusESPState esp;
     Swim swim;
     MacNubusBridge mac_nubus_bridge;
+    MacfbNubusState macfb;
     MemoryRegion macio;
     MemoryRegion macio_alias;
 };
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index a32e6fbf8dec..b770b71d5475 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -452,7 +452,9 @@ static void q800_machine_init(MachineState *machine)
 
     /* framebuffer in nubus slot #9 */
 
-    dev = qdev_new(TYPE_NUBUS_MACFB);
+    object_initialize_child(OBJECT(machine), "macfb", &m->macfb,
+                            TYPE_NUBUS_MACFB);
+    dev = DEVICE(&m->macfb);
     qdev_prop_set_uint32(dev, "slot", 9);
     qdev_prop_set_uint32(dev, "width", graphic_width);
     qdev_prop_set_uint32(dev, "height", graphic_height);
@@ -462,7 +464,7 @@ static void q800_machine_init(MachineState *machine)
     } else {
         qdev_prop_set_uint8(dev, "display", MACFB_DISPLAY_VGA);
     }
-    qdev_realize_and_unref(dev, BUS(nubus), &error_fatal);
+    qdev_realize(dev, BUS(nubus), &error_fatal);
 
     macfb_mode = (NUBUS_MACFB(dev)->macfb).mode;
 
-- 
2.40.1


