Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 527B9B51FF4
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Sep 2025 20:10:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwPFx-00064i-62; Wed, 10 Sep 2025 14:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uwPDo-0004mA-J0
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 14:07:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uwPDk-00056s-AG
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 14:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757527622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iCOyFpxiCvdCHHGGyD8GBC0zxfD/CZNB4t89d+3dimI=;
 b=JnSENXE5AsROEOSlfQ0XHJ6HfCv5RDX6R3n4smA1K9VaeIci0fkkIBP8J/Je/h1XWTWhGf
 qhI7R82SYfl3k/+sNo7lOUlOQ+eNT/39HyqJIMS820FCA+A1oTDMiHMEabwn7Er5FieSaI
 I+BwWvZVW7CfnTkvUO4hvzX9eVwKxnU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-Wd9dl5K6Phe4gU-vK2TIwQ-1; Wed,
 10 Sep 2025 14:06:58 -0400
X-MC-Unique: Wd9dl5K6Phe4gU-vK2TIwQ-1
X-Mimecast-MFC-AGG-ID: Wd9dl5K6Phe4gU-vK2TIwQ_1757527616
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A84031800452; Wed, 10 Sep 2025 18:06:56 +0000 (UTC)
Received: from localhost (unknown [10.2.17.66])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4E52F1800447; Wed, 10 Sep 2025 18:06:56 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Aarushi Mehta <mehta.aaru20@gmail.com>, Fam Zheng <fam@euphon.net>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, eblake@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, hibriansong@gmail.com, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 10/12] aio-posix: avoid EventNotifier for cqe_handler_bh
Date: Wed, 10 Sep 2025 13:57:01 -0400
Message-ID: <20250910175703.374499-11-stefanha@redhat.com>
In-Reply-To: <20250910175703.374499-1-stefanha@redhat.com>
References: <20250910175703.374499-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

fdmon_ops->wait() is called with notify_me enabled. This makes it an
expensive place to call qemu_bh_schedule() because aio_notify() invokes
write(2) on the EventNotifier.

Moving qemu_bh_schedule() after notify_me is reset improves IOPS from
270k to 300k IOPS with --blockdev file,aio=io_uring.

I considered alternatives:
1. Introducing a variant of qemu_bh_schedule() that skips aio_notify().
   This only makes sense within the AioContext and fdmon implementation
   itself and is therefore a specialized internal API. I don't like
   that.
2. Changing fdmon_ops->wait() so implementors can reset notify_me
   themselves. This makes things complex and the other fdmon
   implementations don't need it, so it doesn't seem like a good
   solution.

So in the end I moved the qemu_bh_schedule() call from fdmon-io_uring.c
to aio-posix.c. It's ugly but straightforward.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 util/aio-posix.c      | 11 +++++++++++
 util/fdmon-io_uring.c | 11 ++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index df945312b3..20b11e5650 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -700,6 +700,17 @@ bool aio_poll(AioContext *ctx, bool blocking)
                              qatomic_read(&ctx->notify_me) - 2);
     }
 
+#ifdef CONFIG_LINUX_IO_URING
+    /*
+     * This is part of fdmon-io_uring.c but it's more efficient to do it here
+     * after notify_me has been reset. That way qemu_bh_schedule() ->
+     * aio_notify() does not write the EventNotifier.
+     */
+    if (!QSIMPLEQ_EMPTY(&ctx->cqe_handler_ready_list)) {
+        qemu_bh_schedule(ctx->cqe_handler_bh);
+    }
+#endif
+
     aio_notify_accept(ctx);
 
     /* Calculate blocked time for adaptive polling */
diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
index 7f7c50907d..9ed02597d6 100644
--- a/util/fdmon-io_uring.c
+++ b/util/fdmon-io_uring.c
@@ -334,8 +334,12 @@ static bool process_cqe(AioContext *ctx,
     }
 
     cqe_handler->cqe = *cqe;
+
+    /*
+     * aio_poll() and fdmon_io_uring_gsource_dispatch() schedule cqe_handler_bh
+     * when the list is non-empty.
+     */
     QSIMPLEQ_INSERT_TAIL(&ctx->cqe_handler_ready_list, cqe_handler, next);
-    qemu_bh_schedule(ctx->cqe_handler_bh);
     return false;
 }
 
@@ -386,6 +390,11 @@ static void fdmon_io_uring_gsource_dispatch(AioContext *ctx,
                                             AioHandlerList *ready_list)
 {
     process_cq_ring(ctx, ready_list);
+
+    /* Ensure CqeHandlers enqueued by process_cq_ring() will run */
+    if (!QSIMPLEQ_EMPTY(&ctx->cqe_handler_ready_list)) {
+        qemu_bh_schedule(ctx->cqe_handler_bh);
+    }
 }
 
 static int fdmon_io_uring_wait(AioContext *ctx, AioHandlerList *ready_list,
-- 
2.51.0


