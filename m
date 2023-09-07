Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED12E797E8D
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 00:08:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeN9z-0003qE-AR; Thu, 07 Sep 2023 18:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qeN9s-0003p6-Eh; Thu, 07 Sep 2023 18:07:28 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qeN9o-0001ue-DA; Thu, 07 Sep 2023 18:07:27 -0400
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1qeN6b-00Eeg1-2v;
 Fri, 08 Sep 2023 00:07:17 +0200
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com, andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v2 4/3] qemu-iotests/197: use more generic commands for
 formats other than qcow2
Date: Fri,  8 Sep 2023 01:07:18 +0300
Message-Id: <20230907220718.983430-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230711172553.234055-1-andrey.drobyshev@virtuozzo.com>
References: <20230711172553.234055-1-andrey.drobyshev@virtuozzo.com>
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

In the previous commit e2f938265e0 ("tests/qemu-iotests/197: add
testcase for CoR with subclusters") we've introduced a new testcase for
copy-on-read with subclusters.  Test 197 always forces qcow2 as the top
image, but allows backing image to be in any format.  That last test
case didn't meet these requirements, so let's fix it by using more
generic "qemu-io -c map" command.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qemu-iotests/197     |  8 ++++----
 tests/qemu-iotests/197.out | 18 ++++++++----------
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
index f07a9da136..8ad2bdb035 100755
--- a/tests/qemu-iotests/197
+++ b/tests/qemu-iotests/197
@@ -136,18 +136,18 @@ IMGPROTO=file IMGFMT=qcow2 TEST_IMG_FILE="$TEST_WRAP" \
 $QEMU_IO -c "write -P 0xaa 0 64k" "$TEST_IMG" | _filter_qemu_io
 
 # Allocate individual subclusters in the top image, and not the whole cluster
-$QEMU_IO -c "write -P 0xbb 28K 2K" -c "write -P 0xcc 34K 2K" "$TEST_WRAP" \
+$QEMU_IO -f qcow2 -c "write -P 0xbb 28K 2K" -c "write -P 0xcc 34K 2K" "$TEST_WRAP" \
     | _filter_qemu_io
 
 # Only 2 subclusters should be allocated in the top image at this point
-$QEMU_IMG map "$TEST_WRAP" | _filter_qemu_img_map
+$QEMU_IO -f qcow2 -c map "$TEST_WRAP"
 
 # Actual copy-on-read operation
-$QEMU_IO -C -c "read -P 0xaa 30K 4K" "$TEST_WRAP" | _filter_qemu_io
+$QEMU_IO -f qcow2 -C -c "read -P 0xaa 30K 4K" "$TEST_WRAP" | _filter_qemu_io
 
 # And here we should have 4 subclusters allocated right in the middle of the
 # top image. Make sure the whole cluster remains unallocated
-$QEMU_IMG map "$TEST_WRAP" | _filter_qemu_img_map
+$QEMU_IO -f qcow2 -c map "$TEST_WRAP"
 
 _check_test_img
 
diff --git a/tests/qemu-iotests/197.out b/tests/qemu-iotests/197.out
index 8f34a30afe..86c57b51d3 100644
--- a/tests/qemu-iotests/197.out
+++ b/tests/qemu-iotests/197.out
@@ -42,17 +42,15 @@ wrote 2048/2048 bytes at offset 28672
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 2048/2048 bytes at offset 34816
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Offset          Length          File
-0               0x7000          TEST_DIR/t.IMGFMT
-0x7000          0x800           TEST_DIR/t.wrap.IMGFMT
-0x7800          0x1000          TEST_DIR/t.IMGFMT
-0x8800          0x800           TEST_DIR/t.wrap.IMGFMT
-0x9000          0x7000          TEST_DIR/t.IMGFMT
+28 KiB (0x7000) bytes not allocated at offset 0 bytes (0x0)
+2 KiB (0x800) bytes     allocated at offset 28 KiB (0x7000)
+4 KiB (0x1000) bytes not allocated at offset 30 KiB (0x7800)
+2 KiB (0x800) bytes     allocated at offset 34 KiB (0x8800)
+28 KiB (0x7000) bytes not allocated at offset 36 KiB (0x9000)
 read 4096/4096 bytes at offset 30720
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Offset          Length          File
-0               0x7000          TEST_DIR/t.IMGFMT
-0x7000          0x2000          TEST_DIR/t.wrap.IMGFMT
-0x9000          0x7000          TEST_DIR/t.IMGFMT
+28 KiB (0x7000) bytes not allocated at offset 0 bytes (0x0)
+8 KiB (0x2000) bytes     allocated at offset 28 KiB (0x7000)
+28 KiB (0x7000) bytes not allocated at offset 36 KiB (0x9000)
 No errors were found on the image.
 *** done
-- 
2.39.3


