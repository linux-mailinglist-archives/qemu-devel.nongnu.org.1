Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF4A78D5AE
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 13:51:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbJhr-0003Mo-TE; Wed, 30 Aug 2023 07:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qbJhp-0003JU-Gn
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 07:49:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qbJhn-0003fT-6e
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 07:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693396189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AX//IdUFUoXIjpJJxN5fZZc9DdiIB/g/VvUGBk1qmzI=;
 b=gYk82Wi81DMZa7RBEydeppZjMCgtUBIfcx8Lras8YRDaqHFFeEoHJPcI9WAkSiiQpo1e5c
 C70iErtMvt1VWqa+zOSV2CyJ0U9ahpP1N0kCD6XC39Qc3WL+YO80H41bhCL3QPlcHXtTbr
 +XgV6FMTx0OU12uH2tEcn/cWUA8mN8A=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-345-n05L58SfPtqQ-A7PgGn7nw-1; Wed, 30 Aug 2023 07:49:45 -0400
X-MC-Unique: n05L58SfPtqQ-A7PgGn7nw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 38C763C17142;
 Wed, 30 Aug 2023 11:49:45 +0000 (UTC)
Received: from localhost (unknown [10.39.193.236])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3FC7DC15BC0;
 Wed, 30 Aug 2023 11:49:44 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jeuk Kim <jeuk20.kim@samsung.com>, qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Leonardo Bras <leobras@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PULL v3 0/5] Block patches
Date: Wed, 30 Aug 2023 07:49:37 -0400
Message-ID: <20230830114942.449060-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

The following changes since commit 813bac3d8d70d85cb7835f7945eb9eed84c2d8d0:

  Merge tag '2023q3-bsd-user-pull-request' of https://gitlab.com/bsdimp/qemu into staging (2023-08-29 08:58:00 -0400)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 87ec6f55af38e29be5b2b65a8acf84da73e06d06:

  aio-posix: zero out io_uring sqe user_data (2023-08-30 07:39:59 -0400)

----------------------------------------------------------------
Pull request

v3:
- Drop UFS emulation due to CI failures
- Add "aio-posix: zero out io_uring sqe user_data"

----------------------------------------------------------------

Andrey Drobyshev (3):
  block: add subcluster_size field to BlockDriverInfo
  block/io: align requests to subcluster_size
  tests/qemu-iotests/197: add testcase for CoR with subclusters

Fabiano Rosas (1):
  block-migration: Ensure we don't crash during migration cleanup

Stefan Hajnoczi (1):
  aio-posix: zero out io_uring sqe user_data

 include/block/block-common.h |  5 ++++
 include/block/block-io.h     |  8 +++---
 block.c                      |  7 +++++
 block/io.c                   | 50 ++++++++++++++++++------------------
 block/mirror.c               |  8 +++---
 block/qcow2.c                |  1 +
 migration/block.c            | 11 ++++++--
 util/fdmon-io_uring.c        |  2 ++
 tests/qemu-iotests/197       | 29 +++++++++++++++++++++
 tests/qemu-iotests/197.out   | 24 +++++++++++++++++
 10 files changed, 110 insertions(+), 35 deletions(-)

-- 
2.41.0


