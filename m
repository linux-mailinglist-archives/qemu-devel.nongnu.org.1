Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2F07A6951
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 19:00:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qie3M-0003jf-Re; Tue, 19 Sep 2023 12:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qie3D-0003hF-Qe; Tue, 19 Sep 2023 12:58:16 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qie37-0002Me-G5; Tue, 19 Sep 2023 12:58:15 -0400
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1qidza-00DUte-0L;
 Tue, 19 Sep 2023 18:57:54 +0200
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v3 8/8] iotests: add tests for "qemu-img rebase" with
 compression
Date: Tue, 19 Sep 2023 19:58:04 +0300
Message-Id: <20230919165804.439110-9-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230919165804.439110-1-andrey.drobyshev@virtuozzo.com>
References: <20230919165804.439110-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Reply-to:  Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
From:  Andrey Drobyshev via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

The test cases considered so far:

314 (new test suite):

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

271:

1. Check that when target image has subclusters, rebase with compression
   will make an entire cluster containing the written subcluster
   compressed.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
---
 tests/qemu-iotests/271     |  65 +++++++++++++++
 tests/qemu-iotests/271.out |  40 +++++++++
 tests/qemu-iotests/314     | 165 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/314.out |  75 +++++++++++++++++
 4 files changed, 345 insertions(+)
 create mode 100755 tests/qemu-iotests/314
 create mode 100644 tests/qemu-iotests/314.out

diff --git a/tests/qemu-iotests/271 b/tests/qemu-iotests/271
index e243f57ba7..59a6fafa2f 100755
--- a/tests/qemu-iotests/271
+++ b/tests/qemu-iotests/271
@@ -965,6 +965,71 @@ echo
 
 TEST_IMG="$TEST_IMG.top" alloc="1 30" zero="" _verify_l2_bitmap 0
 
+# Check that rebase with compression works correctly with images containing
+# subclusters.  When compression is enabled and we allocate a new
+# subcluster within the target (overlay) image, we expect the entire cluster
+# containing that subcluster to become compressed.
+#
+# Here we expect 1st and 3rd clusters of the top (overlay) image to become
+# compressed after the rebase, while cluster 2 to remain unallocated and
+# be read from the base (new backing) image.
+#
+# Base (new backing): |-- -- .. -- --|11 11 .. 11 11|-- -- .. -- --|
+# Mid (old backing):  |-- -- .. -- 22|-- -- .. -- --|33 -- .. -- --|
+# Top:                |-- -- .. -- --|-- -- -- -- --|-- -- .. -- --|
+
+echo
+echo "### Rebase with compression for images with subclusters ###"
+echo
+
+echo "# create backing chain"
+echo
+
+TEST_IMG="$TEST_IMG.base" _make_test_img -o cluster_size=1M,extended_l2=on 3M
+TEST_IMG="$TEST_IMG.mid" _make_test_img -o cluster_size=1M,extended_l2=on \
+    -b "$TEST_IMG.base" -F qcow2 3M
+TEST_IMG="$TEST_IMG.top" _make_test_img -o cluster_size=1M,extended_l2=on \
+    -b "$TEST_IMG.mid" -F qcow2 3M
+
+echo
+echo "# fill old and new backing with data"
+echo
+
+$QEMU_IO -c "write -P 0x11 1M 1M" "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IO -c "write -P 0x22 $(( 31 * 32 ))k 32k" \
+         -c "write -P 0x33 $(( 64 * 32 ))k 32k" \
+         "$TEST_IMG.mid" | _filter_qemu_io
+
+echo
+echo "# rebase topmost image onto the new backing, with compression"
+echo
+
+$QEMU_IMG rebase -c -b "$TEST_IMG.base" -F qcow2 "$TEST_IMG.top"
+
+echo "# verify that the 1st and 3rd clusters've become compressed"
+echo
+
+$QEMU_IMG map --output=json "$TEST_IMG.top" | _filter_testdir
+
+echo
+echo "# verify that data is read the same before and after rebase"
+echo
+
+$QEMU_IO -c "read -P 0x22 $(( 31 * 32 ))k 32k" \
+         -c "read -P 0x11 1M 1M" \
+         -c "read -P 0x33 $(( 64 * 32 ))k 32k" \
+         "$TEST_IMG.top" | _filter_qemu_io
+
+echo
+echo "# verify image bitmap"
+echo
+
+# For compressed clusters bitmap is always 0.  For unallocated cluster
+# there should be no entry at all, thus bitmap is also 0.
+TEST_IMG="$TEST_IMG.top" alloc="" zero="" _verify_l2_bitmap 0
+TEST_IMG="$TEST_IMG.top" alloc="" zero="" _verify_l2_bitmap 1
+TEST_IMG="$TEST_IMG.top" alloc="" zero="" _verify_l2_bitmap 2
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/271.out b/tests/qemu-iotests/271.out
index c335a6c608..0b24d50159 100644
--- a/tests/qemu-iotests/271.out
+++ b/tests/qemu-iotests/271.out
@@ -765,4 +765,44 @@ Offset          Length          Mapped to       File
 # verify image bitmap
 
 L2 entry #0: 0x8000000000500000 0000000040000002
+
+### Rebase with compression for images with subclusters ###
+
+# create backing chain
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=3145728
+Formatting 'TEST_DIR/t.IMGFMT.mid', fmt=IMGFMT size=3145728 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT.top', fmt=IMGFMT size=3145728 backing_file=TEST_DIR/t.IMGFMT.mid backing_fmt=IMGFMT
+
+# fill old and new backing with data
+
+wrote 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 32768/32768 bytes at offset 1015808
+32 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 32768/32768 bytes at offset 2097152
+32 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# rebase topmost image onto the new backing, with compression
+
+# verify that the 1st and 3rd clusters've become compressed
+
+[{ "start": 0, "length": 1048576, "depth": 0, "present": true, "zero": false, "data": true, "compressed": true},
+{ "start": 1048576, "length": 1048576, "depth": 1, "present": true, "zero": false, "data": true, "compressed": false, "offset": 5242880},
+{ "start": 2097152, "length": 1048576, "depth": 0, "present": true, "zero": false, "data": true, "compressed": true}]
+
+# verify that data is read the same before and after rebase
+
+read 32768/32768 bytes at offset 1015808
+32 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 32768/32768 bytes at offset 2097152
+32 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# verify image bitmap
+
+L2 entry #0: 0x4008000000500000 0000000000000000
+L2 entry #1: 0x0000000000000000 0000000000000000
+L2 entry #2: 0x400800000050040b 0000000000000000
 *** done
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
2.39.3


