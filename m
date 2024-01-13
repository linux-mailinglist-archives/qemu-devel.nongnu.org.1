Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F85482CA15
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 06:58:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOX1Y-0007NS-DW; Sat, 13 Jan 2024 00:57:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rOX1W-0007NA-CT
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 00:57:38 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rOX1U-00080d-VB
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 00:57:38 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id CC65060A1C;
 Sat, 13 Jan 2024 05:57:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF9BC433F1;
 Sat, 13 Jan 2024 05:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705125455;
 bh=0yPQV6qryJK1G6FSn0cxJJf29iihOzbG0wiZ/T7WCYw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SgAX2EftHV3dDI4c0442KRC7/VEC5nw+fOY/WOrKaSS+fBTWUz3fzqySKb3Nw31wN
 0GGUMLkz5ZGBsEyftg0qpfusIkUvq9zLLGtIP3sSuRroP6K7OFBWSNftktwc7yAu+M
 nnD9tg1VHqXvT0RAgJRsJffopCtv8fJmSdE+uUA6G2ROkNRsKijbDm02n0tS2q9eqS
 nr2u7yiz02440yHMjhhizMYEIa8QDlG34eb5tpnOhRKfIzqlRRvhgICWN/YMCs18ED
 yUGZOQZ+VXe1WgeG5BOYBxF8ILNyb4XfBUAoVg17iJR7r86bn8lRDyIlxrh46DFjqN
 VAk+2ALSmJHWw==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 02/10] hw/hppa/machine: Disable default devices with
 --nodefaults option
Date: Sat, 13 Jan 2024 06:57:20 +0100
Message-ID: <20240113055729.4480-3-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113055729.4480-1-deller@kernel.org>
References: <20240113055729.4480-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -64
X-Spam_score: -6.5
X-Spam_bar: ------
X-Spam_report: (-6.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.09,
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

Recognize the qemu --nodefaults option, which will disable the
following default devices on hppa:
- lsi53c895a SCSI controller,
- artist graphics card,
- LASI 82596 NIC,
- tulip PCI NIC,
- second serial PCI card,
- USB OHCI controller.

Adding this option is very useful to allow manual testing and
debugging of the other possible devices on the command line.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/hppa/machine.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index b11907617e..54ca2fd91a 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -346,8 +346,10 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
     SysBusDevice *s;
 
     /* SCSI disk setup. */
-    dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
-    lsi53c8xx_handle_legacy_cmdline(dev);
+    if (drive_get_max_bus(IF_SCSI) >= 0) {
+        dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
+        lsi53c8xx_handle_legacy_cmdline(dev);
+    }
 
     /* Graphics setup. */
     if (machine->enable_graphics && vga_interface_type != VGA_NONE) {
@@ -360,7 +362,7 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
     }
 
     /* Network setup. */
-    if (enable_lasi_lan()) {
+    if (nd_table[0].used && enable_lasi_lan()) {
         lasi_82596_init(addr_space, translate(NULL, LASI_LAN_HPA),
                         qdev_get_gpio_in(lasi_dev, LASI_IRQ_LAN_HPA));
     }
@@ -385,7 +387,7 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
     pci_set_word(&pci_dev->config[PCI_SUBSYSTEM_ID], 0x1227); /* Powerbar */
 
     /* create a second serial PCI card when running Astro */
-    if (!lasi_dev) {
+    if (serial_hd(1) && !lasi_dev) {
         pci_dev = pci_new(-1, "pci-serial-4x");
         qdev_prop_set_chr(DEVICE(pci_dev), "chardev1", serial_hd(1));
         qdev_prop_set_chr(DEVICE(pci_dev), "chardev2", serial_hd(2));
-- 
2.43.0


