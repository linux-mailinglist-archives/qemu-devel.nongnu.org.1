Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7387479384F
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 11:33:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdott-0000gc-9x; Wed, 06 Sep 2023 05:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdotY-0008MK-JU; Wed, 06 Sep 2023 05:32:20 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdotT-0000f6-96; Wed, 06 Sep 2023 05:32:19 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qdoqL-005qCB-2C;
 Wed, 06 Sep 2023 11:32:00 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: den@openvz.org, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 3/8] qemu-nbd: move srcpath into struct NbdClientOpts
Date: Wed,  6 Sep 2023 11:32:05 +0200
Message-Id: <20230906093210.339585-4-den@openvz.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906093210.339585-1-den@openvz.org>
References: <20230906093210.339585-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We pass other parameters into nbd_client_thread() in this way. This patch
makes the code more consistent.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 qemu-nbd.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index ebfae4d0b6..de6c2be590 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -73,7 +73,6 @@
 
 #define MBR_SIZE 512
 
-static char *srcpath;
 static SocketAddress *saddr;
 static int persistent = 0;
 static enum { RUNNING, TERMINATE, TERMINATED } state;
@@ -255,6 +254,7 @@ static int qemu_nbd_client_list(SocketAddress *saddr, QCryptoTLSCreds *tls,
 
 struct NbdClientOpts {
     char *device;
+    char *srcpath;
     bool fork_process;
     bool verbose;
 };
@@ -320,7 +320,7 @@ static void *nbd_client_thread(void *arg)
 
     if (opts->verbose && !opts->fork_process) {
         fprintf(stderr, "NBD device %s is now connected to %s\n",
-                opts->device, srcpath);
+                opts->device, opts->srcpath);
     } else {
         /* Close stderr so that the qemu-nbd process exits.  */
         if (dup2(STDOUT_FILENO, STDERR_FILENO) < 0) {
@@ -590,6 +590,7 @@ int main(int argc, char **argv)
         .fork_process = false,
         .verbose = false,
         .device = NULL,
+        .srcpath = NULL,
     };
 
 #ifdef CONFIG_POSIX
@@ -1059,19 +1060,19 @@ int main(int argc, char **argv)
     bdrv_init();
     atexit(qemu_nbd_shutdown);
 
-    srcpath = argv[optind];
+    opts.srcpath = argv[optind];
     if (imageOpts) {
-        QemuOpts *opts;
+        QemuOpts *o;
         if (fmt) {
             error_report("--image-opts and -f are mutually exclusive");
             exit(EXIT_FAILURE);
         }
-        opts = qemu_opts_parse_noisily(&file_opts, srcpath, true);
-        if (!opts) {
+        o = qemu_opts_parse_noisily(&file_opts, opts.srcpath, true);
+        if (!o) {
             qemu_opts_reset(&file_opts);
             exit(EXIT_FAILURE);
         }
-        options = qemu_opts_to_qdict(opts, NULL);
+        options = qemu_opts_to_qdict(o, NULL);
         qemu_opts_reset(&file_opts);
         blk = blk_new_open(NULL, NULL, options, flags, &local_err);
     } else {
@@ -1079,7 +1080,7 @@ int main(int argc, char **argv)
             options = qdict_new();
             qdict_put_str(options, "driver", fmt);
         }
-        blk = blk_new_open(srcpath, NULL, options, flags, &local_err);
+        blk = blk_new_open(opts.srcpath, NULL, options, flags, &local_err);
     }
 
     if (!blk) {
-- 
2.34.1


