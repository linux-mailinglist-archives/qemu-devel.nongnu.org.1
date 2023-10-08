Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 150927BCCA5
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 08:27:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpNCx-000889-Hz; Sun, 08 Oct 2023 02:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCu-000871-Td
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:24:04 -0400
Received: from mout.kundenserver.de ([217.72.192.73])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCs-0007nI-Ur
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:24:04 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MAP77-1qiWOQ0GGB-00BvUp; Sun, 08
 Oct 2023 08:24:01 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 14/20] mac_via: work around underflow in TimeDBRA timing loop
 in SETUPTIMEK
Date: Sun,  8 Oct 2023 08:23:43 +0200
Message-ID: <20231008062349.2733552-15-laurent@vivier.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231008062349.2733552-1-laurent@vivier.eu>
References: <20231008062349.2733552-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:p+vj7gnh0rVDtLP+EXazS12NzyHD7epKzxM62FUSFiEFU+umWes
 HyC8Y77DNSGOFsqT5Fm/ruvfDU5ZQuG1ymiXQlVqgfHGaLnvaARUZo7zjC4aVOsx+0loMDz
 vTA/aepNn4fJjLDMBK+1x1wrKcJbQekSqoqrodFanM+Cugj+rLH7bjmKDNN5LAClnzuBLDJ
 xAbD2SA0jbf753bg84GAg==
UI-OutboundReport: notjunk:1;M01:P0:iZGMJlO5NSA=;EyDWnZ/XBuB7DUaGNAKByvdJSqy
 4UqM9mDECsO7Mkdi0DXe6YAN0eZ7Qm23PN8bFePUZpGJHzVgenu2uD8RFpvSuQMNlwlS0qhpJ
 CA1lSOgJU2s/FEXOU2TgzGP0unM2ww8mcR+IwmSC46/RF3cq9QLxCwp3MaAOerAypWqEGtC41
 y7WFGFUfbxDMddu/n5ROpOW1xfCw1JHlbNRsb6NwvaKs8zWd41dJbcwu3cJhg0f9S4xcvCdCZ
 TdytXiknA1lCQektAvUqoyw8fCO6ylEDCleKSLJ+opMGyhfwrwamjKLx0uGZ9P2HS/Z8Ar/wo
 d3bimUWMjHQMFMD9LUpe2M7ys73x8Fk5O2+Y0OjQT5e8uok+SU8gZT9BX5vGRZrYIC0skNPWd
 6s+og/0EidjJsG5fK+hlXWf3Nm8zGDTjfalp3FmhMDDx8Y1oI/VkE3rGODsBBGUZvqhi8w4DX
 0C1SC73sqIULspKdm7Cf1LIXDgEs5Arb04kgvrlmuvmJk+eulCgY84VHlH+D1Tj1wcFONph8p
 c+7WtXNtNQRR0jVOSfBIlG1tYlJhUxTnNX1EoD9AiQhfHt5Vx3/RnlBEnKLteYQL9LTp+upwV
 cqy3Su3hOXs8dXR7tKIb4Pt33yHggG/0sFQv9AeN8wm5xAEO2Jbn6hr9yN3WkQ2o2DaXvJyh/
 C1HTymsHFsH7g8xYnN7Cp++8UGfVfIy2+7lRsAcVS79+gcd2d9rHWKxHc0L6BpGMr4Zz3/Xoh
 kVZyk9lUSd9r1lCACKzTVc2GQYCUDSsHIWyniVtVibAA2Fo2/K3MIot3XoPim/1Bl/AK6L5ar
 e50HLLZBbgnzOZB9dtp5C4fYw3I8pLD4S9KejdL5IseAcw0raDLNkhbNnRRftfHsNfnXZDcHy
 NkuJTo4FuWgEV6A==
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

The MacOS toolbox ROM calculates the number of branches that can be executed
per millisecond as part of its timer calibration. Since modern hosts are
considerably quicker than original hardware, the negative counter reaches zero
before the calibration completes leading to division by zero later in
CALCULATESLOD.

Instead of trying to fudge the timing loop (which won't work for TimeDBRA/TimeSCCDB
anyhow), use the pattern of access to the VIA1 registers to detect when SETUPTIMEK
has finished executing and write some well-known good timer values to TimeDBRA
and TimeSCCDB taken from real hardware with a suitable scaling factor.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20231004083806.757242-15-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/misc/mac_via.h |   3 +
 hw/misc/mac_via.c         | 115 ++++++++++++++++++++++++++++++++++++++
 hw/misc/trace-events      |   1 +
 3 files changed, 119 insertions(+)

diff --git a/include/hw/misc/mac_via.h b/include/hw/misc/mac_via.h
index 422da43bf90a..63cdcf7c69c9 100644
--- a/include/hw/misc/mac_via.h
+++ b/include/hw/misc/mac_via.h
@@ -74,6 +74,9 @@ struct MOS6522Q800VIA1State {
     int64_t next_second;
     QEMUTimer *sixty_hz_timer;
     int64_t next_sixty_hz;
+
+    /* SETUPTIMEK hack */
+    int timer_hack_state;
 };
 
 
diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index e87a1b82d8c5..f2ccb12d643b 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -16,6 +16,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "exec/address-spaces.h"
 #include "migration/vmstate.h"
 #include "hw/sysbus.h"
 #include "hw/irq.h"
@@ -871,6 +872,112 @@ static void via1_auxmode_update(MOS6522Q800VIA1State *v1s)
     }
 }
 
+/*
+ * Addresses and real values for TimeDBRA/TimeSCCB to allow timer calibration
+ * to succeed (NOTE: both values have been multiplied by 3 to cope with the
+ * speed of QEMU execution on a modern host
+ */
+#define MACOS_TIMEDBRA        0xd00
+#define MACOS_TIMESCCB        0xd02
+
+#define MACOS_TIMEDBRA_VALUE  (0x2a00 * 3)
+#define MACOS_TIMESCCB_VALUE  (0x079d * 3)
+
+static bool via1_is_toolbox_timer_calibrated(void)
+{
+    /*
+     * Indicate whether the MacOS toolbox has been calibrated by checking
+     * for the value of our magic constants
+     */
+    uint16_t timedbra = lduw_be_phys(&address_space_memory, MACOS_TIMEDBRA);
+    uint16_t timesccdb = lduw_be_phys(&address_space_memory, MACOS_TIMESCCB);
+
+    return (timedbra == MACOS_TIMEDBRA_VALUE &&
+            timesccdb == MACOS_TIMESCCB_VALUE);
+}
+
+static void via1_timer_calibration_hack(MOS6522Q800VIA1State *v1s, int addr,
+                                        uint64_t val, int size)
+{
+    /*
+     * Work around timer calibration to ensure we that we have non-zero and
+     * known good values for TIMEDRBA and TIMESCCDB.
+     *
+     * This works by attempting to detect the reset and calibration sequence
+     * of writes to VIA1
+     */
+    int old_timer_hack_state = v1s->timer_hack_state;
+
+    switch (v1s->timer_hack_state) {
+    case 0:
+        if (addr == VIA_REG_PCR && val == 0x22) {
+            /* VIA_REG_PCR: configure VIA1 edge triggering */
+            v1s->timer_hack_state = 1;
+        }
+        break;
+    case 1:
+        if (addr == VIA_REG_T2CL && val == 0xc) {
+            /* VIA_REG_T2CL: low byte of 1ms counter */
+            if (!via1_is_toolbox_timer_calibrated()) {
+                v1s->timer_hack_state = 2;
+            } else {
+                v1s->timer_hack_state = 0;
+            }
+        }
+        break;
+    case 2:
+        if (addr == VIA_REG_T2CH && val == 0x3) {
+            /*
+             * VIA_REG_T2CH: high byte of 1ms counter (very likely at the
+             * start of SETUPTIMEK)
+             */
+            if (!via1_is_toolbox_timer_calibrated()) {
+                v1s->timer_hack_state = 3;
+            } else {
+                v1s->timer_hack_state = 0;
+            }
+        }
+        break;
+    case 3:
+        if (addr == VIA_REG_IER && val == 0x20) {
+            /*
+             * VIA_REG_IER: update at end of SETUPTIMEK
+             *
+             * Timer calibration has finished: unfortunately the values in
+             * TIMEDBRA (0xd00) and TIMESCCDB (0xd02) are so far out they
+             * cause divide by zero errors.
+             *
+             * Update them with values obtained from a real Q800 but with
+             * a x3 scaling factor which seems to work well
+             */
+            stw_be_phys(&address_space_memory, MACOS_TIMEDBRA,
+                        MACOS_TIMEDBRA_VALUE);
+            stw_be_phys(&address_space_memory, MACOS_TIMESCCB,
+                        MACOS_TIMESCCB_VALUE);
+
+            v1s->timer_hack_state = 4;
+        }
+        break;
+    case 4:
+        /*
+         * This is the normal post-calibration timer state: we should
+         * generally remain here unless we detect the A/UX calibration
+         * loop, or a write to VIA_REG_PCR suggesting a reset
+         */
+        if (addr == VIA_REG_PCR && val == 0x22) {
+            /* Looks like there has been a reset? */
+            v1s->timer_hack_state = 1;
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (old_timer_hack_state != v1s->timer_hack_state) {
+        trace_via1_timer_hack_state(v1s->timer_hack_state);
+    }
+}
+
 static uint64_t mos6522_q800_via1_read(void *opaque, hwaddr addr, unsigned size)
 {
     MOS6522Q800VIA1State *s = MOS6522_Q800_VIA1(opaque);
@@ -896,6 +1003,9 @@ static void mos6522_q800_via1_write(void *opaque, hwaddr addr, uint64_t val,
     MOS6522State *ms = MOS6522(v1s);
 
     addr = (addr >> 9) & 0xf;
+
+    via1_timer_calibration_hack(v1s, addr, val, size);
+
     mos6522_write(ms, addr, val, size);
 
     switch (addr) {
@@ -1008,6 +1118,9 @@ static void mos6522_q800_via1_reset_hold(Object *obj)
     adb_set_autopoll_enabled(adb_bus, true);
     v1s->cmd = REG_EMPTY;
     v1s->alt = REG_EMPTY;
+
+    /* Timer calibration hack */
+    v1s->timer_hack_state = 0;
 }
 
 static void mos6522_q800_via1_realize(DeviceState *dev, Error **errp)
@@ -1100,6 +1213,8 @@ static const VMStateDescription vmstate_q800_via1 = {
         VMSTATE_INT64(next_second, MOS6522Q800VIA1State),
         VMSTATE_TIMER_PTR(sixty_hz_timer, MOS6522Q800VIA1State),
         VMSTATE_INT64(next_sixty_hz, MOS6522Q800VIA1State),
+        /* Timer hack */
+        VMSTATE_INT32(timer_hack_state, MOS6522Q800VIA1State),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 29bc531d4d3e..5a998f5e4e38 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -272,6 +272,7 @@ via1_adb_send(const char *state, uint8_t data, const char *vadbint) "state %s da
 via1_adb_receive(const char *state, uint8_t data, const char *vadbint, int status, int index, int size) "state %s data=0x%02x vADBInt=%s status=0x%x index=%d size=%d"
 via1_adb_poll(uint8_t data, const char *vadbint, int status, int index, int size) "data=0x%02x vADBInt=%s status=0x%x index=%d size=%d"
 via1_auxmode(int mode) "setting auxmode to %d"
+via1_timer_hack_state(int state) "setting timer_hack_state to %d"
 
 # grlib_ahb_apb_pnp.c
 grlib_ahb_pnp_read(uint64_t addr, unsigned size, uint32_t value) "AHB PnP read addr:0x%03"PRIx64" size:%u data:0x%08x"
-- 
2.41.0


