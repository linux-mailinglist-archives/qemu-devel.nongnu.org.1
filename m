Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F86E79853D
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 11:57:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeYDk-0006xw-1t; Fri, 08 Sep 2023 05:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeYDZ-0006wt-Lu; Fri, 08 Sep 2023 05:56:01 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeYDW-0006OG-VO; Fri, 08 Sep 2023 05:56:01 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 30CDD200C9;
 Fri,  8 Sep 2023 12:56:45 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 294FB2690F;
 Fri,  8 Sep 2023 12:55:56 +0300 (MSK)
Received: (nullmailer pid 275943 invoked by uid 1000);
 Fri, 08 Sep 2023 09:55:55 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 01/23] qemu-img: omit errno value in error message
Date: Fri,  8 Sep 2023 12:54:58 +0300
Message-Id: <20230908095520.275866-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230908095520.275866-1-mjt@tls.msk.ru>
References: <20230908095520.275866-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

I'm getting io-qcow2-244 test failure on mips*
due to output mismatch:

  Take an internal snapshot:
 -qemu-img: Could not create snapshot 'test': -95 (Operation not supported)
 +qemu-img: Could not create snapshot 'test': -122 (Operation not supported)
  No errors were found on the image.

This is because errno values might be different across
different architectures.

This error message in qemu-img.c is the only one which
prints errno directly, all the rest print strerror(errno)
only.  Fix this error message and the expected output
of the 3 test cases too.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.c                 | 4 ++--
 tests/qemu-iotests/080.out | 6 +++---
 tests/qemu-iotests/112.out | 6 +++---
 tests/qemu-iotests/244.out | 2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 27f48051b0..0756dbb835 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3468,8 +3468,8 @@ static int img_snapshot(int argc, char **argv)
 
         ret = bdrv_snapshot_create(bs, &sn);
         if (ret) {
-            error_report("Could not create snapshot '%s': %d (%s)",
-                snapshot_name, ret, strerror(-ret));
+            error_report("Could not create snapshot '%s': %s",
+                snapshot_name, strerror(-ret));
         }
         break;
 
diff --git a/tests/qemu-iotests/080.out b/tests/qemu-iotests/080.out
index 45ab01db8e..d8acb3e723 100644
--- a/tests/qemu-iotests/080.out
+++ b/tests/qemu-iotests/080.out
@@ -33,7 +33,7 @@ qemu-io: can't open device TEST_DIR/t.qcow2: Snapshot table offset invalid
 
 == Hitting snapshot table size limit ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-qemu-img: Could not create snapshot 'test': -27 (File too large)
+qemu-img: Could not create snapshot 'test': File too large
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -56,8 +56,8 @@ qemu-io: can't open device TEST_DIR/t.qcow2: Backing file name too long
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-img: Could not create snapshot 'test': -27 (File too large)
-qemu-img: Could not create snapshot 'test': -11 (Resource temporarily unavailable)
+qemu-img: Could not create snapshot 'test': File too large
+qemu-img: Could not create snapshot 'test': Resource temporarily unavailable
 
 == Invalid snapshot L1 table offset ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
diff --git a/tests/qemu-iotests/112.out b/tests/qemu-iotests/112.out
index dd3cc4383c..ebf426febc 100644
--- a/tests/qemu-iotests/112.out
+++ b/tests/qemu-iotests/112.out
@@ -32,7 +32,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 refcount bits: 1
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-img: Could not create snapshot 'foo': -22 (Invalid argument)
+qemu-img: Could not create snapshot 'foo': Invalid argument
 Leaked cluster 6 refcount=1 reference=0
 
 1 leaked clusters were found on the image.
@@ -44,7 +44,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 refcount bits: 2
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-img: Could not create snapshot 'baz': -22 (Invalid argument)
+qemu-img: Could not create snapshot 'baz': Invalid argument
 Leaked cluster 7 refcount=1 reference=0
 
 1 leaked clusters were found on the image.
@@ -75,7 +75,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 refcount bits: 64
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-img: Could not create snapshot 'foo': -22 (Invalid argument)
+qemu-img: Could not create snapshot 'foo': Invalid argument
 Leaked cluster 5 refcount=18446744073709551615 reference=1
 Leaked cluster 6 refcount=1 reference=0
 
diff --git a/tests/qemu-iotests/244.out b/tests/qemu-iotests/244.out
index 5e03add054..4815a489b0 100644
--- a/tests/qemu-iotests/244.out
+++ b/tests/qemu-iotests/244.out
@@ -41,7 +41,7 @@ write failed: Operation not supported
 No errors were found on the image.
 
 Take an internal snapshot:
-qemu-img: Could not create snapshot 'test': -95 (Operation not supported)
+qemu-img: Could not create snapshot 'test': Operation not supported
 No errors were found on the image.
 
 === Standalone image with external data file (efficient) ===
-- 
2.39.2


