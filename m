Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BEB7940D2
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 17:55:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdurd-0006Qt-Nx; Wed, 06 Sep 2023 11:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdurS-0006PJ-26; Wed, 06 Sep 2023 11:54:35 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdurC-0003mo-1O; Wed, 06 Sep 2023 11:54:33 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qduo5-007ME4-1i;
 Wed, 06 Sep 2023 17:54:04 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@gmail.com,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Subject: [PULL 15/18] iotests: Refactor tests of parallels images checks (131)
Date: Wed,  6 Sep 2023 17:54:10 +0200
Message-Id: <20230906155413.656644-6-den@openvz.org>
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

Replace hardcoded numbers by variables.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qemu-iotests/131 | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/tests/qemu-iotests/131 b/tests/qemu-iotests/131
index a847692b4c..601546c84c 100755
--- a/tests/qemu-iotests/131
+++ b/tests/qemu-iotests/131
@@ -44,31 +44,34 @@ _supported_os Linux
 inuse_offset=$((0x2c))
 
 size=$((64 * 1024 * 1024))
-CLUSTER_SIZE=64k
+CLUSTER_SIZE=$((64 * 1024))
 IMGFMT=parallels
 _make_test_img $size
 
+CLUSTER_HALF_SIZE=$((CLUSTER_SIZE / 2))
+CLUSTER_DBL_SIZE=$((CLUSTER_SIZE * 2))
+
 echo == read empty image ==
-{ $QEMU_IO -c "read -P 0 32k 64k" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+{ $QEMU_IO -c "read -P 0 $CLUSTER_HALF_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 echo == write more than 1 block in a row ==
-{ $QEMU_IO -c "write -P 0x11 32k 128k" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+{ $QEMU_IO -c "write -P 0x11 $CLUSTER_HALF_SIZE $CLUSTER_DBL_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 echo == read less than block ==
-{ $QEMU_IO -c "read -P 0x11 32k 32k" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+{ $QEMU_IO -c "read -P 0x11 $CLUSTER_HALF_SIZE $CLUSTER_HALF_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 echo == read exactly 1 block ==
-{ $QEMU_IO -c "read -P 0x11 64k 64k" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+{ $QEMU_IO -c "read -P 0x11 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 echo == read more than 1 block ==
-{ $QEMU_IO -c "read -P 0x11 32k 128k" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+{ $QEMU_IO -c "read -P 0x11 $CLUSTER_HALF_SIZE $CLUSTER_DBL_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 echo == check that there is no trash after written ==
-{ $QEMU_IO -c "read -P 0 160k 32k" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+{ $QEMU_IO -c "read -P 0 $((CLUSTER_HALF_SIZE + CLUSTER_DBL_SIZE)) $CLUSTER_HALF_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 echo == check that there is no trash before written ==
-{ $QEMU_IO -c "read -P 0 0 32k" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+{ $QEMU_IO -c "read -P 0 0 $CLUSTER_HALF_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 
 echo "== Corrupt image =="
 poke_file "$TEST_IMG" "$inuse_offset" "\x59\x6e\x6f\x74"
-{ $QEMU_IO -c "read -P 0x11 64k 64k" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+{ $QEMU_IO -c "read -P 0x11 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 _check_test_img
 _check_test_img -r all
-{ $QEMU_IO -c "read -P 0x11 64k 64k" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+{ $QEMU_IO -c "read -P 0x11 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 
 echo "== allocate with backing =="
 # Verify that allocating clusters works fine even when there is a backing image.
@@ -83,7 +86,7 @@ TEST_IMG="$TEST_IMG.base" _make_test_img $size
 
 # Write some data to the base image (which would trigger an assertion failure if
 # interpreted as a QEMUIOVector)
-$QEMU_IO -c 'write -P 42 0 64k' "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IO -c "write -P 42 0 $CLUSTER_SIZE" "$TEST_IMG.base" | _filter_qemu_io
 
 # Parallels does not seem to support storing a backing filename in the image
 # itself, so we need to build our backing chain on the command line
@@ -99,8 +102,8 @@ QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT \
 QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT \
     $QEMU_IO --image-opts "$imgopts" \
     -c 'read -P 1 0 64' \
-    -c "read -P 42 64 $((64 * 1024 - 64))" \
-    -c "read -P 0 64k $((size - 64 * 1024))" \
+    -c "read -P 42 64 $((CLUSTER_SIZE - 64))" \
+    -c "read -P 0 $CLUSTER_SIZE $((size - CLUSTER_SIZE))" \
     | _filter_qemu_io
 
 # success, all done
-- 
2.34.1


