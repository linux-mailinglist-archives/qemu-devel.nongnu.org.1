Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDCD798701
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 14:29:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeabB-0006rn-Ne; Fri, 08 Sep 2023 08:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeaax-0006mK-KU
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:28:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeaat-00087V-HV
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694176093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/EZLGQdvr5+VhP6LPPuCDM+vLcYqtKWyHCeVVYuju1Y=;
 b=DVzm0DEG9V9gPCWL+KJgGHd5cPhbXdsdYOu/heX1VJMTF5YVnkqnVul54/u9JFlV9VeX+l
 CVXoRtoyv4cGA2AMfrPQuZg0ci6jlLZy6NgTcPUtsTcC6ZtFk8KpxwpNg+iyGXc8mHKtr3
 rQrKgGPNbXlm1kGg3V0yJcuNno7lN60=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-yikZQkeSMru92-xkxufN3w-1; Fri, 08 Sep 2023 08:28:10 -0400
X-MC-Unique: yikZQkeSMru92-xkxufN3w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C62559464C1;
 Fri,  8 Sep 2023 12:28:09 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F3CA41460FE5;
 Fri,  8 Sep 2023 12:28:08 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL v2 12/13] qemu-nbd: Restore "qemu-nbd -v --fork" output
Date: Fri,  8 Sep 2023 07:26:38 -0500
Message-ID: <20230908122625.1031340-27-eblake@redhat.com>
In-Reply-To: <20230908122625.1031340-15-eblake@redhat.com>
References: <20230908122625.1031340-15-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
CC: Mike Maslenkin <mike.maslenkin@gmail.com>
Fixes: 5c56dd27a2 ("qemu-nbd: fix regression with qemu-nbd --fork run over ssh")
Message-ID: <20230906093210.339585-7-den@openvz.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>
[eblake: fix build by avoiding stderr as struct member name]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-nbd.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 7c4e22def17..30eeb6f3c75 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -255,18 +255,23 @@ struct NbdClientOpts {
     char *device;
     char *srcpath;
     SocketAddress *saddr;
+    int old_stderr;
     bool fork_process;
     bool verbose;
 };

-static void nbd_client_release_pipe(void)
+static void nbd_client_release_pipe(int old_stderr)
 {
     /* Close stderr so that the qemu-nbd process exits.  */
-    if (dup2(STDOUT_FILENO, STDERR_FILENO) < 0) {
+    if (dup2(old_stderr, STDERR_FILENO) < 0) {
         error_report("Could not release pipe to parent: %s",
                      strerror(errno));
         exit(EXIT_FAILURE);
     }
+    if (old_stderr != STDOUT_FILENO && close(old_stderr) < 0) {
+        error_report("Could not release qemu-nbd: %s", strerror(errno));
+        exit(EXIT_FAILURE);
+    }
 }

 #if HAVE_NBD_DEVICE
@@ -332,7 +337,7 @@ static void *nbd_client_thread(void *arg)
         fprintf(stderr, "NBD device %s is now connected to %s\n",
                 opts->device, opts->srcpath);
     } else {
-        nbd_client_release_pipe();
+        nbd_client_release_pipe(opts->old_stderr);
     }

     if (nbd_client(fd) < 0) {
@@ -597,6 +602,7 @@ int main(int argc, char **argv)
         .device = NULL,
         .srcpath = NULL,
         .saddr = NULL,
+        .old_stderr = STDOUT_FILENO,
     };

 #ifdef CONFIG_POSIX
@@ -951,6 +957,16 @@ int main(int argc, char **argv)

             close(stderr_fd[0]);

+            /* Remember parent's stderr if we will be restoring it. */
+            if (opts.verbose /* fork_process is set */) {
+                opts.old_stderr = dup(STDERR_FILENO);
+                if (opts.old_stderr < 0) {
+                    error_report("Could not dup original stderr: %s",
+                                 strerror(errno));
+                    exit(EXIT_FAILURE);
+                }
+            }
+
             ret = qemu_daemon(1, 0);
             saved_errno = errno;    /* dup2 will overwrite error below */

@@ -1181,7 +1197,7 @@ int main(int argc, char **argv)
     }

     if (opts.fork_process) {
-        nbd_client_release_pipe();
+        nbd_client_release_pipe(opts.old_stderr);
     }

     state = RUNNING;
-- 
2.41.0


