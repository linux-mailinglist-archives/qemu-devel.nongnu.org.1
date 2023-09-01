Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8E578FB3F
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 11:43:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc0fj-0001M8-5u; Fri, 01 Sep 2023 05:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=SnXb=ER=kaod.org=clg@ozlabs.org>)
 id 1qc0fg-0001LD-3X; Fri, 01 Sep 2023 05:42:32 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=SnXb=ER=kaod.org=clg@ozlabs.org>)
 id 1qc0fd-0002qV-Qa; Fri, 01 Sep 2023 05:42:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RcY3M4gZVz4x2b;
 Fri,  1 Sep 2023 19:42:23 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RcY3K5sDGz4wxW;
 Fri,  1 Sep 2023 19:42:21 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 01/26] aspeed: Introduce helper for 32-bit hosts limitation
Date: Fri,  1 Sep 2023 11:41:49 +0200
Message-ID: <20230901094214.296918-2-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230901094214.296918-1-clg@kaod.org>
References: <20230901094214.296918-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=SnXb=ER=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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

On 32-bit hosts, RAM has a 2047 MB limit. Use a macro to define the
default ram size of machines (AST2600 SoC) that can have 2 GB.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/arm/aspeed.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 263626abeae1..b922a2c491cc 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -47,6 +47,13 @@ struct AspeedMachineState {
     char *spi_model;
 };
 
+/* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
+#if HOST_LONG_BITS == 32
+#define ASPEED_RAM_SIZE(sz) MIN((sz), 1 * GiB)
+#else
+#define ASPEED_RAM_SIZE(sz) (sz)
+#endif
+
 /* Palmetto hardware value: 0x120CE416 */
 #define PALMETTO_BMC_HW_STRAP1 (                                        \
         SCU_AST2400_HW_STRAP_DRAM_SIZE(DRAM_SIZE_256MB) |               \
@@ -1423,12 +1430,7 @@ static void aspeed_machine_rainier_class_init(ObjectClass *oc, void *data)
         aspeed_soc_num_cpus(amc->soc_name);
 };
 
-/* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
-#if HOST_LONG_BITS == 32
-#define FUJI_BMC_RAM_SIZE (1 * GiB)
-#else
-#define FUJI_BMC_RAM_SIZE (2 * GiB)
-#endif
+#define FUJI_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
 
 static void aspeed_machine_fuji_class_init(ObjectClass *oc, void *data)
 {
@@ -1450,12 +1452,7 @@ static void aspeed_machine_fuji_class_init(ObjectClass *oc, void *data)
         aspeed_soc_num_cpus(amc->soc_name);
 };
 
-/* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
-#if HOST_LONG_BITS == 32
-#define BLETCHLEY_BMC_RAM_SIZE (1 * GiB)
-#else
-#define BLETCHLEY_BMC_RAM_SIZE (2 * GiB)
-#endif
+#define BLETCHLEY_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
 
 static void aspeed_machine_bletchley_class_init(ObjectClass *oc, void *data)
 {
-- 
2.41.0


