Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C03799871
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 15:14:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qexdQ-0006Lw-4W; Sat, 09 Sep 2023 09:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexd9-0006In-Db; Sat, 09 Sep 2023 09:04:08 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexd5-00031Z-89; Sat, 09 Sep 2023 09:04:06 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C61FD205B5;
 Sat,  9 Sep 2023 16:01:20 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 8AED926E1B;
 Sat,  9 Sep 2023 16:00:29 +0300 (MSK)
Received: (nullmailer pid 353172 invoked by uid 1000);
 Sat, 09 Sep 2023 13:00:23 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Hang Yu <francis_yuu@stu.pku.edu.cn>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.5 39/43] hw/i2c/aspeed: Fix TXBUF transmission start
 position error
Date: Sat,  9 Sep 2023 16:00:05 +0300
Message-Id: <20230909130020.352951-39-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.5-20230909155813@cover.tls.msk.ru>
References: <qemu-stable-8.0.5-20230909155813@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Hang Yu <francis_yuu@stu.pku.edu.cn>

According to the ast2600 datasheet and the linux aspeed i2c driver,
the TXBUF transmission start position should be TXBUF[0] instead
of TXBUF[1],so the arg pool_start is useless,and the address is not
included in TXBUF.So even if Tx Count equals zero,there is at least
1 byte data needs to be transmitted,and M_TX_CMD should not be cleared
at this condition.The driver url is:
https://github.com/AspeedTech-BMC/linux/blob/aspeed-master-v5.15/drivers/i2c/busses/i2c-ast2600.c

Signed-off-by: Hang Yu <francis_yuu@stu.pku.edu.cn>
Fixes: 6054fc73e8f4 ("aspeed/i2c: Add support for pool buffer transfers")
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
(cherry picked from commit 961faf3ddbd8ffcdf776bbcf88af0bc97218114a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index e485d8bfb8..44905d7899 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -226,7 +226,7 @@ static int aspeed_i2c_dma_read(AspeedI2CBus *bus, uint8_t *data)
     return 0;
 }
 
-static int aspeed_i2c_bus_send(AspeedI2CBus *bus, uint8_t pool_start)
+static int aspeed_i2c_bus_send(AspeedI2CBus *bus)
 {
     AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(bus->controller);
     int ret = -1;
@@ -239,7 +239,7 @@ static int aspeed_i2c_bus_send(AspeedI2CBus *bus, uint8_t pool_start)
                                                 TX_COUNT) + 1;
 
     if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, TX_BUFF_EN)) {
-        for (i = pool_start; i < pool_tx_count; i++) {
+        for (i = 0; i < pool_tx_count; i++) {
             uint8_t *pool_base = aic->bus_pool_base(bus);
 
             trace_aspeed_i2c_bus_send("BUF", i + 1, pool_tx_count,
@@ -273,7 +273,7 @@ static int aspeed_i2c_bus_send(AspeedI2CBus *bus, uint8_t pool_start)
         }
         SHARED_ARRAY_FIELD_DP32(bus->regs, reg_cmd, TX_DMA_EN, 0);
     } else {
-        trace_aspeed_i2c_bus_send("BYTE", pool_start, 1,
+        trace_aspeed_i2c_bus_send("BYTE", 0, 1,
                                   bus->regs[reg_byte_buf]);
         ret = i2c_send(bus->bus, bus->regs[reg_byte_buf]);
     }
@@ -446,10 +446,8 @@ static void aspeed_i2c_bus_cmd_dump(AspeedI2CBus *bus)
  */
 static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
 {
-    uint8_t pool_start = 0;
     uint32_t reg_intr_sts = aspeed_i2c_bus_intr_sts_offset(bus);
     uint32_t reg_cmd = aspeed_i2c_bus_cmd_offset(bus);
-    uint32_t reg_pool_ctrl = aspeed_i2c_bus_pool_ctrl_offset(bus);
     uint32_t reg_dma_len = aspeed_i2c_bus_dma_len_offset(bus);
 
     if (!aspeed_i2c_check_sram(bus)) {
@@ -483,27 +481,11 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
 
         SHARED_ARRAY_FIELD_DP32(bus->regs, reg_cmd, M_START_CMD, 0);
 
-        /*
-         * The START command is also a TX command, as the slave
-         * address is sent on the bus. Drop the TX flag if nothing
-         * else needs to be sent in this sequence.
-         */
-        if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, TX_BUFF_EN)) {
-            if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_pool_ctrl, TX_COUNT)
-                == 0) {
-                SHARED_ARRAY_FIELD_DP32(bus->regs, reg_cmd, M_TX_CMD, 0);
-            } else {
-                /*
-                 * Increase the start index in the TX pool buffer to
-                 * skip the address byte.
-                 */
-                pool_start++;
-            }
-        } else if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, TX_DMA_EN)) {
+        if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, TX_DMA_EN)) {
             if (bus->regs[reg_dma_len] == 0) {
                 SHARED_ARRAY_FIELD_DP32(bus->regs, reg_cmd, M_TX_CMD, 0);
             }
-        } else {
+        } else if (!SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, TX_BUFF_EN)) {
             SHARED_ARRAY_FIELD_DP32(bus->regs, reg_cmd, M_TX_CMD, 0);
         }
 
@@ -520,7 +502,7 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
 
     if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, M_TX_CMD)) {
         aspeed_i2c_set_state(bus, I2CD_MTXD);
-        if (aspeed_i2c_bus_send(bus, pool_start)) {
+        if (aspeed_i2c_bus_send(bus)) {
             SHARED_ARRAY_FIELD_DP32(bus->regs, reg_intr_sts, TX_NAK, 1);
             i2c_end_transfer(bus->bus);
         } else {
-- 
2.39.2


