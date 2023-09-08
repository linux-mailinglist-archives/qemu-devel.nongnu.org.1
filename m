Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDC479804C
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 03:38:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeQQ6-0008Un-Ps; Thu, 07 Sep 2023 21:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeQQ5-0008U4-Jj
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 21:36:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeQQ0-0007u5-RU
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 21:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694136980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4lPMbSASnD44GbgamL1dxZUWAxhOG0A6Kn43vHsAFa4=;
 b=UvvSWRk8H56YGK+R37uTwUovFwq1asIA0GuVodRYgkVtWZjQjLbZNk7Z+OM41tJzagGIsf
 jaELhupptcX6hbMr/jAEe9dwSKmy7uk+nGAU/2ceZN8j4B1yWuX54TJp3OdMKYII9IOYsf
 gO1Kkpaw0ZVxbFR0Oydc9/c1gS3S088=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-237-zwUxaUcyMiC5VpXQ4F4ZkQ-1; Thu, 07 Sep 2023 21:36:18 -0400
X-MC-Unique: zwUxaUcyMiC5VpXQ4F4ZkQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 061771C07834;
 Fri,  8 Sep 2023 01:36:18 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 96FE840C2070;
 Fri,  8 Sep 2023 01:36:17 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 10/13] qemu-nbd: put saddr into into struct NbdClientOpts
Date: Thu,  7 Sep 2023 20:35:46 -0500
Message-ID: <20230908013535.990731-25-eblake@redhat.com>
In-Reply-To: <20230908013535.990731-15-eblake@redhat.com>
References: <20230908013535.990731-15-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

We pass other parameters into nbd_client_thread() in this way. This patch
makes the code more consistent.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20230906093210.339585-5-den@openvz.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-nbd.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 16c59424f13..86bb2f04e24 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -73,7 +73,6 @@

 #define MBR_SIZE 512

-static SocketAddress *saddr;
 static int persistent = 0;
 static enum { RUNNING, TERMINATE, TERMINATED } state;
 static int shared = 1;
@@ -255,6 +254,7 @@ static int qemu_nbd_client_list(SocketAddress *saddr, QCryptoTLSCreds *tls,
 struct NbdClientOpts {
     char *device;
     char *srcpath;
+    SocketAddress *saddr;
     bool fork_process;
     bool verbose;
 };
@@ -289,7 +289,7 @@ static void *nbd_client_thread(void *arg)

     sioc = qio_channel_socket_new();
     if (qio_channel_socket_connect_sync(sioc,
-                                        saddr,
+                                        opts->saddr,
                                         &local_error) < 0) {
         error_report_err(local_error);
         goto out;
@@ -591,6 +591,7 @@ int main(int argc, char **argv)
         .verbose = false,
         .device = NULL,
         .srcpath = NULL,
+        .saddr = NULL,
     };

 #ifdef CONFIG_POSIX
@@ -892,8 +893,8 @@ int main(int argc, char **argv)
     }

     if (list) {
-        saddr = nbd_build_socket_address(sockpath, bindto, port);
-        return qemu_nbd_client_list(saddr, tlscreds,
+        opts.saddr = nbd_build_socket_address(sockpath, bindto, port);
+        return qemu_nbd_client_list(opts.saddr, tlscreds,
                                     tlshostname ? tlshostname : bindto);
     }

@@ -1024,8 +1025,8 @@ int main(int argc, char **argv)
             exit(EXIT_FAILURE);
         }
 #endif
-        saddr = nbd_build_socket_address(sockpath, bindto, port);
-        if (qio_net_listener_open_sync(server, saddr, backlog,
+        opts.saddr = nbd_build_socket_address(sockpath, bindto, port);
+        if (qio_net_listener_open_sync(server, opts.saddr, backlog,
                                        &local_err) < 0) {
             object_unref(OBJECT(server));
             error_report_err(local_err);
-- 
2.41.0


