Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BC7832EB8
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 19:15:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQtNa-0001on-49; Fri, 19 Jan 2024 13:14:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQtNY-0001oO-8L
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 13:14:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQtNW-0007jq-DO
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 13:14:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705688045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8S/6JmKhF1sJKzjwL9n1KQwB67QmH+PBjRC6YVJgQIk=;
 b=O8YJzDOIZNLuq9Mdj4XzsD4c/k9wrOSC/ClVIVXeceBNx0eJVXx6wFIT9vlC5eAQ/OEmez
 ouGnZzL+Hsyz/RfodBcachKwr8xQDM+GeL7LNd3KGEqYb6a07d+x6W9/1r9yyjjRMSUWj8
 hfa2ZEFWAdlBKBm3ybYQitjYfeP0J7o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-HC7_So04N7qJ8bJyOMWNZw-1; Fri, 19 Jan 2024 13:13:59 -0500
X-MC-Unique: HC7_So04N7qJ8bJyOMWNZw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04A02185A784;
 Fri, 19 Jan 2024 18:13:44 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A887900;
 Fri, 19 Jan 2024 18:13:43 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 13/14] virtio-blk: always set ioeventfd during startup
Date: Fri, 19 Jan 2024 19:13:26 +0100
Message-ID: <20240119181327.236745-14-kwolf@redhat.com>
In-Reply-To: <20240119181327.236745-1-kwolf@redhat.com>
References: <20240119181327.236745-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
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
Message-ID: <20240119135748.270944-7-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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


