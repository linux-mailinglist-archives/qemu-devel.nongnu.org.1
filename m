Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A31078FB44
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 11:44:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc0fr-0001WX-En; Fri, 01 Sep 2023 05:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=SnXb=ER=kaod.org=clg@ozlabs.org>)
 id 1qc0fn-0001Qx-Uq; Fri, 01 Sep 2023 05:42:39 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=SnXb=ER=kaod.org=clg@ozlabs.org>)
 id 1qc0fh-0002rf-47; Fri, 01 Sep 2023 05:42:38 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RcY3V28qhz4x3G;
 Fri,  1 Sep 2023 19:42:30 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RcY3S5SWWz4wxW;
 Fri,  1 Sep 2023 19:42:28 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Hang Yu <francis_yuu@stu.pku.edu.cn>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 04/26] hw/i2c/aspeed: Add support for buffer organization
Date: Fri,  1 Sep 2023 11:41:52 +0200
Message-ID: <20230901094214.296918-5-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230901094214.296918-1-clg@kaod.org>
References: <20230901094214.296918-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=SnXb=ER=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, FORGED_SPF_HELO=1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Added support for the buffer organization option in pool buffer control
register.when set to 1,The buffer is split into two parts: Lower 16 bytes
for Tx and higher 16 bytes for Rx.

Signed-off-by: Hang Yu <francis_yuu@stu.pku.edu.cn>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
[ clg: checkpatch fixes ]
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/i2c/aspeed_i2c.h | 1 +
 hw/i2c/aspeed_i2c.c         | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index 2e1e15aaf0f7..a064479e599c 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -143,6 +143,7 @@ REG32(I2CD_POOL_CTRL, 0x1C) /* Pool Buffer Control */
     SHARED_FIELD(RX_SIZE, 16, 5)
     SHARED_FIELD(TX_COUNT, 8, 5)
     FIELD(I2CD_POOL_CTRL, OFFSET, 2, 6) /* AST2400 */
+    SHARED_FIELD(BUF_ORGANIZATION, 0, 1) /* AST2600 */
 REG32(I2CD_BYTE_BUF, 0x20) /* Transmit/Receive Byte Buffer */
     SHARED_FIELD(RX_BUF, 8, 8)
     SHARED_FIELD(TX_BUF, 0, 8)
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 44905d789998..7275d40749a9 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -297,6 +297,10 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
 
     if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, RX_BUFF_EN)) {
         uint8_t *pool_base = aic->bus_pool_base(bus);
+        if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_pool_ctrl,
+                                    BUF_ORGANIZATION)) {
+            pool_base += 16;
+        }
 
         for (i = 0; i < pool_rx_count; i++) {
             pool_base[i] = i2c_recv(bus->bus);
-- 
2.41.0


