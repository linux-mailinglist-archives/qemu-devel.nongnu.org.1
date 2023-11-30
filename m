Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9147FF3A4
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 16:35:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8j3J-0007b8-T5; Thu, 30 Nov 2023 10:34:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8j2t-0007Vp-Ob
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 10:33:44 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8j2n-0004zx-Rl
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 10:33:40 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40b30308c67so9165775e9.0
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 07:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701358415; x=1701963215; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=va2lSDWI9LZkjDO8/ReZ5EaNyJuoW3LqNMRgLhq6Y3U=;
 b=yOPiNpL4TrcP5O16BAhsTABYX7MURldz6kn4k2iGGCbzNKTpa3sstvHmU8v4FaP+eL
 Nv3R9tBMGg5v5kMyK7/d/B0A4xJSt/J+iITCu2elQmKJvC80W42cgAfJYnvf8WXLoZUE
 LIiNM3AJGL2apFuM4izyjkYbwdXMxJbPsP7+tfdAnYwr1PnRvjVLyS442F9zlwrpVNf9
 96pz6HFLWCBZb96kIWf5FqfPqzRaX3ikQXZfzDSqz6FvGhYckpjJ+iHXZdyQm+hy6RpL
 IRRpgrPDtpMyrJxxBsugFuQBedRxgKSIheeGqdW8gdgvnM/vepPlkoLwt5rPSyPpWBcM
 b7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701358415; x=1701963215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=va2lSDWI9LZkjDO8/ReZ5EaNyJuoW3LqNMRgLhq6Y3U=;
 b=MHWAHweDQiMeW4uQA5GbxOi/DPO4W2gWd3EL44UZHbie3VisS7HJWLAQrPXAbNpYUQ
 aCfJqsVzMbwbayfkp9ONYN1yV3+TsOK4vEyQ3TjmkSb9vdnKOdRG3MYyxWUQ7bJ+wi5j
 Lvzy3KXrUQh1rw7Y8zmn+vb18rz1hD7MHmTa1rCWb/7/s2thtC3YMTzwFGCAUEmReZ8n
 wdtc+ESPDTh2lNYlqpPBl8Kv00AQCU/Gr5zDA/mKmOMzw5VFo+PGZ/33+hR32RsmHp6m
 FgeFuQRCz+wefZuX/WzgBrNDbWbWJqUPznoXDaomsA+88CeFvuCKkHcBu6V9smVAfuKO
 K3lQ==
X-Gm-Message-State: AOJu0YzVrY3YmK9ivP6N3K5BwWpPvIYhMgCdp0OnemAB0p43tg7rcsvw
 KyBMv1La8/ose7p5DjObrOuf9w==
X-Google-Smtp-Source: AGHT+IE4AQmZLV4WP17ttyjyrmITsS3KP8CMjflZwTxzdCB6ZG6aa36b8EV8a+/YaM5E3FhGNOv6Gw==
X-Received: by 2002:adf:da45:0:b0:333:d38:9cf8 with SMTP id
 r5-20020adfda45000000b003330d389cf8mr6268560wrl.23.1701358414648; 
 Thu, 30 Nov 2023 07:33:34 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 e12-20020adfe38c000000b00332fd9b2b52sm1829283wrm.104.2023.11.30.07.33.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 07:33:34 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D11295FB53;
 Thu, 30 Nov 2023 15:33:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-s390x@nongnu.org,
 Beraldo Leal <bleal@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 3/3] gitlab: add optional job to run flaky avocado tests
Date: Thu, 30 Nov 2023 15:33:33 +0000
Message-Id: <20231130153333.2424775-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231130153333.2424775-1-alex.bennee@linaro.org>
References: <20231130153333.2424775-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

One problem with flaky tests is they often only fail under CI
conditions which makes it hard to debug. We add an optional allow_fail
job so developers can trigger the only the flaky tests in the CI
environment if they are debugging.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/testing.rst                   | 15 ++++++------
 .gitlab-ci.d/buildtest.yml               | 30 ++++++++++++++++++++++++
 tests/avocado/boot_linux.py              |  2 ++
 tests/avocado/boot_linux_console.py      |  1 +
 tests/avocado/intel_iommu.py             |  1 +
 tests/avocado/linux_initrd.py            |  2 ++
 tests/avocado/machine_aspeed.py          |  2 ++
 tests/avocado/machine_mips_malta.py      |  2 ++
 tests/avocado/machine_rx_gdbsim.py       |  2 ++
 tests/avocado/machine_s390_ccw_virtio.py |  1 +
 tests/avocado/replay_kernel.py           |  2 ++
 tests/avocado/reverse_debugging.py       |  2 ++
 tests/avocado/smmu.py                    |  1 +
 tests/avocado/tuxrun_baselines.py        |  1 +
 14 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 579d1837e0..fec8f06c09 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -1386,17 +1386,18 @@ below:
   def test(self):
       do_something()
 
+You can also add ``:avocado: tags=flaky`` to the test meta-data so
+only the flaky tests can be run as a group:
+
+.. code::
+
+   env QEMU_TEST_FLAKY_TESTS=1 ./pyvenv/bin/avocado \
+      run tests/avocado -filter-by-tags=flaky
+
 Tests should not live in this state forever and should either be fixed
 or eventually removed. If you move a test into this category please
 consider raising a bug to track progress towards a fix.
 
-To run such tests locally you will need to set the environment
-variable. For example:
-
-.. code::
-
-   env QEMU_TEST_FLAKY_TESTS=1 ./pyvenv/bin/avocado run \
-      tests/avocado/boot_linux.py:BootLinuxPPC64.test_pseries_tcg
 
 Uninstalling Avocado
 ~~~~~~~~~~~~~~~~~~~~
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 7f9af83b10..1624518d6c 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -217,6 +217,36 @@ avocado-system-opensuse:
     MAKE_CHECK_ARGS: check-avocado
     AVOCADO_TAGS: arch:s390x arch:x86_64 arch:aarch64
 
+#
+# Flaky tests. We don't run these by default and they are allow fail
+# but often the CI system is the only way to trigger the failures.
+#
+
+build-system-flaky:
+  extends:
+    - .native_build_job_template
+    - .native_build_artifact_template
+  needs:
+    job: amd64-debian-container
+  variables:
+    IMAGE: debian
+    QEMU_JOB_OPTIONAL: 1
+    TARGETS: arm-softmmu mips64el-softmmu rx-softmmu s390x-softmmu
+      sh4-softmmu x86_64-softmmu 
+    MAKE_CHECK_ARGS: check-build
+
+avocado-system-flaky:
+  extends: .avocado_test_job_template
+  needs:
+    - job: build-system-flaky
+      artifacts: true
+  allow_failure: true
+  variables:
+    IMAGE: debian
+    MAKE_CHECK_ARGS: check-avocado
+    QEMU_JOB_OPTIONAL: 1
+    QEMU_TEST_FLAKY_TESTS: 1
+    AVOCADO_TAGS: flaky
 
 # This jobs explicitly disable TCG (--disable-tcg), KVM is detected by
 # the configure script. The container doesn't contain Xen headers so
diff --git a/tests/avocado/boot_linux.py b/tests/avocado/boot_linux.py
index 9e9773e6e1..7c4769904e 100644
--- a/tests/avocado/boot_linux.py
+++ b/tests/avocado/boot_linux.py
@@ -99,6 +99,7 @@ def test_pseries_tcg(self):
         """
         :avocado: tags=machine:pseries
         :avocado: tags=accel:tcg
+        :avocado: tags=flaky
         """
         self.require_accelerator("tcg")
         self.vm.add_args("-accel", "tcg")
@@ -118,6 +119,7 @@ def test_s390_ccw_virtio_tcg(self):
         """
         :avocado: tags=machine:s390-ccw-virtio
         :avocado: tags=accel:tcg
+        :avocado: tags=flaky
         """
         self.require_accelerator("tcg")
         self.vm.add_args("-accel", "tcg")
diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 231b4f68e5..3f0180e1f8 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -1425,6 +1425,7 @@ def test_sh4_r2d(self):
         """
         :avocado: tags=arch:sh4
         :avocado: tags=machine:r2d
+        :avocado: tags=flaky
         """
         tar_hash = 'fe06a4fd8ccbf2e27928d64472939d47829d4c7e'
         self.vm.add_args('-append', 'console=ttySC1')
diff --git a/tests/avocado/intel_iommu.py b/tests/avocado/intel_iommu.py
index 2dd11a6346..f04ee1cf9d 100644
--- a/tests/avocado/intel_iommu.py
+++ b/tests/avocado/intel_iommu.py
@@ -22,6 +22,7 @@ class IntelIOMMU(LinuxTest):
     :avocado: tags=machine:q35
     :avocado: tags=accel:kvm
     :avocado: tags=intel_iommu
+    :avocado: tags=flaky
     """
 
     IOMMU_ADDON = ',iommu_platform=on,disable-modern=off,disable-legacy=on'
diff --git a/tests/avocado/linux_initrd.py b/tests/avocado/linux_initrd.py
index c40a987bd1..aad5b19bd9 100644
--- a/tests/avocado/linux_initrd.py
+++ b/tests/avocado/linux_initrd.py
@@ -57,6 +57,8 @@ def test_with_2gib_file_should_exit_error_msg_with_linux_v3_6(self):
 
     def test_with_2gib_file_should_work_with_linux_v4_16(self):
         """
+        :avocado: tags=flaky
+
         QEMU has supported up to 4 GiB initrd for recent kernel
         Expect guest can reach 'Unpacking initramfs...'
         """
diff --git a/tests/avocado/machine_aspeed.py b/tests/avocado/machine_aspeed.py
index 258fb50c47..6fa5459a07 100644
--- a/tests/avocado/machine_aspeed.py
+++ b/tests/avocado/machine_aspeed.py
@@ -317,6 +317,7 @@ def test_arm_ast2500_evb_sdk(self):
         """
         :avocado: tags=arch:arm
         :avocado: tags=machine:ast2500-evb
+        :avocado: tags=flaky
         """
 
         image_url = ('https://github.com/AspeedTech-BMC/openbmc/releases/'
@@ -336,6 +337,7 @@ def test_arm_ast2600_evb_sdk(self):
         """
         :avocado: tags=arch:arm
         :avocado: tags=machine:ast2600-evb
+        :avocado: tags=flaky
         """
 
         image_url = ('https://github.com/AspeedTech-BMC/openbmc/releases/'
diff --git a/tests/avocado/machine_mips_malta.py b/tests/avocado/machine_mips_malta.py
index 959dcf5602..99bee49e9a 100644
--- a/tests/avocado/machine_mips_malta.py
+++ b/tests/avocado/machine_mips_malta.py
@@ -109,6 +109,7 @@ def test_mips_malta_i6400_framebuffer_logo_7cores(self):
         :avocado: tags=machine:malta
         :avocado: tags=cpu:I6400
         :avocado: tags=mips:smp
+        :avocado: tags=flaky
         """
         self.do_test_i6400_framebuffer_logo(7)
 
@@ -120,6 +121,7 @@ def test_mips_malta_i6400_framebuffer_logo_8cores(self):
         :avocado: tags=machine:malta
         :avocado: tags=cpu:I6400
         :avocado: tags=mips:smp
+        :avocado: tags=flaky
         """
         self.do_test_i6400_framebuffer_logo(8)
 
diff --git a/tests/avocado/machine_rx_gdbsim.py b/tests/avocado/machine_rx_gdbsim.py
index 350a73fbbb..412a7a5089 100644
--- a/tests/avocado/machine_rx_gdbsim.py
+++ b/tests/avocado/machine_rx_gdbsim.py
@@ -31,6 +31,7 @@ def test_uboot(self):
         :avocado: tags=arch:rx
         :avocado: tags=machine:gdbsim-r5f562n8
         :avocado: tags=endian:little
+        :avocado: tags=flaky
         """
         uboot_url = ('https://acc.dl.osdn.jp/users/23/23888/u-boot.bin.gz')
         uboot_hash = '9b78dbd43b40b2526848c0b1ce9de02c24f4dcdb'
@@ -56,6 +57,7 @@ def test_linux_sash(self):
         :avocado: tags=arch:rx
         :avocado: tags=machine:gdbsim-r5f562n7
         :avocado: tags=endian:little
+        :avocado: tags=flaky
         """
         dtb_url = ('https://acc.dl.osdn.jp/users/23/23887/rx-virt.dtb')
         dtb_hash = '7b4e4e2c71905da44e86ce47adee2210b026ac18'
diff --git a/tests/avocado/machine_s390_ccw_virtio.py b/tests/avocado/machine_s390_ccw_virtio.py
index 61e75d8f9e..26e938c9e9 100644
--- a/tests/avocado/machine_s390_ccw_virtio.py
+++ b/tests/avocado/machine_s390_ccw_virtio.py
@@ -167,6 +167,7 @@ def test_s390x_fedora(self):
         :avocado: tags=device:virtio-gpu
         :avocado: tags=device:virtio-crypto
         :avocado: tags=device:virtio-net
+        :avocado: tags=flaky
         """
 
         kernel_url = ('https://archives.fedoraproject.org/pub/archive'
diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index a60f1d1e54..010d7644c2 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -87,6 +87,7 @@ def test_x86_64_pc(self):
         """
         :avocado: tags=arch:x86_64
         :avocado: tags=machine:pc
+        :avocado: tags=flaky
         """
         kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
                       '/linux/releases/29/Everything/x86_64/os/images/pxeboot'
@@ -185,6 +186,7 @@ def test_arm_cubieboard_initrd(self):
         """
         :avocado: tags=arch:arm
         :avocado: tags=machine:cubieboard
+        :avocado: tags=flaky
         """
         deb_url = ('https://apt.armbian.com/pool/main/l/'
                    'linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb')
diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_debugging.py
index 9a468321e5..4cce5a5598 100644
--- a/tests/avocado/reverse_debugging.py
+++ b/tests/avocado/reverse_debugging.py
@@ -255,6 +255,7 @@ def test_ppc64_pseries(self):
         """
         :avocado: tags=arch:ppc64
         :avocado: tags=machine:pseries
+        :avocado: tags=flaky
         """
         # SLOF branches back to its entry point, which causes this test
         # to take the 'hit a breakpoint again' path. That's not a problem,
@@ -269,6 +270,7 @@ def test_ppc64_powernv(self):
         """
         :avocado: tags=arch:ppc64
         :avocado: tags=machine:powernv
+        :avocado: tags=flaky
         """
         self.endian_is_le = False
         self.reverse_debugging()
diff --git a/tests/avocado/smmu.py b/tests/avocado/smmu.py
index 05b34418a5..21ff030ca7 100644
--- a/tests/avocado/smmu.py
+++ b/tests/avocado/smmu.py
@@ -22,6 +22,7 @@ class SMMU(LinuxTest):
     :avocado: tags=machine:virt
     :avocado: tags=distro:fedora
     :avocado: tags=smmu
+    :avocado: tags=flaky
     """
 
     IOMMU_ADDON = ',iommu_platform=on,disable-modern=off,disable-legacy=on'
diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
index 5f859f4e6f..a936a3b780 100644
--- a/tests/avocado/tuxrun_baselines.py
+++ b/tests/avocado/tuxrun_baselines.py
@@ -561,6 +561,7 @@ def test_sh4(self):
         :avocado: tags=image:zImage
         :avocado: tags=root:sda
         :avocado: tags=console:ttySC1
+        :avocado: tags=flaky
         """
         sums = { "rootfs.ext4.zst" :
                  "3592a7a3d5a641e8b9821449e77bc43c9904a56c30d45da0694349cfd86743fd",
-- 
2.39.2


