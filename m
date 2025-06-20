Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7D5AE1035
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Jun 2025 02:12:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSPLm-0000jM-Ap; Thu, 19 Jun 2025 20:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uSPLX-0000h1-0M
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 20:11:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uSPLV-0004rw-Gw
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 20:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750378264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N8YvnE4tw3No+nwt43NFvLujCKhrK1vA+KDZ/L6h2S8=;
 b=Q1qdkTXpnoex888CpwOpMRk1ksINhXB9yS56/cyZhtrICoKUAjs9ZTmkjpfPQnhd1dPAaM
 NPwFQWZnrcwSmMXJXUkw2ohS28lMT2B0G7AWJQoJP4wtk0r3QQcbypF6IiTtu285VVgQz8
 wKnfvt4YN1HN2OtyJIEQ1D5LLkr7u+E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-Tqb1d-cgMha8PqI3AtfX1g-1; Thu,
 19 Jun 2025 20:11:01 -0400
X-MC-Unique: Tqb1d-cgMha8PqI3AtfX1g-1
X-Mimecast-MFC-AGG-ID: Tqb1d-cgMha8PqI3AtfX1g_1750378257
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72C36180028B; Fri, 20 Jun 2025 00:10:57 +0000 (UTC)
Received: from localhost (unknown [10.2.16.120])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 08FE130001A1; Fri, 20 Jun 2025 00:10:56 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, eblake@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, hibriansong@gmail.com
Subject: [PATCH v2 06/12] aio: free AioContext when aio_context_new() fails
Date: Thu, 19 Jun 2025 20:08:22 -0400
Message-ID: <20250620000829.1426291-7-stefanha@redhat.com>
In-Reply-To: <20250620000829.1426291-1-stefanha@redhat.com>
References: <20250620000829.1426291-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

g_source_destroy() only removes the GSource from the GMainContext it's
attached to, if any. It does not free it.

Use g_source_unref() instead so that the AioContext (which embeds a
GSource) is freed. There is no need to call g_source_destroy() in
aio_context_new() because the GSource isn't attached to a GMainContext
yet.

aio_ctx_finalize() expects everything to be set up already, so introduce
the new ctx->initialized boolean and do nothing when called with
!initialized. This also requires moving aio_context_setup() down after
event_notifier_init() since aio_ctx_finalize() won't release any
resources that aio_context_setup() acquired.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
v2:
- Fix spacing in aio_ctx_finalize() argument list [Eric]
---
 include/block/aio.h |  3 +++
 util/async.c        | 14 +++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index 1657740a0e..2760f308f5 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -291,6 +291,9 @@ struct AioContext {
     gpointer epollfd_tag;
 
     const FDMonOps *fdmon_ops;
+
+    /* Was aio_context_new() successful? */
+    bool initialized;
 };
 
 /**
diff --git a/util/async.c b/util/async.c
index a39410d675..34aaab4e9e 100644
--- a/util/async.c
+++ b/util/async.c
@@ -363,12 +363,16 @@ aio_ctx_dispatch(GSource     *source,
 }
 
 static void
-aio_ctx_finalize(GSource     *source)
+aio_ctx_finalize(GSource *source)
 {
     AioContext *ctx = (AioContext *) source;
     QEMUBH *bh;
     unsigned flags;
 
+    if (!ctx->initialized) {
+        return;
+    }
+
     thread_pool_free_aio(ctx->thread_pool);
 
 #ifdef CONFIG_LINUX_AIO
@@ -579,13 +583,15 @@ AioContext *aio_context_new(Error **errp)
     ctx = (AioContext *) g_source_new(&aio_source_funcs, sizeof(AioContext));
     QSLIST_INIT(&ctx->bh_list);
     QSIMPLEQ_INIT(&ctx->bh_slice_list);
-    aio_context_setup(ctx);
 
     ret = event_notifier_init(&ctx->notifier, false);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Failed to initialize event notifier");
         goto fail;
     }
+
+    aio_context_setup(ctx);
+
     g_source_set_can_recurse(&ctx->source, true);
     qemu_lockcnt_init(&ctx->list_lock);
 
@@ -619,9 +625,11 @@ AioContext *aio_context_new(Error **errp)
 
     register_aiocontext(ctx);
 
+    ctx->initialized = true;
+
     return ctx;
 fail:
-    g_source_destroy(&ctx->source);
+    g_source_unref(&ctx->source);
     return NULL;
 }
 
-- 
2.49.0


