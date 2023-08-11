Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45171778716
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 07:50:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUL1v-0007xa-Gt; Fri, 11 Aug 2023 01:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisyuu@B-L8MBMD6R-2342.local>)
 id 1qUKvb-0006M5-SD; Fri, 11 Aug 2023 01:43:15 -0400
Received: from [2401:b180:8000:2:9109:19ec:a055:9652]
 (helo=B-L8MBMD6R-2342.local) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <francisyuu@B-L8MBMD6R-2342.local>)
 id 1qUKvZ-0000KD-On; Fri, 11 Aug 2023 01:43:15 -0400
Received: by B-L8MBMD6R-2342.local (Postfix, from userid 502)
 id 7D17838B158; Fri, 11 Aug 2023 13:43:04 +0800 (CST)
From: Hang Yu <francis_yuu@stu.pku.edu.cn>
To: qemu-devel@nongnu.org
Cc: komlodi@google.com, peter@pjd.dev, Hang Yu <francis_yuu@stu.pku.edu.cn>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org (open list:ASPEED BMCs)
Subject: [PATCH v2 4/4] hw/i2c/aspeed: Add support for BUFFER ORGANIZATION in
 new register mode
Date: Fri, 11 Aug 2023 13:42:19 +0800
Message-Id: <20230811054220.99562-4-francis_yuu@stu.pku.edu.cn>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230811054220.99562-1-francis_yuu@stu.pku.edu.cn>
References: <20230811054220.99562-1-francis_yuu@stu.pku.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for
 2401:b180:8000:2:9109:19ec:a055:9652 (failed)
Received-SPF: none client-ip=2401:b180:8000:2:9109:19ec:a055:9652;
 envelope-from=francisyuu@B-L8MBMD6R-2342.local; helo=B-L8MBMD6R-2342.local
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NO_DNS_FOR_FROM=0.001, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 11 Aug 2023 01:49:27 -0400
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

Added support for the BUFFER ORGANIZATION option in reg I2CC_POOL_CTRL,
when set to 1,The buffer is split into two parts: Lower 16 bytes for Tx
and higher 16 bytes for Rx.

Signed-off-by: Hang Yu <francis_yuu@stu.pku.edu.cn>
---
 hw/i2c/aspeed_i2c.c         | 7 ++++++-
 include/hw/i2c/aspeed_i2c.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 44905d7899..26fefb8f9e 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -296,7 +296,12 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
                                                 RX_SIZE) + 1;
 
     if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, RX_BUFF_EN)) {
-        uint8_t *pool_base = aic->bus_pool_base(bus);
+        uint8_t *pool_base;
+        if (ARRAY_FIELD_EX32(bus->regs, I2CC_POOL_CTRL, BUF_ORGANIZATION)) {
+            pool_base = aic->bus_pool_base(bus) + 16;
+        } else {
+            pool_base = aic->bus_pool_base(bus);
+        }
 
         for (i = 0; i < pool_rx_count; i++) {
             pool_base[i] = i2c_recv(bus->bus);
diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index 2e1e15aaf0..88b144a599 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -162,6 +162,7 @@ REG32(I2CC_MS_TXRX_BYTE_BUF, 0x08)
     /* 15:0  shared with I2CD_BYTE_BUF[15:0] */
 REG32(I2CC_POOL_CTRL, 0x0c)
     /* 31:0 shared with I2CD_POOL_CTRL[31:0] */
+    FIELD(I2CC_POOL_CTRL, BUF_ORGANIZATION, 0, 1) /* AST2600 */
 REG32(I2CM_INTR_CTRL, 0x10)
 REG32(I2CM_INTR_STS, 0x14)
     FIELD(I2CM_INTR_STS, PKT_STATE, 28, 4)
-- 
2.39.2 (Apple Git-143)


