Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D70759FF7
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 22:38:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMDv9-0005yG-TT; Wed, 19 Jul 2023 16:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qMDv6-0005vJ-KC
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 16:37:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qMDv4-0001na-5N
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 16:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689799029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7LV2Hix5wqvfG0V2Rqr0VJDKzjNRrYLWDNTywYO+Vgc=;
 b=JtfScFi6OE5Iu7+dWcusroJ1Z26dDZE2jg4BLYgRj30QUyelkVb0GswNQ+lGFgbwq9eztm
 HVAUKysRR2/rLNK4ukO0BGory/gVrv1eiOUV/8S8a1D2/jTLQqCpprr89j80QYm1Y0Zskx
 AM83q4FxhXdkg6EI8cGn2b+LqOQD1xY=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-266-tGu8OYR6OOa8kvpZKEi0Xw-1; Wed, 19 Jul 2023 16:37:04 -0400
X-MC-Unique: tGu8OYR6OOa8kvpZKEi0Xw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B9F2438117E3;
 Wed, 19 Jul 2023 20:37:03 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 334EF4CD0F5;
 Wed, 19 Jul 2023 20:37:03 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, qemu-stable@nongnu.org,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 02/14] qemu-nbd: fix regression with qemu-nbd --fork run over
 ssh
Date: Wed, 19 Jul 2023 15:27:39 -0500
Message-ID: <20230719202736.2675295-18-eblake@redhat.com>
In-Reply-To: <20230719202736.2675295-16-eblake@redhat.com>
References: <20230719202736.2675295-16-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
---
 qemu-nbd.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 77f98c736bb..186ce9474c3 100644
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
@@ -1131,6 +1126,7 @@ int main(int argc, char **argv)
         int ret;
         struct NbdClientOpts opts = {
             .device = device,
+            .fork_process = fork_process,
         };

         ret = pthread_create(&client_thread, NULL, nbd_client_thread, &opts);
@@ -1159,8 +1155,7 @@ int main(int argc, char **argv)
     }

     if (fork_process) {
-        dup2(old_stderr, STDERR_FILENO);
-        close(old_stderr);
+        dup2(STDOUT_FILENO, STDERR_FILENO);
     }

     state = RUNNING;
-- 
2.41.0


