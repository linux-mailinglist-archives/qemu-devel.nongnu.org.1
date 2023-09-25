Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A367ADF98
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 21:28:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkrE9-0003U5-WC; Mon, 25 Sep 2023 15:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qkrDu-0003FQ-TS
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:26:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qkrDs-00024I-Kv
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695669984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dbtOLubqlGWQMdr+y6KHf+Zcs4tHDcdTDWH3tF/yOL0=;
 b=Q6WoGz9FDvJxLrTGXbPYXSc+GdiR3FMCjUE4HALeu6tKGxtWVPA6FpWPDl2IClMbjmk1+Q
 y4YK6uuAu07CN1qK4umUI3rvyPGtNoAOkl2xLsKJ3zpcqHNj9XU8WwwzK4ioGpGBUMv65u
 /SOQpPL+9lgOw9wmIM9pJ7QnGq/dr5A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-461-asudK24hN6ifXEV2J6bp4Q-1; Mon, 25 Sep 2023 15:26:18 -0400
X-MC-Unique: asudK24hN6ifXEV2J6bp4Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51BB01C294B5;
 Mon, 25 Sep 2023 19:26:18 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF9DF51E3;
 Mon, 25 Sep 2023 19:26:17 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: libguestfs@redhat.com, qemu-block@nongnu.org, vsementsov@yandex-team.ru,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v7 06/12] nbd/client: Plumb errp through nbd_receive_replies
Date: Mon, 25 Sep 2023 14:22:36 -0500
Message-ID: <20230925192229.3186470-20-eblake@redhat.com>
In-Reply-To: <20230925192229.3186470-14-eblake@redhat.com>
References: <20230925192229.3186470-14-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
message to pass to the caller, we can just plumb the caller's errp
down to the low level.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

v5: set errp on more failure cases [Vladimir], typo fix

v4: new patch [Vladimir]
---
 block/nbd.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 4a7f37da1c6..22d3cb11ac8 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -416,7 +416,8 @@ static void coroutine_fn GRAPH_RDLOCK nbd_reconnect_attempt(BDRVNBDState *s)
     reconnect_delay_timer_del(s);
 }

-static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t cookie)
+static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t cookie,
+                                            Error **errp)
 {
     int ret;
     uint64_t ind = COOKIE_TO_INDEX(cookie), ind2;
@@ -457,20 +458,25 @@ static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t cookie)

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
         if (nbd_reply_is_structured(&s->reply) &&
             s->info.mode < NBD_MODE_STRUCTURED) {
             nbd_channel_error(s, -EINVAL);
+            error_setg(errp, "unexpected structured reply");
             return -EINVAL;
         }
         ind2 = COOKIE_TO_INDEX(s->reply.cookie);
         if (ind2 >= MAX_NBD_REQUESTS || !s->requests[ind2].coroutine) {
             nbd_channel_error(s, -EINVAL);
+            error_setg(errp, "unexpected cookie value");
             return -EINVAL;
         }
         if (s->reply.cookie == cookie) {
@@ -842,9 +848,9 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
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
2.41.0


