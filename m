Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FFC75A008
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 22:39:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMDv7-0005w2-ED; Wed, 19 Jul 2023 16:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qMDv6-0005ut-C9
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 16:37:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qMDv3-0001nG-6Q
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 16:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689799028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M1slwJypsxvWGbXrv0IClYQG31cRevtPkcGQKEXS2jQ=;
 b=IKDyXIN6YE7DRgIi8x4sapnWUg08fs7gKJbVg5UaqABBwBLrOokKP91JPLxKgwWaK8jAVI
 66eN7XZelhs8OyFd4n6rmgfj/hLdXylSLsZqdEyBvHgfUMxKtAGb3dAL9dq5wUfMYr2Cdg
 CMyjn13eucDdwI8pUbCD5QFz5bO/t7o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-493-803jD7I-MleZbFy093sW9Q-1; Wed, 19 Jul 2023 16:37:06 -0400
X-MC-Unique: 803jD7I-MleZbFy093sW9Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C72A185A7A4;
 Wed, 19 Jul 2023 20:37:06 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC06A4CD0F8;
 Wed, 19 Jul 2023 20:37:05 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 06/14] qemu-nbd: make verbose bool and local variable in main()
Date: Wed, 19 Jul 2023 15:27:43 -0500
Message-ID: <20230719202736.2675295-22-eblake@redhat.com>
In-Reply-To: <20230719202736.2675295-16-eblake@redhat.com>
References: <20230719202736.2675295-16-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Pass 'verbose' to nbd_client_thread() inside NbdClientOpts which looks
a little bit cleaner and make it bool as it is used as bool actually.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20230717202520.236999-1-den@openvz.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-nbd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index e30c9ac1793..5b2757920c1 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -73,7 +73,6 @@

 #define MBR_SIZE 512

-static int verbose;
 static char *srcpath;
 static SocketAddress *saddr;
 static int persistent = 0;
@@ -275,6 +274,7 @@ static void *show_parts(void *arg)
 struct NbdClientOpts {
     char *device;
     bool fork_process;
+    bool verbose;
 };

 static void *nbd_client_thread(void *arg)
@@ -318,7 +318,7 @@ static void *nbd_client_thread(void *arg)
     /* update partition table */
     pthread_create(&show_parts_thread, NULL, show_parts, opts->device);

-    if (verbose && !opts->fork_process) {
+    if (opts->verbose && !opts->fork_process) {
         fprintf(stderr, "NBD device %s is now connected to %s\n",
                 opts->device, srcpath);
     } else {
@@ -582,6 +582,7 @@ int main(int argc, char **argv)
     const char *tlshostname = NULL;
     bool imageOpts = false;
     bool writethrough = false; /* Client will flush as needed. */
+    bool verbose = false;
     bool fork_process = false;
     bool list = false;
     unsigned socket_activation;
@@ -746,7 +747,7 @@ int main(int argc, char **argv)
             }
             break;
         case 'v':
-            verbose = 1;
+            verbose = true;
             break;
         case 'V':
             version(argv[0]);
@@ -1147,6 +1148,7 @@ int main(int argc, char **argv)
         struct NbdClientOpts opts = {
             .device = device,
             .fork_process = fork_process,
+            .verbose = verbose,
         };

         ret = pthread_create(&client_thread, NULL, nbd_client_thread, &opts);
-- 
2.41.0


