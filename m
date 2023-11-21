Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F06C07F2807
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 09:52:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5MU3-00063W-D9; Tue, 21 Nov 2023 03:51:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=nm9w=HC=kaod.org=clg@ozlabs.org>)
 id 1r5MU1-000636-MR; Tue, 21 Nov 2023 03:51:49 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=nm9w=HC=kaod.org=clg@ozlabs.org>)
 id 1r5MTz-0003CW-Ej; Tue, 21 Nov 2023 03:51:49 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SZJ5W2YN9z4xWD;
 Tue, 21 Nov 2023 19:51:43 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SZJ5T1Ldrz4xWJ;
 Tue, 21 Nov 2023 19:51:40 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 4/4] ppc/pnv: Fix PNV I2C invalid status after reset
Date: Tue, 21 Nov 2023 09:51:24 +0100
Message-ID: <20231121085124.396578-5-clg@kaod.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121085124.396578-1-clg@kaod.org>
References: <20231121085124.396578-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=nm9w=HC=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

The PNV I2C Controller was clearing the status register
after a reset without repopulating the "upper threshold
for I2C ports", "Command Complete" and the SCL/SDA input
level fields.

Fixed this for resets caused by a system reset as well
as from writing to the "Immediate Reset" register.

Fixes: 263b81ee15af ("ppc/pnv: Add an I2C controller model")
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv_i2c.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
index 384442f898bf..656a48eebe51 100644
--- a/hw/ppc/pnv_i2c.c
+++ b/hw/ppc/pnv_i2c.c
@@ -463,6 +463,23 @@ static uint64_t pnv_i2c_xscom_read(void *opaque, hwaddr addr,
     return val;
 }
 
+static void pnv_i2c_reset(void *dev)
+{
+    PnvI2C *i2c = PNV_I2C(dev);
+
+    memset(i2c->regs, 0, sizeof(i2c->regs));
+
+    i2c->regs[I2C_STAT_REG] =
+        SETFIELD(I2C_STAT_UPPER_THRS, 0ull, i2c->num_busses - 1) |
+        I2C_STAT_CMD_COMP | I2C_STAT_SCL_INPUT_LEVEL |
+        I2C_STAT_SDA_INPUT_LEVEL;
+    i2c->regs[I2C_EXTD_STAT_REG] =
+        SETFIELD(I2C_EXTD_STAT_FIFO_SIZE, 0ull, PNV_I2C_FIFO_SIZE) |
+        SETFIELD(I2C_EXTD_STAT_I2C_VERSION, 0ull, 23); /* last version */
+
+    fifo8_reset(&i2c->fifo);
+}
+
 static void pnv_i2c_xscom_write(void *opaque, hwaddr addr,
                                 uint64_t val, unsigned size)
 {
@@ -500,16 +517,7 @@ static void pnv_i2c_xscom_write(void *opaque, hwaddr addr,
         break;
 
     case I2C_RESET_I2C_REG:
-        i2c->regs[I2C_MODE_REG] = 0;
-        i2c->regs[I2C_CMD_REG] = 0;
-        i2c->regs[I2C_WATERMARK_REG] = 0;
-        i2c->regs[I2C_INTR_MASK_REG] = 0;
-        i2c->regs[I2C_INTR_COND_REG] = 0;
-        i2c->regs[I2C_INTR_RAW_COND_REG] = 0;
-        i2c->regs[I2C_STAT_REG] = 0;
-        i2c->regs[I2C_RESIDUAL_LEN_REG] = 0;
-        i2c->regs[I2C_EXTD_STAT_REG] &=
-            (I2C_EXTD_STAT_FIFO_SIZE | I2C_EXTD_STAT_I2C_VERSION);
+        pnv_i2c_reset(i2c);
         break;
 
     case I2C_RESET_ERRORS:
@@ -621,20 +629,6 @@ static int pnv_i2c_dt_xscom(PnvXScomInterface *dev, void *fdt,
     return 0;
 }
 
-static void pnv_i2c_reset(void *dev)
-{
-    PnvI2C *i2c = PNV_I2C(dev);
-
-    memset(i2c->regs, 0, sizeof(i2c->regs));
-
-    i2c->regs[I2C_STAT_REG] = I2C_STAT_CMD_COMP;
-    i2c->regs[I2C_EXTD_STAT_REG] =
-        SETFIELD(I2C_EXTD_STAT_FIFO_SIZE, 0ull, PNV_I2C_FIFO_SIZE) |
-        SETFIELD(I2C_EXTD_STAT_I2C_VERSION, 0ull, 23); /* last version */
-
-    fifo8_reset(&i2c->fifo);
-}
-
 static void pnv_i2c_realize(DeviceState *dev, Error **errp)
 {
     PnvI2C *i2c = PNV_I2C(dev);
-- 
2.42.0


