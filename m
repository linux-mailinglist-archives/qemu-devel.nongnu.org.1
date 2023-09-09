Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DF8799732
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 11:51:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeuaz-00068m-Gm; Sat, 09 Sep 2023 05:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeuax-0005y7-GQ
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 05:49:39 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeuau-0005Kb-Vi
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 05:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PbbJNixc7/YpuK3MOJAtcZwfyFwpenlFXocTtp67rTc=; b=pAZ+zwitOE1Qf3KMz/XTLKPgvo
 OkdqPFj4M1hDJ8LxlwFQcMXeEVEUgn+DG486Z7PxY412vSFf13923qENUhdPw2N1r9Q0TS0tGBkrM
 tZdCrn7nG+5t34WdpRXVf0bBSy72HRx6u6RbS+fTIZPeJkyyxyeptM9MO51WOqBnRUS9O6SnZh3/k
 DweIGvuq+xGoubsFHSMSY+5xm4IH/duLYGmuuKJQsQRVFLRi4biljaNX3QkNlu1hwNHsBnFmjmx6T
 y/w9XMHinRH3CLILS99iMaUXgAWKGtP5Y3cM7qiC2Fn4CQLZRdgmumuFwqMTGgKcuhSVyK3QCj69N
 jz9ePmDl5NDU74BRnrchnzjdHQoMx+9xHgjgiBGHIcrBfDO5pXShk3+YMn1WA7jgLg84PnXdXS0XI
 jone0ih/zsQonk0reIfv0uLSqg/g9OsAvvDLcauTk+GLwXhbuIi7l3A7RseVqfvpUxaOZL8xY3o62
 gdrEJNLZqRgH9khp8hVKdBTO+6/R6w14T8TI2WBFy1SnsXo4PBBvFxVcu4ZzRU+XML2MFOJpOHp0X
 raqm9XWapAdZFUBMtSu+DshU4S7CdYsXV2vc3s6ySxlJgb11+xOGKZENhON0JrlbE6mDL7mI1kMar
 5HnX5y1Aalz78BHgoiCtp5sZGePrldbl5dZRP4fi8=;
Received: from [2a00:23c4:8baf:5f00:e007:7058:31bc:5be9]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeuae-0000uO-Ro; Sat, 09 Sep 2023 10:49:24 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sat,  9 Sep 2023 10:48:21 +0100
Message-Id: <20230909094827.33871-15-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
References: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:5f00:e007:7058:31bc:5be9
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 14/20] mac_via: work around underflow in TimeDBRA timing
 loop in SETUPTIMEK
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
---
 hw/misc/mac_via.c         | 115 ++++++++++++++++++++++++++++++++++++++
 hw/misc/trace-events      |   1 +
 include/hw/misc/mac_via.h |   3 +
 3 files changed, 119 insertions(+)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index baeb73eeb3..766a32a95d 100644
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
index c9bdb0d30e..0c9762fdf6 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -272,6 +272,7 @@ via1_adb_send(const char *state, uint8_t data, const char *vadbint) "state %s da
 via1_adb_receive(const char *state, uint8_t data, const char *vadbint, int status, int index, int size) "state %s data=0x%02x vADBInt=%s status=0x%x index=%d size=%d"
 via1_adb_poll(uint8_t data, const char *vadbint, int status, int index, int size) "data=0x%02x vADBInt=%s status=0x%x index=%d size=%d"
 via1_auxmode(int mode) "setting auxmode to %d"
+via1_timer_hack_state(int state) "setting timer_hack_state to %d"
 
 # grlib_ahb_apb_pnp.c
 grlib_ahb_pnp_read(uint64_t addr, unsigned size, uint32_t value) "AHB PnP read addr:0x%03"PRIx64" size:%u data:0x%08x"
diff --git a/include/hw/misc/mac_via.h b/include/hw/misc/mac_via.h
index 422da43bf9..63cdcf7c69 100644
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
 
 
-- 
2.39.2


