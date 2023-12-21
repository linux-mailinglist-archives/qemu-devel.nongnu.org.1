Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BB781C015
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 22:27:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGQWN-0006PI-EJ; Thu, 21 Dec 2023 16:23:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQWI-0006OO-Hy
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:23:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQWH-0007wm-78
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:23:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703193832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lHoDdT4g5pQBLJxekSfgaZtRjQKlnJ4hQFL01I1X9lI=;
 b=NoHjVsfFQC9WXwwuRylcjuvDJERDA8iT0mNmmTT55U1xQThzZhQPd6s9mu7XAX5Ynl8iCX
 Uo8K4Qwfmz0+2xvPRu7rvThvKpUZfqC1pOwF+Pk3g5nDrUIJE2Isz2HdAYkPXXzilCNZBd
 xKW2gD8d0MSg2wIObnBJF+Ro4rOLJGY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-kx_YsV9jO8qeHCw3AAAA3A-1; Thu, 21 Dec 2023 16:23:50 -0500
X-MC-Unique: kx_YsV9jO8qeHCw3AAAA3A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 913748B3960;
 Thu, 21 Dec 2023 21:23:50 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE87DC15968;
 Thu, 21 Dec 2023 21:23:48 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 01/33] nbd/server: avoid per-NBDRequest nbd_client_get/put()
Date: Thu, 21 Dec 2023 22:23:06 +0100
Message-ID: <20231221212339.164439-2-kwolf@redhat.com>
In-Reply-To: <20231221212339.164439-1-kwolf@redhat.com>
References: <20231221212339.164439-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

nbd_trip() processes a single NBD request from start to finish and holds
an NBDClient reference throughout. NBDRequest does not outlive the scope
of nbd_trip(). Therefore it is unnecessary to ref/unref NBDClient for
each NBDRequest.

Removing these nbd_client_get()/nbd_client_put() calls will make
thread-safety easier in the commits that follow.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20231221192452.1785567-5-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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


