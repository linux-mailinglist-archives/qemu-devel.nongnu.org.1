Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A83171F2EA
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 21:30:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4nyg-0006jt-44; Thu, 01 Jun 2023 15:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1q4nyX-0006jJ-FJ; Thu, 01 Jun 2023 15:28:45 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1q4nyV-0005mD-OB; Thu, 01 Jun 2023 15:28:45 -0400
Received: from dev005.ch-qa.vzint.dev ([172.29.1.10])
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1q4nyC-00DLDg-0h;
 Thu, 01 Jun 2023 21:28:36 +0200
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH 2/6] qemu-iotests: 024: add rebasing test case for
 overlay_size > backing_size
Date: Thu,  1 Jun 2023 22:28:32 +0300
Message-Id: <20230601192836.598602-3-andrey.drobyshev@virtuozzo.com>
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

Before previous commit, rebase was getting infitely stuck in case of
rebasing within the same backing chain and when overlay_size > backing_size.
Let's add this case to the rebasing test 024 to make sure it doesn't
break again.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qemu-iotests/024     | 57 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/024.out | 30 ++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/tests/qemu-iotests/024 b/tests/qemu-iotests/024
index 25a564a150..98a7c8fd65 100755
--- a/tests/qemu-iotests/024
+++ b/tests/qemu-iotests/024
@@ -199,6 +199,63 @@ echo
 # $BASE_OLD and $BASE_NEW)
 $QEMU_IMG map "$OVERLAY" | _filter_qemu_img_map
 
+# Check that rebase within the chain is working when
+# overlay_size > old_backing_size
+#
+# base_new <-- base_old <-- overlay
+#
+# Backing (new): 11 11 11 11 11
+# Backing (old): 22 22 22 22
+# Overlay:       -- -- -- -- --
+#
+# As a result, overlay should contain data identical to base_old, with the
+# last cluster remaining unallocated.
+
+echo
+echo "=== Test rebase within one backing chain ==="
+echo
+
+echo "Creating backing chain"
+echo
+
+TEST_IMG=$BASE_NEW _make_test_img $(( CLUSTER_SIZE * 5 ))
+TEST_IMG=$BASE_OLD _make_test_img -b "$BASE_NEW" -F $IMGFMT \
+    $(( CLUSTER_SIZE * 4 ))
+TEST_IMG=$OVERLAY _make_test_img -b "$BASE_OLD" -F $IMGFMT \
+    $(( CLUSTER_SIZE * 5 ))
+
+echo
+echo "Fill backing files with data"
+echo
+
+$QEMU_IO "$BASE_NEW" -c "write -P 0x11 0 $(( CLUSTER_SIZE * 5 ))" \
+    | _filter_qemu_io
+$QEMU_IO "$BASE_OLD" -c "write -P 0x22 0 $(( CLUSTER_SIZE * 4 ))" \
+    | _filter_qemu_io
+
+echo
+echo "Check the last cluster is zeroed in overlay before the rebase"
+echo
+$QEMU_IO "$OVERLAY" -c "read -P 0x00 $(( CLUSTER_SIZE * 4 )) $CLUSTER_SIZE" \
+    | _filter_qemu_io
+
+echo
+echo "Rebase onto another image in the same chain"
+echo
+
+$QEMU_IMG rebase -b "$BASE_NEW" -F $IMGFMT "$OVERLAY"
+
+echo "Verify that data is read the same before and after rebase"
+echo
+
+# Verify the first 4 clusters are still read the same as in the old base
+$QEMU_IO "$OVERLAY" -c "read -P 0x22 0 $(( CLUSTER_SIZE * 4 ))" \
+    | _filter_qemu_io
+# Verify the last cluster still reads as zeroes
+$QEMU_IO "$OVERLAY" -c "read -P 0x00 $(( CLUSTER_SIZE * 4 )) $CLUSTER_SIZE" \
+    | _filter_qemu_io
+
+echo
 
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/024.out b/tests/qemu-iotests/024.out
index 973a5a3711..245fe8b1d1 100644
--- a/tests/qemu-iotests/024.out
+++ b/tests/qemu-iotests/024.out
@@ -171,4 +171,34 @@ read 65536/65536 bytes at offset 196608
 Offset          Length          File
 0               0x30000         TEST_DIR/subdir/t.IMGFMT
 0x30000         0x10000         TEST_DIR/subdir/t.IMGFMT.base_new
+
+=== Test rebase within one backing chain ===
+
+Creating backing chain
+
+Formatting 'TEST_DIR/subdir/t.IMGFMT.base_new', fmt=IMGFMT size=327680
+Formatting 'TEST_DIR/subdir/t.IMGFMT.base_old', fmt=IMGFMT size=262144 backing_file=TEST_DIR/subdir/t.IMGFMT.base_new backing_fmt=IMGFMT
+Formatting 'TEST_DIR/subdir/t.IMGFMT', fmt=IMGFMT size=327680 backing_file=TEST_DIR/subdir/t.IMGFMT.base_old backing_fmt=IMGFMT
+
+Fill backing files with data
+
+wrote 327680/327680 bytes at offset 0
+320 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 262144/262144 bytes at offset 0
+256 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+Check the last cluster is zeroed in overlay before the rebase
+
+read 65536/65536 bytes at offset 262144
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+Rebase onto another image in the same chain
+
+Verify that data is read the same before and after rebase
+
+read 262144/262144 bytes at offset 0
+256 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 262144
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
 *** done
-- 
2.31.1


