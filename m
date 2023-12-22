Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E274F81CAE2
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 14:47:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGfr6-0000GI-Aj; Fri, 22 Dec 2023 08:46:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rGfqh-0007Yk-CY
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 08:46:02 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rGfqe-0004Jv-VI
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 08:45:59 -0500
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-40d22d3e751so17786195e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 05:45:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703252754; x=1703857554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wQJrG9MCP1pvE0dTgfxXFOWCPsZWoGZxG155b2taHug=;
 b=Gi4k1d9i5bVXOQNVG4jDDzLiamth+kyG2XVNYuwrSjK/1tL4KpqL+eDW6JCMYiwgxX
 uMS1jGZA0Y6ribpqgdSqqQGOuFa+F7aBgFk4OqotQ1F6Si/Goe8pxhLQCJrFHe8OIlSj
 dvl12eROm4ffGchO4Cadc9Oa2SADoxAqIYhRLeS6MIUsXlQpn+o0+QhM8aXQ8qsMsK9D
 A8ggGlCSQknHdTH7IIcjUrtGd65DNSRhxMEHOcB+NJVCsiyA7t+oYFlBUJdr1N/9tUOt
 pMXNwFyGml3ThDObqYtTnwJW+UwKycqrpdYedfyupY/a8bc4fGLtcJL/tRQ0AaUS6Q0p
 8jzQ==
X-Gm-Message-State: AOJu0Yy6oBBiNET/qpqLRlo/X8kqFhFubsIFlOQh+h4IMN4O+XGqX1sS
 LXR6Bz/OicH2kD6CDEqnZOgTGgJBObE=
X-Google-Smtp-Source: AGHT+IFVIhx2Zvx5iJbWjFRqkt3hKdfOMECA7Itk0AH/FjKcXhOR6xa2yzB1NFlGp39VR2wxc+QIgg==
X-Received: by 2002:a05:600c:4e54:b0:40d:43e4:5315 with SMTP id
 e20-20020a05600c4e5400b0040d43e45315mr866995wmq.49.1703252754499; 
 Fri, 22 Dec 2023 05:45:54 -0800 (PST)
Received: from fedora.. (ip-109-43-177-45.web.vodafone.de. [109.43.177.45])
 by smtp.gmail.com with ESMTPSA id
 j16-20020a05600c191000b0040c11fbe581sm7047333wmq.27.2023.12.22.05.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 05:45:53 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 07/11] next-cube.c: move static phase variable to NextRtc
Date: Fri, 22 Dec 2023 14:45:23 +0100
Message-ID: <20231222134527.15705-8-huth@tuxfamily.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222134527.15705-1-huth@tuxfamily.org>
References: <20231222134527.15705-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.128.51; envelope-from=th.huth@gmail.com;
 helo=mail-wm1-f51.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The phase variable represents part of the state machine used to clock data out
of the NextRtc device.

Note that this is a migration break for the NeXTRtc struct, but as nothing will
currently boot then we simply bump the migration version for now.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20231220131641.592826-8-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
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
2.43.0


