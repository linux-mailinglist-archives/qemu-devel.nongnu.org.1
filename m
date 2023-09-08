Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7A3798044
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 03:38:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeQQ2-0008RV-0f; Thu, 07 Sep 2023 21:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeQPz-0008R6-P5
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 21:36:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeQPx-0007tC-JC
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 21:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694136976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y4/luUrhIOXb/0AEEz5lSG0rtRG28lh7/LGt0/Rofa4=;
 b=LrRtMEGdtBL9dbCUoiuWTxbWG7OWLpV+uuky2blK5XmgPijNehEJaBnSsP5C3hD/YYxzYd
 Qt1flMhCWWXPZRN/lP9yN1xm/GcfDthqpbYhHMjqTh3di6hbT47NPLGObuKMXMzvVXu+8j
 9hdVGoGMJWZtzLGkRYAdrTTrPKqi5Gg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-46-lqOxdrUNMtaUXG0c7xlmDA-1; Thu, 07 Sep 2023 21:36:11 -0400
X-MC-Unique: lqOxdrUNMtaUXG0c7xlmDA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1061C101CA84;
 Fri,  8 Sep 2023 01:36:11 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 73A2B40C2070;
 Fri,  8 Sep 2023 01:36:09 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 03/13] nbd: drop unused nbd_start_negotiate() aio_context
 argument
Date: Thu,  7 Sep 2023 20:35:39 -0500
Message-ID: <20230908013535.990731-18-eblake@redhat.com>
In-Reply-To: <20230908013535.990731-15-eblake@redhat.com>
References: <20230908013535.990731-15-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Message-ID: <20230830224802.493686-3-stefanha@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/client.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 16ec10c8a91..bd7e2001366 100644
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


