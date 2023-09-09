Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D6279972D
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 11:50:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeuaf-0005ll-HL; Sat, 09 Sep 2023 05:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeuae-0005lX-DX
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 05:49:20 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeuac-0005JZ-8v
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 05:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=e+TFyl/x3mQZsVq9AQxMGapSl+70nAtCCqG6ZhHuuVY=; b=kuuu0WMSFvBtSyjr62ohQALs/S
 hoMbeK8dv4aG6Ta9ui/w6vgQ/02wkPXYY8PE5uHzSkZNfiZ9Eu+DoaamXsCQEmf4N7oB0k3ymy4U/
 /vJHrLbSrXcwPh4Y6Tvumc81GMjOzQqaXDtvvH+Qwdusf9psEovKo3oObaLktRJrRI4bNtjVchC90
 9JicMqvNdh8V6y70bMxhTmcHWYtqPCGkfWcyvLQawf+Q9osxmzgPPYLyt6984AmeWmMSvSqJCHYvH
 +4AIeZI82dH+UiVyYyu2EORW6MH4MJRA104vSuASvG4TOxTCVUoOGW7lxqJUl5G9fXiUdCUrXzUtm
 UHSweupdX5VtEe+1J4hams35WpWMBiHcfzQC8NZ4slygtkEfpA/tsEiZn0fldAOVCnUWbSy7BsnGC
 wlwO26rIZG468eByfdvVfHxyHBHV9v7KvCT3CCoeD+Ut4JWWCu1pLkJifposOTfcBZ2/HylscwCht
 tXkqt8/9YN0sAGuBNM5mx/yhu5nqIKBmTsJsCrg9C2m4PGKslxfmU08SJKXpUZzvGNUFXpFFR1EQw
 4grIBh1oRl+6h3l1DVIcGn52K9bYapy8r21o7lotGbIQj5NVoA4MBZyzQbI13fw0M5KxP9TtwT8ZB
 fDLFtEGKK0F9uaflOTi3/D+UB8Nq/ncWSQsDL6bxs=;
Received: from [2a00:23c4:8baf:5f00:e007:7058:31bc:5be9]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeuaZ-0000uO-Nv; Sat, 09 Sep 2023 10:49:16 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sat,  9 Sep 2023 10:48:18 +0100
Message-Id: <20230909094827.33871-12-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
References: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:5f00:e007:7058:31bc:5be9
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 11/20] swim: add trace events for IWM and ISM registers
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


