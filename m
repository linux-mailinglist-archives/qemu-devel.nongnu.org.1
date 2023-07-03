Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CC3745D45
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:28:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJZs-0003HP-Jv; Mon, 03 Jul 2023 09:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGJZp-00031t-6H
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:26:49 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGJZn-0000xV-CA
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:26:48 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qvmsy4V9Tz4wxS;
 Mon,  3 Jul 2023 23:26:46 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qvmsw1MHJz4wxq;
 Mon,  3 Jul 2023 23:26:43 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bin.meng@windriver.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 30/32] hw/arm/aspeed: Set boot device to emmc
Date: Mon,  3 Jul 2023 15:25:07 +0200
Message-ID: <20230703132509.2474225-31-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703132509.2474225-1-clg@kaod.org>
References: <20230703132509.2474225-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=mKPa=CV=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

From: Joel Stanley <joel@jms.id.au>

This must be configurable by the user, as it forces a the u-boot SPL to
use the eMMC device to boot.

Signed-off-by: Joel Stanley <joel@jms.id.au>
[ clg: activated support on rainier ]
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/misc/aspeed_scu.h | 7 +++++++
 hw/arm/aspeed.c              | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
index 5c7c04eedfa7..d48ecf48b8fa 100644
--- a/include/hw/misc/aspeed_scu.h
+++ b/include/hw/misc/aspeed_scu.h
@@ -361,4 +361,11 @@ uint32_t aspeed_scu_get_apb_freq(AspeedSCUState *s);
  */
 #define SCU_AST1030_CLK_GET_PCLK_DIV(x)                    (((x) >> 8) & 0xf)
 
+/* STRAP1 SCU500 */
+#define AST26500_HW_STRAP_BOOT_SRC_EMMC            (0x1 << 2)
+#define AST26500_HW_STRAP_BOOT_SRC_SPI             (0x0 << 2)
+
+/* STRAP2 SCU510 */
+#define AST26500_HW_STRAP_BOOT_SRC_UART            (0x1 << 8)
+
 #endif /* ASPEED_SCU_H */
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 2cb51ffd8d49..00fd3c2e4e8a 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -179,11 +179,11 @@ struct AspeedMachineState {
 #define AST2600_EVB_HW_STRAP2 0x00000003
 
 /* Tacoma hardware value */
-#define TACOMA_BMC_HW_STRAP1  0x00000000
+#define TACOMA_BMC_HW_STRAP1  (0x00000000 | AST26500_HW_STRAP_BOOT_SRC_EMMC)
 #define TACOMA_BMC_HW_STRAP2  0x00000040
 
 /* Rainier hardware value: (QEMU prototype) */
-#define RAINIER_BMC_HW_STRAP1 0x00422016
+#define RAINIER_BMC_HW_STRAP1 (0x00422016 | AST26500_HW_STRAP_BOOT_SRC_EMMC)
 #define RAINIER_BMC_HW_STRAP2 0x80000848
 
 /* Fuji hardware value */
-- 
2.41.0


