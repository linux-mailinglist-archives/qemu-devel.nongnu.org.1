Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B040984FEB7
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Feb 2024 22:24:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYYMP-0001fM-Et; Fri, 09 Feb 2024 16:24:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rYYMM-0001SB-8U; Fri, 09 Feb 2024 16:24:34 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rYYMJ-0000Gp-TX; Fri, 09 Feb 2024 16:24:33 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8C8B74BF6E;
 Sat, 10 Feb 2024 00:24:04 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 781AD77EE8;
 Sat, 10 Feb 2024 00:22:48 +0300 (MSK)
Received: (nullmailer pid 1123206 invoked by uid 1000);
 Fri, 09 Feb 2024 21:22:47 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 22/23] qemu-img: implement short --help,
 remove global help() function
Date: Sat, 10 Feb 2024 00:22:43 +0300
Message-Id: <e791b4d2a91baddca79811b7ceb71e7223796b4f.1707513012.git.mjt@tls.msk.ru>
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

now once all individual subcommands has --help support, remove
the large unreadable help() thing and replace it with small
global --help, which refers to individual command --help for
more info.

While at it, also line-wrap list of formats after 74 chars.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.c | 148 +++++++++++------------------------------------------
 1 file changed, 30 insertions(+), 118 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index e2c8855ff5..d9c5c6078b 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -94,11 +94,6 @@ typedef enum OutputFormat {
 /* Default to cache=writeback as data integrity is not important for qemu-img */
 #define BDRV_DEFAULT_CACHE "writeback"
 
-static void format_print(void *opaque, const char *name)
-{
-    printf(" %s", name);
-}
-
 static G_NORETURN G_GNUC_PRINTF(2, 3)
 void error_exit(const img_cmd_t *ccmd, const char *fmt, ...)
 {
@@ -154,114 +149,6 @@ static OutputFormat parse_output_format(const img_cmd_t *ccmd, const char *arg)
     }
 }
 
-/* Please keep in synch with docs/tools/qemu-img.rst */
-static G_NORETURN
-void help(void)
-{
-    const char *help_msg =
-           QEMU_IMG_VERSION
-           "usage: qemu-img [standard options] command [command options]\n"
-           "QEMU disk image utility\n"
-           "\n"
-           "    '-h', '--help'       display this help and exit\n"
-           "    '-V', '--version'    output version information and exit\n"
-           "    '-T', '--trace'      [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
-           "                         specify tracing options\n"
-           "\n"
-           "Command syntax:\n"
-#define DEF(option, callback, arg_string)        \
-           "  " arg_string "\n"
-#include "qemu-img-cmds.h"
-#undef DEF
-           "\n"
-           "Command parameters:\n"
-           "  'filename' is a disk image filename\n"
-           "  'objectdef' is a QEMU user creatable object definition. See the qemu(1)\n"
-           "    manual page for a description of the object properties. The most common\n"
-           "    object type is a 'secret', which is used to supply passwords and/or\n"
-           "    encryption keys.\n"
-           "  'fmt' is the disk image format. It is guessed automatically in most cases\n"
-           "  'cache' is the cache mode used to write the output disk image, the valid\n"
-           "    options are: 'none', 'writeback' (default, except for convert), 'writethrough',\n"
-           "    'directsync' and 'unsafe' (default for convert)\n"
-           "  'src_cache' is the cache mode used to read input disk images, the valid\n"
-           "    options are the same as for the 'cache' option\n"
-           "  'size' is the disk image size in bytes. Optional suffixes\n"
-           "    'k' or 'K' (kilobyte, 1024), 'M' (megabyte, 1024k), 'G' (gigabyte, 1024M),\n"
-           "    'T' (terabyte, 1024G), 'P' (petabyte, 1024T) and 'E' (exabyte, 1024P)  are\n"
-           "    supported. 'b' is ignored.\n"
-           "  'output_filename' is the destination disk image filename\n"
-           "  'output_fmt' is the destination format\n"
-           "  'options' is a comma separated list of format specific options in a\n"
-           "    name=value format. Use -o help for an overview of the options supported by\n"
-           "    the used format\n"
-           "  'snapshot_param' is param used for internal snapshot, format\n"
-           "    is 'snapshot.id=[ID],snapshot.name=[NAME]', or\n"
-           "    '[ID_OR_NAME]'\n"
-           "  '-c' indicates that target image must be compressed (qcow format only)\n"
-           "  '-u' allows unsafe backing chains. For rebasing, it is assumed that old and\n"
-           "       new backing file match exactly. The image doesn't need a working\n"
-           "       backing file before rebasing in this case (useful for renaming the\n"
-           "       backing file). For image creation, allow creating without attempting\n"
-           "       to open the backing file.\n"
-           "  '-h' with or without a command shows this help and lists the supported formats\n"
-           "  '-p' show progress of command (only certain commands)\n"
-           "  '-q' use Quiet mode - do not print any output (except errors)\n"
-           "  '-S' indicates the consecutive number of bytes (defaults to 4k) that must\n"
-           "       contain only zeros for qemu-img to create a sparse image during\n"
-           "       conversion. If the number of bytes is 0, the source will not be scanned for\n"
-           "       unallocated or zero sectors, and the destination image will always be\n"
-           "       fully allocated\n"
-           "  '--output' takes the format in which the output must be done (human or json)\n"
-           "  '-n' skips the target volume creation (useful if the volume is created\n"
-           "       prior to running qemu-img)\n"
-           "\n"
-           "Parameters to bitmap subcommand:\n"
-           "  'bitmap' is the name of the bitmap to manipulate, through one or more\n"
-           "       actions from '--add', '--remove', '--clear', '--enable', '--disable',\n"
-           "       or '--merge source'\n"
-           "  '-g granularity' sets the granularity for '--add' actions\n"
-           "  '-b source' and '-F src_fmt' tell '--merge' actions to find the source\n"
-           "       bitmaps from an alternative file\n"
-           "\n"
-           "Parameters to check subcommand:\n"
-           "  '-r' tries to repair any inconsistencies that are found during the check.\n"
-           "       '-r leaks' repairs only cluster leaks, whereas '-r all' fixes all\n"
-           "       kinds of errors, with a higher risk of choosing the wrong fix or\n"
-           "       hiding corruption that has already occurred.\n"
-           "\n"
-           "Parameters to convert subcommand:\n"
-           "  '--bitmaps' copies all top-level persistent bitmaps to destination\n"
-           "  '-m' specifies how many coroutines work in parallel during the convert\n"
-           "       process (defaults to 8)\n"
-           "  '-W' allow to write to the target out of order rather than sequential\n"
-           "\n"
-           "Parameters to snapshot subcommand:\n"
-           "  'snapshot' is the name of the snapshot to create, apply or delete\n"
-           "  '-a' applies a snapshot (revert disk to saved state)\n"
-           "  '-c' creates a snapshot\n"
-           "  '-d' deletes a snapshot\n"
-           "  '-l' lists all snapshots in the given image\n"
-           "\n"
-           "Parameters to compare subcommand:\n"
-           "  '-f' first image format\n"
-           "  '-F' second image format\n"
-           "  '-s' run in Strict mode - fail on different image size or sector allocation\n"
-           "\n"
-           "Parameters to dd subcommand:\n"
-           "  'bs=BYTES' read and write up to BYTES bytes at a time "
-           "(default: 512)\n"
-           "  'count=N' copy only N input blocks\n"
-           "  'if=FILE' read from FILE\n"
-           "  'of=FILE' write to FILE\n"
-           "  'skip=N' skip N bs-sized blocks at the start of input\n";
-
-    printf("%s\nSupported formats:", help_msg);
-    bdrv_iterate_format(format_print, NULL, false);
-    printf("\n\n" QEMU_HELP_BOTTOM "\n");
-    exit(EXIT_SUCCESS);
-}
-
 /*
  * Is @list safe for accumulate_options()?
  * It is when multiple of them can be joined together separated by ','.
@@ -5866,6 +5753,16 @@ static const img_cmd_t img_cmds[] = {
     { NULL, NULL, },
 };
 
+static void format_print(void *opaque, const char *name)
+{
+    int *np = opaque;
+    *np += printf(" %s", name);
+    if (*np > 74) {
+        printf("\n ");
+        *np = 1;
+    }
+}
+
 int main(int argc, char **argv)
 {
     const img_cmd_t *cmd;
@@ -5893,10 +5790,6 @@ int main(int argc, char **argv)
 
     module_call_init(MODULE_INIT_QOM);
     bdrv_init();
-    if (argc < 2) {
-        error_exit(NULL, "Not enough arguments");
-    }
-
     qemu_add_opts(&qemu_source_opts);
     qemu_add_opts(&qemu_trace_opts);
 
@@ -5909,7 +5802,22 @@ int main(int argc, char **argv)
             unrecognized_option(NULL, argv[optind - 1]);
             return 0;
         case 'h':
-            help();
+            printf(
+QEMU_IMG_VERSION
+"QEMU disk image utility\n"
+"usage: qemu-img [standard options] command [--help | command options]\n"
+"Standard options:\n"
+" -h|--help - display this help and exit\n"
+" -V|--version - display version info and exit\n"
+" -T|--trace TRACE - specify tracing options:\n"
+"   [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
+"Recognized commands (run qemu-img command --help for command-specific help):\n");
+            for (cmd = img_cmds; cmd->name != NULL; cmd++) {
+                printf("  %s\n", cmd->name);
+            }
+            c = printf("Supported image formats:");
+            bdrv_iterate_format(format_print, &c, false);
+            printf("\n" QEMU_HELP_BOTTOM "\n");
             return 0;
         case 'V':
             printf(QEMU_IMG_VERSION);
@@ -5920,6 +5828,10 @@ int main(int argc, char **argv)
         }
     }
 
+    if (argc < 2) {
+        error_exit(NULL, "Not enough arguments");
+    }
+
     cmdname = argv[optind];
 
     /* reset getopt_long scanning */
-- 
2.39.2


