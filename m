Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FD1723E67
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:53:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TIx-0007oi-SO; Tue, 06 Jun 2023 05:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIp-0007jK-47
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:35 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIj-0004m0-Nc
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:34 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-30ae967ef74so4631007f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044905; x=1688636905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ckp/wBSfFnkv4vrWWhbnnMtnjKyVqQNIxbNpABnud0Q=;
 b=SGb77HOWaHyA3TK/g1iXVzALXf9Xsd9mbPOcV6QvPDatcEaBgdWvB6vLOluwt3taS/
 qThbKBds4sJZvlHTdsYoitHrE6cFE7TjA/3/L2w/XK16rwOmcMbVo2ikLMdJZRvQcyvl
 b3WLdUZ6gcbt7b8PdWtjUBiJa+3EEOlGrMFXKKDlY8efc9pULOws/HP9NVaaiwU9+Vxx
 84MdLMfyKfd6Hynqm/NPxm5r7foU588YIQxgkbD7UhuopjaHgHutUGOPv5yOSR14kGlt
 1QMlM0VOHW3SMiaoi9g6a5u6+PUUGQ/+QZmnYyHvXtEVj5y8vHcjTS+icmKtKcm1rWH9
 A/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044905; x=1688636905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ckp/wBSfFnkv4vrWWhbnnMtnjKyVqQNIxbNpABnud0Q=;
 b=GBwqa1K+fFy0hQlNIJ6JclYLIacLrcQrlg/JsXU2jMw0PqUkmOyKptds8n16bkPULk
 GbVG1MHfjXnuy1m5clPzy2njmwViUL5Wwvc6XuJ2Fh8sqUFV8fRJCfg+ZMqnREQymEhN
 R6MchfGMzCNqWLo+rzMeMsH/fzkJIkrrtt13GG/AS5V7fsIcjro/CrOQm77YkqWL1FPQ
 7MWJkjftbNwGziIUjHdRUGEHOs0DmhhMwiJGntd7JZi3UYhRT7H6DHQWPa7hXbz0PTai
 n+XIu/lMflhfhpT9SiCGdPw7ngfPgoU1H80wOapGi2rKY/94GdUUWAUqR6mUMCKA+mtg
 rpSA==
X-Gm-Message-State: AC+VfDxnDSZvHbtmPCoOa+W47h2WWmhDDohbxzEfUND2FPW/ht0lNVCg
 h8MLGMkPAv99H/obb3Ck2vT1kyGzM/gJ5Fje8ig=
X-Google-Smtp-Source: ACHHUZ69aAl1MI9eEzeQVbqQgTjPBO+zzyEroSI6rCxbKwGsHODjm3/z9gQ7AvggvnFhvdlOE5l2iA==
X-Received: by 2002:a5d:4589:0:b0:30a:d246:32c2 with SMTP id
 p9-20020a5d4589000000b0030ad24632c2mr1455132wrq.23.1686044905026; 
 Tue, 06 Jun 2023 02:48:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/42] tests: avocado: boot_linux_console: Add test case for
 bpim2u
Date: Tue,  6 Jun 2023 10:47:50 +0100
Message-Id: <20230606094814.3581397-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: qianfan Zhao <qianfanguijin@163.com>

Add test case for booting from initrd and sd card.

Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/avocado/boot_linux_console.py | 176 ++++++++++++++++++++++++++++
 1 file changed, 176 insertions(+)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index c0675809e64..6ed660611fe 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -769,6 +769,182 @@ def test_arm_quanta_gsj_initrd(self):
         self.wait_for_console_pattern(
                 'Give root password for system maintenance')
 
+    def test_arm_bpim2u(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:bpim2u
+        :avocado: tags=accel:tcg
+        """
+        deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.10.16-sunxi/'
+                   'linux-image-current-sunxi_21.02.2_armhf.deb')
+        deb_hash = '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        kernel_path = self.extract_from_deb(deb_path,
+                                            '/boot/vmlinuz-5.10.16-sunxi')
+        dtb_path = ('/usr/lib/linux-image-current-sunxi/'
+                    'sun8i-r40-bananapi-m2-ultra.dtb')
+        dtb_path = self.extract_from_deb(deb_path, dtb_path)
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyS0,115200n8 '
+                               'earlycon=uart,mmio32,0x1c28000')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        self.wait_for_console_pattern(console_pattern)
+
+    def test_arm_bpim2u_initrd(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=accel:tcg
+        :avocado: tags=machine:bpim2u
+        """
+        deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.10.16-sunxi/'
+                   'linux-image-current-sunxi_21.02.2_armhf.deb')
+        deb_hash = '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        kernel_path = self.extract_from_deb(deb_path,
+                                            '/boot/vmlinuz-5.10.16-sunxi')
+        dtb_path = ('/usr/lib/linux-image-current-sunxi/'
+                    'sun8i-r40-bananapi-m2-ultra.dtb')
+        dtb_path = self.extract_from_deb(deb_path, dtb_path)
+        initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
+                      '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
+                      'arm/rootfs-armv7a.cpio.gz')
+        initrd_hash = '604b2e45cdf35045846b8bbfbf2129b1891bdc9c'
+        initrd_path_gz = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
+        initrd_path = os.path.join(self.workdir, 'rootfs.cpio')
+        archive.gzip_uncompress(initrd_path_gz, initrd_path)
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyS0,115200 '
+                               'panic=-1 noreboot')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-initrd', initrd_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+        self.vm.launch()
+        self.wait_for_console_pattern('Boot successful.')
+
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
+                                                'Allwinner sun8i Family')
+        exec_command_and_wait_for_pattern(self, 'cat /proc/iomem',
+                                                'system-control@1c00000')
+        exec_command_and_wait_for_pattern(self, 'reboot',
+                                                'reboot: Restarting system')
+        # Wait for VM to shut down gracefully
+        self.vm.wait()
+
+    def test_arm_bpim2u_gmac(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=accel:tcg
+        :avocado: tags=machine:bpim2u
+        :avocado: tags=device:sd
+        """
+        self.require_netdev('user')
+
+        deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.10.16-sunxi/'
+                   'linux-image-current-sunxi_21.02.2_armhf.deb')
+        deb_hash = '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        kernel_path = self.extract_from_deb(deb_path,
+                                            '/boot/vmlinuz-5.10.16-sunxi')
+        dtb_path = ('/usr/lib/linux-image-current-sunxi/'
+                    'sun8i-r40-bananapi-m2-ultra.dtb')
+        dtb_path = self.extract_from_deb(deb_path, dtb_path)
+        rootfs_url = ('http://storage.kernelci.org/images/rootfs/buildroot/'
+                      'buildroot-baseline/20221116.0/armel/rootfs.ext2.xz')
+        rootfs_hash = 'fae32f337c7b87547b10f42599acf109da8b6d9a'
+        rootfs_path_xz = self.fetch_asset(rootfs_url, asset_hash=rootfs_hash)
+        rootfs_path = os.path.join(self.workdir, 'rootfs.cpio')
+        archive.lzma_uncompress(rootfs_path_xz, rootfs_path)
+        image_pow2ceil_expand(rootfs_path)
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyS0,115200 '
+                               'root=/dev/mmcblk0 rootwait rw '
+                               'panic=-1 noreboot')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-drive', 'file=' + rootfs_path + ',if=sd,format=raw',
+                         '-net', 'nic,model=gmac,netdev=host_gmac',
+                         '-netdev', 'user,id=host_gmac',
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+        self.vm.launch()
+        shell_ready = "/bin/sh: can't access tty; job control turned off"
+        self.wait_for_console_pattern(shell_ready)
+
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
+                                                'Allwinner sun8i Family')
+        exec_command_and_wait_for_pattern(self, 'cat /proc/partitions',
+                                                'mmcblk0')
+        exec_command_and_wait_for_pattern(self, 'ifconfig eth0 up',
+                                                 'eth0: Link is Up')
+        exec_command_and_wait_for_pattern(self, 'udhcpc eth0',
+            'udhcpc: lease of 10.0.2.15 obtained')
+        exec_command_and_wait_for_pattern(self, 'ping -c 3 10.0.2.2',
+            '3 packets transmitted, 3 packets received, 0% packet loss')
+        exec_command_and_wait_for_pattern(self, 'reboot',
+                                                'reboot: Restarting system')
+        # Wait for VM to shut down gracefully
+        self.vm.wait()
+
+    @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
+    def test_arm_bpim2u_openwrt_22_03_3(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:bpim2u
+        :avocado: tags=device:sd
+        """
+
+        # This test download a 8.9 MiB compressed image and expand it
+        # to 127 MiB.
+        image_url = ('https://downloads.openwrt.org/releases/22.03.3/targets/'
+                     'sunxi/cortexa7/openwrt-22.03.3-sunxi-cortexa7-'
+                     'sinovoip_bananapi-m2-ultra-ext4-sdcard.img.gz')
+        image_hash = ('5b41b4e11423e562c6011640f9a7cd3b'
+                      'dd0a3d42b83430f7caa70a432e6cd82c')
+        image_path_gz = self.fetch_asset(image_url, asset_hash=image_hash,
+                                         algorithm='sha256')
+        image_path = archive.extract(image_path_gz, self.workdir)
+        image_pow2ceil_expand(image_path)
+
+        self.vm.set_console()
+        self.vm.add_args('-drive', 'file=' + image_path + ',if=sd,format=raw',
+                         '-nic', 'user',
+                         '-no-reboot')
+        self.vm.launch()
+
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'usbcore.nousb '
+                               'noreboot')
+
+        self.wait_for_console_pattern('U-Boot SPL')
+
+        interrupt_interactive_console_until_pattern(
+                self, 'Hit any key to stop autoboot:', '=>')
+        exec_command_and_wait_for_pattern(self, "setenv extraargs '" +
+                                                kernel_command_line + "'", '=>')
+        exec_command_and_wait_for_pattern(self, 'boot', 'Starting kernel ...');
+
+        self.wait_for_console_pattern(
+            'Please press Enter to activate this console.')
+
+        exec_command_and_wait_for_pattern(self, ' ', 'root@')
+
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
+                                                'Allwinner sun8i Family')
+        exec_command_and_wait_for_pattern(self, 'cat /proc/iomem',
+                                                'system-control@1c00000')
+
     def test_arm_orangepi(self):
         """
         :avocado: tags=arch:arm
-- 
2.34.1


