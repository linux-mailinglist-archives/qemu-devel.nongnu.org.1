Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EACF8744E75
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 17:51:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFzL2-0006WW-7w; Sun, 02 Jul 2023 11:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qFzKy-0006OA-NF
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 11:50:08 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qFzKv-0007Ux-TH
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 11:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8d1kD424yCwgXkQ27ySzpfjrDG0peFKyKvz1UrENdxo=; b=L4AQ9q/i4BmaeuZp5I8pi/OFz7
 mTDpz+rhzScTzwiZf1fHlN7BpRfpid+mkqgLseLIMwUjaL1RtGcXDrbXwNA5xr3UwsRpWXclHjyf1
 uZA1IGNxmxa9RwJqxKk9+lnaRQu0W8ABx716sbN/8lRDz0uOdGIaTSyz1Jp5RAXuHIAZwKEA9hi7t
 syGDMisVttBKbf+tHAhKNtg+uBtVuftampU7hAu6YBLOzr5l4UnBfxR2p9fOIdlPRMHb+LsoQT1as
 sa7090qoffefqaDdhkT/jTKRp6cbg+d9c8dBgTz/TBZ454Pzu9oi05eN4DT3OWHQtYeSkbjoU7Gnf
 MCX+xD9KyoF7isz/hTRaN6SUcekwF6VdJta39ijhhDByeDgcqpyr9xQbcmBdfcqM8/0P8InvWeVYV
 ePMW2BgVfCbmbarrQrSBkOANdSjJXLIwx0vc3+asAetMD3GFlUImdjCvvygKS6lE1QeQsrdZjLxYD
 8qJt5KzbMawworDZVT1jzG4rEP+qjTRnu+gMtH2AjanpgEAv3nwRhlP+G9djR9bowDeVz9N1LkI6G
 3C3eLQa4nWgaw3f92UiSck5/P3WQXeFUo4Xs8raWonSatyHXrEvLn5Uof1TqXV2j9DkeSVybmoqgN
 6ROXZ5O2RtKYeUFuBVCWEDBlokwNkm5iILlJGtPXg=;
Received: from [2a00:23c4:8bad:df00:f732:dd76:7417:d15b] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qFzKa-0001Ji-6D; Sun, 02 Jul 2023 16:49:44 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sun,  2 Jul 2023 16:48:37 +0100
Message-Id: <20230702154838.722809-21-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
References: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bad:df00:f732:dd76:7417:d15b
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 20/21] mac_via: allow unaligned access to VIA1 registers
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

During the kernel timer calibration routine A/UX performs an unaligned access
across the T2CL and T2CH registers to read the entire 16-bit value in a
single memory access.

Allow unaligned accesses to the VIA1 memory region such that the unaligned
address and size are available within the MemoryRegionOps read and write
functions. This gives two advantages: i) the unaligned accesses can be
logged and ii) the original access information can be used subsequently to
detect when the A/UX timer calibration is being executed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/q800.c       |   2 +
 hw/misc/mac_via.c    | 127 ++++++++++++++++++++++++++-----------------
 hw/misc/trace-events |   2 +
 3 files changed, 80 insertions(+), 51 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 87665c6407..eb2f11234a 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -198,6 +198,8 @@ static const MemoryRegionOps macio_alias_ops = {
     .valid = {
         .min_access_size = 1,
         .max_access_size = 4,
+        /* VIA1 unaligned access for A/UX timer calibration */
+        .unaligned = true,
     },
 };
 
diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 5d1adf5863..94b4f5cebc 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -995,20 +995,33 @@ static void via1_timer_calibration_hack(MOS6522Q800VIA1State *v1s, int addr,
 
 static uint64_t mos6522_q800_via1_read(void *opaque, hwaddr addr, unsigned size)
 {
-    MOS6522Q800VIA1State *s = MOS6522_Q800_VIA1(opaque);
-    MOS6522State *ms = MOS6522(s);
-    uint64_t ret;
+    MOS6522Q800VIA1State *v1s = MOS6522_Q800_VIA1(opaque);
+    MOS6522State *ms = MOS6522(v1s);
+    int64_t now;
+    uint8_t ret;
+    uint64_t val = 0;
+    int i;
+    hwaddr addr1;
+
+    /* Handle unaligned read used by A/UX timer calibration code */
+    addr1 = (addr >> 9) & 0xf;
+    for (i = 0; i < size; i++, addr1++) {
+        ret = mos6522_read(ms, addr1, size);
+        switch (addr1) {
+        case VIA_REG_A:
+        case VIA_REG_ANH:
+            /* Quadra 800 Id */
+            ret = (ret & ~VIA1A_CPUID_MASK) | VIA1A_CPUID_Q800;
+            break;
+        }
+        val |= ret << ((size - i - 1) << 3);
+    }
 
-    addr = (addr >> 9) & 0xf;
-    ret = mos6522_read(ms, addr, size);
-    switch (addr) {
-    case VIA_REG_A:
-    case VIA_REG_ANH:
-        /* Quadra 800 Id */
-        ret = (ret & ~VIA1A_CPUID_MASK) | VIA1A_CPUID_Q800;
-        break;
+    if ((addr >> 9) != ((addr + size) >> 9)) {
+        trace_via1_unaligned_read(addr, val, size);
     }
-    return ret;
+
+    return val;
 }
 
 static void mos6522_q800_via1_write(void *opaque, hwaddr addr, uint64_t val,
@@ -1018,53 +1031,63 @@ static void mos6522_q800_via1_write(void *opaque, hwaddr addr, uint64_t val,
     MOS6522State *ms = MOS6522(v1s);
     int oldstate, state;
     int oldsr = ms->sr;
+    hwaddr addr1;
+    uint8_t v;
+    int i;
 
-    addr = (addr >> 9) & 0xf;
+    if ((addr >> 9) != ((addr + size) >> 9)) {
+        trace_via1_unaligned_write(addr, val, size);
+    }
 
-    via1_timer_calibration_hack(v1s, addr, val, size);
+    addr1 = (addr >> 9) & 0xf;
+    via1_timer_calibration_hack(v1s, addr1, val, size);
 
-    mos6522_write(ms, addr, val, size);
+    /* Handle unaligned write used by A/UX timer calibration code */
+    for (i = 0; i < size; i++, addr1++) {
+        v = val >> ((size - i - 1) << 3);
+        mos6522_write(ms, addr1, v, size);
 
-    switch (addr) {
-    case VIA_REG_B:
-        via1_rtc_update(v1s);
-        via1_adb_update(v1s);
-        via1_auxmode_update(v1s);
+        switch (addr1) {
+        case VIA_REG_B:
+            via1_rtc_update(v1s);
+            via1_adb_update(v1s);
+            via1_auxmode_update(v1s);
 
-        v1s->last_b = ms->b;
-        break;
+            v1s->last_b = ms->b;
+            break;
 
-    case VIA_REG_SR:
-        {
-            /*
-             * NetBSD assumes it can send its first ADB command after sending
-             * the ADB_BUSRESET command in ADB_STATE_NEW without changing the
-             * state back to ADB_STATE_IDLE first as detailed in the ADB
-             * protocol.
-             *
-             * Add a workaround to detect this condition at the start of ADB
-             * enumeration and send the next command written to SR after a
-             * ADB_BUSRESET onto the bus regardless, even if we don't detect a
-             * state transition to ADB_STATE_NEW.
-             *
-             * Note that in my tests the NetBSD state machine takes one ADB
-             * operation to recover which means the probe for an ADB device at
-             * address 1 always fails. However since the first device is at
-             * address 2 then this will work fine, without having to come up
-             * with a more complicated and invasive solution.
-             */
-            oldstate = (v1s->last_b & VIA1B_vADB_StateMask) >>
-                       VIA1B_vADB_StateShift;
-            state = (ms->b & VIA1B_vADB_StateMask) >> VIA1B_vADB_StateShift;
-
-            if (oldstate == ADB_STATE_NEW && state == ADB_STATE_NEW &&
-                    (ms->acr & VIA1ACR_vShiftOut) &&
-                    oldsr == 0 /* ADB_BUSRESET */) {
-                trace_via1_adb_netbsd_enum_hack();
-                adb_via_send(v1s, state, ms->sr);
+        case VIA_REG_SR:
+            {
+                /*
+                 * NetBSD assumes it can send its first ADB command after
+                 * sending the ADB_BUSRESET command in ADB_STATE_NEW without
+                 * changing the state back to ADB_STATE_IDLE first as detailed
+                 * in the ADB protocol.
+                 *
+                 * Add a workaround to detect this condition at the start of
+                 * ADB enumeration and send the next command written to SR
+                 * after a ADB_BUSRESET onto the bus regardless, even if we
+                 * don't detect a state transition to ADB_STATE_NEW.
+                 *
+                 * Note that in my tests the NetBSD state machine takes one ADB
+                 * operation to recover which means the probe for an ADB device
+                 * at address 1 always fails. However since the first device is
+                 * at address 2 then this will work fine, without having to
+                 * come up with a more complicated and invasive solution.
+                 */
+                oldstate = (v1s->last_b & VIA1B_vADB_StateMask) >>
+                           VIA1B_vADB_StateShift;
+                state = (ms->b & VIA1B_vADB_StateMask) >> VIA1B_vADB_StateShift;
+
+                if (oldstate == ADB_STATE_NEW && state == ADB_STATE_NEW &&
+                        (ms->acr & VIA1ACR_vShiftOut) &&
+                        oldsr == 0 /* ADB_BUSRESET */) {
+                    trace_via1_adb_netbsd_enum_hack();
+                    adb_via_send(v1s, state, ms->sr);
+                }
             }
+            break;
         }
-        break;
     }
 }
 
@@ -1075,6 +1098,8 @@ static const MemoryRegionOps mos6522_q800_via1_ops = {
     .valid = {
         .min_access_size = 1,
         .max_access_size = 4,
+        /* VIA1 unaligned access for A/UX timer calibration */
+        .unaligned = true,
     },
 };
 
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 3d14e1db09..81bb16cea2 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -270,6 +270,8 @@ via1_adb_poll(uint8_t data, const char *vadbint, int status, int index, int size
 via1_adb_netbsd_enum_hack(void) "using NetBSD enum hack"
 via1_auxmode(int mode) "setting auxmode to %d"
 via1_timer_hack_state(int state) "setting timer_hack_state to %d"
+via1_unaligned_read(uint64_t addr, uint64_t value, unsigned size) "addr=0x%"PRIx64" value=0x%"PRIx64" size=%u"
+via1_unaligned_write(uint64_t addr, uint64_t value, unsigned size) "addr=0x%"PRIx64" value=0x%"PRIx64" size=%u"
 
 # grlib_ahb_apb_pnp.c
 grlib_ahb_pnp_read(uint64_t addr, unsigned size, uint32_t value) "AHB PnP read addr:0x%03"PRIx64" size:%u data:0x%08x"
-- 
2.30.2


