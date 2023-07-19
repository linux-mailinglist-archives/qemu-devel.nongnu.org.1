Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FAA759FFA
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 22:38:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMDv6-0005un-Ck; Wed, 19 Jul 2023 16:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qMDv3-0005tg-W9
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 16:37:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qMDv1-0001mj-WD
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 16:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689799027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W7YLu/P/YgajFgHCKNUtyzQmvJdgtGqjZP1FgSzTZDg=;
 b=CFaofVJaEu06HBs9cklbR07Kue4liNL1OhsYcZVi3eBPY7VhCFGh7J+NJ80Ya5onVMhtxW
 c3JN1pSzTD+7n0JkcTfu2+bHTTg5SXxYgxo5xuhOTYHCgNqnWdZKY776EWeyl9sqQd5NBI
 atojCtHP4PmjmFbw/jnTLkiI0G8V6UA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-466-WIbhMaecOK2MN_p9jeuGiQ-1; Wed, 19 Jul 2023 16:37:03 -0400
X-MC-Unique: WIbhMaecOK2MN_p9jeuGiQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 065EE185A795;
 Wed, 19 Jul 2023 20:37:03 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 62C964CD0FB;
 Wed, 19 Jul 2023 20:37:02 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-stable@nongnu.org,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 01/14] qemu-nbd: pass structure into nbd_client_thread instead
 of plain char*
Date: Wed, 19 Jul 2023 15:27:38 -0500
Message-ID: <20230719202736.2675295-17-eblake@redhat.com>
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

We are going to pass additional flag inside next patch.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: <qemu-stable@nongnu.org>
Message-ID: <20230717145544.194786-2-den@openvz.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-nbd.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 4276163564b..77f98c736bb 100644
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
@@ -1125,8 +1129,11 @@ int main(int argc, char **argv)
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
2.41.0


