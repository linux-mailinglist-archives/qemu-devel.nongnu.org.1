Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E856F798045
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 03:38:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeQPx-0008QK-Eb; Thu, 07 Sep 2023 21:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeQPv-0008Pm-Ek
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 21:36:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeQPs-0007sR-0O
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 21:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694136970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C0HCJYBvdpwPjNr/rSSyANOLnacS+MwnaDPetGq22G4=;
 b=ZLxlMbTfDTsfDbaZEC4C+v+/tt8bqQYuhYsirIwu7C3FLo7EyGFSsWYeSapxvRInyHpf6I
 /Thk9WVG6G3t9qbyD4RFhGvP9+WnUQPEK1g1azxEdAmUSrgE69VUR48FGSeB/bphR7QlTD
 0rNiKTMQOIW12J99okEQ8OkDCCVam3I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-hwBfzrkOOYKtF8yUJ-QlHg-1; Thu, 07 Sep 2023 21:36:07 -0400
X-MC-Unique: hwBfzrkOOYKtF8yUJ-QlHg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F814101CA82;
 Fri,  8 Sep 2023 01:36:07 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB75740C2070;
 Fri,  8 Sep 2023 01:36:06 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PULL 01/13] qemu-iotests/197: use more generic commands for formats
 other than qcow2
Date: Thu,  7 Sep 2023 20:35:37 -0500
Message-ID: <20230908013535.990731-16-eblake@redhat.com>
In-Reply-To: <20230908013535.990731-15-eblake@redhat.com>
References: <20230908013535.990731-15-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In the previous commit e2f938265e0 ("tests/qemu-iotests/197: add
testcase for CoR with subclusters") we've introduced a new testcase for
copy-on-read with subclusters.  Test 197 always forces qcow2 as the top
image, but allows backing image to be in any format.  That last test
case didn't meet these requirements, so let's fix it by using more
generic "qemu-io -c map" command.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Message-ID: <20230907220718.983430-1-andrey.drobyshev@virtuozzo.com>
Tested-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/197     |  8 ++++----
 tests/qemu-iotests/197.out | 18 ++++++++----------
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
index f07a9da136a..8ad2bdb035e 100755
--- a/tests/qemu-iotests/197
+++ b/tests/qemu-iotests/197
@@ -136,18 +136,18 @@ IMGPROTO=file IMGFMT=qcow2 TEST_IMG_FILE="$TEST_WRAP" \
 $QEMU_IO -c "write -P 0xaa 0 64k" "$TEST_IMG" | _filter_qemu_io

 # Allocate individual subclusters in the top image, and not the whole cluster
-$QEMU_IO -c "write -P 0xbb 28K 2K" -c "write -P 0xcc 34K 2K" "$TEST_WRAP" \
+$QEMU_IO -f qcow2 -c "write -P 0xbb 28K 2K" -c "write -P 0xcc 34K 2K" "$TEST_WRAP" \
     | _filter_qemu_io

 # Only 2 subclusters should be allocated in the top image at this point
-$QEMU_IMG map "$TEST_WRAP" | _filter_qemu_img_map
+$QEMU_IO -f qcow2 -c map "$TEST_WRAP"

 # Actual copy-on-read operation
-$QEMU_IO -C -c "read -P 0xaa 30K 4K" "$TEST_WRAP" | _filter_qemu_io
+$QEMU_IO -f qcow2 -C -c "read -P 0xaa 30K 4K" "$TEST_WRAP" | _filter_qemu_io

 # And here we should have 4 subclusters allocated right in the middle of the
 # top image. Make sure the whole cluster remains unallocated
-$QEMU_IMG map "$TEST_WRAP" | _filter_qemu_img_map
+$QEMU_IO -f qcow2 -c map "$TEST_WRAP"

 _check_test_img

diff --git a/tests/qemu-iotests/197.out b/tests/qemu-iotests/197.out
index 8f34a30afea..86c57b51d30 100644
--- a/tests/qemu-iotests/197.out
+++ b/tests/qemu-iotests/197.out
@@ -42,17 +42,15 @@ wrote 2048/2048 bytes at offset 28672
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 2048/2048 bytes at offset 34816
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Offset          Length          File
-0               0x7000          TEST_DIR/t.IMGFMT
-0x7000          0x800           TEST_DIR/t.wrap.IMGFMT
-0x7800          0x1000          TEST_DIR/t.IMGFMT
-0x8800          0x800           TEST_DIR/t.wrap.IMGFMT
-0x9000          0x7000          TEST_DIR/t.IMGFMT
+28 KiB (0x7000) bytes not allocated at offset 0 bytes (0x0)
+2 KiB (0x800) bytes     allocated at offset 28 KiB (0x7000)
+4 KiB (0x1000) bytes not allocated at offset 30 KiB (0x7800)
+2 KiB (0x800) bytes     allocated at offset 34 KiB (0x8800)
+28 KiB (0x7000) bytes not allocated at offset 36 KiB (0x9000)
 read 4096/4096 bytes at offset 30720
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Offset          Length          File
-0               0x7000          TEST_DIR/t.IMGFMT
-0x7000          0x2000          TEST_DIR/t.wrap.IMGFMT
-0x9000          0x7000          TEST_DIR/t.IMGFMT
+28 KiB (0x7000) bytes not allocated at offset 0 bytes (0x0)
+8 KiB (0x2000) bytes     allocated at offset 28 KiB (0x7000)
+28 KiB (0x7000) bytes not allocated at offset 36 KiB (0x9000)
 No errors were found on the image.
 *** done
-- 
2.41.0


