Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FACD959691
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Aug 2024 10:32:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sggji-0007aZ-RO; Wed, 21 Aug 2024 04:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sggjB-0005kk-7f
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 04:30:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sggj1-0004Xe-Bh
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 04:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724228983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2pRc0Bgk7Kk44ZtOOH3dtElUV6jzWrYEu5g4FuL1JUQ=;
 b=cMnmESAXWQC5WQjV4w+ynlOKv84Mr05fJ+jLBeE9V8pguQ0oXjnjNnOZjJvpIz0QSs/2Jt
 v6KlRJcsAgsOcPHF+e08qLijm3fKFBRQcMA1/Wtn+uXG9wrPe2RcVXp8VujMyjtCXhewGK
 JhJ3q+A3hm9wt2TsLDWjKjdzw4EHBJo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-Buq0SR9HO3WGV5EV6Gp-AA-1; Wed,
 21 Aug 2024 04:29:39 -0400
X-MC-Unique: Buq0SR9HO3WGV5EV6Gp-AA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FA53192DE26; Wed, 21 Aug 2024 08:29:27 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-191.str.redhat.com
 [10.33.192.191])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1201219773D1; Wed, 21 Aug 2024 08:29:13 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v4 23/35] tests/functional: Convert the virtio_gpu avocado
 test into a standalone test
Date: Wed, 21 Aug 2024 10:27:24 +0200
Message-ID: <20240821082748.65853-24-thuth@redhat.com>
In-Reply-To: <20240821082748.65853-1-thuth@redhat.com>
References: <20240821082748.65853-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Nothing thrilling in here, it's just a straight forward conversion.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/meson.build                  |  1 +
 .../test_virtio_gpu.py}                       | 64 +++++++++----------
 2 files changed, 30 insertions(+), 35 deletions(-)
 rename tests/{avocado/virtio-gpu.py => functional/test_virtio_gpu.py} (73%)
 mode change 100644 => 100755

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 55021c4e4d..8fbd7c4129 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -82,6 +82,7 @@ tests_x86_64_quick = [
 
 tests_x86_64_thorough = [
   'netdev_ethtool',
+  'virtio_gpu',
 ]
 
 precache_all = []
diff --git a/tests/avocado/virtio-gpu.py b/tests/functional/test_virtio_gpu.py
old mode 100644
new mode 100755
similarity index 73%
rename from tests/avocado/virtio-gpu.py
rename to tests/functional/test_virtio_gpu.py
index 6091f614a4..441cbdcf2d
--- a/tests/avocado/virtio-gpu.py
+++ b/tests/functional/test_virtio_gpu.py
@@ -1,14 +1,16 @@
+#!/usr/bin/env python3
+#
 # virtio-gpu tests
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
 
-from avocado_qemu import BUILD_DIR
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
-from avocado_qemu import exec_command_and_wait_for_pattern
-from avocado_qemu import is_readable_executable_file
+from qemu_test import BUILD_DIR
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import is_readable_executable_file
 
 from qemu.utils import kvm_available
 
@@ -28,25 +30,18 @@ def pick_default_vug_bin():
 
 
 class VirtioGPUx86(QemuSystemTest):
-    """
-    :avocado: tags=virtio-gpu
-    :avocado: tags=arch:x86_64
-    :avocado: tags=cpu:host
-    """
 
     KERNEL_COMMAND_LINE = "printk.time=0 console=ttyS0 rdinit=/bin/bash"
-    KERNEL_URL = (
-        "https://archives.fedoraproject.org/pub/archive/fedora"
-        "/linux/releases/33/Everything/x86_64/os/images"
-        "/pxeboot/vmlinuz"
-    )
-    KERNEL_HASH = '1433cfe3f2ffaa44de4ecfb57ec25dc2399cdecf'
-    INITRD_URL = (
-        "https://archives.fedoraproject.org/pub/archive/fedora"
-        "/linux/releases/33/Everything/x86_64/os/images"
-        "/pxeboot/initrd.img"
-    )
-    INITRD_HASH = 'c828d68a027b53e5220536585efe03412332c2d9'
+    ASSET_KERNEL = Asset(
+        ("https://archives.fedoraproject.org/pub/archive/fedora"
+         "/linux/releases/33/Everything/x86_64/os/images"
+         "/pxeboot/vmlinuz"),
+        '2dc5fb5cfe9ac278fa45640f3602d9b7a08cc189ed63fd9b162b07073e4df397')
+    ASSET_INITRD = Asset(
+        ("https://archives.fedoraproject.org/pub/archive/fedora"
+         "/linux/releases/33/Everything/x86_64/os/images"
+         "/pxeboot/initrd.img"),
+        'c49b97f893a5349e4883452178763e402bdc5caa8845b226a2d1329b5f356045')
 
     def wait_for_console_pattern(self, success_message, vm=None):
         wait_for_console_pattern(
@@ -57,16 +52,14 @@ def wait_for_console_pattern(self, success_message, vm=None):
         )
 
     def test_virtio_vga_virgl(self):
-        """
-        :avocado: tags=device:virtio-vga-gl
-        """
         # FIXME: should check presence of virtio, virgl etc
         self.require_accelerator('kvm')
 
-        kernel_path = self.fetch_asset(self.KERNEL_URL, self.KERNEL_HASH)
-        initrd_path = self.fetch_asset(self.INITRD_URL, self.INITRD_HASH)
+        kernel_path = self.ASSET_KERNEL.fetch()
+        initrd_path = self.ASSET_INITRD.fetch()
 
         self.vm.set_console()
+        self.vm.add_args("-cpu", "host")
         self.vm.add_args("-m", "2G")
         self.vm.add_args("-machine", "pc,accel=kvm")
         self.vm.add_args("-device", "virtio-vga-gl")
@@ -83,7 +76,7 @@ def test_virtio_vga_virgl(self):
             self.vm.launch()
         except:
             # TODO: probably fails because we are missing the VirGL features
-            self.cancel("VirGL not enabled?")
+            self.skipTest("VirGL not enabled?")
 
         self.wait_for_console_pattern("as init process")
         exec_command_and_wait_for_pattern(
@@ -92,18 +85,15 @@ def test_virtio_vga_virgl(self):
         self.wait_for_console_pattern("features: +virgl +edid")
 
     def test_vhost_user_vga_virgl(self):
-        """
-        :avocado: tags=device:vhost-user-vga
-        """
         # FIXME: should check presence of vhost-user-gpu, virgl, memfd etc
         self.require_accelerator('kvm')
 
         vug = pick_default_vug_bin()
         if not vug:
-            self.cancel("Could not find vhost-user-gpu")
+            self.skipTest("Could not find vhost-user-gpu")
 
-        kernel_path = self.fetch_asset(self.KERNEL_URL, self.KERNEL_HASH)
-        initrd_path = self.fetch_asset(self.INITRD_URL, self.INITRD_HASH)
+        kernel_path = self.ASSET_KERNEL.fetch()
+        initrd_path = self.ASSET_INITRD.fetch()
 
         # Create socketpair to connect proxy and remote processes
         qemu_sock, vug_sock = socket.socketpair(
@@ -129,6 +119,7 @@ def test_vhost_user_vga_virgl(self):
         )
 
         self.vm.set_console()
+        self.vm.add_args("-cpu", "host")
         self.vm.add_args("-m", "2G")
         self.vm.add_args("-object", "memory-backend-memfd,id=mem,size=2G")
         self.vm.add_args("-machine", "pc,memory-backend=mem,accel=kvm")
@@ -147,7 +138,7 @@ def test_vhost_user_vga_virgl(self):
             self.vm.launch()
         except:
             # TODO: probably fails because we are missing the VirGL features
-            self.cancel("VirGL not enabled?")
+            self.skipTest("VirGL not enabled?")
         self.wait_for_console_pattern("as init process")
         exec_command_and_wait_for_pattern(self, "/usr/sbin/modprobe virtio_gpu",
                                           "features: +virgl +edid")
@@ -155,3 +146,6 @@ def test_vhost_user_vga_virgl(self):
         qemu_sock.close()
         vugp.terminate()
         vugp.wait()
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.46.0


