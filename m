Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D43D7CB36A
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 21:41:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsTSE-0000lR-UO; Mon, 16 Oct 2023 15:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qsTSC-0000hF-HI
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 15:40:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qsTSA-0001Ek-Vb
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 15:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697485238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PivKdxk4mdurscq2RS5WTjojhH6Clx17UfNyr5URoOY=;
 b=Yu/5lpLsr4VDtCND3jb44sLEm5IFLJ/KweF7xHYMXiY8ngoxhi5hbZIB2vxtHUIBRNYt47
 hZYeYkaxvq6TQflUaiKzGiEzJXWc4K84gFWNGRUb6B1WSzSUFEf4ALPrTet0vW5TX34cEn
 i+BK8U+EL4gU9pKheO7l6fpJ61KmSu8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-wnvOC--6NkKPFQANr6ybEA-1; Mon, 16 Oct 2023 15:40:36 -0400
X-MC-Unique: wnvOC--6NkKPFQANr6ybEA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E348B801234;
 Mon, 16 Oct 2023 19:40:35 +0000 (UTC)
Received: from localhost (unknown [10.39.195.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 61057C15BBC;
 Mon, 16 Oct 2023 19:40:35 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, hujian <hu.jian@zte.com.cn>
Subject: [PULL 1/1] virtio-blk: don't start dataplane during the stop of
 dataplane
Date: Mon, 16 Oct 2023 15:40:28 -0400
Message-ID: <20231016194028.163610-2-stefanha@redhat.com>
In-Reply-To: <20231016194028.163610-1-stefanha@redhat.com>
References: <20231016194028.163610-1-stefanha@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: hujian <hu.jian@zte.com.cn>

During the stop of dataplane for virtio-blk, virtio_bus_cleanup_host_notifier() is be
called to clean up notifier at the end, if polled ioeventfd, virtio_blk_handle_output()
is used to handle io request. But due to s->dataplane_disabled is false, it will be
returned directly, which drops io request.
Backtrace:
->virtio_blk_data_plane_stop
  ->virtio_bus_cleanup_host_notifier
    ->virtio_queue_host_notifier_read
      ->virtio_queue_notify_vq
        ->vq->handle_output
          ->virtio_blk_handle_output
            ->if (s->dataplane  && !s->dataplane_stoped)
              ->if (!s->dataplane_disabled)
                ->return *
            ->virtio_blk_handle_output_do
The above problem can occur when using "virsh reset" cmdline to reset guest, while
guest does io.
To fix this problem, don't try to start dataplane if s->stopping is true, and io would
be handled by virtio_blk_handle_vq().

Signed-off-by: hujian <hu.jian@zte.com.cn>
Message-id: 202310111414266586398@zte.com.cn
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/virtio-blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 39e7f23fab..c2d59389cb 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1166,7 +1166,7 @@ static void virtio_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOBlock *s = (VirtIOBlock *)vdev;
 
-    if (s->dataplane && !s->dataplane_started) {
+    if (s->dataplane && !s->dataplane_started && !s->stopping) {
         /* Some guests kick before setting VIRTIO_CONFIG_S_DRIVER_OK so start
          * dataplane here instead of waiting for .set_status().
          */
-- 
2.41.0


