Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EA97B60D8
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 08:39:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnZ39-0002vn-IP; Tue, 03 Oct 2023 02:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnZ2y-0002tl-RU
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 02:38:21 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnZ2t-0003b2-4f
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 02:38:18 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-405524e6769so2638085e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 23:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696315091; x=1696919891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=humCkfJR33ofp5qL0+Yp1u9GmGX6SE5hPaYZ57qqhZI=;
 b=zJ9dro8Di/fEoaU5LLr9MZp5TK4EHGSOeLI7jesnSUN6pCV/eBSGvfmulDGmx3na8y
 XGXGL8JwSY6b+flxJwvGKI61lDGgG5WLzbnbarUNcHqSoe/+riub6CgDTtx+1SGcQ7QJ
 ecfaLji7eeW5CUAHebejlEpTtzIUZkw8XMl56HgqSrTH8fbQWdP9qoxHAlgEywbfdaRY
 Y8YRzV1rEj4I96k/FzQYxxaxB6D0KzqqvhKDkVVCWKlOcxu0veg45xfKXA75AQy8tF/G
 PMNwKa2JNhqiWvw11WEih+g+T4cvaB07lna2L+iSRhz2G2rvjh22wqzheUGlzNTI8Qu9
 Fqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696315091; x=1696919891;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=humCkfJR33ofp5qL0+Yp1u9GmGX6SE5hPaYZ57qqhZI=;
 b=QgZlmYhFnsRnD3MhVk5uMQdg2MPg2/p5VCTNnGRMunbtOtvj1xlq17/3zJSX54tFMI
 IeUdB+9Dtyz9DfYAc2cjkiiY5LnvEPyl61/GOcbs3bvywAn90FAE9tMp4zQHuw9snSgM
 5JMcrwdNtBFlkt5bjISN2iYmGypgQCiXTbvQw1ZT+Gakk948MUsw7pdx9xd5kL743hWq
 PgcHLMil0C601O8wZejh9G5iO/xfUo7t1TOSdGurSoIYsoQcbTVNTMhGimsejbeg/pVz
 xDgKBv0UpWdhuVq+0o0RfTz+AMal051wgGxj9/T+ctonx+oqY9Gkls8aRenCPS8jXvh/
 xsIA==
X-Gm-Message-State: AOJu0Yx4+HISERkNu0r7mzZmX9l7+49/huhs4iLFWeK9ix+Zl3n6/zIS
 FzaAv3RHTQcODFiCVdVSjoSpgWEPPRLC/VvvoUZKOg==
X-Google-Smtp-Source: AGHT+IG/MiBD2wn+Ny+eVo25eDAClWzfyRPMMRSdiag/39lqju3mZPxCN4U8e+gYnYY88kXVVm/5fQ==
X-Received: by 2002:a05:600c:4689:b0:405:29ba:9b5c with SMTP id
 p9-20020a05600c468900b0040529ba9b5cmr1120029wmo.16.1696315091672; 
 Mon, 02 Oct 2023 23:38:11 -0700 (PDT)
Received: from m1x-phil.lan (176-131-222-246.abo.bbox.fr. [176.131.222.246])
 by smtp.gmail.com with ESMTPSA id
 p24-20020a1c7418000000b00405935b417asm8672430wmc.2.2023.10.02.23.38.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Oct 2023 23:38:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Cleber Rosa <crosa@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH] tests/avocado: Re-enable MIPS Malta tests (GitLab issue #1884
 fixed)
Date: Tue,  3 Oct 2023 08:38:08 +0200
Message-ID: <20231003063808.66564-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Commit 18a536f1f8 ("accel/tcg: Always require can_do_io") fixed
the GitLab issue #1884: we can now re-enable those tests.

This reverts commit f959c3d87ccfa585b105de6964a6261e368cc1da.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/avocado/boot_linux_console.py | 7 -------
 tests/avocado/machine_mips_malta.py | 6 ------
 tests/avocado/replay_kernel.py      | 7 -------
 tests/avocado/tuxrun_baselines.py   | 4 ----
 4 files changed, 24 deletions(-)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 01ee149812..6eab515718 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -116,7 +116,6 @@ def test_x86_64_pc(self):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
 
-    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips_malta(self):
         """
         :avocado: tags=arch:mips
@@ -139,7 +138,6 @@ def test_mips_malta(self):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
 
-    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips64el_malta(self):
         """
         This test requires the ar tool to extract "data.tar.gz" from
@@ -193,7 +191,6 @@ def test_mips64el_fuloong2e(self):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
 
-    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips_malta_cpio(self):
         """
         :avocado: tags=arch:mips
@@ -235,7 +232,6 @@ def test_mips_malta_cpio(self):
         # Wait for VM to shut down gracefully
         self.vm.wait()
 
-    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
     def test_mips64el_malta_5KEc_cpio(self):
         """
@@ -296,7 +292,6 @@ def do_test_mips_malta32el_nanomips(self, kernel_url, kernel_hash):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
 
-    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips_malta32el_nanomips_4k(self):
         """
         :avocado: tags=arch:mipsel
@@ -310,7 +305,6 @@ def test_mips_malta32el_nanomips_4k(self):
         kernel_hash = '477456aafd2a0f1ddc9482727f20fe9575565dd6'
         self.do_test_mips_malta32el_nanomips(kernel_url, kernel_hash)
 
-    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips_malta32el_nanomips_16k_up(self):
         """
         :avocado: tags=arch:mipsel
@@ -324,7 +318,6 @@ def test_mips_malta32el_nanomips_16k_up(self):
         kernel_hash = 'e882868f944c71c816e832e2303b7874d044a7bc'
         self.do_test_mips_malta32el_nanomips(kernel_url, kernel_hash)
 
-    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips_malta32el_nanomips_64k_dbg(self):
         """
         :avocado: tags=arch:mipsel
diff --git a/tests/avocado/machine_mips_malta.py b/tests/avocado/machine_mips_malta.py
index 3620266589..92233451c5 100644
--- a/tests/avocado/machine_mips_malta.py
+++ b/tests/avocado/machine_mips_malta.py
@@ -11,7 +11,6 @@
 import gzip
 import logging
 
-from avocado import skip
 from avocado import skipIf
 from avocado import skipUnless
 from avocado.utils import archive
@@ -94,7 +93,6 @@ def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
             cv2.imwrite(debug_png, screendump_bgr)
         self.assertGreaterEqual(tuxlogo_count, cpu_cores_count)
 
-    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips_malta_i6400_framebuffer_logo_1core(self):
         """
         :avocado: tags=arch:mips64el
@@ -103,7 +101,6 @@ def test_mips_malta_i6400_framebuffer_logo_1core(self):
         """
         self.do_test_i6400_framebuffer_logo(1)
 
-    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
     def test_mips_malta_i6400_framebuffer_logo_7cores(self):
         """
@@ -114,7 +111,6 @@ def test_mips_malta_i6400_framebuffer_logo_7cores(self):
         """
         self.do_test_i6400_framebuffer_logo(7)
 
-    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
     def test_mips_malta_i6400_framebuffer_logo_8cores(self):
         """
@@ -146,7 +142,6 @@ def do_test_yamon(self):
         wait_for_console_pattern(self, prompt)
         self.vm.shutdown()
 
-    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mipsel_malta_yamon(self):
         """
         :avocado: tags=arch:mipsel
@@ -155,7 +150,6 @@ def test_mipsel_malta_yamon(self):
         """
         self.do_test_yamon()
 
-    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips64el_malta_yamon(self):
         """
         :avocado: tags=arch:mips64el
diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index f7ccfd2462..a18610542e 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -98,7 +98,6 @@ def test_x86_64_pc(self):
 
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
 
-    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips_malta(self):
         """
         :avocado: tags=arch:mips
@@ -117,7 +116,6 @@ def test_mips_malta(self):
 
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
 
-    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips64el_malta(self):
         """
         This test requires the ar tool to extract "data.tar.gz" from
@@ -433,7 +431,6 @@ class ReplayKernelSlow(ReplayKernelBase):
     # making it very slow.
     timeout = 180
 
-    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips_malta_cpio(self):
         """
         :avocado: tags=arch:mips
@@ -463,7 +460,6 @@ def test_mips_malta_cpio(self):
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5,
                     args=('-initrd', initrd_path))
 
-    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
     def test_mips64el_malta_5KEc_cpio(self):
         """
@@ -506,7 +502,6 @@ def do_test_mips_malta32el_nanomips(self, kernel_path_xz):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
 
-    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips_malta32el_nanomips_4k(self):
         """
         :avocado: tags=arch:mipsel
@@ -521,7 +516,6 @@ def test_mips_malta32el_nanomips_4k(self):
         kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
         self.do_test_mips_malta32el_nanomips(kernel_path_xz)
 
-    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips_malta32el_nanomips_16k_up(self):
         """
         :avocado: tags=arch:mipsel
@@ -536,7 +530,6 @@ def test_mips_malta32el_nanomips_16k_up(self):
         kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
         self.do_test_mips_malta32el_nanomips(kernel_path_xz)
 
-    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips_malta32el_nanomips_64k_dbg(self):
         """
         :avocado: tags=arch:mipsel
diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
index 610b7e2bfa..e12250eabb 100644
--- a/tests/avocado/tuxrun_baselines.py
+++ b/tests/avocado/tuxrun_baselines.py
@@ -352,7 +352,6 @@ def test_i386(self):
 
         self.common_tuxrun(csums=sums, drive="virtio-blk-pci")
 
-    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips32(self):
         """
         :avocado: tags=arch:mips
@@ -371,7 +370,6 @@ def test_mips32(self):
 
         self.common_tuxrun(csums=sums, drive="driver=ide-hd,bus=ide.0,unit=0")
 
-    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips32el(self):
         """
         :avocado: tags=arch:mipsel
@@ -389,7 +387,6 @@ def test_mips32el(self):
 
         self.common_tuxrun(csums=sums, drive="driver=ide-hd,bus=ide.0,unit=0")
 
-    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips64(self):
         """
         :avocado: tags=arch:mips64
@@ -407,7 +404,6 @@ def test_mips64(self):
 
         self.common_tuxrun(csums=sums, drive="driver=ide-hd,bus=ide.0,unit=0")
 
-    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips64el(self):
         """
         :avocado: tags=arch:mips64el
-- 
2.41.0


