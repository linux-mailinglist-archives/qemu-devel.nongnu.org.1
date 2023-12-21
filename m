Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B6181BAFE
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 16:38:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGL5m-0005vp-Hz; Thu, 21 Dec 2023 10:36:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rGL5i-0005ud-3x
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 10:36:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rGL5g-0005aW-Jx
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 10:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703172964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yqk4OFQOKT4s9q1FhkTw1+IEsq2kegWN4COgjx1UDyc=;
 b=fcd2xT/PqvZC8EWrHzp/cwWg6i6GFK9aScy6Q1zY8i424xkeJ6Dmvq5cpsfUmfK5M647bN
 0iYb7buLCHUkRSh6Arul2pqKI0rgufWO/Ct4iRQcRN/AO55B3CfwE5bsJ8h6ZLUY/Mbb6l
 afjiIa/pQ+NzrJeKBKUSzgUR5K9W6sA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-LuOAwn7fPASlaIHSV3yKbw-1; Thu, 21 Dec 2023 10:36:00 -0500
X-MC-Unique: LuOAwn7fPASlaIHSV3yKbw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA3C783BA91;
 Thu, 21 Dec 2023 15:35:59 +0000 (UTC)
Received: from localhost (unknown [10.39.194.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B3761121313;
 Thu, 21 Dec 2023 15:35:59 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>,
	qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH v2 4/6] nbd/server: avoid per-NBDRequest nbd_client_get/put()
Date: Thu, 21 Dec 2023 10:35:46 -0500
Message-ID: <20231221153548.1752005-5-stefanha@redhat.com>
In-Reply-To: <20231221153548.1752005-1-stefanha@redhat.com>
References: <20231221153548.1752005-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
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


