Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A370A98146
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Apr 2025 09:39:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7UfQ-0003Jy-PD; Wed, 23 Apr 2025 03:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7UfE-0003EM-I6
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:37:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7UfB-0003HX-Nh
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745393816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ICnDD9gDStiGMubGBNvzpXFf7u4VFjhcPlW1x+Zd+jo=;
 b=PsJWHmdRVl3gJtLJItIiFnMy0Mjw6AB8U8teW+Pz1HI7p7lsuiXxYSGcA44Nml5BZ2VxqC
 O12L4VWcrxKXAe1UjazERHCsWWwgZsLN1WrLi1C9eU1xeVdvWiyi+zACOC+ugWUfvQZWHH
 fcsm6lAKqwdaVIypkMwmwk3YCrvAc34=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-PO6NiB_7NyObt6Xoptv3Yg-1; Wed,
 23 Apr 2025 03:36:54 -0400
X-MC-Unique: PO6NiB_7NyObt6Xoptv3Yg-1
X-Mimecast-MFC-AGG-ID: PO6NiB_7NyObt6Xoptv3Yg_1745393813
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85B731955DCC; Wed, 23 Apr 2025 07:36:53 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-219.str.redhat.com
 [10.33.192.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ED3181955BCB; Wed, 23 Apr 2025 07:36:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 17/29] tests/functional: Convert the 32-bit little endian
 Wheezy mips test
Date: Wed, 23 Apr 2025 09:35:57 +0200
Message-ID: <20250423073610.271585-18-thuth@redhat.com>
In-Reply-To: <20250423073610.271585-1-thuth@redhat.com>
References: <20250423073610.271585-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250414113031.151105-8-thuth@redhat.com>
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
index 4dedfc7b9f7..cba0abf2920 100644
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


