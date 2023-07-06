Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C54E274A238
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 18:32:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHRtY-0000VH-Cd; Thu, 06 Jul 2023 12:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qHRso-0008Q2-LE; Thu, 06 Jul 2023 12:31:06 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qHRsg-0007Ps-2S; Thu, 06 Jul 2023 12:31:02 -0400
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1qHRrH-00D6CC-13;
 Thu, 06 Jul 2023 18:30:47 +0200
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com, fam@euphon.net,
 eblake@redhat.com, vsementsov@yandex-team.ru,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v2 3/3] qemu-iotests: update expected tests output to contain
 "compressed" field
Date: Thu,  6 Jul 2023 19:30:47 +0300
Message-Id: <20230706163047.128999-4-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230706163047.128999-1-andrey.drobyshev@virtuozzo.com>
References: <20230706163047.128999-1-andrey.drobyshev@virtuozzo.com>
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

The previous commit adds "compressed" boolean field to JSON output of
"qemu-img map" command.  Let's tweak expected tests output accordingly.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qemu-iotests/122.out                    |  84 ++++----
 tests/qemu-iotests/154.out                    | 194 +++++++++---------
 tests/qemu-iotests/179.out                    | 178 ++++++++--------
 tests/qemu-iotests/244.out                    |  24 +--
 tests/qemu-iotests/252.out                    |  10 +-
 tests/qemu-iotests/274.out                    |  48 ++---
 .../tests/nbd-qemu-allocation.out             |   6 +-
 7 files changed, 272 insertions(+), 272 deletions(-)

diff --git a/tests/qemu-iotests/122.out b/tests/qemu-iotests/122.out
index e18766e167..6a1aa3fe2b 100644
--- a/tests/qemu-iotests/122.out
+++ b/tests/qemu-iotests/122.out
@@ -67,12 +67,12 @@ read 65536/65536 bytes at offset 4194304
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 8388608
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true},
-{ "start": 65536, "length": 4128768, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 4194304, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true},
-{ "start": 4259840, "length": 4128768, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 8388608, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true},
-{ "start": 8454144, "length": 4128768, "depth": 0, "present": false, "zero": true, "data": false}]
+[{ "start": 0, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true, "compressed": true},
+{ "start": 65536, "length": 4128768, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 4194304, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true, "compressed": true},
+{ "start": 4259840, "length": 4128768, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 8388608, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true, "compressed": true},
+{ "start": 8454144, "length": 4128768, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 4194304
@@ -94,12 +94,12 @@ wrote 1024/1024 bytes at offset 1046528
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 1024/1024 bytes at offset 0
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true},
-{ "start": 65536, "length": 65536, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 131072, "length": 196608, "depth": 0, "present": true, "zero": false, "data": true},
-{ "start": 327680, "length": 655360, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 983040, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true},
-{ "start": 1048576, "length": 1046528, "depth": 0, "present": false, "zero": true, "data": false}]
+[{ "start": 0, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true, "compressed": true},
+{ "start": 65536, "length": 65536, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 131072, "length": 196608, "depth": 0, "present": true, "zero": false, "data": true, "compressed": true},
+{ "start": 327680, "length": 655360, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 983040, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true, "compressed": true},
+{ "start": 1048576, "length": 1046528, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]
 read 16384/16384 bytes at offset 0
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 16384/16384 bytes at offset 16384
@@ -130,14 +130,14 @@ read 3145728/3145728 bytes at offset 0
 3 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 63963136/63963136 bytes at offset 3145728
 61 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET}]
+[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
 
 convert -c -S 0:
 read 3145728/3145728 bytes at offset 0
 3 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 63963136/63963136 bytes at offset 3145728
 61 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": false, "data": true}]
+[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": false, "data": true, "compressed": true}]
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
 wrote 33554432/33554432 bytes at offset 0
 32 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -152,7 +152,7 @@ read 30408704/30408704 bytes at offset 3145728
 29 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 33554432/33554432 bytes at offset 33554432
 32 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET}]
+[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
 
 convert -c -S 0 with source backing file:
 read 3145728/3145728 bytes at offset 0
@@ -161,7 +161,7 @@ read 30408704/30408704 bytes at offset 3145728
 29 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 33554432/33554432 bytes at offset 33554432
 32 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": false, "data": true}]
+[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": false, "data": true, "compressed": true}]
 
 convert -S 0 -B ...
 read 3145728/3145728 bytes at offset 0
@@ -170,7 +170,7 @@ read 30408704/30408704 bytes at offset 3145728
 29 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 33554432/33554432 bytes at offset 33554432
 32 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET}]
+[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
 
 convert -c -S 0 -B ...
 read 3145728/3145728 bytes at offset 0
@@ -179,7 +179,7 @@ read 30408704/30408704 bytes at offset 3145728
 29 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 33554432/33554432 bytes at offset 33554432
 32 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": false, "data": true}]
+[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": false, "data": true, "compressed": true}]
 
 === Non-zero -S ===
 
@@ -196,32 +196,32 @@ wrote 1024/1024 bytes at offset 66560
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 convert -S 4k
-[{ "start": 0, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 4096, "length": 4096, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 8192, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 12288, "length": 4096, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 16384, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 20480, "length": 67088384, "depth": 0, "present": false, "zero": true, "data": false}]
+[{ "start": 0, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 4096, "length": 4096, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 8192, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 12288, "length": 4096, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 16384, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 20480, "length": 67088384, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]
 
 convert -c -S 4k
-[{ "start": 0, "length": 1024, "depth": 0, "present": true, "zero": false, "data": true},
-{ "start": 1024, "length": 7168, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 8192, "length": 1024, "depth": 0, "present": true, "zero": false, "data": true},
-{ "start": 9216, "length": 8192, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 17408, "length": 1024, "depth": 0, "present": true, "zero": false, "data": true},
-{ "start": 18432, "length": 67090432, "depth": 0, "present": false, "zero": true, "data": false}]
+[{ "start": 0, "length": 1024, "depth": 0, "present": true, "zero": false, "data": true, "compressed": true},
+{ "start": 1024, "length": 7168, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 8192, "length": 1024, "depth": 0, "present": true, "zero": false, "data": true, "compressed": true},
+{ "start": 9216, "length": 8192, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 17408, "length": 1024, "depth": 0, "present": true, "zero": false, "data": true, "compressed": true},
+{ "start": 18432, "length": 67090432, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]
 
 convert -S 8k
-[{ "start": 0, "length": 24576, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 24576, "length": 67084288, "depth": 0, "present": false, "zero": true, "data": false}]
+[{ "start": 0, "length": 24576, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 24576, "length": 67084288, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]
 
 convert -c -S 8k
-[{ "start": 0, "length": 1024, "depth": 0, "present": true, "zero": false, "data": true},
-{ "start": 1024, "length": 7168, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 8192, "length": 1024, "depth": 0, "present": true, "zero": false, "data": true},
-{ "start": 9216, "length": 8192, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 17408, "length": 1024, "depth": 0, "present": true, "zero": false, "data": true},
-{ "start": 18432, "length": 67090432, "depth": 0, "present": false, "zero": true, "data": false}]
+[{ "start": 0, "length": 1024, "depth": 0, "present": true, "zero": false, "data": true, "compressed": true},
+{ "start": 1024, "length": 7168, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 8192, "length": 1024, "depth": 0, "present": true, "zero": false, "data": true, "compressed": true},
+{ "start": 9216, "length": 8192, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 17408, "length": 1024, "depth": 0, "present": true, "zero": false, "data": true, "compressed": true},
+{ "start": 18432, "length": 67090432, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]
 
 === -n to a non-zero image ===
 
@@ -235,18 +235,18 @@ Images are identical.
 
 Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": true, "data": false}]
+[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-[{ "start": 0, "length": 67108864, "depth": 0, "present": false, "zero": true, "data": false}]
+[{ "start": 0, "length": 67108864, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]
 
 === -n to an empty image with a backing file ===
 
 Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
-[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": true, "data": false}]
+[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
-[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": false, "data": true, "offset": 327680}]
+[{ "start": 0, "length": 67108864, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": 327680}]
 
 === -n -B to an image without a backing file ===
 
diff --git a/tests/qemu-iotests/154.out b/tests/qemu-iotests/154.out
index 1fa7ffc475..0199269add 100644
--- a/tests/qemu-iotests/154.out
+++ b/tests/qemu-iotests/154.out
@@ -11,14 +11,14 @@ wrote 2048/2048 bytes at offset 17408
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 2048/2048 bytes at offset 27648
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 4096, "length": 4096, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 8192, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 12288, "length": 4096, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 16384, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 20480, "length": 4096, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 24576, "length": 8192, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 32768, "length": 134184960, "depth": 1, "present": false, "zero": true, "data": false}]
+[{ "start": 0, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 4096, "length": 4096, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 8192, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 12288, "length": 4096, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 16384, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 20480, "length": 4096, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 24576, "length": 8192, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 32768, "length": 134184960, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false}]
 
 == backing file contains non-zero data before write_zeroes ==
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
@@ -41,11 +41,11 @@ read 1024/1024 bytes at offset 65536
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 2048/2048 bytes at offset 67584
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 32768, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 32768, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 36864, "length": 28672, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 65536, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 69632, "length": 134148096, "depth": 1, "present": false, "zero": true, "data": false}]
+[{ "start": 0, "length": 32768, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 32768, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 36864, "length": 28672, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 65536, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 69632, "length": 134148096, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false}]
 
 == backing file contains non-zero data after write_zeroes ==
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
@@ -68,11 +68,11 @@ read 1024/1024 bytes at offset 44032
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 3072/3072 bytes at offset 40960
 3 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 32768, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 32768, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 36864, "length": 4096, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 40960, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 45056, "length": 134172672, "depth": 1, "present": false, "zero": true, "data": false}]
+[{ "start": 0, "length": 32768, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 32768, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 36864, "length": 4096, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 40960, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 45056, "length": 134172672, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false}]
 
 == write_zeroes covers non-zero data ==
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
@@ -101,15 +101,15 @@ wrote 2048/2048 bytes at offset 29696
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 4096/4096 bytes at offset 28672
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 4096, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 4096, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 8192, "length": 4096, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 12288, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 16384, "length": 4096, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 20480, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 24576, "length": 4096, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 28672, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 32768, "length": 134184960, "depth": 1, "present": false, "zero": true, "data": false}]
+[{ "start": 0, "length": 4096, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 4096, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 8192, "length": 4096, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 12288, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 16384, "length": 4096, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 20480, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 24576, "length": 4096, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 28672, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 32768, "length": 134184960, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false}]
 
 == spanning two clusters, non-zero before request ==
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
@@ -142,16 +142,16 @@ read 1024/1024 bytes at offset 67584
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 5120/5120 bytes at offset 68608
 5 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 32768, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 32768, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 36864, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 40960, "length": 8192, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 49152, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 53248, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 57344, "length": 8192, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 65536, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 69632, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 73728, "length": 134144000, "depth": 1, "present": false, "zero": true, "data": false}]
+[{ "start": 0, "length": 32768, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 32768, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 36864, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 40960, "length": 8192, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 49152, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 53248, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 57344, "length": 8192, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 65536, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 69632, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 73728, "length": 134144000, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false}]
 
 == spanning two clusters, non-zero after request ==
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
@@ -184,16 +184,16 @@ read 7168/7168 bytes at offset 65536
 7 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 1024/1024 bytes at offset 72704
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 32768, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 32768, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 36864, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 40960, "length": 8192, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 49152, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 53248, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 57344, "length": 8192, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 65536, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 69632, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 73728, "length": 134144000, "depth": 1, "present": false, "zero": true, "data": false}]
+[{ "start": 0, "length": 32768, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 32768, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 36864, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 40960, "length": 8192, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 49152, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 53248, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 57344, "length": 8192, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 65536, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 69632, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 73728, "length": 134144000, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false}]
 
 == spanning two clusters, partially overwriting backing file ==
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
@@ -212,8 +212,8 @@ read 1024/1024 bytes at offset 5120
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 2048/2048 bytes at offset 6144
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 8192, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 8192, "length": 134209536, "depth": 1, "present": false, "zero": true, "data": false}]
+[{ "start": 0, "length": 8192, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 8192, "length": 134209536, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false}]
 
 == spanning multiple clusters, non-zero in first cluster ==
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
@@ -226,10 +226,10 @@ read 2048/2048 bytes at offset 65536
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 10240/10240 bytes at offset 67584
 10 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 65536, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 65536, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 69632, "length": 8192, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 77824, "length": 134139904, "depth": 1, "present": false, "zero": true, "data": false}]
+[{ "start": 0, "length": 65536, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 65536, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 69632, "length": 8192, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 77824, "length": 134139904, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false}]
 
 == spanning multiple clusters, non-zero in intermediate cluster ==
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
@@ -240,9 +240,9 @@ wrote 7168/7168 bytes at offset 67584
 7 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 12288/12288 bytes at offset 65536
 12 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 65536, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 65536, "length": 12288, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 77824, "length": 134139904, "depth": 1, "present": false, "zero": true, "data": false}]
+[{ "start": 0, "length": 65536, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 65536, "length": 12288, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 77824, "length": 134139904, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false}]
 
 == spanning multiple clusters, non-zero in final cluster ==
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
@@ -255,10 +255,10 @@ read 10240/10240 bytes at offset 65536
 10 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 2048/2048 bytes at offset 75776
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 65536, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 65536, "length": 8192, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 73728, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 77824, "length": 134139904, "depth": 1, "present": false, "zero": true, "data": false}]
+[{ "start": 0, "length": 65536, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 65536, "length": 8192, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 73728, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 77824, "length": 134139904, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false}]
 
 == spanning multiple clusters, partially overwriting backing file ==
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
@@ -277,88 +277,88 @@ read 2048/2048 bytes at offset 74752
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 1024/1024 bytes at offset 76800
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 65536, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 65536, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 69632, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 73728, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 77824, "length": 134139904, "depth": 1, "present": false, "zero": true, "data": false}]
+[{ "start": 0, "length": 65536, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 65536, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 69632, "length": 4096, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 73728, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 77824, "length": 134139904, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false}]
 
 == unaligned image tail cluster, no allocation needed ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776
 wrote 512/512 bytes at offset 134217728
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
-[{ "start": 0, "length": 134217728, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false}]
+[{ "start": 0, "length": 134217728, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776
 wrote 512/512 bytes at offset 134219264
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
-[{ "start": 0, "length": 134217728, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false}]
+[{ "start": 0, "length": 134217728, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776
 wrote 1024/1024 bytes at offset 134218240
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
-[{ "start": 0, "length": 134217728, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false}]
+[{ "start": 0, "length": 134217728, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776
 wrote 2048/2048 bytes at offset 134217728
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
-[{ "start": 0, "length": 134217728, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false}]
+[{ "start": 0, "length": 134217728, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134218752
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 512/512 bytes at offset 134217728
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
-[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false}]
+[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 512/512 bytes at offset 134219264
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
-[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false}]
+[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 1024/1024 bytes at offset 134218240
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
-[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false}]
+[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 2048/2048 bytes at offset 134217728
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
-[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false}]
+[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
 wrote 512/512 bytes at offset 134217728
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 512/512 bytes at offset 134217728
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
-[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false}]
+[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 512/512 bytes at offset 134219264
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
-[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false}]
+[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 1024/1024 bytes at offset 134218240
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
-[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false}]
+[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 2048/2048 bytes at offset 134217728
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
-[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false}]
+[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134218752
 wrote 1024/1024 bytes at offset 134217728
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -369,15 +369,15 @@ read 512/512 bytes at offset 134217728
 read 512/512 bytes at offset 134218240
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 1024/1024 bytes allocated at offset 128 MiB
-[{ "start": 0, "length": 134217728, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 134217728, "length": 1024, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET}]
+[{ "start": 0, "length": 134217728, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 134217728, "length": 1024, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
 wrote 1024/1024 bytes at offset 134217728
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 1024/1024 bytes allocated at offset 128 MiB
 read 1024/1024 bytes at offset 134217728
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 134217728, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 134217728, "length": 1024, "depth": 0, "present": true, "zero": true, "data": false, "offset": OFFSET}]
+[{ "start": 0, "length": 134217728, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 134217728, "length": 1024, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET}]
 
 == unaligned image tail cluster, allocation required ==
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134218752
@@ -390,8 +390,8 @@ read 512/512 bytes at offset 134217728
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 1536/1536 bytes at offset 134218240
 1.500 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET}]
+[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134218752
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 512/512 bytes at offset 134218240
@@ -412,6 +412,6 @@ read 512/512 bytes at offset 134218240
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 1024/1024 bytes at offset 134218752
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET}]
+[{ "start": 0, "length": 134217728, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 134217728, "length": 2048, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
 *** done
diff --git a/tests/qemu-iotests/179.out b/tests/qemu-iotests/179.out
index 7cf22cd75f..65b909ebc2 100644
--- a/tests/qemu-iotests/179.out
+++ b/tests/qemu-iotests/179.out
@@ -13,11 +13,11 @@ wrote 2097152/2097152 bytes at offset 6291456
 2 MiB (0x200000) bytes not allocated at offset 4 MiB (0x400000)
 2 MiB (0x200000) bytes     allocated at offset 6 MiB (0x600000)
 56 MiB (0x3800000) bytes not allocated at offset 8 MiB (0x800000)
-[{ "start": 0, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 4194304, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 6291456, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 8388608, "length": 58720256, "depth": 0, "present": false, "zero": true, "data": false}]
+[{ "start": 0, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 4194304, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 6291456, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 8388608, "length": 58720256, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]
 wrote 2097150/2097150 bytes at offset 10485761
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 2097150/2097150 bytes at offset 14680065
@@ -31,15 +31,15 @@ wrote 2097150/2097150 bytes at offset 14680065
 2 MiB (0x200000) bytes not allocated at offset 12 MiB (0xc00000)
 2 MiB (0x200000) bytes     allocated at offset 14 MiB (0xe00000)
 48 MiB (0x3000000) bytes not allocated at offset 16 MiB (0x1000000)
-[{ "start": 0, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 4194304, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 6291456, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 8388608, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 10485760, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 12582912, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 14680064, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 16777216, "length": 50331648, "depth": 0, "present": false, "zero": true, "data": false}]
+[{ "start": 0, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 4194304, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 6291456, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 8388608, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 10485760, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 12582912, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 14680064, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 16777216, "length": 50331648, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]
 wrote 14680064/14680064 bytes at offset 18874368
 14 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 2097152/2097152 bytes at offset 20971520
@@ -57,21 +57,21 @@ wrote 6291456/6291456 bytes at offset 25165824
 2 MiB (0x200000) bytes not allocated at offset 16 MiB (0x1000000)
 14 MiB (0xe00000) bytes     allocated at offset 18 MiB (0x1200000)
 32 MiB (0x2000000) bytes not allocated at offset 32 MiB (0x2000000)
-[{ "start": 0, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 4194304, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 6291456, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 8388608, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 10485760, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 12582912, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 14680064, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 16777216, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 18874368, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 20971520, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 23068672, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 25165824, "length": 6291456, "depth": 0, "present": true, "zero": true, "data": false, "offset": OFFSET},
-{ "start": 31457280, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 33554432, "length": 33554432, "depth": 0, "present": false, "zero": true, "data": false}]
+[{ "start": 0, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 4194304, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 6291456, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 8388608, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 10485760, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 12582912, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 14680064, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 16777216, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 18874368, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 20971520, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 23068672, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 25165824, "length": 6291456, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET},
+{ "start": 31457280, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 33554432, "length": 33554432, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]
 wrote 2097152/2097152 bytes at offset 27262976
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 2097152/2097152 bytes at offset 29360128
@@ -87,23 +87,23 @@ wrote 2097152/2097152 bytes at offset 29360128
 2 MiB (0x200000) bytes not allocated at offset 16 MiB (0x1000000)
 14 MiB (0xe00000) bytes     allocated at offset 18 MiB (0x1200000)
 32 MiB (0x2000000) bytes not allocated at offset 32 MiB (0x2000000)
-[{ "start": 0, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 4194304, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 6291456, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 8388608, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 10485760, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 12582912, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 14680064, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 16777216, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 18874368, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 20971520, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 23068672, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 25165824, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "offset": OFFSET},
-{ "start": 27262976, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 29360128, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "offset": OFFSET},
-{ "start": 31457280, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 33554432, "length": 33554432, "depth": 0, "present": false, "zero": true, "data": false}]
+[{ "start": 0, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 4194304, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 6291456, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 8388608, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 10485760, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 12582912, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 14680064, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 16777216, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 18874368, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 20971520, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 23068672, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 25165824, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET},
+{ "start": 27262976, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 29360128, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET},
+{ "start": 31457280, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 33554432, "length": 33554432, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]
 wrote 8388608/8388608 bytes at offset 33554432
 8 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 2097152/2097152 bytes at offset 35651584
@@ -121,24 +121,24 @@ wrote 2097152/2097152 bytes at offset 37748736
 2 MiB (0x200000) bytes not allocated at offset 16 MiB (0x1000000)
 22 MiB (0x1600000) bytes     allocated at offset 18 MiB (0x1200000)
 24 MiB (0x1800000) bytes not allocated at offset 40 MiB (0x2800000)
-[{ "start": 0, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 4194304, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 6291456, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 8388608, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 10485760, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 12582912, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 14680064, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 16777216, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 18874368, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 20971520, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 23068672, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 25165824, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "offset": OFFSET},
-{ "start": 27262976, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 29360128, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "offset": OFFSET},
-{ "start": 31457280, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 33554432, "length": 8388608, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 41943040, "length": 25165824, "depth": 0, "present": false, "zero": true, "data": false}]
+[{ "start": 0, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 4194304, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 6291456, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 8388608, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 10485760, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 12582912, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 14680064, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 16777216, "length": 2097152, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 18874368, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 20971520, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 23068672, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 25165824, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET},
+{ "start": 27262976, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 29360128, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET},
+{ "start": 31457280, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 33554432, "length": 8388608, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 41943040, "length": 25165824, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]
 wrote 8388608/8388608 bytes at offset 41943040
 8 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 8388608/8388608 bytes at offset 50331648
@@ -162,31 +162,31 @@ wrote 2097152/2097152 bytes at offset 62914560
 4 MiB (0x400000) bytes not allocated at offset 54 MiB (0x3600000)
 4 MiB (0x400000) bytes     allocated at offset 58 MiB (0x3a00000)
 2 MiB (0x200000) bytes not allocated at offset 62 MiB (0x3e00000)
-[{ "start": 0, "length": 2097152, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 2097152, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false},
-{ "start": 4194304, "length": 2097152, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 6291456, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false},
-{ "start": 8388608, "length": 2097152, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 10485760, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false},
-{ "start": 12582912, "length": 2097152, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 14680064, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false},
-{ "start": 16777216, "length": 2097152, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 18874368, "length": 2097152, "depth": 1, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 20971520, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false},
-{ "start": 23068672, "length": 2097152, "depth": 1, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 25165824, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false, "offset": OFFSET},
-{ "start": 27262976, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false},
-{ "start": 29360128, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false, "offset": OFFSET},
-{ "start": 31457280, "length": 2097152, "depth": 1, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 33554432, "length": 10485760, "depth": 1, "present": true, "zero": true, "data": false},
-{ "start": 44040192, "length": 4194304, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 48234496, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false},
-{ "start": 50331648, "length": 2097152, "depth": 1, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 52428800, "length": 4194304, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 56623104, "length": 2097152, "depth": 1, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 58720256, "length": 2097152, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 60817408, "length": 4194304, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 65011712, "length": 2097152, "depth": 1, "present": false, "zero": true, "data": false}]
+[{ "start": 0, "length": 2097152, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 2097152, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 4194304, "length": 2097152, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 6291456, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 8388608, "length": 2097152, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 10485760, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 12582912, "length": 2097152, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 14680064, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 16777216, "length": 2097152, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 18874368, "length": 2097152, "depth": 1, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 20971520, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 23068672, "length": 2097152, "depth": 1, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 25165824, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET},
+{ "start": 27262976, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 29360128, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET},
+{ "start": 31457280, "length": 2097152, "depth": 1, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 33554432, "length": 10485760, "depth": 1, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 44040192, "length": 4194304, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 48234496, "length": 2097152, "depth": 1, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 50331648, "length": 2097152, "depth": 1, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 52428800, "length": 4194304, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 56623104, "length": 2097152, "depth": 1, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 58720256, "length": 2097152, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 60817408, "length": 4194304, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 65011712, "length": 2097152, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false}]
 No errors were found on the image.
 No errors were found on the image.
 
diff --git a/tests/qemu-iotests/244.out b/tests/qemu-iotests/244.out
index 5e03add054..38ffbd7e1e 100644
--- a/tests/qemu-iotests/244.out
+++ b/tests/qemu-iotests/244.out
@@ -57,12 +57,12 @@ wrote 3145728/3145728 bytes at offset 3145728
 3 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 No errors were found on the image.
 
-[{ "start": 0, "length": 1048576, "depth": 0, "present": false, "zero": true, "data": false},
-{ "start": 1048576, "length": 1048576, "depth": 0, "present": true, "zero": false, "data": true, "offset": 1048576},
-{ "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 4194304, "length": 1048576, "depth": 0, "present": true, "zero": true, "data": false, "offset": 4194304},
-{ "start": 5242880, "length": 1048576, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 6291456, "length": 60817408, "depth": 0, "present": false, "zero": true, "data": false}]
+[{ "start": 0, "length": 1048576, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 1048576, "length": 1048576, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": 1048576},
+{ "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 4194304, "length": 1048576, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": 4194304},
+{ "start": 5242880, "length": 1048576, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 6291456, "length": 60817408, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]
 
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -94,10 +94,10 @@ wrote 3145728/3145728 bytes at offset 3145728
 3 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 No errors were found on the image.
 
-[{ "start": 0, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": 0},
-{ "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 4194304, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "offset": 4194304},
-{ "start": 6291456, "length": 60817408, "depth": 0, "present": true, "zero": false, "data": true, "offset": 6291456}]
+[{ "start": 0, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": 0},
+{ "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 4194304, "length": 2097152, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": 4194304},
+{ "start": 6291456, "length": 60817408, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": 6291456}]
 
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -123,8 +123,8 @@ read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Offset          Length          Mapped to       File
 0               0x100000        0               TEST_DIR/t.qcow2.data
-[{ "start": 0, "length": 1048576, "depth": 0, "present": true, "zero": false, "data": true, "offset": 0},
-{ "start": 1048576, "length": 66060288, "depth": 0, "present": false, "zero": true, "data": false}]
+[{ "start": 0, "length": 1048576, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": 0},
+{ "start": 1048576, "length": 66060288, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]
 
 === Copy offloading ===
 
diff --git a/tests/qemu-iotests/252.out b/tests/qemu-iotests/252.out
index c578129c25..b1aa94cb05 100644
--- a/tests/qemu-iotests/252.out
+++ b/tests/qemu-iotests/252.out
@@ -23,8 +23,8 @@ read 131072/131072 bytes at offset 131072
 read 131072/131072 bytes at offset 262144
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
-[{ "start": 0, "length": 262144, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 262144, "length": 131072, "depth": 0, "present": false, "zero": true, "data": false}]
+[{ "start": 0, "length": 262144, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 262144, "length": 131072, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]
 
 read 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -33,7 +33,7 @@ read 131072/131072 bytes at offset 131072
 read 131072/131072 bytes at offset 262144
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
-[{ "start": 0, "length": 262144, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 262144, "length": 65536, "depth": 0, "present": true, "zero": true, "data": false},
-{ "start": 327680, "length": 65536, "depth": 1, "present": false, "zero": true, "data": false}]
+[{ "start": 0, "length": 262144, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 262144, "length": 65536, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false},
+{ "start": 327680, "length": 65536, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false}]
 *** done
diff --git a/tests/qemu-iotests/274.out b/tests/qemu-iotests/274.out
index acd8b166a6..c2967335ca 100644
--- a/tests/qemu-iotests/274.out
+++ b/tests/qemu-iotests/274.out
@@ -20,18 +20,18 @@ read 1048576/1048576 bytes at offset 1048576
 0/1048576 bytes allocated at offset 1 MiB
 
 === Checking map ===
-[{ "start": 0, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": 327680}]
+[{ "start": 0, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": 327680}]
 
 Offset          Length          Mapped to       File
 0               0x200000        0x50000         TEST_DIR/PID-base
 
-[{ "start": 0, "length": 1048576, "depth": 1, "present": true, "zero": false, "data": true, "offset": 327680}]
+[{ "start": 0, "length": 1048576, "depth": 1, "present": true, "zero": false, "data": true, "compressed": false, "offset": 327680}]
 
 Offset          Length          Mapped to       File
 0               0x100000        0x50000         TEST_DIR/PID-base
 
-[{ "start": 0, "length": 1048576, "depth": 2, "present": true, "zero": false, "data": true, "offset": 327680},
-{ "start": 1048576, "length": 1048576, "depth": 0, "present": false, "zero": true, "data": false}]
+[{ "start": 0, "length": 1048576, "depth": 2, "present": true, "zero": false, "data": true, "compressed": false, "offset": 327680},
+{ "start": 1048576, "length": 1048576, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]
 
 Offset          Length          Mapped to       File
 0               0x100000        0x50000         TEST_DIR/PID-base
@@ -186,8 +186,8 @@ read 65536/65536 bytes at offset 5368709120
 1 GiB (0x40000000) bytes not allocated at offset 0 bytes (0x0)
 7 GiB (0x1c0000000) bytes     allocated at offset 1 GiB (0x40000000)
 
-[{ "start": 0, "length": 1073741824, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 1073741824, "length": 7516192768, "depth": 0, "present": true, "zero": true, "data": false}]
+[{ "start": 0, "length": 1073741824, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 1073741824, "length": 7516192768, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
 
 === preallocation=metadata ===
 wrote 65536/65536 bytes at offset 33285996544
@@ -201,13 +201,13 @@ read 65536/65536 bytes at offset 33285996544
 30 GiB (0x780000000) bytes not allocated at offset 0 bytes (0x0)
 3 GiB (0xc0000000) bytes     allocated at offset 30 GiB (0x780000000)
 
-[{ "start": 0, "length": 32212254720, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 32212254720, "length": 536870912, "depth": 0, "present": true, "zero": true, "data": false, "offset": 327680},
-{ "start": 32749125632, "length": 536870912, "depth": 0, "present": true, "zero": true, "data": false, "offset": 537264128},
-{ "start": 33285996544, "length": 536870912, "depth": 0, "present": true, "zero": true, "data": false, "offset": 1074200576},
-{ "start": 33822867456, "length": 536870912, "depth": 0, "present": true, "zero": true, "data": false, "offset": 1611137024},
-{ "start": 34359738368, "length": 536870912, "depth": 0, "present": true, "zero": true, "data": false, "offset": 2148139008},
-{ "start": 34896609280, "length": 536870912, "depth": 0, "present": true, "zero": true, "data": false, "offset": 2685075456}]
+[{ "start": 0, "length": 32212254720, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 32212254720, "length": 536870912, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": 327680},
+{ "start": 32749125632, "length": 536870912, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": 537264128},
+{ "start": 33285996544, "length": 536870912, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": 1074200576},
+{ "start": 33822867456, "length": 536870912, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": 1611137024},
+{ "start": 34359738368, "length": 536870912, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": 2148139008},
+{ "start": 34896609280, "length": 536870912, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": 2685075456}]
 
 === preallocation=falloc ===
 wrote 65536/65536 bytes at offset 9437184
@@ -221,8 +221,8 @@ read 65536/65536 bytes at offset 9437184
 5 MiB (0x500000) bytes not allocated at offset 0 bytes (0x0)
 10 MiB (0xa00000) bytes     allocated at offset 5 MiB (0x500000)
 
-[{ "start": 0, "length": 5242880, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 5242880, "length": 10485760, "depth": 0, "present": true, "zero": false, "data": true, "offset": 327680}]
+[{ "start": 0, "length": 5242880, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 5242880, "length": 10485760, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": 327680}]
 
 === preallocation=full ===
 wrote 65536/65536 bytes at offset 11534336
@@ -236,8 +236,8 @@ read 65536/65536 bytes at offset 11534336
 8 MiB (0x800000) bytes not allocated at offset 0 bytes (0x0)
 4 MiB (0x400000) bytes     allocated at offset 8 MiB (0x800000)
 
-[{ "start": 0, "length": 8388608, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 8388608, "length": 4194304, "depth": 0, "present": true, "zero": false, "data": true, "offset": 327680}]
+[{ "start": 0, "length": 8388608, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 8388608, "length": 4194304, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": 327680}]
 
 === preallocation=off ===
 wrote 65536/65536 bytes at offset 259072
@@ -251,9 +251,9 @@ read 65536/65536 bytes at offset 259072
 192 KiB (0x30000) bytes not allocated at offset 0 bytes (0x0)
 320 KiB (0x50000) bytes     allocated at offset 192 KiB (0x30000)
 
-[{ "start": 0, "length": 196608, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 196608, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true, "offset": 327680},
-{ "start": 262144, "length": 262144, "depth": 0, "present": true, "zero": true, "data": false}]
+[{ "start": 0, "length": 196608, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 196608, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": 327680},
+{ "start": 262144, "length": 262144, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
 
 === preallocation=off ===
 wrote 65536/65536 bytes at offset 344064
@@ -267,8 +267,8 @@ read 65536/65536 bytes at offset 344064
 256 KiB (0x40000) bytes not allocated at offset 0 bytes (0x0)
 256 KiB (0x40000) bytes     allocated at offset 256 KiB (0x40000)
 
-[{ "start": 0, "length": 262144, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 262144, "length": 262144, "depth": 0, "present": true, "zero": true, "data": false}]
+[{ "start": 0, "length": 262144, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 262144, "length": 262144, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
 
 === preallocation=off ===
 wrote 65536/65536 bytes at offset 446464
@@ -282,6 +282,6 @@ read 65536/65536 bytes at offset 446464
 256 KiB (0x40000) bytes not allocated at offset 0 bytes (0x0)
 244 KiB (0x3d000) bytes     allocated at offset 256 KiB (0x40000)
 
-[{ "start": 0, "length": 262144, "depth": 1, "present": false, "zero": true, "data": false},
-{ "start": 262144, "length": 249856, "depth": 0, "present": true, "zero": true, "data": false}]
+[{ "start": 0, "length": 262144, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false},
+{ "start": 262144, "length": 249856, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
 
diff --git a/tests/qemu-iotests/tests/nbd-qemu-allocation.out b/tests/qemu-iotests/tests/nbd-qemu-allocation.out
index 9d938db24e..c1e60277f2 100644
--- a/tests/qemu-iotests/tests/nbd-qemu-allocation.out
+++ b/tests/qemu-iotests/tests/nbd-qemu-allocation.out
@@ -11,9 +11,9 @@ wrote 2097152/2097152 bytes at offset 1048576
 
 === Check allocation over NBD ===
 
-[{ "start": 0, "length": 1048576, "depth": 1, "present": true, "zero": false, "data": true, "offset": 327680},
-{ "start": 1048576, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": 327680},
-{ "start": 3145728, "length": 1048576, "depth": 1, "present": false, "zero": true, "data": false}]
+[{ "start": 0, "length": 1048576, "depth": 1, "present": true, "zero": false, "data": true, "compressed": false, "offset": 327680},
+{ "start": 1048576, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": 327680},
+{ "start": 3145728, "length": 1048576, "depth": 1, "present": false, "zero": true, "data": false, "compressed": false}]
 exports available: 1
  export: ''
   size:  4194304
-- 
2.39.3


