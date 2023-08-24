Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A3178764E
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 19:01:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZDfn-0006RL-M7; Thu, 24 Aug 2023 12:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qZDfl-0006IT-9p
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:59:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qZDfj-0003UZ-1g
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692896342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+hcJ8z8+yEaQ9eqGuIoLyqdUrwj59cqGQM8mVF2k39U=;
 b=Lm92vFhLpJOwKcu71IO8rkHy4ZGYJ8lfIBD+zt8EE7QQicnM7aUdtkE6jlqbek6t6F3BA9
 uA5Wn2fO9lMpp3idCp/+8YiV7KNN5ihHtO1H+6+gE9AB2UsLh7axqIwQtVm/djy1+Uz+FP
 e2M9d+uxABjuCy8+6mrr+2cAuuP7NfE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557--83RO6jLM3uCu0oRXzXFYw-1; Thu, 24 Aug 2023 12:58:58 -0400
X-MC-Unique: -83RO6jLM3uCu0oRXzXFYw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 504998D40A2;
 Thu, 24 Aug 2023 16:58:57 +0000 (UTC)
Received: from localhost (unknown [10.39.194.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B04596B2B6;
 Thu, 24 Aug 2023 16:58:56 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 John Snow <jsnow@redhat.com>, Jeuk Kim <jeuk20.kim@samsung.com>,
 Hanna Reitz <hreitz@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PULL 8/8] tests/qemu-iotests/197: add testcase for CoR with
 subclusters
Date: Thu, 24 Aug 2023 12:58:33 -0400
Message-ID: <20230824165833.1689137-9-stefanha@redhat.com>
In-Reply-To: <20230824165833.1689137-1-stefanha@redhat.com>
References: <20230824165833.1689137-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Andrey Drobyshev via <qemu-devel@nongnu.org>

Add testcase which checks that allocations during copy-on-read are
performed on the subcluster basis when subclusters are enabled in target
image.

This testcase also triggers the following assert with previous commit
not being applied, so we check that as well:

qemu-io: ../block/io.c:1236: bdrv_co_do_copy_on_readv: Assertion `skip_bytes < pnum' failed.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20230711172553.234055-4-andrey.drobyshev@virtuozzo.com>
---
 tests/qemu-iotests/197     | 29 +++++++++++++++++++++++++++++
 tests/qemu-iotests/197.out | 24 ++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
index a2547bc280..f07a9da136 100755
--- a/tests/qemu-iotests/197
+++ b/tests/qemu-iotests/197
@@ -122,6 +122,35 @@ $QEMU_IO -f qcow2 -C -c 'read 0 1024' "$TEST_WRAP" | _filter_qemu_io
 $QEMU_IO -f qcow2 -c map "$TEST_WRAP"
 _check_test_img
 
+echo
+echo '=== Copy-on-read with subclusters ==='
+echo
+
+# Create base and top images 64K (1 cluster) each.  Make subclusters enabled
+# for the top image
+_make_test_img 64K
+IMGPROTO=file IMGFMT=qcow2 TEST_IMG_FILE="$TEST_WRAP" \
+    _make_test_img --no-opts -o extended_l2=true -F "$IMGFMT" -b "$TEST_IMG" \
+    64K | _filter_img_create
+
+$QEMU_IO -c "write -P 0xaa 0 64k" "$TEST_IMG" | _filter_qemu_io
+
+# Allocate individual subclusters in the top image, and not the whole cluster
+$QEMU_IO -c "write -P 0xbb 28K 2K" -c "write -P 0xcc 34K 2K" "$TEST_WRAP" \
+    | _filter_qemu_io
+
+# Only 2 subclusters should be allocated in the top image at this point
+$QEMU_IMG map "$TEST_WRAP" | _filter_qemu_img_map
+
+# Actual copy-on-read operation
+$QEMU_IO -C -c "read -P 0xaa 30K 4K" "$TEST_WRAP" | _filter_qemu_io
+
+# And here we should have 4 subclusters allocated right in the middle of the
+# top image. Make sure the whole cluster remains unallocated
+$QEMU_IMG map "$TEST_WRAP" | _filter_qemu_img_map
+
+_check_test_img
+
 # success, all done
 echo '*** done'
 status=0
diff --git a/tests/qemu-iotests/197.out b/tests/qemu-iotests/197.out
index ad414c3b0e..8f34a30afe 100644
--- a/tests/qemu-iotests/197.out
+++ b/tests/qemu-iotests/197.out
@@ -31,4 +31,28 @@ read 1024/1024 bytes at offset 0
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)
 No errors were found on the image.
+
+=== Copy-on-read with subclusters ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=65536
+Formatting 'TEST_DIR/t.wrap.IMGFMT', fmt=IMGFMT size=65536 backing_file=TEST_DIR/t.IMGFMT backing_fmt=IMGFMT
+wrote 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2048/2048 bytes at offset 28672
+2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2048/2048 bytes at offset 34816
+2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Offset          Length          File
+0               0x7000          TEST_DIR/t.IMGFMT
+0x7000          0x800           TEST_DIR/t.wrap.IMGFMT
+0x7800          0x1000          TEST_DIR/t.IMGFMT
+0x8800          0x800           TEST_DIR/t.wrap.IMGFMT
+0x9000          0x7000          TEST_DIR/t.IMGFMT
+read 4096/4096 bytes at offset 30720
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Offset          Length          File
+0               0x7000          TEST_DIR/t.IMGFMT
+0x7000          0x2000          TEST_DIR/t.wrap.IMGFMT
+0x9000          0x7000          TEST_DIR/t.IMGFMT
+No errors were found on the image.
 *** done
-- 
2.41.0


