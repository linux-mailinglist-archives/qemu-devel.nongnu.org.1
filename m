Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6833819FB3
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 14:19:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFwSL-00081D-1C; Wed, 20 Dec 2023 08:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFwRm-0007qT-Sp
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 08:17:16 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFwRk-0002NX-NL
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 08:17:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8AoZO7qxeVLLqj8A7vGf+r5/omtc4v8A0boQwNGYSQg=; b=X2nSvxi40d6SlVKII7eIUJNozd
 fIka/14qzj9IBR7Cc2vobF8Jg80u369PF2iEKSaxqnv26tLL/2qpxf8S324jKRmTUmIi7gF1Gazv4
 HIOr0NcR2TnzP+PQQLPZEO4NEswI9Bb3JtPO9XNSFJnGUMdGnJMCZmkS76EK+A24EDBek5I5334gH
 HcLycejmO7W597h9VV4JMOcrPphHHSgGN75f+3ALTdzxHRW5yHZmwJsjlDxqPJudE36qYbQeLn6R1
 jA9QlZmbLTgTn0IEZt9HLDCKotaQ9OaC7mN6jaGt7tgVNcHvRf7X902dg3NVvgaaxnWneaHv6F84t
 F1BnHBkkY/YUyU6ujI8yF7aZf+cojo2Kk1cE/6QR1t6OlPLxvNTFftvs57giet+i7BkHJwmpWNIKO
 jl2XPFyujcUWiIGile3NATh8YlsQWMICRSXzTUt8+9ddpJTe/sIja666On+nxTZcaFNC1MdjOtCie
 IKm2/C70Qw9AahKxdOIGczbDghF+NANQYpMZu0Kq8/2hc/A+lftz1VKw/VR0/JAiOO7M6JSq9SDxc
 tkAsZAMW5r1VkdgoPzIzRCGOa7k7ZpSrdX2IcXGGPTtN+II6O7iShw3d90v9mhBCCFFcXnZ0FlHG0
 KBxUTbS7nH/W2mnU0hi/ozxycOkx3InCbqMGyc7cQ=;
Received: from host86-147-134-9.range86-147.btcentralplus.com ([86.147.134.9]
 helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFwRI-0001qt-8t; Wed, 20 Dec 2023 13:16:48 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 20 Dec 2023 13:16:37 +0000
Message-Id: <20231220131641.592826-8-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231220131641.592826-1-mark.cave-ayland@ilande.co.uk>
References: <20231220131641.592826-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.147.134.9
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 07/11] next-cube.c: move static phase variable to NextRtc
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

The phase variable represents part of the state machine used to clock data out
of the NextRtc device.

Note that this is a migration break for the NeXTRtc struct, but as nothing will
currently boot then we simply bump the migration version for now.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index bcc7650cd9..f2222554fa 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -62,6 +62,7 @@ typedef struct next_dma {
 } next_dma;
 
 typedef struct NextRtc {
+    int8_t phase;
     uint8_t ram[32];
     uint8_t command;
     uint8_t value;
@@ -124,7 +125,6 @@ static const uint8_t rtc_ram2[32] = {
 
 static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
 {
-    static int phase;
     static uint8_t old_scr2;
     uint8_t scr2_2;
     NextRtc *rtc = &s->rtc;
@@ -145,25 +145,25 @@ static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
     }
 
     if (scr2_2 & 0x1) {
-        /* DPRINTF("RTC %x phase %i\n", scr2_2, phase); */
-        if (phase == -1) {
-            phase = 0;
+        /* DPRINTF("RTC %x phase %i\n", scr2_2, rtc->phase); */
+        if (rtc->phase == -1) {
+            rtc->phase = 0;
         }
         /* If we are in going down clock... do something */
         if (((old_scr2 & SCR2_RTCLK) != (scr2_2 & SCR2_RTCLK)) &&
                 ((scr2_2 & SCR2_RTCLK) == 0)) {
-            if (phase < 8) {
+            if (rtc->phase < 8) {
                 rtc->command = (rtc->command << 1) |
                                ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
             }
-            if (phase >= 8 && phase < 16) {
+            if (rtc->phase >= 8 && rtc->phase < 16) {
                 rtc->value = (rtc->value << 1) |
                              ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
 
                 /* if we read RAM register, output RT_DATA bit */
                 if (rtc->command <= 0x1F) {
                     scr2_2 = scr2_2 & (~SCR2_RTDATA);
-                    if (rtc->ram[rtc->command] & (0x80 >> (phase - 8))) {
+                    if (rtc->ram[rtc->command] & (0x80 >> (rtc->phase - 8))) {
                         scr2_2 |= SCR2_RTDATA;
                     }
 
@@ -174,7 +174,7 @@ static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
                 if (rtc->command == 0x30) {
                     scr2_2 = scr2_2 & (~SCR2_RTDATA);
                     /* for now status = 0x98 (new rtc + FTU) */
-                    if (rtc->status & (0x80 >> (phase - 8))) {
+                    if (rtc->status & (0x80 >> (rtc->phase - 8))) {
                         scr2_2 |= SCR2_RTDATA;
                     }
 
@@ -184,7 +184,7 @@ static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
                 /* read the status 0x31 */
                 if (rtc->command == 0x31) {
                     scr2_2 = scr2_2 & (~SCR2_RTDATA);
-                    if (rtc->control & (0x80 >> (phase - 8))) {
+                    if (rtc->control & (0x80 >> (rtc->phase - 8))) {
                         scr2_2 |= SCR2_RTDATA;
                     }
                     rtc->retval = (rtc->retval << 1) |
@@ -220,7 +220,7 @@ static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
 
                     }
 
-                    if (ret & (0x80 >> (phase - 8))) {
+                    if (ret & (0x80 >> (rtc->phase - 8))) {
                         scr2_2 |= SCR2_RTDATA;
                     }
                     rtc->retval = (rtc->retval << 1) |
@@ -229,8 +229,8 @@ static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
 
             }
 
-            phase++;
-            if (phase == 16) {
+            rtc->phase++;
+            if (rtc->phase == 16) {
                 if (rtc->command >= 0x80 && rtc->command <= 0x9F) {
                     rtc->ram[rtc->command - 0x80] = rtc->value;
                 }
@@ -246,7 +246,7 @@ static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
         }
     } else {
         /* else end or abort */
-        phase = -1;
+        rtc->phase = -1;
         rtc->command = 0;
         rtc->value = 0;
     }
@@ -911,9 +911,10 @@ static Property next_pc_properties[] = {
 
 static const VMStateDescription next_rtc_vmstate = {
     .name = "next-rtc",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (VMStateField[]) {
+        VMSTATE_INT8(phase, NextRtc),
         VMSTATE_UINT8_ARRAY(ram, NextRtc, 32),
         VMSTATE_UINT8(command, NextRtc),
         VMSTATE_UINT8(value, NextRtc),
-- 
2.39.2


