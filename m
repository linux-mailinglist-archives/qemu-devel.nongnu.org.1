Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD8B8B04D1
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Apr 2024 10:51:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzYLg-0001p6-3x; Wed, 24 Apr 2024 04:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rzYLN-0001TU-2P; Wed, 24 Apr 2024 04:51:09 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rzYLK-0003yz-H8; Wed, 24 Apr 2024 04:51:08 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7E87161534;
 Wed, 24 Apr 2024 11:50:43 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A6F24BE0E4;
 Wed, 24 Apr 2024 11:50:36 +0300 (MSK)
Received: (nullmailer pid 1179610 invoked by uid 1000);
 Wed, 24 Apr 2024 08:50:36 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-block@nongnu.org
Subject: [PATCH 11/27] qemu-img: convert: refresh options/--help
Date: Wed, 24 Apr 2024 11:50:19 +0300
Message-Id: <347c9859e4a3aa7f916a1daf60c48fafe6442587.1713948448.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1713948448.git.mjt@tls.msk.ru>
References: <cover.1713948448.git.mjt@tls.msk.ru>
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

Add missing long options and --help output.

convert uses -B for --backing, - why not -b?

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 81 insertions(+), 9 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index ea66bfa195..0a32d890e3 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2404,30 +2404,100 @@ static int img_convert(const img_cmd_t *ccmd, int argc, char **argv)
     for(;;) {
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
+            {"quiet", no_argument, 0, 'q'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"source-image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"source-format", required_argument, 0, 'f'},
+            {"source-cache", required_argument, 0, 'T'},
+            {"snapshot", required_argument, 0, 'l'},
+            {"sparse-size", required_argument, 0, 'S'},
+            {"output-format", required_argument, 0, 'O'},
+            {"options", required_argument, 0, 'o'},
+            {"output-cache", required_argument, 0, 't'},
+            {"backing", required_argument, 0, 'B'},
+            {"backing-format", required_argument, 0, 'F'},
             {"force-share", no_argument, 0, 'U'},
             {"target-image-opts", no_argument, 0, OPTION_TARGET_IMAGE_OPTS},
             {"salvage", no_argument, 0, OPTION_SALVAGE},
             {"target-is-zero", no_argument, 0, OPTION_TARGET_IS_ZERO},
             {"bitmaps", no_argument, 0, OPTION_BITMAPS},
             {"skip-broken-bitmaps", no_argument, 0, OPTION_SKIP_BROKEN},
+            {"rate", required_argument, 0, 'r'},
+            {"parallel", required_argument, 0, 'm'},
+            {"oob-writes", no_argument, 0, 'W'},
+            {"copy-range-offloading", no_argument, 0, 'C'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":hf:O:B:CcF:o:l:S:pt:T:qnm:WUr:",
+        c = getopt_long(argc, argv, "hf:O:B:CcF:o:l:S:pt:T:qnm:WUr:",
                         long_options, NULL);
         if (c == -1) {
             break;
         }
-        switch(c) {
-        case ':':
-            missing_argument(argv[optind - 1]);
-            break;
-        case '?':
-            unrecognized_option(argv[optind - 1]);
-            break;
+        switch (c) {
         case 'h':
-            help();
+            cmd_help(ccmd,
+"[-f SRC_FMT|--image-opts] [-T SRC_CACHE] [--bitmaps [--skip-broken-bitmaps]]\n"
+"        [-o TGT_OPTS|--target-image-opts] [-t TGT_CACHE] [-n]\n"
+"        [-B BACKING_FILENAME [-F BACKING_FMT]]\n"
+"        SRC_FILENAME [SRC_FILENAME2 [...]] TGT_FILENAME\n"
+,
+"  -q, --quiet\n"
+"     quiet operations\n"
+"  -p, --progress\n"
+"     show operation progress\n"
+"  -f, --source-format SRC_FMT\n"
+"     specify SRC_FILENAME source image format explicitly\n"
+"  --source-image-opts\n"
+"     indicates that SRC_FILENAME is a complete image specification\n"
+"     instead of a file name (incompatible with --source-format)\n"
+"  -l, --source-snapshot SNAPSHOT_PARAMS\n"
+"     specify source snapshot parameters\n"
+"  -T, --source-cache SRC_CACHE\n"
+"     source image(s) cache mode (" BDRV_DEFAULT_CACHE ")\n"
+"  -O, --target-format TGT_FMT\n"
+"     specify TGT_FILENAME image format (default is raw)\n"
+"  --target-image-opts\n"
+"     indicates that TGT_FILENAME is a complete image specification\n"
+"     instead of a file name (incompatible with --output-format)\n"
+"  -o, --target-options TGT_OPTS\n"
+"     TARGET_FMT-specific options\n"
+"  -c, --compress\n"
+"     create compressed output image (qcow and qcow2 format only)\n"
+"  -t, --target-cache TGT_CACHE\n"
+"     cache mode when opening output image (unsafe)\n"
+"  -B, --backing BACKING_FILENAME\n"
+"     create output to be a CoW on top of BACKING_FILENAME\n"
+"  -F, --backing-format BACKING_FMT\n"
+"     specify BACKING_FILENAME image format explicitly\n"
+"  -n, --no-create\n"
+"     omit target volume creation (eg on rbd)\n"
+"  --target-is-zero\n"
+"  -S, --sparse-size SPARSE_SIZE\n"
+"     XXX todo\n"
+"  --bitmaps\n"
+"     also copy any persistent bitmaps present in source\n"
+"  --skip-broken-bitmaps\n"
+"     skip (do not error out) any broken bitmaps\n"
+"  -U, --force-share\n"
+"     open images in shared mode for concurrent access\n"
+"  -r, --rate RATE\n"
+"     I/O rate limit\n"
+"  -m, --parallel NUM_COROUTINES\n"
+"     specify parallelism (default 8)\n"
+"  -C, --copy-range-offloading\n"
+"     use copy_range offloading\n"
+"  --salvage\n"
+"     XXX todo\n"
+"  -W, --oob-writes\n"
+"     enable out-of-order writes to improve performance\n"
+"  --object OBJDEF\n"
+"     QEMU user-creatable object (eg encryption key)\n"
+"  SRC_FILENAME\n"
+"     source image file name (or specification with --image-opts)\n"
+"  TGT_FILENAME\n"
+"     target (output) image file name\n"
+);
             break;
         case 'f':
             fmt = optarg;
@@ -2546,6 +2616,8 @@ static int img_convert(const img_cmd_t *ccmd, int argc, char **argv)
         case OPTION_SKIP_BROKEN:
             skip_broken = true;
             break;
+        default:
+            tryhelp(argv[0]);
         }
     }
 
-- 
2.39.2


