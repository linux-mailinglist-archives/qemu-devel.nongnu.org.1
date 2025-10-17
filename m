Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3052BBE6C26
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Oct 2025 08:47:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9eDm-00061l-39; Fri, 17 Oct 2025 02:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1v9eDc-0005zX-VW
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 02:45:41 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1v9eDU-0003uW-Lw
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 02:45:38 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Dx_tIF5vFoQDoXAA--.50081S3;
 Fri, 17 Oct 2025 14:45:25 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJDxQ+QD5vFoHDntAA--.1225S5;
 Fri, 17 Oct 2025 14:45:25 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 3/7] hw/loongarch/virt: Get irq number from gpex config info
Date: Fri, 17 Oct 2025 14:45:19 +0800
Message-Id: <20251017064523.2065993-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251017064523.2065993-1-maobibo@loongson.cn>
References: <20251017064523.2065993-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxQ+QD5vFoHDntAA--.1225S5
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The base irq number of GPEX PCIE host bridge can comes from gpex::irq.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 955d0c950b..0fe7337626 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -292,7 +292,7 @@ static void virt_devices_init(DeviceState *pch_pic,
     PCIBus *pci_bus;
     MemoryRegion *ecam_alias, *ecam_reg, *pio_alias, *pio_reg;
     MemoryRegion *mmio_alias, *mmio_reg;
-    int i;
+    int i, irq;
 
     gpex_dev = qdev_new(TYPE_GPEX_HOST);
     d = SYS_BUS_DEVICE(gpex_dev);
@@ -332,9 +332,9 @@ static void virt_devices_init(DeviceState *pch_pic,
                                 pio_alias);
 
     for (i = 0; i < PCI_NUM_PINS; i++) {
-        sysbus_connect_irq(d, i,
-                           qdev_get_gpio_in(pch_pic, 16 + i));
-        gpex_set_irq_num(GPEX_HOST(gpex_dev), i, 16 + i);
+        irq = lvms->gpex.irq + i - VIRT_GSI_BASE;
+        sysbus_connect_irq(d, i, qdev_get_gpio_in(pch_pic, irq));
+        gpex_set_irq_num(GPEX_HOST(gpex_dev), i, irq);
     }
 
     /*
@@ -343,7 +343,7 @@ static void virt_devices_init(DeviceState *pch_pic,
      */
     for (i = VIRT_UART_COUNT; i-- > 0;) {
         hwaddr base = VIRT_UART_BASE + i * VIRT_UART_SIZE;
-        int irq = VIRT_UART_IRQ + i - VIRT_GSI_BASE;
+        irq = VIRT_UART_IRQ + i - VIRT_GSI_BASE;
         serial_mm_init(get_system_memory(), base, 0,
                        qdev_get_gpio_in(pch_pic, irq),
                        115200, serial_hd(i), DEVICE_LITTLE_ENDIAN);
-- 
2.39.3


