Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1150E7B3994
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 20:03:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmHo4-0005v4-1b; Fri, 29 Sep 2023 14:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qmHne-0005Xb-2Y
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 14:01:16 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qmHnP-0005pG-7m
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 14:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ceP4YhNUPMLYSAHn4R7ae6JZr9zikMQNDBraYKRwoQY=; b=fn/VVwnD8Nl8qkYocEc/z9X0st
 I42biNzQKS3/zJKgnGO0sR4K02EnCdd3ZAGPy+FjiknSMNrH4uwLOUezS+qj6asOlJpk07A5cYKuK
 WM3HnwPWOipdMPHoTx5qp3RrDWhDU64BqCj2KSm/tajVZGlKsgg3A11hSNJGAYyRwbkNqbzkXyaC4
 xBJHLhDhyD6yzVsS3B3sLQK96wKAvWiw2yJHnxORT0VAhdeAVuUY+nDwImo1oEi4GmSbkUfmbSL05
 O0vz5eS12C+wPhc4U1xV1qA/m4mLKC++3n/BccxtDanNjTNtdw8+juIiw8wcS2Jh/qMA0M2RA/2IK
 lYTVp/2RYBb8lRnQAnDJDEFmrlokwz0svIfoamDGySv5EOdgFafA8Ebg2p+1BJTObhiZwmf34SOLK
 fJvEUt+diY5FxeoNYyOPhkkYWX/osMKsenEds8rxLxPlxWj8w4k2vTcoIBb8iQfGrN1dFcrsd6CH4
 vEVxBHuCVkkSfcIyExTpWj/O0qGvCW+CTGcaK/mlRdF8LKF5yCFrZhVa1BmU+QusJp2OClp7JnapC
 N3b/8oKZNibg0kjMdcz30rg3zzuehwqRm7d3Zor0mRBKg0jt8lYexQPy3Ka30F8IeSiBHtrOLzd0x
 1wEUs7uXLJy76PADztF1PpsFOmx/sKFjauZR8jjdc=;
Received: from [2a00:23c4:8baf:5f00:c237:5189:8121:f752]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qmHn1-00033Y-Jk; Fri, 29 Sep 2023 19:00:39 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Fri, 29 Sep 2023 18:59:17 +0100
Message-Id: <20230929175917.511133-21-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230929175917.511133-1-mark.cave-ayland@ilande.co.uk>
References: <20230929175917.511133-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:5f00:c237:5189:8121:f752
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 20/20] mac_via: extend timer calibration hack to work with
 A/UX
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


