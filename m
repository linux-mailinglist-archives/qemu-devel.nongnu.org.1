Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B114D7A022D
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 13:10:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgkEZ-0003ea-St; Thu, 14 Sep 2023 07:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1qgkEV-0003dr-VO; Thu, 14 Sep 2023 07:10:04 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1qgkET-0006GT-2t; Thu, 14 Sep 2023 07:10:03 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=debian.fritz.box)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1qgkB4-003B3F-2Y; Thu, 14 Sep 2023 13:09:55 +0200
To: qemu-block@nongnu.org,
	kwolf@redhat.com
Cc: hreitz@redhat.com,
	qemu-devel@nongnu.org,
	den@virtuozzo.com
Subject: [PATCH 2/2] iotests: add new test case for image streaming
Date: Thu, 14 Sep 2023 13:09:51 +0200
Message-Id: <20230914110951.845856-3-andrey.zhadchenko@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914110951.845856-1-andrey.zhadchenko@virtuozzo.com>
References: <20230914110951.845856-1-andrey.zhadchenko@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.zhadchenko@virtuozzo.com; helo=relay.virtuozzo.com
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
Reply-to:  Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
From:  Andrey Zhadchenko via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Check if we can list named block nodes when the block-stream is
finalized but not yet dismissed
This previously led to a crash

Signed-off-by: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
---
 tests/qemu-iotests/030     | 17 +++++++++++++++++
 tests/qemu-iotests/030.out |  4 ++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index 98595d47fe..2be407a8da 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -192,6 +192,23 @@ test_img = os.path.join(iotests.test_dir, 'test.img')
             self.assert_qmp(result, 'return', {})
 
 
+    def test_auto_dismiss(self):
+        result = self.vm.qmp('block-stream', device='drive0', auto_dismiss=False)
+        completed = False
+        while not completed:
+            for event in self.vm.get_qmp_events(wait=True):
+                self.assertNotEqual(event['event'], 'BLOCK_JOB_ERROR')
+                if event['event'] == 'BLOCK_JOB_COMPLETED':
+                    self.assert_qmp(event, 'data/device', 'drive0')
+                    completed = True
+                elif event['event'] == 'JOB_STATUS_CHANGE':
+                    self.assert_qmp(event, 'data/id', 'drive0')
+
+        result = self.vm.qmp('query-named-block-nodes')
+        result = self.vm.qmp('job-dismiss', id='drive0')
+        self.assert_qmp(result, 'return', {})
+
+
 class TestParallelOps(iotests.QMPTestCase):
     num_ops = 4 # Number of parallel block-stream operations
     num_imgs = num_ops * 2 + 1
diff --git a/tests/qemu-iotests/030.out b/tests/qemu-iotests/030.out
index 6d9bee1a4b..af8dac10f9 100644
--- a/tests/qemu-iotests/030.out
+++ b/tests/qemu-iotests/030.out
@@ -1,5 +1,5 @@
-...........................
+............................
 ----------------------------------------------------------------------
-Ran 27 tests
+Ran 28 tests
 
 OK
-- 
2.40.1


