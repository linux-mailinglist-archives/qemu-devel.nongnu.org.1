Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9880819FAD
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 14:18:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFwSL-00082M-W3; Wed, 20 Dec 2023 08:17:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFwRs-0007qq-IL
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 08:17:28 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFwRr-0002Ov-0C
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 08:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s/6gk4s1JWMZwKvEQoHfCZZjfLVJj0fsDht8jOp+RaA=; b=eM8kAfbgkb7ZVhnZyIrQX35zoY
 0kodOcSUp4qh7RmOwzLtPFOZ9hpUG1JHOmdrSUOOU3bx/92/w6vpkTcOkfQgWEYjutqdR89+yqJAn
 pfJ4pvasc1CNC1VqGR2YnbgZUNj5gk/CVKAjfBmbFocUqFt6KeAwX7UdLqvmt83KGyDQPZAkOWr+2
 EnxIaVMQAg0nsLRJ/psJIFMwFL+hhw+NidJjY19hgvbEVD1tY2KgIQ1ExpLxAmeZSbpUT8Jqdwrrs
 4+RqxKJJG5cwf7iNcC+qXIb2DRY50BiZjflvSWqzcHsVMWzXR8kCpngEzaHOf7Utw1RQJDnalGkFU
 Xjgoqh7MVvzZopxRd1LlQq5mxsKFXwdZLWdbDufzD3qmkA2td+Z3l2608w9F7nhZ4957U1JG4oFq2
 dTRch8flcWdR9v7RNsbR/oKgLxuFTnEAtxS79Tc6gMAzSBXtcFmCNcLgEbOktl5Ff/4UYSXxJfRt5
 cH3dJsMj88a7PXK84eucXbM3adCUy4f13XUM5dnFz4oErWKCShJMlObbnlYQXZ+9q7RRufleRXSND
 kRNNWTW9OfQdF92cunPChEs0RumS3L7eWbAJgmJZVHZKqc8G8mGt8tbz1DFTiz4K40gzwU/hBxsKu
 rgZfdL22fclzmxCUFiCbssnEX1xn+YFfEA1+Mk7bk=;
Received: from host86-147-134-9.range86-147.btcentralplus.com ([86.147.134.9]
 helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFwRR-0001qt-2H; Wed, 20 Dec 2023 13:16:54 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 20 Dec 2023 13:16:39 +0000
Message-Id: <20231220131641.592826-10-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231220131641.592826-1-mark.cave-ayland@ilande.co.uk>
References: <20231220131641.592826-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.147.134.9
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 09/11] next-cube.c: move LED logic to new
 next_scr2_led_update() function
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

Ensure that the LED status is updated by calling next_scr2_led_update() whenever
the SC2 register is written.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/next-cube.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index d53f73fb8b..fd707b4b54 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -124,6 +124,18 @@ static const uint8_t rtc_ram2[32] = {
 #define SCR2_RTDATA 0x4
 #define SCR2_TOBCD(x) (((x / 10) << 4) + (x % 10))
 
+static void next_scr2_led_update(NeXTPC *s)
+{
+    if (s->scr2 & 0x1) {
+        DPRINTF("fault!\n");
+        s->led++;
+        if (s->led == 10) {
+            DPRINTF("LED flashing, possible fault!\n");
+            s->led = 0;
+        }
+    }
+}
+
 static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
 {
     uint8_t old_scr2, scr2_2;
@@ -135,15 +147,6 @@ static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
         scr2_2 = val & 0xFF;
     }
 
-    if (val & 0x1) {
-        DPRINTF("fault!\n");
-        s->led++;
-        if (s->led == 10) {
-            DPRINTF("LED flashing, possible fault!\n");
-            s->led = 0;
-        }
-    }
-
     old_scr2 = (s->old_scr2 >> 8) & 0xff;
 
     if (scr2_2 & 0x1) {
@@ -321,6 +324,7 @@ static void next_mmio_write(void *opaque, hwaddr addr, uint64_t val,
     case 0xd000 ... 0xd003:
         s->scr2 = deposit32(s->scr2, (4 - (addr - 0xd000) - size) << 3,
                             size << 3, val);
+        next_scr2_led_update(s);
         nextscr2_write(s, val, size);
         s->old_scr2 = s->scr2;
         break;
-- 
2.39.2


