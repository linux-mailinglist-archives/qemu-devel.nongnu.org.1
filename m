Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD42A20D0E
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Jan 2025 16:30:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcnWp-0002PR-0L; Tue, 28 Jan 2025 10:29:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tcnWi-0002Mz-IU
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 10:29:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tcnWg-0004y9-MZ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 10:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738078158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9gAgBMdzClKVT2mKK3fuQ/Y+AkGacCs7NGuvmu+0J4s=;
 b=B6jDpHxnTzO6wJmgvNRTcioSiNl0ovFLbO6YKfOqMV6sFSl8N5upS5g9UXk8cfwoplcb8n
 C6RHC3Iu1l12sU/lh+7OMGTraAw29fC54TU4faQ302+UMOmYTQFvE+yi5F2thwFD16bXxM
 ih8IO0bG7ZecBjvDDuPkkrkl2p9048U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-5N9vAs3LP0K28JsTazulGQ-1; Tue,
 28 Jan 2025 10:29:13 -0500
X-MC-Unique: 5N9vAs3LP0K28JsTazulGQ-1
X-Mimecast-MFC-AGG-ID: 5N9vAs3LP0K28JsTazulGQ
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C704B180189A; Tue, 28 Jan 2025 15:29:10 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.195.33])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 222A51801A62; Tue, 28 Jan 2025 15:29:06 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hao Wu <wuhaotsh@google.com>, Tyrone Ting <kfting@nuvoton.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 5/5] tests/functional/test_mips_malta: Convert the mips big
 endian replay tests
Date: Tue, 28 Jan 2025 16:28:39 +0100
Message-ID: <20250128152839.184599-6-thuth@redhat.com>
In-Reply-To: <20250128152839.184599-1-thuth@redhat.com>
References: <20250128152839.184599-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Move the mips big endian replay tests from tests/avocado/replay_kernel.py
to the functional framework. Since the functional tests should be run per
target, we cannot stick all replay tests in one file. Thus let's add
these tests to a separate file now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/replay_kernel.py       | 54 ---------------------------
 tests/functional/meson.build         |  1 +
 tests/functional/test_mips_replay.py | 55 ++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 54 deletions(-)
 create mode 100755 tests/functional/test_mips_replay.py

diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index 89a0c0b997..39dbaf5e4d 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -128,24 +128,6 @@ def test_x86_64_q35(self):
 
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
 
-    def test_mips_malta(self):
-        """
-        :avocado: tags=arch:mips
-        :avocado: tags=machine:malta
-        :avocado: tags=endian:big
-        """
-        deb_url = ('http://snapshot.debian.org/archive/debian/'
-                   '20130217T032700Z/pool/main/l/linux-2.6/'
-                   'linux-image-2.6.32-5-4kc-malta_2.6.32-48_mips.deb')
-        deb_hash = 'a8cfc28ad8f45f54811fc6cf74fc43ffcfe0ba04'
-        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinux-2.6.32-5-4kc-malta')
-        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
-        console_pattern = 'Kernel command line: %s' % kernel_command_line
-
-        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
-
     def test_aarch64_virt(self):
         """
         :avocado: tags=arch:aarch64
@@ -412,39 +394,3 @@ def test_xtensa_lx60(self):
                    '/qac-best-of-multiarch/download/day02.tar.xz')
         file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
         self.do_test_advcal_2018(file_path, 'santas-sleigh-ride.elf')
-
-@skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
-class ReplayKernelSlow(ReplayKernelBase):
-    # Override the timeout, because this kernel includes an inner
-    # loop which is executed with TB recompilings during replay,
-    # making it very slow.
-    timeout = 180
-
-    def test_mips_malta_cpio(self):
-        """
-        :avocado: tags=arch:mips
-        :avocado: tags=machine:malta
-        :avocado: tags=endian:big
-        :avocado: tags=slowness:high
-        """
-        deb_url = ('http://snapshot.debian.org/archive/debian/'
-                   '20160601T041800Z/pool/main/l/linux/'
-                   'linux-image-4.5.0-2-4kc-malta_4.5.5-1_mips.deb')
-        deb_hash = 'a3c84f3e88b54e06107d65a410d1d1e8e0f340f8'
-        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinux-4.5.0-2-4kc-malta')
-        initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
-                      '8584a59ed9e5eb5ee7ca91f6d74bbb06619205b8/rootfs/'
-                      'mips/rootfs.cpio.gz')
-        initrd_hash = 'bf806e17009360a866bf537f6de66590de349a99'
-        initrd_path_gz = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
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
index 0a7a382ef6..164699b6c4 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -157,6 +157,7 @@ tests_microblazeel_system_thorough = [
 
 tests_mips_system_thorough = [
   'mips_malta',
+  'mips_replay',
   'mips_tuxrun',
 ]
 
diff --git a/tests/functional/test_mips_replay.py b/tests/functional/test_mips_replay.py
new file mode 100755
index 0000000000..eda031ccad
--- /dev/null
+++ b/tests/functional/test_mips_replay.py
@@ -0,0 +1,55 @@
+#!/usr/bin/env python3
+#
+# Replay tests for the big-endian 32-bit MIPS Malta board
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset, skipSlowTest, exec_command_and_wait_for_pattern
+from replay_kernel import ReplayKernelBase
+
+
+class MipsReplay(ReplayKernelBase):
+
+    ASSET_KERNEL_2_63_2 = Asset(
+        ('http://snapshot.debian.org/archive/debian/'
+         '20130217T032700Z/pool/main/l/linux-2.6/'
+         'linux-image-2.6.32-5-4kc-malta_2.6.32-48_mips.deb'),
+        '16ca524148afb0626f483163e5edf352bc1ab0e4fc7b9f9d473252762f2c7a43')
+
+    def test_replay_mips_malta(self):
+        self.set_machine('malta')
+        kernel_path = self.archive_extract(self.ASSET_KERNEL_2_63_2,
+                                     member='boot/vmlinux-2.6.32-5-4kc-malta')
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
+
+    ASSET_KERNEL_4_5_0 = Asset(
+        ('http://snapshot.debian.org/archive/debian/'
+         '20160601T041800Z/pool/main/l/linux/'
+         'linux-image-4.5.0-2-4kc-malta_4.5.5-1_mips.deb'),
+        '526b17d5889840888b76fc2c36a0ebde182c9b1410a3a1e68203c3b160eb2027')
+
+    ASSET_INITRD = Asset(
+        ('https://github.com/groeck/linux-build-test/raw/'
+         '8584a59ed9e5eb5ee7ca91f6d74bbb06619205b8/rootfs/'
+         'mips/rootfs.cpio.gz'),
+        'dcfe3a7fe3200da3a00d176b95caaa086495eb158f2bff64afc67d7e1eb2cddc')
+
+    @skipSlowTest()
+    def test_replay_mips_malta_cpio(self):
+        self.set_machine('malta')
+        kernel_path = self.archive_extract(self.ASSET_KERNEL_4_5_0,
+                                      member='boot/vmlinux-4.5.0-2-4kc-malta')
+        initrd_path = self.uncompress(self.ASSET_INITRD)
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


