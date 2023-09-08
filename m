Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCF4798047
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 03:38:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeQPv-0008PR-Kd; Thu, 07 Sep 2023 21:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeQPt-0008Ox-Kh
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 21:36:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeQPr-0007sA-1i
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 21:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694136968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0ArZMu5d6y5RkQV0ItdAL9Kk+zXxPA+nAD966084RgE=;
 b=GiFWV6SEIK0ev2JDWHus5UtEDX7HDTSD+cI0PBtfJjjZk34GmLGk5YLp+QYqepMKtH8Vqm
 /DN2Zrjq44t/x9Tiu0VLw0Dc/Web1woqtUIEc2EiewlEkF5V81cCIpZA+Ucm4OLcf4Haym
 u34T67If3Czt2Do+Yrjj9b5OtcH2xfo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-weIEVrSuPledMNlsytISKQ-1; Thu, 07 Sep 2023 21:36:06 -0400
X-MC-Unique: weIEVrSuPledMNlsytISKQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D5AA81652A
 for <qemu-devel@nongnu.org>; Fri,  8 Sep 2023 01:36:06 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 59A2D40C2070
 for <qemu-devel@nongnu.org>; Fri,  8 Sep 2023 01:36:06 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/13] NBD patches through 2023-09-07
Date: Thu,  7 Sep 2023 20:35:36 -0500
Message-ID: <20230908013535.990731-15-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 03a3a62fbd0aa5227e978eef3c67d3978aec9e5f:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2023-09-07 10:29:06 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2023-09-07

for you to fetch changes up to 737ff1b137b7ce1d613c3851e0efaae9b820dbc0:

  qemu-nbd: document -v behavior in respect to --fork in man (2023-09-07 20:32:11 -0500)

----------------------------------------------------------------
NBD patches for 2023-09-07

- Andrey Drobyshev - fix regression in iotest 197 under -nbd
- Stefan Hajnoczi - allow coroutine read and write context to split
across threads
- Philippe Mathieu-Daudé - remove a VLA allocation
- Denis V. Lunev - fix regression in iotest 233 with qemu-nbd -v --fork

----------------------------------------------------------------
Andrey Drobyshev (1):
      qemu-iotests/197: use more generic commands for formats other than qcow2

Denis V. Lunev (7):
      qemu-nbd: improve error message for dup2 error
      qemu-nbd: define struct NbdClientOpts when HAVE_NBD_DEVICE is not defined
      qemu-nbd: move srcpath into struct NbdClientOpts
      qemu-nbd: put saddr into into struct NbdClientOpts
      qemu-nbd: invent nbd_client_release_pipe() helper
      qemu-nbd: Restore "qemu-nbd -v --fork" output
      qemu-nbd: document -v behavior in respect to --fork in man

Philippe Mathieu-Daudé (1):
      util/iov: Avoid dynamic stack allocation

Stefan Hajnoczi (4):
      nbd: drop unused nbd_receive_negotiate() aio_context argument
      nbd: drop unused nbd_start_negotiate() aio_context argument
      io: check there are no qio_channel_yield() coroutines during ->finalize()
      io: follow coroutine AioContext in qio_channel_yield()

 docs/tools/qemu-nbd.rst          |   4 +-
 include/block/nbd.h              |   3 +-
 include/io/channel-util.h        |  23 +++++++
 include/io/channel.h             |  69 +++++++++-----------
 include/qemu/vhost-user-server.h |   1 +
 block/nbd.c                      |  11 +---
 io/channel-command.c             |  10 ++-
 io/channel-file.c                |   9 ++-
 io/channel-null.c                |   3 +-
 io/channel-socket.c              |   9 ++-
 io/channel-tls.c                 |   6 +-
 io/channel-util.c                |  24 +++++++
 io/channel.c                     | 124 ++++++++++++++++++++++++++----------
 migration/channel-block.c        |   3 +-
 migration/rdma.c                 |  25 ++++----
 nbd/client-connection.c          |   3 +-
 nbd/client.c                     |  14 ++---
 nbd/server.c                     |  14 +----
 qemu-nbd.c                       | 133 +++++++++++++++++++++------------------
 scsi/qemu-pr-helper.c            |   4 +-
 util/iov.c                       |   2 +-
 util/vhost-user-server.c         |  27 +++++---
 tests/qemu-iotests/197           |   8 +--
 tests/qemu-iotests/197.out       |  18 +++---
 24 files changed, 328 insertions(+), 219 deletions(-)

-- 
2.41.0


