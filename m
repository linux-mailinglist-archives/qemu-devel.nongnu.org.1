Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5577F2806
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 09:52:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5MTw-00061x-7T; Tue, 21 Nov 2023 03:51:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=nm9w=HC=kaod.org=clg@ozlabs.org>)
 id 1r5MTu-00061k-3G; Tue, 21 Nov 2023 03:51:42 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=nm9w=HC=kaod.org=clg@ozlabs.org>)
 id 1r5MTq-0003BX-Hu; Tue, 21 Nov 2023 03:51:41 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SZJ5L6VfJz4xWP;
 Tue, 21 Nov 2023 19:51:34 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SZJ5H61M3z4xWJ;
 Tue, 21 Nov 2023 19:51:31 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/4] ppc/pnv: Fix potential overflow in I2C model
Date: Tue, 21 Nov 2023 09:51:21 +0100
Message-ID: <20231121085124.396578-2-clg@kaod.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121085124.396578-1-clg@kaod.org>
References: <20231121085124.396578-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=nm9w=HC=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Coverity warns that "i2c_bus_busy(i2c->busses[i]) << i" might overflow
because the expression is evaluated using 32-bit arithmetic and then
used in a context expecting a uint64_t.

While we are at it, introduce a PNV_I2C_MAX_BUSSES constant and check
the number of busses at realize time.

Fixes: Coverity CID 1523918
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv_i2c.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
index f75e59e70977..483d91d15a77 100644
--- a/hw/ppc/pnv_i2c.c
+++ b/hw/ppc/pnv_i2c.c
@@ -151,6 +151,7 @@
 #define I2C_RESET_S_SDA_REG             0x11
 
 #define PNV_I2C_FIFO_SIZE 8
+#define PNV_I2C_MAX_BUSSES 64
 
 static I2CBus *pnv_i2c_get_bus(PnvI2C *i2c)
 {
@@ -437,7 +438,7 @@ static uint64_t pnv_i2c_xscom_read(void *opaque, hwaddr addr,
     case I2C_PORT_BUSY_REG: /* compute busy bit for each port  */
         val = 0;
         for (i = 0; i < i2c->num_busses; i++) {
-            val |= i2c_bus_busy(i2c->busses[i]) << i;
+            val |= (uint64_t)i2c_bus_busy(i2c->busses[i]) << i;
         }
         break;
 
@@ -641,6 +642,11 @@ static void pnv_i2c_realize(DeviceState *dev, Error **errp)
 
     assert(i2c->chip);
 
+    if (i2c->num_busses > PNV_I2C_MAX_BUSSES) {
+        error_setg(errp, "Invalid number of busses: %u", i2c->num_busses);
+        return;
+    }
+
     pnv_xscom_region_init(&i2c->xscom_regs, OBJECT(i2c), &pnv_i2c_xscom_ops,
                           i2c, "xscom-i2c", PNV9_XSCOM_I2CM_SIZE);
 
-- 
2.42.0


