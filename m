Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBC4832AE3
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 15:01:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQpOI-0004pJ-Im; Fri, 19 Jan 2024 08:58:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rQpOF-0004bu-5R
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 08:58:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rQpOC-0000cQ-SG
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 08:58:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705672711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U7t+48tpry5FxJ8YbbmZC6mHpaAUgCVAoEt9nom/U1A=;
 b=TZ5eWUUMuc5rA5hecor8cgA/qqez65eUZYXVpjG4at14vl7EJzzZI19j5bK4SCIEQJWPgp
 CqAJveB3BMqV2/cquxZIbI4CUtMDyhe48QITxL6aSPwkfZEGWWEr6GW9UCrXy6xF5+6t0z
 GQ/sB6U1C9ese3ed1IhemG9IY8DzPO8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-zTJa3cbvOqiF8fMNTfZ45g-1; Fri, 19 Jan 2024 08:58:28 -0500
X-MC-Unique: zTJa3cbvOqiF8fMNTfZ45g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E178101A526;
 Fri, 19 Jan 2024 13:58:28 +0000 (UTC)
Received: from localhost (unknown [10.39.195.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 77D39492BC6;
 Fri, 19 Jan 2024 13:58:27 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/6] virtio-blk: always set ioeventfd during startup
Date: Fri, 19 Jan 2024 08:57:48 -0500
Message-ID: <20240119135748.270944-7-stefanha@redhat.com>
In-Reply-To: <20240119135748.270944-1-stefanha@redhat.com>
References: <20240119135748.270944-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
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

When starting ioeventfd it is common practice to set the event notifier
so that the ioeventfd handler is triggered to run immediately. There may
be no requests waiting to be processed, but the idea is that if a
request snuck in then we guarantee that it will be detected.

One scenario where self-triggering the ioeventfd is necessary is when
virtio_blk_handle_output() is called from a vCPU thread before the
VIRTIO Device Status transitions to DRIVER_OK. In that case we need to
self-trigger the ioeventfd so that the kick handled by the vCPU thread
causes the vq AioContext thread to take over handling the request(s).

Fixes: b6948ab01df0 ("virtio-blk: add iothread-vq-mapping parameter")
Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/virtio-blk.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 73248d15c8..227d83569f 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1809,14 +1809,14 @@ static int virtio_blk_start_ioeventfd(VirtIODevice *vdev)
     smp_wmb(); /* paired with aio_notify_accept() on the read side */
 
     /* Get this show started by hooking up our callbacks */
-    if (!blk_in_drain(s->conf.conf.blk)) {
-        for (i = 0; i < nvqs; i++) {
-            VirtQueue *vq = virtio_get_queue(vdev, i);
-            AioContext *ctx = s->vq_aio_context[i];
+    for (i = 0; i < nvqs; i++) {
+        VirtQueue *vq = virtio_get_queue(vdev, i);
+        AioContext *ctx = s->vq_aio_context[i];
 
-            /* Kick right away to begin processing requests already in vring */
-            event_notifier_set(virtio_queue_get_host_notifier(vq));
+        /* Kick right away to begin processing requests already in vring */
+        event_notifier_set(virtio_queue_get_host_notifier(vq));
 
+        if (!blk_in_drain(s->conf.conf.blk)) {
             virtio_queue_aio_attach_host_notifier(vq, ctx);
         }
     }
-- 
2.43.0


