Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C329F645F
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Dec 2024 12:11:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrww-0006Vh-K5; Wed, 18 Dec 2024 06:10:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrwu-0006V4-1u
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:10:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrwo-0005JU-Qs
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:10:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734520233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JT8UzJi5z7TY7wn9HUyaWCIMSynOf1E1G97gzTKRu6w=;
 b=bL+GdGRdEV5zRNo23jxtWDJdUzAu9JNGNJEc+lKfO5OccU9KSVQBrw7Enbmc0ikf7/BPpC
 FoW/RXPTOlrqbB/sMz3V80XYkIO2Fz3r66sNC0lZIoXX9potNwKhs1buqw0KkhdsCVhI2u
 tGMTEi0iVOXtKFlD3virIa+kKG/AVHQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-9olMasc6O6ytJTsdz7ApcA-1; Wed,
 18 Dec 2024 06:10:31 -0500
X-MC-Unique: 9olMasc6O6ytJTsdz7ApcA-1
X-Mimecast-MFC-AGG-ID: 9olMasc6O6ytJTsdz7ApcA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CEC7F1956087
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 11:10:30 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.114])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3928119560AD; Wed, 18 Dec 2024 11:10:28 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 12/38] tests/functional: switch over to using
 self.build_file(...)
Date: Wed, 18 Dec 2024 12:09:32 +0100
Message-ID: <20241218110958.226932-13-thuth@redhat.com>
In-Reply-To: <20241218110958.226932-1-thuth@redhat.com>
References: <20241218110958.226932-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

From: Daniel P. Berrangé <berrange@redhat.com>

This removes direct access of the 'BUILD_DIR' variable.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20241217155953.3950506-13-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/cmd.py      |  5 ++---
 tests/functional/qemu_test/testcase.py |  4 ++--
 tests/functional/test_aarch64_virt.py  |  5 ++---
 tests/functional/test_virtio_gpu.py    | 11 +++--------
 4 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
index bebcd46dcf..c8971de00a 100644
--- a/tests/functional/qemu_test/cmd.py
+++ b/tests/functional/qemu_test/cmd.py
@@ -16,7 +16,6 @@
 import os.path
 import subprocess
 
-from .config import BUILD_DIR
 
 def which(tool):
     """ looks up the full path for @tool, returns None if not found
@@ -205,10 +204,10 @@ def get_qemu_img(test):
 
     # If qemu-img has been built, use it, otherwise the system wide one
     # will be used.
-    qemu_img = os.path.join(BUILD_DIR, 'qemu-img')
+    qemu_img = test.build_file('qemu-img')
     if os.path.exists(qemu_img):
         return qemu_img
     qemu_img = which('qemu-img')
     if qemu_img is not None:
         return qemu_img
-    test.skipTest(f"qemu-img not found in {BUILD_DIR} or '$PATH'")
+    test.skipTest(f"qemu-img not found in build dir or '$PATH'")
diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 2174fbb155..493938240c 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -133,8 +133,8 @@ def setUp(self, bin_prefix):
         self.arch = self.qemu_bin.split('-')[-1]
         self.socketdir = None
 
-        self.outputdir = os.path.join(BUILD_DIR, 'tests', 'functional',
-                                      self.arch, self.id())
+        self.outputdir = self.build_file('tests', 'functional',
+                                         self.arch, self.id())
         self.workdir = os.path.join(self.outputdir, 'scratch')
         os.makedirs(self.workdir, exist_ok=True)
 
diff --git a/tests/functional/test_aarch64_virt.py b/tests/functional/test_aarch64_virt.py
index c967da41b4..5bc461b482 100755
--- a/tests/functional/test_aarch64_virt.py
+++ b/tests/functional/test_aarch64_virt.py
@@ -14,7 +14,6 @@
 import os
 import logging
 
-from qemu_test import BUILD_DIR
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import exec_command, wait_for_console_pattern
 from qemu_test import get_qemu_img, run_cmd
@@ -54,8 +53,8 @@ def test_alpine_virt_tcg_gic_max(self):
                          "mte=on,"
                          "gic-version=max,iommu=smmuv3")
         self.vm.add_args("-smp", "2", "-m", "1024")
-        self.vm.add_args('-bios', os.path.join(BUILD_DIR, 'pc-bios',
-                                               'edk2-aarch64-code.fd'))
+        self.vm.add_args('-bios', self.build_file('pc-bios',
+                                                  'edk2-aarch64-code.fd'))
         self.vm.add_args("-drive", f"file={iso_path},media=cdrom,format=raw")
         self.vm.add_args('-device', 'virtio-rng-pci,rng=rng0')
         self.vm.add_args('-object', 'rng-random,id=rng0,filename=/dev/urandom')
diff --git a/tests/functional/test_virtio_gpu.py b/tests/functional/test_virtio_gpu.py
index 7654421e6b..81c9156d63 100755
--- a/tests/functional/test_virtio_gpu.py
+++ b/tests/functional/test_virtio_gpu.py
@@ -6,7 +6,6 @@
 # later.  See the COPYING file in the top-level directory.
 
 
-from qemu_test import BUILD_DIR
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
 from qemu_test import exec_command_and_wait_for_pattern
@@ -18,12 +17,8 @@
 import subprocess
 
 
-def pick_default_vug_bin():
-    relative_path = "./contrib/vhost-user-gpu/vhost-user-gpu"
-    if is_readable_executable_file(relative_path):
-        return relative_path
-
-    bld_dir_path = os.path.join(BUILD_DIR, relative_path)
+def pick_default_vug_bin(test):
+    bld_dir_path = test.build_file("contrib", "vhost-user-gpu", "vhost-user-gpu")
     if is_readable_executable_file(bld_dir_path):
         return bld_dir_path
 
@@ -86,7 +81,7 @@ def test_vhost_user_vga_virgl(self):
         # FIXME: should check presence of vhost-user-gpu, virgl, memfd etc
         self.require_accelerator('kvm')
 
-        vug = pick_default_vug_bin()
+        vug = pick_default_vug_bin(self)
         if not vug:
             self.skipTest("Could not find vhost-user-gpu")
 
-- 
2.47.1


