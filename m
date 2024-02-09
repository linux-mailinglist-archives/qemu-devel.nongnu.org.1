Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9095584FEB1
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Feb 2024 22:23:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYYKz-0006j8-1E; Fri, 09 Feb 2024 16:23:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rYYKv-0006ho-Qh; Fri, 09 Feb 2024 16:23:05 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rYYKu-00008r-CC; Fri, 09 Feb 2024 16:23:05 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D35334BF61;
 Sat, 10 Feb 2024 00:24:03 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id BFE1277EDB;
 Sat, 10 Feb 2024 00:22:47 +0300 (MSK)
Received: (nullmailer pid 1123166 invoked by uid 1000);
 Fri, 09 Feb 2024 21:22:47 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 09/23] qemu-img: refresh options/--help for "info" command
Date: Sat, 10 Feb 2024 00:22:30 +0300
Message-Id: <34047bb7a1ebf37cb6cf41a4610f248ebccc5b13.1707513011.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1707513011.git.mjt@tls.msk.ru>
References: <cover.1707513011.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 qemu-img.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index d4dafebff9..a1a0ba99f0 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -65,7 +65,6 @@ typedef struct img_cmd_t {
 
 enum {
     OPTION_OUTPUT = 256,
-    OPTION_BACKING_CHAIN = 257,
     OPTION_OBJECT = 258,
     OPTION_IMAGE_OPTS = 259,
     OPTION_PATTERN = 260,
@@ -3173,13 +3172,13 @@ static int img_info(const img_cmd_t *ccmd, int argc, char **argv)
             {"help", no_argument, 0, 'h'},
             {"format", required_argument, 0, 'f'},
             {"output", required_argument, 0, OPTION_OUTPUT},
-            {"backing-chain", no_argument, 0, OPTION_BACKING_CHAIN},
+            {"backing-chain", no_argument, 0, 'b'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {"force-share", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":f:hU",
+        c = getopt_long(argc, argv, ":f:hbU",
                         long_options, &option_index);
         if (c == -1) {
             break;
@@ -3192,7 +3191,20 @@ static int img_info(const img_cmd_t *ccmd, int argc, char **argv)
             unrecognized_option(ccmd, argv[optind - 1]);
             break;
         case 'h':
-            help();
+            cmd_help(ccmd,
+"[-f FMT | --image-opts] [-b] [-U] [--object OBJDEF]\n"
+"	[--output human|json] FILENAME\n"
+,
+" -f|--format FMT - specify FILENAME image format explicitly\n"
+" --image-opts - indicates that FILENAME is a complete image specification\n"
+"  instead of a file name (incompatible with --format)\n"
+" -b|--backing-chain - display information about backing chaing\n"
+" (in case the image is stacked\n"
+" -U|--force-share - open image in shared mode for concurrent access\n"
+" --object OBJDEF - QEMU user-creatable object (eg encryption key)\n"
+" --output human|json - specify output format name (default human)\n"
+" FILENAME - image file name (or specification with --image-opts)\n"
+);
             break;
         case 'f':
             fmt = optarg;
@@ -3203,7 +3215,7 @@ static int img_info(const img_cmd_t *ccmd, int argc, char **argv)
         case OPTION_OUTPUT:
             output_format = parse_output_format(ccmd, optarg);
             break;
-        case OPTION_BACKING_CHAIN:
+        case 'b':
             chain = true;
             break;
         case OPTION_OBJECT:
-- 
2.39.2


