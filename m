Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3072B78D5A6
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 13:50:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbJi2-0003fp-2u; Wed, 30 Aug 2023 07:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qbJhy-0003X2-Kx
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 07:50:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qbJhw-0003jM-Is
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 07:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693396200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TTOlhnU8FQgncj4r5I4EbHjsKY1j8lGUXnUus2JhPoI=;
 b=ZDjXYOBsUH175Obzzx8CmljKtMUM1M7bESxngyAID8D5AznYSgh2mveKoQQ9M/bBotFSIr
 Uns/M5mJ0JNT5t72W/Hkn/zTBJ/QuDgRwuZZwWWtR5Q2GDt0Luk2/tfZyR4Cq8rP0DOLaY
 c8h48hWc4MCttNmAqGsBYNr2KrvEE1s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-nAKD0yb5PEC7Sjq9YDoyyQ-1; Wed, 30 Aug 2023 07:49:56 -0400
X-MC-Unique: nAKD0yb5PEC7Sjq9YDoyyQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64CF2858290;
 Wed, 30 Aug 2023 11:49:55 +0000 (UTC)
Received: from localhost (unknown [10.39.193.236])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6F3EC15BB8;
 Wed, 30 Aug 2023 11:49:54 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jeuk Kim <jeuk20.kim@samsung.com>, qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Leonardo Bras <leobras@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PULL v3 5/5] aio-posix: zero out io_uring sqe user_data
Date: Wed, 30 Aug 2023 07:49:42 -0400
Message-ID: <20230830114942.449060-6-stefanha@redhat.com>
In-Reply-To: <20230830114942.449060-1-stefanha@redhat.com>
References: <20230830114942.449060-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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

liburing does not clear sqe->user_data. We must do it ourselves to avoid
undefined behavior in process_cqe() when user_data is used.

Note that fdmon-io_uring is currently disabled, so this is a latent bug
that does not affect users. Let's merge this fix now to make it easier
to enable fdmon-io_uring in the future (and I'm working on that).

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20230426212639.82310-1-stefanha@redhat.com>
---
 util/fdmon-io_uring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
index 17ec18b7bd..16054c5ede 100644
--- a/util/fdmon-io_uring.c
+++ b/util/fdmon-io_uring.c
@@ -184,6 +184,7 @@ static void add_poll_remove_sqe(AioContext *ctx, AioHandler *node)
 #else
     io_uring_prep_poll_remove(sqe, node);
 #endif
+    io_uring_sqe_set_data(sqe, NULL);
 }
 
 /* Add a timeout that self-cancels when another cqe becomes ready */
@@ -197,6 +198,7 @@ static void add_timeout_sqe(AioContext *ctx, int64_t ns)
 
     sqe = get_sqe(ctx);
     io_uring_prep_timeout(sqe, &ts, 1, 0);
+    io_uring_sqe_set_data(sqe, NULL);
 }
 
 /* Add sqes from ctx->submit_list for submission */
-- 
2.41.0


