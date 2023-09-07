Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55557797DB1
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 23:04:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeM9C-0004Pk-99; Thu, 07 Sep 2023 17:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qeM99-0004On-7q; Thu, 07 Sep 2023 17:02:39 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qeM94-00032U-Hc; Thu, 07 Sep 2023 17:02:38 -0400
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1qeM5r-00EPgQ-03;
 Thu, 07 Sep 2023 23:02:26 +0200
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com, fam@euphon.net,
 eblake@redhat.com, vsementsov@yandex-team.ru,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v3 0/2] qemu-img: map: implement support for compressed
 clusters
Date: Fri,  8 Sep 2023 00:02:24 +0300
Message-Id: <20230907210226.953821-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

v2 --> v3:
  * Make "compressed" field mandatory, not optional;
  * Adjust field description in qapi/block-core.json;
  * Squash patch 3 into patch 2 so that failing tests don't break bisect;
  * Update even more tests' outputs now that the field is mandatory.

v2: https://lists.nongnu.org/archive/html/qemu-block/2023-07/msg00106.html

Andrey Drobyshev (2):
  block: add BDRV_BLOCK_COMPRESSED flag for bdrv_block_status()
  qemu-img: map: report compressed data blocks

 block/qcow.c                                  |   5 +-
 block/qcow2.c                                 |   3 +
 block/vmdk.c                                  |   2 +
 include/block/block-common.h                  |   3 +
 qapi/block-core.json                          |   7 +-
 qemu-img.c                                    |   8 +-
 tests/qemu-iotests/122.out                    |  84 +-
 tests/qemu-iotests/146.out                    | 780 +++++++++---------
 tests/qemu-iotests/154.out                    | 194 ++---
 tests/qemu-iotests/179.out                    | 178 ++--
 tests/qemu-iotests/209.out                    |   4 +-
 tests/qemu-iotests/221.out                    |  16 +-
 tests/qemu-iotests/223.out                    |  60 +-
 tests/qemu-iotests/241.out                    |  10 +-
 tests/qemu-iotests/244.out                    |  24 +-
 tests/qemu-iotests/252.out                    |  10 +-
 tests/qemu-iotests/253.out                    |  20 +-
 tests/qemu-iotests/274.out                    |  48 +-
 .../tests/nbd-qemu-allocation.out             |  16 +-
 tests/qemu-iotests/tests/qemu-img-bitmaps.out |  24 +-
 20 files changed, 757 insertions(+), 739 deletions(-)

-- 
2.39.3


