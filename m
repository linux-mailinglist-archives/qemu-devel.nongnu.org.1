Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 949667DD66A
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 20:00:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxtxo-0003vT-Cg; Tue, 31 Oct 2023 14:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtxm-0003v4-Ou
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 14:59:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtxW-000667-Ez
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 14:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698778765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dqiKqzDAO8Fz6WSh9MojvnU2xLB4gu2mPAVbFDVB6Cs=;
 b=Klylkwx8Snt8j2UlxV5w3U35vAfLXlehdrTSvC+grdzEFmB7RYgD2ZDwQKuEDTdaHnfZKe
 pbzuVls6I4TARbx8r090CjYXJYjAHPXGfFBwh3i5xcY7/23u9+HGAn2ulkmICTvN97kWEI
 NZPJbOQ7PeTj0CyrJQsEBUwUp7JoHBY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-W-xVw4kNNK2fj02T3n516A-1; Tue, 31 Oct 2023 14:59:23 -0400
X-MC-Unique: W-xVw4kNNK2fj02T3n516A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43F3B835263;
 Tue, 31 Oct 2023 18:59:22 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A5AFD143;
 Tue, 31 Oct 2023 18:59:21 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 02/27] qemu-iotests: 024: add rebasing test case for
 overlay_size > backing_size
Date: Tue, 31 Oct 2023 19:58:53 +0100
Message-ID: <20231031185918.346940-3-kwolf@redhat.com>
In-Reply-To: <20231031185918.346940-1-kwolf@redhat.com>
References: <20231031185918.346940-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Before previous commit, rebase was getting infitely stuck in case of
rebasing within the same backing chain and when overlay_size > backing_size.
Let's add this case to the rebasing test 024 to make sure it doesn't
break again.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20230919165804.439110-3-andrey.drobyshev@virtuozzo.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/024     | 57 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/024.out | 30 ++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/tests/qemu-iotests/024 b/tests/qemu-iotests/024
index 25a564a150..98a7c8fd65 100755
--- a/tests/qemu-iotests/024
+++ b/tests/qemu-iotests/024
@@ -199,6 +199,63 @@ echo
 # $BASE_OLD and $BASE_NEW)
 $QEMU_IMG map "$OVERLAY" | _filter_qemu_img_map
 
+# Check that rebase within the chain is working when
+# overlay_size > old_backing_size
+#
+# base_new <-- base_old <-- overlay
+#
+# Backing (new): 11 11 11 11 11
+# Backing (old): 22 22 22 22
+# Overlay:       -- -- -- -- --
+#
+# As a result, overlay should contain data identical to base_old, with the
+# last cluster remaining unallocated.
+
+echo
+echo "=== Test rebase within one backing chain ==="
+echo
+
+echo "Creating backing chain"
+echo
+
+TEST_IMG=$BASE_NEW _make_test_img $(( CLUSTER_SIZE * 5 ))
+TEST_IMG=$BASE_OLD _make_test_img -b "$BASE_NEW" -F $IMGFMT \
+    $(( CLUSTER_SIZE * 4 ))
+TEST_IMG=$OVERLAY _make_test_img -b "$BASE_OLD" -F $IMGFMT \
+    $(( CLUSTER_SIZE * 5 ))
+
+echo
+echo "Fill backing files with data"
+echo
+
+$QEMU_IO "$BASE_NEW" -c "write -P 0x11 0 $(( CLUSTER_SIZE * 5 ))" \
+    | _filter_qemu_io
+$QEMU_IO "$BASE_OLD" -c "write -P 0x22 0 $(( CLUSTER_SIZE * 4 ))" \
+    | _filter_qemu_io
+
+echo
+echo "Check the last cluster is zeroed in overlay before the rebase"
+echo
+$QEMU_IO "$OVERLAY" -c "read -P 0x00 $(( CLUSTER_SIZE * 4 )) $CLUSTER_SIZE" \
+    | _filter_qemu_io
+
+echo
+echo "Rebase onto another image in the same chain"
+echo
+
+$QEMU_IMG rebase -b "$BASE_NEW" -F $IMGFMT "$OVERLAY"
+
+echo "Verify that data is read the same before and after rebase"
+echo
+
+# Verify the first 4 clusters are still read the same as in the old base
+$QEMU_IO "$OVERLAY" -c "read -P 0x22 0 $(( CLUSTER_SIZE * 4 ))" \
+    | _filter_qemu_io
+# Verify the last cluster still reads as zeroes
+$QEMU_IO "$OVERLAY" -c "read -P 0x00 $(( CLUSTER_SIZE * 4 )) $CLUSTER_SIZE" \
+    | _filter_qemu_io
+
+echo
 
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/024.out b/tests/qemu-iotests/024.out
index 973a5a3711..245fe8b1d1 100644
--- a/tests/qemu-iotests/024.out
+++ b/tests/qemu-iotests/024.out
@@ -171,4 +171,34 @@ read 65536/65536 bytes at offset 196608
 Offset          Length          File
 0               0x30000         TEST_DIR/subdir/t.IMGFMT
 0x30000         0x10000         TEST_DIR/subdir/t.IMGFMT.base_new
+
+=== Test rebase within one backing chain ===
+
+Creating backing chain
+
+Formatting 'TEST_DIR/subdir/t.IMGFMT.base_new', fmt=IMGFMT size=327680
+Formatting 'TEST_DIR/subdir/t.IMGFMT.base_old', fmt=IMGFMT size=262144 backing_file=TEST_DIR/subdir/t.IMGFMT.base_new backing_fmt=IMGFMT
+Formatting 'TEST_DIR/subdir/t.IMGFMT', fmt=IMGFMT size=327680 backing_file=TEST_DIR/subdir/t.IMGFMT.base_old backing_fmt=IMGFMT
+
+Fill backing files with data
+
+wrote 327680/327680 bytes at offset 0
+320 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 262144/262144 bytes at offset 0
+256 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+Check the last cluster is zeroed in overlay before the rebase
+
+read 65536/65536 bytes at offset 262144
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+Rebase onto another image in the same chain
+
+Verify that data is read the same before and after rebase
+
+read 262144/262144 bytes at offset 0
+256 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 262144
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
 *** done
-- 
2.41.0


