Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8427484D056
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Feb 2024 19:00:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXmC8-0003bm-CO; Wed, 07 Feb 2024 12:58:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rXmBq-0003Rr-F2; Wed, 07 Feb 2024 12:58:31 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rXmBn-00040C-MG; Wed, 07 Feb 2024 12:58:28 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2D9474B3D3;
 Wed,  7 Feb 2024 20:59:34 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3E98B763A3;
 Wed,  7 Feb 2024 20:58:22 +0300 (MSK)
Received: (nullmailer pid 296928 invoked by uid 1000);
 Wed, 07 Feb 2024 17:58:19 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 4/8] qemu-img: refresh options/--help for "check" command
Date: Wed,  7 Feb 2024 20:58:13 +0300
Message-Id: <0087ee8eaeedc608b44411732354bc980962f530.1707328606.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1707328606.git.mjt@tls.msk.ru>
References: <cover.1707328606.git.mjt@tls.msk.ru>
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
 qemu-img.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index f851b290cc..e7d5b1b24b 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -780,7 +780,9 @@ static int img_check(const char *cmdname, int argc, char **argv)
         int option_index = 0;
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
+            {"quiet", no_argument, 0, 'q'},
             {"format", required_argument, 0, 'f'},
+            {"cache", required_argument, 0, 'T'},
             {"repair", required_argument, 0, 'r'},
             {"output", required_argument, 0, OPTION_OUTPUT},
             {"object", required_argument, 0, OPTION_OBJECT},
@@ -801,7 +803,20 @@ static int img_check(const char *cmdname, int argc, char **argv)
             unrecognized_option(cmdname, argv[optind - 1]);
             break;
         case 'h':
-            help();
+            cmd_help(cmdname, "[OPTIONS] FILENAME",
+                     "Checks image file validity",
+" -q|--quiet - quiet operations\n"
+" -f|--format FMT - specifies format of the image explicitly\n"
+" --image-opts - indicates that FILENAME is a complete image specification\n"
+"  instead of a file name (incompatible with --format)\n"
+" -T|--cache CACHE_MODE - cache mode when opening image (" BDRV_DEFAULT_CACHE ")\n"
+" -U|--force-share - open image in shared mode for concurrent access\n"
+" --output human|json - output format\n"
+" -r|--repair leaks|all - repair particular aspect of the image\n"
+"  (image will be open in read-write mode, incompatible with --force-share)\n"
+" --object OBJDEF - QEMU user-creatable object (eg encryption key)\n"
+" FILENAME - the image file (or image specification) to operate on\n"
+);
             break;
         case 'f':
             fmt = optarg;
-- 
2.39.2


