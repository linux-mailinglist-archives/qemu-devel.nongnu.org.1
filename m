Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B54FA1312B
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Jan 2025 03:19:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYFS3-0004cF-0q; Wed, 15 Jan 2025 21:17:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tYFRz-0004b7-M6
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 21:17:39 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tYFRv-0006Cc-VE
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 21:17:39 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxaeA9bIhnbzJkAA--.44720S3;
 Thu, 16 Jan 2025 10:17:33 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAx+8QnbIhnhWokAA--.14648S5;
 Thu, 16 Jan 2025 10:17:32 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PULL 3/8] hw/intc/loongson_ipi: Remove num_cpu from
 loongson_ipi_common
Date: Thu, 16 Jan 2025 10:17:05 +0800
Message-Id: <20250116021710.251648-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250116021710.251648-1-maobibo@loongson.cn>
References: <20250116021710.251648-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAx+8QnbIhnhWokAA--.14648S5
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

With mips64 loongson ipi, num_cpu property is used. With loongarch
ipi, num_cpu can be acquired from possible_cpu_arch_ids.

Here remove num_cpu setting from loongson_ipi_common, and this piece
of code is put into loongson and loongarch ipi separately.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_ipi.c       | 13 +++++++++++++
 hw/intc/loongson_ipi.c        | 14 +++++++++++++-
 hw/intc/loongson_ipi_common.c | 14 --------------
 3 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index 4e2f9acddf..e6126e4fbc 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -52,14 +52,27 @@ static CPUState *loongarch_cpu_by_arch_id(int64_t arch_id)
 
 static void loongarch_ipi_realize(DeviceState *dev, Error **errp)
 {
+    LoongsonIPICommonState *lics = LOONGSON_IPI_COMMON(dev);
     LoongarchIPIClass *lic = LOONGARCH_IPI_GET_CLASS(dev);
     Error *local_err = NULL;
+    int i;
 
     lic->parent_realize(dev, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
+
+    if (lics->num_cpu == 0) {
+        error_setg(errp, "num-cpu must be at least 1");
+        return;
+    }
+
+    lics->cpu = g_new0(IPICore, lics->num_cpu);
+    for (i = 0; i < lics->num_cpu; i++) {
+        lics->cpu[i].ipi = lics;
+        qdev_init_gpio_out(dev, &lics->cpu[i].irq, 1);
+    }
 }
 
 static void loongarch_ipi_class_init(ObjectClass *klass, void *data)
diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 4e08f03510..1ed39b90ea 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -36,6 +36,7 @@ static void loongson_ipi_realize(DeviceState *dev, Error **errp)
     LoongsonIPIClass *lic = LOONGSON_IPI_GET_CLASS(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     Error *local_err = NULL;
+    int i;
 
     lic->parent_realize(dev, &local_err);
     if (local_err) {
@@ -43,8 +44,19 @@ static void loongson_ipi_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (sc->num_cpu == 0) {
+        error_setg(errp, "num-cpu must be at least 1");
+        return;
+    }
+
+    sc->cpu = g_new0(IPICore, sc->num_cpu);
+    for (i = 0; i < sc->num_cpu; i++) {
+        sc->cpu[i].ipi = sc;
+        qdev_init_gpio_out(dev, &sc->cpu[i].irq, 1);
+    }
+
     s->ipi_mmio_mem = g_new0(MemoryRegion, sc->num_cpu);
-    for (unsigned i = 0; i < sc->num_cpu; i++) {
+    for (i = 0; i < sc->num_cpu; i++) {
         g_autofree char *name = g_strdup_printf("loongson_ipi_cpu%d_mmio", i);
 
         memory_region_init_io(&s->ipi_mmio_mem[i], OBJECT(dev),
diff --git a/hw/intc/loongson_ipi_common.c b/hw/intc/loongson_ipi_common.c
index 9a081565f5..5d46679ea1 100644
--- a/hw/intc/loongson_ipi_common.c
+++ b/hw/intc/loongson_ipi_common.c
@@ -10,7 +10,6 @@
 #include "hw/intc/loongson_ipi_common.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
-#include "qapi/error.h"
 #include "qemu/log.h"
 #include "migration/vmstate.h"
 #include "trace.h"
@@ -253,12 +252,6 @@ static void loongson_ipi_common_realize(DeviceState *dev, Error **errp)
 {
     LoongsonIPICommonState *s = LOONGSON_IPI_COMMON(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    int i;
-
-    if (s->num_cpu == 0) {
-        error_setg(errp, "num-cpu must be at least 1");
-        return;
-    }
 
     memory_region_init_io(&s->ipi_iocsr_mem, OBJECT(dev),
                           &loongson_ipi_iocsr_ops,
@@ -273,13 +266,6 @@ static void loongson_ipi_common_realize(DeviceState *dev, Error **errp)
                           &loongson_ipi64_ops,
                           s, "loongson_ipi64_iocsr", 0x118);
     sysbus_init_mmio(sbd, &s->ipi64_iocsr_mem);
-
-    s->cpu = g_new0(IPICore, s->num_cpu);
-    for (i = 0; i < s->num_cpu; i++) {
-        s->cpu[i].ipi = s;
-
-        qdev_init_gpio_out(dev, &s->cpu[i].irq, 1);
-    }
 }
 
 static void loongson_ipi_common_unrealize(DeviceState *dev)
-- 
2.43.5


