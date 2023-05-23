Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B9570D9F7
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 12:07:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Ou0-00057K-4c; Tue, 23 May 2023 06:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qianfanguijin@163.com>)
 id 1q1Ott-0004yE-5n; Tue, 23 May 2023 06:05:54 -0400
Received: from m12.mail.163.com ([220.181.12.197])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qianfanguijin@163.com>)
 id 1q1Otm-00077b-UI; Tue, 23 May 2023 06:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=uFah4
 9/+5d/OhQwBHrTnC8+njyaDfvJEjZqRihCQQn8=; b=eRZnVcoRh8NYPyEVYD3rM
 RzY95TzBCYKuU44S+aF1Deyf0cJ6bC+hTIKI/NAESTJvS++D2fK1WF5ul+f48EQZ
 xmwFTmI3svkpzF9zUmqRa6/zzaJyugqtOfnRI3VFZr0QS3sAOxroNBiFOaE8j1jv
 2Hvs+HON55EkMhZ61Td2R4=
Received: from DESKTOP-B1R4FVG.localdomain (unknown [218.201.129.19])
 by zwqz-smtp-mta-g0-3 (Coremail) with SMTP id _____wAnDC3Wj2xkMfafAQ--.65319S5;
 Tue, 23 May 2023 18:05:18 +0800 (CST)
From: qianfanguijin@163.com
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 qianfan Zhao <qianfanguijin@163.com>
Subject: [PATCH v5 03/11] hw: allwinner-r40: Complete uart devices
Date: Tue, 23 May 2023 18:05:00 +0800
Message-Id: <20230523100508.32564-4-qianfanguijin@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230523100508.32564-1-qianfanguijin@163.com>
References: <20230523100508.32564-1-qianfanguijin@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAnDC3Wj2xkMfafAQ--.65319S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFWUJw4DKryxJF1xWr47CFg_yoW5ZF18pr
 9IkrZ5GFyjg3W3ArWxKws3ZrWSy3W8GrnFy3WIya13tF18Xr40vrW2qa1UGr43KrZ3JFW3
 Xr98Gr47W3W2qwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRX_-QUUUUU=
X-Originating-IP: [218.201.129.19]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/1tbiGgB47VaEFUv5dgAAsM
Received-SPF: pass client-ip=220.181.12.197;
 envelope-from=qianfanguijin@163.com; helo=m12.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: qianfan Zhao <qianfanguijin@163.com>

R40 has eight UARTs, support both 16450 and 16550 compatible modes.

Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
---
 hw/arm/allwinner-r40.c         | 34 +++++++++++++++++++++++++++++++---
 include/hw/arm/allwinner-r40.h |  8 ++++++++
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index 72973f69ff..537a90b23d 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -45,6 +45,13 @@ const hwaddr allwinner_r40_memmap[] = {
     [AW_R40_DEV_CCU]        = 0x01c20000,
     [AW_R40_DEV_PIT]        = 0x01c20c00,
     [AW_R40_DEV_UART0]      = 0x01c28000,
+    [AW_R40_DEV_UART1]      = 0x01c28400,
+    [AW_R40_DEV_UART2]      = 0x01c28800,
+    [AW_R40_DEV_UART3]      = 0x01c28c00,
+    [AW_R40_DEV_UART4]      = 0x01c29000,
+    [AW_R40_DEV_UART5]      = 0x01c29400,
+    [AW_R40_DEV_UART6]      = 0x01c29800,
+    [AW_R40_DEV_UART7]      = 0x01c29c00,
     [AW_R40_DEV_GIC_DIST]   = 0x01c81000,
     [AW_R40_DEV_GIC_CPU]    = 0x01c82000,
     [AW_R40_DEV_GIC_HYP]    = 0x01c84000,
@@ -157,6 +164,13 @@ enum {
 /* Shared Processor Interrupts */
 enum {
     AW_R40_GIC_SPI_UART0     =  1,
+    AW_R40_GIC_SPI_UART1     =  2,
+    AW_R40_GIC_SPI_UART2     =  3,
+    AW_R40_GIC_SPI_UART3     =  4,
+    AW_R40_GIC_SPI_UART4     = 17,
+    AW_R40_GIC_SPI_UART5     = 18,
+    AW_R40_GIC_SPI_UART6     = 19,
+    AW_R40_GIC_SPI_UART7     = 20,
     AW_R40_GIC_SPI_TIMER0    = 22,
     AW_R40_GIC_SPI_TIMER1    = 23,
     AW_R40_GIC_SPI_MMC0      = 32,
@@ -384,9 +398,23 @@ static void allwinner_r40_realize(DeviceState *dev, Error **errp)
     }
 
     /* UART0. For future clocktree API: All UARTS are connected to APB2_CLK. */
-    serial_mm_init(get_system_memory(), s->memmap[AW_R40_DEV_UART0], 2,
-                   qdev_get_gpio_in(DEVICE(&s->gic), AW_R40_GIC_SPI_UART0),
-                   115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);
+    for (int i = 0; i < AW_R40_NUM_UARTS; i++) {
+        static const int uart_irqs[AW_R40_NUM_UARTS] = {
+            AW_R40_GIC_SPI_UART0,
+            AW_R40_GIC_SPI_UART1,
+            AW_R40_GIC_SPI_UART2,
+            AW_R40_GIC_SPI_UART3,
+            AW_R40_GIC_SPI_UART4,
+            AW_R40_GIC_SPI_UART5,
+            AW_R40_GIC_SPI_UART6,
+            AW_R40_GIC_SPI_UART7,
+        };
+        const hwaddr addr = s->memmap[AW_R40_DEV_UART0 + i];
+
+        serial_mm_init(get_system_memory(), addr, 2,
+                       qdev_get_gpio_in(DEVICE(&s->gic), uart_irqs[i]),
+                       115200, serial_hd(i), DEVICE_NATIVE_ENDIAN);
+    }
 
     /* Unimplemented devices */
     for (i = 0; i < ARRAY_SIZE(r40_unimplemented); i++) {
diff --git a/include/hw/arm/allwinner-r40.h b/include/hw/arm/allwinner-r40.h
index 3be9dc962b..959b5dc4e0 100644
--- a/include/hw/arm/allwinner-r40.h
+++ b/include/hw/arm/allwinner-r40.h
@@ -41,6 +41,13 @@ enum {
     AW_R40_DEV_CCU,
     AW_R40_DEV_PIT,
     AW_R40_DEV_UART0,
+    AW_R40_DEV_UART1,
+    AW_R40_DEV_UART2,
+    AW_R40_DEV_UART3,
+    AW_R40_DEV_UART4,
+    AW_R40_DEV_UART5,
+    AW_R40_DEV_UART6,
+    AW_R40_DEV_UART7,
     AW_R40_DEV_GIC_DIST,
     AW_R40_DEV_GIC_CPU,
     AW_R40_DEV_GIC_HYP,
@@ -70,6 +77,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AwR40State, AW_R40)
  * which are currently emulated by the R40 SoC code.
  */
 #define AW_R40_NUM_MMCS         4
+#define AW_R40_NUM_UARTS        8
 
 struct AwR40State {
     /*< private >*/
-- 
2.25.1


