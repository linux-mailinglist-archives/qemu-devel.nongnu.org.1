Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF50831379
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 08:58:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQNGj-0007fr-8n; Thu, 18 Jan 2024 02:56:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNGS-0007JN-O5; Thu, 18 Jan 2024 02:56:42 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNGP-0007w8-78; Thu, 18 Jan 2024 02:56:39 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CCD3D45049;
 Thu, 18 Jan 2024 10:54:36 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0315A661B1;
 Thu, 18 Jan 2024 10:54:07 +0300 (MSK)
Received: (nullmailer pid 2381719 invoked by uid 1000);
 Thu, 18 Jan 2024 07:54:05 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.1 30/38] hw/hppa/machine: Disable default devices with
 --nodefaults option
Date: Thu, 18 Jan 2024 10:52:57 +0300
Message-Id: <20240118075404.2381519-30-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
References: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
(cherry picked from commit d8a3220005d74512677b181e3a32cd94b13ddf49)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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
2.39.2


