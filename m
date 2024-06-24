Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CD8914E4D
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jun 2024 15:19:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLjWt-0001Ii-TA; Mon, 24 Jun 2024 09:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sLjWr-0001Hb-Vn; Mon, 24 Jun 2024 09:14:42 -0400
Received: from muminek.juszkiewicz.com.pl ([213.251.184.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sLjWq-0004sc-AX; Mon, 24 Jun 2024 09:14:41 -0400
Received: from localhost (localhost [127.0.0.1])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTP id 3F5D8261A90;
 Mon, 24 Jun 2024 15:14:38 +0200 (CEST)
X-Virus-Scanned: Debian amavis at juszkiewicz.com.pl
Received: from muminek.juszkiewicz.com.pl ([127.0.0.1])
 by localhost (muminek.juszkiewicz.com.pl [127.0.0.1]) (amavis, port 10024)
 with ESMTP id RknKwESWfuaG; Mon, 24 Jun 2024 15:14:36 +0200 (CEST)
Received: from applejack.lan (83.11.22.244.ipv4.supernova.orange.pl
 [83.11.22.244])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTPSA id 76FAC261A96;
 Mon, 24 Jun 2024 15:14:34 +0200 (CEST)
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Date: Mon, 24 Jun 2024 15:14:23 +0200
Subject: [PATCH v2 2/2] tests/avocado: add test for default sbsa-ref cpu
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240624-b4-move-to-freebsd-v2-2-64ea7b04998f@linaro.org>
References: <20240624-b4-move-to-freebsd-v2-0-64ea7b04998f@linaro.org>
In-Reply-To: <20240624-b4-move-to-freebsd-v2-0-64ea7b04998f@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: softfail client-ip=213.251.184.221;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=muminek.juszkiewicz.com.pl
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

We changed sbsa-ref cpu several times already and may do it again in a
future. To newer core or to enable/disable some properties.

This change switches Neoverse-N2 tests to 'let test default cpu' ones.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
---
 tests/avocado/machine_aarch64_sbsaref.py | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
index d52f89f756..0e96e7ea16 100644
--- a/tests/avocado/machine_aarch64_sbsaref.py
+++ b/tests/avocado/machine_aarch64_sbsaref.py
@@ -115,7 +115,7 @@ def test_sbsaref_edk2_firmware(self):
     # This tests the whole boot chain from EFI to Userspace
     # We only boot a whole OS for the current top level CPU and GIC
     # Other test profiles should use more minimal boots
-    def boot_alpine_linux(self, cpu):
+    def boot_alpine_linux(self, cpu=False):
         self.fetch_firmware()
 
         iso_url = (
@@ -128,12 +128,14 @@ def boot_alpine_linux(self, cpu):
 
         self.vm.set_console()
         self.vm.add_args(
-            "-cpu",
-            cpu,
             "-drive",
             f"file={iso_path},format=raw",
         )
 
+        # let allow test which will use default cpu of platform
+        if cpu:
+            self.vm.add_args("-cpu", cpu)
+
         self.vm.launch()
         wait_for_console_pattern(self, "Welcome to Alpine Linux 3.17")
 
@@ -144,12 +146,12 @@ def test_sbsaref_alpine_linux_cortex_a57(self):
         """
         self.boot_alpine_linux("cortex-a57")
 
-    def test_sbsaref_alpine_linux_neoverse_n1(self):
+    # Let test whichever cpu is used as default
+    def test_sbsaref_alpine_linux_default(self):
         """
-        :avocado: tags=cpu:neoverse-n1
         :avocado: tags=os:linux
         """
-        self.boot_alpine_linux("neoverse-n1")
+        self.boot_alpine_linux()
 
     def test_sbsaref_alpine_linux_max_pauth_off(self):
         """
@@ -178,7 +180,7 @@ def test_sbsaref_alpine_linux_max(self):
     # This tests the whole boot chain from EFI to Userspace
     # We only boot a whole OS for the current top level CPU and GIC
     # Other test profiles should use more minimal boots
-    def boot_freebsd(self, cpu):
+    def boot_freebsd(self, cpu=False):
         self.fetch_firmware()
 
         img_url = (
@@ -191,12 +193,14 @@ def boot_freebsd(self, cpu):
 
         self.vm.set_console()
         self.vm.add_args(
-            "-cpu",
-            cpu,
             "-drive",
             f"file={img_path},format=raw",
         )
 
+        # let allow test which will use default cpu of platform
+        if cpu:
+            self.vm.add_args("-cpu", cpu)
+
         self.vm.launch()
         wait_for_console_pattern(self, "Welcome to FreeBSD!")
 
@@ -207,13 +211,12 @@ def test_sbsaref_freebsd_cortex_a57(self):
         """
         self.boot_freebsd("cortex-a57")
 
-    # We use Neoverse-N2 as default cpu
-    def test_sbsaref_freebsd_neoverse_n2(self):
+    # Let test whichever cpu is used as default
+    def test_sbsaref_freebsd_default(self):
         """
-        :avocado: tags=cpu:neoverse-n2
         :avocado: tags=os:freebsd
         """
-        self.boot_freebsd("neoverse-n2")
+        self.boot_freebsd()
 
     def test_sbsaref_freebsd_max_pauth_off(self):
         """

-- 
2.45.2


