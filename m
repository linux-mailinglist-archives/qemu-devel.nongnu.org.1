Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B1376AED6
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 11:42:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQlt1-000418-SV; Tue, 01 Aug 2023 05:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=570bccec8=anthony.perard@citrix.com>)
 id 1qQlsm-0003uc-Mh
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 05:41:37 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=570bccec8=anthony.perard@citrix.com>)
 id 1qQlsk-0005G3-Su
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 05:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1690882894;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pMXoBWEjc1Ssgp4CnHdd/893qbjR4KzHJhnhynp7eic=;
 b=Znlq6/slRJKKYDgR3hKwyrquQb0OdY6dKqFKZwggqgyyRM1YZcod1CF0
 AZPc/wfN9kXjoK6nDfz8Ky3P2DlIlGNR19VdBQ/uoqcFE/kk63bxR/y1f
 QRl9pj+4+210iGHBmvL5UAH3zhqz3RQ+f+jCCqPDZS4V9cSAmoOVGsFh9 0=;
Authentication-Results: esa4.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 120729031
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:MFkXyq3jcqQvm7VZpfbD5b5xkn2cJEfYwER7XKvMYLTBsI5bp2AEn
 GYZWjyFM6qLMzD8fd1+YYSx9hxU78fUytYxSARvpC1hF35El5HIVI+TRqvS04F+DeWYFR46s
 J9OAjXkBJppJpMJjk71atANlVEliefTAOK6ULWeUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tq3qMDEULOf82cc3lk8teTb8XuDgNyo4GlD5gNlPKgQ1LPjvyJ94Kw3dPnZw0TQGuG4LsbiL
 87fwbew+H/u/htFIrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRrukoPD9IOaF8/ttm8t4sZJ
 OOhF3CHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqFvnrSFL/hGVSkL0YMkFulfDk5D7
 tA+BAk3QQmj29mswa2GS/t+r5F2RCXrFNt3VnBIyDjYCbAtQIzZQrWM7thdtNsyrpkQR7CEP
 ZNfMGcxKk2aOHWjOX9OYH46tO6umnn4dSwesF+PrLA7y2PS0BZwwP7mN9+9ltmiHJ8NwRzJ/
 jmfl4j/KkkWG8zO9mGFyG29q972oQrrAtwwMKLto5aGh3XMnzdOWXX6T2CTuPS8lwuyVsxSL
 2QS/Swhq7V081akJvH6WxS2iHeJphAYVpxcHoUHBBqlk/SOpVzDXy5dE2AHMYZ93CMredA0/
 lCmksjFIxBWipKMaS6m7LaLkDKgKwFAeAfuehQ4oRs5D8jL+d9i1kKQEYw6SMZZnfWuR2iun
 mniQDwWwuxK0JVVj/jTEUXv2WrEm3TfcuIiCuw7tEqB5xgxWoOqbpfABbPzvacZd9bxorVsU
 RE5dymiAAMmV8vleNSlGrllIV1Qz6/t3MfgqVBuBYI90D+m5mSue4tdiBknehYxYpxUJWC1P
 BWM0e+02HO0FCL7BZKbnqrrU5h6pUQePYqNug/ogipmPcEqKV7vENBGbk+MxWH9+HXAYolmU
 ap3hf2EVC5AYYw+lWreegvo+eNzrszI7T+JFM+TItXO+eb2WUN5vp9fYAfXNL1os/ndyOgXm
 v4GX/a3J9xkeLWWSkHqHUQ7dw9iwaQTbXwul/FqSw==
IronPort-HdrOrdr: A9a23:fIZWAKy0OrCHcz6I7c9XKrPwT71zdoMgy1knxilNoH1uEvBw8v
 rEoB1173LJYVoqMk3I+urgBED/exzhHPdOiOEs1NyZMDUO1lHHEL1f
X-Talos-CUID: 9a23:COlktG1pHY1H+bjQbiS9wrxfFe8oaVH74E7qDFaYVV1zSaKoSE2C0fYx
X-Talos-MUID: 9a23:ySpnxQm036nYpbuCuHMkdno6OOh4spv1CHoSgLg3gvWtJXYuGROC2WE=
X-IronPort-AV: E=Sophos;i="6.01,246,1684814400"; d="scan'208";a="120729031"
To: <qemu-devel@nongnu.org>
CC: Olaf Hering <olaf@aepfle.de>, Anthony PERARD <anthony.perard@citrix.com>
Subject: [PULL 5/5] xen-platform: do full PCI reset during unplug of IDE
 devices
Date: Tue, 1 Aug 2023 10:40:38 +0100
Message-ID: <20230801094038.11026-6-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230801094038.11026-1-anthony.perard@citrix.com>
References: <20230801094038.11026-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=216.71.155.144;
 envelope-from=prvs=570bccec8=anthony.perard@citrix.com;
 helo=esa4.hc3370-68.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  Anthony PERARD <anthony.perard@citrix.com>
From:  Anthony PERARD via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Olaf Hering <olaf@aepfle.de>

The IDE unplug function needs to reset the entire PCI device, to make
sure all state is initialized to defaults. This is done by calling
pci_device_reset, which resets not only the chip specific registers, but
also all PCI state. This fixes "unplug" in a Xen HVM domU with the
modular legacy xenlinux PV drivers.

Commit ee358e919e38 ("hw/ide/piix: Convert reset handler to
DeviceReset") changed the way how the the disks are unplugged. Prior
this commit the PCI device remained unchanged. After this change,
piix_ide_reset is exercised after the "unplug" command, which was not
the case prior that commit. This function resets the command register.
As a result the ata_piix driver inside the domU will see a disabled PCI
device. The generic PCI code will reenable the PCI device. On the qemu
side, this runs pci_default_write_config/pci_update_mappings. Here a
changed address is returned by pci_bar_address, this is the address
which was truncated in piix_ide_reset. In case of a Xen HVM domU, the
address changes from 0xc120 to 0xc100. This truncation was a bug in
piix_ide_reset, which was fixed in commit 230dfd9257 ("hw/ide/piix:
properly initialize the BMIBA register"). If pci_xen_ide_unplug had used
pci_device_reset, the PCI registers would have been properly reset, and
commit ee358e919e38 would have not introduced a regression for this
specific domU environment.

While the unplug is supposed to hide the IDE disks, the changed BMIBA
address broke the UHCI device. In case the domU has an USB tablet
configured, to recive absolute pointer coordinates for the GUI, it will
cause a hang during device discovery of the partly discovered USB hid
device. Reading the USBSTS word size register will fail. The access ends
up in the QEMU piix-bmdma device, instead of the expected uhci device.
Here a byte size request is expected, and a value of ~0 is returned. As
a result the UCHI driver sees an error state in the register, and turns
off the UHCI controller.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
Reviewed-by: Paul Durrant <paul@xen.org>
Message-Id: <20230720072950.20198-1-olaf@aepfle.de>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/i386/xen/xen_platform.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index 57f1d742c1..17457ff3de 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -164,8 +164,9 @@ static void pci_unplug_nics(PCIBus *bus)
  *
  * [1] https://xenbits.xen.org/gitweb/?p=xen.git;a=blob;f=docs/misc/hvm-emulated-unplug.pandoc
  */
-static void pci_xen_ide_unplug(DeviceState *dev, bool aux)
+static void pci_xen_ide_unplug(PCIDevice *d, bool aux)
 {
+    DeviceState *dev = DEVICE(d);
     PCIIDEState *pci_ide;
     int i;
     IDEDevice *idedev;
@@ -195,7 +196,7 @@ static void pci_xen_ide_unplug(DeviceState *dev, bool aux)
             blk_unref(blk);
         }
     }
-    device_cold_reset(dev);
+    pci_device_reset(d);
 }
 
 static void unplug_disks(PCIBus *b, PCIDevice *d, void *opaque)
@@ -210,7 +211,7 @@ static void unplug_disks(PCIBus *b, PCIDevice *d, void *opaque)
 
     switch (pci_get_word(d->config + PCI_CLASS_DEVICE)) {
     case PCI_CLASS_STORAGE_IDE:
-        pci_xen_ide_unplug(DEVICE(d), aux);
+        pci_xen_ide_unplug(d, aux);
         break;
 
     case PCI_CLASS_STORAGE_SCSI:
-- 
Anthony PERARD


