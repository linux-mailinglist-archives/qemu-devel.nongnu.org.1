Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DCB79384C
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 11:32:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdotg-0008Mu-Pt; Wed, 06 Sep 2023 05:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdotV-0008Lj-K8; Wed, 06 Sep 2023 05:32:19 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdotS-0000f2-Vu; Wed, 06 Sep 2023 05:32:17 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qdoqK-005qCB-2x;
 Wed, 06 Sep 2023 11:31:59 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: den@openvz.org, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 1/8] qemu-nbd: improve error message for dup2 error
Date: Wed,  6 Sep 2023 11:32:03 +0200
Message-Id: <20230906093210.339585-2-den@openvz.org>
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

This error is happened when we are not able to close the pipe to the
parent (to trace errors in the child process) and assign stderr to
/dev/null as required by the daemonizing convention.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Suggested-by: Eric Blake <eblake@redhat.com>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 qemu-nbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index aaccaa3318..4575e4291e 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -324,7 +324,7 @@ static void *nbd_client_thread(void *arg)
     } else {
         /* Close stderr so that the qemu-nbd process exits.  */
         if (dup2(STDOUT_FILENO, STDERR_FILENO) < 0) {
-            error_report("Could not set stderr to /dev/null: %s",
+            error_report("Could not release pipe to parent: %s",
                          strerror(errno));
             exit(EXIT_FAILURE);
         }
@@ -1181,7 +1181,7 @@ int main(int argc, char **argv)
 
     if (fork_process) {
         if (dup2(STDOUT_FILENO, STDERR_FILENO) < 0) {
-            error_report("Could not set stderr to /dev/null: %s",
+            error_report("Could not release pipe to parent: %s",
                          strerror(errno));
             exit(EXIT_FAILURE);
         }
-- 
2.34.1


