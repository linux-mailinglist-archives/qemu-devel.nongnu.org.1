Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C64673E442
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 18:10:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDoli-0004D3-6V; Mon, 26 Jun 2023 12:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qDole-0004Ad-DN; Mon, 26 Jun 2023 12:08:42 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qDolc-0001gm-Rh; Mon, 26 Jun 2023 12:08:42 -0400
Received: from dev005.ch-qa.vzint.dev ([172.29.1.10])
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1qDoka-00DiMx-12;
 Mon, 26 Jun 2023 18:08:27 +0200
To: qemu-block@nongnu.org,
	qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 vsementsov@yandex-team.ru, eblake@redhat.com,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH 0/3] block: align CoR requests to subclusters
Date: Mon, 26 Jun 2023 19:08:31 +0300
Message-Id: <20230626160834.696680-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
From:  Andrey Drobyshev via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

This series makes IO requests performed with copy-on-read to be aligned
to subclusters rather than clusters.  It also affects mirror job requests
alignment.

The initial reason for that change is the following crash discovered:

qemu-img create -f qcow2 base.qcow2 64K
qemu-img create -f qcow2 -o extended_l2=on,backing_file=base.qcow2,backing_fmt=qcow2 img.qcow2 64K
qemu-io -c "write -P 0xaa 0 2K" img.qcow2
qemu-io -C -c "read -P 0x00 2K 62K" img.qcow2

qemu-io: ../block/io.c:1236: bdrv_co_do_copy_on_readv: Assertion `skip_bytes < pnum' failed.

This change in alignment fixes the crash and adds test case covering it.

Andrey Drobyshev (3):
  block: add subcluster_size field to BlockDriverInfo
  block/io: align requests to subcluster_size
  tests/qemu-iotests/197: add testcase for CoR with subclusters

 block.c                      |  6 +++++
 block/io.c                   | 50 ++++++++++++++++++------------------
 block/mirror.c               |  8 +++---
 block/qcow2.c                |  1 +
 include/block/block-common.h |  4 +++
 include/block/block-io.h     |  2 +-
 tests/qemu-iotests/197       | 29 +++++++++++++++++++++
 tests/qemu-iotests/197.out   | 24 +++++++++++++++++
 8 files changed, 94 insertions(+), 30 deletions(-)

-- 
2.39.3


