Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3458A6D7AB
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Mar 2025 10:39:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tweFv-0007MZ-8x; Mon, 24 Mar 2025 05:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tweFs-0007LN-1H
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 05:38:00 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tweFp-0001Ty-0j
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 05:37:59 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxyuDpJ+FnT_ujAA--.13433S3;
 Mon, 24 Mar 2025 17:37:45 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxPsfaJ+FnGn1dAA--.15661S16;
 Mon, 24 Mar 2025 17:37:44 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 14/16] hw/intc/loongarch_pch: Rename memory region
 iomem32_low with iomem
Date: Mon, 24 Mar 2025 17:37:28 +0800
Message-Id: <20250324093730.3683378-15-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250324093730.3683378-1-maobibo@loongson.cn>
References: <20250324093730.3683378-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxPsfaJ+FnGn1dAA--.15661S16
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

Rename memory region iomem32_low with iomem, also change ops name
as follows:
  loongarch_pch_pic_reg32_low_ops  --> loongarch_pch_pic_ops
  loongarch_pch_pic_low_readw      --> loongarch_pch_pic_read
  loongarch_pch_pic_low_writew     --> loongarch_pch_pic_write

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c            | 26 +++++++-------------------
 include/hw/intc/loongarch_pic_common.h |  2 +-
 2 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index ff1e5992bd..db0d8ce7ac 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -230,18 +230,6 @@ static void loongarch_pch_pic_write(void *opaque, hwaddr addr,
     }
 }
 
-static uint64_t loongarch_pch_pic_low_readw(void *opaque, hwaddr addr,
-                                            unsigned size)
-{
-    return loongarch_pch_pic_read(opaque, addr, size);
-}
-
-static void loongarch_pch_pic_low_writew(void *opaque, hwaddr addr,
-                                         uint64_t value, unsigned size)
-{
-    loongarch_pch_pic_write(opaque, addr, value, size);
-}
-
 static uint64_t loongarch_pch_pic_high_readw(void *opaque, hwaddr addr,
                                         unsigned size)
 {
@@ -270,9 +258,9 @@ static void loongarch_pch_pic_writeb(void *opaque, hwaddr addr,
     loongarch_pch_pic_write(opaque, addr, data, size);
 }
 
-static const MemoryRegionOps loongarch_pch_pic_reg32_low_ops = {
-    .read = loongarch_pch_pic_low_readw,
-    .write = loongarch_pch_pic_low_writew,
+static const MemoryRegionOps loongarch_pch_pic_ops = {
+    .read = loongarch_pch_pic_read,
+    .write = loongarch_pch_pic_write,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 8,
@@ -356,15 +344,15 @@ static void loongarch_pic_realize(DeviceState *dev, Error **errp)
 
     qdev_init_gpio_out(dev, s->parent_irq, s->irq_num);
     qdev_init_gpio_in(dev, pch_pic_irq_handler, s->irq_num);
-    memory_region_init_io(&s->iomem32_low, OBJECT(dev),
-                          &loongarch_pch_pic_reg32_low_ops,
-                          s, PCH_PIC_NAME(.reg32_part1), 0x100);
+    memory_region_init_io(&s->iomem, OBJECT(dev),
+                          &loongarch_pch_pic_ops,
+                          s, TYPE_LOONGARCH_PIC, 0x100);
     memory_region_init_io(&s->iomem8, OBJECT(dev), &loongarch_pch_pic_reg8_ops,
                           s, PCH_PIC_NAME(.reg8), 0x2a0);
     memory_region_init_io(&s->iomem32_high, OBJECT(dev),
                           &loongarch_pch_pic_reg32_high_ops,
                           s, PCH_PIC_NAME(.reg32_part2), 0xc60);
-    sysbus_init_mmio(sbd, &s->iomem32_low);
+    sysbus_init_mmio(sbd, &s->iomem);
     sysbus_init_mmio(sbd, &s->iomem8);
     sysbus_init_mmio(sbd, &s->iomem32_high);
 
diff --git a/include/hw/intc/loongarch_pic_common.h b/include/hw/intc/loongarch_pic_common.h
index fb848da4b8..ab8ffff780 100644
--- a/include/hw/intc/loongarch_pic_common.h
+++ b/include/hw/intc/loongarch_pic_common.h
@@ -65,7 +65,7 @@ struct LoongArchPICCommonState {
     uint8_t route_entry[64];  /* 0x100 - 0x138 */
     uint8_t htmsi_vector[64]; /* 0x200 - 0x238 */
 
-    MemoryRegion iomem32_low;
+    MemoryRegion iomem;
     MemoryRegion iomem32_high;
     MemoryRegion iomem8;
     unsigned int irq_num;
-- 
2.39.3


