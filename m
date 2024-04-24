Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A225A8B04E9
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Apr 2024 10:52:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzYMH-00044e-EN; Wed, 24 Apr 2024 04:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rzYM9-0003Ze-Dm; Wed, 24 Apr 2024 04:52:00 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rzYM7-000454-K2; Wed, 24 Apr 2024 04:51:57 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BF7C061539;
 Wed, 24 Apr 2024 11:50:43 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E959DBE0E9;
 Wed, 24 Apr 2024 11:50:36 +0300 (MSK)
Received: (nullmailer pid 1179626 invoked by uid 1000);
 Wed, 24 Apr 2024 08:50:36 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-block@nongnu.org
Subject: [PATCH 16/27] qemu-img: snapshot: refresh options/--help
Date: Wed, 24 Apr 2024 11:50:24 +0300
Message-Id: <0febc7a1a012bcd6311c36a9ae4bf293246389f7.1713948448.git.mjt@tls.msk.ru>
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
 qemu-img.c | 45 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 967f6343de..62f9ce4069 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3609,26 +3609,51 @@ static int img_snapshot(const img_cmd_t *ccmd, int argc, char **argv)
     for(;;) {
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
+            {"quiet", no_argument, 0, 'q'},
             {"object", required_argument, 0, OPTION_OBJECT},
+            {"format", required_argument, 0, 'f'},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {"force-share", no_argument, 0, 'U'},
+            {"list", no_argument, 0, SNAPSHOT_LIST},
+            {"apply", no_argument, 0, SNAPSHOT_APPLY},
+            {"create", no_argument, 0, SNAPSHOT_CREATE},
+            {"delete", no_argument, 0, SNAPSHOT_DELETE},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":la:c:d:f:hqU",
+        c = getopt_long(argc, argv, "la:c:d:f:hqU",
                         long_options, NULL);
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
-            return 0;
+            cmd_help(ccmd,
+"[-f FMT | --image-opts] [-l | -a|-c|-d SNAPSHOT]\n"
+"        [-U] [--object OBJDEF] FILENAME\n"
+,
+"  -q, --quiet\n"
+"      quiet operations\n"
+"  -f, --format FMT\n"
+"      specify FILENAME format explicitly\n"
+"  --image-opts\n"
+"      indicates that FILENAME is a complete image specification\n"
+"   instead of a file name (incompatible with --format)\n"
+"  -U, --force-share\n"
+"      open image in shared mode for concurrent access\n"
+"  --object OBJDEF\n"
+"      QEMU user-creatable object (eg encryption key)\n"
+"  Operation, one of:\n"
+"    -l, --list\n"
+"       list snapshots in FILENAME (the default)\n"
+"    -c, --create SNAPSHOT\n"
+"       create named snapshot\n"
+"    -a, --apply SNAPSHOT\n"
+"       apply named snapshot to the base\n"
+"    -d, --delete SNAPSHOT\n"
+"       delete named snapshot\n"
+"  FILENAME - image file name (or specification with --image-opts)\n"
+);
+            break;
         case 'f':
             fmt = optarg;
             break;
@@ -3655,6 +3680,8 @@ static int img_snapshot(const img_cmd_t *ccmd, int argc, char **argv)
         case OPTION_IMAGE_OPTS:
             image_opts = true;
             break;
+        default:
+            tryhelp(argv[0]);
         }
     }
 
-- 
2.39.2


