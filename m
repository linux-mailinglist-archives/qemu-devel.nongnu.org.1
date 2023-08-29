Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BCD78C954
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 18:07:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb1Ek-00078g-4e; Tue, 29 Aug 2023 12:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qb1Eg-000788-Kf
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:06:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qb1Ee-0002eX-Cs
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693325191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zuhjGRh7yCVcdFHjq6sVrr2QSG6ibDVXOpmvzu8ZeMk=;
 b=COf+ZVMDDHg+4AmhO8SFda5wQ3gRpt7kFU+ZuraN7W+6GhRNnYY6CssUXO3LLsO2iVdneB
 44RA5mrmtaN3mF34wlmIY7V03uIehpxZs2Ab+k9Dr6vE/LiANiXED8cJKQm38+PsFknu+l
 /ok+gSJOglyXjyNjlaWTv6/5lCZp1KI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-32-rXf3QvEAMoaAFp7oEQ5CAw-1; Tue, 29 Aug 2023 12:06:29 -0400
X-MC-Unique: rXf3QvEAMoaAFp7oEQ5CAw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4CB6085C70E;
 Tue, 29 Aug 2023 16:06:28 +0000 (UTC)
Received: from localhost (unknown [10.39.195.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C185D5CC01;
 Tue, 29 Aug 2023 16:06:27 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>, eblake@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 farosas@suse.de, kwolf@redhat.com, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org,
 Coiby Xu <Coiby.Xu@gmail.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 1/4] nbd: drop unused nbd_receive_negotiate() aio_context
 argument
Date: Tue, 29 Aug 2023 12:06:19 -0400
Message-ID: <20230829160623.277411-2-stefanha@redhat.com>
In-Reply-To: <20230829160623.277411-1-stefanha@redhat.com>
References: <20230829160623.277411-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

aio_context is always NULL, so drop it.

Suggested-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/nbd.h     | 3 +--
 nbd/client-connection.c | 3 +--
 nbd/client.c            | 5 ++---
 qemu-nbd.c              | 4 ++--
 4 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 4428bcffbb..f672b76173 100644
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
index 3d14296c04..aafb3d0fb4 100644
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
index 479208d5d9..16ec10c8a9 100644
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
index aaccaa3318..b47459f781 100644
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


