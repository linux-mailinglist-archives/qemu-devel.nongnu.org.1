Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AAE7566EC
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 16:57:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLPdl-0002Pw-Ra; Mon, 17 Jul 2023 10:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qLPdh-0002Nb-JX; Mon, 17 Jul 2023 10:55:53 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qLPde-0003nN-0y; Mon, 17 Jul 2023 10:55:52 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qLPc2-00HTc0-0q;
 Mon, 17 Jul 2023 16:55:39 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 4/5] qemu-nbd: properly report error if qemu_daemon() is failed
Date: Mon, 17 Jul 2023 16:55:43 +0200
Message-Id: <20230717145544.194786-5-den@openvz.org>
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

errno has been overwritten by dup2() just below qemu_daemon() and thus
improperly returned to the caller. Fix accordingly.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 qemu-nbd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 4450cc826b..f27613cb57 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -932,9 +932,12 @@ int main(int argc, char **argv)
             error_report("Failed to fork: %s", strerror(errno));
             exit(EXIT_FAILURE);
         } else if (pid == 0) {
+            int saved_errno;
+
             close(stderr_fd[0]);
 
             ret = qemu_daemon(1, 0);
+            saved_errno = errno;    /* dup2 will overwrite error below */
 
             /* Temporarily redirect stderr to the parent's pipe...  */
             if (dup2(stderr_fd[1], STDERR_FILENO) < 0) {
@@ -952,7 +955,7 @@ int main(int argc, char **argv)
             }
 
             if (ret < 0) {
-                error_report("Failed to daemonize: %s", strerror(errno));
+                error_report("Failed to daemonize: %s", strerror(saved_errno));
                 exit(EXIT_FAILURE);
             }
 
-- 
2.34.1


