Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CE07FE098
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 20:57:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8QfY-00072l-Cb; Wed, 29 Nov 2023 14:56:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r8QfL-0006wG-SV
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 14:56:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r8QfK-0004HV-6g
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 14:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701287768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aS2QKCjvSUaDgBLp5BpYBu5ELqUNynQgUkZ8pGmrnOA=;
 b=PkczHfrzBWmQuzJGedWZd53LHhHi3jf8PdjtMTrPqN/CNxgTNh7ZSXqkqEETi4WIOE0k/d
 EPxoRgLEtGnjw22GwN0wxh68q4dpva4ypKt4rVZfrhncM9ZJRZXsjKhjIZa5oVD4WpeE+Q
 Zui5Ty3ln5q/9hdXj06cIeFxIFzLeTY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-cCc6c86vMTanlI7Lk6yCzA-1; Wed, 29 Nov 2023 14:56:04 -0500
X-MC-Unique: cCc6c86vMTanlI7Lk6yCzA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 54B1D85A5B5;
 Wed, 29 Nov 2023 19:56:03 +0000 (UTC)
Received: from localhost (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 945FCC15881;
 Wed, 29 Nov 2023 19:56:02 +0000 (UTC)
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
Subject: [PATCH 02/12] tests: remove aio_context_acquire() tests
Date: Wed, 29 Nov 2023 14:55:43 -0500
Message-ID: <20231129195553.942921-3-stefanha@redhat.com>
In-Reply-To: <20231129195553.942921-1-stefanha@redhat.com>
References: <20231129195553.942921-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The aio_context_acquire() API is being removed. Drop the test case that
calls the API.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/unit/test-aio.c | 67 +------------------------------------------
 1 file changed, 1 insertion(+), 66 deletions(-)

diff --git a/tests/unit/test-aio.c b/tests/unit/test-aio.c
index 337b6e4ea7..e77d86be87 100644
--- a/tests/unit/test-aio.c
+++ b/tests/unit/test-aio.c
@@ -100,76 +100,12 @@ static void event_ready_cb(EventNotifier *e)
 
 /* Tests using aio_*.  */
 
-typedef struct {
-    QemuMutex start_lock;
-    EventNotifier notifier;
-    bool thread_acquired;
-} AcquireTestData;
-
-static void *test_acquire_thread(void *opaque)
-{
-    AcquireTestData *data = opaque;
-
-    /* Wait for other thread to let us start */
-    qemu_mutex_lock(&data->start_lock);
-    qemu_mutex_unlock(&data->start_lock);
-
-    /* event_notifier_set might be called either before or after
-     * the main thread's call to poll().  The test case's outcome
-     * should be the same in either case.
-     */
-    event_notifier_set(&data->notifier);
-    aio_context_acquire(ctx);
-    aio_context_release(ctx);
-
-    data->thread_acquired = true; /* success, we got here */
-
-    return NULL;
-}
-
 static void set_event_notifier(AioContext *nctx, EventNotifier *notifier,
                                EventNotifierHandler *handler)
 {
     aio_set_event_notifier(nctx, notifier, handler, NULL, NULL);
 }
 
-static void dummy_notifier_read(EventNotifier *n)
-{
-    event_notifier_test_and_clear(n);
-}
-
-static void test_acquire(void)
-{
-    QemuThread thread;
-    AcquireTestData data;
-
-    /* Dummy event notifier ensures aio_poll() will block */
-    event_notifier_init(&data.notifier, false);
-    set_event_notifier(ctx, &data.notifier, dummy_notifier_read);
-    g_assert(!aio_poll(ctx, false)); /* consume aio_notify() */
-
-    qemu_mutex_init(&data.start_lock);
-    qemu_mutex_lock(&data.start_lock);
-    data.thread_acquired = false;
-
-    qemu_thread_create(&thread, "test_acquire_thread",
-                       test_acquire_thread,
-                       &data, QEMU_THREAD_JOINABLE);
-
-    /* Block in aio_poll(), let other thread kick us and acquire context */
-    aio_context_acquire(ctx);
-    qemu_mutex_unlock(&data.start_lock); /* let the thread run */
-    g_assert(aio_poll(ctx, true));
-    g_assert(!data.thread_acquired);
-    aio_context_release(ctx);
-
-    qemu_thread_join(&thread);
-    set_event_notifier(ctx, &data.notifier, NULL);
-    event_notifier_cleanup(&data.notifier);
-
-    g_assert(data.thread_acquired);
-}
-
 static void test_bh_schedule(void)
 {
     BHTestData data = { .n = 0 };
@@ -879,7 +815,7 @@ static void test_worker_thread_co_enter(void)
     qemu_thread_get_self(&this_thread);
     co = qemu_coroutine_create(co_check_current_thread, &this_thread);
 
-    qemu_thread_create(&worker_thread, "test_acquire_thread",
+    qemu_thread_create(&worker_thread, "test_aio_co_enter",
                        test_aio_co_enter,
                        co, QEMU_THREAD_JOINABLE);
 
@@ -899,7 +835,6 @@ int main(int argc, char **argv)
     while (g_main_context_iteration(NULL, false));
 
     g_test_init(&argc, &argv, NULL);
-    g_test_add_func("/aio/acquire",                 test_acquire);
     g_test_add_func("/aio/bh/schedule",             test_bh_schedule);
     g_test_add_func("/aio/bh/schedule10",           test_bh_schedule10);
     g_test_add_func("/aio/bh/cancel",               test_bh_cancel);
-- 
2.42.0


