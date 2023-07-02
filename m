Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C21744E69
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 17:50:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFzKm-00057w-5T; Sun, 02 Jul 2023 11:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qFzKk-00054l-8b
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 11:49:54 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qFzKi-0007Tv-Ms
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 11:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z1ZAtYQYjdnyPY0aObLj8vzSpFTVdd2bEBkqMAC+vFU=; b=v+g042FivUPOS6Z0YZ4uX3TDSt
 bZ7V8mXtA6qjQQaKnELCE8LqkhK88ZiaaaLEy01hCo2zsbR0lMA2HKA+O1jhYKCgXWAYSFcu++Rwj
 QF5OPeH4Yoi0brVe2YKA7UFWKu6cb0GcVILtvX7iA+tcW116xN7UvlAMiWMzGggzumh2VZl7omp1B
 75LZpStWhQH4YMP8L8iUABxUZbXeCNHjSDaKvjyi2vgocPSwc5W3S6uYRtRBZFO1MoVRumw6kLqQa
 /cI/j3re2vxdHAqj2FKFCqmBGrAMKPXUEl8f57MaQ6gVDEOKzbhFkH8bslt01PFPz8fNSP4sB2LCa
 hAZhcSy+Wm/i0Ky2F+IXy5Rh535GVxd2WGxlVwVQ64MRZ1nAITjTKonasyZRf1md0kaO8d2lm5uKf
 Xw1f+Nv8nMfNyXMbdJjZPgQ+GET5hCbJObU0pXyp1oi095o2b3DY8tMY0cEtblD3np5iWPURBvG7k
 DroBsW49X5V+x/jWf6FkkD3mY8mgaMIwIZynHZ9pvDjJDUorcqjbaDHJbh9skd5kzzSU5MKw15HO1
 Q0rqCZXbtWns1Q6scee+f/iny4b4QuWO3tn2EDde1J5ltB525rwx193VzQQ/kTKS2LOgsPJGWXQ0z
 AnkPhsqxxStYmGe0WxZdH2qMCAeQ25sNMnI/cfJFs=;
Received: from [2a00:23c4:8bad:df00:f732:dd76:7417:d15b] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qFzKJ-0001Ji-AD; Sun, 02 Jul 2023 16:49:31 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sun,  2 Jul 2023 16:48:32 +0100
Message-Id: <20230702154838.722809-16-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
References: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bad:df00:f732:dd76:7417:d15b
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 15/21] mac_via: workaround NetBSD ADB bus enumeration issue
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

NetBSD assumes it can send its first ADB command after sending the ADB_BUSRESET
command in ADB_STATE_NEW without changing the state back to ADB_STATE_IDLE
first as detailed in the ADB protocol.

Add a workaround to detect this condition at the start of ADB enumeration
and send the next command written to SR after a ADB_BUSRESET onto the bus
regardless, even if we don't detect a state transition to ADB_STATE_NEW.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/mac_via.c    | 34 ++++++++++++++++++++++++++++++++++
 hw/misc/trace-events |  1 +
 2 files changed, 35 insertions(+)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 766a32a95d..208216aed3 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -1001,6 +1001,8 @@ static void mos6522_q800_via1_write(void *opaque, hwaddr addr, uint64_t val,
 {
     MOS6522Q800VIA1State *v1s = MOS6522_Q800_VIA1(opaque);
     MOS6522State *ms = MOS6522(v1s);
+    int oldstate, state;
+    int oldsr = ms->sr;
 
     addr = (addr >> 9) & 0xf;
 
@@ -1016,6 +1018,38 @@ static void mos6522_q800_via1_write(void *opaque, hwaddr addr, uint64_t val,
 
         v1s->last_b = ms->b;
         break;
+
+    case VIA_REG_SR:
+        {
+            /*
+             * NetBSD assumes it can send its first ADB command after sending
+             * the ADB_BUSRESET command in ADB_STATE_NEW without changing the
+             * state back to ADB_STATE_IDLE first as detailed in the ADB
+             * protocol.
+             *
+             * Add a workaround to detect this condition at the start of ADB
+             * enumeration and send the next command written to SR after a
+             * ADB_BUSRESET onto the bus regardless, even if we don't detect a
+             * state transition to ADB_STATE_NEW.
+             *
+             * Note that in my tests the NetBSD state machine takes one ADB
+             * operation to recover which means the probe for an ADB device at
+             * address 1 always fails. However since the first device is at
+             * address 2 then this will work fine, without having to come up
+             * with a more complicated and invasive solution.
+             */
+            oldstate = (v1s->last_b & VIA1B_vADB_StateMask) >>
+                       VIA1B_vADB_StateShift;
+            state = (ms->b & VIA1B_vADB_StateMask) >> VIA1B_vADB_StateShift;
+
+            if (oldstate == ADB_STATE_NEW && state == ADB_STATE_NEW &&
+                    (ms->acr & VIA1ACR_vShiftOut) &&
+                    oldsr == 0 /* ADB_BUSRESET */) {
+                trace_via1_adb_netbsd_enum_hack();
+                adb_via_send(v1s, state, ms->sr);
+            }
+        }
+        break;
     }
 }
 
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index c717090659..3d14e1db09 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -267,6 +267,7 @@ via1_rtc_cmd_pram_sect_write(int sector, int offset, int addr, int value) "secto
 via1_adb_send(const char *state, uint8_t data, const char *vadbint) "state %s data=0x%02x vADBInt=%s"
 via1_adb_receive(const char *state, uint8_t data, const char *vadbint, int status, int index, int size) "state %s data=0x%02x vADBInt=%s status=0x%x index=%d size=%d"
 via1_adb_poll(uint8_t data, const char *vadbint, int status, int index, int size) "data=0x%02x vADBInt=%s status=0x%x index=%d size=%d"
+via1_adb_netbsd_enum_hack(void) "using NetBSD enum hack"
 via1_auxmode(int mode) "setting auxmode to %d"
 via1_timer_hack_state(int state) "setting timer_hack_state to %d"
 
-- 
2.30.2


