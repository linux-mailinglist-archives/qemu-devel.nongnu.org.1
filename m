Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEBF737DE8
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 10:57:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBtd2-0004ga-W0; Wed, 21 Jun 2023 04:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtcl-0004B6-Mu
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:55:36 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtcj-0005I2-8W
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v40vpYHE+yMJwxHl5cD/t//CNeaQ4+I2oXSKoSJvkaY=; b=yoe2QTHDq74pnhUDmVXhXYnXNT
 N4Erpvdy9joMMLVGHx9AHa404Bezhu5F4l4tvzgK6wJcZxDdGPiYUalj+LWbgI2Q/txBVItBdtbVt
 b+JwOaOZhWJQHf+P/pVmU7CLsGg/CzVEDDYiW58Jdm11eeDCwbG7sTZh2HJhMDGdY+JVaqZWGnWyN
 R0wIw42D79SJnyh//2rbaMZHxbuIEQgoGrgHFjQ+k2Cwaz6EzQrzmsN5f6JEvfjSm5coIrzkNfOA9
 N+MyKDBTB8of9qU81xCYw3k4Bt59vzap0QkDFclnsOVp6NuwX6CEQRb8jZVctneyJYCpCcGSLRGME
 Frpe7DzJ9V4Ks/lRokpFBi0iBvE0XJksydlj6jWEF6Msc+ZgzPQGdNxHXL0lCXRqj2ywKWLUB9MEs
 O5sjN6LjNKHX8F2t0lVU1Xo2AtlSVPp90fgiKM0h7nWuJiJaAfxVi56mJfRFicoGGzobQouyVpzC7
 aBGnnBtRX8wMY7JO45cNcdsHS1Z//wbU5LBczgDAidFiyJIiPFntrMVuPD2+dY4X6eoD5aYUcTzFs
 kXC4wFcwNQ7qVy1YrJfXgSf5OnZzYr2XXlYD5iDX90fuJsl87Nma/mX5UKpBgFmp7eVeOPGtRlFW/
 QxR0BIkNfaY5DmCcqcCB9u9UGrZ2M0kWjhskNEPaM=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtcP-0001ZB-Tr; Wed, 21 Jun 2023 09:55:15 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 21 Jun 2023 09:53:51 +0100
Message-Id: <20230621085353.113233-23-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
References: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 22/24] q800: move macfb device to Q800MachineState
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

Also change the instantiation of the macfb device to use object_initialize_child().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/m68k/q800.c         | 6 ++++--
 include/hw/m68k/q800.h | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index a32e6fbf8d..b770b71d54 100644
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
 
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 8f2c572a81..b3d77f1cba 100644
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
-- 
2.30.2


