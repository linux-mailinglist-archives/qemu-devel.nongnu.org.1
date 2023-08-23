Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AA6786413
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 01:46:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYxXP-0004Iy-F1; Wed, 23 Aug 2023 19:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYxXG-0004H1-Ux
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 19:45:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYxXD-00029F-25
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 19:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692834310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xUFxhWgq71Sj/Pka8VdMB9md2RLMNY/aWGaqhLQ8abg=;
 b=CHxFcrxSHK11B3V8+KP7t3Tk5QQJj7FhJnA53um87T07huR5thuUdWERL+Gq8BeGggI+hU
 KhaulbvdGDMAJOCOnslIxIW5flyQuQ7t4wrP6sXMvvgWeYLvs7KmMX1wDGWlh3hdLMtXf9
 19CuyHHVDdOZbGChgALqXiiRNnngz0c=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-362-TqgIZ4ILOnaIfKCRJMqR6Q-1; Wed, 23 Aug 2023 19:45:07 -0400
X-MC-Unique: TqgIZ4ILOnaIfKCRJMqR6Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7661A3C025C0;
 Wed, 23 Aug 2023 23:45:06 +0000 (UTC)
Received: from localhost (unknown [10.39.192.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C42A540C6E8A;
 Wed, 23 Aug 2023 23:45:05 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, kwolf@redhat.com,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Daniel Berrange <berrange@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Leonardo Bras <leobras@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Peter Xu <peterx@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 0/2] io: follow coroutine AioContext in qio_channel_yield()
Date: Wed, 23 Aug 2023 19:45:02 -0400
Message-ID: <20230823234504.1387239-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The ongoing QEMU multi-queue block layer effort makes it possible for multiple
threads to process I/O in parallel. The nbd block driver is not compatible with
the multi-queue block layer yet because QIOChannel cannot be used easily from
coroutines running in multiple threads. This series changes the QIOChannel API
to make that possible.

Stefan Hajnoczi (2):
  io: check there are no qio_channel_yield() coroutines during
    ->finalize()
  io: follow coroutine AioContext in qio_channel_yield()

 include/io/channel.h             |  34 ++++++++-
 include/qemu/vhost-user-server.h |   1 +
 block/nbd.c                      |  11 +--
 io/channel-command.c             |  13 +++-
 io/channel-file.c                |  18 ++++-
 io/channel-null.c                |   3 +-
 io/channel-socket.c              |  18 ++++-
 io/channel-tls.c                 |   6 +-
 io/channel.c                     | 124 ++++++++++++++++++++++---------
 migration/channel-block.c        |   3 +-
 nbd/client.c                     |   2 +-
 nbd/server.c                     |  14 +---
 scsi/qemu-pr-helper.c            |   4 +-
 util/vhost-user-server.c         |  27 +++++--
 14 files changed, 195 insertions(+), 83 deletions(-)

-- 
2.41.0


