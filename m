Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0ACF70FFC6
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 23:13:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1vnD-0006Fw-8Y; Wed, 24 May 2023 17:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vn9-0005vj-4u
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:13:07 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vn7-0002JR-AD
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U2U5OEm7QFAvoVpU8mTDsKr9yywgDGzYKhTMIGnYMbc=; b=DmIrvLiDSRLD2EFKib04b61NiK
 WqS7IiLkYXI5nBZixsfpT8OC5pXyzrKQ1YmPAEn1cx0p5A/r4gnLuQkng8XnpEs23X7oLaDK1RNuG
 7vtQ+/cj7dgs2ty0AzZkIKlLcd8OKgohsit2NZuVv4D05/F4XgmxcibJoimm6A76f1aeDsEEOsU/a
 lTNfb8CvAxgsGzx1l9o2ewP4Jk6lvTSWShNSAOUlBLXHU8q8dt67RXn/1Qz006UM2+cu6OIKqwwdu
 14jJezhpvdsdGGVPYnckIqI8jViCCHBfIRz4ADRaVeaDtjciUYhtn40v0zsVqyZKkxgGJQOrmnUpp
 9uXd52gH9ICGmApmYU4+5bYMcUSugbB+hWwXRIgPAPAa1ZO78EhG1UQ9i4qk0N4p2zNuBDgBHvmyi
 gnHuVMF0nCf6wIjRP5tuybThJV/rwndIbIjNUEBgPKFsuCSMlA4qCV8bHk0Pok5CtPUBKNQeM20xX
 04WEi9qb6rFcKPY0tkzA9BbUPegophkYjzjN81+CYjosBOfDBttccdeqh815NDryYQgkLSj63AO4R
 rR9oYYa9jxMbV+1eZiJDHP0S8CCkcYISn3A8FmOLbmqJEoLYWH/pVtVA7JFmYXRQle8sv0CUqGzjx
 QYTL2MKAaaTS8fyL68YmmsAq8agmQiFP4gvNyc7cI=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vmp-0005XR-KN; Wed, 24 May 2023 22:12:51 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 24 May 2023 22:11:03 +0100
Message-Id: <20230524211104.686087-30-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 29/30] mac_via: extend timer calibration hack to work with A/UX
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

The A/UX timer calibration loop runs continuously until 2 consecutive iterations
differ by at least 0x492 timer ticks. Modern hosts execute the timer calibration
loop so fast that this situation never occurs causing a hang on boot.

Use a similar method to Shoebill which is to randomly add 0x500 to the T2
counter value during calibration to enable it to eventually succeed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/mac_via.c | 55 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index ee44cb4437..4ec1ee18dd 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -973,6 +973,7 @@ static void via1_timer_calibration_hack(MOS6522Q800VIA1State *v1s, int addr,
             v1s->timer_hack_state = 4;
         }
         break;
+
     case 4:
         /*
          * This is the normal post-calibration timer state: we should
@@ -983,6 +984,38 @@ static void via1_timer_calibration_hack(MOS6522Q800VIA1State *v1s, int addr,
             /* Looks like there has been a reset? */
             v1s->timer_hack_state = 1;
         }
+
+        if (addr == VIA_REG_T2CL && val == 0xf0) {
+            /* VIA_REG_T2CH: high byte of counter (A/UX) */
+            v1s->timer_hack_state = 5;
+        }
+        break;
+    case 5:
+        if (addr == VIA_REG_T2CH && val == 0x3c) {
+            /* VIA_REG_T2CL: low byte of counter (A/UX) */
+            v1s->timer_hack_state = 6;
+        } else {
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
@@ -995,8 +1028,9 @@ static void via1_timer_calibration_hack(MOS6522Q800VIA1State *v1s, int addr,
 
 static uint64_t mos6522_q800_via1_read(void *opaque, hwaddr addr, unsigned size)
 {
-    MOS6522Q800VIA1State *s = MOS6522_Q800_VIA1(opaque);
-    MOS6522State *ms = MOS6522(s);
+    MOS6522Q800VIA1State *v1s = MOS6522_Q800_VIA1(opaque);
+    MOS6522State *ms = MOS6522(v1s);
+    int64_t now;
     uint64_t ret;
 
     addr = (addr >> 9) & 0xf;
@@ -1007,6 +1041,23 @@ static uint64_t mos6522_q800_via1_read(void *opaque, hwaddr addr, unsigned size)
         /* Quadra 800 Id */
         ret = (ret & ~VIA1A_CPUID_MASK) | VIA1A_CPUID_Q800;
         break;
+    case VIA_REG_T2CH:
+        if (v1s->timer_hack_state == 6) {
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
2.30.2


