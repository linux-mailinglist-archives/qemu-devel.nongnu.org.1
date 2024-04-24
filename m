Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D60948B04D4
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Apr 2024 10:51:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzYLg-0001oY-27; Wed, 24 Apr 2024 04:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rzYLL-0001KN-3L; Wed, 24 Apr 2024 04:51:07 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rzYLJ-0003yS-5v; Wed, 24 Apr 2024 04:51:06 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7024D61533;
 Wed, 24 Apr 2024 11:50:43 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 9A109BE0E3;
 Wed, 24 Apr 2024 11:50:36 +0300 (MSK)
Received: (nullmailer pid 1179607 invoked by uid 1000);
 Wed, 24 Apr 2024 08:50:36 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-block@nongnu.org
Subject: [PATCH 10/27] qemu-img: compare: refresh options/--help
Date: Wed, 24 Apr 2024 11:50:18 +0300
Message-Id: <71a9248ec3cd5f0442d84288a7e139e342d49c59.1713948448.git.mjt@tls.msk.ru>
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

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.c | 45 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 7a111bce72..ea66bfa195 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1488,25 +1488,52 @@ static int img_compare(const img_cmd_t *ccmd, int argc, char **argv)
     for (;;) {
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
+            {"quiet", no_argument, 0, 'q'},
             {"object", required_argument, 0, OPTION_OBJECT},
+            {"cache", required_argument, 0, 'T'},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"a-format", required_argument, 0, 'f'},
+            {"left-format", required_argument, 0, 'f'},
+            {"b-format", required_argument, 0, 'F'},
+            {"right-format", required_argument, 0, 'F'},
             {"force-share", no_argument, 0, 'U'},
+            {"strict", no_argument, 0, 's'},
+            {"progress", no_argument, 0, 'p'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":hf:F:T:pqsU",
+        c = getopt_long(argc, argv, "hf:F:T:pqsU",
                         long_options, NULL);
         if (c == -1) {
             break;
         }
         switch (c) {
-        case ':':
-            missing_argument(argv[optind - 1]);
-            break;
-        case '?':
-            unrecognized_option(argv[optind - 1]);
-            break;
         case 'h':
-            help();
+            cmd_help(ccmd,
+"[--image-opts | [-f FMT] [-F FMT]] [-s]\n"
+"        [-T CACHE] [-U] [--object OBJDEF] FILENAME1 FILENAME2\n"
+,
+"  -q, --quiet\n"
+"     quiet operation\n"
+"  -p, --progress\n"
+"     show operation progress\n"
+"  -f, --a-format FMT\n"
+"     specify FILENAME1 image format explicitly\n"
+"  -F, --b-format FMT\n"
+"     specify FILENAME2 image format explicitly\n"
+"  --image-opts\n"
+"     indicates that FILENAMEs are complete image specifications\n"
+"     instead of file names (incompatible with --a-format and --b-format)\n"
+"  -s, --strict\n"
+"     strict mode, also check if sizes are equal\n"
+"  -T, --cache CACHE_MODE\n"
+"     images caching mode (" BDRV_DEFAULT_CACHE ")\n"
+"  -U, --force-share\n"
+"     open images in shared mode for concurrent access\n"
+"  --object OBJDEF\n"
+"     QEMU user-creatable object (eg encryption key)\n"
+"  FILENAME1, FILENAME2\n"
+"     image files (or specifications) to compare\n"
+);
             break;
         case 'f':
             fmt1 = optarg;
@@ -1547,6 +1574,8 @@ static int img_compare(const img_cmd_t *ccmd, int argc, char **argv)
         case OPTION_IMAGE_OPTS:
             image_opts = true;
             break;
+        default:
+            tryhelp(argv[0]);
         }
     }
 
-- 
2.39.2


