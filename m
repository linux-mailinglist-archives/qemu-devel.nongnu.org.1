Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FD3788F40
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 21:29:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZcTC-0006fh-9t; Fri, 25 Aug 2023 15:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qZcTA-0006fP-BW; Fri, 25 Aug 2023 15:27:44 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qZcT7-0000QA-VL; Fri, 25 Aug 2023 15:27:44 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qZcQK-00Fd8q-06;
 Fri, 25 Aug 2023 21:27:34 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, qemu-block@nongnu.org,
 "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH vOther 1/1] qemu-nbd: Restore "qemu-nbd -v --fork" output
Date: Fri, 25 Aug 2023 21:27:36 +0200
Message-Id: <20230825192736.34800-1-den@openvz.org>
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
Reply-To: 20230824200311.636589-2-eblake@redhat.com
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
Fixes: 5c56dd27a2 ("qemu-nbd: fix regression with qemu-nbd --fork run over ssh")
---
After lengthy thoughts there is a different proposal to fix the
introduced regression. Under this approach we could keep original
test output. This looks important to me.

Eric, do you have any opinion?

Thank you in advance,
    Den

 qemu-nbd.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index aaccaa3318..8322bd5b5b 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -275,6 +275,7 @@ struct NbdClientOpts {
     char *device;
     bool fork_process;
     bool verbose;
+    int stderr;
 };
 
 static void *nbd_client_thread(void *arg)
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
@@ -590,7 +594,9 @@ int main(int argc, char **argv)
     const char *selinux_label = NULL;
     BlockExportOptions *export_opts;
 #if HAVE_NBD_DEVICE
-    struct NbdClientOpts opts;
+    struct NbdClientOpts opts = {
+        .stderr = STDOUT_FILENO,
+    };
 #endif
 
 #ifdef CONFIG_POSIX
@@ -944,6 +950,15 @@ int main(int argc, char **argv)
 
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
 
@@ -1180,11 +1195,14 @@ int main(int argc, char **argv)
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


