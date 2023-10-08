Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 185BC7BCC92
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 08:24:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpNCw-000880-So; Sun, 08 Oct 2023 02:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCu-00086r-FK
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:24:04 -0400
Received: from mout.kundenserver.de ([217.72.192.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCs-0007n3-6t
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:24:04 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MORVA-1rE42I0KT8-00Ps1e; Sun, 08
 Oct 2023 08:24:00 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 13/20] swim: update IWM/ISM register block decoding
Date: Sun,  8 Oct 2023 08:23:42 +0200
Message-ID: <20231008062349.2733552-14-laurent@vivier.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231008062349.2733552-1-laurent@vivier.eu>
References: <20231008062349.2733552-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0nOMZ8wFunU+IWz6tOVIf8Pfl8O8T3SoG6z+cfGt7uvZ1pcs4EQ
 Tzj8G8ieDvhl+0tRWybRDykSC+49uEsDgvfl5RG5Z3tn6Kg4ZI4SF7gooag2QmQJ9KxHDUh
 TFGqq9VWY1sszjOidH1RQDGO+uhobKvAzm/xRYjz5loOXX8/lp7Jh7CbKs+jywM0eQGag+c
 fpCsvFwMS/aRz75WiJeAw==
UI-OutboundReport: notjunk:1;M01:P0:wMZYUu3pUBg=;eC9/nYDVsCEw3KNeNvgh+I7JAHR
 B/QoNWACMk88fB6pcOpqv1NFmNNmaZVp5uJB2SYGziC+k1YCrHUnRqqT3UNuwlwrPKdoofyi4
 ssXk/Wymo9uq498Y2PZhBMm7ad210NUhWJWznllYqnTVZFJ6r+1WmC1MRr3B5q4HDxgnpTsZL
 +JjJA3WjBOEHEXhYdHmogOVhrAnTpfD2IK2OisObh//F009ftP7KXgzdqyA8sW+JXl2uoeDV+
 +ZI4TGqZnfp/eEd4GSeXw1NLo/PGKyQe+xdNGHFZg/+hZuTt6fc4btiQZR/eZgFr0Gw47GZo6
 vrk80uRWmXYFUF3gDsfVbCEiCfoaX1UwypCUYt2KhxDR4LY94tscXSz0Um8C5+ETYBPpJq6MT
 ERW46leLbF52zqvg4F/3l7YKY7MlXFU2p03EHlvg2OhCSW4XuY5JeQCEGbE9AQH78k8rpcxlG
 ySRvB8rRHzBA6ueE+fBRC+ezNX5xEhUeXdv/4zIVykpO+r4rCbRG7GGrbBBOOxCpT4GoAZi5i
 dAO6JXn8vxzGs6Or8OzQ2Hels5+Ia0/aECTAiyVOD+aOVBB6LVa2/JzA7WsOUmiBPw9L4h90C
 X0AdWhJQ/7aLz2IbZkuR2PPIaIHtTlyMLNqkG4mV2U/be2Tl7rhOiDGlwxyOoOJmBEsyzkXLL
 9Lwm3ACbgL0xUiX1LBvntd8H9SlsS7DyYIhL6RUJ00X89KaWtIVAsw6nVHDtvWI4gblCUCJcY
 iTakVLvEdP8O1eUAkvJVnECtc3pBTv0ui46KppswHuSbXvFn8d3g/8mb553P7Ng5bW6wMPA/1
 HteugxysPp7DclUU+8KjlYFVMq5m9iYCS0Z2ulxdoCQZqD95p43B9DvhZlZO9UOFkbyG2JTlX
 FEYSiwpVY1ESdVA==
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
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

Update the IWM/ISM register block decoding to match the description given in the
"SWIM Chip Users Reference". This allows us to validate the device response to
the guest OS which currently only does just enough to indicate that the floppy
drive is unavailable.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20231004083806.757242-14-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/block/swim.h |   8 +-
 hw/block/swim.c         | 212 +++++++++++++++++++++++++---------------
 hw/block/trace-events   |   7 +-
 3 files changed, 143 insertions(+), 84 deletions(-)

diff --git a/include/hw/block/swim.h b/include/hw/block/swim.h
index 1bc7635d0212..5f567e8d5957 100644
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
 
diff --git a/hw/block/swim.c b/hw/block/swim.c
index 505718bdae3f..fd65c59f8a10 100644
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
-    uint8_t value;
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
index ea84ad6c77ed..bab21d3a1ca8 100644
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
-- 
2.41.0


