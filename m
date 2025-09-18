Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5793B52003
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Sep 2025 20:12:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwPGX-00075I-UW; Wed, 10 Sep 2025 14:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uwPDk-0004dk-I6
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 14:07:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uwPDc-000554-Gl
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 14:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757527613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xHdACXr84YhqbE/jHeXVyF/tWlCAyRBtrZFX3E/y3wI=;
 b=ZPY0xkKkLR89LYTQ0o/Bh/2pEbfUqZ9tl6brBWqtUADjrzLr52R7BVFfPPZOtj/Zs40KJW
 sUnGBam4aQdXL8modN0wMf2Q1e7PVr1Q31qUY505rlhY+TLFBYsSDrneMND1RskGHoMDml
 wnZ+OKKZOS2MBXG68v07YX4o2qJcJTU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-Cxc0VQl5M8KmS7UuROigjw-1; Wed,
 10 Sep 2025 14:06:50 -0400
X-MC-Unique: Cxc0VQl5M8KmS7UuROigjw-1
X-Mimecast-MFC-AGG-ID: Cxc0VQl5M8KmS7UuROigjw_1757527609
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40FC81800285; Wed, 10 Sep 2025 18:06:49 +0000 (UTC)
Received: from localhost (unknown [10.2.17.66])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B33DD1800447; Wed, 10 Sep 2025 18:06:48 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Aarushi Mehta <mehta.aaru20@gmail.com>, Fam Zheng <fam@euphon.net>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, eblake@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, hibriansong@gmail.com, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 06/12] aio: free AioContext when aio_context_new() fails
Date: Wed, 10 Sep 2025 13:56:57 -0400
Message-ID: <20250910175703.374499-7-stefanha@redhat.com>
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
2.51.0


