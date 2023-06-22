Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B62277398A4
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 09:57:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCFBG-0004Kc-KJ; Thu, 22 Jun 2023 03:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAh-00045D-Lk
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:03 -0400
Received: from mout.kundenserver.de ([212.227.126.135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAb-0002tb-8Q
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:03 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mt7Ll-1pwM6q1ByT-00tThP; Thu, 22
 Jun 2023 09:55:53 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/24] hw/net/dp8393x.c: move TYPE_DP8393X and dp8393xState
 into dp8393x.h
Date: Thu, 22 Jun 2023 09:55:34 +0200
Message-Id: <20230622075544.210899-15-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622075544.210899-1-laurent@vivier.eu>
References: <20230622075544.210899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1T4D7+cQF0AZh1hCu2lG2G5Y4znKuhOiDIqLUajZx5MBmHYkoyJ
 NYa6gFlbutUqYqTvhKfIgieIl/SBajTaaCo1GTpiWbBDDLn6OpE1d4H9slTvyd2EsRzI3zk
 zRmgaulvi2BCYl6DbF9lLLzBRJzB6q9tFI0WzypX5sIlN6cbUHFnQXrJT/64AET65dMecfw
 blkLqyzqiyCMdhfYFJXhA==
UI-OutboundReport: notjunk:1;M01:P0:NVAFAlkA6F4=;Ewq8B3oi2KKeXILtjY4/nGX3Ea5
 nx5GuHJXJWc7J9BeEqz0lj4gbqlQmBnHMv5/ezBgHclEo52oSLYfD7JjEECVvdj1Z/aZkbG3Q
 TDVvND2qBVrTQCTNNwbmGXNRvnl+jdb5Qz/RaSNl+kgZE/5qKuLgUlrjvoqvMf684lw9yOpz4
 5enHkkcxCgiVRu7i5QNWAv3U9W6kghYJ8hPWS7QpvrX8u+dvIEl/Wkuk7zxO5ymo7D5HJ6Nf4
 8q7Zoykylqrq8IZSTQahTlbGngWMnhB6v9jmvOnt8TjRF2yol5EvX8NtI0/b/rBRaEj+Dv4Zw
 WQpwd/RSyhjlFAfw3wm06UF6Q2kMg8t7puLxJQFZc4QgXds+vD2ZTJ31vBvgowR+GKta78amP
 KuXEIxjNU1HTYjwKPtw0jOF4FlJAmV46YE9Hl6c7HObGFYabraAKoEvg6TYK8aecM+7MjSBH3
 UhU7xUm9llq2T4G/y7LHz35DIKLeWWSWDQ63lgdecIsz3iW4t7Sgt0pkyrQYn3L40GBNha6Mr
 1l8yHHEOWar3uTZyVOsdZbed8LZjd+Qg6wRGposrdSdEjGOUSClAnHMuFWwXpE1Q79i7FUAiP
 /0w1UT54CXFaZnGxjVjPafr4mMdb4W2oVoBOMRImBO99BBwdxTjcoHyPz4ukEXp1k7fPgrbEi
 K3Erf+ScpoQ65njpYqZpf8bt4gdPaKyyKcFNVBEFFw==
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is to enable them to be used outside of dp8393x.c.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
CC: Jason Wang <jasowang@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230621085353.113233-15-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/net/dp8393x.h | 60 ++++++++++++++++++++++++++++++++++++++++
 hw/net/dp8393x.c         | 32 +--------------------
 2 files changed, 61 insertions(+), 31 deletions(-)
 create mode 100644 include/hw/net/dp8393x.h

diff --git a/include/hw/net/dp8393x.h b/include/hw/net/dp8393x.h
new file mode 100644
index 000000000000..4a3f7478be44
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
+#include "hw/sysbus.h"
+#include "net/net.h"
+#include "exec/memory.h"
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
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 45b954e46c25..a596f7fbc6b0 100644
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
-- 
2.40.1


