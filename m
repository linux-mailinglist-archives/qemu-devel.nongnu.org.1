Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D26731F5D
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 19:38:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9qt6-0000dd-Ow; Thu, 15 Jun 2023 13:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=xCJj=CD=kaod.org=clg@ozlabs.org>)
 id 1q9qt1-0000bo-FN; Thu, 15 Jun 2023 13:35:55 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=xCJj=CD=kaod.org=clg@ozlabs.org>)
 id 1q9qsx-0007ha-OV; Thu, 15 Jun 2023 13:35:54 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QhqFb1SHlz4x1R;
 Fri, 16 Jun 2023 03:35:47 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QhqFX5LZQz4x0H;
 Fri, 16 Jun 2023 03:35:44 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>
Subject: [PULL 3/6] aspeed: Introduce a boot_rom region at the machine level
Date: Thu, 15 Jun 2023 19:35:22 +0200
Message-Id: <20230615173525.428831-4-clg@kaod.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230615173525.428831-1-clg@kaod.org>
References: <20230615173525.428831-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=xCJj=CD=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

This should also avoid Coverity to report a memory leak warning when
the QEMU process exits. See CID 1508061.

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/arm/aspeed.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index bfc2070bd2ed..76a1e7303de1 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -40,6 +40,7 @@ struct AspeedMachineState {
     /* Public */
 
     AspeedSoCState soc;
+    MemoryRegion boot_rom;
     bool mmio_exec;
     char *fmc_model;
     char *spi_model;
@@ -275,15 +276,15 @@ static void write_boot_rom(BlockBackend *blk, hwaddr addr, size_t rom_size,
  * Create a ROM and copy the flash contents at the expected address
  * (0x0). Boots faster than execute-in-place.
  */
-static void aspeed_install_boot_rom(AspeedSoCState *soc, BlockBackend *blk,
+static void aspeed_install_boot_rom(AspeedMachineState *bmc, BlockBackend *blk,
                                     uint64_t rom_size)
 {
-    MemoryRegion *boot_rom = g_new(MemoryRegion, 1);
+    AspeedSoCState *soc = &bmc->soc;
 
-    memory_region_init_rom(boot_rom, NULL, "aspeed.boot_rom", rom_size,
+    memory_region_init_rom(&bmc->boot_rom, NULL, "aspeed.boot_rom", rom_size,
                            &error_abort);
     memory_region_add_subregion_overlap(&soc->spi_boot_container, 0,
-                                        boot_rom, 1);
+                                        &bmc->boot_rom, 1);
     write_boot_rom(blk, ASPEED_SOC_SPI_BOOT_ADDR, rom_size, &error_abort);
 }
 
@@ -431,8 +432,7 @@ static void aspeed_machine_init(MachineState *machine)
 
         if (mtd0) {
             uint64_t rom_size = memory_region_size(&bmc->soc.spi_boot);
-            aspeed_install_boot_rom(&bmc->soc, blk_by_legacy_dinfo(mtd0),
-                                    rom_size);
+            aspeed_install_boot_rom(bmc, blk_by_legacy_dinfo(mtd0), rom_size);
         }
     }
 
-- 
2.40.1


