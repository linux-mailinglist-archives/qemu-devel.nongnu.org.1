Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A89474F73B
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 19:27:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJH7n-0005xj-5X; Tue, 11 Jul 2023 13:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qJH7k-0005vK-H8; Tue, 11 Jul 2023 13:26:04 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qJH7h-0006yT-NQ; Tue, 11 Jul 2023 13:26:04 -0400
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1qJH6C-008F35-0C;
 Tue, 11 Jul 2023 19:25:44 +0200
To: qemu-block@nongnu.org,
	qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 vsementsov@yandex-team.ru, eblake@redhat.com,
 andrey.drobyshev@virtuozzo.com, den@openvz.org
Subject: [PATCH v2 3/3] tests/qemu-iotests/197: add testcase for CoR with
 subclusters
Date: Tue, 11 Jul 2023 20:25:53 +0300
Message-Id: <20230711172553.234055-4-andrey.drobyshev@virtuozzo.com>
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

Add testcase which checks that allocations during copy-on-read are
performed on the subcluster basis when subclusters are enabled in target
image.

This testcase also triggers the following assert with previous commit
not being applied, so we check that as well:

qemu-io: ../block/io.c:1236: bdrv_co_do_copy_on_readv: Assertion `skip_bytes < pnum' failed.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qemu-iotests/197     | 29 +++++++++++++++++++++++++++++
 tests/qemu-iotests/197.out | 24 ++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
index a2547bc280..f07a9da136 100755
--- a/tests/qemu-iotests/197
+++ b/tests/qemu-iotests/197
@@ -122,6 +122,35 @@ $QEMU_IO -f qcow2 -C -c 'read 0 1024' "$TEST_WRAP" | _filter_qemu_io
 $QEMU_IO -f qcow2 -c map "$TEST_WRAP"
 _check_test_img
 
+echo
+echo '=== Copy-on-read with subclusters ==='
+echo
+
+# Create base and top images 64K (1 cluster) each.  Make subclusters enabled
+# for the top image
+_make_test_img 64K
+IMGPROTO=file IMGFMT=qcow2 TEST_IMG_FILE="$TEST_WRAP" \
+    _make_test_img --no-opts -o extended_l2=true -F "$IMGFMT" -b "$TEST_IMG" \
+    64K | _filter_img_create
+
+$QEMU_IO -c "write -P 0xaa 0 64k" "$TEST_IMG" | _filter_qemu_io
+
+# Allocate individual subclusters in the top image, and not the whole cluster
+$QEMU_IO -c "write -P 0xbb 28K 2K" -c "write -P 0xcc 34K 2K" "$TEST_WRAP" \
+    | _filter_qemu_io
+
+# Only 2 subclusters should be allocated in the top image at this point
+$QEMU_IMG map "$TEST_WRAP" | _filter_qemu_img_map
+
+# Actual copy-on-read operation
+$QEMU_IO -C -c "read -P 0xaa 30K 4K" "$TEST_WRAP" | _filter_qemu_io
+
+# And here we should have 4 subclusters allocated right in the middle of the
+# top image. Make sure the whole cluster remains unallocated
+$QEMU_IMG map "$TEST_WRAP" | _filter_qemu_img_map
+
+_check_test_img
+
 # success, all done
 echo '*** done'
 status=0
diff --git a/tests/qemu-iotests/197.out b/tests/qemu-iotests/197.out
index ad414c3b0e..8f34a30afe 100644
--- a/tests/qemu-iotests/197.out
+++ b/tests/qemu-iotests/197.out
@@ -31,4 +31,28 @@ read 1024/1024 bytes at offset 0
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)
 No errors were found on the image.
+
+=== Copy-on-read with subclusters ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=65536
+Formatting 'TEST_DIR/t.wrap.IMGFMT', fmt=IMGFMT size=65536 backing_file=TEST_DIR/t.IMGFMT backing_fmt=IMGFMT
+wrote 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2048/2048 bytes at offset 28672
+2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2048/2048 bytes at offset 34816
+2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Offset          Length          File
+0               0x7000          TEST_DIR/t.IMGFMT
+0x7000          0x800           TEST_DIR/t.wrap.IMGFMT
+0x7800          0x1000          TEST_DIR/t.IMGFMT
+0x8800          0x800           TEST_DIR/t.wrap.IMGFMT
+0x9000          0x7000          TEST_DIR/t.IMGFMT
+read 4096/4096 bytes at offset 30720
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Offset          Length          File
+0               0x7000          TEST_DIR/t.IMGFMT
+0x7000          0x2000          TEST_DIR/t.wrap.IMGFMT
+0x9000          0x7000          TEST_DIR/t.IMGFMT
+No errors were found on the image.
 *** done
-- 
2.39.3


