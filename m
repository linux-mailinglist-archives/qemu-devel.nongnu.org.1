Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BE8959690
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Aug 2024 10:31:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sggji-0007kw-Rj; Wed, 21 Aug 2024 04:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sggjJ-0006U2-6c
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 04:30:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sggj9-0004Zj-Mk
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 04:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724228997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fwCpJtUSYXaPX3+p6YSDEzXzuEoFq3SxTB6+njIpWUc=;
 b=TwVcp91RGHe9tzlg0JTUP2tOtmxg74gBbFCT9K/fr2lePJT7h4fXXlmMhz0AsePKJAk0ig
 3YU8rFg21pNOw3fePr6wRM7ULe3oh16Gok+CFlI2L7EInpO+PB/u6MjqcDqqRcOEEArtgM
 XDww35TNaYCdfWy0WKS517qqqqzIlz0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-jjFiyWzQNnqqfXwUXNHCnA-1; Wed,
 21 Aug 2024 04:29:53 -0400
X-MC-Unique: jjFiyWzQNnqqfXwUXNHCnA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7013B1954B21; Wed, 21 Aug 2024 08:29:47 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-191.str.redhat.com
 [10.33.192.191])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 60DDE1955F1B; Wed, 21 Aug 2024 08:29:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v4 29/35] tests/functional: Convert the rx_gdbsim avocado test
 into a standalone test
Date: Wed, 21 Aug 2024 10:27:30 +0200
Message-ID: <20240821082748.65853-30-thuth@redhat.com>
In-Reply-To: <20240821082748.65853-1-thuth@redhat.com>
References: <20240821082748.65853-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Provide a "gzip_uncompress" function based on the standard "gzip" module
to avoid the usage of avocado.utils here.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   |  2 +-
 tests/functional/meson.build                  |  4 ++
 tests/functional/qemu_test/utils.py           | 12 +++++
 .../test_rx_gdbsim.py}                        | 54 ++++++++++---------
 4 files changed, 46 insertions(+), 26 deletions(-)
 rename tests/{avocado/machine_rx_gdbsim.py => functional/test_rx_gdbsim.py} (58%)
 mode change 100644 => 100755

diff --git a/MAINTAINERS b/MAINTAINERS
index c2dfb3dad3..25e71ac14c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1665,7 +1665,7 @@ R: Yoshinori Sato <ysato@users.sourceforge.jp>
 S: Orphan
 F: docs/system/target-rx.rst
 F: hw/rx/rx-gdbsim.c
-F: tests/avocado/machine_rx_gdbsim.py
+F: tests/functional/test_rx_gdbsim.py
 
 SH4 Machines
 ------------
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index aa999cb880..e28aa34087 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -82,6 +82,10 @@ tests_riscv64_quick = [
   'riscv_opensbi',
 ]
 
+tests_rx_thorough = [
+  'rx_gdbsim',
+]
+
 tests_s390x_thorough = [
   's390x_ccw_virtio',
   's390x_topology',
diff --git a/tests/functional/qemu_test/utils.py b/tests/functional/qemu_test/utils.py
index a12dac51b6..99eae5fc45 100644
--- a/tests/functional/qemu_test/utils.py
+++ b/tests/functional/qemu_test/utils.py
@@ -8,6 +8,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
+import gzip
 import lzma
 import os
 import shutil
@@ -23,6 +24,17 @@ def archive_extract(archive, dest_dir, member=None):
         else:
             tf.extractall(path=dest_dir)
 
+def gzip_uncompress(gz_path, output_path):
+    if os.path.exists(output_path):
+        return
+    with gzip.open(gz_path, 'rb') as gz_in:
+        try:
+            with open(output_path, 'wb') as raw_out:
+                shutil.copyfileobj(gz_in, raw_out)
+        except:
+            os.remove(output_path)
+            raise
+
 def lzma_uncompress(xz_path, output_path):
     if os.path.exists(output_path):
         return
diff --git a/tests/avocado/machine_rx_gdbsim.py b/tests/functional/test_rx_gdbsim.py
old mode 100644
new mode 100755
similarity index 58%
rename from tests/avocado/machine_rx_gdbsim.py
rename to tests/functional/test_rx_gdbsim.py
index 6bd9ce8199..5687f756bb
--- a/tests/avocado/machine_rx_gdbsim.py
+++ b/tests/functional/test_rx_gdbsim.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Functional test that boots a Linux kernel and checks the console
 #
 # Copyright (c) 2018 Red Hat, Inc.
@@ -10,11 +12,11 @@
 
 import os
 
-from avocado import skipUnless
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import exec_command_and_wait_for_pattern
-from avocado_qemu import wait_for_console_pattern
-from avocado.utils import archive
+from unittest import skipUnless
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import wait_for_console_pattern
+from qemu_test.utils import gzip_uncompress
 
 
 class RxGdbSimMachine(QemuSystemTest):
@@ -22,19 +24,25 @@ class RxGdbSimMachine(QemuSystemTest):
     timeout = 30
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
 
+    ASSET_UBOOT = Asset(
+        'https://acc.dl.osdn.jp/users/23/23888/u-boot.bin.gz',
+        '7146567d669e91dbac166384b29aeba1715beb844c8551e904b86831bfd9d046')
+    ASSET_DTB = Asset(
+        'https://acc.dl.osdn.jp/users/23/23887/rx-virt.dtb',
+        'aa278d9c1907a4501741d7ee57e7f65c02dd1b3e0323b33c6d4247f1b32cf29a')
+    ASSET_KERNEL = Asset(
+        'http://acc.dl.osdn.jp/users/23/23845/zImage',
+        'baa43205e74a7220ed8482188c5e9ce497226712abb7f4e7e4f825ce19ff9656')
+
     def test_uboot(self):
         """
         U-Boot and checks that the console is operational.
-
-        :avocado: tags=arch:rx
-        :avocado: tags=machine:gdbsim-r5f562n8
-        :avocado: tags=endian:little
-        :avocado: tags=flaky
         """
-        uboot_url = ('https://acc.dl.osdn.jp/users/23/23888/u-boot.bin.gz')
-        uboot_hash = '9b78dbd43b40b2526848c0b1ce9de02c24f4dcdb'
-        uboot_path = self.fetch_asset(uboot_url, asset_hash=uboot_hash)
-        uboot_path = archive.uncompress(uboot_path, self.workdir)
+        self.set_machine('gdbsim-r5f562n8')
+
+        uboot_path_gz = self.ASSET_UBOOT.fetch()
+        uboot_path = os.path.join(self.workdir, 'u-boot.bin')
+        gzip_uncompress(uboot_path_gz, uboot_path)
 
         self.vm.set_console()
         self.vm.add_args('-bios', uboot_path,
@@ -50,18 +58,11 @@ def test_uboot(self):
     def test_linux_sash(self):
         """
         Boots a Linux kernel and checks that the console is operational.
-
-        :avocado: tags=arch:rx
-        :avocado: tags=machine:gdbsim-r5f562n7
-        :avocado: tags=endian:little
-        :avocado: tags=flaky
         """
-        dtb_url = ('https://acc.dl.osdn.jp/users/23/23887/rx-virt.dtb')
-        dtb_hash = '7b4e4e2c71905da44e86ce47adee2210b026ac18'
-        dtb_path = self.fetch_asset(dtb_url, asset_hash=dtb_hash)
-        kernel_url = ('http://acc.dl.osdn.jp/users/23/23845/zImage')
-        kernel_hash = '39a81067f8d72faad90866ddfefa19165d68fc99'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+        self.set_machine('gdbsim-r5f562n7')
+
+        dtb_path = self.ASSET_DTB.fetch()
+        kernel_path = self.ASSET_KERNEL.fetch()
 
         self.vm.set_console()
         kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'earlycon'
@@ -72,3 +73,6 @@ def test_linux_sash(self):
         wait_for_console_pattern(self, 'Sash command shell (version 1.1.1)',
                                  failure_message='Kernel panic - not syncing')
         exec_command_and_wait_for_pattern(self, 'printenv', 'TERM=linux')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.46.0


