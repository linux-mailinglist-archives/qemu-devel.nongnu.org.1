Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE281A22D86
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Jan 2025 14:19:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdUQL-00014W-NJ; Thu, 30 Jan 2025 08:17:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdUPF-0007Y9-2R
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:16:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdUPA-0000Dt-MF
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:16:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738242983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tFfvmBjf+tWjx3sZGhtTj0tedyAer4wuoy3HKNkA20w=;
 b=d+PPUtTRPbC9t1ViqqVkTRjTGWP4H8W7Xqov2sZnfS0K1WL+d+DqrCz+vGqPcWdN64g//k
 BA3fQEH/fbg+ltcW3ihwMKE7XmNkRIlIN9l7/nQHU4tbV4XeG6DjR72vr8emKnDIsZk/SU
 3DcVplnd6xZ53w6QVaB2uG/PiorxCmA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589--96Y4m4GMdK8sYSx2v0XwQ-1; Thu,
 30 Jan 2025 08:16:22 -0500
X-MC-Unique: -96Y4m4GMdK8sYSx2v0XwQ-1
X-Mimecast-MFC-AGG-ID: -96Y4m4GMdK8sYSx2v0XwQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8542F1801F23
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 13:16:21 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.95])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3750030001BE; Thu, 30 Jan 2025 13:16:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 18/20] tests/functional/test_mips64el_malta: Convert the
 mips64el replay tests
Date: Thu, 30 Jan 2025 14:15:32 +0100
Message-ID: <20250130131535.91297-19-thuth@redhat.com>
In-Reply-To: <20250130131535.91297-1-thuth@redhat.com>
References: <20250130131535.91297-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_BTC_ID=0.499, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Move the mips64el replay tests from tests/avocado/replay_kernel.py to
the functional framework. Since the functional tests should be run per
target, we cannot stick all replay tests in one file. Thus let's add
these tests to a separate file there now.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250128152839.184599-5-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/replay_kernel.py           | 57 ----------------------
 tests/functional/meson.build             |  1 +
 tests/functional/test_mips64el_replay.py | 60 ++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 57 deletions(-)
 create mode 100755 tests/functional/test_mips64el_replay.py

diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index 4f50f48163..a45881b9a6 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -162,33 +162,6 @@ def test_mips_malta(self):
 
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
 
-    def test_mips64el_malta(self):
-        """
-        This test requires the ar tool to extract "data.tar.gz" from
-        the Debian package.
-
-        The kernel can be rebuilt using this Debian kernel source [1] and
-        following the instructions on [2].
-
-        [1] http://snapshot.debian.org/package/linux-2.6/2.6.32-48/
-            #linux-source-2.6.32_2.6.32-48
-        [2] https://kernel-team.pages.debian.net/kernel-handbook/
-            ch-common-tasks.html#s-common-official
-
-        :avocado: tags=arch:mips64el
-        :avocado: tags=machine:malta
-        """
-        deb_url = ('http://snapshot.debian.org/archive/debian/'
-                   '20130217T032700Z/pool/main/l/linux-2.6/'
-                   'linux-image-2.6.32-5-5kc-malta_2.6.32-48_mipsel.deb')
-        deb_hash = '1aaec92083bf22fda31e0d27fa8d9a388e5fc3d5'
-        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinux-2.6.32-5-5kc-malta')
-        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
-        console_pattern = 'Kernel command line: %s' % kernel_command_line
-        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
-
     def test_aarch64_virt(self):
         """
         :avocado: tags=arch:aarch64
@@ -491,33 +464,3 @@ def test_mips_malta_cpio(self):
         console_pattern = 'Boot successful.'
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5,
                     args=('-initrd', initrd_path))
-
-    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
-    def test_mips64el_malta_5KEc_cpio(self):
-        """
-        :avocado: tags=arch:mips64el
-        :avocado: tags=machine:malta
-        :avocado: tags=endian:little
-        :avocado: tags=slowness:high
-        :avocado: tags=cpu:5KEc
-        """
-        kernel_url = ('https://github.com/philmd/qemu-testing-blob/'
-                      'raw/9ad2df38/mips/malta/mips64el/'
-                      'vmlinux-3.19.3.mtoman.20150408')
-        kernel_hash = '00d1d268fb9f7d8beda1de6bebcc46e884d71754'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-        initrd_url = ('https://github.com/groeck/linux-build-test/'
-                      'raw/8584a59e/rootfs/'
-                      'mipsel64/rootfs.mipsel64r1.cpio.gz')
-        initrd_hash = '1dbb8a396e916847325284dbe2151167'
-        initrd_path_gz = self.fetch_asset(initrd_url, algorithm='md5',
-                                          asset_hash=initrd_hash)
-        initrd_path = self.workdir + "rootfs.cpio"
-        archive.gzip_uncompress(initrd_path_gz, initrd_path)
-
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               'console=ttyS0 console=tty '
-                               'rdinit=/sbin/init noreboot')
-        console_pattern = 'Boot successful.'
-        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5,
-                    args=('-initrd', initrd_path))
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 9049e2f142..cb24e0bb00 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -175,6 +175,7 @@ tests_mips64el_system_thorough = [
   'mips64el_fuloong2e',
   'mips64el_loongson3v',
   'mips64el_malta',
+  'mips64el_replay',
   'mips64el_tuxrun',
 ]
 
diff --git a/tests/functional/test_mips64el_replay.py b/tests/functional/test_mips64el_replay.py
new file mode 100755
index 0000000000..4f63d7fb34
--- /dev/null
+++ b/tests/functional/test_mips64el_replay.py
@@ -0,0 +1,60 @@
+#!/usr/bin/env python3
+#
+# Replay tests for the little-endian 64-bit MIPS Malta board
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import logging
+
+from qemu_test import Asset, exec_command_and_wait_for_pattern
+from qemu_test import skipIfMissingImports, skipFlakyTest, skipUntrustedTest
+from replay_kernel import ReplayKernelBase
+
+
+class Mips64elReplay(ReplayKernelBase):
+
+    ASSET_KERNEL_2_63_2 = Asset(
+        ('http://snapshot.debian.org/archive/debian/'
+         '20130217T032700Z/pool/main/l/linux-2.6/'
+         'linux-image-2.6.32-5-5kc-malta_2.6.32-48_mipsel.deb'),
+        '35eb476f03be589824b0310358f1c447d85e645b88cbcd2ac02b97ef560f9f8d')
+
+    def test_replay_mips64el_malta(self):
+        self.set_machine('malta')
+        kernel_path = self.archive_extract(self.ASSET_KERNEL_2_63_2,
+                                    member='boot/vmlinux-2.6.32-5-5kc-malta')
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
+
+
+    ASSET_KERNEL_3_19_3 = Asset(
+        ('https://github.com/philmd/qemu-testing-blob/'
+         'raw/9ad2df38/mips/malta/mips64el/'
+         'vmlinux-3.19.3.mtoman.20150408'),
+        '8d3beb003bc66051ead98e7172139017fcf9ce2172576541c57e86418dfa5ab8')
+
+    ASSET_CPIO_R1 = Asset(
+        ('https://github.com/groeck/linux-build-test/'
+         'raw/8584a59e/rootfs/mipsel64/'
+         'rootfs.mipsel64r1.cpio.gz'),
+        '75ba10cd35fb44e32948eeb26974f061b703c81c4ba2fab1ebcacf1d1bec3b61')
+
+    @skipUntrustedTest()
+    def test_replay_mips64el_malta_5KEc_cpio(self):
+        self.set_machine('malta')
+        self.cpu = '5KEc'
+        kernel_path = self.ASSET_KERNEL_3_19_3.fetch()
+        initrd_path = self.uncompress(self.ASSET_CPIO_R1)
+
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyS0 console=tty '
+                               'rdinit=/sbin/init noreboot')
+        console_pattern = 'Boot successful.'
+        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5,
+                    args=('-initrd', initrd_path))
+
+
+if __name__ == '__main__':
+    ReplayKernelBase.main()
-- 
2.48.1


