Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FC071807E
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 14:56:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4LM5-0007vn-Po; Wed, 31 May 2023 08:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LM3-0007nl-Kd
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:55:07 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LM1-00074J-LJ
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Zvlhs1WBtWVGhsyV0ky1JlNOr/YczcfNIQsMr2JJW20=; b=SsqD0MQL+sUU594KH8hEwh/eo/
 Sn2VC7XNlz3WBhOa7AXSHf/G1ZNcnbbrh9D8x7BlP+0M1SQA9Wb18iuxr48DmefidTJEA0hWpUPu2
 Ta5/TGbtpB1i/67OGrKThBImhg5Wk+zZw/tMB76QJJQcngewAEoq/n2Wn0pG0P2pSGWqMFH9CfI7o
 bZeROGJsXcHIOlte4p/DmyYUngN4lUC03u1KFTv9zSU6UodEiAo+B4NHU0ugfZDtPZJjf3sRTVRjk
 NZ1LfumUcPp6/WA3BeKV7IEaj77hdHmjtKYXVjQvPU/ueT8VoErE1fUWOT7yH7aJyH95Qzg/zrdPy
 ymhEG9CDKDlQNxxNLX2TCyGw8/ws0PfVUIniNkRl9hcEvdSDejIN1uP4SE/1pPAwNhFcBiQUoceQ6
 TsjNnw6GJINxUPypDf/0wYZJi5J189v+hzns5QZM8Pba27Z9i0ZiAQF2G+3xMNmtcU1CxJyiw7cfz
 jemRGBDAa0MV7ROHBtF3s+gcinQzNRECvU0kIt9vSiTvAIDhrvcH69Z2Wv4ZtcGgM7TGUhu1q5xN4
 NeZpBuPP35+pmvusp9YXDYRiz/MLC0OBuF1F2Y0Xiiza3MLN+amghn1F38lEYtQgDlGP8/YkAgSrN
 guT79ZhC+pUx9UGvQo34XjMHx+M0Nneo1mtx3Yjg4=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LLr-0008vd-Qz; Wed, 31 May 2023 13:54:59 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 May 2023 13:53:50 +0100
Message-Id: <20230531125400.288917-14-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 13/23] hw/net/dp8393x.c: move TYPE_DP8393X and dp8393xState
 into dp8393x.h
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

This is to enable them to be used outside of dp8393x.c.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
CC: Jason Wang <jasowang@redhat.com>
---
 hw/net/dp8393x.c         | 32 +--------------------
 include/hw/net/dp8393x.h | 60 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 31 deletions(-)
 create mode 100644 include/hw/net/dp8393x.h

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 45b954e46c..a596f7fbc6 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
+#include "hw/net/dp8393x.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
@@ -85,7 +86,6 @@ static const char *reg_names[] = {
 #define SONIC_MPT    0x2e
 #define SONIC_MDT    0x2f
 #define SONIC_DCR2   0x3f
-#define SONIC_REG_COUNT  0x40
 
 #define SONIC_CR_HTX     0x0001
 #define SONIC_CR_TXP     0x0002
@@ -139,36 +139,6 @@ static const char *reg_names[] = {
 #define SONIC_DESC_EOL   0x0001
 #define SONIC_DESC_ADDR  0xFFFE
 
-#define TYPE_DP8393X "dp8393x"
-OBJECT_DECLARE_SIMPLE_TYPE(dp8393xState, DP8393X)
-
-struct dp8393xState {
-    SysBusDevice parent_obj;
-
-    /* Hardware */
-    uint8_t it_shift;
-    bool big_endian;
-    bool last_rba_is_full;
-    qemu_irq irq;
-    int irq_level;
-    QEMUTimer *watchdog;
-    int64_t wt_last_update;
-    NICConf conf;
-    NICState *nic;
-    MemoryRegion mmio;
-
-    /* Registers */
-    uint16_t cam[16][3];
-    uint16_t regs[SONIC_REG_COUNT];
-
-    /* Temporaries */
-    uint8_t tx_buffer[0x10000];
-    int loopback_packet;
-
-    /* Memory access */
-    MemoryRegion *dma_mr;
-    AddressSpace as;
-};
 
 /*
  * Accessor functions for values which are formed by
diff --git a/include/hw/net/dp8393x.h b/include/hw/net/dp8393x.h
new file mode 100644
index 0000000000..bb5f0ced5a
--- /dev/null
+++ b/include/hw/net/dp8393x.h
@@ -0,0 +1,60 @@
+/*
+ * QEMU NS SONIC DP8393x netcard
+ *
+ * Copyright (c) 2008-2009 Herve Poussineau
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_NET_DP8393X_H
+#define HW_NET_DP8393X_H
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "net/net.h"
+
+#define SONIC_REG_COUNT  0x40
+
+#define TYPE_DP8393X "dp8393x"
+OBJECT_DECLARE_SIMPLE_TYPE(dp8393xState, DP8393X)
+
+struct dp8393xState {
+    SysBusDevice parent_obj;
+
+    /* Hardware */
+    uint8_t it_shift;
+    bool big_endian;
+    bool last_rba_is_full;
+    qemu_irq irq;
+    int irq_level;
+    QEMUTimer *watchdog;
+    int64_t wt_last_update;
+    NICConf conf;
+    NICState *nic;
+    MemoryRegion mmio;
+
+    /* Registers */
+    uint16_t cam[16][3];
+    uint16_t regs[SONIC_REG_COUNT];
+
+    /* Temporaries */
+    uint8_t tx_buffer[0x10000];
+    int loopback_packet;
+
+    /* Memory access */
+    MemoryRegion *dma_mr;
+    AddressSpace as;
+};
+
+#endif
-- 
2.30.2


