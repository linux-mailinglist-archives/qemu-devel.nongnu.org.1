Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C51793851
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 11:33:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdotq-0000aT-Nj; Wed, 06 Sep 2023 05:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdotZ-0008Mv-BL; Wed, 06 Sep 2023 05:32:22 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdotT-0000fR-JR; Wed, 06 Sep 2023 05:32:21 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qdoqM-005qCB-33;
 Wed, 06 Sep 2023 11:32:01 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: den@openvz.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>
Subject: [PATCH 6/8] qemu-nbd: Restore "qemu-nbd -v --fork" output
Date: Wed,  6 Sep 2023 11:32:08 +0200
Message-Id: <20230906093210.339585-7-den@openvz.org>
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

Closing stderr earlier is good for daemonized qemu-nbd under ssh
earlier, but breaks the case where -v is being used to track what is
happening in the server, as in iotest 233.

When we know we are verbose, we should preserve original stderr and
restore it once the setup stage is done. This commit restores the
original behavior with -v option. In this case original output
inside the test is kept intact.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Mike Maslenkin <mike.maslenkin@gmail.com>
Fixes: 5c56dd27a2 ("qemu-nbd: fix regression with qemu-nbd --fork run over ssh")
---
 qemu-nbd.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 9f28e3ebda..b9c74ce77c 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -255,18 +255,23 @@ struct NbdClientOpts {
     char *device;
     char *srcpath;
     SocketAddress *saddr;
+    int stderr;
     bool fork_process;
     bool verbose;
 };
 
-static void nbd_client_release_pipe(void)
+static void nbd_client_release_pipe(int old_stderr)
 {
     /* Close stderr so that the qemu-nbd process exits.  */
-    if (dup2(STDOUT_FILENO, STDERR_FILENO) < 0) {
+    if (dup2(old_stderr, STDERR_FILENO) < 0) {
         error_report("Could not release pipe to parent: %s",
                      strerror(errno));
         exit(EXIT_FAILURE);
     }
+    if (old_stderr != STDOUT_FILENO && close(old_stderr) < 0) {
+        error_report("Could not release qemu-nbd: %s", strerror(errno));
+        exit(EXIT_FAILURE);
+    }
 }
 
 #if HAVE_NBD_DEVICE
@@ -332,7 +337,7 @@ static void *nbd_client_thread(void *arg)
         fprintf(stderr, "NBD device %s is now connected to %s\n",
                 opts->device, opts->srcpath);
     } else {
-        nbd_client_release_pipe();
+        nbd_client_release_pipe(opts->stderr);
     }
 
     if (nbd_client(fd) < 0) {
@@ -597,6 +602,7 @@ int main(int argc, char **argv)
         .device = NULL,
         .srcpath = NULL,
         .saddr = NULL,
+        .stderr = STDOUT_FILENO,
     };
 
 #ifdef CONFIG_POSIX
@@ -951,6 +957,16 @@ int main(int argc, char **argv)
 
             close(stderr_fd[0]);
 
+            /* Remember parent's stderr if we will be restoring it. */
+            if (opts.verbose /* fork_process is set */) {
+                opts.stderr = dup(STDERR_FILENO);
+                if (opts.stderr < 0) {
+                    error_report("Could not dup original stderr: %s",
+                                 strerror(errno));
+                    exit(EXIT_FAILURE);
+                }
+            }
+
             ret = qemu_daemon(1, 0);
             saved_errno = errno;    /* dup2 will overwrite error below */
 
@@ -1181,7 +1197,7 @@ int main(int argc, char **argv)
     }
 
     if (opts.fork_process) {
-        nbd_client_release_pipe();
+        nbd_client_release_pipe(opts.stderr);
     }
 
     state = RUNNING;
-- 
2.34.1


