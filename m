Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E567FE092
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 20:57:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8QfX-00071b-Kg; Wed, 29 Nov 2023 14:56:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r8QfO-0006yE-Gj
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 14:56:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r8QfN-0004If-51
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 14:56:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701287772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jC9wKpUncUXW/n39IkHJZO19bmqglRHH0XTJO58TB7M=;
 b=Lpi+SiAtSWuTmpoXJbO+6lSa4GnAe28qlTAsv5NXY9pQYLc/VNr4FfFmmd5TczqmcbL9Pj
 u6NkrkXTwaK1ZdF100ZhC9MqBs4EXOunQbxA3A96+XPXgEJecS8NSvF+HRQuGIe1sv8wti
 wH6uak60qFXHcqBiLjSsTPeFB8ke+m4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-8eQxkhYyPXOHpZ0VJZcoIw-1; Wed,
 29 Nov 2023 14:56:07 -0500
X-MC-Unique: 8eQxkhYyPXOHpZ0VJZcoIw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 18C2529AA2C8;
 Wed, 29 Nov 2023 19:56:06 +0000 (UTC)
Received: from localhost (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4111440C6EBA;
 Wed, 29 Nov 2023 19:56:04 +0000 (UTC)
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
Subject: [PATCH 03/12] aio: make aio_context_acquire()/aio_context_release() a
 no-op
Date: Wed, 29 Nov 2023 14:55:44 -0500
Message-ID: <20231129195553.942921-4-stefanha@redhat.com>
In-Reply-To: <20231129195553.942921-1-stefanha@redhat.com>
References: <20231129195553.942921-1-stefanha@redhat.com>
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
2.42.0


