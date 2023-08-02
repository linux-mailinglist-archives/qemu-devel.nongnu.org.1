Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB3F76D930
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 23:09:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRJ59-00041a-Sr; Wed, 02 Aug 2023 17:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1qRJ57-00040Y-TV; Wed, 02 Aug 2023 17:08:33 -0400
Received: from relay9-d.mail.gandi.net ([2001:4b98:dc4:8::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1qRJ56-0007P1-4w; Wed, 02 Aug 2023 17:08:33 -0400
Received: by mail.gandi.net (Postfix) with ESMTPSA id AA9C1FF804;
 Wed,  2 Aug 2023 21:08:29 +0000 (UTC)
From: Jean-Christophe Dubois <jcd@tribudubois.net>
To: qemu-arm@nongnu.org
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 4/5] Add i.MX7 missing TZ devices and memory regions
Date: Wed,  2 Aug 2023 23:08:07 +0200
Message-Id: <5ee0e4c1fde379d1865e45ba38a3ff7fbb4741f4.1691010283.git.jcd@tribudubois.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1691010283.git.jcd@tribudubois.net>
References: <cover.1691010283.git.jcd@tribudubois.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jcd@tribudubois.net
Received-SPF: pass client-ip=2001:4b98:dc4:8::229;
 envelope-from=jcd@tribudubois.net; helo=relay9-d.mail.gandi.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
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

* Add TZASC as unimplemented device.
  - Allow bare metal application to access this (unimplemented) device
* Add CSU as unimplemented device.
  - Allow bare metal application to access this (unimplemented) device
* Add various memory segments
  - OCRAM
  - OCRAM EPDC
  - OCRAM PXP
  - OCRAM S
  - ROM
  - CAAM

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
---
 hw/arm/fsl-imx7.c         | 63 +++++++++++++++++++++++++++++++++++++++
 include/hw/arm/fsl-imx7.h |  7 +++++
 2 files changed, 70 insertions(+)

diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 3bb0da6850..7ca105fd24 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -666,6 +666,69 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("pcie-phy", FSL_IMX7_PCIE_PHY_ADDR,
                                 FSL_IMX7_PCIE_PHY_SIZE);
 
+    /*
+     * CSU
+     */
+    create_unimplemented_device("csu", FSL_IMX7_CSU_ADDR,
+                                FSL_IMX7_CSU_SIZE);
+
+    /*
+     * TZASC
+     */
+    create_unimplemented_device("tzasc", FSL_IMX7_TZASC_ADDR,
+                                FSL_IMX7_TZASC_SIZE);
+
+    /*
+     * OCRAM memory
+     */
+    memory_region_init_ram(&s->ocram, NULL, "imx7.ocram",
+                           FSL_IMX7_OCRAM_MEM_SIZE,
+                           &error_abort);
+    memory_region_add_subregion(get_system_memory(), FSL_IMX7_OCRAM_MEM_ADDR,
+                                &s->ocram);
+
+    /*
+     * OCRAM EPDC memory
+     */
+    memory_region_init_ram(&s->ocram_epdc, NULL, "imx7.ocram_epdc",
+                           FSL_IMX7_OCRAM_EPDC_SIZE,
+                           &error_abort);
+    memory_region_add_subregion(get_system_memory(), FSL_IMX7_OCRAM_EPDC_ADDR,
+                                &s->ocram_epdc);
+
+    /*
+     * OCRAM PXP memory
+     */
+    memory_region_init_ram(&s->ocram_pxp, NULL, "imx7.ocram_pxp",
+                           FSL_IMX7_OCRAM_PXP_SIZE,
+                           &error_abort);
+    memory_region_add_subregion(get_system_memory(), FSL_IMX7_OCRAM_PXP_ADDR,
+                                &s->ocram_pxp);
+
+    /*
+     * OCRAM_S memory
+     */
+    memory_region_init_ram(&s->ocram_s, NULL, "imx7.ocram_s",
+                           FSL_IMX7_OCRAM_S_SIZE,
+                           &error_abort);
+    memory_region_add_subregion(get_system_memory(), FSL_IMX7_OCRAM_S_ADDR,
+                                &s->ocram_s);
+
+    /*
+     * ROM memory
+     */
+    memory_region_init_rom(&s->rom, OBJECT(dev), "imx7.rom",
+                           FSL_IMX7_ROM_SIZE, &error_abort);
+    memory_region_add_subregion(get_system_memory(), FSL_IMX7_ROM_ADDR,
+                                &s->rom);
+
+    /*
+     * CAAM memory
+     */
+    memory_region_init_rom(&s->caam, OBJECT(dev), "imx7.caam",
+                           FSL_IMX7_CAAM_MEM_SIZE, &error_abort);
+    memory_region_add_subregion(get_system_memory(), FSL_IMX7_CAAM_MEM_ADDR,
+                                &s->caam);
 }
 
 static Property fsl_imx7_properties[] = {
diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index 9a7cc4e366..629c385987 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -84,6 +84,13 @@ struct FslIMX7State {
     IMX7GPRState       gpr;
     ChipideaState      usb[FSL_IMX7_NUM_USBS];
     DesignwarePCIEHost pcie;
+    MemoryRegion       rom;
+    MemoryRegion       caam;
+    MemoryRegion       ocram;
+    MemoryRegion       ocram_epdc;
+    MemoryRegion       ocram_pxp;
+    MemoryRegion       ocram_s;
+
     uint32_t           phy_num[FSL_IMX7_NUM_ETHS];
     bool               phy_connected[FSL_IMX7_NUM_ETHS];
 };
-- 
2.34.1


