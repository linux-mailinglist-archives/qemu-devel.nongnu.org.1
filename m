Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29437B80959
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Sep 2025 17:32:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyqlO-0008Ou-1r; Wed, 17 Sep 2025 07:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uyql0-0007jr-QD; Wed, 17 Sep 2025 07:55:34 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uyqky-0004dD-7h; Wed, 17 Sep 2025 07:55:29 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id E6AC44DC0C;
 Wed, 17 Sep 2025 13:55:20 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com
Subject: [PATCH v2 5/5] iotests: add test for resizing a 'file' node below a
 'raw' node
Date: Wed, 17 Sep 2025 13:54:52 +0200
Message-ID: <20250917115509.401015-6-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250917115509.401015-1-f.ebner@proxmox.com>
References: <20250917115509.401015-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1758110111538
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

New in v2.

 tests/qemu-iotests/tests/resize-below-raw     | 53 +++++++++++++++++++
 tests/qemu-iotests/tests/resize-below-raw.out |  5 ++
 2 files changed, 58 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/resize-below-raw
 create mode 100644 tests/qemu-iotests/tests/resize-below-raw.out

diff --git a/tests/qemu-iotests/tests/resize-below-raw b/tests/qemu-iotests/tests/resize-below-raw
new file mode 100755
index 0000000000..3c9241c918
--- /dev/null
+++ b/tests/qemu-iotests/tests/resize-below-raw
@@ -0,0 +1,53 @@
+#!/usr/bin/env python3
+# group: rw quick
+#
+# Test what happens when a 'file' node below a 'raw' node is resized.
+#
+# Copyright (C) Proxmox Server Solutions GmbH
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import iotests
+from iotests import imgfmt, qemu_img_create, QMPTestCase
+
+image_size = 1 * 1024 * 1024
+image = os.path.join(iotests.test_dir, 'test.img')
+
+class TestResizeBelowRaw(QMPTestCase):
+    def setUp(self) -> None:
+        qemu_img_create('-f', imgfmt, image, str(image_size))
+
+        self.vm = iotests.VM()
+        self.vm.add_blockdev(self.vm.qmp_to_opts({
+            'driver': imgfmt,
+            'node-name': 'node0',
+            'file': {
+                'driver': 'file',
+                'filename': image,
+                'node-name': 'file0',
+            }
+        }))
+        self.vm.launch()
+
+    def tearDown(self) -> None:
+        self.vm.shutdown()
+        os.remove(image)
+
+    def assert_size(self, size: int) -> None:
+        nodes = self.vm.qmp('query-named-block-nodes', flat=True)['return']
+        self.assertEqual(len(nodes), 2)
+        for node in nodes:
+            if node['drv'] == 'file':
+                continue
+            self.assertEqual(node['image']['virtual-size'], size)
+
+    def test_resize_below_raw(self) -> None:
+        self.assert_size(image_size)
+        self.vm.qmp('block_resize', node_name='file0', size=2*image_size)
+        self.assert_size(2*image_size)
+        self.vm.qmp('block_resize', node_name='node0', size=3*image_size)
+        self.assert_size(3*image_size)
+
+if __name__ == '__main__':
+    iotests.main(supported_fmts=['raw'], supported_protocols=['file'])
diff --git a/tests/qemu-iotests/tests/resize-below-raw.out b/tests/qemu-iotests/tests/resize-below-raw.out
new file mode 100644
index 0000000000..ae1213e6f8
--- /dev/null
+++ b/tests/qemu-iotests/tests/resize-below-raw.out
@@ -0,0 +1,5 @@
+.
+----------------------------------------------------------------------
+Ran 1 tests
+
+OK
-- 
2.47.2



