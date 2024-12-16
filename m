Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DEC9F284C
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Dec 2024 02:58:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN0Ld-0006KY-3K; Sun, 15 Dec 2024 20:56:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tN0LZ-0006Jx-Mg
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 20:56:34 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tN0LS-0007no-4R
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 20:56:32 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxyuDHiF9njUBXAA--.38243S3;
 Mon, 16 Dec 2024 09:56:23 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAxnsK3iF9nKNCEAA--.50112S12;
 Mon, 16 Dec 2024 09:56:23 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 10/18] include: Move struct LoongArchExtIOI to header file
 loongarch_extioi_common
Date: Mon, 16 Dec 2024 09:55:59 +0800
Message-Id: <20241216015607.1795880-11-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241216015607.1795880-1-maobibo@loongson.cn>
References: <20241216015607.1795880-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxnsK3iF9nKNCEAA--.50112S12
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

Move definiton of structure LoongArchExtIOI from header file loongarch_extioi.h
to file loongarch_extioi_common.h.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 include/hw/intc/loongarch_extioi.h        | 26 ----------------------
 include/hw/intc/loongarch_extioi_common.h | 27 +++++++++++++++++++++++
 2 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/include/hw/intc/loongarch_extioi.h b/include/hw/intc/loongarch_extioi.h
index b1f87cd246..64924f5a0a 100644
--- a/include/hw/intc/loongarch_extioi.h
+++ b/include/hw/intc/loongarch_extioi.h
@@ -10,32 +10,6 @@
 
 #include "hw/intc/loongarch_extioi_common.h"
 
-typedef struct ExtIOICore {
-    uint32_t coreisr[EXTIOI_IRQS_GROUP_COUNT];
-    DECLARE_BITMAP(sw_isr[LS3A_INTC_IP], EXTIOI_IRQS);
-    qemu_irq parent_irq[LS3A_INTC_IP];
-} ExtIOICore;
-
 #define TYPE_LOONGARCH_EXTIOI "loongarch.extioi"
 OBJECT_DECLARE_SIMPLE_TYPE(LoongArchExtIOI, LOONGARCH_EXTIOI)
-struct LoongArchExtIOI {
-    SysBusDevice parent_obj;
-    uint32_t num_cpu;
-    uint32_t features;
-    uint32_t status;
-    /* hardware state */
-    uint32_t nodetype[EXTIOI_IRQS_NODETYPE_COUNT / 2];
-    uint32_t bounce[EXTIOI_IRQS_GROUP_COUNT];
-    uint32_t isr[EXTIOI_IRQS / 32];
-    uint32_t enable[EXTIOI_IRQS / 32];
-    uint32_t ipmap[EXTIOI_IRQS_IPMAP_SIZE / 4];
-    uint32_t coremap[EXTIOI_IRQS / 4];
-    uint32_t sw_pending[EXTIOI_IRQS / 32];
-    uint8_t  sw_ipmap[EXTIOI_IRQS_IPMAP_SIZE];
-    uint8_t  sw_coremap[EXTIOI_IRQS];
-    qemu_irq irq[EXTIOI_IRQS];
-    ExtIOICore *cpu;
-    MemoryRegion extioi_system_mem;
-    MemoryRegion virt_extend;
-};
 #endif /* LOONGARCH_EXTIOI_H */
diff --git a/include/hw/intc/loongarch_extioi_common.h b/include/hw/intc/loongarch_extioi_common.h
index 09e2b760f3..1eb8780549 100644
--- a/include/hw/intc/loongarch_extioi_common.h
+++ b/include/hw/intc/loongarch_extioi_common.h
@@ -55,4 +55,31 @@
 #define  EXTIOI_ENABLE_CPU_ENCODE    (3)
 #define EXTIOI_VIRT_COREMAP_START    (0x40)
 #define EXTIOI_VIRT_COREMAP_END      (0x240)
+
+typedef struct ExtIOICore {
+    uint32_t coreisr[EXTIOI_IRQS_GROUP_COUNT];
+    DECLARE_BITMAP(sw_isr[LS3A_INTC_IP], EXTIOI_IRQS);
+    qemu_irq parent_irq[LS3A_INTC_IP];
+} ExtIOICore;
+
+struct LoongArchExtIOI {
+    SysBusDevice parent_obj;
+    uint32_t num_cpu;
+    uint32_t features;
+    uint32_t status;
+    /* hardware state */
+    uint32_t nodetype[EXTIOI_IRQS_NODETYPE_COUNT / 2];
+    uint32_t bounce[EXTIOI_IRQS_GROUP_COUNT];
+    uint32_t isr[EXTIOI_IRQS / 32];
+    uint32_t enable[EXTIOI_IRQS / 32];
+    uint32_t ipmap[EXTIOI_IRQS_IPMAP_SIZE / 4];
+    uint32_t coremap[EXTIOI_IRQS / 4];
+    uint32_t sw_pending[EXTIOI_IRQS / 32];
+    uint8_t  sw_ipmap[EXTIOI_IRQS_IPMAP_SIZE];
+    uint8_t  sw_coremap[EXTIOI_IRQS];
+    qemu_irq irq[EXTIOI_IRQS];
+    ExtIOICore *cpu;
+    MemoryRegion extioi_system_mem;
+    MemoryRegion virt_extend;
+};
 #endif /* LOONGARCH_EXTIOI_H */
-- 
2.43.5


