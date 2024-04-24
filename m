Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D278B0518
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Apr 2024 10:54:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzYNf-00016X-Um; Wed, 24 Apr 2024 04:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rzYN9-0000Wf-SD; Wed, 24 Apr 2024 04:53:05 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rzYN7-0004Cz-Nd; Wed, 24 Apr 2024 04:52:59 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5BCD161543;
 Wed, 24 Apr 2024 11:50:44 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 85EBDBE0F3;
 Wed, 24 Apr 2024 11:50:37 +0300 (MSK)
Received: (nullmailer pid 1179657 invoked by uid 1000);
 Wed, 24 Apr 2024 08:50:36 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-block@nongnu.org
Subject: [PATCH 26/27] qemu-img: inline list of supported commands,
 remove qemu-img-cmds.h include
Date: Wed, 24 Apr 2024 11:50:34 +0300
Message-Id: <ac85fe0aec9caf4cf8bef0f9c48564c978ed3aa8.1713948448.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1713948448.git.mjt@tls.msk.ru>
References: <cover.1713948448.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

also add short description to each command and use it in --help

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qemu-img.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 39dfaa5144..694647f6ff 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -61,6 +61,7 @@
 typedef struct img_cmd_t {
     const char *name;
     int (*handler)(const struct img_cmd_t *ccmd, int argc, char **argv);
+    const char *description;
 } img_cmd_t;
 
 enum {
@@ -127,6 +128,7 @@ void cmd_help(const img_cmd_t *ccmd,
 {
     printf(
 "Usage:\n"
+"%s.  Usage:\n"
 "\n"
 "  %s %s %s"
 "\n"
@@ -134,7 +136,7 @@ void cmd_help(const img_cmd_t *ccmd,
 "  -h, --help\n"
 "     print this help and exit\n"
 "%s\n",
-           "qemu-img", ccmd->name,
+           ccmd->description, "qemu-img", ccmd->name,
            syntax, arguments);
     exit(EXIT_SUCCESS);
 }
@@ -5828,10 +5830,36 @@ out:
 }
 
 static const img_cmd_t img_cmds[] = {
-#define DEF(option, callback, arg_string)        \
-    { option, callback },
-#include "qemu-img-cmds.h"
-#undef DEF
+    { "amend", img_amend,
+      "Update format-specific options of the image" },
+    { "bench", img_bench,
+      "Run simple image benchmark" },
+    { "bitmap", img_bitmap,
+      "Perform modifications of the persistent bitmap in the image" },
+    { "check", img_check,
+      "Check basic image integrity" },
+    { "commit", img_commit,
+      "Commit image to its backing file" },
+    { "compare", img_compare,
+      "Check if two images have the same contents" },
+    { "convert", img_convert,
+      "Copy one image to another with optional format conversion" },
+    { "create", img_create,
+      "Create and format new image file" },
+    { "dd", img_dd,
+      "Copy input to output with optional format conversion" },
+    { "info", img_info,
+      "Display information about image" },
+    { "map", img_map,
+      "Dump image metadata" },
+    { "measure", img_measure,
+      "Calculate file size requred for a new image" },
+    { "rebase", img_rebase,
+      "Change backing file of the image" },
+    { "resize", img_resize,
+      "Resize the image to the new size" },
+    { "snapshot", img_snapshot,
+      "List or manipulate snapshots within image" },
     { NULL, NULL, },
 };
 
@@ -5896,7 +5924,7 @@ QEMU_IMG_VERSION
 "\n"
 "Recognized commands (run qemu-img COMMAND --help for command-specific help):\n\n");
             for (cmd = img_cmds; cmd->name != NULL; cmd++) {
-                printf("  %s\n", cmd->name);
+                printf("  %s - %s\n", cmd->name, cmd->description);
             }
             printf("\nSupported image formats:\n");
             c = 99; /* force a newline */
-- 
2.39.2


