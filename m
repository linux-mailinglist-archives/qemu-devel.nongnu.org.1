Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B528812088
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 22:17:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDWaD-0005OH-JQ; Wed, 13 Dec 2023 16:15:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rDWaA-0005Ml-QP
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 16:15:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rDWa7-0004w7-P4
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 16:15:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702502150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Z3mfsB+g0UESdfvtFV3G9r7JZ6MKqPAQAnsgAco710E=;
 b=HSVxdWXb7V7rEvAuZ7IGP07SrImGPaFd6Arp8RbEcPJFKmepm8DmT5YXUZ7l9QbdtJRwgt
 /6u54DVOvQG6OXAfnwtCnKi03hu4SQAhAO4kslssYiOTU7u9vMNaCV8iuw04aD5UPUKEUR
 P/4QhLJSt6PtPm8Rqap7trn7KRW2clw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-3lXHFd4DPF62kj6gQAEggw-1; Wed, 13 Dec 2023 16:15:48 -0500
X-MC-Unique: 3lXHFd4DPF62kj6gQAEggw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7C08185A781;
 Wed, 13 Dec 2023 21:15:47 +0000 (UTC)
Received: from localhost (unknown [10.39.195.82])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 860C5492BC6;
 Wed, 13 Dec 2023 21:15:46 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, pbonzini@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Fiona Ebner <f.ebner@proxmox.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC 0/3] aio-posix: call ->poll_end() when removing AioHandler
Date: Wed, 13 Dec 2023 16:15:41 -0500
Message-ID: <20231213211544.1601971-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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

Hanna and Fiona encountered a bug in aio_set_fd_handler(): there is no matching
io_poll_end() call upon removing an AioHandler when io_poll_begin() was
previously called. The missing io_poll_end() call leaves virtqueue
notifications disabled and the virtqueue's ioeventfd will never become
readable anymore.

The details of how virtio-scsi devices using IOThreads can hang after
hotplug/unplug are covered here:
https://issues.redhat.com/browse/RHEL-3934

Hanna is currently away over the December holidays. I'm sending these RFC
patches in the meantime. They demonstrate running aio_set_fd_handler() in the
AioContext home thread and adding the missing io_poll_end() call.

The downside to my approach is that aio_set_fd_handler() becomes a
synchronization point that waits for the remote AioContext thread to finish
running a BH. Synchronization points are prone to deadlocks if the caller
invokes them while holding a lock that the remote AioContext needs to make
progress or if the remote AioContext cannot make progress before we make
progress in our own event loop. To minimize these concerns I have based this
patch series on my AioContext lock removal series and only allow the main loop
thread to call aio_set_fd_handler() on other threads (which I think is already
the convention today).

Another concern is that aio_set_fd_handler() now invokes user-provided
io_poll_end(), io_poll(), and io_poll_ready() functions. The io_poll_ready()
callback might contain a nested aio_poll() call, so there is a new place where
nested event loops can occur and hence a new re-entrant code path that I
haven't thought about yet.

But there you have it. Please let me know what you think and try your
reproducers to see if this fixes the missing io_poll_end() issue. Thanks!

Alternatives welcome! (A cleaner version of this approach might be to forbid
cross-thread aio_set_fd_handler() calls and to refactor all
aio_set_fd_handler() callers so they come from the AioContext's home thread.
I'm starting to think that only the aio_notify() and aio_schedule_bh() APIs
should be thread-safe.)

Stefan Hajnoczi (3):
  aio-posix: run aio_set_fd_handler() in target AioContext
  aio: use counter instead of ctx->list_lock
  aio-posix: call ->poll_end() when removing AioHandler

 include/block/aio.h |  22 ++---
 util/aio-posix.c    | 197 ++++++++++++++++++++++++++++++++------------
 util/async.c        |   2 -
 util/fdmon-epoll.c  |   6 +-
 4 files changed, 152 insertions(+), 75 deletions(-)

-- 
2.43.0


