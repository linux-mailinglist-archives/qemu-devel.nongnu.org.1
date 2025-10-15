Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DF7BDCB61
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Oct 2025 08:25:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8uux-0001H8-Eu; Wed, 15 Oct 2025 02:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v8uuv-0001Dm-CK; Wed, 15 Oct 2025 02:23:21 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v8uus-0002xW-ND; Wed, 15 Oct 2025 02:23:20 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 15 Oct
 2025 14:22:12 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 15 Oct 2025 14:22:12 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v1 07/12] hw/arm/aspeed_ast27x0-fc: Map FMC0 flash contents
 into CA35 boot ROM
Date: Wed, 15 Oct 2025 14:22:02 +0800
Message-ID: <20251015062210.3128710-8-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015062210.3128710-1-jamin_lin@aspeedtech.com>
References: <20251015062210.3128710-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

This patch introduces a dedicated ca35_boot_rom memory region and
copies the FMC0 flash data into it.

The motivation is to support the upcoming vbootrom. The vbootrom
replaces the existing BOOTMCU (RISC-V 32 SPL) flow, which currently reads
the "image-bmc" from FMC_CS0 and loads the following components
into DRAM:

- Trusted Firmware-A
- OP-TEE OS
- u-boot-nodtb.bin
- u-boot.dtb

After loading, BOOTMCU releases the CA35 reset so that CA35 can start
executing Trusted Firmware-A.

The vbootrom follows the same sequence: CA35 fetches "image-bmc" from FMC0
flash at the SPI boot ROM base address (0x100000000), parses the FIT image,
loads each component into its designated DRAM location, and then jumps to
Trusted Firmware-A.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast27x0-fc.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index 99af87dbd7..99c0b34159 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -35,6 +35,7 @@ struct Ast2700FCState {
 
     MemoryRegion ca35_memory;
     MemoryRegion ca35_dram;
+    MemoryRegion ca35_boot_rom;
     MemoryRegion ssp_memory;
     MemoryRegion tsp_memory;
 
@@ -44,8 +45,6 @@ struct Ast2700FCState {
     Aspeed27x0SoCState ca35;
     Aspeed27x0CoprocessorState ssp;
     Aspeed27x0CoprocessorState tsp;
-
-    bool mmio_exec;
 };
 
 #define AST2700FC_BMC_RAM_SIZE (1 * GiB)
@@ -61,6 +60,9 @@ static bool ast2700fc_ca35_init(MachineState *machine, Error **errp)
     Ast2700FCState *s = AST2700A1FC(machine);
     AspeedSoCState *soc;
     AspeedSoCClass *sc;
+    BlockBackend *fmc0 = NULL;
+    DeviceState *dev = NULL;
+    uint64_t rom_size;
 
     object_initialize_child(OBJECT(s), "ca35", &s->ca35, "ast2700-a1");
     soc = ASPEED_SOC(&s->ca35);
@@ -112,6 +114,14 @@ static bool ast2700fc_ca35_init(MachineState *machine, Error **errp)
     ast2700fc_board_info.ram_size = machine->ram_size;
     ast2700fc_board_info.loader_start = sc->memmap[ASPEED_DEV_SDRAM];
 
+    dev = ssi_get_cs(soc->fmc.spi, 0);
+    fmc0 = dev ? m25p80_get_blk(dev) : NULL;
+
+    if (fmc0) {
+        rom_size = memory_region_size(&soc->spi_boot);
+        aspeed_install_boot_rom(soc, fmc0, &s->ca35_boot_rom, rom_size);
+    }
+
     arm_load_kernel(ARM_CPU(first_cpu), machine, &ast2700fc_board_info);
 
     return true;
-- 
2.43.0


