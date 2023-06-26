Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1D873E04F
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:16:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDm3x-0002sb-EB; Mon, 26 Jun 2023 09:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1qDkiE-0001C8-AS
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:48:56 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1qDkiB-00015B-O1
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:48:54 -0400
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QqQyp5D8lz6DB1L;
 Mon, 26 Jun 2023 19:45:54 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 12:48:39 +0100
To: <op-tee@lists.trustedfirmware.org>, <qemu-devel@nongnu.org>,
 <linaro-open-discussions@op-lists.linaro.org>
CC: <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
 <prime.zeng@hisilicon.com>, <zhouguangwei5@huawei.com>,
 <shiju.jose@huawei.com>
Subject: [RFC PATCH 1/1] tests/avocado: Introduce avocado tests for aarch64
 S-EL2 booting
Date: Mon, 26 Jun 2023 19:48:25 +0800
Message-ID: <20230626114825.1859-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.234]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56; envelope-from=shiju.jose@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 26 Jun 2023 09:15:20 -0400
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
Reply-to:  <shiju.jose@huawei.com>
From: shiju.jose--- via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Shiju Jose <shiju.jose@huawei.com>

Add avocado tests for aarch64 S-EL2, include booting and
run xtest on linux terminal.

The prebuilt S-EL2 images are corresponding to the
https://github.com/jenswi-linaro/manifest.git \
-m qemu_v8.xml -b qemu_sel2

How to run
==========
"make check-avocado" in qemu/build
or
with QEMU_CI=1 and QEMU_CI_AVOCADO_TESTING=1
"amd64-fedora-container",  "build-cfi-aarch64" and
"avocado-cfi-aarch64" on gitlab for qemu

Question:
Presently tested with the prebuilt images temporarily  in
/tests/data/sel2-boot-images/prebuilt-sel2-images.zip

Can the prebuilt images for SEL2 available in the OP-TEE/TF-A/similar
release?

Note1:
The pre-built S-EL2 images used are few months old
as there are some issue found in xtest with the images build from
the recent Linaro SEL2 code.

Note2:
On gitlab CI, there is an outstanding issue found in booting linux,
after starting network OK.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 tests/avocado/machine_aarch64_virt.py         |  63 ++++++++++++++++++
 .../sel2-boot-images/prebuilt-sel2-images.zip | Bin 0 -> 23151996 bytes
 2 files changed, 63 insertions(+)
 create mode 100644 tests/data/sel2-boot-images/prebuilt-sel2-images.zip

diff --git a/tests/avocado/machine_aarch64_virt.py b/tests/avocado/machine_aarch64_virt.py
index a90dc6ff4b..039673fd40 100644
--- a/tests/avocado/machine_aarch64_virt.py
+++ b/tests/avocado/machine_aarch64_virt.py
@@ -11,13 +11,16 @@
 import time
 import os
 import logging
+import shutil
 
 from avocado_qemu import QemuSystemTest
 from avocado_qemu import wait_for_console_pattern
 from avocado_qemu import exec_command
 from avocado_qemu import BUILD_DIR
+from avocado_qemu import is_readable_executable_file
 from avocado.utils import process
 from avocado.utils.path import find_command
+from avocado.utils import archive
 
 class Aarch64VirtMachine(QemuSystemTest):
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
@@ -144,3 +147,63 @@ def test_aarch64_virt_gicv2(self):
         :avocado: tags=cpu:max
         """
         self.common_aarch64_virt("virt,gic-version=2")
+
+    def copy_sel2_prebuilt_images(self):
+        """extract the prebuilt S-EL2 binaries to the test directory. """
+
+        relative_path = "./tests/data/sel2-boot-images/prebuilt-sel2-images.zip"
+        prebuilt_bin_path = os.path.join(BUILD_DIR, relative_path)
+        target_dir = os.path.join(BUILD_DIR)
+
+        self.assertTrue(os.path.exists(prebuilt_bin_path))
+        self.assertTrue(os.path.exists(target_dir))
+        archive.extract(prebuilt_bin_path, target_dir)
+
+    timeout = 1000
+    def test_aarch64_sel2_boot(self):
+        """
+        :avocado: tags=arch:aarch64
+        :avocado: tags=machine:secure
+        :avocado: tags=machine:virt
+        :avocado: tags=cpu:max
+        """
+
+        self.copy_sel2_prebuilt_images()
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyAMA0,38400 keep_bootcon root=/dev/vda2 nokaslr')
+
+        self.vm.add_args("-cpu", "max,sme=off,pauth-impdef=on")
+        self.vm.add_args("-machine",
+                         "virt,secure=on,"
+                         "virtualization=on,"
+                         "mte=on,"
+                         "gic-version=3")
+        self.vm.add_args("-d", "unimp")
+        self.vm.add_args("-semihosting-config", "enable=on,target=native")
+        self.vm.add_args("-smp", "2", "-m", "1024")
+        self.vm.add_args('-bios', 'bl1.bin')
+        self.vm.add_args('-initrd', 'rootfs.cpio.gz')
+        self.vm.add_args('-kernel', 'Image')
+        self.vm.add_args('-machine', 'acpi=off')
+        self.vm.add_args('-append', kernel_command_line)
+        self.vm.add_args('-object', 'rng-random,filename=/dev/urandom,id=rng0')
+        self.vm.add_args('-device', 'virtio-rng-pci,rng=rng0,max-bytes=1024,period=1000')
+        self.vm.launch()
+        self.wait_for_console_pattern('Welcome to Buildroot')
+        time.sleep(0.1)
+        exec_command(self, 'root')
+        time.sleep(0.1)
+
+    def test_aarch64_sel2_xtest(self):
+        """
+        :avocado: tags=arch:aarch64
+        :avocado: tags=machine:secure
+        :avocado: tags=machine:virt
+        :avocado: tags=cpu:max
+        """
+        self.test_aarch64_sel2_boot()
+        exec_command(self, 'xtest')
+        time.sleep(0.1)
+        self.wait_for_console_pattern('subtests of which 0 failed')
+        time.sleep(0.1)
diff --git a/tests/data/sel2-boot-images/prebuilt-sel2-images.zip b/tests/data/sel2-boot-images/prebuilt-sel2-images.zip
new file mode 100644
index 0000000000..13c5e1e4cc
Binary files /dev/null and b/tests/data/sel2-boot-images/prebuilt-sel2-images.zip differ
-- 
2.25.1


