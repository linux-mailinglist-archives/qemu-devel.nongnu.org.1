Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E832A723E6F
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:53:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TIr-0007kF-Ak; Tue, 06 Jun 2023 05:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIl-0007gX-N4
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:31 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIi-0004m9-S9
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:31 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3094910b150so6000330f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044905; x=1688636905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Et2qUptw81NHilUmOkdAFt1UlRfDK+zLpfIlo91MuxU=;
 b=apK7H3p15vHLDXNXKc/5dhAj2DME6JsRscYgLkYyTzZ49GgSgvfayX0ByYD4M14Zx0
 MBB0/xMl+RHAT84uNRNT/wOXxS3T9N0rB/UUGfkUF207Y33QcnRGcP5ancu3+KP6KoLr
 pjMqyPYSrGqAe/a8qZyZabBhP0cha4Zl8QYkriKQl8MfY7fTAFZJABNNyNbfEfsqDxZm
 96brzg315o9pHDLmF3YuWp7YMny1/9th9aISntnUnT+MJyTq3k8RQdC4q6aphZfGJzCx
 CKB6fZnS4Eni0bj3cOOIS0KwejF1ti8ExhOvsnNuB051lvDcBtIrGcOfDAs+vCjP8JWH
 krtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044905; x=1688636905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Et2qUptw81NHilUmOkdAFt1UlRfDK+zLpfIlo91MuxU=;
 b=Fu3wiLlgWJJg61pkji5Biyp2aDsxmv51zNBoRR7NE80S4m4I8fZaavI4/98YjOpzsL
 /OOJB+eNhv7ou1IvKg7uDnG/P23p/XUOjmuPX5RLcbW/jkL/pS6ZSxBmuOahTMdc44sx
 CdwoxdbJX4bObFaIsqXhAuumZRnLRXk/Jc3C2+A9NE9IWpumu+GkYAc9o6zA/jxxF1Qr
 TE0H1BpFqwamqE6RIha5kCzxyz0AiKe1ieFVid+ow5JBNTLY7bSw1WhqMuhwNuMO+rj/
 gPP0agA0xL54Sr/sdKfUA8C1tN3foSHb87180DJrovYSAqykYV3W7eoMihRO7ePowDqP
 Ebow==
X-Gm-Message-State: AC+VfDwJUmS5UayKPrC5FUoNbGLXKo2mq79igJfpR+6EcfEyPwPOwUJ7
 oTfBYh9+d0Gq7GhiNRkCYpQhI2e9d+qtnuNuewc=
X-Google-Smtp-Source: ACHHUZ7N3uNlwZCyeG32LAAEVEABttV1ZsYQFDjEc9ygn65btXGmMXitsUwAMT7nBsjOIqTzBaL1fw==
X-Received: by 2002:a5d:49ce:0:b0:30e:2ff3:8c88 with SMTP id
 t14-20020a5d49ce000000b0030e2ff38c88mr1318790wrs.35.1686044905453; 
 Tue, 06 Jun 2023 02:48:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/42] docs: system: arm: Introduce bananapi_m2u
Date: Tue,  6 Jun 2023 10:47:51 +0100
Message-Id: <20230606094814.3581397-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
[PMM: Minor format fixes to correct sphinx errors]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/bananapi_m2u.rst | 139 +++++++++++++++++++++++++++++++
 docs/system/target-arm.rst       |   1 +
 2 files changed, 140 insertions(+)
 create mode 100644 docs/system/arm/bananapi_m2u.rst

diff --git a/docs/system/arm/bananapi_m2u.rst b/docs/system/arm/bananapi_m2u.rst
new file mode 100644
index 00000000000..b09ba5c5486
--- /dev/null
+++ b/docs/system/arm/bananapi_m2u.rst
@@ -0,0 +1,139 @@
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
+
+  $ qemu-system-arm -M bpim2u -nographic -sd sd.img
+
+Banana Pi M2U integration tests
+"""""""""""""""""""""""""""""""
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
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 91ebc26c6db..a12b6bca051 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -83,6 +83,7 @@ undocumented; you can get a complete list by running
    arm/versatile
    arm/vexpress
    arm/aspeed
+   arm/bananapi_m2u.rst
    arm/sabrelite
    arm/digic
    arm/cubieboard
-- 
2.34.1


