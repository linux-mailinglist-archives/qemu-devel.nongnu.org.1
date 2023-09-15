Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D37C7A263E
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 20:42:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhDl8-0004Vh-Dt; Fri, 15 Sep 2023 14:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qhDl5-0004SP-VM; Fri, 15 Sep 2023 14:41:39 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qhDl4-00038C-1k; Fri, 15 Sep 2023 14:41:39 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qhDhf-00Fs9Q-2d;
 Fri, 15 Sep 2023 20:41:32 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: stefanha@redhat.com, alexander.ivanov@virtuozzo.com,
 mike.maslenkin@gmail.com, "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 08/21] tests: ensure that image validation will not cure the
 corruption
Date: Fri, 15 Sep 2023 20:41:16 +0200
Message-Id: <20230915184130.403366-10-den@openvz.org>
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

Since
    commit cfce1091d55322789582480798a891cbaf66924e
    Author: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
    Date:   Tue Jul 18 12:44:29 2023 +0200
    parallels: Image repairing in parallels_open()
there is a potential pit fall with calling
    qemu-io -c "read"
The image is opened in read-write mode and thus could be potentially
repaired. This could ruin testing process.

The patch forces read-only opening for reads. In that case repairing
is impossible.

Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qemu-iotests/tests/parallels-checks | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/tests/parallels-checks b/tests/qemu-iotests/tests/parallels-checks
index a7a1b357b5..5917ee079d 100755
--- a/tests/qemu-iotests/tests/parallels-checks
+++ b/tests/qemu-iotests/tests/parallels-checks
@@ -91,7 +91,7 @@ file_size=`stat --printf="%s" "$TEST_IMG"`
 echo "file size: $file_size"
 
 echo "== check last cluster =="
-{ $QEMU_IO -c "read -P 0x11 $LAST_CLUSTER_OFF $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+{ $QEMU_IO -r -c "read -P 0x11 $LAST_CLUSTER_OFF $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 
 # Clear image
 _make_test_img $SIZE
@@ -105,19 +105,20 @@ echo "== write another pattern to second cluster =="
 { $QEMU_IO -c "write -P 0x55 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 
 echo "== check second cluster =="
-{ $QEMU_IO -c "read -P 0x55 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+{ $QEMU_IO -r -c "read -P 0x55 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
 
 echo "== corrupt image =="
 poke_file "$TEST_IMG" "$(($BAT_OFFSET + 4))" "\x01\x00\x00\x00"
 
 echo "== check second cluster =="
-{ $QEMU_IO -c "read -P 0x11 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+{ $QEMU_IO -r -c "read -P 0x11 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 
 echo "== repair image =="
 _check_test_img -r all
 
 echo "== check second cluster =="
-{ $QEMU_IO -c "read -P 0x11 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+{ $QEMU_IO -r -c "read -P 0x11 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 
 echo "== check first cluster on host =="
 printf "content: 0x%02x\n" `peek_file_le $TEST_IMG $(($CLUSTER_SIZE)) 1`
-- 
2.34.1


