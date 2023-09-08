Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE23E79803F
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 03:37:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeQPx-0008QJ-6f; Thu, 07 Sep 2023 21:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeQPv-0008Pr-JY
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 21:36:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeQPt-0007sV-2Z
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 21:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694136972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DRV578KzQi2bfJ0mlQnroELkcGRUQ+AZukcRhklKJ4o=;
 b=cNN2rnhyqn60ibUDOeRU9w27Ux10OP2CYhBSh36XCJXeAcDYsti6f1dAr+vco25rx4pVQt
 uZMcKG4n0pw+f3tVjstAl77Wj61ctYNqVIwxM3bBIqE7OHqO+XXatigpnsRPb02U1Wq78g
 D/EdW6rwUEZBsaG7oHUFCiGj+0Ghugw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-221-nDA0AfeUPUK_wXn-Acll9w-1; Thu, 07 Sep 2023 21:36:09 -0400
X-MC-Unique: nDA0AfeUPUK_wXn-Acll9w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48B39816529;
 Fri,  8 Sep 2023 01:36:09 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7038440C2070;
 Fri,  8 Sep 2023 01:36:07 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 02/13] nbd: drop unused nbd_receive_negotiate() aio_context
 argument
Date: Thu,  7 Sep 2023 20:35:38 -0500
Message-ID: <20230908013535.990731-17-eblake@redhat.com>
In-Reply-To: <20230908013535.990731-15-eblake@redhat.com>
References: <20230908013535.990731-15-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Stefan Hajnoczi <stefanha@redhat.com>

aio_context is always NULL, so drop it.

Suggested-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230830224802.493686-2-stefanha@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/nbd.h     | 3 +--
 nbd/client-connection.c | 3 +--
 nbd/client.c            | 5 ++---
 qemu-nbd.c              | 4 ++--
 4 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 4428bcffbb9..f672b76173b 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -324,8 +324,7 @@ typedef struct NBDExportInfo {
     char **contexts;
 } NBDExportInfo;

-int nbd_receive_negotiate(AioContext *aio_context, QIOChannel *ioc,
-                          QCryptoTLSCreds *tlscreds,
+int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
                           const char *hostname, QIOChannel **outioc,
                           NBDExportInfo *info, Error **errp);
 void nbd_free_export_list(NBDExportInfo *info, int count);
diff --git a/nbd/client-connection.c b/nbd/client-connection.c
index 3d14296c042..aafb3d0fb43 100644
--- a/nbd/client-connection.c
+++ b/nbd/client-connection.c
@@ -146,8 +146,7 @@ static int nbd_connect(QIOChannelSocket *sioc, SocketAddress *addr,
         return 0;
     }

-    ret = nbd_receive_negotiate(NULL, QIO_CHANNEL(sioc), tlscreds,
-                                tlshostname,
+    ret = nbd_receive_negotiate(QIO_CHANNEL(sioc), tlscreds, tlshostname,
                                 outioc, info, errp);
     if (ret < 0) {
         /*
diff --git a/nbd/client.c b/nbd/client.c
index 479208d5d9d..16ec10c8a91 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -1014,8 +1014,7 @@ static int nbd_negotiate_finish_oldstyle(QIOChannel *ioc, NBDExportInfo *info,
  * Returns: negative errno: failure talking to server
  *          0: server is connected
  */
-int nbd_receive_negotiate(AioContext *aio_context, QIOChannel *ioc,
-                          QCryptoTLSCreds *tlscreds,
+int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
                           const char *hostname, QIOChannel **outioc,
                           NBDExportInfo *info, Error **errp)
 {
@@ -1027,7 +1026,7 @@ int nbd_receive_negotiate(AioContext *aio_context, QIOChannel *ioc,
     assert(info->name && strlen(info->name) <= NBD_MAX_STRING_SIZE);
     trace_nbd_receive_negotiate_name(info->name);

-    result = nbd_start_negotiate(aio_context, ioc, tlscreds, hostname, outioc,
+    result = nbd_start_negotiate(NULL, ioc, tlscreds, hostname, outioc,
                                  info->structured_reply, &zeroes, errp);
     if (result < 0) {
         return result;
diff --git a/qemu-nbd.c b/qemu-nbd.c
index aaccaa33184..b47459f781d 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -295,8 +295,8 @@ static void *nbd_client_thread(void *arg)
         goto out;
     }

-    if (nbd_receive_negotiate(NULL, QIO_CHANNEL(sioc),
-                              NULL, NULL, NULL, &info, &local_error) < 0) {
+    if (nbd_receive_negotiate(QIO_CHANNEL(sioc), NULL, NULL, NULL,
+                              &info, &local_error) < 0) {
         if (local_error) {
             error_report_err(local_error);
         }
-- 
2.41.0


