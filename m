Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A11AA7BCCA8
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 08:27:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpNCx-00088A-FC; Sun, 08 Oct 2023 02:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCv-00087U-Cs
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:24:05 -0400
Received: from mout.kundenserver.de ([212.227.17.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCt-0007ne-Ll
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:24:05 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MVMJ7-1qyxsc40hT-00SMzH; Sun, 08
 Oct 2023 08:24:02 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 15/20] mac_via: workaround NetBSD ADB bus enumeration issue
Date: Sun,  8 Oct 2023 08:23:44 +0200
Message-ID: <20231008062349.2733552-16-laurent@vivier.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231008062349.2733552-1-laurent@vivier.eu>
References: <20231008062349.2733552-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:v4IxPU9uPZV6gC7Dl+yog1tVLzzvEkppU8r3gOYvwuEEqDO6rL0
 WOfOInyYIvC6b4B1m2TjLrVQF7vy5DFjdxF5rUpsgPGR7x4bZnqBClD5U8dTjrmjq1FX5Pc
 kFP7f1ESKQAN9Ee78+NzttCiszGTPkBrlY8bu8PFImCa8w139LbB9/8/YQYWPonNMX4wEfg
 bR2E2RD8NcBNJaZwg9aSQ==
UI-OutboundReport: notjunk:1;M01:P0:Vyfj6YTztmw=;VTZHvP2kyY2pQL2yO4fStZrWg1j
 u79AylKF6LpmdxX51Z2OgldxaA+HyvLSSUAF8mdAkP5uDKOpE3jGptUzqP0RJZkjnZ50nLmO7
 w8JGWBloGLMkU1QRziRRoXD6zfmS9UfuvMesfFk2c4UtTYxr3Er8NfIS1PznEwUyRFJ8Itt9i
 e2QHXfom9LsNLzpN/6jOVSEnpQ0yTD2Rr15sNQ6c26zn9oo3yTKCFRnr1DxpWMr/c68YtLZsx
 88UxOdTOjUaCTlcfvx3LIWHqSS4Lu4XQktezmVWmTABPKjEinxahiYpU84o3ER35VINKniX0L
 Ry9VrnEUGB6M5hHHkdzhUUGVedZakzuE5kycrmY5K0cJRomTDY5npuN1B4oFcxVuHE1ULVnFH
 Q8qMr4jCsAW2eExdZKUMZOuXKaBy4TrU3i+/w0AAa0QXBUwC1NpGscKHzYCNf8I9fTKgvFzoe
 /lNahyyuWiD/0nmTVqva1+e0u4A4NnQjG5xc7YHdFk+wwGUeMzs5KbzPcSkHZyksCEZQ24TQo
 NJDU+z4c2hDN7i9Y2B988iIvo+mqzRKSEnA6M81jTNI6Ylga8diFgN/LrJwRtBTx+tBFOuQvl
 +4iieDreDHfrYtiNttf3NGWWsZ49eg+v38wohhrp8Hxnu1ayjQB8Dv5X1cFsAbAdrhSBIRTG4
 kgijQh4wmBaGXO6qI1by/oJwCmgqDq+N5iEbMZNq/+YS+e+MrH8mB8X7DHfi1bY2UL09723dY
 9vYOHLELNIHaNA30HMh9naD5YBz3KjeV3YeobxxNN3TGTVFD20fHFC+WZwpCssMa5xUvL3ZaX
 iE1LDeO9BHEFEul8H++A0o9q5tpY/0VK0inf/9yI690YfpsW3cpOXhwpEOknFso4h+3u8DuR0
 jN0mlB0eIXyA3dA==
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
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

NetBSD assumes it can send its first ADB command after sending the ADB_BUSRESET
command in ADB_STATE_NEW without changing the state back to ADB_STATE_IDLE
first as detailed in the ADB protocol.

Add a workaround to detect this condition at the start of ADB enumeration
and send the next command written to SR after a ADB_BUSRESET onto the bus
regardless, even if we don't detect a state transition to ADB_STATE_NEW.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20231004083806.757242-16-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/misc/mac_via.c    | 34 ++++++++++++++++++++++++++++++++++
 hw/misc/trace-events |  1 +
 2 files changed, 35 insertions(+)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index f2ccb12d643b..9f9c2815d0e9 100644
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
index 5a998f5e4e38..24ba7cc4d0e9 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -271,6 +271,7 @@ via1_rtc_cmd_pram_sect_write(int sector, int offset, int addr, int value) "secto
 via1_adb_send(const char *state, uint8_t data, const char *vadbint) "state %s data=0x%02x vADBInt=%s"
 via1_adb_receive(const char *state, uint8_t data, const char *vadbint, int status, int index, int size) "state %s data=0x%02x vADBInt=%s status=0x%x index=%d size=%d"
 via1_adb_poll(uint8_t data, const char *vadbint, int status, int index, int size) "data=0x%02x vADBInt=%s status=0x%x index=%d size=%d"
+via1_adb_netbsd_enum_hack(void) "using NetBSD enum hack"
 via1_auxmode(int mode) "setting auxmode to %d"
 via1_timer_hack_state(int state) "setting timer_hack_state to %d"
 
-- 
2.41.0


