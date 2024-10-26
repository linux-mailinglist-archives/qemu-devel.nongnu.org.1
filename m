Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 786AC9B19CB
	for <lists+qemu-devel@lfdr.de>; Sat, 26 Oct 2024 18:32:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4jhC-0007xJ-Jz; Sat, 26 Oct 2024 12:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <libvirt-e6954efa@volkihar.be>)
 id 1t4jgj-0007si-S0; Sat, 26 Oct 2024 12:31:01 -0400
Received: from icts-p-cavuit-3.kulnet.kuleuven.be ([2a02:2c40:0:c0::25:133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <libvirt-e6954efa@volkihar.be>)
 id 1t4jge-0003c4-CN; Sat, 26 Oct 2024 12:30:53 -0400
X-KULeuven-Envelope-From: libvirt-e6954efa@volkihar.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 315BA200BC.ADDE3
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be
 (icts-p-ceifnet-smtps.service.icts.svcd
 [IPv6:2a02:2c40:0:51:135:242:ac11:35])
 by icts-p-cavuit-3.kulnet.kuleuven.be (Postfix) with ESMTP id 315BA200BC;
 Sat, 26 Oct 2024 18:30:38 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: 
X-CAV-Cluster: smtps
Received: from flutterbat.volkihar.be (236.58-240-81.adsl-dyn.isp.belgacom.be
 [81.240.58.236])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id 0E73ED4F2584F; 
 Sat, 26 Oct 2024 18:30:38 +0200 (CEST)
Received: by flutterbat.volkihar.be (Postfix, from userid 1000)
 id C703B4B91F2; Sat, 26 Oct 2024 18:30:37 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>,
 Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
Subject: [PATCH v4 5/5] block: add test non-active commit with zeroed data
Date: Sat, 26 Oct 2024 18:30:09 +0200
Message-ID: <20241026163010.2865002-6-libvirt-e6954efa@volkihar.be>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20241026163010.2865002-1-libvirt-e6954efa@volkihar.be>
References: <20241026163010.2865002-1-libvirt-e6954efa@volkihar.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:2c40:0:c0::25:133;
 envelope-from=libvirt-e6954efa@volkihar.be;
 helo=icts-p-cavuit-3.kulnet.kuleuven.be
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 tests/qemu-iotests/tests/commit-zero-blocks   | 96 +++++++++++++++++++
 .../qemu-iotests/tests/commit-zero-blocks.out | 54 +++++++++++
 2 files changed, 150 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/commit-zero-blocks
 create mode 100644 tests/qemu-iotests/tests/commit-zero-blocks.out

diff --git a/tests/qemu-iotests/tests/commit-zero-blocks b/tests/qemu-iotests/tests/commit-zero-blocks
new file mode 100755
index 0000000000..de00273e72
--- /dev/null
+++ b/tests/qemu-iotests/tests/commit-zero-blocks
@@ -0,0 +1,96 @@
+#!/usr/bin/env bash
+# group: rw quick
+#
+# Test for commit of discarded blocks
+#
+# This tests committing a live snapshot where some of the blocks that
+# are present in the base image are discarded in the intermediate image.
+# This intends to check that these blocks are also discarded in the base
+# image after the commit.
+#
+# Copyright (C) 2024 Vincent Vanlaer.
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
+# creator
+owner=libvirt-e6954efa@volkihar.be
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+
+_cleanup()
+{
+    _cleanup_qemu
+    _rm_test_img "${TEST_IMG}.base"
+    _rm_test_img "${TEST_IMG}.mid"
+    _cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+cd ..
+. ./common.rc
+. ./common.filter
+. ./common.qemu
+
+_supported_fmt qcow2
+_supported_proto file
+
+size="1M"
+
+TEST_IMG="$TEST_IMG.base" _make_test_img $size
+TEST_IMG="$TEST_IMG.mid" _make_test_img -b "$TEST_IMG.base" -F $IMGFMT $size
+_make_test_img -b "${TEST_IMG}.mid" -F $IMGFMT $size
+
+$QEMU_IO -c "write -P 0x01 64k 128k" "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IO -c "discard 64k 64k" "$TEST_IMG.mid" | _filter_qemu_io
+
+echo
+echo "=== Base image info before commit ==="
+TEST_IMG="${TEST_IMG}.base" _img_info | _filter_img_info
+$QEMU_IMG map --output=json "$TEST_IMG.base" | _filter_qemu_img_map
+
+echo
+echo "=== Middle image info before commit ==="
+TEST_IMG="${TEST_IMG}.mid" _img_info | _filter_img_info
+$QEMU_IMG map --output=json "$TEST_IMG.mid" | _filter_qemu_img_map
+
+echo
+echo === Running QEMU Live Commit Test ===
+echo
+
+qemu_comm_method="qmp"
+_launch_qemu -drive file="${TEST_IMG}",if=virtio,id=test
+h=$QEMU_HANDLE
+
+_send_qemu_cmd $h "{ 'execute': 'qmp_capabilities' }" "return"
+
+_send_qemu_cmd $h "{ 'execute': 'block-commit',
+                                 'arguments': { 'device': 'test',
+                                 'top': '"${TEST_IMG}.mid"',
+                                 'base': '"${TEST_IMG}.base"'} }" '"status": "null"'
+
+_cleanup_qemu
+
+echo
+echo "=== Base image info after commit ==="
+TEST_IMG="${TEST_IMG}.base" _img_info | _filter_img_info
+$QEMU_IMG map --output=json "$TEST_IMG.base" | _filter_qemu_img_map
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/tests/commit-zero-blocks.out b/tests/qemu-iotests/tests/commit-zero-blocks.out
new file mode 100644
index 0000000000..85bdc46aaf
--- /dev/null
+++ b/tests/qemu-iotests/tests/commit-zero-blocks.out
@@ -0,0 +1,54 @@
+QA output created by commit-zero-blocks
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=1048576
+Formatting 'TEST_DIR/t.IMGFMT.mid', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.mid backing_fmt=IMGFMT
+wrote 131072/131072 bytes at offset 65536
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+discard 65536/65536 bytes at offset 65536
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== Base image info before commit ===
+image: TEST_DIR/t.IMGFMT.base
+file format: IMGFMT
+virtual size: 1 MiB (1048576 bytes)
+[{ "start": 0, "length": 65536, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 65536, "length": 131072, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 196608, "length": 851968, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]
+
+=== Middle image info before commit ===
+image: TEST_DIR/t.IMGFMT.mid
+file format: IMGFMT
+virtual size: 1 MiB (1048576 bytes)
+backing file: TEST_DIR/t.IMGFMT.base
+backing file format: IMGFMT
+[{ "start": 0, "length": 65536, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 65536, "length": 65536, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 131072, "length": 65536, "depth": 1, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 196608, "length": 851968, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false}]
+
+=== Running QEMU Live Commit Test ===
+
+{ 'execute': 'qmp_capabilities' }
+{"return": {}}
+{ 'execute': 'block-commit',
+                                 'arguments': { 'device': 'test',
+                                 'top': 'TEST_DIR/t.IMGFMT.mid',
+                                 'base': 'TEST_DIR/t.IMGFMT.base'} }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "test"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "test"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "test"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "test"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "test", "len": 1048576, "offset": 1048576, "speed": 0, "type": "commit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "test"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "test"}}
+
+=== Base image info after commit ===
+image: TEST_DIR/t.IMGFMT.base
+file format: IMGFMT
+virtual size: 1 MiB (1048576 bytes)
+[{ "start": 0, "length": 65536, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 65536, "length": 65536, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 131072, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 196608, "length": 851968, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]
+*** done
-- 
2.44.1


