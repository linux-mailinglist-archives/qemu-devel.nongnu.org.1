Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA85987E32
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Sep 2024 08:14:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su4EN-0005E7-NY; Fri, 27 Sep 2024 02:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1su4E6-0003bu-RC; Fri, 27 Sep 2024 02:13:15 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1su4E1-0003Wq-Nd; Fri, 27 Sep 2024 02:13:11 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7B0A592D28;
 Fri, 27 Sep 2024 09:10:52 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id EAC9214671A;
 Fri, 27 Sep 2024 09:11:22 +0300 (MSK)
Received: (nullmailer pid 573410 invoked by uid 1000);
 Fri, 27 Sep 2024 06:11:21 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 23/27] qemu-img: dd: refresh options/--help
Date: Fri, 27 Sep 2024 09:11:17 +0300
Message-Id: <20240927061121.573271-24-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240927061121.573271-1-mjt@tls.msk.ru>
References: <20240927061121.573271-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
 qemu-img.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 7c20a5772d..b3e521bc09 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -5504,31 +5504,48 @@ static int img_dd(const img_cmd_t *ccmd, int argc, char **argv)
     const struct option long_options[] = {
         { "help", no_argument, 0, 'h'},
         { "object", required_argument, 0, OPTION_OBJECT},
+        { "format", required_argument, 0, 'f'},
+        { "output-format", required_argument, 0, 'O'},
         { "image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
         { "force-share", no_argument, 0, 'U'},
         { 0, 0, 0, 0 }
     };
 
-    while ((c = getopt_long(argc, argv, ":hf:O:U", long_options, NULL))) {
+    while ((c = getopt_long(argc, argv, "hf:O:U", long_options, NULL))) {
         if (c == EOF) {
             break;
         }
         switch (c) {
+        case 'h':
+            cmd_help(ccmd,
+"[-f FMT|--image-opts] [-O OUTPUT_FMT] [-U]\n"
+"        [bs=BLOCK_SIZE] [count=BLOCKS] if=INPUT of=OUTPUT\n"
+,
+"  -f, --format FMT\n"
+"     specify format for INPUT explicitly\n"
+"  --image-opts\n"
+"     indicates that INPUT is a complete image specification\n"
+"     instead of a file name (incompatible with --format)\n"
+"  -O, --output-format OUTPUT_FMT\n"
+"     format of the OUTPUT (default raw)\n"
+"  -U, --force-share\n"
+"     open images in shared mode for concurrent access\n"
+"  bs=BLOCK_SIZE[kKMGTP]\n"
+"     size of I/O block (default 512)\n"
+"  count=COUNT\n"
+"     number of blocks to convert (default whole INPUT)\n"
+"  if=INPUT\n"
+"     input file name (or image specification with --image-opts)\n"
+"  of=OUTPUT\n"
+"     output file name to create\n"
+);
+            break;
         case 'O':
             out_fmt = optarg;
             break;
         case 'f':
             fmt = optarg;
             break;
-        case ':':
-            missing_argument(argv[optind - 1]);
-            break;
-        case '?':
-            unrecognized_option(argv[optind - 1]);
-            break;
-        case 'h':
-            help();
-            break;
         case 'U':
             force_share = true;
             break;
@@ -5538,6 +5555,8 @@ static int img_dd(const img_cmd_t *ccmd, int argc, char **argv)
         case OPTION_IMAGE_OPTS:
             image_opts = true;
             break;
+        default:
+            tryhelp(argv[0]);
         }
     }
 
-- 
2.39.5


