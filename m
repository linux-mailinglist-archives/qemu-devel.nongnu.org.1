Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C8499A9E2
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Oct 2024 19:25:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJDL-0000Rk-V5; Fri, 11 Oct 2024 13:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1szJ78-0004AI-KS
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:07:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1szFZf-0004Ri-IL
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 09:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728652851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OcUoJ5PXttCpLGQ6HYe2UvZN9SjHytyJH4avjZ+Qm5g=;
 b=L1e/5NKe+674O4Bda5qwP8cMiQL066D36zqnycQbyw9xJap/ArXN+wPP3lvxX4us9HVHM2
 pAPTrc2juN4vbsQfhA1TfMosSKjMVbBnckAeTEyB/23F07pMaPYNo/eB3QrcB01pvEl2Ho
 /fuXVws44e3xJtk03acbCDUaHSRbxV4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-SG5v50-HPv6Dp-mKY8YTwA-1; Fri,
 11 Oct 2024 09:20:50 -0400
X-MC-Unique: SG5v50-HPv6Dp-mKY8YTwA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B66B11955D47; Fri, 11 Oct 2024 13:20:48 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.77])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D527B1956052; Fri, 11 Oct 2024 13:20:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 13/17] tests/functional: Convert the Avocado mips64 tuxrun test
Date: Fri, 11 Oct 2024 15:19:30 +0200
Message-ID: <20241011131937.377223-14-thuth@redhat.com>
In-Reply-To: <20241011131937.377223-1-thuth@redhat.com>
References: <20241011131937.377223-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Move the test into a new file so that it can be run via
qemu-system-mips64 in the functional framework.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/tuxrun_baselines.py      | 17 -------------
 tests/functional/meson.build           |  4 +++
 tests/functional/test_mips64_tuxrun.py | 35 ++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 17 deletions(-)
 create mode 100755 tests/functional/test_mips64_tuxrun.py

diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
index d45c2ce35e..e0e6a56067 100644
--- a/tests/avocado/tuxrun_baselines.py
+++ b/tests/avocado/tuxrun_baselines.py
@@ -192,23 +192,6 @@ def common_tuxrun(self,
     #        --kernel https://storage.tuxboot.com/{TUXBOOT}/{IMAGE}
     #
 
-    def test_mips64(self):
-        """
-        :avocado: tags=arch:mips64
-        :avocado: tags=machine:malta
-        :avocado: tags=tuxboot:mips64
-        :avocado: tags=endian:big
-        :avocado: tags=image:vmlinux
-        :avocado: tags=root:sda
-        :avocado: tags=shutdown:nowait
-        """
-        sums = { "rootfs.ext4.zst" :
-                 "69d91eeb04df3d8d172922c6993bb37d4deeb6496def75d8580f6f9de3e431da",
-                 "vmlinux" :
-                 "09010e51e4b8bcbbd2494786ffb48eca78f228e96e5c5438344b0eac4029dc61" }
-
-        self.common_tuxrun(csums=sums, drive="driver=ide-hd,bus=ide.0,unit=0")
-
     def test_mips64el(self):
         """
         :avocado: tags=arch:mips64el
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 813237e412..eef48edf52 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -100,6 +100,10 @@ tests_mipsel_system_thorough = [
   'mipsel_tuxrun',
 ]
 
+tests_mips64_system_thorough = [
+  'mips64_tuxrun',
+]
+
 tests_mips64el_system_thorough = [
   'mips64el_fuloong2e',
   'mips64el_loongson3v',
diff --git a/tests/functional/test_mips64_tuxrun.py b/tests/functional/test_mips64_tuxrun.py
new file mode 100755
index 0000000000..54af1ae794
--- /dev/null
+++ b/tests/functional/test_mips64_tuxrun.py
@@ -0,0 +1,35 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots known good tuxboot images the same way
+# that tuxrun (www.tuxrun.org) does. This tool is used by things like
+# the LKFT project to run regression tests on kernels.
+#
+# Copyright (c) 2023 Linaro Ltd.
+#
+# Author:
+#  Alex Bennée <alex.bennee@linaro.org>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset
+from qemu_test.tuxruntest import TuxRunBaselineTest
+
+class TuxRunMips64Test(TuxRunBaselineTest):
+
+    ASSET_MIPS64_KERNEL = Asset(
+        'https://storage.tuxboot.com/20230331/mips64/vmlinux',
+        '09010e51e4b8bcbbd2494786ffb48eca78f228e96e5c5438344b0eac4029dc61')
+    ASSET_MIPS64_ROOTFS = Asset(
+        'https://storage.tuxboot.com/20230331/mips64/rootfs.ext4.zst',
+        '69d91eeb04df3d8d172922c6993bb37d4deeb6496def75d8580f6f9de3e431da')
+
+    def test_mips64(self):
+        self.set_machine('malta')
+        self.root="sda"
+        self.wait_for_shutdown=False
+        self.common_tuxrun(kernel_asset=self.ASSET_MIPS64_KERNEL,
+                           rootfs_asset=self.ASSET_MIPS64_ROOTFS,
+                           drive="driver=ide-hd,bus=ide.0,unit=0")
+
+if __name__ == '__main__':
+    TuxRunBaselineTest.main()
-- 
2.46.1


