Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A152F7B3985
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 20:02:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmHml-00032Y-PS; Fri, 29 Sep 2023 14:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qmHmi-00031k-Qa
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 14:00:17 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qmHmh-0005fa-AT
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 14:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EeJUdGQriujDLVWAuyFisLNH+ZEjrZeVSKeIvh0lhw8=; b=f84w9WSQ9ZClWRa7qWSxLzdnEZ
 KRdjMc1zS//DsuBTyUFXh/86SOj0p4Npn45//huPnwfibcZyJjluuDxjsy5p6/lLFr7xAitLmPDfl
 lDPXkG6cLzdWbuw2nHBoe7NMh1n0k2OvOxiM9AHh6T/KRa0Xy4gQ4b4bOGaEHKwQ1QDxbOe52XrHy
 ho7tpmkShB3yP1i62Lbify9EbdClqLDiBKxNyGr8sD2NIMPrVvi8pPAfzvLajH76Z4TQo4NKxOPP+
 FVXkF+dWpc7qI6a+X+wR4HX1Ev9QVOhJsUeEORoWb0ljRW5TDoTjP+yy+IbezpbR6cPhgSrb8cBem
 SOW3vecnDAr+XkU2NiY7pXjaHB2+PsWVqwuhS4pGVLZ6eiX7XOnUUKK60dcm2EdTvCBZmWaFdaeOW
 mXQXPESHUjV92o4h5F1vqYk3wLJ4Wdyr47G17SkuhQ0c36tfqlVOEivse4Ofw1L2c/9V21iuJvSBc
 QogAWgVRgr9WzwQf88ox8I//G4cw1H6hLkEpwnkC7/yurGOuzWObQQHujXzoMMyJemC7JuIEmKrCm
 ZmPgsSR8fQ8t1+N4iOBqZcJ/fFB6JzJ4lMBRC/Rz8u84/4o+IhE6il0ojE01pmmzM45L3egPtiWTz
 je94GPsBWsPmfro/kq+Suj8lX5UiGlR6G84fkjar4=;
Received: from [2a00:23c4:8baf:5f00:c237:5189:8121:f752]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qmHmX-00033Y-G2; Fri, 29 Sep 2023 19:00:06 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Fri, 29 Sep 2023 18:59:08 +0100
Message-Id: <20230929175917.511133-12-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230929175917.511133-1-mark.cave-ayland@ilande.co.uk>
References: <20230929175917.511133-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:5f00:c237:5189:8121:f752
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 11/20] swim: add trace events for IWM and ISM registers
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

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/block/swim.c       | 14 ++++++++++++++
 hw/block/trace-events |  7 +++++++
 2 files changed, 21 insertions(+)

diff --git a/hw/block/swim.c b/hw/block/swim.c
index 333da08ce0..7df36ea139 100644
--- a/hw/block/swim.c
+++ b/hw/block/swim.c
@@ -19,6 +19,7 @@
 #include "hw/block/block.h"
 #include "hw/block/swim.h"
 #include "hw/qdev-properties.h"
+#include "trace.h"
 
 /* IWM registers */
 
@@ -125,6 +126,13 @@
 #define SWIM_HEDSEL          0x20
 #define SWIM_MOTON           0x80
 
+static const char *swim_reg_names[] = {
+    "WRITE_DATA", "WRITE_MARK", "WRITE_CRC", "WRITE_PARAMETER",
+    "WRITE_PHASE", "WRITE_SETUP", "WRITE_MODE0", "WRITE_MODE1",
+    "READ_DATA", "READ_MARK", "READ_ERROR", "READ_PARAMETER",
+    "READ_PHASE", "READ_SETUP", "READ_STATUS", "READ_HANDSHAKE"
+};
+
 static void fd_recalibrate(FDrive *drive)
 {
 }
@@ -267,6 +275,7 @@ static void iwmctrl_write(void *opaque, hwaddr reg, uint64_t value,
     reg >>= REG_SHIFT;
 
     swimctrl->regs[reg >> 1] = reg & 1;
+    trace_swim_iwmctrl_write((reg >> 1), size, (reg & 1));
 
     if (swimctrl->regs[IWM_Q6] &&
         swimctrl->regs[IWM_Q7]) {
@@ -297,6 +306,7 @@ static void iwmctrl_write(void *opaque, hwaddr reg, uint64_t value,
                 if (value == 0x57) {
                     swimctrl->mode = SWIM_MODE_SWIM;
                     swimctrl->iwm_switch = 0;
+                    trace_swim_iwm_switch();
                 }
                 break;
             }
@@ -312,6 +322,7 @@ static uint64_t iwmctrl_read(void *opaque, hwaddr reg, unsigned size)
 
     swimctrl->regs[reg >> 1] = reg & 1;
 
+    trace_swim_iwmctrl_read((reg >> 1), size, (reg & 1));
     return 0;
 }
 
@@ -327,6 +338,8 @@ static void swimctrl_write(void *opaque, hwaddr reg, uint64_t value,
 
     reg >>= REG_SHIFT;
 
+    trace_swim_swimctrl_write(reg, swim_reg_names[reg], size, value);
+
     switch (reg) {
     case SWIM_WRITE_PHASE:
         swimctrl->swim_phase = value;
@@ -376,6 +389,7 @@ static uint64_t swimctrl_read(void *opaque, hwaddr reg, unsigned size)
         break;
     }
 
+    trace_swim_swimctrl_read(reg, swim_reg_names[reg], size, value);
     return value;
 }
 
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 34be8b9135..c041ec45e3 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -90,3 +90,10 @@ m25p80_read_data(void *s, uint32_t pos, uint8_t v) "[%p] Read data 0x%"PRIx32"=0
 m25p80_read_sfdp(void *s, uint32_t addr, uint8_t v) "[%p] Read SFDP 0x%"PRIx32"=0x%"PRIx8
 m25p80_binding(void *s) "[%p] Binding to IF_MTD drive"
 m25p80_binding_no_bdrv(void *s) "[%p] No BDRV - binding to RAM"
+
+# swim.c
+swim_swimctrl_read(int reg, const char *name, unsigned size, uint64_t value) "reg=%d [%s] size=%u value=0x%"PRIx64
+swim_swimctrl_write(int reg, const char *name, unsigned size, uint64_t value) "reg=%d [%s] size=%u value=0x%"PRIx64
+swim_iwmctrl_read(int reg, unsigned size, uint64_t value) "reg=%d size=%u value=0x%"PRIx64
+swim_iwmctrl_write(int reg, unsigned size, uint64_t value) "reg=%d size=%u value=0x%"PRIx64
+swim_iwm_switch(void) "switch from IWM to SWIM mode"
-- 
2.39.2


