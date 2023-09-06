Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 003DF7940D6
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 17:56:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdure-0006UK-TT; Wed, 06 Sep 2023 11:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdurU-0006Ps-Ia; Wed, 06 Sep 2023 11:54:37 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdurC-0003mk-8G; Wed, 06 Sep 2023 11:54:36 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qduo4-007ME4-2O;
 Wed, 06 Sep 2023 17:54:03 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@gmail.com,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Subject: [PULL 13/18] iotests: Add leak check test for parallels format
Date: Wed,  6 Sep 2023 17:54:08 +0200
Message-Id: <20230906155413.656644-4-den@openvz.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906155413.656644-1-den@openvz.org>
References: <20230906154942.656537-1-den@openvz.org>
 <20230906155413.656644-1-den@openvz.org>
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

From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

Write a pattern to the last cluster, extend the image by 1 claster, repair
and check that the last cluster still has the same pattern.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qemu-iotests/tests/parallels-checks     | 27 +++++++++++++++++++
 tests/qemu-iotests/tests/parallels-checks.out | 22 +++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/tests/qemu-iotests/tests/parallels-checks b/tests/qemu-iotests/tests/parallels-checks
index 055ce34766..8be282fabe 100755
--- a/tests/qemu-iotests/tests/parallels-checks
+++ b/tests/qemu-iotests/tests/parallels-checks
@@ -65,6 +65,33 @@ poke_file "$TEST_IMG" "$BAT_OFFSET" "\x$cluster\x00\x00\x00"
 echo "== read corrupted image with repairing =="
 { $QEMU_IO -c "read -P 0x00 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 
+# Clear image
+_make_test_img $SIZE
+
+echo "== TEST LEAK CHECK =="
+
+echo "== write pattern to last cluster =="
+echo "write -P 0x11 $LAST_CLUSTER_OFF $CLUSTER_SIZE"
+{ $QEMU_IO -c "write -P 0x11 $LAST_CLUSTER_OFF $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+file_size=`stat --printf="%s" "$TEST_IMG"`
+echo "file size: $file_size"
+
+echo "== extend image by 1 cluster =="
+fallocate -xl $((file_size + CLUSTER_SIZE)) "$TEST_IMG"
+
+file_size=`stat --printf="%s" "$TEST_IMG"`
+echo "file size: $file_size"
+
+echo "== repair image =="
+_check_test_img -r all
+
+file_size=`stat --printf="%s" "$TEST_IMG"`
+echo "file size: $file_size"
+
+echo "== check last cluster =="
+{ $QEMU_IO -c "read -P 0x11 $LAST_CLUSTER_OFF $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/tests/parallels-checks.out b/tests/qemu-iotests/tests/parallels-checks.out
index ea4dcef0a6..f2cb6dde85 100644
--- a/tests/qemu-iotests/tests/parallels-checks.out
+++ b/tests/qemu-iotests/tests/parallels-checks.out
@@ -9,4 +9,26 @@ wrote 4194304/4194304 bytes at offset 0
 Repairing cluster 0 is outside image
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
+== TEST LEAK CHECK ==
+== write pattern to last cluster ==
+write -P 0x11 3145728 1048576
+wrote 1048576/1048576 bytes at offset 3145728
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+file size: 2097152
+== extend image by 1 cluster ==
+file size: 3145728
+== repair image ==
+Repairing space leaked at the end of the image 1048576
+The following inconsistencies were found and repaired:
+
+    1 leaked clusters
+    0 corruptions
+
+Double checking the fixed image now...
+No errors were found on the image.
+file size: 2097152
+== check last cluster ==
+read 1048576/1048576 bytes at offset 3145728
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 *** done
-- 
2.34.1


