Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D28C81C001
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 22:24:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGQXE-0000Kp-1E; Thu, 21 Dec 2023 16:24:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQX2-0008Vp-0q
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:24:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQWx-00089s-IR
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:24:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703193874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q2q1e9ZEJvgJXKiRyNP2U5ItW7rMBl990Uvn+m6WofE=;
 b=fI312PKQTcfeEsrKgDfyxnNBBql6FyH/MnTKmXNjwfxHqmeQnNU8xlgM9YI0L7qoJQQcfv
 OMsmgmgii5Whe97PEzDYNOF2lPxAdk0g4gQTIbzUwSTs9EgBzejLerRgvJWhPnoIfC8y4p
 hO9PWkYZdXI26dSwFnqrBadBCa1SAQY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-QKHHEsDiPDK6w4Pac5thhw-1; Thu, 21 Dec 2023 16:24:31 -0500
X-MC-Unique: QKHHEsDiPDK6w4Pac5thhw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2AF76101A52A;
 Thu, 21 Dec 2023 21:24:31 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B3B1C159B0;
 Thu, 21 Dec 2023 21:24:28 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 18/33] aio: make aio_context_acquire()/aio_context_release() a
 no-op
Date: Thu, 21 Dec 2023 22:23:23 +0100
Message-ID: <20231221212339.164439-19-kwolf@redhat.com>
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
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

aio_context_acquire()/aio_context_release() has been replaced by
fine-grained locking to protect state shared by multiple threads. The
AioContext lock still plays the role of balancing locking in
AIO_WAIT_WHILE() and many functions in QEMU either require that the
AioContext lock is held or not held for this reason. In other words, the
AioContext lock is purely there for consistency with itself and serves
no real purpose anymore.

Stop actually acquiring/releasing the lock in
aio_context_acquire()/aio_context_release() so that subsequent patches
can remove callers across the codebase incrementally.

I have performed "make check" and qemu-iotests stress tests across
x86-64, ppc64le, and aarch64 to confirm that there are no failures as a
result of eliminating the lock.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Acked-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20231205182011.1976568-5-stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 util/async.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util/async.c b/util/async.c
index 8f90ddc304..04ee83d220 100644
--- a/util/async.c
+++ b/util/async.c
@@ -725,12 +725,12 @@ void aio_context_unref(AioContext *ctx)
 
 void aio_context_acquire(AioContext *ctx)
 {
-    qemu_rec_mutex_lock(&ctx->lock);
+    /* TODO remove this function */
 }
 
 void aio_context_release(AioContext *ctx)
 {
-    qemu_rec_mutex_unlock(&ctx->lock);
+    /* TODO remove this function */
 }
 
 QEMU_DEFINE_STATIC_CO_TLS(AioContext *, my_aiocontext)
-- 
2.43.0


