Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC409D2921
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Nov 2024 16:07:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDPno-00060n-7G; Tue, 19 Nov 2024 10:06:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tDPnf-0005vz-IL
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 10:05:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tDPnd-0003k4-CD
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 10:05:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732028752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mpQSBVmEKA0YchuFKMeQpzWQy9TzwDXdTqUn1SW8rgM=;
 b=Jz+leoN6vGhOAPZ+HWc35VxSK943ZTLu3+cAgDzrTOTIoZciVof36iUvaWjpuphIKCyXoT
 pWmBm5Kh3Ao4hYZfY7VtCv04LJpJNPjAB3NI4z7xYN3R04txLIA6VweDYC9YgeuEcinTmW
 BtT369wjxLpF5AAVAtcG6H6Rvu2eijQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-M98W3FevOE2abGHUGtWi_g-1; Tue,
 19 Nov 2024 10:05:49 -0500
X-MC-Unique: M98W3FevOE2abGHUGtWi_g-1
X-Mimecast-MFC-AGG-ID: M98W3FevOE2abGHUGtWi_g
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A2511955F3C; Tue, 19 Nov 2024 15:05:48 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.110])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3295A19560A3; Tue, 19 Nov 2024 15:05:45 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 08/15] tests/functional: honour self.workdir in ACPI bits tests
Date: Tue, 19 Nov 2024 15:05:12 +0000
Message-ID: <20241119150519.1123365-9-berrange@redhat.com>
In-Reply-To: <20241119150519.1123365-1-berrange@redhat.com>
References: <20241119150519.1123365-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The ACPI bits test sets up its own private temporary directory into it
creates scratch files. This is justified by a suggestion that we need
to be able to preserve the scratch files. We have the ability to
preserve the scratch dir with our functional harness, so there's no
reason to diverge from standard practice in file placement.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/test_acpi_bits.py | 44 +++++++++---------------------
 1 file changed, 13 insertions(+), 31 deletions(-)

diff --git a/tests/functional/test_acpi_bits.py b/tests/functional/test_acpi_bits.py
index 6a7758c576..8774a79312 100755
--- a/tests/functional/test_acpi_bits.py
+++ b/tests/functional/test_acpi_bits.py
@@ -150,7 +150,6 @@ class AcpiBitsTest(QemuBaseTest): #pylint: disable=too-many-instance-attributes
     def __init__(self, *args, **kwargs):
         super().__init__(*args, **kwargs)
         self._vm = None
-        self._workDir = None
         self._baseDir = None
 
         self._debugcon_addr = '0x403'
@@ -169,7 +168,7 @@ def copy_bits_config(self):
         config_file = 'bits-cfg.txt'
         bits_config_dir = os.path.join(self._baseDir, 'acpi-bits',
                                        'bits-config')
-        target_config_dir = os.path.join(self._workDir,
+        target_config_dir = os.path.join(self.workdir,
                                          'bits-%d' %self.BITS_INTERNAL_VER,
                                          'boot')
         self.assertTrue(os.path.exists(bits_config_dir))
@@ -186,7 +185,7 @@ def copy_test_scripts(self):
 
         bits_test_dir = os.path.join(self._baseDir, 'acpi-bits',
                                      'bits-tests')
-        target_test_dir = os.path.join(self._workDir,
+        target_test_dir = os.path.join(self.workdir,
                                        'bits-%d' %self.BITS_INTERNAL_VER,
                                        'boot', 'python')
 
@@ -224,8 +223,8 @@ def fix_mkrescue(self, mkrescue):
             the directory where we have extracted our pre-built bits grub
             tarball.
         """
-        grub_x86_64_mods = os.path.join(self._workDir, 'grub-inst-x86_64-efi')
-        grub_i386_mods = os.path.join(self._workDir, 'grub-inst')
+        grub_x86_64_mods = os.path.join(self.workdir, 'grub-inst-x86_64-efi')
+        grub_i386_mods = os.path.join(self.workdir, 'grub-inst')
 
         self.assertTrue(os.path.exists(grub_x86_64_mods))
         self.assertTrue(os.path.exists(grub_i386_mods))
@@ -246,11 +245,11 @@ def generate_bits_iso(self):
         """ Uses grub-mkrescue to generate a fresh bits iso with the python
             test scripts
         """
-        bits_dir = os.path.join(self._workDir,
+        bits_dir = os.path.join(self.workdir,
                                 'bits-%d' %self.BITS_INTERNAL_VER)
-        iso_file = os.path.join(self._workDir,
+        iso_file = os.path.join(self.workdir,
                                 'bits-%d.iso' %self.BITS_INTERNAL_VER)
-        mkrescue_script = os.path.join(self._workDir,
+        mkrescue_script = os.path.join(self.workdir,
                                        'grub-inst-x86_64-efi', 'bin',
                                        'grub-mkrescue')
 
@@ -289,17 +288,7 @@ def setUp(self): # pylint: disable=arguments-differ
 
         self._baseDir = Path(__file__).parent
 
-        # workdir could also be avocado's own workdir in self.workdir.
-        # At present, I prefer to maintain my own temporary working
-        # directory. It gives us more control over the generated bits
-        # log files and also for debugging, we may chose not to remove
-        # this working directory so that the logs and iso can be
-        # inspected manually and archived if needed.
-        self._workDir = tempfile.mkdtemp(prefix='acpi-bits-',
-                                         suffix='.tmp')
-        self.logger.info('working dir: %s', self._workDir)
-
-        prebuiltDir = os.path.join(self._workDir, 'prebuilt')
+        prebuiltDir = os.path.join(self.workdir, 'prebuilt')
         if not os.path.isdir(prebuiltDir):
             os.mkdir(prebuiltDir, mode=0o775)
 
@@ -320,10 +309,10 @@ def setUp(self): # pylint: disable=arguments-differ
 
         # extract the bits software in the temp working directory
         with zipfile.ZipFile(bits_zip_file, 'r') as zref:
-            zref.extractall(self._workDir)
+            zref.extractall(self.workdir)
 
         with tarfile.open(grub_tar_file, 'r', encoding='utf-8') as tarball:
-            tarball.extractall(self._workDir)
+            tarball.extractall(self.workdir)
 
         self.copy_test_scripts()
         self.copy_bits_config()
@@ -333,7 +322,7 @@ def parse_log(self):
         """parse the log generated by running bits tests and
            check for failures.
         """
-        debugconf = os.path.join(self._workDir, self._debugcon_log)
+        debugconf = os.path.join(self.workdir, self._debugcon_log)
         log = ""
         with open(debugconf, 'r', encoding='utf-8') as filehandle:
             log = filehandle.read()
@@ -359,25 +348,18 @@ def tearDown(self):
         """
         if self._vm:
             self.assertFalse(not self._vm.is_running)
-        if not os.getenv('BITS_DEBUG') and self._workDir:
-            self.logger.info('removing the work directory %s', self._workDir)
-            shutil.rmtree(self._workDir)
-        else:
-            self.logger.info('not removing the work directory %s ' \
-                             'as BITS_DEBUG is ' \
-                             'passed in the environment', self._workDir)
         super().tearDown()
 
     def test_acpi_smbios_bits(self):
         """The main test case implementation."""
 
-        iso_file = os.path.join(self._workDir,
+        iso_file = os.path.join(self.workdir,
                                 'bits-%d.iso' %self.BITS_INTERNAL_VER)
 
         self.assertTrue(os.access(iso_file, os.R_OK))
 
         self._vm = QEMUBitsMachine(binary=self.qemu_bin,
-                                   base_temp_dir=self._workDir,
+                                   base_temp_dir=self.workdir,
                                    debugcon_log=self._debugcon_log,
                                    debugcon_addr=self._debugcon_addr)
 
-- 
2.46.0


