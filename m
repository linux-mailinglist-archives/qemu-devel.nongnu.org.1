Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F37017771C9
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 09:44:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU0KJ-0005MM-U5; Thu, 10 Aug 2023 03:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1qU0KH-0005ME-Km
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 03:43:21 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1qU0KD-0003V3-HG
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 03:43:21 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxZ+gGldRks3oUAA--.8434S3;
 Thu, 10 Aug 2023 15:43:03 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxbSMDldRk9bhSAA--.26845S2; 
 Thu, 10 Aug 2023 15:42:59 +0800 (CST)
From: xianglai li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>
Subject: [PATCH] roms: Support compile the efi bios for loongarch
Date: Thu, 10 Aug 2023 15:42:58 +0800
Message-Id: <260307952ffe5382a55d66a4999034490e04f7df.1691653307.git.lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxbSMDldRk9bhSAA--.26845S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

1.Add edk2-platform submodule
2.Added loongarch UEFI BIOS support to compiled scripts.
3.The cross-compilation toolchain on x86 can be obtained from the link below:
https://github.com/loongson/build-tools/tree/2022.09.06

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>
Cc: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: xianglai li <lixianglai@loongson.cn>
---
 .gitmodules            |  3 +++
 meson.build            |  2 +-
 pc-bios/meson.build    |  2 ++
 roms/edk2-build.config | 14 ++++++++++++++
 roms/edk2-build.py     |  4 ++--
 roms/edk2-platforms    |  1 +
 6 files changed, 23 insertions(+), 3 deletions(-)
 create mode 160000 roms/edk2-platforms

diff --git a/.gitmodules b/.gitmodules
index 73cae4cd4d..0cb57123fa 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -43,3 +43,6 @@
 [submodule "tests/lcitool/libvirt-ci"]
 	path = tests/lcitool/libvirt-ci
 	url = https://gitlab.com/libvirt/libvirt-ci.git
+[submodule "roms/edk2-platforms"]
+	path = roms/edk2-platforms
+	url = https://github.com/tianocore/edk2-platforms.git
diff --git a/meson.build b/meson.build
index 98e68ef0b1..b398caf2ce 100644
--- a/meson.build
+++ b/meson.build
@@ -153,7 +153,7 @@ if targetos != 'darwin'
   modular_tcg = ['i386-softmmu', 'x86_64-softmmu']
 endif
 
-edk2_targets = [ 'arm-softmmu', 'aarch64-softmmu', 'i386-softmmu', 'x86_64-softmmu' ]
+edk2_targets = [ 'arm-softmmu', 'aarch64-softmmu', 'i386-softmmu', 'x86_64-softmmu', 'loongarch64-softmmu' ]
 unpack_edk2_blobs = false
 foreach target : edk2_targets
   if target in target_dirs
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index a7224ef469..fc73222b6c 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -9,6 +9,8 @@ if unpack_edk2_blobs
     'edk2-i386-vars.fd',
     'edk2-x86_64-code.fd',
     'edk2-x86_64-secure-code.fd',
+    'edk2-loongarch64-code.fd',
+    'edk2-loongarch64-vars.fd',
   ]
 
   foreach f : fds
diff --git a/roms/edk2-build.config b/roms/edk2-build.config
index 66ef9ffcb9..7960c4c2c5 100644
--- a/roms/edk2-build.config
+++ b/roms/edk2-build.config
@@ -1,5 +1,6 @@
 [global]
 core = edk2
+pkgs = edk2-platforms
 
 ####################################################################################
 # options
@@ -122,3 +123,16 @@ plat = RiscVVirtQemu
 dest = ../pc-bios
 cpy1 = FV/RISCV_VIRT.fd  edk2-riscv.fd
 pad1 = edk2-riscv.fd     32m
+
+####################################################################################
+# LoongArch64
+
+[build.loongach64.qemu]
+conf = Platform/Loongson/LoongArchQemuPkg/Loongson.dsc
+arch = LOONGARCH64
+plat = LoongArchQemu
+dest = ../pc-bios
+cpy1 = FV/QEMU_EFI.fd  edk2-loongarch64-code.fd
+pad1 = edk2-loongarch64-code.fd     4m
+cpy2 = FV/QEMU_VARS.fd  edk2-loongarch64-vars.fd
+pad2 = edk2-loongarch64-vars.fd     16m
diff --git a/roms/edk2-build.py b/roms/edk2-build.py
index 870893f7c8..dbd641e51e 100755
--- a/roms/edk2-build.py
+++ b/roms/edk2-build.py
@@ -269,8 +269,8 @@ def prepare_env(cfg):
     # for cross builds
     if binary_exists('arm-linux-gnu-gcc'):
         os.environ['GCC5_ARM_PREFIX'] = 'arm-linux-gnu-'
-    if binary_exists('loongarch64-linux-gnu-gcc'):
-        os.environ['GCC5_LOONGARCH64_PREFIX'] = 'loongarch64-linux-gnu-'
+    if binary_exists('loongarch64-unknown-linux-gnu-gcc'):
+        os.environ['GCC5_LOONGARCH64_PREFIX'] = 'loongarch64-unknown-linux-gnu-'
 
     hostarch = os.uname().machine
     if binary_exists('aarch64-linux-gnu-gcc') and hostarch != 'aarch64':
diff --git a/roms/edk2-platforms b/roms/edk2-platforms
new file mode 160000
index 0000000000..84ccada592
--- /dev/null
+++ b/roms/edk2-platforms
@@ -0,0 +1 @@
+Subproject commit 84ccada59257a8151a592a416017fbb03b8ed3cf
-- 
2.39.1


