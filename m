Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C99A7BCC9E
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 08:25:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpND3-0008BE-HN; Sun, 08 Oct 2023 02:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpND0-0008AN-W9
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:24:11 -0400
Received: from mout.kundenserver.de ([212.227.126.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCz-0007qC-AD
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:24:10 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1M2ep5-1qsOHQ0msx-004BHv; Sun, 08
 Oct 2023 08:24:07 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 20/20] mac_via: extend timer calibration hack to work with A/UX
Date: Sun,  8 Oct 2023 08:23:49 +0200
Message-ID: <20231008062349.2733552-21-laurent@vivier.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231008062349.2733552-1-laurent@vivier.eu>
References: <20231008062349.2733552-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:muxX34OZPlG+tVM/KErZKWneQNQtd7qKzYRCqKlq+ZtowYKTrUz
 dv7BnJpnSZvnJocMVMLjK5fJQ40GsKQmyoXeM/hennNymblbO7kPjs6BQK8RsQNOmuVZy1n
 kfmUhdsgh2JE9iPnkQ8zzxReGCDsiJfNHr+0nY9iRHDaMp5Qxwk/Zux39Gn3HJoboKRtgyu
 YA9QXUyNQM7F/53fWELhg==
UI-OutboundReport: notjunk:1;M01:P0:5uwZ6rjD1r0=;Vxq0cRCaJFKq24MqyCO1RHFgs3U
 3kXbJ+slURz1pJEmw8XlfVx57j4/AEKF6SWmtRBF8mRVaIhCmwnRWkyCUXUbRxsoGZ8Q4fVHX
 3uqWOBgRm2NGJsNQ9aEwfA53LpKbuYEJUggI6JeBr0zB8/fyUDR78OkrcexYuaeC1IvPVuBJJ
 GxAWFRXI1RLCQkFL/z2CW1lyq/XODfuQ2fWZfWUohPOt9S9xR+rB0lLw/MJDAbsQesF/Md+s2
 vQRWryttvhCbCKBkSP1g8fgAxS5hWTuaaS2DETjO+8yrwW3Cy6F9zC0hYgem1lzRC0sYQQTu6
 g6dKMW6lAc83iiPrPQC+S+ZVvL97w/YI4inFZvByiRrPfoVrcWEvcQogqghBYGQzXJgQlV9p/
 xaT4sEUbllMiwup5g4vckK4u3lGzv518ufcMsYztxEEmVHAy7Bv5+hPrtkwwnYrMPA9DgsJa3
 pNRTrhqWxWxD92eOHjwdHHnZMQGxXAGd1xUEefiiABqpMHlknzhK2bh96uUC+AbcvJ1WdL5cJ
 vQxWWG4MuAZm9Cglnkq37qvss57V59tVmNj0HQPjtIOcArkDhyLO7Z702hNOLSMDbpLNMaiat
 9b/fwknrXapkEXWy3WDWAHWzv9MjWC2MmF7xDJ0ri+6lBFoSytZ0GCuUyinCqp9sI6yYWZdyy
 yns5eWUDYO7Mb6bj5fqUKPyCpxtL981TM84T+Ey2j1n7PMKvbpvdX24qZ2w/CGKbtg+8W+xm+
 LrYEiHKjRhx0FBIvnJb2DbZwBviG0MEBvazxXGCFmOvUBDhRuPGxoO5huyQUhSo7wMkVG66jR
 Zl5o8tE3e2FUxTP4X81O3fEufrAdAB5aWzNPcb+WQKf0mZ4uo0WCDKm0PRpkUbPgpaXhrSBTe
 emaFz2ZcDyRfZEg==
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.376, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The A/UX timer calibration loop runs continuously until 2 consecutive iterations
differ by at least 0x492 timer ticks. Modern hosts execute the timer calibration
loop so fast that this situation never occurs causing a hang on boot.

Use a similar method to Shoebill which is to randomly add 0x500 to the T2
counter value during calibration to enable it to eventually succeed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20231004083806.757242-21-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/misc/mac_via.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 500ece5872bd..b6206ef73ca7 100644
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
2.41.0


