Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D43A45AF8
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Feb 2025 10:59:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnEAt-0003MO-02; Wed, 26 Feb 2025 04:57:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnEAr-0003Lk-0Y
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:57:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnEAn-00085T-31
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:57:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740563868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MBiOe30Wx9xQJR+vhoaQ4ph01QluaMCb1w2dsYeZ3S0=;
 b=JlTHoT+jofXG2R/XAIqSSovxJc+fNmUXf1DMdANgnvOycWeClP3elovhVolZIheLdfjfSj
 ig/Xl1szpIkfd4T1wIdFv32J9v6+OwgyErH+Mo1+hztj/LC9tr6zKXA1zB0cBdCE1o/B7P
 QXsPXKcG8SXUHri6kH2mfXzWFYM+tWI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-DwB7yroxNcCiaYpcYrLsvQ-1; Wed,
 26 Feb 2025 04:57:46 -0500
X-MC-Unique: DwB7yroxNcCiaYpcYrLsvQ-1
X-Mimecast-MFC-AGG-ID: DwB7yroxNcCiaYpcYrLsvQ_1740563865
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86B5919783B3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 09:57:45 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.144])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B46061800358; Wed, 26 Feb 2025 09:57:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 04/18] tests/functional: Convert the xtensa replay test to the
 functional framework
Date: Wed, 26 Feb 2025 10:57:17 +0100
Message-ID: <20250226095731.1172375-5-thuth@redhat.com>
In-Reply-To: <20250226095731.1172375-1-thuth@redhat.com>
References: <20250226095731.1172375-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Put the tests into a separate file now (since in the functional
framework, each file is run with one specific qemu-system-* binary).

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250218152744.228335-3-thuth@redhat.com>
---
 tests/avocado/replay_kernel.py         | 11 ----------
 tests/functional/meson.build           |  1 +
 tests/functional/test_xtensa_replay.py | 28 ++++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 11 deletions(-)
 create mode 100755 tests/functional/test_xtensa_replay.py

diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index b9b54a8793d..54b8417d3d5 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -399,14 +399,3 @@ def test_sparc_ss20(self):
         file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
         self.do_test_advcal_2018(file_path, 'zImage.elf')
 
-    def test_xtensa_lx60(self):
-        """
-        :avocado: tags=arch:xtensa
-        :avocado: tags=machine:lx60
-        :avocado: tags=cpu:dc233c
-        """
-        tar_hash = '49e88d9933742f0164b60839886c9739cb7a0d34'
-        tar_url = ('https://qemu-advcal.gitlab.io'
-                   '/qac-best-of-multiarch/download/day02.tar.xz')
-        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
-        self.do_test_advcal_2018(file_path, 'santas-sleigh-ride.elf')
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 111d8bab262..4d3d62f3fe7 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -296,6 +296,7 @@ tests_x86_64_system_thorough = [
 
 tests_xtensa_system_thorough = [
   'xtensa_lx60',
+  'xtensa_replay',
 ]
 
 precache_all = []
diff --git a/tests/functional/test_xtensa_replay.py b/tests/functional/test_xtensa_replay.py
new file mode 100755
index 00000000000..eb00a3b0044
--- /dev/null
+++ b/tests/functional/test_xtensa_replay.py
@@ -0,0 +1,28 @@
+#!/usr/bin/env python3
+#
+# Replay test that boots a Linux kernel on an xtensa lx650 machine
+# and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset
+from replay_kernel import ReplayKernelBase
+
+
+class XTensaReplay(ReplayKernelBase):
+
+    ASSET_DAY02 = Asset(
+        'https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/day02.tar.xz',
+        '68ff07f9b3fd3df36d015eb46299ba44748e94bfbb2d5295fddc1a8d4a9fd324')
+
+    def test_replay(self):
+        self.set_machine('lx60')
+        self.cpu = 'dc233c'
+        kernel_path = self.archive_extract(self.ASSET_DAY02,
+                                         member='day02/santas-sleigh-ride.elf')
+        self.run_rr(kernel_path, self.REPLAY_KERNEL_COMMAND_LINE,
+                    'QEMU advent calendar')
+
+
+if __name__ == '__main__':
+    ReplayKernelBase.main()
-- 
2.48.1


