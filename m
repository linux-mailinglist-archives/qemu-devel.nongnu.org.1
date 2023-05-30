Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86ACA7166E7
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 17:25:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q41Ba-0007wc-O7; Tue, 30 May 2023 11:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1q41BY-0007wG-CW; Tue, 30 May 2023 11:22:56 -0400
Received: from muminek.juszkiewicz.com.pl ([213.251.184.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1q41BW-0008NN-Jw; Tue, 30 May 2023 11:22:56 -0400
Received: from localhost (localhost [127.0.0.1])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTP id B800A2602B4;
 Tue, 30 May 2023 17:22:51 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at juszkiewicz.com.pl
Received: from muminek.juszkiewicz.com.pl ([127.0.0.1])
 by localhost (muminek.juszkiewicz.com.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JvwwKVhfywJH; Tue, 30 May 2023 17:22:49 +0200 (CEST)
Received: from applejack.lan (83.21.93.182.ipv4.supernova.orange.pl
 [83.21.93.182])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTPSA id 6BE84260172;
 Tue, 30 May 2023 17:22:48 +0200 (CEST)
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: [PATCH 1/1] tests/avocado: update firmware to enable sbsa-ref/max
Date: Tue, 30 May 2023 17:22:40 +0200
Message-Id: <20230530152240.79160-1-marcin.juszkiewicz@linaro.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=213.251.184.221;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=muminek.juszkiewicz.com.pl
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Update prebuilt firmware images to have TF-A with FEAT_FGT support
enabled. This allowed us to enable test for "max" cpu in sbsa-ref
machine.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
---
 tests/avocado/machine_aarch64_sbsaref.py | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
index 0a79fa7ab6..35f8042416 100644
--- a/tests/avocado/machine_aarch64_sbsaref.py
+++ b/tests/avocado/machine_aarch64_sbsaref.py
@@ -29,23 +29,23 @@ def fetch_firmware(self):
         """
         Flash volumes generated using:
 
-        - Fedora GNU Toolchain version 12.2.1 20220819 (Red Hat Cross 12.2.1-2)
+        - Fedora GNU Toolchain version 13.1.1 20230511 (Red Hat 13.1.1-2)
 
         - Trusted Firmware-A
-          https://github.com/ARM-software/arm-trusted-firmware/tree/5fdb2e54
+          https://github.com/ARM-software/arm-trusted-firmware/tree/c0d8ee38
 
         - Tianocore EDK II
-          https://github.com/tianocore/edk2/tree/494127613b
-          https://github.com/tianocore/edk2-non-osi/tree/41876073
-          https://github.com/tianocore/edk2-platforms/tree/8efa4f42
+          https://github.com/tianocore/edk2/tree/0f9283429dd4
+          https://github.com/tianocore/edk2-non-osi/tree/f0bb00937ad6
+          https://github.com/tianocore/edk2-platforms/tree/7880b92e2a04
         """
 
         # Secure BootRom (TF-A code)
         fs0_xz_url = (
-            "https://fileserver.linaro.org/s/ATnSmq6k8SoXgbH/"
+            "https://fileserver.linaro.org/s/HrYMCjP7MEccjRP/"
             "download/SBSA_FLASH0.fd.xz"
         )
-        fs0_xz_hash = "a210a09692bcbe0a3743ffd0df44e80e0c7ad8ab"
+        fs0_xz_hash = "447eff64a90b84ce47703c6ec41fbfc25befaaea"
         tar_xz_path = self.fetch_asset(fs0_xz_url, asset_hash=fs0_xz_hash)
         archive.extract(tar_xz_path, self.workdir)
         fs0_path = os.path.join(self.workdir, "SBSA_FLASH0.fd")
@@ -93,15 +93,15 @@ def test_sbsaref_edk2_firmware(self):
 
         # AP Trusted ROM
         wait_for_console_pattern(self, "Booting Trusted Firmware")
-        wait_for_console_pattern(self, "BL1: v2.8(release):v2.8")
+        wait_for_console_pattern(self, "BL1: v2.9(release):v2.9")
         wait_for_console_pattern(self, "BL1: Booting BL2")
 
         # Trusted Boot Firmware
-        wait_for_console_pattern(self, "BL2: v2.8(release)")
+        wait_for_console_pattern(self, "BL2: v2.9(release)")
         wait_for_console_pattern(self, "Booting BL31")
 
         # EL3 Runtime Software
-        wait_for_console_pattern(self, "BL31: v2.8(release)")
+        wait_for_console_pattern(self, "BL31: v2.9(release)")
 
         # Non-trusted Firmware
         wait_for_console_pattern(self, "UEFI firmware (version 1.0")
@@ -150,7 +150,7 @@ def test_sbsaref_alpine_linux_neoverse_n1(self):
         """
         self.boot_alpine_linux("neoverse-n1")
 
-    @skip("requires TF-A update to handle FEAT_FGT")
+    @skipUnless(os.getenv("AVOCADO_TIMEOUT_EXPECTED"), "Test might timeout")
     def test_sbsaref_alpine_linux_max(self):
         """
         :avocado: tags=cpu:max
-- 
2.40.1


