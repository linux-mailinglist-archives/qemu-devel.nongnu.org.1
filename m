Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34194799734
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 11:51:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeual-0005n3-Jr; Sat, 09 Sep 2023 05:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeuaj-0005mq-IZ
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 05:49:25 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeuag-0005K6-P6
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 05:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sXgONcpkbJf+3nwTqZ6RrBzKyumNh6iECMeRCKHdZ2k=; b=oL95qk7naU3QVWHQMefSteQfKv
 iKWMFuTWadcyveyj2ipVVaLRi0k9moS20B0jyd8nDJ/uTtbW/nE6aiCuRdxxvQDmXUbTOCvcbSOf/
 DddYLX0sXgmqwToxv8CwAiH9t4xbQu9ywPvcJcdD25w/95hCrH5YnUQLvlcVcRlTRXYaww3CTbpmb
 p+JAKIWrQX6l0VKeVfLmccygfetUV+ekyC2e7FGfJWY8X5rZ6gkHBiwniOaM4FFBJh7qDKOW1SyUH
 FGVAwPCtX7eD8qXQkxFzYy9wzWF3CXRpGwuIlE0l2CRG2/rVb91tGwbZse4G/Rvv5X/hr8CCg+2G3
 OATIYmV749JQuxomo09ryl9diCJZKbDGAMQJS5OAXa++DtGXuAoOCw+YOXAlqJrn+1Zxfz3Jb7aOz
 h1rGshsDbowGP3LHMUo+Ws9LtMa2ljPgfQc3TDGthhiSt2KJp1QDSfFe/Xe2pfFFkgm+xJizFzVcc
 4Y0PU4x2FhSnWVf3Dbxps7yftog6bdBUvgpr4vIMmsWy11hBzLEGqvUTBPBxb0VFWNzhL0oUuJR/x
 axzgUHbPA5LqgRy58ujFXmqBE/yILMViPaeJYLtHfYRi76WwPs/SIR+EZAUSmZhm2n+2K+VaHaJwc
 4kv9OIOIX8cwL09OCVu/VwdlBbPFXS7qBFGvI3Oyw=;
Received: from [2a00:23c4:8baf:5f00:e007:7058:31bc:5be9]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeuaa-0000uO-LU; Sat, 09 Sep 2023 10:49:20 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sat,  9 Sep 2023 10:48:20 +0100
Message-Id: <20230909094827.33871-14-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
References: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:5f00:e007:7058:31bc:5be9
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 13/20] swim: update IWM/ISM register block decoding
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

Update the IWM/ISM register block decoding to match the description given in the
"SWIM Chip Users Reference". This allows us to validate the device response to
the guest OS which currently only does just enough to indicate that the floppy
drive is unavailable.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/block/swim.c         | 212 +++++++++++++++++++++++++---------------
 hw/block/trace-events   |   7 +-
 include/hw/block/swim.h |   8 +-
 3 files changed, 143 insertions(+), 84 deletions(-)

diff --git a/hw/block/swim.c b/hw/block/swim.c
index 735b335883..fd65c59f8a 100644
--- a/hw/block/swim.c
+++ b/hw/block/swim.c
@@ -21,24 +21,28 @@
 #include "hw/qdev-properties.h"
 #include "trace.h"
 
+
+/* IWM latch bits */
+
+#define IWMLB_PHASE0            0
+#define IWMLB_PHASE1            1
+#define IWMLB_PHASE2            2
+#define IWMLB_PHASE3            3
+#define IWMLB_MOTORON           4
+#define IWMLB_DRIVESEL          5
+#define IWMLB_L6                6
+#define IWMLB_L7                7
+
 /* IWM registers */
 
-#define IWM_PH0L                0
-#define IWM_PH0H                1
-#define IWM_PH1L                2
-#define IWM_PH1H                3
-#define IWM_PH2L                4
-#define IWM_PH2H                5
-#define IWM_PH3L                6
-#define IWM_PH3H                7
-#define IWM_MTROFF              8
-#define IWM_MTRON               9
-#define IWM_INTDRIVE            10
-#define IWM_EXTDRIVE            11
-#define IWM_Q6L                 12
-#define IWM_Q6H                 13
-#define IWM_Q7L                 14
-#define IWM_Q7H                 15
+#define IWM_READALLONES         0
+#define IWM_READDATA            1
+#define IWM_READSTATUS0         2
+#define IWM_READSTATUS1         3
+#define IWM_READWHANDSHAKE0     4
+#define IWM_READWHANDSHAKE1     5
+#define IWM_WRITESETMODE        6
+#define IWM_WRITEDATA           7
 
 /* SWIM registers */
 
@@ -62,8 +66,9 @@
 
 #define REG_SHIFT               9
 
-#define SWIM_MODE_IWM  0
-#define SWIM_MODE_SWIM 1
+#define SWIM_MODE_STATUS_BIT    6
+#define SWIM_MODE_IWM           0
+#define SWIM_MODE_ISM           1
 
 /* bits in phase register */
 
@@ -127,10 +132,8 @@
 #define SWIM_MOTON           0x80
 
 static const char *iwm_reg_names[] = {
-    "PH0L", "PH0H", "PH1L", "PH1H",
-    "PH2L", "PH2H", "PH3L", "PH3H",
-    "MTROFF", "MTRON", "INTDRIVE", "EXTDRIVE",
-    "Q6L", "Q6H", "Q7L", "Q7H"
+    "READALLONES", "READDATA", "READSTATUS0", "READSTATUS1",
+    "READWHANDSHAKE0", "READWHANDSHAKE1", "WRITESETMODE", "WRITEDATA"
 };
 
 static const char *ism_reg_names[] = {
@@ -274,68 +277,99 @@ static const TypeInfo swim_bus_info = {
     .instance_size = sizeof(SWIMBus),
 };
 
-static void iwmctrl_write(void *opaque, hwaddr reg, uint64_t value,
+static void iwmctrl_write(void *opaque, hwaddr addr, uint64_t value,
                           unsigned size)
 {
     SWIMCtrl *swimctrl = opaque;
+    uint8_t latch, reg, ism_bit;
 
-    reg >>= REG_SHIFT;
+    addr >>= REG_SHIFT;
+
+    /* A3-A1 select a latch, A0 specifies the value */
+    latch = (addr >> 1) & 7;
+    if (addr & 1) {
+        swimctrl->iwm_latches |= (1 << latch);
+    } else {
+        swimctrl->iwm_latches &= ~(1 << latch);
+    }
+
+    reg = (swimctrl->iwm_latches & 0xc0) >> 5 |
+          (swimctrl->iwm_latches & 0x10) >> 4;
 
     swimctrl->iwmregs[reg] = value;
     trace_swim_iwmctrl_write(reg, iwm_reg_names[reg], size, value);
 
-    if (swimctrl->iwmregs[IWM_Q7H]) {
-        if (swimctrl->iwmregs[IWM_MTRON]) {
-            /* data register */
-            swimctrl->iwm_data = value;
-        } else {
-            /* mode register */
-            swimctrl->iwm_mode = value;
-            /* detect sequence to switch from IWM mode to SWIM mode */
-            switch (swimctrl->iwm_switch) {
-            case 0:
-                if (value == 0x57) {
-                    swimctrl->iwm_switch++;
-                }
-                break;
-            case 1:
-                if (value == 0x17) {
-                    swimctrl->iwm_switch++;
-                }
-                break;
-            case 2:
-                if (value == 0x57) {
-                    swimctrl->iwm_switch++;
-                }
-                break;
-            case 3:
-                if (value == 0x57) {
-                    swimctrl->mode = SWIM_MODE_SWIM;
-                    swimctrl->iwm_switch = 0;
-                    trace_swim_iwm_switch();
-
-                    /* Switch to ISM registers */
-                    memory_region_del_subregion(&swimctrl->swim,
-                                                &swimctrl->iwm);
-                    memory_region_add_subregion(&swimctrl->swim, 0x0,
-                                                &swimctrl->ism);
-                }
-                break;
+    switch (reg) {
+    case IWM_WRITESETMODE:
+        /* detect sequence to switch from IWM mode to SWIM mode */
+        ism_bit = (value & (1 << SWIM_MODE_STATUS_BIT));
+
+        switch (swimctrl->iwm_switch) {
+        case 0:
+            if (ism_bit) {    /* 1 */
+                swimctrl->iwm_switch++;
+            }
+            break;
+        case 1:
+            if (!ism_bit) {   /* 0 */
+                swimctrl->iwm_switch++;
+            }
+            break;
+        case 2:
+            if (ism_bit) {    /* 1 */
+                swimctrl->iwm_switch++;
             }
+            break;
+        case 3:
+            if (ism_bit) {    /* 1 */
+                swimctrl->iwm_switch++;
+
+                swimctrl->mode = SWIM_MODE_ISM;
+                swimctrl->swim_mode |= (1 << SWIM_MODE_STATUS_BIT);
+                swimctrl->iwm_switch = 0;
+                trace_swim_switch_to_ism();
+
+                /* Switch to ISM registers */
+                memory_region_del_subregion(&swimctrl->swim, &swimctrl->iwm);
+                memory_region_add_subregion(&swimctrl->swim, 0x0,
+                                            &swimctrl->ism);
+            }
+            break;
         }
+        break;
+    default:
+        break;
     }
 }
 
-static uint64_t iwmctrl_read(void *opaque, hwaddr reg, unsigned size)
+static uint64_t iwmctrl_read(void *opaque, hwaddr addr, unsigned size)
 {
     SWIMCtrl *swimctrl = opaque;
-    uint16_t value;
+    uint8_t latch, reg, value;
 
-    reg >>= REG_SHIFT;
+    addr >>= REG_SHIFT;
 
-    value = swimctrl->iwmregs[reg];
-    trace_swim_iwmctrl_read(reg, iwm_reg_names[reg], size, value);
+    /* A3-A1 select a latch, A0 specifies the value */
+    latch = (addr >> 1) & 7;
+    if (addr & 1) {
+        swimctrl->iwm_latches |= (1 << latch);
+    } else {
+        swimctrl->iwm_latches &= ~(1 << latch);
+    }
+
+    reg = (swimctrl->iwm_latches & 0xc0) >> 5 |
+          (swimctrl->iwm_latches & 0x10) >> 4;
+
+    switch (reg) {
+    case IWM_READALLONES:
+        value = 0xff;
+        break;
+    default:
+        value = 0;
+        break;
+    }
 
+    trace_swim_iwmctrl_read(reg, iwm_reg_names[reg], size, value);
     return value;
 }
 
@@ -352,7 +386,7 @@ static void ismctrl_write(void *opaque, hwaddr reg, uint64_t value,
 
     reg >>= REG_SHIFT;
 
-    trace_swim_swimctrl_write(reg, ism_reg_names[reg], size, value);
+    trace_swim_ismctrl_write(reg, ism_reg_names[reg], size, value);
 
     switch (reg) {
     case SWIM_WRITE_PHASE:
@@ -360,14 +394,31 @@ static void ismctrl_write(void *opaque, hwaddr reg, uint64_t value,
         break;
     case SWIM_WRITE_MODE0:
         swimctrl->swim_mode &= ~value;
+        /* Any access to MODE0 register resets PRAM index */
+        swimctrl->pram_idx = 0;
+
+        if (!(swimctrl->swim_mode & (1 << SWIM_MODE_STATUS_BIT))) {
+            /* Clearing the mode bit switches to IWM mode */
+            swimctrl->mode = SWIM_MODE_IWM;
+            swimctrl->iwm_latches = 0;
+            trace_swim_switch_to_iwm();
+
+            /* Switch to IWM registers */
+            memory_region_del_subregion(&swimctrl->swim, &swimctrl->ism);
+            memory_region_add_subregion(&swimctrl->swim, 0x0,
+                                        &swimctrl->iwm);
+        }
         break;
     case SWIM_WRITE_MODE1:
         swimctrl->swim_mode |= value;
         break;
+    case SWIM_WRITE_PARAMETER:
+        swimctrl->pram[swimctrl->pram_idx++] = value;
+        swimctrl->pram_idx &= 0xf;
+        break;
     case SWIM_WRITE_DATA:
     case SWIM_WRITE_MARK:
     case SWIM_WRITE_CRC:
-    case SWIM_WRITE_PARAMETER:
     case SWIM_WRITE_SETUP:
         break;
     }
@@ -390,16 +441,24 @@ static uint64_t ismctrl_read(void *opaque, hwaddr reg, unsigned size)
             value = SWIM_SENSE;
         }
         break;
+    case SWIM_READ_PARAMETER:
+        value = swimctrl->pram[swimctrl->pram_idx++];
+        swimctrl->pram_idx &= 0xf;
+        break;
+    case SWIM_READ_STATUS:
+        value = swimctrl->swim_status & ~(1 << SWIM_MODE_STATUS_BIT);
+        if (swimctrl->swim_mode == SWIM_MODE_ISM) {
+            value |= (1 << SWIM_MODE_STATUS_BIT);
+        }
+        break;
     case SWIM_READ_DATA:
     case SWIM_READ_MARK:
     case SWIM_READ_ERROR:
-    case SWIM_READ_PARAMETER:
     case SWIM_READ_SETUP:
-    case SWIM_READ_STATUS:
         break;
     }
 
-    trace_swim_swimctrl_read(reg, ism_reg_names[reg], size, value);
+    trace_swim_ismctrl_read(reg, ism_reg_names[reg], size, value);
     return value;
 }
 
@@ -417,13 +476,11 @@ static void sysbus_swim_reset(DeviceState *d)
 
     ctrl->mode = 0;
     ctrl->iwm_switch = 0;
-    ctrl->iwm_data = 0;
-    ctrl->iwm_mode = 0;
-    memset(ctrl->iwmregs, 0, 16);
+    memset(ctrl->iwmregs, 0, sizeof(ctrl->iwmregs));
 
     ctrl->swim_phase = 0;
     ctrl->swim_mode = 0;
-    memset(ctrl->ismregs, 0, 16);
+    memset(ctrl->ismregs, 0, sizeof(ctrl->ismregs));
     for (i = 0; i < SWIM_MAX_FD; i++) {
         fd_recalibrate(&ctrl->drives[i]);
     }
@@ -472,9 +529,8 @@ static const VMStateDescription vmstate_swim = {
         VMSTATE_INT32(mode, SWIMCtrl),
         /* IWM mode */
         VMSTATE_INT32(iwm_switch, SWIMCtrl),
-        VMSTATE_UINT8_ARRAY(iwmregs, SWIMCtrl, 16),
-        VMSTATE_UINT8(iwm_data, SWIMCtrl),
-        VMSTATE_UINT8(iwm_mode, SWIMCtrl),
+        VMSTATE_UINT8(iwm_latches, SWIMCtrl),
+        VMSTATE_UINT8_ARRAY(iwmregs, SWIMCtrl, 8),
         /* SWIM mode */
         VMSTATE_UINT8_ARRAY(ismregs, SWIMCtrl, 16),
         VMSTATE_UINT8(swim_phase, SWIMCtrl),
diff --git a/hw/block/trace-events b/hw/block/trace-events
index ea84ad6c77..bab21d3a1c 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -92,8 +92,9 @@ m25p80_binding(void *s) "[%p] Binding to IF_MTD drive"
 m25p80_binding_no_bdrv(void *s) "[%p] No BDRV - binding to RAM"
 
 # swim.c
-swim_swimctrl_read(int reg, const char *name, unsigned size, uint64_t value) "reg=%d [%s] size=%u value=0x%"PRIx64
-swim_swimctrl_write(int reg, const char *name, unsigned size, uint64_t value) "reg=%d [%s] size=%u value=0x%"PRIx64
+swim_ismctrl_read(int reg, const char *name, unsigned size, uint64_t value) "reg=%d [%s] size=%u value=0x%"PRIx64
+swim_ismctrl_write(int reg, const char *name, unsigned size, uint64_t value) "reg=%d [%s] size=%u value=0x%"PRIx64
 swim_iwmctrl_read(int reg, const char *name, unsigned size, uint64_t value) "reg=%d [%s] size=%u value=0x%"PRIx64
 swim_iwmctrl_write(int reg, const char *name, unsigned size, uint64_t value) "reg=%d [%s] size=%u value=0x%"PRIx64
-swim_iwm_switch(void) "switch from IWM to SWIM mode"
+swim_switch_to_ism(void) "switch from IWM to ISM mode"
+swim_switch_to_iwm(void) "switch from ISM to IWM mode"
diff --git a/include/hw/block/swim.h b/include/hw/block/swim.h
index 1bc7635d02..5f567e8d59 100644
--- a/include/hw/block/swim.h
+++ b/include/hw/block/swim.h
@@ -50,13 +50,15 @@ struct SWIMCtrl {
     int mode;
     /* IWM mode */
     int iwm_switch;
-    uint8_t iwmregs[16];
-    uint8_t iwm_data;
-    uint8_t iwm_mode;
+    uint8_t iwm_latches;
+    uint8_t iwmregs[8];
     /* SWIM mode */
     uint8_t ismregs[16];
     uint8_t swim_phase;
     uint8_t swim_mode;
+    uint8_t swim_status;
+    uint8_t pram[16];
+    uint8_t pram_idx;
     SWIMBus bus;
 };
 
-- 
2.39.2


