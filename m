Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FFB7BCC99
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 08:25:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpNCv-000870-At; Sun, 08 Oct 2023 02:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCt-00086C-0k
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:24:03 -0400
Received: from mout.kundenserver.de ([217.72.192.73])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCq-0007mX-Ae
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:24:02 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MulVd-1rfxgz2d99-00rled; Sun, 08
 Oct 2023 08:23:58 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 11/20] swim: add trace events for IWM and ISM registers
Date: Sun,  8 Oct 2023 08:23:40 +0200
Message-ID: <20231008062349.2733552-12-laurent@vivier.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231008062349.2733552-1-laurent@vivier.eu>
References: <20231008062349.2733552-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Ovk+qe9uRj8XUgrVgV6Z2NUaSWC6x19RWRnuw8w14KsDpS7yTcq
 UJbFCsOETCr4NMDoThYfscnnypLW7lVkjAat/plx2FLfpl4pNWeDpfDRL0QeoVJy2xNpUj9
 hWWqibWJbK7kEz0reyrFJuB6kU2IadPcvfk4uvDHBQ8M4LLIK6bMo1dDXVdZr1wjqEqK5o1
 lqMvkl79gBqnkWBYHihAA==
UI-OutboundReport: notjunk:1;M01:P0:jxvfbnT7NRk=;vRL6d9Pjut06vvQ9Pz/35S4Afjc
 UAsV1w6PpPAPSgL2EfYNJEy12/Y51W9/i3Q+OttjJVAHc+JYlxm47XON9mKEw7sP81sVtp+xr
 MD2Svxx/FXsq4MWcz1/SkPxmvtnPpsdw6AXv1ExIc1YH21AHvXPXOjMNM5cfNZPwdPAGoKkNY
 VEGmgmj2HMezk9Vluub4S8MU6dPbb35I5xZ37ASHMiVKOOtHS20EWA0t3KC3zTFfFAokJH8QA
 Di2VBiAejwWVtn0Z6dLACtD+qs4D+3hXb/eSg3/wbnwPqdxNSZjCSKJqc/vwQcKM2f2sOaafd
 //E37UBuWrTdt6YDH+np/9dH6GtmGBPCdTnrYOG46JuascMGQYMXtPX8Vrwa3/kuCMQMWkNF7
 maorWCzdm/085kT8Vs4u/V+v84rLw9zdgJbeNOAuohQhwBZJCcEko2+eDJ11JH4W4Cb8KNHQC
 fNUOVRhxctMWx0DsKZA4APjQ0Rmzhqq5BfB09lyf5y1N+QaLX5nvIBM+rNXzN6/Gqd7VycuhA
 LCG6SnJuIJ7TNvJ8Fglusdbb0DyNOoCE6VEEmLMps1wAlEeAoSlmzdSLhqd6ehodskQZyqk7t
 T5N5/oNrd7DlNx4BV4kKgVJFvMT1PMjjuvo9YaImcEW92lP9kW92vG1c8NwvLyCWXD9WPT1cB
 SURjTbvAtsbABsvlT69t1zRwOONrCqQpQzWGBxTu9yt+VWRpRphAc3n3OWoD9UDbHZLTi0y+6
 fsKIQh2FFkpUjzsZUoMDkHnWbqgySD89K7DWdmJBABYwBwdcvIHjDEwaNaqGlkyYPduGRhBC2
 1MZl9D0e0sfI1D8FbpPYuInS2DlzK67SxsS3vYObu6+4mSM5UD+gWo7aywufd3jAeRqIk2uv0
 XC/Vn7Mf2z+0diQ==
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

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20231004083806.757242-12-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/block/swim.c       | 14 ++++++++++++++
 hw/block/trace-events |  7 +++++++
 2 files changed, 21 insertions(+)

diff --git a/hw/block/swim.c b/hw/block/swim.c
index 333da08ce093..7df36ea139cb 100644
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
index 34be8b9135f5..c041ec45e312 100644
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
2.41.0


