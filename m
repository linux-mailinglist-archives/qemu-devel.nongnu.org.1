Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDAE7BCCA6
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 08:27:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpNCy-00088c-3e; Sun, 08 Oct 2023 02:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCu-00086j-8D
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:24:04 -0400
Received: from mout.kundenserver.de ([212.227.17.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCs-0007mx-6D
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:24:03 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1Mdv2u-1rPGBd1hzS-00b4Fa; Sun, 08
 Oct 2023 08:23:59 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 12/20] swim: split into separate IWM and ISM register blocks
Date: Sun,  8 Oct 2023 08:23:41 +0200
Message-ID: <20231008062349.2733552-13-laurent@vivier.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231008062349.2733552-1-laurent@vivier.eu>
References: <20231008062349.2733552-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:t3HIZh8jiXfosNAjs4CGjOMQvKCrdJfoGKJ8r94IfcaHDDCD2c0
 hZTkhXHsUuDL2ugOnDT+i1nvh82X+AtV7/uVpyFKb31xP8Sbux5Yce1tq2ei3nqvb8egEnp
 B6NtVpVfo4h+rXXFDM+JHIvhK2sHAGj+Qk/B4Y5GkrFM/VVtjlljGRi5BGgx5UfIQqlmtld
 vVn15Ehja4W4dhL0JNBWA==
UI-OutboundReport: notjunk:1;M01:P0:aRYgWmEI1yA=;aGQ99OSg8RJmhjFs7DhHLUSAMgr
 EUgMEAtRnZB90jpkMG/uvR6MF9IO4bAzzdWj9Iq/Zn/4qLCszwyhDU0RHd6+YtOYMMU746ac8
 EXWRIrhaoicwYoLBLa7GUbXm1aApy2pCx1xwJleBXE5tMCyN2Dj9c6Zj2G5hOl0jbb4CRv8x7
 GEDHE2+blNzf8xdT99rN+5Rvr7xUT7G/U0aUSylUonzv0XeoJunMnybWv+V54WYfFQL15DhY9
 QGU3gTHlUxHhIyRbBKki00jKR82IIlZ1JQbaJPRkl/JjHHsuq1OoZ+avO2LwdXlWd49x5kyJ2
 fruZGF3biWuVlCdGuSK5wRPVARXllqyQXxPuDXVhGCHnLKcy6AAcPDcVL3tH/90Ap/PvQkh7O
 b44kigHCD8Zuk3dR8H4qT2qt8yqy7lPdszPe24YRNVB+1ecnfivEu6iIBi6CbDjccu0P6ckfA
 hgPUH1uOjP0NyHsPJplwVT2t2KklAxTDH6DR/WmK/R58s2ycoirYTZHyHjM5NCJTLkmHuFiHe
 wgp7HUAWBq+7HGcUJIuPukOfq+uk3eOCIBAUZwUUZkx8U2XnoyRthWUUv00pdWJfZkAL+lkFA
 VAMPtB3O44+aKK0OJYJKmMqEFWUCYFYQ1OAbrP2s3Kgs3m4Rtb13qZ8CpfeAO8LPB6a4diMEX
 66USa3xtIKTquAGHSVRipzpUYoSz+vC0kLuI0HJyW5sLdgUMZ50QQpeJrGxIV74bobpvK158O
 jyysAGBxonQPt/owQSdPuxMXv4PzNk+j1aEvvFnIvpUVhGjlZuETRshbD1B6OAtgByHv0XwKg
 YamsJcWJMSVu8A5a0t6O+NHPDnfDAflL75CPHZ8vxvddJOjIC5AijSdP15DwXa6jHT7ONh3bl
 Q7kjuq58WbU72fHke6rxTDW6yBEkGxefXJQM=
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

The swim chip provides an implementation of both Apple's IWM and ISM floppy disk
controllers. Split the existing implementation into separate register banks for
each controller, whilst also switching the IWM registers from 16-bit to 8-bit
as implemented in real hardware.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20231004083806.757242-13-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/block/swim.h | 15 +++-----
 hw/block/swim.c         | 85 ++++++++++++++++++++++++-----------------
 hw/block/trace-events   |  4 +-
 3 files changed, 58 insertions(+), 46 deletions(-)

diff --git a/include/hw/block/swim.h b/include/hw/block/swim.h
index 9b3dcb029d3f..1bc7635d0212 100644
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
diff --git a/hw/block/swim.c b/hw/block/swim.c
index 7df36ea139cb..505718bdae3f 100644
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
+    uint8_t value;
 
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
index c041ec45e312..ea84ad6c77ed 100644
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
-- 
2.41.0


