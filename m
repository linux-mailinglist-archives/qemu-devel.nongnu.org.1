Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B505C9A6F1B
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Oct 2024 18:13:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2v13-00040c-UT; Mon, 21 Oct 2024 12:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2v0v-0003yt-HM
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:12:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2v0t-0003Bw-Jm
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729527130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jKPnelz0WM5Rf9rpq48k1kp1Fidx5JMBWCmlQHIgqno=;
 b=gbfpJ+clD4DMaC6xtlf3owwQ9PzfmXJGZFTNKOo1cLOn5iVi6tb1VbWj/nqoDWoFbfAmxT
 HFJePZpGFA4/DbC/JXKQRamY1TZTeyZiPEWx1wp53Qd7HSzdjIKKl0qQTcfsv6HrKvRaAM
 /NdmRQAYtGsF4DJdo1nzmyx6K3TXHRg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-U29FoURNP0mfjDjjfdChog-1; Mon,
 21 Oct 2024 12:12:08 -0400
X-MC-Unique: U29FoURNP0mfjDjjfdChog-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E263C1977039; Mon, 21 Oct 2024 16:12:07 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.49])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5081A195607C; Mon, 21 Oct 2024 16:12:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 14/20] tests/functional: Convert the Avocado mips tuxrun test
Date: Mon, 21 Oct 2024 18:11:48 +0200
Message-ID: <20241021161156.176427-5-thuth@redhat.com>
In-Reply-To: <20241021161156.176427-1-thuth@redhat.com>
References: <20241021161156.176427-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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
qemu-system-mips in the functional framework.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20241011131937.377223-12-thuth@redhat.com>
---
 tests/avocado/tuxrun_baselines.py    | 18 --------------
 tests/functional/meson.build         |  1 +
 tests/functional/test_mips_tuxrun.py | 36 ++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 18 deletions(-)
 create mode 100755 tests/functional/test_mips_tuxrun.py

diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
index 55a4a42d77..ed6c2ce0d4 100644
--- a/tests/avocado/tuxrun_baselines.py
+++ b/tests/avocado/tuxrun_baselines.py
@@ -223,24 +223,6 @@ def test_arm64be(self):
                  "e6ffd8813c8a335bc15728f2835f90539c84be7f8f5f691a8b01451b47fb4bd7"}
         self.common_tuxrun(csums=sums)
 
-    def test_mips32(self):
-        """
-        :avocado: tags=arch:mips
-        :avocado: tags=machine:malta
-        :avocado: tags=cpu:mips32r6-generic
-        :avocado: tags=endian:big
-        :avocado: tags=tuxboot:mips32
-        :avocado: tags=image:vmlinux
-        :avocado: tags=root:sda
-        :avocado: tags=shutdown:nowait
-        """
-        sums = { "rootfs.ext4.zst" :
-                 "fc3da0b4c2f38d74c6d705123bb0f633c76ed953128f9d0859378c328a6d11a0",
-                 "vmlinux" :
-                 "bfd2172f8b17fb32970ca0c8c58f59c5a4ca38aa5855d920be3a69b5d16e52f0" }
-
-        self.common_tuxrun(csums=sums, drive="driver=ide-hd,bus=ide.0,unit=0")
-
     def test_mips32el(self):
         """
         :avocado: tags=arch:mipsel
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index cbc3b20bd4..00591fbcba 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -90,6 +90,7 @@ tests_microblazeel_system_thorough = [
 
 tests_mips_system_thorough = [
   'mips_malta',
+  'mips_tuxrun',
 ]
 
 tests_mipsel_system_thorough = [
diff --git a/tests/functional/test_mips_tuxrun.py b/tests/functional/test_mips_tuxrun.py
new file mode 100755
index 0000000000..6fec44c2bf
--- /dev/null
+++ b/tests/functional/test_mips_tuxrun.py
@@ -0,0 +1,36 @@
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
+class TuxRunMipsTest(TuxRunBaselineTest):
+
+    ASSET_MIPS_KERNEL = Asset(
+        'https://storage.tuxboot.com/20230331/mips32/vmlinux',
+        'bfd2172f8b17fb32970ca0c8c58f59c5a4ca38aa5855d920be3a69b5d16e52f0')
+    ASSET_MIPS_ROOTFS = Asset(
+        'https://storage.tuxboot.com/20230331/mips32/rootfs.ext4.zst',
+        'fc3da0b4c2f38d74c6d705123bb0f633c76ed953128f9d0859378c328a6d11a0')
+
+    def test_mips32(self):
+        self.set_machine('malta')
+        self.cpu="mips32r6-generic"
+        self.root="sda"
+        self.wait_for_shutdown=False
+        self.common_tuxrun(kernel_asset=self.ASSET_MIPS_KERNEL,
+                           rootfs_asset=self.ASSET_MIPS_ROOTFS,
+                           drive="driver=ide-hd,bus=ide.0,unit=0")
+
+if __name__ == '__main__':
+    TuxRunBaselineTest.main()
-- 
2.47.0


