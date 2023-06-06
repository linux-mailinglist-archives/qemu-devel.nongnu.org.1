Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0EF723E6C
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:53:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TIu-0007nV-IA; Tue, 06 Jun 2023 05:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIh-0007b5-EF
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:29 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TId-0004kC-JE
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:25 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-30ad8f33f1aso5183652f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044901; x=1688636901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h0eW8qzIccTtiuHWKz/SuMzOqYz5huBqwsYf7UEDet8=;
 b=nvNzzTp8Kw5V+H/luVVqIdh3/f0gUe5cF40sZgmvWXuqowM0Mp69Q0z7KGg8oubqvt
 enN+08ydGiEtxXzFDpwiYjB0JWyhrvqGALJr30YBVYa4yLJZikw1IX138Gw19zwVXay0
 Ll7hOic/k0WnhrfU2PeB7Vp8Gi0SpMFnWK2m+0cFsHT6qYtzdIJYtSBS0yLLe/9qkIUH
 60gXX4J9ZQ7whhUpGBqUTjrMn5fQtv51WJPaD1VZWL3MNoLF1na6I8jqeavnFaILJEg7
 J/4C7vUC++KVrNbBlBmWvldgTOSFsD4ndtEkVD9cjiiy3EA2knep3MjPglaT7KZqM4gO
 ZzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044901; x=1688636901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h0eW8qzIccTtiuHWKz/SuMzOqYz5huBqwsYf7UEDet8=;
 b=RMFi2NheJjliO8YVtjkB7uQ3M5k7w+zT+hC65wCunxDMZKN70gXYh5KfD2tN7tnpR6
 tS4YJSA7qnNRctY6xaR6iD0S5CwNdq2enH91Ann/ragyJYWSqy5DGwTSM/zAgZWaCdH1
 +O3IQxcPt56CNquPFtyAKWUX1EfWgXEJ/1I4YXTZDNc7/y+ofSDKaq2NtDrO0kzyQO2T
 5IpNSlDmfD/0URRtmG7Y781yOx1os0MEUH5jQW1YMeGdmsC4vT7/g2nZYo+W6wxIH3no
 5Qp5gi9THNKqizEX/oafA1y5+VbMZcvHbtPUF63QSjH3PwomcAfDkWAP7ZO26bkGIP7B
 xljw==
X-Gm-Message-State: AC+VfDw2d/u1FKDZZPQQ0xDVW9VHfWYV75/uqytOsSWLaczANchKkqsF
 2bKrM8kmwpg25t/zM7qM+Hg4GzDBYm7znc+I3XI=
X-Google-Smtp-Source: ACHHUZ6hXnFRdb+1QDv0JEvNRIyelNHn+wOyhatuW3d1wZBhvsLvS8Fe/ozn3eeXs27s68nn96JT6g==
X-Received: by 2002:a5d:6382:0:b0:306:44ea:4fba with SMTP id
 p2-20020a5d6382000000b0030644ea4fbamr1364778wru.31.1686044901612; 
 Tue, 06 Jun 2023 02:48:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/42] hw: allwinner-r40: Complete uart devices
Date: Tue,  6 Jun 2023 10:47:43 +0100
Message-Id: <20230606094814.3581397-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/allwinner-r40.h |  8 ++++++++
 hw/arm/allwinner-r40.c         | 34 +++++++++++++++++++++++++++++++---
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/allwinner-r40.h b/include/hw/arm/allwinner-r40.h
index 3be9dc962be..959b5dc4e04 100644
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
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index 72973f69ff0..537a90b23d8 100644
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
-- 
2.34.1


