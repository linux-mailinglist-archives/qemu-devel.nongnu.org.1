Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8517E7003
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 18:17:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r18dN-0000rT-3K; Thu, 09 Nov 2023 12:16:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=uA+F=GW=kaod.org=clg@ozlabs.org>)
 id 1r18d6-0000mM-Pn; Thu, 09 Nov 2023 12:15:47 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=uA+F=GW=kaod.org=clg@ozlabs.org>)
 id 1r18d1-0007L0-PM; Thu, 09 Nov 2023 12:15:43 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SR7rQ2yF8z4xVK;
 Fri, 10 Nov 2023 04:15:34 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SR7rM3Ykcz4xVl;
 Fri, 10 Nov 2023 04:15:31 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PATCH v2] ppc/pnv: Fix potential overflow in I2C model
Date: Thu,  9 Nov 2023 18:15:25 +0100
Message-ID: <20231109171525.1129353-1-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=uA+F=GW=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---

 v2: - check PNV_I2C_MAX_BUSSES in realize
     - removed extra space before cast.

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
2.41.0


