Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3591815086
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 21:01:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEEMk-0005uW-20; Fri, 15 Dec 2023 15:00:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rEEMZ-0005ry-Ef
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 15:00:55 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rEEMV-0002W6-BE
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 15:00:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t7NYmuuKOglnRq+iVZqx0e5y2gO1A/159zsXHO+M4qk=; b=QZW73i0iyBHymChJK3XtVk0hC1
 UgYywS/x5Lbb8ZdnGsEuQB0FeemgSFSV3fREppfbUhjQH9rfU30z4MKa0B12F9pYN5ytHzmARGX12
 rfYYoPRdGknXL4IdWTOd3dc5IUuQxYzDk9XWknjk2OqDwP9DPFvUMnrxy8kXMpf7C0JMxwAITnnLC
 C8raXJ4qJ/WgjGg2r6KeZTvzkKhYXh9LfwwVH4HiQAdxLO+eIVhkzVKvvFH4MoMhP1azdjkA1JNUT
 +5NTp/lGHB6pXvvjPtRb990SwOsT0AhykI+X7nzPc39T2zxJf4AT2TEQgZCpLaVy/czpiX7PwloNQ
 z26K6BOM7V/TKg7xX+ygStOyC4H3T3qdvS6n0f0aucxiGSWPjrOuL+jdgp3STSx6HP1x/5+gLo757
 AJdmfH2dVJJZQzdeAv3yaaT09CWaqZ9mIChWS9NRZFdPWotHEuFk8OlUwVHE33Xpm1pDuW4nqf4cV
 5UCuJCCEvjaO+po0bpOZTiDsZTUP+VH0h8Aw/K3PdJRf0L1jpBA9Ro+A+cZLw++0I/5Xq1J4D5ptn
 XMl0/XMUF+wPJjc/fUNKNcsnqgNCrW3iR3mzxavehFpDJAIDwLk9YS14lEXOFqzZO6/591vdZxgI3
 ZBegl578A7Ge6wyp2cq8DXZz4jwYcI/RfBMD8qi1s=;
Received: from [2a00:23c4:8bb0:f100:5e2c:460f:a6a7:b066]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rEEM4-000AEs-8j; Fri, 15 Dec 2023 20:00:20 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Fri, 15 Dec 2023 20:00:05 +0000
Message-Id: <20231215200009.346212-9-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231215200009.346212-1-mark.cave-ayland@ilande.co.uk>
References: <20231215200009.346212-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:f100:5e2c:460f:a6a7:b066
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 08/12] next-cube.c: move LED logic to new
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
index f2222554fa..7ffd1c412e 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -123,6 +123,18 @@ static const uint8_t rtc_ram2[32] = {
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
     static uint8_t old_scr2;
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
     if (scr2_2 & 0x1) {
         /* DPRINTF("RTC %x phase %i\n", scr2_2, rtc->phase); */
         if (rtc->phase == -1) {
@@ -318,6 +321,7 @@ static void next_mmio_write(void *opaque, hwaddr addr, uint64_t val,
         break;
 
     case 0xd000 ... 0xd003:
+        next_scr2_led_update(s);
         nextscr2_write(s, val, size);
         break;
 
-- 
2.39.2


