Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C1485724B
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Feb 2024 01:12:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raloJ-0007fg-5r; Thu, 15 Feb 2024 19:10:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1raloG-0007fI-3n; Thu, 15 Feb 2024 19:10:32 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1raloB-0006yL-Kq; Thu, 15 Feb 2024 19:10:31 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C296B4E602D;
 Fri, 16 Feb 2024 01:10:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id eu2Pfsm8kVmo; Fri, 16 Feb 2024 01:10:19 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 69A524E601F; Fri, 16 Feb 2024 01:10:19 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] docs/system/ppc: Document running Linux on AmigaNG machines
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, clg@kaod.org
Message-Id: <20240216001019.69A524E601F@zero.eik.bme.hu>
Date: Fri, 16 Feb 2024 01:10:19 +0100 (CET)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Documentation on how to run Linux on the amigaone, pegasos2 and
sam460ex machines is currently burried in the depths of the qemu-devel
mailing list and in the source code. Let's collect the information in
the QEMU handbook for a one stop solution.

Co-authored-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
Supersedes: <20231216123013.67978-1-shentey@gmail.com>

 MAINTAINERS                 |   1 +
 docs/system/ppc/amigang.rst | 160 ++++++++++++++++++++++++++++++++++++
 docs/system/target-ppc.rst  |   1 +
 3 files changed, 162 insertions(+)
 create mode 100644 docs/system/ppc/amigang.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index a24c2b51b6..8e5b47e7b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1560,6 +1560,7 @@ F: hw/rtc/m41t80.c
 F: pc-bios/canyonlands.dt[sb]
 F: pc-bios/u-boot-sam460ex-20100605.bin
 F: roms/u-boot-sam460ex
+F: docs/system/ppc/amigang.rst
 
 pegasos2
 M: BALATON Zoltan <balaton@eik.bme.hu>
diff --git a/docs/system/ppc/amigang.rst b/docs/system/ppc/amigang.rst
new file mode 100644
index 0000000000..c03a7e0d66
--- /dev/null
+++ b/docs/system/ppc/amigang.rst
@@ -0,0 +1,160 @@
+AmigaNG boards (``amigaone``, ``pegasos2``, ``sam460ex``)
+=========================================================
+
+These PowerPC machines emulate boards that are primarily used for
+running Amiga like OSes (AmigaOS 4, MorphOS and AROS) but these can
+also run Linux which is what this section documents.
+
+Eyetech AmigaOne/Mai Logic Teron (``amigaone``)
+===============================================
+
+The ``amigaone`` machine emulates an AmigaOne XE mainboard by Eyetech
+which is a rebranded Mai Logic Teron board with modified U-Boot
+firmware to support AmigaOS 4.
+
+Emulated devices
+----------------
+
+ * PowerPC 7457 CPU (can also use``-cpu g3, 750cxe, 750fx`` or ``750gx``)
+ * Articia S north bridge
+ * VIA VT82C686B south bridge
+ * PCI VGA compatible card (guests may need other card instead)
+ * PS/2 keyboard and mouse
+
+Firmware
+--------
+
+A firmware binary is necessary for the boot process. It is a modified
+U-Boot under GPL but its source is lost so it cannot be included in
+QEMU. A binary is available at
+https://www.hyperion-entertainment.com/index.php/downloads?view=files&parent=28.
+The ROM image is in the last 512kB which can be extracted with the
+following command:
+
+.. code-block:: bash
+
+  $ tail -c 524288 updater.image > u-boot-amigaone.bin
+
+The BIOS emulator in the firmware is unable to run QEMU‘s standard
+vgabios so ``VGABIOS-lgpl-latest.bin`` is needed instead which can be
+downloaded from http://www.nongnu.org/vgabios.
+
+Running Linux
+-------------
+
+There are some Linux images under the following link that work on the
+``amigaone`` machine:
+https://sourceforge.net/projects/amigaone-linux/files/debian-installer/.
+To boot the system run:
+
+.. code-block:: bash
+
+  $ qemu-system-ppc -machine amigaone -bios u-boot-amigaone.bin \
+                    -cdrom "A1 Linux Net Installer.iso" \
+                    -device ati-vga,model=rv100,romfile=VGABIOS-lgpl-latest.bin
+
+From the firmware menu that appears select ``Boot sequence`` →
+``Amiga Multiboot Options`` and set ``Boot device 1`` to
+``Onboard VIA IDE CDROM``. Then hit escape until the main screen appears again,
+hit escape once more and from the exit menu that appears select either
+``Save settings and exit`` or ``Use settings for this session only``. It may
+take a long time loading the kernel into memory but eventually it boots and the
+installer becomes visible. The ``ati-vga`` RV100 emulation is not
+complete yet so only frame buffer works, DRM and 3D is not available.
+
+Genesi/bPlan Pegasos II (``pegasos2``)
+======================================
+
+The ``pegasos2`` machine emulates the Pegasos II sold by Genesi and
+designed by bPlan. Its schematics are available at
+https://www.powerdeveloper.org/platforms/pegasos/schematics
+
+Emulated devices
+----------------
+
+ * PowerPC 7457 CPU (can also use``-cpu g3`` or ``750cxe``)
+ * Marvell MV64361 Discovery II north bridge
+ * VIA VT8231 south bridge
+ * PCI VGA compatible card (guests may need other card instead)
+ * PS/2 keyboard and mouse
+
+Firmware
+--------
+
+The Pegasos II board has an Open Firmware compliant ROM based on
+SmartFirmware but it has some changes that are not open sourced
+therefore the ROM binary cannot be included in QEMU. An updater was
+available from bPlan, it can be found here:
+http://web.archive.org/web/20071021223056/http://www.bplan-gmbh.de/up050404/up050404
+The ROM image can be extracted from it with the following command:
+
+.. code-block:: bash
+
+  $ tail -c +85581 up050404 | head -c 524288 > pegasos2.rom
+
+Running Linux
+-------------
+
+The PowerPC version of Debian 8.11 supported Pegasos II. The BIOS
+emulator in the firmware binary is unable to run QEMU‘s standard
+vgabios so it needs to be disabled. To boot the system run:
+
+.. code-block:: bash
+
+  $ qemu-system-ppc -machine pegasos2 -bios pegasos2.rom \
+                    -cdrom debian-8.11.0-powerpc-netinst.iso \
+                    -device VGA,romfile="" -serial stdio
+
+At the firmware ``ok`` prompt enter ``boot cd install/pegasos``.
+
+Alternatively it is possible to boot the kernel directly without
+firmware ROM using the QEMU built in minimal Virtual Open Firmware
+(VOF) emulation which is also supported on ``pegasos2``. For this,
+extract the kernel ``install/powerpc/vmlinuz-chrp.initrd`` from the CD
+image then run:
+
+.. code-block:: bash
+
+  $ qemu-system-ppc -machine pegasos2 -serial stdio \
+                    -kernel vmlinuz-chrp.initrd -append "---" \
+                    -cdrom debian-8.11.0-powerpc-netinst.iso
+
+aCube Sam460ex (``sam460ex``)
+=============================
+
+The ``sam460ex`` machine emulates the Sam460ex board by aCube which is
+based on the AMCC PowerPC 460EX SoC (that despite its name has a
+PPC440 CPU core).
+
+Firmware
+--------
+
+The board has a firmware based on an older U-Boot version with
+modifications to support booting AmigaOS 4. The firmware ROM is
+included with QEMU.
+
+Emulated devices
+----------------
+
+ * PowerPC 460EX SoC
+ * M41T80 serial RTC chip
+ * Silicon Motion SM501 display parts (identical to SM502 on real board)
+ * Silicon Image SiI3112 2 port SATA controller
+ * USB keyboard and mouse
+
+Running Linux
+-------------
+
+The only Linux distro that supported Sam460ex out of box was CruxPPC
+2.x. It can be booted by running:
+
+.. code-block:: bash
+
+  $ qemu-system-ppc -machine sam460ex -serial stdio \
+                    -drive if=none,id=cd,format=raw,file=crux-ppc-2.7a.iso \
+                    -device ide-cd,drive=cd,bus=ide.1
+
+There are some other kernels and instructions for booting other
+distros on aCube's product page at
+https://www.acube-systems.biz/index.php?page=hardware&pid=5
+but those are untested.
diff --git a/docs/system/target-ppc.rst b/docs/system/target-ppc.rst
index 4f6eb93b17..87bf412ce5 100644
--- a/docs/system/target-ppc.rst
+++ b/docs/system/target-ppc.rst
@@ -17,6 +17,7 @@ help``.
 .. toctree::
    :maxdepth: 1
 
+   ppc/amigang
    ppc/embedded
    ppc/powermac
    ppc/powernv
-- 
2.30.9


