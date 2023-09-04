Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F277919CD
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 16:39:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdAhL-00028S-Te; Mon, 04 Sep 2023 10:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qdAhI-00024j-FR
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:37:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qdAhD-0001im-Qy
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693838215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YppG38p4fI7IkW5KTcUJJ8zgxjw9sbWGfDrMfbpE9oA=;
 b=ZdNT/tumB95Z+HrdxK2MzskYFqYnDBnT4H69SX0jcmwfjgy6NxD8BRXh6jnPbuQ79n7X7G
 sujkbCYheZaWifqJCLa1OAUgpWFBsvitxep/8OA1f7hEq2PPfZE+xPD8feksjBfBek64Ov
 y7UANxi4WoGhjagMop/CdCu+lsQQydU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-uP6kimPPNoCbvIPwucGj0g-1; Mon, 04 Sep 2023 10:36:53 -0400
X-MC-Unique: uP6kimPPNoCbvIPwucGj0g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B8BD3803921;
 Mon,  4 Sep 2023 14:36:53 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E108C493114;
 Mon,  4 Sep 2023 14:36:52 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 05/14] qemu-img: omit errno value in error message
Date: Mon,  4 Sep 2023 16:36:34 +0200
Message-ID: <20230904143643.259916-6-kwolf@redhat.com>
In-Reply-To: <20230904143643.259916-1-kwolf@redhat.com>
References: <20230904143643.259916-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

From: Michael Tokarev <mjt@tls.msk.ru>

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
Message-ID: <20230811110946.2435067-1-mjt@tls.msk.ru>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
2.41.0


