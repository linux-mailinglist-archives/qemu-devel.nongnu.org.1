Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B20B072820C
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 16:00:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7G8y-0004EH-3N; Thu, 08 Jun 2023 09:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7G8i-00041Q-9h
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:57:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7G8a-0004jv-JF
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686232633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kXlO+2va6l3lJFccCzHTil3AsL3vWsyS3WIIcDGVh0Y=;
 b=DennrWKNHI8cLcIdxq/mgkvxNgT3eu5tMdRklRno720Z/VGLmV8bzOMh8uFX/qL46tVE2T
 ggk0iAx+9lw3mOrjX3qjBvT3H4OzUBAVffaZ95rybjcuZ+vWk8ho/dXgtr+n2zDrfbf0ri
 R6XGgqZXJxaEZHC4rt5brIZEnrudWv8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-140-1OHfx_KjPfOuTq2ZnnIkPQ-1; Thu, 08 Jun 2023 09:57:10 -0400
X-MC-Unique: 1OHfx_KjPfOuTq2ZnnIkPQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6ECE80231B;
 Thu,  8 Jun 2023 13:57:09 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18A6A492B00;
 Thu,  8 Jun 2023 13:57:09 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, libguestfs@redhat.com, vsementsov@yandex-team.ru,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v4 18/24] nbd/client: Plumb errp through nbd_receive_replies
Date: Thu,  8 Jun 2023 08:56:47 -0500
Message-Id: <20230608135653.2918540-19-eblake@redhat.com>
In-Reply-To: <20230608135653.2918540-1-eblake@redhat.com>
References: <20230608135653.2918540-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Instead of ignoring the low-level error just to refabricate our own
message to pass to the caller, we can just plump the caller's errp
down to the low level.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

v4: new patch [Vladimir]
---
 block/nbd.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 57123c17f94..c17ce935f17 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -417,7 +417,8 @@ static void coroutine_fn GRAPH_RDLOCK nbd_reconnect_attempt(BDRVNBDState *s)
     reconnect_delay_timer_del(s);
 }

-static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t cookie)
+static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t cookie,
+                                            Error **errp)
 {
     int ret;
     uint64_t ind = COOKIE_TO_INDEX(cookie), ind2;
@@ -458,9 +459,12 @@ static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t cookie)

         /* We are under mutex and cookie is 0. We have to do the dirty work. */
         assert(s->reply.cookie == 0);
-        ret = nbd_receive_reply(s->bs, s->ioc, &s->reply, NULL);
-        if (ret <= 0) {
-            ret = ret ? ret : -EIO;
+        ret = nbd_receive_reply(s->bs, s->ioc, &s->reply, errp);
+        if (ret == 0) {
+            ret = -EIO;
+            error_setg(errp, "server dropped connection");
+        }
+        if (ret < 0) {
             nbd_channel_error(s, ret);
             return ret;
         }
@@ -843,9 +847,9 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
     }
     *request_ret = 0;

-    ret = nbd_receive_replies(s, cookie);
+    ret = nbd_receive_replies(s, cookie, errp);
     if (ret < 0) {
-        error_setg(errp, "Connection closed");
+        error_prepend(errp, "Connection closed: ");
         return -EIO;
     }
     assert(s->ioc);
-- 
2.40.1


