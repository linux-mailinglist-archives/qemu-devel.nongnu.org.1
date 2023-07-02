Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E76744E71
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 17:51:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFzL4-0006dx-Mb; Sun, 02 Jul 2023 11:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qFzKy-0006OG-NO
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 11:50:08 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qFzKw-0007V1-6T
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 11:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UEHg4P0OOBpd0e1wB2PrNZv1ZDTepBghvW1RkyLjlZw=; b=yqoRBGinRBHUTXK/Tt597nxlG4
 BZiCAUT/lcRks50ugXaRLnxpXmOgvm4soNgF8YnbI75eyqHnbrvTUGnTDcQaBd4w8uIxZSeQ7dk6y
 h3w6uu9DVpWsaOJ7drf9XOmpuLmZ3x+dC0JhUEhQRGVqMbArrwGYLdkXqg94jUCkZKItkPCfxCnWo
 +Lpt0Owc6l1PVO/EkTki4f9Ugjuo1kJt2s/o1yG+8bLc2EKhBxyTlx88D1XRorcN7ckNfTViNOIT+
 kAuRmItmOwXfvz7gQpuHM1yb7//9vVYtzvkzQH/KQRs1W5fB5EfsIllFC0qgIjBQM07HoXW4efH6/
 9RR6bmfZhCKLSpeUEKyGuPMCWwy7swOw8zs8S/kKINiD1qH7NaGo4O8YxhdqHEhOcPxLQWSfrc9Z1
 +p9Kr9saTA6pzpPeuPMGqKkfaaS/q2zGLP6CfyOo+/3B+jyTQOpu608oNHXQ7mhmtA7PdId8MFQEr
 F4cXBJ+hu4Q5TEeRRNAmysO9hho01ESl5URG06V0QZp0vfEA1ObvaywXogrARP8RLzrXXqSr5BDnu
 UWKBQ6mKNAvWmeH9wfMWzrueQUFAc6J4ulFWRXZESHRjEdSq9LZjw6JmXRfisfGuawzHQg9/Y0WOq
 FD2KN5hPw5cjjHkl835UgY88zFw1DaBZkruwYkQLU=;
Received: from [2a00:23c4:8bad:df00:f732:dd76:7417:d15b] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qFzKa-0001Ji-L3; Sun, 02 Jul 2023 16:49:44 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sun,  2 Jul 2023 16:48:38 +0100
Message-Id: <20230702154838.722809-22-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
References: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bad:df00:f732:dd76:7417:d15b
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 21/21] mac_via: extend timer calibration hack to work with A/UX
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
 hw/misc/mac_via.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 94b4f5cebc..ea9d8b3aa9 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -983,6 +983,30 @@ static void via1_timer_calibration_hack(MOS6522Q800VIA1State *v1s, int addr,
             /* Looks like there has been a reset? */
             v1s->timer_hack_state = 1;
         }
+
+        if (addr == VIA_REG_T2CL && val == 0xf03c && size == 2) {
+            /* VIA_REG_T2CH: high byte of counter (A/UX) */
+            v1s->timer_hack_state = 5;
+        }
+        break;
+    case 5:
+        if ((addr == VIA_REG_IER && val == 0x20) || addr == VIA_REG_T2CH) {
+            /* End of A/UX timer calibration routine, or another write */
+            v1s->timer_hack_state = 6;
+        } else {
+            v1s->timer_hack_state = 0;
+        }
+        break;
+    case 6:
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
@@ -1013,6 +1037,23 @@ static uint64_t mos6522_q800_via1_read(void *opaque, hwaddr addr, unsigned size)
             /* Quadra 800 Id */
             ret = (ret & ~VIA1A_CPUID_MASK) | VIA1A_CPUID_Q800;
             break;
+        case VIA_REG_T2CH:
+            if (v1s->timer_hack_state == 5) {
+                /*
+                 * The A/UX timer calibration loop runs continuously until 2
+                 * consecutive iterations differ by at least 0x492 timer ticks.
+                 * Modern hosts execute the timer calibration loop so fast that
+                 * this situation never occurs causing a hang on boot. Use a
+                 * similar method to Shoebill which is to randomly add 0x500 to
+                 * the T2 counter value during calibration to enable it to
+                 * eventually succeed.
+                 */
+                now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+                if (now & 1) {
+                    ret += 0x5;
+                }
+            }
+            break;
         }
         val |= ret << ((size - i - 1) << 3);
     }
-- 
2.30.2


