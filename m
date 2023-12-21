Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6DB81C013
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 22:26:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGQXJ-0001Hg-Fb; Thu, 21 Dec 2023 16:24:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQXC-0000UU-1E
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:24:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQXA-0008DK-DQ
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:24:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703193887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QWPwOV+Eggy5rAsqxhITajGjrnDzyV7XidGn13y1SGk=;
 b=U/tzJ4YPfB9YdvNGqAVqN/JYXCnx/VUbZGUTzbujfzXqIUKafSruRd68J7GxaUPObp5BtK
 H2lMnPJLMA4uljE0EGNSSAJ5vZSJ8anmCA5hSZO1nSHdy9ZSIuU737ooBfYfF5ahCs8z2r
 uUs9f8Ivnibud6+3nnBBp2AtPAFMRrM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-VqBQhSAUML-cDynnKQmLsQ-1; Thu, 21 Dec 2023 16:24:45 -0500
X-MC-Unique: VqBQhSAUML-cDynnKQmLsQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9DAF6833A0F;
 Thu, 21 Dec 2023 21:24:45 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 30187C159B0;
 Thu, 21 Dec 2023 21:24:43 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 24/33] aio: remove aio_context_acquire()/aio_context_release()
 API
Date: Thu, 21 Dec 2023 22:23:29 +0100
Message-ID: <20231221212339.164439-25-kwolf@redhat.com>
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

Delete these functions because nothing calls these functions anymore.

I introduced these APIs in commit 98563fc3ec44 ("aio: add
aio_context_acquire() and aio_context_release()") in 2014. It's with a
sigh of relief that I delete these APIs almost 10 years later.

Thanks to Paolo Bonzini's vision for multi-queue QEMU, we got an
understanding of where the code needed to go in order to remove the
limitations that the original dataplane and the IOThread/AioContext
approach that followed it.

Emanuele Giuseppe Esposito had the splendid determination to convert
large parts of the codebase so that they no longer needed the AioContext
lock. This was a painstaking process, both in the actual code changes
required and the iterations of code review that Emanuele eked out of
Kevin and me over many months.

Kevin Wolf tackled multitudes of graph locking conversions to protect
in-flight I/O from run-time changes to the block graph as well as the
clang Thread Safety Analysis annotations that allow the compiler to
check whether the graph lock is being used correctly.

And me, well, I'm just here to add some pizzazz to the QEMU multi-queue
block layer :). Thank you to everyone who helped with this effort,
including Eric Blake, code reviewer extraordinaire, and others who I've
forgotten to mention.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-ID: <20231205182011.1976568-11-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/aio.h | 17 -----------------
 util/async.c        | 10 ----------
 2 files changed, 27 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index f08b358077..af05512a7d 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -278,23 +278,6 @@ void aio_context_ref(AioContext *ctx);
  */
 void aio_context_unref(AioContext *ctx);
 
-/* Take ownership of the AioContext.  If the AioContext will be shared between
- * threads, and a thread does not want to be interrupted, it will have to
- * take ownership around calls to aio_poll().  Otherwise, aio_poll()
- * automatically takes care of calling aio_context_acquire and
- * aio_context_release.
- *
- * Note that this is separate from bdrv_drained_begin/bdrv_drained_end.  A
- * thread still has to call those to avoid being interrupted by the guest.
- *
- * Bottom halves, timers and callbacks can be created or removed without
- * acquiring the AioContext.
- */
-void aio_context_acquire(AioContext *ctx);
-
-/* Relinquish ownership of the AioContext. */
-void aio_context_release(AioContext *ctx);
-
 /**
  * aio_bh_schedule_oneshot_full: Allocate a new bottom half structure that will
  * run only once and as soon as possible.
diff --git a/util/async.c b/util/async.c
index dfd44ef612..460529057c 100644
--- a/util/async.c
+++ b/util/async.c
@@ -719,16 +719,6 @@ void aio_context_unref(AioContext *ctx)
     g_source_unref(&ctx->source);
 }
 
-void aio_context_acquire(AioContext *ctx)
-{
-    /* TODO remove this function */
-}
-
-void aio_context_release(AioContext *ctx)
-{
-    /* TODO remove this function */
-}
-
 QEMU_DEFINE_STATIC_CO_TLS(AioContext *, my_aiocontext)
 
 AioContext *qemu_get_current_aio_context(void)
-- 
2.43.0


