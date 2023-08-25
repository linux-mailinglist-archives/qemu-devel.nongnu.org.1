Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E70DD78870B
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 14:22:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZVp2-0003xK-5N; Fri, 25 Aug 2023 08:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1qZVoZ-0003wC-Ed; Fri, 25 Aug 2023 08:21:24 -0400
Received: from relay3-d.mail.gandi.net ([2001:4b98:dc4:8::223])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1qZVoW-0004wV-Ka; Fri, 25 Aug 2023 08:21:22 -0400
Received: by mail.gandi.net (Postfix) with ESMTPSA id D79F060003;
 Fri, 25 Aug 2023 12:21:17 +0000 (UTC)
From: Jean-Christophe Dubois <jcd@tribudubois.net>
To: qemu-arm@nongnu.org
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 1/6] Remove i.MX7 IOMUX GPR device from i.MX6UL
Date: Fri, 25 Aug 2023 14:20:51 +0200
Message-Id: <48681bf51ee97646479bb261bee19abebbc8074e.1692964892.git.jcd@tribudubois.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1692964891.git.jcd@tribudubois.net>
References: <cover.1692964891.git.jcd@tribudubois.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jcd@tribudubois.net
Received-SPF: pass client-ip=2001:4b98:dc4:8::223;
 envelope-from=jcd@tribudubois.net; helo=relay3-d.mail.gandi.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

i.MX7 IOMUX GPR device is not equivalent to i.MX6UL IOMUXC GPR device.
In particular, register 22 is not present on i.MX6UL and this is actualy
The only register that is really emulated in the i.MX7 IOMUX GPR device.

Note: The i.MX6UL code is actually also implementing the IOMUX GPR device
as an unimplemented device at the same bus adress and the 2 instantiations
were actualy colliding. So we go back to the unimplemented device for now.

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
---
 hw/arm/fsl-imx6ul.c         | 11 -----------
 include/hw/arm/fsl-imx6ul.h |  2 --
 2 files changed, 13 deletions(-)

diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 2189dcbb72..0fdd2782ba 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -63,11 +63,6 @@ static void fsl_imx6ul_init(Object *obj)
      */
     object_initialize_child(obj, "snvs", &s->snvs, TYPE_IMX7_SNVS);
 
-    /*
-     * GPR
-     */
-    object_initialize_child(obj, "gpr", &s->gpr, TYPE_IMX7_GPR);
-
     /*
      * GPIOs 1 to 5
      */
@@ -537,12 +532,6 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
                                             FSL_IMX6UL_WDOGn_IRQ[i]));
     }
 
-    /*
-     * GPR
-     */
-    sysbus_realize(SYS_BUS_DEVICE(&s->gpr), &error_abort);
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpr), 0, FSL_IMX6UL_IOMUXC_GPR_ADDR);
-
     /*
      * SDMA
      */
diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index 9ee15ae38d..3bec6bb3fb 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -22,7 +22,6 @@
 #include "hw/misc/imx6ul_ccm.h"
 #include "hw/misc/imx6_src.h"
 #include "hw/misc/imx7_snvs.h"
-#include "hw/misc/imx7_gpr.h"
 #include "hw/intc/imx_gpcv2.h"
 #include "hw/watchdog/wdt_imx2.h"
 #include "hw/gpio/imx_gpio.h"
@@ -74,7 +73,6 @@ struct FslIMX6ULState {
     IMX6SRCState       src;
     IMX7SNVSState      snvs;
     IMXGPCv2State      gpcv2;
-    IMX7GPRState       gpr;
     IMXSPIState        spi[FSL_IMX6UL_NUM_ECSPIS];
     IMXI2CState        i2c[FSL_IMX6UL_NUM_I2CS];
     IMXSerialState     uart[FSL_IMX6UL_NUM_UARTS];
-- 
2.34.1


