Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A60447A2162
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 16:48:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhA3W-0000Sr-3X; Fri, 15 Sep 2023 10:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qhA3M-0000GJ-4b
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:44:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qhA3H-00054T-Au
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694789050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jh4kljrr9SeFUP69cUCk2aTRn89Uu1v8ZzpmMOQk49o=;
 b=fJjlB/d6JJYOn7QwmT8iXlaR5AiABebNkLwuWbpEb2FhJD2fxHhPe1J+zhFGW0SB6WkV0b
 finibFrX78tjG7PYN/xMj11S/kBOPso5SBg8SI9Nd4b3KshO6EqbiS2v1QfQmi+gib0IXV
 ToL2/iNcBI88tFYH6fkBvEUg4+pvgX8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-Ch2MJFaAPYiyMfqrugTq6Q-1; Fri, 15 Sep 2023 10:44:08 -0400
X-MC-Unique: Ch2MJFaAPYiyMfqrugTq6Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DCD2418162CE;
 Fri, 15 Sep 2023 14:44:07 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.146])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 09BBB2026D4B;
 Fri, 15 Sep 2023 14:44:06 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 23/28] qemu-img: map: report compressed data blocks
Date: Fri, 15 Sep 2023 16:43:39 +0200
Message-ID: <20230915144344.238596-24-kwolf@redhat.com>
In-Reply-To: <20230915144344.238596-1-kwolf@redhat.com>
References: <20230915144344.238596-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Andrey Drobyshev via <qemu-block@nongnu.org>

Right now "qemu-img map" reports compressed blocks as containing data
but having no host offset.  This is not very informative.  Instead,
let's add another boolean field named "compressed" in case JSON output
mode is specified.  This is achieved by utilizing new allocation status
flag BDRV_BLOCK_COMPRESSED for bdrv_block_status().

Also update the expected qemu-iotests outputs to contain the new field.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Message-ID: <20230907210226.953821-3-andrey.drobyshev@virtuozzo.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json                          |   6 +-
 qemu-img.c                                    |   8 +-
 tests/qemu-iotests/122.out                    |  84 +-
 tests/qemu-iotests/146.out                    | 780 +++++++++---------
 tests/qemu-iotests/154.out                    | 194 ++---
 tests/qemu-iotests/179.out                    | 178 ++--
 tests/qemu-iotests/209.out                    |   4 +-
 tests/qemu-iotests/221.out                    |  16 +-
 tests/qemu-iotests/223.out                    |  60 +-
 tests/qemu-iotests/241.out                    |  10 +-
 tests/qemu-iotests/244.out                    |  24 +-
 tests/qemu-iotests/252.out                    |  10 +-
 tests/qemu-iotests/253.out                    |  20 +-
 tests/qemu-iotests/274.out                    |  48 +-
 .../tests/nbd-qemu-allocation.out             |  16 +-
 tests/qemu-iotests/tests/qemu-img-bitmaps.out |  24 +-
 16 files changed, 744 insertions(+), 738 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 2b1d493d6e..89751d81f2 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -409,6 +409,8 @@
 #
 # @zero: whether the virtual blocks read as zeroes
 #
+# @compressed: true if the data is stored compressed (since 8.2)
+#
 # @depth: number of layers (0 = top image, 1 = top image's backing
 #     file, ..., n - 1 = bottom image (where n is the number of images
 #     in the chain)) before reaching one for which the range is
@@ -426,8 +428,8 @@
 ##
 { 'struct': 'MapEntry',
   'data': {'start': 'int', 'length': 'int', 'data': 'bool',
-           'zero': 'bool', 'depth': 'int', 'present': 'bool',
-           '*offset': 'int', '*filename': 'str' } }
+           'zero': 'bool', 'compressed': 'bool', 'depth': 'int',
+           'present': 'bool', '*offset': 'int', '*filename': 'str' } }
 
 ##
 # @BlockdevCacheInfo:
diff --git a/qemu-img.c b/qemu-img.c
index 0756dbb835..a48edb7101 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3108,10 +3108,12 @@ static int dump_map_entry(OutputFormat output_format, MapEntry *e,
     case OFORMAT_JSON:
         printf("{ \"start\": %"PRId64", \"length\": %"PRId64","
                " \"depth\": %"PRId64", \"present\": %s, \"zero\": %s,"
-               " \"data\": %s", e->start, e->length, e->depth,
+               " \"data\": %s, \"compressed\": %s",
+               e->start, e->length, e->depth,
                e->present ? "true" : "false",
                e->zero ? "true" : "false",
-               e->data ? "true" : "false");
+               e->data ? "true" : "false",
+               e->compressed ? "true" : "false");
         if (e->has_offset) {
             printf(", \"offset\": %"PRId64"", e->offset);
         }
@@ -3172,6 +3174,7 @@ static int get_block_status(BlockDriverState *bs, int64_t offset,
         .length = bytes,
         .data = !!(ret & BDRV_BLOCK_DATA),
         .zero = !!(ret & BDRV_BLOCK_ZERO),
+        .compressed = !!(ret & BDRV_BLOCK_COMPRESSED),
         .offset = map,
         .has_offset = has_offset,
         .depth = depth,
@@ -3189,6 +3192,7 @@ static inline bool entry_mergeable(const MapEntry *curr, const MapEntry *next)
     }
     if (curr->zero != next->zero ||
         curr->data != next->data ||
+        curr->compressed != next->compressed ||
         curr->depth != next->depth ||
         curr->present != next->present ||
         !curr->filename != !next->filename ||
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
 
diff --git a/tests/qemu-iotests/146.out b/tests/qemu-iotests/146.out
index dfd6c77140..a48804154e 100644
--- a/tests/qemu-iotests/146.out
+++ b/tests/qemu-iotests/146.out
@@ -2,414 +2,414 @@ QA output created by 146
 
 === Testing VPC Autodetect ===
 
-[{ "start": 0, "length": 136363130880, "depth": 0, "present": true, "zero": true, "data": false}]
+[{ "start": 0, "length": 136363130880, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
 
 === Testing VPC with current_size force ===
 
-[{ "start": 0, "length": 136365211648, "depth": 0, "present": true, "zero": true, "data": false}]
+[{ "start": 0, "length": 136365211648, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
 
 === Testing VPC with chs force ===
 
-[{ "start": 0, "length": 136363130880, "depth": 0, "present": true, "zero": true, "data": false}]
+[{ "start": 0, "length": 136363130880, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
 
 === Testing Hyper-V Autodetect ===
 
-[{ "start": 0, "length": 136365211648, "depth": 0, "present": true, "zero": true, "data": false}]
+[{ "start": 0, "length": 136365211648, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
 
 === Testing Hyper-V with current_size force ===
 
-[{ "start": 0, "length": 136365211648, "depth": 0, "present": true, "zero": true, "data": false}]
+[{ "start": 0, "length": 136365211648, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
 
 === Testing Hyper-V with chs force ===
 
-[{ "start": 0, "length": 136363130880, "depth": 0, "present": true, "zero": true, "data": false}]
+[{ "start": 0, "length": 136363130880, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
 
 === Testing d2v Autodetect ===
 
-[{ "start": 0, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 4194304, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 6291456, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 8388608, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 10485760, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 12582912, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 14680064, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 16777216, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 18874368, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 20971520, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 23068672, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 25165824, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 27262976, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 29360128, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 31457280, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 33554432, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 35651584, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 37748736, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 39845888, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 41943040, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 44040192, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 46137344, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 48234496, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 50331648, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 52428800, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 54525952, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 56623104, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 58720256, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 60817408, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 62914560, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 65011712, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 67108864, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 69206016, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 71303168, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 73400320, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 75497472, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 77594624, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 79691776, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 81788928, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 83886080, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 85983232, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 88080384, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 90177536, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 92274688, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 94371840, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 96468992, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 98566144, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 100663296, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 102760448, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 104857600, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 106954752, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 109051904, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 111149056, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 113246208, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 115343360, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 117440512, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 119537664, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 121634816, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 123731968, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 125829120, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 127926272, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 130023424, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 132120576, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 134217728, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 136314880, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 138412032, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 140509184, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 142606336, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 144703488, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 146800640, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 148897792, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 150994944, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 153092096, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 155189248, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 157286400, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 159383552, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 161480704, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 163577856, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 165675008, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 167772160, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 169869312, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 171966464, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 174063616, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 176160768, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 178257920, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 180355072, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 182452224, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 184549376, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 186646528, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 188743680, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 190840832, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 192937984, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 195035136, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 197132288, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 199229440, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 201326592, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 203423744, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 205520896, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 207618048, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 209715200, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 211812352, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 213909504, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 216006656, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 218103808, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 220200960, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 222298112, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 224395264, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 226492416, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 228589568, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 230686720, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 232783872, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 234881024, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 236978176, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 239075328, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 241172480, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 243269632, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 245366784, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 247463936, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 249561088, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 251658240, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 253755392, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 255852544, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 257949696, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 260046848, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 262144000, "length": 1310720, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET}]
+[{ "start": 0, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 4194304, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 6291456, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 8388608, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 10485760, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 12582912, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 14680064, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 16777216, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 18874368, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 20971520, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 23068672, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 25165824, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 27262976, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 29360128, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 31457280, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 33554432, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 35651584, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 37748736, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 39845888, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 41943040, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 44040192, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 46137344, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 48234496, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 50331648, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 52428800, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 54525952, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 56623104, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 58720256, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 60817408, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 62914560, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 65011712, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 67108864, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 69206016, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 71303168, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 73400320, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 75497472, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 77594624, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 79691776, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 81788928, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 83886080, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 85983232, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 88080384, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 90177536, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 92274688, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 94371840, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 96468992, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 98566144, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 100663296, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 102760448, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 104857600, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 106954752, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 109051904, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 111149056, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 113246208, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 115343360, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 117440512, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 119537664, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 121634816, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 123731968, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 125829120, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 127926272, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 130023424, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 132120576, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 134217728, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 136314880, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 138412032, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 140509184, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 142606336, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 144703488, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 146800640, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 148897792, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 150994944, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 153092096, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 155189248, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 157286400, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 159383552, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 161480704, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 163577856, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 165675008, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 167772160, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 169869312, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 171966464, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 174063616, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 176160768, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 178257920, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 180355072, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 182452224, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 184549376, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 186646528, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 188743680, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 190840832, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 192937984, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 195035136, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 197132288, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 199229440, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 201326592, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 203423744, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 205520896, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 207618048, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 209715200, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 211812352, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 213909504, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 216006656, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 218103808, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 220200960, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 222298112, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 224395264, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 226492416, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 228589568, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 230686720, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 232783872, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 234881024, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 236978176, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 239075328, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 241172480, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 243269632, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 245366784, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 247463936, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 249561088, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 251658240, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 253755392, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 255852544, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 257949696, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 260046848, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 262144000, "length": 1310720, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
 
 === Testing d2v with current_size force ===
 
-[{ "start": 0, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 4194304, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 6291456, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 8388608, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 10485760, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 12582912, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 14680064, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 16777216, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 18874368, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 20971520, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 23068672, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 25165824, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 27262976, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 29360128, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 31457280, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 33554432, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 35651584, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 37748736, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 39845888, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 41943040, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 44040192, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 46137344, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 48234496, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 50331648, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 52428800, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 54525952, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 56623104, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 58720256, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 60817408, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 62914560, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 65011712, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 67108864, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 69206016, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 71303168, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 73400320, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 75497472, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 77594624, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 79691776, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 81788928, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 83886080, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 85983232, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 88080384, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 90177536, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 92274688, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 94371840, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 96468992, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 98566144, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 100663296, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 102760448, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 104857600, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 106954752, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 109051904, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 111149056, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 113246208, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 115343360, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 117440512, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 119537664, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 121634816, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 123731968, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 125829120, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 127926272, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 130023424, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 132120576, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 134217728, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 136314880, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 138412032, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 140509184, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 142606336, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 144703488, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 146800640, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 148897792, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 150994944, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 153092096, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 155189248, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 157286400, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 159383552, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 161480704, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 163577856, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 165675008, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 167772160, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 169869312, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 171966464, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 174063616, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 176160768, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 178257920, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 180355072, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 182452224, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 184549376, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 186646528, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 188743680, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 190840832, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 192937984, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 195035136, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 197132288, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 199229440, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 201326592, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 203423744, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 205520896, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 207618048, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 209715200, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 211812352, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 213909504, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 216006656, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 218103808, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 220200960, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 222298112, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 224395264, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 226492416, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 228589568, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 230686720, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 232783872, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 234881024, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 236978176, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 239075328, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 241172480, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 243269632, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 245366784, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 247463936, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 249561088, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 251658240, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 253755392, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 255852544, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 257949696, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 260046848, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 262144000, "length": 1310720, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET}]
+[{ "start": 0, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 4194304, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 6291456, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 8388608, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 10485760, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 12582912, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 14680064, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 16777216, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 18874368, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 20971520, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 23068672, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 25165824, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 27262976, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 29360128, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 31457280, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 33554432, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 35651584, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 37748736, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 39845888, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 41943040, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 44040192, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 46137344, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 48234496, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 50331648, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 52428800, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 54525952, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 56623104, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 58720256, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 60817408, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 62914560, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 65011712, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 67108864, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 69206016, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 71303168, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 73400320, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 75497472, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 77594624, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 79691776, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 81788928, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 83886080, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 85983232, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 88080384, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 90177536, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 92274688, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 94371840, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 96468992, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 98566144, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 100663296, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 102760448, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 104857600, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 106954752, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 109051904, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 111149056, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 113246208, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 115343360, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 117440512, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 119537664, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 121634816, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 123731968, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 125829120, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 127926272, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 130023424, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 132120576, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 134217728, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 136314880, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 138412032, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 140509184, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 142606336, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 144703488, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 146800640, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 148897792, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 150994944, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 153092096, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 155189248, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 157286400, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 159383552, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 161480704, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 163577856, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 165675008, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 167772160, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 169869312, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 171966464, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 174063616, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 176160768, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 178257920, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 180355072, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 182452224, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 184549376, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 186646528, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 188743680, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 190840832, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 192937984, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 195035136, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 197132288, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 199229440, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 201326592, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 203423744, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 205520896, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 207618048, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 209715200, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 211812352, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 213909504, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 216006656, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 218103808, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 220200960, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 222298112, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 224395264, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 226492416, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 228589568, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 230686720, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 232783872, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 234881024, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 236978176, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 239075328, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 241172480, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 243269632, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 245366784, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 247463936, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 249561088, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 251658240, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 253755392, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 255852544, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 257949696, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 260046848, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 262144000, "length": 1310720, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
 
 === Testing d2v with chs force ===
 
-[{ "start": 0, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 4194304, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 6291456, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 8388608, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 10485760, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 12582912, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 14680064, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 16777216, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 18874368, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 20971520, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 23068672, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 25165824, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 27262976, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 29360128, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 31457280, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 33554432, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 35651584, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 37748736, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 39845888, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 41943040, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 44040192, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 46137344, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 48234496, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 50331648, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 52428800, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 54525952, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 56623104, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 58720256, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 60817408, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 62914560, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 65011712, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 67108864, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 69206016, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 71303168, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 73400320, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 75497472, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 77594624, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 79691776, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 81788928, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 83886080, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 85983232, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 88080384, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 90177536, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 92274688, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 94371840, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 96468992, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 98566144, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 100663296, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 102760448, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 104857600, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 106954752, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 109051904, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 111149056, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 113246208, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 115343360, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 117440512, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 119537664, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 121634816, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 123731968, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 125829120, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 127926272, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 130023424, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 132120576, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 134217728, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 136314880, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 138412032, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 140509184, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 142606336, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 144703488, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 146800640, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 148897792, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 150994944, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 153092096, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 155189248, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 157286400, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 159383552, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 161480704, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 163577856, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 165675008, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 167772160, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 169869312, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 171966464, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 174063616, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 176160768, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 178257920, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 180355072, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 182452224, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 184549376, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 186646528, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 188743680, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 190840832, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 192937984, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 195035136, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 197132288, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 199229440, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 201326592, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 203423744, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 205520896, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 207618048, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 209715200, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 211812352, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 213909504, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 216006656, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 218103808, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 220200960, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 222298112, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 224395264, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 226492416, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 228589568, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 230686720, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 232783872, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 234881024, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 236978176, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 239075328, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 241172480, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 243269632, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 245366784, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 247463936, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 249561088, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 251658240, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 253755392, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 255852544, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 257949696, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 260046848, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 262144000, "length": 1310720, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET}]
+[{ "start": 0, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 2097152, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 4194304, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 6291456, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 8388608, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 10485760, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 12582912, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 14680064, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 16777216, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 18874368, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 20971520, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 23068672, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 25165824, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 27262976, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 29360128, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 31457280, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 33554432, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 35651584, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 37748736, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 39845888, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 41943040, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 44040192, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 46137344, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 48234496, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 50331648, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 52428800, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 54525952, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 56623104, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 58720256, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 60817408, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 62914560, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 65011712, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 67108864, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 69206016, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 71303168, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 73400320, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 75497472, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 77594624, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 79691776, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 81788928, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 83886080, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 85983232, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 88080384, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 90177536, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 92274688, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 94371840, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 96468992, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 98566144, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 100663296, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 102760448, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 104857600, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 106954752, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 109051904, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 111149056, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 113246208, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 115343360, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 117440512, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 119537664, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 121634816, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 123731968, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 125829120, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 127926272, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 130023424, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 132120576, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 134217728, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 136314880, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 138412032, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 140509184, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 142606336, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 144703488, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 146800640, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 148897792, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 150994944, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 153092096, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 155189248, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 157286400, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 159383552, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 161480704, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 163577856, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 165675008, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 167772160, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 169869312, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 171966464, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 174063616, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 176160768, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 178257920, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 180355072, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 182452224, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 184549376, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 186646528, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 188743680, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 190840832, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 192937984, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 195035136, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 197132288, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 199229440, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 201326592, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 203423744, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 205520896, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 207618048, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 209715200, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 211812352, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 213909504, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 216006656, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 218103808, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 220200960, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 222298112, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 224395264, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 226492416, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 228589568, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 230686720, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 232783872, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 234881024, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 236978176, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 239075328, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 241172480, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 243269632, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 245366784, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 247463936, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 249561088, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 251658240, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 253755392, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 255852544, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 257949696, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 260046848, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 262144000, "length": 1310720, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
 
 === Testing Image create, default ===
 
@@ -417,15 +417,15 @@ Formatting 'TEST_DIR/IMGFMT-create-test.IMGFMT', fmt=IMGFMT size=4294967296
 
 === Read created image, default opts ====
 
-[{ "start": 0, "length": 4295467008, "depth": 0, "present": true, "zero": true, "data": false}]
+[{ "start": 0, "length": 4295467008, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
 
 === Read created image, force_size_calc=chs ====
 
-[{ "start": 0, "length": 4295467008, "depth": 0, "present": true, "zero": true, "data": false}]
+[{ "start": 0, "length": 4295467008, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
 
 === Read created image, force_size_calc=current_size ====
 
-[{ "start": 0, "length": 4295467008, "depth": 0, "present": true, "zero": true, "data": false}]
+[{ "start": 0, "length": 4295467008, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
 
 === Testing Image create, force_size ===
 
@@ -433,13 +433,13 @@ Formatting 'TEST_DIR/IMGFMT-create-test.IMGFMT', fmt=IMGFMT size=4294967296
 
 === Read created image, default opts ====
 
-[{ "start": 0, "length": 4294967296, "depth": 0, "present": true, "zero": true, "data": false}]
+[{ "start": 0, "length": 4294967296, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
 
 === Read created image, force_size_calc=chs ====
 
-[{ "start": 0, "length": 4294967296, "depth": 0, "present": true, "zero": true, "data": false}]
+[{ "start": 0, "length": 4294967296, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
 
 === Read created image, force_size_calc=current_size ====
 
-[{ "start": 0, "length": 4294967296, "depth": 0, "present": true, "zero": true, "data": false}]
+[{ "start": 0, "length": 4294967296, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
 *** done
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
 
diff --git a/tests/qemu-iotests/209.out b/tests/qemu-iotests/209.out
index 515906ac7a..79c4103a22 100644
--- a/tests/qemu-iotests/209.out
+++ b/tests/qemu-iotests/209.out
@@ -1,4 +1,4 @@
-[{ "start": 0, "length": 524288, "depth": 0, "present": true, "zero": false, "data": true, "offset": 0},
-{ "start": 524288, "length": 524288, "depth": 0, "present": true, "zero": true, "data": false, "offset": 524288}]
+[{ "start": 0, "length": 524288, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": 0},
+{ "start": 524288, "length": 524288, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": 524288}]
 
 done.
diff --git a/tests/qemu-iotests/221.out b/tests/qemu-iotests/221.out
index 9cdd171a2d..df231c4e3d 100644
--- a/tests/qemu-iotests/221.out
+++ b/tests/qemu-iotests/221.out
@@ -5,14 +5,14 @@ QA output created by 221
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=65537
 discard 65537/65537 bytes at offset 0
 64.001 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 66048, "depth": 0, "present": true, "zero": true, "data": false, "offset": OFFSET}]
-[{ "start": 0, "length": 66048, "depth": 0, "present": true, "zero": true, "data": false, "offset": OFFSET}]
+[{ "start": 0, "length": 66048, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET}]
+[{ "start": 0, "length": 66048, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET}]
 wrote 1/1 bytes at offset 65536
 1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 65536, "depth": 0, "present": true, "zero": true, "data": false, "offset": OFFSET},
-{ "start": 65536, "length": 1, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 65537, "length": 511, "depth": 0, "present": true, "zero": true, "data": false, "offset": OFFSET}]
-[{ "start": 0, "length": 65536, "depth": 0, "present": true, "zero": true, "data": false, "offset": OFFSET},
-{ "start": 65536, "length": 1, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 65537, "length": 511, "depth": 0, "present": true, "zero": true, "data": false, "offset": OFFSET}]
+[{ "start": 0, "length": 65536, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET},
+{ "start": 65536, "length": 1, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 65537, "length": 511, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET}]
+[{ "start": 0, "length": 65536, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET},
+{ "start": 65536, "length": 1, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 65537, "length": 511, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET}]
 *** done
diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
index 26fb347c5d..86a37014d0 100644
--- a/tests/qemu-iotests/223.out
+++ b/tests/qemu-iotests/223.out
@@ -120,23 +120,23 @@ read 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 2097152/2097152 bytes at offset 2097152
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 4096, "length": 1044480, "depth": 0, "present": true, "zero": true, "data": false, "offset": OFFSET},
-{ "start": 1048576, "length": 3145728, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET}]
-[{ "start": 0, "length": 65536, "depth": 0, "present": false, "zero": false, "data": false},
-{ "start": 65536, "length": 2031616, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 2097152, "length": 2097152, "depth": 0, "present": false, "zero": false, "data": false}]
+[{ "start": 0, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 4096, "length": 1044480, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET},
+{ "start": 1048576, "length": 3145728, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
+[{ "start": 0, "length": 65536, "depth": 0, "present": false, "zero": false, "data": false, "compressed": false},
+{ "start": 65536, "length": 2031616, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 2097152, "length": 2097152, "depth": 0, "present": false, "zero": false, "data": false, "compressed": false}]
 
 === Contrast to small granularity dirty-bitmap ===
 
-[{ "start": 0, "length": 512, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 512, "length": 512, "depth": 0, "present": false, "zero": false, "data": false},
-{ "start": 1024, "length": 2096128, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 2097152, "length": 2097152, "depth": 0, "present": false, "zero": false, "data": false}]
+[{ "start": 0, "length": 512, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 512, "length": 512, "depth": 0, "present": false, "zero": false, "data": false, "compressed": false},
+{ "start": 1024, "length": 2096128, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 2097152, "length": 2097152, "depth": 0, "present": false, "zero": false, "data": false, "compressed": false}]
 
 === Check bitmap taken from another node ===
 
-[{ "start": 0, "length": 4194304, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET}]
+[{ "start": 0, "length": 4194304, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
 
 === End qemu NBD server ===
 
@@ -239,23 +239,23 @@ read 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 2097152/2097152 bytes at offset 2097152
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 4096, "length": 1044480, "depth": 0, "present": true, "zero": true, "data": false, "offset": OFFSET},
-{ "start": 1048576, "length": 3145728, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET}]
-[{ "start": 0, "length": 65536, "depth": 0, "present": false, "zero": false, "data": false},
-{ "start": 65536, "length": 2031616, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 2097152, "length": 2097152, "depth": 0, "present": false, "zero": false, "data": false}]
+[{ "start": 0, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 4096, "length": 1044480, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET},
+{ "start": 1048576, "length": 3145728, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
+[{ "start": 0, "length": 65536, "depth": 0, "present": false, "zero": false, "data": false, "compressed": false},
+{ "start": 65536, "length": 2031616, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 2097152, "length": 2097152, "depth": 0, "present": false, "zero": false, "data": false, "compressed": false}]
 
 === Contrast to small granularity dirty-bitmap ===
 
-[{ "start": 0, "length": 512, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 512, "length": 512, "depth": 0, "present": false, "zero": false, "data": false},
-{ "start": 1024, "length": 2096128, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 2097152, "length": 2097152, "depth": 0, "present": false, "zero": false, "data": false}]
+[{ "start": 0, "length": 512, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 512, "length": 512, "depth": 0, "present": false, "zero": false, "data": false, "compressed": false},
+{ "start": 1024, "length": 2096128, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 2097152, "length": 2097152, "depth": 0, "present": false, "zero": false, "data": false, "compressed": false}]
 
 === Check bitmap taken from another node ===
 
-[{ "start": 0, "length": 4194304, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET}]
+[{ "start": 0, "length": 4194304, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
 
 === End qemu NBD server ===
 
@@ -281,12 +281,12 @@ read 2097152/2097152 bytes at offset 2097152
 
 === Use qemu-nbd as server ===
 
-[{ "start": 0, "length": 65536, "depth": 0, "present": false, "zero": false, "data": false},
-{ "start": 65536, "length": 2031616, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 2097152, "length": 2097152, "depth": 0, "present": false, "zero": false, "data": false}]
-[{ "start": 0, "length": 512, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 512, "length": 512, "depth": 0, "present": false, "zero": false, "data": false},
-{ "start": 1024, "length": 11321, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET}]
-[{ "start": 12345, "length": 2084807, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 2097152, "length": 2097152, "depth": 0, "present": false, "zero": false, "data": false}]
+[{ "start": 0, "length": 65536, "depth": 0, "present": false, "zero": false, "data": false, "compressed": false},
+{ "start": 65536, "length": 2031616, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 2097152, "length": 2097152, "depth": 0, "present": false, "zero": false, "data": false, "compressed": false}]
+[{ "start": 0, "length": 512, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 512, "length": 512, "depth": 0, "present": false, "zero": false, "data": false, "compressed": false},
+{ "start": 1024, "length": 11321, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
+[{ "start": 12345, "length": 2084807, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 2097152, "length": 2097152, "depth": 0, "present": false, "zero": false, "data": false, "compressed": false}]
 *** done
diff --git a/tests/qemu-iotests/241.out b/tests/qemu-iotests/241.out
index 88e8cfcd7e..7946c286d5 100644
--- a/tests/qemu-iotests/241.out
+++ b/tests/qemu-iotests/241.out
@@ -6,8 +6,8 @@ exports available: 1
  export: ''
   size:  1024
   min block: 1
-[{ "start": 0, "length": 1000, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 1000, "length": 24, "depth": 0, "present": true, "zero": true, "data": false, "offset": OFFSET}]
+[{ "start": 0, "length": 1000, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 1000, "length": 24, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET}]
 1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)
 
 === Exporting unaligned raw image, forced server sector alignment ===
@@ -16,7 +16,7 @@ exports available: 1
  export: ''
   size:  1024
   min block: 512
-[{ "start": 0, "length": 1024, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET}]
+[{ "start": 0, "length": 1024, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
 1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
          Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
@@ -28,7 +28,7 @@ exports available: 1
  export: ''
   size:  1024
   min block: 1
-[{ "start": 0, "length": 1000, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 1000, "length": 24, "depth": 0, "present": true, "zero": true, "data": false, "offset": OFFSET}]
+[{ "start": 0, "length": 1000, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 1000, "length": 24, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET}]
 1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)
 *** done
diff --git a/tests/qemu-iotests/244.out b/tests/qemu-iotests/244.out
index 4815a489b0..f46cfe93f1 100644
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
diff --git a/tests/qemu-iotests/253.out b/tests/qemu-iotests/253.out
index b3dca75a89..b458085adb 100644
--- a/tests/qemu-iotests/253.out
+++ b/tests/qemu-iotests/253.out
@@ -3,16 +3,16 @@ QA output created by 253
 === Check mapping of unaligned raw image ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048575
-[{ "start": 0, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 4096, "length": 1044480, "depth": 0, "present": true, "zero": true, "data": false, "offset": OFFSET}]
-[{ "start": 0, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 4096, "length": 1044480, "depth": 0, "present": true, "zero": true, "data": false, "offset": OFFSET}]
+[{ "start": 0, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 4096, "length": 1044480, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET}]
+[{ "start": 0, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 4096, "length": 1044480, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET}]
 wrote 65535/65535 bytes at offset 983040
 63.999 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 4096, "length": 978944, "depth": 0, "present": true, "zero": true, "data": false, "offset": OFFSET},
-{ "start": 983040, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET}]
-[{ "start": 0, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 4096, "length": 978944, "depth": 0, "present": true, "zero": true, "data": false, "offset": OFFSET},
-{ "start": 983040, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET}]
+[{ "start": 0, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 4096, "length": 978944, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET},
+{ "start": 983040, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
+[{ "start": 0, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 4096, "length": 978944, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET},
+{ "start": 983040, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
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
index 9d938db24e..138eb09c6d 100644
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
@@ -24,9 +24,9 @@ exports available: 1
   available meta contexts: 2
    base:allocation
    qemu:allocation-depth
-[{ "start": 0, "length": 3145728, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 3145728, "length": 1048576, "depth": 0, "present": true, "zero": true, "data": false, "offset": OFFSET}]
-[{ "start": 0, "length": 1048576, "depth": 0, "present": true, "zero": true, "data": true, "offset": OFFSET},
-{ "start": 1048576, "length": 2097152, "depth": 0, "present": false, "zero": false, "data": false},
-{ "start": 3145728, "length": 1048576, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET}]
+[{ "start": 0, "length": 3145728, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 3145728, "length": 1048576, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET}]
+[{ "start": 0, "length": 1048576, "depth": 0, "present": true, "zero": true, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 1048576, "length": 2097152, "depth": 0, "present": false, "zero": false, "data": false, "compressed": false},
+{ "start": 3145728, "length": 1048576, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
 *** done
diff --git a/tests/qemu-iotests/tests/qemu-img-bitmaps.out b/tests/qemu-iotests/tests/qemu-img-bitmaps.out
index e851f0320e..74b81f703b 100644
--- a/tests/qemu-iotests/tests/qemu-img-bitmaps.out
+++ b/tests/qemu-iotests/tests/qemu-img-bitmaps.out
@@ -103,18 +103,18 @@ Format specific information:
 
 === Check bitmap contents ===
 
-[{ "start": 0, "length": 3145728, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 3145728, "length": 1048576, "depth": 0, "present": false, "zero": false, "data": false},
-{ "start": 4194304, "length": 6291456, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET}]
-[{ "start": 0, "length": 1048576, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 1048576, "length": 1048576, "depth": 0, "present": false, "zero": false, "data": false},
-{ "start": 2097152, "length": 8388608, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET}]
-[{ "start": 0, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 2097152, "length": 1048576, "depth": 0, "present": false, "zero": false, "data": false},
-{ "start": 3145728, "length": 7340032, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET}]
-[{ "start": 0, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 2097152, "length": 1048576, "depth": 0, "present": false, "zero": false, "data": false},
-{ "start": 3145728, "length": 7340032, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET}]
+[{ "start": 0, "length": 3145728, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 3145728, "length": 1048576, "depth": 0, "present": false, "zero": false, "data": false, "compressed": false},
+{ "start": 4194304, "length": 6291456, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
+[{ "start": 0, "length": 1048576, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 1048576, "length": 1048576, "depth": 0, "present": false, "zero": false, "data": false, "compressed": false},
+{ "start": 2097152, "length": 8388608, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
+[{ "start": 0, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 2097152, "length": 1048576, "depth": 0, "present": false, "zero": false, "data": false, "compressed": false},
+{ "start": 3145728, "length": 7340032, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
+[{ "start": 0, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 2097152, "length": 1048576, "depth": 0, "present": false, "zero": false, "data": false, "compressed": false},
+{ "start": 3145728, "length": 7340032, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
 
 === Check handling of inconsistent bitmap ===
 
-- 
2.41.0


