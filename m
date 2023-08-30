Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F046178D5AF
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 13:51:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbJi1-0003Zt-1s; Wed, 30 Aug 2023 07:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qbJhx-0003T2-8H
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 07:50:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qbJhv-0003iz-0W
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 07:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693396198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ga6qSUQdwzhmfn/lQ9lhh6t3Yiayp8nRSobjZ382ohU=;
 b=SsVF7tZAtHz99Lh+WLZoxtdMafuNvbcAkpQSGBgZCwUvkrOs36UdlDaZqnC5Ws3h/HVMmF
 j2aKdnBvLToUM5cA9+kM8HH7gKfs3Z4l01fCSgs7XSOXFDzlm/ns0Yh3g+gvWsCKBWaXaD
 u0TmQA7v4HBhy2Gg5aNdoJrg6I01fgU=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-s8R2zKAEPTC61o899lSztQ-1; Wed, 30 Aug 2023 07:49:54 -0400
X-MC-Unique: s8R2zKAEPTC61o899lSztQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 87D1F381C166;
 Wed, 30 Aug 2023 11:49:53 +0000 (UTC)
Received: from localhost (unknown [10.39.193.236])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0095E40C6F4C;
 Wed, 30 Aug 2023 11:49:52 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jeuk Kim <jeuk20.kim@samsung.com>, qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Leonardo Bras <leobras@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Eric Blake <eblake@redhat.com>, "Denis V . Lunev" <den@openvz.org>
Subject: [PULL v3 4/5] tests/qemu-iotests/197: add testcase for CoR with
 subclusters
Date: Wed, 30 Aug 2023 07:49:41 -0400
Message-ID: <20230830114942.449060-5-stefanha@redhat.com>
In-Reply-To: <20230830114942.449060-1-stefanha@redhat.com>
References: <20230830114942.449060-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

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


