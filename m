Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 799C77A772C
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 11:23:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qitQB-0003G9-Dl; Wed, 20 Sep 2023 05:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qitQA-0003EV-7A; Wed, 20 Sep 2023 05:22:58 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qitQ8-00021A-DM; Wed, 20 Sep 2023 05:22:57 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qitL0-0028Y8-0k;
 Wed, 20 Sep 2023 11:21:02 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Subject: [PULL 14/22] tests: test self-cure of parallels image with duplicated
 clusters
Date: Wed, 20 Sep 2023 11:21:00 +0200
Message-Id: <20230920092108.258898-15-den@openvz.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920092108.258898-1-den@openvz.org>
References: <20230920092108.258898-1-den@openvz.org>
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

The test is quite similar with the original one for duplicated clusters.
There is the only difference in the operation which should fix the
image.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 tests/qemu-iotests/tests/parallels-checks     | 36 +++++++++++++++++++
 tests/qemu-iotests/tests/parallels-checks.out | 31 ++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/tests/qemu-iotests/tests/parallels-checks b/tests/qemu-iotests/tests/parallels-checks
index df99558486..b281246a42 100755
--- a/tests/qemu-iotests/tests/parallels-checks
+++ b/tests/qemu-iotests/tests/parallels-checks
@@ -135,6 +135,42 @@ echo "== check the second cluster (deduplicated) =="
 # Clear image
 _make_test_img $SIZE
 
+echo "== TEST DUPLICATION SELF-CURE =="
+
+echo "== write pattern to whole image =="
+{ $QEMU_IO -c "write -P 0x11 0 $SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+echo "== write another pattern to second cluster =="
+{ $QEMU_IO -c "write -P 0x55 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+echo "== check second cluster =="
+{ $QEMU_IO -r -c "read -P 0x55 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+
+echo "== corrupt image =="
+poke_file "$TEST_IMG" "$(($BAT_OFFSET + 4))" "\x01\x00\x00\x00"
+
+echo "== check second cluster =="
+{ $QEMU_IO -r -c "read -P 0x11 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+echo "== check the first cluster with self-repair =="
+{ $QEMU_IO -c "read -P 0x11 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+echo "== check second cluster =="
+{ $QEMU_IO -r -c "read -P 0x11 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+echo "== write another pattern to the first clusters =="
+{ $QEMU_IO -c "write -P 0x66 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+echo "== check the first cluster =="
+{ $QEMU_IO -r -c "read -P 0x66 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+echo "== check the second cluster (deduplicated) =="
+{ $QEMU_IO -r -c "read -P 0x11 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+# Clear image
+_make_test_img $SIZE
+
 echo "== TEST DATA_OFF CHECK =="
 
 echo "== write pattern to first cluster =="
diff --git a/tests/qemu-iotests/tests/parallels-checks.out b/tests/qemu-iotests/tests/parallels-checks.out
index 1325d2b611..9793423111 100644
--- a/tests/qemu-iotests/tests/parallels-checks.out
+++ b/tests/qemu-iotests/tests/parallels-checks.out
@@ -71,6 +71,37 @@ read 1048576/1048576 bytes at offset 0
 read 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
+== TEST DUPLICATION SELF-CURE ==
+== write pattern to whole image ==
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== write another pattern to second cluster ==
+wrote 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== check second cluster ==
+read 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== corrupt image ==
+== check second cluster ==
+read 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== check the first cluster with self-repair ==
+Repairing duplicate offset in BAT entry 1
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== check second cluster ==
+read 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== write another pattern to the first clusters ==
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== check the first cluster ==
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== check the second cluster (deduplicated) ==
+read 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
 == TEST DATA_OFF CHECK ==
 == write pattern to first cluster ==
 wrote 1048576/1048576 bytes at offset 0
-- 
2.34.1


