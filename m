Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4E0ACEA94
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Jun 2025 09:00:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN4Zq-0006Cq-SZ; Thu, 05 Jun 2025 02:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1uN4Zo-0006Ca-TO
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 02:59:49 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1uN4Zn-0003AO-8Q
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 02:59:48 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:471f:0:640:3878:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 60BE860A97;
 Thu,  5 Jun 2025 09:59:45 +0300 (MSK)
Received: from dtalexundeer-nx.yandex-team.ru (unknown
 [2a02:6bf:8080:976::1:1f])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id LxWRjF5FYqM0-HPA5WuV9; Thu, 05 Jun 2025 09:59:44 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1749106784;
 bh=3/h61kQxPwdAilj5alYDrAVzILLMpqc0WLRxoW+McIc=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=R6v1uA5naUzGX917MV1pvAndlxdfww7Gio4bYIMR3iDadfjPqbLGrhT+lOt+8KrJ7
 CWHFKMnZ+/9H7TREFI+RQZ5tcaNcqyJ3TTvnPb5A1fiXU1kDDtq5eSX9EyF+ohcUDS
 fxjxf5+ZSMtTcBhw+FwDO4Ps6jAOFLzmywqSEOLU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 "yc-core @ yandex-team . ru" <yc-core@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PATCH v9 2/2] tests/functional: add memlock tests
Date: Thu,  5 Jun 2025 11:59:11 +0500
Message-Id: <20250605065908.299979-3-dtalexundeer@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250605065908.299979-1-dtalexundeer@yandex-team.ru>
References: <20250605065908.299979-1-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Add new tests to check the correctness of the `-overcommit memlock`
option (possible values: off, on, on-fault) by using
`/proc/{qemu_pid}/status` file to check in VmSize, VmRSS and VmLck
values:

* if `memlock=off`, then VmLck = 0;
* if `memlock=on`, then VmLck > 0 and almost all memory is resident;
* if `memlock=on-fault`, then VmLck > 0 and only few memory is resident.

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
---
 tests/functional/meson.build     |  1 +
 tests/functional/test_memlock.py | 79 ++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100755 tests/functional/test_memlock.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 52b4706cfe..4eea7115fb 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -311,6 +311,7 @@ tests_x86_64_system_quick = [
   'virtio_version',
   'x86_cpu_model_versions',
   'vnc',
+  'memlock',
 ]
 
 tests_x86_64_system_thorough = [
diff --git a/tests/functional/test_memlock.py b/tests/functional/test_memlock.py
new file mode 100755
index 0000000000..2b515ff979
--- /dev/null
+++ b/tests/functional/test_memlock.py
@@ -0,0 +1,79 @@
+#!/usr/bin/env python3
+#
+# Functional test that check overcommit memlock options
+#
+# Copyright (c) Yandex Technologies LLC, 2025
+#
+# Author:
+#  Alexandr Moshkov <dtalexundeer@yandex-team.ru>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import re
+
+from typing import Dict
+
+from qemu_test import QemuSystemTest
+from qemu_test import skipLockedMemoryTest
+
+
+STATUS_VALUE_PATTERN = re.compile(r'^(\w+):\s+(\d+) kB', re.MULTILINE)
+
+
+@skipLockedMemoryTest(2_097_152)  # 2GB
+class MemlockTest(QemuSystemTest):
+    """
+    Runs a guest with memlock options.
+    Then verify, that this options is working correctly
+    by checking the status file of the QEMU process.
+    """
+
+    def common_vm_setup_with_memlock(self, memlock):
+        self.vm.add_args('-overcommit', f'mem-lock={memlock}')
+        self.vm.launch()
+
+    def test_memlock_off(self):
+        self.common_vm_setup_with_memlock('off')
+
+        status = self.get_process_status_values(self.vm.get_pid())
+
+        self.assertTrue(status['VmLck'] == 0)
+
+    def test_memlock_on(self):
+        self.common_vm_setup_with_memlock('on')
+
+        status = self.get_process_status_values(self.vm.get_pid())
+
+        # VmLck > 0 kB and almost all memory is resident
+        self.assertTrue(status['VmLck'] > 0)
+        self.assertTrue(status['VmRSS'] >= status['VmSize'] * 0.70)
+
+    def test_memlock_onfault(self):
+        self.common_vm_setup_with_memlock('on-fault')
+
+        status = self.get_process_status_values(self.vm.get_pid())
+
+        # VmLck > 0 kB and only few memory is resident
+        self.assertTrue(status['VmLck'] > 0)
+        self.assertTrue(status['VmRSS'] <= status['VmSize'] * 0.30)
+
+    def get_process_status_values(self, pid: int) -> Dict[str, int]:
+        result = {}
+        raw_status = self._get_raw_process_status(pid)
+
+        for line in raw_status.split('\n'):
+            if m := STATUS_VALUE_PATTERN.match(line):
+                result[m.group(1)] = int(m.group(2))
+
+        return result
+
+    def _get_raw_process_status(self, pid: int) -> str:
+        try:
+            with open(f'/proc/{pid}/status', 'r') as f:
+                return f.read()
+        except FileNotFoundError:
+            self.skipTest("Can't open status file of the process")
+
+
+if __name__ == '__main__':
+    MemlockTest.main()
-- 
2.34.1


