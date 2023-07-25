Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDABB761B3B
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:20:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOIt2-0001Ny-4j; Tue, 25 Jul 2023 10:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qOIt0-0001N0-4g
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:19:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qOIsx-00018r-Ok
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690294775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ElkOAw29cupZm2Lb8DTdXY3ykifXeEsS4g38U+Sj6PU=;
 b=epx8J52B7Mw7eFjLPMlBLwTJVirWcd7ceJ1VOUAHI+VoWn5jXJlRStLaD6Xmp+g9wtDefq
 BrtNhGkq1HRGeYFVX+sS/kkh89G0jBM92R6ZOR/l2vxcsyBbyQxgK89iJgSr2pfrTO55Zh
 SzCVCE74wLgKX/baA2cr8n/bG6novVE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-Gcm6aizTM-upy-_BmQSqhg-1; Tue, 25 Jul 2023 10:19:29 -0400
X-MC-Unique: Gcm6aizTM-upy-_BmQSqhg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2743B809F8F;
 Tue, 25 Jul 2023 14:19:29 +0000 (UTC)
Received: from localhost (unknown [10.39.192.118])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB4BA2166B25;
 Tue, 25 Jul 2023 14:19:28 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 5/7] iotests: add -io_uring support
Date: Tue, 25 Jul 2023 10:19:13 -0400
Message-ID: <20230725141915.386364-6-stefanha@redhat.com>
In-Reply-To: <20230725141915.386364-1-stefanha@redhat.com>
References: <20230725141915.386364-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The libblkio-based io_uring block driver currently has no test coverage.
Running existing qemu-iotests with io_uring is possible with just a few
tweaks.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/033       |  1 +
 tests/qemu-iotests/check     |  2 +-
 tests/qemu-iotests/common.rc | 12 +++++++++++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/033 b/tests/qemu-iotests/033
index da9133c44b..a32af9942f 100755
--- a/tests/qemu-iotests/033
+++ b/tests/qemu-iotests/033
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt generic
 _supported_proto generic
+_unsupported_proto io_uring # libblkio 1.3.0 does not support write_zeroes with FUA
 _unsupported_imgopts "subformat=streamOptimized"
 
 
diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index f2e9d27dcf..7a3368b768 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -94,7 +94,7 @@ def make_argparser() -> argparse.ArgumentParser:
         mg.add_argument('-' + fmt, dest='imgfmt', action='store_const',
                         const=fmt, help=f'test {fmt}')
 
-    protocol_list = ['file', 'rbd', 'nbd', 'ssh', 'nfs', 'fuse']
+    protocol_list = ['file', 'rbd', 'nbd', 'ssh', 'nfs', 'fuse', 'io_uring']
     g_prt = p.add_argument_group(
         '  image protocol options',
         'The following options set the IMGPROTO environment variable. '
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index d145f08201..da4b972ebd 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -290,6 +290,9 @@ if [ "$IMGOPTSSYNTAX" = "true" ]; then
     elif [ "$IMGPROTO" = "fuse" ]; then
         TEST_IMG_FILE=$TEST_DIR/t.$IMGFMT
         TEST_IMG="$DRIVER,file.filename=$SOCK_DIR/fuse-t.$IMGFMT"
+    elif [ "$IMGPROTO" = "io_uring" ]; then
+        TEST_IMG_FILE=$TEST_DIR/t.$IMGFMT
+        TEST_IMG="$DRIVER,file.driver=$IMGPROTO,file.filename=$TEST_DIR/t.$IMGFMT"
     elif [ "$IMGPROTO" = "ssh" ]; then
         TEST_IMG_FILE=$TEST_DIR/t.$IMGFMT
         TEST_IMG="$DRIVER,file.driver=ssh,file.host=127.0.0.1,file.path=$TEST_IMG_FILE"
@@ -309,6 +312,9 @@ else
     elif [ "$IMGPROTO" = "fuse" ]; then
         TEST_IMG_FILE=$TEST_DIR/t.$IMGFMT
         TEST_IMG="$SOCK_DIR/fuse-t.$IMGFMT"
+    elif [ "$IMGPROTO" = "io_uring" ]; then
+        TEST_IMG_FILE=$TEST_DIR/t.$IMGFMT
+        TEST_IMG=io_uring:$TEST_DIR/t.$IMGFMT
     elif [ "$IMGPROTO" = "ssh" ]; then
         TEST_IMG_FILE=$TEST_DIR/t.$IMGFMT
         REMOTE_TEST_DIR="ssh://\\($USER@\\)\\?127.0.0.1\\(:[0-9]\\+\\)\\?$TEST_DIR"
@@ -400,6 +406,10 @@ _test_img_to_test_img_file()
             echo "$1" | sed -e "s#$SOCK_DIR/fuse-#$TEST_DIR/#"
             ;;
 
+        io_uring)
+            echo "$1" | sed -e "s#io_uring:##"
+            ;;
+
         nfs)
             echo "$1" | sed -e "s#nfs://127.0.0.1##"
             ;;
@@ -653,7 +663,7 @@ _cleanup_test_img()
             FUSE_EXPORTS=()
             ;;
 
-        file)
+        file|io_uring)
             _rm_test_img "$TEST_DIR/t.$IMGFMT"
             _rm_test_img "$TEST_DIR/t.$IMGFMT.orig"
             _rm_test_img "$TEST_DIR/t.$IMGFMT.base"
-- 
2.41.0


