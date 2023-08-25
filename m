Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC08788F8C
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 22:10:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZd6u-00035V-VN; Fri, 25 Aug 2023 16:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qZd6r-00034x-Bc; Fri, 25 Aug 2023 16:08:45 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qZd6o-0007At-V0; Fri, 25 Aug 2023 16:08:45 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qZd41-00Fheq-35;
 Fri, 25 Aug 2023 22:08:36 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, qemu-block@nongnu.org,
 "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>
Subject: [PATCH vOther2 1/1] qemu-nbd: Restore "qemu-nbd -v --fork" output
Date: Fri, 25 Aug 2023 22:08:38 +0200
Message-Id: <20230825200838.39994-1-den@openvz.org>
X-Mailer: git-send-email 2.34.1
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
Reply-To: 20230825192940.35364-1-den@openvz.org
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
Changes from v1:
* fixed compilation with undefined HAVE_NBD_DEVICE, thanks to Mike Maslenkin

 qemu-nbd.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index aaccaa3318..19a4147d24 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -253,6 +253,13 @@ static int qemu_nbd_client_list(SocketAddress *saddr, QCryptoTLSCreds *tls,
 }
 
 
+struct NbdClientOpts {
+    char *device;
+    bool fork_process;
+    bool verbose;
+    int stderr;
+};
+
 #if HAVE_NBD_DEVICE
 static void *show_parts(void *arg)
 {
@@ -271,12 +278,6 @@ static void *show_parts(void *arg)
     return NULL;
 }
 
-struct NbdClientOpts {
-    char *device;
-    bool fork_process;
-    bool verbose;
-};
-
 static void *nbd_client_thread(void *arg)
 {
     struct NbdClientOpts *opts = arg;
@@ -323,11 +324,14 @@ static void *nbd_client_thread(void *arg)
                 opts->device, srcpath);
     } else {
         /* Close stderr so that the qemu-nbd process exits.  */
-        if (dup2(STDOUT_FILENO, STDERR_FILENO) < 0) {
+        if (dup2(opts->stderr, STDERR_FILENO) < 0) {
             error_report("Could not set stderr to /dev/null: %s",
                          strerror(errno));
             exit(EXIT_FAILURE);
         }
+        if (opts->stderr != STDOUT_FILENO) {
+            close(opts->stderr);
+        }
     }
 
     if (nbd_client(fd) < 0) {
@@ -589,9 +593,9 @@ int main(int argc, char **argv)
     const char *pid_file_name = NULL;
     const char *selinux_label = NULL;
     BlockExportOptions *export_opts;
-#if HAVE_NBD_DEVICE
-    struct NbdClientOpts opts;
-#endif
+    struct NbdClientOpts opts = {
+        .stderr = STDOUT_FILENO,
+    };
 
 #ifdef CONFIG_POSIX
     os_setup_early_signal_handling();
@@ -944,6 +948,15 @@ int main(int argc, char **argv)
 
             close(stderr_fd[0]);
 
+            /* Remember parent's stderr if we will be restoring it. */
+            if (verbose /* fork_process is set */) {
+                opts.stderr = dup(STDERR_FILENO);
+                if (opts.stderr < 0) {
+                    error_report("Could not dup stdedd: %s", strerror(errno));
+                    exit(EXIT_FAILURE);
+                }
+            }
+
             ret = qemu_daemon(1, 0);
             saved_errno = errno;    /* dup2 will overwrite error below */
 
@@ -1152,6 +1165,7 @@ int main(int argc, char **argv)
             .device = device,
             .fork_process = fork_process,
             .verbose = verbose,
+            .stderr = STDOUT_FILENO,
         };
 
         ret = pthread_create(&client_thread, NULL, nbd_client_thread, &opts);
@@ -1180,11 +1194,14 @@ int main(int argc, char **argv)
     }
 
     if (fork_process) {
-        if (dup2(STDOUT_FILENO, STDERR_FILENO) < 0) {
+        if (dup2(opts.stderr, STDERR_FILENO) < 0) {
             error_report("Could not set stderr to /dev/null: %s",
                          strerror(errno));
             exit(EXIT_FAILURE);
         }
+        if (opts.stderr != STDOUT_FILENO) {
+            close(opts.stderr);
+        }
     }
 
     state = RUNNING;
-- 
2.34.1


