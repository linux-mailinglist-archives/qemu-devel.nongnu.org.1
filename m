Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0867C96B8B2
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Sep 2024 12:41:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slnRk-0006tf-T9; Wed, 04 Sep 2024 06:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnRi-0006iN-LF
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:41:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnRf-0000TI-Vw
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725446463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+H2zAIaCvXqycK9RY55+UERYhbxvdqjfeqsuSJFsjxs=;
 b=QFZ6FlWGlnfapCEM/5fGxPnNHI7gw1VhvLgXfj5TP5QDhoOqaE9hdoOZa4zU4E6ijUE+Z+
 QcNtns0/dvrnkcgjfhWNCCxCZ1kCWawbEnyEIJHDcmKjzQXuNRofieFo5BaC6N0mxETmQw
 92reQV5SAee9mqx8g78uwhA4y74a3VM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-Y0kW9bHPMG69-DOACNWL7Q-1; Wed,
 04 Sep 2024 06:40:57 -0400
X-MC-Unique: Y0kW9bHPMG69-DOACNWL7Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E7451955D45; Wed,  4 Sep 2024 10:40:56 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.48])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 598E3195605A; Wed,  4 Sep 2024 10:40:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: [PULL 32/42] tests/functional: Convert Aarch64 SBSA-Ref avocado tests
Date: Wed,  4 Sep 2024 12:39:07 +0200
Message-ID: <20240904103923.451847-33-thuth@redhat.com>
In-Reply-To: <20240904103923.451847-1-thuth@redhat.com>
References: <20240904103923.451847-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Straight forward conversion. Since SBSA_FLASH files are not
tarballs, use lzma_uncompress() method.

Avocado used to set a timeout of 11 tests * 180s = 1980s.
Hopefully 600s should be sufficient.

Running on macOS Sonoma / Apple silicon M1:

  $ QEMU_TEST_TIMEOUT_EXPECTED=1 make check-functional-aarch64 V=1
  ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_alpine_linux_max              OK
  ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_alpine_linux_max_pauth_impdef OK
  ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_alpine_linux_max_pauth_off    OK
  ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_alpine_linux_neoverse_n1      OK
  ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_edk2_firmware                 OK
  ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_openbsd73_cortex_a57          OK
  ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_openbsd73_max                 OK
  ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_openbsd73_max_pauth_impdef    OK
  ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_openbsd73_max_pauth_off       OK
  ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_openbsd73_neoverse_n1         OK
  1/5 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-aarch64_sbsaref        OK   241.79s  11 subtests passed
  ...

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240823131614.10269-1-philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20240830133841.142644-35-thuth@redhat.com>
[thuth: remove remaining Avocado tags]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   |   2 +-
 tests/functional/meson.build                  |   5 +
 .../test_aarch64_sbsaref.py}                  | 148 ++++++------------
 3 files changed, 55 insertions(+), 100 deletions(-)
 rename tests/{avocado/machine_aarch64_sbsaref.py => functional/test_aarch64_sbsaref.py} (55%)
 mode change 100644 => 100755

diff --git a/MAINTAINERS b/MAINTAINERS
index a0b7e68c62..edd8e03a42 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -970,7 +970,7 @@ F: hw/misc/sbsa_ec.c
 F: hw/watchdog/sbsa_gwdt.c
 F: include/hw/watchdog/sbsa_gwdt.h
 F: docs/system/arm/sbsa.rst
-F: tests/avocado/machine_aarch64_sbsaref.py
+F: tests/functional/test_aarch64_sbsaref.py
 
 Sharp SL-5500 (Collie) PDA
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 7abd998e3c..b59cd4468f 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -11,6 +11,7 @@ endif
 
 # Timeouts for individual tests that can be slow e.g. with debugging enabled
 test_timeouts = {
+  'aarch64_sbsaref' : 600,
   'acpi_bits' : 240,
   'netdev_ethtool' : 180,
   'ppc_40p' : 240,
@@ -32,6 +33,10 @@ tests_generic_linuxuser = [
 tests_generic_bsduser = [
 ]
 
+tests_aarch64_system_thorough = [
+  'aarch64_sbsaref',
+]
+
 tests_arm_system_thorough = [
   'arm_canona1100',
   'arm_integratorcp',
diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/functional/test_aarch64_sbsaref.py
old mode 100644
new mode 100755
similarity index 55%
rename from tests/avocado/machine_aarch64_sbsaref.py
rename to tests/functional/test_aarch64_sbsaref.py
index f8bf40c192..f31c2a60b6
--- a/tests/avocado/machine_aarch64_sbsaref.py
+++ b/tests/functional/test_aarch64_sbsaref.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Functional test that boots a Linux kernel and checks the console
 #
 # SPDX-FileCopyrightText: 2023-2024 Linaro Ltd.
@@ -8,26 +10,31 @@
 
 import os
 
-from avocado import skipUnless
-from avocado.utils import archive
-
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
-from avocado_qemu import interrupt_interactive_console_until_pattern
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+from qemu_test import interrupt_interactive_console_until_pattern
+from qemu_test.utils import lzma_uncompress
+from unittest import skipUnless
 
 
 class Aarch64SbsarefMachine(QemuSystemTest):
     """
-    :avocado: tags=arch:aarch64
-    :avocado: tags=machine:sbsa-ref
-    :avocado: tags=accel:tcg
-
     As firmware runs at a higher privilege level than the hypervisor we
     can only run these tests under TCG emulation.
     """
 
     timeout = 180
 
+    ASSET_FLASH0 = Asset(
+        ('https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/'
+         '20240619-148232/edk2/SBSA_FLASH0.fd.xz'),
+        '0c954842a590988f526984de22e21ae0ab9cb351a0c99a8a58e928f0c7359cf7')
+
+    ASSET_FLASH1 = Asset(
+        ('https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/'
+         '20240619-148232/edk2/SBSA_FLASH1.fd.xz'),
+        'c6ec39374c4d79bb9e9cdeeb6db44732d90bb4a334cec92002b3f4b9cac4b5ee')
+
     def fetch_firmware(self):
         """
         Flash volumes generated using:
@@ -44,47 +51,31 @@ def fetch_firmware(self):
         """
 
         # Secure BootRom (TF-A code)
-        fs0_xz_url = (
-            "https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/"
-            "20240619-148232/edk2/SBSA_FLASH0.fd.xz"
-        )
-        fs0_xz_hash = "0c954842a590988f526984de22e21ae0ab9cb351a0c99a8a58e928f0c7359cf7"
-        tar_xz_path = self.fetch_asset(fs0_xz_url, asset_hash=fs0_xz_hash,
-                                      algorithm='sha256')
-        archive.extract(tar_xz_path, self.workdir)
+        fs0_xz_path = self.ASSET_FLASH0.fetch()
         fs0_path = os.path.join(self.workdir, "SBSA_FLASH0.fd")
+        lzma_uncompress(fs0_xz_path, fs0_path)
 
         # Non-secure rom (UEFI and EFI variables)
-        fs1_xz_url = (
-            "https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/"
-            "20240619-148232/edk2/SBSA_FLASH1.fd.xz"
-        )
-        fs1_xz_hash = "c6ec39374c4d79bb9e9cdeeb6db44732d90bb4a334cec92002b3f4b9cac4b5ee"
-        tar_xz_path = self.fetch_asset(fs1_xz_url, asset_hash=fs1_xz_hash,
-                                      algorithm='sha256')
-        archive.extract(tar_xz_path, self.workdir)
+        fs1_xz_path = self.ASSET_FLASH1.fetch()
         fs1_path = os.path.join(self.workdir, "SBSA_FLASH1.fd")
+        lzma_uncompress(fs1_xz_path, fs1_path)
 
         for path in [fs0_path, fs1_path]:
             with open(path, "ab+") as fd:
                 fd.truncate(256 << 20)  # Expand volumes to 256MiB
 
+        self.set_machine('sbsa-ref')
         self.vm.set_console()
         self.vm.add_args(
-            "-drive",
-            f"if=pflash,file={fs0_path},format=raw",
-            "-drive",
-            f"if=pflash,file={fs1_path},format=raw",
-            "-machine",
-            "sbsa-ref",
+            "-drive", f"if=pflash,file={fs0_path},format=raw",
+            "-drive", f"if=pflash,file={fs1_path},format=raw",
         )
 
     def test_sbsaref_edk2_firmware(self):
-        """
-        :avocado: tags=cpu:cortex-a57
-        """
 
         self.fetch_firmware()
+
+        self.vm.add_args('-cpu', 'cortex-a57')
         self.vm.launch()
 
         # TF-A boot sequence:
@@ -110,87 +101,62 @@ def test_sbsaref_edk2_firmware(self):
         wait_for_console_pattern(self, "UEFI firmware (version 1.0")
         interrupt_interactive_console_until_pattern(self, "QEMU SBSA-REF Machine")
 
+
+    ASSET_ALPINE_ISO = Asset(
+        ('https://dl-cdn.alpinelinux.org/'
+         'alpine/v3.17/releases/aarch64/alpine-standard-3.17.2-aarch64.iso'),
+        '5a36304ecf039292082d92b48152a9ec21009d3a62f459de623e19c4bd9dc027')
+
     # This tests the whole boot chain from EFI to Userspace
     # We only boot a whole OS for the current top level CPU and GIC
     # Other test profiles should use more minimal boots
     def boot_alpine_linux(self, cpu):
         self.fetch_firmware()
 
-        iso_url = (
-            "https://dl-cdn.alpinelinux.org/"
-            "alpine/v3.17/releases/aarch64/alpine-standard-3.17.2-aarch64.iso"
-        )
-
-        iso_hash = "5a36304ecf039292082d92b48152a9ec21009d3a62f459de623e19c4bd9dc027"
-        iso_path = self.fetch_asset(iso_url, algorithm="sha256", asset_hash=iso_hash)
+        iso_path = self.ASSET_ALPINE_ISO.fetch()
 
         self.vm.set_console()
         self.vm.add_args(
-            "-cpu",
-            cpu,
-            "-drive",
-            f"file={iso_path},media=cdrom,format=raw",
+            "-cpu", cpu,
+            "-drive", f"file={iso_path},media=cdrom,format=raw",
         )
 
         self.vm.launch()
         wait_for_console_pattern(self, "Welcome to Alpine Linux 3.17")
 
     def test_sbsaref_alpine_linux_cortex_a57(self):
-        """
-        :avocado: tags=cpu:cortex-a57
-        :avocado: tags=os:linux
-        """
         self.boot_alpine_linux("cortex-a57")
 
     def test_sbsaref_alpine_linux_neoverse_n1(self):
-        """
-        :avocado: tags=cpu:neoverse-n1
-        :avocado: tags=os:linux
-        """
         self.boot_alpine_linux("neoverse-n1")
 
     def test_sbsaref_alpine_linux_max_pauth_off(self):
-        """
-        :avocado: tags=cpu:max
-        :avocado: tags=os:linux
-        """
         self.boot_alpine_linux("max,pauth=off")
 
     def test_sbsaref_alpine_linux_max_pauth_impdef(self):
-        """
-        :avocado: tags=cpu:max
-        :avocado: tags=os:linux
-        """
         self.boot_alpine_linux("max,pauth-impdef=on")
 
-    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
+    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'), 'Test might timeout')
     def test_sbsaref_alpine_linux_max(self):
-        """
-        :avocado: tags=cpu:max
-        :avocado: tags=os:linux
-        """
         self.boot_alpine_linux("max")
 
 
+    ASSET_OPENBSD_ISO = Asset(
+        ('https://cdn.openbsd.org/pub/OpenBSD/7.3/arm64/miniroot73.img'),
+        '7fc2c75401d6f01fbfa25f4953f72ad7d7c18650056d30755c44b9c129b707e5')
+
     # This tests the whole boot chain from EFI to Userspace
     # We only boot a whole OS for the current top level CPU and GIC
     # Other test profiles should use more minimal boots
     def boot_openbsd73(self, cpu):
         self.fetch_firmware()
 
-        img_url = (
-            "https://cdn.openbsd.org/pub/OpenBSD/7.3/arm64/miniroot73.img"
-        )
-
-        img_hash = "7fc2c75401d6f01fbfa25f4953f72ad7d7c18650056d30755c44b9c129b707e5"
-        img_path = self.fetch_asset(img_url, algorithm="sha256", asset_hash=img_hash)
+        img_path = self.ASSET_OPENBSD_ISO.fetch()
 
         self.vm.set_console()
         self.vm.add_args(
-            "-cpu",
-            cpu,
-            "-drive",
-            f"file={img_path},format=raw,snapshot=on",
+            "-cpu", cpu,
+            "-drive", f"file={img_path},format=raw,snapshot=on",
         )
 
         self.vm.launch()
@@ -199,38 +165,22 @@ def boot_openbsd73(self, cpu):
                                  " 7.3 installation program.")
 
     def test_sbsaref_openbsd73_cortex_a57(self):
-        """
-        :avocado: tags=cpu:cortex-a57
-        :avocado: tags=os:openbsd
-        """
         self.boot_openbsd73("cortex-a57")
 
     def test_sbsaref_openbsd73_neoverse_n1(self):
-        """
-        :avocado: tags=cpu:neoverse-n1
-        :avocado: tags=os:openbsd
-        """
         self.boot_openbsd73("neoverse-n1")
 
     def test_sbsaref_openbsd73_max_pauth_off(self):
-        """
-        :avocado: tags=cpu:max
-        :avocado: tags=os:openbsd
-        """
         self.boot_openbsd73("max,pauth=off")
 
-    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
+    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'), 'Test might timeout')
     def test_sbsaref_openbsd73_max_pauth_impdef(self):
-        """
-        :avocado: tags=cpu:max
-        :avocado: tags=os:openbsd
-        """
         self.boot_openbsd73("max,pauth-impdef=on")
 
-    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
+    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'), 'Test might timeout')
     def test_sbsaref_openbsd73_max(self):
-        """
-        :avocado: tags=cpu:max
-        :avocado: tags=os:openbsd
-        """
         self.boot_openbsd73("max")
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.46.0


