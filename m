Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CECD9A6F1F
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Oct 2024 18:13:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2v0z-0003z1-1A; Mon, 21 Oct 2024 12:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2v0s-0003yG-Eu
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:12:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2v0q-0003BY-LI
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729527128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yYwZiGw0VXAp52pkCAH0yBX6aMBQKwqlcr7JzQV2whk=;
 b=Ow29coXytaXRxsiaGhtCzFd/ibKr54aHp4R20lCrROZDpp1GtGJ/RtMTs5CdaIOpB8qftK
 nyRJccMzwylYtnvEpaeJim3n3rDiEuWoWWDcYSlYhulf4fu7mebmROk4qn1/kAWRKgjtRS
 bUhAE/8lf6hy39eJ6Qlp9K1eSg7uCxU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619--lG1nOiENKyPAwy78zMUSg-1; Mon,
 21 Oct 2024 12:12:04 -0400
X-MC-Unique: -lG1nOiENKyPAwy78zMUSg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4DB751955EAA; Mon, 21 Oct 2024 16:12:03 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.49])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0F5531956089; Mon, 21 Oct 2024 16:12:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 12/20] tests/functional: Convert the Avocado i386 tuxrun test
Date: Mon, 21 Oct 2024 18:11:46 +0200
Message-ID: <20241021161156.176427-3-thuth@redhat.com>
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

Move the tests to a new file so that they can be run via
qemu-system-i386 in the functional framework.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20241011131937.377223-10-thuth@redhat.com>
---
 MAINTAINERS                          |  1 +
 tests/avocado/tuxrun_baselines.py    | 16 -------------
 tests/functional/meson.build         |  4 ++++
 tests/functional/test_i386_tuxrun.py | 35 ++++++++++++++++++++++++++++
 4 files changed, 40 insertions(+), 16 deletions(-)
 create mode 100755 tests/functional/test_i386_tuxrun.py

diff --git a/MAINTAINERS b/MAINTAINERS
index ffc50bc0be..0c1966e985 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1782,6 +1782,7 @@ F: hw/isa/apm.c
 F: include/hw/isa/apm.h
 F: tests/unit/test-x86-topo.c
 F: tests/qtest/test-x86-cpuid-compat.c
+F: tests/functional/test_i386_tuxrun.py
 F: tests/functional/test_mem_addr_space.py
 F: tests/functional/test_pc_cpu_hotplug_props.py
 F: tests/functional/test_x86_cpu_model_versions.py
diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
index 6856a8f46a..f1463336e9 100644
--- a/tests/avocado/tuxrun_baselines.py
+++ b/tests/avocado/tuxrun_baselines.py
@@ -223,22 +223,6 @@ def test_arm64be(self):
                  "e6ffd8813c8a335bc15728f2835f90539c84be7f8f5f691a8b01451b47fb4bd7"}
         self.common_tuxrun(csums=sums)
 
-    def test_i386(self):
-        """
-        :avocado: tags=arch:i386
-        :avocado: tags=cpu:coreduo
-        :avocado: tags=machine:q35
-        :avocado: tags=tuxboot:i386
-        :avocado: tags=image:bzImage
-        :avocado: tags=shutdown:nowait
-        """
-        sums = {"bzImage" :
-                "a3e5b32a354729e65910f5a1ffcda7c14a6c12a55e8213fb86e277f1b76ed956",
-                "rootfs.ext4.zst" :
-                "f15e66b2bf673a210ec2a4b2e744a80530b36289e04f5388aab812b97f69754a" }
-
-        self.common_tuxrun(csums=sums, drive="virtio-blk-pci")
-
     def test_mips32(self):
         """
         :avocado: tags=arch:mips
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 96a83f54f7..ad112faf36 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -66,6 +66,10 @@ tests_avr_system_thorough = [
   'avr_mega2560',
 ]
 
+tests_i386_system_thorough = [
+  'i386_tuxrun',
+]
+
 tests_loongarch64_system_thorough = [
   'loongarch64_virt',
 ]
diff --git a/tests/functional/test_i386_tuxrun.py b/tests/functional/test_i386_tuxrun.py
new file mode 100755
index 0000000000..c593ffbe8c
--- /dev/null
+++ b/tests/functional/test_i386_tuxrun.py
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
+class TuxRunI386Test(TuxRunBaselineTest):
+
+    ASSET_I386_KERNEL = Asset(
+        'https://storage.tuxboot.com/20230331/i386/bzImage',
+        'a3e5b32a354729e65910f5a1ffcda7c14a6c12a55e8213fb86e277f1b76ed956')
+    ASSET_I386_ROOTFS = Asset(
+        'https://storage.tuxboot.com/20230331/i386/rootfs.ext4.zst',
+        'f15e66b2bf673a210ec2a4b2e744a80530b36289e04f5388aab812b97f69754a')
+
+    def test_i386(self):
+        self.set_machine('q35')
+        self.cpu="coreduo"
+        self.wait_for_shutdown=False
+        self.common_tuxrun(kernel_asset=self.ASSET_I386_KERNEL,
+                           rootfs_asset=self.ASSET_I386_ROOTFS,
+                           drive="virtio-blk-pci")
+
+if __name__ == '__main__':
+    TuxRunBaselineTest.main()
-- 
2.47.0


