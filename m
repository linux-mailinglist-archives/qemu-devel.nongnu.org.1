Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA469857B6
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Sep 2024 13:12:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stPvB-0007A1-QF; Wed, 25 Sep 2024 07:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1stPv8-00071z-QY
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:10:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1stPv7-0003Uu-17
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727262656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VB4nmDbjMujt0fdaIqI0rVBSF2sbIhacJKAHpqjPw3I=;
 b=CZC4k8lGWczthkIS1potXGEqh8v3iYWnfiCcxpyTMrzwiDfpgUmgGTigVj3t0WPdxjREuo
 IKgC8OrbGrqDZ/0NfGj5gD+sWpVabalZ60iBYN88WvMBsahHIZIlCJ/6AZ5Z0OAEhhY9KM
 UOlFzHwBak6EFKoZwSJ6eZSHTV93U6E=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-lHD06N02NiuCofo2BSol0w-1; Wed,
 25 Sep 2024 07:10:54 -0400
X-MC-Unique: lHD06N02NiuCofo2BSol0w-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D44821955D56; Wed, 25 Sep 2024 11:10:53 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.206])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1784A1956094; Wed, 25 Sep 2024 11:10:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 05/44] tests/functional: Convert the e500 ppc64 Avocado test
Date: Wed, 25 Sep 2024 13:09:46 +0200
Message-ID: <20240925111029.24082-6-thuth@redhat.com>
In-Reply-To: <20240925111029.24082-1-thuth@redhat.com>
References: <20240925111029.24082-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.108,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Use the new launch_kernel function to convert this test in a simple way.

Message-ID: <20240919185749.71222-6-thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                         |  1 +
 tests/avocado/boot_linux_console.py | 11 -----------
 tests/functional/meson.build        |  1 +
 tests/functional/test_ppc64_e500.py | 25 +++++++++++++++++++++++++
 4 files changed, 27 insertions(+), 11 deletions(-)
 create mode 100755 tests/functional/test_ppc64_e500.py

diff --git a/MAINTAINERS b/MAINTAINERS
index b85a3fc529..3dd80a0138 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1445,6 +1445,7 @@ F: pc-bios/u-boot.e500
 F: hw/intc/openpic_kvm.c
 F: include/hw/ppc/openpic_kvm.h
 F: docs/system/ppc/ppce500.rst
+F: tests/functional/test_ppc64_e500.py
 
 mpc8544ds
 L: qemu-ppc@nongnu.org
diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 900af67412..344c7835a2 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -918,17 +918,6 @@ def test_arm_ast2600_debian(self):
         self.wait_for_console_pattern("SMP: Total of 2 processors activated")
         self.wait_for_console_pattern("No filesystem could mount root")
 
-    def test_ppc64_e500(self):
-        """
-        :avocado: tags=arch:ppc64
-        :avocado: tags=machine:ppce500
-        :avocado: tags=cpu:e5500
-        :avocado: tags=accel:tcg
-        """
-        self.require_accelerator("tcg")
-        tar_hash = '6951d86d644b302898da2fd701739c9406527fe1'
-        self.do_test_advcal_2018('19', tar_hash, 'uImage')
-
     def do_test_ppc64_powernv(self, proc):
         self.require_accelerator("tcg")
         images_url = ('https://github.com/open-power/op-build/releases/download/v2.7/')
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 8aacd15cf3..bc33332313 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -111,6 +111,7 @@ tests_ppc_system_thorough = [
 ]
 
 tests_ppc64_system_thorough = [
+  'ppc64_e500',
   'ppc64_hv',
   'ppc64_powernv',
   'ppc64_pseries',
diff --git a/tests/functional/test_ppc64_e500.py b/tests/functional/test_ppc64_e500.py
new file mode 100755
index 0000000000..3558ae0c8c
--- /dev/null
+++ b/tests/functional/test_ppc64_e500.py
@@ -0,0 +1,25 @@
+#!/usr/bin/env python3
+#
+# Boot a Linux kernel on a e500 ppc64 machine and check the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest, Asset
+from qemu_test.utils import archive_extract
+
+class E500Test(LinuxKernelTest):
+
+    ASSET_DAY19 = Asset(
+        'https://www.qemu-advent-calendar.org/2018/download/day19.tar.xz',
+        '20b1bb5a8488c664defbb5d283addc91a05335a936c63b3f5ff7eee74b725755')
+
+    def test_ppc64_e500(self):
+        self.set_machine('ppce500')
+        self.cpu = 'e5500'
+        file_path = self.ASSET_DAY19.fetch()
+        archive_extract(file_path, self.workdir)
+        self.launch_kernel(self.workdir + '/day19/uImage',
+                           wait_for='QEMU advent calendar')
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.46.0


