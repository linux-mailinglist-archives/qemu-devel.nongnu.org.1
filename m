Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A72AA42289
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Feb 2025 15:12:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmZAN-00067Y-Hh; Mon, 24 Feb 2025 09:10:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tmZAI-00067D-R9; Mon, 24 Feb 2025 09:10:35 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tmZAG-0003D7-V8; Mon, 24 Feb 2025 09:10:34 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2DE024E6039;
 Mon, 24 Feb 2025 15:10:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id TAViYdDBcBQT; Mon, 24 Feb 2025 15:10:26 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3B36C4E6010; Mon, 24 Feb 2025 15:10:26 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2] hw/misc/macio/gpio.c: Add constants for register bits
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
    philmd@linaro.org
Message-Id: <20250224141026.3B36C4E6010@zero.eik.bme.hu>
Date: Mon, 24 Feb 2025 15:10:26 +0100 (CET)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, PP_MIME_FAKE_ASCII_TEXT=0.238,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add named constants for register bit values that should make it easier
to understand what these mean.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/macio/gpio.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/misc/macio/gpio.c b/hw/misc/macio/gpio.c
index 4364afc84a..e87bfca1f5 100644
--- a/hw/misc/macio/gpio.c
+++ b/hw/misc/macio/gpio.c
@@ -34,6 +34,11 @@
 #include "qemu/module.h"
 #include "trace.h"
 
+enum MacioGPIORegisterBits {
+    OUT_DATA   = 1,
+    IN_DATA    = 2,
+    OUT_ENABLE = 4,
+};
 
 void macio_set_gpio(MacIOGPIOState *s, uint32_t gpio, bool state)
 {
@@ -41,14 +46,14 @@ void macio_set_gpio(MacIOGPIOState *s, uint32_t gpio, bool state)
 
     trace_macio_set_gpio(gpio, state);
 
-    if (s->gpio_regs[gpio] & 4) {
+    if (s->gpio_regs[gpio] & OUT_ENABLE) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "GPIO: Setting GPIO %d while it's an output\n", gpio);
     }
 
-    new_reg = s->gpio_regs[gpio] & ~2;
+    new_reg = s->gpio_regs[gpio] & ~IN_DATA;
     if (state) {
-        new_reg |= 2;
+        new_reg |= IN_DATA;
     }
 
     if (new_reg == s->gpio_regs[gpio]) {
@@ -107,12 +112,12 @@ static void macio_gpio_write(void *opaque, hwaddr addr, uint64_t value,
 
     addr -= 8;
     if (addr < 36) {
-        value &= ~2;
+        value &= ~IN_DATA;
 
-        if (value & 4) {
-            ibit = (value & 1) << 1;
+        if (value & OUT_ENABLE) {
+            ibit = (value & OUT_DATA) << 1;
         } else {
-            ibit = s->gpio_regs[addr] & 2;
+            ibit = s->gpio_regs[addr] & IN_DATA;
         }
 
         s->gpio_regs[addr] = value | ibit;
-- 
2.30.9


