Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 692169EC4E1
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Dec 2024 07:37:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLGHC-0006cN-1Z; Wed, 11 Dec 2024 01:32:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tLGG5-0004fA-1n
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 01:31:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tLGFv-0008T8-UU
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 01:31:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733898691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AR/NRMiRGLpnrxJqXYyzazkP88xAkX0L2EWkyBm8vhA=;
 b=QFIWwf7+TcMDEuQ6vhRE+S31brFfIt+YeTiCQqqfcSXtGjgvxat0WX2gDavkwLC1CkVcTx
 0SogVi67uh1HNFFh/gWFjoAty2oWJj2lBlYw/U4/3vY3IayTE1kjkXNYRbSb55Oph7JmdG
 Ibm5Z3jK7GUNk8xsOyNYby4k6PJ7Ufw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-MT3xsyS7O1qGGIzOle_6vA-1; Wed,
 11 Dec 2024 01:31:28 -0500
X-MC-Unique: MT3xsyS7O1qGGIzOle_6vA-1
X-Mimecast-MFC-AGG-ID: MT3xsyS7O1qGGIzOle_6vA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88AA51955D4C; Wed, 11 Dec 2024 06:31:27 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.194.144])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B1A0195605A; Wed, 11 Dec 2024 06:31:25 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 09/24] tests/functional: Introduce a specific test for
 palmetto-bmc machine
Date: Wed, 11 Dec 2024 07:30:43 +0100
Message-ID: <20241211063058.1222038-10-clg@redhat.com>
In-Reply-To: <20241211063058.1222038-1-clg@redhat.com>
References: <20241211063058.1222038-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This introduces a new aspeed module for sharing code between tests and
moves the palmetto test to a new test file. No changes in the test.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Link: https://lore.kernel.org/r/20241206131132.520911-3-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/aspeed.py                   | 23 +++++++++++++++++++
 tests/functional/meson.build                 |  2 ++
 tests/functional/test_arm_aspeed.py          | 10 --------
 tests/functional/test_arm_aspeed_palmetto.py | 24 ++++++++++++++++++++
 4 files changed, 49 insertions(+), 10 deletions(-)
 create mode 100644 tests/functional/aspeed.py
 create mode 100644 tests/functional/test_arm_aspeed_palmetto.py

diff --git a/tests/functional/aspeed.py b/tests/functional/aspeed.py
new file mode 100644
index 000000000000..d4dc5320b97a
--- /dev/null
+++ b/tests/functional/aspeed.py
@@ -0,0 +1,23 @@
+# Test class to boot aspeed machines
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest
+
+class AspeedTest(LinuxKernelTest):
+
+    def do_test_arm_aspeed(self, machine, image):
+        self.set_machine(machine)
+        self.vm.set_console()
+        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
+                         '-net', 'nic', '-snapshot')
+        self.vm.launch()
+
+        self.wait_for_console_pattern("U-Boot 2016.07")
+        self.wait_for_console_pattern("## Loading kernel from FIT Image at 20080000")
+        self.wait_for_console_pattern("Starting kernel ...")
+        self.wait_for_console_pattern("Booting Linux on physical CPU 0x0")
+        self.wait_for_console_pattern(
+                "aspeed-smc 1e620000.spi: read control register: 203b0641")
+        self.wait_for_console_pattern("ftgmac100 1e660000.ethernet eth0: irq ")
+        self.wait_for_console_pattern("systemd[1]: Set hostname to")
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 66f10da99d63..4752dca9d66c 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -18,6 +18,7 @@ test_timeouts = {
   'aarch64_tuxrun' : 240,
   'aarch64_virt' : 720,
   'acpi_bits' : 420,
+  'arm_aspeed_palmetto' : 120,
   'arm_aspeed' : 600,
   'arm_bpim2u' : 500,
   'arm_collie' : 180,
@@ -67,6 +68,7 @@ tests_alpha_system_thorough = [
 tests_arm_system_thorough = [
   'arm_aspeed',
   'arm_aspeed_ast1030',
+  'arm_aspeed_palmetto',
   'arm_bpim2u',
   'arm_canona1100',
   'arm_collie',
diff --git a/tests/functional/test_arm_aspeed.py b/tests/functional/test_arm_aspeed.py
index 9e58fcd84009..48a229608ef6 100755
--- a/tests/functional/test_arm_aspeed.py
+++ b/tests/functional/test_arm_aspeed.py
@@ -37,16 +37,6 @@ def do_test_arm_aspeed(self, machine, image):
         self.wait_for_console_pattern("ftgmac100 1e660000.ethernet eth0: irq ")
         self.wait_for_console_pattern("systemd[1]: Set hostname to")
 
-    ASSET_PALMETTO_FLASH = Asset(
-        ('https://github.com/openbmc/openbmc/releases/download/2.9.0/'
-         'obmc-phosphor-image-palmetto.static.mtd'),
-        '3e13bbbc28e424865dc42f35ad672b10f2e82cdb11846bb28fa625b48beafd0d');
-
-    def test_arm_ast2400_palmetto_openbmc_v2_9_0(self):
-        image_path = self.ASSET_PALMETTO_FLASH.fetch()
-
-        self.do_test_arm_aspeed('palmetto-bmc', image_path)
-
     ASSET_ROMULUS_FLASH = Asset(
         ('https://github.com/openbmc/openbmc/releases/download/2.9.0/'
          'obmc-phosphor-image-romulus.static.mtd'),
diff --git a/tests/functional/test_arm_aspeed_palmetto.py b/tests/functional/test_arm_aspeed_palmetto.py
new file mode 100644
index 000000000000..6588c02aad79
--- /dev/null
+++ b/tests/functional/test_arm_aspeed_palmetto.py
@@ -0,0 +1,24 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots the ASPEED machines
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset
+from aspeed import AspeedTest
+
+class PalmettoMachine(AspeedTest):
+
+    ASSET_PALMETTO_FLASH = Asset(
+        ('https://github.com/openbmc/openbmc/releases/download/2.9.0/'
+         'obmc-phosphor-image-palmetto.static.mtd'),
+        '3e13bbbc28e424865dc42f35ad672b10f2e82cdb11846bb28fa625b48beafd0d');
+
+    def test_arm_ast2400_palmetto_openbmc_v2_9_0(self):
+        image_path = self.ASSET_PALMETTO_FLASH.fetch()
+
+        self.do_test_arm_aspeed('palmetto-bmc', image_path)
+
+
+if __name__ == '__main__':
+    AspeedTest.main()
-- 
2.47.1


