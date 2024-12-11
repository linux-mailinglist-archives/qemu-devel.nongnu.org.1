Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BECEB9ED3B9
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Dec 2024 18:34:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLQVj-0007zO-C0; Wed, 11 Dec 2024 12:28:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tLQVV-0007ot-P9
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 12:28:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tLQVT-0001HK-Of
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 12:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733938095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vOzKQVZOZ/+VHfbCjlSNMjVwOIJdTjM8Ad+SBr+PYYM=;
 b=hx6kyS0NfWIe41F+VUatgbONjt/aVS0pHlETk99firvgAcXxXOx6o6goYDMX/HJ3GVBziI
 4Kh5ol3qD4pN9LsGHdTnTHfH/7hdF2PtgmRElKN4nXg3q7qNkJMR2rZwrecPQX2OIpDKZF
 narkvw+x8sYHSVccdwLHX/mSTQsLZsQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-EqKv7I7pMEC2plRUdzKD8w-1; Wed,
 11 Dec 2024 12:28:13 -0500
X-MC-Unique: EqKv7I7pMEC2plRUdzKD8w-1
X-Mimecast-MFC-AGG-ID: EqKv7I7pMEC2plRUdzKD8w
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BAFBD19560B6; Wed, 11 Dec 2024 17:28:12 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ACA881956048; Wed, 11 Dec 2024 17:28:10 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 28/31] tests/functional: replace 'run_cmd' with subprocess
 helpers
Date: Wed, 11 Dec 2024 17:26:44 +0000
Message-ID: <20241211172648.2893097-29-berrange@redhat.com>
In-Reply-To: <20241211172648.2893097-1-berrange@redhat.com>
References: <20241211172648.2893097-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The 'run_cmd' helper is re-implementing a convenient helper that
already exists in the form of the 'run' and 'check_call' methods
provided by 'subprocess'.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/archive.py    |  9 ++++---
 tests/functional/qemu_test/tesseract.py  | 10 ++++----
 tests/functional/qemu_test/testcase.py   | 31 +++++++++++++-----------
 tests/functional/qemu_test/tuxruntest.py |  8 +++---
 tests/functional/test_aarch64_virt.py    |  6 +++--
 tests/functional/test_ppc64_tuxrun.py    |  7 ++++--
 6 files changed, 41 insertions(+), 30 deletions(-)

diff --git a/tests/functional/qemu_test/archive.py b/tests/functional/qemu_test/archive.py
index c439d9413a..c803fdaf6d 100644
--- a/tests/functional/qemu_test/archive.py
+++ b/tests/functional/qemu_test/archive.py
@@ -14,7 +14,6 @@
 import zipfile
 
 from .asset import Asset
-from .cmd import run_cmd
 
 
 def tar_extract(archive, dest_dir, member=None):
@@ -52,9 +51,11 @@ def deb_extract(archive, dest_dir, member=None):
     cwd = os.getcwd()
     os.chdir(dest_dir)
     try:
-        (stdout, stderr, ret) = run_cmd(['ar', 't', archive])
-        file_path = stdout.split()[2]
-        run_cmd(['ar', 'x', archive, file_path])
+        proc = run(['ar', 't', archive],
+                   check=True, capture_output=True, encoding='utf8')
+        file_path = proc.stdout.split()[2]
+        check_call(['ar', 'x', archive, file_path],
+                   stdout=DEVNULL, stderr=DEVNULL)
         tar_extract(file_path, dest_dir, member)
     finally:
         os.chdir(cwd)
diff --git a/tests/functional/qemu_test/tesseract.py b/tests/functional/qemu_test/tesseract.py
index 1b7818090a..ede6c6501e 100644
--- a/tests/functional/qemu_test/tesseract.py
+++ b/tests/functional/qemu_test/tesseract.py
@@ -6,18 +6,18 @@
 # later. See the COPYING file in the top-level directory.
 
 import logging
+from subprocess import run
 
-from . import run_cmd
 
 def tesseract_ocr(image_path, tesseract_args=''):
     console_logger = logging.getLogger('console')
     console_logger.debug(image_path)
-    (stdout, stderr, ret) = run_cmd(['tesseract', image_path,
-                                     'stdout'])
-    if ret:
+    proc = run(['tesseract', image_path, 'stdout'],
+               capture_output=True, encoding='utf8')
+    if proc.returncode:
         return None
     lines = []
-    for line in stdout.split('\n'):
+    for line in proc.stdout.split('\n'):
         sline = line.strip()
         if len(sline):
             console_logger.debug(sline)
diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 684c94d45f..7bece8738a 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -16,7 +16,7 @@
 from pathlib import Path
 import pycotap
 import shutil
-import subprocess
+from subprocess import run
 import sys
 import tempfile
 import unittest
@@ -27,7 +27,6 @@
 
 from .archive import archive_extract
 from .asset import Asset
-from .cmd import run_cmd
 from .config import BUILD_DIR
 from .uncompress import uncompress
 
@@ -251,11 +250,11 @@ def add_ldpath(self, ldpath):
         self._ldpath.append(os.path.abspath(ldpath))
 
     def run_cmd(self, bin_path, args=[]):
-        return subprocess.run([self.qemu_bin]
-                              + ["-L %s" % ldpath for ldpath in self._ldpath]
-                              + [bin_path]
-                              + args,
-                              text=True, capture_output=True)
+        return run([self.qemu_bin]
+                   + ["-L %s" % ldpath for ldpath in self._ldpath]
+                   + [bin_path]
+                   + args,
+                   text=True, capture_output=True)
 
 class QemuSystemTest(QemuBaseTest):
     """Facilitates system emulation tests."""
@@ -282,7 +281,9 @@ def setUp(self):
     def set_machine(self, machinename):
         # TODO: We should use QMP to get the list of available machines
         if not self._machinehelp:
-            self._machinehelp = run_cmd([self.qemu_bin, '-M', 'help'])[0];
+            self._machinehelp = run(
+                [self.qemu_bin, '-M', 'help'],
+                capture_output=True, check=True, encoding='utf8').stdout
         if self._machinehelp.find(machinename) < 0:
             self.skipTest('no support for machine ' + machinename)
         self.machine = machinename
@@ -310,15 +311,17 @@ def require_accelerator(self, accelerator):
                           "available" % accelerator)
 
     def require_netdev(self, netdevname):
-        netdevhelp = run_cmd([self.qemu_bin,
-                             '-M', 'none', '-netdev', 'help'])[0];
-        if netdevhelp.find('\n' + netdevname + '\n') < 0:
+        help = run([self.qemu_bin,
+                    '-M', 'none', '-netdev', 'help'],
+                   capture_output=True, check=True, encoding='utf8').stdout;
+        if help.find('\n' + netdevname + '\n') < 0:
             self.skipTest('no support for " + netdevname + " networking')
 
     def require_device(self, devicename):
-        devhelp = run_cmd([self.qemu_bin,
-                           '-M', 'none', '-device', 'help'])[0];
-        if devhelp.find(devicename) < 0:
+        help = run([self.qemu_bin,
+                    '-M', 'none', '-device', 'help'],
+                   capture_output=True, check=True, encoding='utf8').stdout;
+        if help.find(devicename) < 0:
             self.skipTest('no support for device ' + devicename)
 
     def _new_vm(self, name, *args):
diff --git a/tests/functional/qemu_test/tuxruntest.py b/tests/functional/qemu_test/tuxruntest.py
index 0b1bb8f0ed..7227a83757 100644
--- a/tests/functional/qemu_test/tuxruntest.py
+++ b/tests/functional/qemu_test/tuxruntest.py
@@ -11,11 +11,12 @@
 
 import os
 import stat
+from subprocess import check_call, DEVNULL
 
 from qemu_test import QemuSystemTest
 from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test import wait_for_console_pattern
-from qemu_test import which, run_cmd, get_qemu_img
+from qemu_test import which, get_qemu_img
 
 class TuxRunBaselineTest(QemuSystemTest):
 
@@ -76,8 +77,9 @@ def fetch_tuxrun_assets(self, kernel_asset, rootfs_asset, dtb_asset=None):
 
         disk_image = self.scratch_file("rootfs.ext4")
 
-        run_cmd(['zstd', "-f", "-d", disk_image_zst,
-                 "-o", disk_image])
+        check_call(['zstd', "-f", "-d", disk_image_zst,
+                    "-o", disk_image],
+                   stdout=DEVNULL, stderr=DEVNULL)
         # zstd copies source archive permissions for the output
         # file, so must make this writable for QEMU
         os.chmod(disk_image, stat.S_IRUSR | stat.S_IWUSR)
diff --git a/tests/functional/test_aarch64_virt.py b/tests/functional/test_aarch64_virt.py
index cc49f8963d..08576b0694 100755
--- a/tests/functional/test_aarch64_virt.py
+++ b/tests/functional/test_aarch64_virt.py
@@ -12,10 +12,11 @@
 
 import time
 import logging
+from subprocess import check_call, DEVNULL
 
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import exec_command, wait_for_console_pattern
-from qemu_test import get_qemu_img, run_cmd
+from qemu_test import get_qemu_img
 
 
 class Aarch64VirtMachine(QemuSystemTest):
@@ -96,7 +97,8 @@ def common_aarch64_virt(self, machine):
         logger.info('creating scratch qcow2 image')
         image_path = self.scratch_file('scratch.qcow2')
         qemu_img = get_qemu_img(self)
-        run_cmd([qemu_img, 'create', '-f', 'qcow2', image_path, '8M'])
+        check_call([qemu_img, 'create', '-f', 'qcow2', image_path, '8M'],
+                   stdout=DEVNULL, stderr=DEVNULL)
 
         # Add the device
         self.vm.add_args('-blockdev',
diff --git a/tests/functional/test_ppc64_tuxrun.py b/tests/functional/test_ppc64_tuxrun.py
index 03b47e07f2..8a98d18ab3 100755
--- a/tests/functional/test_ppc64_tuxrun.py
+++ b/tests/functional/test_ppc64_tuxrun.py
@@ -11,9 +11,10 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
+from subprocess import check_call, DEVNULL
 import tempfile
 
-from qemu_test import run_cmd, Asset
+from qemu_test import Asset
 from qemu_test.tuxruntest import TuxRunBaselineTest
 
 class TuxRunPPC64Test(TuxRunBaselineTest):
@@ -70,7 +71,9 @@ def ppc64_common_tuxrun(self, kernel_asset, rootfs_asset, prefix):
         # Create a temporary qcow2 and launch the test-case
         with tempfile.NamedTemporaryFile(prefix=prefix,
                                          suffix='.qcow2') as qcow2:
-            run_cmd([self.qemu_img, 'create', '-f', 'qcow2', qcow2.name, ' 1G'])
+            check_call([self.qemu_img, 'create', '-f', 'qcow2',
+                        qcow2.name, ' 1G'],
+                       stdout=DEVNULL, stderr=DEVNULL)
 
             self.vm.add_args('-drive', 'file=' + qcow2.name +
                          ',format=qcow2,if=none,id='
-- 
2.46.0


