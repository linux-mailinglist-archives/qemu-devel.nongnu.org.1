Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A149AC2E3
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Oct 2024 11:06:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3XEX-0002nr-Nk; Wed, 23 Oct 2024 05:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XER-0002Oa-If
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 05:00:43 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XEK-0000cM-AY
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 05:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=nUcp+w8Fh2G1W3jfhfSio7O1n3oHdDz2TKbys7bs9Nc=; b=z+8d/yBahWykfPKg2Ot4cnVugf
 rvkaNgpreQRjJquAsQhs296X/hNajYOfGEcbLE/MdBURnec/2SHNy9bBe80MyFSD2dvvcSlGdBlKe
 JpAiIbQwhklGVKAoWi5nAtPLlQQNDSKpy0+V85XLWat+kLp4UrlQSQdQ1YzMH0plT4NF8LfBWgAxy
 Dei79WkHD9PdKPJjXK44+wUWD6qIX1h56d9/ceNXft50IHwKF8kpOfL+Jt3PthHJv7DGsZwxAw2yC
 86uR6Fp7Yjlw8703HtNvmfHYIHFBoXVyAgFG64E4qkqfTin/0ptjpQXlC0unooW5g54RHVUcgNdoM
 0eS/QggbkFVd/FVodqhb3OSgiX3gSH+Jc9AnhTb/j3TVtlwvD/7XHE2uaIFfA0HnrZrwe9H0DxVbF
 VOaKJnXipi6UrYVZUWnfvB3yr1HxEPZUEqxTR0fu+dQQ0sTOmOeWyIhRTLmhJiVhGO1ORp9NteJPR
 IegPA5bMV/Tem6nhPBVPiB6WMcdTgulUUyUxK5UQ+c+5IsBqFOClcKFhx0iFuDSkkoj5OCPCs/4N9
 v3qzY2E9asPA4Vy00QQYW/NeOchUy69/eRe4gTHc2nKvVoLphJ7aN76yh0VZojy0kECMd3GIELlyx
 lzJcRtVeN9hHrJsxcYho9Y4R4fq9N3oqrQmAgKt7Q=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XDp-0008EL-Uv; Wed, 23 Oct 2024 10:00:10 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 23 Oct 2024 09:58:39 +0100
Message-Id: <20241023085852.1061031-24-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 23/36] next-cube: always use retval to return rtc read values
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Instead of shifting out rtc read values from individual rtc registers, change
the logic so that rtc read commands are executed when the last bit of the rtc
command is received and the result stored in retval. This simplifies the rtc
read logic such that the shift out logic can be consolidated for rtc phases
between 8 and 16.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/next-cube.c | 99 ++++++++++++++++++---------------------------
 1 file changed, 40 insertions(+), 59 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 4aed80c9fe..bca975065f 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -190,93 +190,74 @@ static void next_scr2_rtc_update(NeXTPC *s)
             if (rtc->phase < 8) {
                 rtc->command = (rtc->command << 1) |
                                ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
-            }
-            if (rtc->phase >= 8 && rtc->phase < 16) {
-                if (next_rtc_cmd_is_write(rtc->command)) {
-                    /* Shift in value to write */
-                    rtc->value = (rtc->value << 1) |
-                                 ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
-                } else {
-                    /* Shift out value to read */
 
-                    /* if we read RAM register, output RT_DATA bit */
-                    if (rtc->command <= 0x1F) {
-                        scr2_2 = scr2_2 & (~SCR2_RTDATA);
-                        if (rtc->ram[rtc->command] &
-                            (0x80 >> (rtc->phase - 8))) {
-                                scr2_2 |= SCR2_RTDATA;
-                        }
-
-                        rtc->retval = (rtc->retval << 1) |
-                                      ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
-                    }
-                    /* read the status 0x30 */
-                    if (rtc->command == 0x30) {
-                        scr2_2 = scr2_2 & (~SCR2_RTDATA);
-                        /* for now status = 0x98 (new rtc + FTU) */
-                        if (rtc->status & (0x80 >> (rtc->phase - 8))) {
-                            scr2_2 |= SCR2_RTDATA;
-                        }
-
-                        rtc->retval = (rtc->retval << 1) |
-                                      ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
-                    }
-                    /* read the status 0x31 */
-                    if (rtc->command == 0x31) {
-                        scr2_2 = scr2_2 & (~SCR2_RTDATA);
-                        if (rtc->control & (0x80 >> (rtc->phase - 8))) {
-                            scr2_2 |= SCR2_RTDATA;
-                        }
-                        rtc->retval = (rtc->retval << 1) |
-                                      ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
+                if (rtc->phase == 7 && !next_rtc_cmd_is_write(rtc->command)) {
+                    if (rtc->command <= 0x1f) {
+                        /* RAM registers */
+                        rtc->retval = rtc->ram[rtc->command];
                     }
-
                     if ((rtc->command >= 0x20) && (rtc->command <= 0x2F)) {
-                        scr2_2 = scr2_2 & (~SCR2_RTDATA);
-                        /* for now 0x00 */
+                        /* RTC */
                         time_t time_h = time(NULL);
                         struct tm *info = localtime(&time_h);
-                        int ret = 0;
+                        rtc->retval = 0;
 
                         switch (rtc->command) {
                         case 0x20:
-                            ret = SCR2_TOBCD(info->tm_sec);
+                            rtc->retval = SCR2_TOBCD(info->tm_sec);
                             break;
                         case 0x21:
-                            ret = SCR2_TOBCD(info->tm_min);
+                            rtc->retval = SCR2_TOBCD(info->tm_min);
                             break;
                         case 0x22:
-                            ret = SCR2_TOBCD(info->tm_hour);
+                            rtc->retval = SCR2_TOBCD(info->tm_hour);
                             break;
                         case 0x24:
-                            ret = SCR2_TOBCD(info->tm_mday);
+                            rtc->retval = SCR2_TOBCD(info->tm_mday);
                             break;
                         case 0x25:
-                            ret = SCR2_TOBCD((info->tm_mon + 1));
+                            rtc->retval = SCR2_TOBCD((info->tm_mon + 1));
                             break;
                         case 0x26:
-                            ret = SCR2_TOBCD((info->tm_year - 100));
+                            rtc->retval = SCR2_TOBCD((info->tm_year - 100));
                             break;
                         }
-
-                        if (ret & (0x80 >> (rtc->phase - 8))) {
-                            scr2_2 |= SCR2_RTDATA;
-                        }
-                        rtc->retval = (rtc->retval << 1) |
-                                      ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
+                    }
+                    if (rtc->command == 0x30) {
+                        /* read the status 0x30 */
+                        rtc->retval = rtc->status;
+                    }
+                    if (rtc->command == 0x31) {
+                        /* read the control 0x31 */
+                        rtc->retval = rtc->control;
+                    }
+                }
+            }
+            if (rtc->phase >= 8 && rtc->phase < 16) {
+                if (next_rtc_cmd_is_write(rtc->command)) {
+                    /* Shift in value to write */
+                    rtc->value = (rtc->value << 1) |
+                                 ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
+                } else {
+                    /* Shift out value to read */
+                    if (rtc->retval & (0x80 >> (rtc->phase - 8))) {
+                        scr2_2 |= SCR2_RTDATA;
+                    } else {
+                        scr2_2 &= ~SCR2_RTDATA;
                     }
                 }
             }
 
             rtc->phase++;
-            if (rtc->phase == 16) {
-                if (rtc->command >= 0x80 && rtc->command <= 0x9F) {
+            if (rtc->phase == 16 && next_rtc_cmd_is_write(rtc->command)) {
+                if (rtc->command >= 0x80 && rtc->command <= 0x9f) {
+                    /* RAM registers */
                     rtc->ram[rtc->command - 0x80] = rtc->value;
                 }
-                /* write to x30 register */
-                if (rtc->command == 0xB1) {
-                    /* clear FTU */
+                if (rtc->command == 0xb1) {
+                    /* write to 0x30 register */
                     if (rtc->value & 0x04) {
+                        /* clear FTU */
                         rtc->status = rtc->status & (~0x18);
                         qemu_irq_lower(s->rtc_power_irq);
                     }
-- 
2.39.5


