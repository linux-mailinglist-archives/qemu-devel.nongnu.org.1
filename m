Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F36447FE097
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 20:57:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8Qfi-0007L6-8X; Wed, 29 Nov 2023 14:56:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r8Qfg-0007KY-RH
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 14:56:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r8Qff-0004Na-4n
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 14:56:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701287790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LEy9EWuebl4CuFgfogaWwDt3UnxTDs2t+LuSpg8gM1k=;
 b=QIpFOEM3P+UcwlRS8PFadX67/n06mUI3wwBsyA+41zLZhFgbmON4Pj/jS6JA6dc6XfHOLu
 gsJQo+9PEPCTTIOD79+BEp+MZNDsTvvbS9qIOOwLO0OXT44Cvnt2WzP4doAebFJPr0cHrk
 1f4lS52OFLkIsh1D1hfzWsQTlMe8xm0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-z9E51FFMPQOGFuJl_yEIDg-1; Wed, 29 Nov 2023 14:56:26 -0500
X-MC-Unique: z9E51FFMPQOGFuJl_yEIDg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 569E8852ACC;
 Wed, 29 Nov 2023 19:56:25 +0000 (UTC)
Received: from localhost (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A6CB32026D66;
 Wed, 29 Nov 2023 19:56:23 +0000 (UTC)
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
Subject: [PATCH 09/12] docs: remove AioContext lock from IOThread docs
Date: Wed, 29 Nov 2023 14:55:50 -0500
Message-ID: <20231129195553.942921-10-stefanha@redhat.com>
In-Reply-To: <20231129195553.942921-1-stefanha@redhat.com>
References: <20231129195553.942921-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Encourage the use of locking primitives and stop mentioning the
AioContext lock since it is being removed.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
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
2.42.0


