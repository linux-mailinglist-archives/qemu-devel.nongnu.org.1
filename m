Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 611FF71F2E8
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 21:30:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4nye-0006jx-Ci; Thu, 01 Jun 2023 15:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1q4nyX-0006jU-UL; Thu, 01 Jun 2023 15:28:45 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1q4nyV-0005mA-Bd; Thu, 01 Jun 2023 15:28:45 -0400
Received: from dev005.ch-qa.vzint.dev ([172.29.1.10])
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1q4nyC-00DLDg-1O;
 Thu, 01 Jun 2023 21:28:37 +0200
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH 6/6] iotests: add test 314 for "qemu-img rebase" with
 compression
Date: Thu,  1 Jun 2023 22:28:36 +0300
Message-Id: <20230601192836.598602-7-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230601192836.598602-1-andrey.drobyshev@virtuozzo.com>
References: <20230601192836.598602-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
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
Reply-to:  Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
From:  Andrey Drobyshev via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

The test cases considered so far:

1. Check that compression mode isn't compatible with "-f raw" (raw
   format doesn't support compression).
2. Check that rebasing an image onto no backing file preserves the data
   and writes the copied clusters actually compressed.
3. Same as 2, but with a raw backing file (i.e. the clusters copied from the
   backing are originally uncompressed -- we check they end up compressed
   after being merged).
4. Remove a single delta from a backing chain, perform the same checks
   as in 2.
5. Check that even when backing and overlay are initially uncompressed,
   copied clusters end up compressed when rebase with compression is
   performed.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qemu-iotests/314     | 165 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/314.out |  75 +++++++++++++++++
 2 files changed, 240 insertions(+)
 create mode 100755 tests/qemu-iotests/314
 create mode 100644 tests/qemu-iotests/314.out

diff --git a/tests/qemu-iotests/314 b/tests/qemu-iotests/314
new file mode 100755
index 0000000000..96d7b4d258
--- /dev/null
+++ b/tests/qemu-iotests/314
@@ -0,0 +1,165 @@
+#!/usr/bin/env bash
+# group: rw backing auto quick
+#
+# Test qemu-img rebase with compression
+#
+# Copyright (c) 2023 Virtuozzo International GmbH.
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
+# creator
+owner=andrey.drobyshev@virtuozzo.com
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+    _rm_test_img "$TEST_IMG.base"
+    _rm_test_img "$TEST_IMG.itmd"
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+
+# Want the size divisible by 2 and 3
+size=$(( 48 * 1024 * 1024 ))
+half_size=$(( size / 2 ))
+third_size=$(( size / 3 ))
+
+# 1. "qemu-img rebase -c" should refuse working with any format which doesn't
+# support compression.  We only check "-f raw" here.
+echo
+echo "=== Testing compressed rebase format compatibility ==="
+echo
+
+$QEMU_IMG create -f raw "$TEST_IMG" "$size" | _filter_img_create
+$QEMU_IMG rebase -c -f raw -b "" "$TEST_IMG"
+
+# 2. Write the 1st half of $size to backing file (compressed), 2nd half -- to
+# the top image (also compressed).  Rebase the top image onto no backing file,
+# with compression (i.e. "qemu-img -c -b ''").  Check that the resulting image
+# has the written data preserved, and "qemu-img check" reports 100% clusters
+# as compressed.
+echo
+echo "=== Testing rebase with compression onto no backing file ==="
+echo
+
+TEST_IMG="$TEST_IMG.base" _make_test_img $size
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $size
+
+$QEMU_IO -c "write -c -P 0xaa 0 $half_size" "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IO -c "write -c -P 0xbb $half_size $half_size" "$TEST_IMG" \
+    | _filter_qemu_io
+
+$QEMU_IMG rebase -c -f $IMGFMT -b "" "$TEST_IMG"
+
+$QEMU_IO -c "read -P 0xaa 0 $half_size" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "read -P 0xbb $half_size $half_size" "$TEST_IMG" | _filter_qemu_io
+
+$QEMU_IMG check "$TEST_IMG" | _filter_testdir
+
+# 3. Same as the previous one, but with raw backing file (hence write to
+# the backing is uncompressed).
+echo
+echo "=== Testing rebase with compression with raw backing file ==="
+echo
+
+$QEMU_IMG create -f raw "$TEST_IMG.base" "$half_size" | _filter_img_create
+_make_test_img -b "$TEST_IMG.base" -F raw $size
+
+$QEMU_IO -f raw -c "write -P 0xaa 0 $half_size" "$TEST_IMG.base" \
+    | _filter_qemu_io
+$QEMU_IO -c "write -c -P 0xbb $half_size $half_size" \
+    "$TEST_IMG" | _filter_qemu_io
+
+$QEMU_IMG rebase -c -f $IMGFMT -b "" "$TEST_IMG"
+
+$QEMU_IO -c "read -P 0xaa 0 $half_size" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "read -P 0xbb $half_size $half_size" "$TEST_IMG" | _filter_qemu_io
+
+$QEMU_IMG check "$TEST_IMG" | _filter_testdir
+
+# 4. Create a backing chain base<--itmd<--img, filling 1st, 2nd and 3rd
+# thirds of them, respectively (with compression).  Rebase img onto base,
+# effectively deleting itmd from the chain, and check that written data is
+# preserved in the resulting image.  Also check that "qemu-img check" reports
+# 100% clusters as compressed.
+echo
+echo "=== Testing compressed rebase removing single delta from the chain ==="
+echo
+
+TEST_IMG="$TEST_IMG.base" _make_test_img $size
+TEST_IMG="$TEST_IMG.itmd" _make_test_img -b "$TEST_IMG.base" -F $IMGFMT $size
+_make_test_img -b "$TEST_IMG.itmd" -F $IMGFMT $size
+
+$QEMU_IO -c "write -c -P 0xaa 0 $third_size" \
+    "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IO -c "write -c -P 0xbb $third_size $third_size" \
+    "$TEST_IMG.itmd" | _filter_qemu_io
+$QEMU_IO -c "write -c -P 0xcc $((third_size * 2 )) $third_size" \
+    "$TEST_IMG" | _filter_qemu_io
+
+$QEMU_IMG rebase -c -f $IMGFMT -b "$TEST_IMG.base" -F $IMGFMT "$TEST_IMG"
+
+$QEMU_IO -c "read -P 0xaa 0 $third_size" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "read -P 0xbb $third_size $third_size" \
+    "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "read -P 0xcc $(( third_size * 2 )) $third_size" \
+    "$TEST_IMG" | _filter_qemu_io
+
+$QEMU_IMG check "$TEST_IMG" | _filter_testdir
+
+# 5. Create one-cluster backing and overlay images, and fill only the first
+# (half - 1) bytes of the backing with data (uncompressed).  Rebase the
+# overlay onto no backing file with compression.  Check that data is still
+# read correctly, and that cluster is now really compressed ("qemu-img check"
+# reports 100% clusters as compressed.
+echo
+echo "=== Testing compressed rebase with unaligned unmerged data ==="
+echo
+
+CLUSTER_SIZE=65536
+
+TEST_IMG="$TEST_IMG.base" _make_test_img $CLUSTER_SIZE
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $CLUSTER_SIZE
+
+$QEMU_IO -c "write -P 0xaa 0 $(( CLUSTER_SIZE / 2 - 1 ))" $TEST_IMG.base \
+    | _filter_qemu_io
+
+$QEMU_IMG rebase -c -f $IMGFMT -b "" "$TEST_IMG"
+
+$QEMU_IO -c "read -P 0xaa 0 $(( CLUSTER_SIZE / 2 - 1 ))" "$TEST_IMG" \
+    | _filter_qemu_io
+$QEMU_IO -c \
+    "read -P 0x00 $(( CLUSTER_SIZE / 2 - 1 )) $(( CLUSTER_SIZE / 2 + 1 ))" \
+    "$TEST_IMG" | _filter_qemu_io
+
+$QEMU_IMG check "$TEST_IMG" | _filter_testdir
+
+# success, all done
+echo
+echo '*** done'
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/314.out b/tests/qemu-iotests/314.out
new file mode 100644
index 0000000000..ac9337a543
--- /dev/null
+++ b/tests/qemu-iotests/314.out
@@ -0,0 +1,75 @@
+QA output created by 314
+
+=== Testing compressed rebase format compatibility ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=raw size=50331648
+qemu-img: Compression not supported for this file format
+
+=== Testing rebase with compression onto no backing file ===
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=50331648
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=50331648 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+wrote 25165824/25165824 bytes at offset 0
+24 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 25165824/25165824 bytes at offset 25165824
+24 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 25165824/25165824 bytes at offset 0
+24 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 25165824/25165824 bytes at offset 25165824
+24 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+No errors were found on the image.
+768/768 = 100.00% allocated, 100.00% fragmented, 100.00% compressed clusters
+Image end offset: 458752
+
+=== Testing rebase with compression with raw backing file ===
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=raw size=25165824
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=50331648 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=raw
+wrote 25165824/25165824 bytes at offset 0
+24 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 25165824/25165824 bytes at offset 25165824
+24 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 25165824/25165824 bytes at offset 0
+24 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 25165824/25165824 bytes at offset 25165824
+24 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+No errors were found on the image.
+768/768 = 100.00% allocated, 100.00% fragmented, 100.00% compressed clusters
+Image end offset: 458752
+
+=== Testing compressed rebase removing single delta from the chain ===
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=50331648
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=50331648 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=50331648 backing_file=TEST_DIR/t.IMGFMT.itmd backing_fmt=IMGFMT
+wrote 16777216/16777216 bytes at offset 0
+16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 16777216/16777216 bytes at offset 16777216
+16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 16777216/16777216 bytes at offset 33554432
+16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 16777216/16777216 bytes at offset 0
+16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 16777216/16777216 bytes at offset 16777216
+16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 16777216/16777216 bytes at offset 33554432
+16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+No errors were found on the image.
+512/768 = 66.67% allocated, 100.00% fragmented, 100.00% compressed clusters
+Image end offset: 458752
+
+=== Testing compressed rebase with unaligned unmerged data ===
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=65536
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=65536 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+wrote 32767/32767 bytes at offset 0
+31.999 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 32767/32767 bytes at offset 0
+31.999 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 32769/32769 bytes at offset 32767
+32.001 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+No errors were found on the image.
+1/1 = 100.00% allocated, 100.00% fragmented, 100.00% compressed clusters
+Image end offset: 393216
+
+*** done
-- 
2.31.1


