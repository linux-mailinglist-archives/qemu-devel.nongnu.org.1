Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86621B52A06
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Sep 2025 09:32:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwbhk-0000nn-A1; Thu, 11 Sep 2025 03:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uwbgd-0007mk-5H; Thu, 11 Sep 2025 03:25:45 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uwbgY-0000j4-S0; Thu, 11 Sep 2025 03:25:40 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 11 Sep
 2025 15:24:55 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 11 Sep 2025 15:24:55 +0800
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <nabihestefan@google.com>, <wuhaotsh@google.com>, <titusr@google.com>
Subject: [PATCH v2 07/14] hw/arm/aspeed: Wire up PCIe devices in SoC model
Date: Thu, 11 Sep 2025 15:24:31 +0800
Message-ID: <20250911072452.314553-8-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911072452.314553-1-jamin_lin@aspeedtech.com>
References: <20250911072452.314553-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Add PCIe controller and PHY instances to the Aspeed SoC state and device
enum. This prepares the SoC model to host PCIe Root Complexes and their
associated PHYs.

Although the AST2600 supports only a single Root Complex, the AST2700
provides three Root Complexes. For this reason, the model defines arrays
of three PCIe config/PHY objects and enumerates three PCIe device IDs so
that both SoCs can be represented consistently.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/arm/aspeed_soc.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 217ef0eafd..79fe353f83 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -37,6 +37,7 @@
 #include "qom/object.h"
 #include "hw/misc/aspeed_lpc.h"
 #include "hw/misc/unimp.h"
+#include "hw/pci-host/aspeed_pcie.h"
 #include "hw/misc/aspeed_peci.h"
 #include "hw/fsi/aspeed_apb2opb.h"
 #include "hw/char/serial-mm.h"
@@ -49,6 +50,7 @@
 #define ASPEED_MACS_NUM  4
 #define ASPEED_UARTS_NUM 13
 #define ASPEED_JTAG_NUM  2
+#define ASPEED_PCIE_NUM  3
 
 struct AspeedSoCState {
     DeviceState parent;
@@ -87,6 +89,8 @@ struct AspeedSoCState {
     AspeedSDHCIState sdhci;
     AspeedSDHCIState emmc;
     AspeedLPCState lpc;
+    AspeedPCIECfgState pcie[ASPEED_PCIE_NUM];
+    AspeedPCIEPhyState pcie_phy[ASPEED_PCIE_NUM];
     AspeedPECIState peci;
     SerialMM uart[ASPEED_UARTS_NUM];
     Clock *sysclk;
@@ -254,6 +258,15 @@ enum {
     ASPEED_DEV_LPC,
     ASPEED_DEV_IBT,
     ASPEED_DEV_I2C,
+    ASPEED_DEV_PCIE0,
+    ASPEED_DEV_PCIE1,
+    ASPEED_DEV_PCIE2,
+    ASPEED_DEV_PCIE_PHY0,
+    ASPEED_DEV_PCIE_PHY1,
+    ASPEED_DEV_PCIE_PHY2,
+    ASPEED_DEV_PCIE_MMIO0,
+    ASPEED_DEV_PCIE_MMIO1,
+    ASPEED_DEV_PCIE_MMIO2,
     ASPEED_DEV_PECI,
     ASPEED_DEV_ETH1,
     ASPEED_DEV_ETH2,
-- 
2.43.0


