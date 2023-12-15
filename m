Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C08815089
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 21:01:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEEMk-0005v3-Mu; Fri, 15 Dec 2023 15:00:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rEEMY-0005rX-NA
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 15:00:54 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rEEMT-0002Vr-5r
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 15:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A6zds8D80y24qI9OvDDHoMzVYeu3f74yQ3ZR2B9qF5g=; b=P6h3gpZVNqmyYjnEPNMoC8Jdsz
 EALzxFmcQF3twH+nmF1QalAXSA+6GQH2dEW0NolRtp7KFzZyLnZ97XlwNzTfDPoAGYBPRiG28MW2E
 39tSqtQMiUtFUZsAgVQuE+MTHcabegNCLhWwrvPDP2vCCYe89gMaeounPHe6yv//5oJ39IHn7DiZ8
 VcQoT4OHBpdGjYTWXbphzRnJbgZU7eEfELyzxi1dnWvgdo3KBIwqZl99lU00fVDmdrbGcGPsAk9Vl
 Xg/k3UX3/CjnX7gjYKG4R3AmR06hwh3FwdPG1b+q08XrbD2uAp8JGj99tkntvH4PtScZMlZPYxZ35
 4JBpIQuL17nVZVRdaStZwUXEqnXT/cCyBRgSXIUVsOPbOSrwwXRB+EqmvvDweGG8dRpBon7c0ap61
 bIJR4Pc7T5Al1+C2JB/KWYU6PZMtqi+08t+X1OwCeiaudWOGQWKCbtQCRSsSaewkW839nQMn8xW7r
 /fV6oGANXYRjSpQFjFeqwv5+p+0iVvF6C/t1Pce1DHZdD5X2DX0FJmv4qpWebC+y5Cev7C7YIEmVW
 TyPskYceuJziEO3UyFnzrsMDblNi4rQXLJ/jqNATtgguP3XVHNNUFMvOn6xNPW7sZuSTFZZdLrJ5s
 BfzDhca42wd4m4h+jK061wWSXN1JT50wb1ngcEEC0=;
Received: from [2a00:23c4:8bb0:f100:5e2c:460f:a6a7:b066]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rEEM0-000AEs-2N; Fri, 15 Dec 2023 20:00:16 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Fri, 15 Dec 2023 20:00:04 +0000
Message-Id: <20231215200009.346212-8-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231215200009.346212-1-mark.cave-ayland@ilande.co.uk>
References: <20231215200009.346212-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:f100:5e2c:460f:a6a7:b066
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 07/12] next-cube.c: move static phase variable to NextRtc
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


