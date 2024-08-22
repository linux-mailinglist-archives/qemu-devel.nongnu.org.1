Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CC695B8A6
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Aug 2024 16:37:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh8vT-0003bO-QG; Thu, 22 Aug 2024 10:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sh8vR-0003ZC-KU
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 10:36:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sh8vQ-0000Jn-3x
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 10:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724337391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FixiWQ3cwOxFgkWOuuQBMcavXNUKMBjsxQygjgu1SbY=;
 b=Vm8kddtvy+M+oWPRhc0PZY3yN73wu2UM4v9bBFEj2rxdl44qBaqPSUzcjpl/aWjJEoFGG4
 AQupSX2y/2XEc5EzyAVuftX1pml6187U7i8u+4D+msofDuuQnpge+Q/xZR5JDgEhT7brMF
 JmPaSd7Q1lejwz2cf8MyAO5YZNX+RUA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-itsr66tRPYqkE0OEe0fdnA-1; Thu,
 22 Aug 2024 10:36:25 -0400
X-MC-Unique: itsr66tRPYqkE0OEe0fdnA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC1451955BEF; Thu, 22 Aug 2024 14:36:23 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.74])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4109719560A3; Thu, 22 Aug 2024 14:36:19 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, berrange@redhat.com, andrey.drobyshev@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 vsementsov@yandex-team.ru
Subject: [PATCH for-9.1] nbd/server: CVE-2024-7409: Avoid use-after-free when
 closing server
Date: Thu, 22 Aug 2024 09:35:29 -0500
Message-ID: <20240822143617.800419-2-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Commit 3e7ef738 plugged the use-after-free of the global nbd_server
object, but overlooked a use-after-free of nbd_server->listener.
Although this race is harder to hit, notice that our shutdown path
first drops the reference count of nbd_server->listener, then triggers
actions that can result in a pending client reaching the
nbd_blockdev_client_closed() callback, which in turn calls
qio_net_listener_set_client_func on a potentially stale object.

If we know we don't want any more clients to connect, and have already
told the listener socket to shut down, then we should not be trying to
update the listener socket's associated function.

Reproducer:

> #!/usr/bin/python3
>
> import os
> from threading import Thread
>
> def start_stop():
>     while 1:
>         os.system('virsh qemu-monitor-command VM \'{"execute": "nbd-server-start",
+"arguments":{"addr":{"type":"unix","data":{"path":"/tmp/nbd-sock"}}}}\'')
>         os.system('virsh qemu-monitor-command VM \'{"execute": "nbd-server-stop"}\'')
>
> def nbd_list():
>     while 1:
>         os.system('/path/to/build/qemu-nbd -L -k /tmp/nbd-sock')
>
> def test():
>     sst = Thread(target=start_stop)
>     sst.start()
>     nlt = Thread(target=nbd_list)
>     nlt.start()
>
>     sst.join()
>     nlt.join()
>
> test()

Fixes: CVE-2024-7409
Fixes: 3e7ef738c8 ("nbd/server: CVE-2024-7409: Close stray clients at server-stop")
CC: qemu-stable@nongnu.org
Reported-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 blockdev-nbd.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index f73409ae494..b36f41b7c5a 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -92,10 +92,13 @@ static void nbd_accept(QIONetListener *listener, QIOChannelSocket *cioc,

 static void nbd_update_server_watch(NBDServerData *s)
 {
-    if (!s->max_connections || s->connections < s->max_connections) {
-        qio_net_listener_set_client_func(s->listener, nbd_accept, NULL, NULL);
-    } else {
-        qio_net_listener_set_client_func(s->listener, NULL, NULL, NULL);
+    if (s->listener) {
+        if (!s->max_connections || s->connections < s->max_connections) {
+            qio_net_listener_set_client_func(s->listener, nbd_accept, NULL,
+                                             NULL);
+        } else {
+            qio_net_listener_set_client_func(s->listener, NULL, NULL, NULL);
+        }
     }
 }

@@ -113,6 +116,7 @@ static void nbd_server_free(NBDServerData *server)
      */
     qio_net_listener_disconnect(server->listener);
     object_unref(OBJECT(server->listener));
+    server->listener = NULL;
     QLIST_FOREACH_SAFE(conn, &server->conns, next, tmp) {
         qio_channel_shutdown(QIO_CHANNEL(conn->cioc), QIO_CHANNEL_SHUTDOWN_BOTH,
                              NULL);
-- 
2.46.0


