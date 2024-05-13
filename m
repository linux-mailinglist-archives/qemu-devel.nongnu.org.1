Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F8F8C3B62
	for <lists+qemu-devel@lfdr.de>; Mon, 13 May 2024 08:33:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6PFB-0008UC-21; Mon, 13 May 2024 02:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1s6PF0-00089W-T2; Mon, 13 May 2024 02:32:56 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1s6PEy-00049v-EI; Mon, 13 May 2024 02:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=R4R/EM7x91MDHNlq7MOKJ/r9R0K3nmFs8YcblSdqhbs=; b=ivjEPqBGjCuz
 jk1ImlSt2WCUe4HvH4IxIORPzA/oA0nWON+YRgBiS+8pQdrfpwDNHAz7yyQqtf58enx4EyeeuDWcb
 P95S4u04wIMpPH9TVzuqosB/nqsQtR6trY+H7DrsWCEAIO4c6MCgE9rE+TuyHnb1WkEWg8tt1aMdf
 OrXW2xGH7KdBLopWFSVQHqhpbXV7YVsNamW4P9fXm1bwFRzBd3r7NrYvS21gHIf+h3coxPbluDdA3
 MGIaEc4SN6JBEU9j1pREegmk+iDPCgLHyia5/Rraegv/2AP7T5R0cb5sRFWa+5JvEU5P8DjtAoP7Q
 xhsTCFdx3RLX8djzn6DC5Q==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1s6PAS-000qpR-02;
 Mon, 13 May 2024 08:31:57 +0200
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, jean-louis@dupond.be,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v2 11/11] iotests/271: add test cases for subcluster-based
 discard/unmap
Date: Mon, 13 May 2024 09:32:03 +0300
Message-Id: <20240513063203.113911-12-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240513063203.113911-1-andrey.drobyshev@virtuozzo.com>
References: <20240513063203.113911-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Add a bunch of test cases covering new subclusters behaviour: unmap of
last allocated subclusters; unmap of subclusters within unallocated
cluster; discard of unallocated subclusters within a cluster; regular discard
of subclusters within a cluster; discard of last allocated subclusters.

Also make all discard/unmap operations enable trace point 'file_do_fallocate'
so that actual fallocate() calls are visible.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qemu-iotests/271     | 70 +++++++++++++++++++++++++++++---------
 tests/qemu-iotests/271.out | 69 ++++++++++++++++++++++++++++++++++---
 2 files changed, 119 insertions(+), 20 deletions(-)

diff --git a/tests/qemu-iotests/271 b/tests/qemu-iotests/271
index 04c57813c2..8b80682cff 100755
--- a/tests/qemu-iotests/271
+++ b/tests/qemu-iotests/271
@@ -81,6 +81,12 @@ _verify_l2_bitmap()
     fi
 }
 
+# Filter out trace params which we don't control (file fd)
+_filter_trace_fallocate()
+{
+    sed -E 's/fd=[0-9]+/fd=N/g'
+}
+
 # This should be called as _run_test c=XXX sc=XXX off=XXX len=XXX cmd=XXX
 # c:   cluster number (0 if unset)
 # sc:  subcluster number inside cluster @c (0 if unset)
@@ -94,12 +100,13 @@ _verify_l2_bitmap()
 #      discard  -> discard
 _run_test()
 {
-    unset c sc off len cmd
+    unset c sc off len cmd opt
     for var in "$@"; do eval "$var"; done
     case "${cmd:-write}" in
         zero)
             cmd="write -q -z";;
         unmap)
+            opt="--trace enable=file_do_fallocate"
             cmd="write -q -z -u";;
         compress)
             pat=$((${pat:-0} + 1))
@@ -108,6 +115,7 @@ _run_test()
             pat=$((${pat:-0} + 1))
             cmd="write -q -P ${pat}";;
         discard)
+            opt="--trace enable=file_do_fallocate"
             cmd="discard -q";;
         *)
             echo "Unknown option $cmd"
@@ -121,7 +129,7 @@ _run_test()
     cmd="$cmd ${offset} ${len}"
     raw_cmd=$(echo $cmd | sed s/-c//) # Raw images don't support -c
     echo $cmd | sed 's/-P [0-9][0-9]\?/-P PATTERN/'
-    $QEMU_IO -c "$cmd" "$TEST_IMG" | _filter_qemu_io
+    $QEMU_IO $opt -c "$cmd" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_trace_fallocate
     $QEMU_IO -c "$raw_cmd" -f raw "$TEST_IMG.raw" | _filter_qemu_io
     _verify_img
     _verify_l2_bitmap "$c"
@@ -202,9 +210,10 @@ for use_backing_file in yes no; do
     alloc="$(seq 16 31)"; zero="$(seq 0 15)"
     _run_test sc=0 len=32k cmd=unmap
 
-    ### Zero and unmap cluster #0
+    ### Zero and unmap second half of cluster #0 (this will unmap it and
+    ### discard l2 entry)
     alloc=""; zero="$(seq 0 31)"
-    _run_test sc=0 len=64k cmd=unmap
+    _run_test sc=16 len=32k cmd=unmap
 
     ### Write subcluster #1 (middle of subcluster)
     alloc="1"; zero="0 $(seq 2 31)"
@@ -439,6 +448,12 @@ for use_backing_file in yes no; do
     _verify_l2_bitmap 16
     _verify_l2_bitmap 17
 
+    # Unmap subclusters #0-#3 of an unallocated cluster #8.  Since
+    # 'write -z -u' doesn't lead to full discard, subclusters should become
+    # explicitly zeroized
+    alloc=""; zero="$(seq 0 3)"
+    _run_test c=8 sc=0 len=8k cmd=unmap
+
     # Cluster-aligned request from clusters #9 to #11
     alloc=""; zero="$(seq 0 31)"
     _run_test c=9 sc=0 len=192k cmd=unmap
@@ -523,26 +538,45 @@ for use_backing_file in yes no; do
     echo
     echo "### Discarding clusters with non-zero bitmaps (backing file: $use_backing_file) ###"
     echo
+
+    _reset_img 1M
+
+    # Write first half of cluster #0 and discard another half
+    alloc="$(seq 0 15)"; zero=""
+    _run_test sc=0 len=32k
+    # When discarding unallocated subclusters, they only have to be
+    # explicitly zeroized when the image has a backing file
     if [ "$use_backing_file" = "yes" ]; then
-        _make_test_img -o extended_l2=on -F raw -b "$TEST_IMG.base" 1M
+        alloc="$(seq 0 15)"; zero="$(seq 16 31)"
     else
-        _make_test_img -o extended_l2=on 1M
+        alloc="$(seq 0 15)"; zero=""
     fi
-    # Write clusters #0-#2 and then discard them
-    $QEMU_IO -c 'write -q 0 128k' "$TEST_IMG"
-    $QEMU_IO -c 'discard -q 0 128k' "$TEST_IMG"
+    _run_test sc=16 len=32k cmd=discard
+
+    # Write cluster #0 and discard its subclusters #0-#3
+    alloc="$(seq 0 31)"; zero=""
+    _run_test sc=0 len=64k
+    alloc="$(seq 4 31)"; zero="$(seq 0 3)"
+    _run_test sc=0 len=8k cmd=discard
+
+    # Discard remaining subclusters #4-#32.  This should unmap the cluster
+    # and discard its l2 entry
+    alloc=""; zero="$(seq 0 31)"
+    _run_test sc=4 len=56k cmd=discard
+
+    # Write clusters #0-#1 and then discard them
+    alloc="$(seq 0 31)"; zero=""
+    _run_test sc=0 len=128k
     # 'qemu-io discard' doesn't do a full discard, it zeroizes the
-    # cluster, so both clusters have all zero bits set now
+    # cluster, so both clusters have all zero bits set after discard
     alloc=""; zero="$(seq 0 31)"
-    _verify_l2_bitmap 0
+    _run_test sc=0 len=128k cmd=discard
     _verify_l2_bitmap 1
+
     # Now mark the 2nd half of the subclusters from cluster #0 as unallocated
     poke_file "$TEST_IMG" $(($l2_offset+8)) "\x00\x00"
+
     # Discard cluster #0 again to see how the zero bits have changed
-    $QEMU_IO -c 'discard -q 0 64k' "$TEST_IMG"
-    # And do a full discard of cluster #1 by shrinking and growing the image
-    $QEMU_IMG resize --shrink "$TEST_IMG" 64k
-    $QEMU_IMG resize "$TEST_IMG" 1M
     # A normal discard sets all 'zero' bits only if the image has a
     # backing file, otherwise it won't touch them.
     if [ "$use_backing_file" = "yes" ]; then
@@ -550,7 +584,11 @@ for use_backing_file in yes no; do
     else
         alloc=""; zero="$(seq 0 15)"
     fi
-    _verify_l2_bitmap 0
+    _run_test sc=0 len=64k cmd=discard
+
+    # And do a full discard of cluster #1 by shrinking and growing the image
+    $QEMU_IMG resize --shrink "$TEST_IMG" 64k
+    $QEMU_IMG resize "$TEST_IMG" 1M
     # A full discard should clear the L2 entry completely. However
     # when growing an image with a backing file the new clusters are
     # zeroized to hide the stale data from the backing file
diff --git a/tests/qemu-iotests/271.out b/tests/qemu-iotests/271.out
index 0b24d50159..c03e4c9bc2 100644
--- a/tests/qemu-iotests/271.out
+++ b/tests/qemu-iotests/271.out
@@ -29,14 +29,17 @@ L2 entry #0: 0x8000000000050000 ffffffff00000000
 write -q -P PATTERN 0 64k
 L2 entry #0: 0x8000000000050000 00000000ffffffff
 write -q -z -u 0 32k
+file_do_fallocate fd=N mode=0x03 offset=327680 len=32768
 L2 entry #0: 0x8000000000050000 0000ffffffff0000
-write -q -z -u 0 64k
+write -q -z -u 32k 32k
+file_do_fallocate fd=N mode=0x03 offset=327680 len=65536
 L2 entry #0: 0x0000000000000000 ffffffff00000000
 write -q -P PATTERN 3k 512
 L2 entry #0: 0x8000000000050000 fffffffd00000002
 write -q -P PATTERN 0 64k
 L2 entry #0: 0x8000000000050000 00000000ffffffff
 discard -q 0 64k
+file_do_fallocate fd=N mode=0x03 offset=327680 len=65536
 L2 entry #0: 0x0000000000000000 ffffffff00000000
 write -q -c -P PATTERN 0 64k
 L2 entry #0: 0x4000000000050000 0000000000000000
@@ -71,14 +74,17 @@ L2 entry #0: 0x8000000000050000 ffffffff00000000
 write -q -P PATTERN 0 64k
 L2 entry #0: 0x8000000000050000 00000000ffffffff
 write -q -z -u 0 32k
+file_do_fallocate fd=N mode=0x03 offset=327680 len=32768
 L2 entry #0: 0x8000000000050000 0000ffffffff0000
-write -q -z -u 0 64k
+write -q -z -u 32k 32k
+file_do_fallocate fd=N mode=0x03 offset=327680 len=65536
 L2 entry #0: 0x0000000000000000 ffffffff00000000
 write -q -P PATTERN 3k 512
 L2 entry #0: 0x8000000000050000 fffffffd00000002
 write -q -P PATTERN 0 64k
 L2 entry #0: 0x8000000000050000 00000000ffffffff
 discard -q 0 64k
+file_do_fallocate fd=N mode=0x03 offset=327680 len=65536
 L2 entry #0: 0x0000000000000000 ffffffff00000000
 write -q -c -P PATTERN 0 64k
 L2 entry #0: 0x4000000000050000 0000000000000000
@@ -301,15 +307,20 @@ L2 entry #14: 0x80000000000a0000 00000000ffffffff
 L2 entry #15: 0x80000000000b0000 00000000ffffffff
 L2 entry #16: 0x80000000000c0000 00000000ffffffff
 L2 entry #17: 0x80000000000d0000 00000000ffffffff
+write -q -z -u 512k 8k
+L2 entry #8: 0x0000000000000000 0000000f00000000
 write -q -z -u 576k 192k
+file_do_fallocate fd=N mode=0x03 offset=327680 len=196608
 L2 entry #9: 0x0000000000000000 ffffffff00000000
 L2 entry #10: 0x0000000000000000 ffffffff00000000
 L2 entry #11: 0x0000000000000000 ffffffff00000000
 write -q -z -u 800k 128k
+file_do_fallocate fd=N mode=0x03 offset=557056 len=131072
 L2 entry #12: 0x8000000000080000 ffff00000000ffff
 L2 entry #13: 0x0000000000000000 ffffffff00000000
 L2 entry #14: 0x80000000000a0000 0000ffffffff0000
 write -q -z -u 991k 128k
+file_do_fallocate fd=N mode=0x03 offset=753664 len=129024
 L2 entry #15: 0x80000000000b0000 ffff00000000ffff
 L2 entry #16: 0x0000000000000000 ffffffff00000000
 L2 entry #17: 0x80000000000d0000 00007fffffff8000
@@ -339,6 +350,7 @@ L2 entry #27: 0x4000000000120000 0000000000000000
 write -q -c -P PATTERN 1792k 64k
 L2 entry #28: 0x4000000000130000 0000000000000000
 write -q -z -u 1152k 192k
+file_do_fallocate fd=N mode=0x03 offset=327680 len=196608
 L2 entry #18: 0x0000000000000000 ffffffff00000000
 L2 entry #19: 0x0000000000000000 ffffffff00000000
 L2 entry #20: 0x0000000000000000 ffffffff00000000
@@ -351,6 +363,8 @@ L2 entry #24: 0x8000000000090000 00000000ffffffff
 L2 entry #25: 0x80000000000e0000 00000000ffffffff
 L2 entry #26: 0x80000000000f0000 00000000ffffffff
 write -q -z -u 1759k 128k
+file_do_fallocate fd=N mode=0x03 offset=819200 len=32768
+file_do_fallocate fd=N mode=0x03 offset=1245184 len=65536
 L2 entry #27: 0x80000000000c0000 ffff00000000ffff
 L2 entry #28: 0x0000000000000000 ffffffff00000000
 L2 entry #29: 0x8000000000100000 00007fff00008000
@@ -369,15 +383,20 @@ L2 entry #14: 0x80000000000a0000 00000000ffffffff
 L2 entry #15: 0x80000000000b0000 00000000ffffffff
 L2 entry #16: 0x80000000000c0000 00000000ffffffff
 L2 entry #17: 0x80000000000d0000 00000000ffffffff
+write -q -z -u 512k 8k
+L2 entry #8: 0x0000000000000000 0000000f00000000
 write -q -z -u 576k 192k
+file_do_fallocate fd=N mode=0x03 offset=327680 len=196608
 L2 entry #9: 0x0000000000000000 ffffffff00000000
 L2 entry #10: 0x0000000000000000 ffffffff00000000
 L2 entry #11: 0x0000000000000000 ffffffff00000000
 write -q -z -u 800k 128k
+file_do_fallocate fd=N mode=0x03 offset=557056 len=131072
 L2 entry #12: 0x8000000000080000 ffff00000000ffff
 L2 entry #13: 0x0000000000000000 ffffffff00000000
 L2 entry #14: 0x80000000000a0000 0000ffffffff0000
 write -q -z -u 991k 128k
+file_do_fallocate fd=N mode=0x03 offset=753664 len=129024
 L2 entry #15: 0x80000000000b0000 ffff00000000ffff
 L2 entry #16: 0x0000000000000000 ffffffff00000000
 L2 entry #17: 0x80000000000d0000 00007fffffff8000
@@ -407,6 +426,7 @@ L2 entry #27: 0x4000000000120000 0000000000000000
 write -q -c -P PATTERN 1792k 64k
 L2 entry #28: 0x4000000000130000 0000000000000000
 write -q -z -u 1152k 192k
+file_do_fallocate fd=N mode=0x03 offset=327680 len=196608
 L2 entry #18: 0x0000000000000000 ffffffff00000000
 L2 entry #19: 0x0000000000000000 ffffffff00000000
 L2 entry #20: 0x0000000000000000 ffffffff00000000
@@ -419,28 +439,69 @@ L2 entry #24: 0x8000000000090000 00000000ffffffff
 L2 entry #25: 0x80000000000e0000 00000000ffffffff
 L2 entry #26: 0x80000000000f0000 00000000ffffffff
 write -q -z -u 1759k 128k
+file_do_fallocate fd=N mode=0x03 offset=819200 len=32768
+file_do_fallocate fd=N mode=0x03 offset=1245184 len=65536
 L2 entry #27: 0x80000000000c0000 ffff00000000ffff
 L2 entry #28: 0x0000000000000000 ffffffff00000000
 L2 entry #29: 0x0000000000000000 0000ffff00000000
 
 ### Discarding clusters with non-zero bitmaps (backing file: yes) ###
 
+Formatting 'TEST_DIR/t.IMGFMT.raw', fmt=raw size=1048576
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=raw size=1048576
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=raw
+write -q -P PATTERN 0 32k
+L2 entry #0: 0x8000000000050000 000000000000ffff
+discard -q 32k 32k
+file_do_fallocate fd=N mode=0x03 offset=360448 len=32768
+L2 entry #0: 0x8000000000050000 ffff00000000ffff
+write -q -P PATTERN 0 64k
+L2 entry #0: 0x8000000000050000 00000000ffffffff
+discard -q 0 8k
+file_do_fallocate fd=N mode=0x03 offset=327680 len=8192
+L2 entry #0: 0x8000000000050000 0000000ffffffff0
+discard -q 8k 56k
+file_do_fallocate fd=N mode=0x03 offset=327680 len=65536
+L2 entry #0: 0x0000000000000000 ffffffff00000000
+write -q -P PATTERN 0 128k
+L2 entry #0: 0x8000000000050000 00000000ffffffff
+discard -q 0 128k
+file_do_fallocate fd=N mode=0x03 offset=327680 len=131072
 L2 entry #0: 0x0000000000000000 ffffffff00000000
 L2 entry #1: 0x0000000000000000 ffffffff00000000
+discard -q 0 64k
+L2 entry #0: 0x0000000000000000 ffffffff00000000
 Image resized.
 Image resized.
-L2 entry #0: 0x0000000000000000 ffffffff00000000
 L2 entry #1: 0x0000000000000000 ffffffff00000000
 
 ### Discarding clusters with non-zero bitmaps (backing file: no) ###
 
+Formatting 'TEST_DIR/t.IMGFMT.raw', fmt=raw size=1048576
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+write -q -P PATTERN 0 32k
+L2 entry #0: 0x8000000000050000 000000000000ffff
+discard -q 32k 32k
+file_do_fallocate fd=N mode=0x03 offset=360448 len=32768
+L2 entry #0: 0x8000000000050000 000000000000ffff
+write -q -P PATTERN 0 64k
+L2 entry #0: 0x8000000000050000 00000000ffffffff
+discard -q 0 8k
+file_do_fallocate fd=N mode=0x03 offset=327680 len=8192
+L2 entry #0: 0x8000000000050000 0000000ffffffff0
+discard -q 8k 56k
+file_do_fallocate fd=N mode=0x03 offset=327680 len=65536
+L2 entry #0: 0x0000000000000000 ffffffff00000000
+write -q -P PATTERN 0 128k
+L2 entry #0: 0x8000000000050000 00000000ffffffff
+discard -q 0 128k
+file_do_fallocate fd=N mode=0x03 offset=327680 len=131072
 L2 entry #0: 0x0000000000000000 ffffffff00000000
 L2 entry #1: 0x0000000000000000 ffffffff00000000
+discard -q 0 64k
+L2 entry #0: 0x0000000000000000 0000ffff00000000
 Image resized.
 Image resized.
-L2 entry #0: 0x0000000000000000 0000ffff00000000
 L2 entry #1: 0x0000000000000000 0000000000000000
 
 ### Corrupted L2 entries - read test (allocated) ###
-- 
2.39.3


