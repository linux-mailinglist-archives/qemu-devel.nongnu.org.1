Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C2781AC5A
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 02:51:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG8Bo-00087u-47; Wed, 20 Dec 2023 20:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rG8Be-00086f-FX
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 20:49:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rG8Bd-0002hB-1t
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 20:49:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703123360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qruMacLlFsPykvuMWRHnESpS+zRnMwzUPQmLEI3rCE8=;
 b=YrPtnGzFqQ0+NSFw7e2M3hax1GCtwvOvo5whpfnkoQN7ApuVdEPHMXOIUc4IqZg/OnIj1L
 doDHgYJ+CFOU9ApcYp68wdA0pwdSdy4NZffhtfE/lQ6Nz9QlDYybdCyUEOfLtnmM/5icmu
 GCFN/+/7R8nKx0+r1f46ZHRS2FlYYek=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-4tWsDGHQOpisg6JAfnZvdg-1; Wed,
 20 Dec 2023 20:49:15 -0500
X-MC-Unique: 4tWsDGHQOpisg6JAfnZvdg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 974091C05EA0;
 Thu, 21 Dec 2023 01:49:15 +0000 (UTC)
Received: from localhost (unknown [10.39.192.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0157D3C25;
 Thu, 21 Dec 2023 01:49:14 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>,
	qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH 4/6] nbd/server: avoid per-NBDRequest nbd_client_get/put()
Date: Wed, 20 Dec 2023 20:49:01 -0500
Message-ID: <20231221014903.1537962-5-stefanha@redhat.com>
In-Reply-To: <20231221014903.1537962-1-stefanha@redhat.com>
References: <20231221014903.1537962-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

nbd_trip() processes a single NBD request from start to finish and holds
an NBDClient reference throughout. NBDRequest does not outlive the scope
of nbd_trip(). Therefore it is unnecessary to ref/unref NBDClient for
each NBDRequest.

Removing these nbd_client_get()/nbd_client_put() calls will make
thread-safety easier in the commits that follow.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 nbd/server.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 895cf0a752..0b09ccc8dc 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1557,7 +1557,6 @@ static NBDRequestData *nbd_request_get(NBDClient *client)
     client->nb_requests++;
 
     req = g_new0(NBDRequestData, 1);
-    nbd_client_get(client);
     req->client = client;
     return req;
 }
@@ -1578,8 +1577,6 @@ static void nbd_request_put(NBDRequestData *req)
     }
 
     nbd_client_receive_next_request(client);
-
-    nbd_client_put(client);
 }
 
 static void blk_aio_attached(AioContext *ctx, void *opaque)
-- 
2.43.0


