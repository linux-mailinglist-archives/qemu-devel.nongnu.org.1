Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A813896FA62
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Sep 2024 20:07:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smdM7-0008C0-0J; Fri, 06 Sep 2024 14:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smdLs-0007ma-EP
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 14:06:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smdLp-00053o-Jg
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 14:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725645989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ji84iv9XBJKYjEg7xYMJZg1LQX8VnwwUmA7czsLEGX8=;
 b=hwJzwMWhppqrNvEiH9sDz0A6n1FPYAxaxBMCgWxK2YwtO1W6OSNPBzwOaszkeqv/z7fKDh
 mWSGDjPcYYPELQCrC3WuOd2O9JWZr5we/NUCbX/zAHQd5EH3hg0fwZwifa5hTxlnrbDiCB
 d5tOaJBnS/EIFXZ73MnDWW6lUgLv7A4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540--OPRPHQjPD6smKOd9JS_YQ-1; Fri,
 06 Sep 2024 14:06:27 -0400
X-MC-Unique: -OPRPHQjPD6smKOd9JS_YQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A83921977009; Fri,  6 Sep 2024 18:06:26 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.70])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2815C19560AA; Fri,  6 Sep 2024 18:06:23 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Subject: [PATCH 10/14] tests/functional: Convert Aarch64 Raspi3 avocado tests
Date: Fri,  6 Sep 2024 20:05:45 +0200
Message-ID: <20240906180549.792832-11-thuth@redhat.com>
In-Reply-To: <20240906180549.792832-1-thuth@redhat.com>
References: <20240906180549.792832-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Straight forward conversion. Update the SHA1 hashes to SHA256
hashes since SHA1 should not be used anymore nowadays.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240826221058.75126-4-philmd@linaro.org>
[thuth: Use the LinuxKernelTest class]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                             |  1 +
 tests/avocado/boot_linux_console.py     | 23 --------------
 tests/functional/meson.build            |  1 +
 tests/functional/test_aarch64_raspi3.py | 41 +++++++++++++++++++++++++
 4 files changed, 43 insertions(+), 23 deletions(-)
 create mode 100755 tests/functional/test_aarch64_raspi3.py

diff --git a/MAINTAINERS b/MAINTAINERS
index eaf71bb976..4e5a6d71b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -912,6 +912,7 @@ F: include/hw/arm/rasp*
 F: include/hw/*/bcm283*
 F: docs/system/arm/raspi.rst
 F: tests/functional/test_arm_raspi2.py
+F: tests/functional/test_aarch64_raspi3.py
 
 Real View
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 827a286429..e4caf34379 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -979,29 +979,6 @@ def test_arm_orangepi_uboot_netbsd9(self):
         # Wait for user-space
         wait_for_console_pattern(self, 'Starting root file system check')
 
-    def test_aarch64_raspi3_atf(self):
-        """
-        :avocado: tags=accel:tcg
-        :avocado: tags=arch:aarch64
-        :avocado: tags=machine:raspi3b
-        :avocado: tags=cpu:cortex-a53
-        :avocado: tags=device:pl011
-        :avocado: tags=atf
-        """
-        zip_url = ('https://github.com/pbatard/RPi3/releases/download/'
-                   'v1.15/RPi3_UEFI_Firmware_v1.15.zip')
-        zip_hash = '74b3bd0de92683cadb14e008a7575e1d0c3cafb9'
-        zip_path = self.fetch_asset(zip_url, asset_hash=zip_hash)
-
-        archive.extract(zip_path, self.workdir)
-        efi_fd = os.path.join(self.workdir, 'RPI_EFI.fd')
-
-        self.vm.set_console(console_index=1)
-        self.vm.add_args('-nodefaults',
-                         '-device', 'loader,file=%s,force-raw=true' % efi_fd)
-        self.vm.launch()
-        self.wait_for_console_pattern('version UEFI Firmware v1.15')
-
     def test_alpha_clipper(self):
         """
         :avocado: tags=arch:alpha
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index ff3fe7981e..35eebbe9b9 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -35,6 +35,7 @@ tests_generic_bsduser = [
 ]
 
 tests_aarch64_system_thorough = [
+  'aarch64_raspi3',
   'aarch64_sbsaref',
   'aarch64_virt',
 ]
diff --git a/tests/functional/test_aarch64_raspi3.py b/tests/functional/test_aarch64_raspi3.py
new file mode 100755
index 0000000000..369f95a3d9
--- /dev/null
+++ b/tests/functional/test_aarch64_raspi3.py
@@ -0,0 +1,41 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel on a Raspberry Pi machine
+# and checks the console
+#
+# Copyright (c) 2020 Philippe Mathieu-Daudé <f4bug@amsat.org>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+from zipfile import ZipFile
+
+from qemu_test import LinuxKernelTest, Asset
+
+
+class Aarch64Raspi3Machine(LinuxKernelTest):
+
+    ASSET_RPI3_UEFI = Asset(
+        ('https://github.com/pbatard/RPi3/releases/download/'
+         'v1.15/RPi3_UEFI_Firmware_v1.15.zip'),
+        '8cff2e979560048b4c84921f41a91893240b9fb71a88f0b5c5d6c8edd994bd5b')
+
+    def test_aarch64_raspi3_atf(self):
+        efi_name = 'RPI_EFI.fd'
+        zip_path = self.ASSET_RPI3_UEFI.fetch()
+
+        with ZipFile(zip_path, 'r') as zf:
+                     zf.extract(efi_name, path=self.workdir)
+        efi_fd = os.path.join(self.workdir, efi_name)
+
+        self.set_machine('raspi3b')
+        self.vm.set_console(console_index=1)
+        self.vm.add_args('-cpu', 'cortex-a53',
+                         '-nodefaults',
+                         '-device', f'loader,file={efi_fd},force-raw=true')
+        self.vm.launch()
+        self.wait_for_console_pattern('version UEFI Firmware v1.15')
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.46.0


