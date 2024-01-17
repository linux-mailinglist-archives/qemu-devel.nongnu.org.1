Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FE6830A70
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 17:08:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ8Sa-0006m5-6v; Wed, 17 Jan 2024 11:08:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rQ8SO-0006UG-4U; Wed, 17 Jan 2024 11:08:00 -0500
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rQ8SI-0000Go-S4; Wed, 17 Jan 2024 11:07:59 -0500
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:62a3:0:640:1524:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 8FD8C622AB;
 Wed, 17 Jan 2024 19:07:51 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b43a::1:2b])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id c7sSt20Ih8c0-hTGHKQFL; Wed, 17 Jan 2024 19:07:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1705507670;
 bh=liPz+eyj6yyjB8pLBgydYqfPcqmYRyAOSKFDJlxHpYk=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=LaLyur0uLBckw262QUg000flqp/aFECAYzxFqQMTtsATTYsK15Apij2jqJtx4+zSm
 cHggAqWHRw4sLepXX5fxvNyI0mJOe0eovYfkYqI47RlneAW16QFy1HUDl9IvWwBbrl
 c5VGJed5Lcrms3cKkeXql/f+u3+nci1+lX4SUC8Y=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, hreitz@redhat.com,
 kwolf@redhat.com, vsementsov@yandex-team.ru, jsnow@redhat.com,
 f.ebner@proxmox.com
Subject: [PATCH v2 4/4] iotests: add backup-discard-source
Date: Wed, 17 Jan 2024 19:07:37 +0300
Message-Id: <20240117160737.1057513-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117160737.1057513-1-vsementsov@yandex-team.ru>
References: <20240117160737.1057513-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add test for a new backup option: discard-source.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 .../qemu-iotests/tests/backup-discard-source  | 151 ++++++++++++++++++
 .../tests/backup-discard-source.out           |   5 +
 2 files changed, 156 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/backup-discard-source
 create mode 100644 tests/qemu-iotests/tests/backup-discard-source.out

diff --git a/tests/qemu-iotests/tests/backup-discard-source b/tests/qemu-iotests/tests/backup-discard-source
new file mode 100755
index 0000000000..8a88b0f6c4
--- /dev/null
+++ b/tests/qemu-iotests/tests/backup-discard-source
@@ -0,0 +1,151 @@
+#!/usr/bin/env python3
+#
+# Test removing persistent bitmap from backing
+#
+# Copyright (c) 2022 Virtuozzo International GmbH.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+import os
+
+import iotests
+from iotests import qemu_img_create, qemu_img_map, qemu_io
+
+
+temp_img = os.path.join(iotests.test_dir, 'temp')
+source_img = os.path.join(iotests.test_dir, 'source')
+target_img = os.path.join(iotests.test_dir, 'target')
+size = '1M'
+
+
+def get_actual_size(vm, node_name):
+    nodes = vm.cmd('query-named-block-nodes', flat=True)
+    node = next(n for n in nodes if n['node-name'] == node_name)
+    return node['image']['actual-size']
+
+
+class TestBackup(iotests.QMPTestCase):
+    def setUp(self):
+        qemu_img_create('-f', iotests.imgfmt, source_img, size)
+        qemu_img_create('-f', iotests.imgfmt, temp_img, size)
+        qemu_img_create('-f', iotests.imgfmt, target_img, size)
+        qemu_io('-c', 'write 0 1M', source_img)
+
+        self.vm = iotests.VM()
+        self.vm.launch()
+
+        self.vm.cmd('blockdev-add', {
+            'node-name': 'cbw',
+            'driver': 'copy-before-write',
+            'file': {
+                'driver': iotests.imgfmt,
+                'file': {
+                    'driver': 'file',
+                    'filename': source_img,
+                }
+            },
+            'target': {
+                'driver': iotests.imgfmt,
+                'discard': 'unmap',
+                'node-name': 'temp',
+                'file': {
+                    'driver': 'file',
+                    'filename': temp_img
+                }
+            }
+        })
+
+        self.vm.cmd('blockdev-add', {
+            'node-name': 'access',
+            'discard': 'unmap',
+            'driver': 'snapshot-access',
+            'file': 'cbw'
+        })
+
+        self.vm.cmd('blockdev-add', {
+            'driver': iotests.imgfmt,
+            'node-name': 'target',
+            'file': {
+                'driver': 'file',
+                'filename': target_img
+            }
+        })
+
+        self.assertLess(get_actual_size(self.vm, 'temp'), 512 * 1024)
+
+    def tearDown(self):
+        # That should fail, because region is discarded
+        self.vm.hmp_qemu_io('access', 'read 0 1M')
+
+        self.vm.shutdown()
+
+        self.assertTrue('read failed: Permission denied' in self.vm.get_log())
+
+        # Final check that temp image is empty
+        mapping = qemu_img_map(temp_img)
+        self.assertEqual(len(mapping), 1)
+        self.assertEqual(mapping[0]['start'], 0)
+        self.assertEqual(mapping[0]['length'], 1024 * 1024)
+        self.assertEqual(mapping[0]['data'], False)
+
+        os.remove(temp_img)
+        os.remove(source_img)
+        os.remove(target_img)
+
+    def do_backup(self):
+        self.vm.cmd('blockdev-backup', device='access',
+                    sync='full', target='target',
+                    job_id='backup0',
+                    discard_source=True)
+
+        self.vm.event_wait(name='BLOCK_JOB_COMPLETED')
+
+    def test_discard_written(self):
+        """
+        1. Guest writes
+        2. copy-before-write operation, data is stored to temp
+        3. start backup(discard_source=True), check that data is
+           removed from temp
+        """
+        # Trigger copy-before-write operation
+        result = self.vm.hmp_qemu_io('cbw', 'write 0 1M')
+        self.assert_qmp(result, 'return', '')
+
+        # Check that data is written to temporary image
+        self.assertGreater(get_actual_size(self.vm, 'temp'), 1024 * 1024)
+
+        self.do_backup()
+
+    def test_discard_cbw(self):
+        """
+        1. do backup(discard_source=True), which should inform
+           copy-before-write that data is not needed anymore
+        2. Guest writes
+        3. Check that copy-before-write operation is not done
+        """
+        self.do_backup()
+
+        # Try trigger copy-before-write operation
+        result = self.vm.hmp_qemu_io('cbw', 'write 0 1M')
+        self.assert_qmp(result, 'return', '')
+
+        # Check that data is not written to temporary image, as region
+        # is discarded from copy-before-write process
+        self.assertLess(get_actual_size(self.vm, 'temp'), 512 * 1024)
+
+
+if __name__ == '__main__':
+    iotests.main(supported_fmts=['qcow2'],
+                 supported_protocols=['file'])
diff --git a/tests/qemu-iotests/tests/backup-discard-source.out b/tests/qemu-iotests/tests/backup-discard-source.out
new file mode 100644
index 0000000000..fbc63e62f8
--- /dev/null
+++ b/tests/qemu-iotests/tests/backup-discard-source.out
@@ -0,0 +1,5 @@
+..
+----------------------------------------------------------------------
+Ran 2 tests
+
+OK
-- 
2.34.1


