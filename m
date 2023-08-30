Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A3678E293
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 00:49:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbTyx-0006UH-IG; Wed, 30 Aug 2023 18:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qbTyv-0006TK-RD
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 18:48:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qbTys-0001KU-W9
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 18:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693435690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gN6y1nBDUA1LI5Ks5qyQNeC2RuI/LEi5lAp7pT50gvM=;
 b=YK+V3+4BRjyXN/kS6W7IIhGg6nuoAagFOr0lGrtAlqin63BXb2w0ovZ4GytilWo39Wyfxy
 +HUfz9f/cvGQBgtZY6EWjSRMA3/Er+gp03Twr/aTqaNujt0FLztOcUl1M72Z7XlpwcSAz8
 bzwWL+qqteXzxOoPseRAe8OUkHftY5A=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-570-R9Tp_LbZP3S0yZR_C7rNVg-1; Wed, 30 Aug 2023 18:48:07 -0400
X-MC-Unique: R9Tp_LbZP3S0yZR_C7rNVg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5156B3803915;
 Wed, 30 Aug 2023 22:48:06 +0000 (UTC)
Received: from localhost (unknown [10.39.192.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C0C84492C13;
 Wed, 30 Aug 2023 22:48:05 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Daniel Berrange <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Leonardo Bras <leobras@redhat.com>, farosas@suse.de,
 Hanna Reitz <hreitz@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 kwolf@redhat.com, Coiby Xu <Coiby.Xu@gmail.com>,
 Fam Zheng <fam@euphon.net>, eblake@redhat.com, <qemu-block@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 1/4] nbd: drop unused nbd_receive_negotiate() aio_context
 argument
Date: Wed, 30 Aug 2023 18:47:59 -0400
Message-ID: <20230830224802.493686-2-stefanha@redhat.com>
In-Reply-To: <20230830224802.493686-1-stefanha@redhat.com>
References: <20230830224802.493686-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


