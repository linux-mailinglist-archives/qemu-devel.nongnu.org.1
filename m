Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A65D800E3D
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 16:14:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r95CX-00050L-R4; Fri, 01 Dec 2023 10:13:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r95C1-0004rA-Gm
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 10:12:42 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r95Bv-0003ss-GO
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 10:12:37 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40b4f60064eso22260025e9.1
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 07:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701443550; x=1702048350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CILzwn6E0PdXeCb4qj1dxi6nAuVedehhKSy9oJRmnFs=;
 b=iR1ax6BhxVk5A5LGGuIFfntG9UKlZjzJU6vlxbSNtPpcG0Wa6lgYew7EuNZx8zLgGR
 ft0KoIuZc7ZD+FV+LiUff7eh8Z+cUttQCnUJHjS3X9pqRj5ZvyXyvaivcrNN5No9F7a7
 GXCnyJOLcNujdEs3uGv0KlwiMaLNE9n+LXU2YvIjp1cmm+8MCPi3a1So7F6VLsx6+7cV
 vl6a4u64B/oWNTJn0LgyLaSwfZ3hLNBfxx2vQdYa2OW8X2wMxXzVEJRZg0CPz1mKhaJP
 iOgseyjFYJW6FWRwgDIh4f4y43n9JJ1O8G/RfQZT5psojQII5Dxndeh3iVlHgCk4bl5f
 nVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701443550; x=1702048350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CILzwn6E0PdXeCb4qj1dxi6nAuVedehhKSy9oJRmnFs=;
 b=a6+YSvW/IgAwDKzGsVgTIgBISohutr8JTi1MykhOsGloc46BvP/Cs8HUIN7D+hJn7+
 m0YFCWoCkyHZa+j7DXiQNU96uWlJ44H19VS9lxpJWYBKDzR4q3ylJ5Q8yisSyPEH4fJI
 zc0P3ivcXSo03Py+tkUPT7My2/oH1F5sCs/NXsQKuy5p7Ynd2NvaKrQyQmoS4lqeCMKs
 O2dSUFPlDEUzcS/kCa62InjsQAQQUzZnleMhgkPD0Sfc4sI/QqiURLgZkjXYv7CPus2R
 x3NpiqPVBRzcWTHko0ZC5FZo+QoVVAcgs+fS2wZCL6wcFxkwfQoFUfmKNVvvj4dl0c3V
 meWQ==
X-Gm-Message-State: AOJu0YzpNvp5wHdfhqFxXihwUlD624NEPmBJ3gyajHehnbEFDp4GPGWV
 8n5MeNTKtk1idXZU06fTSOMDHQ==
X-Google-Smtp-Source: AGHT+IG8xY1Q4RXBKn2JJQRswoW42sjM6PolpjAZpEHBwZGOTpeOaxwm4a3uIG8Oe0SYwUnH9GjWkA==
X-Received: by 2002:a7b:c45a:0:b0:40b:5f03:b42e with SMTP id
 l26-20020a7bc45a000000b0040b5f03b42emr219917wmi.336.1701443550024; 
 Fri, 01 Dec 2023 07:12:30 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a13-20020a05600c348d00b0040b5377cf03sm9420700wmq.1.2023.12.01.07.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 07:12:29 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 218245FB63;
 Fri,  1 Dec 2023 15:12:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Aurelien Jarno <aurelien@aurel32.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org (open list:ASPEED BMCs),
 qemu-s390x@nongnu.org (open list:S390 Virtio-ccw)
Subject: [PULL 2/6] docs/devel: rationalise unstable gitlab tests under
 FLAKY_TESTS
Date: Fri,  1 Dec 2023 15:12:24 +0000
Message-Id: <20231201151228.2610209-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231201151228.2610209-1-alex.bennee@linaro.org>
References: <20231201151228.2610209-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

It doesn't make sense to have two classes of flaky tests. While it may
take the constrained environment of CI to trigger failures easily it
doesn't mean they don't occasionally happen on developer machines. As
CI is the gating factor to passing there is no point developers
running the tests locally anyway unless they are trying to fix things.

While we are at it update the language in the docs to discourage the
QEMU_TEST_FLAKY_TESTS becoming a permanent solution.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231201093633.2551497-3-alex.bennee@linaro.org>

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 22218dbedb..76465b8f3d 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -1371,23 +1371,32 @@ conditions. For example, tests that take longer to execute when QEMU is
 compiled with debug flags. Therefore, the ``AVOCADO_TIMEOUT_EXPECTED`` variable
 has been used to determine whether those tests should run or not.
 
-GITLAB_CI
-^^^^^^^^^
-A number of tests are flagged to not run on the GitLab CI. Usually because
-they proved to the flaky or there are constraints on the CI environment which
-would make them fail. If you encounter a similar situation then use that
-variable as shown on the code snippet below to skip the test:
+QEMU_TEST_FLAKY_TESTS
+^^^^^^^^^^^^^^^^^^^^^
+Some tests are not working reliably and thus are disabled by default.
+This includes tests that don't run reliably on GitLab's CI which
+usually expose real issues that are rarely seen on developer machines
+due to the constraints of the CI environment. If you encounter a
+similar situation then raise a bug and then mark the test as shown on
+the code snippet below:
 
 .. code::
 
-  @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
+  # See https://gitlab.com/qemu-project/qemu/-/issues/nnnn
+  @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
   def test(self):
       do_something()
 
-QEMU_TEST_FLAKY_TESTS
-^^^^^^^^^^^^^^^^^^^^^
-Some tests are not working reliably and thus are disabled by default.
-Set this environment variable to enable them.
+Tests should not live in this state forever and should either be fixed
+or eventually removed.
+
+To run such tests locally you will need to set the environment
+variable. For example:
+
+.. code::
+
+   env QEMU_TEST_FLAKY_TESTS=1 ./pyvenv/bin/avocado run \
+      tests/avocado/boot_linux.py:BootLinuxPPC64.test_pseries_tcg
 
 Uninstalling Avocado
 ~~~~~~~~~~~~~~~~~~~~
diff --git a/tests/avocado/boot_linux.py b/tests/avocado/boot_linux.py
index be30dcbd58..9e9773e6e1 100644
--- a/tests/avocado/boot_linux.py
+++ b/tests/avocado/boot_linux.py
@@ -12,7 +12,7 @@
 
 from avocado_qemu import LinuxTest, BUILD_DIR
 
-from avocado import skipIf
+from avocado import skipUnless
 
 
 class BootLinuxX8664(LinuxTest):
@@ -93,7 +93,8 @@ class BootLinuxPPC64(LinuxTest):
 
     timeout = 360
 
-    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
+
     def test_pseries_tcg(self):
         """
         :avocado: tags=machine:pseries
@@ -111,7 +112,8 @@ class BootLinuxS390X(LinuxTest):
 
     timeout = 240
 
-    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
+
     def test_s390_ccw_virtio_tcg(self):
         """
         :avocado: tags=machine:s390-ccw-virtio
diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 6eab515718..231b4f68e5 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -15,7 +15,7 @@
 
 from avocado import skip
 from avocado import skipUnless
-from avocado import skipIf
+from avocado import skipUnless
 from avocado_qemu import QemuSystemTest
 from avocado_qemu import exec_command
 from avocado_qemu import exec_command_and_wait_for_pattern
@@ -1419,7 +1419,8 @@ def test_ppc_mac99(self):
     # This test has a 6-10% failure rate on various hosts that look
     # like issues with a buggy kernel. As a result we don't want it
     # gating releases on Gitlab.
-    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
+
     def test_sh4_r2d(self):
         """
         :avocado: tags=arch:sh4
diff --git a/tests/avocado/intel_iommu.py b/tests/avocado/intel_iommu.py
index 77635ab56c..2dd11a6346 100644
--- a/tests/avocado/intel_iommu.py
+++ b/tests/avocado/intel_iommu.py
@@ -9,10 +9,11 @@
 # later.  See the COPYING file in the top-level directory.
 import os
 
-from avocado import skipIf
+from avocado import skipUnless
 from avocado_qemu import LinuxTest
 
-@skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
+@skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
+
 class IntelIOMMU(LinuxTest):
     """
     :avocado: tags=arch:x86_64
diff --git a/tests/avocado/linux_initrd.py b/tests/avocado/linux_initrd.py
index ba02e5a563..c40a987bd1 100644
--- a/tests/avocado/linux_initrd.py
+++ b/tests/avocado/linux_initrd.py
@@ -13,7 +13,7 @@
 import tempfile
 
 from avocado_qemu import QemuSystemTest
-from avocado import skipIf
+from avocado import skipUnless
 
 
 class LinuxInitrd(QemuSystemTest):
@@ -53,7 +53,8 @@ def test_with_2gib_file_should_exit_error_msg_with_linux_v3_6(self):
                 max_size + 1)
             self.assertRegex(self.vm.get_log(), expected_msg)
 
-    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
+
     def test_with_2gib_file_should_work_with_linux_v4_16(self):
         """
         QEMU has supported up to 4 GiB initrd for recent kernel
diff --git a/tests/avocado/machine_aspeed.py b/tests/avocado/machine_aspeed.py
index df31b2a8a8..258fb50c47 100644
--- a/tests/avocado/machine_aspeed.py
+++ b/tests/avocado/machine_aspeed.py
@@ -18,7 +18,7 @@
 from avocado_qemu import interrupt_interactive_console_until_pattern
 from avocado_qemu import has_cmd
 from avocado.utils import archive
-from avocado import skipIf
+from avocado import skipUnless
 from avocado import skipUnless
 
 
@@ -311,7 +311,8 @@ def do_test_arm_aspeed_sdk_start(self, image):
             self, 'boot', '## Loading kernel from FIT Image')
         self.wait_for_console_pattern('Starting kernel ...')
 
-    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
+
     def test_arm_ast2500_evb_sdk(self):
         """
         :avocado: tags=arch:arm
@@ -329,7 +330,8 @@ def test_arm_ast2500_evb_sdk(self):
             self.workdir + '/ast2500-default/image-bmc')
         self.wait_for_console_pattern('nodistro.0 ast2500-default ttyS4')
 
-    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
+
     def test_arm_ast2600_evb_sdk(self):
         """
         :avocado: tags=arch:arm
diff --git a/tests/avocado/machine_mips_malta.py b/tests/avocado/machine_mips_malta.py
index 9bd54518bf..959dcf5602 100644
--- a/tests/avocado/machine_mips_malta.py
+++ b/tests/avocado/machine_mips_malta.py
@@ -11,7 +11,7 @@
 import gzip
 import logging
 
-from avocado import skipIf
+from avocado import skipUnless
 from avocado import skipUnless
 from avocado.utils import archive
 from avocado_qemu import QemuSystemTest
@@ -101,7 +101,8 @@ def test_mips_malta_i6400_framebuffer_logo_1core(self):
         """
         self.do_test_i6400_framebuffer_logo(1)
 
-    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
+
     def test_mips_malta_i6400_framebuffer_logo_7cores(self):
         """
         :avocado: tags=arch:mips64el
@@ -111,7 +112,8 @@ def test_mips_malta_i6400_framebuffer_logo_7cores(self):
         """
         self.do_test_i6400_framebuffer_logo(7)
 
-    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
+
     def test_mips_malta_i6400_framebuffer_logo_8cores(self):
         """
         :avocado: tags=arch:mips64el
diff --git a/tests/avocado/machine_rx_gdbsim.py b/tests/avocado/machine_rx_gdbsim.py
index 6cd8704b01..350a73fbbb 100644
--- a/tests/avocado/machine_rx_gdbsim.py
+++ b/tests/avocado/machine_rx_gdbsim.py
@@ -10,7 +10,7 @@
 
 import os
 
-from avocado import skipIf
+from avocado import skipUnless
 from avocado_qemu import QemuSystemTest
 from avocado_qemu import exec_command_and_wait_for_pattern
 from avocado_qemu import wait_for_console_pattern
@@ -22,7 +22,8 @@ class RxGdbSimMachine(QemuSystemTest):
     timeout = 30
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
 
-    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
+
     def test_uboot(self):
         """
         U-Boot and checks that the console is operational.
@@ -46,7 +47,8 @@ def test_uboot(self):
         # FIXME limit baudrate on chardev, else we type too fast
         #exec_command_and_wait_for_pattern(self, 'version', gcc_version)
 
-    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
+
     def test_linux_sash(self):
         """
         Boots a Linux kernel and checks that the console is operational.
diff --git a/tests/avocado/machine_s390_ccw_virtio.py b/tests/avocado/machine_s390_ccw_virtio.py
index ffd914ded9..61e75d8f9e 100644
--- a/tests/avocado/machine_s390_ccw_virtio.py
+++ b/tests/avocado/machine_s390_ccw_virtio.py
@@ -12,7 +12,7 @@
 import os
 import tempfile
 
-from avocado import skipIf
+from avocado import skipUnless
 from avocado_qemu import QemuSystemTest
 from avocado_qemu import exec_command_and_wait_for_pattern
 from avocado_qemu import wait_for_console_pattern
diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index 53cb7e5091..0d32cc280e 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -15,7 +15,7 @@
 import time
 
 from avocado import skip
-from avocado import skipIf
+from avocado import skipUnless
 from avocado import skipUnless
 from avocado_qemu import wait_for_console_pattern
 from avocado.utils import archive
@@ -82,6 +82,7 @@ def run_rr(self, kernel_path, kernel_command_line, console_pattern,
 
 class ReplayKernelNormal(ReplayKernelBase):
 
+    # See https://gitlab.com/qemu-project/qemu/-/issues/2010
     @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test sometimes gets stuck')
     def test_x86_64_pc(self):
         """
@@ -179,7 +180,8 @@ def test_arm_virt(self):
 
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=1)
 
-    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
+
     def test_arm_cubieboard_initrd(self):
         """
         :avocado: tags=arch:arm
diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_debugging.py
index ed04e92bb4..9a468321e5 100644
--- a/tests/avocado/reverse_debugging.py
+++ b/tests/avocado/reverse_debugging.py
@@ -10,7 +10,7 @@
 import os
 import logging
 
-from avocado import skipIf
+from avocado import skipUnless
 from avocado_qemu import BUILD_DIR
 from avocado.utils import datadrainer
 from avocado.utils import gdb
@@ -206,7 +206,8 @@ def get_pc(self, g):
             + self.get_reg_le(g, self.REG_CS) * 0x10
 
     # unidentified gitlab timeout problem
-    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
+
     def test_x86_64_pc(self):
         """
         :avocado: tags=arch:x86_64
@@ -223,7 +224,8 @@ class ReverseDebugging_AArch64(ReverseDebugging):
     REG_PC = 32
 
     # unidentified gitlab timeout problem
-    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
+
     def test_aarch64_virt(self):
         """
         :avocado: tags=arch:aarch64
@@ -247,7 +249,8 @@ class ReverseDebugging_ppc64(ReverseDebugging):
     REG_PC = 0x40
 
     # unidentified gitlab timeout problem
-    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
+
     def test_ppc64_pseries(self):
         """
         :avocado: tags=arch:ppc64
@@ -260,7 +263,8 @@ def test_ppc64_pseries(self):
         self.reverse_debugging()
 
     # See https://gitlab.com/qemu-project/qemu/-/issues/1992
-    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
+
     def test_ppc64_powernv(self):
         """
         :avocado: tags=arch:ppc64
diff --git a/tests/avocado/smmu.py b/tests/avocado/smmu.py
index b3c4de6bf4..05b34418a5 100644
--- a/tests/avocado/smmu.py
+++ b/tests/avocado/smmu.py
@@ -9,10 +9,11 @@
 # later.  See the COPYING file in the top-level directory.
 import os
 
-from avocado import skipIf
+from avocado import skipUnless
 from avocado_qemu import LinuxTest, BUILD_DIR
 
-@skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
+@skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
+
 class SMMU(LinuxTest):
     """
     :avocado: tags=accel:kvm
diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
index c99bea6c0b..5f859f4e6f 100644
--- a/tests/avocado/tuxrun_baselines.py
+++ b/tests/avocado/tuxrun_baselines.py
@@ -13,7 +13,7 @@
 import time
 import tempfile
 
-from avocado import skip, skipIf
+from avocado import skip, skipUnless
 from avocado_qemu import QemuSystemTest
 from avocado_qemu import exec_command, exec_command_and_wait_for_pattern
 from avocado_qemu import wait_for_console_pattern
@@ -551,7 +551,7 @@ def test_s390(self):
                            haltmsg="Requesting system halt")
 
     # Note: some segfaults caused by unaligned userspace access
-    @skipIf(os.getenv('GITLAB_CI'), 'Skipping unstable test on GitLab')
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
     def test_sh4(self):
         """
         :avocado: tags=arch:sh4
-- 
2.39.2


