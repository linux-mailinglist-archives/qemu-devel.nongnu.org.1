Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EC096F301
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Sep 2024 13:25:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smWwx-0003oR-7C; Fri, 06 Sep 2024 07:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWvr-0000Mt-IA; Fri, 06 Sep 2024 07:15:16 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWvp-0007yu-Ki; Fri, 06 Sep 2024 07:15:15 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 28D968C488;
 Fri,  6 Sep 2024 14:12:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 295FA1336F2;
 Fri,  6 Sep 2024 14:13:26 +0300 (MSK)
Received: (nullmailer pid 353618 invoked by uid 1000);
 Fri, 06 Sep 2024 11:13:24 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.3 24/69] hw/misc/bcm2835_property: Fix handling of
 FRAMEBUFFER_SET_PALETTE
Date: Fri,  6 Sep 2024 14:12:33 +0300
Message-Id: <20240906111324.353230-24-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
References: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

The documentation of the "Set palette" mailbox property at
https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface#set-palette
says it has the form:

    Length: 24..1032
    Value:
        u32: offset: first palette index to set (0-255)
        u32: length: number of palette entries to set (1-256)
        u32...: RGBA palette values (offset to offset+length-1)

We get this wrong in a couple of ways:
 * we aren't checking the offset and length are in range, so the guest
   can make us spin for a long time by providing a large length
 * the bounds check on our loop is wrong: we should iterate through
   'length' palette entries, not 'length - offset' entries

Fix the loop to implement the bounds checks and get the loop
condition right. In the process, make the variables local to
this switch case, rather than function-global, so it's clearer
what type they are when reading the code.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240723131029.1159908-2-peter.maydell@linaro.org
(cherry picked from commit 0892fffc2abaadfb5d8b79bb0250ae1794862560)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: context fix due to lack of
 v9.0.0-1812-g5d5f1b60916a "hw/misc: Implement mailbox properties for customer OTP and device specific private keys"
 also remove now-unused local `n' variable which gets removed in the next change in this file,
 v9.0.0-2720-g32f1c201eedf "hw/misc/bcm2835_property: Avoid overflow in OTP access properties")

diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index bdd9a6bbce..faa489491c 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -30,8 +30,6 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
     uint32_t tot_len;
     size_t resplen;
     uint32_t tmp;
-    int n;
-    uint32_t offset, length, color;
 
     /*
      * Copy the current state of the framebuffer config; we will update
@@ -273,19 +271,25 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             resplen = 16;
             break;
         case RPI_FWREQ_FRAMEBUFFER_SET_PALETTE:
-            offset = ldl_le_phys(&s->dma_as, value + 12);
-            length = ldl_le_phys(&s->dma_as, value + 16);
-            n = 0;
-            while (n < length - offset) {
-                color = ldl_le_phys(&s->dma_as, value + 20 + (n << 2));
-                stl_le_phys(&s->dma_as,
-                            s->fbdev->vcram_base + ((offset + n) << 2), color);
-                n++;
+        {
+            uint32_t offset = ldl_le_phys(&s->dma_as, value + 12);
+            uint32_t length = ldl_le_phys(&s->dma_as, value + 16);
+            int resp;
+
+            if (offset > 255 || length < 1 || length > 256) {
+                resp = 1; /* invalid request */
+            } else {
+                for (uint32_t e = 0; e < length; e++) {
+                    uint32_t color = ldl_le_phys(&s->dma_as, value + 20 + (e << 2));
+                    stl_le_phys(&s->dma_as,
+                                s->fbdev->vcram_base + ((offset + e) << 2), color);
+                }
+                resp = 0;
             }
-            stl_le_phys(&s->dma_as, value + 12, 0);
+            stl_le_phys(&s->dma_as, value + 12, resp);
             resplen = 4;
             break;
-
+        }
         case RPI_FWREQ_FRAMEBUFFER_GET_NUM_DISPLAYS:
             stl_le_phys(&s->dma_as, value + 12, 1);
             resplen = 4;
-- 
2.39.2


