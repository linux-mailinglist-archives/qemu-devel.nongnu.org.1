Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2E878C956
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 18:08:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb1Eg-00077h-4N; Tue, 29 Aug 2023 12:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qb1Ed-00076v-UE
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:06:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qb1Eb-0002dn-7D
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693325188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wCGmh4cWubafe7dBtG1mtE4hH3rT62Pk/6eZcpMuo00=;
 b=GvCex75UXIEQV2bdROghm8QPYspJ7wC4lMLTKR5XGZ8DXpJBfvk4KBP8Lp+YaVjgMVIEoH
 IM5c1QfJGJ3nd5qv8n9D9kdWfKdcQPXUiOqXj0vrQjGftSjOqo0ZywAIXEF+IBd4KPLqbv
 /hYUgEVSvVIYD/koOASTo55AQYhO4bM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-Vx_oGcejMOebTJNX8M2r5g-1; Tue, 29 Aug 2023 12:06:26 -0400
X-MC-Unique: Vx_oGcejMOebTJNX8M2r5g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ECC7880602D;
 Tue, 29 Aug 2023 16:06:25 +0000 (UTC)
Received: from localhost (unknown [10.39.195.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 90850140E950;
 Tue, 29 Aug 2023 16:06:24 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>, eblake@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 farosas@suse.de, kwolf@redhat.com, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org,
 Coiby Xu <Coiby.Xu@gmail.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 0/4] io: follow coroutine AioContext in qio_channel_yield()
Date: Tue, 29 Aug 2023 12:06:18 -0400
Message-ID: <20230829160623.277411-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

v2:
- Add Patch 1 & 2 to remove unused NBD aio_context arguments and dead code [Fabiano]
- Remove attach/detach prototypes from "io/channel.h" [Daniel]
- Add utility function to set fd handlers [Daniel]

The ongoing QEMU multi-queue block layer effort makes it possible for multiple
threads to process I/O in parallel. The nbd block driver is not compatible with
the multi-queue block layer yet because QIOChannel cannot be used easily from
coroutines running in multiple threads. This series changes the QIOChannel API
to make that possible.

Stefan Hajnoczi (4):
  nbd: drop unused nbd_receive_negotiate() aio_context argument
  nbd: drop unused nbd_start_negotiate() aio_context argument
  io: check there are no qio_channel_yield() coroutines during
    ->finalize()
  io: follow coroutine AioContext in qio_channel_yield()

 include/block/nbd.h              |   3 +-
 include/io/channel-util.h        |  23 ++++++
 include/io/channel.h             |  69 ++++++++---------
 include/qemu/vhost-user-server.h |   1 +
 block/nbd.c                      |  11 +--
 io/channel-command.c             |  10 ++-
 io/channel-file.c                |   9 ++-
 io/channel-null.c                |   3 +-
 io/channel-socket.c              |   9 ++-
 io/channel-tls.c                 |   6 +-
 io/channel-util.c                |  24 ++++++
 io/channel.c                     | 124 ++++++++++++++++++++++---------
 migration/channel-block.c        |   3 +-
 nbd/client-connection.c          |   3 +-
 nbd/client.c                     |  14 +---
 nbd/server.c                     |  14 +---
 qemu-nbd.c                       |   4 +-
 scsi/qemu-pr-helper.c            |   4 +-
 util/vhost-user-server.c         |  27 +++++--
 19 files changed, 228 insertions(+), 133 deletions(-)

-- 
2.41.0


