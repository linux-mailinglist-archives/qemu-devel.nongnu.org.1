Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC3B70D9FA
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 12:07:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1OuA-0005Mg-A1; Tue, 23 May 2023 06:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qianfanguijin@163.com>)
 id 1q1Ou7-0005Ig-NR; Tue, 23 May 2023 06:06:07 -0400
Received: from m12.mail.163.com ([220.181.12.216])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qianfanguijin@163.com>)
 id 1q1Ou5-0007DO-E1; Tue, 23 May 2023 06:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=bA3h2
 I7xP6Oj01W3XOIOrdMHbHFaP7w3meXx8CbMtuQ=; b=LCzSb0Xyarg6wLf3PF1Qq
 PebizUtr/u6dMtnPJolGXGtR1uDDUChAf2vqWjhnq/gqmKbRhc77a/iMm+982iER
 uRUDVj9vKOdf6lp9cRNT9NiFlAHNjDiSbQHm8JPBcV5Jp84JVslJbq4kDA71m89P
 VnDRTU3ZZlZ5mxJ3XjFQWQ=
Received: from DESKTOP-B1R4FVG.localdomain (unknown [218.201.129.19])
 by zwqz-smtp-mta-g1-2 (Coremail) with SMTP id _____wBXjpIDkGxk9rKiAQ--.54569S2;
 Tue, 23 May 2023 18:05:56 +0800 (CST)
From: qianfanguijin@163.com
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 qianfan Zhao <qianfanguijin@163.com>
Subject: [PATCH v5 11/11] docs: system: arm: Introduce bananapi_m2u
Date: Tue, 23 May 2023 18:05:55 +0800
Message-Id: <20230523100555.32718-1-qianfanguijin@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBXjpIDkGxk9rKiAQ--.54569S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuw4fCF4ruF4fCr1xZw47urg_yoW7CF1kpF
 yvka15KrWkJF1Fya97Kw1fWFy5Xas5ArWUJF1kJ34FqF98Kr1vqwn3Kwn8Wasrtw4Ivw10
 qrW7KF12gwn8J3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pM2NZrUUUUU=
X-Originating-IP: [218.201.129.19]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/1tbiQgh47VaEFabJwAAAs3
Received-SPF: pass client-ip=220.181.12.216;
 envelope-from=qianfanguijin@163.com; helo=m12.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

From: qianfan Zhao <qianfanguijin@163.com>

Add documents for Banana Pi M2U

Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
---
 docs/system/arm/bananapi_m2u.rst | 138 +++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)
 create mode 100644 docs/system/arm/bananapi_m2u.rst

diff --git a/docs/system/arm/bananapi_m2u.rst b/docs/system/arm/bananapi_m2u.rst
new file mode 100644
index 0000000000..ae7194a9df
--- /dev/null
+++ b/docs/system/arm/bananapi_m2u.rst
@@ -0,0 +1,138 @@
+Banana Pi BPI-M2U (``bpim2u``)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Banana Pi BPI-M2 Ultra is a quad-core mini single board computer built with
+Allwinner A40i/R40/V40 SoC. It features 2GB of RAM and 8GB eMMC. It also
+has onboard WiFi and BT. On the ports side, the BPI-M2 Ultra has 2 USB A
+2.0 ports, 1 USB OTG port, 1 HDMI port, 1 audio jack, a DC power port,
+and last but not least, a SATA port.
+
+Supported devices
+"""""""""""""""""
+
+The Banana Pi M2U machine supports the following devices:
+
+ * SMP (Quad Core Cortex-A7)
+ * Generic Interrupt Controller configuration
+ * SRAM mappings
+ * SDRAM controller
+ * Timer device (re-used from Allwinner A10)
+ * UART
+ * SD/MMC storage controller
+ * EMAC ethernet
+ * GMAC ethernet
+ * Clock Control Unit
+ * TWI (I2C)
+
+Limitations
+"""""""""""
+
+Currently, Banana Pi M2U does *not* support the following features:
+
+- Graphical output via HDMI, GPU and/or the Display Engine
+- Audio output
+- Hardware Watchdog
+- Real Time Clock
+- USB 2.0 interfaces
+
+Also see the 'unimplemented' array in the Allwinner R40 SoC module
+for a complete list of unimplemented I/O devices: ``./hw/arm/allwinner-r40.c``
+
+Boot options
+""""""""""""
+
+The Banana Pi M2U machine can start using the standard -kernel functionality
+for loading a Linux kernel or ELF executable. Additionally, the Banana Pi M2U
+machine can also emulate the BootROM which is present on an actual Allwinner R40
+based SoC, which loads the bootloader from a SD card, specified via the -sd
+argument to qemu-system-arm.
+
+Running mainline Linux
+""""""""""""""""""""""
+
+To build a Linux mainline kernel that can be booted by the Banana Pi M2U machine,
+simply configure the kernel using the sunxi_defconfig configuration:
+
+.. code-block:: bash
+
+  $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make mrproper
+  $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make sunxi_defconfig
+
+To boot the newly build linux kernel in QEMU with the Banana Pi M2U machine, use:
+
+.. code-block:: bash
+
+  $ qemu-system-arm -M bpim2u -nographic \
+      -kernel /path/to/linux/arch/arm/boot/zImage \
+      -append 'console=ttyS0,115200' \
+      -dtb /path/to/linux/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dtb
+
+Banana Pi M2U images
+""""""""""""""""""""
+
+Note that the mainline kernel does not have a root filesystem. You can choose
+to build you own image with buildroot using the bananapi_m2_ultra_defconfig.
+Also see https://buildroot.org for more information.
+
+Another possibility is to run an OpenWrt image for Banana Pi M2U which
+can be downloaded from:
+
+   https://downloads.openwrt.org/releases/22.03.3/targets/sunxi/cortexa7/
+
+When using an image as an SD card, it must be resized to a power of two. This can be
+done with the ``qemu-img`` command. It is recommended to only increase the image size
+instead of shrinking it to a power of two, to avoid loss of data. For example,
+to prepare a downloaded Armbian image, first extract it and then increase
+its size to one gigabyte as follows:
+
+.. code-block:: bash
+
+  $ qemu-img resize \
+    openwrt-22.03.3-sunxi-cortexa7-sinovoip_bananapi-m2-ultra-ext4-sdcard.img \
+    1G
+
+Instead of providing a custom Linux kernel via the -kernel command you may also
+choose to let the Banana Pi M2U machine load the bootloader from SD card, just like
+a real board would do using the BootROM. Simply pass the selected image via the -sd
+argument and remove the -kernel, -append, -dbt and -initrd arguments:
+
+.. code-block:: bash
+
+  $ qemu-system-arm -M bpim2u -nic user -nographic \
+    -sd openwrt-22.03.3-sunxi-cortexa7-sinovoip_bananapi-m2-ultra-ext4-sdcard.img
+
+Running U-Boot
+""""""""""""""
+
+U-Boot mainline can be build and configured using the Bananapi_M2_Ultra_defconfig
+using similar commands as describe above for Linux. Note that it is recommended
+for development/testing to select the following configuration setting in U-Boot:
+
+  Device Tree Control > Provider for DTB for DT Control > Embedded DTB
+
+The BootROM of allwinner R40 loading u-boot from the 8KiB offset of sdcard.
+Let's create an bootable disk image:
+
+.. code-block:: bash
+
+  $ dd if=/dev/zero of=sd.img bs=32M count=1
+  $ dd if=u-boot-sunxi-with-spl.bin of=sd.img bs=1k seek=8 conv=notrunc
+
+And then boot it.
+
+.. code-block:: bash
+  $ qemu-system-arm -M bpim2u -nographic -sd sd.img
+
+Banana Pi M2U integration tests
+""""""""""""""""""""""""""""""
+
+The Banana Pi M2U machine has several integration tests included.
+To run the whole set of tests, build QEMU from source and simply
+provide the following command:
+
+.. code-block:: bash
+
+  $ cd qemu-build-dir
+  $ AVOCADO_ALLOW_LARGE_STORAGE=yes tests/venv/bin/avocado \
+    --verbose --show=app,console run -t machine:bpim2u \
+    ../tests/avocado/boot_linux_console.py
-- 
2.25.1


