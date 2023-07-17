Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E78297566EB
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 16:57:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLPdz-0002SO-7k; Mon, 17 Jul 2023 10:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qLPdh-0002Na-JV; Mon, 17 Jul 2023 10:55:53 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qLPde-0003rk-0r; Mon, 17 Jul 2023 10:55:53 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qLPc2-00HTc0-2N;
 Mon, 17 Jul 2023 16:55:40 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 5/5] qemu-nbd: handle dup2() error when qemu-nbd finished
 setup process
Date: Mon, 17 Jul 2023 16:55:44 +0200
Message-Id: <20230717145544.194786-6-den@openvz.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717145544.194786-1-den@openvz.org>
References: <20230717145544.194786-1-den@openvz.org>
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

Fail on error, we are in trouble.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 qemu-nbd.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index f27613cb57..cd0e965705 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -323,7 +323,12 @@ static void *nbd_client_thread(void *arg)
                 opts->device, srcpath);
     } else {
         /* Close stderr so that the qemu-nbd process exits.  */
-        dup2(STDOUT_FILENO, STDERR_FILENO);
+        int err = dup2(STDOUT_FILENO, STDERR_FILENO);
+        if (err < 0) {
+            error_report("Could not set stderr to /dev/null: %s",
+                         strerror(errno));
+            exit(EXIT_FAILURE);
+        }
     }
 
     if (nbd_client(fd) < 0) {
@@ -1171,7 +1176,12 @@ int main(int argc, char **argv)
     }
 
     if (fork_process) {
-        dup2(STDOUT_FILENO, STDERR_FILENO);
+        ret = dup2(STDOUT_FILENO, STDERR_FILENO);
+        if (ret < 0) {
+            error_report("Could not set stderr to /dev/null: %s",
+                         strerror(errno));
+            exit(EXIT_FAILURE);
+        }
     }
 
     state = RUNNING;
-- 
2.34.1


