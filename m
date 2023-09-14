Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD12C7A09E8
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 17:56:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgogG-0002DR-Iy; Thu, 14 Sep 2023 11:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qgofw-0001Xk-Ki
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:54:41 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qgofn-00088d-SB
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:54:40 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-401b5516104so11914095e9.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 08:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694706868; x=1695311668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AWyWexWkL9ehHlLTXF4LI+FOAnsZypSIrQiBOsr8h/U=;
 b=SH7fXgKyT31E+0Q2zuqubjaLC01a8vnyRv6GwCiD3ULNI5ANPsscx3Bbo/iqpGcw51
 qPwR0CFhF0WLjOnjnYotK9IsPHLJETxx0+yJvm0g/mvHEnng6Zqe7Jcm7vXBghlY2CvQ
 dPVjLZwhmY+9XOd1Tp0E85xR6WIdVYGiV6y0pN7Gg1MGfbTp9ZAGxXSdaMnV+zoYqyui
 k86/0Yw68vdJPQOlrNVTbYNL2rUtSfCdn/TWyvYKVnyF+pfqa+Ws7Da+eW3Lmtg1n+lt
 SJJ60g8Q6b/wolh8M9Om39MwYlCKuorHl0Zvx9pgmDdCS8K9zmrltLLBfBf+9aaICF4h
 oIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694706868; x=1695311668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AWyWexWkL9ehHlLTXF4LI+FOAnsZypSIrQiBOsr8h/U=;
 b=bhj8LLzw2vLk9LWRA8502HD8OQN/diAg1tSv8Qv7ZXTJt1GBkhy8/9DXI2qch9BmDX
 QEwJ/4+gzBJB+me1/lgYzwfPGM+sqzLP1omkvPeCfEMdWyIBsNcOkDIV15ZF9m5Kml7J
 +1rVqvMYn8OprXp2HimgX0ECnI/E62iqE4isX2ifYEgnJ9jRcVdIFm26/mwc8xZYcCSs
 Ntrcg3Qmrnp0pruVH4zBiMjg9aMOSrv9lED3Yu6BSUMVR+YPLBpHeuxkfwORaWILyN9t
 vuzjEBzB5hDe1oG3A8NwrcAtKiAJOb8QsvhNso9Lw8q61JgbBpATQd5E7YCvoXgPveH5
 wcAQ==
X-Gm-Message-State: AOJu0Yz6+W/ehf9219qe2MY2qtFoNWXfOU59Ldgab8XmgC7so1eDD5mr
 MRkQ3CmWkw7USFBtAykHigcGGQ==
X-Google-Smtp-Source: AGHT+IFf4fI6Ty48UFsJkIDinQNl2hKC2bBGPwIfPRRqYdrTwz+cGC6m8VsIsVmN+mIPbjDphOr2rQ==
X-Received: by 2002:a7b:c012:0:b0:3fe:dcd0:2e10 with SMTP id
 c18-20020a7bc012000000b003fedcd02e10mr4562816wmb.17.1694706868544; 
 Thu, 14 Sep 2023 08:54:28 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 18-20020a05600c235200b003fe61c33df5sm5228397wmq.3.2023.09.14.08.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 08:54:26 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6FE691FFBB;
 Thu, 14 Sep 2023 16:54:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 9/9] tests/avocado: Disable MIPS Malta tests due to GitLab
 issue #1884
Date: Thu, 14 Sep 2023 16:54:22 +0100
Message-Id: <20230914155422.426639-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230914155422.426639-1-alex.bennee@linaro.org>
References: <20230914155422.426639-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Commit 0d58c66068 ("softmmu: Use async_run_on_cpu in tcg_commit")
introduced a regression which is only triggered by the MIPS Malta
machine. Since those tests are gatting and disturb the CI workflow,
disable them until https://gitlab.com/qemu-project/qemu/-/issues/1866
is fixed.

  $ make check-avocado \
      AVOCADO_TAGS='arch:mipsel arch:mips64el' \
      AVOCADO_ALLOW_UNTRUSTED_CODE=1 \
      AVOCADO_TIMEOUT_EXPECTED=1
    AVOCADO tests/avocado
   (04/24) tests/avocado/boot_linux_console.py:BootLinuxConsole.test_mips_malta32el_nanomips_4k: INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Timeout reached\nOriginal status: ERROR\n... (90.39 s)
   (05/24) tests/avocado/boot_linux_console.py:BootLinuxConsole.test_mips_malta32el_nanomips_16k_up: INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Timeout reached\nOriginal status: ERROR\n... (90.29 s)
   (06/24) tests/avocado/boot_linux_console.py:BootLinuxConsole.test_mips_malta32el_nanomips_64k_dbg: INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Timeout reached\nOriginal status: ERROR\n... (92.53 s)
   (11/24) tests/avocado/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_1core: INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Timeout reached\nOriginal status: ERROR\n... (25.78 s)
  RESULTS    : PASS 8 | ERROR 0 | FAIL 0 | SKIP 7 | WARN 2 | INTERRUPT 5 | CANCEL 2
  JOB TIME   : 525.60 s                                      ^^^^^^^^^^^

Reported-by: Thomas Huth <thuth@redhat.com>
Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230913135339.9128-1-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/avocado/boot_linux_console.py | 7 +++++++
 tests/avocado/machine_mips_malta.py | 6 ++++++
 tests/avocado/replay_kernel.py      | 7 +++++++
 tests/avocado/tuxrun_baselines.py   | 4 ++++
 4 files changed, 24 insertions(+)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 6eab515718..01ee149812 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -116,6 +116,7 @@ def test_x86_64_pc(self):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
 
+    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips_malta(self):
         """
         :avocado: tags=arch:mips
@@ -138,6 +139,7 @@ def test_mips_malta(self):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
 
+    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips64el_malta(self):
         """
         This test requires the ar tool to extract "data.tar.gz" from
@@ -191,6 +193,7 @@ def test_mips64el_fuloong2e(self):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
 
+    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips_malta_cpio(self):
         """
         :avocado: tags=arch:mips
@@ -232,6 +235,7 @@ def test_mips_malta_cpio(self):
         # Wait for VM to shut down gracefully
         self.vm.wait()
 
+    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
     def test_mips64el_malta_5KEc_cpio(self):
         """
@@ -292,6 +296,7 @@ def do_test_mips_malta32el_nanomips(self, kernel_url, kernel_hash):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
 
+    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips_malta32el_nanomips_4k(self):
         """
         :avocado: tags=arch:mipsel
@@ -305,6 +310,7 @@ def test_mips_malta32el_nanomips_4k(self):
         kernel_hash = '477456aafd2a0f1ddc9482727f20fe9575565dd6'
         self.do_test_mips_malta32el_nanomips(kernel_url, kernel_hash)
 
+    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips_malta32el_nanomips_16k_up(self):
         """
         :avocado: tags=arch:mipsel
@@ -318,6 +324,7 @@ def test_mips_malta32el_nanomips_16k_up(self):
         kernel_hash = 'e882868f944c71c816e832e2303b7874d044a7bc'
         self.do_test_mips_malta32el_nanomips(kernel_url, kernel_hash)
 
+    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips_malta32el_nanomips_64k_dbg(self):
         """
         :avocado: tags=arch:mipsel
diff --git a/tests/avocado/machine_mips_malta.py b/tests/avocado/machine_mips_malta.py
index 92233451c5..3620266589 100644
--- a/tests/avocado/machine_mips_malta.py
+++ b/tests/avocado/machine_mips_malta.py
@@ -11,6 +11,7 @@
 import gzip
 import logging
 
+from avocado import skip
 from avocado import skipIf
 from avocado import skipUnless
 from avocado.utils import archive
@@ -93,6 +94,7 @@ def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
             cv2.imwrite(debug_png, screendump_bgr)
         self.assertGreaterEqual(tuxlogo_count, cpu_cores_count)
 
+    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips_malta_i6400_framebuffer_logo_1core(self):
         """
         :avocado: tags=arch:mips64el
@@ -101,6 +103,7 @@ def test_mips_malta_i6400_framebuffer_logo_1core(self):
         """
         self.do_test_i6400_framebuffer_logo(1)
 
+    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
     def test_mips_malta_i6400_framebuffer_logo_7cores(self):
         """
@@ -111,6 +114,7 @@ def test_mips_malta_i6400_framebuffer_logo_7cores(self):
         """
         self.do_test_i6400_framebuffer_logo(7)
 
+    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
     def test_mips_malta_i6400_framebuffer_logo_8cores(self):
         """
@@ -142,6 +146,7 @@ def do_test_yamon(self):
         wait_for_console_pattern(self, prompt)
         self.vm.shutdown()
 
+    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mipsel_malta_yamon(self):
         """
         :avocado: tags=arch:mipsel
@@ -150,6 +155,7 @@ def test_mipsel_malta_yamon(self):
         """
         self.do_test_yamon()
 
+    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips64el_malta_yamon(self):
         """
         :avocado: tags=arch:mips64el
diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index a18610542e..f7ccfd2462 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -98,6 +98,7 @@ def test_x86_64_pc(self):
 
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
 
+    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips_malta(self):
         """
         :avocado: tags=arch:mips
@@ -116,6 +117,7 @@ def test_mips_malta(self):
 
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
 
+    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips64el_malta(self):
         """
         This test requires the ar tool to extract "data.tar.gz" from
@@ -431,6 +433,7 @@ class ReplayKernelSlow(ReplayKernelBase):
     # making it very slow.
     timeout = 180
 
+    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips_malta_cpio(self):
         """
         :avocado: tags=arch:mips
@@ -460,6 +463,7 @@ def test_mips_malta_cpio(self):
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5,
                     args=('-initrd', initrd_path))
 
+    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
     def test_mips64el_malta_5KEc_cpio(self):
         """
@@ -502,6 +506,7 @@ def do_test_mips_malta32el_nanomips(self, kernel_path_xz):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
 
+    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips_malta32el_nanomips_4k(self):
         """
         :avocado: tags=arch:mipsel
@@ -516,6 +521,7 @@ def test_mips_malta32el_nanomips_4k(self):
         kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
         self.do_test_mips_malta32el_nanomips(kernel_path_xz)
 
+    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips_malta32el_nanomips_16k_up(self):
         """
         :avocado: tags=arch:mipsel
@@ -530,6 +536,7 @@ def test_mips_malta32el_nanomips_16k_up(self):
         kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
         self.do_test_mips_malta32el_nanomips(kernel_path_xz)
 
+    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips_malta32el_nanomips_64k_dbg(self):
         """
         :avocado: tags=arch:mipsel
diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
index e12250eabb..610b7e2bfa 100644
--- a/tests/avocado/tuxrun_baselines.py
+++ b/tests/avocado/tuxrun_baselines.py
@@ -352,6 +352,7 @@ def test_i386(self):
 
         self.common_tuxrun(csums=sums, drive="virtio-blk-pci")
 
+    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips32(self):
         """
         :avocado: tags=arch:mips
@@ -370,6 +371,7 @@ def test_mips32(self):
 
         self.common_tuxrun(csums=sums, drive="driver=ide-hd,bus=ide.0,unit=0")
 
+    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips32el(self):
         """
         :avocado: tags=arch:mipsel
@@ -387,6 +389,7 @@ def test_mips32el(self):
 
         self.common_tuxrun(csums=sums, drive="driver=ide-hd,bus=ide.0,unit=0")
 
+    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips64(self):
         """
         :avocado: tags=arch:mips64
@@ -404,6 +407,7 @@ def test_mips64(self):
 
         self.common_tuxrun(csums=sums, drive="driver=ide-hd,bus=ide.0,unit=0")
 
+    @skip('https://gitlab.com/qemu-project/qemu/-/issues/1884')
     def test_mips64el(self):
         """
         :avocado: tags=arch:mips64el
-- 
2.39.2


