Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 214EC78C958
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 18:08:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb1F5-0007Bm-9c; Tue, 29 Aug 2023 12:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qb1Eq-0007Ay-1N
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:06:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qb1El-0002l8-SH
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693325199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f8gQEQZFbJz851gMAxlrbEWVAGA7PIQfI9u3ENDQ7KQ=;
 b=Fx6L7HphV1btTgpwQgCeXuyXf6uekOxUm1qcOYPTWcMtNbaByMbQWHKcGFJQW2Z/20wIzN
 xoFxWiG1nsFGZt6hCELa51RdbOl9Gr55hiSvnxqqA8jqalbNROLP9V+YBtbbYYmaeLcujR
 iIU6cr5DqwnStePBTQLQ7gNdE8hjyrI=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-g248c82qMvm5YAGn30045w-1; Tue, 29 Aug 2023 12:06:33 -0400
X-MC-Unique: g248c82qMvm5YAGn30045w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D42883C147E9;
 Tue, 29 Aug 2023 16:06:30 +0000 (UTC)
Received: from localhost (unknown [10.39.195.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 59E6D6B2AC;
 Tue, 29 Aug 2023 16:06:30 +0000 (UTC)
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
Subject: [PATCH v2 2/4] nbd: drop unused nbd_start_negotiate() aio_context
 argument
Date: Tue, 29 Aug 2023 12:06:20 -0400
Message-ID: <20230829160623.277411-3-stefanha@redhat.com>
In-Reply-To: <20230829160623.277411-1-stefanha@redhat.com>
References: <20230829160623.277411-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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
 nbd/client.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 16ec10c8a9..bd7e200136 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -877,8 +877,7 @@ static int nbd_list_meta_contexts(QIOChannel *ioc,
  * Returns: negative errno: failure talking to server
  *          non-negative: enum NBDMode describing server abilities
  */
-static int nbd_start_negotiate(AioContext *aio_context, QIOChannel *ioc,
-                               QCryptoTLSCreds *tlscreds,
+static int nbd_start_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
                                const char *hostname, QIOChannel **outioc,
                                bool structured_reply, bool *zeroes,
                                Error **errp)
@@ -946,10 +945,6 @@ static int nbd_start_negotiate(AioContext *aio_context, QIOChannel *ioc,
                     return -EINVAL;
                 }
                 ioc = *outioc;
-                if (aio_context) {
-                    qio_channel_set_blocking(ioc, false, NULL);
-                    qio_channel_attach_aio_context(ioc, aio_context);
-                }
             } else {
                 error_setg(errp, "Server does not support STARTTLS");
                 return -EINVAL;
@@ -1026,7 +1021,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
     assert(info->name && strlen(info->name) <= NBD_MAX_STRING_SIZE);
     trace_nbd_receive_negotiate_name(info->name);
 
-    result = nbd_start_negotiate(NULL, ioc, tlscreds, hostname, outioc,
+    result = nbd_start_negotiate(ioc, tlscreds, hostname, outioc,
                                  info->structured_reply, &zeroes, errp);
     if (result < 0) {
         return result;
@@ -1149,7 +1144,7 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
     QIOChannel *sioc = NULL;
 
     *info = NULL;
-    result = nbd_start_negotiate(NULL, ioc, tlscreds, hostname, &sioc, true,
+    result = nbd_start_negotiate(ioc, tlscreds, hostname, &sioc, true,
                                  NULL, errp);
     if (tlscreds && sioc) {
         ioc = sioc;
-- 
2.41.0


