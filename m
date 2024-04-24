Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 461D78B04DC
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Apr 2024 10:52:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzYLL-0001JQ-Sv; Wed, 24 Apr 2024 04:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rzYLB-00016S-Ko; Wed, 24 Apr 2024 04:51:00 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rzYL9-0003wK-0M; Wed, 24 Apr 2024 04:50:57 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2F90E6152E;
 Wed, 24 Apr 2024 11:50:43 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4CF95BE0DE;
 Wed, 24 Apr 2024 11:50:36 +0300 (MSK)
Received: (nullmailer pid 1179592 invoked by uid 1000);
 Wed, 24 Apr 2024 08:50:36 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-block@nongnu.org
Subject: [PATCH 05/27] qemu-img: create: refresh options/--help
Date: Wed, 24 Apr 2024 11:50:13 +0300
Message-Id: <00771f64e9f2213fefa28879b3f2ec47ac15c673.1713948448.git.mjt@tls.msk.ru>
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

Create helper function cmd_help() to display command-specific
help text, and use it to print --help for 'create' subcommand.

Add missing long options (eg --format) in img_create().

Remove usage of missing_argument()/unrecognized_option() in
img_create().

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 61 insertions(+), 8 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index e8234104e5..7ed5e6d1a8 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -132,6 +132,32 @@ void unrecognized_option(const char *option)
     error_exit("qemu-img", "unrecognized option '%s'", option);
 }
 
+/*
+ * Print --help output for a command and exit.
+ * syntax and description are multi-line with trailing EOL
+ * (to allow easy extending of the text)
+ * syntax has each subsequent line indented by 8 chars.
+ * desrciption is indented by 2 chars for argument on each own line,
+ * and with 5 chars for argument description (like -h arg below).
+ */
+static G_NORETURN
+void cmd_help(const img_cmd_t *ccmd,
+              const char *syntax, const char *arguments)
+{
+    printf(
+"Usage:\n"
+"\n"
+"  %s %s %s"
+"\n"
+"Arguments:\n"
+"  -h, --help\n"
+"     print this help and exit\n"
+"%s\n",
+           "qemu-img", ccmd->name,
+           syntax, arguments);
+    exit(EXIT_SUCCESS);
+}
+
 /* Please keep in synch with docs/tools/qemu-img.rst */
 static G_NORETURN
 void help(void)
@@ -530,23 +556,48 @@ static int img_create(const img_cmd_t *ccmd, int argc, char **argv)
     for(;;) {
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
+            {"quiet", no_argument, 0, 'q'},
             {"object", required_argument, 0, OPTION_OBJECT},
+            {"format", required_argument, 0, 'f'},
+            {"backing", required_argument, 0, 'b'},
+            {"backing-format", required_argument, 0, 'F'},
+            {"backing-unsafe", no_argument, 0, 'u'},
+            {"options", required_argument, 0, 'o'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":F:b:f:ho:qu",
+        c = getopt_long(argc, argv, "F:b:f:ho:qu",
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
+            cmd_help(ccmd,
+"[-f FMT] [-o FMT_OPTS] [-b BACKING_FILENAME [-F BACKING_FMT]]\n"
+"        [--object OBJDEF] [-u] FILENAME [SIZE[bkKMGTPE]]\n"
+,
+"  -q, --quiet\n"
+"     quiet operations\n"
+"  -f, --format FMT\n"
+"     specifies format of the new image, default is raw\n"
+"  -o, --options FMT_OPTS\n"
+"     format-specific options ('-o list' for list)\n"
+"  -b, --backing BACKING_FILENAME\n"
+"     stack new image on top of BACKING_FILENAME\n"
+"     (for formats which support stacking)\n"
+"  -F, --backing-format BACKING_FMT\n"
+"     specify format of BACKING_FILENAME\n"
+"  -u, --backing-unsafe\n"
+"     do not fail if BACKING_FMT can not be read\n"
+"  --object OBJDEF\n"
+"     QEMU user-creatable object (eg encryption key)\n"
+"  FILENAME\n"
+"     image file to create.  It will be overridden if exists\n"
+"  SIZE\n"
+"     image size with optional suffix (multiplies in 1024)\n"
+"     SIZE is required unless BACKING_IMG is specified,\n"
+"     in which case it will be the same as size of BACKING_IMG\n"
+);
             break;
         case 'F':
             base_fmt = optarg;
@@ -571,6 +622,8 @@ static int img_create(const img_cmd_t *ccmd, int argc, char **argv)
         case OPTION_OBJECT:
             user_creatable_process_cmdline(optarg);
             break;
+        default:
+            tryhelp(argv[0]);
         }
     }
 
-- 
2.39.2


