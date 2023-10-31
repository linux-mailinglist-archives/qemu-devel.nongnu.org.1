Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9337DD689
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 20:05:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxtyX-0004OJ-6b; Tue, 31 Oct 2023 15:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxty5-00046k-48
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:00:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtxY-00066j-96
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698778767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LuzGSHRYWNhL3bPfqe+1ChrNIVo0NtQpku8LkFy8xcE=;
 b=ev71SFu3hcu+J6AVDIEge/ivMMWJ+qwVkjrxNaYTvLUiBGtDsfFbeQXJD6HiUlO2ICsEFF
 fEqkAbVBZG7Vtlm9mfUCTMnNmdbUcP0FfijiW9yL1ECH3EzITLwhdPQE4bIxbb+XOVnFFf
 CSpUELaSPZ3XtKwj1nkfzzuagDDHmas=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-fkAhPb97M8mIcP0Wo0MnBg-1; Tue, 31 Oct 2023 14:59:25 -0400
X-MC-Unique: fkAhPb97M8mIcP0Wo0MnBg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 852FB811E86;
 Tue, 31 Oct 2023 18:59:25 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E93DF3DB;
 Tue, 31 Oct 2023 18:59:24 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 06/27] iotests/{024, 271}: add testcases for qemu-img rebase
Date: Tue, 31 Oct 2023 19:58:57 +0100
Message-ID: <20231031185918.346940-7-kwolf@redhat.com>
In-Reply-To: <20231031185918.346940-1-kwolf@redhat.com>
References: <20231031185918.346940-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_PDS_OTHER_BAD_TLD=0.01,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

As the previous commit changes the logic of "qemu-img rebase" (it's using
write alignment now), let's add a couple more test cases which would
ensure it works correctly.  In particular, the following scenarios:

024: add test case for rebase within one backing chain when the overlay
     cluster size > backings cluster size;
271: add test case for rebase images that contain subclusters.  Check
     that no extra allocations are being made.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20230919165804.439110-7-andrey.drobyshev@virtuozzo.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/024     | 60 ++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/024.out | 43 +++++++++++++++++++++++++
 tests/qemu-iotests/271     | 66 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/271.out | 42 ++++++++++++++++++++++++
 4 files changed, 211 insertions(+)

diff --git a/tests/qemu-iotests/024 b/tests/qemu-iotests/024
index 98a7c8fd65..285f17e79f 100755
--- a/tests/qemu-iotests/024
+++ b/tests/qemu-iotests/024
@@ -257,6 +257,66 @@ $QEMU_IO "$OVERLAY" -c "read -P 0x00 $(( CLUSTER_SIZE * 4 )) $CLUSTER_SIZE" \
 
 echo
 
+# Check that rebase within the chain is working when
+# overlay cluster size > backings cluster size
+# (here overlay cluster size == 2 * backings cluster size)
+#
+# base_new <-- base_old <-- overlay
+#
+# Backing (new): -- -- -- -- -- --
+# Backing (old): -- 11 -- -- 22 --
+# Overlay:      |-- --|-- --|-- --|
+#
+# We should end up having 1st and 3rd cluster allocated, and their halves
+# being read as zeroes.
+
+echo
+echo "=== Test rebase with different cluster sizes ==="
+echo
+
+echo "Creating backing chain"
+echo
+
+TEST_IMG=$BASE_NEW _make_test_img $(( CLUSTER_SIZE * 6 ))
+TEST_IMG=$BASE_OLD _make_test_img -b "$BASE_NEW" -F $IMGFMT \
+    $(( CLUSTER_SIZE * 6 ))
+CLUSTER_SIZE=$(( CLUSTER_SIZE * 2 )) TEST_IMG=$OVERLAY \
+    _make_test_img -b "$BASE_OLD" -F $IMGFMT $(( CLUSTER_SIZE * 6 ))
+
+TEST_IMG=$OVERLAY _img_info
+
+echo
+echo "Fill backing files with data"
+echo
+
+$QEMU_IO "$BASE_OLD" -c "write -P 0x11 $CLUSTER_SIZE $CLUSTER_SIZE" \
+    -c "write -P 0x22 $(( CLUSTER_SIZE * 4 )) $CLUSTER_SIZE" \
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
+$QEMU_IO "$OVERLAY" -c "read -P 0x00 0 $CLUSTER_SIZE" \
+    -c "read -P 0x11 $CLUSTER_SIZE $CLUSTER_SIZE" \
+    -c "read -P 0x00 $(( CLUSTER_SIZE * 2 )) $(( CLUSTER_SIZE * 2 ))" \
+    -c "read -P 0x22 $(( CLUSTER_SIZE * 4 )) $CLUSTER_SIZE" \
+    -c "read -P 0x00 $(( CLUSTER_SIZE * 5 )) $CLUSTER_SIZE" \
+    | _filter_qemu_io
+
+echo
+echo "Verify that untouched cluster remains unallocated"
+echo
+
+$QEMU_IMG map "$OVERLAY" | _filter_qemu_img_map
+
+echo
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/024.out b/tests/qemu-iotests/024.out
index 245fe8b1d1..e1e8eea863 100644
--- a/tests/qemu-iotests/024.out
+++ b/tests/qemu-iotests/024.out
@@ -201,4 +201,47 @@ read 262144/262144 bytes at offset 0
 read 65536/65536 bytes at offset 262144
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
+
+=== Test rebase with different cluster sizes ===
+
+Creating backing chain
+
+Formatting 'TEST_DIR/subdir/t.IMGFMT.base_new', fmt=IMGFMT size=393216
+Formatting 'TEST_DIR/subdir/t.IMGFMT.base_old', fmt=IMGFMT size=393216 backing_file=TEST_DIR/subdir/t.IMGFMT.base_new backing_fmt=IMGFMT
+Formatting 'TEST_DIR/subdir/t.IMGFMT', fmt=IMGFMT size=393216 backing_file=TEST_DIR/subdir/t.IMGFMT.base_old backing_fmt=IMGFMT
+image: TEST_DIR/subdir/t.IMGFMT
+file format: IMGFMT
+virtual size: 384 KiB (393216 bytes)
+cluster_size: 131072
+backing file: TEST_DIR/subdir/t.IMGFMT.base_old
+backing file format: IMGFMT
+
+Fill backing files with data
+
+wrote 65536/65536 bytes at offset 65536
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 262144
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+Rebase onto another image in the same chain
+
+Verify that data is read the same before and after rebase
+
+read 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 65536
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 131072/131072 bytes at offset 131072
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 262144
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 327680
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+Verify that untouched cluster remains unallocated
+
+Offset          Length          File
+0               0x20000         TEST_DIR/subdir/t.IMGFMT
+0x40000         0x20000         TEST_DIR/subdir/t.IMGFMT
+
 *** done
diff --git a/tests/qemu-iotests/271 b/tests/qemu-iotests/271
index c7c2cadda0..e243f57ba7 100755
--- a/tests/qemu-iotests/271
+++ b/tests/qemu-iotests/271
@@ -899,6 +899,72 @@ _concurrent_io     | $QEMU_IO | _filter_qemu_io | \
     sed -e 's/\(20480\|40960\)/OFFSET/'
 _concurrent_verify | $QEMU_IO | _filter_qemu_io
 
+############################################################
+############################################################
+############################################################
+
+echo
+echo "### Rebase of qcow2 images with subclusters ###"
+echo
+
+l2_offset=$((0x400000))
+
+# Check that rebase operation preserve holes between allocated subclusters
+# within one cluster (i.e. does not allocate extra space).  Check that the
+# data is preserved as well.
+#
+# Base (new backing): -- -- -- ... -- -- --
+# Mid (old backing):  -- 11 -- ... -- 22 --
+# Top:                -- -- -- ... -- -- --
+
+echo "### Preservation of unallocated holes after rebase ###"
+echo
+
+echo "# create backing chain"
+echo
+
+TEST_IMG="$TEST_IMG.base" _make_test_img -o cluster_size=1M,extended_l2=on 1M
+TEST_IMG="$TEST_IMG.mid" _make_test_img -o cluster_size=1M,extended_l2=on \
+    -b "$TEST_IMG.base" -F qcow2 1M
+TEST_IMG="$TEST_IMG.top" _make_test_img -o cluster_size=1M,extended_l2=on \
+    -b "$TEST_IMG.mid" -F qcow2 1M
+
+echo
+echo "# fill old backing with data (separate subclusters within cluster)"
+echo
+
+$QEMU_IO -c "write -P 0x11 32k 32k" \
+         -c "write -P 0x22 $(( 30 * 32 ))k 32k" \
+         "$TEST_IMG.mid" | _filter_qemu_io
+
+echo
+echo "# rebase topmost image onto the new backing"
+echo
+
+$QEMU_IMG rebase -b "$TEST_IMG.base" -F qcow2 "$TEST_IMG.top"
+
+echo "# verify that data is read the same before and after rebase"
+echo
+
+$QEMU_IO -c "read -P 0x00 0 32k" \
+         -c "read -P 0x11 32k 32k" \
+         -c "read -P 0x00 64k $(( 28 * 32 ))k" \
+         -c "read -P 0x22 $(( 30 * 32 ))k 32k" \
+         -c "read -P 0x00 $(( 31 * 32 ))k 32k" \
+         "$TEST_IMG.top" | _filter_qemu_io
+
+echo
+echo "# verify that only selected subclusters remain allocated"
+echo
+
+$QEMU_IMG map "$TEST_IMG.top" | _filter_testdir
+
+echo
+echo "# verify image bitmap"
+echo
+
+TEST_IMG="$TEST_IMG.top" alloc="1 30" zero="" _verify_l2_bitmap 0
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/271.out b/tests/qemu-iotests/271.out
index 5be780de76..c335a6c608 100644
--- a/tests/qemu-iotests/271.out
+++ b/tests/qemu-iotests/271.out
@@ -723,4 +723,46 @@ wrote 2048/2048 bytes at offset OFFSET
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 2048/2048 bytes at offset OFFSET
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+### Rebase of qcow2 images with subclusters ###
+
+### Preservation of unallocated holes after rebase ###
+
+# create backing chain
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=1048576
+Formatting 'TEST_DIR/t.IMGFMT.mid', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT.top', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.mid backing_fmt=IMGFMT
+
+# fill old backing with data (separate subclusters within cluster)
+
+wrote 32768/32768 bytes at offset 32768
+32 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 32768/32768 bytes at offset 983040
+32 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# rebase topmost image onto the new backing
+
+# verify that data is read the same before and after rebase
+
+read 32768/32768 bytes at offset 0
+32 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 32768/32768 bytes at offset 32768
+32 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 917504/917504 bytes at offset 65536
+896 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 32768/32768 bytes at offset 983040
+32 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 32768/32768 bytes at offset 1015808
+32 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# verify that only selected subclusters remain allocated
+
+Offset          Length          Mapped to       File
+0x8000          0x8000          0x508000        TEST_DIR/t.qcow2.top
+0xf0000         0x8000          0x5f0000        TEST_DIR/t.qcow2.top
+
+# verify image bitmap
+
+L2 entry #0: 0x8000000000500000 0000000040000002
 *** done
-- 
2.41.0


