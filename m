Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2426F799729
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 11:50:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeuai-0005mn-Ov; Sat, 09 Sep 2023 05:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeuag-0005mA-M1
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 05:49:22 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeuad-0005Jd-KY
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 05:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QuBzyOwiWH41kPcYS+vyYI3R4waZLbhaJZhEWYTvsQc=; b=0zN7EqEpLlPyHQYiJn+MHrjkj1
 xqqBLxQotfqJl9Uu11BjewJ2StXgaKxBM8j4/ytA7XUigAMZyuLS5+ssN8GCYwVEXnCZBGwQ0HVGR
 y9q37+YT69O6Cm2vw+KkMYnGCW+AYPhxDpLqx8u1m3MD96n5dvp79Tx1n9MIhs+zNRH5CjHjRqUZt
 EsfHUOn5FJgN+Ng7S7z1hg4nxg9Ro6gV+xGbsvGh5SQePxgiTrjMsF8mWpIuV7U97v+hLxbO0LjUM
 QCt06sCYZtkbrMIKbeaiZoRxlAumfyIV383yi2XUF8+JYy0Nb1QuszPSLQaVf/m61rtu/BEUNMFe7
 bQz8QDBfbhxUYDZnfpLQQ+oro2T8RdbvJIEJEHv46CvLod2icKQtwEBaupmB/gbsTc/m1UfVZ0ot1
 ttgTINstT/9JbOraDEvsbKVBOY1XXmo0SQlh5BQ4DCpKiHV3AvyGqaAMy1V2YJhgCSLXIk6iu6zIW
 pa1n2VmFqdKm1C9X0XOWav/5XD56yCHeLOxmoBNVZSRJ4aO78Xlqle5YFzdYKTnXOkLHAls7C/HUL
 XvOawx/N5HonsTf9m7Uz5R8LlJXTgybgDVN0D0cmDczPbhJYGotF0ZMIfzTFeuMJUImMH92S9FBKQ
 uytQC8csbQ42Pvr5bly2bBu/51tyKZqlm9/LsExWw=;
Received: from [2a00:23c4:8baf:5f00:e007:7058:31bc:5be9]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeuaa-0000uO-4w; Sat, 09 Sep 2023 10:49:16 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sat,  9 Sep 2023 10:48:19 +0100
Message-Id: <20230909094827.33871-13-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
References: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:5f00:e007:7058:31bc:5be9
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 12/20] swim: split into separate IWM and ISM register blocks
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

The swim chip provides an implementation of both Apple's IWM and ISM floppy disk
controllers. Split the existing implementation into separate register banks for
each controller, whilst also switching the IWM registers from 16-bit to 8-bit
as implemented in real hardware.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/block/swim.c         | 85 ++++++++++++++++++++++++-----------------
 hw/block/trace-events   |  4 +-
 include/hw/block/swim.h | 15 +++-----
 3 files changed, 58 insertions(+), 46 deletions(-)

diff --git a/hw/block/swim.c b/hw/block/swim.c
index 7df36ea139..735b335883 100644
--- a/hw/block/swim.c
+++ b/hw/block/swim.c
@@ -126,7 +126,14 @@
 #define SWIM_HEDSEL          0x20
 #define SWIM_MOTON           0x80
 
-static const char *swim_reg_names[] = {
+static const char *iwm_reg_names[] = {
+    "PH0L", "PH0H", "PH1L", "PH1H",
+    "PH2L", "PH2H", "PH3L", "PH3H",
+    "MTROFF", "MTRON", "INTDRIVE", "EXTDRIVE",
+    "Q6L", "Q6H", "Q7L", "Q7H"
+};
+
+static const char *ism_reg_names[] = {
     "WRITE_DATA", "WRITE_MARK", "WRITE_CRC", "WRITE_PARAMETER",
     "WRITE_PHASE", "WRITE_SETUP", "WRITE_MODE0", "WRITE_MODE1",
     "READ_DATA", "READ_MARK", "READ_ERROR", "READ_PARAMETER",
@@ -274,12 +281,11 @@ static void iwmctrl_write(void *opaque, hwaddr reg, uint64_t value,
 
     reg >>= REG_SHIFT;
 
-    swimctrl->regs[reg >> 1] = reg & 1;
-    trace_swim_iwmctrl_write((reg >> 1), size, (reg & 1));
+    swimctrl->iwmregs[reg] = value;
+    trace_swim_iwmctrl_write(reg, iwm_reg_names[reg], size, value);
 
-    if (swimctrl->regs[IWM_Q6] &&
-        swimctrl->regs[IWM_Q7]) {
-        if (swimctrl->regs[IWM_MTR]) {
+    if (swimctrl->iwmregs[IWM_Q7H]) {
+        if (swimctrl->iwmregs[IWM_MTRON]) {
             /* data register */
             swimctrl->iwm_data = value;
         } else {
@@ -307,6 +313,12 @@ static void iwmctrl_write(void *opaque, hwaddr reg, uint64_t value,
                     swimctrl->mode = SWIM_MODE_SWIM;
                     swimctrl->iwm_switch = 0;
                     trace_swim_iwm_switch();
+
+                    /* Switch to ISM registers */
+                    memory_region_del_subregion(&swimctrl->swim,
+                                                &swimctrl->iwm);
+                    memory_region_add_subregion(&swimctrl->swim, 0x0,
+                                                &swimctrl->ism);
                 }
                 break;
             }
@@ -317,28 +329,30 @@ static void iwmctrl_write(void *opaque, hwaddr reg, uint64_t value,
 static uint64_t iwmctrl_read(void *opaque, hwaddr reg, unsigned size)
 {
     SWIMCtrl *swimctrl = opaque;
+    uint16_t value;
 
     reg >>= REG_SHIFT;
 
-    swimctrl->regs[reg >> 1] = reg & 1;
+    value = swimctrl->iwmregs[reg];
+    trace_swim_iwmctrl_read(reg, iwm_reg_names[reg], size, value);
 
-    trace_swim_iwmctrl_read((reg >> 1), size, (reg & 1));
-    return 0;
+    return value;
 }
 
-static void swimctrl_write(void *opaque, hwaddr reg, uint64_t value,
-                           unsigned size)
+static const MemoryRegionOps swimctrl_iwm_ops = {
+    .write = iwmctrl_write,
+    .read = iwmctrl_read,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void ismctrl_write(void *opaque, hwaddr reg, uint64_t value,
+                          unsigned size)
 {
     SWIMCtrl *swimctrl = opaque;
 
-    if (swimctrl->mode == SWIM_MODE_IWM) {
-        iwmctrl_write(opaque, reg, value, size);
-        return;
-    }
-
     reg >>= REG_SHIFT;
 
-    trace_swim_swimctrl_write(reg, swim_reg_names[reg], size, value);
+    trace_swim_swimctrl_write(reg, ism_reg_names[reg], size, value);
 
     switch (reg) {
     case SWIM_WRITE_PHASE:
@@ -359,15 +373,11 @@ static void swimctrl_write(void *opaque, hwaddr reg, uint64_t value,
     }
 }
 
-static uint64_t swimctrl_read(void *opaque, hwaddr reg, unsigned size)
+static uint64_t ismctrl_read(void *opaque, hwaddr reg, unsigned size)
 {
     SWIMCtrl *swimctrl = opaque;
     uint32_t value = 0;
 
-    if (swimctrl->mode == SWIM_MODE_IWM) {
-        return iwmctrl_read(opaque, reg, size);
-    }
-
     reg >>= REG_SHIFT;
 
     switch (reg) {
@@ -389,14 +399,14 @@ static uint64_t swimctrl_read(void *opaque, hwaddr reg, unsigned size)
         break;
     }
 
-    trace_swim_swimctrl_read(reg, swim_reg_names[reg], size, value);
+    trace_swim_swimctrl_read(reg, ism_reg_names[reg], size, value);
     return value;
 }
 
-static const MemoryRegionOps swimctrl_mem_ops = {
-    .write = swimctrl_write,
-    .read = swimctrl_read,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+static const MemoryRegionOps swimctrl_ism_ops = {
+    .write = ismctrl_write,
+    .read = ismctrl_read,
+    .endianness = DEVICE_BIG_ENDIAN,
 };
 
 static void sysbus_swim_reset(DeviceState *d)
@@ -407,13 +417,13 @@ static void sysbus_swim_reset(DeviceState *d)
 
     ctrl->mode = 0;
     ctrl->iwm_switch = 0;
-    for (i = 0; i < 8; i++) {
-        ctrl->regs[i] = 0;
-    }
     ctrl->iwm_data = 0;
     ctrl->iwm_mode = 0;
+    memset(ctrl->iwmregs, 0, 16);
+
     ctrl->swim_phase = 0;
     ctrl->swim_mode = 0;
+    memset(ctrl->ismregs, 0, 16);
     for (i = 0; i < SWIM_MAX_FD; i++) {
         fd_recalibrate(&ctrl->drives[i]);
     }
@@ -425,9 +435,12 @@ static void sysbus_swim_init(Object *obj)
     Swim *sbs = SWIM(obj);
     SWIMCtrl *swimctrl = &sbs->ctrl;
 
-    memory_region_init_io(&swimctrl->iomem, obj, &swimctrl_mem_ops, swimctrl,
-                          "swim", 0x2000);
-    sysbus_init_mmio(sbd, &swimctrl->iomem);
+    memory_region_init(&swimctrl->swim, obj, "swim", 0x2000);
+    memory_region_init_io(&swimctrl->iwm, obj, &swimctrl_iwm_ops, swimctrl,
+                          "iwm", 0x2000);
+    memory_region_init_io(&swimctrl->ism, obj, &swimctrl_ism_ops, swimctrl,
+                          "ism", 0x2000);
+    sysbus_init_mmio(sbd, &swimctrl->swim);
 }
 
 static void sysbus_swim_realize(DeviceState *dev, Error **errp)
@@ -437,6 +450,9 @@ static void sysbus_swim_realize(DeviceState *dev, Error **errp)
 
     qbus_init(&swimctrl->bus, sizeof(SWIMBus), TYPE_SWIM_BUS, dev, NULL);
     swimctrl->bus.ctrl = swimctrl;
+
+    /* Default register set is IWM */
+    memory_region_add_subregion(&swimctrl->swim, 0x0, &swimctrl->iwm);
 }
 
 static const VMStateDescription vmstate_fdrive = {
@@ -456,10 +472,11 @@ static const VMStateDescription vmstate_swim = {
         VMSTATE_INT32(mode, SWIMCtrl),
         /* IWM mode */
         VMSTATE_INT32(iwm_switch, SWIMCtrl),
-        VMSTATE_UINT16_ARRAY(regs, SWIMCtrl, 8),
+        VMSTATE_UINT8_ARRAY(iwmregs, SWIMCtrl, 16),
         VMSTATE_UINT8(iwm_data, SWIMCtrl),
         VMSTATE_UINT8(iwm_mode, SWIMCtrl),
         /* SWIM mode */
+        VMSTATE_UINT8_ARRAY(ismregs, SWIMCtrl, 16),
         VMSTATE_UINT8(swim_phase, SWIMCtrl),
         VMSTATE_UINT8(swim_mode, SWIMCtrl),
         /* Drives */
diff --git a/hw/block/trace-events b/hw/block/trace-events
index c041ec45e3..ea84ad6c77 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -94,6 +94,6 @@ m25p80_binding_no_bdrv(void *s) "[%p] No BDRV - binding to RAM"
 # swim.c
 swim_swimctrl_read(int reg, const char *name, unsigned size, uint64_t value) "reg=%d [%s] size=%u value=0x%"PRIx64
 swim_swimctrl_write(int reg, const char *name, unsigned size, uint64_t value) "reg=%d [%s] size=%u value=0x%"PRIx64
-swim_iwmctrl_read(int reg, unsigned size, uint64_t value) "reg=%d size=%u value=0x%"PRIx64
-swim_iwmctrl_write(int reg, unsigned size, uint64_t value) "reg=%d size=%u value=0x%"PRIx64
+swim_iwmctrl_read(int reg, const char *name, unsigned size, uint64_t value) "reg=%d [%s] size=%u value=0x%"PRIx64
+swim_iwmctrl_write(int reg, const char *name, unsigned size, uint64_t value) "reg=%d [%s] size=%u value=0x%"PRIx64
 swim_iwm_switch(void) "switch from IWM to SWIM mode"
diff --git a/include/hw/block/swim.h b/include/hw/block/swim.h
index 9b3dcb029d..1bc7635d02 100644
--- a/include/hw/block/swim.h
+++ b/include/hw/block/swim.h
@@ -43,23 +43,18 @@ typedef struct FDrive {
 } FDrive;
 
 struct SWIMCtrl {
-    MemoryRegion iomem;
+    MemoryRegion swim;
+    MemoryRegion iwm;
+    MemoryRegion ism;
     FDrive drives[SWIM_MAX_FD];
     int mode;
     /* IWM mode */
     int iwm_switch;
-    uint16_t regs[8];
-#define IWM_PH0   0
-#define IWM_PH1   1
-#define IWM_PH2   2
-#define IWM_PH3   3
-#define IWM_MTR   4
-#define IWM_DRIVE 5
-#define IWM_Q6    6
-#define IWM_Q7    7
+    uint8_t iwmregs[16];
     uint8_t iwm_data;
     uint8_t iwm_mode;
     /* SWIM mode */
+    uint8_t ismregs[16];
     uint8_t swim_phase;
     uint8_t swim_mode;
     SWIMBus bus;
-- 
2.39.2


