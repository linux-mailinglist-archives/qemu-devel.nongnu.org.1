Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD88E74A44C
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 21:16:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHUSO-00027N-0a; Thu, 06 Jul 2023 15:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qHUSI-000267-2f; Thu, 06 Jul 2023 15:15:54 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qHUSG-0004ra-6V; Thu, 06 Jul 2023 15:15:53 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qHUQu-00FXJs-0p;
 Thu, 06 Jul 2023 21:15:44 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 1/1] qemu-nbd: fix regression with qemu-nbd --fork run over ssh
Date: Thu,  6 Jul 2023 21:15:45 +0200
Message-Id: <20230706191545.130087-1-den@openvz.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
STDOUT copying to STDERR does the trick.

This also leads to proper 'ssh' connection closing which fixes my
original problem.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Hanna Reitz <hreitz@redhat.com>
---
 qemu-nbd.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 4276163564..e9e118dfdb 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -575,7 +575,6 @@ int main(int argc, char **argv)
     bool writethrough = false; /* Client will flush as needed. */
     bool fork_process = false;
     bool list = false;
-    int old_stderr = -1;
     unsigned socket_activation;
     const char *pid_file_name = NULL;
     const char *selinux_label = NULL;
@@ -930,11 +929,6 @@ int main(int argc, char **argv)
         } else if (pid == 0) {
             close(stderr_fd[0]);
 
-            /* Remember parent's stderr if we will be restoring it. */
-            if (fork_process) {
-                old_stderr = dup(STDERR_FILENO);
-            }
-
             ret = qemu_daemon(1, 0);
 
             /* Temporarily redirect stderr to the parent's pipe...  */
@@ -1152,8 +1146,7 @@ int main(int argc, char **argv)
     }
 
     if (fork_process) {
-        dup2(old_stderr, STDERR_FILENO);
-        close(old_stderr);
+        dup2(STDOUT_FILENO, STDERR_FILENO);
     }
 
     state = RUNNING;
-- 
2.34.1


