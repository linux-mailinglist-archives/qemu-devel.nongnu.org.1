Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE92F703DE3
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 21:55:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyeGZ-0004x8-Ly; Mon, 15 May 2023 15:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pyeGW-0004w5-Up
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:53:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pyeGU-00047b-Ss
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684180430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hPqe0FFBC9bRi3EyvCrDIgSuJLMS5H5eHjoCpmGVNBU=;
 b=FAm05HNPxkhUunouJBOsnU4XR+S/KcpDxsH/mIfkhqG0tIALbYI8sCbQZEePXg/KMqrL4Y
 Y8q198YiQXD0dncNg6KUkJtu7XUhavqwfDuNWzUqYO3F4ZhycJRFbs/KE2bQF+2+OiZcOb
 x528iItRmBot2Nr4AraUrT08qT2W3iY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-5AN_19FUOCSrZXe0X5m_hw-1; Mon, 15 May 2023 15:53:47 -0400
X-MC-Unique: 5AN_19FUOCSrZXe0X5m_hw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8D6629ABA1E;
 Mon, 15 May 2023 19:53:46 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 40A951410ED9;
 Mon, 15 May 2023 19:53:46 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: libguestfs@redhat.com, vsementsov@yandex-team.ru,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PATCH v3 01/14] nbd/client: Use smarter assert
Date: Mon, 15 May 2023 14:53:30 -0500
Message-Id: <20230515195343.1915857-2-eblake@redhat.com>
In-Reply-To: <20230515195343.1915857-1-eblake@redhat.com>
References: <20230515195343.1915857-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Assigning strlen() to a uint32_t and then asserting that it isn't too
large doesn't catch the case of an input string 4G in length.
Thankfully, the incoming strings can never be that large: if the
export name or query is reflecting a string the client got from the
server, we already guarantee that we dropped the NBD connection if the
server sent more than 32M in a single reply to our NBD_OPT_* request;
if the export name is coming from qemu, nbd_receive_negotiate()
asserted that strlen(info->name) <= NBD_MAX_STRING_SIZE; and
similarly, a query string via x->dirty_bitmap coming from the user was
bounds-checked in either qemu-nbd or by the limitations of QMP.
Still, it doesn't hurt to be more explicit in how we write our
assertions to not have to analyze whether inadvertent wraparound is
possible.

Fixes: 93676c88 ("nbd: Don't send oversize strings", v4.2.0)
Reported-by: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Eric Blake <eblake@redhat.com>

---

Looking through older branches, I came across this one that was never
applied at the time, but which also had a useful review comment from
Vladimir that invalidates the R-b it had back then.

v2 was here: https://lists.gnu.org/archive/html/qemu-devel/2022-10/msg02733.html
since then - update David's email, use strnlen before strlen
---
 nbd/client.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 30d5383cb19..ff75722e487 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -650,19 +650,20 @@ static int nbd_send_meta_query(QIOChannel *ioc, uint32_t opt,
                                Error **errp)
 {
     int ret;
-    uint32_t export_len = strlen(export);
+    uint32_t export_len;
     uint32_t queries = !!query;
     uint32_t query_len = 0;
     uint32_t data_len;
     char *data;
     char *p;

+    assert(strnlen(export, NBD_MAX_STRING_SIZE + 1) <= NBD_MAX_STRING_SIZE);
+    export_len = strlen(export);
     data_len = sizeof(export_len) + export_len + sizeof(queries);
-    assert(export_len <= NBD_MAX_STRING_SIZE);
     if (query) {
+        assert(strnlen(query, NBD_MAX_STRING_SIZE + 1) <= NBD_MAX_STRING_SIZE);
         query_len = strlen(query);
         data_len += sizeof(query_len) + query_len;
-        assert(query_len <= NBD_MAX_STRING_SIZE);
     } else {
         assert(opt == NBD_OPT_LIST_META_CONTEXT);
     }
-- 
2.40.1


