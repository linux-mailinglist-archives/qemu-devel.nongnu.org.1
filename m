Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F01E7169E2
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 18:40:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q42Ip-0001vw-8L; Tue, 30 May 2023 12:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42Hk-0006xX-0q
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:33:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42Hg-0008VV-W9
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685464400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ORMxaB7LiQ5yr4u/kXEFuDR+l8a9PEdRdpdItmlyfqA=;
 b=Rhceda1wHG7cxHCaJP9SB7KcUc/d9gkT6VTp29Bhq8dHpEq4p5I3K90clf2E95IdIgg5yu
 Ap7bBT8h54DQteQr3109HLex/fChEFGgWG4F+/W0IBysg1z94ut6kRE1eYv+6dMbO50cGr
 DBjf6vV+B2vtWLlGtyt9bMnbr88bEGA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-BYaT7_HHM0Ku1BseVcYsTA-1; Tue, 30 May 2023 12:33:16 -0400
X-MC-Unique: BYaT7_HHM0Ku1BseVcYsTA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 721B2811E8F;
 Tue, 30 May 2023 16:33:16 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B9AE1C154D2;
 Tue, 30 May 2023 16:33:15 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 31/32] virtio: do not set is_external=true on host notifiers
Date: Tue, 30 May 2023 18:32:38 +0200
Message-Id: <20230530163239.576632-32-kwolf@redhat.com>
In-Reply-To: <20230530163239.576632-1-kwolf@redhat.com>
References: <20230530163239.576632-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Host notifiers can now use is_external=false since virtio-blk and
virtio-scsi no longer rely on is_external=true for drained sections.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20230516190238.8401-20-stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/virtio/virtio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index cb09cb6464..08011be8dc 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3491,7 +3491,7 @@ static void virtio_queue_host_notifier_aio_poll_end(EventNotifier *n)
 
 void virtio_queue_aio_attach_host_notifier(VirtQueue *vq, AioContext *ctx)
 {
-    aio_set_event_notifier(ctx, &vq->host_notifier, true,
+    aio_set_event_notifier(ctx, &vq->host_notifier, false,
                            virtio_queue_host_notifier_read,
                            virtio_queue_host_notifier_aio_poll,
                            virtio_queue_host_notifier_aio_poll_ready);
@@ -3508,14 +3508,14 @@ void virtio_queue_aio_attach_host_notifier(VirtQueue *vq, AioContext *ctx)
  */
 void virtio_queue_aio_attach_host_notifier_no_poll(VirtQueue *vq, AioContext *ctx)
 {
-    aio_set_event_notifier(ctx, &vq->host_notifier, true,
+    aio_set_event_notifier(ctx, &vq->host_notifier, false,
                            virtio_queue_host_notifier_read,
                            NULL, NULL);
 }
 
 void virtio_queue_aio_detach_host_notifier(VirtQueue *vq, AioContext *ctx)
 {
-    aio_set_event_notifier(ctx, &vq->host_notifier, true, NULL, NULL, NULL);
+    aio_set_event_notifier(ctx, &vq->host_notifier, false, NULL, NULL, NULL);
 }
 
 void virtio_queue_host_notifier_read(EventNotifier *n)
-- 
2.40.1


