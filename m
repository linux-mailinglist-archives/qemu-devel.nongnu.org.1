Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E96A745D94
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:37:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJZv-0003dE-Hu; Mon, 03 Jul 2023 09:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGJZs-0003PA-OW
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:26:52 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGJZq-0000xV-FZ
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:26:52 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qvmt14LwLz4wxn;
 Mon,  3 Jul 2023 23:26:49 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qvmsz1C0kz4wZp;
 Mon,  3 Jul 2023 23:26:46 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bin.meng@windriver.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 31/32] aspeed: Set bootconfig
Date: Mon,  3 Jul 2023 15:25:08 +0200
Message-ID: <20230703132509.2474225-32-clg@kaod.org>
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

This value is taken from a running Rainier machine. It sets bit 3
(select boot0) and bit 6 (enable).

Signed-off-by: Joel Stanley <joel@jms.id.au>
[ clg: Check HW strapping to choose the boot device ]
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/arm/aspeed_soc.h |  1 +
 hw/arm/aspeed.c             | 14 ++++++++++----
 hw/arm/aspeed_ast2600.c     |  1 +
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 8adff7007286..17ded3e1fd18 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -118,6 +118,7 @@ struct AspeedSoCClass {
     const hwaddr *memmap;
     uint32_t num_cpus;
     qemu_irq (*get_irq)(AspeedSoCState *s, int dev);
+    bool boot_emmc;
 };
 
 
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 00fd3c2e4e8a..6631552358d1 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -319,7 +319,8 @@ void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
     }
 }
 
-static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, bool emmc)
+static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, bool emmc,
+                               bool boot_emmc)
 {
         DeviceState *card;
 
@@ -329,6 +330,7 @@ static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, bool emmc)
         card = qdev_new(emmc ? TYPE_EMMC : TYPE_SD_CARD);
         if (emmc) {
             qdev_prop_set_uint8(card, "spec_version", SD_PHY_SPECv3_01_VERS);
+            qdev_prop_set_uint8(card, "boot-config", boot_emmc ? 0x48 : 0x0);
         }
         qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
                                 &error_fatal);
@@ -361,11 +363,15 @@ static void aspeed_machine_init(MachineState *machine)
     int i;
     NICInfo *nd = &nd_table[0];
     DriveInfo *emmc0 = NULL;
+    bool boot_emmc;
 
     object_initialize_child(OBJECT(machine), "soc", &bmc->soc, amc->soc_name);
 
     sc = ASPEED_SOC_GET_CLASS(&bmc->soc);
 
+    boot_emmc = sc->boot_emmc &&
+        !!(amc->hw_strap1 & AST26500_HW_STRAP_BOOT_SRC_EMMC);
+
     /*
      * This will error out if the RAM size is not supported by the
      * memory controller of the SoC.
@@ -432,19 +438,19 @@ static void aspeed_machine_init(MachineState *machine)
 
     for (i = 0; i < bmc->soc.sdhci.num_slots; i++) {
         sdhci_attach_drive(&bmc->soc.sdhci.slots[i],
-                           drive_get(IF_SD, 0, i), false);
+                           drive_get(IF_SD, 0, i), false, false);
     }
 
     if (bmc->soc.emmc.num_slots) {
         emmc0 = drive_get(IF_SD, 0, bmc->soc.sdhci.num_slots);
-        sdhci_attach_drive(&bmc->soc.emmc.slots[0], emmc0, true);
+        sdhci_attach_drive(&bmc->soc.emmc.slots[0], emmc0, true, boot_emmc);
     }
 
     if (!bmc->mmio_exec) {
         DeviceState *dev = ssi_get_cs(bmc->soc.fmc.spi, 0);
         BlockBackend *fmc0 = dev ? m25p80_get_blk(dev) : NULL;
 
-        if (fmc0) {
+        if (fmc0 && !boot_emmc) {
             uint64_t rom_size = memory_region_size(&bmc->soc.spi_boot);
             aspeed_install_boot_rom(bmc, fmc0, rom_size);
         } else if (emmc0) {
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index a8b3a8065a11..9d7551b109df 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -644,6 +644,7 @@ static void aspeed_soc_ast2600_class_init(ObjectClass *oc, void *data)
     sc->memmap       = aspeed_soc_ast2600_memmap;
     sc->num_cpus     = 2;
     sc->get_irq      = aspeed_soc_ast2600_get_irq;
+    sc->boot_emmc    = true;
 }
 
 static const TypeInfo aspeed_soc_ast2600_type_info = {
-- 
2.41.0


