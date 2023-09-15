Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0909B7A2665
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 20:44:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhDmL-0007mt-Qg; Fri, 15 Sep 2023 14:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qhDmE-0007gf-2P; Fri, 15 Sep 2023 14:42:50 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qhDmC-0003Lv-9O; Fri, 15 Sep 2023 14:42:49 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qhDhi-00Fs9Q-09;
 Fri, 15 Sep 2023 20:41:34 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: stefanha@redhat.com, alexander.ivanov@virtuozzo.com,
 mike.maslenkin@gmail.com, "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 12/21] tests: fix broken deduplication check in parallels
 format test
Date: Fri, 15 Sep 2023 20:41:21 +0200
Message-Id: <20230915184130.403366-15-den@openvz.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915184130.403366-1-den@openvz.org>
References: <20230915184130.403366-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Original check is broken as supposed reading from 2 different clusters
results in read from the same file offset twice. This is definitely
wrong.

We should be sure that
* the content of both clusters is correct after repair
* clusters are at the different offsets after repair
In order to check the latter we write some content into the first one
and validate that fact.

Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qemu-iotests/tests/parallels-checks     | 14 ++++++++++----
 tests/qemu-iotests/tests/parallels-checks.out | 16 ++++++++++++----
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/tests/parallels-checks b/tests/qemu-iotests/tests/parallels-checks
index f4ca50295e..df99558486 100755
--- a/tests/qemu-iotests/tests/parallels-checks
+++ b/tests/qemu-iotests/tests/parallels-checks
@@ -117,14 +117,20 @@ echo "== check second cluster =="
 echo "== repair image =="
 _check_test_img -r all
 
+echo "== check the first cluster =="
+{ $QEMU_IO -r -c "read -P 0x11 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
 echo "== check second cluster =="
 { $QEMU_IO -r -c "read -P 0x11 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 
-echo "== check first cluster on host =="
-printf "content: 0x%02x\n" `peek_file_le $TEST_IMG $(($CLUSTER_SIZE)) 1`
+echo "== write another pattern to the first clusters =="
+{ $QEMU_IO -c "write -P 0x66 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+echo "== check the first cluster =="
+{ $QEMU_IO -r -c "read -P 0x66 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 
-echo "== check second cluster on host =="
-printf "content: 0x%02x\n" `peek_file_le $TEST_IMG $(($CLUSTER_SIZE)) 1`
+echo "== check the second cluster (deduplicated) =="
+{ $QEMU_IO -r -c "read -P 0x11 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 
 # Clear image
 _make_test_img $SIZE
diff --git a/tests/qemu-iotests/tests/parallels-checks.out b/tests/qemu-iotests/tests/parallels-checks.out
index 74a5e29260..1325d2b611 100644
--- a/tests/qemu-iotests/tests/parallels-checks.out
+++ b/tests/qemu-iotests/tests/parallels-checks.out
@@ -55,13 +55,21 @@ The following inconsistencies were found and repaired:
 
 Double checking the fixed image now...
 No errors were found on the image.
+== check the first cluster ==
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == check second cluster ==
 read 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-== check first cluster on host ==
-content: 0x11
-== check second cluster on host ==
-content: 0x11
+== write another pattern to the first clusters ==
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== check the first cluster ==
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== check the second cluster (deduplicated) ==
+read 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
 == TEST DATA_OFF CHECK ==
 == write pattern to first cluster ==
-- 
2.34.1


