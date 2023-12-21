Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC9481BF15
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 20:26:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGOfW-0001Qj-4K; Thu, 21 Dec 2023 14:25:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rGOfT-0001Pn-Ve
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 14:25:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rGOfL-000230-T5
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 14:25:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703186706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yqk4OFQOKT4s9q1FhkTw1+IEsq2kegWN4COgjx1UDyc=;
 b=BklmLzDrQXuc3IgX1CXQIVLrdxW7I2vAOtIw/0il5EFNHVBsIFmljXrTZr4VOobaXVp48V
 7cie5OrvEGA3IRiKASb/JeehjrLHUnwG8eKYPZdMdwssQueSIIdKTi51Zy3EVKzMnbci2y
 hbSUqDaFnGTmjPYfwwNx+2WyAueMxWM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-Ua_GNtDNP9uxN9d5btR23Q-1; Thu,
 21 Dec 2023 14:25:03 -0500
X-MC-Unique: Ua_GNtDNP9uxN9d5btR23Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D0531C04B6C;
 Thu, 21 Dec 2023 19:25:02 +0000 (UTC)
Received: from localhost (unknown [10.39.194.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1809E51D5;
 Thu, 21 Dec 2023 19:25:01 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Kevin Wolf <kwolf@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 pbonzini@redhat.com, Peter Xu <peterx@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v3 4/6] nbd/server: avoid per-NBDRequest nbd_client_get/put()
Date: Thu, 21 Dec 2023 14:24:50 -0500
Message-ID: <20231221192452.1785567-5-stefanha@redhat.com>
In-Reply-To: <20231221192452.1785567-1-stefanha@redhat.com>
References: <20231221192452.1785567-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
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


