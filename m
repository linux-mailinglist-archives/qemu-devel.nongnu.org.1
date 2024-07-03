Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4609260A6
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jul 2024 14:40:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOzHQ-0007OM-4K; Wed, 03 Jul 2024 08:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sOzHJ-0007HJ-97; Wed, 03 Jul 2024 08:40:07 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sOzHG-0004hY-B4; Wed, 03 Jul 2024 08:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1720010396; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=rTLRqFdMD4b7OWC1tQsY7AZTS4HIoPyqg3r8Of9GuTc=;
 b=fMckGef08IN4D7tpnndGgxECkA1MXVjBQKID5iMeKswUEw9tKaNtrrPx6IZJWnuUF14KtVcz3h0ogX0zD8d9uR/+N7w1cop5tdTlasrjnBKJMbxc8bVMQlODMLNpzQII4oNhD8IpqlZg2y3dxIVCp3ymSZIXKL3o4Z5Z2h9l+YA=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032014031;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W9nRtuf_1720010394; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W9nRtuf_1720010394) by smtp.aliyun-inc.com;
 Wed, 03 Jul 2024 20:39:55 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v2 7/7] tests/avocado: Add an avocado test for riscv64
Date: Wed,  3 Jul 2024 20:34:49 +0800
Message-Id: <20240703123449.1108-8-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240703123449.1108-1-zhiwei_liu@linux.alibaba.com>
References: <20240703123449.1108-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.132;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-132.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

To regularly test booting Linux with rv32 on QEMU RV64,
we have added a test to boot_linux_console.py to retrieve
cpuinfo and verify if it shows 'rv32' when using RV64 to
boot rv32 CPUs.

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 tests/avocado/boot_linux_console.py | 35 +++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index c35fc5e9ba..408f936f9a 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -12,6 +12,7 @@
 import lzma
 import gzip
 import shutil
+import time
 
 from avocado import skip
 from avocado import skipUnless
@@ -1545,3 +1546,37 @@ def test_xtensa_lx60(self):
         """
         tar_hash = '49e88d9933742f0164b60839886c9739cb7a0d34'
         self.do_test_advcal_2018('02', tar_hash, 'santas-sleigh-ride.elf')
+
+    def test_riscv64_virt_rv32i(self):
+        """
+        :avocado: tags=arch:riscv64
+        :avocado: tags=machine:virt
+        :avocado: tags=cpu:rv32
+        """
+        kernel_url = ('https://github.com/romanheros/rv32-linux/raw/master/Image32.xz')
+        kernel_hash = 'a7ced5c38722481e0821b7cd70719cf53e46c13b'
+        kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+
+        kernel_path =  os.path.join(self.workdir, 'kernel.riscv32')
+        archive.lzma_uncompress(kernel_path_xz, kernel_path)
+
+        rootfs_url = ('https://github.com/romanheros/rv32-linux/raw/master/rootfs.ext2.xz')
+        rootfs_hash = 'dc25ab9d4b233e8e0bcf7eb220d56fd2008fe263'
+        rootfs_path_xz = self.fetch_asset(rootfs_url, asset_hash=rootfs_hash)
+
+        rootfs_path =  os.path.join(self.workdir, 'rootfs.riscv32')
+        archive.lzma_uncompress(rootfs_path_xz, rootfs_path)
+
+        self.vm.set_console()
+        kernel_command_line = 'root=/dev/vda ro console=ttyS0'
+        self.vm.add_args('-kernel', kernel_path,
+                         '-append', kernel_command_line,
+                         '-drive', f'file={rootfs_path},format=raw,id=hd0',
+                         '-device', 'virtio-blk-device,drive=hd0',)
+        self.vm.launch()
+
+        console_pattern = 'Welcome to Buildroot'
+        self.wait_for_console_pattern(console_pattern)
+        exec_command(self, 'root')
+        time.sleep(0.1)
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo', 'rv32i')
-- 
2.43.0


