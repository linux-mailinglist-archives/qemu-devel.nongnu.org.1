Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A752D798041
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 03:37:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeQQ9-00006L-H1; Thu, 07 Sep 2023 21:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeQQ7-0008Vx-GO
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 21:36:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeQQ2-0007uv-In
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 21:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694136982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f5jd/6kc4vjjX7uDpoVyEKlPLRMa8RsVseLch70y3qo=;
 b=WmH6IFcCzOPDAkAGHoH7aVMyqXcA3ZiK/hAIA0iAJ2w6yZPI0ij3DQg7QgIi2X7QDvLq18
 15vgKdT42FzlkV/7IyGxtt1X1gY8B/8wFsHiXtpCPsl4a0XH7vosbNqp7Q9IPhPF5D1jnM
 qXr3I9mMkZyE7FGEy7yU6R4044g3UYU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-408-SFcbv7h9MTaOInXUmbq41A-1; Thu, 07 Sep 2023 21:36:19 -0400
X-MC-Unique: SFcbv7h9MTaOInXUmbq41A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 93C708007CE;
 Fri,  8 Sep 2023 01:36:18 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2FC2740C2070;
 Fri,  8 Sep 2023 01:36:18 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 11/13] qemu-nbd: invent nbd_client_release_pipe() helper
Date: Thu,  7 Sep 2023 20:35:47 -0500
Message-ID: <20230908013535.990731-26-eblake@redhat.com>
In-Reply-To: <20230908013535.990731-15-eblake@redhat.com>
References: <20230908013535.990731-15-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Move the code from main() and nbd_client_thread() into the specific
helper. This code is going to be grown.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20230906093210.339585-6-den@openvz.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-nbd.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 86bb2f04e24..7c4e22def17 100644
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
2.41.0


