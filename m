Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BA07940D5
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 17:56:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdurf-0006Uw-6q; Wed, 06 Sep 2023 11:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdurT-0006Pc-NB; Wed, 06 Sep 2023 11:54:37 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdurC-0003nG-MW; Wed, 06 Sep 2023 11:54:35 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qduo5-007ME4-31;
 Wed, 06 Sep 2023 17:54:04 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@gmail.com,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Subject: [PULL 16/18] iotests: Fix cluster size in parallels images tests (131)
Date: Wed,  6 Sep 2023 17:54:11 +0200
Message-Id: <20230906155413.656644-7-den@openvz.org>
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

In this test cluster size is 64k, but modern tools generate images with
cluster size 1M. Calculate cluster size using track field from image header.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qemu-iotests/131     |  5 ++++-
 tests/qemu-iotests/131.out | 44 +++++++++++++++++++-------------------
 2 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/tests/qemu-iotests/131 b/tests/qemu-iotests/131
index 601546c84c..72f6535581 100755
--- a/tests/qemu-iotests/131
+++ b/tests/qemu-iotests/131
@@ -44,10 +44,13 @@ _supported_os Linux
 inuse_offset=$((0x2c))
 
 size=$((64 * 1024 * 1024))
-CLUSTER_SIZE=$((64 * 1024))
 IMGFMT=parallels
 _make_test_img $size
 
+# get cluster size in sectors from "tracks" header field
+CLUSTER_SIZE_OFFSET=28
+CLUSTER_SIZE=$(peek_file_le $TEST_IMG $CLUSTER_SIZE_OFFSET 4)
+CLUSTER_SIZE=$((CLUSTER_SIZE * 512))
 CLUSTER_HALF_SIZE=$((CLUSTER_SIZE / 2))
 CLUSTER_DBL_SIZE=$((CLUSTER_SIZE * 2))
 
diff --git a/tests/qemu-iotests/131.out b/tests/qemu-iotests/131.out
index de5ef7a8f5..98017a067e 100644
--- a/tests/qemu-iotests/131.out
+++ b/tests/qemu-iotests/131.out
@@ -1,26 +1,26 @@
 QA output created by 131
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 == read empty image ==
-read 65536/65536 bytes at offset 32768
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 1048576/1048576 bytes at offset 524288
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == write more than 1 block in a row ==
-wrote 131072/131072 bytes at offset 32768
-128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097152/2097152 bytes at offset 524288
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == read less than block ==
-read 32768/32768 bytes at offset 32768
-32 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 524288/524288 bytes at offset 524288
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == read exactly 1 block ==
-read 65536/65536 bytes at offset 65536
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == read more than 1 block ==
-read 131072/131072 bytes at offset 32768
-128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 2097152/2097152 bytes at offset 524288
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == check that there is no trash after written ==
-read 32768/32768 bytes at offset 163840
-32 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 524288/524288 bytes at offset 2621440
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == check that there is no trash before written ==
-read 32768/32768 bytes at offset 0
-32 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 524288/524288 bytes at offset 0
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == Corrupt image ==
 qemu-io: can't open device TEST_DIR/t.parallels: parallels: Image was not closed correctly; cannot be opened read/write
 ERROR image was not closed correctly
@@ -35,19 +35,19 @@ The following inconsistencies were found and repaired:
 
 Double checking the fixed image now...
 No errors were found on the image.
-read 65536/65536 bytes at offset 65536
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == allocate with backing ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
-wrote 65536/65536 bytes at offset 0
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 64/64 bytes at offset 0
 64 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 64/64 bytes at offset 0
 64 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 65472/65472 bytes at offset 64
-63.938 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 67043328/67043328 bytes at offset 65536
-63.938 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 1048512/1048512 bytes at offset 64
+1023.938 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 66060288/66060288 bytes at offset 1048576
+63 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 *** done
-- 
2.34.1


