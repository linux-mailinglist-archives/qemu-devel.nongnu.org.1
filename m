Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CA67D93EC
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 11:38:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwJHU-0002OI-J5; Fri, 27 Oct 2023 05:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qwJHR-0002NK-TR
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 05:37:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qwJHQ-0002lE-Df
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 05:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698399443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BCNJv8ghV91jJ74e+LHf+QzzbZftotexdatDHwsc+oE=;
 b=OaYkHlma10//JcuOy9t4dsvkAyLw0WpX9IsKLZhfI0vBtQA8h15AJA/UZxKB+YiC50jeXE
 xBLZK+OWYbk1Dv1LRB3PyqRcrHk6x/pD/o0pjskyFd+EvLJt0SGuV3F/PnBlR/YVLF9LTB
 jTKv5iYN4GJPiFfBpiSyNwBGpvzXwbs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-NCmQOfiTNy-GAm1t5afWLA-1; Fri, 27 Oct 2023 05:37:22 -0400
X-MC-Unique: NCmQOfiTNy-GAm1t5afWLA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7C43101A481;
 Fri, 27 Oct 2023 09:37:21 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 023F61121320;
 Fri, 27 Oct 2023 09:37:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/11] tests/aio: Clean up global variable shadowing
Date: Fri, 27 Oct 2023 11:37:06 +0200
Message-ID: <20231027093710.273558-8-thuth@redhat.com>
In-Reply-To: <20231027093710.273558-1-thuth@redhat.com>
References: <20231027093710.273558-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Rename the argument to fix:

  tests/unit/test-aio.c:130:44: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  static void set_event_notifier(AioContext *ctx, EventNotifier *notifier,
                                             ^
  tests/unit/test-aio.c:22:20: note: previous declaration is here
  static AioContext *ctx;
                     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20231009100251.56019-9-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/unit/test-aio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/unit/test-aio.c b/tests/unit/test-aio.c
index 71ed31a4db..337b6e4ea7 100644
--- a/tests/unit/test-aio.c
+++ b/tests/unit/test-aio.c
@@ -127,10 +127,10 @@ static void *test_acquire_thread(void *opaque)
     return NULL;
 }
 
-static void set_event_notifier(AioContext *ctx, EventNotifier *notifier,
+static void set_event_notifier(AioContext *nctx, EventNotifier *notifier,
                                EventNotifierHandler *handler)
 {
-    aio_set_event_notifier(ctx, notifier, handler, NULL, NULL);
+    aio_set_event_notifier(nctx, notifier, handler, NULL, NULL);
 }
 
 static void dummy_notifier_read(EventNotifier *n)
-- 
2.41.0


