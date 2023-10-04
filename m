Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A856E7B7A58
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:41:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxQG-0007pa-GP; Wed, 04 Oct 2023 04:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qnxQ2-0006v5-QP
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:39:51 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qnxPr-0007lU-Uf
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ceP4YhNUPMLYSAHn4R7ae6JZr9zikMQNDBraYKRwoQY=; b=gUm0mAkHdWdepsv3cjkHLE0Oao
 i4RXd24xE4YRo8g0gY7kff8/LpoyP1I3np1gGH0gVqWNbRwTNma/DRZezXHVuIMYJo4CL1eFRcYlb
 MScZnAtPPaeYRi5B1PlgEytP/I+3LmTDYZ2FY//2tFAijaYvE0nuZNApxX7ceLTbwV1NtUx1upcI5
 BYmphCdoYxupkBjGyPVP65LRBkIl3+FqcgNA/2Vu5fr6U12rqDIWShlzQD+woIOT0VAXmdUAwVVXW
 ibYSpwGSU8qUz+VyP8BOC2kRBiaNpYZayPTQZt4Tpc+2M+A+RuL51ek6opn+gl2vE81oQgAeahwiY
 Niez5p7Pa5HC34b3VT6u6Ri5nh2dCsYB1XGyQDyjSpjkPVtW+R8GvjlPSso0Hs1F7ESm3sWl+nlHZ
 o3/Q7t6k4Lk7VHQOw3vtKflSgzodr3DToBYpc2gf3cjupqFXtKabF8cF0wqq8AJXuZmObLzumAXks
 gT2QZWpPLNidiXrEUnkffX0l13yvUeHvaY5J3CdfILUwSnAJ3rW+CmqqyfNs+N8FkDocvSwxBmJoG
 xbLCC22WXu7a+Vfj56d8dz+cPGBc2XF0nN/DxSYSbcrYVQDrpXU7+mOmkA97QXsE2dIXc97N7BQ21
 4/PTAl8R2d1pycNyITG3hTqpnUYMq0PkUMNrhQOq0=;
Received: from host86-159-123-68.range86-159.btcentralplus.com
 ([86.159.123.68] helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qnxPW-0006za-S3; Wed, 04 Oct 2023 09:39:15 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed,  4 Oct 2023 09:38:06 +0100
Message-Id: <20231004083806.757242-21-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004083806.757242-1-mark.cave-ayland@ilande.co.uk>
References: <20231004083806.757242-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.159.123.68
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 20/20] mac_via: extend timer calibration hack to work with
 A/UX
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The A/UX timer calibration loop runs continuously until 2 consecutive iterations
differ by at least 0x492 timer ticks. Modern hosts execute the timer calibration
loop so fast that this situation never occurs causing a hang on boot.

Use a similar method to Shoebill which is to randomly add 0x500 to the T2
counter value during calibration to enable it to eventually succeed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/misc/mac_via.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 500ece5872..b6206ef73c 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -983,6 +983,44 @@ static void via1_timer_calibration_hack(MOS6522Q800VIA1State *v1s, int addr,
             /* Looks like there has been a reset? */
             v1s->timer_hack_state = 1;
         }
+
+        if (addr == VIA_REG_T2CL && val == 0xf0) {
+            /* VIA_REG_T2CL: low byte of counter (A/UX) */
+            v1s->timer_hack_state = 5;
+        }
+        break;
+    case 5:
+        if (addr == VIA_REG_T2CH && val == 0x3c) {
+            /*
+             * VIA_REG_T2CH: high byte of counter (A/UX). We are now extremely
+             * likely to be in the A/UX timer calibration routine, so move to
+             * the next state where we enable the calibration hack.
+             */
+            v1s->timer_hack_state = 6;
+        } else if ((addr == VIA_REG_IER && val == 0x20) ||
+                   addr == VIA_REG_T2CH) {
+            /* We're doing something else with the timer, not calibration */
+            v1s->timer_hack_state = 0;
+        }
+        break;
+    case 6:
+        if ((addr == VIA_REG_IER && val == 0x20) || addr == VIA_REG_T2CH) {
+            /* End of A/UX timer calibration routine, or another write */
+            v1s->timer_hack_state = 7;
+        } else {
+            v1s->timer_hack_state = 0;
+        }
+        break;
+    case 7:
+        /*
+         * This is the normal post-calibration timer state once both the
+         * MacOS toolbox and A/UX have been calibrated, until we see a write
+         * to VIA_REG_PCR to suggest a reset
+         */
+        if (addr == VIA_REG_PCR && val == 0x22) {
+            /* Looks like there has been a reset? */
+            v1s->timer_hack_state = 1;
+        }
         break;
     default:
         g_assert_not_reached();
@@ -998,6 +1036,7 @@ static uint64_t mos6522_q800_via1_read(void *opaque, hwaddr addr, unsigned size)
     MOS6522Q800VIA1State *s = MOS6522_Q800_VIA1(opaque);
     MOS6522State *ms = MOS6522(s);
     uint64_t ret;
+    int64_t now;
 
     addr = (addr >> 9) & 0xf;
     ret = mos6522_read(ms, addr, size);
@@ -1007,6 +1046,23 @@ static uint64_t mos6522_q800_via1_read(void *opaque, hwaddr addr, unsigned size)
         /* Quadra 800 Id */
         ret = (ret & ~VIA1A_CPUID_MASK) | VIA1A_CPUID_Q800;
         break;
+    case VIA_REG_T2CH:
+        if (s->timer_hack_state == 6) {
+            /*
+             * The A/UX timer calibration loop runs continuously until 2
+             * consecutive iterations differ by at least 0x492 timer ticks.
+             * Modern hosts execute the timer calibration loop so fast that
+             * this situation never occurs causing a hang on boot. Use a
+             * similar method to Shoebill which is to randomly add 0x500 to
+             * the T2 counter value during calibration to enable it to
+             * eventually succeed.
+             */
+            now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+            if (now & 1) {
+                ret += 0x5;
+            }
+        }
+        break;
     }
     return ret;
 }
-- 
2.39.2


