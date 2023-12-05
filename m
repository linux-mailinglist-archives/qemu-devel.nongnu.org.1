Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB27805D3A
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 19:23:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAa4G-0002HP-Iu; Tue, 05 Dec 2023 13:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAa2b-0000HG-AP
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 13:21:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAa2O-0002oH-OH
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 13:21:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701800451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8/B7zc0XB6x72qbuhQc1b2o1g2AgjtE1qkTNJwgvUlY=;
 b=es5UEZFnLlnAER/WQ1VKxtnMjgIKwE0DDM1v837p1/n0jTVeKA0d+O2qZidblkg5bDK/Cp
 YQzVB2uaRoJMrqNPUZDCEBW2WJIQfYffuWr/E007pFDVIbAFlXRuWuphSZ7KE+h/L5yEK1
 b9GUUnFTleR5zaHMhZtyd/DWP7msn4g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-8BIN0AuQO9OJpRD2qHD49w-1; Tue,
 05 Dec 2023 13:20:46 -0500
X-MC-Unique: 8BIN0AuQO9OJpRD2qHD49w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 780813C2A1C1;
 Tue,  5 Dec 2023 18:20:45 +0000 (UTC)
Received: from localhost (unknown [10.39.194.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D5A7A40C6EB9;
 Tue,  5 Dec 2023 18:20:44 +0000 (UTC)
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
Subject: [PATCH v2 11/14] docs: remove AioContext lock from IOThread docs
Date: Tue,  5 Dec 2023 13:20:08 -0500
Message-ID: <20231205182011.1976568-12-stefanha@redhat.com>
In-Reply-To: <20231205182011.1976568-1-stefanha@redhat.com>
References: <20231205182011.1976568-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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

Encourage the use of locking primitives and stop mentioning the
AioContext lock since it is being removed.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 docs/devel/multiple-iothreads.txt | 45 +++++++++++--------------------
 1 file changed, 15 insertions(+), 30 deletions(-)

diff --git a/docs/devel/multiple-iothreads.txt b/docs/devel/multiple-iothreads.txt
index a3e949f6b3..4865196bde 100644
--- a/docs/devel/multiple-iothreads.txt
+++ b/docs/devel/multiple-iothreads.txt
@@ -88,27 +88,18 @@ loop, depending on which AioContext instance the caller passes in.
 
 How to synchronize with an IOThread
 -----------------------------------
-AioContext is not thread-safe so some rules must be followed when using file
-descriptors, event notifiers, timers, or BHs across threads:
+Variables that can be accessed by multiple threads require some form of
+synchronization such as qemu_mutex_lock(), rcu_read_lock(), etc.
 
-1. AioContext functions can always be called safely.  They handle their
-own locking internally.
-
-2. Other threads wishing to access the AioContext must use
-aio_context_acquire()/aio_context_release() for mutual exclusion.  Once the
-context is acquired no other thread can access it or run event loop iterations
-in this AioContext.
-
-Legacy code sometimes nests aio_context_acquire()/aio_context_release() calls.
-Do not use nesting anymore, it is incompatible with the BDRV_POLL_WHILE() macro
-used in the block layer and can lead to hangs.
-
-There is currently no lock ordering rule if a thread needs to acquire multiple
-AioContexts simultaneously.  Therefore, it is only safe for code holding the
-QEMU global mutex to acquire other AioContexts.
+AioContext functions like aio_set_fd_handler(), aio_set_event_notifier(),
+aio_bh_new(), and aio_timer_new() are thread-safe. They can be used to trigger
+activity in an IOThread.
 
 Side note: the best way to schedule a function call across threads is to call
-aio_bh_schedule_oneshot().  No acquire/release or locking is needed.
+aio_bh_schedule_oneshot().
+
+The main loop thread can wait synchronously for a condition using
+AIO_WAIT_WHILE().
 
 AioContext and the block layer
 ------------------------------
@@ -124,22 +115,16 @@ Block layer code must therefore expect to run in an IOThread and avoid using
 old APIs that implicitly use the main loop.  See the "How to program for
 IOThreads" above for information on how to do that.
 
-If main loop code such as a QMP function wishes to access a BlockDriverState
-it must first call aio_context_acquire(bdrv_get_aio_context(bs)) to ensure
-that callbacks in the IOThread do not run in parallel.
-
 Code running in the monitor typically needs to ensure that past
 requests from the guest are completed.  When a block device is running
 in an IOThread, the IOThread can also process requests from the guest
 (via ioeventfd).  To achieve both objects, wrap the code between
 bdrv_drained_begin() and bdrv_drained_end(), thus creating a "drained
-section".  The functions must be called between aio_context_acquire()
-and aio_context_release().  You can freely release and re-acquire the
-AioContext within a drained section.
+section".
 
-Long-running jobs (usually in the form of coroutines) are best scheduled in
-the BlockDriverState's AioContext to avoid the need to acquire/release around
-each bdrv_*() call.  The functions bdrv_add/remove_aio_context_notifier,
-or alternatively blk_add/remove_aio_context_notifier if you use BlockBackends,
-can be used to get a notification whenever bdrv_try_change_aio_context() moves a
+Long-running jobs (usually in the form of coroutines) are often scheduled in
+the BlockDriverState's AioContext.  The functions
+bdrv_add/remove_aio_context_notifier, or alternatively
+blk_add/remove_aio_context_notifier if you use BlockBackends, can be used to
+get a notification whenever bdrv_try_change_aio_context() moves a
 BlockDriverState to a different AioContext.
-- 
2.43.0


