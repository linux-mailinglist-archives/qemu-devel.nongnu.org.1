Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 595E6AA1057
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Apr 2025 17:22:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9mmp-0002oX-2n; Tue, 29 Apr 2025 11:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u9mmg-0002ns-SZ
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:22:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u9mme-00049K-H7
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745940127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K/F9KKI5Ly37ogAkhfAEuNfmZg6YFwY9rqdP2aeDEtI=;
 b=Pm5g54pdZAj/+ZckpjhQTFEU9L4PvIow55HpcToUf/wc2OgASfjQq9FOXoIjovMxFAvVF7
 5ELLEUHZ8X7zptH5LVu4sd6Ms249yV721cGfQLuGalKGjCDabakvUeqZFZ+c1y3ju0PjRV
 105rY+5cC5ufl/eOnCULKQEO5IS7XeU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-ultpsPSbNI-vxHWSfwegZA-1; Tue,
 29 Apr 2025 11:22:04 -0400
X-MC-Unique: ultpsPSbNI-vxHWSfwegZA-1
X-Mimecast-MFC-AGG-ID: ultpsPSbNI-vxHWSfwegZA_1745940123
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C6DC180048E; Tue, 29 Apr 2025 15:22:03 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.241])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9EA7A1800DA0; Tue, 29 Apr 2025 15:22:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH 4/4] tests/functional: Test with
 scripts/vmstate-static-checker.py
Date: Tue, 29 Apr 2025 17:21:41 +0200
Message-ID: <20250429152141.294380-5-thuth@redhat.com>
In-Reply-To: <20250429152141.294380-1-thuth@redhat.com>
References: <20250429152141.294380-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
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

We've got this nice vmstate-static-checker.py script that can help
to detect screw-ups in the migration states. Unfortunately, it's
currently only run manually, so there could be regressions that nobody
notices immediately. Let's run it from a functional test automatically
so that we got at least a basic coverage in each CI run.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                      |  1 +
 tests/functional/meson.build     | 13 +++++++-
 tests/functional/test_vmstate.py | 56 ++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 1 deletion(-)
 create mode 100755 tests/functional/test_vmstate.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 65fb61844b3..6a8d81458ad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3525,6 +3525,7 @@ F: migration/
 F: scripts/vmstate-static-checker.py
 F: tests/data/vmstate-static-checker/
 F: tests/functional/test_migration.py
+F: tests/functional/test_vmstate.py
 F: tests/qtest/migration/
 F: tests/qtest/migration-*
 F: docs/devel/migration/
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index b317ad42c5a..9f339e626f6 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -76,6 +76,7 @@ tests_generic_bsduser = [
 
 tests_aarch64_system_quick = [
   'migration',
+  'vmstate',
 ]
 
 tests_aarch64_system_thorough = [
@@ -164,6 +165,10 @@ tests_loongarch64_system_thorough = [
   'loongarch64_virt',
 ]
 
+tests_m68k_system_quick = [
+  'vmstate',
+]
+
 tests_m68k_system_thorough = [
   'm68k_mcf5208evb',
   'm68k_nextcube',
@@ -230,6 +235,7 @@ tests_ppc_system_thorough = [
 
 tests_ppc64_system_quick = [
   'migration',
+  'vmstate',
 ]
 
 tests_ppc64_system_thorough = [
@@ -265,6 +271,10 @@ tests_rx_system_thorough = [
   'rx_gdbsim',
 ]
 
+tests_s390x_system_quick = [
+  'vmstate',
+]
+
 tests_s390x_system_thorough = [
   's390x_ccw_virtio',
   's390x_replay',
@@ -305,8 +315,9 @@ tests_x86_64_system_quick = [
   'migration',
   'pc_cpu_hotplug_props',
   'virtio_version',
-  'x86_cpu_model_versions',
+  'vmstate',
   'vnc',
+  'x86_cpu_model_versions',
 ]
 
 tests_x86_64_system_thorough = [
diff --git a/tests/functional/test_vmstate.py b/tests/functional/test_vmstate.py
new file mode 100755
index 00000000000..3ba56d580db
--- /dev/null
+++ b/tests/functional/test_vmstate.py
@@ -0,0 +1,56 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# This test runs the vmstate-static-checker script with the current QEMU
+
+import subprocess
+
+from qemu_test import QemuSystemTest
+
+
+class VmStateTest(QemuSystemTest):
+
+    def test_vmstate(self):
+        target_machine = {
+            'aarch64': 'virt-7.2',
+            'm68k': 'virt-7.2',
+            'ppc64': 'pseries-7.2',
+            's390x': 's390-ccw-virtio-7.2',
+            'x86_64': 'pc-q35-7.2',
+        }
+        self.set_machine(target_machine[self.arch])
+
+        # Run QEMU to get the current vmstate json file:
+        dst_json = self.scratch_file('dest.json')
+        self.log.info('Dumping vmstate from ' + self.qemu_bin)
+        cp = subprocess.run([self.qemu_bin, '-nodefaults',
+                             '-M', target_machine[self.arch],
+                             '-dump-vmstate', dst_json],
+                            stdout=subprocess.PIPE,
+                            stderr=subprocess.STDOUT,
+                            text=True)
+        if cp.returncode != 0:
+            self.fail('Running QEMU failed:\n' + cp.stdout)
+        if cp.stdout:
+            self.log.info('QEMU output: ' + cp.stdout)
+
+        # Check whether the old vmstate json file is still compatible:
+        src_json = self.data_file('..', 'data', 'vmstate-static-checker',
+                                  self.arch,
+                                  target_machine[self.arch] + '.json')
+        vmstate_checker = self.data_file('..', '..', 'scripts',
+                                         'vmstate-static-checker.py')
+        self.log.info('Comparing vmstate with ' + src_json)
+        cp = subprocess.run([vmstate_checker, '-s', src_json, '-d', dst_json],
+                            stdout=subprocess.PIPE,
+                            stderr=subprocess.STDOUT,
+                            text=True)
+        if cp.returncode != 0:
+            self.fail('Running vmstate-static-checker failed:\n' + cp.stdout)
+        if cp.stdout:
+            self.log.warning('vmstate-static-checker output: ' + cp.stdout)
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.49.0


