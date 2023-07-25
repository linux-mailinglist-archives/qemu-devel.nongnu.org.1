Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BF6761B4E
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:21:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOIsv-0001GJ-UD; Tue, 25 Jul 2023 10:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qOIst-0001CQ-Mt
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:19:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qOIss-00015N-3u
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690294769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pMSNPxAWGxF+lDy8Hhk1C/MKJRUlaBiwTYUH5uNcg9g=;
 b=gpdnoc+WOj1DMYOS4IPf7plscsMzYhndIQKhUL/OlZ5MnC/SxoojyBZAy0f8cHFk2IjXfk
 sdwFf7x29dLB+DFtUKRoFInVeU1WJEH6y9x+/eOaTPetjWcIBm53gBC4VL79VnlsdL6FDN
 iSGdRT+rfpJO8F3GZIsCNGFE68vXs0s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-gYn8ls09OSWSB3mP9EUcUA-1; Tue, 25 Jul 2023 10:19:27 -0400
X-MC-Unique: gYn8ls09OSWSB3mP9EUcUA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1DD588CC49;
 Tue, 25 Jul 2023 14:19:26 +0000 (UTC)
Received: from localhost (unknown [10.39.192.118])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 71A801121330;
 Tue, 25 Jul 2023 14:19:26 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 4/7] iotests: filter img create backing_file when IMGPROTO is
 modified
Date: Tue, 25 Jul 2023 10:19:12 -0400
Message-ID: <20230725141915.386364-5-stefanha@redhat.com>
In-Reply-To: <20230725141915.386364-1-stefanha@redhat.com>
References: <20230725141915.386364-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

197 and 215 modify IMGPROTO, IMGFMT, etc temporarily while creating an
additional image file after the main test image. The backing file name
still has the old IMGPROTO, IMGFMT, etc. This means _filter_img_create
will not filter the backing_file= output from qemu-img.

Add a helper that filters backing_file= output so these test cases are
more robust. This will be necessary in order to enable the io_uring
protocol driver in qemu-iotests.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/197           | 4 +++-
 tests/qemu-iotests/197.out       | 2 +-
 tests/qemu-iotests/215           | 4 +++-
 tests/qemu-iotests/215.out       | 2 +-
 tests/qemu-iotests/common.filter | 8 ++++++++
 5 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
index a2547bc280..756603b19e 100755
--- a/tests/qemu-iotests/197
+++ b/tests/qemu-iotests/197
@@ -68,7 +68,9 @@ fi
 _make_test_img 4G
 $QEMU_IO -c "write -P 55 3G 1k" "$TEST_IMG" | _filter_qemu_io
 IMGPROTO=file IMGFMT=qcow2 TEST_IMG_FILE="$TEST_WRAP" \
-    _make_test_img --no-opts -F "$IMGFMT" -b "$TEST_IMG" | _filter_img_create
+    _make_test_img --no-opts -F "$IMGFMT" -b "$TEST_IMG" | \
+    _filter_img_create_backing_file | \
+    _filter_img_create
 $QEMU_IO -f qcow2 -c "write -z -u 1M 64k" "$TEST_WRAP" | _filter_qemu_io
 
 # Ensure that a read of two clusters, but where one is already allocated,
diff --git a/tests/qemu-iotests/197.out b/tests/qemu-iotests/197.out
index ad414c3b0e..bbfb3413e4 100644
--- a/tests/qemu-iotests/197.out
+++ b/tests/qemu-iotests/197.out
@@ -5,7 +5,7 @@ QA output created by 197
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4294967296
 wrote 1024/1024 bytes at offset 3221225472
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Formatting 'TEST_DIR/t.wrap.IMGFMT', fmt=IMGFMT size=4294967296 backing_file=TEST_DIR/t.IMGFMT backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.wrap.IMGFMT', fmt=IMGFMT size=4294967296 backing_file=BACKING_FILE backing_fmt=IMGFMT
 wrote 65536/65536 bytes at offset 1048576
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 131072/131072 bytes at offset 1048576
diff --git a/tests/qemu-iotests/215 b/tests/qemu-iotests/215
index d464596f14..145f2bb3eb 100755
--- a/tests/qemu-iotests/215
+++ b/tests/qemu-iotests/215
@@ -65,7 +65,9 @@ fi
 _make_test_img 4G
 $QEMU_IO -c "write -P 55 3G 1k" "$TEST_IMG" | _filter_qemu_io
 IMGPROTO=file IMGFMT=qcow2 TEST_IMG_FILE="$TEST_WRAP" \
-    _make_test_img --no-opts -F "$IMGFMT" -b "$TEST_IMG" | _filter_img_create
+    _make_test_img --no-opts -F "$IMGFMT" -b "$TEST_IMG" | \
+    _filter_img_create_backing_file | \
+    _filter_img_create
 $QEMU_IO -f qcow2 -c "write -z -u 1M 64k" "$TEST_WRAP" | _filter_qemu_io
 
 # Ensure that a read of two clusters, but where one is already allocated,
diff --git a/tests/qemu-iotests/215.out b/tests/qemu-iotests/215.out
index 5a2fe40d03..d10cce71bc 100644
--- a/tests/qemu-iotests/215.out
+++ b/tests/qemu-iotests/215.out
@@ -5,7 +5,7 @@ QA output created by 215
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4294967296
 wrote 1024/1024 bytes at offset 3221225472
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Formatting 'TEST_DIR/t.wrap.IMGFMT', fmt=IMGFMT size=4294967296 backing_file=TEST_DIR/t.IMGFMT backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.wrap.IMGFMT', fmt=IMGFMT size=4294967296 backing_file=BACKING_FILE backing_fmt=IMGFMT
 wrote 65536/65536 bytes at offset 1048576
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 131072/131072 bytes at offset 1048576
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index 4acac16c52..b047fe43a0 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -206,6 +206,14 @@ _filter_img_create()
     done
 }
 
+# When creating additional images with different IMGPROTO, IMGFMT, etc than the
+# main test image, _filter_img_create cannot filter backing_file since it
+# contains different IMGPROTO, IMGFMT, etc values than currently in use.
+_filter_img_create_backing_file()
+{
+    sed -e "s/ backing_file=[^ ]*/ backing_file=BACKING_FILE/g"
+}
+
 _filter_img_create_size()
 {
     gsed -e "s# size=[0-9]\\+# size=SIZE#g"
-- 
2.41.0


