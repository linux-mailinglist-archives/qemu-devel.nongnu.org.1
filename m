Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2E3765D05
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 22:13:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP7Ag-0000ep-Sg; Thu, 27 Jul 2023 16:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qP7Ac-0000db-7m
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 16:01:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qP7AZ-0002fl-Sh
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 16:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690488066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EJCKaXx2reEQv2jkA9KLDOTxJPVAu6k6sc0PzTJpPbY=;
 b=DX0aa1lnfzXhjS1gLJlk5rnF+FzwcLVO3MuMEQp11bEUvzPTvc+bKgGxNf4U2bAS3vIQgE
 O4DtacGRQ5Zq7hh3XQWoRxnOCmYmN3OUADIe2OhPxBOvqNC0/cOWOnzMQ92LRwwvlFtSZX
 9yvkYGpZ2ZuY4E1AHvZVOgDbKy/SFLY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-2a7PcnEoON6gcp39mIFEkQ-1; Thu, 27 Jul 2023 16:01:04 -0400
X-MC-Unique: 2a7PcnEoON6gcp39mIFEkQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B4878802A7D;
 Thu, 27 Jul 2023 20:01:03 +0000 (UTC)
Received: from localhost (unknown [10.39.193.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 207CB1454147;
 Thu, 27 Jul 2023 20:01:02 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Richard Henderson <rth@twiddle.net>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL for-8.1 1/8] block/blkio: enable the completion eventfd
Date: Thu, 27 Jul 2023 16:00:51 -0400
Message-ID: <20230727200058.1071776-2-stefanha@redhat.com>
In-Reply-To: <20230727200058.1071776-1-stefanha@redhat.com>
References: <20230727200058.1071776-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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

From: Stefano Garzarella <sgarzare@redhat.com>

Until libblkio 1.3.0, virtio-blk drivers had completion eventfd
notifications enabled from the start, but from the next releases
this is no longer the case, so we have to explicitly enable them.

In fact, the libblkio documentation says they could be disabled,
so we should always enable them at the start if we want to be
sure to get completion eventfd notifications:

    By default, the driver might not generate completion events for
    requests so it is necessary to explicitly enable the completion
    file descriptor before use:

    void blkioq_set_completion_fd_enabled(struct blkioq *q, bool enable);

I discovered this while trying a development version of libblkio:
the guest kernel hangs during boot, while probing the device.

Fixes: fd66dbd424f5 ("blkio: add libblkio block driver")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-id: 20230725103744.77343-1-sgarzare@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/blkio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blkio.c b/block/blkio.c
index 1798648134..bc1fac48b7 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -845,6 +845,7 @@ static int blkio_file_open(BlockDriverState *bs, QDict *options, int flags,
     QLIST_INIT(&s->bounce_bufs);
     s->blkioq = blkio_get_queue(s->blkio, 0);
     s->completion_fd = blkioq_get_completion_fd(s->blkioq);
+    blkioq_set_completion_fd_enabled(s->blkioq, true);
 
     blkio_attach_aio_context(bs, bdrv_get_aio_context(bs));
     return 0;
-- 
2.41.0


