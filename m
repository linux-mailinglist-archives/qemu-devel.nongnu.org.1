Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 831618B0505
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Apr 2024 10:53:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzYLT-0001Xo-6L; Wed, 24 Apr 2024 04:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rzYLE-0001Ay-UZ; Wed, 24 Apr 2024 04:51:01 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rzYLD-0003xB-4g; Wed, 24 Apr 2024 04:51:00 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4A13661530;
 Wed, 24 Apr 2024 11:50:43 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7409FBE0E0;
 Wed, 24 Apr 2024 11:50:36 +0300 (MSK)
Received: (nullmailer pid 1179598 invoked by uid 1000);
 Wed, 24 Apr 2024 08:50:36 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-block@nongnu.org
Subject: [PATCH 07/27] qemu-img: check: refresh options/--help
Date: Wed, 24 Apr 2024 11:50:15 +0300
Message-Id: <45e4705726f1982098e346ceb8c85d2af00aa1aa.1713948448.git.mjt@tls.msk.ru>
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

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 08536553c7..1bd88fcf63 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -805,7 +805,9 @@ static int img_check(const img_cmd_t *ccmd, int argc, char **argv)
         int option_index = 0;
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
+            {"quiet", no_argument, 0, 'q'},
             {"format", required_argument, 0, 'f'},
+            {"cache", required_argument, 0, 'T'},
             {"repair", required_argument, 0, 'r'},
             {"output", required_argument, 0, OPTION_OUTPUT},
             {"object", required_argument, 0, OPTION_OBJECT},
@@ -813,20 +815,38 @@ static int img_check(const img_cmd_t *ccmd, int argc, char **argv)
             {"force-share", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":hf:r:T:qU",
+        c = getopt_long(argc, argv, "hf:r:T:qU",
                         long_options, &option_index);
         if (c == -1) {
             break;
         }
         switch(c) {
-        case ':':
-            missing_argument(argv[optind - 1]);
-            break;
-        case '?':
-            unrecognized_option(argv[optind - 1]);
-            break;
         case 'h':
-            help();
+            cmd_help(ccmd,
+"[-f FMT | --image-opts] [-T CACHE_MODE] [-r] [-u]\n"
+"        [--output human|json] [--object OBJDEF] FILENAME\n"
+,
+"  -q, --quiet\n"
+"     quiet operations\n"
+"  -f, --format FMT\n"
+"     specifies format of the image explicitly\n"
+"  --image-opts\n"
+"     indicates that FILENAME is a complete image specification\n"
+"     instead of a file name (incompatible with --format)\n"
+"  -T, --cache CACHE_MODE\n"
+"     image cache mode (" BDRV_DEFAULT_CACHE ")\n"
+"  -U, --force-share\n"
+"     open image in shared mode for concurrent access\n"
+"  --output human|json\n"
+"     output format\n"
+"  -r, --repair leaks|all\n"
+"     repair particular aspect of the image\n"
+"     (image will be open in read-write mode, incompatible with --force-share)\n"
+"  --object OBJDEF\n"
+"     QEMU user-creatable object (eg encryption key)\n"
+"  FILENAME\n"
+"     the image file (or image specification) to operate on\n"
+);
             break;
         case 'f':
             fmt = optarg;
@@ -861,6 +881,8 @@ static int img_check(const img_cmd_t *ccmd, int argc, char **argv)
         case OPTION_IMAGE_OPTS:
             image_opts = true;
             break;
+        default:
+            tryhelp(argv[0]);
         }
     }
     if (optind != argc - 1) {
-- 
2.39.2


