Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70166786410
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 01:46:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYxXM-0004If-8c; Wed, 23 Aug 2023 19:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYxXJ-0004HG-6V
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 19:45:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYxXG-00029o-D2
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 19:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692834313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d16GLWmfy5FhG1Fr3wOFsMSDmIuMXj/fy9DU4sb46rY=;
 b=J5wzmqZvFUuTycC4pp98YcHoiiqecfqej19SqY/ypDFwKfXhLElAwlmzvvdMPBXAgWTMlx
 PbVTeTe2VH+0XjfH3Ahrm1V9jbs5vndvI+wx6DssDoNa7OEMZDVNeSZsMDRVkFpVaQHI9/
 4LObw+pTbzavIYE3EA8Wen0gzFPWiyw=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-UgAm2ZmwM7iOeWJkItk54A-1; Wed, 23 Aug 2023 19:45:10 -0400
X-MC-Unique: UgAm2ZmwM7iOeWJkItk54A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2654E3801BC0;
 Wed, 23 Aug 2023 23:45:10 +0000 (UTC)
Received: from localhost (unknown [10.39.192.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8927A2026D76;
 Wed, 23 Aug 2023 23:45:09 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, kwolf@redhat.com,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Daniel Berrange <berrange@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Leonardo Bras <leobras@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Peter Xu <peterx@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 1/2] io: check there are no qio_channel_yield() coroutines
 during ->finalize()
Date: Wed, 23 Aug 2023 19:45:03 -0400
Message-ID: <20230823234504.1387239-2-stefanha@redhat.com>
In-Reply-To: <20230823234504.1387239-1-stefanha@redhat.com>
References: <20230823234504.1387239-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Callers must clean up their coroutines before calling
object_unref(OBJECT(ioc)) to prevent an fd handler leak. Add an
assertion to check this.

This patch is preparation for the fd handler changes that follow.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 io/channel.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/io/channel.c b/io/channel.c
index 72f0066af5..c415f3fc88 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -653,6 +653,10 @@ static void qio_channel_finalize(Object *obj)
 {
     QIOChannel *ioc = QIO_CHANNEL(obj);
 
+    /* Must not have coroutines in qio_channel_yield() */
+    assert(!ioc->read_coroutine);
+    assert(!ioc->write_coroutine);
+
     g_free(ioc->name);
 
 #ifdef _WIN32
-- 
2.41.0


