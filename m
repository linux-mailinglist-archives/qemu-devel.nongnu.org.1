Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3294587BA51
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Mar 2024 10:24:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkhJX-0004rl-0F; Thu, 14 Mar 2024 05:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rkhJL-0004oO-3X; Thu, 14 Mar 2024 05:23:39 -0400
Received: from muminek.juszkiewicz.com.pl ([213.251.184.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rkhJG-0007sf-J5; Thu, 14 Mar 2024 05:23:38 -0400
Received: from localhost (localhost [127.0.0.1])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTP id E4EDD260B83;
 Thu, 14 Mar 2024 10:23:32 +0100 (CET)
X-Virus-Scanned: Debian amavis at juszkiewicz.com.pl
Received: from muminek.juszkiewicz.com.pl ([127.0.0.1])
 by localhost (muminek.juszkiewicz.com.pl [127.0.0.1]) (amavis, port 10024)
 with ESMTP id JzZQ8miKfSNd; Thu, 14 Mar 2024 10:23:30 +0100 (CET)
Received: from [172.17.0.1] (83.11.22.169.ipv4.supernova.orange.pl
 [83.11.22.169])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTPSA id 88AFB2600DA;
 Thu, 14 Mar 2024 10:23:29 +0100 (CET)
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Date: Thu, 14 Mar 2024 10:23:26 +0100
Subject: [PATCH v2 3/4] tests/avocado: use OpenBSD 7.4 for sbsa-ref
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240314-sbsa-ref-firmware-update-v2-3-b557c56559cd@linaro.org>
References: <20240314-sbsa-ref-firmware-update-v2-0-b557c56559cd@linaro.org>
In-Reply-To: <20240314-sbsa-ref-firmware-update-v2-0-b557c56559cd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Radoslaw Biernacki <rad@semihalf.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, Brad Smith <brad@comstyle.com>, 
 qemu-arm@nongnu.org, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
X-Mailer: b4 0.12.3
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

7.4 was released in October 2023, time to update before 7.3 gets dropped.

Disabled tests for 'max' cpu as OpenBSD fails there.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
---
 tests/avocado/machine_aarch64_sbsaref.py | 47 +++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
index 259225f15f..0e52dc5854 100644
--- a/tests/avocado/machine_aarch64_sbsaref.py
+++ b/tests/avocado/machine_aarch64_sbsaref.py
@@ -159,14 +159,14 @@ def test_sbsaref_alpine_linux_max(self):
     # This tests the whole boot chain from EFI to Userspace
     # We only boot a whole OS for the current top level CPU and GIC
     # Other test profiles should use more minimal boots
-    def boot_openbsd73(self, cpu):
+    def boot_openbsd(self, cpu):
         self.fetch_firmware()
 
         img_url = (
-            "https://cdn.openbsd.org/pub/OpenBSD/7.3/arm64/miniroot73.img"
+            "https://cdn.openbsd.org/pub/OpenBSD/7.4/arm64/miniroot74.img"
         )
 
-        img_hash = "7fc2c75401d6f01fbfa25f4953f72ad7d7c18650056d30755c44b9c129b707e5"
+        img_hash = "7b08b2ce081cff6408d183f7152ddcfd2779912104866e4fdf6ae2d864b51142"
         img_path = self.fetch_asset(img_url, algorithm="sha256", asset_hash=img_hash)
 
         self.vm.set_console()
@@ -180,23 +180,44 @@ def boot_openbsd73(self, cpu):
         self.vm.launch()
         wait_for_console_pattern(self,
                                  "Welcome to the OpenBSD/arm64"
-                                 " 7.3 installation program.")
+                                 " 7.4 installation program.")
 
-    def test_sbsaref_openbsd73_cortex_a57(self):
+    def test_sbsaref_openbsd_cortex_a57(self):
         """
         :avocado: tags=cpu:cortex-a57
+        :avocado: tags=os:openbsd
         """
-        self.boot_openbsd73("cortex-a57")
+        self.boot_openbsd("cortex-a57")
 
-    def test_sbsaref_openbsd73_neoverse_n1(self):
+    def test_sbsaref_openbsd_neoverse_n1(self):
         """
         :avocado: tags=cpu:neoverse-n1
+        :avocado: tags=os:openbsd
         """
-        self.boot_openbsd73("neoverse-n1")
+        self.boot_openbsd("neoverse-n1")
 
-    def test_sbsaref_openbsd73_max(self):
-        """
-        :avocado: tags=cpu:max
-        """
-        self.boot_openbsd73("max")
+# OpenBSD 7.4 does not boot on current max cpu.
+#
+#   def test_sbsaref_openbsd_max_pauth_off(self):
+#       """
+#       :avocado: tags=cpu:max
+#       :avocado: tags=os:openbsd
+#       """
+#       self.boot_openbsd("max,pauth=off")
+
+#   @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
+#   def test_sbsaref_openbsd_max_pauth_impdef(self):
+#       """
+#       :avocado: tags=cpu:max
+#       :avocado: tags=os:openbsd
+#       """
+#       self.boot_openbsd("max,pauth-impdef=on")
+
+#   @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
+#   def test_sbsaref_openbsd_max(self):
+#       """
+#       :avocado: tags=cpu:max
+#       :avocado: tags=os:openbsd
+#       """
+#       self.boot_openbsd("max")
 

-- 
2.44.0


