Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D195761B15
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:12:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOIk6-0003UP-8R; Tue, 25 Jul 2023 10:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIk3-0003TY-Qp; Tue, 25 Jul 2023 10:10:23 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIk2-0007UZ-5l; Tue, 25 Jul 2023 10:10:23 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1B90216167;
 Tue, 25 Jul 2023 17:10:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B0629194FF;
 Tue, 25 Jul 2023 17:10:11 +0300 (MSK)
Received: (nullmailer pid 3372584 invoked by uid 1000);
 Tue, 25 Jul 2023 14:10:11 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.5 05/14] qemu-nbd: fix regression with qemu-nbd --fork
 run over ssh
Date: Tue, 25 Jul 2023 17:09:59 +0300
Message-Id: <20230725141009.3372529-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.5-20230725170615@cover.tls.msk.ru>
References: <qemu-stable-7.2.5-20230725170615@cover.tls.msk.ru>
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

From: "Denis V. Lunev" <den@openvz.org>

Commit e6df58a5578fee7a50bbf36f4a50a2781cff855d
    Author: Hanna Reitz <hreitz@redhat.com>
    Date:   Wed May 8 23:18:18 2019 +0200
    qemu-nbd: Do not close stderr

has introduced an interesting regression. Original behavior of
    ssh somehost qemu-nbd /home/den/tmp/file -f raw --fork
was the following:
 * qemu-nbd was started as a daemon
 * the command execution is done and ssh exited with success

The patch has changed this behavior and 'ssh' command now hangs forever.

According to the normal specification of the daemon() call, we should
endup with STDERR pointing to /dev/null. That should be done at the
very end of the successful startup sequence when the pipe to the
bootstrap process (used for diagnostics) is no longer needed.

This could be achived in the same way as done for 'qemu-nbd -c' case.
That was commit 0eaf453e, also fixing up e6df58a5. STDOUT copying to
STDERR does the trick.

This also leads to proper 'ssh' connection closing which fixes my
original problem.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Hanna Reitz <hreitz@redhat.com>
CC: <qemu-stable@nongnu.org>
Message-ID: <20230717145544.194786-3-den@openvz.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
(cherry picked from commit 5c56dd27a2c905c9cf2472d2fd057621ce5fd00d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 89afd2e749..bcdb74ff13 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -274,6 +274,7 @@ static void *show_parts(void *arg)
 
 struct NbdClientOpts {
     char *device;
+    bool fork_process;
 };
 
 static void *nbd_client_thread(void *arg)
@@ -317,7 +318,7 @@ static void *nbd_client_thread(void *arg)
     /* update partition table */
     pthread_create(&show_parts_thread, NULL, show_parts, opts->device);
 
-    if (verbose) {
+    if (verbose && !opts->fork_process) {
         fprintf(stderr, "NBD device %s is now connected to %s\n",
                 opts->device, srcpath);
     } else {
@@ -579,7 +580,6 @@ int main(int argc, char **argv)
     bool writethrough = false; /* Client will flush as needed. */
     bool fork_process = false;
     bool list = false;
-    int old_stderr = -1;
     unsigned socket_activation;
     const char *pid_file_name = NULL;
     const char *selinux_label = NULL;
@@ -934,11 +934,6 @@ int main(int argc, char **argv)
         } else if (pid == 0) {
             close(stderr_fd[0]);
 
-            /* Remember parent's stderr if we will be restoring it. */
-            if (fork_process) {
-                old_stderr = dup(STDERR_FILENO);
-            }
-
             ret = qemu_daemon(1, 0);
 
             /* Temporarily redirect stderr to the parent's pipe...  */
@@ -1129,6 +1124,7 @@ int main(int argc, char **argv)
         int ret;
         struct NbdClientOpts opts = {
             .device = device,
+            .fork_process = fork_process,
         };
 
         ret = pthread_create(&client_thread, NULL, nbd_client_thread, &opts);
@@ -1157,8 +1153,7 @@ int main(int argc, char **argv)
     }
 
     if (fork_process) {
-        dup2(old_stderr, STDERR_FILENO);
-        close(old_stderr);
+        dup2(STDOUT_FILENO, STDERR_FILENO);
     }
 
     state = RUNNING;
-- 
2.39.2


