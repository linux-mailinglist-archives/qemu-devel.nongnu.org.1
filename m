Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0918A70AE8
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Mar 2025 21:02:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txASk-0000VA-Tv; Tue, 25 Mar 2025 16:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1txASJ-0000UC-6n
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 16:00:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1txASH-0002hA-3M
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 16:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742932856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CFD13zo5vrdsSqguVPG+sHYd6VXC3OOA9Pt1+E4U9I0=;
 b=AQ1+OhbjY08kBjayVw1ymGf1c8A2NdA9TXkSpnasFEdgqgt1V3UKRbjmXbF+KihVqosZcV
 4YbiaAQEeyAlLxknr75fuAwD0gBG7LgcfGv+8Z46S4Xhw9TlmKQTWum8m0rFMSIs0FxcOk
 vTC6G2qfnmgZxI7GlPrNHFiv67pGxjI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-cESPxFN9MMuay3EhRf0bDA-1; Tue,
 25 Mar 2025 16:00:54 -0400
X-MC-Unique: cESPxFN9MMuay3EhRf0bDA-1
X-Mimecast-MFC-AGG-ID: cESPxFN9MMuay3EhRf0bDA_1742932853
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CBF2C1956070; Tue, 25 Mar 2025 20:00:53 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.142])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 091631801747; Tue, 25 Mar 2025 20:00:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/15] tests/functional: Convert the 32-bit little endian
 Wheezy mips test
Date: Tue, 25 Mar 2025 21:00:15 +0100
Message-ID: <20250325200026.344006-8-thuth@redhat.com>
In-Reply-To: <20250325200026.344006-1-thuth@redhat.com>
References: <20250325200026.344006-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Huth <thuth@redhat.com>

Reuse the test function from the big endian test to easily
convert the 32-bit little endian Wheezy mips test.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/linux_ssh_mips_malta.py |  8 --------
 tests/functional/meson.build          |  1 +
 tests/functional/test_mipsel_malta.py | 22 ++++++++++++++++++++++
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/tests/avocado/linux_ssh_mips_malta.py b/tests/avocado/linux_ssh_mips_malta.py
index 73d294ad5cf..c1300aec961 100644
--- a/tests/avocado/linux_ssh_mips_malta.py
+++ b/tests/avocado/linux_ssh_mips_malta.py
@@ -172,14 +172,6 @@ def check_mips_malta(self, uname_m, endianess):
         # Wait for VM to shut down gracefully
         self.vm.wait()
 
-    def test_mips_malta32el_kernel3_2_0(self):
-        """
-        :avocado: tags=arch:mipsel
-        :avocado: tags=endian:little
-        :avocado: tags=device:pcnet32
-        """
-        self.check_mips_malta('mips', 'le')
-
     def test_mips_malta64eb_kernel3_2_0(self):
         """
         :avocado: tags=arch:mips64
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 3f8fabd218d..c7bd4eb4edf 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -40,6 +40,7 @@ test_timeouts = {
   'arm_sx1' : 360,
   'intel_iommu': 300,
   'mips_malta' : 480,
+  'mipsel_malta' : 420,
   'mipsel_replay' : 480,
   'mips64el_replay' : 180,
   'netdev_ethtool' : 180,
diff --git a/tests/functional/test_mipsel_malta.py b/tests/functional/test_mipsel_malta.py
index fe9c3a172e6..9ee2884da8e 100755
--- a/tests/functional/test_mipsel_malta.py
+++ b/tests/functional/test_mipsel_malta.py
@@ -13,6 +13,8 @@
 from qemu_test import interrupt_interactive_console_until_pattern
 from qemu_test import wait_for_console_pattern
 
+from test_mips_malta import mips_check_wheezy
+
 
 class MaltaMachineConsole(LinuxKernelTest):
 
@@ -57,6 +59,26 @@ def test_mips_malta32el_nanomips_16k_up(self):
     def test_mips_malta32el_nanomips_64k_dbg(self):
         self.do_test_mips_malta32el_nanomips(self.ASSET_KERNEL_64K)
 
+    ASSET_WHEEZY_KERNEL = Asset(
+        ('https://people.debian.org/~aurel32/qemu/mipsel/'
+         'vmlinux-3.2.0-4-4kc-malta'),
+        'dc8a3648305b0201ca7a5cd135fe2890067a65d93c38728022bb0e656ad2bf9a')
+
+    ASSET_WHEEZY_DISK = Asset(
+        ('https://people.debian.org/~aurel32/qemu/mipsel/'
+         'debian_wheezy_mipsel_standard.qcow2'),
+        '454f09ae39f7e6461c84727b927100d2c7813841f2a0a5dce328114887ecf914')
+
+    def test_wheezy(self):
+        kernel_path = self.ASSET_WHEEZY_KERNEL.fetch()
+        image_path = self.ASSET_WHEEZY_DISK.fetch()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
+                               + 'console=ttyS0 root=/dev/sda1')
+        mips_check_wheezy(self,
+            kernel_path, image_path, kernel_command_line,
+            dl_file='/boot/initrd.img-3.2.0-4-4kc-malta',
+            hsum='9fc9f250ed56a74e35e704ddfd5a1c5a5625adefc5c9da91f649288d3ca000f0')
+
 
 class MaltaMachineYAMON(QemuSystemTest):
 
-- 
2.49.0


