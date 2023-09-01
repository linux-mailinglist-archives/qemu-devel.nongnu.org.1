Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1847778FB43
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 11:43:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc0gI-0002S9-I8; Fri, 01 Sep 2023 05:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=SnXb=ER=kaod.org=clg@ozlabs.org>)
 id 1qc0g3-0001w9-Jj; Fri, 01 Sep 2023 05:42:55 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=SnXb=ER=kaod.org=clg@ozlabs.org>)
 id 1qc0fv-00032X-GH; Fri, 01 Sep 2023 05:42:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RcY3m15Pqz4x2b;
 Fri,  1 Sep 2023 19:42:44 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RcY3k4XNZz4wy6;
 Fri,  1 Sep 2023 19:42:42 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Subject: [PULL 10/26] aspeed: Create flash devices only when defaults are
 enabled
Date: Fri,  1 Sep 2023 11:41:58 +0200
Message-ID: <20230901094214.296918-11-clg@kaod.org>
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

When the -nodefaults option is set, flash devices should be created
with :

    -blockdev node-name=fmc0,driver=file,filename=./flash.img \
    -device mx66u51235f,cs=0x0,bus=ssi.0,drive=fmc0 \

To be noted that in this case, the ROM will not be installed and the
initial boot sequence (U-Boot loading) will fetch instructions using
SPI transactions which is significantly slower. That's exactly how HW
operates though.

Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 docs/system/arm/aspeed.rst | 35 +++++++++++++++++++++++++++++------
 hw/arm/aspeed.c            |  6 ++++--
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index 80538422a1a4..b2dea54eedad 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -104,7 +104,7 @@ To boot a kernel directly from a Linux build tree:
         -dtb arch/arm/boot/dts/aspeed-ast2600-evb.dtb \
         -initrd rootfs.cpio
 
-The image should be attached as an MTD drive. Run :
+To boot the machine from the flash image, use an MTD drive :
 
 .. code-block:: bash
 
@@ -117,23 +117,46 @@ Options specific to Aspeed machines are :
    device by using the FMC controller to load the instructions, and
    not simply from RAM. This takes a little longer.
 
- * ``fmc-model`` to change the FMC Flash model. FW needs support for
-   the chip model to boot.
+ * ``fmc-model`` to change the default FMC Flash model. FW needs
+   support for the chip model to boot.
 
- * ``spi-model`` to change the SPI Flash model.
+ * ``spi-model`` to change the default SPI Flash model.
 
  * ``bmc-console`` to change the default console device. Most of the
    machines use the ``UART5`` device for a boot console, which is
    mapped on ``/dev/ttyS4`` under Linux, but it is not always the
    case.
 
-For instance, to start the ``ast2500-evb`` machine with a different
-FMC chip and a bigger (64M) SPI chip, use :
+To use other flash models, for instance a different FMC chip and a
+bigger (64M) SPI for the ``ast2500-evb`` machine, run :
 
 .. code-block:: bash
 
   -M ast2500-evb,fmc-model=mx25l25635e,spi-model=mx66u51235f
 
+When more flexibility is needed to define the flash devices, to use
+different flash models or define all flash devices (up to 8), the
+``-nodefaults`` QEMU option can be used to avoid creating the default
+flash devices.
+
+Flash devices should then be created from the command line and attached
+to a block device :
+
+.. code-block:: bash
+
+  $ qemu-system-arm -M ast2600-evb \
+        -blockdev node-name=fmc0,driver=file,filename=/path/to/fmc0.img \
+	-device mx66u51235f,bus=ssi.0,cs=0x0,drive=fmc0 \
+	-blockdev node-name=fmc1,driver=file,filename=/path/to/fmc1.img \
+	-device mx66u51235f,bus=ssi.0,cs=0x1,drive=fmc1 \
+	-blockdev node-name=spi1,driver=file,filename=/path/to/spi1.img \
+	-device mx66u51235f,cs=0x0,bus=ssi.1,drive=spi1 \
+	-nographic -nodefaults
+
+In that case, the machine boots fetching instructions from the FMC0
+device. It is slower to start but closer to what HW does. Using the
+machine option ``execute-in-place`` has a similar effect.
+
 To change the boot console and use device ``UART3`` (``/dev/ttyS2``
 under Linux), use :
 
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index cd92cf9ce0bb..271512ce5ced 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -396,12 +396,14 @@ static void aspeed_machine_init(MachineState *machine)
     connect_serial_hds_to_uarts(bmc);
     qdev_realize(DEVICE(&bmc->soc), NULL, &error_abort);
 
-    aspeed_board_init_flashes(&bmc->soc.fmc,
+    if (defaults_enabled()) {
+        aspeed_board_init_flashes(&bmc->soc.fmc,
                               bmc->fmc_model ? bmc->fmc_model : amc->fmc_model,
                               amc->num_cs, 0);
-    aspeed_board_init_flashes(&bmc->soc.spi[0],
+        aspeed_board_init_flashes(&bmc->soc.spi[0],
                               bmc->spi_model ? bmc->spi_model : amc->spi_model,
                               1, amc->num_cs);
+    }
 
     if (machine->kernel_filename && sc->num_cpus > 1) {
         /* With no u-boot we must set up a boot stub for the secondary CPU */
-- 
2.41.0


