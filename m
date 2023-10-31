Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1B77DCE62
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 14:57:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpEf-0001I3-NG; Tue, 31 Oct 2023 09:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qxpE5-0000XC-Kd; Tue, 31 Oct 2023 09:56:16 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qxpE0-0000qO-Tr; Tue, 31 Oct 2023 09:56:11 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 72CFE42A5D;
 Tue, 31 Oct 2023 14:55:52 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, den@virtuozzo.com, t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com
Subject: [PATCH v4 10/10] iotests: add test for changing mirror's copy_mode
Date: Tue, 31 Oct 2023 14:54:31 +0100
Message-Id: <20231031135431.393137-11-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031135431.393137-1-f.ebner@proxmox.com>
References: <20231031135431.393137-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

One part of the test is using a throttled source to ensure that there
are no obvious issues when changing the copy_mode while there are
ongoing requests (source and target images are compared at the very
end).

The other part of the test is using a throttled target to ensure that
the change to active mode actually happened. This is done by hitting
the throttling limit, issuing a synchronous write and then immediately
verifying the target side. QSD is used, because otherwise, a
synchronous write would hang there.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

New in v4.

 .../tests/mirror-change-copy-mode             | 192 ++++++++++++++++++
 .../tests/mirror-change-copy-mode.out         |   5 +
 2 files changed, 197 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/mirror-change-copy-mode
 create mode 100644 tests/qemu-iotests/tests/mirror-change-copy-mode.out

diff --git a/tests/qemu-iotests/tests/mirror-change-copy-mode b/tests/qemu-iotests/tests/mirror-change-copy-mode
new file mode 100755
index 0000000000..e9fef8c5e9
--- /dev/null
+++ b/tests/qemu-iotests/tests/mirror-change-copy-mode
@@ -0,0 +1,192 @@
+#!/usr/bin/env python3
+# group: rw
+#
+# Test for changing mirror copy mode from background to active
+#
+# Copyright (C) 2023 Proxmox Server Solutions GmbH
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
+import time
+
+import iotests
+from iotests import qemu_img, qemu_io, QemuStorageDaemon
+
+iops_target = 8
+iops_source = iops_target * 2
+image_size = 1 * 1024 * 1024
+source_img = os.path.join(iotests.test_dir, 'source.' + iotests.imgfmt)
+target_img = os.path.join(iotests.test_dir, 'target.' + iotests.imgfmt)
+nbd_sock = os.path.join(iotests.sock_dir, 'nbd.sock')
+
+class TestMirrorChangeCopyMode(iotests.QMPTestCase):
+
+    def setUp(self):
+        qemu_img('create', '-f', iotests.imgfmt, source_img, str(image_size))
+        qemu_img('create', '-f', iotests.imgfmt, target_img, str(image_size))
+
+        self.qsd = QemuStorageDaemon('--nbd-server',
+                                     f'addr.type=unix,addr.path={nbd_sock}',
+                                     qmp=True)
+
+        self.qsd.cmd('object-add', {
+            'qom-type': 'throttle-group',
+            'id': 'thrgr-target',
+            'limits': {
+                'iops-write': iops_target,
+                'iops-write-max': iops_target
+            }
+        })
+
+        self.qsd.cmd('blockdev-add', {
+            'node-name': 'target',
+            'driver': 'throttle',
+            'throttle-group': 'thrgr-target',
+            'file': {
+                'driver': iotests.imgfmt,
+                'file': {
+                    'driver': 'file',
+                    'filename': target_img
+                }
+            }
+        })
+
+        self.qsd.cmd('block-export-add', {
+            'id': 'exp0',
+            'type': 'nbd',
+            'node-name': 'target',
+            'writable': True
+        })
+
+        self.vm = iotests.VM()
+        self.vm.add_args('-drive',
+                         f'file={source_img},if=none,format={iotests.imgfmt},' +
+                         f'iops_wr={iops_source},' +
+                         f'iops_wr_max={iops_source},' +
+                         'id=source')
+        self.vm.launch()
+
+        self.vm.cmd('blockdev-add', {
+            'node-name': 'target',
+            'driver': 'nbd',
+            'export': 'target',
+            'server': {
+                'type': 'unix',
+                'path': nbd_sock
+            }
+        })
+
+
+    def tearDown(self):
+        self.vm.shutdown()
+        self.qsd.stop()
+        self.check_qemu_io_errors()
+        self.check_images_identical()
+        os.remove(source_img)
+        os.remove(target_img)
+
+    # Once the VM is shut down we can parse the log and see if qemu-io ran
+    # without errors.
+    def check_qemu_io_errors(self):
+        self.assertFalse(self.vm.is_running())
+        log = self.vm.get_log()
+        for line in log.split("\n"):
+            assert not line.startswith("Pattern verification failed")
+
+    def check_images_identical(self):
+        qemu_img('compare', '-f', iotests.imgfmt, source_img, target_img)
+
+    def start_mirror(self):
+        self.vm.cmd('blockdev-mirror',
+                    job_id='mirror',
+                    device='source',
+                    target='target',
+                    filter_node_name='mirror-top',
+                    sync='full',
+                    copy_mode='background')
+
+    def test_background_to_active(self):
+        self.vm.hmp_qemu_io('source', f'write 0 {image_size}')
+        self.vm.hmp_qemu_io('target', f'write 0 {image_size}')
+
+        self.start_mirror()
+
+        result = self.vm.cmd('query-block-jobs')
+        assert not result[0]['actively-synced']
+
+        self.vm.event_wait('BLOCK_JOB_READY')
+
+        result = self.vm.cmd('query-block-jobs')
+        assert not result[0]['actively-synced']
+
+        # Start some background requests.
+        reqs = 4 * iops_source
+        req_size = image_size // reqs
+        for i in range(0, reqs):
+            req = f'aio_write -P 7 {req_size * i} {req_size}'
+            self.vm.hmp_qemu_io('source', req)
+
+        # Wait for the first few requests.
+        time.sleep(1)
+        self.vm.qtest(f'clock_step {1 * 1000 * 1000 * 1000}')
+
+        result = self.vm.cmd('query-block-jobs')
+        # There should've been new requests.
+        assert result[0]['len'] > image_size
+        # To verify later that not all requests were completed at this point.
+        len_before_change = result[0]['len']
+
+        # Change the copy mode while requests are happening.
+        self.vm.cmd('block-job-change',
+                    id='mirror',
+                    type='mirror',
+                    copy_mode='write-blocking')
+
+        # Wait until image is actively synced.
+        while True:
+            time.sleep(0.1)
+            self.vm.qtest(f'clock_step {100 * 1000 * 1000}')
+            result = self.vm.cmd('query-block-jobs')
+            if result[0]['actively-synced']:
+                break
+
+        # Because of throttling, not all request should've been completed above.
+        result = self.vm.cmd('query-block-jobs')
+        assert result[0]['len'] > len_before_change
+
+        # Issue enough requests for a few seconds only touching the first half
+        # of the image.
+        reqs = 4 * iops_target
+        req_size = image_size // 2 // reqs
+        for i in range(0, reqs):
+            req = f'aio_write -P 19 {req_size * i} {req_size}'
+            self.vm.hmp_qemu_io('source', req)
+
+        # Now issue a synchronous write in the second half of the image and
+        # immediately verify that it was written to the target too. This would
+        # fail without switching the copy mode. Note that this only produces a
+        # log line and the actual checking happens during tearDown().
+        req_args = f'-P 37 {3 * (image_size // 4)} {req_size}'
+        self.vm.hmp_qemu_io('source', f'write {req_args}')
+        self.vm.hmp_qemu_io('target', f'read {req_args}')
+
+        self.vm.cmd('block-job-cancel', device='mirror')
+        while len(self.vm.cmd('query-block-jobs')) > 0:
+            time.sleep(0.1)
+
+if __name__ == '__main__':
+    iotests.main(supported_fmts=['qcow2', 'raw'],
+                 supported_protocols=['file'])
diff --git a/tests/qemu-iotests/tests/mirror-change-copy-mode.out b/tests/qemu-iotests/tests/mirror-change-copy-mode.out
new file mode 100644
index 0000000000..ae1213e6f8
--- /dev/null
+++ b/tests/qemu-iotests/tests/mirror-change-copy-mode.out
@@ -0,0 +1,5 @@
+.
+----------------------------------------------------------------------
+Ran 1 tests
+
+OK
-- 
2.39.2



