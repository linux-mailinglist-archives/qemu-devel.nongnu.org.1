Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A238E788714
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 14:23:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZVp8-000473-4O; Fri, 25 Aug 2023 08:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1qZVoi-0003wu-Ca; Fri, 25 Aug 2023 08:21:34 -0400
Received: from relay3-d.mail.gandi.net ([2001:4b98:dc4:8::223])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1qZVob-0004xD-Ve; Fri, 25 Aug 2023 08:21:28 -0400
Received: by mail.gandi.net (Postfix) with ESMTPSA id E2E796000E;
 Fri, 25 Aug 2023 12:21:21 +0000 (UTC)
From: Jean-Christophe Dubois <jcd@tribudubois.net>
To: qemu-arm@nongnu.org
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 3/6] Add i.MX6UL missing devices.
Date: Fri, 25 Aug 2023 14:20:53 +0200
Message-Id: <59e4dc56e14eccfefd379275ec19048dff9c10b3.1692964892.git.jcd@tribudubois.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1692964891.git.jcd@tribudubois.net>
References: <cover.1692964891.git.jcd@tribudubois.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

* Add TZASC as unimplemented device.
  - Allow bare metal application to access this (unimplemented) device
* Add CSU as unimplemented device.
  - Allow bare metal application to access this (unimplemented) device
* Add 4 missing PWM devices

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/fsl-imx6ul.c         | 16 ++++++++++++++++
 include/hw/arm/fsl-imx6ul.h |  2 +-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 06a32aff64..e37b69a5e1 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -583,6 +583,10 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
             FSL_IMX6UL_PWM2_ADDR,
             FSL_IMX6UL_PWM3_ADDR,
             FSL_IMX6UL_PWM4_ADDR,
+            FSL_IMX6UL_PWM5_ADDR,
+            FSL_IMX6UL_PWM6_ADDR,
+            FSL_IMX6UL_PWM7_ADDR,
+            FSL_IMX6UL_PWM8_ADDR,
         };
 
         snprintf(name, NAME_SIZE, "pwm%d", i);
@@ -636,6 +640,18 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("lcdif", FSL_IMX6UL_LCDIF_ADDR,
                                 FSL_IMX6UL_LCDIF_SIZE);
 
+    /*
+     * CSU
+     */
+    create_unimplemented_device("csu", FSL_IMX6UL_CSU_ADDR,
+                                FSL_IMX6UL_CSU_SIZE);
+
+    /*
+     * TZASC
+     */
+    create_unimplemented_device("tzasc", FSL_IMX6UL_TZASC_ADDR,
+                                FSL_IMX6UL_TZASC_SIZE);
+
     /*
      * ROM memory
      */
diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index f7bf684b42..63012628ff 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -60,7 +60,7 @@ enum FslIMX6ULConfiguration {
     FSL_IMX6UL_NUM_USBS         = 2,
     FSL_IMX6UL_NUM_SAIS         = 3,
     FSL_IMX6UL_NUM_CANS         = 2,
-    FSL_IMX6UL_NUM_PWMS         = 4,
+    FSL_IMX6UL_NUM_PWMS         = 8,
 };
 
 struct FslIMX6ULState {
-- 
2.34.1


