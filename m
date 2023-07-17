Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAAE7566EE
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 16:58:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLPe2-0002Tf-Fn; Mon, 17 Jul 2023 10:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qLPdh-0002NZ-J5; Mon, 17 Jul 2023 10:55:53 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qLPdd-0003kY-WC; Mon, 17 Jul 2023 10:55:53 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qLPc1-00HTc0-2U;
 Mon, 17 Jul 2023 16:55:39 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 3/5] qemu-nbd: properly report error on error in dup2() after
 qemu_daemon()
Date: Mon, 17 Jul 2023 16:55:42 +0200
Message-Id: <20230717145544.194786-4-den@openvz.org>
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

We are trying to temporary redirect stderr of daemonized process to
a pipe to report a error and get failed. In that case we could not
use error_report() helper, but should write the message directly into
the problematic pipe.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 qemu-nbd.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 186ce9474c..4450cc826b 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -937,7 +937,20 @@ int main(int argc, char **argv)
             ret = qemu_daemon(1, 0);
 
             /* Temporarily redirect stderr to the parent's pipe...  */
-            dup2(stderr_fd[1], STDERR_FILENO);
+            if (dup2(stderr_fd[1], STDERR_FILENO) < 0) {
+                char str[256];
+                snprintf(str, sizeof(str),
+                         "%s: Failed to link stderr to the pipe: %s\n",
+                         g_get_prgname(), strerror(errno));
+                /*
+                 * We are unable to use error_report() here as we need to get
+                 * stderr pointed to the parent's pipe. Write to that pipe
+                 * manually.
+                 */
+                ret = write(stderr_fd[1], str, strlen(str));
+                exit(EXIT_FAILURE);
+            }
+
             if (ret < 0) {
                 error_report("Failed to daemonize: %s", strerror(errno));
                 exit(EXIT_FAILURE);
-- 
2.34.1


