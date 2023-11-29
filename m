Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F137FE0A6
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 20:58:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8Qfh-0007Kp-Hk; Wed, 29 Nov 2023 14:56:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r8Qff-0007IC-8D
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 14:56:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r8Qfb-0004Mo-I4
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 14:56:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701287787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dKDLiHF1X71kKBGZSvHJbLZCC/+L9f9ZlF5nJQ5JHss=;
 b=dl2D5idt9BfZPOgXMfEH5h6P4I3EcEUcpv4K5nXNLD2FwFwlAxQt96AZsRf+lw6hlIb+Bw
 Z6gzkKgek7Brm7nf3kHimR9i0j7P/tz0T6rWv7lxJhj90uq2SrSl6AKbyKl1+Yl8Ggdf91
 AvwS6bI811adYXY29+PD2jYFWjoSCI4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-V4RCa5FgOVyNOyjvlaQEWQ-1; Wed, 29 Nov 2023 14:56:22 -0500
X-MC-Unique: V4RCa5FgOVyNOyjvlaQEWQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EDC72185A781;
 Wed, 29 Nov 2023 19:56:21 +0000 (UTC)
Received: from localhost (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 59B8540C6EBA;
 Wed, 29 Nov 2023 19:56:21 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alberto Garcia <berto@igalia.com>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 <qemu-block@nongnu.org>, xen-devel@lists.xenproject.org,
 Coiby Xu <Coiby.Xu@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Xie Changlong <xiechanglong.d@gmail.com>, Ari Sundholm <ari@tuxera.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Cleber Rosa <crosa@redhat.com>,
 Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Zhang Chen <chen.zhang@intel.com>, Peter Xu <peterx@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Leonardo Bras <leobras@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Fam Zheng <fam@euphon.net>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 08/12] aio: remove aio_context_acquire()/aio_context_release()
 API
Date: Wed, 29 Nov 2023 14:55:49 -0500
Message-ID: <20231129195553.942921-9-stefanha@redhat.com>
In-Reply-To: <20231129195553.942921-1-stefanha@redhat.com>
References: <20231129195553.942921-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
required and the iterations of code review that Emanuele eeked out of
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
2.42.0


