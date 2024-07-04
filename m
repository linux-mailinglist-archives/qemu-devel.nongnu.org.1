Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F9F927E71
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jul 2024 23:04:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPTb5-0001rT-8f; Thu, 04 Jul 2024 17:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPTau-0001Sm-F8; Thu, 04 Jul 2024 17:02:20 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPTas-0004S0-6k; Thu, 04 Jul 2024 17:02:19 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 937A377570;
 Fri,  5 Jul 2024 00:00:51 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 9B85DFECA9;
 Fri,  5 Jul 2024 00:00:56 +0300 (MSK)
Received: (nullmailer pid 1507768 invoked by uid 1000);
 Thu, 04 Jul 2024 21:00:55 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.2 18/22] qcow2: Don't open data_file with BDRV_O_NO_IO
Date: Fri,  5 Jul 2024 00:00:48 +0300
Message-Id: <20240704210055.1507652-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.2-20240704162154@cover.tls.msk.ru>
References: <qemu-stable-9.0.2-20240704162154@cover.tls.msk.ru>
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

From: Kevin Wolf <kwolf@redhat.com>

One use case for 'qemu-img info' is verifying that untrusted images
don't reference an unwanted external file, be it as a backing file or an
external data file. To make sure that calling 'qemu-img info' can't
already have undesired side effects with a malicious image, just don't
open the data file at all with BDRV_O_NO_IO. If nothing ever tries to do
I/O, we don't need to have it open.

This changes the output of iotests case 061, which used 'qemu-img info'
to show that opening an image with an invalid data file fails. After
this patch, it succeeds. Replace this part of the test with a qemu-io
call, but keep the final 'qemu-img info' to show that the invalid data
file is correctly displayed in the output.

Fixes: CVE-2024-4467
Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
(cherry picked from commit bd385a5298d7062668e804d73944d52aec9549f1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/qcow2.c b/block/qcow2.c
index 956128b409..4c78665bcb 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1636,7 +1636,22 @@ qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
-    if (open_data_file) {
+    if (open_data_file && (flags & BDRV_O_NO_IO)) {
+        /*
+         * Don't open the data file for 'qemu-img info' so that it can be used
+         * to verify that an untrusted qcow2 image doesn't refer to external
+         * files.
+         *
+         * Note: This still makes has_data_file() return true.
+         */
+        if (s->incompatible_features & QCOW2_INCOMPAT_DATA_FILE) {
+            s->data_file = NULL;
+        } else {
+            s->data_file = bs->file;
+        }
+        qdict_extract_subqdict(options, NULL, "data-file.");
+        qdict_del(options, "data-file");
+    } else if (open_data_file) {
         /* Open external data file */
         bdrv_graph_co_rdunlock();
         s->data_file = bdrv_co_open_child(NULL, options, "data-file", bs,
diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
index 53c7d428e3..b71ac097d1 100755
--- a/tests/qemu-iotests/061
+++ b/tests/qemu-iotests/061
@@ -326,12 +326,14 @@ $QEMU_IMG amend -o "data_file=foo" "$TEST_IMG"
 echo
 _make_test_img -o "compat=1.1,data_file=$TEST_IMG.data" 64M
 $QEMU_IMG amend -o "data_file=foo" "$TEST_IMG"
-_img_info --format-specific
+$QEMU_IO -c "read 0 4k" "$TEST_IMG" 2>&1 | _filter_testdir | _filter_imgfmt
+$QEMU_IO -c "open -o data-file.filename=$TEST_IMG.data,file.filename=$TEST_IMG" -c "read 0 4k" | _filter_qemu_io
 TEST_IMG="data-file.filename=$TEST_IMG.data,file.filename=$TEST_IMG" _img_info --format-specific --image-opts
 
 echo
 $QEMU_IMG amend -o "data_file=" --image-opts "data-file.filename=$TEST_IMG.data,file.filename=$TEST_IMG"
-_img_info --format-specific
+$QEMU_IO -c "read 0 4k" "$TEST_IMG" 2>&1 | _filter_testdir | _filter_imgfmt
+$QEMU_IO -c "open -o data-file.filename=$TEST_IMG.data,file.filename=$TEST_IMG" -c "read 0 4k" | _filter_qemu_io
 TEST_IMG="data-file.filename=$TEST_IMG.data,file.filename=$TEST_IMG" _img_info --format-specific --image-opts
 
 echo
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index 139fc68177..24c33add7c 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -545,7 +545,9 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 qemu-img: data-file can only be set for images that use an external data file
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 data_file=TEST_DIR/t.IMGFMT.data
-qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Could not open 'foo': No such file or directory
+qemu-io: can't open device TEST_DIR/t.IMGFMT: Could not open 'foo': No such file or directory
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 64 MiB (67108864 bytes)
@@ -560,7 +562,9 @@ Format specific information:
     corrupt: false
     extended l2: false
 
-qemu-img: Could not open 'TEST_DIR/t.IMGFMT': 'data-file' is required for this image
+qemu-io: can't open device TEST_DIR/t.IMGFMT: 'data-file' is required for this image
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 64 MiB (67108864 bytes)
-- 
2.39.2


