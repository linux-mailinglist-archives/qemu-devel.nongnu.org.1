Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CA27F2808
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 09:52:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5MU7-00067r-0F; Tue, 21 Nov 2023 03:51:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=nm9w=HC=kaod.org=clg@ozlabs.org>)
 id 1r5MU3-00063x-A8; Tue, 21 Nov 2023 03:51:51 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=nm9w=HC=kaod.org=clg@ozlabs.org>)
 id 1r5MTx-0003CF-DQ; Tue, 21 Nov 2023 03:51:51 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SZJ5S4djBz4xWG;
 Tue, 21 Nov 2023 19:51:40 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SZJ5Q3Q8zz4xWQ;
 Tue, 21 Nov 2023 19:51:38 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 3/4] ppc/pnv: PNV I2C engines assigned incorrect XSCOM addresses
Date: Tue, 21 Nov 2023 09:51:23 +0100
Message-ID: <20231121085124.396578-4-clg@kaod.org>
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
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

The PNV I2C engines for power9 and power10 were being assigned a base
XSCOM address that was off by one I2C engine's address range such
that engine 0 had engine 1's address and so on.  The xscom address
assignment was being based on the device tree engine numbering, which
starts at 1.  Rather than changing the device tree numbering to start
with 0, the addressing was changed to be based on the existing device
tree numbers minus one.

Fixes: 1ceda19c28a1 ("ppc/pnv: Connect PNV I2C controller to powernv10)
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv.c     | 6 ++++--
 hw/ppc/pnv_i2c.c | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 9c2972733784..0297871bdd5d 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1623,7 +1623,8 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
             return;
         }
         pnv_xscom_add_subregion(chip, PNV9_XSCOM_I2CM_BASE +
-                               chip9->i2c[i].engine * PNV9_XSCOM_I2CM_SIZE,
+                                (chip9->i2c[i].engine - 1) *
+                                        PNV9_XSCOM_I2CM_SIZE,
                                 &chip9->i2c[i].xscom_regs);
         qdev_connect_gpio_out(DEVICE(&chip9->i2c[i]), 0,
                               qdev_get_gpio_in(DEVICE(&chip9->psi),
@@ -1871,7 +1872,8 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
             return;
         }
         pnv_xscom_add_subregion(chip, PNV10_XSCOM_I2CM_BASE +
-                                chip10->i2c[i].engine * PNV10_XSCOM_I2CM_SIZE,
+                                (chip10->i2c[i].engine - 1) *
+                                        PNV10_XSCOM_I2CM_SIZE,
                                 &chip10->i2c[i].xscom_regs);
         qdev_connect_gpio_out(DEVICE(&chip10->i2c[i]), 0,
                               qdev_get_gpio_in(DEVICE(&chip10->psi),
diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
index 483d91d15a77..384442f898bf 100644
--- a/hw/ppc/pnv_i2c.c
+++ b/hw/ppc/pnv_i2c.c
@@ -594,7 +594,7 @@ static int pnv_i2c_dt_xscom(PnvXScomInterface *dev, void *fdt,
     int i2c_offset;
     const char i2c_compat[] = "ibm,power8-i2cm\0ibm,power9-i2cm";
     uint32_t i2c_pcba = PNV9_XSCOM_I2CM_BASE +
-        i2c->engine * PNV9_XSCOM_I2CM_SIZE;
+        (i2c->engine - 1) * PNV9_XSCOM_I2CM_SIZE;
     uint32_t reg[2] = {
         cpu_to_be32(i2c_pcba),
         cpu_to_be32(PNV9_XSCOM_I2CM_SIZE)
-- 
2.42.0


