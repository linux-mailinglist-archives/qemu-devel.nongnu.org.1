Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB519F285F
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Dec 2024 03:07:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN0V5-0007fv-Um; Sun, 15 Dec 2024 21:06:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tN0V0-0007dw-7x
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 21:06:18 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tN0Uy-00013o-0b
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 21:06:18 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Dx2uETi19nY0FXAA--.41947S3;
 Mon, 16 Dec 2024 10:06:11 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAxlsAOi19nPtKEAA--.15339S5;
 Mon, 16 Dec 2024 10:06:09 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 18/18] hw/intc/loongarch_extioi: Code cleanup about
 loongarch_extioi
Date: Mon, 16 Dec 2024 10:06:04 +0800
Message-Id: <20241216020604.1810588-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241216020604.1810588-1-maobibo@loongson.cn>
References: <20241216015607.1795880-1-maobibo@loongson.cn>
 <20241216020604.1810588-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxlsAOi19nPtKEAA--.15339S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Remove definition about LoongArchExtIOI and LOONGARCH_EXTIOI, and
replace them with LoongArchExtIOICommonState and macro
LOONGARCH_EXTIOI_COMMON separately. Also remove unnecessary header
files.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_extioi.c         | 31 ++++++++++++++----------------
 include/hw/intc/loongarch_extioi.h |  2 --
 2 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index ee8a1817de..a026e06ad6 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -10,16 +10,13 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "hw/irq.h"
-#include "hw/sysbus.h"
 #include "hw/loongarch/virt.h"
-#include "hw/qdev-properties.h"
 #include "exec/address-spaces.h"
 #include "hw/intc/loongarch_extioi.h"
-#include "migration/vmstate.h"
 #include "trace.h"
 
 
-static void extioi_update_irq(LoongArchExtIOI *s, int irq, int level)
+static void extioi_update_irq(LoongArchExtIOICommonState *s, int irq, int level)
 {
     int ipnum, cpu, found, irq_index, irq_mask;
 
@@ -54,7 +51,7 @@ static void extioi_update_irq(LoongArchExtIOI *s, int irq, int level)
 
 static void extioi_setirq(void *opaque, int irq, int level)
 {
-    LoongArchExtIOI *s = LOONGARCH_EXTIOI(opaque);
+    LoongArchExtIOICommonState *s = LOONGARCH_EXTIOI_COMMON(opaque);
     trace_loongarch_extioi_setirq(irq, level);
     if (level) {
         set_bit32(irq, s->isr);
@@ -67,7 +64,7 @@ static void extioi_setirq(void *opaque, int irq, int level)
 static MemTxResult extioi_readw(void *opaque, hwaddr addr, uint64_t *data,
                                 unsigned size, MemTxAttrs attrs)
 {
-    LoongArchExtIOI *s = LOONGARCH_EXTIOI(opaque);
+    LoongArchExtIOICommonState *s = LOONGARCH_EXTIOI_COMMON(opaque);
     unsigned long offset = addr & 0xffff;
     uint32_t index, cpu;
 
@@ -106,7 +103,7 @@ static MemTxResult extioi_readw(void *opaque, hwaddr addr, uint64_t *data,
     return MEMTX_OK;
 }
 
-static inline void extioi_enable_irq(LoongArchExtIOI *s, int index,\
+static inline void extioi_enable_irq(LoongArchExtIOICommonState *s, int index,\
                                      uint32_t mask, int level)
 {
     uint32_t val;
@@ -125,8 +122,8 @@ static inline void extioi_enable_irq(LoongArchExtIOI *s, int index,\
     }
 }
 
-static inline void extioi_update_sw_coremap(LoongArchExtIOI *s, int irq,
-                                            uint64_t val, bool notify)
+static inline void extioi_update_sw_coremap(LoongArchExtIOICommonState *s,
+                                            int irq, uint64_t val, bool notify)
 {
     int i, cpu;
 
@@ -162,8 +159,8 @@ static inline void extioi_update_sw_coremap(LoongArchExtIOI *s, int irq,
     }
 }
 
-static inline void extioi_update_sw_ipmap(LoongArchExtIOI *s, int index,
-                                          uint64_t val)
+static inline void extioi_update_sw_ipmap(LoongArchExtIOICommonState *s,
+                                          int index, uint64_t val)
 {
     int i;
     uint8_t ipnum;
@@ -186,7 +183,7 @@ static MemTxResult extioi_writew(void *opaque, hwaddr addr,
                           uint64_t val, unsigned size,
                           MemTxAttrs attrs)
 {
-    LoongArchExtIOI *s = LOONGARCH_EXTIOI(opaque);
+    LoongArchExtIOICommonState *s = LOONGARCH_EXTIOI_COMMON(opaque);
     int cpu, index, old_data, irq;
     uint32_t offset;
 
@@ -266,7 +263,7 @@ static const MemoryRegionOps extioi_ops = {
 static MemTxResult extioi_virt_readw(void *opaque, hwaddr addr, uint64_t *data,
                                      unsigned size, MemTxAttrs attrs)
 {
-    LoongArchExtIOI *s = LOONGARCH_EXTIOI(opaque);
+    LoongArchExtIOICommonState *s = LOONGARCH_EXTIOI_COMMON(opaque);
 
     switch (addr) {
     case EXTIOI_VIRT_FEATURES:
@@ -286,7 +283,7 @@ static MemTxResult extioi_virt_writew(void *opaque, hwaddr addr,
                           uint64_t val, unsigned size,
                           MemTxAttrs attrs)
 {
-    LoongArchExtIOI *s = LOONGARCH_EXTIOI(opaque);
+    LoongArchExtIOICommonState *s = LOONGARCH_EXTIOI_COMMON(opaque);
 
     switch (addr) {
     case EXTIOI_VIRT_FEATURES:
@@ -365,21 +362,21 @@ static void loongarch_extioi_realize(DeviceState *dev, Error **errp)
 
 static void loongarch_extioi_unrealize(DeviceState *dev)
 {
-    LoongArchExtIOICommonState *s = LOONGARCH_EXTIOI(dev);
+    LoongArchExtIOICommonState *s = LOONGARCH_EXTIOI_COMMON(dev);
 
     g_free(s->cpu);
 }
 
 static void loongarch_extioi_reset(DeviceState *d)
 {
-    LoongArchExtIOI *s = LOONGARCH_EXTIOI(d);
+    LoongArchExtIOICommonState *s = LOONGARCH_EXTIOI_COMMON(d);
 
     s->status = 0;
 }
 
 static int vmstate_extioi_post_load(void *opaque, int version_id)
 {
-    LoongArchExtIOI *s = LOONGARCH_EXTIOI(opaque);
+    LoongArchExtIOICommonState *s = LOONGARCH_EXTIOI_COMMON(opaque);
     int i, start_irq;
 
     for (i = 0; i < (EXTIOI_IRQS / 4); i++) {
diff --git a/include/hw/intc/loongarch_extioi.h b/include/hw/intc/loongarch_extioi.h
index cc160c52dc..351f18afcf 100644
--- a/include/hw/intc/loongarch_extioi.h
+++ b/include/hw/intc/loongarch_extioi.h
@@ -24,6 +24,4 @@ struct LoongArchExtIOIClass {
     DeviceUnrealize parent_unrealize;
 };
 
-#define LoongArchExtIOI         LoongArchExtIOICommonState
-#define LOONGARCH_EXTIOI(obj)   ((LoongArchExtIOICommonState *)obj)
 #endif /* LOONGARCH_EXTIOI_H */
-- 
2.43.5


