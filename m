Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FC0761A65
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 15:47:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOINk-0008AV-PN; Tue, 25 Jul 2023 09:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOINO-0006Kj-3e; Tue, 25 Jul 2023 09:46:58 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOINM-0001c2-Co; Tue, 25 Jul 2023 09:46:57 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D58B0160FF;
 Tue, 25 Jul 2023 16:45:36 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 6924B194C1;
 Tue, 25 Jul 2023 16:45:34 +0300 (MSK)
Received: (nullmailer pid 3370849 invoked by uid 1000);
 Tue, 25 Jul 2023 13:45:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 22/31] qemu-nbd: pass structure into nbd_client_thread
 instead of plain char*
Date: Tue, 25 Jul 2023 16:45:07 +0300
Message-Id: <20230725134517.3370706-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
References: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
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

We are going to pass additional flag inside next patch.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: <qemu-stable@nongnu.org>
Message-ID: <20230717145544.194786-2-den@openvz.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
(cherry picked from commit 03b67621445d601c9cdc7dfe25812e9f19b81488)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 6ff45308a9..87c46bb0e5 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -272,9 +272,13 @@ static void *show_parts(void *arg)
     return NULL;
 }
 
+struct NbdClientOpts {
+    char *device;
+};
+
 static void *nbd_client_thread(void *arg)
 {
-    char *device = arg;
+    struct NbdClientOpts *opts = arg;
     NBDExportInfo info = { .request_sizes = false, .name = g_strdup("") };
     QIOChannelSocket *sioc;
     int fd = -1;
@@ -298,10 +302,10 @@ static void *nbd_client_thread(void *arg)
         goto out;
     }
 
-    fd = open(device, O_RDWR);
+    fd = open(opts->device, O_RDWR);
     if (fd < 0) {
         /* Linux-only, we can use %m in printf.  */
-        error_report("Failed to open %s: %m", device);
+        error_report("Failed to open %s: %m", opts->device);
         goto out;
     }
 
@@ -311,11 +315,11 @@ static void *nbd_client_thread(void *arg)
     }
 
     /* update partition table */
-    pthread_create(&show_parts_thread, NULL, show_parts, device);
+    pthread_create(&show_parts_thread, NULL, show_parts, opts->device);
 
     if (verbose) {
         fprintf(stderr, "NBD device %s is now connected to %s\n",
-                device, srcpath);
+                opts->device, srcpath);
     } else {
         /* Close stderr so that the qemu-nbd process exits.  */
         dup2(STDOUT_FILENO, STDERR_FILENO);
@@ -1121,8 +1125,11 @@ int main(int argc, char **argv)
     if (device) {
 #if HAVE_NBD_DEVICE
         int ret;
+        struct NbdClientOpts opts = {
+            .device = device,
+        };
 
-        ret = pthread_create(&client_thread, NULL, nbd_client_thread, device);
+        ret = pthread_create(&client_thread, NULL, nbd_client_thread, &opts);
         if (ret != 0) {
             error_report("Failed to create client thread: %s", strerror(ret));
             exit(EXIT_FAILURE);
-- 
2.39.2


