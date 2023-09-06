Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 683E879384B
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 11:32:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdotl-00008H-Vi; Wed, 06 Sep 2023 05:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdotY-0008MH-Ib; Wed, 06 Sep 2023 05:32:20 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdotT-0000fD-9d; Wed, 06 Sep 2023 05:32:19 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qdoqM-005qCB-1R;
 Wed, 06 Sep 2023 11:32:01 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: den@openvz.org, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 5/8] qemu-nbd: invent nbd_client_release_pipe() helper
Date: Wed,  6 Sep 2023 11:32:07 +0200
Message-Id: <20230906093210.339585-6-den@openvz.org>
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

Move the code from main() and nbd_client_thread() into the specific
helper. This code is going to be grown.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 qemu-nbd.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index d0f8d8bad2..9f28e3ebda 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -259,6 +259,16 @@ struct NbdClientOpts {
     bool verbose;
 };
 
+static void nbd_client_release_pipe(void)
+{
+    /* Close stderr so that the qemu-nbd process exits.  */
+    if (dup2(STDOUT_FILENO, STDERR_FILENO) < 0) {
+        error_report("Could not release pipe to parent: %s",
+                     strerror(errno));
+        exit(EXIT_FAILURE);
+    }
+}
+
 #if HAVE_NBD_DEVICE
 static void *show_parts(void *arg)
 {
@@ -322,12 +332,7 @@ static void *nbd_client_thread(void *arg)
         fprintf(stderr, "NBD device %s is now connected to %s\n",
                 opts->device, opts->srcpath);
     } else {
-        /* Close stderr so that the qemu-nbd process exits.  */
-        if (dup2(STDOUT_FILENO, STDERR_FILENO) < 0) {
-            error_report("Could not release pipe to parent: %s",
-                         strerror(errno));
-            exit(EXIT_FAILURE);
-        }
+        nbd_client_release_pipe();
     }
 
     if (nbd_client(fd) < 0) {
@@ -1176,11 +1181,7 @@ int main(int argc, char **argv)
     }
 
     if (opts.fork_process) {
-        if (dup2(STDOUT_FILENO, STDERR_FILENO) < 0) {
-            error_report("Could not release pipe to parent: %s",
-                         strerror(errno));
-            exit(EXIT_FAILURE);
-        }
+        nbd_client_release_pipe();
     }
 
     state = RUNNING;
-- 
2.34.1


