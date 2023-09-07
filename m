Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C872C797D82
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 22:42:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeLoY-0005fX-Hj; Thu, 07 Sep 2023 16:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeLoV-0005f1-MH
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 16:41:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeLoT-0003rV-8k
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 16:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694119275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ybf1H6iXeZeQZKgRYChD2TacS17EA9Fpdh4nrlBrTys=;
 b=ZJKn1B1k9vOjmKQyg45sJIXtHTEZILR2naXBhFDplMwgqd2jY6+Ugc0LeQ10KbQihgaZrH
 QUeHBz9I9dto75TbFMHpvtSwDayMmH3vdrcXYDYN2Y4DCEIpaUoLwNtcntCBlF/2VQVWPc
 gHkbQg6lbEqSQifZy4CRBhJUPYHyQgs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-ke15JoBEPlWKmh6HugczLQ-1; Thu, 07 Sep 2023 16:41:12 -0400
X-MC-Unique: ke15JoBEPlWKmh6HugczLQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2842C8E4EA0;
 Thu,  7 Sep 2023 20:41:12 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 69A55493110;
 Thu,  7 Sep 2023 20:41:10 +0000 (UTC)
Date: Thu, 7 Sep 2023 15:41:08 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Daniel Berrange <berrange@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Leonardo Bras <leobras@redhat.com>, farosas@suse.de, 
 Hanna Reitz <hreitz@redhat.com>, Juan Quintela <quintela@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 kwolf@redhat.com, 
 Coiby Xu <Coiby.Xu@gmail.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH v3 4/4] io: follow coroutine AioContext in
 qio_channel_yield()
Message-ID: <k34b7gfkxtjrhflgtqrbg23gthoa7x3o3hs2kwhqi3jdhphcio@aukpe23gjewv>
References: <20230830224802.493686-1-stefanha@redhat.com>
 <20230830224802.493686-5-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230830224802.493686-5-stefanha@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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

On Wed, Aug 30, 2023 at 06:48:02PM -0400, Stefan Hajnoczi wrote:
> The ongoing QEMU multi-queue block layer effort makes it possible for multiple
> threads to process I/O in parallel. The nbd block driver is not compatible with
> the multi-queue block layer yet because QIOChannel cannot be used easily from
> coroutines running in multiple threads. This series changes the QIOChannel API
> to make that possible.
> 
...
> 
> This API change allows the nbd block driver to use QIOChannel from any thread.
> It's important to keep in mind that the block driver already synchronizes
> QIOChannel access and ensures that two coroutines never read simultaneously or
> write simultaneously.
> 
> This patch updates all users of qio_channel_attach_aio_context() to the
> new API. Most conversions are simple, but vhost-user-server requires a
> new qemu_coroutine_yield() call to quiesce the vu_client_trip()
> coroutine when not attached to any AioContext.
> 
> While the API is has become simpler, there is one wart: QIOChannel has a
> special case for the iohandler AioContext (used for handlers that must not run
> in nested event loops). I didn't find an elegant way preserve that behavior, so
> I added a new API called qio_channel_set_follow_coroutine_ctx(ioc, true|false)
> for opting in to the new AioContext model. By default QIOChannel uses the
> iohandler AioHandler. Code that formerly called
> qio_channel_attach_aio_context() now calls
> qio_channel_set_follow_coroutine_ctx(ioc, true) once after the QIOChannel is
> created.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Acked-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  include/io/channel-util.h        |  23 ++++++
>  include/io/channel.h             |  69 ++++++++----------
>  include/qemu/vhost-user-server.h |   1 +
>  block/nbd.c                      |  11 +--
>  io/channel-command.c             |  10 ++-
>  io/channel-file.c                |   9 ++-
>  io/channel-null.c                |   3 +-
>  io/channel-socket.c              |   9 ++-
>  io/channel-tls.c                 |   6 +-
>  io/channel-util.c                |  24 +++++++
>  io/channel.c                     | 120 ++++++++++++++++++++++---------
>  migration/channel-block.c        |   3 +-
>  nbd/server.c                     |  14 +---
>  scsi/qemu-pr-helper.c            |   4 +-
>  util/vhost-user-server.c         |  27 +++++--
>  15 files changed, 216 insertions(+), 117 deletions(-)

Looks like migration/rdma.c is also impacted:

../migration/rdma.c: In function ‘qio_channel_rdma_class_init’:
../migration/rdma.c:4037:38: error: assignment to ‘void (*)(QIOChannel *, AioContext *, void (*)(void *), AioContext *, void (*)(void *), void *)’ from incompatible pointer type ‘void (*)(QIOChannel *, AioContext *, void (*)(void *), void (*)(void *), void *)’ [-Werror=incompatible-pointer-types]
 4037 |     ioc_klass->io_set_aio_fd_handler = qio_channel_rdma_set_aio_fd_handler;
      |                                      ^

I'm squashing this in:

diff --git i/migration/rdma.c w/migration/rdma.c
index ca430d319d9..a2a3db35b1d 100644
--- i/migration/rdma.c
+++ w/migration/rdma.c
@@ -3103,22 +3103,23 @@ static GSource *qio_channel_rdma_create_watch(QIOChannel *ioc,
 }

 static void qio_channel_rdma_set_aio_fd_handler(QIOChannel *ioc,
-                                                  AioContext *ctx,
-                                                  IOHandler *io_read,
-                                                  IOHandler *io_write,
-                                                  void *opaque)
+                                                AioContext *read_ctx,
+                                                IOHandler *io_read,
+                                                AioContext *write_ctx,
+                                                IOHandler *io_write,
+                                                void *opaque)
 {
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
     if (io_read) {
-        aio_set_fd_handler(ctx, rioc->rdmain->recv_comp_channel->fd, io_read,
-                           io_write, NULL, NULL, opaque);
-        aio_set_fd_handler(ctx, rioc->rdmain->send_comp_channel->fd, io_read,
-                           io_write, NULL, NULL, opaque);
+        aio_set_fd_handler(read_ctx, rioc->rdmain->recv_comp_channel->fd,
+                           io_read, io_write, NULL, NULL, opaque);
+        aio_set_fd_handler(read_ctx, rioc->rdmain->send_comp_channel->fd,
+                           io_read, io_write, NULL, NULL, opaque);
     } else {
-        aio_set_fd_handler(ctx, rioc->rdmaout->recv_comp_channel->fd, io_read,
-                           io_write, NULL, NULL, opaque);
-        aio_set_fd_handler(ctx, rioc->rdmaout->send_comp_channel->fd, io_read,
-                           io_write, NULL, NULL, opaque);
+        aio_set_fd_handler(write_ctx, rioc->rdmaout->recv_comp_channel->fd,
+                           io_read, io_write, NULL, NULL, opaque);
+        aio_set_fd_handler(write_ctx, rioc->rdmaout->send_comp_channel->fd,
+                           io_read, io_write, NULL, NULL, opaque);
     }
 }



-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


