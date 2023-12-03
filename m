Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B875802934
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 00:48:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9w7W-0007VR-0B; Sun, 03 Dec 2023 18:43:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9w72-0007LV-06; Sun, 03 Dec 2023 18:43:00 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9w6z-0002pf-4E; Sun, 03 Dec 2023 18:42:59 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5d2d0661a8dso43897677b3.2; 
 Sun, 03 Dec 2023 15:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701646975; x=1702251775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mcF9QghvfuN/SOxiRcej/fFnaurGCk30s1qkfL8vZWQ=;
 b=GYYX5nOckpQlwRRC+0FikWNNLRh7U5RUOjSvC4fpD1aJPRe7NdR3JUorc9lsAXQuNd
 lmPS14EK1DYhWUDDgPe60di5Es7sCOThslAVNZq4nw6fpVJSoLfnpew1/GzTl91GYH3D
 TvXnuvCCrsKojp1kkuQZ2rIU7zQb34gZEFhasP/oQJXhzG4qnPGEeJ49ZRcjebcOhGeC
 UxGmPu4snGq6a1YQDYyaJ/m3IANjJfcCmwc3BbcS/dyK8W4+BkcB2zYuUCCojoyk7LCo
 0MPrN9t9JwavmZUW9ZkQdjA1pAhKJaQ2AfdNch59/Cy64+8xGFqM2QetNC2sHhVYuF3C
 nqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701646975; x=1702251775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mcF9QghvfuN/SOxiRcej/fFnaurGCk30s1qkfL8vZWQ=;
 b=b1XC6Z6oO7Pl2o/NyruKF2nfiO3l6XggipyyJuGU9i7e9SO2vDp/Uj2itShYoDKjRB
 Snc3KZoGV5TV0QhHhrn4ppg2q398rThC4jYg6Fe/kX74RosMI7S8CJoL0RdsxaAItJVM
 C+HPMDcwomra9sqXOoddzelW7DNvopz13SISyEZtABYEyYPxYeFrXl1kq29umsSmX9iY
 qiS041HVvY1p9XqK9S9Eb75+rHCVMwQelU5tDukriLR+zMR11tnwSXfyou0IroMFWM4H
 T7NMBk2CdZmDQrG8UQSIf0K+y1cFOgxvHyDgjF0XJ02n3WpRRQpgeFepEtLZdD7R9rBo
 bFVg==
X-Gm-Message-State: AOJu0YzgfWESUnczL4GMOqcLy2gtWOV+du748wd+GmNoPfNEZFaPSP0y
 oa8oDshTnQ6V9SVUtXMcgpQOMof/1m6mZQ==
X-Google-Smtp-Source: AGHT+IF77VQQ61ea+ttlg+IT5oNDbLmFaqVXCugCE1cqSTPeYJ/6EJOiGhve5LWSiNBGnPYtwXn3KA==
X-Received: by 2002:a81:4e96:0:b0:5d7:387d:50e8 with SMTP id
 c144-20020a814e96000000b005d7387d50e8mr2743018ywb.25.1701646975262; 
 Sun, 03 Dec 2023 15:42:55 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 c126-20020a0dda84000000b005d718fff165sm1536299ywe.78.2023.12.03.15.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 15:42:55 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v3 34/45] Add Rpi4b boot tests
Date: Sun,  3 Dec 2023 17:42:02 -0600
Message-Id: <20231203234213.1366214-35-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 tests/avocado/boot_linux_console.py | 92 +++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 6eab515718..62aac02bbb 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -501,6 +501,98 @@ def test_arm_raspi2_initrd(self):
         # Wait for VM to shut down gracefully
         self.vm.wait()
 
+    def test_arm_raspi4(self):
+        """
+        :avocado: tags=arch:aarch64
+        :avocado: tags=machine:raspi4b2g
+        :avocado: tags=device:pl011
+        :avocado: tags=accel:tcg
+        :avocado: tags=rpi4b
+
+        The kernel can be rebuilt using the kernel source referenced
+        and following the instructions on the on:
+        https://www.raspberrypi.org/documentation/linux/kernel/building.md
+        """
+
+        deb_url = ('http://archive.raspberrypi.org/debian/'
+            'pool/main/r/raspberrypi-firmware/'
+            'raspberrypi-kernel_1.20230106-1_arm64.deb')
+        deb_hash = '08dc55696535b18a6d4fe6fa10d4c0d905cbb2ed'
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        kernel_path = self.extract_from_deb(deb_path, '/boot/kernel8.img')
+        dtb_path = self.extract_from_deb(deb_path, '/boot/bcm2711-rpi-4-b.dtb')
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'earlycon=pl011,mmio32,0xfe201000 ' +
+                               'console=ttyAMA0,115200 ' +
+                               'root=/dev/mmcblk1p2 rootwait ' +
+                               'dwc_otg.fiq_fsm_enable=0')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-append', kernel_command_line,
+                         '-device', 'qemu-xhci,bus=pcie.1,id=xhci',
+                         '-device', 'usb-kbd,bus=xhci.0')
+        self.vm.launch()
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        self.wait_for_console_pattern(console_pattern)
+        console_pattern = 'Product: QEMU USB Keyboard'
+        self.wait_for_console_pattern(console_pattern)
+
+
+    def test_arm_raspi4_initrd(self):
+        """
+        :avocado: tags=arch:aarch64
+        :avocado: tags=machine:raspi4b2g
+        :avocado: tags=device:pl011
+        :avocado: tags=accel:tcg
+        :avocado: tags=rpi4b
+
+        The kernel can be rebuilt using the kernel source referenced
+        and following the instructions on the on:
+        https://www.raspberrypi.org/documentation/linux/kernel/building.md
+        """
+        deb_url = ('http://archive.raspberrypi.org/debian/'
+            'pool/main/r/raspberrypi-firmware/'
+            'raspberrypi-kernel_1.20230106-1_arm64.deb')
+        deb_hash = '08dc55696535b18a6d4fe6fa10d4c0d905cbb2ed'
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        kernel_path = self.extract_from_deb(deb_path, '/boot/kernel8.img')
+        dtb_path = self.extract_from_deb(deb_path, '/boot/bcm2711-rpi-4-b.dtb')
+
+        initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
+                      '86b2be1384d41c8c388e63078a847f1e1c4cb1de/rootfs/'
+                      'arm64/rootfs.cpio.gz')
+        initrd_hash = 'f3d4f9fa92a49aa542f1b44d34be77bbf8ca5b9d'
+        initrd_path_gz = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
+        initrd_path = os.path.join(self.workdir, 'rootfs.cpio')
+        archive.gzip_uncompress(initrd_path_gz, initrd_path)
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'earlycon=pl011,mmio32,0xfe201000 ' +
+                               'console=ttyAMA0,115200 ' +
+                               'panic=-1 noreboot ' +
+                               'dwc_otg.fiq_fsm_enable=0')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-initrd', initrd_path,
+                         '-append', kernel_command_line,
+                         '-device', 'qemu-xhci,bus=pcie.1,id=xhci',
+                         '-device', 'usb-kbd,bus=xhci.0',
+                         '-no-reboot')
+        self.vm.launch()
+        self.wait_for_console_pattern('Boot successful.')
+
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
+                                                'BCM2835')
+        exec_command_and_wait_for_pattern(self, 'cat /proc/iomem',
+                                                'cprman@7e101000')
+        exec_command_and_wait_for_pattern(self, 'halt', 'reboot: System halted')
+        # TODO: Raspberry Pi4 doesn't shut down properly with recent kernels
+        # Wait for VM to shut down gracefully
+        #self.vm.wait()
+
     def test_arm_exynos4210_initrd(self):
         """
         :avocado: tags=arch:arm
-- 
2.34.1


