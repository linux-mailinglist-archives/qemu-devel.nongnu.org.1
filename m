Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E90805D45
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 19:24:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAa2x-0000N1-6c; Tue, 05 Dec 2023 13:21:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAa2Z-0000Gz-Sh
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 13:21:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAa2K-0002ng-0x
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 13:21:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701800447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pcv/XqVh2Z7iu9z6gUwclnS+Bu4/7vR59iug4jWCKh4=;
 b=I0eWWqwf0rzerGOK+nmlDAFUP2UBjGGpJ3jZEG7FhY7wE8tYTxD0QWxEt8In9/fkW2Yia1
 5Y7wgKcu7MzgmT2mLE4CcZkHWj2Nc23XUodVGZQi+Ji1u6Om0OO3WE/rR/EVl8Fx7Iq/Ij
 UyHizvNWA+fdecJ+zxwP8ARPvNxJY+E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-vcT85WOuNBCsPHqsqxe_sw-1; Tue,
 05 Dec 2023 13:20:42 -0500
X-MC-Unique: vcT85WOuNBCsPHqsqxe_sw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 309EC3C2A1C8;
 Tue,  5 Dec 2023 18:20:41 +0000 (UTC)
Received: from localhost (unknown [10.39.194.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 716931121312;
 Tue,  5 Dec 2023 18:20:40 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Cleber Rosa <crosa@redhat.com>, Xie Changlong <xiechanglong.d@gmail.com>,
 Paul Durrant <paul@xen.org>, Ari Sundholm <ari@tuxera.com>,
 Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Wen Congyang <wencongyang2@huawei.com>, Alberto Garcia <berto@igalia.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Hanna Reitz <hreitz@redhat.com>,
 Zhang Chen <chen.zhang@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Peter Xu <peterx@redhat.com>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>,
 Fam Zheng <fam@euphon.net>, Leonardo Bras <leobras@redhat.com>,
 David Hildenbrand <david@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 09/14] aio-wait: draw equivalence between AIO_WAIT_WHILE()
 and AIO_WAIT_WHILE_UNLOCKED()
Date: Tue,  5 Dec 2023 13:20:06 -0500
Message-ID: <20231205182011.1976568-10-stefanha@redhat.com>
In-Reply-To: <20231205182011.1976568-1-stefanha@redhat.com>
References: <20231205182011.1976568-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Now that the AioContext lock no longer exists, AIO_WAIT_WHILE() and
AIO_WAIT_WHILE_UNLOCKED() are equivalent.

A future patch will get rid of AIO_WAIT_WHILE_UNLOCKED().

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/block/aio-wait.h | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/include/block/aio-wait.h b/include/block/aio-wait.h
index 5449b6d742..157f105916 100644
--- a/include/block/aio-wait.h
+++ b/include/block/aio-wait.h
@@ -63,9 +63,6 @@ extern AioWait global_aio_wait;
  * @ctx: the aio context, or NULL if multiple aio contexts (for which the
  *       caller does not hold a lock) are involved in the polling condition.
  * @cond: wait while this conditional expression is true
- * @unlock: whether to unlock and then lock again @ctx. This applies
- * only when waiting for another AioContext from the main loop.
- * Otherwise it's ignored.
  *
  * Wait while a condition is true.  Use this to implement synchronous
  * operations that require event loop activity.
@@ -78,7 +75,7 @@ extern AioWait global_aio_wait;
  * wait on conditions between two IOThreads since that could lead to deadlock,
  * go via the main loop instead.
  */
-#define AIO_WAIT_WHILE_INTERNAL(ctx, cond, unlock) ({              \
+#define AIO_WAIT_WHILE_INTERNAL(ctx, cond) ({                      \
     bool waited_ = false;                                          \
     AioWait *wait_ = &global_aio_wait;                             \
     AioContext *ctx_ = (ctx);                                      \
@@ -95,13 +92,7 @@ extern AioWait global_aio_wait;
         assert(qemu_get_current_aio_context() ==                   \
                qemu_get_aio_context());                            \
         while ((cond)) {                                           \
-            if (unlock && ctx_) {                                  \
-                aio_context_release(ctx_);                         \
-            }                                                      \
             aio_poll(qemu_get_aio_context(), true);                \
-            if (unlock && ctx_) {                                  \
-                aio_context_acquire(ctx_);                         \
-            }                                                      \
             waited_ = true;                                        \
         }                                                          \
     }                                                              \
@@ -109,10 +100,11 @@ extern AioWait global_aio_wait;
     waited_; })
 
 #define AIO_WAIT_WHILE(ctx, cond)                                  \
-    AIO_WAIT_WHILE_INTERNAL(ctx, cond, true)
+    AIO_WAIT_WHILE_INTERNAL(ctx, cond)
 
+/* TODO replace this with AIO_WAIT_WHILE() in a future patch */
 #define AIO_WAIT_WHILE_UNLOCKED(ctx, cond)                         \
-    AIO_WAIT_WHILE_INTERNAL(ctx, cond, false)
+    AIO_WAIT_WHILE_INTERNAL(ctx, cond)
 
 /**
  * aio_wait_kick:
-- 
2.43.0


