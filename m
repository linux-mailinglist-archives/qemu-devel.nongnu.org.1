Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 014707D187E
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 23:58:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtxTx-0003r7-K3; Fri, 20 Oct 2023 17:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qtxTu-0003pN-AB; Fri, 20 Oct 2023 17:56:35 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qtxTq-0008G2-OS; Fri, 20 Oct 2023 17:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=xoAP6FRspQjKbgVizSw7Z47QzqhgL7NJIPq3ksUKjlQ=; b=CLcr3tGDzQpd
 4+NuWJAQd0mk3B2QF8YmZZhYCYO8AjI4AyqJbSAYXY/Qzfvj4gpmHsQnN1dV0XBQMmsmH2FaIkP6y
 QJF27wyG729GUXK6sxiERxKB/sNrytvWVDpA/ZI2OuUda73bZil9kDZ3MOi6DNFgnsluX7zWZe/Lx
 TTQ8p5MQh3I/mmZLPn5uZ9YyWSsGskQAKyH2xspoP9ok5EhcWagJIbE59HIGCzpwiwGH61idMoSYv
 5+5xv1kvxe0iey525ZoL2vZ06/G2daZd92vFvmgmm+NjhPSgpm8bKCyd7kWQq7iGW/TXBg5232wlU
 m5jFPanI66HdTSQUzOxkDQ==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1qtxTT-00A9pF-2n;
 Fri, 20 Oct 2023 23:56:20 +0200
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, andrey.drobyshev@virtuozzo.com,
 den@virtuozzo.com
Subject: [PATCH 7/7] iotests/271: check disk usage on subcluster-based
 discard/unmap
Date: Sat, 21 Oct 2023 00:56:22 +0300
Message-Id: <20231020215622.789260-8-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231020215622.789260-1-andrey.drobyshev@virtuozzo.com>
References: <20231020215622.789260-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Add _verify_du_delta() checker which is used to check that real disk
usage delta meets the expectations.  For now we use it for checking that
subcluster-based discard/unmap operations lead to actual disk usage
decrease (i.e. PUNCH_HOLE operation is performed).

Also add separate test case for discarding particular subcluster within
one cluster.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qemu-iotests/271     | 25 ++++++++++++++++++++++++-
 tests/qemu-iotests/271.out |  2 ++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/271 b/tests/qemu-iotests/271
index c7c2cadda0..5fcb209f5f 100755
--- a/tests/qemu-iotests/271
+++ b/tests/qemu-iotests/271
@@ -81,6 +81,15 @@ _verify_l2_bitmap()
     fi
 }
 
+# Check disk usage delta after a discard/unmap operation
+# _verify_du_delta $before $after $expected_delta
+_verify_du_delta()
+{
+    if [ $(($1 - $2)) -ne $3 ]; then
+        printf "ERROR: unexpected delta: $1 - $2 = $(($1 - $2)) != $3\n"
+    fi
+}
+
 # This should be called as _run_test c=XXX sc=XXX off=XXX len=XXX cmd=XXX
 # c:   cluster number (0 if unset)
 # sc:  subcluster number inside cluster @c (0 if unset)
@@ -198,9 +207,12 @@ for use_backing_file in yes no; do
     alloc="$(seq 0 31)"; zero=""
     _run_test sc=0 len=64k
 
-    ### Zero and unmap half of cluster #0 (this won't unmap it)
+    ### Zero and unmap half of cluster #0 (this will unmap it)
     alloc="$(seq 16 31)"; zero="$(seq 0 15)"
+    before=$(disk_usage "$TEST_IMG")
     _run_test sc=0 len=32k cmd=unmap
+    after=$(disk_usage "$TEST_IMG")
+    _verify_du_delta $before $after 32768
 
     ### Zero and unmap cluster #0
     alloc=""; zero="$(seq 0 31)"
@@ -447,7 +459,10 @@ for use_backing_file in yes no; do
 
     # Subcluster-aligned request from clusters #12 to #14
     alloc="$(seq 0 15)"; zero="$(seq 16 31)"
+    before=$(disk_usage "$TEST_IMG")
     _run_test c=12 sc=16 len=128k cmd=unmap
+    after=$(disk_usage "$TEST_IMG")
+    _verify_du_delta $before $after $((128 * 1024))
     alloc=""; zero="$(seq 0 31)"
     _verify_l2_bitmap 13
     alloc="$(seq 16 31)"; zero="$(seq 0 15)"
@@ -528,6 +543,14 @@ for use_backing_file in yes no; do
     else
         _make_test_img -o extended_l2=on 1M
     fi
+    # Write cluster #0 and discard its subclusters #0-#3
+    $QEMU_IO -c 'write -q 0 64k' "$TEST_IMG"
+    before=$(disk_usage "$TEST_IMG")
+    $QEMU_IO -c 'discard -q 0 8k' "$TEST_IMG"
+    after=$(disk_usage "$TEST_IMG")
+    _verify_du_delta $before $after 8192
+    alloc="$(seq 4 31)"; zero="$(seq 0 3)"
+    _verify_l2_bitmap 0
     # Write clusters #0-#2 and then discard them
     $QEMU_IO -c 'write -q 0 128k' "$TEST_IMG"
     $QEMU_IO -c 'discard -q 0 128k' "$TEST_IMG"
diff --git a/tests/qemu-iotests/271.out b/tests/qemu-iotests/271.out
index 5be780de76..0da8d72cde 100644
--- a/tests/qemu-iotests/271.out
+++ b/tests/qemu-iotests/271.out
@@ -426,6 +426,7 @@ L2 entry #29: 0x0000000000000000 0000ffff00000000
 ### Discarding clusters with non-zero bitmaps (backing file: yes) ###
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=raw
+L2 entry #0: 0x8000000000050000 0000000ffffffff0
 L2 entry #0: 0x0000000000000000 ffffffff00000000
 L2 entry #1: 0x0000000000000000 ffffffff00000000
 Image resized.
@@ -436,6 +437,7 @@ L2 entry #1: 0x0000000000000000 ffffffff00000000
 ### Discarding clusters with non-zero bitmaps (backing file: no) ###
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+L2 entry #0: 0x8000000000050000 0000000ffffffff0
 L2 entry #0: 0x0000000000000000 ffffffff00000000
 L2 entry #1: 0x0000000000000000 ffffffff00000000
 Image resized.
-- 
2.39.3


