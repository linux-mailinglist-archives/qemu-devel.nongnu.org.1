Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDC9ABD51D
	for <lists+qemu-devel@lfdr.de>; Tue, 20 May 2025 12:35:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKGt-0003FD-6h; Tue, 20 May 2025 06:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uHKFJ-0008Kn-V6; Tue, 20 May 2025 06:30:54 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uHKFG-00053v-Aj; Tue, 20 May 2025 06:30:53 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 3113143958;
 Tue, 20 May 2025 12:30:24 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: [PATCH v2 21/24] iotests/graph-changes-while-io: add test case with
 removal of lower snapshot
Date: Tue, 20 May 2025 12:30:09 +0200
Message-Id: <20250520103012.424311-22-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250520103012.424311-1-f.ebner@proxmox.com>
References: <20250520103012.424311-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

This case is catching potential deadlock which takes place when job-dismiss
is issued when I/O requests are processed in a separate iothread.

See https://mail.gnu.org/archive/html/qemu-devel/2025-04/msg04421.html

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
[FE: re-use top image and rename snap1->mid as suggested by Kevin Wolf
     remove image file after test as suggested by Kevin Wolf
     add type annotation for function argument to make mypy happy]
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Changes in v2:
* Re-use 'top' image, rename other image to 'mid'.
* Remove image after test.
* Add type annotation for function argument for mypy.

 .../qemu-iotests/tests/graph-changes-while-io | 101 ++++++++++++++++--
 .../tests/graph-changes-while-io.out          |   4 +-
 2 files changed, 96 insertions(+), 9 deletions(-)

diff --git a/tests/qemu-iotests/tests/graph-changes-while-io b/tests/qemu-iotests/tests/graph-changes-while-io
index 35489e3b5e..dca1167b6d 100755
--- a/tests/qemu-iotests/tests/graph-changes-while-io
+++ b/tests/qemu-iotests/tests/graph-changes-while-io
@@ -27,6 +27,7 @@ from iotests import imgfmt, qemu_img, qemu_img_create, qemu_io, \
 
 
 top = os.path.join(iotests.test_dir, 'top.img')
+mid = os.path.join(iotests.test_dir, 'mid.img')
 nbd_sock = os.path.join(iotests.sock_dir, 'nbd.sock')
 
 
@@ -59,6 +60,15 @@ class TestGraphChangesWhileIO(QMPTestCase):
         self.qsd.stop()
         os.remove(top)
 
+    def _wait_for_blockjob(self, status: str) -> None:
+        done = False
+        while not done:
+            for event in self.qsd.get_qmp().get_events(wait=10.0):
+                if event['event'] != 'JOB_STATUS_CHANGE':
+                    continue
+                if event['data']['status'] == status:
+                    done = True
+
     def test_blockdev_add_while_io(self) -> None:
         # Run qemu-img bench in the background
         bench_thr = Thread(target=do_qemu_img_bench)
@@ -117,16 +127,93 @@ class TestGraphChangesWhileIO(QMPTestCase):
                 'device': 'job0',
             })
 
-            cancelled = False
-            while not cancelled:
-                for event in self.qsd.get_qmp().get_events(wait=10.0):
-                    if event['event'] != 'JOB_STATUS_CHANGE':
-                        continue
-                    if event['data']['status'] == 'null':
-                        cancelled = True
+            self._wait_for_blockjob('null')
 
         bench_thr.join()
 
+    def test_remove_lower_snapshot_while_io(self) -> None:
+        # Run qemu-img bench in the background
+        bench_thr = Thread(target=do_qemu_img_bench, args=(100000, ))
+        bench_thr.start()
+
+        # While I/O is performed on 'node0' node, consequently add 2 snapshots
+        # on top of it, then remove (commit) them starting from lower one.
+        while bench_thr.is_alive():
+            # Recreate snapshot images on every iteration
+            qemu_img_create('-f', imgfmt, mid, '1G')
+            qemu_img_create('-f', imgfmt, top, '1G')
+
+            self.qsd.cmd('blockdev-add', {
+                'driver': imgfmt,
+                'node-name': 'mid',
+                'file': {
+                    'driver': 'file',
+                    'filename': mid
+                }
+            })
+
+            self.qsd.cmd('blockdev-snapshot', {
+                'node': 'node0',
+                'overlay': 'mid',
+            })
+
+            self.qsd.cmd('blockdev-add', {
+                'driver': imgfmt,
+                'node-name': 'top',
+                'file': {
+                    'driver': 'file',
+                    'filename': top
+                }
+            })
+
+            self.qsd.cmd('blockdev-snapshot', {
+                'node': 'mid',
+                'overlay': 'top',
+            })
+
+            self.qsd.cmd('block-commit', {
+                'job-id': 'commit-mid',
+                'device': 'top',
+                'top-node': 'mid',
+                'base-node': 'node0',
+                'auto-finalize': True,
+                'auto-dismiss': False,
+            })
+
+            self._wait_for_blockjob('concluded')
+            self.qsd.cmd('job-dismiss', {
+                'id': 'commit-mid',
+            })
+
+            self.qsd.cmd('block-commit', {
+                'job-id': 'commit-top',
+                'device': 'top',
+                'top-node': 'top',
+                'base-node': 'node0',
+                'auto-finalize': True,
+                'auto-dismiss': False,
+            })
+
+            self._wait_for_blockjob('ready')
+            self.qsd.cmd('job-complete', {
+                'id': 'commit-top',
+            })
+
+            self._wait_for_blockjob('concluded')
+            self.qsd.cmd('job-dismiss', {
+                'id': 'commit-top',
+            })
+
+            self.qsd.cmd('blockdev-del', {
+                'node-name': 'mid'
+            })
+            self.qsd.cmd('blockdev-del', {
+                'node-name': 'top'
+            })
+
+        bench_thr.join()
+        os.remove(mid)
+
 if __name__ == '__main__':
     # Format must support raw backing files
     iotests.main(supported_fmts=['qcow', 'qcow2', 'qed'],
diff --git a/tests/qemu-iotests/tests/graph-changes-while-io.out b/tests/qemu-iotests/tests/graph-changes-while-io.out
index fbc63e62f8..8d7e996700 100644
--- a/tests/qemu-iotests/tests/graph-changes-while-io.out
+++ b/tests/qemu-iotests/tests/graph-changes-while-io.out
@@ -1,5 +1,5 @@
-..
+...
 ----------------------------------------------------------------------
-Ran 2 tests
+Ran 3 tests
 
 OK
-- 
2.39.5



