Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3DB827192
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 15:40:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMqlr-0006Xb-Ro; Mon, 08 Jan 2024 09:38:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rMqlg-0006Td-KR
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 09:38:22 -0500
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rMqld-0007mX-91
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 09:38:20 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 97A8DCE119B;
 Mon,  8 Jan 2024 14:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CFDC433C9;
 Mon,  8 Jan 2024 14:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704724687;
 bh=oaMIfnlI/vyznx8Vsna73wbJCQNRediFZRBx4P/PiJk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kzkFEmt5bQGd0pQqydWHg4A8g1QEICrPwMcrEfPJig0ID48Q2fJRgkBHohpk7ujOV
 +zkIPU9jwUdkFMIg9boJ560kFAOGo21OtHkQ9AfhRykSWY+ZWGEcD/SiHKS2ALs5pR
 N6Imd4SZAn2hQVGqHMle0NLBuvPFXE1FeV3OOJ3UbWmCa32yTce9X6/FPSB9/4Dtp0
 NDZFhmxo4pvpGPenAi+izjUGsuHo/WVLRArIrnCRAphag9t43AsjNmnbnaihuOUreO
 I4mzhL2xGM7u565erg4hlS8qdQHrxhc4DDT64FhcgI8WVG5OLLULwM9VhWk/dbw+gI
 ImL7Ew7MszYJQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 2/9] hw/hppa/machine: Disable default devices with --nodefaults
 option
Date: Mon,  8 Jan 2024 15:37:55 +0100
Message-ID: <20240108143802.50256-3-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108143802.50256-1-deller@kernel.org>
References: <20240108143802.50256-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.73.55; envelope-from=deller@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -66
X-Spam_score: -6.7
X-Spam_bar: ------
X-Spam_report: (-6.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Helge Deller <deller@gmx.de>

Add support for the qemu --nodefaults option, which will disable the
following default devices:
- lsi53c895a SCSI controller,
- artist graphics card,
- LASI 82596 NIC,
- tulip PCI NIC,
- second serial PCI card,
- USB OHCI controller.

Adding this option is very useful to allow manual testing and
debugging of the other possible devices on the command line.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/machine.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index b11907617e..8017002a2a 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -346,11 +346,14 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
     SysBusDevice *s;
 
     /* SCSI disk setup. */
-    dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
-    lsi53c8xx_handle_legacy_cmdline(dev);
+    if (defaults_enabled()) {
+        dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
+        lsi53c8xx_handle_legacy_cmdline(dev);
+    }
 
     /* Graphics setup. */
-    if (machine->enable_graphics && vga_interface_type != VGA_NONE) {
+    if (defaults_enabled() && machine->enable_graphics &&
+        vga_interface_type != VGA_NONE) {
         vga_interface_created = true;
         dev = qdev_new("artist");
         s = SYS_BUS_DEVICE(dev);
@@ -360,7 +363,7 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
     }
 
     /* Network setup. */
-    if (enable_lasi_lan()) {
+    if (defaults_enabled() && enable_lasi_lan()) {
         lasi_82596_init(addr_space, translate(NULL, LASI_LAN_HPA),
                         qdev_get_gpio_in(lasi_dev, LASI_IRQ_LAN_HPA));
     }
@@ -385,7 +388,7 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
     pci_set_word(&pci_dev->config[PCI_SUBSYSTEM_ID], 0x1227); /* Powerbar */
 
     /* create a second serial PCI card when running Astro */
-    if (!lasi_dev) {
+    if (defaults_enabled() && !lasi_dev) {
         pci_dev = pci_new(-1, "pci-serial-4x");
         qdev_prop_set_chr(DEVICE(pci_dev), "chardev1", serial_hd(1));
         qdev_prop_set_chr(DEVICE(pci_dev), "chardev2", serial_hd(2));
@@ -395,7 +398,7 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
     }
 
     /* create USB OHCI controller for USB keyboard & mouse on Astro machines */
-    if (!lasi_dev && machine->enable_graphics) {
+    if (defaults_enabled() && !lasi_dev && machine->enable_graphics) {
         pci_create_simple(pci_bus, -1, "pci-ohci");
         usb_create_simple(usb_bus_find(-1), "usb-kbd");
         usb_create_simple(usb_bus_find(-1), "usb-mouse");
-- 
2.43.0


